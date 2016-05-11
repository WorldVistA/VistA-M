IBDEI0XP ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,15801,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15801,1,3,0)
 ;;=3^Inhalant Intoxication Delirium w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,15801,1,4,0)
 ;;=4^F18.221
 ;;^UTILITY(U,$J,358.3,15801,2)
 ;;=^5003395
 ;;^UTILITY(U,$J,358.3,15802,0)
 ;;=F18.921^^58^694^16
 ;;^UTILITY(U,$J,358.3,15802,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15802,1,3,0)
 ;;=3^Inhalant Intoxication Delirium w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,15802,1,4,0)
 ;;=4^F18.921
 ;;^UTILITY(U,$J,358.3,15802,2)
 ;;=^5003407
 ;;^UTILITY(U,$J,358.3,15803,0)
 ;;=F18.129^^58^694^17
 ;;^UTILITY(U,$J,358.3,15803,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15803,1,3,0)
 ;;=3^Inhalant Intoxication w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,15803,1,4,0)
 ;;=4^F18.129
 ;;^UTILITY(U,$J,358.3,15803,2)
 ;;=^5003383
 ;;^UTILITY(U,$J,358.3,15804,0)
 ;;=F18.229^^58^694^18
 ;;^UTILITY(U,$J,358.3,15804,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15804,1,3,0)
 ;;=3^Inhalant Intoxication w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,15804,1,4,0)
 ;;=4^F18.229
 ;;^UTILITY(U,$J,358.3,15804,2)
 ;;=^5003396
 ;;^UTILITY(U,$J,358.3,15805,0)
 ;;=F18.929^^58^694^19
 ;;^UTILITY(U,$J,358.3,15805,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15805,1,3,0)
 ;;=3^Inhalant Intoxication w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,15805,1,4,0)
 ;;=4^F18.929
 ;;^UTILITY(U,$J,358.3,15805,2)
 ;;=^5003408
 ;;^UTILITY(U,$J,358.3,15806,0)
 ;;=F18.180^^58^694^1
 ;;^UTILITY(U,$J,358.3,15806,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15806,1,3,0)
 ;;=3^Inhalant Induced Anxiety Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,15806,1,4,0)
 ;;=4^F18.180
 ;;^UTILITY(U,$J,358.3,15806,2)
 ;;=^5003389
 ;;^UTILITY(U,$J,358.3,15807,0)
 ;;=F18.280^^58^694^2
 ;;^UTILITY(U,$J,358.3,15807,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15807,1,3,0)
 ;;=3^Inhalant Induced Anxiety Disorder w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,15807,1,4,0)
 ;;=4^F18.280
 ;;^UTILITY(U,$J,358.3,15807,2)
 ;;=^5003402
 ;;^UTILITY(U,$J,358.3,15808,0)
 ;;=F18.980^^58^694^3
 ;;^UTILITY(U,$J,358.3,15808,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15808,1,3,0)
 ;;=3^Inhalant Induced Anxiety Disorder w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,15808,1,4,0)
 ;;=4^F18.980
 ;;^UTILITY(U,$J,358.3,15808,2)
 ;;=^5003414
 ;;^UTILITY(U,$J,358.3,15809,0)
 ;;=F18.94^^58^694^4
 ;;^UTILITY(U,$J,358.3,15809,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15809,1,3,0)
 ;;=3^Inhalant Induced Depressive Disorder w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,15809,1,4,0)
 ;;=4^F18.94
 ;;^UTILITY(U,$J,358.3,15809,2)
 ;;=^5003409
 ;;^UTILITY(U,$J,358.3,15810,0)
 ;;=F18.17^^58^694^5
 ;;^UTILITY(U,$J,358.3,15810,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15810,1,3,0)
 ;;=3^Inhalant Induced Major Neurocog Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,15810,1,4,0)
 ;;=4^F18.17
 ;;^UTILITY(U,$J,358.3,15810,2)
 ;;=^5003388
 ;;^UTILITY(U,$J,358.3,15811,0)
 ;;=F18.27^^58^694^6
 ;;^UTILITY(U,$J,358.3,15811,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15811,1,3,0)
 ;;=3^Inhalant Induced Major Neurocog Disorder w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,15811,1,4,0)
 ;;=4^F18.27
 ;;^UTILITY(U,$J,358.3,15811,2)
 ;;=^5003401
 ;;^UTILITY(U,$J,358.3,15812,0)
 ;;=F18.97^^58^694^7
 ;;^UTILITY(U,$J,358.3,15812,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15812,1,3,0)
 ;;=3^Inhalant Induced Major Neurocog Disorder w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,15812,1,4,0)
 ;;=4^F18.97
 ;;^UTILITY(U,$J,358.3,15812,2)
 ;;=^5003413
 ;;^UTILITY(U,$J,358.3,15813,0)
 ;;=F18.188^^58^694^8
