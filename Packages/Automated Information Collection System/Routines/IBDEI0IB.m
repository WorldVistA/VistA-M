IBDEI0IB ; ; 01-FEB-2022
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 01, 2022
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,8241,0)
 ;;=H57.13^^39^395^12
 ;;^UTILITY(U,$J,358.3,8241,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8241,1,3,0)
 ;;=3^Ocular Pain,Bilateral
 ;;^UTILITY(U,$J,358.3,8241,1,4,0)
 ;;=4^H57.13
 ;;^UTILITY(U,$J,358.3,8241,2)
 ;;=^5006384
 ;;^UTILITY(U,$J,358.3,8242,0)
 ;;=H57.12^^39^395^13
 ;;^UTILITY(U,$J,358.3,8242,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8242,1,3,0)
 ;;=3^Ocular Pain,Left Eye
 ;;^UTILITY(U,$J,358.3,8242,1,4,0)
 ;;=4^H57.12
 ;;^UTILITY(U,$J,358.3,8242,2)
 ;;=^5006383
 ;;^UTILITY(U,$J,358.3,8243,0)
 ;;=H57.11^^39^395^14
 ;;^UTILITY(U,$J,358.3,8243,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8243,1,3,0)
 ;;=3^Ocular Pain,Right Eye
 ;;^UTILITY(U,$J,358.3,8243,1,4,0)
 ;;=4^H57.11
 ;;^UTILITY(U,$J,358.3,8243,2)
 ;;=^5006382
 ;;^UTILITY(U,$J,358.3,8244,0)
 ;;=H01.00B^^39^395^5
 ;;^UTILITY(U,$J,358.3,8244,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8244,1,3,0)
 ;;=3^Blepharitis,Unspec,Left Upper & Lower Eyelids
 ;;^UTILITY(U,$J,358.3,8244,1,4,0)
 ;;=4^H01.00B
 ;;^UTILITY(U,$J,358.3,8244,2)
 ;;=^5157319
 ;;^UTILITY(U,$J,358.3,8245,0)
 ;;=H01.00A^^39^395^6
 ;;^UTILITY(U,$J,358.3,8245,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8245,1,3,0)
 ;;=3^Blepharitis,Unspec,Right Upper & Lower Eyelids
 ;;^UTILITY(U,$J,358.3,8245,1,4,0)
 ;;=4^H01.00A
 ;;^UTILITY(U,$J,358.3,8245,2)
 ;;=^5157318
 ;;^UTILITY(U,$J,358.3,8246,0)
 ;;=S05.02XA^^39^396^3
 ;;^UTILITY(U,$J,358.3,8246,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8246,1,3,0)
 ;;=3^Inj Conjunctiva/Corneal Abrasion w/o FB,Left Eye,Init
 ;;^UTILITY(U,$J,358.3,8246,1,4,0)
 ;;=4^S05.02XA
 ;;^UTILITY(U,$J,358.3,8246,2)
 ;;=^5020582
 ;;^UTILITY(U,$J,358.3,8247,0)
 ;;=S05.01XA^^39^396^4
 ;;^UTILITY(U,$J,358.3,8247,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8247,1,3,0)
 ;;=3^Inj Conjunctiva/Corneal Abrasion w/o FB,Right Eye,Init
 ;;^UTILITY(U,$J,358.3,8247,1,4,0)
 ;;=4^S05.01XA
 ;;^UTILITY(U,$J,358.3,8247,2)
 ;;=^5020579
 ;;^UTILITY(U,$J,358.3,8248,0)
 ;;=T15.02XA^^39^396^1
 ;;^UTILITY(U,$J,358.3,8248,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8248,1,3,0)
 ;;=3^Foreign Body in Cornea,Left Eye,Init Encntr
 ;;^UTILITY(U,$J,358.3,8248,1,4,0)
 ;;=4^T15.02XA
 ;;^UTILITY(U,$J,358.3,8248,2)
 ;;=^5046387
 ;;^UTILITY(U,$J,358.3,8249,0)
 ;;=T15.01XA^^39^396^2
 ;;^UTILITY(U,$J,358.3,8249,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8249,1,3,0)
 ;;=3^Foreign Body in Cornea,Right Eye,Init Encntr
 ;;^UTILITY(U,$J,358.3,8249,1,4,0)
 ;;=4^T15.01XA
 ;;^UTILITY(U,$J,358.3,8249,2)
 ;;=^5046384
 ;;^UTILITY(U,$J,358.3,8250,0)
 ;;=S00.252A^^39^396^5
 ;;^UTILITY(U,$J,358.3,8250,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8250,1,3,0)
 ;;=3^Superficial FB of Left Eyelid/Periocular Area,Init Encntr
 ;;^UTILITY(U,$J,358.3,8250,1,4,0)
 ;;=4^S00.252A
 ;;^UTILITY(U,$J,358.3,8250,2)
 ;;=^5019820
 ;;^UTILITY(U,$J,358.3,8251,0)
 ;;=S00.251A^^39^396^6
 ;;^UTILITY(U,$J,358.3,8251,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8251,1,3,0)
 ;;=3^Superficial FB of Right Eyelid/Periocular Area,Init Encntr
 ;;^UTILITY(U,$J,358.3,8251,1,4,0)
 ;;=4^S00.251A
 ;;^UTILITY(U,$J,358.3,8251,2)
 ;;=^5019817
 ;;^UTILITY(U,$J,358.3,8252,0)
 ;;=B96.81^^39^397^64
 ;;^UTILITY(U,$J,358.3,8252,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8252,1,3,0)
 ;;=3^H. Pylori as the Cause of Diseases Classified Elsewhere
 ;;^UTILITY(U,$J,358.3,8252,1,4,0)
 ;;=4^B96.81
 ;;^UTILITY(U,$J,358.3,8252,2)
 ;;=^5000857
