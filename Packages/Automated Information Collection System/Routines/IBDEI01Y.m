IBDEI01Y ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,138,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,138,1,3,0)
 ;;=3^Fear of Injections & Transfusions
 ;;^UTILITY(U,$J,358.3,138,1,4,0)
 ;;=4^F40.231
 ;;^UTILITY(U,$J,358.3,138,2)
 ;;=^5003551
 ;;^UTILITY(U,$J,358.3,139,0)
 ;;=F40.232^^3^24^11
 ;;^UTILITY(U,$J,358.3,139,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,139,1,3,0)
 ;;=3^Fear of Oth Medical Care
 ;;^UTILITY(U,$J,358.3,139,1,4,0)
 ;;=4^F40.232
 ;;^UTILITY(U,$J,358.3,139,2)
 ;;=^5003552
 ;;^UTILITY(U,$J,358.3,140,0)
 ;;=F40.233^^3^24^10
 ;;^UTILITY(U,$J,358.3,140,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,140,1,3,0)
 ;;=3^Fear of Injury
 ;;^UTILITY(U,$J,358.3,140,1,4,0)
 ;;=4^F40.233
 ;;^UTILITY(U,$J,358.3,140,2)
 ;;=^5003553
 ;;^UTILITY(U,$J,358.3,141,0)
 ;;=F40.240^^3^24^7
 ;;^UTILITY(U,$J,358.3,141,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,141,1,3,0)
 ;;=3^Claustrophobia
 ;;^UTILITY(U,$J,358.3,141,1,4,0)
 ;;=4^F40.240
 ;;^UTILITY(U,$J,358.3,141,2)
 ;;=^5003554
 ;;^UTILITY(U,$J,358.3,142,0)
 ;;=F40.241^^3^24^1
 ;;^UTILITY(U,$J,358.3,142,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,142,1,3,0)
 ;;=3^Acrophobia
 ;;^UTILITY(U,$J,358.3,142,1,4,0)
 ;;=4^F40.241
 ;;^UTILITY(U,$J,358.3,142,2)
 ;;=^5003555
 ;;^UTILITY(U,$J,358.3,143,0)
 ;;=F40.248^^3^24^15
 ;;^UTILITY(U,$J,358.3,143,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,143,1,3,0)
 ;;=3^Situational Type Phobia NEC
 ;;^UTILITY(U,$J,358.3,143,1,4,0)
 ;;=4^F40.248
 ;;^UTILITY(U,$J,358.3,143,2)
 ;;=^5003558
 ;;^UTILITY(U,$J,358.3,144,0)
 ;;=F40.01^^3^24^3
 ;;^UTILITY(U,$J,358.3,144,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,144,1,3,0)
 ;;=3^Agoraphobia w/ Panic Disorder
 ;;^UTILITY(U,$J,358.3,144,1,4,0)
 ;;=4^F40.01
 ;;^UTILITY(U,$J,358.3,144,2)
 ;;=^331911
 ;;^UTILITY(U,$J,358.3,145,0)
 ;;=F06.33^^3^25^1
 ;;^UTILITY(U,$J,358.3,145,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,145,1,3,0)
 ;;=3^Bipolar & Related Disorder d/t Medical Condition w/ Manic Features
 ;;^UTILITY(U,$J,358.3,145,1,4,0)
 ;;=4^F06.33
 ;;^UTILITY(U,$J,358.3,145,2)
 ;;=^5003059
 ;;^UTILITY(U,$J,358.3,146,0)
 ;;=F06.34^^3^25^2
 ;;^UTILITY(U,$J,358.3,146,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,146,1,3,0)
 ;;=3^Bipolar & Related Disorder d/t Medical Condition w/ Mixed Features
 ;;^UTILITY(U,$J,358.3,146,1,4,0)
 ;;=4^F06.34
 ;;^UTILITY(U,$J,358.3,146,2)
 ;;=^5003060
 ;;^UTILITY(U,$J,358.3,147,0)
 ;;=F31.11^^3^25^3
 ;;^UTILITY(U,$J,358.3,147,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,147,1,3,0)
 ;;=3^Bipolar I Disorder,Current/Recent Episode Manic,Mild
 ;;^UTILITY(U,$J,358.3,147,1,4,0)
 ;;=4^F31.11
 ;;^UTILITY(U,$J,358.3,147,2)
 ;;=^5003496
 ;;^UTILITY(U,$J,358.3,148,0)
 ;;=F31.12^^3^25^4
 ;;^UTILITY(U,$J,358.3,148,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,148,1,3,0)
 ;;=3^Bipolar I Disorder,Current/Recent Episode Manic,Moderate
 ;;^UTILITY(U,$J,358.3,148,1,4,0)
 ;;=4^F31.12
 ;;^UTILITY(U,$J,358.3,148,2)
 ;;=^5003497
 ;;^UTILITY(U,$J,358.3,149,0)
 ;;=F31.13^^3^25^5
 ;;^UTILITY(U,$J,358.3,149,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,149,1,3,0)
 ;;=3^Bipolar I Disorder,Current/Recent Episode Manic,Severe
 ;;^UTILITY(U,$J,358.3,149,1,4,0)
 ;;=4^F31.13
 ;;^UTILITY(U,$J,358.3,149,2)
 ;;=^5003498
 ;;^UTILITY(U,$J,358.3,150,0)
 ;;=F31.2^^3^25^6
 ;;^UTILITY(U,$J,358.3,150,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,150,1,3,0)
 ;;=3^Bipolar I Disorder,Current/Recent Episode Manic,w/ Psychotic Features
 ;;^UTILITY(U,$J,358.3,150,1,4,0)
 ;;=4^F31.2
 ;;^UTILITY(U,$J,358.3,150,2)
 ;;=^5003499
 ;;^UTILITY(U,$J,358.3,151,0)
 ;;=F31.73^^3^25^7
 ;;^UTILITY(U,$J,358.3,151,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,151,1,3,0)
 ;;=3^Bipolar I Disorder,Current/Recent Episode Manic,In Partial Remission
