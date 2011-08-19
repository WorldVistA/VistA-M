RTNQ1 ;TROY ISC/MJK-Record Trace Routine ; 5/8/87  8:43 AM ; 1/17/03 9:23am
 ;;2.0;Record Tracking;**31**;10/22/91 
 I '$D(RTAPL) D APL2^RTPSET D NEXT:$D(RTAPL) K RTAPL,RTSYS Q
NEXT S RTA=+RTAPL D ASK^RTB K RTA G Q:$D(RTESC),RTNQ1:Y<0 S RTE=X
 S RTRD(1)="Mixed^sort movements of all records together",RTRD(2)="Separate^sort each record type and volume separately",RTRD("B")=1,RTRD("A")="How do you want the '"_$P($P(RTAPL,"^"),";",2)_"' records sorted? ",RTRD(0)="S"
 D SET^RTRD K RTRD G Q:X="^" S RTSORT=$E(X)
 S RTVAR="RTSORT^RTAPL^RTE^DTIME",RTPGM="START^RTNQ1" D ZIS^RTUTL G Q:POP D START G NEXT
 ;
START U IO K RTESC,DFN,^TMP($J,"RTRACE")
 F RT=0:0 S RT=$O(^RT("AA",+RTAPL,RTE,RT)) Q:'RT  I $D(^RT(RT,0)) S Y=^(0) I $S('$D(RTTY):1,$P(Y,"^",3)=+RTTY:1,1:0) S O=+$P(^DIC(195.2,+$P(Y,"^",3),0),"^",4),V=999-$P(Y,"^",7) D HIS
 K RT,RT0,RTH,RTH0 S RTPAGE=0 D HD,PRT:$D(^TMP($J,"RTRACE"))
 W:'$D(^TMP($J,"RTRACE")) !!?3,"...No history online." ;D DPT:RTE["DPT("
Q K RTY,RTH0,RTPAGE,RTVAR,RTPGM,RTE,RTS1,RTS2,RTS3,RTSORT,RTO,RTDT,RTVOL,RTVL,RTESC,^TMP($J,"RTRACE") D CLOSE^RTUTL
 K DUOUT,X1,Y,Y2,RT,RTS4,%I,%Y,C,DIC,DIY,N,O,POP,V,X Q
PRT F RTS1=0:0 S RTS1=$O(^TMP($J,"RTRACE",RTS1)) Q:'RTS1  F RTS2=0:0 S RTS2=$O(^TMP($J,"RTRACE",RTS1,RTS2)) Q:'RTS2  D PRT1 G PRTQ:$D(RTESC)
PRTQ Q
 ;
PRT1 F RTS3=0:0 S RTS3=$O(^TMP($J,"RTRACE",RTS1,RTS2,RTS3)) Q:'RTS3  F RTS4=0:0 S RTS4=$O(^TMP($J,"RTRACE",RTS1,RTS2,RTS3,RTS4)) Q:'RTS4  S RTH0=^(RTS4) D PRT2 G PRT1Q:$D(RTESC)
PRT1Q Q
 ;
PRT2 S RT=+RTH0 Q:'RT  I '$D(RTVL(RT)) D DEMOS^RTUTL1 S RTVL(RT)=RTD("A")_RTD("V") I RTSORT="S" D HD:($Y+5)>IOSL Q:$D(RTESC)  D DEMOS^RTUTL1:'$D(RTD) W !!,"[ ",RTD("T"),"]"
 D HD:($Y+5)>IOSL Q:$D(RTESC)  S Y=RTH0 D DEMOS3^RTUTL1 S Y=$P(RTH0,"^",8),C=$P(^DD(190.3,8,0),"^",2) D Y^DIQ S M=Y,X1=+$P(RTH0,"^",9),X2=+$P(RTH0,"^",6) S:'X1 X1=DT D ^%DTC S D=$S(X'<0:X,1:"")
 W !,RTD("D"),?20,RTVL(RT),?25,RTD("B"),?50,$E(M,1,24),?75,D W:$D(RTD("PROV")) !?25,"(",RTD("PROV"),")"
 K RT,D,RTD,B,B1,M,D1 Q
 ;
HD I RTPAGE,IOST["C-" D ESC^RTRD Q:$D(RTESC)
 S RTPAGE=RTPAGE+1,X1="Movement History for the "_$S($D(^DIC(195.1,+RTAPL,"HD")):$P(^("HD"),"^"),1:$P($P(RTAPL,"^"),";",2)) D PTHD^RTUTL2,EQUALS^RTUTL3 K X1
 I $D(DFN) W !!,"[ Clinic History Profile ]",!?3,"Clinic",?30,"Appointment Date/Time",?55,"Status",!?3,"------",?30,"---------------------",?55,"------" Q
 W !,"[SORT: ",$S(RTSORT="M":"By date charged,record type display order and then volume",1:"By record type display order,volume and then date charged"),"]"
 W !!,"Date Charged",?20,"Vol",?25,"Borrower",?50,"Type of Movement",?70,"# of Days" D LINE^RTUTL3
 Q
 ;
HIS F RTH=0:0 S RTH=$O(^RTV(190.3,"B",RT,RTH)) Q:'RTH  I $D(^RTV(190.3,RTH,0)) S RTH0=^(0) D SET
 Q
 ;
SET S D=9999999.9999-$P(RTH0,"^",6)
 I RTSORT="S" F Y=999:-1 I '$D(^TMP($J,"RTRACE",O,V,D,Y)) S ^(Y)=RTH0 Q
 ; the next line accounts for more than one movement transaction having
 ; occurred within the same minute, while preserving the "reverse date"
 ; sort order
 ;
 I RTSORT'="S" F Y=999:-1 I '$D(^TMP($J,"RTRACE",D,O,V,Y)) S ^(Y)=RTH0 Q
 Q
