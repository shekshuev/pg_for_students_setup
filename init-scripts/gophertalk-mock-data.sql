DO $$
DECLARE
    user_count INTEGER := 1000;
    post_count INTEGER := 50000;
    user_id BIGINT;
    post_id BIGINT;
    comment_count INTEGER;
    view_count INTEGER;
    like_count INTEGER;
    i INTEGER;
BEGIN
    -- Generate users
    FOR i IN 1..user_count LOOP
        INSERT INTO public.users (user_name, first_name, last_name, password_hash)
        VALUES (
            CONCAT('user', i),
            CONCAT('FirstName', i),
            CONCAT('LastName', i),
            '$2a$10$jE3vrgoO352BXuEPdpxTuuvm5qDXeGlMMJ6ejj2w.kEfthPhRpJCy'
        ) RETURNING id INTO user_id;
    END LOOP;

    -- Generate posts
    FOR i IN 1..post_count LOOP
        -- Randomly select a user to author the post
        SELECT id INTO user_id FROM public.users OFFSET floor(random() * user_count) LIMIT 1;

        -- Insert post
        INSERT INTO public.posts ("text", user_id, likes_count, replies_count, views_count)
        VALUES (
            CONCAT('Post text for post ', i),
            user_id,
            0, -- Initial likes_count
            0, -- Initial replies_count
            0  -- Initial views_count
        ) RETURNING id INTO post_id;

        -- Generate comments (2 to 10 per post)
        comment_count := floor(random() * 9 + 2); -- Random number between 2 and 10
        FOR j IN 1..comment_count LOOP
            -- Randomly select a user to comment
            SELECT id INTO user_id FROM public.users OFFSET floor(random() * user_count) LIMIT 1;

            -- Insert comment as a reply
            INSERT INTO public.posts ("text", user_id, reply_to_id)
            VALUES (
                CONCAT('Comment text for post ', post_id, ' comment ', j),
                user_id,
                post_id
            );

            -- Update replies_count for the post
            UPDATE public.posts
            SET replies_count = replies_count + 1
            WHERE id = post_id;
        END LOOP;

        -- Generate views (10 to 100 per post)
        view_count := floor(random() * 91 + 10); -- Random number between 10 and 100
        FOR j IN 1..view_count LOOP
            -- Randomly select a user to view
            SELECT id INTO user_id FROM public.users OFFSET floor(random() * user_count) LIMIT 1;

            -- Insert view
            INSERT INTO public."views" (user_id, post_id)
            VALUES (user_id, post_id)
            ON CONFLICT DO NOTHING; -- Avoid duplicate views
        END LOOP;

        -- Update views_count for the post
        UPDATE public.posts
        SET views_count = views_count + view_count
        WHERE id = post_id;

        -- Generate likes (5 to 20 per post)
        like_count := floor(random() * 16 + 5); -- Random number between 5 and 20
        FOR j IN 1..like_count LOOP
            -- Randomly select a user to like
            SELECT id INTO user_id FROM public.users OFFSET floor(random() * user_count) LIMIT 1;

            -- Insert like
            INSERT INTO public.likes (user_id, post_id)
            VALUES (user_id, post_id)
            ON CONFLICT DO NOTHING; -- Avoid duplicate likes
        END LOOP;

        -- Update likes_count for the post
        UPDATE public.posts
        SET likes_count = likes_count + like_count
        WHERE id = post_id;
    END LOOP;

    RAISE NOTICE 'Test data generation complete.';
END $$;
