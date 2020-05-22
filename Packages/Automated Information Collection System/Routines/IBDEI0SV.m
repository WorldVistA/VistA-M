IBDEI0SV ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,12859,0)
 ;;=N99.62^^80^789^32
 ;;^UTILITY(U,$J,358.3,12859,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12859,1,3,0)
 ;;=3^Intraoperative Hemorrhage/Hematoma of GU System
 ;;^UTILITY(U,$J,358.3,12859,1,4,0)
 ;;=4^N99.62
 ;;^UTILITY(U,$J,358.3,12859,2)
 ;;=^5015964
 ;;^UTILITY(U,$J,358.3,12860,0)
 ;;=M96.811^^80^789^34
 ;;^UTILITY(U,$J,358.3,12860,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12860,1,3,0)
 ;;=3^Intraoperative Hemorrhage/Hematoma of Musculoskeletal System
 ;;^UTILITY(U,$J,358.3,12860,1,4,0)
 ;;=4^M96.811
 ;;^UTILITY(U,$J,358.3,12860,2)
 ;;=^5015394
 ;;^UTILITY(U,$J,358.3,12861,0)
 ;;=J95.62^^80^789^37
 ;;^UTILITY(U,$J,358.3,12861,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12861,1,3,0)
 ;;=3^Intraoperative Hemorrhage/Hematoma of Respiratory System
 ;;^UTILITY(U,$J,358.3,12861,1,4,0)
 ;;=4^J95.62
 ;;^UTILITY(U,$J,358.3,12861,2)
 ;;=^5008333
 ;;^UTILITY(U,$J,358.3,12862,0)
 ;;=K91.72^^80^789^1
 ;;^UTILITY(U,$J,358.3,12862,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12862,1,3,0)
 ;;=3^Accidental Puncture/Laceration of Digestive System During Surgery
 ;;^UTILITY(U,$J,358.3,12862,1,4,0)
 ;;=4^K91.72
 ;;^UTILITY(U,$J,358.3,12862,2)
 ;;=^5008906
 ;;^UTILITY(U,$J,358.3,12863,0)
 ;;=E36.12^^80^789^2
 ;;^UTILITY(U,$J,358.3,12863,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12863,1,3,0)
 ;;=3^Accidental Puncture/Laceration of Endocrine System During Surgery
 ;;^UTILITY(U,$J,358.3,12863,1,4,0)
 ;;=4^E36.12
 ;;^UTILITY(U,$J,358.3,12863,2)
 ;;=^5002782
 ;;^UTILITY(U,$J,358.3,12864,0)
 ;;=H59.221^^80^789^9
 ;;^UTILITY(U,$J,358.3,12864,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12864,1,3,0)
 ;;=3^Accidental Puncture/Laceration of Right Eye/Adnexa During Surgery
 ;;^UTILITY(U,$J,358.3,12864,1,4,0)
 ;;=4^H59.221
 ;;^UTILITY(U,$J,358.3,12864,2)
 ;;=^5006413
 ;;^UTILITY(U,$J,358.3,12865,0)
 ;;=H59.222^^80^789^5
 ;;^UTILITY(U,$J,358.3,12865,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12865,1,3,0)
 ;;=3^Accidental Puncture/Laceration of Left Eye/Adnexa During Surgery
 ;;^UTILITY(U,$J,358.3,12865,1,4,0)
 ;;=4^H59.222
 ;;^UTILITY(U,$J,358.3,12865,2)
 ;;=^5006414
 ;;^UTILITY(U,$J,358.3,12866,0)
 ;;=N99.72^^80^789^4
 ;;^UTILITY(U,$J,358.3,12866,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12866,1,3,0)
 ;;=3^Accidental Puncture/Laceration of GU System
 ;;^UTILITY(U,$J,358.3,12866,1,4,0)
 ;;=4^N99.72
 ;;^UTILITY(U,$J,358.3,12866,2)
 ;;=^5015966
 ;;^UTILITY(U,$J,358.3,12867,0)
 ;;=M96.821^^80^789^6
 ;;^UTILITY(U,$J,358.3,12867,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12867,1,3,0)
 ;;=3^Accidental Puncture/Laceration of Musculoskeletal System
 ;;^UTILITY(U,$J,358.3,12867,1,4,0)
 ;;=4^M96.821
 ;;^UTILITY(U,$J,358.3,12867,2)
 ;;=^5015396
 ;;^UTILITY(U,$J,358.3,12868,0)
 ;;=G97.49^^80^789^7
 ;;^UTILITY(U,$J,358.3,12868,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12868,1,3,0)
 ;;=3^Accidental Puncture/Laceration of Nervous System During Surgery
 ;;^UTILITY(U,$J,358.3,12868,1,4,0)
 ;;=4^G97.49
 ;;^UTILITY(U,$J,358.3,12868,2)
 ;;=^5004208
 ;;^UTILITY(U,$J,358.3,12869,0)
 ;;=J95.72^^80^789^8
 ;;^UTILITY(U,$J,358.3,12869,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12869,1,3,0)
 ;;=3^Accidental Puncture/Laceration of Respiratory System During Surgery
 ;;^UTILITY(U,$J,358.3,12869,1,4,0)
 ;;=4^J95.72
 ;;^UTILITY(U,$J,358.3,12869,2)
 ;;=^5008335
 ;;^UTILITY(U,$J,358.3,12870,0)
 ;;=L76.12^^80^789^10
