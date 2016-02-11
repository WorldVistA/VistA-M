IBDEI2V7 ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,48073,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,48073,1,3,0)
 ;;=3^Secondary Malig Neop of Axilla/Upper Limb Lymph Nodes
 ;;^UTILITY(U,$J,358.3,48073,1,4,0)
 ;;=4^C77.3
 ;;^UTILITY(U,$J,358.3,48073,2)
 ;;=^5001330
 ;;^UTILITY(U,$J,358.3,48074,0)
 ;;=C77.4^^209^2376^3
 ;;^UTILITY(U,$J,358.3,48074,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,48074,1,3,0)
 ;;=3^Secondary Malig Neop of Inguinal/Lower Limb Lymph Nodes
 ;;^UTILITY(U,$J,358.3,48074,1,4,0)
 ;;=4^C77.4
 ;;^UTILITY(U,$J,358.3,48074,2)
 ;;=^5001331
 ;;^UTILITY(U,$J,358.3,48075,0)
 ;;=C77.5^^209^2376^5
 ;;^UTILITY(U,$J,358.3,48075,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,48075,1,3,0)
 ;;=3^Secondary Malig Neop of Intrapelvic Lymph Nodes
 ;;^UTILITY(U,$J,358.3,48075,1,4,0)
 ;;=4^C77.5
 ;;^UTILITY(U,$J,358.3,48075,2)
 ;;=^267319
 ;;^UTILITY(U,$J,358.3,48076,0)
 ;;=C77.8^^209^2376^7
 ;;^UTILITY(U,$J,358.3,48076,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,48076,1,3,0)
 ;;=3^Secondary Malig Neop of Lymph Nodes of Mult Regions
 ;;^UTILITY(U,$J,358.3,48076,1,4,0)
 ;;=4^C77.8
 ;;^UTILITY(U,$J,358.3,48076,2)
 ;;=^5001332
 ;;^UTILITY(U,$J,358.3,48077,0)
 ;;=C77.9^^209^2376^8
 ;;^UTILITY(U,$J,358.3,48077,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,48077,1,3,0)
 ;;=3^Secondary Malig Neop of Lymph Nodes,Unspec
 ;;^UTILITY(U,$J,358.3,48077,1,4,0)
 ;;=4^C77.9
 ;;^UTILITY(U,$J,358.3,48077,2)
 ;;=^5001333
 ;;^UTILITY(U,$J,358.3,48078,0)
 ;;=C78.01^^209^2377^11
 ;;^UTILITY(U,$J,358.3,48078,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,48078,1,3,0)
 ;;=3^Secondary Malig Neop of Right Lung
 ;;^UTILITY(U,$J,358.3,48078,1,4,0)
 ;;=4^C78.01
 ;;^UTILITY(U,$J,358.3,48078,2)
 ;;=^5001335
 ;;^UTILITY(U,$J,358.3,48079,0)
 ;;=C78.02^^209^2377^4
 ;;^UTILITY(U,$J,358.3,48079,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,48079,1,3,0)
 ;;=3^Secondary Malig Neop of Left Lung
 ;;^UTILITY(U,$J,358.3,48079,1,4,0)
 ;;=4^C78.02
 ;;^UTILITY(U,$J,358.3,48079,2)
 ;;=^5001336
 ;;^UTILITY(U,$J,358.3,48080,0)
 ;;=C78.1^^209^2377^6
 ;;^UTILITY(U,$J,358.3,48080,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,48080,1,3,0)
 ;;=3^Secondary Malig Neop of Mediastinum
 ;;^UTILITY(U,$J,358.3,48080,1,4,0)
 ;;=4^C78.1
 ;;^UTILITY(U,$J,358.3,48080,2)
 ;;=^267323
 ;;^UTILITY(U,$J,358.3,48081,0)
 ;;=C78.2^^209^2377^7
 ;;^UTILITY(U,$J,358.3,48081,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,48081,1,3,0)
 ;;=3^Secondary Malig Neop of Pleura
 ;;^UTILITY(U,$J,358.3,48081,1,4,0)
 ;;=4^C78.2
 ;;^UTILITY(U,$J,358.3,48081,2)
 ;;=^267324
 ;;^UTILITY(U,$J,358.3,48082,0)
 ;;=C78.30^^209^2377^8
 ;;^UTILITY(U,$J,358.3,48082,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,48082,1,3,0)
 ;;=3^Secondary Malig Neop of Respiratory Organ,Unspec
 ;;^UTILITY(U,$J,358.3,48082,1,4,0)
 ;;=4^C78.30
 ;;^UTILITY(U,$J,358.3,48082,2)
 ;;=^5001337
 ;;^UTILITY(U,$J,358.3,48083,0)
 ;;=C78.39^^209^2377^9
 ;;^UTILITY(U,$J,358.3,48083,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,48083,1,3,0)
 ;;=3^Secondary Malig Neop of Respiratory Organs NEC
 ;;^UTILITY(U,$J,358.3,48083,1,4,0)
 ;;=4^C78.39
 ;;^UTILITY(U,$J,358.3,48083,2)
 ;;=^267325
 ;;^UTILITY(U,$J,358.3,48084,0)
 ;;=C78.4^^209^2377^12
 ;;^UTILITY(U,$J,358.3,48084,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,48084,1,3,0)
 ;;=3^Secondary Malig Neop of Small Intestine
 ;;^UTILITY(U,$J,358.3,48084,1,4,0)
 ;;=4^C78.4
 ;;^UTILITY(U,$J,358.3,48084,2)
 ;;=^5001338
 ;;^UTILITY(U,$J,358.3,48085,0)
 ;;=C78.5^^209^2377^3
 ;;^UTILITY(U,$J,358.3,48085,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,48085,1,3,0)
 ;;=3^Secondary Malig Neop of Large Intestine/Rectum
