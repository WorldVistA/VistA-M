IBDEI06E ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,2469,1,4,0)
 ;;=4^K21.9
 ;;^UTILITY(U,$J,358.3,2469,2)
 ;;=^5008505
 ;;^UTILITY(U,$J,358.3,2470,0)
 ;;=K22.70^^6^74^5
 ;;^UTILITY(U,$J,358.3,2470,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2470,1,3,0)
 ;;=3^Barrett's esophagus w/o dysplasia
 ;;^UTILITY(U,$J,358.3,2470,1,4,0)
 ;;=4^K22.70
 ;;^UTILITY(U,$J,358.3,2470,2)
 ;;=^5008511
 ;;^UTILITY(U,$J,358.3,2471,0)
 ;;=K22.710^^6^74^4
 ;;^UTILITY(U,$J,358.3,2471,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2471,1,3,0)
 ;;=3^Barrett's esophagus w/ low grade dysplasia
 ;;^UTILITY(U,$J,358.3,2471,1,4,0)
 ;;=4^K22.710
 ;;^UTILITY(U,$J,358.3,2471,2)
 ;;=^5008512
 ;;^UTILITY(U,$J,358.3,2472,0)
 ;;=K22.711^^6^74^3
 ;;^UTILITY(U,$J,358.3,2472,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2472,1,3,0)
 ;;=3^Barrett's esophagus w/ high grade dysplasia
 ;;^UTILITY(U,$J,358.3,2472,1,4,0)
 ;;=4^K22.711
 ;;^UTILITY(U,$J,358.3,2472,2)
 ;;=^5008513
 ;;^UTILITY(U,$J,358.3,2473,0)
 ;;=K22.719^^6^74^2
 ;;^UTILITY(U,$J,358.3,2473,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2473,1,3,0)
 ;;=3^Barrett's esophagus w/ dysplasia, unspecified
 ;;^UTILITY(U,$J,358.3,2473,1,4,0)
 ;;=4^K22.719
 ;;^UTILITY(U,$J,358.3,2473,2)
 ;;=^5008514
 ;;^UTILITY(U,$J,358.3,2474,0)
 ;;=K44.9^^6^74^7
 ;;^UTILITY(U,$J,358.3,2474,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2474,1,3,0)
 ;;=3^Diaphragmatic hernia w/o obstruction or gangrene
 ;;^UTILITY(U,$J,358.3,2474,1,4,0)
 ;;=4^K44.9
 ;;^UTILITY(U,$J,358.3,2474,2)
 ;;=^5008617
 ;;^UTILITY(U,$J,358.3,2475,0)
 ;;=Q39.4^^6^74^13
 ;;^UTILITY(U,$J,358.3,2475,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2475,1,3,0)
 ;;=3^Esophageal web
 ;;^UTILITY(U,$J,358.3,2475,1,4,0)
 ;;=4^Q39.4
 ;;^UTILITY(U,$J,358.3,2475,2)
 ;;=^5018659
 ;;^UTILITY(U,$J,358.3,2476,0)
 ;;=T18.108A^^6^74^16
 ;;^UTILITY(U,$J,358.3,2476,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2476,1,3,0)
 ;;=3^Foreign body in esophagus causing oth injury, init
 ;;^UTILITY(U,$J,358.3,2476,1,4,0)
 ;;=4^T18.108A
 ;;^UTILITY(U,$J,358.3,2476,2)
 ;;=^5046582
 ;;^UTILITY(U,$J,358.3,2477,0)
 ;;=T18.118A^^6^74^18
 ;;^UTILITY(U,$J,358.3,2477,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2477,1,3,0)
 ;;=3^Gastric contents in esophagus causing oth injury, init
 ;;^UTILITY(U,$J,358.3,2477,1,4,0)
 ;;=4^T18.118A
 ;;^UTILITY(U,$J,358.3,2477,2)
 ;;=^5046588
 ;;^UTILITY(U,$J,358.3,2478,0)
 ;;=T18.128A^^6^74^15
 ;;^UTILITY(U,$J,358.3,2478,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2478,1,3,0)
 ;;=3^Food in esophagus causing other injury, initial encounter
 ;;^UTILITY(U,$J,358.3,2478,1,4,0)
 ;;=4^T18.128A
 ;;^UTILITY(U,$J,358.3,2478,2)
 ;;=^5046594
 ;;^UTILITY(U,$J,358.3,2479,0)
 ;;=T18.198A^^6^74^17
 ;;^UTILITY(U,$J,358.3,2479,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2479,1,3,0)
 ;;=3^Foreign object in esophagus causing oth injury, init
 ;;^UTILITY(U,$J,358.3,2479,1,4,0)
 ;;=4^T18.198A
 ;;^UTILITY(U,$J,358.3,2479,2)
 ;;=^5046600
 ;;^UTILITY(U,$J,358.3,2480,0)
 ;;=A63.0^^6^75^7
 ;;^UTILITY(U,$J,358.3,2480,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2480,1,3,0)
 ;;=3^Anogenital (venereal) warts
 ;;^UTILITY(U,$J,358.3,2480,1,4,0)
 ;;=4^A63.0
 ;;^UTILITY(U,$J,358.3,2480,2)
 ;;=^5000360
 ;;^UTILITY(U,$J,358.3,2481,0)
 ;;=C18.9^^6^75^42
 ;;^UTILITY(U,$J,358.3,2481,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2481,1,3,0)
 ;;=3^Malignant neoplasm of colon, unspecified
 ;;^UTILITY(U,$J,358.3,2481,1,4,0)
 ;;=4^C18.9
 ;;^UTILITY(U,$J,358.3,2481,2)
 ;;=^5000929
 ;;^UTILITY(U,$J,358.3,2482,0)
 ;;=D12.5^^6^75^16
 ;;^UTILITY(U,$J,358.3,2482,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2482,1,3,0)
 ;;=3^Benign neoplasm of sigmoid colon
