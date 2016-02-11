IBDEI0OL ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,11250,1,3,0)
 ;;=3^Spondylosis w/o Myelopathy/Radiculopathy,Cervical Region
 ;;^UTILITY(U,$J,358.3,11250,1,4,0)
 ;;=4^M47.812
 ;;^UTILITY(U,$J,358.3,11250,2)
 ;;=^5012069
 ;;^UTILITY(U,$J,358.3,11251,0)
 ;;=M47.814^^68^681^153
 ;;^UTILITY(U,$J,358.3,11251,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11251,1,3,0)
 ;;=3^Spondylosis w/o Myelopathy/Radiculopathy,Thoracic Region
 ;;^UTILITY(U,$J,358.3,11251,1,4,0)
 ;;=4^M47.814
 ;;^UTILITY(U,$J,358.3,11251,2)
 ;;=^5012071
 ;;^UTILITY(U,$J,358.3,11252,0)
 ;;=M47.817^^68^681^154
 ;;^UTILITY(U,$J,358.3,11252,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11252,1,3,0)
 ;;=3^Spondylosis w/o Myelopathy/Radiculopathy,Lumbosacral Region
 ;;^UTILITY(U,$J,358.3,11252,1,4,0)
 ;;=4^M47.817
 ;;^UTILITY(U,$J,358.3,11252,2)
 ;;=^5012074
 ;;^UTILITY(U,$J,358.3,11253,0)
 ;;=M48.50XA^^68^681^21
 ;;^UTILITY(U,$J,358.3,11253,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11253,1,3,0)
 ;;=3^Collapsed Vertebra NEC,Site Unspec,Init Encntr
 ;;^UTILITY(U,$J,358.3,11253,1,4,0)
 ;;=4^M48.50XA
 ;;^UTILITY(U,$J,358.3,11253,2)
 ;;=^5012159
 ;;^UTILITY(U,$J,358.3,11254,0)
 ;;=M48.50XD^^68^681^22
 ;;^UTILITY(U,$J,358.3,11254,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11254,1,3,0)
 ;;=3^Collapsed Vertebra NEC,Site Unspec,Subs Encntr
 ;;^UTILITY(U,$J,358.3,11254,1,4,0)
 ;;=4^M48.50XD
 ;;^UTILITY(U,$J,358.3,11254,2)
 ;;=^5012160
 ;;^UTILITY(U,$J,358.3,11255,0)
 ;;=M48.52XA^^68^681^23
 ;;^UTILITY(U,$J,358.3,11255,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11255,1,3,0)
 ;;=3^Collapsed Vertebra,Cervical Region,Init Encntr
 ;;^UTILITY(U,$J,358.3,11255,1,4,0)
 ;;=4^M48.52XA
 ;;^UTILITY(U,$J,358.3,11255,2)
 ;;=^5012167
 ;;^UTILITY(U,$J,358.3,11256,0)
 ;;=M48.52XD^^68^681^24
 ;;^UTILITY(U,$J,358.3,11256,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11256,1,3,0)
 ;;=3^Collapsed Vertebra,Cervical Region,Subs Encntr,Rt Healing
 ;;^UTILITY(U,$J,358.3,11256,1,4,0)
 ;;=4^M48.52XD
 ;;^UTILITY(U,$J,358.3,11256,2)
 ;;=^5012168
 ;;^UTILITY(U,$J,358.3,11257,0)
 ;;=M48.54XA^^68^681^32
 ;;^UTILITY(U,$J,358.3,11257,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11257,1,3,0)
 ;;=3^Collapsed Vertebra,Throacic Region,Init Encntr
 ;;^UTILITY(U,$J,358.3,11257,1,4,0)
 ;;=4^M48.54XA
 ;;^UTILITY(U,$J,358.3,11257,2)
 ;;=^5012175
 ;;^UTILITY(U,$J,358.3,11258,0)
 ;;=M48.54XD^^68^681^33
 ;;^UTILITY(U,$J,358.3,11258,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11258,1,3,0)
 ;;=3^Collapsed Vertebra,Throacic Region,Subs Encntr
 ;;^UTILITY(U,$J,358.3,11258,1,4,0)
 ;;=4^M48.54XD
 ;;^UTILITY(U,$J,358.3,11258,2)
 ;;=^5012176
 ;;^UTILITY(U,$J,358.3,11259,0)
 ;;=M48.57XA^^68^681^25
 ;;^UTILITY(U,$J,358.3,11259,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11259,1,3,0)
 ;;=3^Collapsed Vertebra,Lumbosacral Region,Init Encntr
 ;;^UTILITY(U,$J,358.3,11259,1,4,0)
 ;;=4^M48.57XA
 ;;^UTILITY(U,$J,358.3,11259,2)
 ;;=^5012187
 ;;^UTILITY(U,$J,358.3,11260,0)
 ;;=M48.57XD^^68^681^26
 ;;^UTILITY(U,$J,358.3,11260,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11260,1,3,0)
 ;;=3^Collapsed Vertebra,Lumbosacral Region,Subs Encntr,Rt Healing
 ;;^UTILITY(U,$J,358.3,11260,1,4,0)
 ;;=4^M48.57XD
 ;;^UTILITY(U,$J,358.3,11260,2)
 ;;=^5012188
 ;;^UTILITY(U,$J,358.3,11261,0)
 ;;=M50.30^^68^681^13
 ;;^UTILITY(U,$J,358.3,11261,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11261,1,3,0)
 ;;=3^Cervical Disc Degeneration,Unspec Region
 ;;^UTILITY(U,$J,358.3,11261,1,4,0)
 ;;=4^M50.30
 ;;^UTILITY(U,$J,358.3,11261,2)
 ;;=^5012227
 ;;^UTILITY(U,$J,358.3,11262,0)
 ;;=M51.14^^68^681^52
 ;;^UTILITY(U,$J,358.3,11262,1,0)
 ;;=^358.31IA^4^2
