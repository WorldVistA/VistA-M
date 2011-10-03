IVMRTSR1 ;ALB/KCL - Report of IVM Transmissions ; 30 April 1993
 ;;Version 2.0 ; INCOME VERIFICATION MATCH ;; 21-OCT-94
 ;
 ;
EN ;entry point
 ;
 ; Convert FM dates to external date format
 S Y=IVMBEG D DD^%DT S IVMBEG=Y
 S Y=IVMEND D DD^%DT S IVMEND=Y
 ;
HDR ; Print header of report
 D HEAD
 ;
SINGLE ; Check for a single date report
 ; Print body of report for single transmission date
 I IVMFLG=1 D
 .I 'IVMCNT W !!!!!,?19,"No data found for the date: ",$E(IVMBEG,1,12),!!! Q
 .W !!?10,"Transmission Date:  ",$E(IVMBEG,1,12)
 .W !?10,"Number of Transmissions:  ",IVMCNT
 .W !?21,"Without Status:  ",+$G(IVMCNTS("NO"))
 .W !?24,"Transmitted:  ",+$G(IVMCNTS(0))
 .W !?27,"Received:  ",+$G(IVMCNTS(1))
 .W !?27,"In Error:  ",+$G(IVMCNTS(2))
 .W !?21,"Re-transmitted:  ",+$G(IVMCNTS(3))
 .W !?10,"Multiple Transmissions:   ",IVMCNT1," (of ",IVMCNT,")"
 .W !!!,?10,"Category",?30,"With Insurance",?55,"Without Insurance"
 .W !,?10,"-----------",?30,"--------------",?55,"-----------------"
 .W !,?10,"Category A ",?30,$J(IVMIN,10),?55,$J(IVMNIN,10)
 .W !,?10,"Category C ",?30,$J(IVMCIN,10),?55,$J(IVMCNIN,10)
 ;
IVMRNG ; Check for a date range report
 ; Print body of report summary for a range of transmssion dates
 I IVMFLG=2 D
 .I 'IVMCNT W !!!!!,?7,"No data found for the date range: "_$E(IVMBEG,1,12)_"  to  "_$E(IVMEND,1,12),!!! Q
 .W !!,?10,"Date range selected: "_$E(IVMBEG,1,12)_"  to  "_$E(IVMEND,1,12),!!
 .W !,?10,"Total number of days: ",?49,$J(IVMRNG,10)
 .W !,?10,"Total number of transmissions: ",?49,$J(IVMCNT,10),"  (",$J(IVMCNT/IVMRNG,0,2),"/day)"
 .W !!?12,"Without Status: ",+$G(IVMCNTS("NO")),?50,"In Error: ",+$G(IVMCNTS(3))
 .W !?15,"Transmitted: ",+$G(IVMCNTS(0)),?44,"Re-transmitted: ",+$G(IVMCNTS(2))
 .W !?18,"Received: ",+$G(IVMCNTS(1)),?36,"Multiple Transmissions: ",IVMCNT1," (of ",IVMCNT,")"
 .W !!,?35,"With Insurance",?55,"Without Insurance"
 .W !,?35,"--------------",?55,"-----------------"
 .W !,?10,"Percentage Category A:",?38,$J(IVMPERA,6,2)_" %",?61,$J(IVMPERB,6,2)_" %"
 .W !,?10,"Percentage Category C:",?38,$J(IVMPERC1,6,2)_" %",?61,$J(IVMPERC,6,2)_" %"
 ;
 D PAUSE^IVMRUTL I $G(IVMQUIT) G ENQ
 ;
MQRY ; Display Master Query Results
 I $E(IOST,1,2)["C-" D HEAD
 I $E(IOST,1,2)'["C-" W !
 D HEAD1
 I '$D(^IVM(301.9,1,10)) W !!?22,"--  No Master Queries Received --" G ENQ1
 S IVM=0 F  S IVM=$O(^IVM(301.9,1,10,IVM)) Q:'IVM  S IVMD=$G(^(IVM,0)) D  I $G(IVMQUIT) G ENQ
 .Q:'IVMD
 .I $Y>(IOSL-5) D PAUSE^IVMRUTL Q:$G(IVMQUIT)  D HEAD,HEAD1
 .W !?16,$E(+IVMD,1,3)+1700
 .W ?30,$$DAT1^IVMUFNC4($P(IVMD,"^",2),1)
 .W ?50,$$DAT1^IVMUFNC4($P(IVMD,"^",3),1)
 ;
ENQ1 D PAUSE^IVMRUTL
 ;
ENQ ; cleanup
 K IVMCNIN,IVMCNT,IVMCNT1,IVMFLG,IVMIN,IVMNIN,IVMPERA,IVMPERB,IVMPERC,IVMRNG,Y,IVMQUIT,IVM,IVMD,IVMCIN,IVMPERC1
 Q
 ;
HEAD ; Display header.
 I $E(IOST,1,2)["C-" W @IOF ; init form feed to CRT, subsequent form feeds to all other devices
 W !?5,"====================================================================="
 W !?5,"|",?17,"INCOME VERIFICATION MATCH - TRANSMISSIONS REPORT",?73,"|"
 W !?5,"|",?73,"|"
 W !?5,"|-------------------------------------------------------------------|"
 S Y=DT D DD^%DT W !?5,"|",?25,"DATE PRINTED: ",Y,?73,"|"
 W !?5,"====================================================================="
 Q
 ;
HEAD1 ; Display Master Query header.
 W !!?16,"** M A S T E R   Q U E R Y   S U M M A R Y **"
 W !!?10,"Query Income Year",?30,"Date Received",?50,"Date Responded"
 W !?10,"-----------------",?30,"-----------------",?50,"-----------------"
 Q
