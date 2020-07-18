PXRMDD41 ;SLC/PJH - Reminder Dialog file calls ;10/19/2015  09:13
 ;;2.0;CLINICAL REMINDERS;**45**;Feb 04, 2005;Build 566
 ;
 ;copied from ORDD41 for dialog reminders
KILL(DLG) ;
 Q
 ;
 ; Update audit trail when ITEMS changed
REDOX I $D(^PXRMD(801.41,+$G(DA(1)),0)) S $P(^(99),U)=$$NOW^XLFDT
 Q
 ;
SCREEN ;validate dialog type
 Q:'$G(DA(1))
 N PXRMMTYP
 S PXRMMTYP=$P($G(^PXRMD(801.41,DA(1),0)),U,4)
 ;MH results and Reminder dialogs dissallowed
 S DIC("S")="I ""RST""'[$P(^(0),U,4)"
 ;Dialog elements can only contain prompts/forced values
 I PXRMMTYP="E" S DIC("S")="I ""FP""[$P(^(0),U,4)"
 ;Reminder dialogs can contain only Elements and Groups
 I PXRMMTYP="R" S DIC("S")="I ""EG""[$P(^(0),U,4)"
 ;MH Result Groups can only contain MH Result Elementss
 I PXRMMTYP="S" S DIC("S")="I ""T""=$P(^(0),U,4)"
 ;Dialog groups cannot point to themselves
 I PXRMMTYP="G" D
 .;S DIC("S")=DIC("S")_",$G(Y)'=DA(1)"
 .S DIC("S")=DIC("S")_",$G(Y)'=DA(1),$$VGROUP^PXRMDD41($G(Y),DA(1))=0"
 Q
 ;
 ; UPDATE last amend date
SET(DLG) ;
 S $P(^PXRMD(801.41,DLG,99),U)=$$NOW^XLFDT
 Q
 ;
 ; -- Ck menu tree to ensure new item is not an ancestor
 ;    Input Xform for Item field #2 of Items subfile #801.412
 ;      expecting DA, DA(1), X from FileMan
TREE ;
 D SCREEN
 N PXRMDDA,PXRMDD S PXRMDDA=DA(1)
 K:X=PXRMDDA X D TREE1
 Q
 ; -- Look for X in ancestors
TREE1 F PXRMDD=0:0 Q:'$D(X)  S PXRMDD=$O(^PXRMD(801.41,"AD",PXRMDDA,PXRMDD)) Q:PXRMDD'>0  K:X=PXRMDD X Q:'$D(X)  D TREE2
 Q
 ; Back up another level
TREE2 N PXRMDDA S PXRMDDA=PXRMDD N PXRMDD D TREE1
 Q
 ;
VGROUP(DIEN,IEN) ;Check dialog index to see if group will point to itself 
 N FOUND
 S FOUND=0
 ;
 ;Only do check if dialog is a group
 I $P($G(^PXRMD(801.41,DIEN,0)),U,4)'="G" Q FOUND
 ;
 ;Group cannot be added to itself
 I DIEN=IEN S FOUND=1 Q FOUND
 ;
 ;IEN is the dialog group being added to 
 D VGROUP1(DIEN,IEN)
 Q FOUND
 ;
VGROUP1(DIEN,IEN) ;Examine all parent dialogs
 ;
 ;End search if already found
 Q:FOUND
 ;
 ;Check if dialog being added is a parent at this level
 I $D(^PXRMD(801.41,"AD",IEN,DIEN)) S FOUND=1 Q
 ;
 ;If not look at other parents
 N SUB,TIEN
 S SUB=0
 F  S SUB=$O(^PXRMD(801.41,"AD",IEN,SUB)) Q:'SUB  D  Q:FOUND
 .;Ignore reminder dialogs
 .I $P($G(^PXRMD(801.41,SUB,0)),U,4)'="G" Q
 .;Repeat check on other parents
 .D VGROUP1(DIEN,SUB)
 Q
