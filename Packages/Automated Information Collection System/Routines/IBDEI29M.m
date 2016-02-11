IBDEI29M ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,38046,0)
 ;;=F40.231^^177^1915^9
 ;;^UTILITY(U,$J,358.3,38046,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38046,1,3,0)
 ;;=3^Fear of Injections & Transfusions
 ;;^UTILITY(U,$J,358.3,38046,1,4,0)
 ;;=4^F40.231
 ;;^UTILITY(U,$J,358.3,38046,2)
 ;;=^5003551
 ;;^UTILITY(U,$J,358.3,38047,0)
 ;;=F40.232^^177^1915^11
 ;;^UTILITY(U,$J,358.3,38047,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38047,1,3,0)
 ;;=3^Fear of Oth Medical Care
 ;;^UTILITY(U,$J,358.3,38047,1,4,0)
 ;;=4^F40.232
 ;;^UTILITY(U,$J,358.3,38047,2)
 ;;=^5003552
 ;;^UTILITY(U,$J,358.3,38048,0)
 ;;=F40.233^^177^1915^10
 ;;^UTILITY(U,$J,358.3,38048,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38048,1,3,0)
 ;;=3^Fear of Injury
 ;;^UTILITY(U,$J,358.3,38048,1,4,0)
 ;;=4^F40.233
 ;;^UTILITY(U,$J,358.3,38048,2)
 ;;=^5003553
 ;;^UTILITY(U,$J,358.3,38049,0)
 ;;=F40.240^^177^1915^7
 ;;^UTILITY(U,$J,358.3,38049,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38049,1,3,0)
 ;;=3^Claustrophobia
 ;;^UTILITY(U,$J,358.3,38049,1,4,0)
 ;;=4^F40.240
 ;;^UTILITY(U,$J,358.3,38049,2)
 ;;=^5003554
 ;;^UTILITY(U,$J,358.3,38050,0)
 ;;=F40.241^^177^1915^1
 ;;^UTILITY(U,$J,358.3,38050,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38050,1,3,0)
 ;;=3^Acrophobia
 ;;^UTILITY(U,$J,358.3,38050,1,4,0)
 ;;=4^F40.241
 ;;^UTILITY(U,$J,358.3,38050,2)
 ;;=^5003555
 ;;^UTILITY(U,$J,358.3,38051,0)
 ;;=F40.248^^177^1915^15
 ;;^UTILITY(U,$J,358.3,38051,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38051,1,3,0)
 ;;=3^Situational Type Phobia NEC
 ;;^UTILITY(U,$J,358.3,38051,1,4,0)
 ;;=4^F40.248
 ;;^UTILITY(U,$J,358.3,38051,2)
 ;;=^5003558
 ;;^UTILITY(U,$J,358.3,38052,0)
 ;;=F40.01^^177^1915^3
 ;;^UTILITY(U,$J,358.3,38052,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38052,1,3,0)
 ;;=3^Agoraphobia w/ Panic Disorder
 ;;^UTILITY(U,$J,358.3,38052,1,4,0)
 ;;=4^F40.01
 ;;^UTILITY(U,$J,358.3,38052,2)
 ;;=^331911
 ;;^UTILITY(U,$J,358.3,38053,0)
 ;;=F06.33^^177^1916^1
 ;;^UTILITY(U,$J,358.3,38053,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38053,1,3,0)
 ;;=3^Bipolar & Related Disorder d/t Medical Condition w/ Manic Features
 ;;^UTILITY(U,$J,358.3,38053,1,4,0)
 ;;=4^F06.33
 ;;^UTILITY(U,$J,358.3,38053,2)
 ;;=^5003059
 ;;^UTILITY(U,$J,358.3,38054,0)
 ;;=F06.34^^177^1916^2
 ;;^UTILITY(U,$J,358.3,38054,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38054,1,3,0)
 ;;=3^Bipolar & Related Disorder d/t Medical Condition w/ Mixed Features
 ;;^UTILITY(U,$J,358.3,38054,1,4,0)
 ;;=4^F06.34
 ;;^UTILITY(U,$J,358.3,38054,2)
 ;;=^5003060
 ;;^UTILITY(U,$J,358.3,38055,0)
 ;;=F31.11^^177^1916^3
 ;;^UTILITY(U,$J,358.3,38055,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38055,1,3,0)
 ;;=3^Bipolar I Disorder,Current/Recent Episode Manic,Mild
 ;;^UTILITY(U,$J,358.3,38055,1,4,0)
 ;;=4^F31.11
 ;;^UTILITY(U,$J,358.3,38055,2)
 ;;=^5003496
 ;;^UTILITY(U,$J,358.3,38056,0)
 ;;=F31.12^^177^1916^4
 ;;^UTILITY(U,$J,358.3,38056,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38056,1,3,0)
 ;;=3^Bipolar I Disorder,Current/Recent Episode Manic,Moderate
 ;;^UTILITY(U,$J,358.3,38056,1,4,0)
 ;;=4^F31.12
 ;;^UTILITY(U,$J,358.3,38056,2)
 ;;=^5003497
 ;;^UTILITY(U,$J,358.3,38057,0)
 ;;=F31.13^^177^1916^5
 ;;^UTILITY(U,$J,358.3,38057,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38057,1,3,0)
 ;;=3^Bipolar I Disorder,Current/Recent Episode Manic,Severe
 ;;^UTILITY(U,$J,358.3,38057,1,4,0)
 ;;=4^F31.13
 ;;^UTILITY(U,$J,358.3,38057,2)
 ;;=^5003498
 ;;^UTILITY(U,$J,358.3,38058,0)
 ;;=F31.2^^177^1916^6
 ;;^UTILITY(U,$J,358.3,38058,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38058,1,3,0)
 ;;=3^Bipolar I Disorder,Current/Recent Episode Manic,w/ Psychotic Features
