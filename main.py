from sly import Lexer, Parser
from pprint import pprint
import json
import codecs
import sys

class SLexer(Lexer):

    tokens = {
      	NEXT,NUMBER,NAME,OPEN,CLOSE,ASSIGN,
    	STR,RP,LP,LG,RG,ARG,GROUP
    }

    # ignore
    ignore = '\t\r '
    ignore_comment = r'\#.*'

    # Ключевые токены
    NEXT =  r'\n+'
    NUMBER = r'\d+'
    NAME = r'[^ "\t\#\{};=()*<>@%\n]+'
    OPEN = r'{'
    CLOSE = r'}'

    # Обработка токенов
    @_(r'\d+')
    def NUMBER(self, t):
      t.value = int(t.value)
      return t

    # Токены формирования
    ASSIGN = r'='
    STR = r'"[^ \t\#\{};=<>@%]+"'
    RP  = r'\)'
    LP  = r'\('
    LG = r'\<'
    RG = r'\>'
    ARG = r'\@'
    GROUP = r'\%'

class SParser(Parser):
	tokens = SLexer.tokens

	# group ::= NAME OPEN main CLOSE NEXT
	@_('NAME OPEN NEXT main CLOSE NEXT')
	def group(self, p):
   		return {p.NAME: p.main}

	# var ::= NAME ASSIGN STR | NAME ASSIGN NUMBER
	@_('NAME ASSIGN STR NEXT')
	def var(self, p):
		return {p.NAME: p.STR[1:-1]}
   		
	@_('NAME ASSIGN NUMBER NEXT')
	def var(self, p):
   		return {p.NAME: p.NUMBER}

	# arr ::= NAME LP NUMBER NAME NUMBER NAME NUMBER RP ASSIGN STR STR
	@_('NAME LP NUMBER NAME NUMBER NAME NUMBER RP ASSIGN STR STR NEXT')
	def arr(self, p):
		label = []
		for i in range(p.NUMBER0, p.NUMBER1, p.NUMBER2):
   			string_value = p.STR0[1:-1] + str(i) + p.STR1[1:-1]
   			label.append(string_value)
		d = dict.fromkeys(label)
		return d

   	# type ::= NAME LG NAME strings ARG STR arguments |
   	# NAME LG NAME strings ARG NUMBER arguments
	@_('NAME LG NAME strings ARG STR arguments RG NEXT')
	def type(self, p):
   		return [p.NAME0, [[p.NAME1] + p.strings, [p.STR[1:-1]] + p.arguments]]

	@_('NAME LG NAME strings ARG NUMBER arguments RG NEXT')
	def type(self, p):
   		return [p.NAME0, [[p.NAME1] + p.strings, [p.NUMBER] + p.arguments]]

    # strings ::= NAME strings | empty
	@_('NAME strings')
	def strings(self, p):
   		return [p.NAME] + p.strings

	@_('empty')
	def strings(self, p):
   		return []

   	# arguments ::= STR arguments | NUMBER arguments | empty
	@_('STR arguments')
	def arguments(self, p):
   		return [p.STR[1:-1]] + p.arguments

	@_('NUMBER arguments')
	def arguments(self, p):
   		return [p.NUMBER] + p.arguments

	@_('empty')
	def arguments(self, p):
   		return []

   	# main ::= box main | var main | arr main | type main | empty
	@_('box main')
	def main(self, p):
   		return ["box", p.box] + p.main;
	@_('var main')
	def main(self, p):
   		return ["var", p.var] + p.main;
	@_('arr main')
	def main(self, p):
   		return ["arr", p.arr] + p.main;
	@_('type main')
	def main(self, p):
   		return ["type", p.type] + p.main;
	@_('group main')
	def main(self, p):
   		return ["group", p.group] + p.main;
	@_('empty')
	def main(self, p):
   		return []

   	# box ::= NAME GROUP NAME
	@_('NAME GROUP NAME NEXT')
	def box(self, p):
   		return {p.NAME0: p.NAME1}

	@_('')
	def empty(self, p):
   		pass
"""
var ::= NAME ASSIGN STR | NUMBER
arr ::= NAME LP NUMBER NAME NUMBER NAME NUMBER RP ASSIGN STR STR
type ::= NAME LG STR strings ARG STR arguments | NUMBER arguments
strings ::= STR strings | empty
arguments ::= STR arguments | NUMBER arguments | empty
main ::= box main | var main | arr main | type main | empty
box ::= NAME GROUP NAME
group ::= NAME "{" main "}"
"""

file = codecs.open( sys.argv[1], "r", "utf-8" )
data = file.read()
lexer = SLexer()
parser = SParser()
result = parser.parse(lexer.tokenize(data))
print(json.dumps(result, ensure_ascii=False, indent=2))
