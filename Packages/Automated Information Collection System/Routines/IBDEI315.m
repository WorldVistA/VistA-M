IBDEI315 ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,50800,1,4,0)
 ;;=4^M48.21
 ;;^UTILITY(U,$J,358.3,50800,2)
 ;;=^5012107
 ;;^UTILITY(U,$J,358.3,50801,0)
 ;;=M48.22^^222^2466^177
 ;;^UTILITY(U,$J,358.3,50801,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,50801,1,3,0)
 ;;=3^Kissing spine, cervical region
 ;;^UTILITY(U,$J,358.3,50801,1,4,0)
 ;;=4^M48.22
 ;;^UTILITY(U,$J,358.3,50801,2)
 ;;=^5012108
 ;;^UTILITY(U,$J,358.3,50802,0)
 ;;=M48.23^^222^2466^178
 ;;^UTILITY(U,$J,358.3,50802,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,50802,1,3,0)
 ;;=3^Kissing spine, cervicothoracic region
 ;;^UTILITY(U,$J,358.3,50802,1,4,0)
 ;;=4^M48.23
 ;;^UTILITY(U,$J,358.3,50802,2)
 ;;=^5012109
 ;;^UTILITY(U,$J,358.3,50803,0)
 ;;=M48.24^^222^2466^183
 ;;^UTILITY(U,$J,358.3,50803,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,50803,1,3,0)
 ;;=3^Kissing spine, thoracic region
 ;;^UTILITY(U,$J,358.3,50803,1,4,0)
 ;;=4^M48.24
 ;;^UTILITY(U,$J,358.3,50803,2)
 ;;=^5012110
 ;;^UTILITY(U,$J,358.3,50804,0)
 ;;=M48.25^^222^2466^184
 ;;^UTILITY(U,$J,358.3,50804,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,50804,1,3,0)
 ;;=3^Kissing spine, thoracolumbar region
 ;;^UTILITY(U,$J,358.3,50804,1,4,0)
 ;;=4^M48.25
 ;;^UTILITY(U,$J,358.3,50804,2)
 ;;=^5012111
 ;;^UTILITY(U,$J,358.3,50805,0)
 ;;=M48.26^^222^2466^179
 ;;^UTILITY(U,$J,358.3,50805,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,50805,1,3,0)
 ;;=3^Kissing spine, lumbar region
 ;;^UTILITY(U,$J,358.3,50805,1,4,0)
 ;;=4^M48.26
 ;;^UTILITY(U,$J,358.3,50805,2)
 ;;=^5012112
 ;;^UTILITY(U,$J,358.3,50806,0)
 ;;=M48.27^^222^2466^180
 ;;^UTILITY(U,$J,358.3,50806,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,50806,1,3,0)
 ;;=3^Kissing spine, lumbosacral region
 ;;^UTILITY(U,$J,358.3,50806,1,4,0)
 ;;=4^M48.27
 ;;^UTILITY(U,$J,358.3,50806,2)
 ;;=^5012113
 ;;^UTILITY(U,$J,358.3,50807,0)
 ;;=M48.10^^222^2466^55
 ;;^UTILITY(U,$J,358.3,50807,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,50807,1,3,0)
 ;;=3^Ankylsng hyperostosis [Forestier], site unspec
 ;;^UTILITY(U,$J,358.3,50807,1,4,0)
 ;;=4^M48.10
 ;;^UTILITY(U,$J,358.3,50807,2)
 ;;=^5012096
 ;;^UTILITY(U,$J,358.3,50808,0)
 ;;=M48.11^^222^2466^53
 ;;^UTILITY(U,$J,358.3,50808,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,50808,1,3,0)
 ;;=3^Ankylsng hyperostosis [Forestier], ocpito-atlanto-ax regn
 ;;^UTILITY(U,$J,358.3,50808,1,4,0)
 ;;=4^M48.11
 ;;^UTILITY(U,$J,358.3,50808,2)
 ;;=^5012097
 ;;^UTILITY(U,$J,358.3,50809,0)
 ;;=M48.12^^222^2466^48
 ;;^UTILITY(U,$J,358.3,50809,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,50809,1,3,0)
 ;;=3^Ankylsng hyperostosis [Forestier], crvcl region
 ;;^UTILITY(U,$J,358.3,50809,1,4,0)
 ;;=4^M48.12
 ;;^UTILITY(U,$J,358.3,50809,2)
 ;;=^5012098
 ;;^UTILITY(U,$J,358.3,50810,0)
 ;;=M48.13^^222^2466^49
 ;;^UTILITY(U,$J,358.3,50810,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,50810,1,3,0)
 ;;=3^Ankylsng hyperostosis [Forestier], crvicothor regn
 ;;^UTILITY(U,$J,358.3,50810,1,4,0)
 ;;=4^M48.13
 ;;^UTILITY(U,$J,358.3,50810,2)
 ;;=^5012099
 ;;^UTILITY(U,$J,358.3,50811,0)
 ;;=M48.14^^222^2466^56
 ;;^UTILITY(U,$J,358.3,50811,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,50811,1,3,0)
 ;;=3^Ankylsng hyperostosis [Forestier], thor regn
 ;;^UTILITY(U,$J,358.3,50811,1,4,0)
 ;;=4^M48.14
 ;;^UTILITY(U,$J,358.3,50811,2)
 ;;=^5012100
 ;;^UTILITY(U,$J,358.3,50812,0)
 ;;=M48.15^^222^2466^57
 ;;^UTILITY(U,$J,358.3,50812,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,50812,1,3,0)
 ;;=3^Ankylsng hyperostosis [Forestier], thoralmbr regn
 ;;^UTILITY(U,$J,358.3,50812,1,4,0)
 ;;=4^M48.15
 ;;^UTILITY(U,$J,358.3,50812,2)
 ;;=^5012101
 ;;^UTILITY(U,$J,358.3,50813,0)
 ;;=M48.16^^222^2466^50
