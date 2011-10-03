PXRMDEDI ; SLC/PJH - Edit PXRM reminder dialog. ;05/31/2006
 ;;2.0;CLINICAL REMINDERS;**4**;Feb 04, 2005;Build 21
 ;
 ;Used by protocol PXRM DIALOG SELECTION ITEM
 ;
ASK(PIEN,SEQ) ;Ask if OK to delete
 N DDATA,DIR,DTYP,NAME,TYP,X,Y
 K DIROUT,DIRUT,DTOUT,DUOUT
 S DDATA=$G(^PXRMD(801.41,PIEN,0))
 S NAME=$P(DDATA,U),TYP=$P(DDATA,U,4)
 S DIR(0)="YA0"
 S DIR("A")="Delete sequence "_SEQ_" from "
 I TYP="G" S DIR("A")=DIR("A")_"group "_NAME_": "
 E  S DIR("A")=DIR("A")_"reminder dialog "_NAME_": "
 S DIR("B")="N"
 S DIR("?")="Enter Y or N. For detailed help type ??"
 S DIR("??")=U_"D XHLP^PXRMDLG(1)"
 D ^DIR K DIR
 I $D(DIROUT) S DTOUT=1
 I $D(DTOUT)!($D(DUOUT)) Q
 I $E(Y(0))="N" S DUOUT=1
 S VALMBCK="R"
 Q
 ;
DEL(SEQ,PXRMDIEN) ;Delete individual element from dialog or group
 N DA,DIK
 S DIEN=0
 F  S DIEN=$O(^PXRMD(801.41,PXRMDIEN,10,DIEN)) Q:'DIEN  D
 .I $P($G(^PXRMD(801.41,PXRMDIEN,10,DIEN,0)),U)=SEQ D
 ..S DA(1)=PXRMDIEN,DA=DIEN W !,"DA: "_DA Q:'DA
 ..S DIK="^PXRMD(801.41,"_DA(1)_",10,"
 ..D ^DIK
 S VALMBG=1
 Q
 ;
IND(DIEN,SEL) ;Edit individual element
 W IORESET
 N DIC,DIDEL,DR,DTOUT,DTYP,DUOUT,DINUSE,HED,LFIND,LOCK,NATIONAL,OIEN,PLOCK,Y
 ;
 S OIEN=0
 ;Check for Uneditable flag
 S LOCK=$P($G(^PXRMD(801.41,DIEN,100)),U,4)
 S LFIND=$P($G(^PXRMD(801.41,DIEN,1)),U,5)
 I LOCK=1,$G(LFIND)'="",$G(LFIND)'["ORD",'$G(PXRMINST) D  Q
 .W !,"This item can not be edited" H 2
 ;
 S NATIONAL=0
 ;Limited edit of National dialogs
 I $P($G(^PXRMD(801.41,PXRMDIEN,100)),U)="N" D
 .I $G(PXRMINST)=1,DUZ(0)="@" Q
 .S NATIONAL=1
 .S PLOCK=$P($G(^PXRMD(801.41,PXRMDIEN,100)),U,4)
 ;
 N ANS,DATA,PIEN,SEQ
 ;Get group or reminder dialog ien for this component
 S DATA=$G(^TMP("PXRMDLG4",$J,"IEN",SEL))
 S PIEN=$P(DATA,U),SEQ=$P(DATA,U,2)
 ;National dialogs can only be edited
 I NATIONAL S ANS="E"
 ;In Group edit the group can only be edited
 I DIEN=PXRMDIEN S ANS="E"
 ;Ask what to do with local dialogs
 S DTYP=$P($G(^PXRMD(801.41,DIEN,0)),U,4) Q:DTYP=""
 I (('NATIONAL)&(DIEN'=PXRMDIEN))!((NATIONAL)&($G(PLOCK)=1)&(DIEN'=PXRMDIEN)&($G(LOCK)'=1)) D  Q:$D(DUOUT)!$D(DTOUT)
 .D PROMPT(.ANS,DIEN) Q:$D(DTOUT)!$D(DUOUT)
 .;Display usage
 .I "DC"[ANS D
 ..W !,"Dialog Name: "_$P($G(^PXRMD(801.41,DIEN,0)),U)
 .; Verify delete
 .I ANS="D" D ASK(PIEN,SEQ)
 ;Ask what to do with National Dialogs that have a lock on them
 ;I NATIONAL,DIEN'=PXRMDIEN,$P($G(^PXRMD(801.41,DIEN,100)),U,4)=1 D  Q:$D(DUOUT)!$D(DTOUT)
 I NATIONAL,DIEN'=PXRMDIEN,LOCK=1,DTYP="G" D  Q
 .W !,"Cannot modify lock group from a higher level view. Please modify"
 .W !,"this group from the group editor screen." H 2
 ;
 ;Delete line
 I ANS="D" D DEL(SEQ,PIEN) Q
 ;Copy and Replace option
 I ANS="C" D SEL^PXRMDCPY(.DIEN,PIEN) Q:$D(DTOUT)!$D(DUOUT) 
 ;Determine if a taxonomy dialog
 N FIND
 I ANS="R" S OIEN=DIEN,(IEN,DIEN)=$P($G(^PXRMD(801.41,DIEN,49)),U,3)
 S FIND=$P($G(^PXRMD(801.41,IEN,1)),U,5),VALMBCK="R"
 ;Edit taxomomy dialog
 I $P(FIND,";",2)="PXD(811.2," D EDIT^PXRMGEDT("DTAX",$P(FIND,";"),0) Q
 ;Option to change an element to a group
 I DTYP="E",'NATIONAL D NTYP^PXRMDEDT(.DTYP) Q:$D(DUOUT)!$D(DTOUT)  D:DTYP="G"
 .S $P(^PXRMD(801.41,DIEN,0),U,4)=DTYP
 .W !,"Dialog element changed to a dialog group"
 ;Edit Element
 D EDIT^PXRMDEDT(DTYP,DIEN,OIEN)
 Q
 ;
PROMPT(ANS,DIEN) ;Select Dialog Element Action
 N NAME,X,Y,DIR K DIROUT,DIRUT,DTOUT,DUOUT
 S DIR(0)="S"_U_"E:Edit;"
 S DIR(0)=DIR(0)_"C:Copy and Replace current element;"
 S DIR(0)=DIR(0)_"D:Delete element from this dialog;"
 I $P($G(^PXRMD(801.41,DIEN,49)),U,3)>0 D
 .S NAME=$P($G(^PXRMD(801.41,$P($G(^PXRMD(801.41,DIEN,49)),U,3),0)),U)
 .S DIR(0)=DIR(0)_"R:Edit Replacement Element/Group "_NAME_";"
 S DIR("A")="Select Dialog Element Action"
 S DIR("B")="E"
 S DIR("?")="Select from the codes displayed. For detailed help type ??"
 S DIR("??")=U_"D HELP^PXRMDEDI(1)"
 D ^DIR K DIR
 I $D(DIROUT) S DTOUT=1
 I $D(DTOUT)!($D(DUOUT)) Q
 S ANS=Y
 Q
 ;
HELP(CALL) ;General help text routine
 N HTEXT
 N DIWF,DIWL,DIWR,IC
 S DIWF="C70",DIWL=0,DIWR=70
 ;
 I CALL=1 D
 .S HTEXT(1)="Select E to edit dialog element. If you wish to create"
 .S HTEXT(2)="a new dialog element just for this reminder dialog select"
 .S HTEXT(3)="C to copy and replace the current element. Select D to"
 .S HTEXT(4)="delete the sequence number/element from the dialog."
 K ^UTILITY($J,"W")
 S IC=""
 F  S IC=$O(HTEXT(IC)) Q:IC=""  D
 . S X=HTEXT(IC)
 . D ^DIWP
 W !
 S IC=0
 F  S IC=$O(^UTILITY($J,"W",0,IC)) Q:IC=""  D
 . W !,^UTILITY($J,"W",0,IC,0)
 K ^UTILITY($J,"W")
 W !
 Q
