IBDEI0LH ; ; 01-FEB-2022
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 01, 2022
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,9664,0)
 ;;=F12.93^^39^415^19
 ;;^UTILITY(U,$J,358.3,9664,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9664,1,3,0)
 ;;=3^Cannabis Use,Unspec w/ Withdrawal
 ;;^UTILITY(U,$J,358.3,9664,1,4,0)
 ;;=4^F12.93
 ;;^UTILITY(U,$J,358.3,9664,2)
 ;;=^5157302
 ;;^UTILITY(U,$J,358.3,9665,0)
 ;;=F10.130^^39^415^4
 ;;^UTILITY(U,$J,358.3,9665,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9665,1,3,0)
 ;;=3^Alcohol Abuse w/ Withdrawal,Uncomp
 ;;^UTILITY(U,$J,358.3,9665,1,4,0)
 ;;=4^F10.130
 ;;^UTILITY(U,$J,358.3,9665,2)
 ;;=^5159130
 ;;^UTILITY(U,$J,358.3,9666,0)
 ;;=F10.131^^39^415^2
 ;;^UTILITY(U,$J,358.3,9666,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9666,1,3,0)
 ;;=3^Alcohol Abuse w/ Withdrawal Delirium
 ;;^UTILITY(U,$J,358.3,9666,1,4,0)
 ;;=4^F10.131
 ;;^UTILITY(U,$J,358.3,9666,2)
 ;;=^5159131
 ;;^UTILITY(U,$J,358.3,9667,0)
 ;;=F10.132^^39^415^3
 ;;^UTILITY(U,$J,358.3,9667,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9667,1,3,0)
 ;;=3^Alcohol Abuse w/ Withdrawal w/ Perceptual Disturbance
 ;;^UTILITY(U,$J,358.3,9667,1,4,0)
 ;;=4^F10.132
 ;;^UTILITY(U,$J,358.3,9667,2)
 ;;=^5159132
 ;;^UTILITY(U,$J,358.3,9668,0)
 ;;=F10.139^^39^415^5
 ;;^UTILITY(U,$J,358.3,9668,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9668,1,3,0)
 ;;=3^Alcohol Abuse w/ Withdrawal,Unspec
 ;;^UTILITY(U,$J,358.3,9668,1,4,0)
 ;;=4^F10.139
 ;;^UTILITY(U,$J,358.3,9668,2)
 ;;=^5159133
 ;;^UTILITY(U,$J,358.3,9669,0)
 ;;=F10.930^^39^415^12
 ;;^UTILITY(U,$J,358.3,9669,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9669,1,3,0)
 ;;=3^Alcohol Use,Unspec w/ Withdrawal,Uncomp
 ;;^UTILITY(U,$J,358.3,9669,1,4,0)
 ;;=4^F10.930
 ;;^UTILITY(U,$J,358.3,9669,2)
 ;;=^5159134
 ;;^UTILITY(U,$J,358.3,9670,0)
 ;;=F10.931^^39^415^10
 ;;^UTILITY(U,$J,358.3,9670,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9670,1,3,0)
 ;;=3^Alcohol Use,Unspec w/ Withdrawal Delirium
 ;;^UTILITY(U,$J,358.3,9670,1,4,0)
 ;;=4^F10.931
 ;;^UTILITY(U,$J,358.3,9670,2)
 ;;=^5159135
 ;;^UTILITY(U,$J,358.3,9671,0)
 ;;=F10.932^^39^415^11
 ;;^UTILITY(U,$J,358.3,9671,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9671,1,3,0)
 ;;=3^Alcohol Use,Unspec w/ Withdrawal w/ Perceptual Disturbance
 ;;^UTILITY(U,$J,358.3,9671,1,4,0)
 ;;=4^F10.932
 ;;^UTILITY(U,$J,358.3,9671,2)
 ;;=^5159136
 ;;^UTILITY(U,$J,358.3,9672,0)
 ;;=F10.939^^39^415^13
 ;;^UTILITY(U,$J,358.3,9672,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9672,1,3,0)
 ;;=3^Alcohol Use,Unspec w/ Withdrawal,Unspec
 ;;^UTILITY(U,$J,358.3,9672,1,4,0)
 ;;=4^F10.939
 ;;^UTILITY(U,$J,358.3,9672,2)
 ;;=^5159137
 ;;^UTILITY(U,$J,358.3,9673,0)
 ;;=F12.13^^39^415^14
 ;;^UTILITY(U,$J,358.3,9673,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9673,1,3,0)
 ;;=3^Cannabis Abuse w/ Withdrawal
 ;;^UTILITY(U,$J,358.3,9673,1,4,0)
 ;;=4^F12.13
 ;;^UTILITY(U,$J,358.3,9673,2)
 ;;=^5159139
 ;;^UTILITY(U,$J,358.3,9674,0)
 ;;=F11.13^^39^415^47
 ;;^UTILITY(U,$J,358.3,9674,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9674,1,3,0)
 ;;=3^Opioid Abuse w/ Withdrawal
 ;;^UTILITY(U,$J,358.3,9674,1,4,0)
 ;;=4^F11.13
 ;;^UTILITY(U,$J,358.3,9674,2)
 ;;=^5159138
 ;;^UTILITY(U,$J,358.3,9675,0)
 ;;=I83.019^^39^416^3
 ;;^UTILITY(U,$J,358.3,9675,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9675,1,3,0)
 ;;=3^Varicose Veins Right Lower Extrem w/ Ulcer,Unspec
 ;;^UTILITY(U,$J,358.3,9675,1,4,0)
 ;;=4^I83.019
 ;;^UTILITY(U,$J,358.3,9675,2)
 ;;=^5007979
 ;;^UTILITY(U,$J,358.3,9676,0)
 ;;=I83.219^^39^416^4
