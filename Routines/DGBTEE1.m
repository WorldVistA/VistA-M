DGBTEE1 ;ALB/SCK - BENEFICIARY TRAVEL ENTER/EDIT CHECK; 12/7/92 3/19/93
 ;;1.0;Beneficiary Travel;**14**;September 25, 2001;Build 7
 Q
SCREEN ;  called by dgbtee,dgbtce
 Q:'$D(^DGBT(392,DGBTDT,0))
 K DGBTVAR F I=0,"A","D","M","R","T" S DGBTVAR(I)=$S($D(^DGBT(392,DGBTDT,I)):^(I),1:"") ; ref file #392, claims
 W @IOF S DGBTFLAG=0
 I '$D(^DG(43,1,"BT"))!('$D(^DG(43.1,$O(^DG(43.1,(9999999.99999-DGBTDT))),"BT"))) W !!,"Module has not been properly initialized - to continue you should first complete",!,"the parameters" Q
 W !?16,"Beneficiary Travel Claim Information <Enter/Edit>"
 D PID^VADPT6
 W !!?8,"Name: ",VADM(1),?40,"PT ID: ",VA("PID"),?64,"DOB: ",$P(VADM(3),"^",2),!
START ; ask date/time, and division
 K DIC,^TMP("DGBT",$J),X
 S DIE="^DGBT(392,",DIE("NO^")="OUTOK"
 S DR=".01;S (DGBTDT,VADAT(""W""))=X D ^VADATE S DGBTDTI=VADATE(""I""),DGBTDTE=VADATE(""E"") K VADAT,VADATE I '$D(DGBTMD) S Y=""@1"";11;@1"
 S DIDEL=392 ; allows users to delete BT claims
 D ^DIE K DIE,DIDEL,DQ,DR I $D(DTOUT)!($D(Y)) S DGBTTOUT=-1 Q
 K X
 I '$D(^DGBT(392,DGBTDT,0)) Q
 I $D(^DGBT(392,DGBTDT,0)) L ^DGBT(392,DGBTDT):2 I '$T W !?5,"Another user is editing this entry.",*7 S DGBTTOUT=1 G QUIT
 ; set rates and build eligibilities in DGBTEE2
 D RATES^DGBTEE2
ELIG1 ;  select eligibility from those available in TMP list
 I '$O(VAEL(1,0)) S DGBTELIG=+VAEL(1) G ESET1
 S DIR("A")="Select ELIGIBILITY",DIR("B")=$S($P(^DGBT(392,DGBTDT,0),"^",3):$P(^DIC(8,$P(^DGBT(392,DGBTDT,0),"^",3),0),"^"),VAEL(1):$P(VAEL(1),"^",2),1:"")
 S DIR(0)="F",DIR("?")="^D ELIST^DGBTEE2"
 D ^DIR K DIR I $D(DUOUT) W !?3,"SORRY, '^' NOT ALLOWED!!" G ELIG1
 I $D(DTOUT) S DGBTTOUT=-1 Q
 S:Y="" DGBTELIG=$S($P(^DGBT(392,DGBTDT,0),"^",3):$P(^(0),"^",3),1:+VAEL(1)) ; ref file #392, claims
 I X["@" W !,"ELIGIBILITY REQUIRED." G ELIG1
 I Y?1A.E F I=0:0 S I=$O(^TMP("DGBT",$J,I)) Q:'I  I $E($P(^(I),"^",2),1,$L(X))=X S XX=Y,Y=I G ESET ; ref ^TMP file for eligibility
 I +Y?1N.N S Y=+Y F I=0:0 S I=$O(^TMP("DGBT",$J,I)) Q:'I  I +$P(^(I),"^")=Y S XX=Y,Y=I G ESET ; ref ^TMP file for eligibility
ECHOZ ;
 W !!,"Choose by NUMBER the primary eligibility or other entitled eligibilities",!
 I DGBTCT>1 F I=0:0 S I=$O(^TMP("DGBT",$J,I)) Q:'I  W !?5,I,?10,$P(^TMP("DGBT",$J,I),"^",2)
 K DIR,X S DIR("A")="Choose 1-"_DGBTCT,DIR(0)="NO^1:"_DGBTCT,DIR("?")="Enter choice from those displayed"
 D ^DIR K DIR G:$D(DIRUT) ELIG1 S XX=Y
 I '$D(^TMP("DGBT",$J,Y)) W " ?? ",!,"Select ELIGIBILITY: " G ECHOZ
ESET ;
 S:$D(Y) DGBTELIG=$S($D(^TMP("DGBT",$J,Y)):+^TMP("DGBT",$J,Y),'$D(XX):Y,1:+VAEL(1))
 W:Y]"" ?30,$E($P(^DIC(8,+DGBTELIG,0),"^"),$S($D(XX):($L(XX)+1),1:1),99)
ESET1 ;
 S DGBTSCP=$S($P(^DIC(8,DGBTELIG,0),"^",9)=1&(+VAEL(3)):$P(VAEL(3),"^",2),$P(^DIC(8,DGBTELIG,0),"^",9)=3&(+VAEL(3)):$P(VAEL(3),"^",2),1:"")
CERT ;  stuff of certification date if appropriate
 ; naked global ref file #392.2, certification file.
 I $P(VAEL(3),"^") S DGBTCD="" I VAEL(3)&($P(VAEL(3),"^",2)'>29) S DGBTIDT=9999999.99999-DGBTDT F I=0:0 S I=$O(^DGBT(392.2,"C",DFN,I)) Q:'I  I I'>DGBTIDT&($P(^DGBT(392.2,I,0),"^",3)) S DGBTCD=$P(^(0),"^")
ACCT ;  allowed to select only valid active accounts
 S DGBTOACT=$S('$D(^DGBT(392.3,+$P(DGBTVAR(0),"^",6),0)):0,1:+$P(^DGBT(392.3,$P(DGBTVAR(0),"^",6),0),"^",5))
 K X S (DIC("B"),X)=$S(+$P(DGBTVAR(0),"^",6):$P(^DGBT(392.3,$P(DGBTVAR(0),"^",6),0),"^"),1:$$DEFLT1) S DIC("A")="Select ACCOUNT: "
 S DIC="^DGBT(392.3,",DIC(0)="AEQMZ",DIC("S")="I $P(^(0),U,3)'>DGBTDT&('$P(^(0),U,4)!($P(^(0),U,4)'<DGBTDT))"
 D ^DIC K DIC I $D(DTOUT) S DGBTTOUT=-1 K DTOUT Q
 I Y'>0 W !,"ACCOUNT IS REQUIRED!!" G ACCT
 S DGBTACTN=$P(Y,"^"),DGBTACCT=$P(Y(0),"^",5)
 ;  if account is ALL OTHER - stuff in mileage info
 I $D(DGBTVAR("M")) S DGBTML=$P(DGBTVAR("M"),"^",2),DGBTOWRT=$P(DGBTVAR("M"),"^"),DGBTMLT=$J((DGBTML*DGBTOWRT*DGBTMR),0,2)
QUIT ;
 K A,C,I,IA,J,X,XX,^TMP("DGBT",$J),DGBTDIV,DGBTIDT,DGBTCT
 Q
 ;
DEFLT1() ;
 N REC,Y
 S REC="0" F  S REC=$O(^DGBT(392.3,REC)) Q:'REC  D  Q:$D(Y)
 . S:$P(^DGBT(392.3,REC,0),U,5)=4&($P(^(0),U,3)'>DGBTDT&('$P(^(0),U,4)!($P(^(0),U,4)'<DGBTDT))) Y=$P(^(0),U,1)
 Q $G(Y)
