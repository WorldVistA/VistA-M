PSDUP3 ;BHM/DAV,JPW-IRL Program/Data Download Vault Inv. Insp. ; 5 Oct 94
 ;;3.0; CONTROLLED SUBSTANCES ;**3**;13 Feb 97
VAULT ;vault upload
 I '$D(PSDSITE) D ^PSDSET Q:'$D(PSDSITE)
ASKD ;ask disp location
 S PSDS=$P(PSDSITE,U,3),PSDSN=$P(PSDSITE,U,4)
 G:$P(PSDSITE,U,5) LOOP
 W ! K DIC,DA S DIC=58.8,DIC(0)="QEAZ",DIC("S")="I $P(^(0),""^"",3)=+PSDSITE,$S($P(^(0),""^"",2)[""M"":1,$P(^(0),""^"",2)[""S"":1,1:0)",DIC("A")="Select Dispensing Site to Inventory: ",DIC("B")=$P(PSDSITE,U,4)
 D ^DIC K DIC
 I Y<0 W $C(7),!!,"No action taken!",!! G Q
 S PSDS=+Y,PSDSN=$P(Y,"^",2),$P(PSDSITE,U,3)=+Y,$P(PSDSITE,U,4)=PSDSN
LOOP ;loop and set ^tmp for trakker
 I $D(PSDTRAKU) Q
 K ^TMP("PSDUP3",$J)
 W !!,"Compiling inventory data...",!
 F PSD=0:0 S PSD=$O(^PSD(58.8,+PSDS,1,PSD)) Q:'PSD  I $D(^PSD(58.8,+PSDS,1,PSD,0)) S QTY=+$P($G(^(0)),"^",4) D
 .S PSDN=$S($P($G(^PSDRUG(+PSD,0)),"^")]"":$P($G(^(0)),"^"),1:"UNKNOWN")
 .S ^TMP("PSDUP3",$J,PSD)=PSDN_"^"_QTY
START ;begin
 D ^%ZIS G Q:POP S PSDIO=IO,PSDIO(0)=IOST(0) U IO X:$D(^%ZIS(2,IOST(0),10)) ^(10)
 W !,"/$",!,".$1",!,"$$",!,"I",!
 K X,X1
1 S X1=$S('$D(X1):$O(^PSD(58.88,1,1,0)),1:$O(^PSD(58.88,1,1,X1))) G 2:X1'>0 S X=$P(^PSD(58.88,1,1,X1,0),"::")
 F Y=$L(X):-1:0 Q:$E(X,Y)'=" "  S X=$E(X,1,(Y-1))
 W X,! G 1
 ;
2 W !,"ER",!,"//",! X:$D(^%ZIS(2,IOST(0),11)) ^(11) H 3 W !,"Awaiting TRAKKER signal" F X=1:1 R XX:DTIME Q:XX="*"  G NOSIGN:XX["^"!('$T)
 U PSDIO X:$D(^%ZIS(2,PSDIO(0),10)) ^(10)
 I XX="*" W "*"_+PSDS,!
 K DATA
DATA S DATA="" F  S DATA=$O(^TMP("PSDUP3",$J,DATA))  G QQ:DATA="" S DATA(1)=^TMP("PSDUP3",$J,DATA) W DATA,!,$P(DATA(1),U),!,$P(DATA(1),U,2),!
QQ W !,"END" X:$D(^%ZIS(2,PSDIO(0),11)) ^(11)
 W !,"You can now disconnect the TRAKKER.",!! H 2
 D ^%ZISC
 G Q
UPLOAD ;upload data to DHCP
 K CNT,DA,DATA,DIC,DIR,DIROUT,DIRUT,DTOUT,DUOUT,PSDS,PSDSN,X,X1,Y
 S PSDTRAKU=1 D VAULT K PSDTRAKU
 I '$G(PSDS) W !,"No vault identified." G Q
 S OK=$S($D(^XUSEC("PSJ RPHARM",DUZ)):1,1:0)
 I 'OK W $C(7),!!,?9,"** Please contact your Pharmacy Coordinator for access to",!,?12,"upload this data to the trakker.",!!,?12,"The PSJ RPHARM security key is required.",! G Q
 W !!,"Use the Send Data to DHCP option on the TRAKKER at this time.",!
 K CNT,X,^TMP("PSDWN3",$J) S PSDCON=$C(1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31)
UP1 R !,X:DTIME S:X'="" CNT=$G(CNT)+1 G FIL:X["++++" I $G(CNT)=1 S:X'="" ^TMP("PSDWN3",$J,CNT,0)=$TR(X,PSDCON) G UP1
 S:X'="" ^TMP("PSDWN3",$J,CNT,0)=$TR(X,PSDCON) G UP1
 G UP1
FIL I $D(^TMP("PSDWN3",$J)) G ^PSDFIL3
Q K CNT,DA,DATA,DIC,DTOUT,DUOUT,OK,POP,PSD,PSDCON,PSDIO,PSDN,PSDS,PSDSN,PROG,QTY,X,X1,XX,Y
 K ^TMP("PSDUP3",$J)
 Q
NOSIGN W $C(7),$C(7),!!,"No signal received from the TRAKKER",! D ^%ZISC G Q
