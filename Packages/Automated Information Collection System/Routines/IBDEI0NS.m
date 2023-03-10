IBDEI0NS ; ; 01-FEB-2022
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 01, 2022
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,10704,2)
 ;;=^5003799
 ;;^UTILITY(U,$J,358.3,10705,0)
 ;;=G24.02^^42^478^8
 ;;^UTILITY(U,$J,358.3,10705,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10705,1,3,0)
 ;;=3^Medication-Induced Acute Dystonia
 ;;^UTILITY(U,$J,358.3,10705,1,4,0)
 ;;=4^G24.02
 ;;^UTILITY(U,$J,358.3,10705,2)
 ;;=^5003785
 ;;^UTILITY(U,$J,358.3,10706,0)
 ;;=G21.0^^42^478^12
 ;;^UTILITY(U,$J,358.3,10706,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10706,1,3,0)
 ;;=3^Neuroleptic Malignant Syndrome
 ;;^UTILITY(U,$J,358.3,10706,1,4,0)
 ;;=4^G21.0
 ;;^UTILITY(U,$J,358.3,10706,2)
 ;;=^5003771
 ;;^UTILITY(U,$J,358.3,10707,0)
 ;;=T50.905A^^42^478^1
 ;;^UTILITY(U,$J,358.3,10707,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10707,1,3,0)
 ;;=3^Adverse Effect of Medication,Other,Init Encntr
 ;;^UTILITY(U,$J,358.3,10707,1,4,0)
 ;;=4^T50.905A
 ;;^UTILITY(U,$J,358.3,10707,2)
 ;;=^5052160
 ;;^UTILITY(U,$J,358.3,10708,0)
 ;;=T50.905S^^42^478^2
 ;;^UTILITY(U,$J,358.3,10708,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10708,1,3,0)
 ;;=3^Adverse Effect of Medication,Other,Sequela
 ;;^UTILITY(U,$J,358.3,10708,1,4,0)
 ;;=4^T50.905S
 ;;^UTILITY(U,$J,358.3,10708,2)
 ;;=^5052162
 ;;^UTILITY(U,$J,358.3,10709,0)
 ;;=T50.905D^^42^478^3
 ;;^UTILITY(U,$J,358.3,10709,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10709,1,3,0)
 ;;=3^Adverse Effect of Medication,Other,Subseq Encntr
 ;;^UTILITY(U,$J,358.3,10709,1,4,0)
 ;;=4^T50.905D
 ;;^UTILITY(U,$J,358.3,10709,2)
 ;;=^5052161
 ;;^UTILITY(U,$J,358.3,10710,0)
 ;;=F45.22^^42^479^1
 ;;^UTILITY(U,$J,358.3,10710,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10710,1,3,0)
 ;;=3^Body Dysmorphic Disorder
 ;;^UTILITY(U,$J,358.3,10710,1,4,0)
 ;;=4^F45.22
 ;;^UTILITY(U,$J,358.3,10710,2)
 ;;=^5003588
 ;;^UTILITY(U,$J,358.3,10711,0)
 ;;=F63.3^^42^479^7
 ;;^UTILITY(U,$J,358.3,10711,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10711,1,3,0)
 ;;=3^Trichotillomania (Hair-Pulling Disorder)
 ;;^UTILITY(U,$J,358.3,10711,1,4,0)
 ;;=4^F63.3
 ;;^UTILITY(U,$J,358.3,10711,2)
 ;;=^5003643
 ;;^UTILITY(U,$J,358.3,10712,0)
 ;;=F06.8^^42^479^5
 ;;^UTILITY(U,$J,358.3,10712,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10712,1,3,0)
 ;;=3^Obsessive-Compulsive & Related Disorder d/t Another Med Condition
 ;;^UTILITY(U,$J,358.3,10712,1,4,0)
 ;;=4^F06.8
 ;;^UTILITY(U,$J,358.3,10712,2)
 ;;=^5003062
 ;;^UTILITY(U,$J,358.3,10713,0)
 ;;=F42.3^^42^479^3
 ;;^UTILITY(U,$J,358.3,10713,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10713,1,3,0)
 ;;=3^Hoarding Disorder
 ;;^UTILITY(U,$J,358.3,10713,1,4,0)
 ;;=4^F42.3
 ;;^UTILITY(U,$J,358.3,10713,2)
 ;;=^5138445
 ;;^UTILITY(U,$J,358.3,10714,0)
 ;;=F42.9^^42^479^6
 ;;^UTILITY(U,$J,358.3,10714,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10714,1,3,0)
 ;;=3^Obsessive-Compulsive Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,10714,1,4,0)
 ;;=4^F42.9
 ;;^UTILITY(U,$J,358.3,10714,2)
 ;;=^5138448
 ;;^UTILITY(U,$J,358.3,10715,0)
 ;;=F42.2^^42^479^4
 ;;^UTILITY(U,$J,358.3,10715,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10715,1,3,0)
 ;;=3^Mixed Obsessional Thoughts and Acts
 ;;^UTILITY(U,$J,358.3,10715,1,4,0)
 ;;=4^F42.2
 ;;^UTILITY(U,$J,358.3,10715,2)
 ;;=^5138444
 ;;^UTILITY(U,$J,358.3,10716,0)
 ;;=F42.4^^42^479^2
 ;;^UTILITY(U,$J,358.3,10716,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10716,1,3,0)
 ;;=3^Excoriation (Skin-Picking) Disorder
 ;;^UTILITY(U,$J,358.3,10716,1,4,0)
 ;;=4^F42.4
 ;;^UTILITY(U,$J,358.3,10716,2)
 ;;=^5138446
