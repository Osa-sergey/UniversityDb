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

create table habr_app.company_category
(
    id serial
        constraint company_category_pk primary key,
    name varchar(60) not null
        constraint company_category_name_u
            unique,
    description text not null
);

create table habr_app.company
(
    id bigserial
        constraint company_pk primary key,
    name varchar(60) not null
        constraint company_name_u
            unique,
    description text not null,
    web_link varchar(60) not null,
    register_date date default now() not null,
    create_date date not null,
    employee_number varchar(30) not null,
    location varchar(60) not null,
    img_src varchar(60),
    ambassador int8 references habr_app."user"(id) not null,
    rating float4 default 0.0 check ( rating >= 0.0 )
);

create table habr_app.companies_to_categories
(
    company_id int8 references habr_app.company(id) not null,
    category_id int4 references habr_app.company_category(id) not null,
    primary key (company_id, category_id)
);

create table habr_app.hub
(
    id serial
        constraint hub_pk primary key,
    name varchar(60) not null
        constraint hub_name_u
            unique,
    description text not null,
    img_src varchar(60),
    rating float4 default 0.0 check ( rating >= 0.0 )
);

create table habr_app.habr_flow
(
    name varchar(60)
        constraint habr_flow_pk primary key,
    description text not null
);

create table habr_app.habr_flows_to_hubs
(
    flow_id varchar(60) references habr_app.habr_flow(name) not null,
    hub_id int4 references habr_app.hub(id) not null,
    primary key (flow_id, hub_id)
);

create table habr_app.habr_article_tag
(
    "name" varchar(30)
        constraint habr_article_tag_pk primary key
);

create table habr_app.article
(
    id bigserial
        constraint article_pk primary key,
    title varchar(200) not null,
    "content" text not null,
    publish_timestamp timestamptz default now() not null,
    author int8 references habr_app."user"(id) not null,
    company int8 references habr_app.company(id),
    voices_up int default 0 not null,
    voices_down int default 0 not null,
    views int default 0 not null,
    bookmarks int default 0 not null,
    "comments" int default 0 not null,
    title_img_src varchar(60)
);

create table habr_app.habr_article_tags_to_articles
(
    tag_id varchar(30) references habr_app.habr_article_tag(name) not null,
    article_id int8 references habr_app.article(id) not null,
    primary key (tag_id, article_id)
);

create table habr_app.hubs_to_articles
(
    hub_id int4 references habr_app.hub(id) not null,
    article_id int8 references habr_app.article(id) not null,
    primary key (hub_id, article_id)
);

create table habr_app.user_article_tag
(
    id bigserial
        constraint user_article_tag_pk primary key,
    "name" varchar(90) not null,
    user_id int8 references habr_app."user"(id) not null,
    description text,
    unique ("name", user_id)
);

create table habr_app.user_article_tags_to_articles
(
    tag_id int8 references habr_app.user_article_tag(id) not null,
    article_id int8 references habr_app.article(id) not null,
    primary key (tag_id, article_id)
);

create table habr_app.favorite_author
(
    user_id int8 references habr_app."user"(id) not null,
    author_id int8 references habr_app."user"(id) not null,
    primary key (user_id, author_id)
);

create table habr_app.favorite_hub
(
    user_id int8 references habr_app."user"(id) not null,
    hub_id int4 references habr_app.hub(id) not null,
    primary key (user_id, hub_id)
);

create table habr_app.favorite_company
(
    user_id int8 references habr_app."user"(id) not null,
    company_id int8 references habr_app.company(id) not null,
    primary key (user_id, company_id)
);

create table habr_app.bookmark
(
    user_id int8 references habr_app."user"(id) not null,
    article_id int8 references habr_app.article(id) not null,
    path text  default '/' not null,
    primary key (user_id, article_id)
);

create table habr_app.note
(
    user_id int8 references habr_app."user"(id) not null,
    article_id int8 references habr_app.article(id) not null,
    noted_text text,
    note text not null,
    primary key(user_id, article_id, noted_text)
);

create table habr_app.pin
(
    user_id int8 references habr_app."user"(id) not null,
    article_id int8 references habr_app.article(id) not null,
    pin_timestamp timestamptz default now() not null,
    primary key (user_id, article_id)
)



