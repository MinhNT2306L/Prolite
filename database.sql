-- WARNING: This schema is for context only and is not meant to be run.
-- Table order and constraints may not be valid for execution.

CREATE TABLE public.comment_likes (
  id uuid NOT NULL DEFAULT gen_random_uuid(),
  user_id uuid,
  comment_id uuid,
  created_at timestamp without time zone DEFAULT now(),
  CONSTRAINT comment_likes_pkey PRIMARY KEY (id),
  CONSTRAINT comment_likes_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id),
  CONSTRAINT comment_likes_comment_id_fkey FOREIGN KEY (comment_id) REFERENCES public.comments(comment_id)
);
CREATE TABLE public.comments (
  comment_id uuid NOT NULL DEFAULT gen_random_uuid(),
  user_id uuid,
  post_id uuid,
  content text NOT NULL,
  created_at timestamp without time zone DEFAULT now(),
  CONSTRAINT comments_pkey PRIMARY KEY (comment_id),
  CONSTRAINT comments_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id),
  CONSTRAINT comments_post_id_fkey FOREIGN KEY (post_id) REFERENCES public.posts(post_id)
);
CREATE TABLE public.conversation_members (
  id uuid NOT NULL DEFAULT gen_random_uuid(),
  conversation_id uuid,
  user_id uuid,
  CONSTRAINT conversation_members_pkey PRIMARY KEY (id),
  CONSTRAINT conversation_members_conversation_id_fkey FOREIGN KEY (conversation_id) REFERENCES public.conversations(conversation_id),
  CONSTRAINT conversation_members_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id)
);
CREATE TABLE public.conversations (
  conversation_id uuid NOT NULL DEFAULT gen_random_uuid(),
  is_group boolean DEFAULT false,
  created_at timestamp without time zone DEFAULT now(),
  CONSTRAINT conversations_pkey PRIMARY KEY (conversation_id)
);
CREATE TABLE public.friendships (
  id uuid NOT NULL DEFAULT gen_random_uuid(),
  requester_id uuid,
  addressee_id uuid,
  status text CHECK (status = ANY (ARRAY['pending'::text, 'accepted'::text, 'blocked'::text])),
  created_at timestamp without time zone DEFAULT now(),
  CONSTRAINT friendships_pkey PRIMARY KEY (id),
  CONSTRAINT friendships_requester_id_fkey FOREIGN KEY (requester_id) REFERENCES public.users(user_id),
  CONSTRAINT friendships_addressee_id_fkey FOREIGN KEY (addressee_id) REFERENCES public.users(user_id)
);
CREATE TABLE public.messages (
  id uuid NOT NULL DEFAULT gen_random_uuid(),
  conversation_id uuid,
  sender_id uuid,
  content text,
  is_read boolean DEFAULT false,
  created_at timestamp without time zone DEFAULT now(),
  CONSTRAINT messages_pkey PRIMARY KEY (id),
  CONSTRAINT messages_conversation_id_fkey FOREIGN KEY (conversation_id) REFERENCES public.conversations(conversation_id),
  CONSTRAINT messages_sender_id_fkey FOREIGN KEY (sender_id) REFERENCES public.users(user_id)
);
CREATE TABLE public.notifications (
  id uuid NOT NULL DEFAULT gen_random_uuid(),
  user_id uuid,
  type text,
  reference_id uuid,
  is_read boolean DEFAULT false,
  created_at timestamp without time zone DEFAULT now(),
  CONSTRAINT notifications_pkey PRIMARY KEY (id),
  CONSTRAINT notifications_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id)
);
CREATE TABLE public.post_images (
  id uuid NOT NULL DEFAULT gen_random_uuid(),
  post_id uuid NOT NULL,
  image_url text NOT NULL,
  position integer DEFAULT 0,
  created_at timestamp with time zone DEFAULT now(),
  CONSTRAINT post_images_pkey PRIMARY KEY (id),
  CONSTRAINT fk_post_images_post FOREIGN KEY (post_id) REFERENCES public.posts(post_id)
);
CREATE TABLE public.post_likes (
  id uuid NOT NULL DEFAULT gen_random_uuid(),
  user_id uuid,
  post_id uuid,
  created_at timestamp without time zone DEFAULT now(),
  CONSTRAINT post_likes_pkey PRIMARY KEY (id),
  CONSTRAINT post_likes_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id),
  CONSTRAINT post_likes_post_id_fkey FOREIGN KEY (post_id) REFERENCES public.posts(post_id)
);
CREATE TABLE public.post_shares (
  id uuid NOT NULL DEFAULT gen_random_uuid(),
  user_id uuid,
  post_id uuid,
  created_at timestamp without time zone DEFAULT now(),
  CONSTRAINT post_shares_pkey PRIMARY KEY (id),
  CONSTRAINT post_shares_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id),
  CONSTRAINT post_shares_post_id_fkey FOREIGN KEY (post_id) REFERENCES public.posts(post_id)
);
CREATE TABLE public.posts (
  post_id uuid NOT NULL DEFAULT gen_random_uuid(),
  user_id uuid,
  content text,
  privacy text DEFAULT 'public'::text CHECK (privacy = ANY (ARRAY['public'::text, 'friends'::text, 'private'::text])),
  created_at timestamp without time zone DEFAULT now(),
  title text,
  CONSTRAINT posts_pkey PRIMARY KEY (post_id),
  CONSTRAINT posts_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id)
);
CREATE TABLE public.users (
  user_id uuid NOT NULL DEFAULT gen_random_uuid(),
  username text NOT NULL,
  email text NOT NULL UNIQUE,
  password text NOT NULL,
  avatar text,
  bio text,
  created_at timestamp without time zone DEFAULT now(),
  CONSTRAINT users_pkey PRIMARY KEY (user_id)
);