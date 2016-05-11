IBDEI0EB ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,6584,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6584,1,3,0)
 ;;=3^Malig Neop Peripheral Nerves/Autonomic Nervous System,Unspec
 ;;^UTILITY(U,$J,358.3,6584,1,4,0)
 ;;=4^C47.9
 ;;^UTILITY(U,$J,358.3,6584,2)
 ;;=^5001121
 ;;^UTILITY(U,$J,358.3,6585,0)
 ;;=C38.4^^30^396^145
 ;;^UTILITY(U,$J,358.3,6585,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6585,1,3,0)
 ;;=3^Malig Neop Pleura
 ;;^UTILITY(U,$J,358.3,6585,1,4,0)
 ;;=4^C38.4
 ;;^UTILITY(U,$J,358.3,6585,2)
 ;;=^267140
 ;;^UTILITY(U,$J,358.3,6586,0)
 ;;=C61.^^30^396^146
 ;;^UTILITY(U,$J,358.3,6586,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6586,1,3,0)
 ;;=3^Malig Neop Prostate
 ;;^UTILITY(U,$J,358.3,6586,1,4,0)
 ;;=4^C61.
 ;;^UTILITY(U,$J,358.3,6586,2)
 ;;=^267239
 ;;^UTILITY(U,$J,358.3,6587,0)
 ;;=C20.^^30^396^147
 ;;^UTILITY(U,$J,358.3,6587,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6587,1,3,0)
 ;;=3^Malig Neop Rectum
 ;;^UTILITY(U,$J,358.3,6587,1,4,0)
 ;;=4^C20.
 ;;^UTILITY(U,$J,358.3,6587,2)
 ;;=^267090
 ;;^UTILITY(U,$J,358.3,6588,0)
 ;;=C64.1^^30^396^152
 ;;^UTILITY(U,$J,358.3,6588,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6588,1,3,0)
 ;;=3^Malig Neop Right Kidney,Except Renal pelvis
 ;;^UTILITY(U,$J,358.3,6588,1,4,0)
 ;;=4^C64.1
 ;;^UTILITY(U,$J,358.3,6588,2)
 ;;=^5001248
 ;;^UTILITY(U,$J,358.3,6589,0)
 ;;=C65.1^^30^396^155
 ;;^UTILITY(U,$J,358.3,6589,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6589,1,3,0)
 ;;=3^Malig Neop Right Renal Pelvis
 ;;^UTILITY(U,$J,358.3,6589,1,4,0)
 ;;=4^C65.1
 ;;^UTILITY(U,$J,358.3,6589,2)
 ;;=^5001251
 ;;^UTILITY(U,$J,358.3,6590,0)
 ;;=C62.91^^30^396^156
 ;;^UTILITY(U,$J,358.3,6590,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6590,1,3,0)
 ;;=3^Malig Neop Right Testis
 ;;^UTILITY(U,$J,358.3,6590,1,4,0)
 ;;=4^C62.91
 ;;^UTILITY(U,$J,358.3,6590,2)
 ;;=^5001237
 ;;^UTILITY(U,$J,358.3,6591,0)
 ;;=C17.9^^30^396^157
 ;;^UTILITY(U,$J,358.3,6591,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6591,1,3,0)
 ;;=3^Malig Neop Small Intestine,Unspec
 ;;^UTILITY(U,$J,358.3,6591,1,4,0)
 ;;=4^C17.9
 ;;^UTILITY(U,$J,358.3,6591,2)
 ;;=^5000926
 ;;^UTILITY(U,$J,358.3,6592,0)
 ;;=C16.9^^30^396^158
 ;;^UTILITY(U,$J,358.3,6592,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6592,1,3,0)
 ;;=3^Malig Neop Stomach,Unspec
 ;;^UTILITY(U,$J,358.3,6592,1,4,0)
 ;;=4^C16.9
 ;;^UTILITY(U,$J,358.3,6592,2)
 ;;=^5000923
 ;;^UTILITY(U,$J,358.3,6593,0)
 ;;=C02.9^^30^396^160
 ;;^UTILITY(U,$J,358.3,6593,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6593,1,3,0)
 ;;=3^Malig Neop Tongue,Unspec
 ;;^UTILITY(U,$J,358.3,6593,1,4,0)
 ;;=4^C02.9
 ;;^UTILITY(U,$J,358.3,6593,2)
 ;;=^5000891
 ;;^UTILITY(U,$J,358.3,6594,0)
 ;;=C64.9^^30^396^125
 ;;^UTILITY(U,$J,358.3,6594,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6594,1,3,0)
 ;;=3^Malig Neop Kidney,Except Renal Pelvis,Unspec
 ;;^UTILITY(U,$J,358.3,6594,1,4,0)
 ;;=4^C64.9
 ;;^UTILITY(U,$J,358.3,6594,2)
 ;;=^5001250
 ;;^UTILITY(U,$J,358.3,6595,0)
 ;;=C34.92^^30^396^128
 ;;^UTILITY(U,$J,358.3,6595,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6595,1,3,0)
 ;;=3^Malig Neop Left Bronchus/Lung,Unspec Part
 ;;^UTILITY(U,$J,358.3,6595,1,4,0)
 ;;=4^C34.92
 ;;^UTILITY(U,$J,358.3,6595,2)
 ;;=^5000968
 ;;^UTILITY(U,$J,358.3,6596,0)
 ;;=C34.90^^30^396^114
 ;;^UTILITY(U,$J,358.3,6596,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6596,1,3,0)
 ;;=3^Malig Neop Bronchus/Lung,Unspec Part
 ;;^UTILITY(U,$J,358.3,6596,1,4,0)
 ;;=4^C34.90
 ;;^UTILITY(U,$J,358.3,6596,2)
 ;;=^5000966
 ;;^UTILITY(U,$J,358.3,6597,0)
 ;;=C65.9^^30^396^148
 ;;^UTILITY(U,$J,358.3,6597,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6597,1,3,0)
 ;;=3^Malig Neop Renal Pelvis,Unspec
