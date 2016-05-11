IBDEI0TP ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,13927,1,4,0)
 ;;=4^M45.8
 ;;^UTILITY(U,$J,358.3,13927,2)
 ;;=^5011968
 ;;^UTILITY(U,$J,358.3,13928,0)
 ;;=M47.22^^53^599^172
 ;;^UTILITY(U,$J,358.3,13928,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13928,1,3,0)
 ;;=3^Sponylosis w/ Radiculopathy,Cervical Region NEC
 ;;^UTILITY(U,$J,358.3,13928,1,4,0)
 ;;=4^M47.22
 ;;^UTILITY(U,$J,358.3,13928,2)
 ;;=^5012061
 ;;^UTILITY(U,$J,358.3,13929,0)
 ;;=M47.24^^53^599^174
 ;;^UTILITY(U,$J,358.3,13929,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13929,1,3,0)
 ;;=3^Sponylosis w/ Radiculopathy,Thoracic Region NEC
 ;;^UTILITY(U,$J,358.3,13929,1,4,0)
 ;;=4^M47.24
 ;;^UTILITY(U,$J,358.3,13929,2)
 ;;=^5012063
 ;;^UTILITY(U,$J,358.3,13930,0)
 ;;=M47.27^^53^599^173
 ;;^UTILITY(U,$J,358.3,13930,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13930,1,3,0)
 ;;=3^Sponylosis w/ Radiculopathy,Lumbosacral Region NEC
 ;;^UTILITY(U,$J,358.3,13930,1,4,0)
 ;;=4^M47.27
 ;;^UTILITY(U,$J,358.3,13930,2)
 ;;=^5012066
 ;;^UTILITY(U,$J,358.3,13931,0)
 ;;=M47.812^^53^599^169
 ;;^UTILITY(U,$J,358.3,13931,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13931,1,3,0)
 ;;=3^Spondylosis w/o Myelopathy/Radiculopathy,Cervical Region
 ;;^UTILITY(U,$J,358.3,13931,1,4,0)
 ;;=4^M47.812
 ;;^UTILITY(U,$J,358.3,13931,2)
 ;;=^5012069
 ;;^UTILITY(U,$J,358.3,13932,0)
 ;;=M47.814^^53^599^170
 ;;^UTILITY(U,$J,358.3,13932,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13932,1,3,0)
 ;;=3^Spondylosis w/o Myelopathy/Radiculopathy,Thoracic Region
 ;;^UTILITY(U,$J,358.3,13932,1,4,0)
 ;;=4^M47.814
 ;;^UTILITY(U,$J,358.3,13932,2)
 ;;=^5012071
 ;;^UTILITY(U,$J,358.3,13933,0)
 ;;=M47.817^^53^599^171
 ;;^UTILITY(U,$J,358.3,13933,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13933,1,3,0)
 ;;=3^Spondylosis w/o Myelopathy/Radiculopathy,Lumbosacral Region
 ;;^UTILITY(U,$J,358.3,13933,1,4,0)
 ;;=4^M47.817
 ;;^UTILITY(U,$J,358.3,13933,2)
 ;;=^5012074
 ;;^UTILITY(U,$J,358.3,13934,0)
 ;;=M48.50XA^^53^599^21
 ;;^UTILITY(U,$J,358.3,13934,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13934,1,3,0)
 ;;=3^Collapsed Vertebra NEC,Site Unspec,Init Encntr
 ;;^UTILITY(U,$J,358.3,13934,1,4,0)
 ;;=4^M48.50XA
 ;;^UTILITY(U,$J,358.3,13934,2)
 ;;=^5012159
 ;;^UTILITY(U,$J,358.3,13935,0)
 ;;=M48.50XD^^53^599^22
 ;;^UTILITY(U,$J,358.3,13935,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13935,1,3,0)
 ;;=3^Collapsed Vertebra NEC,Site Unspec,Subs Encntr
 ;;^UTILITY(U,$J,358.3,13935,1,4,0)
 ;;=4^M48.50XD
 ;;^UTILITY(U,$J,358.3,13935,2)
 ;;=^5012160
 ;;^UTILITY(U,$J,358.3,13936,0)
 ;;=M48.52XA^^53^599^23
 ;;^UTILITY(U,$J,358.3,13936,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13936,1,3,0)
 ;;=3^Collapsed Vertebra,Cervical Region,Init Encntr
 ;;^UTILITY(U,$J,358.3,13936,1,4,0)
 ;;=4^M48.52XA
 ;;^UTILITY(U,$J,358.3,13936,2)
 ;;=^5012167
 ;;^UTILITY(U,$J,358.3,13937,0)
 ;;=M48.52XD^^53^599^24
 ;;^UTILITY(U,$J,358.3,13937,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13937,1,3,0)
 ;;=3^Collapsed Vertebra,Cervical Region,Subs Encntr,Rt Healing
 ;;^UTILITY(U,$J,358.3,13937,1,4,0)
 ;;=4^M48.52XD
 ;;^UTILITY(U,$J,358.3,13937,2)
 ;;=^5012168
 ;;^UTILITY(U,$J,358.3,13938,0)
 ;;=M48.54XA^^53^599^32
 ;;^UTILITY(U,$J,358.3,13938,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13938,1,3,0)
 ;;=3^Collapsed Vertebra,Throacic Region,Init Encntr
 ;;^UTILITY(U,$J,358.3,13938,1,4,0)
 ;;=4^M48.54XA
 ;;^UTILITY(U,$J,358.3,13938,2)
 ;;=^5012175
 ;;^UTILITY(U,$J,358.3,13939,0)
 ;;=M48.54XD^^53^599^33
 ;;^UTILITY(U,$J,358.3,13939,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13939,1,3,0)
 ;;=3^Collapsed Vertebra,Throacic Region,Subs Encntr
 ;;^UTILITY(U,$J,358.3,13939,1,4,0)
 ;;=4^M48.54XD
