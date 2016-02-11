IBDEI0GQ ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,7465,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7465,1,3,0)
 ;;=3^Displacement of Intraperitoneal Dialysis Catheter,Init Encntr
 ;;^UTILITY(U,$J,358.3,7465,1,4,0)
 ;;=4^T85.621A
 ;;^UTILITY(U,$J,358.3,7465,2)
 ;;=^5055625
 ;;^UTILITY(U,$J,358.3,7466,0)
 ;;=T85.621D^^52^501^9
 ;;^UTILITY(U,$J,358.3,7466,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7466,1,3,0)
 ;;=3^Displacement of Intraperitoneal Dialysis Catheter,Subs Encntr
 ;;^UTILITY(U,$J,358.3,7466,1,4,0)
 ;;=4^T85.621D
 ;;^UTILITY(U,$J,358.3,7466,2)
 ;;=^5055626
 ;;^UTILITY(U,$J,358.3,7467,0)
 ;;=K65.0^^52^501^10
 ;;^UTILITY(U,$J,358.3,7467,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7467,1,3,0)
 ;;=3^Generalized (acute) Peritonitis
 ;;^UTILITY(U,$J,358.3,7467,1,4,0)
 ;;=4^K65.0
 ;;^UTILITY(U,$J,358.3,7467,2)
 ;;=^332799
 ;;^UTILITY(U,$J,358.3,7468,0)
 ;;=G60.9^^52^501^14
 ;;^UTILITY(U,$J,358.3,7468,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7468,1,3,0)
 ;;=3^Hereditary & Idiopathic Neuropathy,Unspec
 ;;^UTILITY(U,$J,358.3,7468,1,4,0)
 ;;=4^G60.9
 ;;^UTILITY(U,$J,358.3,7468,2)
 ;;=^5004071
 ;;^UTILITY(U,$J,358.3,7469,0)
 ;;=T82.838A^^52^501^12
 ;;^UTILITY(U,$J,358.3,7469,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7469,1,3,0)
 ;;=3^Hemorrhage of Vascular Graft/Fistula,Init Encntr
 ;;^UTILITY(U,$J,358.3,7469,1,4,0)
 ;;=4^T82.838A
 ;;^UTILITY(U,$J,358.3,7469,2)
 ;;=^5054929
 ;;^UTILITY(U,$J,358.3,7470,0)
 ;;=T82.838D^^52^501^13
 ;;^UTILITY(U,$J,358.3,7470,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7470,1,3,0)
 ;;=3^Hemorrhage of Vascular Graft/Fistula,Subs Encntr
 ;;^UTILITY(U,$J,358.3,7470,1,4,0)
 ;;=4^T82.838D
 ;;^UTILITY(U,$J,358.3,7470,2)
 ;;=^5054930
 ;;^UTILITY(U,$J,358.3,7471,0)
 ;;=E83.81^^52^501^15
 ;;^UTILITY(U,$J,358.3,7471,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7471,1,3,0)
 ;;=3^Hungry Bone Syndrome
 ;;^UTILITY(U,$J,358.3,7471,1,4,0)
 ;;=4^E83.81
 ;;^UTILITY(U,$J,358.3,7471,2)
 ;;=^336538
 ;;^UTILITY(U,$J,358.3,7472,0)
 ;;=T85.71XA^^52^501^21
 ;;^UTILITY(U,$J,358.3,7472,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7472,1,3,0)
 ;;=3^Infection d/t Peritoneal Dialysis Catheter,Init Encntr
 ;;^UTILITY(U,$J,358.3,7472,1,4,0)
 ;;=4^T85.71XA
 ;;^UTILITY(U,$J,358.3,7472,2)
 ;;=^5055670
 ;;^UTILITY(U,$J,358.3,7473,0)
 ;;=T85.71XD^^52^501^22
 ;;^UTILITY(U,$J,358.3,7473,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7473,1,3,0)
 ;;=3^Infection d/t Peritoneal Dialysis Catheter,Subs Encntr
 ;;^UTILITY(U,$J,358.3,7473,1,4,0)
 ;;=4^T85.71XD
 ;;^UTILITY(U,$J,358.3,7473,2)
 ;;=^5055671
 ;;^UTILITY(U,$J,358.3,7474,0)
 ;;=T82.7XXA^^52^501^19
 ;;^UTILITY(U,$J,358.3,7474,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7474,1,3,0)
 ;;=3^Infection d/t Dialysis Catheter or AV Fistula/Graft,Init Encntr
 ;;^UTILITY(U,$J,358.3,7474,1,4,0)
 ;;=4^T82.7XXA
 ;;^UTILITY(U,$J,358.3,7474,2)
 ;;=^5054911
 ;;^UTILITY(U,$J,358.3,7475,0)
 ;;=T82.7XXD^^52^501^20
 ;;^UTILITY(U,$J,358.3,7475,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7475,1,3,0)
 ;;=3^Infection d/t Dialysis Catheter or AV Fistula/Graft,Subs Encntr
 ;;^UTILITY(U,$J,358.3,7475,1,4,0)
 ;;=4^T82.7XXD
 ;;^UTILITY(U,$J,358.3,7475,2)
 ;;=^5054912
 ;;^UTILITY(U,$J,358.3,7476,0)
 ;;=T85.631A^^52^501^23
 ;;^UTILITY(U,$J,358.3,7476,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7476,1,3,0)
 ;;=3^Leakage of Intraperitoneal Dialysis Catheter,Init Encntr
 ;;^UTILITY(U,$J,358.3,7476,1,4,0)
 ;;=4^T85.631A
 ;;^UTILITY(U,$J,358.3,7476,2)
 ;;=^5055643
 ;;^UTILITY(U,$J,358.3,7477,0)
 ;;=T85.631D^^52^501^24
 ;;^UTILITY(U,$J,358.3,7477,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7477,1,3,0)
 ;;=3^Leakage of Intraperitoneal Dialysis Catheter,Subs Encntr
