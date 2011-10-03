PRCHAMU ;WISC/AKS-Modules helpful in amendments ;8/18/97  9:12
 ;;5.1;IFCAP;**21,117**;Oct 20, 2000;Build 2
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 W !,"Call at the appropriate entry point",$C(7)
 Q
 ;
GETPO ;get a valid PO
 ;the variable RETURN is either the PO/REQ# or null if no PO is selected
 N DIC,D,Y,X,TRANS,PRCHSTAT
 S DIC="^PRC(442,",DIC(0)="QEAMZ",D="C"
 S DIC("A")=$S($D(PRCHREQ):"REQUISITION NO.: ",1:"PURCHASE ORDER: ")
 S DIC("S")="I +$P(^(0),U)=PRC(""SITE"")"_$S($D(PRCHREQ):",$P(^(0),U,2)=8!($P(^(0),U,2)=25)",1:",$P(^(0),U,2)<8!($P(^(0),U,2)=25)!($P(^(0),U,2)=26)")
 I $G(PRCHAUTH)=1 S DIC("S")="I +$P(^(0),U)=PRC(""SITE""),($P($G(^(23)),U,11)=""P""!($P($G(^(23)),U,11)=""S""))"
 I $G(PRCHAUTH)=2 S DIC("S")="I +$P(^(0),U)=PRC(""SITE""),$P($G(^(23)),U,11)=""D"""
 D ^DIC K DIC I Y<0 S OUT=1 Q
 ;A time-out/up-arrow check before locking the record.
 I $D(DTOUT)!$D(DUOUT) Q
 ; Locking the 442 entry i.e. selected by the user to amend. 
 ; This lock is released ONLY at one exit point in EXIT^PRCHMA routine.
 ;
 S PRCENTRY=+Y,OUT=0
 L +^PRC(442,PRCENTRY):1 E  W !!,?5," Someone else is already editing this amendment record." S PRCFL=1 Q
 S X=$S($D(^PRC(442,+Y,7)):$P($G(^PRCD(442.3,+^(7),0)),U,2),1:"")
 I X="" W !,$C(7),"Invalid Supply Status" Q
 I X<20 W !,$C(7),"    This order is not properly signed yet!!" Q
 I X=45 W !,$C(7),"This is a cancelled " W:$D(PRCHREQ) "requisition." W:'$D(PRCHREQ) "purchase order." Q
 I $G(PRCHAUTH)=1 S PCARD=$P($G(^PRC(442,+Y,23)),U,8) D  I $G(PRCHFG) K PCARD,PRCHFG Q
 . I '$D(^PRC(440.5,"C",DUZ,PCARD)) W !,?5,"You are not authorized to amend this purchase card order." S PRCHFG=1
 K PCARD,PRCHFG
 I $G(PRCHAUTH)=2 S PRCHAUCP=$P(^PRC(442,+Y,0),U,3) D  I $G(PRCHAUFG) K PRCHAUCP,PRCHAUFG Q
 . I '$D(^PRC(420,PRC("SITE"),1,+PRCHAUCP,1,DUZ)) D  S PRCHAUFG=1
 . . W !!,"You are not an authorized user for "_$P(PRCHAUCP," ",1,2)_" control point.",!
 K PRCHAUCP,PRCHAUFG
 I '$D(TRANSCMP) I X=40!(X=41) D  Q:$G(TRANS)=1
 .Q:($P(^PRC(442,+Y,0),"^",2)=2)!($P(^PRC(442,+Y,0),"^",2)=4)
 .W $C(7),!!,?5,"Purchase orders (Excluding CERTIFIED INVOICE and GUARANTEED DELIVERY)",!,?5,"with a status of 'Transaction Complete' cannot be amended."
 .S TRANS=1
 I X=50!(X=51) D  Q
 . W $C(7),!!,?5,"Reconciled Purchase Card orders cannot be amended."
 I X=28!(X=33) W $C(7),!,"Amendment not allowed until after order has been obligated!!" Q
 I $D(^PRC(443.6,+Y,0)) S PRCHAM=$O(^PRC(443.6,+Y,6,0)) I PRCHAM="" D  Q
 .W !!?5,"This record is not set-up properly, it is being cleaned-up."
 .W !?5,"Please RE-START the amendment process.",!
 .D DEL
 I $D(^PRC(443.6,+Y,0)) S PRCHAM=$O(^PRC(443.6,+Y,6,0)) Q:PRCHAM'>0  D  Q:$D(FIS)
 .I $P($G(^PRC(443.6,+Y,6,PRCHAM,1)),U,2)]"" D
 ..W !!,?5,"Pending Amendment: ",PRCHAM,"       Status: Pending Fiscal Action" S FIS=1
 D FMS
 I $G(STATUS)]"" I $E(STATUS,1)="R"!($E(STATUS,1)="E") D  K STATUS Q
 .W !!,?5,"One of the previous documents has been rejected by",!,?5,"FMS or has errored in transmission.",!,?5,"This purchase order cannot be amended at this time."
 I $D(^PRC(443.6,+Y,0)) I $D(^PRC(443.6,+Y,11)) W !!,"There is a pending Adjustment Voucher against this purchase order" Q
 I $D(^PRC(443.6,+Y,0)) W $C(7),!!,?5,"*** There is already an amendment pending for this purchase order. ***" S PRCHNEW=111 D  Q:%'=1!$D(DEL)
 .S %=1,%B="",%A="         Would you like to Edit it" D ^PRCFYN W !
 .I %=2 S %B="",%A="         Would you like to delete it" D ^PRCFYN W ! D
 ..D:%=1 DEL
 S PRCHPO=+Y
 Q
AMENDNO ;gets next valid amendment number to create
 ;
 N I,%,%A,%B,PRCHEX,PRCHEX1
 S PRCHAM=1
 I $D(^PRC(442,PRCHPO,6)) D
 .S I=0 F  S I=$O(^PRC(442,PRCHPO,6,I)) Q:'I  S PRCHAM=I+1
 W !!?5,"Amendment Number: ",PRCHAM
 I $D(^PRC(443.6,PRCHPO,0)) W ! Q
 W !!,"...copying Purchase Order into work file...",! D WAIT^DICD W !
 F I=0,1,7,12,23 S ^PRC(443.6,PRCHPO,I)=$G(^PRC(442,PRCHPO,I))
 S $P(^PRC(443.6,0),"^",3)=PRCHPO,$P(^(0),"^",4)=$P(^(0),"^",4)+1
 S PRCHEX=$P(^PRC(443.6,PRCHPO,0),"^"),PRCHEX1=$P(PRCHEX,"-",2)
 S (^PRC(443.6,"B",PRCHEX,PRCHPO),^PRC(443.6,"E",PRCHEX1,PRCHPO))=""
 Q
 ;
INFO ; Ask for common information for amendments
 N DIE,DA,DR,FLGUP
 S ER=0,FLGUP=0,DIE="^PRC(443.6,",DA=PRCHPO,DR="[PRCHAMEND]"
 S:$D(PRCHAV) DR="[PRCHAMENDAV]"
 S:$G(PRCPROST)=90 DR="[PRCHAMENDPRO]"
 S:$G(PRCPROST)=6 DR="[PRCHAMENDPRO EDIT]"
 D ^DIE
 I $D(Y)!'FLGUP S ER=1 Q
 S DIE="^PRC(443.6,"_PRCHPO_",6,",DA=PRCHAM,DR="15///TODAY+4" D ^DIE
 I '$D(^PRC(443.6,PRCHPO,6,PRCHAM,1)) D  S ER=1 Q
 .W !,?5,"Can't continue without a Purchasing Agent !"
 ;S PRCHLC=$P(PRCH(0),U,14)
 Q
ASK ;Ask type amendment
 N PRCHREPO S PRCHREPO=$O(^PRC(443.6,PRCHPO,6,PRCHAM,3,"AC",32,0)) I PRCHREPO>0 S REPONUM=1 Q
 S ER=0 W !
 I '$G(PRCHAUTH) D
 . S DIC=$S($D(PRCHREQ):"^PRCD(441.6,",1:"^PRCD(442.2,")
 . S DIC("S")="I Y>19,($P(^(0),U,3)]"""")"
 . S DIC(0)="MQEAZ" D ^DIC K DIC
 I $G(PRCHAUTH) D
 . D:'$D(PRCHREQ) DIRPO^PRCHPCAR D:$D(PRCHREQ) DIRREQ^PRCHPCAR
 I Y<0 S ER=1 K PRCHVFLG Q
 I $D(PRCHREQ) D  G:ER ASK
 .I '$D(^PRCD(441.6,+Y,1)) D  S ER=1
 ..W !!?5,"Amendment Lines in 'Type of Requisition Amendment' file are not defined "
 I '$D(PRCHREQ) D  G:ER ASK
 .I '$D(^PRCD(442.2,+Y,1)) D  S ER=1
 ..W !!?5,"Amendment Lines in 'Type of Amendment' file are not defined "
 I $P($G(Y(0)),U,3)="" D
 . S Y(0)=$S($D(PRCHREQ):^PRCD(441.6,Y,0),1:^PRCD(442.2,Y,0))
 S PRCHAMDA=+Y,ROU=$P(Y(0),U,3),ROU=$TR(ROU,"~","^")
 S PRCHL1=$P(^PRCD(442.2,+Y,1),U),PRCHL2=$P(^(1),U,2)
 Q
UPDATE ;Update Delivery date, Original Delivery Date, Amendment status and
 ;Justification.
 I $G(DELIVER) D
 .S PRCHDT=$P(^PRC(443.6,PRCHPO,0),U,10)
 .I $P($G(^PRC(442,PRCHPO,23)),"^",11)'="S" S DIE="^PRC(443.6,",DA=PRCHPO,DR=7 D ^DIE K DIE
 .I PRCHDT,$P(^PRC(443.6,PRCHPO,0),U,20)="",$P(^(0),U,10)'=PRCHDT S $P(^(0),U,20)=PRCHDT
 .K PRCHDT
 S POSTAT=+$G(^PRC(443.6,PRCHPO,7))
 S AMSTAT=$S(POSTAT=25:26,POSTAT=30:31,POSTAT=40:71,POSTAT=6:83,POSTAT=84:85,POSTAT=86:87,POSTAT=90:91,POSTAT=92:93,POSTAT=94:95,POSTAT=96:97,POSTAT=45:45,1:POSTAT)
 I $G(PRCHAUTH)=1,(AMSTAT=40!(AMSTAT=71)) S AMSTAT=83
 S AMSTAT=$P(^PRCD(442.3,AMSTAT,0),U)
 S DIE="^PRC(443.6,PRCHPO,6,",DA(1)=PRCHPO,DA=PRCHAM,DR="9//^S X=AMSTAT;16"
 N AAREPO S AAREPO=$O(^PRC(443.6,PRCHPO,6,PRCHAM,3,"AC",32,0))
 I $G(CAN)=1!(AAREPO>0) S DR=16
 I $G(PRCPROST)=90 S DR="16////Prosthetic order cancelled"
 I $G(PRCPROST)=6 S DR="16////Prosthetic Cost Changes"
 D ^DIE K DIE,AMSTAT,POSTAT
 QUIT
FMS ;Checking FMS documents status
 ;
 N N,CODE
 S N=0,STATUS="" F  S N=$O(^PRC(442,+Y,10,N)) Q:N'>0  D  Q:$E(STATUS,1)="R"!($E(STATUS,1)="E")
 .I $E(^PRC(442,+Y,10,N,0),1,2)="MO"!($E(^(0),1,2)="SO") D
 ..S CODE=$P($G(^PRC(442,+Y,10,N,0)),U,4)
 ..S STATUS=$$STATUS^GECSSGET(CODE)
 Q
DEL ;Delete this amendment
 N PO,EXPO,EXPO1,N,ZERO,REC,PAT,ITEM
 S PO=+Y
 S EXPO=$P(^PRC(443.6,PO,0),U),EXPO1=$P(EXPO,"-",2)
 S N=0 F  S N=$O(^PRC(441.7,"B",EXPO,N)) Q:N'>0  D
 .S REC=^PRC(441.7,N,0)
 .S PAT=$P(REC,U)
 .S ITEM=$P(REC,U,2)
 .I ITEM>0 K ^PRC(441.7,"AG",PAT,ITEM,N)
 .K ^PRC(441.7,"B",PAT,N)
 .K ^PRC(441.7,N,0)
 .S ZERO=^PRC(441.7,0)
 .S $P(ZERO,U,4)=$P(ZERO,U,4)-1
 .S:$P(ZERO,U,4)<1 $P(ZERO,U,4)=""
 .S ^PRC(441.7,0)=ZERO
 K ^PRC(443.6,"B",EXPO),^PRC(443.6,"C",PO),^PRC(443.6,"D",PO)
 K ^PRC(443.6,"E",EXPO1),^PRC(443.6,PO)
 S ZERO=^PRC(443.6,0)
 S $P(ZERO,U,4)=$P(ZERO,U,4)-1
 S:$P(ZERO,U,4)<1 $P(ZERO,U,4)=""
 S ^PRC(443.6,0)=ZERO
 S DEL=1
 QUIT
 ;
MSG ;This subroutine is called by PRCHMA
 ;Display message for 'Vendor Change'
 N AA
 S AA="NOTE: The vendor has been changed."
 S AA=AA_"  Please review LINE ITEM & FPDS information"
 S AA=AA_"        for any necessary changes."
 D EN^DDIOL(AA) W !
 QUIT
 ;
MSG1 ;This subroutine is called by PRCHMA
 ;Source code was changed to 2
 N AA
 S AA="NOTE: THE CONTRACT WILL BE REMOVED FROM ALL ITEMS"
 D EN^DDIOL(AA) W !
 QUIT
 ;
SOURCE ;This subroutine is called by PRCHMA
 ;Source code was changed to 2
 ;Remove contract number from $P2 and AC x-reference.
 KILL SCE
 N CONTRACT,ITEM S ITEM=0
 F  S ITEM=$O(^PRC(443.6,PRCHPO,2,ITEM)) Q:'ITEM  D
 .  S CONTRACT=$G(^PRC(443.6,PRCHPO,2,ITEM,2))
 .  S CONTRACT=$P(CONTRACT,U,2)
 .  Q:CONTRACT=""
 .  S $P(^PRC(443.6,PRCHPO,2,ITEM,2),U,2)=""
 .  KILL ^PRC(443.6,PRCHPO,2,"AC",CONTRACT,ITEM)
 ;
 QUIT
