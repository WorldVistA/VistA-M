IBDEI0FA ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,7047,1,4,0)
 ;;=4^M47.27
 ;;^UTILITY(U,$J,358.3,7047,2)
 ;;=^5012066
 ;;^UTILITY(U,$J,358.3,7048,0)
 ;;=M47.812^^30^402^160
 ;;^UTILITY(U,$J,358.3,7048,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7048,1,3,0)
 ;;=3^Spondylosis w/o Myelopathy/Radiculopathy,Cervical Region
 ;;^UTILITY(U,$J,358.3,7048,1,4,0)
 ;;=4^M47.812
 ;;^UTILITY(U,$J,358.3,7048,2)
 ;;=^5012069
 ;;^UTILITY(U,$J,358.3,7049,0)
 ;;=M47.814^^30^402^161
 ;;^UTILITY(U,$J,358.3,7049,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7049,1,3,0)
 ;;=3^Spondylosis w/o Myelopathy/Radiculopathy,Thoracic Region
 ;;^UTILITY(U,$J,358.3,7049,1,4,0)
 ;;=4^M47.814
 ;;^UTILITY(U,$J,358.3,7049,2)
 ;;=^5012071
 ;;^UTILITY(U,$J,358.3,7050,0)
 ;;=M47.817^^30^402^162
 ;;^UTILITY(U,$J,358.3,7050,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7050,1,3,0)
 ;;=3^Spondylosis w/o Myelopathy/Radiculopathy,Lumbosacral Region
 ;;^UTILITY(U,$J,358.3,7050,1,4,0)
 ;;=4^M47.817
 ;;^UTILITY(U,$J,358.3,7050,2)
 ;;=^5012074
 ;;^UTILITY(U,$J,358.3,7051,0)
 ;;=M48.50XA^^30^402^21
 ;;^UTILITY(U,$J,358.3,7051,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7051,1,3,0)
 ;;=3^Collapsed Vertebra NEC,Site Unspec,Init Encntr
 ;;^UTILITY(U,$J,358.3,7051,1,4,0)
 ;;=4^M48.50XA
 ;;^UTILITY(U,$J,358.3,7051,2)
 ;;=^5012159
 ;;^UTILITY(U,$J,358.3,7052,0)
 ;;=M48.50XD^^30^402^22
 ;;^UTILITY(U,$J,358.3,7052,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7052,1,3,0)
 ;;=3^Collapsed Vertebra NEC,Site Unspec,Subs Encntr
 ;;^UTILITY(U,$J,358.3,7052,1,4,0)
 ;;=4^M48.50XD
 ;;^UTILITY(U,$J,358.3,7052,2)
 ;;=^5012160
 ;;^UTILITY(U,$J,358.3,7053,0)
 ;;=M48.52XA^^30^402^23
 ;;^UTILITY(U,$J,358.3,7053,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7053,1,3,0)
 ;;=3^Collapsed Vertebra,Cervical Region,Init Encntr
 ;;^UTILITY(U,$J,358.3,7053,1,4,0)
 ;;=4^M48.52XA
 ;;^UTILITY(U,$J,358.3,7053,2)
 ;;=^5012167
 ;;^UTILITY(U,$J,358.3,7054,0)
 ;;=M48.52XD^^30^402^24
 ;;^UTILITY(U,$J,358.3,7054,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7054,1,3,0)
 ;;=3^Collapsed Vertebra,Cervical Region,Subs Encntr,Rt Healing
 ;;^UTILITY(U,$J,358.3,7054,1,4,0)
 ;;=4^M48.52XD
 ;;^UTILITY(U,$J,358.3,7054,2)
 ;;=^5012168
 ;;^UTILITY(U,$J,358.3,7055,0)
 ;;=M48.54XA^^30^402^32
 ;;^UTILITY(U,$J,358.3,7055,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7055,1,3,0)
 ;;=3^Collapsed Vertebra,Throacic Region,Init Encntr
 ;;^UTILITY(U,$J,358.3,7055,1,4,0)
 ;;=4^M48.54XA
 ;;^UTILITY(U,$J,358.3,7055,2)
 ;;=^5012175
 ;;^UTILITY(U,$J,358.3,7056,0)
 ;;=M48.54XD^^30^402^33
 ;;^UTILITY(U,$J,358.3,7056,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7056,1,3,0)
 ;;=3^Collapsed Vertebra,Throacic Region,Subs Encntr
 ;;^UTILITY(U,$J,358.3,7056,1,4,0)
 ;;=4^M48.54XD
 ;;^UTILITY(U,$J,358.3,7056,2)
 ;;=^5012176
 ;;^UTILITY(U,$J,358.3,7057,0)
 ;;=M48.57XA^^30^402^25
 ;;^UTILITY(U,$J,358.3,7057,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7057,1,3,0)
 ;;=3^Collapsed Vertebra,Lumbosacral Region,Init Encntr
 ;;^UTILITY(U,$J,358.3,7057,1,4,0)
 ;;=4^M48.57XA
 ;;^UTILITY(U,$J,358.3,7057,2)
 ;;=^5012187
 ;;^UTILITY(U,$J,358.3,7058,0)
 ;;=M48.57XD^^30^402^26
 ;;^UTILITY(U,$J,358.3,7058,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7058,1,3,0)
 ;;=3^Collapsed Vertebra,Lumbosacral Region,Subs Encntr,Rt Healing
 ;;^UTILITY(U,$J,358.3,7058,1,4,0)
 ;;=4^M48.57XD
 ;;^UTILITY(U,$J,358.3,7058,2)
 ;;=^5012188
 ;;^UTILITY(U,$J,358.3,7059,0)
 ;;=M50.30^^30^402^13
 ;;^UTILITY(U,$J,358.3,7059,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7059,1,3,0)
 ;;=3^Cervical Disc Degeneration,Unspec Region
 ;;^UTILITY(U,$J,358.3,7059,1,4,0)
 ;;=4^M50.30
 ;;^UTILITY(U,$J,358.3,7059,2)
 ;;=^5012227
