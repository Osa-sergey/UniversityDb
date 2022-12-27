/*
    CRUD операции на базовые сущности
 */
/*
    User
 */

insert into habr_app."user"("name", nickname, hashed_password, about_info)
values ('Дмитрий Иванов', 'dimka', '$2a$12$noxi.d0SiUz5CRmrDXY2MeHqtDxBUkLBLZ/p8UIMg2lbHrw0Yep4C',
        'Программист с большим стажем в крупной IT компании');

update habr_app."user"
set nickname = 'dima'
where nickname = 'dimka'
returning "user".id;

/*
 Удаление пользователей которые не публиковали статьи
 */
with article_count as (
    SELECT id, count(*) as n
    from habr_app.article
    group by id
)
delete from habr_app."user" as u
where u.id not in (select id from article_count)
returning u.id;

/*
  Показать всех пользователей с шаблоном никнейма *_*
 */
select id, nickname from habr_app."user" where nickname like '%\_%';

/*
    Company
 */

insert into habr_app.company(name, description, web_link, create_date, employee_number, location, ambassador)
values ('Удмуртский GameDev', 'Команда разработчиков мобильных игр из Удмуртии',
        'https://udm_games.ru/about', '10.05.2021', '5 человек', 'Ижевск', 2);

insert into habr_app.article(title, content, author, company)
values ('test5', 'test5', 1, 1),
       ('test3', 'test3', 1, 2),
       ('test4', 'test4', 1, 2);

/*
 Проставление в описание компании текста о топ 3 компании по количеству опубликованных статей
 */
with company_article_number as (
    select c.id, count(*) articles_count from habr_app.company c
    join habr_app.article a on a.company = c.id
    group by c.id
    having count(*) > 1
)
update habr_app.company
set description = 'Топ 3 активных компаний' || description
where id in (select id from company_article_number
                       order by articles_count
                       limit 3)
returning id, "name";

insert into habr_app.hubs_to_articles(hub_id, article_id)
values (1,4),
       (2,5),
       (1,6);
/*
 Выводим отсортированный (по компании, по хабу) список количества статей для кадлой компании
 */
select co.name as company_name, h.name as hub_name, count(*) as article_number from habr_app.company co
    join habr_app.article a on co.id = a.company
    join habr_app.hubs_to_articles hta on a.id = hta.article_id
    join habr_app.hub h on hta.hub_id = h.id
    GROUP BY co.name, h.name
    having count(*) > 1
    ORDER BY co.name, h.name;

select c.name as company_name, h.name as hub_name, count(*)
from  habr_app.company c, habr_app.article a, habr_app.hubs_to_articles hta , habr_app.hub h
where c.id = a.id and a.id = hta.article_id and h.id = hta.hub_id
GROUP BY c.name, h.name
having count(*) > 1
ORDER BY c.name, h.name;