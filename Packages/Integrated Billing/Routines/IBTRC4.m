IBTRC4 ;ALB/AAS - CLAIMS TRACKING - PRINT REVIEW WORKSHEET ; 14-JUL-93
 ;;Version 2.0 ; INTEGRATED BILLING ;; 21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
% G RWM
 ;
RW ; -- print Review Worksheet from lm action from ibtre
 D FULL^VALM1
 D PRINT(DFN)
RWQ S VALMBCK="R" Q
 ;
RWM ; -- print review worksheet from menu
 W !,"Print Insurance Review Worksheet",!
RWM1 ;
 ; -- select patient
 D PAT^IBCNSM I $D(VALMQUIT)!('$G(DFN)) G RWMQ
 ;
 ; -- print the sheet, reask patient
 I $G(DFN) D PRINT(DFN),RWMQ W !! G RWM1
 Q
 ;
RWMQ K I,J,X,Y,DIC,DFN,VALMQUIT
 Q
 ;
PRINT(DFN) ; -- print one worksheet
 ;
 N I,J,X,Y,VA,VA200,VAERR,VAIN,IBINS,IBCNT,IBX,TAB,TAB2,POP
 ;
 S %ZIS="QM" D ^%ZIS G:POP PRINTQ
 I $D(IO("Q")) K IO("Q") S ZTRTN="DQ1^IBTRC4",ZTSAVE("DFN")="",ZTSAVE("IB*")="",ZTDESC="IB - Print Review Worksheet" D ^%ZTLOAD K ZTSK D HOME^%ZIS G PRINTQ
 ;
 U IO
 ;
DQ1 D DQ G RWMQ
 Q
DQ ; -- entry point from taskman
 S VA200="",TAB=3,TAB2=$S(IOM>120:80,1:44)
 D INP^VADPT,PID^VADPT,INS
 ;
TOP W !!,?(IOM-26/2),"INSURANCE REVIEW WORKSHEET",!?(IOM-22),$$HTE^XLFDT($H)
 W !!?TAB,"     Specialty: ",$E($P($G(VAIN(3)),"^",2),1,23)
 W ?TAB2+8,"Ward: ",$P($G(VAIN(4)),"^",2)
 W !!?TAB,"          Name: ",$E($P($G(^DPT(DFN,0)),"^",1),1,23)
 W ?TAB2,"Insurance Co: ",$G(IBX(1))
 W !?TAB,"         Pt ID: ",VA("PID"),?(TAB2+14),$G(IBX(2))
 W !?TAB,"           DOB: ",$$FMTE^XLFDT($P($G(^DPT(DFN,0)),"^",3)),?(TAB2+14),$G(IBX(3))
 W !!?TAB,"Admission Date: ",$P($G(VAIN(7)),"^",2)
 W ?TAB2,"     DC Date: ________  LOS: _____"
 W !!?TAB,"  Attending MD: ",$E($P($G(VAIN(11)),"^",2),1,20)
 W ?TAB2,"  Primary MD: ",$E($P($G(VAIN(2)),"^",2),1,20)
 W !!?TAB,"Complaint/Hist: ",$$LINE("_",IOM-TAB-17)
 W !!?TAB,"                ",$$LINE("_",IOM-TAB-17)
 W !!?TAB,"     Treatment: ",$$LINE("_",IOM-TAB-17)
 W !!?TAB,"                ",$$LINE("_",IOM-TAB-17)
 I $E(IOST,1,2)="C-" D PAUSE^VALM1 I $D(DIRUT) G PRINTQ
 ;
MID ;
 W !!?TAB,$$LINE("=",IOM-TAB-1)
 W !?TAB,"|Date",?12,"|Diagnosis",?37,"|Procedure",?64,"|DRG",?71,"|LOS   |" W:IOM>130 "Notes",?130,"|"
 I $E(IOST,1,2)'="C-" W $C(13),"   ",$$LINE("_",IOM-TAB-1)
 F I=1:1:8 D BLINE
 W !?TAB,$$LINE("=",IOM-TAB-1)
 I $E(IOST,1,2)="C-" D PAUSE^VALM1 I $D(DIRUT) G PRINTQ
 ;
BOT ;
 W !?TAB,"|Insurance Contact: ",$$LINE("_",26),"  Phone: ",$$LINE("_",20),"|"
 W !?TAB,"|",$$LINE("_",IOM-TAB-3),"|"
 W !?TAB,"|Date    |Comments (#day approved, next review date, etc.)",?IOM-2,"|"
 I $E(IOST,1,2)'="C-" W $C(13),"   ",$$LINE("_",IOM-TAB-1)
 F I=1:1:5 D BLINE2
 W !?TAB,$$LINE("=",IOM-TAB-1)
 W !!?TAB,"Reviewer: _____________________________________  Date: ____________________"
 I $E(IOST,1,2)="C-" D PAUSE^VALM1 I $D(DIRUT) G PRINTQ
 ;
PRINTQ W !
 I $D(ZTQUEUED) S ZTREQ="@" Q
 D ^%ZISC
 Q
 ;
LINE(CHAR,LEN) ; -- return line of length len of character char
 I '$G(LEN) S LEN=IOM
 I $G(CHAR)="" S CHAR="-"
 Q $TR($J(" ",LEN)," ",CHAR)
 ;
BLINE ; -- print line with bars
 W !?TAB,"|        |                        |                          |      |      |" W:IOM>130 "                                                   |"
 W !?TAB,"|________|________________________|__________________________|______|______|" W:IOM>130 "___________________________________________________|"
 Q
BLINE2 ; -- print line with bars
 W !?TAB,"|        |                                                                 " W:IOM<130 "|" W:IOM>130 "                                                    |"
 W !?TAB,"|________|_________________________________________________________________" W:IOM<130 "|" W:IOM>130 "____________________________________________________|"
 Q
 ;
INS ; -- print insurance info
 D ALL^IBCNS1(DFN,"IBINS",1,$S(+VAIN(8):+VAIN(8),1:DT))
 K IBX
 I $G(IBINS(0))<1 S IBX(1)="No Active Insurance" G INSQ
 S I=0,IBCNT=0 F  S I=$O(IBINS(I)) Q:'I  S IBCNT=$G(IBCNT)+1,IBX(IBCNT)=$E($P($G(^DIC(36,+IBINS(I,0),0)),"^"),1,20) Q:IBCNT>3
 ;
INSQ Q
