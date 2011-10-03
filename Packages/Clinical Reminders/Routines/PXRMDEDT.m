PXRMDEDT ; SLC/PJH - Edit PXRM reminder dialog. ;03/01/2010
 ;;2.0;CLINICAL REMINDERS;**4,6,12,17,16**;Feb 04, 2005;Build 119
 ;
 ;Used by protocol PXRM SELECTION ADD/PXRM GENERAL ADD
 ;
 ;Add Dialog
 ;----------
ADD N DA,DIC,Y,DTOUT,DUOUT,DTYP,DLAYGO,HED
 S HED="ADD DIALOG"
 W IORESET
 F  D  Q:$D(DTOUT)
 .S DIC="^PXRMD(801.41,"
 .;Set the starting place for additions.
 .D SETSTART^PXRMCOPY(DIC)
 .S DIC(0)="AELMQ",DLAYGO=801.41
 .S DIC("A")="Select DIALOG to add: "
 .S DIC("DR")="4///"_$G(PXRMDTYP)
 .D ^DIC
 .I $D(DUOUT) S DTOUT=1
 .I ($D(DTOUT))!($D(DUOUT)) Q
 .I Y=-1 K DIC S DTOUT=1 Q
 .I $P(Y,U,3)'=1 W !,"This dialog name already exists" Q
 .S DA=$P(Y,U,1)
 .;Determine dialog type
 .S DTYP=$P($G(^PXRMD(801.41,DA,0)),U,4)
 .;Enter dialog type if a new entry
 .I DTYP="" D  Q:$D(Y)
 ..N DIE,DR
 ..S DIE=801.41,DR=4
 ..D ^DIE
 .;
 .;Edit Dialog
 .D EDIT(DTYP,DA,0)
 Q
 ;
 ;called by protocol PXRM DIALOG EDIT
 ;-----------------------------------
EDIT(TYP,DA,OIEN) ;
 Q:'$$LOCK(DA)
 W IORESET
 N CS1,CS2,D1,DIC,DIDEL,DIE,DIK,DR,DTOUT,DUOUT,DINUSE,TYP,ODA,Y
 ;Save checksum
 S VALMBCK=""
 S CS1=$$FILE^PXRMEXCS(801.41,DA)
 ;
 ;Check dialog type
 S TYP=$P($G(^PXRMD(801.41,DA,0)),U,4)
 S DIE="^PXRMD(801.41,",DIDEL=801.41,DINUSE=0,ODA=DA
 ;Reminder Dialog
 I TYP="R" S DR="[PXRM EDIT REMINDER DIALOG]"
 ;Dialog Element
 I TYP="E" S DR="[PXRM EDIT ELEMENT]"
 ;Additional Prompt
 ;I TYP="P" S DR="[PXRM EDIT PROMPT]"
 ;Forced Value
 I TYP="F" S DR="[PXRM EDIT FORCED VALUE]"
 ;Dialog Group (Finding item dialog)
 I TYP="G" S DR="[PXRM EDIT GROUP]" ;S VALMBCK="R"
 ;Result Group
 I TYP="S" S DR="[PXRM RESULT GROUP]"
 ;Result Element
 I TYP="T" S DR="[PXRM RESULT ELEMENT]"
 ;Allows limited edit of national dialogs
 I $P($G(^PXRMD(801.41,DA,100)),U)="N" D
 .I TYP="T",+$P($G(^PXMRD(801.41,DA,100)),U,4)=0 Q
 .I $G(PXRMINST)=1,DUZ(0)="@" Q
 .S DR="[PXRM EDIT NATIONAL DIALOG]",DINUSE=1
 ;
 I "GEPFS"[TYP D
 .I '$D(^PXRMD(801.41,"AD",DA)),'$D(^PXRMD(801.41,"R",DA)),'$D(^PXRMD(801.41,"RG",DA)) W !,"Not used by any other dialog",! Q
 .I PXRMGTYP'="DLG" S DINUSE=1 Q
 .I PXRMGTYP="DLG" D  Q
 ..N SUB
 ..S SUB=0
 ..F  S SUB=$O(^PXRMD(801.41,"AD",DA,SUB)) Q:'SUB  Q:DINUSE  D
 ...I SUB'=PXRMDIEN S DINUSE=1
 I DINUSE D
 .W !,"Current dialog "_$S(TYP="S":"result group",1:"element/group")_" name: "_$P($G(^PXRMD(801.41,DA,0)),U)
 .I TYP="S" W !,"Used by:" D USE^PXRMDLST(DA,10,PXRMDIEN,"RG") Q
 .I PXRMGTYP="DLGE" D
 ..W !,"Used by:" D USE^PXRMDLST(DA,10,"","AD")
 ..I $D(^PXRMD(801.41,"R",DA))'>0 Q
 ..W !,"Used as a Replacement Element/Group for: " D USE^PXRMDLST(DA,10,"","R")
 .I PXRMGTYP'="DLGE" D
 ..W !,"Used by:" D USE^PXRMDLST(DA,10,PXRMDIEN,"AD")
 ..I $D(^PXRMD(801.41,"R",DA))'>0 Q
 ..W !,"Used as a Replacement Element/Group for: " D USE^PXRMDLST(DA,10,PXRMDIEN,"R")
 ;
 ;Save list of components
 N COMP D COMP^PXRMDEDX(DA,.COMP)
 ;Edit dialog then unlock
 I TYP'="P" D ^DIE D UNLOCK(ODA) I $G(DA)="",$G(OIEN)>0 D
 .S DA=OIEN,DR="118////@" D ^DIE K DA
 I TYP="P" D PROMPT(DA) D UNLOCK(ODA)
 ;I '$D(DUOUT)&($G(D1)'="") D  Q
 I $G(D1)'="" D
 . I $P($G(^PXRMD(801.41,DA,10,D1,0)),U,2)="" D  Q
 . . S DA(1)=DA,DA=D1 Q:'DA
 . . S DIK="^PXRMD(801.41,"_DA(1)_",10,"
 . . D ^DIK
 . . ;S VALMBG=1
 I $D(DUOUT) S VALMBG=1 Q
 I '$D(DA) D  Q
 .;Clear any pointers from #811.9
 .I $D(PXRMDIEN) D PURGE(PXRMDIEN)
 .;Option to delete components
 .I $D(COMP) D DELETE^PXRMDEDX(.COMP)
 .S VALMBCK="R"
 ;
 ;Update edit history
 I (TYP'="R") D
 .S CS2=$$FILE^PXRMEXCS(801.41,DA) Q:CS2=CS1  Q:+CS2=0
 .S DIC="^PXRMD(801.41,"
 .D SEHIST^PXRMUTIL(801.41,DIC,DA)
 ;
 ;Redisplay changes (reminder dialog option only)
 I PXRMGTYP="DLG",TYP="R" D
 .;Get name of reminder dialog again
 .S Y=$P($G(^PXRMD(801.41,DA,0)),U)
 .;Format headings to include dialog name
 .S PXRMHD="REMINDER DIALOG NAME: "_$P(Y,U)
 .;Check if the set is disable and add to header if disabled
 .I $P(^PXRMD(801.41,DA,0),U,3)]"" S PXRMHD=PXRMHD_" (DISABLED)"
 .;Reset header in case name has changed
 .S VALMHDR(1)=PXRMHD
 Q
 ;
 ;Add SINGLE dialog element (protocol PXRM DIALOG SELECTION ITEM)
 ;-------------------------
ESEL(PXRMDIEN,SEL) ;
 N DA,DIC,DLAYGO,DNEW,DTOUT,DUOUT,DTYP,Y
 ;
 S DIC="^PXRMD(801.41,"
 S DLAYGO="801.41"
 ;Set the starting place for additions.
 D SETSTART^PXRMCOPY(DIC)
 S DIC(0)="AEMQL"
 S DIC("A")="Select new DIALOG ELEMENT: "
 S DIC("S")="I ""EGPF""[$P(^PXRMD(801.41,Y,0),U,4)"
 S DIC("DR")="4///E"
 W !
 D ^DIC
 I $D(DUOUT) S DTOUT=1
 I ($D(DTOUT))!($D(DUOUT)) Q
 I Y=-1 K DIC S DTOUT=1 Q
 S DA=$P(Y,U,1) Q:'DA
 S DNEW=$P(Y,U,3)
 ;Group points to itself
 I 'DNEW,$$VGROUP(DA,PXRMDIEN) Q
 ;Add to dialog
 D EADD(SEL,DA,PXRMDIEN)
 ;Determine dialog type
 S DTYP=$P($G(^PXRMD(801.41,DA,0)),U,4)
 ;
 ;Edit Dialog
 I DNEW D EDIT(DTYP,DA)
 Q
 ;
 ;Update dialog component multiple
 ;--------------------------------
EADD(SEL,NSUB,PXRMDIEN) ;
 N ERRMSG,FDAIEN,FDA,IENS
 S IENS="+2,"_PXRMDIEN_","
 S FDA(801.412,IENS,.01)=SEL
 S FDA(801.412,IENS,2)=NSUB
 D UPDATE^DIE("","FDA","FDAIEN","ERRMSG")
 I $D(MSG) D AWRITE^PXRMUTIL("ERRMSG")
 Q
 ;
 ;Change Dialog Element Type
 ;--------------------------
NTYP(TYP) ;
 N X,Y,DIR K DIROUT,DIRUT,DTOUT,DUOUT
 S DIR(0)="SA"_U_"E:Element;"
 S DIR(0)=DIR(0)_"G:Group;"
 S DIR("A")="Dialog Element Type: "
 S DIR("B")="E"
 S DIR("?")="Select from the codes displayed. For detailed help type ??"
 S DIR("??")=U_"D HELP^PXRMDEDT(3)"
 D ^DIR K DIR
 I $D(DIROUT) S DTOUT=1
 I $D(DTOUT)!($D(DUOUT)) Q
 S TYP=Y
 Q
 ;
 ;Clear pointers from the reminder file and process ID file
 ;---------------------------------------------------------
PURGE(DIEN) ;
 ;Purge pointers to this dialog from reminder file
 N RIEN
 S RIEN=0
 F  S RIEN=$O(^PXD(811.9,"AG",DIEN,RIEN)) Q:'RIEN  D
 .K ^PXD(811.9,RIEN,51),^PXD(811.9,"AG",DIEN,RIEN)
 ;
 Q
 ;
VGROUP(DA,IEN) ;Check dialog index to see if group will point to itself 
 N FOUND
 S FOUND=0
 ;
 ;Only do check if dialog is a group
 I $P($G(^PXRMD(801.41,DA,0)),U,4)'="G" Q FOUND
 ;
 ;Group cannot be added to itself
 I DA=IEN D  Q FOUND
 .S FOUND=1
 .W !,"A group cannot be added to itself" H 2
 ;
 ;IEN is the dialog group being added to 
 D VGROUP1(DA,IEN)
 Q FOUND
 ;
VGROUP1(DA,DIEN) ;Examine all parent dialogs
 ;
 ;End search if already found
 Q:FOUND
 ;
 ;Check if dialog being added is a parent at this level
 I $D(^PXRMD(801.41,"AD",DIEN,DA)) D  Q
 .S FOUND=1
 .W !,"A group cannot be added as it's own descendant" H 2
 ;
 ;If not look at other parents
 N SUB
 S SUB=0
 F  S SUB=$O(^PXRMD(801.41,"AD",DIEN,SUB)) Q:'SUB  D  Q:FOUND
 .;Ignore reminder dialogs
 .I $P($G(^PXRMD(801.41,SUB,0)),U,4)'="G" Q
 .;Repeat check on other parents
 .D VGROUP1(DA,SUB)
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
 I CALL=2 D
 .S HTEXT(1)="Enter Y to copy the current dialog element to a new name"
 .S HTEXT(2)="and then use this new element in the reminder dialog."
 I CALL=3 D
 .S HTEXT(1)="Enter G to change the current dialog element into a dialog"
 .S HTEXT(2)="group so that additional elements can be added. Enter E to"
 .S HTEXT(3)="leave the type of the dialog element unchanged."
 I CALL=4 D
 .S HTEXT(1)="Enter Y to change the dialog prompt created into a forced"
 .S HTEXT(2)="value. To edit the new forced value switch to the forced"
 .S HTEXT(3)="value screen using CV. This option only applies to prompts"
 .S HTEXT(4)="which update PCE or vitals."
 .S HTEXT(5)="Enter N to leave the dialog prompt unchanged."
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
 ;
LOCK(DA) ;Lock the record
 N OK
 S OK=1
 I '$$VEDIT^PXRMUTIL("^PXRMD(801.41,",DA) D
 .N DTYP
 .S DTYP=$P($G(^PXRMD(801.41,DA,0)),U,4)
 .;Allow limit edit of Result Elements that are not lock
 .I DTYP="T",+$P($G(^PXRMD(801.41,DA,100)),U,4)=0 Q
 .;Allow edit of findings but not component multiple on groups 
 .I DTYP="G",$G(PXRMDIEN),DA'=PXRMDIEN Q
 .I DTYP="G",$G(PXRMGTYP)="DLGE" Q
 .;Allow edit of element findings
 .I DTYP="E" Q
 .S OK=0
 .W !!,?5,"VA- and national class reminder dialogs may not be edited" H 2
 I 'OK Q 0
 ;
 L +^PXRMD(801.41,DA):0 I  Q 1
 E  W !!,?5,"Another user is editing this file, try later" H 2 Q 0
 ;
PROMPT(IEN) ;
 N DIE,DR
 S DIE="^PXRMD(801.41,",DA=IEN
 S DR=".01;3;100;101;102;24;23;21"
 S IEN=$G(^PXRMD(801.41,IEN,46)) I $G(IEN)="" G EX
 I $P($G(^PXRMD(801.42,IEN,0)),U)="COM" S DR=DR_";45"
EX ;
 D ^DIE
 Q
 ;
UNLOCK(DA) ;Unlock the record
 L -^PXRMD(801.41,DA)
 Q
