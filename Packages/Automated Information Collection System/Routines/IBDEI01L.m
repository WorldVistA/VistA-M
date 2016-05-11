IBDEI01L ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,244,1,4,0)
 ;;=4^N94.3
 ;;^UTILITY(U,$J,358.3,244,2)
 ;;=^5015919
 ;;^UTILITY(U,$J,358.3,245,0)
 ;;=G31.84^^3^28^21
 ;;^UTILITY(U,$J,358.3,245,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,245,1,3,0)
 ;;=3^Mild Cognitive Impairment,So Stated
 ;;^UTILITY(U,$J,358.3,245,1,4,0)
 ;;=4^G31.84
 ;;^UTILITY(U,$J,358.3,245,2)
 ;;=^5003813
 ;;^UTILITY(U,$J,358.3,246,0)
 ;;=F44.81^^3^29^6
 ;;^UTILITY(U,$J,358.3,246,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,246,1,3,0)
 ;;=3^Dissociative Identity Disorder
 ;;^UTILITY(U,$J,358.3,246,1,4,0)
 ;;=4^F44.81
 ;;^UTILITY(U,$J,358.3,246,2)
 ;;=^331909
 ;;^UTILITY(U,$J,358.3,247,0)
 ;;=F44.9^^3^29^5
 ;;^UTILITY(U,$J,358.3,247,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,247,1,3,0)
 ;;=3^Dissociative Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,247,1,4,0)
 ;;=4^F44.9
 ;;^UTILITY(U,$J,358.3,247,2)
 ;;=^5003584
 ;;^UTILITY(U,$J,358.3,248,0)
 ;;=F44.0^^3^29^2
 ;;^UTILITY(U,$J,358.3,248,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,248,1,3,0)
 ;;=3^Dissociative Amnesia
 ;;^UTILITY(U,$J,358.3,248,1,4,0)
 ;;=4^F44.0
 ;;^UTILITY(U,$J,358.3,248,2)
 ;;=^5003577
 ;;^UTILITY(U,$J,358.3,249,0)
 ;;=F48.1^^3^29^1
 ;;^UTILITY(U,$J,358.3,249,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,249,1,3,0)
 ;;=3^Depersonalization/Derealization Disorder
 ;;^UTILITY(U,$J,358.3,249,1,4,0)
 ;;=4^F48.1
 ;;^UTILITY(U,$J,358.3,249,2)
 ;;=^5003593
 ;;^UTILITY(U,$J,358.3,250,0)
 ;;=F44.89^^3^29^4
 ;;^UTILITY(U,$J,358.3,250,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,250,1,3,0)
 ;;=3^Dissociative Disorder NEC
 ;;^UTILITY(U,$J,358.3,250,1,4,0)
 ;;=4^F44.89
 ;;^UTILITY(U,$J,358.3,250,2)
 ;;=^5003583
 ;;^UTILITY(U,$J,358.3,251,0)
 ;;=F44.1^^3^29^3
 ;;^UTILITY(U,$J,358.3,251,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,251,1,3,0)
 ;;=3^Dissociative Amnesia w/ Dissociative Fugue
 ;;^UTILITY(U,$J,358.3,251,1,4,0)
 ;;=4^F44.1
 ;;^UTILITY(U,$J,358.3,251,2)
 ;;=^331908
 ;;^UTILITY(U,$J,358.3,252,0)
 ;;=F50.02^^3^30^1
 ;;^UTILITY(U,$J,358.3,252,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,252,1,3,0)
 ;;=3^Anorexia Nervosa,Binge-Eating/Purging Type
 ;;^UTILITY(U,$J,358.3,252,1,4,0)
 ;;=4^F50.02
 ;;^UTILITY(U,$J,358.3,252,2)
 ;;=^5003599
 ;;^UTILITY(U,$J,358.3,253,0)
 ;;=F50.01^^3^30^2
 ;;^UTILITY(U,$J,358.3,253,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,253,1,3,0)
 ;;=3^Anorexia Nervosa,Restricting Type
 ;;^UTILITY(U,$J,358.3,253,1,4,0)
 ;;=4^F50.01
 ;;^UTILITY(U,$J,358.3,253,2)
 ;;=^5003598
 ;;^UTILITY(U,$J,358.3,254,0)
 ;;=F50.9^^3^30^7
 ;;^UTILITY(U,$J,358.3,254,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,254,1,3,0)
 ;;=3^Feeding/Eating Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,254,1,4,0)
 ;;=4^F50.9
 ;;^UTILITY(U,$J,358.3,254,2)
 ;;=^5003602
 ;;^UTILITY(U,$J,358.3,255,0)
 ;;=F50.8^^3^30^6
 ;;^UTILITY(U,$J,358.3,255,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,255,1,3,0)
 ;;=3^Feeding/Eating Disorder NEC
 ;;^UTILITY(U,$J,358.3,255,1,4,0)
 ;;=4^F50.8
 ;;^UTILITY(U,$J,358.3,255,2)
 ;;=^5003601
 ;;^UTILITY(U,$J,358.3,256,0)
 ;;=F50.8^^3^30^3
 ;;^UTILITY(U,$J,358.3,256,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,256,1,3,0)
 ;;=3^Avoidant/Restrictive Food Intake Disorder
 ;;^UTILITY(U,$J,358.3,256,1,4,0)
 ;;=4^F50.8
 ;;^UTILITY(U,$J,358.3,256,2)
 ;;=^5003601
 ;;^UTILITY(U,$J,358.3,257,0)
 ;;=F50.8^^3^30^4
 ;;^UTILITY(U,$J,358.3,257,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,257,1,3,0)
 ;;=3^Binge-Eating Disorder
 ;;^UTILITY(U,$J,358.3,257,1,4,0)
 ;;=4^F50.8
 ;;^UTILITY(U,$J,358.3,257,2)
 ;;=^5003601
 ;;^UTILITY(U,$J,358.3,258,0)
 ;;=F50.2^^3^30^5
 ;;^UTILITY(U,$J,358.3,258,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,258,1,3,0)
 ;;=3^Bulimia Nervosa
