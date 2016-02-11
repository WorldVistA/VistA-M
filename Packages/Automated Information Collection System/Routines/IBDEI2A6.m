IBDEI2A6 ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,38301,1,3,0)
 ;;=3^Alcohol Use Disorder,Moderate-Severe w/ Withdrawal
 ;;^UTILITY(U,$J,358.3,38301,1,4,0)
 ;;=4^F10.230
 ;;^UTILITY(U,$J,358.3,38301,2)
 ;;=^5003086
 ;;^UTILITY(U,$J,358.3,38302,0)
 ;;=F10.231^^177^1940^5
 ;;^UTILITY(U,$J,358.3,38302,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38302,1,3,0)
 ;;=3^Alcohol Use Disorder,Moderate-Severe w/ Withdrawal Delirium
 ;;^UTILITY(U,$J,358.3,38302,1,4,0)
 ;;=4^F10.231
 ;;^UTILITY(U,$J,358.3,38302,2)
 ;;=^5003087
 ;;^UTILITY(U,$J,358.3,38303,0)
 ;;=F10.232^^177^1940^6
 ;;^UTILITY(U,$J,358.3,38303,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38303,1,3,0)
 ;;=3^Alcohol Use Disorder,Moderate-Severe w/ Withdrawal Perceptual Disturbances
 ;;^UTILITY(U,$J,358.3,38303,1,4,0)
 ;;=4^F10.232
 ;;^UTILITY(U,$J,358.3,38303,2)
 ;;=^5003088
 ;;^UTILITY(U,$J,358.3,38304,0)
 ;;=F10.239^^177^1940^7
 ;;^UTILITY(U,$J,358.3,38304,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38304,1,3,0)
 ;;=3^Alcohol Withdrawal w/o Perceptual Disturbances
 ;;^UTILITY(U,$J,358.3,38304,1,4,0)
 ;;=4^F10.239
 ;;^UTILITY(U,$J,358.3,38304,2)
 ;;=^5003089
 ;;^UTILITY(U,$J,358.3,38305,0)
 ;;=F10.24^^177^1940^9
 ;;^UTILITY(U,$J,358.3,38305,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38305,1,3,0)
 ;;=3^Alcohol-Induced Depressive & Related Disorder w/ Moderate-Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,38305,1,4,0)
 ;;=4^F10.24
 ;;^UTILITY(U,$J,358.3,38305,2)
 ;;=^5003090
 ;;^UTILITY(U,$J,358.3,38306,0)
 ;;=F10.29^^177^1940^11
 ;;^UTILITY(U,$J,358.3,38306,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38306,1,3,0)
 ;;=3^Alcohol-Related Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,38306,1,4,0)
 ;;=4^F10.29
 ;;^UTILITY(U,$J,358.3,38306,2)
 ;;=^5003100
 ;;^UTILITY(U,$J,358.3,38307,0)
 ;;=F15.10^^177^1941^4
 ;;^UTILITY(U,$J,358.3,38307,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38307,1,3,0)
 ;;=3^Amphetamine-Type Disorder,Mild
 ;;^UTILITY(U,$J,358.3,38307,1,4,0)
 ;;=4^F15.10
 ;;^UTILITY(U,$J,358.3,38307,2)
 ;;=^5003282
 ;;^UTILITY(U,$J,358.3,38308,0)
 ;;=F15.14^^177^1941^2
 ;;^UTILITY(U,$J,358.3,38308,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38308,1,3,0)
 ;;=3^Amphetamine-Induced Depressive,Bipolar & Related Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,38308,1,4,0)
 ;;=4^F15.14
 ;;^UTILITY(U,$J,358.3,38308,2)
 ;;=^5003287
 ;;^UTILITY(U,$J,358.3,38309,0)
 ;;=F15.182^^177^1941^3
 ;;^UTILITY(U,$J,358.3,38309,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38309,1,3,0)
 ;;=3^Amphetamine-Induced Sleep Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,38309,1,4,0)
 ;;=4^F15.182
 ;;^UTILITY(U,$J,358.3,38309,2)
 ;;=^5003293
 ;;^UTILITY(U,$J,358.3,38310,0)
 ;;=F15.20^^177^1941^5
 ;;^UTILITY(U,$J,358.3,38310,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38310,1,3,0)
 ;;=3^Amphetamine-Type Disorder,Moderate-Severe
 ;;^UTILITY(U,$J,358.3,38310,1,4,0)
 ;;=4^F15.20
 ;;^UTILITY(U,$J,358.3,38310,2)
 ;;=^5003295
 ;;^UTILITY(U,$J,358.3,38311,0)
 ;;=F15.21^^177^1941^6
 ;;^UTILITY(U,$J,358.3,38311,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38311,1,3,0)
 ;;=3^Amphetamine-Type Disorder,Moderate-Severe In Remission
 ;;^UTILITY(U,$J,358.3,38311,1,4,0)
 ;;=4^F15.21
 ;;^UTILITY(U,$J,358.3,38311,2)
 ;;=^5003296
 ;;^UTILITY(U,$J,358.3,38312,0)
 ;;=F15.23^^177^1941^1
 ;;^UTILITY(U,$J,358.3,38312,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38312,1,3,0)
 ;;=3^Amphetamine or Other Stimulant Withdrawal
 ;;^UTILITY(U,$J,358.3,38312,1,4,0)
 ;;=4^F15.23
 ;;^UTILITY(U,$J,358.3,38312,2)
 ;;=^5003301
 ;;^UTILITY(U,$J,358.3,38313,0)
 ;;=F12.10^^177^1942^1
 ;;^UTILITY(U,$J,358.3,38313,1,0)
 ;;=^358.31IA^4^2
