IBDEI06R ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,2641,1,4,0)
 ;;=4^R19.4
 ;;^UTILITY(U,$J,358.3,2641,2)
 ;;=^5019273
 ;;^UTILITY(U,$J,358.3,2642,0)
 ;;=R19.8^^6^81^36
 ;;^UTILITY(U,$J,358.3,2642,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2642,1,3,0)
 ;;=3^Symptoms and signs involving the dgstv sys and abdomen NEC
 ;;^UTILITY(U,$J,358.3,2642,1,4,0)
 ;;=4^R19.8
 ;;^UTILITY(U,$J,358.3,2642,2)
 ;;=^5019277
 ;;^UTILITY(U,$J,358.3,2643,0)
 ;;=R10.11^^6^81^35
 ;;^UTILITY(U,$J,358.3,2643,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2643,1,3,0)
 ;;=3^Right upper quadrant pain
 ;;^UTILITY(U,$J,358.3,2643,1,4,0)
 ;;=4^R10.11
 ;;^UTILITY(U,$J,358.3,2643,2)
 ;;=^5019206
 ;;^UTILITY(U,$J,358.3,2644,0)
 ;;=R10.12^^6^81^29
 ;;^UTILITY(U,$J,358.3,2644,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2644,1,3,0)
 ;;=3^Left upper quadrant pain
 ;;^UTILITY(U,$J,358.3,2644,1,4,0)
 ;;=4^R10.12
 ;;^UTILITY(U,$J,358.3,2644,2)
 ;;=^5019207
 ;;^UTILITY(U,$J,358.3,2645,0)
 ;;=R10.31^^6^81^34
 ;;^UTILITY(U,$J,358.3,2645,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2645,1,3,0)
 ;;=3^Right lower quadrant pain
 ;;^UTILITY(U,$J,358.3,2645,1,4,0)
 ;;=4^R10.31
 ;;^UTILITY(U,$J,358.3,2645,2)
 ;;=^5019211
 ;;^UTILITY(U,$J,358.3,2646,0)
 ;;=R10.32^^6^81^28
 ;;^UTILITY(U,$J,358.3,2646,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2646,1,3,0)
 ;;=3^Left lower quadrant pain
 ;;^UTILITY(U,$J,358.3,2646,1,4,0)
 ;;=4^R10.32
 ;;^UTILITY(U,$J,358.3,2646,2)
 ;;=^5019212
 ;;^UTILITY(U,$J,358.3,2647,0)
 ;;=R10.84^^6^81^23
 ;;^UTILITY(U,$J,358.3,2647,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2647,1,3,0)
 ;;=3^Generalized abdominal pain
 ;;^UTILITY(U,$J,358.3,2647,1,4,0)
 ;;=4^R10.84
 ;;^UTILITY(U,$J,358.3,2647,2)
 ;;=^5019229
 ;;^UTILITY(U,$J,358.3,2648,0)
 ;;=R16.0^^6^81^27
 ;;^UTILITY(U,$J,358.3,2648,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2648,1,3,0)
 ;;=3^Hepatomegaly, not elsewhere classified
 ;;^UTILITY(U,$J,358.3,2648,1,4,0)
 ;;=4^R16.0
 ;;^UTILITY(U,$J,358.3,2648,2)
 ;;=^5019248
 ;;^UTILITY(U,$J,358.3,2649,0)
 ;;=R16.2^^6^81^26
 ;;^UTILITY(U,$J,358.3,2649,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2649,1,3,0)
 ;;=3^Hepatomegaly with splenomegaly, not elsewhere classified
 ;;^UTILITY(U,$J,358.3,2649,1,4,0)
 ;;=4^R16.2
 ;;^UTILITY(U,$J,358.3,2649,2)
 ;;=^5019250
 ;;^UTILITY(U,$J,358.3,2650,0)
 ;;=R18.8^^6^81^6
 ;;^UTILITY(U,$J,358.3,2650,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2650,1,3,0)
 ;;=3^Ascites NEC
 ;;^UTILITY(U,$J,358.3,2650,1,4,0)
 ;;=4^R18.8
 ;;^UTILITY(U,$J,358.3,2650,2)
 ;;=^5019253
 ;;^UTILITY(U,$J,358.3,2651,0)
 ;;=R79.89^^6^81^2
 ;;^UTILITY(U,$J,358.3,2651,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2651,1,3,0)
 ;;=3^Abnormal Findings of Blood Chemistry
 ;;^UTILITY(U,$J,358.3,2651,1,4,0)
 ;;=4^R79.89
 ;;^UTILITY(U,$J,358.3,2651,2)
 ;;=^5019593
 ;;^UTILITY(U,$J,358.3,2652,0)
 ;;=R19.5^^6^81^18
 ;;^UTILITY(U,$J,358.3,2652,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2652,1,3,0)
 ;;=3^Fecal Abnormalities NEC
 ;;^UTILITY(U,$J,358.3,2652,1,4,0)
 ;;=4^R19.5
 ;;^UTILITY(U,$J,358.3,2652,2)
 ;;=^5019274
 ;;^UTILITY(U,$J,358.3,2653,0)
 ;;=R07.9^^6^81^8
 ;;^UTILITY(U,$J,358.3,2653,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2653,1,3,0)
 ;;=3^Chest pain, unspecified
 ;;^UTILITY(U,$J,358.3,2653,1,4,0)
 ;;=4^R07.9
 ;;^UTILITY(U,$J,358.3,2653,2)
 ;;=^5019201
 ;;^UTILITY(U,$J,358.3,2654,0)
 ;;=R12.^^6^81^24
 ;;^UTILITY(U,$J,358.3,2654,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2654,1,3,0)
 ;;=3^Heartburn
 ;;^UTILITY(U,$J,358.3,2654,1,4,0)
 ;;=4^R12.
 ;;^UTILITY(U,$J,358.3,2654,2)
 ;;=^5019238
 ;;^UTILITY(U,$J,358.3,2655,0)
 ;;=R13.0^^6^81^5
 ;;^UTILITY(U,$J,358.3,2655,1,0)
 ;;=^358.31IA^4^2
