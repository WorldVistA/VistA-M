IBDEI02N ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,687,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,687,1,3,0)
 ;;=3^Cardiomyopathy, unspecified
 ;;^UTILITY(U,$J,358.3,687,1,4,0)
 ;;=4^I42.9
 ;;^UTILITY(U,$J,358.3,687,2)
 ;;=^5007200
 ;;^UTILITY(U,$J,358.3,688,0)
 ;;=I45.10^^3^29^24
 ;;^UTILITY(U,$J,358.3,688,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,688,1,3,0)
 ;;=3^Right Bundle-Branch Block,Unspec
 ;;^UTILITY(U,$J,358.3,688,1,4,0)
 ;;=4^I45.10
 ;;^UTILITY(U,$J,358.3,688,2)
 ;;=^5007212
 ;;^UTILITY(U,$J,358.3,689,0)
 ;;=I47.1^^3^29^26
 ;;^UTILITY(U,$J,358.3,689,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,689,1,3,0)
 ;;=3^Supraventricular tachycardia
 ;;^UTILITY(U,$J,358.3,689,1,4,0)
 ;;=4^I47.1
 ;;^UTILITY(U,$J,358.3,689,2)
 ;;=^5007223
 ;;^UTILITY(U,$J,358.3,690,0)
 ;;=I47.2^^3^29^29
 ;;^UTILITY(U,$J,358.3,690,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,690,1,3,0)
 ;;=3^Ventricular tachycardia
 ;;^UTILITY(U,$J,358.3,690,1,4,0)
 ;;=4^I47.2
 ;;^UTILITY(U,$J,358.3,690,2)
 ;;=^125976
 ;;^UTILITY(U,$J,358.3,691,0)
 ;;=I48.91^^3^29^7
 ;;^UTILITY(U,$J,358.3,691,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,691,1,3,0)
 ;;=3^Atrial Fibrillation,Unspec
 ;;^UTILITY(U,$J,358.3,691,1,4,0)
 ;;=4^I48.91
 ;;^UTILITY(U,$J,358.3,691,2)
 ;;=^5007229
 ;;^UTILITY(U,$J,358.3,692,0)
 ;;=I49.3^^3^29^28
 ;;^UTILITY(U,$J,358.3,692,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,692,1,3,0)
 ;;=3^Ventricular premature depolarization
 ;;^UTILITY(U,$J,358.3,692,1,4,0)
 ;;=4^I49.3
 ;;^UTILITY(U,$J,358.3,692,2)
 ;;=^5007233
 ;;^UTILITY(U,$J,358.3,693,0)
 ;;=I49.9^^3^29^8
 ;;^UTILITY(U,$J,358.3,693,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,693,1,3,0)
 ;;=3^Cardiac arrhythmia, unspecified
 ;;^UTILITY(U,$J,358.3,693,1,4,0)
 ;;=4^I49.9
 ;;^UTILITY(U,$J,358.3,693,2)
 ;;=^5007237
 ;;^UTILITY(U,$J,358.3,694,0)
 ;;=I50.9^^3^29^16
 ;;^UTILITY(U,$J,358.3,694,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,694,1,3,0)
 ;;=3^Heart failure, unspecified
 ;;^UTILITY(U,$J,358.3,694,1,4,0)
 ;;=4^I50.9
 ;;^UTILITY(U,$J,358.3,694,2)
 ;;=^5007251
 ;;^UTILITY(U,$J,358.3,695,0)
 ;;=G45.9^^3^29^27
 ;;^UTILITY(U,$J,358.3,695,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,695,1,3,0)
 ;;=3^Transient cerebral ischemic attack, unspecified
 ;;^UTILITY(U,$J,358.3,695,1,4,0)
 ;;=4^G45.9
 ;;^UTILITY(U,$J,358.3,695,2)
 ;;=^5003959
 ;;^UTILITY(U,$J,358.3,696,0)
 ;;=I70.90^^3^29^5
 ;;^UTILITY(U,$J,358.3,696,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,696,1,3,0)
 ;;=3^Atherosclerosis,Unspec
 ;;^UTILITY(U,$J,358.3,696,1,4,0)
 ;;=4^I70.90
 ;;^UTILITY(U,$J,358.3,696,2)
 ;;=^5007784
 ;;^UTILITY(U,$J,358.3,697,0)
 ;;=I73.9^^3^29^22
 ;;^UTILITY(U,$J,358.3,697,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,697,1,3,0)
 ;;=3^Peripheral vascular disease, unspecified
 ;;^UTILITY(U,$J,358.3,697,1,4,0)
 ;;=4^I73.9
 ;;^UTILITY(U,$J,358.3,697,2)
 ;;=^184182
 ;;^UTILITY(U,$J,358.3,698,0)
 ;;=I82.401^^3^29^3
 ;;^UTILITY(U,$J,358.3,698,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,698,1,3,0)
 ;;=3^Ac Embolism/Thombos Unspec Deep Veins,Right Lower Extrm
 ;;^UTILITY(U,$J,358.3,698,1,4,0)
 ;;=4^I82.401
 ;;^UTILITY(U,$J,358.3,698,2)
 ;;=^5007854
 ;;^UTILITY(U,$J,358.3,699,0)
 ;;=I82.402^^3^29^2
 ;;^UTILITY(U,$J,358.3,699,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,699,1,3,0)
 ;;=3^Ac Embolism/Thombos Unspec Deep Veins,Left Lower Extrm
 ;;^UTILITY(U,$J,358.3,699,1,4,0)
 ;;=4^I82.402
 ;;^UTILITY(U,$J,358.3,699,2)
 ;;=^5007855
 ;;^UTILITY(U,$J,358.3,700,0)
 ;;=I82.403^^3^29^1
 ;;^UTILITY(U,$J,358.3,700,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,700,1,3,0)
 ;;=3^Ac Embolism/Thombos Unspec Deep Veins,Bilat Lower Extrm
