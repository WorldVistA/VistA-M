DGHTENR ;ALB/JAM - Home Telehealth Patient Sign-up;10 January 2005 ; 9/20/07 8:27am
 ;;5.3;Registration;**644**;Aug 13, 1993;Build 11
 ;
EN N DGDFN,STOP,ARR,RESULT,DGVEN,DGPRV,DGCON,GETOK,DGHTH,DGMID,DGCHK,DGDEF
 N DGEVNDT,VENDOR,DGTYPE
 S ARR=$NA(HLA("HLS"))
 S STOP=0
 F  D  Q:STOP
 .K DGHTH
 .S DGHTH("DGTYPE")="A"
 .;Get patient
 .W !!
 .S DGDFN=$$GETPAT() I 'DGDFN S STOP=1 Q
 .S DGHTH("DFN")=DGDFN
 .;Get receiving vendor
 .S DGVEN=$$GETVEN() I 'DGVEN Q
 .S DGHTH("VENDOR")=DGVEN
 .;Check if Patient is already signed up
 .S DGCHK=$$SGNUPCHK(.DGHTH)
 .I 'DGCHK W "  ...Patient Sign-Up/Activation request terminated." Q
 .;Get consult number
 .S DGDEF=$G(DGHTH("CONSULT")),DGCON=$$GCONSULT(DGDFN,DGDEF) I 'DGCON Q
 .S DGHTH("CONSULT")=DGCON
 .;Get Care Coordinator
 .S DGDEF=$G(DGHTH("COORD")),DGPRV=$$GETPROV(DGDEF) I 'DGPRV Q
 .S DGHTH("COORD")=DGPRV
 .;Get okay for transmission
 .S GETOK=$$SNDMSG(DGHTH("DGTYPE"))
 .I 'GETOK W "  ...Patient record not transmitted." Q
 .;file patient data in #391.31
 .S DGEVNDT=$$NOW^XLFDT(),DGHTH("EVENTDT")=DGEVNDT
 .D FILE
 .;build message
 .W !!,"Generating HL7 message ..."
 .K @ARR
 .S RESULT=$$BLDHL7^DGHTHL7(.DGHTH,ARR)
 .I +RESULT<0 D  Q
 ..W !,"** UNABLE TO BUILD MESSAGE **",!,$P(RESULT,"^",2) K @ARR
 .I RESULT=0 D  Q
 ..W !,"** EMPTY MESSAGE BUILT **" K @ARR
 .;send message
 .W !,"Sending message ..."
 .S RESULT=$$SNDHL7^DGHTHL7(ARR,DGVEN,"DG HOME TELEHEALTH ADT-A04 SERVER")
 .I $P(RESULT,"^",2)'="" D  Q
 ..W !,"** UNABLE TO SEND MESSAGE **"
 ..W !,"Error Code: ",$P(RESULT,"^",2),"  Message: ",$P(RESULT,"^",3)
 ..K @ARR
 .;Update File #391.31 with message ID
 .S DGMID=$P(RESULT,"^")
 .D MIDUPD
 .W !,"Sent using message ID ",$P(RESULT,"^")
 .K @ARR
 Q
 ;
SGNUPCHK(DGARY)        ;Check if patient already signed up & whether to 
 ;continue signup for transmission
 ;Input : Array with patient data with at least patient & vendor IEN
 ;Output: 0 = Patient was signed up, terminate processing 
 ;        1 = Continue processing
 ;
 N X,Y,DA,DA1,DAIEN,DGDAT,DTOUT,DUOUT,DIR
 S X="" F  S X=$O(DGARY(X)) Q:X=""  D
 .I DGARY(X)="" K DGARY(X) Q
 .S @X=DGARY(X)
 I '$G(DFN)!('$G(VENDOR))!($G(DGTYPE)="") Q 1
 S DAIEN=$$LOCREC^DGHTINAC(DFN,VENDOR,DGTYPE)
 I 'DAIEN Q 1
 W @IOF,!,"PATIENT ALREADY SIGNED-UP/ACTIVATED WITH VENDOR",!!
 D DSPREC(DAIEN)
 S DIR(0)="Y",DIR("A")="Continue Patient Sign-Up/Activation",DIR("B")="No"
 S DIR("?")="Enter NO to terminate sign-up/activation or YES to continue sign-up/activation."
 D ^DIR I Y D
 .S DGDAT=^DGHT(391.31,$P(DAIEN,"^"),0),DGARY("DA")=DAIEN
 .S DGARY("CONSULT")=$P(DGDAT,"^",4),DGARY("COORD")=$P(DGDAT,"^",5)
 W !
 Q $S(+Y<0:0,1:+Y)
 ;
DSPREC(DGIEN) ;Display Home Telehealth record
 ;Input : IEN and sub IEN for Home Telehealth files #391.31 & #391.317
 ;Output: Displays record if found
 ;
 N DA,DA1,DGDAT,DGDAT1
 I $G(DGIEN)="" Q
 S DA=$P(DGIEN,"^"),DA1=$P(DGIEN,"^",2)
 I '+DA Q
 S DGDAT=^DGHT(391.31,DA,0)
 S DGDAT1=$S(DA1:^DGHT(391.31,DA,"TRAN",DA1,0),1:"")
 W !?3,"Patient:          ",$$GET1^DIQ(2,$P(DGDAT,"^",2),.01,"E")
 W !?3,"Vendor:           ",$$GET1^DIQ(4,$P(DGDAT,"^",3),.01,"E")
 W !?3,"Care Coordinator: ",$$GET1^DIQ(200,$P(DGDAT,"^",5),.01,"E")
 W ?45,"Consult Number:    ",$P(DGDAT,"^",4)
 W !?3,"Activation Date:  ",$$FMTE^XLFDT($P(DGDAT,"^",6),2)
 W:$P(DGDAT,"^",7)'="" ?45,"Inactivation Date: ",$$FMTE^XLFDT($P(DGDAT,"^",7),2)
 I DGDAT1'="" D
 .W !?3,"Transaction Date: ",$$FMTE^XLFDT($P(DGDAT1,"^"),2)
 .W ?45,"Transaction Type:  "
 .W $S('$P(DGDAT1,"^",5):"Retransmit",$P(DGDAT1,"^",5)=1:"Add",1:"Edit")
 .W !?3,"Message Type:     ",$S($P(DGDAT1,"^",4)="A":"Activation",$P(DGDAT1,"^",4)="I":"Inactivation",1:"Unknown")
 .W ?45,"Message ID:        ",$P(DGDAT1,"^",2)
 .W !?3,"Data Entry User:  ",$$GET1^DIQ(200,$P(DGDAT1,"^",3),.01,"E")
 .W !?3,"Acknowledge Date: ",$$FMTE^XLFDT($P(DGDAT1,"^",6),2)
 .W ?45,"Acknowledge Code:  "
 .W $S($P(DGDAT1,"^",7)="A":"Accepted",$P(DGDAT1,"^",7)="R":"Rejected",1:"")
 .I $P(DGDAT1,"^",8)'="" W !?3,"Reject Message:   ",$P(DGDAT1,"^",8)
 .W !
 Q
 ;
GETPAT()        ;Prompt user for patient
 ;Input : None
 ;Output: Pointer to PATIENT File, #2 (i.e. DFN)
 ;        0 on user quit
 N DIC,X,Y,DTOUT,DUOUT,IENVAL
 S DIC="^DPT(",DIC("A")="Patient: ",DIC(0)="AEQM"
 D ^DIC I +Y<0 Q 0
 S IENVAL=$$PATOK(+Y) I 'IENVAL Q 0
 Q +Y
 ;
PATOK(DFN)      ;Patient screen
 ;Input : DFN - Pointer to PATIENT
 ;Output: 1 = Patient selectable
 ;        0 = Patient not selectable
 N NODE
 ;Dead
 I $G(^DPT(DFN,.35)) W !,"*** Patient has expired. ***" Q 0
 ;No national ICN
 S NODE=$G(^DPT(DFN,"MPI"))
 I $P(NODE,"^",1)="" W !,"*** Patient has no ICN. ***" Q 0
 ;Local ICN
 I $P(NODE,"^",4) W !,"*** Patient has local ICN. ***" Q 0
 ;Selectable patient
 Q 1
 ;
GETVEN() ;Prompt user for receiving vendor
 ;Input : None
 ;Output: N = Pointer to INSTITUTION File, #4
 ;        0 = User quit
 ;
 N DIR,X,Y,DTOUT,DUOUT,DIRUT
 S DIR(0)="391.31,2",DIR("A")="Vendor"
 S DIR("?")="Enter the Home Telehealth vendor patient is signed up with."
 D ^DIR
 Q $S(+Y<0:0,1:+Y)
 ;
GCONSULT(DFN,DEFAULT) ;Prompt Consult number from file #123
 ;Input : DFN      Patient pointer for file #2
 ;        DEFAULT  Default value for consult number (if existing)
 ;Output: N        Pointer to REQUEST/CONSULTATION file, #123
 ;        0        User quit
 ;
 N DIR,X,Y,DTOUT,DUOUT,DIRUT,CON,CONZER,DGTMP
 ;find ien for 'CARE COORDINATION HOME TELEHEALTH SCREENING'
 S CON="CARE COORDINATION HOME TELEHEALTH SCREENING"
 K ^TMP("GMRCR",$J)
 D GUI^GMRCASV1("DGTMP",CON,1,0) ;DBIA#3252
 S CON=$O(DGTMP(0))
 I 'CON W !,"Service Area not available" Q 0
 S CON=+DGTMP(CON) ;DBIA#2740
 D OER^GMRCSLM1(DFN,CON,"")
 S CONZER=$G(^TMP("GMRCR",$J,"CS",0)),DIR("?")="^D CONHELP^DGHTENR"
 I '+$P(CONZER,"^",4) D  Q 0
 .W !!,"No Home Telehealth consult available for this patient!!"
 S DIR(0)="P^TMP(""GMRCR"",$J,""CS"",:AEQMZ",DIR("A")="Consult Number"
 I $G(DEFAULT)'="" S DIR("B")=DEFAULT
 D ^DIR
 K ^TMP("GMRCR",$J)
 Q $S(+Y<0:0,1:$P(Y,"^",2))
 ;
CONHELP ;Help for consult #
 N DIC,XX,D
 I $D(^TMP("GMRCR",$J,"CS")) D  Q
 .W !?1,"Answer with the number representing consult.",!?1,"Choose from:"
 .S XX=0 F  S XX=$O(^TMP("GMRCR",$J,"CS",XX)) Q:'XX  D
 ..W !?1,XX,")",?5,$P(^TMP("GMRCR",$J,"CS",XX,0),"^"),?15
 ..W $$FMTE^XLFDT($P(^TMP("GMRCR",$J,"CS",XX,0),"^",2),"2HM"),?30
 ..W $E($P(^TMP("GMRCR",$J,"CS",XX,0),"^",7),1,38),?70,$P(^TMP("GMRCR",$J,"CS",XX,0),"^",3)
 S DIC="^TMP(""GMRCR"",$J,""CS"")",DIC(0)="MQEZ" D DQ^DICQ
 Q
 ;
GETPROV(DEFAULT) ;Prompt for Care Coordinator
 ;Input : DEFAULT = Default value for provider (if existing)
 ;Output: N =       Pointer to NEW PERSON file, #200
 ;        0 =       User quit
 ;
 N DIR,X,Y,DTOUT,DUOUT,DIRUT
 S DIR(0)="P^VA(200,:AEQM",DIR("A")="Care Coordinator"
 S DIR("?")="Enter the Care Coordinator responsible for signing up this patient."
 I $G(DEFAULT)'="" S DIR("B")=$$GET1^DIQ(200,DEFAULT,.01,"E")
 D ^DIR
 Q $S(+Y<0:0,1:+Y)
 ;
SNDMSG(TYPE)        ;Prompt to transmit transaction to vendor server
 ;Input : None
 ;Output: 1 = Send message
 ;        0 = User quit
 ;
 N DIR,X,Y,DTOUT,DUOUT,DIRUT
 S DIR(0)="Y",DIR("B")="Yes"
 S DIR("A")=$S(TYPE="A":"Send Sign-Up/Activation",TYPE="I":"Send Inactivation",1:"")
 S DIR("?")="Enter 'Yes' to transmit patient information to vendor. 'No' not to transmit."
 D ^DIR
 Q $S(+Y<0:0,1:+Y)
 ;
FILE ;File patient data in #391.31
 N DIC,DIE,DA,DR,X,Y,DGRN,DGTREVN,DINUM
 S DGTREVN=0
 I $G(DGHTH("DA"))'="" D  Q
 .D FILE1
HTADD L +^DGHT(391.31,0)
 S DGRN=$P(^DGHT(391.31,0),"^",3)+1 I $D(^DGHT(391.31,DGRN)) D  G HTADD
 .S $P(^DGHT(391.31,0),"^",3)=$P(^(0),"^",3)+1 L -^DGHT(391.31,0)
 L -^DGHT(391.31,0)
 S DIC(0)="L",DIC="^DGHT(391.31,",X=DGRN,DINUM=X D FILE^DICN
 S DGHTH("DA")=+Y,DGTREVN=1
 ;
FILE1 ;Add/Update fields in #391.31
 S DIE="^DGHT(391.31,",DA=+DGHTH("DA")
 S DR="1////"_DGDFN_";2////"_DGVEN_";3////"_DGCON_";4////"_DGPRV
 S:DGTREVN DR=DR_";5////"_DGEVNDT
 D ^DIE
 ;file entry in subfile #391.317
 K DIC,DD,DO,DA
 S DIC(0)="L",DIC("P")=$P(^DD(391.31,7,0),"^",2),DA(1)=+DGHTH("DA")
 I $P(DGHTH("DA"),"^",2)="" D
 .S DGRN=$S('$D(^DGHTH(391.31,DA(1),"TRAN")):0,1:$P(^DGHTH(391.31,DA(1),"TRAN",0),"^",3))+1,$P(DGHTH("DA"),"^",2)=DGRN,X=DGEVNDT
 .S DIC="^DGHT(391.31,"_DA(1)_","_"""TRAN"""_","
 .D FILE^DICN
 K DR
 S DA=$P(DGHTH("DA"),"^",2),DIE="^DGHT(391.31,"_DA(1)_","_"""TRAN"""_","
 S (DR,DR(2,391.317))=".01////"_DGEVNDT_";.02////@"_";.03////"_DUZ_";.04////"_DGTYPE_";.05////"_DGTREVN  ;";.07////@" retain AA and trans. date/time when 1st transmitted successfully.
 D ^DIE
 Q
 ;
MIDUPD ;Update File #391.31 with message ID
 N DIE,DR,DA,X,Y
 S DA=$P(DGHTH("DA"),"^",2),DA(1)=+DGHTH("DA")
 S (DR,DR(2,391.317))=".02////"_DGMID
 S DIE="^DGHT(391.31,"_DA(1)_","_"""TRAN"""_","
 D ^DIE
 Q
