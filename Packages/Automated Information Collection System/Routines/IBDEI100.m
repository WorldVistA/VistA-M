IBDEI100 ; ; 09-AUG-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,47206,0)
 ;;=S92.154A^^139^1984^231
 ;;^UTILITY(U,$J,358.3,47206,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,47206,1,3,0)
 ;;=3^Nondisp avulsion fx (chip) of rt talus, init
 ;;^UTILITY(U,$J,358.3,47206,1,4,0)
 ;;=4^S92.154A
 ;;^UTILITY(U,$J,358.3,47206,2)
 ;;=^5044794
 ;;^UTILITY(U,$J,358.3,47207,0)
 ;;=S92.152A^^139^1984^7
 ;;^UTILITY(U,$J,358.3,47207,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,47207,1,3,0)
 ;;=3^Disp avulsion fx (chip) of lft talus, init
 ;;^UTILITY(U,$J,358.3,47207,1,4,0)
 ;;=4^S92.152A
 ;;^UTILITY(U,$J,358.3,47207,2)
 ;;=^5044780
 ;;^UTILITY(U,$J,358.3,47208,0)
 ;;=S92.135A^^139^1984^341
 ;;^UTILITY(U,$J,358.3,47208,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,47208,1,3,0)
 ;;=3^Nondisp fx of posterior process of lft talus, init
 ;;^UTILITY(U,$J,358.3,47208,1,4,0)
 ;;=4^S92.135A
 ;;^UTILITY(U,$J,358.3,47208,2)
 ;;=^5044717
 ;;^UTILITY(U,$J,358.3,47209,0)
 ;;=S92.151A^^139^1984^8
 ;;^UTILITY(U,$J,358.3,47209,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,47209,1,3,0)
 ;;=3^Disp avulsion fx (chip) of rt talus, init
 ;;^UTILITY(U,$J,358.3,47209,1,4,0)
 ;;=4^S92.151A
 ;;^UTILITY(U,$J,358.3,47209,2)
 ;;=^5044773
 ;;^UTILITY(U,$J,358.3,47210,0)
 ;;=S92.145A^^139^1984^245
 ;;^UTILITY(U,$J,358.3,47210,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,47210,1,3,0)
 ;;=3^Nondisp dome fx of lft talus, init
 ;;^UTILITY(U,$J,358.3,47210,1,4,0)
 ;;=4^S92.145A
 ;;^UTILITY(U,$J,358.3,47210,2)
 ;;=^5044759
 ;;^UTILITY(U,$J,358.3,47211,0)
 ;;=S92.144A^^139^1984^247
 ;;^UTILITY(U,$J,358.3,47211,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,47211,1,3,0)
 ;;=3^Nondisp dome fx of rt talus, init
 ;;^UTILITY(U,$J,358.3,47211,1,4,0)
 ;;=4^S92.144A
 ;;^UTILITY(U,$J,358.3,47211,2)
 ;;=^5044752
 ;;^UTILITY(U,$J,358.3,47212,0)
 ;;=S92.142A^^139^1984^21
 ;;^UTILITY(U,$J,358.3,47212,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,47212,1,3,0)
 ;;=3^Disp dome fx of lft talus, init
 ;;^UTILITY(U,$J,358.3,47212,1,4,0)
 ;;=4^S92.142A
 ;;^UTILITY(U,$J,358.3,47212,2)
 ;;=^5044738
 ;;^UTILITY(U,$J,358.3,47213,0)
 ;;=S92.141A^^139^1984^22
 ;;^UTILITY(U,$J,358.3,47213,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,47213,1,3,0)
 ;;=3^Disp dome fx of rt talus, init
 ;;^UTILITY(U,$J,358.3,47213,1,4,0)
 ;;=4^S92.141A
 ;;^UTILITY(U,$J,358.3,47213,2)
 ;;=^5044731
 ;;^UTILITY(U,$J,358.3,47214,0)
 ;;=S92.101A^^139^1984^219
 ;;^UTILITY(U,$J,358.3,47214,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,47214,1,3,0)
 ;;=3^Fx of rt talus, unspec, init
 ;;^UTILITY(U,$J,358.3,47214,1,4,0)
 ;;=4^S92.101A
 ;;^UTILITY(U,$J,358.3,47214,2)
 ;;=^5044591
 ;;^UTILITY(U,$J,358.3,47215,0)
 ;;=S92.111A^^139^1984^115
 ;;^UTILITY(U,$J,358.3,47215,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,47215,1,3,0)
 ;;=3^Disp fx of neck of rt talus, init
 ;;^UTILITY(U,$J,358.3,47215,1,4,0)
 ;;=4^S92.111A
 ;;^UTILITY(U,$J,358.3,47215,2)
 ;;=^5044605
 ;;^UTILITY(U,$J,358.3,47216,0)
 ;;=S92.102A^^139^1984^202
 ;;^UTILITY(U,$J,358.3,47216,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,47216,1,3,0)
 ;;=3^Fx of lft talus, unspec, init
 ;;^UTILITY(U,$J,358.3,47216,1,4,0)
 ;;=4^S92.102A
 ;;^UTILITY(U,$J,358.3,47216,2)
 ;;=^5044598
 ;;^UTILITY(U,$J,358.3,47217,0)
 ;;=S92.134A^^139^1984^342
 ;;^UTILITY(U,$J,358.3,47217,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,47217,1,3,0)
 ;;=3^Nondisp fx of posterior process of rt talus, init
 ;;^UTILITY(U,$J,358.3,47217,1,4,0)
 ;;=4^S92.134A
 ;;^UTILITY(U,$J,358.3,47217,2)
 ;;=^5044710
 ;;^UTILITY(U,$J,358.3,47218,0)
 ;;=S92.132A^^139^1984^116
 ;;^UTILITY(U,$J,358.3,47218,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,47218,1,3,0)
 ;;=3^Disp fx of posterior process of lft talus, init
 ;;^UTILITY(U,$J,358.3,47218,1,4,0)
 ;;=4^S92.132A
 ;;^UTILITY(U,$J,358.3,47218,2)
 ;;=^5044696
 ;;^UTILITY(U,$J,358.3,47219,0)
 ;;=S92.131A^^139^1984^117
 ;;^UTILITY(U,$J,358.3,47219,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,47219,1,3,0)
 ;;=3^Disp fx of posterior process of rt talus, init
 ;;^UTILITY(U,$J,358.3,47219,1,4,0)
 ;;=4^S92.131A
 ;;^UTILITY(U,$J,358.3,47219,2)
 ;;=^5044689
 ;;^UTILITY(U,$J,358.3,47220,0)
 ;;=S92.125A^^139^1984^307
 ;;^UTILITY(U,$J,358.3,47220,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,47220,1,3,0)
 ;;=3^Nondisp fx of body of lft talus, init
 ;;^UTILITY(U,$J,358.3,47220,1,4,0)
 ;;=4^S92.125A
 ;;^UTILITY(U,$J,358.3,47220,2)
 ;;=^5044675
 ;;^UTILITY(U,$J,358.3,47221,0)
 ;;=S92.124A^^139^1984^309
 ;;^UTILITY(U,$J,358.3,47221,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,47221,1,3,0)
 ;;=3^Nondisp fx of body of rt talus, init
 ;;^UTILITY(U,$J,358.3,47221,1,4,0)
 ;;=4^S92.124A
 ;;^UTILITY(U,$J,358.3,47221,2)
 ;;=^5044668
 ;;^UTILITY(U,$J,358.3,47222,0)
 ;;=S92.122A^^139^1984^82
 ;;^UTILITY(U,$J,358.3,47222,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,47222,1,3,0)
 ;;=3^Disp fx of body of lft talus, init
 ;;^UTILITY(U,$J,358.3,47222,1,4,0)
 ;;=4^S92.122A
 ;;^UTILITY(U,$J,358.3,47222,2)
 ;;=^5044654
 ;;^UTILITY(U,$J,358.3,47223,0)
 ;;=S92.121A^^139^1984^84
 ;;^UTILITY(U,$J,358.3,47223,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,47223,1,3,0)
 ;;=3^Disp fx of body of rt talus, init
 ;;^UTILITY(U,$J,358.3,47223,1,4,0)
 ;;=4^S92.121A
 ;;^UTILITY(U,$J,358.3,47223,2)
 ;;=^5044647
 ;;^UTILITY(U,$J,358.3,47224,0)
 ;;=S92.115A^^139^1984^339
 ;;^UTILITY(U,$J,358.3,47224,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,47224,1,3,0)
 ;;=3^Nondisp fx of neck of lft talus, init
 ;;^UTILITY(U,$J,358.3,47224,1,4,0)
 ;;=4^S92.115A
 ;;^UTILITY(U,$J,358.3,47224,2)
 ;;=^5044633
 ;;^UTILITY(U,$J,358.3,47225,0)
 ;;=S92.114A^^139^1984^340
 ;;^UTILITY(U,$J,358.3,47225,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,47225,1,3,0)
 ;;=3^Nondisp fx of neck of rt talus, init
 ;;^UTILITY(U,$J,358.3,47225,1,4,0)
 ;;=4^S92.114A
 ;;^UTILITY(U,$J,358.3,47225,2)
 ;;=^5044626
 ;;^UTILITY(U,$J,358.3,47226,0)
 ;;=S92.112A^^139^1984^114
 ;;^UTILITY(U,$J,358.3,47226,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,47226,1,3,0)
 ;;=3^Disp fx of neck of lft talus, init
 ;;^UTILITY(U,$J,358.3,47226,1,4,0)
 ;;=4^S92.112A
 ;;^UTILITY(U,$J,358.3,47226,2)
 ;;=^5044612
 ;;^UTILITY(U,$J,358.3,47227,0)
 ;;=S92.251A^^139^1984^113
 ;;^UTILITY(U,$J,358.3,47227,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,47227,1,3,0)
 ;;=3^Disp fx of navicular of rt ft, init
 ;;^UTILITY(U,$J,358.3,47227,1,4,0)
 ;;=4^S92.251A
 ;;^UTILITY(U,$J,358.3,47227,2)
 ;;=^5045004
 ;;^UTILITY(U,$J,358.3,47228,0)
 ;;=S92.252A^^139^1984^112
 ;;^UTILITY(U,$J,358.3,47228,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,47228,1,3,0)
 ;;=3^Disp fx of navicular of lft ft, init
 ;;^UTILITY(U,$J,358.3,47228,1,4,0)
 ;;=4^S92.252A
 ;;^UTILITY(U,$J,358.3,47228,2)
 ;;=^5045011
 ;;^UTILITY(U,$J,358.3,47229,0)
 ;;=S92.254A^^139^1984^338
 ;;^UTILITY(U,$J,358.3,47229,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,47229,1,3,0)
 ;;=3^Nondisp fx of navicular of rt ft, init
 ;;^UTILITY(U,$J,358.3,47229,1,4,0)
 ;;=4^S92.254A
 ;;^UTILITY(U,$J,358.3,47229,2)
 ;;=^5045025
 ;;^UTILITY(U,$J,358.3,47230,0)
 ;;=S92.255A^^139^1984^321
 ;;^UTILITY(U,$J,358.3,47230,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,47230,1,3,0)
 ;;=3^Nondisp fx of lft ft, init
 ;;^UTILITY(U,$J,358.3,47230,1,4,0)
 ;;=4^S92.255A
 ;;^UTILITY(U,$J,358.3,47230,2)
 ;;=^5045032
 ;;^UTILITY(U,$J,358.3,47231,0)
 ;;=S92.211A^^139^1984^86
 ;;^UTILITY(U,$J,358.3,47231,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,47231,1,3,0)
 ;;=3^Disp fx of cuboid bone of rt ft, init
 ;;^UTILITY(U,$J,358.3,47231,1,4,0)
 ;;=4^S92.211A
 ;;^UTILITY(U,$J,358.3,47231,2)
 ;;=^5044836
 ;;^UTILITY(U,$J,358.3,47232,0)
 ;;=S92.212A^^139^1984^85
 ;;^UTILITY(U,$J,358.3,47232,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,47232,1,3,0)
 ;;=3^Disp fx of cuboid bone of lft ft, init
 ;;^UTILITY(U,$J,358.3,47232,1,4,0)
 ;;=4^S92.212A
 ;;^UTILITY(U,$J,358.3,47232,2)
 ;;=^5044843
 ;;^UTILITY(U,$J,358.3,47233,0)
 ;;=S92.214A^^139^1984^311
 ;;^UTILITY(U,$J,358.3,47233,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,47233,1,3,0)
 ;;=3^Nondisp fx of cuboid bone of rt ft, init
 ;;^UTILITY(U,$J,358.3,47233,1,4,0)
 ;;=4^S92.214A
 ;;^UTILITY(U,$J,358.3,47233,2)
 ;;=^5044857
 ;;^UTILITY(U,$J,358.3,47234,0)
 ;;=S92.215A^^139^1984^310
 ;;^UTILITY(U,$J,358.3,47234,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,47234,1,3,0)
 ;;=3^Nondisp fx of cuboid bone of lft ft, init
 ;;^UTILITY(U,$J,358.3,47234,1,4,0)
 ;;=4^S92.215A
 ;;^UTILITY(U,$J,358.3,47234,2)
 ;;=^5044864
 ;;^UTILITY(U,$J,358.3,47235,0)
 ;;=S92.244A^^139^1984^335
 ;;^UTILITY(U,$J,358.3,47235,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,47235,1,3,0)
 ;;=3^Nondisp fx of medial cuneiform of rt ft, init
 ;;^UTILITY(U,$J,358.3,47235,1,4,0)
 ;;=4^S92.244A
 ;;^UTILITY(U,$J,358.3,47235,2)
 ;;=^5044983
 ;;^UTILITY(U,$J,358.3,47236,0)
 ;;=S92.245A^^139^1984^334
 ;;^UTILITY(U,$J,358.3,47236,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,47236,1,3,0)
 ;;=3^Nondisp fx of medial cuneiform of lft ft, init
 ;;^UTILITY(U,$J,358.3,47236,1,4,0)
 ;;=4^S92.245A
 ;;^UTILITY(U,$J,358.3,47236,2)
 ;;=^5044990
 ;;^UTILITY(U,$J,358.3,47237,0)
 ;;=S92.221A^^139^1984^100
 ;;^UTILITY(U,$J,358.3,47237,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,47237,1,3,0)
 ;;=3^Disp fx of ltrl cuneiform of rt ft, init
 ;;^UTILITY(U,$J,358.3,47237,1,4,0)
 ;;=4^S92.221A
 ;;^UTILITY(U,$J,358.3,47237,2)
 ;;=^5044878
 ;;^UTILITY(U,$J,358.3,47238,0)
 ;;=S92.222A^^139^1984^99
 ;;^UTILITY(U,$J,358.3,47238,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,47238,1,3,0)
 ;;=3^Disp fx of ltrl cuneiform of lft ft, init
 ;;^UTILITY(U,$J,358.3,47238,1,4,0)
 ;;=4^S92.222A
 ;;^UTILITY(U,$J,358.3,47238,2)
 ;;=^5044885
 ;;^UTILITY(U,$J,358.3,47239,0)
 ;;=S92.224A^^139^1984^325
 ;;^UTILITY(U,$J,358.3,47239,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,47239,1,3,0)
 ;;=3^Nondisp fx of ltrl cuneiform of rt ft, init
 ;;^UTILITY(U,$J,358.3,47239,1,4,0)
 ;;=4^S92.224A
 ;;^UTILITY(U,$J,358.3,47239,2)
 ;;=^5044899
