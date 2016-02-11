IBDEI0RB ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,12516,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12516,1,3,0)
 ;;=3^Acromegaly and Pituitary Gigantism
 ;;^UTILITY(U,$J,358.3,12516,1,4,0)
 ;;=4^E22.0
 ;;^UTILITY(U,$J,358.3,12516,2)
 ;;=^5002717
 ;;^UTILITY(U,$J,358.3,12517,0)
 ;;=E24.0^^74^722^76
 ;;^UTILITY(U,$J,358.3,12517,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12517,1,3,0)
 ;;=3^Pituitary-Dependent Cushing's Disease
 ;;^UTILITY(U,$J,358.3,12517,1,4,0)
 ;;=4^E24.0
 ;;^UTILITY(U,$J,358.3,12517,2)
 ;;=^5002725
 ;;^UTILITY(U,$J,358.3,12518,0)
 ;;=E24.1^^74^722^65
 ;;^UTILITY(U,$J,358.3,12518,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12518,1,3,0)
 ;;=3^Nelson's Syndrome
 ;;^UTILITY(U,$J,358.3,12518,1,4,0)
 ;;=4^E24.1
 ;;^UTILITY(U,$J,358.3,12518,2)
 ;;=^5002726
 ;;^UTILITY(U,$J,358.3,12519,0)
 ;;=E24.2^^74^722^33
 ;;^UTILITY(U,$J,358.3,12519,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12519,1,3,0)
 ;;=3^Drug-Induced Cushing's Syndrome
 ;;^UTILITY(U,$J,358.3,12519,1,4,0)
 ;;=4^E24.2
 ;;^UTILITY(U,$J,358.3,12519,2)
 ;;=^5002727
 ;;^UTILITY(U,$J,358.3,12520,0)
 ;;=E24.4^^74^722^3
 ;;^UTILITY(U,$J,358.3,12520,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12520,1,3,0)
 ;;=3^Alcohol-Induced Pseudo-Cushing's Syndrome
 ;;^UTILITY(U,$J,358.3,12520,1,4,0)
 ;;=4^E24.4
 ;;^UTILITY(U,$J,358.3,12520,2)
 ;;=^5002729
 ;;^UTILITY(U,$J,358.3,12521,0)
 ;;=E24.8^^74^722^18
 ;;^UTILITY(U,$J,358.3,12521,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12521,1,3,0)
 ;;=3^Cushing's Syndrome NEC
 ;;^UTILITY(U,$J,358.3,12521,1,4,0)
 ;;=4^E24.8
 ;;^UTILITY(U,$J,358.3,12521,2)
 ;;=^5002730
 ;;^UTILITY(U,$J,358.3,12522,0)
 ;;=E24.9^^74^722^19
 ;;^UTILITY(U,$J,358.3,12522,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12522,1,3,0)
 ;;=3^Cushing's Syndrome,Unspec
 ;;^UTILITY(U,$J,358.3,12522,1,4,0)
 ;;=4^E24.9
 ;;^UTILITY(U,$J,358.3,12522,2)
 ;;=^5002731
 ;;^UTILITY(U,$J,358.3,12523,0)
 ;;=E05.00^^74^722^38
 ;;^UTILITY(U,$J,358.3,12523,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12523,1,3,0)
 ;;=3^Graves Disease
 ;;^UTILITY(U,$J,358.3,12523,1,4,0)
 ;;=4^E05.00
 ;;^UTILITY(U,$J,358.3,12523,2)
 ;;=^5002481
 ;;^UTILITY(U,$J,358.3,12524,0)
 ;;=D44.0^^74^722^74
 ;;^UTILITY(U,$J,358.3,12524,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12524,1,3,0)
 ;;=3^Neoplasm of Thyroid Gland,Uncertain Behavior
 ;;^UTILITY(U,$J,358.3,12524,1,4,0)
 ;;=4^D44.0
 ;;^UTILITY(U,$J,358.3,12524,2)
 ;;=^5002235
 ;;^UTILITY(U,$J,358.3,12525,0)
 ;;=D44.11^^74^722^73
 ;;^UTILITY(U,$J,358.3,12525,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12525,1,3,0)
 ;;=3^Neoplasm of Right Adrenal Gland,Uncertain Behavior
 ;;^UTILITY(U,$J,358.3,12525,1,4,0)
 ;;=4^D44.11
 ;;^UTILITY(U,$J,358.3,12525,2)
 ;;=^5002237
 ;;^UTILITY(U,$J,358.3,12526,0)
 ;;=D44.12^^74^722^70
 ;;^UTILITY(U,$J,358.3,12526,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12526,1,3,0)
 ;;=3^Neoplasm of Left Adrenal Gland,Uncertain Behavior
 ;;^UTILITY(U,$J,358.3,12526,1,4,0)
 ;;=4^D44.12
 ;;^UTILITY(U,$J,358.3,12526,2)
 ;;=^5002238
 ;;^UTILITY(U,$J,358.3,12527,0)
 ;;=D44.2^^74^722^71
 ;;^UTILITY(U,$J,358.3,12527,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12527,1,3,0)
 ;;=3^Neoplasm of Parathyroid Gland,Uncertain Behavior
 ;;^UTILITY(U,$J,358.3,12527,1,4,0)
 ;;=4^D44.2
 ;;^UTILITY(U,$J,358.3,12527,2)
 ;;=^5002239
 ;;^UTILITY(U,$J,358.3,12528,0)
 ;;=D44.3^^74^722^66
 ;;^UTILITY(U,$J,358.3,12528,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12528,1,3,0)
 ;;=3^Neoplams of Pituitary Gland,Uncertain Behavior
 ;;^UTILITY(U,$J,358.3,12528,1,4,0)
 ;;=4^D44.3
 ;;^UTILITY(U,$J,358.3,12528,2)
 ;;=^5002240
 ;;^UTILITY(U,$J,358.3,12529,0)
 ;;=D44.4^^74^722^69
