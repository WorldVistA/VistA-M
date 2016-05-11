IBDEI01R ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,327,1,4,0)
 ;;=4^Z56.82
 ;;^UTILITY(U,$J,358.3,327,2)
 ;;=^5063115
 ;;^UTILITY(U,$J,358.3,328,0)
 ;;=E66.3^^3^37^7
 ;;^UTILITY(U,$J,358.3,328,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,328,1,3,0)
 ;;=3^Overweight
 ;;^UTILITY(U,$J,358.3,328,1,4,0)
 ;;=4^E66.3
 ;;^UTILITY(U,$J,358.3,328,2)
 ;;=^5002830
 ;;^UTILITY(U,$J,358.3,329,0)
 ;;=Z62.811^^3^37^10
 ;;^UTILITY(U,$J,358.3,329,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,329,1,3,0)
 ;;=3^Personal Hx of Childhood Psychological Abuse
 ;;^UTILITY(U,$J,358.3,329,1,4,0)
 ;;=4^Z62.811
 ;;^UTILITY(U,$J,358.3,329,2)
 ;;=^5063154
 ;;^UTILITY(U,$J,358.3,330,0)
 ;;=Z62.812^^3^37^8
 ;;^UTILITY(U,$J,358.3,330,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,330,1,3,0)
 ;;=3^Personal Hx of Childhood Neglect
 ;;^UTILITY(U,$J,358.3,330,1,4,0)
 ;;=4^Z62.812
 ;;^UTILITY(U,$J,358.3,330,2)
 ;;=^5063155
 ;;^UTILITY(U,$J,358.3,331,0)
 ;;=Z62.810^^3^37^9
 ;;^UTILITY(U,$J,358.3,331,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,331,1,3,0)
 ;;=3^Personal Hx of Childhood Physical/Sexual Abuse
 ;;^UTILITY(U,$J,358.3,331,1,4,0)
 ;;=4^Z62.810
 ;;^UTILITY(U,$J,358.3,331,2)
 ;;=^5063153
 ;;^UTILITY(U,$J,358.3,332,0)
 ;;=Z91.83^^3^37^16
 ;;^UTILITY(U,$J,358.3,332,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,332,1,3,0)
 ;;=3^Wandering Associated w/ a Mental Disorder
 ;;^UTILITY(U,$J,358.3,332,1,4,0)
 ;;=4^Z91.83
 ;;^UTILITY(U,$J,358.3,332,2)
 ;;=^5063627
 ;;^UTILITY(U,$J,358.3,333,0)
 ;;=F90.0^^3^38^3
 ;;^UTILITY(U,$J,358.3,333,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,333,1,3,0)
 ;;=3^ADHD,Inattentive Type
 ;;^UTILITY(U,$J,358.3,333,1,4,0)
 ;;=4^F90.0
 ;;^UTILITY(U,$J,358.3,333,2)
 ;;=^5003692
 ;;^UTILITY(U,$J,358.3,334,0)
 ;;=F90.2^^3^38^1
 ;;^UTILITY(U,$J,358.3,334,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,334,1,3,0)
 ;;=3^ADHD,Combined Type
 ;;^UTILITY(U,$J,358.3,334,1,4,0)
 ;;=4^F90.2
 ;;^UTILITY(U,$J,358.3,334,2)
 ;;=^5003694
 ;;^UTILITY(U,$J,358.3,335,0)
 ;;=F90.1^^3^38^2
 ;;^UTILITY(U,$J,358.3,335,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,335,1,3,0)
 ;;=3^ADHD,Hyperactive/Impulsive Type
 ;;^UTILITY(U,$J,358.3,335,1,4,0)
 ;;=4^F90.1
 ;;^UTILITY(U,$J,358.3,335,2)
 ;;=^5003693
 ;;^UTILITY(U,$J,358.3,336,0)
 ;;=F90.8^^3^38^4
 ;;^UTILITY(U,$J,358.3,336,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,336,1,3,0)
 ;;=3^ADHD,Other Specified
 ;;^UTILITY(U,$J,358.3,336,1,4,0)
 ;;=4^F90.8
 ;;^UTILITY(U,$J,358.3,336,2)
 ;;=^5003695
 ;;^UTILITY(U,$J,358.3,337,0)
 ;;=F90.9^^3^38^5
 ;;^UTILITY(U,$J,358.3,337,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,337,1,3,0)
 ;;=3^ADHD,Unspec
 ;;^UTILITY(U,$J,358.3,337,1,4,0)
 ;;=4^F90.9
 ;;^UTILITY(U,$J,358.3,337,2)
 ;;=^5003696
 ;;^UTILITY(U,$J,358.3,338,0)
 ;;=Z70.9^^3^39^4
 ;;^UTILITY(U,$J,358.3,338,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,338,1,3,0)
 ;;=3^Sex Counseling
 ;;^UTILITY(U,$J,358.3,338,1,4,0)
 ;;=4^Z70.9
 ;;^UTILITY(U,$J,358.3,338,2)
 ;;=^5063241
 ;;^UTILITY(U,$J,358.3,339,0)
 ;;=Z71.9^^3^39^1
 ;;^UTILITY(U,$J,358.3,339,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,339,1,3,0)
 ;;=3^Counseling/Consultation NEC
 ;;^UTILITY(U,$J,358.3,339,1,4,0)
 ;;=4^Z71.9
 ;;^UTILITY(U,$J,358.3,339,2)
 ;;=^5063254
 ;;^UTILITY(U,$J,358.3,340,0)
 ;;=Z51.81^^3^39^5
 ;;^UTILITY(U,$J,358.3,340,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,340,1,3,0)
 ;;=3^Therapeutic Drug Level Monitoring
 ;;^UTILITY(U,$J,358.3,340,1,4,0)
 ;;=4^Z51.81
 ;;^UTILITY(U,$J,358.3,340,2)
 ;;=^5063064
 ;;^UTILITY(U,$J,358.3,341,0)
 ;;=Z69.12^^3^39^2
 ;;^UTILITY(U,$J,358.3,341,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,341,1,3,0)
 ;;=3^Mental Health Svcs for Perpetrator of Spousal/Partner Abuse
