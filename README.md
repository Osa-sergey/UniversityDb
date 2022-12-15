# Проект по реляционной базе данных Postgresql для института

## Способ запуска
Для запуска используется файл docker-compose.yaml:

```bash
docker-compose up
```

Основной файл, разворачивающий стурктуру базы представлен в __db.sql__

Для заполнения базы тестовыми данными нужно выполнить скрипт __init_data.sql__
После заполнения базы можно выполнять скрипты из queries.sql 

## Тематика проекта

База разрабатывается для использования в другом моем проекте по созданию 
удобного web и мобильного приложения reader для сайта habr.ru.

> __Note__: На текущий момент мной ведется разработка требований к продукту и освоение 
фреймворка React.js для написания web версии. 

Для лучшего понимания контекста представляю 
ссылки на часть документов связанных с дизайн макетами и перечнем желаемой функциональности:

> - [Желаемая функциональность готового решения](https://miro.com/app/board/uXjVPVow5Zg=/?share_link_id=108723963298)
> - [Прототип мобильного дизайна](https://www.figma.com/file/iQeuGrKGDypd76Sv2T9jtp/HabrApp_mob?node-id=0%3A1&t=7IiEKDajyPMNENjR-1)
> - [Прототип части web дизайна](https://www.figma.com/file/F2IyuEjobxxae2NMKfumCF/HabrApp_web?node-id=0%3A1&t=PMzAmSWdohEsmyKf-1)

В данной работе я постараюсь спроектировать прототип базы данных, подходящий под часть желаемого функционала и 
реализовывающей специфические для этих функций запросы.
