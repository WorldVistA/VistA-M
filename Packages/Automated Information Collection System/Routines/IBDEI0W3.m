IBDEI0W3 ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,14285,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14285,1,3,0)
 ;;=3^Walking,Difficulty NEC
 ;;^UTILITY(U,$J,358.3,14285,1,4,0)
 ;;=4^R26.2
 ;;^UTILITY(U,$J,358.3,14285,2)
 ;;=^5019306
 ;;^UTILITY(U,$J,358.3,14286,0)
 ;;=R53.1^^83^822^148
 ;;^UTILITY(U,$J,358.3,14286,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14286,1,3,0)
 ;;=3^Weakness
 ;;^UTILITY(U,$J,358.3,14286,1,4,0)
 ;;=4^R53.1
 ;;^UTILITY(U,$J,358.3,14286,2)
 ;;=^5019516
 ;;^UTILITY(U,$J,358.3,14287,0)
 ;;=R29.810^^83^822^149
 ;;^UTILITY(U,$J,358.3,14287,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14287,1,3,0)
 ;;=3^Weakness,Facial
 ;;^UTILITY(U,$J,358.3,14287,1,4,0)
 ;;=4^R29.810
 ;;^UTILITY(U,$J,358.3,14287,2)
 ;;=^329954
 ;;^UTILITY(U,$J,358.3,14288,0)
 ;;=I69.010^^83^822^8
 ;;^UTILITY(U,$J,358.3,14288,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14288,1,3,0)
 ;;=3^Attn & Concentration Deficit After Ntrm Subarach Hemor
 ;;^UTILITY(U,$J,358.3,14288,1,4,0)
 ;;=4^I69.010
 ;;^UTILITY(U,$J,358.3,14288,2)
 ;;=^5138620
 ;;^UTILITY(U,$J,358.3,14289,0)
 ;;=I69.011^^83^822^88
 ;;^UTILITY(U,$J,358.3,14289,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14289,1,3,0)
 ;;=3^Memory Deficit After Subarachnoid Hemorrhage
 ;;^UTILITY(U,$J,358.3,14289,1,4,0)
 ;;=4^I69.011
 ;;^UTILITY(U,$J,358.3,14289,2)
 ;;=^5138621
 ;;^UTILITY(U,$J,358.3,14290,0)
 ;;=I69.012^^83^822^146
 ;;^UTILITY(U,$J,358.3,14290,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14290,1,3,0)
 ;;=3^Vis Def/Sptl Nglct After Ntrm Subarachnoid Hemorrhage
 ;;^UTILITY(U,$J,358.3,14290,1,4,0)
 ;;=4^I69.012
 ;;^UTILITY(U,$J,358.3,14290,2)
 ;;=^5138622
 ;;^UTILITY(U,$J,358.3,14291,0)
 ;;=I69.013^^83^822^133
 ;;^UTILITY(U,$J,358.3,14291,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14291,1,3,0)
 ;;=3^Psychomotor Deficit After Ntrm Subarachnoid Hemorrhage
 ;;^UTILITY(U,$J,358.3,14291,1,4,0)
 ;;=4^I69.013
 ;;^UTILITY(U,$J,358.3,14291,2)
 ;;=^5138623
 ;;^UTILITY(U,$J,358.3,14292,0)
 ;;=I69.014^^83^822^74
 ;;^UTILITY(U,$J,358.3,14292,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14292,1,3,0)
 ;;=3^Fntl Lobe & Exec Fcn Deficit After Ntrm Subarachnoid Hemorrhage
 ;;^UTILITY(U,$J,358.3,14292,1,4,0)
 ;;=4^I69.014
 ;;^UTILITY(U,$J,358.3,14292,2)
 ;;=^5138624
 ;;^UTILITY(U,$J,358.3,14293,0)
 ;;=I69.015^^83^822^49
 ;;^UTILITY(U,$J,358.3,14293,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14293,1,3,0)
 ;;=3^Cognitive Social/Emotional Deficit After Ntrm Subarachnoid Hemorrage
 ;;^UTILITY(U,$J,358.3,14293,1,4,0)
 ;;=4^I69.015
 ;;^UTILITY(U,$J,358.3,14293,2)
 ;;=^5138625
 ;;^UTILITY(U,$J,358.3,14294,0)
 ;;=I69.018^^83^822^47
 ;;^UTILITY(U,$J,358.3,14294,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14294,1,3,0)
 ;;=3^Cognitive Fnctn Symptoms/Signs After Ntrm Subarachnoid Hemorrage,Other
 ;;^UTILITY(U,$J,358.3,14294,1,4,0)
 ;;=4^I69.018
 ;;^UTILITY(U,$J,358.3,14294,2)
 ;;=^5138626
 ;;^UTILITY(U,$J,358.3,14295,0)
 ;;=I69.110^^83^822^9
 ;;^UTILITY(U,$J,358.3,14295,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14295,1,3,0)
 ;;=3^Attn & Concentration Deficit After Ntrm Intcrbl Hemorrhage
 ;;^UTILITY(U,$J,358.3,14295,1,4,0)
 ;;=4^I69.110
 ;;^UTILITY(U,$J,358.3,14295,2)
 ;;=^5138628
 ;;^UTILITY(U,$J,358.3,14296,0)
 ;;=I69.111^^83^822^87
 ;;^UTILITY(U,$J,358.3,14296,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14296,1,3,0)
 ;;=3^Memory Deficit After Intcrbl Hemorrhage
 ;;^UTILITY(U,$J,358.3,14296,1,4,0)
 ;;=4^I69.111
