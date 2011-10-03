YSGAF1 ;ASF/ALB- GLOBAL ASSESSMENT OF FUNCTIONNING CONT;9/25/97  11:19 ;11/10/97  16:08
 ;;5.01;MENTAL HEALTH;**33**;Dec 30, 1994
 Q
ONELOC ;single hospital location
 N DIC,Y
 S YSCLIN="",YSCNAME=""
 S DIC="^SC(",DIC(0)="AEQMZ" D ^DIC Q:Y<1
 S YSCLIN=+Y,YSCNAME=$P(Y,U,2)
 S YSSTOP=$P(Y(0),U,7) S:YSSTOP YSSTOP=$P($G(^DIC(40.7,YSSTOP,0)),U,2) ;ASF 9/30
 I YSSTOP>499&(YSSTOP<600) Q
 W !,YSCNAME," does not have a mental health stop code"
 S DIR("A")="Do you wish to continue? ",DIR("B")="No",DIR(0)="Y" D ^DIR
 I Y'=1 D ONELOC
 Q
DATE ;
 N %DT
 S %DT("A")="Enter Report Date: ",%DT("B")="T",%DT="AEF" D ^%DT
 S YSDATE=Y
 Q
ONLYREQ ;only > ysdays
 S YSONLY=""
 K DIR S DIR(0)="Y",DIR("A")="Show only patients who do not have a GAF within "_YSDAYS_" days",DIR("B")="Yes" D ^DIR K DIR
 Q:$D(DIRUT)  S YSONLY=Y
 Q
LP1 ;loop to create tmp pt list
 K ^TMP("YSGAF",$J)
 S YSDD=YSDATE
 F  S YSDD=$O(^SC(YSCLIN,"S",YSDD)) Q:YSDD<1!(YSDD\1-YSDATE)  D LP2
 Q
LP2 ;apps at one time
 S K=0 F  S K=$O(^SC(YSCLIN,"S",YSDD,1,K)) Q:K<1  D:$G(^SC(YSCLIN,"S",YSDD,1,K,0))
 . S YSG=^SC(YSCLIN,"S",YSDD,1,K,0)
 . S DFN=+YSG,YSPTN=$P(^DPT(DFN,0),U)
 . Q:$P($G(^DPT(DFN,"S",YSDD,0)),U,2)'=""  ;dont list if cancelled, noshow or ip
 . S ^TMP("YSGAF",$J,"A",YSPTN,DFN)=""
 Q
HX ;GAF history
 N %DT,DA,DIE,DIR,DIRUT,DLAYGO,DR,K,VA,VADM,X,X1,X2,Y,YSCLIN,YSCNAME,YSDA,YSDATE,YSDAYS,YSDD,YSDXEG,YSDXEL,YSDXEN,YSG,YSGAFLC,YSGAFLD,YSGAFLN,YSGC,YSGD,YSGN,YSGR,YSGT,YSLINE,YSN,YSONLY,YSOUT,YSPAGE,YSPTN,YSRULE,YSSTOP
 K DIC,DFN D ^YSLRP Q:'$D(DFN)
 ;ASK DEVICE 
 S %ZIS="QM"
 D ^%ZIS
 Q:$G(POP)
 I $D(IO("Q")) D  Q
 .N ZTRTN,ZTDESC,ZTSAVE
 .S ZTRTN="QHX^YSGAF1"
 .S ZTDESC="YSGAF1 HX PRINT"
 . S ZTSAVE("DFN")=""
 .D ^%ZTLOAD
 .D HOME^%ZIS
 .Q
 U IO
QHX ;Queued Task Entry Point
 S:$D(ZTQUEUED) ZTREQ="@"
 D DEM^VADPT
 K ^TMP("YSGAF",$J)
 D HXLP
 D TOP
 I '$D(^TMP("YSGAF",$J,"H")) W !!,"No previous GAF's on file for this patient" Q
 S YSOUT=1
 S YSDD=0 F  S YSDD=$O(^TMP("YSGAF",$J,"H",YSDD)) Q:YSDD'>0  S YSN=0 F  S YSN=$O(^TMP("YSGAF",$J,"H",YSDD,YSN)) Q:YSN'>0  D  D:$Y+4>IOSL BOT Q:YSOUT<1
 . S YSG=^TMP("YSGAF",$J,"H",YSDD,YSN)
 . S Y=$P(YSG,U,2) W !,$E(Y,4,5)_"/"_$E(Y,6,7)_"/"_$E(Y,2,3),$S($L($P(YSG,U,4)):"Err",1:"   ")
 . I $P(YSG,U,3) W $E($P($G(^VA(200,$P(YSG,U,3),0)),U),1,15)
 . W ?26,$J(+YSG,3)
 . W " ",$E(YSGR,1,+YSG\2)
 D ^%ZISC
 Q
HXLP ;
 S YSDD=0 F  S YSDD=$O(^YSD(627.8,"AX5",DFN,YSDD)) Q:YSDD'>0  S YSN=0 F  S YSN=$O(^YSD(627.8,"AX5",DFN,YSDD,YSN)) Q:YSN'>0  D
 . S ^TMP("YSGAF",$J,"H",YSDD,YSN)=$P($G(^YSD(627.8,YSN,60)),U,3)_U_$P($G(^YSD(627.8,YSN,0)),U,3)_U_$P($G(^YSD(627.8,YSN,0)),U,4)_U_$G(^YSD(627.8,YSN,80,1,0))
 Q
TOP ;
 S YSGT="   10   20   30   40   50   60   70   80   90    |"
 S YSGR="####|####|####|####|####|####|####|####|####|####|"
 W @IOF,"Global Assessment of Functioning Historical Listing"
 W !,VADM(1),?$X+5,VA("PID"),?45,"printed: "
 D NOW^%DTC S Y=% X ^DD("DD") W Y
 S YSLINE="",$P(YSLINE,"-",79)="" W !,YSLINE
 W !,"Date",?10,"Clinician",?26,"GAF",?30,YSGT
 Q
BOT ;page end
 K DIR S YSOUT=1 I IOST'?1"C".E D TOP Q
 W !! S DIR(0)="E" D ^DIR
 S YSOUT=Y D:Y=1 TOP
 Q
