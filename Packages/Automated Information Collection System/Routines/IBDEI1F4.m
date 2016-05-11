IBDEI1F4 ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,24107,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24107,1,3,0)
 ;;=3^Body Dysmorphic Disorder
 ;;^UTILITY(U,$J,358.3,24107,1,4,0)
 ;;=4^F45.22
 ;;^UTILITY(U,$J,358.3,24107,2)
 ;;=^5003588
 ;;^UTILITY(U,$J,358.3,24108,0)
 ;;=F63.3^^90^1047^8
 ;;^UTILITY(U,$J,358.3,24108,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24108,1,3,0)
 ;;=3^Trichotillomania
 ;;^UTILITY(U,$J,358.3,24108,1,4,0)
 ;;=4^F63.3
 ;;^UTILITY(U,$J,358.3,24108,2)
 ;;=^5003643
 ;;^UTILITY(U,$J,358.3,24109,0)
 ;;=L98.1^^90^1047^2
 ;;^UTILITY(U,$J,358.3,24109,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24109,1,3,0)
 ;;=3^Excoriation (Skin-Picking) Disorder
 ;;^UTILITY(U,$J,358.3,24109,1,4,0)
 ;;=4^L98.1
 ;;^UTILITY(U,$J,358.3,24109,2)
 ;;=^186781
 ;;^UTILITY(U,$J,358.3,24110,0)
 ;;=F68.10^^90^1047^3
 ;;^UTILITY(U,$J,358.3,24110,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24110,1,3,0)
 ;;=3^Factitious Disorder
 ;;^UTILITY(U,$J,358.3,24110,1,4,0)
 ;;=4^F68.10
 ;;^UTILITY(U,$J,358.3,24110,2)
 ;;=^5003663
 ;;^UTILITY(U,$J,358.3,24111,0)
 ;;=F63.9^^90^1047^5
 ;;^UTILITY(U,$J,358.3,24111,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24111,1,3,0)
 ;;=3^Impulse Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,24111,1,4,0)
 ;;=4^F63.9
 ;;^UTILITY(U,$J,358.3,24111,2)
 ;;=^5003646
 ;;^UTILITY(U,$J,358.3,24112,0)
 ;;=F42.^^90^1047^4
 ;;^UTILITY(U,$J,358.3,24112,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24112,1,3,0)
 ;;=3^Hoarding Disorder
 ;;^UTILITY(U,$J,358.3,24112,1,4,0)
 ;;=4^F42.
 ;;^UTILITY(U,$J,358.3,24112,2)
 ;;=^5003568
 ;;^UTILITY(U,$J,358.3,24113,0)
 ;;=F06.8^^90^1047^6
 ;;^UTILITY(U,$J,358.3,24113,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24113,1,3,0)
 ;;=3^Obsessive-Compulsive & Related Disorder d/t Another Med Condition
 ;;^UTILITY(U,$J,358.3,24113,1,4,0)
 ;;=4^F06.8
 ;;^UTILITY(U,$J,358.3,24113,2)
 ;;=^5003062
 ;;^UTILITY(U,$J,358.3,24114,0)
 ;;=F06.2^^90^1048^5
 ;;^UTILITY(U,$J,358.3,24114,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24114,1,3,0)
 ;;=3^Psychotic Disorder w/ Delusions d/t Another Medical Condition
 ;;^UTILITY(U,$J,358.3,24114,1,4,0)
 ;;=4^F06.2
 ;;^UTILITY(U,$J,358.3,24114,2)
 ;;=^5003055
 ;;^UTILITY(U,$J,358.3,24115,0)
 ;;=F06.0^^90^1048^6
 ;;^UTILITY(U,$J,358.3,24115,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24115,1,3,0)
 ;;=3^Psychotic Disorder w/ Hallucinations d/t Another Medical Condition
 ;;^UTILITY(U,$J,358.3,24115,1,4,0)
 ;;=4^F06.0
 ;;^UTILITY(U,$J,358.3,24115,2)
 ;;=^5003053
 ;;^UTILITY(U,$J,358.3,24116,0)
 ;;=F06.4^^90^1048^1
 ;;^UTILITY(U,$J,358.3,24116,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24116,1,3,0)
 ;;=3^Anxiety Disorder d/t Another Medical Condition
 ;;^UTILITY(U,$J,358.3,24116,1,4,0)
 ;;=4^F06.4
 ;;^UTILITY(U,$J,358.3,24116,2)
 ;;=^5003061
 ;;^UTILITY(U,$J,358.3,24117,0)
 ;;=F06.1^^90^1048^2
 ;;^UTILITY(U,$J,358.3,24117,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24117,1,3,0)
 ;;=3^Catatonia Associated w/ Schizophrenia
 ;;^UTILITY(U,$J,358.3,24117,1,4,0)
 ;;=4^F06.1
 ;;^UTILITY(U,$J,358.3,24117,2)
 ;;=^5003054
 ;;^UTILITY(U,$J,358.3,24118,0)
 ;;=R41.9^^90^1048^3
 ;;^UTILITY(U,$J,358.3,24118,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24118,1,3,0)
 ;;=3^Neurocognitive Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,24118,1,4,0)
 ;;=4^R41.9
 ;;^UTILITY(U,$J,358.3,24118,2)
 ;;=^5019449
 ;;^UTILITY(U,$J,358.3,24119,0)
 ;;=F29.^^90^1048^7
 ;;^UTILITY(U,$J,358.3,24119,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24119,1,3,0)
 ;;=3^Schizophrenia Spectrum/Psychotic Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,24119,1,4,0)
 ;;=4^F29.
 ;;^UTILITY(U,$J,358.3,24119,2)
 ;;=^5003484
