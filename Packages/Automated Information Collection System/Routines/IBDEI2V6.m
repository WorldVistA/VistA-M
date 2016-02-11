IBDEI2V6 ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,48060,1,3,0)
 ;;=3^Malig Neop of Right Adrenal Gland,Unspec
 ;;^UTILITY(U,$J,358.3,48060,1,4,0)
 ;;=4^C74.91
 ;;^UTILITY(U,$J,358.3,48060,2)
 ;;=^5001318
 ;;^UTILITY(U,$J,358.3,48061,0)
 ;;=C74.92^^209^2375^7
 ;;^UTILITY(U,$J,358.3,48061,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,48061,1,3,0)
 ;;=3^Malig Neop of Left Adrenal Gland,Unspec
 ;;^UTILITY(U,$J,358.3,48061,1,4,0)
 ;;=4^C74.92
 ;;^UTILITY(U,$J,358.3,48061,2)
 ;;=^5001319
 ;;^UTILITY(U,$J,358.3,48062,0)
 ;;=C75.0^^209^2375^10
 ;;^UTILITY(U,$J,358.3,48062,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,48062,1,3,0)
 ;;=3^Malig Neop of Parathyroid Gland
 ;;^UTILITY(U,$J,358.3,48062,1,4,0)
 ;;=4^C75.0
 ;;^UTILITY(U,$J,358.3,48062,2)
 ;;=^267299
 ;;^UTILITY(U,$J,358.3,48063,0)
 ;;=C75.1^^209^2375^12
 ;;^UTILITY(U,$J,358.3,48063,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,48063,1,3,0)
 ;;=3^Malig Neop of Pituitary Gland
 ;;^UTILITY(U,$J,358.3,48063,1,4,0)
 ;;=4^C75.1
 ;;^UTILITY(U,$J,358.3,48063,2)
 ;;=^5001320
 ;;^UTILITY(U,$J,358.3,48064,0)
 ;;=C75.2^^209^2375^5
 ;;^UTILITY(U,$J,358.3,48064,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,48064,1,3,0)
 ;;=3^Malig Neop of Craniopharyngeal Duct
 ;;^UTILITY(U,$J,358.3,48064,1,4,0)
 ;;=4^C75.2
 ;;^UTILITY(U,$J,358.3,48064,2)
 ;;=^5001321
 ;;^UTILITY(U,$J,358.3,48065,0)
 ;;=C75.3^^209^2375^11
 ;;^UTILITY(U,$J,358.3,48065,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,48065,1,3,0)
 ;;=3^Malig Neop of Pineal Gland
 ;;^UTILITY(U,$J,358.3,48065,1,4,0)
 ;;=4^C75.3
 ;;^UTILITY(U,$J,358.3,48065,2)
 ;;=^267301
 ;;^UTILITY(U,$J,358.3,48066,0)
 ;;=C75.4^^209^2375^2
 ;;^UTILITY(U,$J,358.3,48066,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,48066,1,3,0)
 ;;=3^Malig Neop of Carotid Body
 ;;^UTILITY(U,$J,358.3,48066,1,4,0)
 ;;=4^C75.4
 ;;^UTILITY(U,$J,358.3,48066,2)
 ;;=^267302
 ;;^UTILITY(U,$J,358.3,48067,0)
 ;;=C75.5^^209^2375^1
 ;;^UTILITY(U,$J,358.3,48067,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,48067,1,3,0)
 ;;=3^Malig Neop of Aortic Body/Paraganglia
 ;;^UTILITY(U,$J,358.3,48067,1,4,0)
 ;;=4^C75.5
 ;;^UTILITY(U,$J,358.3,48067,2)
 ;;=^267303
 ;;^UTILITY(U,$J,358.3,48068,0)
 ;;=C75.8^^209^2375^15
 ;;^UTILITY(U,$J,358.3,48068,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,48068,1,3,0)
 ;;=3^Malig Neop w/ Pluriglandular Involvement,Unspec
 ;;^UTILITY(U,$J,358.3,48068,1,4,0)
 ;;=4^C75.8
 ;;^UTILITY(U,$J,358.3,48068,2)
 ;;=^5001322
 ;;^UTILITY(U,$J,358.3,48069,0)
 ;;=C75.9^^209^2375^6
 ;;^UTILITY(U,$J,358.3,48069,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,48069,1,3,0)
 ;;=3^Malig Neop of Endocrine Gland,Unspec
 ;;^UTILITY(U,$J,358.3,48069,1,4,0)
 ;;=4^C75.9
 ;;^UTILITY(U,$J,358.3,48069,2)
 ;;=^5001323
 ;;^UTILITY(U,$J,358.3,48070,0)
 ;;=C77.0^^209^2376^2
 ;;^UTILITY(U,$J,358.3,48070,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,48070,1,3,0)
 ;;=3^Secondary Malig Neop of Head/Face/Neck Lymph Nodes
 ;;^UTILITY(U,$J,358.3,48070,1,4,0)
 ;;=4^C77.0
 ;;^UTILITY(U,$J,358.3,48070,2)
 ;;=^5001329
 ;;^UTILITY(U,$J,358.3,48071,0)
 ;;=C77.1^^209^2376^6
 ;;^UTILITY(U,$J,358.3,48071,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,48071,1,3,0)
 ;;=3^Secondary Malig Neop of Intrathoracic Lymph Nodes
 ;;^UTILITY(U,$J,358.3,48071,1,4,0)
 ;;=4^C77.1
 ;;^UTILITY(U,$J,358.3,48071,2)
 ;;=^267315
 ;;^UTILITY(U,$J,358.3,48072,0)
 ;;=C77.2^^209^2376^4
 ;;^UTILITY(U,$J,358.3,48072,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,48072,1,3,0)
 ;;=3^Secondary Malig Neop of Intra-Abdominal Lymph Nodes
 ;;^UTILITY(U,$J,358.3,48072,1,4,0)
 ;;=4^C77.2
 ;;^UTILITY(U,$J,358.3,48072,2)
 ;;=^267316
 ;;^UTILITY(U,$J,358.3,48073,0)
 ;;=C77.3^^209^2376^1
