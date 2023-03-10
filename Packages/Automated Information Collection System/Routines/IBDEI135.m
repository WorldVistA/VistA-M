IBDEI135 ; ; 01-FEB-2022
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 01, 2022
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,17628,0)
 ;;=F10.139^^61^789^5
 ;;^UTILITY(U,$J,358.3,17628,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17628,1,3,0)
 ;;=3^Alcohol Abuse w/ Withdrawal,Unspec
 ;;^UTILITY(U,$J,358.3,17628,1,4,0)
 ;;=4^F10.139
 ;;^UTILITY(U,$J,358.3,17628,2)
 ;;=^5159133
 ;;^UTILITY(U,$J,358.3,17629,0)
 ;;=F10.930^^61^789^12
 ;;^UTILITY(U,$J,358.3,17629,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17629,1,3,0)
 ;;=3^Alcohol Use,Unspec w/ Withdrawal,Uncomp
 ;;^UTILITY(U,$J,358.3,17629,1,4,0)
 ;;=4^F10.930
 ;;^UTILITY(U,$J,358.3,17629,2)
 ;;=^5159134
 ;;^UTILITY(U,$J,358.3,17630,0)
 ;;=F10.931^^61^789^10
 ;;^UTILITY(U,$J,358.3,17630,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17630,1,3,0)
 ;;=3^Alcohol Use,Unspec w/ Withdrawal Delirium
 ;;^UTILITY(U,$J,358.3,17630,1,4,0)
 ;;=4^F10.931
 ;;^UTILITY(U,$J,358.3,17630,2)
 ;;=^5159135
 ;;^UTILITY(U,$J,358.3,17631,0)
 ;;=F10.932^^61^789^11
 ;;^UTILITY(U,$J,358.3,17631,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17631,1,3,0)
 ;;=3^Alcohol Use,Unspec w/ Withdrawal w/ Perceptual Disturbance
 ;;^UTILITY(U,$J,358.3,17631,1,4,0)
 ;;=4^F10.932
 ;;^UTILITY(U,$J,358.3,17631,2)
 ;;=^5159136
 ;;^UTILITY(U,$J,358.3,17632,0)
 ;;=F10.939^^61^789^13
 ;;^UTILITY(U,$J,358.3,17632,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17632,1,3,0)
 ;;=3^Alcohol Use,Unspec w/ Withdrawal,Unspec
 ;;^UTILITY(U,$J,358.3,17632,1,4,0)
 ;;=4^F10.939
 ;;^UTILITY(U,$J,358.3,17632,2)
 ;;=^5159137
 ;;^UTILITY(U,$J,358.3,17633,0)
 ;;=F12.13^^61^789^14
 ;;^UTILITY(U,$J,358.3,17633,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17633,1,3,0)
 ;;=3^Cannabis Abuse w/ Withdrawal
 ;;^UTILITY(U,$J,358.3,17633,1,4,0)
 ;;=4^F12.13
 ;;^UTILITY(U,$J,358.3,17633,2)
 ;;=^5159139
 ;;^UTILITY(U,$J,358.3,17634,0)
 ;;=F11.13^^61^789^47
 ;;^UTILITY(U,$J,358.3,17634,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17634,1,3,0)
 ;;=3^Opioid Abuse w/ Withdrawal
 ;;^UTILITY(U,$J,358.3,17634,1,4,0)
 ;;=4^F11.13
 ;;^UTILITY(U,$J,358.3,17634,2)
 ;;=^5159138
 ;;^UTILITY(U,$J,358.3,17635,0)
 ;;=I83.019^^61^790^3
 ;;^UTILITY(U,$J,358.3,17635,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17635,1,3,0)
 ;;=3^Varicose Veins Right Lower Extrem w/ Ulcer,Unspec
 ;;^UTILITY(U,$J,358.3,17635,1,4,0)
 ;;=4^I83.019
 ;;^UTILITY(U,$J,358.3,17635,2)
 ;;=^5007979
 ;;^UTILITY(U,$J,358.3,17636,0)
 ;;=I83.219^^61^790^4
 ;;^UTILITY(U,$J,358.3,17636,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17636,1,3,0)
 ;;=3^Varicose Veins Right Lower Extrem w/ Ulcer & Inflam,Unspec
 ;;^UTILITY(U,$J,358.3,17636,1,4,0)
 ;;=4^I83.219
 ;;^UTILITY(U,$J,358.3,17636,2)
 ;;=^5008003
 ;;^UTILITY(U,$J,358.3,17637,0)
 ;;=I83.029^^61^790^1
 ;;^UTILITY(U,$J,358.3,17637,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17637,1,3,0)
 ;;=3^Varicose Veins Left Lower Extrem w/ Ulcer,Unspec
 ;;^UTILITY(U,$J,358.3,17637,1,4,0)
 ;;=4^I83.029
 ;;^UTILITY(U,$J,358.3,17637,2)
 ;;=^5007986
 ;;^UTILITY(U,$J,358.3,17638,0)
 ;;=I83.229^^61^790^2
 ;;^UTILITY(U,$J,358.3,17638,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17638,1,3,0)
 ;;=3^Varicose Veins Left Lower Extrem w/ Ulcer & Inflam,Unspec
 ;;^UTILITY(U,$J,358.3,17638,1,4,0)
 ;;=4^I83.229
 ;;^UTILITY(U,$J,358.3,17638,2)
 ;;=^5008010
 ;;^UTILITY(U,$J,358.3,17639,0)
 ;;=B00.81^^61^791^55
 ;;^UTILITY(U,$J,358.3,17639,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17639,1,3,0)
 ;;=3^Herpesviral Hepatitis
 ;;^UTILITY(U,$J,358.3,17639,1,4,0)
 ;;=4^B00.81
