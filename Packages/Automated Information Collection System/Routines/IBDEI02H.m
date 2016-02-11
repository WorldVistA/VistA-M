IBDEI02H ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,393,2)
 ;;=^5003086
 ;;^UTILITY(U,$J,358.3,394,0)
 ;;=F10.231^^3^49^5
 ;;^UTILITY(U,$J,358.3,394,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,394,1,3,0)
 ;;=3^Alcohol Use Disorder,Moderate-Severe w/ Withdrawal Delirium
 ;;^UTILITY(U,$J,358.3,394,1,4,0)
 ;;=4^F10.231
 ;;^UTILITY(U,$J,358.3,394,2)
 ;;=^5003087
 ;;^UTILITY(U,$J,358.3,395,0)
 ;;=F10.232^^3^49^6
 ;;^UTILITY(U,$J,358.3,395,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,395,1,3,0)
 ;;=3^Alcohol Use Disorder,Moderate-Severe w/ Withdrawal Perceptual Disturbances
 ;;^UTILITY(U,$J,358.3,395,1,4,0)
 ;;=4^F10.232
 ;;^UTILITY(U,$J,358.3,395,2)
 ;;=^5003088
 ;;^UTILITY(U,$J,358.3,396,0)
 ;;=F10.239^^3^49^7
 ;;^UTILITY(U,$J,358.3,396,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,396,1,3,0)
 ;;=3^Alcohol Withdrawal w/o Perceptual Disturbances
 ;;^UTILITY(U,$J,358.3,396,1,4,0)
 ;;=4^F10.239
 ;;^UTILITY(U,$J,358.3,396,2)
 ;;=^5003089
 ;;^UTILITY(U,$J,358.3,397,0)
 ;;=F10.24^^3^49^9
 ;;^UTILITY(U,$J,358.3,397,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,397,1,3,0)
 ;;=3^Alcohol-Induced Depressive & Related Disorder w/ Moderate-Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,397,1,4,0)
 ;;=4^F10.24
 ;;^UTILITY(U,$J,358.3,397,2)
 ;;=^5003090
 ;;^UTILITY(U,$J,358.3,398,0)
 ;;=F10.29^^3^49^11
 ;;^UTILITY(U,$J,358.3,398,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,398,1,3,0)
 ;;=3^Alcohol-Related Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,398,1,4,0)
 ;;=4^F10.29
 ;;^UTILITY(U,$J,358.3,398,2)
 ;;=^5003100
 ;;^UTILITY(U,$J,358.3,399,0)
 ;;=F15.10^^3^50^4
 ;;^UTILITY(U,$J,358.3,399,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,399,1,3,0)
 ;;=3^Amphetamine-Type Disorder,Mild
 ;;^UTILITY(U,$J,358.3,399,1,4,0)
 ;;=4^F15.10
 ;;^UTILITY(U,$J,358.3,399,2)
 ;;=^5003282
 ;;^UTILITY(U,$J,358.3,400,0)
 ;;=F15.14^^3^50^2
 ;;^UTILITY(U,$J,358.3,400,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,400,1,3,0)
 ;;=3^Amphetamine-Induced Depressive,Bipolar & Related Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,400,1,4,0)
 ;;=4^F15.14
 ;;^UTILITY(U,$J,358.3,400,2)
 ;;=^5003287
 ;;^UTILITY(U,$J,358.3,401,0)
 ;;=F15.182^^3^50^3
 ;;^UTILITY(U,$J,358.3,401,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,401,1,3,0)
 ;;=3^Amphetamine-Induced Sleep Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,401,1,4,0)
 ;;=4^F15.182
 ;;^UTILITY(U,$J,358.3,401,2)
 ;;=^5003293
 ;;^UTILITY(U,$J,358.3,402,0)
 ;;=F15.20^^3^50^5
 ;;^UTILITY(U,$J,358.3,402,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,402,1,3,0)
 ;;=3^Amphetamine-Type Disorder,Moderate-Severe
 ;;^UTILITY(U,$J,358.3,402,1,4,0)
 ;;=4^F15.20
 ;;^UTILITY(U,$J,358.3,402,2)
 ;;=^5003295
 ;;^UTILITY(U,$J,358.3,403,0)
 ;;=F15.21^^3^50^6
 ;;^UTILITY(U,$J,358.3,403,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,403,1,3,0)
 ;;=3^Amphetamine-Type Disorder,Moderate-Severe In Remission
 ;;^UTILITY(U,$J,358.3,403,1,4,0)
 ;;=4^F15.21
 ;;^UTILITY(U,$J,358.3,403,2)
 ;;=^5003296
 ;;^UTILITY(U,$J,358.3,404,0)
 ;;=F15.23^^3^50^1
 ;;^UTILITY(U,$J,358.3,404,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,404,1,3,0)
 ;;=3^Amphetamine or Other Stimulant Withdrawal
 ;;^UTILITY(U,$J,358.3,404,1,4,0)
 ;;=4^F15.23
 ;;^UTILITY(U,$J,358.3,404,2)
 ;;=^5003301
 ;;^UTILITY(U,$J,358.3,405,0)
 ;;=F12.10^^3^51^1
 ;;^UTILITY(U,$J,358.3,405,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,405,1,3,0)
 ;;=3^Cannabis Use Disorder,Mild
 ;;^UTILITY(U,$J,358.3,405,1,4,0)
 ;;=4^F12.10
 ;;^UTILITY(U,$J,358.3,405,2)
 ;;=^5003155
 ;;^UTILITY(U,$J,358.3,406,0)
 ;;=F12.180^^3^51^2
 ;;^UTILITY(U,$J,358.3,406,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,406,1,3,0)
 ;;=3^Cannabis-Induced Anxiety Disorder w/ Mild Use Disorders
