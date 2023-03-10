IBDEI0ND ; ; 01-FEB-2022
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 01, 2022
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,10524,1,4,0)
 ;;=4^Z69.12
 ;;^UTILITY(U,$J,358.3,10524,2)
 ;;=^5063233
 ;;^UTILITY(U,$J,358.3,10525,0)
 ;;=Z69.11^^42^469^32
 ;;^UTILITY(U,$J,358.3,10525,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10525,1,3,0)
 ;;=3^MH Svc for Victim of Spousal/Partner Psychological Abuse
 ;;^UTILITY(U,$J,358.3,10525,1,4,0)
 ;;=4^Z69.11
 ;;^UTILITY(U,$J,358.3,10525,2)
 ;;=^5063232
 ;;^UTILITY(U,$J,358.3,10526,0)
 ;;=Z69.11^^42^469^33
 ;;^UTILITY(U,$J,358.3,10526,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10526,1,3,0)
 ;;=3^MH Svc for Victim of Spousal/Partner Violence,Physical
 ;;^UTILITY(U,$J,358.3,10526,1,4,0)
 ;;=4^Z69.11
 ;;^UTILITY(U,$J,358.3,10526,2)
 ;;=^5063232
 ;;^UTILITY(U,$J,358.3,10527,0)
 ;;=Z69.11^^42^469^34
 ;;^UTILITY(U,$J,358.3,10527,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10527,1,3,0)
 ;;=3^MH Svc for Victim of Spousal/Partner Violence,Sexual
 ;;^UTILITY(U,$J,358.3,10527,1,4,0)
 ;;=4^Z69.11
 ;;^UTILITY(U,$J,358.3,10527,2)
 ;;=^5063232
 ;;^UTILITY(U,$J,358.3,10528,0)
 ;;=Z62.812^^42^469^36
 ;;^UTILITY(U,$J,358.3,10528,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10528,1,3,0)
 ;;=3^Personal Past Hx of Childhood Neglect
 ;;^UTILITY(U,$J,358.3,10528,1,4,0)
 ;;=4^Z62.812
 ;;^UTILITY(U,$J,358.3,10528,2)
 ;;=^5063155
 ;;^UTILITY(U,$J,358.3,10529,0)
 ;;=Z62.810^^42^469^37
 ;;^UTILITY(U,$J,358.3,10529,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10529,1,3,0)
 ;;=3^Personal Past Hx of Childhood Physical Abuse
 ;;^UTILITY(U,$J,358.3,10529,1,4,0)
 ;;=4^Z62.810
 ;;^UTILITY(U,$J,358.3,10529,2)
 ;;=^5063153
 ;;^UTILITY(U,$J,358.3,10530,0)
 ;;=Z62.810^^42^469^39
 ;;^UTILITY(U,$J,358.3,10530,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10530,1,3,0)
 ;;=3^Personal Past Hx of Childhood Sexual Abuse
 ;;^UTILITY(U,$J,358.3,10530,1,4,0)
 ;;=4^Z62.810
 ;;^UTILITY(U,$J,358.3,10530,2)
 ;;=^5063153
 ;;^UTILITY(U,$J,358.3,10531,0)
 ;;=Z62.811^^42^469^38
 ;;^UTILITY(U,$J,358.3,10531,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10531,1,3,0)
 ;;=3^Personal Past Hx of Childhood Psychological Abuse
 ;;^UTILITY(U,$J,358.3,10531,1,4,0)
 ;;=4^Z62.811
 ;;^UTILITY(U,$J,358.3,10531,2)
 ;;=^5063154
 ;;^UTILITY(U,$J,358.3,10532,0)
 ;;=Z91.410^^42^469^42
 ;;^UTILITY(U,$J,358.3,10532,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10532,1,3,0)
 ;;=3^Personal Past Hx of Spouse or Partner Violence,Sexual
 ;;^UTILITY(U,$J,358.3,10532,1,4,0)
 ;;=4^Z91.410
 ;;^UTILITY(U,$J,358.3,10532,2)
 ;;=^5063619
 ;;^UTILITY(U,$J,358.3,10533,0)
 ;;=F06.4^^42^470^3
 ;;^UTILITY(U,$J,358.3,10533,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10533,1,3,0)
 ;;=3^Anxiety Disorder d/t Another Medical Condition
 ;;^UTILITY(U,$J,358.3,10533,1,4,0)
 ;;=4^F06.4
 ;;^UTILITY(U,$J,358.3,10533,2)
 ;;=^5003061
 ;;^UTILITY(U,$J,358.3,10534,0)
 ;;=F41.0^^42^470^12
 ;;^UTILITY(U,$J,358.3,10534,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10534,1,3,0)
 ;;=3^Panic Disorder
 ;;^UTILITY(U,$J,358.3,10534,1,4,0)
 ;;=4^F41.0
 ;;^UTILITY(U,$J,358.3,10534,2)
 ;;=^5003564
 ;;^UTILITY(U,$J,358.3,10535,0)
 ;;=F41.1^^42^470^10
 ;;^UTILITY(U,$J,358.3,10535,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10535,1,3,0)
 ;;=3^Generalized Anxiety Disorder
 ;;^UTILITY(U,$J,358.3,10535,1,4,0)
 ;;=4^F41.1
 ;;^UTILITY(U,$J,358.3,10535,2)
 ;;=^50059
 ;;^UTILITY(U,$J,358.3,10536,0)
 ;;=F40.10^^42^470^17
 ;;^UTILITY(U,$J,358.3,10536,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10536,1,3,0)
 ;;=3^Social Anxiety Disorder (Social Phobia)
