## Можно создавать шаблонные запросы
(
	(var 20)
	(student() (name "Игорь") (fam "Петров"))
	(denis()) student
) output debug

## Если нет, slots к которому обращаться, то будет написана ошибка в debug.
(
	(denis()) student
)

## Если был создан slots-запрос можно обратиться к нему и скопировать его содержимое в новый
## slots-запрос
