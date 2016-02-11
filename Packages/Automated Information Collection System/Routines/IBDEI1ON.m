IBDEI1ON ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,28154,1,3,0)
 ;;=3^Spondylosis w/o Myelopathy/Radiculopathy,Thoracic Region
 ;;^UTILITY(U,$J,358.3,28154,1,4,0)
 ;;=4^M47.814
 ;;^UTILITY(U,$J,358.3,28154,2)
 ;;=^5012071
 ;;^UTILITY(U,$J,358.3,28155,0)
 ;;=M47.817^^132^1326^154
 ;;^UTILITY(U,$J,358.3,28155,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28155,1,3,0)
 ;;=3^Spondylosis w/o Myelopathy/Radiculopathy,Lumbosacral Region
 ;;^UTILITY(U,$J,358.3,28155,1,4,0)
 ;;=4^M47.817
 ;;^UTILITY(U,$J,358.3,28155,2)
 ;;=^5012074
 ;;^UTILITY(U,$J,358.3,28156,0)
 ;;=M48.50XA^^132^1326^21
 ;;^UTILITY(U,$J,358.3,28156,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28156,1,3,0)
 ;;=3^Collapsed Vertebra NEC,Site Unspec,Init Encntr
 ;;^UTILITY(U,$J,358.3,28156,1,4,0)
 ;;=4^M48.50XA
 ;;^UTILITY(U,$J,358.3,28156,2)
 ;;=^5012159
 ;;^UTILITY(U,$J,358.3,28157,0)
 ;;=M48.50XD^^132^1326^22
 ;;^UTILITY(U,$J,358.3,28157,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28157,1,3,0)
 ;;=3^Collapsed Vertebra NEC,Site Unspec,Subs Encntr
 ;;^UTILITY(U,$J,358.3,28157,1,4,0)
 ;;=4^M48.50XD
 ;;^UTILITY(U,$J,358.3,28157,2)
 ;;=^5012160
 ;;^UTILITY(U,$J,358.3,28158,0)
 ;;=M48.52XA^^132^1326^23
 ;;^UTILITY(U,$J,358.3,28158,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28158,1,3,0)
 ;;=3^Collapsed Vertebra,Cervical Region,Init Encntr
 ;;^UTILITY(U,$J,358.3,28158,1,4,0)
 ;;=4^M48.52XA
 ;;^UTILITY(U,$J,358.3,28158,2)
 ;;=^5012167
 ;;^UTILITY(U,$J,358.3,28159,0)
 ;;=M48.52XD^^132^1326^24
 ;;^UTILITY(U,$J,358.3,28159,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28159,1,3,0)
 ;;=3^Collapsed Vertebra,Cervical Region,Subs Encntr,Rt Healing
 ;;^UTILITY(U,$J,358.3,28159,1,4,0)
 ;;=4^M48.52XD
 ;;^UTILITY(U,$J,358.3,28159,2)
 ;;=^5012168
 ;;^UTILITY(U,$J,358.3,28160,0)
 ;;=M48.54XA^^132^1326^32
 ;;^UTILITY(U,$J,358.3,28160,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28160,1,3,0)
 ;;=3^Collapsed Vertebra,Throacic Region,Init Encntr
 ;;^UTILITY(U,$J,358.3,28160,1,4,0)
 ;;=4^M48.54XA
 ;;^UTILITY(U,$J,358.3,28160,2)
 ;;=^5012175
 ;;^UTILITY(U,$J,358.3,28161,0)
 ;;=M48.54XD^^132^1326^33
 ;;^UTILITY(U,$J,358.3,28161,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28161,1,3,0)
 ;;=3^Collapsed Vertebra,Throacic Region,Subs Encntr
 ;;^UTILITY(U,$J,358.3,28161,1,4,0)
 ;;=4^M48.54XD
 ;;^UTILITY(U,$J,358.3,28161,2)
 ;;=^5012176
 ;;^UTILITY(U,$J,358.3,28162,0)
 ;;=M48.57XA^^132^1326^25
 ;;^UTILITY(U,$J,358.3,28162,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28162,1,3,0)
 ;;=3^Collapsed Vertebra,Lumbosacral Region,Init Encntr
 ;;^UTILITY(U,$J,358.3,28162,1,4,0)
 ;;=4^M48.57XA
 ;;^UTILITY(U,$J,358.3,28162,2)
 ;;=^5012187
 ;;^UTILITY(U,$J,358.3,28163,0)
 ;;=M48.57XD^^132^1326^26
 ;;^UTILITY(U,$J,358.3,28163,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28163,1,3,0)
 ;;=3^Collapsed Vertebra,Lumbosacral Region,Subs Encntr,Rt Healing
 ;;^UTILITY(U,$J,358.3,28163,1,4,0)
 ;;=4^M48.57XD
 ;;^UTILITY(U,$J,358.3,28163,2)
 ;;=^5012188
 ;;^UTILITY(U,$J,358.3,28164,0)
 ;;=M50.30^^132^1326^13
 ;;^UTILITY(U,$J,358.3,28164,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28164,1,3,0)
 ;;=3^Cervical Disc Degeneration,Unspec Region
 ;;^UTILITY(U,$J,358.3,28164,1,4,0)
 ;;=4^M50.30
 ;;^UTILITY(U,$J,358.3,28164,2)
 ;;=^5012227
 ;;^UTILITY(U,$J,358.3,28165,0)
 ;;=M51.14^^132^1326^52
 ;;^UTILITY(U,$J,358.3,28165,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,28165,1,3,0)
 ;;=3^Intvrt Disc Disorder w/ Radiculopathy,Thoracic Region
 ;;^UTILITY(U,$J,358.3,28165,1,4,0)
 ;;=4^M51.14
 ;;^UTILITY(U,$J,358.3,28165,2)
 ;;=^5012243
 ;;^UTILITY(U,$J,358.3,28166,0)
 ;;=M51.17^^132^1326^51
 ;;^UTILITY(U,$J,358.3,28166,1,0)
 ;;=^358.31IA^4^2
