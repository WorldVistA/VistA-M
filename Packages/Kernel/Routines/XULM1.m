XULM1 ;IRMFO-ALB/CJM/SWO/RGG - KERNEL LOCK MANAGER ;12/04/2012
 ;;8.0;KERNEL;**608**;JUL 10, 1995;Build 84
 ;;Per VA Directive 6402, this routine should not be modified
 ;
 ;  ******************************************************************
 ;  *                                                                *
 ;  *  The Kernel Lock Manager is based on the VistA Lock Manager    *
 ;  *        developed by Tommy Martin.                              *
 ;  *                                                                *
 ;  ******************************************************************
 ;Contains routines for editing and creating entries in the LOCK DICTIONARY
 ;
SNTXLOCK(X,PARTS) ;
 ;
 ;Checks the syntax for a lock, returns 1 if ok, 0 otherwise
 ;
 ;Input: 
 ;  X - the value of the LOCK TEMPLATE that was entered
 ;  DA - if defined, it should be the ien of the record that is being edited
 ;Output:
 ;  function returns 1 if X is syntactically correct, 0 otherwise
 ;  PARTS - optional, pass-by-references.  Returns the parsed of the LOCK TEMPLATE
 ;  PARTS(<subscripts>):
 ;       ("GLOBAL") =1 if the lock is on a global, 0 otherwise
 ;       ("VARIABLE") = the locked variable, without subscripts
 ;       (0) = count of subscripts
 ;       (<1,2,3,...>) = the subscripts, in the order they occur
 ;
 N LOCK,BAD,NODE0,NODE1
 I $E(X)=" " S X=$E(X,2,500)
 I $L(X)>245 Q 0
 I $G(DA) S NODE1=$G(^XLM(8993,DA,1)) I $P(NODE1,"^",2),$E(X)'="^" S X="^"_X
 ;
 S LOCK=X
 K PARTS
 S PARTS(0)=0
 S PARTS("GLOBAL")=0
 S BAD=0
 ;
 I $E(LOCK)="^" D
 .S LOCK=$E(LOCK,2,245)
 .S PARTS("GLOBAL")=1
 S PARTS("VARIABLE")=$P(LOCK,"(")
 I $G(DA) S NODE0=$G(^XLM(8993,DA,0)),NODE1=$G(^XLM(8993,DA,1)) I $L(NODE1) Q:($L($P(NODE1,"^",2))&($P(NODE1,"^",2)'=PARTS("GLOBAL")))!($L($P(NODE0,"^"))&($P($P(NODE0,"^"),"(")'=PARTS("VARIABLE"))) 0
 D
 .N COUNT
 .I '$$SNTXVAR(PARTS("VARIABLE")) S BAD=1 Q
 .Q:LOCK'["("
 .I $E(LOCK,$L(LOCK))'=")" S BAD=1 Q
 .S LOCK=$P(LOCK,"(",2,99)
 .F COUNT=1:1 S PARTS=$P(LOCK,",",COUNT) Q:PARTS=""  D  Q:BAD
 ..I $E(PARTS,$L(PARTS))=")" S PARTS=$E(PARTS,1,$L(PARTS)-1) I $P(LOCK,",",COUNT+1)'="" S BAD=1 Q
 ..S PARTS(COUNT)=PARTS,PARTS(0)=COUNT
 ..;
 ..D
 ...;PARTS is either a number, a string, or a variable
 ...I PARTS=+PARTS S PARTS(COUNT,"VARIABLE")=0 Q
 ...I $E(PARTS)="""",$E(PARTS,$L(PARTS))="""" S PARTS(COUNT,"VARIABLE")=0 Q
 ...I '$$SNTXVAR(PARTS) S BAD=1 Q
 ...S PARTS(COUNT,"VARIABLE")=1 Q
 ;
 I BAD K PARTS S PARTS(0)=0
 S PARTS=""
 Q 'BAD
SNTXVAR(X) ;
 ;Checks the syntax for a variable.  Returns 1 if ok, 0 otherwise.
 ;
 N PATTERN,LEN
 S LEN=$L(X)
 Q:LEN>8 0
 S PATTERN=$S(LEN>1:"1U"_(LEN-1)_"UN",1:"1U")
 I X?@PATTERN Q 1
 Q 0
 ;
ADDPARTS(IEN) ;
 ;Adds the parts parsed from the lock template to the dictionary
 ;IEN is the record in the LOCK DICTIONARY.
 ;PARTS is an array containing the elements parsed out of the lock template
 ;
 N TEMPLATE,PARTS
 S TEMPLATE=$$TEMPLATE^XULMU(IEN)
 Q:'$$SNTXLOCK(TEMPLATE,.PARTS)
 N ORDER,DATA,DA
 S DATA(1.02)=PARTS("GLOBAL")
 D UPD^XULMU(8993,IEN,.DATA)
 K DATA
 F ORDER=1:1:PARTS(0) D
 .S DA(1)=IEN
 .S DATA(.01)=ORDER
 .S DATA(.02)=PARTS(ORDER)
 .S DATA(.04)=$S($G(PARTS(ORDER,"VARIABLE")):"V",1:"L")
 .S DA=$O(^XLM(8993,DA(1),2,"B",ORDER,0))
 .I 'DA D
 ..D ADD^XULMU(8993.02,.DA,.DATA)
 .E  D
 ..D UPD^XULMU(8993.02,.DA,.DATA)
 ;
 ;delete any subscripts not found in the LOCK TEMPLATE
 S ORDER=PARTS(0) F  S ORDER=$O(^XLM(8993,IEN,2,"B",ORDER)) Q:'ORDER  S DA=$O(^XLM(8993,IEN,2,"B",ORDER,0)) I DA S DA(1)=IEN D DELETE^XULMU(8993.02,.DA)
 Q
 ;
SELECT() ;Select a LOCK TEMPLATE to edit
 N DA,DIC,Y,DTOUT
 S DA=0
 S DIC=8993
 S DIC(0)="AEMNO"
 W !,"** You cannot enter the '^' prefix when selecting a lock template. **"
 D ^DIC
 S:+Y>0 DA=+Y
 Q DA
 ;
EDIT(DA) ;Edit the lock dictionary entry ien=DA
 ;
 Q:'$G(DA)
 N DIE,DR,Y,RET,DTOUT,ORDER,D,D0,DI,DQ,QUIT
 S QUIT=0
 ;
 D
 .S RET=DA
 .S DR=".01;1.02;1.01;1.03//YES;W !!,""What is the purpose of the lock?"",!;4Purpose;S QUIT=0"
 .S DIE=8993
 .S QUIT=1
 .D ^DIE
 .Q:QUIT
 .D ADDPARTS(RET)
 .S DA(1)=RET
 .F ORDER=1:1 S DA=$O(^XLM(8993,DA(1),2,"B",ORDER,0)) Q:'DA  D  I QUIT S QUIT=0 Q
 ..I ORDER=1 W !!,"Checking for variables within the LOCK TEMPLATE..."
 ..N NODE
 ..S NODE=$G(^XLM(8993,DA(1),2,DA,0))
 ..I $P(NODE,"^",4)="V" D
 ...N VARIABLE
 ...S VARIABLE=$P(NODE,"^",2)
 ...W !!,"Found variable '"_VARIABLE_"'..."
 ...S DIE="^XLM(8993,DA(1),2,"
 ...W !!,"You can optionally enter MUMPS code to verify that the variable '"_VARIABLE_"'",!,"has a permissible value. It should set Y=0 if not ok, Y=1 if ok.",!
 ...S DR="1Executable check logic"
 ...D ^DIE I $D(DTOUT)!$D(Y) S QUIT=1 Q
 .;
 .W !!,"You can display file identifiers for the locked record, or for a record in"
 .W !,"another file related to the locked record.  Most locks are related to a"
 .W !,"specific patient, so most entries in the lock dictionary should include a"
 .W !,"file reference to the PATIENT file (#2) and to the file of the locked record,"
 .W !,"and perhaps other files as well."
 .W !!,"If you would like to include file references, first select the file, and then",!,"enter the MUMPS code that will retrieve the file identifiers from that file.",!
 .K DA S DA=+RET
 .S DR="3"
 .S DR(2,8993.03)=".01File;W !!,""Enter MUMPS code to return identifiers for the record related to the lock."",!;1MUMPS Code;W !!,""List the identifiers that are returned for this file reference."",!;2Identifiers"
 .S DIE=8993
 .D ^DIE
 .I $D(DTOUT)!$D(Y) S QUIT=1 Q
 Q QUIT
 ;
ASK() ;Ask user if he wants to edit an existing lock template or create
 ;a new one.
 ;
 N DIR
 S DIR(0)="S^A:Add a new entry;E:Edit an existing entry;D:Delete an existing entry"
 S DIR("?")="Do you want to Add, Edit, or Delete an entry in the lock dictionary?"
 W !,DIR("?"),!
 S DIR("B")="E"
 D ^DIR
 I Y="E" D
 .D EDIT($$SELECT)
 E  I Y="D" D
 .D DELETE($$SELECT)
 E  I Y="A" D
 .D EDIT($$CREATE)
 Q
DELETE(IEN) ;
 Q:'IEN
 I $$ASKYESNO^XULMU("Are you sure","NO") D DELETE^XULMU(8993,IEN) W !,"Deleted!"
 Q
 ;
 ;
CREATE() ;Ask the user to enter a LOCK TEMPLATE, then
 ;create a new entry in the lock dictionary.
 ;
 N DA,QUIT
 S (DA,QUIT)=0
 ;
 F  D  Q:QUIT
 .N I,DIR,X,Y
 .N TEMPLATE,GLOBAL
 .S DIR(0)="8993,.01"
 .;ask user for LOCK TEMPLATE
 .D ^DIR
 .I $D(DIRUT) S QUIT=1 K DIRUT Q
 .S GLOBAL=$S($E(X,1,2)["^":1,1:0)
 .S TEMPLATE=$P(X,"^",(1+GLOBAL))
 .I TEMPLATE="" S QUIT=1 QUIT
 .S DA=$O(^XLM(8993,"E",GLOBAL,TEMPLATE,0))
 .S:'DA DA=$O(^XLM(8993,"E",'GLOBAL,TEMPLATE,0))
 .I DA S QUIT='$$ASKYESNO^XULMU("That LOCK TEMPLATE already exists!  Do you want to edit it","NO") I QUIT S DA=0 Q
 .;
 .;create a new entry
 .I 'DA D
 ..N DATA,ERROR
 ..S DATA(.01)=TEMPLATE
 ..S DATA(1.02)=GLOBAL
 ..S DA=$$ADD^XULMU(8993,,.DATA,.ERROR)
 ..I 'DA W !,ERROR
 ..S QUIT=1
 ;
 ;
 Q DA
 ;
 ;
 ;
