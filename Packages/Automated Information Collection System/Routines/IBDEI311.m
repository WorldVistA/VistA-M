IBDEI311 ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,50750,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,50750,1,3,0)
 ;;=3^Vitamin D deficiency, unspec
 ;;^UTILITY(U,$J,358.3,50750,1,4,0)
 ;;=4^E55.9
 ;;^UTILITY(U,$J,358.3,50750,2)
 ;;=^5002799
 ;;^UTILITY(U,$J,358.3,50751,0)
 ;;=G56.91^^222^2466^192
 ;;^UTILITY(U,$J,358.3,50751,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,50751,1,3,0)
 ;;=3^Mononeuropathy of rt upr limb, unspec
 ;;^UTILITY(U,$J,358.3,50751,1,4,0)
 ;;=4^G56.91
 ;;^UTILITY(U,$J,358.3,50751,2)
 ;;=^5004036
 ;;^UTILITY(U,$J,358.3,50752,0)
 ;;=G56.92^^222^2466^191
 ;;^UTILITY(U,$J,358.3,50752,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,50752,1,3,0)
 ;;=3^Mononeuropathy of lft upr limb, unspec
 ;;^UTILITY(U,$J,358.3,50752,1,4,0)
 ;;=4^G56.92
 ;;^UTILITY(U,$J,358.3,50752,2)
 ;;=^5004037
 ;;^UTILITY(U,$J,358.3,50753,0)
 ;;=M30.0^^222^2466^200
 ;;^UTILITY(U,$J,358.3,50753,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,50753,1,3,0)
 ;;=3^Polyarteritis nodosa
 ;;^UTILITY(U,$J,358.3,50753,1,4,0)
 ;;=4^M30.0
 ;;^UTILITY(U,$J,358.3,50753,2)
 ;;=^5011738
 ;;^UTILITY(U,$J,358.3,50754,0)
 ;;=M35.9^^222^2466^281
 ;;^UTILITY(U,$J,358.3,50754,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,50754,1,3,0)
 ;;=3^Systemic involvement of connective tissue, unspec
 ;;^UTILITY(U,$J,358.3,50754,1,4,0)
 ;;=4^M35.9
 ;;^UTILITY(U,$J,358.3,50754,2)
 ;;=^5011797
 ;;^UTILITY(U,$J,358.3,50755,0)
 ;;=M45.9^^222^2466^47
 ;;^UTILITY(U,$J,358.3,50755,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,50755,1,3,0)
 ;;=3^Ankylosing spondylitis unspec sites in spine
 ;;^UTILITY(U,$J,358.3,50755,1,4,0)
 ;;=4^M45.9
 ;;^UTILITY(U,$J,358.3,50755,2)
 ;;=^5011969
 ;;^UTILITY(U,$J,358.3,50756,0)
 ;;=M45.0^^222^2466^42
 ;;^UTILITY(U,$J,358.3,50756,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,50756,1,3,0)
 ;;=3^Ankylosing spondylitis mltpl sites in spine
 ;;^UTILITY(U,$J,358.3,50756,1,4,0)
 ;;=4^M45.0
 ;;^UTILITY(U,$J,358.3,50756,2)
 ;;=^5011960
 ;;^UTILITY(U,$J,358.3,50757,0)
 ;;=M45.1^^222^2466^43
 ;;^UTILITY(U,$J,358.3,50757,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,50757,1,3,0)
 ;;=3^Ankylosing spondylitis occipito-atlanto-axial region
 ;;^UTILITY(U,$J,358.3,50757,1,4,0)
 ;;=4^M45.1
 ;;^UTILITY(U,$J,358.3,50757,2)
 ;;=^5011961
 ;;^UTILITY(U,$J,358.3,50758,0)
 ;;=M45.2^^222^2466^38
 ;;^UTILITY(U,$J,358.3,50758,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,50758,1,3,0)
 ;;=3^Ankylosing spondylitis cervical region
 ;;^UTILITY(U,$J,358.3,50758,1,4,0)
 ;;=4^M45.2
 ;;^UTILITY(U,$J,358.3,50758,2)
 ;;=^5011962
 ;;^UTILITY(U,$J,358.3,50759,0)
 ;;=M45.3^^222^2466^39
 ;;^UTILITY(U,$J,358.3,50759,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,50759,1,3,0)
 ;;=3^Ankylosing spondylitis crvicothrcic region
 ;;^UTILITY(U,$J,358.3,50759,1,4,0)
 ;;=4^M45.3
 ;;^UTILITY(U,$J,358.3,50759,2)
 ;;=^5011963
 ;;^UTILITY(U,$J,358.3,50760,0)
 ;;=M45.4^^222^2466^45
 ;;^UTILITY(U,$J,358.3,50760,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,50760,1,3,0)
 ;;=3^Ankylosing spondylitis thoracic region
 ;;^UTILITY(U,$J,358.3,50760,1,4,0)
 ;;=4^M45.4
 ;;^UTILITY(U,$J,358.3,50760,2)
 ;;=^5011964
 ;;^UTILITY(U,$J,358.3,50761,0)
 ;;=M45.5^^222^2466^46
 ;;^UTILITY(U,$J,358.3,50761,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,50761,1,3,0)
 ;;=3^Ankylosing spondylitis thoracolumbar regn
 ;;^UTILITY(U,$J,358.3,50761,1,4,0)
 ;;=4^M45.5
 ;;^UTILITY(U,$J,358.3,50761,2)
 ;;=^5011965
 ;;^UTILITY(U,$J,358.3,50762,0)
 ;;=M45.6^^222^2466^40
 ;;^UTILITY(U,$J,358.3,50762,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,50762,1,3,0)
 ;;=3^Ankylosing spondylitis lumbar region
 ;;^UTILITY(U,$J,358.3,50762,1,4,0)
 ;;=4^M45.6
