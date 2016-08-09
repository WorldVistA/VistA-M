IBDEI0F2 ; ; 12-MAY-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,15066,1,3,0)
 ;;=3^Primary Osteoarthritis of Left Shoulder
 ;;^UTILITY(U,$J,358.3,15066,1,4,0)
 ;;=4^M19.012
 ;;^UTILITY(U,$J,358.3,15066,2)
 ;;=^5010809
 ;;^UTILITY(U,$J,358.3,15067,0)
 ;;=M19.031^^61^746^136
 ;;^UTILITY(U,$J,358.3,15067,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15067,1,3,0)
 ;;=3^Primary Osteoarthritis of Right Wrist
 ;;^UTILITY(U,$J,358.3,15067,1,4,0)
 ;;=4^M19.031
 ;;^UTILITY(U,$J,358.3,15067,2)
 ;;=^5010814
 ;;^UTILITY(U,$J,358.3,15068,0)
 ;;=M19.032^^61^746^130
 ;;^UTILITY(U,$J,358.3,15068,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15068,1,3,0)
 ;;=3^Primary Osteoarthritis of Left Wrist
 ;;^UTILITY(U,$J,358.3,15068,1,4,0)
 ;;=4^M19.032
 ;;^UTILITY(U,$J,358.3,15068,2)
 ;;=^5010815
 ;;^UTILITY(U,$J,358.3,15069,0)
 ;;=M19.041^^61^746^131
 ;;^UTILITY(U,$J,358.3,15069,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15069,1,3,0)
 ;;=3^Primary Osteoarthritis of Right Hand
 ;;^UTILITY(U,$J,358.3,15069,1,4,0)
 ;;=4^M19.041
 ;;^UTILITY(U,$J,358.3,15069,2)
 ;;=^5010817
 ;;^UTILITY(U,$J,358.3,15070,0)
 ;;=M19.042^^61^746^125
 ;;^UTILITY(U,$J,358.3,15070,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15070,1,3,0)
 ;;=3^Primary Osteoarthritis of Left Hand
 ;;^UTILITY(U,$J,358.3,15070,1,4,0)
 ;;=4^M19.042
 ;;^UTILITY(U,$J,358.3,15070,2)
 ;;=^5010818
 ;;^UTILITY(U,$J,358.3,15071,0)
 ;;=M19.90^^61^746^68
 ;;^UTILITY(U,$J,358.3,15071,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15071,1,3,0)
 ;;=3^Osteoarthritis,Unspec
 ;;^UTILITY(U,$J,358.3,15071,1,4,0)
 ;;=4^M19.90
 ;;^UTILITY(U,$J,358.3,15071,2)
 ;;=^5010853
 ;;^UTILITY(U,$J,358.3,15072,0)
 ;;=M25.40^^61^746^37
 ;;^UTILITY(U,$J,358.3,15072,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15072,1,3,0)
 ;;=3^Effusion,Unspec
 ;;^UTILITY(U,$J,358.3,15072,1,4,0)
 ;;=4^M25.40
 ;;^UTILITY(U,$J,358.3,15072,2)
 ;;=^5011575
 ;;^UTILITY(U,$J,358.3,15073,0)
 ;;=M45.0^^61^746^6
 ;;^UTILITY(U,$J,358.3,15073,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15073,1,3,0)
 ;;=3^Ankylosing Spondylitis of Spine,Mult Sites
 ;;^UTILITY(U,$J,358.3,15073,1,4,0)
 ;;=4^M45.0
 ;;^UTILITY(U,$J,358.3,15073,2)
 ;;=^5011960
 ;;^UTILITY(U,$J,358.3,15074,0)
 ;;=M45.2^^61^746^3
 ;;^UTILITY(U,$J,358.3,15074,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15074,1,3,0)
 ;;=3^Ankylosing Spondylitis of Cervical Region
 ;;^UTILITY(U,$J,358.3,15074,1,4,0)
 ;;=4^M45.2
 ;;^UTILITY(U,$J,358.3,15074,2)
 ;;=^5011962
 ;;^UTILITY(U,$J,358.3,15075,0)
 ;;=M45.4^^61^746^7
 ;;^UTILITY(U,$J,358.3,15075,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15075,1,3,0)
 ;;=3^Ankylosing Spondylitis of Thoracic Region
 ;;^UTILITY(U,$J,358.3,15075,1,4,0)
 ;;=4^M45.4
 ;;^UTILITY(U,$J,358.3,15075,2)
 ;;=^5011964
 ;;^UTILITY(U,$J,358.3,15076,0)
 ;;=M45.7^^61^746^4
 ;;^UTILITY(U,$J,358.3,15076,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15076,1,3,0)
 ;;=3^Ankylosing Spondylitis of Lumbosacral Region
 ;;^UTILITY(U,$J,358.3,15076,1,4,0)
 ;;=4^M45.7
 ;;^UTILITY(U,$J,358.3,15076,2)
 ;;=^5011967
 ;;^UTILITY(U,$J,358.3,15077,0)
 ;;=M45.8^^61^746^5
 ;;^UTILITY(U,$J,358.3,15077,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15077,1,3,0)
 ;;=3^Ankylosing Spondylitis of Sacral/Sacrococcygeal Region
 ;;^UTILITY(U,$J,358.3,15077,1,4,0)
 ;;=4^M45.8
 ;;^UTILITY(U,$J,358.3,15077,2)
 ;;=^5011968
 ;;^UTILITY(U,$J,358.3,15078,0)
 ;;=M47.22^^61^746^172
 ;;^UTILITY(U,$J,358.3,15078,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15078,1,3,0)
 ;;=3^Sponylosis w/ Radiculopathy,Cervical Region NEC
 ;;^UTILITY(U,$J,358.3,15078,1,4,0)
 ;;=4^M47.22
 ;;^UTILITY(U,$J,358.3,15078,2)
 ;;=^5012061
 ;;^UTILITY(U,$J,358.3,15079,0)
 ;;=M47.24^^61^746^174
 ;;^UTILITY(U,$J,358.3,15079,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15079,1,3,0)
 ;;=3^Sponylosis w/ Radiculopathy,Thoracic Region NEC
 ;;^UTILITY(U,$J,358.3,15079,1,4,0)
 ;;=4^M47.24
 ;;^UTILITY(U,$J,358.3,15079,2)
 ;;=^5012063
 ;;^UTILITY(U,$J,358.3,15080,0)
 ;;=M47.27^^61^746^173
 ;;^UTILITY(U,$J,358.3,15080,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15080,1,3,0)
 ;;=3^Sponylosis w/ Radiculopathy,Lumbosacral Region NEC
 ;;^UTILITY(U,$J,358.3,15080,1,4,0)
 ;;=4^M47.27
 ;;^UTILITY(U,$J,358.3,15080,2)
 ;;=^5012066
 ;;^UTILITY(U,$J,358.3,15081,0)
 ;;=M47.812^^61^746^169
 ;;^UTILITY(U,$J,358.3,15081,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15081,1,3,0)
 ;;=3^Spondylosis w/o Myelopathy/Radiculopathy,Cervical Region
 ;;^UTILITY(U,$J,358.3,15081,1,4,0)
 ;;=4^M47.812
 ;;^UTILITY(U,$J,358.3,15081,2)
 ;;=^5012069
 ;;^UTILITY(U,$J,358.3,15082,0)
 ;;=M47.814^^61^746^170
 ;;^UTILITY(U,$J,358.3,15082,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15082,1,3,0)
 ;;=3^Spondylosis w/o Myelopathy/Radiculopathy,Thoracic Region
 ;;^UTILITY(U,$J,358.3,15082,1,4,0)
 ;;=4^M47.814
 ;;^UTILITY(U,$J,358.3,15082,2)
 ;;=^5012071
 ;;^UTILITY(U,$J,358.3,15083,0)
 ;;=M47.817^^61^746^171
 ;;^UTILITY(U,$J,358.3,15083,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15083,1,3,0)
 ;;=3^Spondylosis w/o Myelopathy/Radiculopathy,Lumbosacral Region
 ;;^UTILITY(U,$J,358.3,15083,1,4,0)
 ;;=4^M47.817
 ;;^UTILITY(U,$J,358.3,15083,2)
 ;;=^5012074
 ;;^UTILITY(U,$J,358.3,15084,0)
 ;;=M48.50XA^^61^746^21
 ;;^UTILITY(U,$J,358.3,15084,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15084,1,3,0)
 ;;=3^Collapsed Vertebra NEC,Site Unspec,Init Encntr
 ;;^UTILITY(U,$J,358.3,15084,1,4,0)
 ;;=4^M48.50XA
 ;;^UTILITY(U,$J,358.3,15084,2)
 ;;=^5012159
 ;;^UTILITY(U,$J,358.3,15085,0)
 ;;=M48.50XD^^61^746^22
 ;;^UTILITY(U,$J,358.3,15085,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15085,1,3,0)
 ;;=3^Collapsed Vertebra NEC,Site Unspec,Subs Encntr
 ;;^UTILITY(U,$J,358.3,15085,1,4,0)
 ;;=4^M48.50XD
 ;;^UTILITY(U,$J,358.3,15085,2)
 ;;=^5012160
 ;;^UTILITY(U,$J,358.3,15086,0)
 ;;=M48.52XA^^61^746^23
 ;;^UTILITY(U,$J,358.3,15086,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15086,1,3,0)
 ;;=3^Collapsed Vertebra,Cervical Region,Init Encntr
 ;;^UTILITY(U,$J,358.3,15086,1,4,0)
 ;;=4^M48.52XA
 ;;^UTILITY(U,$J,358.3,15086,2)
 ;;=^5012167
 ;;^UTILITY(U,$J,358.3,15087,0)
 ;;=M48.52XD^^61^746^24
 ;;^UTILITY(U,$J,358.3,15087,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15087,1,3,0)
 ;;=3^Collapsed Vertebra,Cervical Region,Subs Encntr,Rt Healing
 ;;^UTILITY(U,$J,358.3,15087,1,4,0)
 ;;=4^M48.52XD
 ;;^UTILITY(U,$J,358.3,15087,2)
 ;;=^5012168
 ;;^UTILITY(U,$J,358.3,15088,0)
 ;;=M48.54XA^^61^746^32
 ;;^UTILITY(U,$J,358.3,15088,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15088,1,3,0)
 ;;=3^Collapsed Vertebra,Throacic Region,Init Encntr
 ;;^UTILITY(U,$J,358.3,15088,1,4,0)
 ;;=4^M48.54XA
 ;;^UTILITY(U,$J,358.3,15088,2)
 ;;=^5012175
 ;;^UTILITY(U,$J,358.3,15089,0)
 ;;=M48.54XD^^61^746^33
 ;;^UTILITY(U,$J,358.3,15089,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15089,1,3,0)
 ;;=3^Collapsed Vertebra,Throacic Region,Subs Encntr
 ;;^UTILITY(U,$J,358.3,15089,1,4,0)
 ;;=4^M48.54XD
 ;;^UTILITY(U,$J,358.3,15089,2)
 ;;=^5012176
 ;;^UTILITY(U,$J,358.3,15090,0)
 ;;=M48.57XA^^61^746^25
 ;;^UTILITY(U,$J,358.3,15090,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15090,1,3,0)
 ;;=3^Collapsed Vertebra,Lumbosacral Region,Init Encntr
 ;;^UTILITY(U,$J,358.3,15090,1,4,0)
 ;;=4^M48.57XA
 ;;^UTILITY(U,$J,358.3,15090,2)
 ;;=^5012187
 ;;^UTILITY(U,$J,358.3,15091,0)
 ;;=M48.57XD^^61^746^26
 ;;^UTILITY(U,$J,358.3,15091,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15091,1,3,0)
 ;;=3^Collapsed Vertebra,Lumbosacral Region,Subs Encntr,Rt Healing
 ;;^UTILITY(U,$J,358.3,15091,1,4,0)
 ;;=4^M48.57XD
 ;;^UTILITY(U,$J,358.3,15091,2)
 ;;=^5012188
 ;;^UTILITY(U,$J,358.3,15092,0)
 ;;=M50.30^^61^746^13
 ;;^UTILITY(U,$J,358.3,15092,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15092,1,3,0)
 ;;=3^Cervical Disc Degeneration,Unspec Region
 ;;^UTILITY(U,$J,358.3,15092,1,4,0)
 ;;=4^M50.30
 ;;^UTILITY(U,$J,358.3,15092,2)
 ;;=^5012227
 ;;^UTILITY(U,$J,358.3,15093,0)
 ;;=M51.14^^61^746^52
