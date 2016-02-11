IBDEI0RA ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,12503,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12503,1,3,0)
 ;;=3^Benign Neop of Endocrine Glands,Oth Specified
 ;;^UTILITY(U,$J,358.3,12503,1,4,0)
 ;;=4^D35.7
 ;;^UTILITY(U,$J,358.3,12503,2)
 ;;=^5002147
 ;;^UTILITY(U,$J,358.3,12504,0)
 ;;=C74.01^^74^722^62
 ;;^UTILITY(U,$J,358.3,12504,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12504,1,3,0)
 ;;=3^Malig Neop of Right Adrenal Gland Cortex
 ;;^UTILITY(U,$J,358.3,12504,1,4,0)
 ;;=4^C74.01
 ;;^UTILITY(U,$J,358.3,12504,2)
 ;;=^5001312
 ;;^UTILITY(U,$J,358.3,12505,0)
 ;;=C74.02^^74^722^57
 ;;^UTILITY(U,$J,358.3,12505,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12505,1,3,0)
 ;;=3^Malig Neop of Left Adrenal Gland Cortex
 ;;^UTILITY(U,$J,358.3,12505,1,4,0)
 ;;=4^C74.02
 ;;^UTILITY(U,$J,358.3,12505,2)
 ;;=^5001313
 ;;^UTILITY(U,$J,358.3,12506,0)
 ;;=C74.11^^74^722^63
 ;;^UTILITY(U,$J,358.3,12506,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12506,1,3,0)
 ;;=3^Malig Neop of Right Adrenal Gland Medulla
 ;;^UTILITY(U,$J,358.3,12506,1,4,0)
 ;;=4^C74.11
 ;;^UTILITY(U,$J,358.3,12506,2)
 ;;=^5001315
 ;;^UTILITY(U,$J,358.3,12507,0)
 ;;=C74.12^^74^722^58
 ;;^UTILITY(U,$J,358.3,12507,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12507,1,3,0)
 ;;=3^Malig Neop of Left Adrenal Gland Medulla
 ;;^UTILITY(U,$J,358.3,12507,1,4,0)
 ;;=4^C74.12
 ;;^UTILITY(U,$J,358.3,12507,2)
 ;;=^5001316
 ;;^UTILITY(U,$J,358.3,12508,0)
 ;;=C75.0^^74^722^59
 ;;^UTILITY(U,$J,358.3,12508,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12508,1,3,0)
 ;;=3^Malig Neop of Parathyroid Gland
 ;;^UTILITY(U,$J,358.3,12508,1,4,0)
 ;;=4^C75.0
 ;;^UTILITY(U,$J,358.3,12508,2)
 ;;=^267299
 ;;^UTILITY(U,$J,358.3,12509,0)
 ;;=C75.1^^74^722^61
 ;;^UTILITY(U,$J,358.3,12509,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12509,1,3,0)
 ;;=3^Malig Neop of Pituitary Gland
 ;;^UTILITY(U,$J,358.3,12509,1,4,0)
 ;;=4^C75.1
 ;;^UTILITY(U,$J,358.3,12509,2)
 ;;=^5001320
 ;;^UTILITY(U,$J,358.3,12510,0)
 ;;=C75.2^^74^722^55
 ;;^UTILITY(U,$J,358.3,12510,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12510,1,3,0)
 ;;=3^Malig Neop of Craniopharyngeal Duct
 ;;^UTILITY(U,$J,358.3,12510,1,4,0)
 ;;=4^C75.2
 ;;^UTILITY(U,$J,358.3,12510,2)
 ;;=^5001321
 ;;^UTILITY(U,$J,358.3,12511,0)
 ;;=C75.3^^74^722^60
 ;;^UTILITY(U,$J,358.3,12511,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12511,1,3,0)
 ;;=3^Malig Neop of Pineal Gland
 ;;^UTILITY(U,$J,358.3,12511,1,4,0)
 ;;=4^C75.3
 ;;^UTILITY(U,$J,358.3,12511,2)
 ;;=^267301
 ;;^UTILITY(U,$J,358.3,12512,0)
 ;;=C75.4^^74^722^54
 ;;^UTILITY(U,$J,358.3,12512,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12512,1,3,0)
 ;;=3^Malig Neop of Carotid Body
 ;;^UTILITY(U,$J,358.3,12512,1,4,0)
 ;;=4^C75.4
 ;;^UTILITY(U,$J,358.3,12512,2)
 ;;=^267302
 ;;^UTILITY(U,$J,358.3,12513,0)
 ;;=C75.5^^74^722^53
 ;;^UTILITY(U,$J,358.3,12513,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12513,1,3,0)
 ;;=3^Malig Neop of Aortic Body/Oth Paraganglia
 ;;^UTILITY(U,$J,358.3,12513,1,4,0)
 ;;=4^C75.5
 ;;^UTILITY(U,$J,358.3,12513,2)
 ;;=^267303
 ;;^UTILITY(U,$J,358.3,12514,0)
 ;;=C75.8^^74^722^64
 ;;^UTILITY(U,$J,358.3,12514,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12514,1,3,0)
 ;;=3^Malig Neop w/ Pluriglandular Involvement,Unspec
 ;;^UTILITY(U,$J,358.3,12514,1,4,0)
 ;;=4^C75.8
 ;;^UTILITY(U,$J,358.3,12514,2)
 ;;=^5001322
 ;;^UTILITY(U,$J,358.3,12515,0)
 ;;=C75.9^^74^722^56
 ;;^UTILITY(U,$J,358.3,12515,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12515,1,3,0)
 ;;=3^Malig Neop of Endocrine Gland,Unspec
 ;;^UTILITY(U,$J,358.3,12515,1,4,0)
 ;;=4^C75.9
 ;;^UTILITY(U,$J,358.3,12515,2)
 ;;=^5001323
 ;;^UTILITY(U,$J,358.3,12516,0)
 ;;=E22.0^^74^722^1
