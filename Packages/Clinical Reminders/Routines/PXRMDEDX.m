PXRMDEDX ;SLC/PJH - Delete dialog components ;12/12/2001
 ;;2.0;CLINICAL REMINDERS;;Feb 04, 2005
 ;
 ;=====================================================================
 ;
 ;Yes/No Prompts
 ;--------------
ASK(YESNO,TEXT,HELP) ;
 W !
 N DIR,X,Y
 K DIROUT,DIRUT,DTOUT,DUOUT
 S DIR(0)="YA0"
 M DIR("A")=TEXT
 S DIR("B")="Y"
 S DIR("?")="Enter Y or N. For detailed help type ??"
 S DIR("??")=U_"D HLP^PXRMDEDX(HELP)"
 D ^DIR K DIR
 I $D(DIROUT) S DTOUT=1
 I $D(DTOUT)!($D(DUOUT)) Q
 S YESNO=$E(Y(0))
 Q
 ;
 ;Give option to delete all descendents
 ;-------------------------------------
DELETE(COMP) ;
 N ANS,HLP,DIEN,DNAM,DTYP,IC,TEXT
 ;Parent name and type
 S DNAM=$P(COMP(0),U),DTYP=$P(COMP(0),U,2)
 ;Prompt information
 I DTYP="R" D
 .S TEXT(1)="Reminder dialog "_DNAM_" had unused components."
 .S TEXT="Delete all these components:"
 I DTYP="G" D
 .S TEXT(1)="Dialog group "_DNAM_" had unused elements or prompts."
 .S TEXT="Delete all these components:"
 I DTYP="E" D
 .S TEXT(1)="Deleted dialog element "_DNAM_" had unused prompts."
 .S TEXT="Delete all these components:"
 ;List component names
 S IC=2,DIEN=0,TEXT(2)="",HLP=1
 F  S DIEN=$O(COMP(DIEN)) Q:'DIEN  D  Q:IC>15
 .S IC=IC+1 I IC>15 S TEXT(IC)="<<more>>" Q
 .N DTYP
 .S DTYP=$P(COMP(DIEN),U,2)
 .S DTYP=$S(DTYP="E":"element",DTYP="G":"group",1:"prompt")
 .S TEXT(IC)=$P(COMP(DIEN),U)_$J("",5)_DTYP
 S TEXT(IC+1)=""
 ;Ask Delete Y/N?
 D ASK(.ANS,.TEXT,HLP) Q:$G(ANS)'="Y"
 ;Use DIK to remove all unused components
 N DA,DIK
 S DIEN=0
 ;Scan list of unused components
 F  S DIEN=$O(COMP(DIEN)) Q:'DIEN  D
 .;Delete component dialog
 .S DA=DIEN,DIK="^PXRMD(801.41," D ^DIK
 Q
 ;
 ;Build list of components
 ;------------------------
COMP(PXRMDIEN,COMP) ;
 ;Build list of components
 D COMPR(PXRMDIEN,.COMP) Q:'$D(COMP)
 ;Get reminder dialog, group or element name and type
 N DDATA
 S DDATA=$G(^PXRMD(801.41,PXRMDIEN,0))
 ;Save for future use
 S COMP(0)=$P(DDATA,U)_U_$P(DDATA,U,4)
 Q
 ;
 ;Recursive call
 ;--------------
COMPR(PXRMDIEN,COMP) ;
 N DIEN,DNAME,DNODE,DTYP,PARENT,SUB
 S DIEN=0,PARENT="LOCAL"
 ;Check if parent is national
 I $P($G(^PXRMD(801.41,PXRMDIEN,100)),U)="N" S PARENT="NATIONAL"
 ;
 F  S DIEN=$O(^PXRMD(801.41,PXRMDIEN,10,"D",DIEN)) Q:'DIEN  D
 .;Ignore national components
 .I $P($G(^PXRMD(801.41,DIEN,100)),U)="N",PARENT'="NATIONAL" Q
 .;Ignore if in use
 .I $$USED(DIEN,PXRMDIEN) Q
 .;Save component dialog type and name
 .S DNODE=$G(^PXRMD(801.41,DIEN,0)),DNAME=$P(DNODE,U),DTYP=$P(DNODE,U,4)
 .S COMP(DIEN)=DNAME_U_DTYP
 .;For groups and element check sub-components
 .I (DTYP="G")!(DTYP="E") D COMPR(DIEN,.COMP)
 Q
 ;
 ;Check if in use
 ;---------------
USED(DIEN,PXRMDIEN) ;
 N SUB,DINUSE
 S SUB=0,DINUSE=0
 F  S SUB=$O(^PXRMD(801.41,"AD",DIEN,SUB)) Q:'SUB  D  Q:DINUSE
 .;In use by other than parent
 .I SUB'=PXRMDIEN S DINUSE=1
 Q DINUSE
 ;
 ;General help text routine.
 ;--------------------------
HLP(CALL) ;
 N HTEXT
 N DIWF,DIWL,DIWR,IC
 S DIWF="C75",DIWL=0,DIWR=75
 ;
 I CALL=1 D
 .S HTEXT(1)="Enter 'Yes' to DELETE all sub-components listed above"
 .S HTEXT(2)="or enter 'No' to quit."
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
