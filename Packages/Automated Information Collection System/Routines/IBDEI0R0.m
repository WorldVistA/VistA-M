IBDEI0R0 ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,12057,0)
 ;;=K85.20^^80^769^6
 ;;^UTILITY(U,$J,358.3,12057,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12057,1,3,0)
 ;;=3^Alcohol Induced Acute Pancreatitis
 ;;^UTILITY(U,$J,358.3,12057,1,4,0)
 ;;=4^K85.20
 ;;^UTILITY(U,$J,358.3,12057,2)
 ;;=^5138752
 ;;^UTILITY(U,$J,358.3,12058,0)
 ;;=K85.21^^80^769^8
 ;;^UTILITY(U,$J,358.3,12058,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12058,1,3,0)
 ;;=3^Alcohol Induced Acute Pancreatitis w/ Uninfected Necrosis
 ;;^UTILITY(U,$J,358.3,12058,1,4,0)
 ;;=4^K85.21
 ;;^UTILITY(U,$J,358.3,12058,2)
 ;;=^5138753
 ;;^UTILITY(U,$J,358.3,12059,0)
 ;;=K85.22^^80^769^7
 ;;^UTILITY(U,$J,358.3,12059,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12059,1,3,0)
 ;;=3^Alcohol Induced Acute Pancreatitis w/ Infected Necrosis
 ;;^UTILITY(U,$J,358.3,12059,1,4,0)
 ;;=4^K85.22
 ;;^UTILITY(U,$J,358.3,12059,2)
 ;;=^5138754
 ;;^UTILITY(U,$J,358.3,12060,0)
 ;;=K85.10^^80^769^17
 ;;^UTILITY(U,$J,358.3,12060,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12060,1,3,0)
 ;;=3^Biliary Acute Pancreatitis
 ;;^UTILITY(U,$J,358.3,12060,1,4,0)
 ;;=4^K85.10
 ;;^UTILITY(U,$J,358.3,12060,2)
 ;;=^5138749
 ;;^UTILITY(U,$J,358.3,12061,0)
 ;;=K85.11^^80^769^19
 ;;^UTILITY(U,$J,358.3,12061,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12061,1,3,0)
 ;;=3^Biliary Acute pancreatitis w/ Uninfected Necrosis
 ;;^UTILITY(U,$J,358.3,12061,1,4,0)
 ;;=4^K85.11
 ;;^UTILITY(U,$J,358.3,12061,2)
 ;;=^5138750
 ;;^UTILITY(U,$J,358.3,12062,0)
 ;;=K85.12^^80^769^18
 ;;^UTILITY(U,$J,358.3,12062,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12062,1,3,0)
 ;;=3^Biliary Acute Pancreatitis w/ Infected Necrosis
 ;;^UTILITY(U,$J,358.3,12062,1,4,0)
 ;;=4^K85.12
 ;;^UTILITY(U,$J,358.3,12062,2)
 ;;=^5138751
 ;;^UTILITY(U,$J,358.3,12063,0)
 ;;=K85.31^^80^769^38
 ;;^UTILITY(U,$J,358.3,12063,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12063,1,3,0)
 ;;=3^Drug Induced Acute Pancreatitis w/ Uninfected Necrosis
 ;;^UTILITY(U,$J,358.3,12063,1,4,0)
 ;;=4^K85.31
 ;;^UTILITY(U,$J,358.3,12063,2)
 ;;=^5138756
 ;;^UTILITY(U,$J,358.3,12064,0)
 ;;=K85.30^^80^769^36
 ;;^UTILITY(U,$J,358.3,12064,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12064,1,3,0)
 ;;=3^Drug Induced Acute Pancreatitis
 ;;^UTILITY(U,$J,358.3,12064,1,4,0)
 ;;=4^K85.30
 ;;^UTILITY(U,$J,358.3,12064,2)
 ;;=^5138755
 ;;^UTILITY(U,$J,358.3,12065,0)
 ;;=K85.32^^80^769^37
 ;;^UTILITY(U,$J,358.3,12065,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12065,1,3,0)
 ;;=3^Drug Induced Acute Pancreatitis w/ Infected Necrosis
 ;;^UTILITY(U,$J,358.3,12065,1,4,0)
 ;;=4^K85.32
 ;;^UTILITY(U,$J,358.3,12065,2)
 ;;=^5138757
 ;;^UTILITY(U,$J,358.3,12066,0)
 ;;=C78.7^^80^770^93
 ;;^UTILITY(U,$J,358.3,12066,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12066,1,3,0)
 ;;=3^Secondary Malig Neop of Liver/Intrahepatic Bile Duct
 ;;^UTILITY(U,$J,358.3,12066,1,4,0)
 ;;=4^C78.7
 ;;^UTILITY(U,$J,358.3,12066,2)
 ;;=^5001339
 ;;^UTILITY(U,$J,358.3,12067,0)
 ;;=C78.5^^80^770^92
 ;;^UTILITY(U,$J,358.3,12067,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12067,1,3,0)
 ;;=3^Secondary Malig Neop of Large Intestine/Rectum
 ;;^UTILITY(U,$J,358.3,12067,1,4,0)
 ;;=4^C78.5
 ;;^UTILITY(U,$J,358.3,12067,2)
 ;;=^267327
 ;;^UTILITY(U,$J,358.3,12068,0)
 ;;=C78.89^^80^770^91
 ;;^UTILITY(U,$J,358.3,12068,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12068,1,3,0)
 ;;=3^Secondary Malig Neop of Digestive Organs NEC
 ;;^UTILITY(U,$J,358.3,12068,1,4,0)
 ;;=4^C78.89
