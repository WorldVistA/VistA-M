IBDEI1WA ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,31734,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31734,1,3,0)
 ;;=3^Alcohol Use Disorder,Moderate-Severe w/ Withdrawal Delirium
 ;;^UTILITY(U,$J,358.3,31734,1,4,0)
 ;;=4^F10.231
 ;;^UTILITY(U,$J,358.3,31734,2)
 ;;=^5003087
 ;;^UTILITY(U,$J,358.3,31735,0)
 ;;=F10.232^^138^1451^6
 ;;^UTILITY(U,$J,358.3,31735,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31735,1,3,0)
 ;;=3^Alcohol Use Disorder,Moderate-Severe w/ Withdrawal Perceptual Disturbances
 ;;^UTILITY(U,$J,358.3,31735,1,4,0)
 ;;=4^F10.232
 ;;^UTILITY(U,$J,358.3,31735,2)
 ;;=^5003088
 ;;^UTILITY(U,$J,358.3,31736,0)
 ;;=F10.239^^138^1451^7
 ;;^UTILITY(U,$J,358.3,31736,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31736,1,3,0)
 ;;=3^Alcohol Withdrawal w/o Perceptual Disturbances
 ;;^UTILITY(U,$J,358.3,31736,1,4,0)
 ;;=4^F10.239
 ;;^UTILITY(U,$J,358.3,31736,2)
 ;;=^5003089
 ;;^UTILITY(U,$J,358.3,31737,0)
 ;;=F10.24^^138^1451^9
 ;;^UTILITY(U,$J,358.3,31737,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31737,1,3,0)
 ;;=3^Alcohol-Induced Depressive & Related Disorder w/ Moderate-Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,31737,1,4,0)
 ;;=4^F10.24
 ;;^UTILITY(U,$J,358.3,31737,2)
 ;;=^5003090
 ;;^UTILITY(U,$J,358.3,31738,0)
 ;;=F10.29^^138^1451^11
 ;;^UTILITY(U,$J,358.3,31738,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31738,1,3,0)
 ;;=3^Alcohol-Related Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,31738,1,4,0)
 ;;=4^F10.29
 ;;^UTILITY(U,$J,358.3,31738,2)
 ;;=^5003100
 ;;^UTILITY(U,$J,358.3,31739,0)
 ;;=F15.10^^138^1452^4
 ;;^UTILITY(U,$J,358.3,31739,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31739,1,3,0)
 ;;=3^Amphetamine-Type Disorder,Mild
 ;;^UTILITY(U,$J,358.3,31739,1,4,0)
 ;;=4^F15.10
 ;;^UTILITY(U,$J,358.3,31739,2)
 ;;=^5003282
 ;;^UTILITY(U,$J,358.3,31740,0)
 ;;=F15.14^^138^1452^2
 ;;^UTILITY(U,$J,358.3,31740,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31740,1,3,0)
 ;;=3^Amphetamine-Induced Depressive,Bipolar & Related Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,31740,1,4,0)
 ;;=4^F15.14
 ;;^UTILITY(U,$J,358.3,31740,2)
 ;;=^5003287
 ;;^UTILITY(U,$J,358.3,31741,0)
 ;;=F15.182^^138^1452^3
 ;;^UTILITY(U,$J,358.3,31741,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31741,1,3,0)
 ;;=3^Amphetamine-Induced Sleep Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,31741,1,4,0)
 ;;=4^F15.182
 ;;^UTILITY(U,$J,358.3,31741,2)
 ;;=^5003293
 ;;^UTILITY(U,$J,358.3,31742,0)
 ;;=F15.20^^138^1452^5
 ;;^UTILITY(U,$J,358.3,31742,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31742,1,3,0)
 ;;=3^Amphetamine-Type Disorder,Moderate-Severe
 ;;^UTILITY(U,$J,358.3,31742,1,4,0)
 ;;=4^F15.20
 ;;^UTILITY(U,$J,358.3,31742,2)
 ;;=^5003295
 ;;^UTILITY(U,$J,358.3,31743,0)
 ;;=F15.21^^138^1452^6
 ;;^UTILITY(U,$J,358.3,31743,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31743,1,3,0)
 ;;=3^Amphetamine-Type Disorder,Moderate-Severe In Remission
 ;;^UTILITY(U,$J,358.3,31743,1,4,0)
 ;;=4^F15.21
 ;;^UTILITY(U,$J,358.3,31743,2)
 ;;=^5003296
 ;;^UTILITY(U,$J,358.3,31744,0)
 ;;=F15.23^^138^1452^1
 ;;^UTILITY(U,$J,358.3,31744,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31744,1,3,0)
 ;;=3^Amphetamine or Other Stimulant Withdrawal
 ;;^UTILITY(U,$J,358.3,31744,1,4,0)
 ;;=4^F15.23
 ;;^UTILITY(U,$J,358.3,31744,2)
 ;;=^5003301
 ;;^UTILITY(U,$J,358.3,31745,0)
 ;;=F12.10^^138^1453^1
 ;;^UTILITY(U,$J,358.3,31745,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31745,1,3,0)
 ;;=3^Cannabis Use Disorder,Mild
 ;;^UTILITY(U,$J,358.3,31745,1,4,0)
 ;;=4^F12.10
 ;;^UTILITY(U,$J,358.3,31745,2)
 ;;=^5003155
 ;;^UTILITY(U,$J,358.3,31746,0)
 ;;=F12.180^^138^1453^2
 ;;^UTILITY(U,$J,358.3,31746,1,0)
 ;;=^358.31IA^4^2
