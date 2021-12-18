# KSE-configuration-language

### Single variable query
>`( (var 10) )`
`( (var -5) )`
`( (var 2.5) )`
`( (var -5.2) )`
`( (var "a") )`
`( (var "var") )`

Single variables may be needed to store information in numeric or string form. You can also manipulate variables with different amounts of data.
### Multiple data variables
>`( (var 10 3.5 "simple") )`

It can be useful to store data under a common variable name

### Variables of the same data
>`( (var(10) 10) )`
`( (var(10 10) 10 -5.33) )`
`( (var(10 100 1000) 10 4.5 "---") )`

May be useful for data stored with the same values

## Slot-Requests
>`(
	(var 10)
	(block() (temp1 var) (temp2 var))
	(student() (name "Игорь") (fam "Петров"))
)`

To create a slot it is necessary before the slot name there were OPEN CLOSE brackets, then there should be queries on the variables of various types mentioned above. Slots are a complex query with an internal arrangement.
