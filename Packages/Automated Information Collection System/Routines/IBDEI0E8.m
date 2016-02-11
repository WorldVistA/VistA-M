IBDEI0E8 ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,6210,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6210,1,3,0)
 ;;=3^Intraoperative Hemorrhage/Hematoma of GU System
 ;;^UTILITY(U,$J,358.3,6210,1,4,0)
 ;;=4^N99.62
 ;;^UTILITY(U,$J,358.3,6210,2)
 ;;=^5015964
 ;;^UTILITY(U,$J,358.3,6211,0)
 ;;=M96.811^^40^386^34
 ;;^UTILITY(U,$J,358.3,6211,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6211,1,3,0)
 ;;=3^Intraoperative Hemorrhage/Hematoma of Musculoskeletal System
 ;;^UTILITY(U,$J,358.3,6211,1,4,0)
 ;;=4^M96.811
 ;;^UTILITY(U,$J,358.3,6211,2)
 ;;=^5015394
 ;;^UTILITY(U,$J,358.3,6212,0)
 ;;=J95.62^^40^386^37
 ;;^UTILITY(U,$J,358.3,6212,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6212,1,3,0)
 ;;=3^Intraoperative Hemorrhage/Hematoma of Respiratory System
 ;;^UTILITY(U,$J,358.3,6212,1,4,0)
 ;;=4^J95.62
 ;;^UTILITY(U,$J,358.3,6212,2)
 ;;=^5008333
 ;;^UTILITY(U,$J,358.3,6213,0)
 ;;=K91.72^^40^386^1
 ;;^UTILITY(U,$J,358.3,6213,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6213,1,3,0)
 ;;=3^Accidental Puncture/Laceration of Digestive System During Surgery
 ;;^UTILITY(U,$J,358.3,6213,1,4,0)
 ;;=4^K91.72
 ;;^UTILITY(U,$J,358.3,6213,2)
 ;;=^5008906
 ;;^UTILITY(U,$J,358.3,6214,0)
 ;;=E36.12^^40^386^2
 ;;^UTILITY(U,$J,358.3,6214,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6214,1,3,0)
 ;;=3^Accidental Puncture/Laceration of Endocrine System During Surgery
 ;;^UTILITY(U,$J,358.3,6214,1,4,0)
 ;;=4^E36.12
 ;;^UTILITY(U,$J,358.3,6214,2)
 ;;=^5002782
 ;;^UTILITY(U,$J,358.3,6215,0)
 ;;=H59.221^^40^386^9
 ;;^UTILITY(U,$J,358.3,6215,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6215,1,3,0)
 ;;=3^Accidental Puncture/Laceration of Right Eye/Adnexa During Surgery
 ;;^UTILITY(U,$J,358.3,6215,1,4,0)
 ;;=4^H59.221
 ;;^UTILITY(U,$J,358.3,6215,2)
 ;;=^5006413
 ;;^UTILITY(U,$J,358.3,6216,0)
 ;;=H59.222^^40^386^5
 ;;^UTILITY(U,$J,358.3,6216,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6216,1,3,0)
 ;;=3^Accidental Puncture/Laceration of Left Eye/Adnexa During Surgery
 ;;^UTILITY(U,$J,358.3,6216,1,4,0)
 ;;=4^H59.222
 ;;^UTILITY(U,$J,358.3,6216,2)
 ;;=^5006414
 ;;^UTILITY(U,$J,358.3,6217,0)
 ;;=N99.72^^40^386^4
 ;;^UTILITY(U,$J,358.3,6217,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6217,1,3,0)
 ;;=3^Accidental Puncture/Laceration of GU System
 ;;^UTILITY(U,$J,358.3,6217,1,4,0)
 ;;=4^N99.72
 ;;^UTILITY(U,$J,358.3,6217,2)
 ;;=^5015966
 ;;^UTILITY(U,$J,358.3,6218,0)
 ;;=M96.821^^40^386^6
 ;;^UTILITY(U,$J,358.3,6218,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6218,1,3,0)
 ;;=3^Accidental Puncture/Laceration of Musculoskeletal System
 ;;^UTILITY(U,$J,358.3,6218,1,4,0)
 ;;=4^M96.821
 ;;^UTILITY(U,$J,358.3,6218,2)
 ;;=^5015396
 ;;^UTILITY(U,$J,358.3,6219,0)
 ;;=G97.49^^40^386^7
 ;;^UTILITY(U,$J,358.3,6219,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6219,1,3,0)
 ;;=3^Accidental Puncture/Laceration of Nervous System During Surgery
 ;;^UTILITY(U,$J,358.3,6219,1,4,0)
 ;;=4^G97.49
 ;;^UTILITY(U,$J,358.3,6219,2)
 ;;=^5004208
 ;;^UTILITY(U,$J,358.3,6220,0)
 ;;=J95.72^^40^386^8
 ;;^UTILITY(U,$J,358.3,6220,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6220,1,3,0)
 ;;=3^Accidental Puncture/Laceration of Respiratory System During Surgery
 ;;^UTILITY(U,$J,358.3,6220,1,4,0)
 ;;=4^J95.72
 ;;^UTILITY(U,$J,358.3,6220,2)
 ;;=^5008335
 ;;^UTILITY(U,$J,358.3,6221,0)
 ;;=L76.12^^40^386^10
 ;;^UTILITY(U,$J,358.3,6221,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6221,1,3,0)
 ;;=3^Accidental Puncture/Laceration of Skin During Surgery
 ;;^UTILITY(U,$J,358.3,6221,1,4,0)
 ;;=4^L76.12
 ;;^UTILITY(U,$J,358.3,6221,2)
 ;;=^5009305
 ;;^UTILITY(U,$J,358.3,6222,0)
 ;;=I97.88^^40^386^15
