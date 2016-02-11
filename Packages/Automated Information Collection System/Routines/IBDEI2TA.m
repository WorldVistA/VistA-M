IBDEI2TA ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,47208,0)
 ;;=C49.3^^209^2341^10
 ;;^UTILITY(U,$J,358.3,47208,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,47208,1,3,0)
 ;;=3^Malig Neop of Thorax Connective/Soft Tissue
 ;;^UTILITY(U,$J,358.3,47208,1,4,0)
 ;;=4^C49.3
 ;;^UTILITY(U,$J,358.3,47208,2)
 ;;=^5001131
 ;;^UTILITY(U,$J,358.3,47209,0)
 ;;=C49.4^^209^2341^1
 ;;^UTILITY(U,$J,358.3,47209,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,47209,1,3,0)
 ;;=3^Malig Neop of Abdomen Connective/Soft Tissue
 ;;^UTILITY(U,$J,358.3,47209,1,4,0)
 ;;=4^C49.4
 ;;^UTILITY(U,$J,358.3,47209,2)
 ;;=^5001132
 ;;^UTILITY(U,$J,358.3,47210,0)
 ;;=C49.5^^209^2341^7
 ;;^UTILITY(U,$J,358.3,47210,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,47210,1,3,0)
 ;;=3^Malig Neop of Pelvis Connective/Soft Tissue
 ;;^UTILITY(U,$J,358.3,47210,1,4,0)
 ;;=4^C49.5
 ;;^UTILITY(U,$J,358.3,47210,2)
 ;;=^5001133
 ;;^UTILITY(U,$J,358.3,47211,0)
 ;;=C49.6^^209^2341^11
 ;;^UTILITY(U,$J,358.3,47211,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,47211,1,3,0)
 ;;=3^Malig Neop of Trunk Connective/Soft Tissue,Unspec
 ;;^UTILITY(U,$J,358.3,47211,1,4,0)
 ;;=4^C49.6
 ;;^UTILITY(U,$J,358.3,47211,2)
 ;;=^5001134
 ;;^UTILITY(U,$J,358.3,47212,0)
 ;;=C49.8^^209^2341^6
 ;;^UTILITY(U,$J,358.3,47212,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,47212,1,3,0)
 ;;=3^Malig Neop of Overlapping Sites of Connective/Soft Tissue
 ;;^UTILITY(U,$J,358.3,47212,1,4,0)
 ;;=4^C49.8
 ;;^UTILITY(U,$J,358.3,47212,2)
 ;;=^5001135
 ;;^UTILITY(U,$J,358.3,47213,0)
 ;;=C49.9^^209^2341^2
 ;;^UTILITY(U,$J,358.3,47213,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,47213,1,3,0)
 ;;=3^Malig Neop of Connective/Soft Tissue,Unspec
 ;;^UTILITY(U,$J,358.3,47213,1,4,0)
 ;;=4^C49.9
 ;;^UTILITY(U,$J,358.3,47213,2)
 ;;=^5001136
 ;;^UTILITY(U,$J,358.3,47214,0)
 ;;=C15.3^^209^2342^5
 ;;^UTILITY(U,$J,358.3,47214,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,47214,1,3,0)
 ;;=3^Malig Neop of Upper Third of Esophagus
 ;;^UTILITY(U,$J,358.3,47214,1,4,0)
 ;;=4^C15.3
 ;;^UTILITY(U,$J,358.3,47214,2)
 ;;=^267059
 ;;^UTILITY(U,$J,358.3,47215,0)
 ;;=C15.4^^209^2342^3
 ;;^UTILITY(U,$J,358.3,47215,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,47215,1,3,0)
 ;;=3^Malig Neop of Middle Third of Esophagus
 ;;^UTILITY(U,$J,358.3,47215,1,4,0)
 ;;=4^C15.4
 ;;^UTILITY(U,$J,358.3,47215,2)
 ;;=^267060
 ;;^UTILITY(U,$J,358.3,47216,0)
 ;;=C15.5^^209^2342^2
 ;;^UTILITY(U,$J,358.3,47216,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,47216,1,3,0)
 ;;=3^Malig Neop of Lower Third of Esophagus
 ;;^UTILITY(U,$J,358.3,47216,1,4,0)
 ;;=4^C15.5
 ;;^UTILITY(U,$J,358.3,47216,2)
 ;;=^267061
 ;;^UTILITY(U,$J,358.3,47217,0)
 ;;=C15.8^^209^2342^4
 ;;^UTILITY(U,$J,358.3,47217,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,47217,1,3,0)
 ;;=3^Malig Neop of Overlapping Sites of Esophagus
 ;;^UTILITY(U,$J,358.3,47217,1,4,0)
 ;;=4^C15.8
 ;;^UTILITY(U,$J,358.3,47217,2)
 ;;=^5000918
 ;;^UTILITY(U,$J,358.3,47218,0)
 ;;=C15.9^^209^2342^1
 ;;^UTILITY(U,$J,358.3,47218,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,47218,1,3,0)
 ;;=3^Malig Neop of Esophagus,Unspec
 ;;^UTILITY(U,$J,358.3,47218,1,4,0)
 ;;=4^C15.9
 ;;^UTILITY(U,$J,358.3,47218,2)
 ;;=^5000919
 ;;^UTILITY(U,$J,358.3,47219,0)
 ;;=C13.0^^209^2343^4
 ;;^UTILITY(U,$J,358.3,47219,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,47219,1,3,0)
 ;;=3^Malig Neop of Postcricoid Region
 ;;^UTILITY(U,$J,358.3,47219,1,4,0)
 ;;=4^C13.0
 ;;^UTILITY(U,$J,358.3,47219,2)
 ;;=^5000912
 ;;^UTILITY(U,$J,358.3,47220,0)
 ;;=C13.1^^209^2343^1
 ;;^UTILITY(U,$J,358.3,47220,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,47220,1,3,0)
 ;;=3^Malig Neop of Aryepiglottic Fold
