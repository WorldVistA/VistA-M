IBDEI02A ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,298,1,3,0)
 ;;=3^Malingering
 ;;^UTILITY(U,$J,358.3,298,1,4,0)
 ;;=4^Z76.5
 ;;^UTILITY(U,$J,358.3,298,2)
 ;;=^5063302
 ;;^UTILITY(U,$J,358.3,299,0)
 ;;=R41.83^^3^37^2
 ;;^UTILITY(U,$J,358.3,299,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,299,1,3,0)
 ;;=3^Borderline Intellectual Functioning
 ;;^UTILITY(U,$J,358.3,299,1,4,0)
 ;;=4^R41.83
 ;;^UTILITY(U,$J,358.3,299,2)
 ;;=^5019442
 ;;^UTILITY(U,$J,358.3,300,0)
 ;;=Z56.82^^3^37^4
 ;;^UTILITY(U,$J,358.3,300,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,300,1,3,0)
 ;;=3^Military Deployment Status,Current
 ;;^UTILITY(U,$J,358.3,300,1,4,0)
 ;;=4^Z56.82
 ;;^UTILITY(U,$J,358.3,300,2)
 ;;=^5063115
 ;;^UTILITY(U,$J,358.3,301,0)
 ;;=E66.3^^3^37^7
 ;;^UTILITY(U,$J,358.3,301,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,301,1,3,0)
 ;;=3^Overweight
 ;;^UTILITY(U,$J,358.3,301,1,4,0)
 ;;=4^E66.3
 ;;^UTILITY(U,$J,358.3,301,2)
 ;;=^5002830
 ;;^UTILITY(U,$J,358.3,302,0)
 ;;=F90.0^^3^38^3
 ;;^UTILITY(U,$J,358.3,302,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,302,1,3,0)
 ;;=3^ADHD,Inattentive Type
 ;;^UTILITY(U,$J,358.3,302,1,4,0)
 ;;=4^F90.0
 ;;^UTILITY(U,$J,358.3,302,2)
 ;;=^5003692
 ;;^UTILITY(U,$J,358.3,303,0)
 ;;=F90.2^^3^38^1
 ;;^UTILITY(U,$J,358.3,303,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,303,1,3,0)
 ;;=3^ADHD,Combined Type
 ;;^UTILITY(U,$J,358.3,303,1,4,0)
 ;;=4^F90.2
 ;;^UTILITY(U,$J,358.3,303,2)
 ;;=^5003694
 ;;^UTILITY(U,$J,358.3,304,0)
 ;;=F90.1^^3^38^2
 ;;^UTILITY(U,$J,358.3,304,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,304,1,3,0)
 ;;=3^ADHD,Hyperactive/Impulsive Type
 ;;^UTILITY(U,$J,358.3,304,1,4,0)
 ;;=4^F90.1
 ;;^UTILITY(U,$J,358.3,304,2)
 ;;=^5003693
 ;;^UTILITY(U,$J,358.3,305,0)
 ;;=Z70.9^^3^39^4
 ;;^UTILITY(U,$J,358.3,305,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,305,1,3,0)
 ;;=3^Sex Counseling
 ;;^UTILITY(U,$J,358.3,305,1,4,0)
 ;;=4^Z70.9
 ;;^UTILITY(U,$J,358.3,305,2)
 ;;=^5063241
 ;;^UTILITY(U,$J,358.3,306,0)
 ;;=Z71.9^^3^39^1
 ;;^UTILITY(U,$J,358.3,306,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,306,1,3,0)
 ;;=3^Counseling/Consultation NEC
 ;;^UTILITY(U,$J,358.3,306,1,4,0)
 ;;=4^Z71.9
 ;;^UTILITY(U,$J,358.3,306,2)
 ;;=^5063254
 ;;^UTILITY(U,$J,358.3,307,0)
 ;;=Z51.81^^3^39^5
 ;;^UTILITY(U,$J,358.3,307,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,307,1,3,0)
 ;;=3^Therapeutic Drug Level Monitoring
 ;;^UTILITY(U,$J,358.3,307,1,4,0)
 ;;=4^Z51.81
 ;;^UTILITY(U,$J,358.3,307,2)
 ;;=^5063064
 ;;^UTILITY(U,$J,358.3,308,0)
 ;;=Z69.12^^3^39^2
 ;;^UTILITY(U,$J,358.3,308,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,308,1,3,0)
 ;;=3^Mental Health Svcs for Perpetrator of Spousal/Partner Abuse
 ;;^UTILITY(U,$J,358.3,308,1,4,0)
 ;;=4^Z69.12
 ;;^UTILITY(U,$J,358.3,308,2)
 ;;=^5063233
 ;;^UTILITY(U,$J,358.3,309,0)
 ;;=Z69.11^^3^39^3
 ;;^UTILITY(U,$J,358.3,309,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,309,1,3,0)
 ;;=3^Mental Health Svcs for Victim of Spousal/Partner Abuse
 ;;^UTILITY(U,$J,358.3,309,1,4,0)
 ;;=4^Z69.11
 ;;^UTILITY(U,$J,358.3,309,2)
 ;;=^5063232
 ;;^UTILITY(U,$J,358.3,310,0)
 ;;=Z60.0^^3^40^2
 ;;^UTILITY(U,$J,358.3,310,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,310,1,3,0)
 ;;=3^Phase of Life Problem
 ;;^UTILITY(U,$J,358.3,310,1,4,0)
 ;;=4^Z60.0
 ;;^UTILITY(U,$J,358.3,310,2)
 ;;=^5063139
 ;;^UTILITY(U,$J,358.3,311,0)
 ;;=Z60.2^^3^40^3
 ;;^UTILITY(U,$J,358.3,311,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,311,1,3,0)
 ;;=3^Problem Related to Living Alone
 ;;^UTILITY(U,$J,358.3,311,1,4,0)
 ;;=4^Z60.2
 ;;^UTILITY(U,$J,358.3,311,2)
 ;;=^5063140
 ;;^UTILITY(U,$J,358.3,312,0)
 ;;=Z60.3^^3^40^1
 ;;^UTILITY(U,$J,358.3,312,1,0)
 ;;=^358.31IA^4^2
