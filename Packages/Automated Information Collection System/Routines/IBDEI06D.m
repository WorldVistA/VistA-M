IBDEI06D ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,2456,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2456,1,3,0)
 ;;=3^Secondary and unsp malignant neoplasm of nodes of head,face and neck
 ;;^UTILITY(U,$J,358.3,2456,1,4,0)
 ;;=4^C77.0
 ;;^UTILITY(U,$J,358.3,2456,2)
 ;;=^5001329
 ;;^UTILITY(U,$J,358.3,2457,0)
 ;;=B37.81^^6^74^6
 ;;^UTILITY(U,$J,358.3,2457,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2457,1,3,0)
 ;;=3^Candidal esophagitis
 ;;^UTILITY(U,$J,358.3,2457,1,4,0)
 ;;=4^B37.81
 ;;^UTILITY(U,$J,358.3,2457,2)
 ;;=^5000620
 ;;^UTILITY(U,$J,358.3,2458,0)
 ;;=C15.9^^6^74^22
 ;;^UTILITY(U,$J,358.3,2458,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2458,1,3,0)
 ;;=3^Malignant neoplasm of esophagus, unspecified
 ;;^UTILITY(U,$J,358.3,2458,1,4,0)
 ;;=4^C15.9
 ;;^UTILITY(U,$J,358.3,2458,2)
 ;;=^5000919
 ;;^UTILITY(U,$J,358.3,2459,0)
 ;;=I85.01^^6^74^11
 ;;^UTILITY(U,$J,358.3,2459,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2459,1,3,0)
 ;;=3^Esophageal varices w/ bleeding
 ;;^UTILITY(U,$J,358.3,2459,1,4,0)
 ;;=4^I85.01
 ;;^UTILITY(U,$J,358.3,2459,2)
 ;;=^269835
 ;;^UTILITY(U,$J,358.3,2460,0)
 ;;=I85.00^^6^74^12
 ;;^UTILITY(U,$J,358.3,2460,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2460,1,3,0)
 ;;=3^Esophageal varices w/o bleeding
 ;;^UTILITY(U,$J,358.3,2460,1,4,0)
 ;;=4^I85.00
 ;;^UTILITY(U,$J,358.3,2460,2)
 ;;=^5008023
 ;;^UTILITY(U,$J,358.3,2461,0)
 ;;=K22.0^^6^74^1
 ;;^UTILITY(U,$J,358.3,2461,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2461,1,3,0)
 ;;=3^Achalasia of cardia
 ;;^UTILITY(U,$J,358.3,2461,1,4,0)
 ;;=4^K22.0
 ;;^UTILITY(U,$J,358.3,2461,2)
 ;;=^5008506
 ;;^UTILITY(U,$J,358.3,2462,0)
 ;;=K20.9^^6^74^14
 ;;^UTILITY(U,$J,358.3,2462,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2462,1,3,0)
 ;;=3^Esophagitis, unspecified
 ;;^UTILITY(U,$J,358.3,2462,1,4,0)
 ;;=4^K20.9
 ;;^UTILITY(U,$J,358.3,2462,2)
 ;;=^295809
 ;;^UTILITY(U,$J,358.3,2463,0)
 ;;=K21.0^^6^74^20
 ;;^UTILITY(U,$J,358.3,2463,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2463,1,3,0)
 ;;=3^Gastro-esophageal reflux disease w/ esophagitis
 ;;^UTILITY(U,$J,358.3,2463,1,4,0)
 ;;=4^K21.0
 ;;^UTILITY(U,$J,358.3,2463,2)
 ;;=^5008504
 ;;^UTILITY(U,$J,358.3,2464,0)
 ;;=K20.0^^6^74^9
 ;;^UTILITY(U,$J,358.3,2464,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2464,1,3,0)
 ;;=3^Eosinophilic esophagitis
 ;;^UTILITY(U,$J,358.3,2464,1,4,0)
 ;;=4^K20.0
 ;;^UTILITY(U,$J,358.3,2464,2)
 ;;=^336605
 ;;^UTILITY(U,$J,358.3,2465,0)
 ;;=K22.10^^6^74^23
 ;;^UTILITY(U,$J,358.3,2465,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2465,1,3,0)
 ;;=3^Ulcer of esophagus w/o bleeding
 ;;^UTILITY(U,$J,358.3,2465,1,4,0)
 ;;=4^K22.10
 ;;^UTILITY(U,$J,358.3,2465,2)
 ;;=^329929
 ;;^UTILITY(U,$J,358.3,2466,0)
 ;;=K22.2^^6^74^10
 ;;^UTILITY(U,$J,358.3,2466,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2466,1,3,0)
 ;;=3^Esophageal obstruction
 ;;^UTILITY(U,$J,358.3,2466,1,4,0)
 ;;=4^K22.2
 ;;^UTILITY(U,$J,358.3,2466,2)
 ;;=^5008507
 ;;^UTILITY(U,$J,358.3,2467,0)
 ;;=K22.5^^6^74^8
 ;;^UTILITY(U,$J,358.3,2467,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2467,1,3,0)
 ;;=3^Diverticulum of esophagus, acquired
 ;;^UTILITY(U,$J,358.3,2467,1,4,0)
 ;;=4^K22.5
 ;;^UTILITY(U,$J,358.3,2467,2)
 ;;=^5008509
 ;;^UTILITY(U,$J,358.3,2468,0)
 ;;=K22.6^^6^74^19
 ;;^UTILITY(U,$J,358.3,2468,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2468,1,3,0)
 ;;=3^Gastro-esophageal laceration-hemorrhage syndrome
 ;;^UTILITY(U,$J,358.3,2468,1,4,0)
 ;;=4^K22.6
 ;;^UTILITY(U,$J,358.3,2468,2)
 ;;=^5008510
 ;;^UTILITY(U,$J,358.3,2469,0)
 ;;=K21.9^^6^74^21
 ;;^UTILITY(U,$J,358.3,2469,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2469,1,3,0)
 ;;=3^Gastro-esophageal reflux disease w/o esophagitis
