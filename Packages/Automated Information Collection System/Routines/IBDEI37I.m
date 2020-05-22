IBDEI37I ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,51197,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,51197,1,3,0)
 ;;=3^Spondylosis w/o Myelopathy/Radiculopathy,Lumbosacral Region
 ;;^UTILITY(U,$J,358.3,51197,1,4,0)
 ;;=4^M47.817
 ;;^UTILITY(U,$J,358.3,51197,2)
 ;;=^5012074
 ;;^UTILITY(U,$J,358.3,51198,0)
 ;;=M48.50XA^^193^2503^22
 ;;^UTILITY(U,$J,358.3,51198,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,51198,1,3,0)
 ;;=3^Collapsed Vertebra NEC,Site Unspec,Init Encntr
 ;;^UTILITY(U,$J,358.3,51198,1,4,0)
 ;;=4^M48.50XA
 ;;^UTILITY(U,$J,358.3,51198,2)
 ;;=^5012159
 ;;^UTILITY(U,$J,358.3,51199,0)
 ;;=M48.50XD^^193^2503^23
 ;;^UTILITY(U,$J,358.3,51199,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,51199,1,3,0)
 ;;=3^Collapsed Vertebra NEC,Site Unspec,Subs Encntr
 ;;^UTILITY(U,$J,358.3,51199,1,4,0)
 ;;=4^M48.50XD
 ;;^UTILITY(U,$J,358.3,51199,2)
 ;;=^5012160
 ;;^UTILITY(U,$J,358.3,51200,0)
 ;;=M48.52XA^^193^2503^24
 ;;^UTILITY(U,$J,358.3,51200,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,51200,1,3,0)
 ;;=3^Collapsed Vertebra,Cervical Region,Init Encntr
 ;;^UTILITY(U,$J,358.3,51200,1,4,0)
 ;;=4^M48.52XA
 ;;^UTILITY(U,$J,358.3,51200,2)
 ;;=^5012167
 ;;^UTILITY(U,$J,358.3,51201,0)
 ;;=M48.52XD^^193^2503^25
 ;;^UTILITY(U,$J,358.3,51201,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,51201,1,3,0)
 ;;=3^Collapsed Vertebra,Cervical Region,Subs Encntr,Rt Healing
 ;;^UTILITY(U,$J,358.3,51201,1,4,0)
 ;;=4^M48.52XD
 ;;^UTILITY(U,$J,358.3,51201,2)
 ;;=^5012168
 ;;^UTILITY(U,$J,358.3,51202,0)
 ;;=M48.54XA^^193^2503^33
 ;;^UTILITY(U,$J,358.3,51202,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,51202,1,3,0)
 ;;=3^Collapsed Vertebra,Throacic Region,Init Encntr
 ;;^UTILITY(U,$J,358.3,51202,1,4,0)
 ;;=4^M48.54XA
 ;;^UTILITY(U,$J,358.3,51202,2)
 ;;=^5012175
 ;;^UTILITY(U,$J,358.3,51203,0)
 ;;=M48.54XD^^193^2503^34
 ;;^UTILITY(U,$J,358.3,51203,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,51203,1,3,0)
 ;;=3^Collapsed Vertebra,Throacic Region,Subs Encntr
 ;;^UTILITY(U,$J,358.3,51203,1,4,0)
 ;;=4^M48.54XD
 ;;^UTILITY(U,$J,358.3,51203,2)
 ;;=^5012176
 ;;^UTILITY(U,$J,358.3,51204,0)
 ;;=M48.57XA^^193^2503^26
 ;;^UTILITY(U,$J,358.3,51204,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,51204,1,3,0)
 ;;=3^Collapsed Vertebra,Lumbosacral Region,Init Encntr
 ;;^UTILITY(U,$J,358.3,51204,1,4,0)
 ;;=4^M48.57XA
 ;;^UTILITY(U,$J,358.3,51204,2)
 ;;=^5012187
 ;;^UTILITY(U,$J,358.3,51205,0)
 ;;=M48.57XD^^193^2503^27
 ;;^UTILITY(U,$J,358.3,51205,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,51205,1,3,0)
 ;;=3^Collapsed Vertebra,Lumbosacral Region,Subs Encntr,Rt Healing
 ;;^UTILITY(U,$J,358.3,51205,1,4,0)
 ;;=4^M48.57XD
 ;;^UTILITY(U,$J,358.3,51205,2)
 ;;=^5012188
 ;;^UTILITY(U,$J,358.3,51206,0)
 ;;=M50.30^^193^2503^14
 ;;^UTILITY(U,$J,358.3,51206,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,51206,1,3,0)
 ;;=3^Cervical Disc Degeneration,Unspec Region
 ;;^UTILITY(U,$J,358.3,51206,1,4,0)
 ;;=4^M50.30
 ;;^UTILITY(U,$J,358.3,51206,2)
 ;;=^5012227
 ;;^UTILITY(U,$J,358.3,51207,0)
 ;;=M51.14^^193^2503^55
 ;;^UTILITY(U,$J,358.3,51207,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,51207,1,3,0)
 ;;=3^Intvrt Disc Disorder w/ Radiculopathy,Thoracic Region
 ;;^UTILITY(U,$J,358.3,51207,1,4,0)
 ;;=4^M51.14
 ;;^UTILITY(U,$J,358.3,51207,2)
 ;;=^5012243
 ;;^UTILITY(U,$J,358.3,51208,0)
 ;;=M51.17^^193^2503^54
 ;;^UTILITY(U,$J,358.3,51208,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,51208,1,3,0)
 ;;=3^Intvrt Disc Disorder w/ Radiculopathy,Lumbosacral Region
