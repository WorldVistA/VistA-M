IBDEI2GO ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,39306,2)
 ;;=^5020582
 ;;^UTILITY(U,$J,358.3,39307,0)
 ;;=S05.01XA^^152^1995^4
 ;;^UTILITY(U,$J,358.3,39307,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39307,1,3,0)
 ;;=3^Inj Conjunctiva/Corneal Abrasion w/o FB,Right Eye,Init
 ;;^UTILITY(U,$J,358.3,39307,1,4,0)
 ;;=4^S05.01XA
 ;;^UTILITY(U,$J,358.3,39307,2)
 ;;=^5020579
 ;;^UTILITY(U,$J,358.3,39308,0)
 ;;=T15.02XA^^152^1995^1
 ;;^UTILITY(U,$J,358.3,39308,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39308,1,3,0)
 ;;=3^Foreign Body in Cornea,Left Eye,Init Encntr
 ;;^UTILITY(U,$J,358.3,39308,1,4,0)
 ;;=4^T15.02XA
 ;;^UTILITY(U,$J,358.3,39308,2)
 ;;=^5046387
 ;;^UTILITY(U,$J,358.3,39309,0)
 ;;=T15.01XA^^152^1995^2
 ;;^UTILITY(U,$J,358.3,39309,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39309,1,3,0)
 ;;=3^Foreign Body in Cornea,Right Eye,Init Encntr
 ;;^UTILITY(U,$J,358.3,39309,1,4,0)
 ;;=4^T15.01XA
 ;;^UTILITY(U,$J,358.3,39309,2)
 ;;=^5046384
 ;;^UTILITY(U,$J,358.3,39310,0)
 ;;=S00.252A^^152^1995^5
 ;;^UTILITY(U,$J,358.3,39310,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39310,1,3,0)
 ;;=3^Superficial FB of Left Eyelid/Periocular Area,Init Encntr
 ;;^UTILITY(U,$J,358.3,39310,1,4,0)
 ;;=4^S00.252A
 ;;^UTILITY(U,$J,358.3,39310,2)
 ;;=^5019820
 ;;^UTILITY(U,$J,358.3,39311,0)
 ;;=S00.251A^^152^1995^6
 ;;^UTILITY(U,$J,358.3,39311,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39311,1,3,0)
 ;;=3^Superficial FB of Right Eyelid/Periocular Area,Init Encntr
 ;;^UTILITY(U,$J,358.3,39311,1,4,0)
 ;;=4^S00.251A
 ;;^UTILITY(U,$J,358.3,39311,2)
 ;;=^5019817
 ;;^UTILITY(U,$J,358.3,39312,0)
 ;;=B96.81^^152^1996^63
 ;;^UTILITY(U,$J,358.3,39312,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39312,1,3,0)
 ;;=3^H. Pylori as the Cause of Diseases Classified Elsewhere
 ;;^UTILITY(U,$J,358.3,39312,1,4,0)
 ;;=4^B96.81
 ;;^UTILITY(U,$J,358.3,39312,2)
 ;;=^5000857
 ;;^UTILITY(U,$J,358.3,39313,0)
 ;;=B15.9^^152^1996^65
 ;;^UTILITY(U,$J,358.3,39313,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39313,1,3,0)
 ;;=3^Hepatitis A,Acute w/o Hepatic Coma
 ;;^UTILITY(U,$J,358.3,39313,1,4,0)
 ;;=4^B15.9
 ;;^UTILITY(U,$J,358.3,39313,2)
 ;;=^5000536
 ;;^UTILITY(U,$J,358.3,39314,0)
 ;;=B16.9^^152^1996^66
 ;;^UTILITY(U,$J,358.3,39314,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39314,1,3,0)
 ;;=3^Hepatitis B,Acute w/o Delta-Agent & w/o Hepatic Coma
 ;;^UTILITY(U,$J,358.3,39314,1,4,0)
 ;;=4^B16.9
 ;;^UTILITY(U,$J,358.3,39314,2)
 ;;=^5000540
 ;;^UTILITY(U,$J,358.3,39315,0)
 ;;=B19.10^^152^1996^68
 ;;^UTILITY(U,$J,358.3,39315,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39315,1,3,0)
 ;;=3^Hepatitis B,Viral w/o Hepatic Coma,Unspec
 ;;^UTILITY(U,$J,358.3,39315,1,4,0)
 ;;=4^B19.10
 ;;^UTILITY(U,$J,358.3,39315,2)
 ;;=^5000552
 ;;^UTILITY(U,$J,358.3,39316,0)
 ;;=B18.1^^152^1996^67
 ;;^UTILITY(U,$J,358.3,39316,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39316,1,3,0)
 ;;=3^Hepatitis B,Chronic Viral w/o Delta-Agent
 ;;^UTILITY(U,$J,358.3,39316,1,4,0)
 ;;=4^B18.1
 ;;^UTILITY(U,$J,358.3,39316,2)
 ;;=^5000547
 ;;^UTILITY(U,$J,358.3,39317,0)
 ;;=B17.10^^152^1996^69
 ;;^UTILITY(U,$J,358.3,39317,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39317,1,3,0)
 ;;=3^Hepatitis C,Acute w/o Hepatic Coma
 ;;^UTILITY(U,$J,358.3,39317,1,4,0)
 ;;=4^B17.10
 ;;^UTILITY(U,$J,358.3,39317,2)
 ;;=^5000542
 ;;^UTILITY(U,$J,358.3,39318,0)
 ;;=B18.2^^152^1996^70
 ;;^UTILITY(U,$J,358.3,39318,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39318,1,3,0)
 ;;=3^Hepatitis C,Chronic Viral
