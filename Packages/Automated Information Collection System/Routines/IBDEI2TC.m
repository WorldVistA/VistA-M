IBDEI2TC ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,47233,1,4,0)
 ;;=4^C34.11
 ;;^UTILITY(U,$J,358.3,47233,2)
 ;;=^5000961
 ;;^UTILITY(U,$J,358.3,47234,0)
 ;;=C34.12^^209^2345^4
 ;;^UTILITY(U,$J,358.3,47234,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,47234,1,3,0)
 ;;=3^Malig Neop of Left Upper Lobe of Bronchus/Lung
 ;;^UTILITY(U,$J,358.3,47234,1,4,0)
 ;;=4^C34.12
 ;;^UTILITY(U,$J,358.3,47234,2)
 ;;=^5000962
 ;;^UTILITY(U,$J,358.3,47235,0)
 ;;=C34.2^^209^2345^6
 ;;^UTILITY(U,$J,358.3,47235,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,47235,1,3,0)
 ;;=3^Malig Neop of Middle Lobe of Bronchus/Lung
 ;;^UTILITY(U,$J,358.3,47235,1,4,0)
 ;;=4^C34.2
 ;;^UTILITY(U,$J,358.3,47235,2)
 ;;=^267137
 ;;^UTILITY(U,$J,358.3,47236,0)
 ;;=C34.31^^209^2345^10
 ;;^UTILITY(U,$J,358.3,47236,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,47236,1,3,0)
 ;;=3^Malig Neop of Right Lower Lobe of Bronchus/Lung
 ;;^UTILITY(U,$J,358.3,47236,1,4,0)
 ;;=4^C34.31
 ;;^UTILITY(U,$J,358.3,47236,2)
 ;;=^5133321
 ;;^UTILITY(U,$J,358.3,47237,0)
 ;;=C34.32^^209^2345^2
 ;;^UTILITY(U,$J,358.3,47237,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,47237,1,3,0)
 ;;=3^Malig Neop of Left Lower Lobe of Bronchus/Lung
 ;;^UTILITY(U,$J,358.3,47237,1,4,0)
 ;;=4^C34.32
 ;;^UTILITY(U,$J,358.3,47237,2)
 ;;=^5133322
 ;;^UTILITY(U,$J,358.3,47238,0)
 ;;=C34.81^^209^2345^8
 ;;^UTILITY(U,$J,358.3,47238,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,47238,1,3,0)
 ;;=3^Malig Neop of Overlapping Sites Right Bronchus/Lung
 ;;^UTILITY(U,$J,358.3,47238,1,4,0)
 ;;=4^C34.81
 ;;^UTILITY(U,$J,358.3,47238,2)
 ;;=^5000964
 ;;^UTILITY(U,$J,358.3,47239,0)
 ;;=C34.82^^209^2345^7
 ;;^UTILITY(U,$J,358.3,47239,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,47239,1,3,0)
 ;;=3^Malig Neop of Overlapping Sites Left Bronchus/Lung
 ;;^UTILITY(U,$J,358.3,47239,1,4,0)
 ;;=4^C34.82
 ;;^UTILITY(U,$J,358.3,47239,2)
 ;;=^5000965
 ;;^UTILITY(U,$J,358.3,47240,0)
 ;;=C34.00^^209^2345^5
 ;;^UTILITY(U,$J,358.3,47240,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,47240,1,3,0)
 ;;=3^Malig Neop of Main Bronchus,Unspec
 ;;^UTILITY(U,$J,358.3,47240,1,4,0)
 ;;=4^C34.00
 ;;^UTILITY(U,$J,358.3,47240,2)
 ;;=^5000957
 ;;^UTILITY(U,$J,358.3,47241,0)
 ;;=C34.91^^209^2345^9
 ;;^UTILITY(U,$J,358.3,47241,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,47241,1,3,0)
 ;;=3^Malig Neop of Right Bronchus/Lung,Unspec Part
 ;;^UTILITY(U,$J,358.3,47241,1,4,0)
 ;;=4^C34.91
 ;;^UTILITY(U,$J,358.3,47241,2)
 ;;=^5000967
 ;;^UTILITY(U,$J,358.3,47242,0)
 ;;=C34.92^^209^2345^1
 ;;^UTILITY(U,$J,358.3,47242,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,47242,1,3,0)
 ;;=3^Malig Neop of Left Bronchus/Lung,Unspec Part
 ;;^UTILITY(U,$J,358.3,47242,1,4,0)
 ;;=4^C34.92
 ;;^UTILITY(U,$J,358.3,47242,2)
 ;;=^5000968
 ;;^UTILITY(U,$J,358.3,47243,0)
 ;;=C37.^^209^2345^13
 ;;^UTILITY(U,$J,358.3,47243,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,47243,1,3,0)
 ;;=3^Malig Neop of Thymus
 ;;^UTILITY(U,$J,358.3,47243,1,4,0)
 ;;=4^C37.
 ;;^UTILITY(U,$J,358.3,47243,2)
 ;;=^267145
 ;;^UTILITY(U,$J,358.3,47244,0)
 ;;=C81.00^^209^2346^372
 ;;^UTILITY(U,$J,358.3,47244,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,47244,1,3,0)
 ;;=3^Nodular Lymphocyte Predominant Hodgkin Lymphoma,Unspec Site
 ;;^UTILITY(U,$J,358.3,47244,1,4,0)
 ;;=4^C81.00
 ;;^UTILITY(U,$J,358.3,47244,2)
 ;;=^5001391
 ;;^UTILITY(U,$J,358.3,47245,0)
 ;;=C81.01^^209^2346^373
 ;;^UTILITY(U,$J,358.3,47245,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,47245,1,3,0)
 ;;=3^Nodular Lymphocyte Predominant Hodgkin Lymphoma,Head/Face/Neck
 ;;^UTILITY(U,$J,358.3,47245,1,4,0)
 ;;=4^C81.01
 ;;^UTILITY(U,$J,358.3,47245,2)
 ;;=^5001392
