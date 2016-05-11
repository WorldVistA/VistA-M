IBDEI1LX ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,27267,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27267,1,3,0)
 ;;=3^Renal Osteodystrophy
 ;;^UTILITY(U,$J,358.3,27267,1,4,0)
 ;;=4^N25.0
 ;;^UTILITY(U,$J,358.3,27267,2)
 ;;=^104747
 ;;^UTILITY(U,$J,358.3,27268,0)
 ;;=T80.211A^^106^1346^3
 ;;^UTILITY(U,$J,358.3,27268,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27268,1,3,0)
 ;;=3^Bloodstream Infection d/t Central Venous Catheter,Init Encntr
 ;;^UTILITY(U,$J,358.3,27268,1,4,0)
 ;;=4^T80.211A
 ;;^UTILITY(U,$J,358.3,27268,2)
 ;;=^5054350
 ;;^UTILITY(U,$J,358.3,27269,0)
 ;;=T80.211D^^106^1346^4
 ;;^UTILITY(U,$J,358.3,27269,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27269,1,3,0)
 ;;=3^Bloodstream Infection d/t Central Venous Catheter,Subs Encntr
 ;;^UTILITY(U,$J,358.3,27269,1,4,0)
 ;;=4^T80.211D
 ;;^UTILITY(U,$J,358.3,27269,2)
 ;;=^5054351
 ;;^UTILITY(U,$J,358.3,27270,0)
 ;;=E83.59^^106^1346^5
 ;;^UTILITY(U,$J,358.3,27270,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27270,1,3,0)
 ;;=3^Calciphylaxis
 ;;^UTILITY(U,$J,358.3,27270,1,4,0)
 ;;=4^E83.59
 ;;^UTILITY(U,$J,358.3,27270,2)
 ;;=^5003006
 ;;^UTILITY(U,$J,358.3,27271,0)
 ;;=T85.621A^^106^1346^8
 ;;^UTILITY(U,$J,358.3,27271,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27271,1,3,0)
 ;;=3^Displacement of Intraperitoneal Dialysis Catheter,Init Encntr
 ;;^UTILITY(U,$J,358.3,27271,1,4,0)
 ;;=4^T85.621A
 ;;^UTILITY(U,$J,358.3,27271,2)
 ;;=^5055625
 ;;^UTILITY(U,$J,358.3,27272,0)
 ;;=T85.621D^^106^1346^9
 ;;^UTILITY(U,$J,358.3,27272,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27272,1,3,0)
 ;;=3^Displacement of Intraperitoneal Dialysis Catheter,Subs Encntr
 ;;^UTILITY(U,$J,358.3,27272,1,4,0)
 ;;=4^T85.621D
 ;;^UTILITY(U,$J,358.3,27272,2)
 ;;=^5055626
 ;;^UTILITY(U,$J,358.3,27273,0)
 ;;=K65.0^^106^1346^10
 ;;^UTILITY(U,$J,358.3,27273,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27273,1,3,0)
 ;;=3^Generalized (acute) Peritonitis
 ;;^UTILITY(U,$J,358.3,27273,1,4,0)
 ;;=4^K65.0
 ;;^UTILITY(U,$J,358.3,27273,2)
 ;;=^332799
 ;;^UTILITY(U,$J,358.3,27274,0)
 ;;=G60.9^^106^1346^14
 ;;^UTILITY(U,$J,358.3,27274,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27274,1,3,0)
 ;;=3^Hereditary & Idiopathic Neuropathy,Unspec
 ;;^UTILITY(U,$J,358.3,27274,1,4,0)
 ;;=4^G60.9
 ;;^UTILITY(U,$J,358.3,27274,2)
 ;;=^5004071
 ;;^UTILITY(U,$J,358.3,27275,0)
 ;;=T82.838A^^106^1346^12
 ;;^UTILITY(U,$J,358.3,27275,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27275,1,3,0)
 ;;=3^Hemorrhage of Vascular Graft/Fistula,Init Encntr
 ;;^UTILITY(U,$J,358.3,27275,1,4,0)
 ;;=4^T82.838A
 ;;^UTILITY(U,$J,358.3,27275,2)
 ;;=^5054929
 ;;^UTILITY(U,$J,358.3,27276,0)
 ;;=T82.838D^^106^1346^13
 ;;^UTILITY(U,$J,358.3,27276,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27276,1,3,0)
 ;;=3^Hemorrhage of Vascular Graft/Fistula,Subs Encntr
 ;;^UTILITY(U,$J,358.3,27276,1,4,0)
 ;;=4^T82.838D
 ;;^UTILITY(U,$J,358.3,27276,2)
 ;;=^5054930
 ;;^UTILITY(U,$J,358.3,27277,0)
 ;;=E83.81^^106^1346^15
 ;;^UTILITY(U,$J,358.3,27277,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27277,1,3,0)
 ;;=3^Hungry Bone Syndrome
 ;;^UTILITY(U,$J,358.3,27277,1,4,0)
 ;;=4^E83.81
 ;;^UTILITY(U,$J,358.3,27277,2)
 ;;=^336538
 ;;^UTILITY(U,$J,358.3,27278,0)
 ;;=T85.71XA^^106^1346^21
 ;;^UTILITY(U,$J,358.3,27278,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27278,1,3,0)
 ;;=3^Infection d/t Peritoneal Dialysis Catheter,Init Encntr
 ;;^UTILITY(U,$J,358.3,27278,1,4,0)
 ;;=4^T85.71XA
 ;;^UTILITY(U,$J,358.3,27278,2)
 ;;=^5055670
 ;;^UTILITY(U,$J,358.3,27279,0)
 ;;=T85.71XD^^106^1346^22
 ;;^UTILITY(U,$J,358.3,27279,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27279,1,3,0)
 ;;=3^Infection d/t Peritoneal Dialysis Catheter,Subs Encntr
