IBDEI1T7 ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,30741,1,4,0)
 ;;=4^F31.4
 ;;^UTILITY(U,$J,358.3,30741,2)
 ;;=^5003503
 ;;^UTILITY(U,$J,358.3,30742,0)
 ;;=F31.5^^123^1531^16
 ;;^UTILITY(U,$J,358.3,30742,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30742,1,3,0)
 ;;=3^Bipolar I Disorder,Current/Recent Episode Depressed,w/ Psychotic Features
 ;;^UTILITY(U,$J,358.3,30742,1,4,0)
 ;;=4^F31.5
 ;;^UTILITY(U,$J,358.3,30742,2)
 ;;=^5003504
 ;;^UTILITY(U,$J,358.3,30743,0)
 ;;=F31.75^^123^1531^17
 ;;^UTILITY(U,$J,358.3,30743,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30743,1,3,0)
 ;;=3^Bipolar I Disorder,Current/Recent Episode Depressed,In Partial Remission
 ;;^UTILITY(U,$J,358.3,30743,1,4,0)
 ;;=4^F31.75
 ;;^UTILITY(U,$J,358.3,30743,2)
 ;;=^5003515
 ;;^UTILITY(U,$J,358.3,30744,0)
 ;;=F31.76^^123^1531^18
 ;;^UTILITY(U,$J,358.3,30744,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30744,1,3,0)
 ;;=3^Bipolar I Disorder,Current/Recent Episode Depressed,In Full Remission
 ;;^UTILITY(U,$J,358.3,30744,1,4,0)
 ;;=4^F31.76
 ;;^UTILITY(U,$J,358.3,30744,2)
 ;;=^5003516
 ;;^UTILITY(U,$J,358.3,30745,0)
 ;;=F31.9^^123^1531^19
 ;;^UTILITY(U,$J,358.3,30745,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30745,1,3,0)
 ;;=3^Bipolar I Disorder,Current/Recent Episode Unspec
 ;;^UTILITY(U,$J,358.3,30745,1,4,0)
 ;;=4^F31.9
 ;;^UTILITY(U,$J,358.3,30745,2)
 ;;=^331892
 ;;^UTILITY(U,$J,358.3,30746,0)
 ;;=F31.81^^123^1531^20
 ;;^UTILITY(U,$J,358.3,30746,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30746,1,3,0)
 ;;=3^Bipolar II Disorder
 ;;^UTILITY(U,$J,358.3,30746,1,4,0)
 ;;=4^F31.81
 ;;^UTILITY(U,$J,358.3,30746,2)
 ;;=^5003519
 ;;^UTILITY(U,$J,358.3,30747,0)
 ;;=F34.0^^123^1531^22
 ;;^UTILITY(U,$J,358.3,30747,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30747,1,3,0)
 ;;=3^Cyclothymic Disorder
 ;;^UTILITY(U,$J,358.3,30747,1,4,0)
 ;;=4^F34.0
 ;;^UTILITY(U,$J,358.3,30747,2)
 ;;=^5003538
 ;;^UTILITY(U,$J,358.3,30748,0)
 ;;=F31.0^^123^1531^3
 ;;^UTILITY(U,$J,358.3,30748,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30748,1,3,0)
 ;;=3^Bipolar Disorder,Current/Recent Episode Hypomanic
 ;;^UTILITY(U,$J,358.3,30748,1,4,0)
 ;;=4^F31.0
 ;;^UTILITY(U,$J,358.3,30748,2)
 ;;=^5003494
 ;;^UTILITY(U,$J,358.3,30749,0)
 ;;=F31.71^^123^1531^4
 ;;^UTILITY(U,$J,358.3,30749,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30749,1,3,0)
 ;;=3^Bipolar Disorder,Current/Recent Episode Hypomanic,In Partial Remission
 ;;^UTILITY(U,$J,358.3,30749,1,4,0)
 ;;=4^F31.71
 ;;^UTILITY(U,$J,358.3,30749,2)
 ;;=^5003511
 ;;^UTILITY(U,$J,358.3,30750,0)
 ;;=F31.72^^123^1531^5
 ;;^UTILITY(U,$J,358.3,30750,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30750,1,3,0)
 ;;=3^Bipolar Disorder,Current/Recent Episode Hypomanic,In Full Remission
 ;;^UTILITY(U,$J,358.3,30750,1,4,0)
 ;;=4^F31.72
 ;;^UTILITY(U,$J,358.3,30750,2)
 ;;=^5003512
 ;;^UTILITY(U,$J,358.3,30751,0)
 ;;=F31.89^^123^1531^21
 ;;^UTILITY(U,$J,358.3,30751,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30751,1,3,0)
 ;;=3^Bipolar and Other Related Disorder,Oth Specified
 ;;^UTILITY(U,$J,358.3,30751,1,4,0)
 ;;=4^F31.89
 ;;^UTILITY(U,$J,358.3,30751,2)
 ;;=^5003520
 ;;^UTILITY(U,$J,358.3,30752,0)
 ;;=F10.232^^123^1532^2
 ;;^UTILITY(U,$J,358.3,30752,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30752,1,3,0)
 ;;=3^Alcohol Withdrawal Delirium w/ Perceptual Disturbances
 ;;^UTILITY(U,$J,358.3,30752,1,4,0)
 ;;=4^F10.232
 ;;^UTILITY(U,$J,358.3,30752,2)
 ;;=^5003088
 ;;^UTILITY(U,$J,358.3,30753,0)
 ;;=F10.231^^123^1532^3
 ;;^UTILITY(U,$J,358.3,30753,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30753,1,3,0)
 ;;=3^Alcohol Withdrawal Delirium w/o Perceptual Disturbances
