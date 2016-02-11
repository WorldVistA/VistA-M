IBDEI28E ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,37478,1,4,0)
 ;;=4^G90.522
 ;;^UTILITY(U,$J,358.3,37478,2)
 ;;=^5133371
 ;;^UTILITY(U,$J,358.3,37479,0)
 ;;=G90.512^^172^1885^15
 ;;^UTILITY(U,$J,358.3,37479,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37479,1,3,0)
 ;;=3^Complex regional pain syndrome I of left upper limb
 ;;^UTILITY(U,$J,358.3,37479,1,4,0)
 ;;=4^G90.512
 ;;^UTILITY(U,$J,358.3,37479,2)
 ;;=^5004165
 ;;^UTILITY(U,$J,358.3,37480,0)
 ;;=G90.523^^172^1885^16
 ;;^UTILITY(U,$J,358.3,37480,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37480,1,3,0)
 ;;=3^Complex regional pain syndrome I of lower limb, bilateral
 ;;^UTILITY(U,$J,358.3,37480,1,4,0)
 ;;=4^G90.523
 ;;^UTILITY(U,$J,358.3,37480,2)
 ;;=^5004169
 ;;^UTILITY(U,$J,358.3,37481,0)
 ;;=G90.521^^172^1885^17
 ;;^UTILITY(U,$J,358.3,37481,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37481,1,3,0)
 ;;=3^Complex regional pain syndrome I of right lower limb
 ;;^UTILITY(U,$J,358.3,37481,1,4,0)
 ;;=4^G90.521
 ;;^UTILITY(U,$J,358.3,37481,2)
 ;;=^5004168
 ;;^UTILITY(U,$J,358.3,37482,0)
 ;;=G90.511^^172^1885^18
 ;;^UTILITY(U,$J,358.3,37482,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37482,1,3,0)
 ;;=3^Complex regional pain syndrome I of right upper limb
 ;;^UTILITY(U,$J,358.3,37482,1,4,0)
 ;;=4^G90.511
 ;;^UTILITY(U,$J,358.3,37482,2)
 ;;=^5004164
 ;;^UTILITY(U,$J,358.3,37483,0)
 ;;=I96.^^172^1885^20
 ;;^UTILITY(U,$J,358.3,37483,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37483,1,3,0)
 ;;=3^Gangrene, not elsewhere classified
 ;;^UTILITY(U,$J,358.3,37483,1,4,0)
 ;;=4^I96.
 ;;^UTILITY(U,$J,358.3,37483,2)
 ;;=^5008081
 ;;^UTILITY(U,$J,358.3,37484,0)
 ;;=M10.9^^172^1885^21
 ;;^UTILITY(U,$J,358.3,37484,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37484,1,3,0)
 ;;=3^Gout, unspecified
 ;;^UTILITY(U,$J,358.3,37484,1,4,0)
 ;;=4^M10.9
 ;;^UTILITY(U,$J,358.3,37484,2)
 ;;=^5010404
 ;;^UTILITY(U,$J,358.3,37485,0)
 ;;=M87.08^^172^1885^22
 ;;^UTILITY(U,$J,358.3,37485,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37485,1,3,0)
 ;;=3^Idiopathic aseptic necrosis of bone, other site
 ;;^UTILITY(U,$J,358.3,37485,1,4,0)
 ;;=4^M87.08
 ;;^UTILITY(U,$J,358.3,37485,2)
 ;;=^5014698
 ;;^UTILITY(U,$J,358.3,37486,0)
 ;;=T84.52XA^^172^1885^23
 ;;^UTILITY(U,$J,358.3,37486,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37486,1,3,0)
 ;;=3^Infect/inflm reaction d/t internal left hip prosth, init
 ;;^UTILITY(U,$J,358.3,37486,1,4,0)
 ;;=4^T84.52XA
 ;;^UTILITY(U,$J,358.3,37486,2)
 ;;=^5055388
 ;;^UTILITY(U,$J,358.3,37487,0)
 ;;=T84.54XA^^172^1885^24
 ;;^UTILITY(U,$J,358.3,37487,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37487,1,3,0)
 ;;=3^Infect/inflm reaction d/t internal left knee prosth, init
 ;;^UTILITY(U,$J,358.3,37487,1,4,0)
 ;;=4^T84.54XA
 ;;^UTILITY(U,$J,358.3,37487,2)
 ;;=^5055394
 ;;^UTILITY(U,$J,358.3,37488,0)
 ;;=T84.51XA^^172^1885^27
 ;;^UTILITY(U,$J,358.3,37488,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37488,1,3,0)
 ;;=3^Infect/inflm reaction d/t internal right hip prosth, init
 ;;^UTILITY(U,$J,358.3,37488,1,4,0)
 ;;=4^T84.51XA
 ;;^UTILITY(U,$J,358.3,37488,2)
 ;;=^5055385
 ;;^UTILITY(U,$J,358.3,37489,0)
 ;;=T84.53XA^^172^1885^28
 ;;^UTILITY(U,$J,358.3,37489,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37489,1,3,0)
 ;;=3^Infect/inflm reaction d/t internal right knee prosth, init
 ;;^UTILITY(U,$J,358.3,37489,1,4,0)
 ;;=4^T84.53XA
 ;;^UTILITY(U,$J,358.3,37489,2)
 ;;=^5055391
 ;;^UTILITY(U,$J,358.3,37490,0)
 ;;=T84.59XA^^172^1885^31
 ;;^UTILITY(U,$J,358.3,37490,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37490,1,3,0)
 ;;=3^Infect/inflm reaction d/t oth internal joint prosth, init
 ;;^UTILITY(U,$J,358.3,37490,1,4,0)
 ;;=4^T84.59XA
