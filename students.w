{
    subject = "Конфигурационное управление";
    groups = for(1 25 1 "ИКБО-&-20"); 
    student1 = 
    (
        age(19)
        group("ИКБО-4-20")
        name("Иванов И.И.")
    );
    student2 =
    (
        age(18)
        group("ИКБО-4-20")
        name("Петров П.П.")
    );
    student3 =
    (
        age(18)
        group("ИКБО-5-20")
        name("Сидоров С.С.")
    );
}

(
    groups(
            &groups
          )
    students(
            &student1 
            &student2 
            &student3
        (
            age(20) group("ИКБО-6-20") name("Козлов К.К.")
        )
    ) 
subject(&subject)
)


class SParser(Parser):
  tokens = SLexer.tokens

  @_('OPEN main CLOSE')
  def programm(self, p):
    return p.main

  # main ::= simple_var main | block_var main | group main | empty
  @_('simple_var main')
  def main(self, p):
    return [p.simple_var, p.main]
  """@_('block_var main')
  def main(self, p):
    return [p.block_var, p.main]
  @_('group main')
  def main(self, p):
    return [p.group, p.main]
  @_('empty')
  def main(self, p):
    return []"""

  # simple_var ::= NAME ASSIGN STRING | NAME ASSIGN NUMBER
  @_('NAME ASSIGN STRING')
  def simple_var(self, p):
    return [p.NAME, p.STRING[1:-1]]
  @_('NAME ASSIGN NUMBER')
  def simple_var(self, p):
    return [p.NAME, p.NUMBER]
"""
  # block_var ::= NAME OPEN main CLOSE
  @_('NAME OPEN main CLOSE')
  def block_var(self, p):
    return [p.NAME, p.main]

  # names ::= NAME NAME | empty
  @_('NAME NAME')
  def names(self, p):
    return p.NAME0
  @_('empty')
  def names(self, p):
    return []

  # group ::= 
  # NAME OPEN NUMBER NAME NUMBER NAME NUMBER CLOSE ASSIGN STRING STRING | 
  # NAME OPEN NAME names CLOSE |
  # empty
  @_('NAME OPEN NUMBER NAME NUMBER NAME NUMBER CLOSE ASSIGN STRING STRING')
  def group(self, p):
    label = []
    for i in range(p.NUMBER0, p.NUMBER1, p.NUMBER2):
      label.append(p.STRING0+str(i)+p.STRING1)
    return label
  @_('NAME OPEN NAME names CLOSE')
  def group(self, p):
    return [p.NAME0, [p.NAME1, names]]
  @_('empty')
  def group(self, p):
    return []
"""

"""
programm ::= OPEN main CLOSE
main ::= simple_var main | block_var main | group main | empty
simple_var ::= NAME ASSIGN STRING | NAME ASSIGN NUMBER | empty
group ::= 
NAME OPEN NUMBER NAME NUMBER NAME NUMBER CLOSE ASSIGN STRING STRING | 
NAME OPEN NAME names CLOSE |
empty
block_var ::= NAME OPEN main CLOSE
names ::= NAME NAME | empty
"""


  # main ::= simple_var main | block_var main | group main | empty
  @_('simple_var main')
  def main(self, p):
    return [p.simple_var, p.main]
  """@_('block_var main')
  def main(self, p):
    return [p.block_var, p.main]
  @_('group main')
  def main(self, p):
    return [p.group, p.main]
  @_('empty')
  def main(self, p):
    return []"""

  # simple_var ::= NAME ASSIGN STRING | NAME ASSIGN NUMBER
  @_('NAME ASSIGN STRING')
  def simple_var(self, p):
    return [p.NAME, p.STRING[1:-1]]
  @_('NAME ASSIGN NUMBER')
  def simple_var(self, p):
    return [p.NAME, p.NUMBER]
"""
  # block_var ::= NAME OPEN main CLOSE
  @_('NAME OPEN main CLOSE')
  def block_var(self, p):
    return [p.NAME, p.main]

  # names ::= NAME NAME | empty
  @_('NAME NAME')
  def names(self, p):
    return p.NAME0
  @_('empty')
  def names(self, p):
    return []

  # group ::= 
  # NAME OPEN NUMBER NAME NUMBER NAME NUMBER CLOSE ASSIGN STRING STRING | 
  # NAME OPEN NAME names CLOSE |
  # empty
  @_('NAME OPEN NUMBER NAME NUMBER NAME NUMBER CLOSE ASSIGN STRING STRING')
  def group(self, p):
    label = []
    for i in range(p.NUMBER0, p.NUMBER1, p.NUMBER2):
      label.append(p.STRING0+str(i)+p.STRING1)
    return label
  @_('NAME OPEN NAME names CLOSE')
  def group(self, p):
    return [p.NAME0, [p.NAME1, names]]
  @_('empty')
  def group(self, p):
    return []
"""

"""
programm ::= OPEN main CLOSE
main ::= simple_var main | block_var main | group main | empty
simple_var ::= NAME ASSIGN STRING | NAME ASSIGN NUMBER | empty
group ::= 
NAME OPEN NUMBER NAME NUMBER NAME NUMBER CLOSE ASSIGN STRING STRING | 
NAME OPEN NAME names CLOSE |
empty
block_var ::= NAME OPEN main CLOSE
names ::= NAME NAME | empty
"""

