OOPSSOF2 ;HINES/WAA-SOF/E Safety officer CLOSE Routine ;3/30/98
 ;;2.0;ASISTS;;Jun 03, 2002
 ;;
EN1 ;  Main Entry Point
 N DIC,SSN,IEN,CLOSED,FORM,SIGN
 S IEN=0
 D  Q:IEN<1
 .N DIC,X
 .S DIC="^OOPS(2260,"
 .S DIC(0)="AEMNZ",DIC("S")="I $$GET1^DIQ(2260,Y,51,""I"")'=3",DIC("A")="Select Case: "
 .D ^DIC
 .Q:Y<1
 .Q:$D(DTOUT)!($D(DUOUT))
 .S IEN=$P(Y,U)
 .Q
CLOSE ; Close
 N DR,DIE,SIGN2,CURSTAT,DIR
 D ^OOPSDIS
 S CURSTAT=$$GET1^DIQ(2260,IEN,51,"E")
 S DIR(0)="SAO^0:Open;1:Closed;2:Deleted"
 S DIR("A")=" CASE STATUS.................."
 S DIR("B")=$S(CURSTAT'="":$E(CURSTAT,1),1:"C") D ^DIR
 I $D(DIRUT) Q
 S DR=""
 ; Patch 5 - Clear Field 57 when needed
 I CURSTAT="Closed" D
 . I $$EXTERNAL^DILFD(2260,51,,Y)["Deleted" Q    ; Perserve Date
 . I $$EXTERNAL^DILFD(2260,51,,Y)'[CURSTAT D
 .. S DR(1,2260,2)="57////@"
 S DR(1,2260,1)="51////"_Y
 I Y=2 D
 .S DR(1,2260,2)="58 REASON FOR DELETION........."
 S DIE="^OOPS(2260,",DA=IEN
 D ^DIE
 K SUP                         ; patch 8 - clean up var from OOPSDIS
 Q
