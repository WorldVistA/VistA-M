IBDEI01P ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,300,0)
 ;;=T50.905D^^3^34^3
 ;;^UTILITY(U,$J,358.3,300,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,300,1,3,0)
 ;;=3^Adverse Effect of Unspec Medication,Subseq Encntr
 ;;^UTILITY(U,$J,358.3,300,1,4,0)
 ;;=4^T50.905D
 ;;^UTILITY(U,$J,358.3,300,2)
 ;;=^5052161
 ;;^UTILITY(U,$J,358.3,301,0)
 ;;=T50.905S^^3^34^2
 ;;^UTILITY(U,$J,358.3,301,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,301,1,3,0)
 ;;=3^Adverse Effect of Unspec Medication,Sequela
 ;;^UTILITY(U,$J,358.3,301,1,4,0)
 ;;=4^T50.905S
 ;;^UTILITY(U,$J,358.3,301,2)
 ;;=^5052162
 ;;^UTILITY(U,$J,358.3,302,0)
 ;;=F42.^^3^35^7
 ;;^UTILITY(U,$J,358.3,302,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,302,1,3,0)
 ;;=3^Obsessive-Compulsive Disorder
 ;;^UTILITY(U,$J,358.3,302,1,4,0)
 ;;=4^F42.
 ;;^UTILITY(U,$J,358.3,302,2)
 ;;=^5003568
 ;;^UTILITY(U,$J,358.3,303,0)
 ;;=F45.22^^3^35^1
 ;;^UTILITY(U,$J,358.3,303,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,303,1,3,0)
 ;;=3^Body Dysmorphic Disorder
 ;;^UTILITY(U,$J,358.3,303,1,4,0)
 ;;=4^F45.22
 ;;^UTILITY(U,$J,358.3,303,2)
 ;;=^5003588
 ;;^UTILITY(U,$J,358.3,304,0)
 ;;=F63.3^^3^35^8
 ;;^UTILITY(U,$J,358.3,304,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,304,1,3,0)
 ;;=3^Trichotillomania
 ;;^UTILITY(U,$J,358.3,304,1,4,0)
 ;;=4^F63.3
 ;;^UTILITY(U,$J,358.3,304,2)
 ;;=^5003643
 ;;^UTILITY(U,$J,358.3,305,0)
 ;;=L98.1^^3^35^2
 ;;^UTILITY(U,$J,358.3,305,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,305,1,3,0)
 ;;=3^Excoriation (Skin-Picking) Disorder
 ;;^UTILITY(U,$J,358.3,305,1,4,0)
 ;;=4^L98.1
 ;;^UTILITY(U,$J,358.3,305,2)
 ;;=^186781
 ;;^UTILITY(U,$J,358.3,306,0)
 ;;=F68.10^^3^35^3
 ;;^UTILITY(U,$J,358.3,306,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,306,1,3,0)
 ;;=3^Factitious Disorder
 ;;^UTILITY(U,$J,358.3,306,1,4,0)
 ;;=4^F68.10
 ;;^UTILITY(U,$J,358.3,306,2)
 ;;=^5003663
 ;;^UTILITY(U,$J,358.3,307,0)
 ;;=F63.9^^3^35^5
 ;;^UTILITY(U,$J,358.3,307,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,307,1,3,0)
 ;;=3^Impulse Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,307,1,4,0)
 ;;=4^F63.9
 ;;^UTILITY(U,$J,358.3,307,2)
 ;;=^5003646
 ;;^UTILITY(U,$J,358.3,308,0)
 ;;=F42.^^3^35^4
 ;;^UTILITY(U,$J,358.3,308,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,308,1,3,0)
 ;;=3^Hoarding Disorder
 ;;^UTILITY(U,$J,358.3,308,1,4,0)
 ;;=4^F42.
 ;;^UTILITY(U,$J,358.3,308,2)
 ;;=^5003568
 ;;^UTILITY(U,$J,358.3,309,0)
 ;;=F06.8^^3^35^6
 ;;^UTILITY(U,$J,358.3,309,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,309,1,3,0)
 ;;=3^Obsessive-Compulsive & Related Disorder d/t Another Med Condition
 ;;^UTILITY(U,$J,358.3,309,1,4,0)
 ;;=4^F06.8
 ;;^UTILITY(U,$J,358.3,309,2)
 ;;=^5003062
 ;;^UTILITY(U,$J,358.3,310,0)
 ;;=F06.2^^3^36^5
 ;;^UTILITY(U,$J,358.3,310,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,310,1,3,0)
 ;;=3^Psychotic Disorder w/ Delusions d/t Another Medical Condition
 ;;^UTILITY(U,$J,358.3,310,1,4,0)
 ;;=4^F06.2
 ;;^UTILITY(U,$J,358.3,310,2)
 ;;=^5003055
 ;;^UTILITY(U,$J,358.3,311,0)
 ;;=F06.0^^3^36^6
 ;;^UTILITY(U,$J,358.3,311,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,311,1,3,0)
 ;;=3^Psychotic Disorder w/ Hallucinations d/t Another Medical Condition
 ;;^UTILITY(U,$J,358.3,311,1,4,0)
 ;;=4^F06.0
 ;;^UTILITY(U,$J,358.3,311,2)
 ;;=^5003053
 ;;^UTILITY(U,$J,358.3,312,0)
 ;;=F06.4^^3^36^1
 ;;^UTILITY(U,$J,358.3,312,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,312,1,3,0)
 ;;=3^Anxiety Disorder d/t Another Medical Condition
 ;;^UTILITY(U,$J,358.3,312,1,4,0)
 ;;=4^F06.4
 ;;^UTILITY(U,$J,358.3,312,2)
 ;;=^5003061
 ;;^UTILITY(U,$J,358.3,313,0)
 ;;=F06.1^^3^36^2
 ;;^UTILITY(U,$J,358.3,313,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,313,1,3,0)
 ;;=3^Catatonia Associated w/ Schizophrenia
