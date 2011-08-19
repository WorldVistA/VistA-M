IBDFU4 ;ALB/CJM - ENCOUNTER FORM - BUILD FORM(write single form block to array for display,position & size copied block) ; 08-JAN-1993
 ;;3.0;AUTOMATED INFO COLLECTION SYS;**10**;APR 24, 1997
 ;
IDXBLOCK ; create list containing block rows for list processor
 ;
 N I
 W !,"... BUILDING THE FORM BLOCK ..."
 Q:$$BLKDESCR^IBDFU1B(.IBBLK)
 ;
 ;keep small blocks in memory
 ;I ((IBBLK("H")+1)*(IBBLK("W")+1))<4000 S VALMAR="IBMEMARY"
 ;
 K @VALMAR D KILL^VALM10()
 D BLNKFORM^IBDF5A(0,IBBLK("H")-1,IBBLK("W"))
 S I="",$P(I,"~",IBBLK("W")+1)="~"
 S @VALMAR@(IBBLK("H")+1,0)="    "_I
 S VALMCNT=IBBLK("H")+1
 D DRWBLOCK^IBDF2A1(.IBBLK,1)
 Q
POS(NEWBLOCK,DFLTX,DFLTY) ;allows the user to position and size the block
 ;NEWBLOCK = block to be edited
 ;DFLTY - default value for starting row
 ;DFLTX - default value for starting column
 N IBX,IBY ;used in the input template
 S:$G(DFLTX)=+$G(DFLTX) $P(NODE,"^",5)=DFLTX
 S:$G(DFLTY)=+$G(DFLTY) $P(NODE,"^",4)=DFLTY
 N NODE,IBBLK,IBDONE
 S IBBLK=NEWBLOCK
 S NODE=$G(^IBE(357.1,NEWBLOCK,0))
 ;set defaults for starting column, starting row
 S ^IBE(357.1,NEWBLOCK,0)=NODE,IBDONE=0
 K DIE S DIE=357.1,DA=NEWBLOCK,DR="[IBDF POSITION COPIED BLOCK]"
 D ^DIE K DIE,DR,DA
 I 'IBDONE D DLTBLK^IBDFU3(NEWBLOCK,IBFORM,357.1)
 Q
CURX() ;returns the current X position (top left corner of displayed poriton of the form - internal column value)
 N IB
 S IB=+$G(VALMLFT),IB=IB-5 S:IB<0 IB=0
 Q IB
CURY() ;returns the current Y position (top left corner of displayed poriton of the form - internal row value)
 N IB
 S IB=+$G(VALMBG),IB=IB-1 S:IB<0 IB=0
 Q IB
SLCTFORM(TK,NODE) ;allows the user to select a form and returns the IEN
 ;returns 0 if no form selected
 ;
 ;INPUTS
 ;if TK=0 assumes form should not be a toolkit form
 ;if TK=1 assumes form should be a toolkit form
 ;otherwise, ask the user if the he wants to select fromt he toolkit
 ;
 ;NODE is optional - if defined it returns the 0 node of the form selected - should be passed by reference
 ;
 N FORM,Y S FORM=0
 S TK=$G(TK)
 I TK'=0,TK'=1 D
 .K DIR S DIR(0)="YA",DIR("A")="Do you want to select a form from the toolkit? "
 .D ^DIR
 .I Y'=-1,'$D(DIRUT) S TK=Y
 ;don't continue with the selection if it is not known whether or not the form is comming from the toolkit
 I (TK=1)!(TK=0) D
 .D:$G(IBDEVICE("LISTMAN")) FULL^VALM1
 .K DIC S DIC("S")=$S(TK:"I $P($G(^(0)),U,7),$P($G(^(0)),U)'=""TOOL KIT"",$P($G(^(0)),U)'=""WORKCOPY"",$P($G(^(0)),U)'=""DEFAULTS""",1:"I '$P($G(^(0)),U,7)"),DIC=357,DIC(0)="AEQ"_$S($D(NODE):"Z",1:"")
 .S DIC("A")="Select a FORM: "
 .D ^DIC S:+Y>0 FORM=+Y
 I FORM,$D(NODE) S NODE=Y(0)
 K DIC,Y,DIR
 Q FORM
CLINICS(FORM,ARY) ;finds the list of clinics using FORM
 ;@ARY@(0) is set to the number of clinics found
 ;ARY is where to put the list of clinics
 ;
 N CLINIC,SETUP,IDX,COUNT,NAME
 K @ARY
 S COUNT=0
 F IDX="C","D","E","F","G","H","I","J" D
 .S SETUP="" F  S SETUP=$O(^SD(409.95,IDX,FORM,SETUP)) Q:'SETUP  D
 ..S CLINIC=$P($G(^SD(409.95,SETUP,0)),"^",1)
 ..Q:'CLINIC
 ..S NAME=$P($G(^SC(CLINIC,0)),"^",1)
 ..Q:NAME=""
 ..I '$D(@ARY@(NAME)) S @ARY@(NAME)=CLINIC,COUNT=COUNT+1
 S @ARY@(0)=COUNT
 Q
LIST(ARY,SCRNSIZE) ;
 ;ARY is the same as in CLINICS
 N CLINIC,COUNT,DIR,DTOUT,DUOUT,DIRUT,DIROUT
 S DIR(0)="YO",DIR("B")="Y",DIR("A")="List the clinics using the form"
 D ^DIR K DIR I '$D(DIRUT),Y D
 .S (COUNT,CLINIC)=0
 .S DIR(0)="E"
 .F  S CLINIC=$O(@ARY@(CLINIC)) Q:CLINIC=""  W !,CLINIC S COUNT=COUNT+1 I COUNT=SCRNSIZE D ^DIR Q:'Y  S COUNT=0
 .I '$D(DUOUT) D:COUNT>0 ^DIR
 Q
