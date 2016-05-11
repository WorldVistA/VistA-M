IBDEI26U ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,37120,1,4,0)
 ;;=4^M48.21
 ;;^UTILITY(U,$J,358.3,37120,2)
 ;;=^5012107
 ;;^UTILITY(U,$J,358.3,37121,0)
 ;;=M48.22^^140^1787^179
 ;;^UTILITY(U,$J,358.3,37121,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37121,1,3,0)
 ;;=3^Kissing spine, cervical region
 ;;^UTILITY(U,$J,358.3,37121,1,4,0)
 ;;=4^M48.22
 ;;^UTILITY(U,$J,358.3,37121,2)
 ;;=^5012108
 ;;^UTILITY(U,$J,358.3,37122,0)
 ;;=M48.23^^140^1787^180
 ;;^UTILITY(U,$J,358.3,37122,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37122,1,3,0)
 ;;=3^Kissing spine, cervicothoracic region
 ;;^UTILITY(U,$J,358.3,37122,1,4,0)
 ;;=4^M48.23
 ;;^UTILITY(U,$J,358.3,37122,2)
 ;;=^5012109
 ;;^UTILITY(U,$J,358.3,37123,0)
 ;;=M48.24^^140^1787^185
 ;;^UTILITY(U,$J,358.3,37123,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37123,1,3,0)
 ;;=3^Kissing spine, thoracic region
 ;;^UTILITY(U,$J,358.3,37123,1,4,0)
 ;;=4^M48.24
 ;;^UTILITY(U,$J,358.3,37123,2)
 ;;=^5012110
 ;;^UTILITY(U,$J,358.3,37124,0)
 ;;=M48.25^^140^1787^186
 ;;^UTILITY(U,$J,358.3,37124,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37124,1,3,0)
 ;;=3^Kissing spine, thoracolumbar region
 ;;^UTILITY(U,$J,358.3,37124,1,4,0)
 ;;=4^M48.25
 ;;^UTILITY(U,$J,358.3,37124,2)
 ;;=^5012111
 ;;^UTILITY(U,$J,358.3,37125,0)
 ;;=M48.26^^140^1787^181
 ;;^UTILITY(U,$J,358.3,37125,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37125,1,3,0)
 ;;=3^Kissing spine, lumbar region
 ;;^UTILITY(U,$J,358.3,37125,1,4,0)
 ;;=4^M48.26
 ;;^UTILITY(U,$J,358.3,37125,2)
 ;;=^5012112
 ;;^UTILITY(U,$J,358.3,37126,0)
 ;;=M48.27^^140^1787^182
 ;;^UTILITY(U,$J,358.3,37126,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37126,1,3,0)
 ;;=3^Kissing spine, lumbosacral region
 ;;^UTILITY(U,$J,358.3,37126,1,4,0)
 ;;=4^M48.27
 ;;^UTILITY(U,$J,358.3,37126,2)
 ;;=^5012113
 ;;^UTILITY(U,$J,358.3,37127,0)
 ;;=M48.10^^140^1787^55
 ;;^UTILITY(U,$J,358.3,37127,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37127,1,3,0)
 ;;=3^Ankylsng hyperostosis [Forestier], site unspec
 ;;^UTILITY(U,$J,358.3,37127,1,4,0)
 ;;=4^M48.10
 ;;^UTILITY(U,$J,358.3,37127,2)
 ;;=^5012096
 ;;^UTILITY(U,$J,358.3,37128,0)
 ;;=M48.11^^140^1787^53
 ;;^UTILITY(U,$J,358.3,37128,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37128,1,3,0)
 ;;=3^Ankylsng hyperostosis [Forestier], ocpito-atlanto-ax regn
 ;;^UTILITY(U,$J,358.3,37128,1,4,0)
 ;;=4^M48.11
 ;;^UTILITY(U,$J,358.3,37128,2)
 ;;=^5012097
 ;;^UTILITY(U,$J,358.3,37129,0)
 ;;=M48.12^^140^1787^48
 ;;^UTILITY(U,$J,358.3,37129,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37129,1,3,0)
 ;;=3^Ankylsng hyperostosis [Forestier], crvcl region
 ;;^UTILITY(U,$J,358.3,37129,1,4,0)
 ;;=4^M48.12
 ;;^UTILITY(U,$J,358.3,37129,2)
 ;;=^5012098
 ;;^UTILITY(U,$J,358.3,37130,0)
 ;;=M48.13^^140^1787^49
 ;;^UTILITY(U,$J,358.3,37130,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37130,1,3,0)
 ;;=3^Ankylsng hyperostosis [Forestier], crvicothor regn
 ;;^UTILITY(U,$J,358.3,37130,1,4,0)
 ;;=4^M48.13
 ;;^UTILITY(U,$J,358.3,37130,2)
 ;;=^5012099
 ;;^UTILITY(U,$J,358.3,37131,0)
 ;;=M48.14^^140^1787^56
 ;;^UTILITY(U,$J,358.3,37131,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37131,1,3,0)
 ;;=3^Ankylsng hyperostosis [Forestier], thor regn
 ;;^UTILITY(U,$J,358.3,37131,1,4,0)
 ;;=4^M48.14
 ;;^UTILITY(U,$J,358.3,37131,2)
 ;;=^5012100
 ;;^UTILITY(U,$J,358.3,37132,0)
 ;;=M48.15^^140^1787^57
 ;;^UTILITY(U,$J,358.3,37132,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37132,1,3,0)
 ;;=3^Ankylsng hyperostosis [Forestier], thoralmbr regn
 ;;^UTILITY(U,$J,358.3,37132,1,4,0)
 ;;=4^M48.15
 ;;^UTILITY(U,$J,358.3,37132,2)
 ;;=^5012101
 ;;^UTILITY(U,$J,358.3,37133,0)
 ;;=M48.16^^140^1787^50
