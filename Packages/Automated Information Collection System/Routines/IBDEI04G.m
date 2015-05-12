IBDEI04G ; ; 09-FEB-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;OCT 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,5449,1,3,0)
 ;;=3^Secondary Malig Neop of Respiratory Organ,Unspec
 ;;^UTILITY(U,$J,358.3,5449,1,4,0)
 ;;=4^C78.30
 ;;^UTILITY(U,$J,358.3,5449,2)
 ;;=^5001337
 ;;^UTILITY(U,$J,358.3,5450,0)
 ;;=C78.39^^22^247^9
 ;;^UTILITY(U,$J,358.3,5450,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5450,1,3,0)
 ;;=3^Secondary Malig Neop of Respiratory Organs NEC
 ;;^UTILITY(U,$J,358.3,5450,1,4,0)
 ;;=4^C78.39
 ;;^UTILITY(U,$J,358.3,5450,2)
 ;;=^267325
 ;;^UTILITY(U,$J,358.3,5451,0)
 ;;=C78.4^^22^247^12
 ;;^UTILITY(U,$J,358.3,5451,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5451,1,3,0)
 ;;=3^Secondary Malig Neop of Small Intestine
 ;;^UTILITY(U,$J,358.3,5451,1,4,0)
 ;;=4^C78.4
 ;;^UTILITY(U,$J,358.3,5451,2)
 ;;=^5001338
 ;;^UTILITY(U,$J,358.3,5452,0)
 ;;=C78.5^^22^247^3
 ;;^UTILITY(U,$J,358.3,5452,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5452,1,3,0)
 ;;=3^Secondary Malig Neop of Large Intestine/Rectum
 ;;^UTILITY(U,$J,358.3,5452,1,4,0)
 ;;=4^C78.5
 ;;^UTILITY(U,$J,358.3,5452,2)
 ;;=^267327
 ;;^UTILITY(U,$J,358.3,5453,0)
 ;;=C78.6^^22^247^10
 ;;^UTILITY(U,$J,358.3,5453,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5453,1,3,0)
 ;;=3^Secondary Malig Neop of Retroperitoneum/Peritoneum
 ;;^UTILITY(U,$J,358.3,5453,1,4,0)
 ;;=4^C78.6
 ;;^UTILITY(U,$J,358.3,5453,2)
 ;;=^108899
 ;;^UTILITY(U,$J,358.3,5454,0)
 ;;=C78.7^^22^247^5
 ;;^UTILITY(U,$J,358.3,5454,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5454,1,3,0)
 ;;=3^Secondary Malig Neop of Liver/Intrahepatic Bile Duct
 ;;^UTILITY(U,$J,358.3,5454,1,4,0)
 ;;=4^C78.7
 ;;^UTILITY(U,$J,358.3,5454,2)
 ;;=^5001339
 ;;^UTILITY(U,$J,358.3,5455,0)
 ;;=C78.80^^22^247^1
 ;;^UTILITY(U,$J,358.3,5455,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5455,1,3,0)
 ;;=3^Secondary Malig Neop of Digestive Organ,Unspec
 ;;^UTILITY(U,$J,358.3,5455,1,4,0)
 ;;=4^C78.80
 ;;^UTILITY(U,$J,358.3,5455,2)
 ;;=^5001340
 ;;^UTILITY(U,$J,358.3,5456,0)
 ;;=C78.89^^22^247^2
 ;;^UTILITY(U,$J,358.3,5456,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5456,1,3,0)
 ;;=3^Secondary Malig Neop of Digestive Organs NEC
 ;;^UTILITY(U,$J,358.3,5456,1,4,0)
 ;;=4^C78.89
 ;;^UTILITY(U,$J,358.3,5456,2)
 ;;=^5001341
