IBDEI2AT ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,38608,1,3,0)
 ;;=3^Ankylosing hyperostosis, thoracolumbar region
 ;;^UTILITY(U,$J,358.3,38608,1,4,0)
 ;;=4^M48.15
 ;;^UTILITY(U,$J,358.3,38608,2)
 ;;=^5012101
 ;;^UTILITY(U,$J,358.3,38609,0)
 ;;=M48.13^^180^1980^2
 ;;^UTILITY(U,$J,358.3,38609,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38609,1,3,0)
 ;;=3^Ankylosing hyperostosis, cervicothoracic region
 ;;^UTILITY(U,$J,358.3,38609,1,4,0)
 ;;=4^M48.13
 ;;^UTILITY(U,$J,358.3,38609,2)
 ;;=^5012099
 ;;^UTILITY(U,$J,358.3,38610,0)
 ;;=M48.14^^180^1980^8
 ;;^UTILITY(U,$J,358.3,38610,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38610,1,3,0)
 ;;=3^Ankylosing hyperostosis, thoracic region
 ;;^UTILITY(U,$J,358.3,38610,1,4,0)
 ;;=4^M48.14
 ;;^UTILITY(U,$J,358.3,38610,2)
 ;;=^5012100
 ;;^UTILITY(U,$J,358.3,38611,0)
 ;;=M45.2^^180^1980^10
 ;;^UTILITY(U,$J,358.3,38611,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38611,1,3,0)
 ;;=3^Ankylosing spondylitis of cervical region
 ;;^UTILITY(U,$J,358.3,38611,1,4,0)
 ;;=4^M45.2
 ;;^UTILITY(U,$J,358.3,38611,2)
 ;;=^5011962
 ;;^UTILITY(U,$J,358.3,38612,0)
 ;;=M45.3^^180^1980^11
 ;;^UTILITY(U,$J,358.3,38612,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38612,1,3,0)
 ;;=3^Ankylosing spondylitis of cervicothoracic region
 ;;^UTILITY(U,$J,358.3,38612,1,4,0)
 ;;=4^M45.3
 ;;^UTILITY(U,$J,358.3,38612,2)
 ;;=^5011963
 ;;^UTILITY(U,$J,358.3,38613,0)
 ;;=M45.7^^180^1980^13
 ;;^UTILITY(U,$J,358.3,38613,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38613,1,3,0)
 ;;=3^Ankylosing spondylitis of lumbosacral region
 ;;^UTILITY(U,$J,358.3,38613,1,4,0)
 ;;=4^M45.7
 ;;^UTILITY(U,$J,358.3,38613,2)
 ;;=^5011967
 ;;^UTILITY(U,$J,358.3,38614,0)
 ;;=M45.0^^180^1980^14
 ;;^UTILITY(U,$J,358.3,38614,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38614,1,3,0)
 ;;=3^Ankylosing spondylitis of multiple sites in spine
 ;;^UTILITY(U,$J,358.3,38614,1,4,0)
 ;;=4^M45.0
 ;;^UTILITY(U,$J,358.3,38614,2)
 ;;=^5011960
 ;;^UTILITY(U,$J,358.3,38615,0)
 ;;=M45.1^^180^1980^15
 ;;^UTILITY(U,$J,358.3,38615,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38615,1,3,0)
 ;;=3^Ankylosing spondylitis of occipito-atlanto-axial region
 ;;^UTILITY(U,$J,358.3,38615,1,4,0)
 ;;=4^M45.1
 ;;^UTILITY(U,$J,358.3,38615,2)
 ;;=^5011961
 ;;^UTILITY(U,$J,358.3,38616,0)
 ;;=M45.8^^180^1980^16
 ;;^UTILITY(U,$J,358.3,38616,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38616,1,3,0)
 ;;=3^Ankylosing spondylitis of sacral and sacrococcygeal region
 ;;^UTILITY(U,$J,358.3,38616,1,4,0)
 ;;=4^M45.8
 ;;^UTILITY(U,$J,358.3,38616,2)
 ;;=^5011968
 ;;^UTILITY(U,$J,358.3,38617,0)
 ;;=M45.4^^180^1980^17
 ;;^UTILITY(U,$J,358.3,38617,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38617,1,3,0)
 ;;=3^Ankylosing spondylitis of thoracic region
 ;;^UTILITY(U,$J,358.3,38617,1,4,0)
 ;;=4^M45.4
 ;;^UTILITY(U,$J,358.3,38617,2)
 ;;=^5011964
 ;;^UTILITY(U,$J,358.3,38618,0)
 ;;=M45.6^^180^1980^12
 ;;^UTILITY(U,$J,358.3,38618,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38618,1,3,0)
 ;;=3^Ankylosing spondylitis of lumbar region
 ;;^UTILITY(U,$J,358.3,38618,1,4,0)
 ;;=4^M45.6
 ;;^UTILITY(U,$J,358.3,38618,2)
 ;;=^5011966
 ;;^UTILITY(U,$J,358.3,38619,0)
 ;;=M50.03^^180^1980^18
 ;;^UTILITY(U,$J,358.3,38619,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38619,1,3,0)
 ;;=3^Cervical disc disorder w myelopathy, cervicothoracic region
 ;;^UTILITY(U,$J,358.3,38619,1,4,0)
 ;;=4^M50.03
 ;;^UTILITY(U,$J,358.3,38619,2)
 ;;=^5012218
 ;;^UTILITY(U,$J,358.3,38620,0)
 ;;=M50.02^^180^1980^20
 ;;^UTILITY(U,$J,358.3,38620,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38620,1,3,0)
 ;;=3^Cervical disc disorder w myelopathy, mid-cervical region
