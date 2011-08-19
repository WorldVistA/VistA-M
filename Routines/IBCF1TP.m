IBCF1TP ;ALB/MJB - UB-82 TEST PATTERN PRINT  ;23 SEP 88 13:42
 ;;Version 2.0 ; INTEGRATED BILLING ;; 21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ;MAP TO DGCRTP
 ;
ZIS ;
 ;***
 ;S XRTL=$ZU(0),XRTN="IBCF1TP-1" D T0^%ZOSV ;start rt clock
 ;
 S %ZIS="QM" D ^%ZIS G:POP Q
 I $D(IO("Q")) K IO("Q") S ZTRTN="ENP^IBCF1TP",ZTDESC="IB - TEST UB-82 PRINT" D ^%ZTLOAD K ZTSK D HOME^%ZIS G Q
 U IO
 ;***
 ;I $D(XRT0) S:'$D(XRTN) XRTN="IBCF1TP" D T1^%ZOSV ;stop rt clock
 ;
 D ENP
Q I $D(ZTQUEUED) S ZTREQ="@"
 K DGPGM,DGVAR,POP
 ;***
 ;I $D(XRT0) S:'$D(XRTN) XRTN="IBCF1TP" D T1^%ZOSV ;stop rt clock
 Q
ENP ;
 ;***
 ;S XRTL=$ZU(0),XRTN="IBCF1TP-2" D T0^%ZOSV ;start rt clock
 ;
 W @IOF,?24,"*** UB-82 TEST PATTERN ***",!,"AGENT CASHIER",!,"AGENT CASHIER STREET",?24," F. L. 2",?57,"BILL NUMBER",?74,"XXX"
 W !,"CITY STATE  ZIP",!,"PHONE #",?24,"BC/BS #",?38,"FED TAX #",?71,"F. L. 9"
 W !!,"PATIENT NAME",?33,"PATIENT ADDRESS",!!,"PT DOB",?8,"X",?10,"X",?14,"ADM DT",?21,"HR",?25,"X",?28,"X",?30,"AH",?33,"DH",?36,"XX",?40,"FROM",?48,"TO",?70,"F. L. 27",!!
 W "OC",?3,"DATE" W ?11,"OC",?14,"DATE" W ?22,"OC",?25,"DATE",?35,"OC",?38,"DATE",?46,"OC",?49,"DATE"
 W !,"MAILING ADDRESS NAME",!,"STREET ADDRESS 1",?30,"CC",?33,"CC",?36,"CC",?39,"CC",?42,"CC",?61,"F. L. 45"
 W !,"STREET ADDRESS 2",!,"STREET ADDRESS 3"
 W !,"CITY",?$X+2,"STATE",?$X+2,"ZIP"
8 W !!!!,"000 DAYS MEDICAL CARE",!
 F I=1:1:3 W !,"REV CODE ",I,?24,"000.00",?31,"000",?35,"00",?39,"  0000.00"
 W !!,"SUBTOTAL",?39," 00000.00"
 F I=1:1 Q:$Y=30  W !
 W !!,"TOTAL",?39," 00000.00"
 F I=1:1 Q:$Y=40  W !
 F I=1:1:3 W !,"PAYER ",I,?24,"X",?27,"X"
 F I=1:1 Q:$Y=45  W !
 F I=1:1:3 W !,"INSURED NAME ",I,?23,"X",?26,"XX",?29,"POLICY # ",I,?46,"GROUP NAME ",I,?61,"GROUP # ",I
 F I=1:1 Q:$Y=50  W !
 W "X",?2,"X",?4,"EMPLOYER NAME",?42,"CITY  STATE  ZIP"
 F I=1:1 Q:$Y=53  W !
 W "PRINCIPAL DIAGNOSIS",?44,"CODE" F I=51,58,65,72 W ?I,"CODE"
 W !!,"X",?3,"PRINCIPAL PROCEDURE",?44,"CODE",?51,"DATE",?57,"CODE",?63,"DATE",?68,"CODE",?74,"DATE"
 F I=1:1 Q:$Y=56  W !
 W !?22,"TX. AUTH.",?33,"Dept. Veterans Affairs",?56,"F. L. 93"
 W !!,"Patient ID: ","XXXXXXXXX",!,"Bill Type: ","XXXX XXXXXXX",!,"UB-82 TEST PATTERN",!,"**TEST PATTERN**"
16 F I=1:1 Q:$Y=62  W !
 W ?46,"UB-82 SIGNER NAME",!,?46,"UB-82 SIGNER TITLE",?69,"DATE"
 K I
 I $D(ZTQUEUED) S ZTREQ="@" Q
 D ^%ZISC
 ;***
 ;I $D(XRT0) S:'$D(XRTN) XRTN="IBCF1TP" D T1^%ZOSV ;stop rt clock
 Q
 ;IBCF1TP
