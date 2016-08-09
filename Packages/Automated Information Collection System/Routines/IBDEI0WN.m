IBDEI0WN ; ; 12-MAY-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,32840,0)
 ;;=M19.90^^119^1570^68
 ;;^UTILITY(U,$J,358.3,32840,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32840,1,3,0)
 ;;=3^Osteoarthritis,Unspec
 ;;^UTILITY(U,$J,358.3,32840,1,4,0)
 ;;=4^M19.90
 ;;^UTILITY(U,$J,358.3,32840,2)
 ;;=^5010853
 ;;^UTILITY(U,$J,358.3,32841,0)
 ;;=M25.40^^119^1570^37
 ;;^UTILITY(U,$J,358.3,32841,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32841,1,3,0)
 ;;=3^Effusion,Unspec
 ;;^UTILITY(U,$J,358.3,32841,1,4,0)
 ;;=4^M25.40
 ;;^UTILITY(U,$J,358.3,32841,2)
 ;;=^5011575
 ;;^UTILITY(U,$J,358.3,32842,0)
 ;;=M45.0^^119^1570^6
 ;;^UTILITY(U,$J,358.3,32842,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32842,1,3,0)
 ;;=3^Ankylosing Spondylitis of Spine,Mult Sites
 ;;^UTILITY(U,$J,358.3,32842,1,4,0)
 ;;=4^M45.0
 ;;^UTILITY(U,$J,358.3,32842,2)
 ;;=^5011960
 ;;^UTILITY(U,$J,358.3,32843,0)
 ;;=M45.2^^119^1570^3
 ;;^UTILITY(U,$J,358.3,32843,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32843,1,3,0)
 ;;=3^Ankylosing Spondylitis of Cervical Region
 ;;^UTILITY(U,$J,358.3,32843,1,4,0)
 ;;=4^M45.2
 ;;^UTILITY(U,$J,358.3,32843,2)
 ;;=^5011962
 ;;^UTILITY(U,$J,358.3,32844,0)
 ;;=M45.4^^119^1570^7
 ;;^UTILITY(U,$J,358.3,32844,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32844,1,3,0)
 ;;=3^Ankylosing Spondylitis of Thoracic Region
 ;;^UTILITY(U,$J,358.3,32844,1,4,0)
 ;;=4^M45.4
 ;;^UTILITY(U,$J,358.3,32844,2)
 ;;=^5011964
 ;;^UTILITY(U,$J,358.3,32845,0)
 ;;=M45.7^^119^1570^4
 ;;^UTILITY(U,$J,358.3,32845,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32845,1,3,0)
 ;;=3^Ankylosing Spondylitis of Lumbosacral Region
 ;;^UTILITY(U,$J,358.3,32845,1,4,0)
 ;;=4^M45.7
 ;;^UTILITY(U,$J,358.3,32845,2)
 ;;=^5011967
 ;;^UTILITY(U,$J,358.3,32846,0)
 ;;=M45.8^^119^1570^5
 ;;^UTILITY(U,$J,358.3,32846,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32846,1,3,0)
 ;;=3^Ankylosing Spondylitis of Sacral/Sacrococcygeal Region
 ;;^UTILITY(U,$J,358.3,32846,1,4,0)
 ;;=4^M45.8
 ;;^UTILITY(U,$J,358.3,32846,2)
 ;;=^5011968
 ;;^UTILITY(U,$J,358.3,32847,0)
 ;;=M47.22^^119^1570^172
 ;;^UTILITY(U,$J,358.3,32847,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32847,1,3,0)
 ;;=3^Sponylosis w/ Radiculopathy,Cervical Region NEC
 ;;^UTILITY(U,$J,358.3,32847,1,4,0)
 ;;=4^M47.22
 ;;^UTILITY(U,$J,358.3,32847,2)
 ;;=^5012061
 ;;^UTILITY(U,$J,358.3,32848,0)
 ;;=M47.24^^119^1570^174
 ;;^UTILITY(U,$J,358.3,32848,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32848,1,3,0)
 ;;=3^Sponylosis w/ Radiculopathy,Thoracic Region NEC
 ;;^UTILITY(U,$J,358.3,32848,1,4,0)
 ;;=4^M47.24
 ;;^UTILITY(U,$J,358.3,32848,2)
 ;;=^5012063
 ;;^UTILITY(U,$J,358.3,32849,0)
 ;;=M47.27^^119^1570^173
 ;;^UTILITY(U,$J,358.3,32849,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32849,1,3,0)
 ;;=3^Sponylosis w/ Radiculopathy,Lumbosacral Region NEC
 ;;^UTILITY(U,$J,358.3,32849,1,4,0)
 ;;=4^M47.27
 ;;^UTILITY(U,$J,358.3,32849,2)
 ;;=^5012066
 ;;^UTILITY(U,$J,358.3,32850,0)
 ;;=M47.812^^119^1570^169
 ;;^UTILITY(U,$J,358.3,32850,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32850,1,3,0)
 ;;=3^Spondylosis w/o Myelopathy/Radiculopathy,Cervical Region
 ;;^UTILITY(U,$J,358.3,32850,1,4,0)
 ;;=4^M47.812
 ;;^UTILITY(U,$J,358.3,32850,2)
 ;;=^5012069
 ;;^UTILITY(U,$J,358.3,32851,0)
 ;;=M47.814^^119^1570^170
 ;;^UTILITY(U,$J,358.3,32851,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32851,1,3,0)
 ;;=3^Spondylosis w/o Myelopathy/Radiculopathy,Thoracic Region
 ;;^UTILITY(U,$J,358.3,32851,1,4,0)
 ;;=4^M47.814
 ;;^UTILITY(U,$J,358.3,32851,2)
 ;;=^5012071
 ;;^UTILITY(U,$J,358.3,32852,0)
 ;;=M47.817^^119^1570^171
 ;;^UTILITY(U,$J,358.3,32852,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32852,1,3,0)
 ;;=3^Spondylosis w/o Myelopathy/Radiculopathy,Lumbosacral Region
 ;;^UTILITY(U,$J,358.3,32852,1,4,0)
 ;;=4^M47.817
 ;;^UTILITY(U,$J,358.3,32852,2)
 ;;=^5012074
 ;;^UTILITY(U,$J,358.3,32853,0)
 ;;=M48.50XA^^119^1570^21
 ;;^UTILITY(U,$J,358.3,32853,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32853,1,3,0)
 ;;=3^Collapsed Vertebra NEC,Site Unspec,Init Encntr
 ;;^UTILITY(U,$J,358.3,32853,1,4,0)
 ;;=4^M48.50XA
 ;;^UTILITY(U,$J,358.3,32853,2)
 ;;=^5012159
 ;;^UTILITY(U,$J,358.3,32854,0)
 ;;=M48.50XD^^119^1570^22
 ;;^UTILITY(U,$J,358.3,32854,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32854,1,3,0)
 ;;=3^Collapsed Vertebra NEC,Site Unspec,Subs Encntr
 ;;^UTILITY(U,$J,358.3,32854,1,4,0)
 ;;=4^M48.50XD
 ;;^UTILITY(U,$J,358.3,32854,2)
 ;;=^5012160
 ;;^UTILITY(U,$J,358.3,32855,0)
 ;;=M48.52XA^^119^1570^23
 ;;^UTILITY(U,$J,358.3,32855,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32855,1,3,0)
 ;;=3^Collapsed Vertebra,Cervical Region,Init Encntr
 ;;^UTILITY(U,$J,358.3,32855,1,4,0)
 ;;=4^M48.52XA
 ;;^UTILITY(U,$J,358.3,32855,2)
 ;;=^5012167
 ;;^UTILITY(U,$J,358.3,32856,0)
 ;;=M48.52XD^^119^1570^24
 ;;^UTILITY(U,$J,358.3,32856,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32856,1,3,0)
 ;;=3^Collapsed Vertebra,Cervical Region,Subs Encntr,Rt Healing
 ;;^UTILITY(U,$J,358.3,32856,1,4,0)
 ;;=4^M48.52XD
 ;;^UTILITY(U,$J,358.3,32856,2)
 ;;=^5012168
 ;;^UTILITY(U,$J,358.3,32857,0)
 ;;=M48.54XA^^119^1570^32
 ;;^UTILITY(U,$J,358.3,32857,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32857,1,3,0)
 ;;=3^Collapsed Vertebra,Throacic Region,Init Encntr
 ;;^UTILITY(U,$J,358.3,32857,1,4,0)
 ;;=4^M48.54XA
 ;;^UTILITY(U,$J,358.3,32857,2)
 ;;=^5012175
 ;;^UTILITY(U,$J,358.3,32858,0)
 ;;=M48.54XD^^119^1570^33
 ;;^UTILITY(U,$J,358.3,32858,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32858,1,3,0)
 ;;=3^Collapsed Vertebra,Throacic Region,Subs Encntr
 ;;^UTILITY(U,$J,358.3,32858,1,4,0)
 ;;=4^M48.54XD
 ;;^UTILITY(U,$J,358.3,32858,2)
 ;;=^5012176
 ;;^UTILITY(U,$J,358.3,32859,0)
 ;;=M48.57XA^^119^1570^25
 ;;^UTILITY(U,$J,358.3,32859,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32859,1,3,0)
 ;;=3^Collapsed Vertebra,Lumbosacral Region,Init Encntr
 ;;^UTILITY(U,$J,358.3,32859,1,4,0)
 ;;=4^M48.57XA
 ;;^UTILITY(U,$J,358.3,32859,2)
 ;;=^5012187
 ;;^UTILITY(U,$J,358.3,32860,0)
 ;;=M48.57XD^^119^1570^26
 ;;^UTILITY(U,$J,358.3,32860,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32860,1,3,0)
 ;;=3^Collapsed Vertebra,Lumbosacral Region,Subs Encntr,Rt Healing
 ;;^UTILITY(U,$J,358.3,32860,1,4,0)
 ;;=4^M48.57XD
 ;;^UTILITY(U,$J,358.3,32860,2)
 ;;=^5012188
 ;;^UTILITY(U,$J,358.3,32861,0)
 ;;=M50.30^^119^1570^13
 ;;^UTILITY(U,$J,358.3,32861,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32861,1,3,0)
 ;;=3^Cervical Disc Degeneration,Unspec Region
 ;;^UTILITY(U,$J,358.3,32861,1,4,0)
 ;;=4^M50.30
 ;;^UTILITY(U,$J,358.3,32861,2)
 ;;=^5012227
 ;;^UTILITY(U,$J,358.3,32862,0)
 ;;=M51.14^^119^1570^52
 ;;^UTILITY(U,$J,358.3,32862,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32862,1,3,0)
 ;;=3^Intvrt Disc Disorder w/ Radiculopathy,Thoracic Region
 ;;^UTILITY(U,$J,358.3,32862,1,4,0)
 ;;=4^M51.14
 ;;^UTILITY(U,$J,358.3,32862,2)
 ;;=^5012243
 ;;^UTILITY(U,$J,358.3,32863,0)
 ;;=M51.17^^119^1570^51
 ;;^UTILITY(U,$J,358.3,32863,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32863,1,3,0)
 ;;=3^Intvrt Disc Disorder w/ Radiculopathy,Lumbosacral Region
 ;;^UTILITY(U,$J,358.3,32863,1,4,0)
 ;;=4^M51.17
 ;;^UTILITY(U,$J,358.3,32863,2)
 ;;=^5012246
 ;;^UTILITY(U,$J,358.3,32864,0)
 ;;=M51.34^^119^1570^50
 ;;^UTILITY(U,$J,358.3,32864,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32864,1,3,0)
 ;;=3^Intvrt Disc Degeneration,Thoracic Region
 ;;^UTILITY(U,$J,358.3,32864,1,4,0)
 ;;=4^M51.34
 ;;^UTILITY(U,$J,358.3,32864,2)
 ;;=^5012251
 ;;^UTILITY(U,$J,358.3,32865,0)
 ;;=M51.37^^119^1570^49
 ;;^UTILITY(U,$J,358.3,32865,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32865,1,3,0)
 ;;=3^Intvrt Disc Degeneration,Lumbosacral Region
 ;;^UTILITY(U,$J,358.3,32865,1,4,0)
 ;;=4^M51.37
 ;;^UTILITY(U,$J,358.3,32865,2)
 ;;=^5012254
 ;;^UTILITY(U,$J,358.3,32866,0)
 ;;=M54.14^^119^1570^140
 ;;^UTILITY(U,$J,358.3,32866,1,0)
 ;;=^358.31IA^4^2
