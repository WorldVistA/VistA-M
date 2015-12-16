IBDEI1NT ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,29479,2)
 ;;=^5004195
 ;;^UTILITY(U,$J,358.3,29480,0)
 ;;=G96.11^^176^1884^7
 ;;^UTILITY(U,$J,358.3,29480,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29480,1,3,0)
 ;;=3^Dural tear
 ;;^UTILITY(U,$J,358.3,29480,1,4,0)
 ;;=4^G96.11
 ;;^UTILITY(U,$J,358.3,29480,2)
 ;;=^5004196
 ;;^UTILITY(U,$J,358.3,29481,0)
 ;;=G82.51^^176^1884^10
 ;;^UTILITY(U,$J,358.3,29481,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29481,1,3,0)
 ;;=3^Quadriplegia, C1-C4 complete
 ;;^UTILITY(U,$J,358.3,29481,1,4,0)
 ;;=4^G82.51
 ;;^UTILITY(U,$J,358.3,29481,2)
 ;;=^5004129
 ;;^UTILITY(U,$J,358.3,29482,0)
 ;;=G82.52^^176^1884^11
 ;;^UTILITY(U,$J,358.3,29482,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29482,1,3,0)
 ;;=3^Quadriplegia, C1-C4 incomplete
 ;;^UTILITY(U,$J,358.3,29482,1,4,0)
 ;;=4^G82.52
 ;;^UTILITY(U,$J,358.3,29482,2)
 ;;=^5004130
 ;;^UTILITY(U,$J,358.3,29483,0)
 ;;=G82.53^^176^1884^12
 ;;^UTILITY(U,$J,358.3,29483,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29483,1,3,0)
 ;;=3^Quadriplegia, C5-C7 complete
 ;;^UTILITY(U,$J,358.3,29483,1,4,0)
 ;;=4^G82.53
 ;;^UTILITY(U,$J,358.3,29483,2)
 ;;=^5004131
 ;;^UTILITY(U,$J,358.3,29484,0)
 ;;=G82.54^^176^1884^13
 ;;^UTILITY(U,$J,358.3,29484,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29484,1,3,0)
 ;;=3^Quadriplegia, C5-C7 incomplete
 ;;^UTILITY(U,$J,358.3,29484,1,4,0)
 ;;=4^G82.54
 ;;^UTILITY(U,$J,358.3,29484,2)
 ;;=^5004132
 ;;^UTILITY(U,$J,358.3,29485,0)
 ;;=M45.4^^176^1885^1
 ;;^UTILITY(U,$J,358.3,29485,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29485,1,3,0)
 ;;=3^Ankylosing spondylitis of thoracic region
 ;;^UTILITY(U,$J,358.3,29485,1,4,0)
 ;;=4^M45.4
 ;;^UTILITY(U,$J,358.3,29485,2)
 ;;=^5011964
 ;;^UTILITY(U,$J,358.3,29486,0)
 ;;=M47.14^^176^1885^13
 ;;^UTILITY(U,$J,358.3,29486,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29486,1,3,0)
 ;;=3^Spondylosis with myelopathy, thoracic region NEC
 ;;^UTILITY(U,$J,358.3,29486,1,4,0)
 ;;=4^M47.14
 ;;^UTILITY(U,$J,358.3,29486,2)
 ;;=^5012054
 ;;^UTILITY(U,$J,358.3,29487,0)
 ;;=M51.34^^176^1885^5
 ;;^UTILITY(U,$J,358.3,29487,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29487,1,3,0)
 ;;=3^Intervertebral disc degeneration, thoracic region NEC
 ;;^UTILITY(U,$J,358.3,29487,1,4,0)
 ;;=4^M51.34
 ;;^UTILITY(U,$J,358.3,29487,2)
 ;;=^5012251
 ;;^UTILITY(U,$J,358.3,29488,0)
 ;;=M51.24^^176^1885^7
 ;;^UTILITY(U,$J,358.3,29488,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29488,1,3,0)
 ;;=3^Intervertebral disc displacement, thoracic region NEC
 ;;^UTILITY(U,$J,358.3,29488,1,4,0)
 ;;=4^M51.24
 ;;^UTILITY(U,$J,358.3,29488,2)
 ;;=^5012247
 ;;^UTILITY(U,$J,358.3,29489,0)
 ;;=M51.04^^176^1885^6
 ;;^UTILITY(U,$J,358.3,29489,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29489,1,3,0)
 ;;=3^Intervertebral disc disorders w myelopathy, thoracic region
 ;;^UTILITY(U,$J,358.3,29489,1,4,0)
 ;;=4^M51.04
 ;;^UTILITY(U,$J,358.3,29489,2)
 ;;=^5012239
 ;;^UTILITY(U,$J,358.3,29490,0)
 ;;=M51.05^^176^1885^9
 ;;^UTILITY(U,$J,358.3,29490,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29490,1,3,0)
 ;;=3^Intvrt disc disorders w myelopathy, thoracolumbar region
 ;;^UTILITY(U,$J,358.3,29490,1,4,0)
 ;;=4^M51.05
 ;;^UTILITY(U,$J,358.3,29490,2)
 ;;=^5012240
 ;;^UTILITY(U,$J,358.3,29491,0)
 ;;=M48.04^^176^1885^11
 ;;^UTILITY(U,$J,358.3,29491,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29491,1,3,0)
 ;;=3^Spinal stenosis, thoracic region
 ;;^UTILITY(U,$J,358.3,29491,1,4,0)
 ;;=4^M48.04
 ;;^UTILITY(U,$J,358.3,29491,2)
 ;;=^5012091
 ;;^UTILITY(U,$J,358.3,29492,0)
 ;;=Q76.2^^176^1885^3
 ;;^UTILITY(U,$J,358.3,29492,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29492,1,3,0)
 ;;=3^Congenital spondylolisthesis
