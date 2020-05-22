IBDEI1ZD ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,31619,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31619,1,3,0)
 ;;=3^Maternal care,excess ftl growht,3rd tri,unsp
 ;;^UTILITY(U,$J,358.3,31619,1,4,0)
 ;;=4^O36.63X0
 ;;^UTILITY(U,$J,358.3,31619,2)
 ;;=^5017047
 ;;^UTILITY(U,$J,358.3,31620,0)
 ;;=O36.63X1^^126^1626^123
 ;;^UTILITY(U,$J,358.3,31620,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31620,1,3,0)
 ;;=3^Maternal care,excess ftl growht,3rd tri,fts 1
 ;;^UTILITY(U,$J,358.3,31620,1,4,0)
 ;;=4^O36.63X1
 ;;^UTILITY(U,$J,358.3,31620,2)
 ;;=^5017048
 ;;^UTILITY(U,$J,358.3,31621,0)
 ;;=O36.63X2^^126^1626^124
 ;;^UTILITY(U,$J,358.3,31621,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31621,1,3,0)
 ;;=3^Maternal care,excess ftl growht,3rd tri,fts 2
 ;;^UTILITY(U,$J,358.3,31621,1,4,0)
 ;;=4^O36.63X2
 ;;^UTILITY(U,$J,358.3,31621,2)
 ;;=^5017049
 ;;^UTILITY(U,$J,358.3,31622,0)
 ;;=O36.63X3^^126^1626^125
 ;;^UTILITY(U,$J,358.3,31622,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31622,1,3,0)
 ;;=3^Maternal care,excess ftl growht,3rd tri,fts 3
 ;;^UTILITY(U,$J,358.3,31622,1,4,0)
 ;;=4^O36.63X3
 ;;^UTILITY(U,$J,358.3,31622,2)
 ;;=^5017050
 ;;^UTILITY(U,$J,358.3,31623,0)
 ;;=O36.63X4^^126^1626^126
 ;;^UTILITY(U,$J,358.3,31623,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31623,1,3,0)
 ;;=3^Maternal care,excess ftl growht,3rd tri,fts 4
 ;;^UTILITY(U,$J,358.3,31623,1,4,0)
 ;;=4^O36.63X4
 ;;^UTILITY(U,$J,358.3,31623,2)
 ;;=^5017051
 ;;^UTILITY(U,$J,358.3,31624,0)
 ;;=O36.63X5^^126^1626^127
 ;;^UTILITY(U,$J,358.3,31624,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31624,1,3,0)
 ;;=3^Maternal care,excess ftl growht,3rd tri,fts 5
 ;;^UTILITY(U,$J,358.3,31624,1,4,0)
 ;;=4^O36.63X5
 ;;^UTILITY(U,$J,358.3,31624,2)
 ;;=^5017052
 ;;^UTILITY(U,$J,358.3,31625,0)
 ;;=O40.1XX0^^126^1626^223
 ;;^UTILITY(U,$J,358.3,31625,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31625,1,3,0)
 ;;=3^Polyhydramnios, first trimester, unsp
 ;;^UTILITY(U,$J,358.3,31625,1,4,0)
 ;;=4^O40.1XX0
 ;;^UTILITY(U,$J,358.3,31625,2)
 ;;=^5017187
 ;;^UTILITY(U,$J,358.3,31626,0)
 ;;=O40.1XX1^^126^1626^218
 ;;^UTILITY(U,$J,358.3,31626,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31626,1,3,0)
 ;;=3^Polyhydramnios, first trimester, fetus 1
 ;;^UTILITY(U,$J,358.3,31626,1,4,0)
 ;;=4^O40.1XX1
 ;;^UTILITY(U,$J,358.3,31626,2)
 ;;=^5017188
 ;;^UTILITY(U,$J,358.3,31627,0)
 ;;=O40.1XX2^^126^1626^219
 ;;^UTILITY(U,$J,358.3,31627,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31627,1,3,0)
 ;;=3^Polyhydramnios, first trimester, fetus 2
 ;;^UTILITY(U,$J,358.3,31627,1,4,0)
 ;;=4^O40.1XX2
 ;;^UTILITY(U,$J,358.3,31627,2)
 ;;=^5017189
 ;;^UTILITY(U,$J,358.3,31628,0)
 ;;=O40.1XX3^^126^1626^220
 ;;^UTILITY(U,$J,358.3,31628,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31628,1,3,0)
 ;;=3^Polyhydramnios, first trimester, fetus 3
 ;;^UTILITY(U,$J,358.3,31628,1,4,0)
 ;;=4^O40.1XX3
 ;;^UTILITY(U,$J,358.3,31628,2)
 ;;=^5017190
 ;;^UTILITY(U,$J,358.3,31629,0)
 ;;=O40.1XX4^^126^1626^221
 ;;^UTILITY(U,$J,358.3,31629,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31629,1,3,0)
 ;;=3^Polyhydramnios, first trimester, fetus 4
 ;;^UTILITY(U,$J,358.3,31629,1,4,0)
 ;;=4^O40.1XX4
 ;;^UTILITY(U,$J,358.3,31629,2)
 ;;=^5017191
 ;;^UTILITY(U,$J,358.3,31630,0)
 ;;=O40.1XX5^^126^1626^222
 ;;^UTILITY(U,$J,358.3,31630,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31630,1,3,0)
 ;;=3^Polyhydramnios, first trimester, fetus 5
 ;;^UTILITY(U,$J,358.3,31630,1,4,0)
 ;;=4^O40.1XX5
