PXRMSTAC ;SLC/PKR - Stack routines for use by PXRM. ;11/08/2011
 ;;2.0;CLINICAL REMINDERS;**18**;Feb 04, 2005;Build 152
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
POSTFIX(EXPR,OPERS,PFSTACK) ;Given an expression, EXPR, in infix notation
 ;convert it to postfix and return the result in PFSTACK. PFSTACK(0)
 ;will contain the number of elements in PFSTACK. OPERS is a
 ;string containing allowable operators.
 N CHAR,IND,LEN,NSYM,OPERP,PFP,QF,QUOTE,SP,STACK,SYM,SYMP,SYMT
 N TEMP,UNARYOPS
 S UNARYOPS=""
 F TEMP="+","-","'" I OPERS[TEMP S UNARYOPS=UNARYOPS_TEMP
 S QUOTE=$C(34)
 S OPERP=OPERS_"()"
 S LEN=$L(EXPR)
 ;Break the expression into (, ), operators, and operands.
 ;Put the symbols onto the symbol stack in left to right order.
 ;Symbol number 1 is SYM(1).
 S QF=0,NSYM=0,TEMP=""
 F IND=1:1:LEN D
 . S CHAR=$E(EXPR,IND)
 . I (CHAR=QUOTE),('QF) S TEMP=TEMP_CHAR,QF=1 Q
 . I (QF),(CHAR'=QUOTE) S TEMP=TEMP_CHAR Q
 . I (QF),(CHAR=QUOTE) S TEMP=TEMP_CHAR,QF=0 Q
 . I OPERP[CHAR D  Q
 .. I TEMP'="" S NSYM=NSYM+1,SYM(NSYM)=TEMP,TEMP=""
 ..;In MUMPS "'=", "'<", "'>", "'&", and "'!" must be treated as
 ..;a single operator.
 .. I CHAR="'" D
 ... S TEMP=$E(EXPR,IND+1)
 ... I (TEMP="=")!(TEMP="<")!(TEMP=">")!(TEMP="&")!(TEMP="!") S CHAR=CHAR_TEMP,IND=IND+1
 .. S NSYM=NSYM+1,SYM(NSYM)=CHAR,TEMP=""
 . S TEMP=TEMP_CHAR
 I (IND=LEN),(TEMP'="") S NSYM=NSYM+1,SYM(NSYM)=TEMP
 ;Process the symbols.
 S (PFP,SP)=0
 F SYMP=1:1:NSYM D
 . S SYMT=SYM(SYMP)
 .;
 .;Symbol is "("
 . I SYMT="(" S SP=SP+1,STACK(SP)=SYMT Q
 .;
 .;Symbol is an operator
 . I OPERS[SYMT D  Q
 ..;Check for a unary operator, they have the highest precendence.
 .. ;The NOT operator is always unary.
 .. I SYMT="'" S SYMT=SYMT_"U",SP=SP+1,STACK(SP)=SYMT Q
 .. I (SYMP=1),(UNARYOPS[SYMT) S SYMT=SYMT_"U"
 .. I (SYMP>1),(OPERS[SYM(SYMP-1)),(UNARYOPS[SYMT) S SYMT=SYMT_"U"
 .. I SYMT["U" S SP=SP+1,STACK(SP)=SYMT Q
 .. S LEN=SP
 .. F IND=LEN:-1:1 S TEMP=STACK(IND) Q:TEMP="("  D
 ... S PFP=PFP+1,PFSTACK(PFP)=TEMP
 ... K STACK(SP)
 ... S SP=SP-1
 .. S SP=SP+1
 .. S STACK(SP)=SYMT
 .;
 .;Symbol is ")"
 . I SYMT=")" D  Q
 .. S LEN=SP
 .. F IND=LEN:-1:1 S TEMP=STACK(IND) Q:TEMP="("  D
 ... S PFP=PFP+1,PFSTACK(PFP)=TEMP
 ... K STACK(SP)
 ... S SP=SP-1
 ..;Pop the "(" at the top of the stack.
 .. K STACK(SP)
 .. S SP=SP-1
 .;
 .;If we get to here then symbol is an operand.
 . S PFP=PFP+1,PFSTACK(PFP)=SYMT
 ;
 ;Pop and output anything left on the stack.
 F IND=SP:-1:1 S PFP=PFP+1,PFSTACK(PFP)=STACK(IND)
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
