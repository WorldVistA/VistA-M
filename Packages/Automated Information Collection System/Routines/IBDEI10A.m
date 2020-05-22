IBDEI10A ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,16179,1,3,0)
 ;;=3^Inj Conjunctiva/Corneal Abrasion w/o FB,Left Eye,Init
 ;;^UTILITY(U,$J,358.3,16179,1,4,0)
 ;;=4^S05.02XA
 ;;^UTILITY(U,$J,358.3,16179,2)
 ;;=^5020582
 ;;^UTILITY(U,$J,358.3,16180,0)
 ;;=S05.01XA^^88^874^4
 ;;^UTILITY(U,$J,358.3,16180,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16180,1,3,0)
 ;;=3^Inj Conjunctiva/Corneal Abrasion w/o FB,Right Eye,Init
 ;;^UTILITY(U,$J,358.3,16180,1,4,0)
 ;;=4^S05.01XA
 ;;^UTILITY(U,$J,358.3,16180,2)
 ;;=^5020579
 ;;^UTILITY(U,$J,358.3,16181,0)
 ;;=T15.02XA^^88^874^1
 ;;^UTILITY(U,$J,358.3,16181,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16181,1,3,0)
 ;;=3^Foreign Body in Cornea,Left Eye,Init Encntr
 ;;^UTILITY(U,$J,358.3,16181,1,4,0)
 ;;=4^T15.02XA
 ;;^UTILITY(U,$J,358.3,16181,2)
 ;;=^5046387
 ;;^UTILITY(U,$J,358.3,16182,0)
 ;;=T15.01XA^^88^874^2
 ;;^UTILITY(U,$J,358.3,16182,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16182,1,3,0)
 ;;=3^Foreign Body in Cornea,Right Eye,Init Encntr
 ;;^UTILITY(U,$J,358.3,16182,1,4,0)
 ;;=4^T15.01XA
 ;;^UTILITY(U,$J,358.3,16182,2)
 ;;=^5046384
 ;;^UTILITY(U,$J,358.3,16183,0)
 ;;=S00.252A^^88^874^5
 ;;^UTILITY(U,$J,358.3,16183,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16183,1,3,0)
 ;;=3^Superficial FB of Left Eyelid/Periocular Area,Init Encntr
 ;;^UTILITY(U,$J,358.3,16183,1,4,0)
 ;;=4^S00.252A
 ;;^UTILITY(U,$J,358.3,16183,2)
 ;;=^5019820
 ;;^UTILITY(U,$J,358.3,16184,0)
 ;;=S00.251A^^88^874^6
 ;;^UTILITY(U,$J,358.3,16184,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16184,1,3,0)
 ;;=3^Superficial FB of Right Eyelid/Periocular Area,Init Encntr
 ;;^UTILITY(U,$J,358.3,16184,1,4,0)
 ;;=4^S00.251A
 ;;^UTILITY(U,$J,358.3,16184,2)
 ;;=^5019817
 ;;^UTILITY(U,$J,358.3,16185,0)
 ;;=B96.81^^88^875^63
 ;;^UTILITY(U,$J,358.3,16185,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16185,1,3,0)
 ;;=3^H. Pylori as the Cause of Diseases Classified Elsewhere
 ;;^UTILITY(U,$J,358.3,16185,1,4,0)
 ;;=4^B96.81
 ;;^UTILITY(U,$J,358.3,16185,2)
 ;;=^5000857
 ;;^UTILITY(U,$J,358.3,16186,0)
 ;;=B15.9^^88^875^65
 ;;^UTILITY(U,$J,358.3,16186,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16186,1,3,0)
 ;;=3^Hepatitis A,Acute w/o Hepatic Coma
 ;;^UTILITY(U,$J,358.3,16186,1,4,0)
 ;;=4^B15.9
 ;;^UTILITY(U,$J,358.3,16186,2)
 ;;=^5000536
 ;;^UTILITY(U,$J,358.3,16187,0)
 ;;=B16.9^^88^875^66
 ;;^UTILITY(U,$J,358.3,16187,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16187,1,3,0)
 ;;=3^Hepatitis B,Acute w/o Delta-Agent & w/o Hepatic Coma
 ;;^UTILITY(U,$J,358.3,16187,1,4,0)
 ;;=4^B16.9
 ;;^UTILITY(U,$J,358.3,16187,2)
 ;;=^5000540
 ;;^UTILITY(U,$J,358.3,16188,0)
 ;;=B19.10^^88^875^68
 ;;^UTILITY(U,$J,358.3,16188,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16188,1,3,0)
 ;;=3^Hepatitis B,Viral w/o Hepatic Coma,Unspec
 ;;^UTILITY(U,$J,358.3,16188,1,4,0)
 ;;=4^B19.10
 ;;^UTILITY(U,$J,358.3,16188,2)
 ;;=^5000552
 ;;^UTILITY(U,$J,358.3,16189,0)
 ;;=B18.1^^88^875^67
 ;;^UTILITY(U,$J,358.3,16189,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16189,1,3,0)
 ;;=3^Hepatitis B,Chronic Viral w/o Delta-Agent
 ;;^UTILITY(U,$J,358.3,16189,1,4,0)
 ;;=4^B18.1
 ;;^UTILITY(U,$J,358.3,16189,2)
 ;;=^5000547
 ;;^UTILITY(U,$J,358.3,16190,0)
 ;;=B17.10^^88^875^69
 ;;^UTILITY(U,$J,358.3,16190,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16190,1,3,0)
 ;;=3^Hepatitis C,Acute w/o Hepatic Coma
 ;;^UTILITY(U,$J,358.3,16190,1,4,0)
 ;;=4^B17.10
 ;;^UTILITY(U,$J,358.3,16190,2)
 ;;=^5000542
