IBDEI028 ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,270,1,4,0)
 ;;=4^G24.02
 ;;^UTILITY(U,$J,358.3,270,2)
 ;;=^5003785
 ;;^UTILITY(U,$J,358.3,271,0)
 ;;=G24.01^^3^34^7
 ;;^UTILITY(U,$J,358.3,271,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,271,1,3,0)
 ;;=3^Tardive Dyskinesia
 ;;^UTILITY(U,$J,358.3,271,1,4,0)
 ;;=4^G24.01
 ;;^UTILITY(U,$J,358.3,271,2)
 ;;=^5003784
 ;;^UTILITY(U,$J,358.3,272,0)
 ;;=G24.09^^3^34^8
 ;;^UTILITY(U,$J,358.3,272,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,272,1,3,0)
 ;;=3^Tardive Dystonia
 ;;^UTILITY(U,$J,358.3,272,1,4,0)
 ;;=4^G24.09
 ;;^UTILITY(U,$J,358.3,272,2)
 ;;=^5003786
 ;;^UTILITY(U,$J,358.3,273,0)
 ;;=G25.1^^3^34^4
 ;;^UTILITY(U,$J,358.3,273,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,273,1,3,0)
 ;;=3^Medication-Induced Postural Tremor
 ;;^UTILITY(U,$J,358.3,273,1,4,0)
 ;;=4^G25.1
 ;;^UTILITY(U,$J,358.3,273,2)
 ;;=^5003792
 ;;^UTILITY(U,$J,358.3,274,0)
 ;;=G25.71^^3^34^6
 ;;^UTILITY(U,$J,358.3,274,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,274,1,3,0)
 ;;=3^Tardive Akathisia/Medication-Induced Acute Akatisia
 ;;^UTILITY(U,$J,358.3,274,1,4,0)
 ;;=4^G25.71
 ;;^UTILITY(U,$J,358.3,274,2)
 ;;=^5003799
 ;;^UTILITY(U,$J,358.3,275,0)
 ;;=G25.79^^3^34^2
 ;;^UTILITY(U,$J,358.3,275,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,275,1,3,0)
 ;;=3^Medication-Induced Movement Disorder NEC
 ;;^UTILITY(U,$J,358.3,275,1,4,0)
 ;;=4^G25.79
 ;;^UTILITY(U,$J,358.3,275,2)
 ;;=^5003800
 ;;^UTILITY(U,$J,358.3,276,0)
 ;;=F42.^^3^35^6
 ;;^UTILITY(U,$J,358.3,276,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,276,1,3,0)
 ;;=3^Obsessive-Compulsive Disorder
 ;;^UTILITY(U,$J,358.3,276,1,4,0)
 ;;=4^F42.
 ;;^UTILITY(U,$J,358.3,276,2)
 ;;=^5003568
 ;;^UTILITY(U,$J,358.3,277,0)
 ;;=F45.22^^3^35^1
 ;;^UTILITY(U,$J,358.3,277,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,277,1,3,0)
 ;;=3^Body Dysmorphic Disorder
 ;;^UTILITY(U,$J,358.3,277,1,4,0)
 ;;=4^F45.22
 ;;^UTILITY(U,$J,358.3,277,2)
 ;;=^5003588
 ;;^UTILITY(U,$J,358.3,278,0)
 ;;=F63.3^^3^35^7
 ;;^UTILITY(U,$J,358.3,278,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,278,1,3,0)
 ;;=3^Trichotillomania
 ;;^UTILITY(U,$J,358.3,278,1,4,0)
 ;;=4^F63.3
 ;;^UTILITY(U,$J,358.3,278,2)
 ;;=^5003643
 ;;^UTILITY(U,$J,358.3,279,0)
 ;;=L98.1^^3^35^2
 ;;^UTILITY(U,$J,358.3,279,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,279,1,3,0)
 ;;=3^Excoriation (Skin-Picking) Disorder
 ;;^UTILITY(U,$J,358.3,279,1,4,0)
 ;;=4^L98.1
 ;;^UTILITY(U,$J,358.3,279,2)
 ;;=^186781
 ;;^UTILITY(U,$J,358.3,280,0)
 ;;=F63.0^^3^35^4
 ;;^UTILITY(U,$J,358.3,280,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,280,1,3,0)
 ;;=3^Gambling Disorder
 ;;^UTILITY(U,$J,358.3,280,1,4,0)
 ;;=4^F63.0
 ;;^UTILITY(U,$J,358.3,280,2)
 ;;=^5003640
 ;;^UTILITY(U,$J,358.3,281,0)
 ;;=F68.10^^3^35^3
 ;;^UTILITY(U,$J,358.3,281,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,281,1,3,0)
 ;;=3^Factitious Disorder
 ;;^UTILITY(U,$J,358.3,281,1,4,0)
 ;;=4^F68.10
 ;;^UTILITY(U,$J,358.3,281,2)
 ;;=^5003663
 ;;^UTILITY(U,$J,358.3,282,0)
 ;;=F63.9^^3^35^5
 ;;^UTILITY(U,$J,358.3,282,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,282,1,3,0)
 ;;=3^Impulse Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,282,1,4,0)
 ;;=4^F63.9
 ;;^UTILITY(U,$J,358.3,282,2)
 ;;=^5003646
 ;;^UTILITY(U,$J,358.3,283,0)
 ;;=F06.2^^3^36^5
 ;;^UTILITY(U,$J,358.3,283,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,283,1,3,0)
 ;;=3^Psychotic Disorder w/ Delusions d/t Another Medical Condition
 ;;^UTILITY(U,$J,358.3,283,1,4,0)
 ;;=4^F06.2
 ;;^UTILITY(U,$J,358.3,283,2)
 ;;=^5003055
 ;;^UTILITY(U,$J,358.3,284,0)
 ;;=F06.0^^3^36^6
 ;;^UTILITY(U,$J,358.3,284,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,284,1,3,0)
 ;;=3^Psychotic Disorder w/ Hallucinations d/t Another Medical Condition
