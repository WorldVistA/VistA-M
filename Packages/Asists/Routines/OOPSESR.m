OOPSESR ;WIOFO/CAH-EDIT STUB RECORD ;12/14/99
 ;;2.0;ASISTS;;Jun 03, 2002
EN1(CALLER) ;Entry for Edit Stub Routine
 N DIC,Y
 S DIC("S")="I '(+$TR($$SIGNED^OOPSESR(Y),""^""))"
 S DIC="^OOPS(2260,",DIC(0)="AEMZ" D ^DIC Q:Y=-1
 K DIC
 S IEN=+Y
 Q:'IEN
EDIT ;EDIT STUB 
 D ^OOPSDIS
 S DA=IEN,DR="",DIE=2260
 N REC,NDR S REC=DA
 S DR(1,2260,5)="3 1.  TYPE OF INCIDENT..........."
 S DR(1,2260,10)="6 2.  DATE OF BIRTH.............."
 S DR(1,2260,15)="5 3.  SSN........................"
 S DR(1,2260,20)="7 4.  SEX........................"
 S DR(1,2260,25)="8 5.  HOME STREET ADDRESS........"
 S DR(1,2260,26)="I X'="""",'$$VCHAR^OOPSUTL4(X) W !,""Invalid character entered, (~,`,@,#,$,%,*,_,|,\,},{,[,],>, or <),"",!,""please edit."",! S Y=8"
 S DR(1,2260,30)="9 6.  CITY......................."
 S DR(1,2260,31)="I X'="""",'$$VCHAR^OOPSUTL4(X) W !,""Invalid character entered, (~,`,@,#,$,%,*,_,|,\,},{,[,],>, or <),"",!,""please edit."",! S Y=9"
 S DR(1,2260,35)="10 7.  STATE......................"
 S DR(1,2260,40)="11 8.  ZIP CODE..................."
 S DR(1,2260,45)="12 9.  HOME PHONE NUMBER.........."
 ; Patch 8 - add error checking for DOL requirement
 S DR(1,2260,46)="I $TR(X,""/-*#"","""")'?10N W !?3,""Phone number must include area code and 7 digits only.  Example 703-123-8789"" S Y=12"
 S DR(1,2260,50)="13 10. STATION NUMBER............."
 S DR(1,2260,55)="53 11. SUPERVISOR................."
 S DR(1,2260,60)="53.1 12. SECONDARY SUPERVISOR......."
 S NDR=DR
 L +^OOPS(2260,DA):2
 I $T D ^DIE
 L -^OOPS(2260,REC)
 E  W !,"File is currently locked by another user"
 K DA,DR,DIE,REC,NDR
 Q
SIGNED(IEN) ;Check to see if 2162, CA1 or CA2 is signed.
 N CHECK
 S CHECK=""
 F I=45,49,120,170,222,266 D
 .S CHECK=CHECK_$S($$GET1^DIQ(2260,IEN,I,"I")'="":1,1:0)_U
 Q CHECK
