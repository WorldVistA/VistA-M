PXRMSTAC ; SLC/PKR - Stack routines for use by PXRM. ;11/24/2004
 ;;2.0;CLINICAL REMINDERS;;Feb 04, 2005
 ;
 ;=====================================================
POP(STACK) ;Pop an element off of the stack.
 I STACK(0)=0 Q ""
 N IND,TEMP
 S TEMP=STACK(1)
 F IND=2:1:STACK(0) S STACK(IND-1)=STACK(IND)
 K STACK(STACK(0))
 S STACK(0)=STACK(0)-1
 Q TEMP
 ;
 ;=====================================================
POSTFIX(EXPR,OPER,PFSTACK) ;Given an expression, EXPR, in infix notation
 ;convert it to postfix and return the result in PFSTACK. PFSTACK(0)
 ;will contain the number of elements in PFSTACK. OPER is a
 ;string containing allowable operators.
 N CHAR,IND,LEN,OPERP,PFP,SP,SPACE,STACK,SYM,SYMP,SYMT,TAB,TEMP
 S SPACE=$C(32)
 S TAB=$C(9)
 S TEMP=""
 S OPERP=OPER_"()"
 S SYMP=0
 S LEN=$L(EXPR)
 ;Break the expression into (, ), operators, and operands.
 ;Remove spaces and tabs and put the symbols onto the symbol
 ;stack in left to right order. Symbol number 1 is SYM(1).
 F IND=1:1:LEN D
 . S CHAR=$E(EXPR,IND)
 . I (CHAR=SPACE)!(CHAR=TAB) Q
 . I OPERP[CHAR D
 .. I $L(TEMP)>0 D
 ... S SYMP=SYMP+1
 ... S SYM(SYMP)=TEMP
 ... S TEMP=""
 .. S SYMP=SYMP+1
 .. S SYM(SYMP)=CHAR
 . E  S TEMP=TEMP_CHAR
 . I (IND=LEN)&(TEMP'="") D
 .. S SYMP=SYMP+1
 .. S SYM(SYMP)=TEMP
 ;Process the symbols.
 S (PFP,SP)=0
 S LEN=SYMP
 F SYMP=1:1:LEN D
 . S SYMT=SYM(SYMP)
 .;
 .;Symbol is "("
 . I SYMT="(" D  Q
 .. S SP=SP+1
 .. S STACK(SP)=SYMT
 .;
 .;Symbol is an operator
 . I OPER[SYMT D  Q
 .. S LEN=SP
 .. F IND=LEN:-1:1 S TEMP=STACK(IND) Q:TEMP="("  D
 ...;M has no operator precedence so we don't need to check.
 ... S PFP=PFP+1
 ... S PFSTACK(PFP)=TEMP
 ... K STACK(SP)
 ... S SP=SP-1
 .. S SP=SP+1
 .. S STACK(SP)=SYMT
 .;
 .;Symbol is ")"
 . I SYMT=")" D  Q
 .. S LEN=SP
 .. F IND=LEN:-1:1 S TEMP=STACK(IND) Q:TEMP="("  D
 ... S PFP=PFP+1
 ... S PFSTACK(PFP)=TEMP
 ... K STACK(SP)
 ... S SP=SP-1
 ..;Pop the "(" at the top of the stack.
 .. K STACK(SP)
 .. S SP=SP-1
 .;
 .;If we get to here then symbol is an operand.
 . S PFP=PFP+1
 . S PFSTACK(PFP)=SYMT
 ;
 ;Pop and output anything left on the stack.
 F IND=SP:-1:1 D
 . S PFP=PFP+1
 . S PFSTACK(PFP)=STACK(IND)
 ;
 ;Save the number of elements in PFSTACK.
 S PFSTACK(0)=PFP
 Q
 ;
 ;=====================================================
PUSH(STACK,ELEM) ;Push an element on the stack.
 I '$D(STACK) S STACK(1)=ELEM,STACK(0)=1 Q
 I STACK(0)=0 S STACK(1)=ELEM,STACK(0)=1 Q
 N IND
 F IND=STACK(0):-1:1 S STACK(IND+1)=STACK(IND)
 S STACK(1)=ELEM,STACK(0)=STACK(0)+1
 Q
 ;
