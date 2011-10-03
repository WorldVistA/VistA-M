RMPOBIL4 ;NG/DUG-HOME OXYGEN BILLING TRANSACTIONS ;7/22/98  11:08
 ;;3.0;PROSTHETICS;**29**;Feb 09, 1996
ACCEPT ;the vaiable RMPOTYPE is available. If '1',1358. If '2',purchase card.
 ;variable RMPOA is an Entry Action set in [RMPO ACCEPT BILL] to allow
 ;  seperate option to accept transactions
 ;variable RMPOACN set in RMPOBIL1 means there is at least one patient
 ;  transaction that has not been accepted.
 S DIR(0)="S^1:ACCEPT;2:UNACCEPT",DIR("?")="Enter '1' to accept transactions, '2' to unaccept.",DIR("A")="ACCEPT or UNACCEPT Billing Transaction(s)" D ^DIR K DIR Q:$D(DIRUT)  S:Y(0)="UNACCEPT" RMPOUA=1 D PROS K RMPOUA Q
 I '$D(RMPOACPN) W !!,"All transactions have been accepted.",!,"Press <RETURN> to continue." R RET:DTIME Q
 I $D(RMPOA) R !!,"Accept ? Y// ",ANS1:DTIME Q:'$T!("yY"'[ANS1)  D PROS Q
 W !!,"Are you sure you want to ACCEPT these transactions (",ANS,") ? No // "
 R ANS1:DTIME Q:'$T!("^Nn"[ANS1)
 I "Yy"'[ANS1 W !,"Type 'Y' to accept the billing transactions for ",!,"the patients you selected. Press return to leave." G ACCEPT
PROS ;
 F M=1:1:CNT I $D(ANS(M)),$D(CNT(M)),$D(^RMPO(665.72,RMPOREC,1,RMPOREC1)) D
   .  S RMPOREC2=$O(^RMPO(665.72,RMPOREC,1,RMPOREC1,1,"B",CNT(M),0))
   .  I $G(RMPOREC2)]"",$D(^RMPO(665.72,RMPOREC,1,RMPOREC1,1,RMPOREC2,0)) S:'$D(RMPOUA) $P(^(0),U,2)=1 S:$D(RMPOUA) $P(^(0),U,2)=""
   .  S RMPOX=""
   .  F  S RMPOX=$O(^TMP($J,RMPOX)) Q:RMPOX=""  D
   .  .  I $P(RMPOX,U,2)=RMPOPATN D
   .  .  .  S:'$D(RMPOUA) $P(^TMP($J,RMPOX),U)="a"
   .  .  .  S:$D(RMPOUA) $P(^TMP($J,RMPOX),U)="" W "."
   .  .  .  Q
   .  .  ;
   .  .  ;$D(RMPOUA)="ACCEPTED
   .  .  ;Otherwise it is UNACCEPTED
   .  .  ;H 2
   .  .  ;
   .  .  ;RMPOA is set if running ACCEPT option
   .  .  ;Q:$D(RMPOA)!($D(RMPOVA)) ; quit unnecessary, quits anyway.
   .  .  Q
   .  ;D ^RMPOBIL1 K RMPOX
   .  Q
 Q
POST ;locates item records for the "Post" option using CNT1(CNT1) array
 K RMPOCAP S RMPOPATN=$TR(RMPOPATN,"`","") Q:$G(RMPOPATN)<1
 S RMPOREC1=$O(^RMPO(665.72,RMPOREC,1,"B",RMPODATE,0)),RMPOREC2=$O(^RMPO(665.72,RMPOREC,1,RMPOREC1,1,"B",RMPOPATN,0)) I RMPOREC2="" W !,"No items listed for this patient. Record is incomplete." H 3 Q
 Q:$P(^RMPO(665.72,RMPOREC,1,RMPOREC1,1,RMPOREC2,0),U,3)'=""
 S RMPOVEN=0,RMPOVEN=$O(^RMPO(665.72,RMPOREC,1,RMPOREC1,1,RMPOREC2,"V",RMPOVEN)) Q:RMPOVEN=""
 Q:$P($G(^RMPO(665.72,RMPOREC,1,RMPOREC1,1,RMPOREC2,"V",RMPOVEN,"I",0)),U,3)=""  S CNT1=1,RMPOREC3=0 F  S RMPOREC3=$O(^RMPO(665.72,RMPOREC,1,RMPOREC1,1,RMPOREC2,"V",RMPOVEN,"I",RMPOREC3)) Q:RMPOREC3<1  D
 .S RMPOITEM=$G(^RMPO(665.72,RMPOREC,1,RMPOREC1,1,RMPOREC2,"V",RMPOVEN,"I",RMPOREC3,0))_RMPOREC3,CNT1(CNT1)=RMPOITEM_U_$P(RMPOITEM,U)_U_RMPOPATN
 .S RMPOIT=$P(RMPOITEM,U),RMPOIT=$P(^RMPR(661,RMPOIT,0),U),RMPOIT=$P(^PRC(441,RMPOIT,0),U,2),$P(CNT1(CNT1),U)=RMPOIT,CNT1=CNT1+1
 ;D FCP^RMPOBIL6,POST2 Q
POST1  Q:"^"[$G(ANS1)
 W !!,"Warning, transactions cannot be editted once they are posted."
 R "Post ? No// ",ANS1:DTIME Q:'$T!("Nn"[ANS1)
 ;I "Yy"[ANS1 D FCP^RMPOBIL6
 Q  ;ADDED TO SKIP FOLOWING MESSAGE - UNSUCCESSFUL POSTING 
POST2 ;requires variable RMPOCAP which verifies successful posting 
 ;from ^RMPOBIL.
 Q  ;ADDED TO SKIP FOLLOWING MESSAGE
 I '$D(RMPOCAP) W !!,"UNSUCCESSFUL POSTING!" H 3 K RMPOPO Q
 S RMPOX="" F  S RMPOX=$O(^TMP($J,RMPOX)) Q:RMPOX=""  I $P(RMPOX,U,2)=RMPOPATN K ^TMP($J,RMPOX) D
 .S RMPOREC2=$O(^RMPO(665.72,RMPOREC,1,RMPOREC1,1,"B",RMPOPATN,0)),$P(^RMPO(665.72,RMPOREC,1,RMPOREC1,1,RMPOREC2,0),U,3)=1
 W !!,"." H 3
 K RMPOPO Q
EXPIRE ;this subroutine is used to calculate the Rx expiration date for
 ;file 665. It calculates the order of the prescription that it has been
 ;asked to calculate the expiration date for and uses the appropriate 
 ;"Default Days to Exparation" from the Prescription Sequence Number 
 ;multiple.
 ;
 ;X is Return Value (for call from input template)
 ;
 ;If there is a value on file, use it.
 N RMPODATA,RMPODAXD
 S RMPODATA=$G(^RMPR(665,DA(1),"RMPOB",DA,0))
 S X=$P(RMPODATA,"^",3) Q:X
 ;
 ;Calculate Sequence Number for Prescription - Default=1
 S RMPODAXD=0,X=0
 F  S X=$O(^RMPR(665,DA(1),"RMPOB","B",X)) S RMPODAXD=RMPODAXD+1 Q:$S(X-RMPODATA=0:1,'X:1,1:0)
 ;
 ;Calculate value based on Prescription Data + Site Parameter
 ;
 N RMPOSITE,X1,X2,Y
 S RMPOSITE=$P($G(^RMPR(665,DA(1),"RMPOA")),U,7)
 Q:RMPOSITE=""  D
  .  S X2=$P($G(^RMPR(669.9,RMPOSITE,"RMPORXN",RMPODAXD,0)),U,2)
  .  Q:'X2  S X=""
  .  S X1=$P(RMPODATA,U) D C^%DTC
  .  Q
 Q
EXPAT(X,Y) ;Entry for RMPOPED
 N DA S DA=Y,DA(1)=X D EXPIRE
 Q X
