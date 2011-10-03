PXRMDD41 ; SLC/PJH Reminder Dialog file calls ;11/22/2000
 ;;2.0;CLINICAL REMINDERS;;Feb 04, 2005
 ;
 ;copied from ORDD41 for dialog reminders
 ;
 ;
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
 .S DIC("S")=DIC("S")_"&($G(Y)'=DA(1))"
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
