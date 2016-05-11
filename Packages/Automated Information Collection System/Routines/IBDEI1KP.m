IBDEI1KP ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,26684,0)
 ;;=T50.905D^^100^1276^3
 ;;^UTILITY(U,$J,358.3,26684,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26684,1,3,0)
 ;;=3^Adverse Effect of Unspec Medication,Subseq Encntr
 ;;^UTILITY(U,$J,358.3,26684,1,4,0)
 ;;=4^T50.905D
 ;;^UTILITY(U,$J,358.3,26684,2)
 ;;=^5052161
 ;;^UTILITY(U,$J,358.3,26685,0)
 ;;=T50.905S^^100^1276^2
 ;;^UTILITY(U,$J,358.3,26685,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26685,1,3,0)
 ;;=3^Adverse Effect of Unspec Medication,Sequela
 ;;^UTILITY(U,$J,358.3,26685,1,4,0)
 ;;=4^T50.905S
 ;;^UTILITY(U,$J,358.3,26685,2)
 ;;=^5052162
 ;;^UTILITY(U,$J,358.3,26686,0)
 ;;=F42.^^100^1277^7
 ;;^UTILITY(U,$J,358.3,26686,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26686,1,3,0)
 ;;=3^Obsessive-Compulsive Disorder
 ;;^UTILITY(U,$J,358.3,26686,1,4,0)
 ;;=4^F42.
 ;;^UTILITY(U,$J,358.3,26686,2)
 ;;=^5003568
 ;;^UTILITY(U,$J,358.3,26687,0)
 ;;=F45.22^^100^1277^1
 ;;^UTILITY(U,$J,358.3,26687,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26687,1,3,0)
 ;;=3^Body Dysmorphic Disorder
 ;;^UTILITY(U,$J,358.3,26687,1,4,0)
 ;;=4^F45.22
 ;;^UTILITY(U,$J,358.3,26687,2)
 ;;=^5003588
 ;;^UTILITY(U,$J,358.3,26688,0)
 ;;=F63.3^^100^1277^8
 ;;^UTILITY(U,$J,358.3,26688,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26688,1,3,0)
 ;;=3^Trichotillomania
 ;;^UTILITY(U,$J,358.3,26688,1,4,0)
 ;;=4^F63.3
 ;;^UTILITY(U,$J,358.3,26688,2)
 ;;=^5003643
 ;;^UTILITY(U,$J,358.3,26689,0)
 ;;=L98.1^^100^1277^2
 ;;^UTILITY(U,$J,358.3,26689,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26689,1,3,0)
 ;;=3^Excoriation (Skin-Picking) Disorder
 ;;^UTILITY(U,$J,358.3,26689,1,4,0)
 ;;=4^L98.1
 ;;^UTILITY(U,$J,358.3,26689,2)
 ;;=^186781
 ;;^UTILITY(U,$J,358.3,26690,0)
 ;;=F68.10^^100^1277^3
 ;;^UTILITY(U,$J,358.3,26690,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26690,1,3,0)
 ;;=3^Factitious Disorder
 ;;^UTILITY(U,$J,358.3,26690,1,4,0)
 ;;=4^F68.10
 ;;^UTILITY(U,$J,358.3,26690,2)
 ;;=^5003663
 ;;^UTILITY(U,$J,358.3,26691,0)
 ;;=F63.9^^100^1277^5
 ;;^UTILITY(U,$J,358.3,26691,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26691,1,3,0)
 ;;=3^Impulse Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,26691,1,4,0)
 ;;=4^F63.9
 ;;^UTILITY(U,$J,358.3,26691,2)
 ;;=^5003646
 ;;^UTILITY(U,$J,358.3,26692,0)
 ;;=F42.^^100^1277^4
 ;;^UTILITY(U,$J,358.3,26692,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26692,1,3,0)
 ;;=3^Hoarding Disorder
 ;;^UTILITY(U,$J,358.3,26692,1,4,0)
 ;;=4^F42.
 ;;^UTILITY(U,$J,358.3,26692,2)
 ;;=^5003568
 ;;^UTILITY(U,$J,358.3,26693,0)
 ;;=F06.8^^100^1277^6
 ;;^UTILITY(U,$J,358.3,26693,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26693,1,3,0)
 ;;=3^Obsessive-Compulsive & Related Disorder d/t Another Med Condition
 ;;^UTILITY(U,$J,358.3,26693,1,4,0)
 ;;=4^F06.8
 ;;^UTILITY(U,$J,358.3,26693,2)
 ;;=^5003062
 ;;^UTILITY(U,$J,358.3,26694,0)
 ;;=F06.2^^100^1278^5
 ;;^UTILITY(U,$J,358.3,26694,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26694,1,3,0)
 ;;=3^Psychotic Disorder w/ Delusions d/t Another Medical Condition
 ;;^UTILITY(U,$J,358.3,26694,1,4,0)
 ;;=4^F06.2
 ;;^UTILITY(U,$J,358.3,26694,2)
 ;;=^5003055
 ;;^UTILITY(U,$J,358.3,26695,0)
 ;;=F06.0^^100^1278^6
 ;;^UTILITY(U,$J,358.3,26695,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26695,1,3,0)
 ;;=3^Psychotic Disorder w/ Hallucinations d/t Another Medical Condition
 ;;^UTILITY(U,$J,358.3,26695,1,4,0)
 ;;=4^F06.0
 ;;^UTILITY(U,$J,358.3,26695,2)
 ;;=^5003053
 ;;^UTILITY(U,$J,358.3,26696,0)
 ;;=F06.4^^100^1278^1
 ;;^UTILITY(U,$J,358.3,26696,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26696,1,3,0)
 ;;=3^Anxiety Disorder d/t Another Medical Condition
 ;;^UTILITY(U,$J,358.3,26696,1,4,0)
 ;;=4^F06.4
