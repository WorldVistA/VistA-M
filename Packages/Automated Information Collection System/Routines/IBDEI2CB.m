IBDEI2CB ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,39304,1,4,0)
 ;;=4^M48.18
 ;;^UTILITY(U,$J,358.3,39304,2)
 ;;=^5012104
 ;;^UTILITY(U,$J,358.3,39305,0)
 ;;=M48.15^^183^2018^9
 ;;^UTILITY(U,$J,358.3,39305,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39305,1,3,0)
 ;;=3^Ankylosing hyperostosis, thoracolumbar region
 ;;^UTILITY(U,$J,358.3,39305,1,4,0)
 ;;=4^M48.15
 ;;^UTILITY(U,$J,358.3,39305,2)
 ;;=^5012101
 ;;^UTILITY(U,$J,358.3,39306,0)
 ;;=M48.13^^183^2018^2
 ;;^UTILITY(U,$J,358.3,39306,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39306,1,3,0)
 ;;=3^Ankylosing hyperostosis, cervicothoracic region
 ;;^UTILITY(U,$J,358.3,39306,1,4,0)
 ;;=4^M48.13
 ;;^UTILITY(U,$J,358.3,39306,2)
 ;;=^5012099
 ;;^UTILITY(U,$J,358.3,39307,0)
 ;;=M48.14^^183^2018^8
 ;;^UTILITY(U,$J,358.3,39307,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39307,1,3,0)
 ;;=3^Ankylosing hyperostosis, thoracic region
 ;;^UTILITY(U,$J,358.3,39307,1,4,0)
 ;;=4^M48.14
 ;;^UTILITY(U,$J,358.3,39307,2)
 ;;=^5012100
 ;;^UTILITY(U,$J,358.3,39308,0)
 ;;=M45.2^^183^2018^10
 ;;^UTILITY(U,$J,358.3,39308,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39308,1,3,0)
 ;;=3^Ankylosing spondylitis of cervical region
 ;;^UTILITY(U,$J,358.3,39308,1,4,0)
 ;;=4^M45.2
 ;;^UTILITY(U,$J,358.3,39308,2)
 ;;=^5011962
 ;;^UTILITY(U,$J,358.3,39309,0)
 ;;=M45.3^^183^2018^11
 ;;^UTILITY(U,$J,358.3,39309,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39309,1,3,0)
 ;;=3^Ankylosing spondylitis of cervicothoracic region
 ;;^UTILITY(U,$J,358.3,39309,1,4,0)
 ;;=4^M45.3
 ;;^UTILITY(U,$J,358.3,39309,2)
 ;;=^5011963
 ;;^UTILITY(U,$J,358.3,39310,0)
 ;;=M45.7^^183^2018^13
 ;;^UTILITY(U,$J,358.3,39310,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39310,1,3,0)
 ;;=3^Ankylosing spondylitis of lumbosacral region
 ;;^UTILITY(U,$J,358.3,39310,1,4,0)
 ;;=4^M45.7
 ;;^UTILITY(U,$J,358.3,39310,2)
 ;;=^5011967
 ;;^UTILITY(U,$J,358.3,39311,0)
 ;;=M45.0^^183^2018^14
 ;;^UTILITY(U,$J,358.3,39311,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39311,1,3,0)
 ;;=3^Ankylosing spondylitis of multiple sites in spine
 ;;^UTILITY(U,$J,358.3,39311,1,4,0)
 ;;=4^M45.0
 ;;^UTILITY(U,$J,358.3,39311,2)
 ;;=^5011960
 ;;^UTILITY(U,$J,358.3,39312,0)
 ;;=M45.1^^183^2018^15
 ;;^UTILITY(U,$J,358.3,39312,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39312,1,3,0)
 ;;=3^Ankylosing spondylitis of occipito-atlanto-axial region
 ;;^UTILITY(U,$J,358.3,39312,1,4,0)
 ;;=4^M45.1
 ;;^UTILITY(U,$J,358.3,39312,2)
 ;;=^5011961
 ;;^UTILITY(U,$J,358.3,39313,0)
 ;;=M45.8^^183^2018^16
 ;;^UTILITY(U,$J,358.3,39313,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39313,1,3,0)
 ;;=3^Ankylosing spondylitis of sacral and sacrococcygeal region
 ;;^UTILITY(U,$J,358.3,39313,1,4,0)
 ;;=4^M45.8
 ;;^UTILITY(U,$J,358.3,39313,2)
 ;;=^5011968
 ;;^UTILITY(U,$J,358.3,39314,0)
 ;;=M45.4^^183^2018^17
 ;;^UTILITY(U,$J,358.3,39314,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39314,1,3,0)
 ;;=3^Ankylosing spondylitis of thoracic region
 ;;^UTILITY(U,$J,358.3,39314,1,4,0)
 ;;=4^M45.4
 ;;^UTILITY(U,$J,358.3,39314,2)
 ;;=^5011964
 ;;^UTILITY(U,$J,358.3,39315,0)
 ;;=M45.6^^183^2018^12
 ;;^UTILITY(U,$J,358.3,39315,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39315,1,3,0)
 ;;=3^Ankylosing spondylitis of lumbar region
 ;;^UTILITY(U,$J,358.3,39315,1,4,0)
 ;;=4^M45.6
 ;;^UTILITY(U,$J,358.3,39315,2)
 ;;=^5011966
 ;;^UTILITY(U,$J,358.3,39316,0)
 ;;=M50.03^^183^2018^18
 ;;^UTILITY(U,$J,358.3,39316,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39316,1,3,0)
 ;;=3^Cervical disc disorder w myelopathy, cervicothoracic region
 ;;^UTILITY(U,$J,358.3,39316,1,4,0)
 ;;=4^M50.03
 ;;^UTILITY(U,$J,358.3,39316,2)
 ;;=^5012218
