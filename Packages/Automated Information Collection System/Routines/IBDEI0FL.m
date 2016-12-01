IBDEI0FL ; ; 09-AUG-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,19713,1,4,0)
 ;;=4^M18.0
 ;;^UTILITY(U,$J,358.3,19713,2)
 ;;=^5010795
 ;;^UTILITY(U,$J,358.3,19714,0)
 ;;=M18.11^^55^794^132
 ;;^UTILITY(U,$J,358.3,19714,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19714,1,3,0)
 ;;=3^Primary Osteoarthritis of Right Hand 1st Carpometacarp Jt
 ;;^UTILITY(U,$J,358.3,19714,1,4,0)
 ;;=4^M18.11
 ;;^UTILITY(U,$J,358.3,19714,2)
 ;;=^5010797
 ;;^UTILITY(U,$J,358.3,19715,0)
 ;;=M18.12^^55^794^126
 ;;^UTILITY(U,$J,358.3,19715,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19715,1,3,0)
 ;;=3^Primary Osteoarthritis of Left Hand 1st Carpometacarp Jt
 ;;^UTILITY(U,$J,358.3,19715,1,4,0)
 ;;=4^M18.12
 ;;^UTILITY(U,$J,358.3,19715,2)
 ;;=^5010798
 ;;^UTILITY(U,$J,358.3,19716,0)
 ;;=M19.011^^55^794^135
 ;;^UTILITY(U,$J,358.3,19716,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19716,1,3,0)
 ;;=3^Primary Osteoarthritis of Right Shoulder
 ;;^UTILITY(U,$J,358.3,19716,1,4,0)
 ;;=4^M19.011
 ;;^UTILITY(U,$J,358.3,19716,2)
 ;;=^5010808
 ;;^UTILITY(U,$J,358.3,19717,0)
 ;;=M19.012^^55^794^129
 ;;^UTILITY(U,$J,358.3,19717,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19717,1,3,0)
 ;;=3^Primary Osteoarthritis of Left Shoulder
 ;;^UTILITY(U,$J,358.3,19717,1,4,0)
 ;;=4^M19.012
 ;;^UTILITY(U,$J,358.3,19717,2)
 ;;=^5010809
 ;;^UTILITY(U,$J,358.3,19718,0)
 ;;=M19.031^^55^794^136
 ;;^UTILITY(U,$J,358.3,19718,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19718,1,3,0)
 ;;=3^Primary Osteoarthritis of Right Wrist
 ;;^UTILITY(U,$J,358.3,19718,1,4,0)
 ;;=4^M19.031
 ;;^UTILITY(U,$J,358.3,19718,2)
 ;;=^5010814
 ;;^UTILITY(U,$J,358.3,19719,0)
 ;;=M19.032^^55^794^130
 ;;^UTILITY(U,$J,358.3,19719,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19719,1,3,0)
 ;;=3^Primary Osteoarthritis of Left Wrist
 ;;^UTILITY(U,$J,358.3,19719,1,4,0)
 ;;=4^M19.032
 ;;^UTILITY(U,$J,358.3,19719,2)
 ;;=^5010815
 ;;^UTILITY(U,$J,358.3,19720,0)
 ;;=M19.041^^55^794^131
 ;;^UTILITY(U,$J,358.3,19720,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19720,1,3,0)
 ;;=3^Primary Osteoarthritis of Right Hand
 ;;^UTILITY(U,$J,358.3,19720,1,4,0)
 ;;=4^M19.041
 ;;^UTILITY(U,$J,358.3,19720,2)
 ;;=^5010817
 ;;^UTILITY(U,$J,358.3,19721,0)
 ;;=M19.042^^55^794^125
 ;;^UTILITY(U,$J,358.3,19721,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19721,1,3,0)
 ;;=3^Primary Osteoarthritis of Left Hand
 ;;^UTILITY(U,$J,358.3,19721,1,4,0)
 ;;=4^M19.042
 ;;^UTILITY(U,$J,358.3,19721,2)
 ;;=^5010818
 ;;^UTILITY(U,$J,358.3,19722,0)
 ;;=M19.90^^55^794^68
 ;;^UTILITY(U,$J,358.3,19722,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19722,1,3,0)
 ;;=3^Osteoarthritis,Unspec
 ;;^UTILITY(U,$J,358.3,19722,1,4,0)
 ;;=4^M19.90
 ;;^UTILITY(U,$J,358.3,19722,2)
 ;;=^5010853
 ;;^UTILITY(U,$J,358.3,19723,0)
 ;;=M25.40^^55^794^37
 ;;^UTILITY(U,$J,358.3,19723,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19723,1,3,0)
 ;;=3^Effusion,Unspec
 ;;^UTILITY(U,$J,358.3,19723,1,4,0)
 ;;=4^M25.40
 ;;^UTILITY(U,$J,358.3,19723,2)
 ;;=^5011575
 ;;^UTILITY(U,$J,358.3,19724,0)
 ;;=M45.0^^55^794^6
 ;;^UTILITY(U,$J,358.3,19724,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19724,1,3,0)
 ;;=3^Ankylosing Spondylitis of Spine,Mult Sites
 ;;^UTILITY(U,$J,358.3,19724,1,4,0)
 ;;=4^M45.0
 ;;^UTILITY(U,$J,358.3,19724,2)
 ;;=^5011960
 ;;^UTILITY(U,$J,358.3,19725,0)
 ;;=M45.2^^55^794^3
 ;;^UTILITY(U,$J,358.3,19725,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19725,1,3,0)
 ;;=3^Ankylosing Spondylitis of Cervical Region
 ;;^UTILITY(U,$J,358.3,19725,1,4,0)
 ;;=4^M45.2
 ;;^UTILITY(U,$J,358.3,19725,2)
 ;;=^5011962
 ;;^UTILITY(U,$J,358.3,19726,0)
 ;;=M45.4^^55^794^7
 ;;^UTILITY(U,$J,358.3,19726,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19726,1,3,0)
 ;;=3^Ankylosing Spondylitis of Thoracic Region
 ;;^UTILITY(U,$J,358.3,19726,1,4,0)
 ;;=4^M45.4
 ;;^UTILITY(U,$J,358.3,19726,2)
 ;;=^5011964
 ;;^UTILITY(U,$J,358.3,19727,0)
 ;;=M45.7^^55^794^4
 ;;^UTILITY(U,$J,358.3,19727,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19727,1,3,0)
 ;;=3^Ankylosing Spondylitis of Lumbosacral Region
 ;;^UTILITY(U,$J,358.3,19727,1,4,0)
 ;;=4^M45.7
 ;;^UTILITY(U,$J,358.3,19727,2)
 ;;=^5011967
 ;;^UTILITY(U,$J,358.3,19728,0)
 ;;=M45.8^^55^794^5
 ;;^UTILITY(U,$J,358.3,19728,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19728,1,3,0)
 ;;=3^Ankylosing Spondylitis of Sacral/Sacrococcygeal Region
 ;;^UTILITY(U,$J,358.3,19728,1,4,0)
 ;;=4^M45.8
 ;;^UTILITY(U,$J,358.3,19728,2)
 ;;=^5011968
 ;;^UTILITY(U,$J,358.3,19729,0)
 ;;=M47.22^^55^794^172
 ;;^UTILITY(U,$J,358.3,19729,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19729,1,3,0)
 ;;=3^Sponylosis w/ Radiculopathy,Cervical Region NEC
 ;;^UTILITY(U,$J,358.3,19729,1,4,0)
 ;;=4^M47.22
 ;;^UTILITY(U,$J,358.3,19729,2)
 ;;=^5012061
 ;;^UTILITY(U,$J,358.3,19730,0)
 ;;=M47.24^^55^794^174
 ;;^UTILITY(U,$J,358.3,19730,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19730,1,3,0)
 ;;=3^Sponylosis w/ Radiculopathy,Thoracic Region NEC
 ;;^UTILITY(U,$J,358.3,19730,1,4,0)
 ;;=4^M47.24
 ;;^UTILITY(U,$J,358.3,19730,2)
 ;;=^5012063
 ;;^UTILITY(U,$J,358.3,19731,0)
 ;;=M47.27^^55^794^173
 ;;^UTILITY(U,$J,358.3,19731,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19731,1,3,0)
 ;;=3^Sponylosis w/ Radiculopathy,Lumbosacral Region NEC
 ;;^UTILITY(U,$J,358.3,19731,1,4,0)
 ;;=4^M47.27
 ;;^UTILITY(U,$J,358.3,19731,2)
 ;;=^5012066
 ;;^UTILITY(U,$J,358.3,19732,0)
 ;;=M47.812^^55^794^169
 ;;^UTILITY(U,$J,358.3,19732,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19732,1,3,0)
 ;;=3^Spondylosis w/o Myelopathy/Radiculopathy,Cervical Region
 ;;^UTILITY(U,$J,358.3,19732,1,4,0)
 ;;=4^M47.812
 ;;^UTILITY(U,$J,358.3,19732,2)
 ;;=^5012069
 ;;^UTILITY(U,$J,358.3,19733,0)
 ;;=M47.814^^55^794^170
 ;;^UTILITY(U,$J,358.3,19733,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19733,1,3,0)
 ;;=3^Spondylosis w/o Myelopathy/Radiculopathy,Thoracic Region
 ;;^UTILITY(U,$J,358.3,19733,1,4,0)
 ;;=4^M47.814
 ;;^UTILITY(U,$J,358.3,19733,2)
 ;;=^5012071
 ;;^UTILITY(U,$J,358.3,19734,0)
 ;;=M47.817^^55^794^171
 ;;^UTILITY(U,$J,358.3,19734,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19734,1,3,0)
 ;;=3^Spondylosis w/o Myelopathy/Radiculopathy,Lumbosacral Region
 ;;^UTILITY(U,$J,358.3,19734,1,4,0)
 ;;=4^M47.817
 ;;^UTILITY(U,$J,358.3,19734,2)
 ;;=^5012074
 ;;^UTILITY(U,$J,358.3,19735,0)
 ;;=M48.50XA^^55^794^21
 ;;^UTILITY(U,$J,358.3,19735,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19735,1,3,0)
 ;;=3^Collapsed Vertebra NEC,Site Unspec,Init Encntr
 ;;^UTILITY(U,$J,358.3,19735,1,4,0)
 ;;=4^M48.50XA
 ;;^UTILITY(U,$J,358.3,19735,2)
 ;;=^5012159
 ;;^UTILITY(U,$J,358.3,19736,0)
 ;;=M48.50XD^^55^794^22
 ;;^UTILITY(U,$J,358.3,19736,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19736,1,3,0)
 ;;=3^Collapsed Vertebra NEC,Site Unspec,Subs Encntr
 ;;^UTILITY(U,$J,358.3,19736,1,4,0)
 ;;=4^M48.50XD
 ;;^UTILITY(U,$J,358.3,19736,2)
 ;;=^5012160
 ;;^UTILITY(U,$J,358.3,19737,0)
 ;;=M48.52XA^^55^794^23
 ;;^UTILITY(U,$J,358.3,19737,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19737,1,3,0)
 ;;=3^Collapsed Vertebra,Cervical Region,Init Encntr
 ;;^UTILITY(U,$J,358.3,19737,1,4,0)
 ;;=4^M48.52XA
 ;;^UTILITY(U,$J,358.3,19737,2)
 ;;=^5012167
 ;;^UTILITY(U,$J,358.3,19738,0)
 ;;=M48.52XD^^55^794^24
 ;;^UTILITY(U,$J,358.3,19738,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19738,1,3,0)
 ;;=3^Collapsed Vertebra,Cervical Region,Subs Encntr,Rt Healing
 ;;^UTILITY(U,$J,358.3,19738,1,4,0)
 ;;=4^M48.52XD
 ;;^UTILITY(U,$J,358.3,19738,2)
 ;;=^5012168
 ;;^UTILITY(U,$J,358.3,19739,0)
 ;;=M48.54XA^^55^794^32
 ;;^UTILITY(U,$J,358.3,19739,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19739,1,3,0)
 ;;=3^Collapsed Vertebra,Throacic Region,Init Encntr
 ;;^UTILITY(U,$J,358.3,19739,1,4,0)
 ;;=4^M48.54XA
 ;;^UTILITY(U,$J,358.3,19739,2)
 ;;=^5012175
 ;;^UTILITY(U,$J,358.3,19740,0)
 ;;=M48.54XD^^55^794^33
 ;;^UTILITY(U,$J,358.3,19740,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19740,1,3,0)
 ;;=3^Collapsed Vertebra,Throacic Region,Subs Encntr
 ;;^UTILITY(U,$J,358.3,19740,1,4,0)
 ;;=4^M48.54XD
 ;;^UTILITY(U,$J,358.3,19740,2)
 ;;=^5012176
 ;;^UTILITY(U,$J,358.3,19741,0)
 ;;=M48.57XA^^55^794^25
 ;;^UTILITY(U,$J,358.3,19741,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19741,1,3,0)
 ;;=3^Collapsed Vertebra,Lumbosacral Region,Init Encntr
 ;;^UTILITY(U,$J,358.3,19741,1,4,0)
 ;;=4^M48.57XA
 ;;^UTILITY(U,$J,358.3,19741,2)
 ;;=^5012187
 ;;^UTILITY(U,$J,358.3,19742,0)
 ;;=M48.57XD^^55^794^26
 ;;^UTILITY(U,$J,358.3,19742,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19742,1,3,0)
 ;;=3^Collapsed Vertebra,Lumbosacral Region,Subs Encntr,Rt Healing
 ;;^UTILITY(U,$J,358.3,19742,1,4,0)
 ;;=4^M48.57XD
 ;;^UTILITY(U,$J,358.3,19742,2)
 ;;=^5012188
 ;;^UTILITY(U,$J,358.3,19743,0)
 ;;=M50.30^^55^794^13
 ;;^UTILITY(U,$J,358.3,19743,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19743,1,3,0)
 ;;=3^Cervical Disc Degeneration,Unspec Region
 ;;^UTILITY(U,$J,358.3,19743,1,4,0)
 ;;=4^M50.30
 ;;^UTILITY(U,$J,358.3,19743,2)
 ;;=^5012227
 ;;^UTILITY(U,$J,358.3,19744,0)
 ;;=M51.14^^55^794^52
 ;;^UTILITY(U,$J,358.3,19744,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19744,1,3,0)
 ;;=3^Intvrt Disc Disorder w/ Radiculopathy,Thoracic Region
 ;;^UTILITY(U,$J,358.3,19744,1,4,0)
 ;;=4^M51.14
 ;;^UTILITY(U,$J,358.3,19744,2)
 ;;=^5012243
 ;;^UTILITY(U,$J,358.3,19745,0)
 ;;=M51.17^^55^794^51
 ;;^UTILITY(U,$J,358.3,19745,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19745,1,3,0)
 ;;=3^Intvrt Disc Disorder w/ Radiculopathy,Lumbosacral Region
 ;;^UTILITY(U,$J,358.3,19745,1,4,0)
 ;;=4^M51.17
 ;;^UTILITY(U,$J,358.3,19745,2)
 ;;=^5012246
 ;;^UTILITY(U,$J,358.3,19746,0)
 ;;=M51.34^^55^794^50
 ;;^UTILITY(U,$J,358.3,19746,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19746,1,3,0)
 ;;=3^Intvrt Disc Degeneration,Thoracic Region
 ;;^UTILITY(U,$J,358.3,19746,1,4,0)
 ;;=4^M51.34
 ;;^UTILITY(U,$J,358.3,19746,2)
 ;;=^5012251
 ;;^UTILITY(U,$J,358.3,19747,0)
 ;;=M51.37^^55^794^49
 ;;^UTILITY(U,$J,358.3,19747,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19747,1,3,0)
 ;;=3^Intvrt Disc Degeneration,Lumbosacral Region
