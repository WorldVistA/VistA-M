IBDEI0HZ ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,8320,1,4,0)
 ;;=4^N62.
 ;;^UTILITY(U,$J,358.3,8320,2)
 ;;=^5015790
 ;;^UTILITY(U,$J,358.3,8321,0)
 ;;=D35.01^^35^442^14
 ;;^UTILITY(U,$J,358.3,8321,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8321,1,3,0)
 ;;=3^Benign Neop of Right Adrenal Gland
 ;;^UTILITY(U,$J,358.3,8321,1,4,0)
 ;;=4^D35.01
 ;;^UTILITY(U,$J,358.3,8321,2)
 ;;=^5002143
 ;;^UTILITY(U,$J,358.3,8322,0)
 ;;=D35.02^^35^442^10
 ;;^UTILITY(U,$J,358.3,8322,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8322,1,3,0)
 ;;=3^Benign Neop of Left Adrenal Gland
 ;;^UTILITY(U,$J,358.3,8322,1,4,0)
 ;;=4^D35.02
 ;;^UTILITY(U,$J,358.3,8322,2)
 ;;=^5002144
 ;;^UTILITY(U,$J,358.3,8323,0)
 ;;=D35.1^^35^442^11
 ;;^UTILITY(U,$J,358.3,8323,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8323,1,3,0)
 ;;=3^Benign Neop of Parathyroid Gland
 ;;^UTILITY(U,$J,358.3,8323,1,4,0)
 ;;=4^D35.1
 ;;^UTILITY(U,$J,358.3,8323,2)
 ;;=^267689
 ;;^UTILITY(U,$J,358.3,8324,0)
 ;;=D35.4^^35^442^12
 ;;^UTILITY(U,$J,358.3,8324,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8324,1,3,0)
 ;;=3^Benign Neop of Pineal Gland
 ;;^UTILITY(U,$J,358.3,8324,1,4,0)
 ;;=4^D35.4
 ;;^UTILITY(U,$J,358.3,8324,2)
 ;;=^267691
 ;;^UTILITY(U,$J,358.3,8325,0)
 ;;=D35.5^^35^442^7
 ;;^UTILITY(U,$J,358.3,8325,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8325,1,3,0)
 ;;=3^Benign Neop of Carotid Body
 ;;^UTILITY(U,$J,358.3,8325,1,4,0)
 ;;=4^D35.5
 ;;^UTILITY(U,$J,358.3,8325,2)
 ;;=^267692
 ;;^UTILITY(U,$J,358.3,8326,0)
 ;;=D35.6^^35^442^6
 ;;^UTILITY(U,$J,358.3,8326,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8326,1,3,0)
 ;;=3^Benign Neop of Aortic Body/Oth Paraganglia
 ;;^UTILITY(U,$J,358.3,8326,1,4,0)
 ;;=4^D35.6
 ;;^UTILITY(U,$J,358.3,8326,2)
 ;;=^267693
 ;;^UTILITY(U,$J,358.3,8327,0)
 ;;=D35.7^^35^442^9
 ;;^UTILITY(U,$J,358.3,8327,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8327,1,3,0)
 ;;=3^Benign Neop of Endocrine Glands,Oth Specified
 ;;^UTILITY(U,$J,358.3,8327,1,4,0)
 ;;=4^D35.7
 ;;^UTILITY(U,$J,358.3,8327,2)
 ;;=^5002147
 ;;^UTILITY(U,$J,358.3,8328,0)
 ;;=C74.01^^35^442^65
 ;;^UTILITY(U,$J,358.3,8328,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8328,1,3,0)
 ;;=3^Malig Neop of Right Adrenal Gland Cortex
 ;;^UTILITY(U,$J,358.3,8328,1,4,0)
 ;;=4^C74.01
 ;;^UTILITY(U,$J,358.3,8328,2)
 ;;=^5001312
 ;;^UTILITY(U,$J,358.3,8329,0)
 ;;=C74.02^^35^442^60
 ;;^UTILITY(U,$J,358.3,8329,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8329,1,3,0)
 ;;=3^Malig Neop of Left Adrenal Gland Cortex
 ;;^UTILITY(U,$J,358.3,8329,1,4,0)
 ;;=4^C74.02
 ;;^UTILITY(U,$J,358.3,8329,2)
 ;;=^5001313
 ;;^UTILITY(U,$J,358.3,8330,0)
 ;;=C74.11^^35^442^66
 ;;^UTILITY(U,$J,358.3,8330,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8330,1,3,0)
 ;;=3^Malig Neop of Right Adrenal Gland Medulla
 ;;^UTILITY(U,$J,358.3,8330,1,4,0)
 ;;=4^C74.11
 ;;^UTILITY(U,$J,358.3,8330,2)
 ;;=^5001315
 ;;^UTILITY(U,$J,358.3,8331,0)
 ;;=C74.12^^35^442^61
 ;;^UTILITY(U,$J,358.3,8331,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8331,1,3,0)
 ;;=3^Malig Neop of Left Adrenal Gland Medulla
 ;;^UTILITY(U,$J,358.3,8331,1,4,0)
 ;;=4^C74.12
 ;;^UTILITY(U,$J,358.3,8331,2)
 ;;=^5001316
 ;;^UTILITY(U,$J,358.3,8332,0)
 ;;=C75.0^^35^442^62
 ;;^UTILITY(U,$J,358.3,8332,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8332,1,3,0)
 ;;=3^Malig Neop of Parathyroid Gland
 ;;^UTILITY(U,$J,358.3,8332,1,4,0)
 ;;=4^C75.0
 ;;^UTILITY(U,$J,358.3,8332,2)
 ;;=^267299
 ;;^UTILITY(U,$J,358.3,8333,0)
 ;;=C75.1^^35^442^64
 ;;^UTILITY(U,$J,358.3,8333,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8333,1,3,0)
 ;;=3^Malig Neop of Pituitary Gland
 ;;^UTILITY(U,$J,358.3,8333,1,4,0)
 ;;=4^C75.1
