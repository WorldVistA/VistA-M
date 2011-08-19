OOPSSOF1 ;HINES/WAA-SOF/E Safety officer Edit Routine ;3/30/98
 ;;2.0;ASISTS;;Jun 03, 2002
 ;;
 ; The call to $$SAFETY^OOPSUTL2 filters cases that have not been
 ; signed by the Supervisor.  Only signed cases can be selected.
EN1 ;  Main Entry Point
 N SSN,IEN,FORM,SIGN
 S IEN=0
 Q:DUZ<1
 Q:$G(^VA(200,DUZ,1))=""
 S SSN=$P(^VA(200,DUZ,1),U,9)
 D  Q:IEN<1
 .N DIC,X
 .S DIC="^OOPS(2260,",DIC("S")="I '$$GET1^DIQ(2260,Y,51,""I""),$$SAFETY^OOPSUTL2(Y)"
 .S DIC(0)="AEMNZ",DIC("A")="Select Case: "
 .D ^DIC
 .Q:Y<1
 .Q:$D(DTOUT)!($D(DUOUT))
 .S IEN=$P(Y,U)
 .Q
 D FORM I $D(Y) G EXIT
 D SIGN(FORM)
 I $P(SIGN,U) D CLOSE
EXIT K DIC,SUP
 Q
CLOSE ; Close
 N DR,DIE
 S DR="",DA=IEN,DIE="^OOPS(2260,"
 S DR="51 CASE STATUS..................//C"
 D ^DIE
 Q
FORM ; Form
 S FORM="2162"
 N DR,DIE
 D ^OOPSDIS
 ; Patch 8 - changed call from local subroutine
 D CLRES^OOPSUTL1(IEN,"O",FORM)
 S DR="",DIE="^OOPS(2260,",DA=IEN
 ; Patch 5 - changed order of the following 2 prompts
 S DR(1,2260,1)="47 CORRECTIVE ACTION TAKEN......"
 S DR(1,2260,5)="55 SAFETY OFF. COMMENTS........."
 D ^DIE
 Q
SIGN(FORM) ; Sign/validate Document
 N INC,VALID,SSIGN,ESIGN,CLOSE,MSG,Y
 S CLOSE=1,VALID=0,SIGN=""
 W ! ; Added linefeed for readablitiy - P8
 D VALIDATE^OOPSUTL4(IEN,FORM,"O",.VALID) W !
 I 'VALID Q
 S INC=$$GET1^DIQ(2260,IEN,52,"I")
 S SSIGN=$$EDSTA^OOPSUTL1(IEN,"S")
 S ESIGN=$$EDSTA^OOPSUTL1(IEN,"E")
 ; Patch 8 - determine if emp & super have signed CA, if not, give
 ; safety option of signing. Else, sign without asking
 I '$P(ESIGN,U,INC) D
 . W !,"The Employee portion of the CA",$S(INC=1:1,INC=2:2,1:0)," has not been signed."
 . S CLOSE=0
 . Q
 I '$P(SSIGN,U,INC) D
 . W !,"The Supervisor portion of the CA",$S(INC=1:1,INC=2:2,1:0)," has not been signed."
 . S CLOSE=0
 . Q
 I 'CLOSE D
 . S MSG("DIHELP",1)=""
 . S MSG("DIHELP",2)="The Employee or Supervisor has not signed their"
 . S MSG("DIHELP",3)="part of the CA Claim form."
 . S MSG("DIHELP",4)="Signing the form now closes the case and removes"
 . S MSG("DIHELP",5)="it from everyone's selection list for editing."
 . D MSG^DIALOG("WH","","","","MSG")
 . K DIR S DIR(0)="S^1:Yes;0:No"
 . S DIR("A")="Do you want to sign the Case"
 . D ^DIR K DIR
 . S CLOSE=$S(Y=1:1,Y=0:0,1:0)
 . Q
 I 'CLOSE Q
 S SIGN=$$SIG^OOPSESIG(DUZ,IEN)
 ; file electronic signature
 I $P(SIGN,U) D
 . S $P(^OOPS(2260,IEN,"2162ES"),U,4,6)=SIGN
 Q
