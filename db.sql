create schema if not exists habr_app;

create table habr_app."user"
(
    id                       bigserial
        constraint user_pk
            primary key,
    name                     varchar(60)               not null,
    nickname                 varchar(60)               not null
        constraint user_nickname_u
            unique,
    hashed_password          varchar(60)               not null,
    about_info               text,
    datetime_of_registration timestamptz default now() not null,
    img_src                  varchar(60),
    carma                    int4 default 0 check ( carma >= 0 ),
    rating                   float4 default 0.0 check ( rating >= 0.0 )
);

comment on column habr_app."user".name is 'name of user';

comment on column habr_app."user".nickname is 'unique @nickname of user';

comment on column habr_app."user".hashed_password is 'bcrypt password hash';

comment on column habr_app."user".about_info is 'some info about user';

comment on column habr_app."user".datetime_of_registration is 'date and time of user registration';

comment on column habr_app."user".img_src is 'uri of user img src';

comment on column habr_app."user".carma is 'user carma';

comment on column habr_app."user".rating is 'user rating';

