IBDEI0YF ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,15858,1,3,0)
 ;;=3^Intraoperative Hemorrhage/Hematoma of Endocrine System
 ;;^UTILITY(U,$J,358.3,15858,1,4,0)
 ;;=4^E36.02
 ;;^UTILITY(U,$J,358.3,15858,2)
 ;;=^5002780
 ;;^UTILITY(U,$J,358.3,15859,0)
 ;;=H59.121^^85^828^36
 ;;^UTILITY(U,$J,358.3,15859,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15859,1,3,0)
 ;;=3^Intraoperative Hemorrhage/Hematoma of Right Eye/Adnexa
 ;;^UTILITY(U,$J,358.3,15859,1,4,0)
 ;;=4^H59.121
 ;;^UTILITY(U,$J,358.3,15859,2)
 ;;=^5006405
 ;;^UTILITY(U,$J,358.3,15860,0)
 ;;=H59.122^^85^828^33
 ;;^UTILITY(U,$J,358.3,15860,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15860,1,3,0)
 ;;=3^Intraoperative Hemorrhage/Hematoma of Left Eye/Adnexa
 ;;^UTILITY(U,$J,358.3,15860,1,4,0)
 ;;=4^H59.122
 ;;^UTILITY(U,$J,358.3,15860,2)
 ;;=^5006406
 ;;^UTILITY(U,$J,358.3,15861,0)
 ;;=H59.123^^85^828^24
 ;;^UTILITY(U,$J,358.3,15861,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15861,1,3,0)
 ;;=3^Intraoperative Hemorrhage/Hematoma of Bilateral Eyes/Adnexa
 ;;^UTILITY(U,$J,358.3,15861,1,4,0)
 ;;=4^H59.123
 ;;^UTILITY(U,$J,358.3,15861,2)
 ;;=^5006407
 ;;^UTILITY(U,$J,358.3,15862,0)
 ;;=N99.62^^85^828^32
 ;;^UTILITY(U,$J,358.3,15862,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15862,1,3,0)
 ;;=3^Intraoperative Hemorrhage/Hematoma of GU System
 ;;^UTILITY(U,$J,358.3,15862,1,4,0)
 ;;=4^N99.62
 ;;^UTILITY(U,$J,358.3,15862,2)
 ;;=^5015964
 ;;^UTILITY(U,$J,358.3,15863,0)
 ;;=M96.811^^85^828^34
 ;;^UTILITY(U,$J,358.3,15863,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15863,1,3,0)
 ;;=3^Intraoperative Hemorrhage/Hematoma of Musculoskeletal System
 ;;^UTILITY(U,$J,358.3,15863,1,4,0)
 ;;=4^M96.811
 ;;^UTILITY(U,$J,358.3,15863,2)
 ;;=^5015394
 ;;^UTILITY(U,$J,358.3,15864,0)
 ;;=J95.62^^85^828^37
 ;;^UTILITY(U,$J,358.3,15864,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15864,1,3,0)
 ;;=3^Intraoperative Hemorrhage/Hematoma of Respiratory System
 ;;^UTILITY(U,$J,358.3,15864,1,4,0)
 ;;=4^J95.62
 ;;^UTILITY(U,$J,358.3,15864,2)
 ;;=^5008333
 ;;^UTILITY(U,$J,358.3,15865,0)
 ;;=K91.72^^85^828^1
 ;;^UTILITY(U,$J,358.3,15865,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15865,1,3,0)
 ;;=3^Accidental Puncture/Laceration of Digestive System During Surgery
 ;;^UTILITY(U,$J,358.3,15865,1,4,0)
 ;;=4^K91.72
 ;;^UTILITY(U,$J,358.3,15865,2)
 ;;=^5008906
 ;;^UTILITY(U,$J,358.3,15866,0)
 ;;=E36.12^^85^828^2
 ;;^UTILITY(U,$J,358.3,15866,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15866,1,3,0)
 ;;=3^Accidental Puncture/Laceration of Endocrine System During Surgery
 ;;^UTILITY(U,$J,358.3,15866,1,4,0)
 ;;=4^E36.12
 ;;^UTILITY(U,$J,358.3,15866,2)
 ;;=^5002782
 ;;^UTILITY(U,$J,358.3,15867,0)
 ;;=H59.221^^85^828^9
 ;;^UTILITY(U,$J,358.3,15867,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15867,1,3,0)
 ;;=3^Accidental Puncture/Laceration of Right Eye/Adnexa During Surgery
 ;;^UTILITY(U,$J,358.3,15867,1,4,0)
 ;;=4^H59.221
 ;;^UTILITY(U,$J,358.3,15867,2)
 ;;=^5006413
 ;;^UTILITY(U,$J,358.3,15868,0)
 ;;=H59.222^^85^828^5
 ;;^UTILITY(U,$J,358.3,15868,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15868,1,3,0)
 ;;=3^Accidental Puncture/Laceration of Left Eye/Adnexa During Surgery
 ;;^UTILITY(U,$J,358.3,15868,1,4,0)
 ;;=4^H59.222
 ;;^UTILITY(U,$J,358.3,15868,2)
 ;;=^5006414
 ;;^UTILITY(U,$J,358.3,15869,0)
 ;;=N99.72^^85^828^4
 ;;^UTILITY(U,$J,358.3,15869,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15869,1,3,0)
 ;;=3^Accidental Puncture/Laceration of GU System
 ;;^UTILITY(U,$J,358.3,15869,1,4,0)
 ;;=4^N99.72
 ;;^UTILITY(U,$J,358.3,15869,2)
 ;;=^5015966
 ;;^UTILITY(U,$J,358.3,15870,0)
 ;;=M96.821^^85^828^6
