IBDEI0EW ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,6410,2)
 ;;=^5007158
 ;;^UTILITY(U,$J,358.3,6411,0)
 ;;=I30.0^^53^411^1
 ;;^UTILITY(U,$J,358.3,6411,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6411,1,3,0)
 ;;=3^Acute Nonspecific Idiopathic Pericarditis
 ;;^UTILITY(U,$J,358.3,6411,1,4,0)
 ;;=4^I30.0
 ;;^UTILITY(U,$J,358.3,6411,2)
 ;;=^5007157
 ;;^UTILITY(U,$J,358.3,6412,0)
 ;;=I33.0^^53^411^3
 ;;^UTILITY(U,$J,358.3,6412,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6412,1,3,0)
 ;;=3^Acute/Subacute Infective Endocarditis
 ;;^UTILITY(U,$J,358.3,6412,1,4,0)
 ;;=4^I33.0
 ;;^UTILITY(U,$J,358.3,6412,2)
 ;;=^5007167
 ;;^UTILITY(U,$J,358.3,6413,0)
 ;;=I33.9^^53^411^2
 ;;^UTILITY(U,$J,358.3,6413,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6413,1,3,0)
 ;;=3^Acute/Subacute Endocarditis,Unspec
 ;;^UTILITY(U,$J,358.3,6413,1,4,0)
 ;;=4^I33.9
 ;;^UTILITY(U,$J,358.3,6413,2)
 ;;=^5007168
 ;;^UTILITY(U,$J,358.3,6414,0)
 ;;=I31.0^^53^411^4
 ;;^UTILITY(U,$J,358.3,6414,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6414,1,3,0)
 ;;=3^Adhesive Pericarditis,Chronic
 ;;^UTILITY(U,$J,358.3,6414,1,4,0)
 ;;=4^I31.0
 ;;^UTILITY(U,$J,358.3,6414,2)
 ;;=^5007161
 ;;^UTILITY(U,$J,358.3,6415,0)
 ;;=I31.1^^53^411^6
 ;;^UTILITY(U,$J,358.3,6415,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6415,1,3,0)
 ;;=3^Constrictive Pericarditis,Chronic
 ;;^UTILITY(U,$J,358.3,6415,1,4,0)
 ;;=4^I31.1
 ;;^UTILITY(U,$J,358.3,6415,2)
 ;;=^5007162
 ;;^UTILITY(U,$J,358.3,6416,0)
 ;;=E78.1^^53^412^7
 ;;^UTILITY(U,$J,358.3,6416,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6416,1,3,0)
 ;;=3^Pure Hyperglyceridemia
 ;;^UTILITY(U,$J,358.3,6416,1,4,0)
 ;;=4^E78.1
 ;;^UTILITY(U,$J,358.3,6416,2)
 ;;=^101303
 ;;^UTILITY(U,$J,358.3,6417,0)
 ;;=E78.2^^53^412^5
 ;;^UTILITY(U,$J,358.3,6417,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6417,1,3,0)
 ;;=3^Mixed Hyperlipidemia
 ;;^UTILITY(U,$J,358.3,6417,1,4,0)
 ;;=4^E78.2
 ;;^UTILITY(U,$J,358.3,6417,2)
 ;;=^78424
 ;;^UTILITY(U,$J,358.3,6418,0)
 ;;=E78.6^^53^412^4
 ;;^UTILITY(U,$J,358.3,6418,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6418,1,3,0)
 ;;=3^Lipoprotein Deficiency
 ;;^UTILITY(U,$J,358.3,6418,1,4,0)
 ;;=4^E78.6
 ;;^UTILITY(U,$J,358.3,6418,2)
 ;;=^5002970
 ;;^UTILITY(U,$J,358.3,6419,0)
 ;;=E78.01^^53^412^2
 ;;^UTILITY(U,$J,358.3,6419,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6419,1,3,0)
 ;;=3^Familial Hypercholesterolemia
 ;;^UTILITY(U,$J,358.3,6419,1,4,0)
 ;;=4^E78.01
 ;;^UTILITY(U,$J,358.3,6419,2)
 ;;=^7570555
 ;;^UTILITY(U,$J,358.3,6420,0)
 ;;=E78.00^^53^412^6
 ;;^UTILITY(U,$J,358.3,6420,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6420,1,3,0)
 ;;=3^Pure Hypercholesterolemia,Unspec
 ;;^UTILITY(U,$J,358.3,6420,1,4,0)
 ;;=4^E78.00
 ;;^UTILITY(U,$J,358.3,6420,2)
 ;;=^5138435
 ;;^UTILITY(U,$J,358.3,6421,0)
 ;;=E78.41^^53^412^1
 ;;^UTILITY(U,$J,358.3,6421,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6421,1,3,0)
 ;;=3^Elevated Lipoprotein(a)
 ;;^UTILITY(U,$J,358.3,6421,1,4,0)
 ;;=4^E78.41
 ;;^UTILITY(U,$J,358.3,6421,2)
 ;;=^5157298
 ;;^UTILITY(U,$J,358.3,6422,0)
 ;;=E78.49^^53^412^3
 ;;^UTILITY(U,$J,358.3,6422,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6422,1,3,0)
 ;;=3^Hyperlipidemia,Other
 ;;^UTILITY(U,$J,358.3,6422,1,4,0)
 ;;=4^E78.49
 ;;^UTILITY(U,$J,358.3,6422,2)
 ;;=^5157299
 ;;^UTILITY(U,$J,358.3,6423,0)
 ;;=I22.0^^53^413^12
 ;;^UTILITY(U,$J,358.3,6423,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6423,1,3,0)
 ;;=3^Subsequent STEMI of Anterior Wall
