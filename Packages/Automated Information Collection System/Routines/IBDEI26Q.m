IBDEI26Q ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,37070,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37070,1,3,0)
 ;;=3^Vitamin D deficiency, unspec
 ;;^UTILITY(U,$J,358.3,37070,1,4,0)
 ;;=4^E55.9
 ;;^UTILITY(U,$J,358.3,37070,2)
 ;;=^5002799
 ;;^UTILITY(U,$J,358.3,37071,0)
 ;;=G56.91^^140^1787^194
 ;;^UTILITY(U,$J,358.3,37071,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37071,1,3,0)
 ;;=3^Mononeuropathy of rt upr limb, unspec
 ;;^UTILITY(U,$J,358.3,37071,1,4,0)
 ;;=4^G56.91
 ;;^UTILITY(U,$J,358.3,37071,2)
 ;;=^5004036
 ;;^UTILITY(U,$J,358.3,37072,0)
 ;;=G56.92^^140^1787^193
 ;;^UTILITY(U,$J,358.3,37072,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37072,1,3,0)
 ;;=3^Mononeuropathy of lft upr limb, unspec
 ;;^UTILITY(U,$J,358.3,37072,1,4,0)
 ;;=4^G56.92
 ;;^UTILITY(U,$J,358.3,37072,2)
 ;;=^5004037
 ;;^UTILITY(U,$J,358.3,37073,0)
 ;;=M30.0^^140^1787^202
 ;;^UTILITY(U,$J,358.3,37073,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37073,1,3,0)
 ;;=3^Polyarteritis nodosa
 ;;^UTILITY(U,$J,358.3,37073,1,4,0)
 ;;=4^M30.0
 ;;^UTILITY(U,$J,358.3,37073,2)
 ;;=^5011738
 ;;^UTILITY(U,$J,358.3,37074,0)
 ;;=M35.9^^140^1787^282
 ;;^UTILITY(U,$J,358.3,37074,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37074,1,3,0)
 ;;=3^Systemic involvement of connective tissue, unspec
 ;;^UTILITY(U,$J,358.3,37074,1,4,0)
 ;;=4^M35.9
 ;;^UTILITY(U,$J,358.3,37074,2)
 ;;=^5011797
 ;;^UTILITY(U,$J,358.3,37075,0)
 ;;=M45.9^^140^1787^47
 ;;^UTILITY(U,$J,358.3,37075,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37075,1,3,0)
 ;;=3^Ankylosing spondylitis unspec sites in spine
 ;;^UTILITY(U,$J,358.3,37075,1,4,0)
 ;;=4^M45.9
 ;;^UTILITY(U,$J,358.3,37075,2)
 ;;=^5011969
 ;;^UTILITY(U,$J,358.3,37076,0)
 ;;=M45.0^^140^1787^42
 ;;^UTILITY(U,$J,358.3,37076,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37076,1,3,0)
 ;;=3^Ankylosing spondylitis mltpl sites in spine
 ;;^UTILITY(U,$J,358.3,37076,1,4,0)
 ;;=4^M45.0
 ;;^UTILITY(U,$J,358.3,37076,2)
 ;;=^5011960
 ;;^UTILITY(U,$J,358.3,37077,0)
 ;;=M45.1^^140^1787^43
 ;;^UTILITY(U,$J,358.3,37077,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37077,1,3,0)
 ;;=3^Ankylosing spondylitis occipito-atlanto-axial region
 ;;^UTILITY(U,$J,358.3,37077,1,4,0)
 ;;=4^M45.1
 ;;^UTILITY(U,$J,358.3,37077,2)
 ;;=^5011961
 ;;^UTILITY(U,$J,358.3,37078,0)
 ;;=M45.2^^140^1787^38
 ;;^UTILITY(U,$J,358.3,37078,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37078,1,3,0)
 ;;=3^Ankylosing spondylitis cervical region
 ;;^UTILITY(U,$J,358.3,37078,1,4,0)
 ;;=4^M45.2
 ;;^UTILITY(U,$J,358.3,37078,2)
 ;;=^5011962
 ;;^UTILITY(U,$J,358.3,37079,0)
 ;;=M45.3^^140^1787^39
 ;;^UTILITY(U,$J,358.3,37079,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37079,1,3,0)
 ;;=3^Ankylosing spondylitis crvicothrcic region
 ;;^UTILITY(U,$J,358.3,37079,1,4,0)
 ;;=4^M45.3
 ;;^UTILITY(U,$J,358.3,37079,2)
 ;;=^5011963
 ;;^UTILITY(U,$J,358.3,37080,0)
 ;;=M45.4^^140^1787^45
 ;;^UTILITY(U,$J,358.3,37080,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37080,1,3,0)
 ;;=3^Ankylosing spondylitis thoracic region
 ;;^UTILITY(U,$J,358.3,37080,1,4,0)
 ;;=4^M45.4
 ;;^UTILITY(U,$J,358.3,37080,2)
 ;;=^5011964
 ;;^UTILITY(U,$J,358.3,37081,0)
 ;;=M45.5^^140^1787^46
 ;;^UTILITY(U,$J,358.3,37081,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37081,1,3,0)
 ;;=3^Ankylosing spondylitis thoracolumbar regn
 ;;^UTILITY(U,$J,358.3,37081,1,4,0)
 ;;=4^M45.5
 ;;^UTILITY(U,$J,358.3,37081,2)
 ;;=^5011965
 ;;^UTILITY(U,$J,358.3,37082,0)
 ;;=M45.6^^140^1787^40
 ;;^UTILITY(U,$J,358.3,37082,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37082,1,3,0)
 ;;=3^Ankylosing spondylitis lumbar region
 ;;^UTILITY(U,$J,358.3,37082,1,4,0)
 ;;=4^M45.6
