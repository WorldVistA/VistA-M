IBDEI0ZX ; ; 01-FEB-2022
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 01, 2022
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,16205,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16205,1,3,0)
 ;;=3^Blepharitis,Unspec,Right Upper & Lower Eyelids
 ;;^UTILITY(U,$J,358.3,16205,1,4,0)
 ;;=4^H01.00A
 ;;^UTILITY(U,$J,358.3,16205,2)
 ;;=^5157318
 ;;^UTILITY(U,$J,358.3,16206,0)
 ;;=S05.02XA^^61^770^3
 ;;^UTILITY(U,$J,358.3,16206,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16206,1,3,0)
 ;;=3^Inj Conjunctiva/Corneal Abrasion w/o FB,Left Eye,Init
 ;;^UTILITY(U,$J,358.3,16206,1,4,0)
 ;;=4^S05.02XA
 ;;^UTILITY(U,$J,358.3,16206,2)
 ;;=^5020582
 ;;^UTILITY(U,$J,358.3,16207,0)
 ;;=S05.01XA^^61^770^4
 ;;^UTILITY(U,$J,358.3,16207,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16207,1,3,0)
 ;;=3^Inj Conjunctiva/Corneal Abrasion w/o FB,Right Eye,Init
 ;;^UTILITY(U,$J,358.3,16207,1,4,0)
 ;;=4^S05.01XA
 ;;^UTILITY(U,$J,358.3,16207,2)
 ;;=^5020579
 ;;^UTILITY(U,$J,358.3,16208,0)
 ;;=T15.02XA^^61^770^1
 ;;^UTILITY(U,$J,358.3,16208,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16208,1,3,0)
 ;;=3^Foreign Body in Cornea,Left Eye,Init Encntr
 ;;^UTILITY(U,$J,358.3,16208,1,4,0)
 ;;=4^T15.02XA
 ;;^UTILITY(U,$J,358.3,16208,2)
 ;;=^5046387
 ;;^UTILITY(U,$J,358.3,16209,0)
 ;;=T15.01XA^^61^770^2
 ;;^UTILITY(U,$J,358.3,16209,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16209,1,3,0)
 ;;=3^Foreign Body in Cornea,Right Eye,Init Encntr
 ;;^UTILITY(U,$J,358.3,16209,1,4,0)
 ;;=4^T15.01XA
 ;;^UTILITY(U,$J,358.3,16209,2)
 ;;=^5046384
 ;;^UTILITY(U,$J,358.3,16210,0)
 ;;=S00.252A^^61^770^5
 ;;^UTILITY(U,$J,358.3,16210,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16210,1,3,0)
 ;;=3^Superficial FB of Left Eyelid/Periocular Area,Init Encntr
 ;;^UTILITY(U,$J,358.3,16210,1,4,0)
 ;;=4^S00.252A
 ;;^UTILITY(U,$J,358.3,16210,2)
 ;;=^5019820
 ;;^UTILITY(U,$J,358.3,16211,0)
 ;;=S00.251A^^61^770^6
 ;;^UTILITY(U,$J,358.3,16211,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16211,1,3,0)
 ;;=3^Superficial FB of Right Eyelid/Periocular Area,Init Encntr
 ;;^UTILITY(U,$J,358.3,16211,1,4,0)
 ;;=4^S00.251A
 ;;^UTILITY(U,$J,358.3,16211,2)
 ;;=^5019817
 ;;^UTILITY(U,$J,358.3,16212,0)
 ;;=B96.81^^61^771^64
 ;;^UTILITY(U,$J,358.3,16212,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16212,1,3,0)
 ;;=3^H. Pylori as the Cause of Diseases Classified Elsewhere
 ;;^UTILITY(U,$J,358.3,16212,1,4,0)
 ;;=4^B96.81
 ;;^UTILITY(U,$J,358.3,16212,2)
 ;;=^5000857
 ;;^UTILITY(U,$J,358.3,16213,0)
 ;;=B15.9^^61^771^66
 ;;^UTILITY(U,$J,358.3,16213,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16213,1,3,0)
 ;;=3^Hepatitis A,Acute w/o Hepatic Coma
 ;;^UTILITY(U,$J,358.3,16213,1,4,0)
 ;;=4^B15.9
 ;;^UTILITY(U,$J,358.3,16213,2)
 ;;=^5000536
 ;;^UTILITY(U,$J,358.3,16214,0)
 ;;=B16.9^^61^771^67
 ;;^UTILITY(U,$J,358.3,16214,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16214,1,3,0)
 ;;=3^Hepatitis B,Acute w/o Delta-Agent & w/o Hepatic Coma
 ;;^UTILITY(U,$J,358.3,16214,1,4,0)
 ;;=4^B16.9
 ;;^UTILITY(U,$J,358.3,16214,2)
 ;;=^5000540
 ;;^UTILITY(U,$J,358.3,16215,0)
 ;;=B19.10^^61^771^69
 ;;^UTILITY(U,$J,358.3,16215,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16215,1,3,0)
 ;;=3^Hepatitis B,Viral w/o Hepatic Coma,Unspec
 ;;^UTILITY(U,$J,358.3,16215,1,4,0)
 ;;=4^B19.10
 ;;^UTILITY(U,$J,358.3,16215,2)
 ;;=^5000552
 ;;^UTILITY(U,$J,358.3,16216,0)
 ;;=B18.1^^61^771^68
 ;;^UTILITY(U,$J,358.3,16216,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16216,1,3,0)
 ;;=3^Hepatitis B,Chronic Viral w/o Delta-Agent
 ;;^UTILITY(U,$J,358.3,16216,1,4,0)
 ;;=4^B18.1
