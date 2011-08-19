YSCEN55 ;ALB/ASF-CENSUS HX DATE SORT ;12/19/90  09:19 ;03/14/94 15:13
 ;;5.01;MENTAL HEALTH;;Dec 30, 1994
 ;
EN2 ; Called from MENU option YSCENDAYHX
 ;
 D IN S %DT("A")="Most recent date :",%DT="APXE" D ^%DT S YSTO=+Y,YSTO1=+Y Q:Y<1  S YSTO=9999999-YSTO-1
 S %DT("A")="To oldest date: ",%DT="APXE" D ^%DT S YSFRM=+Y,YSFRM1=+Y Q:Y<1  S YSFRM=9999999-YSFRM-.0001
 S:YSFRM'>YSTO X=YSFRM,YSFRM=YSTO,YSTO=X
ASK ;
 S (YSFL6,YSFL5)=0 R !,"Do you wish to output a single Ward? N// ",YSFL7:DTIME S YSTOUT='$T,YSUOUT=YSFL7["^" Q:YSTOUT!(YSUOUT)
 S YSR1="YSFL7",YSR2="N",YSR3="YN",YSR4="Answer Yes if you want to restrict listing to a particular ward" D ^YSCEN14 G ASK:YSFL7="?" Q:YSFL7=-1
 ;
 ;  Undefined Q3 error occurs if user ^'s at 'ward' query
 ;  Thanks to Chris Parris, Birmingham ISC, for reporting problem!!!
 I "Yy"[YSFL7 K Q3 S YSFL6=1 D A^YSCEN51 Q:$G(Q3)!('$D(Q3))  ;->
 ;
 K IOP S %ZIS="Q" D ^%ZIS Q:POP  I $D(IO("Q")) K IO("Q") S ZTRTN="HXQ^YSCEN55",ZTDESC="YS IP HX" F ZZ="YS(","YSTO","YSTO1","YSFL6","YSFL5","W1","YSFRM","YSFRM1" S ZTSAVE(ZZ)=""
 I  D ^%ZTLOAD W !,$S($D(ZTSK):"QUEUED",1:"Not queued"),$C(7) Q
HXQ ;
 U IO S YSTLT="INPATIENT HISTORY: ",Y=YSTO1 D DD^%DT S YSTLT=YSTLT_Y,Y=YSFRM1 D DD^%DT S YSTLT=YSTLT_"-"_Y
 K Y D ENDTM^YSUTL S YSHTM=YSTM,YSTLT=YSTLT_"     "_YSDT(0)_" "_YSHTM_" pg.",P=0
 S X7=YSTO,Q3=0 D HDD F  S X7=$O(^YSG("INP","AIN",X7)) Q:'X7!(X7>YSFRM)  D 3 Q:Q3
 G END
3 ;
 Q:Q3  S W1=0 F  S W1=$O(^YSG("INP","AIN",X7,W1)) Q:'W1  S YSDFN=$P(^YSG("INP",W1,0),U,2),DA=W1 D 1^YSCEN51:YSFL6,2^YSCEN5:'YSFL6!(YSFL5) D:$Y+8>IOSL WAIT,HDD Q:Q3
 Q
WAIT ;
 Q:Q3  D:IOST?1"C-".E WAIT^YSCEN1 Q
HDD ;
 Q:Q3  S P=P+1 W @IOF,YSTLT,P Q:'YSFL6  W !,"Listing for the following Teams: " S X=0 F  S X=$O(YS(X)) Q:'X  S X1=$P(^YSG("SUB",X,0),U) W:$L(X1)>IOM ! W ?$X+1,X1,","
 W ! Q
END ;
 D KILL^%ZTLOAD
 K ^UTILITY($J),%ZIS,IOP,YSFL5,YSFL7 W !! D ^%ZISC Q
IN ;
 S YSTLT="M E N T A L   H E A L T H   I N P A T I E N T   H I S T O R Y" W @IOF,!?((IOM-$L(YSTLT))\2),YSTLT,!
 Q
