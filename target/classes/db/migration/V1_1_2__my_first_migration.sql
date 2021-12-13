--create extension if not exists pgcrypto;

UPDATE usr SET password = CRYPT(password, gen_salt('bf', 8));