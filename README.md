# KSE-configuration-language

## Single variable query
`( (var 10) )`
`( (var -5) )`
`( (var 2.5) )`
`( (var -5.2) )`
`( (var "a") )`
`( (var "var") )`

Single variables may be needed to store information in numeric or string form. You can also manipulate variables with different amounts of data.
## Multiple data variables
`( (var 10 3.5 "simple") )`

It can be useful to store data under a common variable name

## Variables of the same data
`( (var(10) 10) )`
`( (var(10 10) 10 -5.33) )`
`( (var(10 100 1000) 10 4.5 "---") )`

May be useful for data stored with the same values

## Slot-Requests
To create a slot it is necessary before the slot name there were OPEN CLOSE brackets, then there should be queries on the variables of various types mentioned above. Slots are a complex query with an internal arrangement.
<br/>

	(
	  (var 10) 
	  (block() (temp1 var) (temp2 var))
	  (student() (name "Игорь") (fam "Петров"))
	)

## Anonymous requests

<br/>

	(
	  (students(0) ((name "Первый") (name "Второй") (name "Третий"))
	)


## Cloning slots

Thus, both the student and Igor will have the same slots in terms of content. It can be useful when creating identical slots.
<br/> 

	(
	  (var 20)
	  (student() (name "Игорь") (fam "Петров"))
	  (Igor()) student
	)
You cannot create a non-native clone, otherwise Null slots will be cloned to where you are cloning ❌
<br/> 

	(
	  (Igor()) student
	)

## Merge-Function

The merge function is a tool to merge two or more slots into one combo slot.
<br/>

	(
	  (2)merge1 (1(1) 2(1))
	  (student1() (var1 10) (notvar 20))
	  (student2() (var2 20))
	  (score()) merge1(student1() student2())
	)

## Special types

Special types are a great solution for storing a specific type of data. The way types are declared is pre-query.
<br/> 

	id(int(0 3) "." int(0 3) "." int(0 3) "." int(0 3)) 
	(
	  (id1 190.222.123.30)
	  (id2 183.120.233.48)
	)
