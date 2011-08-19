ENEQRP5 ;(WASH ISC)/DH-PM Workload Report ;4-27-95
 ;;7.0;ENGINEERING;**15,22**;Aug 17, 1993
EN S DIC="^DIC(6922,",DIC(0)="AEMQ" D ^DIC Q:Y'>0  S ENSHKEY=+Y,ENSHOP=$P(^DIC(6922,ENSHKEY,0),U,1)
 S (ENTEC,ENTEC("ALL"))=0
 S DIR(0)="Y",DIR("A")="Should results be broken out by TECHNICIAN"
 S DIR("B")="NO"
 S DIR("?",1)="If you say YES, counts and totals will be reported separately for"
 S DIR("?",2)="different assigned technicians.  You will be allowed to request this"
 S DIR("?")="information for all technicians or for one particular technician."
 D ^DIR K DIR G:$D(DIRUT) EXIT
 I Y=1 D  I $D(DIRUT)!('$D(ENTEC)) G EXIT
 . S DIR(0)="Y",DIR("A")="Include ALL technicians",DIR("B")="YES"
 . S DIR("?",1)="If you say NO, you will be asked to select a technician of interest"
 . S DIR("?")="from the Eng Employee File."
 . D ^DIR K DIR Q:$D(DIRUT)  S:Y=1 ENTEC("ALL")=1
 . I 'ENTEC("ALL") D
 .. S DIR(0)="P^6929:AEMQ",DIR("A")="Select TECHNICIAN of interest"
 .. K DIR("B") D ^DIR K DIR I Y>0 S ENTEC=+Y,ENEMP=$P($G(^ENG("EMP",+Y,0)),U)
 .. I Y'>0 K ENTEC Q
 .. I ENEMP']"" K ENTEC Q
DEV D DEV^ENLIB G:POP EXIT I $D(IO("Q")) K IO("Q") S ZTRTN="EN1^ENEQRP5",ZTSAVE("EN*")="",ZTDESC="PM Workload Analysis" D ^%ZTLOAD K ZTSK D HOME^%ZIS G EXIT
EN1 S (ENC,ENT)=0 F I=1:1:12 S (ENC(I),ENT(I))=0
 I '$D(ZTQUEUED) W !!,"    compiling data"
 F ENDA=0:0 S ENDA=$O(^ENG(6914,"AB",ENSHKEY,ENDA)) Q:ENDA'>0  S ENM=$O(^ENG(6914,"AB",ENSHKEY,ENDA,0)) D NTRE I '$D(ZTQUEUED) W:'(ENDA#10) "."
 I '$D(DT) S %DT="",X="T" D ^%DT S DT=Y
PR U IO W:$E(IOST,1,2)="C-" @IOF S ENDONE=0 I ENTEC("ALL") D  G EXIT
 . S ENEMP="A" F  S ENEMP=$O(ENC(ENEMP)) Q:ENEMP']""!(ENDONE)  D
 .. F I=1:1:12 I '$D(ENC(ENEMP,I)) S ENC(ENEMP,I)=0
 .. D PR1
PR1 W "PM Workload Analysis: ",ENSHOP," Shop" S Y=DT X ^DD("DD") W ?65,Y
 I ENTEC!ENTEC("ALL") W !,"Responsible Technician: ",ENEMP
 W !,?5,"Month",?20,"Item Count*",?35,"Standard Hours",! F I=1:1:79 W "-"
 F I=1:1:12 W !,?7,$P("JAN^FEB^MAR^APR^MAY^JUN^JUL^AUG^SEP^OCT^NOV^DEC",U,I),?20,$J($S(ENTEC("ALL"):ENC(ENEMP,I),1:ENC(I)),10),?35,$J($S(ENTEC("ALL"):ENT(ENEMP,I),1:ENT(I)),14,1)
 I ENTEC("ALL") S ENT=0 F I=1:1:12 S ENT=ENT+ENT(ENEMP,I)
 E  F I=1:1:12 S ENT=ENT+ENT(I)
 W !,?20,"----------",?35,"--------------",!,"COUNT**",?20,$J($S(ENTEC("ALL"):ENC(ENEMP),1:ENC),10),!,"TOTAL",?35,$J(ENT,14,1)
 W !!,"*  Count of items to be inspected in month indicated."
 W !,"**  Count of all items for which this ",$S(ENTEC:"technician",ENTEC("ALL"):"technician",1:"shop")," has PM responsibility."
 I $E(IOST,1,2)="C-" D HOLD I ENDONE,ENTEC("ALL") Q
 W @IOF I 'ENTEC("ALL") D EXIT
 Q
 ;
NTRE I $D(^ENG(6914,ENDA,3)) S EN=^(3),ENA=$P(EN,U,1) I ENA>3,ENA<6 Q
 Q:'$D(^ENG(6914,ENDA,4,ENM))  S ENTEC("CURRENT")=$P($G(^(ENM,0)),U,2) I ENTEC,ENTEC'=ENTEC("CURRENT") Q
 K ENA S ENSTMN=$S($D(^ENG(6914,ENDA,4,ENM,1)):^(1),1:"") I ENSTMN="" S ENSTMN=1
 I ENTEC("ALL") S ENEMP=$S(ENTEC("CURRENT")>0:$P($G(^ENG("EMP",+ENTEC("CURRENT"),0)),U),1:"") S:ENEMP="" ENEMP="UNASSIGNED" S ENC(ENEMP)=$G(ENC(ENEMP))+1
 I 'ENTEC("ALL") S ENC=ENC+1
 F I=1:1:12 S $P(ENA,U,I)=""
 F I=0:0 S I=$O(^ENG(6914,ENDA,4,ENM,2,I)) Q:I'>0  S ENHZ=$P(^ENG(6914,ENDA,4,ENM,2,I,0),U,1),ENA(ENHZ)=$S($P(^(0),U,2)]"":$P(^(0),U,2),1:0)
 I $D(ENA("M")) F I=1:1:12 S $P(ENA,U,I)=ENA("M")
 I $D(ENA("BM")) F I=ENSTMN:2:(ENSTMN+10) S J=I S:J>12 J=J#12 S $P(ENA,U,J)=ENA("BM")
 I $D(ENA("Q")) F I=ENSTMN:3:(ENSTMN+9) S J=I S:J>12 J=J#12 S $P(ENA,U,J)=ENA("Q")
 I $D(ENA("S")) F I=ENSTMN,(ENSTMN+6) S J=I S:J>12 J=J#12 S $P(ENA,U,J)=ENA("S")
 I $D(ENA("A")) S $P(ENA,U,ENSTMN)=ENA("A")
 S ENA("WT")="" I $D(ENA("W")) S ENA("WT")=ENA("W")*4
 I $D(ENA("BW")) S ENA("WT")=ENA("WT")/2+(ENA("BW")*2)
 F I=1:1:12 S ENT(I)=ENT(I)+$P(ENA,U,I)+ENA("WT")
 I ENA("WT")]"" F I=1:1:12 S ENC(I)=ENC(I)+1
 E  F I=1:1:12 I $P(ENA,U,I)]"" S ENC(I)=ENC(I)+1
 I ENTEC("ALL") D
 . F I=1:1:12 S ENT(ENEMP,I)=$G(ENT(ENEMP,I))+$P(ENA,U,I)+ENA("WT")
 . I ENA("WT")]"" F I=1:1:12 S ENC(ENEMP,I)=$G(ENC(ENEMP,I))+1
 . E  F I=1:1:12 I $P(ENA,U,I) S ENC(ENEMP,I)=$G(ENC(ENEMP,I))+1
 Q
HOLD W ! S DIR(0)="E" D ^DIR K DIR S:'Y ENDONE=1
 Q
 ;
EXIT K EN,ENC,ENT,ENA,ENSHKEY,ENSHOP,ENHZ,ENDA,ENSTMN,ENMNB,ENM,ENTEC,ENEMP
 K ENDONE,ZTRTN,ZTSAVE,ZTDESC S:$D(ZTQUEUED) ZTREQ="@"
 K DIC,DIR,DIROUT,DIRUT,DTOUT,DUOUT
 I '$D(ZTQUEUED),$E(IOST,1,2)="P-" D ^%ZISC
 Q
 ;ENEQRP5
