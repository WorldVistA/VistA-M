PXRMLREX ;SLC/PJH - Delete rule components ;07/03/2002
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
 S DIR("??")=U_"D HLP^PXRMLREX(HELP)"
 D ^DIR K DIR
 I $D(DIROUT) S DTOUT=1
 I $D(DTOUT)!($D(DUOUT)) Q
 S YESNO=$E(Y(0))
 Q
 ;
 ;Give option to delete all descendents
 ;-------------------------------------
DELETE(COMP) ;
 N ANS,HLP,LRIEN,LRNAM,LRTYP,IC,TEXT
 ;Parent name and type
 S LRNAM=$P(COMP(0),U)
 ;Prompt information
 S TEXT(1)="List Rule Set "_LRNAM_" had unused components."
 S TEXT="Delete all these component rules:"
 ;List component names
 S IC=2,LRIEN=0,TEXT(2)="",HLP=1
 F  S LRIEN=$O(COMP(LRIEN)) Q:'LRIEN  D  Q:IC>15
 .S IC=IC+1 I IC>15 S TEXT(IC)="<<more>>" Q
 .N LRTYP
 .S LRTYP=$P(COMP(LRIEN),U,2)
 .S LRTYP=$S(LRTYP=1:"list rule",LRTYP=2:"reminder rule",1:"output rule")
 .S TEXT(IC)=$P(COMP(LRIEN),U)_$J("",5)_LRTYP
 S TEXT(IC+1)=""
 ;Ask Delete Y/N?
 D ASK(.ANS,.TEXT,HLP) Q:$G(ANS)'="Y"
 ;Use DIK to remove all unused components
 N DA,DIK
 S LRIEN=0
 ;Scan list of unused components
 F  S LRIEN=$O(COMP(LRIEN)) Q:'LRIEN  D
 .;Delete component dialog
 .S DA=LRIEN,DIK="^PXRM(810.4," D ^DIK
 Q
 ;
 ;Build list of components
 ;------------------------
COMP(IEN,COMP) ;
 ;Build list of components
 D COMPR(IEN,.COMP) Q:'$D(COMP)
 ;Get reminder dialog, group or element name and type
 N DATA
 S DATA=$G(^PXRM(810.4,IEN,0))
 ;Save for future use
 S COMP(0)=$P(DATA,U)_U_$P(DATA,U,4)
 Q
 ;
 ;Recursive call
 ;--------------
COMPR(IEN,COMP) ;
 N DATA,LRIEN,LRNAME,LRTYP,PARENT,SUB
 S LRIEN=0,PARENT="LOCAL"
 ;Check if parent is national
 I $P($G(^PXRM(810.4,IEN,100)),U)="N" S PARENT="NATIONAL"
 ;
 F  S LRIEN=$O(^PXRM(810.4,IEN,30,"D",LRIEN)) Q:'LRIEN  D
 .;Ignore national components
 .I $P($G(^PXRM(810.4,LRIEN,100)),U)="N",PARENT'="NATIONAL" Q
 .;Ignore if in use
 .I $$USED(LRIEN,IEN) Q
 .;Save component dialog type and name
 .S DATA=$G(^PXRM(810.4,LRIEN,0)),LRNAME=$P(DATA,U),LRTYP=$P(DATA,U,3)
 .S COMP(LRIEN)=LRNAME_U_LRTYP
 .;For groups and element check sub-components
 .I (LRTYP="G")!(LRTYP="E") D COMPR(LRIEN,.COMP)
 Q
 ;
 ;Check if in use
 ;---------------
USED(LRIEN,IEN) ;
 N SUB,DINUSE
 S SUB=0,DINUSE=0
 F  S SUB=$O(^PXRM(810.4,"AD",LRIEN,SUB)) Q:'SUB  D  Q:DINUSE
 .;In use by other than parent
 .I SUB'=IEN S DINUSE=1
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
 ;
 D HELP^PXRMEUT(.HTEXT)
 Q
