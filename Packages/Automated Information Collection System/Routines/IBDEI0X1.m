IBDEI0X1 ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,15499,2)
 ;;=^5003771
 ;;^UTILITY(U,$J,358.3,15500,0)
 ;;=T50.905A^^58^669^1
 ;;^UTILITY(U,$J,358.3,15500,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15500,1,3,0)
 ;;=3^Adverse Effect of Unspec Medication,Init Encntr
 ;;^UTILITY(U,$J,358.3,15500,1,4,0)
 ;;=4^T50.905A
 ;;^UTILITY(U,$J,358.3,15500,2)
 ;;=^5052160
 ;;^UTILITY(U,$J,358.3,15501,0)
 ;;=T50.905D^^58^669^3
 ;;^UTILITY(U,$J,358.3,15501,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15501,1,3,0)
 ;;=3^Adverse Effect of Unspec Medication,Subseq Encntr
 ;;^UTILITY(U,$J,358.3,15501,1,4,0)
 ;;=4^T50.905D
 ;;^UTILITY(U,$J,358.3,15501,2)
 ;;=^5052161
 ;;^UTILITY(U,$J,358.3,15502,0)
 ;;=T50.905S^^58^669^2
 ;;^UTILITY(U,$J,358.3,15502,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15502,1,3,0)
 ;;=3^Adverse Effect of Unspec Medication,Sequela
 ;;^UTILITY(U,$J,358.3,15502,1,4,0)
 ;;=4^T50.905S
 ;;^UTILITY(U,$J,358.3,15502,2)
 ;;=^5052162
 ;;^UTILITY(U,$J,358.3,15503,0)
 ;;=F42.^^58^670^7
 ;;^UTILITY(U,$J,358.3,15503,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15503,1,3,0)
 ;;=3^Obsessive-Compulsive Disorder
 ;;^UTILITY(U,$J,358.3,15503,1,4,0)
 ;;=4^F42.
 ;;^UTILITY(U,$J,358.3,15503,2)
 ;;=^5003568
 ;;^UTILITY(U,$J,358.3,15504,0)
 ;;=F45.22^^58^670^1
 ;;^UTILITY(U,$J,358.3,15504,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15504,1,3,0)
 ;;=3^Body Dysmorphic Disorder
 ;;^UTILITY(U,$J,358.3,15504,1,4,0)
 ;;=4^F45.22
 ;;^UTILITY(U,$J,358.3,15504,2)
 ;;=^5003588
 ;;^UTILITY(U,$J,358.3,15505,0)
 ;;=F63.3^^58^670^8
 ;;^UTILITY(U,$J,358.3,15505,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15505,1,3,0)
 ;;=3^Trichotillomania
 ;;^UTILITY(U,$J,358.3,15505,1,4,0)
 ;;=4^F63.3
 ;;^UTILITY(U,$J,358.3,15505,2)
 ;;=^5003643
 ;;^UTILITY(U,$J,358.3,15506,0)
 ;;=L98.1^^58^670^2
 ;;^UTILITY(U,$J,358.3,15506,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15506,1,3,0)
 ;;=3^Excoriation (Skin-Picking) Disorder
 ;;^UTILITY(U,$J,358.3,15506,1,4,0)
 ;;=4^L98.1
 ;;^UTILITY(U,$J,358.3,15506,2)
 ;;=^186781
 ;;^UTILITY(U,$J,358.3,15507,0)
 ;;=F68.10^^58^670^3
 ;;^UTILITY(U,$J,358.3,15507,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15507,1,3,0)
 ;;=3^Factitious Disorder
 ;;^UTILITY(U,$J,358.3,15507,1,4,0)
 ;;=4^F68.10
 ;;^UTILITY(U,$J,358.3,15507,2)
 ;;=^5003663
 ;;^UTILITY(U,$J,358.3,15508,0)
 ;;=F63.9^^58^670^5
 ;;^UTILITY(U,$J,358.3,15508,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15508,1,3,0)
 ;;=3^Impulse Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,15508,1,4,0)
 ;;=4^F63.9
 ;;^UTILITY(U,$J,358.3,15508,2)
 ;;=^5003646
 ;;^UTILITY(U,$J,358.3,15509,0)
 ;;=F42.^^58^670^4
 ;;^UTILITY(U,$J,358.3,15509,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15509,1,3,0)
 ;;=3^Hoarding Disorder
 ;;^UTILITY(U,$J,358.3,15509,1,4,0)
 ;;=4^F42.
 ;;^UTILITY(U,$J,358.3,15509,2)
 ;;=^5003568
 ;;^UTILITY(U,$J,358.3,15510,0)
 ;;=F06.8^^58^670^6
 ;;^UTILITY(U,$J,358.3,15510,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15510,1,3,0)
 ;;=3^Obsessive-Compulsive & Related Disorder d/t Another Med Condition
 ;;^UTILITY(U,$J,358.3,15510,1,4,0)
 ;;=4^F06.8
 ;;^UTILITY(U,$J,358.3,15510,2)
 ;;=^5003062
 ;;^UTILITY(U,$J,358.3,15511,0)
 ;;=F06.2^^58^671^5
 ;;^UTILITY(U,$J,358.3,15511,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15511,1,3,0)
 ;;=3^Psychotic Disorder w/ Delusions d/t Another Medical Condition
 ;;^UTILITY(U,$J,358.3,15511,1,4,0)
 ;;=4^F06.2
 ;;^UTILITY(U,$J,358.3,15511,2)
 ;;=^5003055
 ;;^UTILITY(U,$J,358.3,15512,0)
 ;;=F06.0^^58^671^6
 ;;^UTILITY(U,$J,358.3,15512,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15512,1,3,0)
 ;;=3^Psychotic Disorder w/ Hallucinations d/t Another Medical Condition
