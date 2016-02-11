IBDEI22H ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,34658,2)
 ;;=^5004130
 ;;^UTILITY(U,$J,358.3,34659,0)
 ;;=G82.53^^160^1762^12
 ;;^UTILITY(U,$J,358.3,34659,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34659,1,3,0)
 ;;=3^Quadriplegia, C5-C7 complete
 ;;^UTILITY(U,$J,358.3,34659,1,4,0)
 ;;=4^G82.53
 ;;^UTILITY(U,$J,358.3,34659,2)
 ;;=^5004131
 ;;^UTILITY(U,$J,358.3,34660,0)
 ;;=G82.54^^160^1762^13
 ;;^UTILITY(U,$J,358.3,34660,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34660,1,3,0)
 ;;=3^Quadriplegia, C5-C7 incomplete
 ;;^UTILITY(U,$J,358.3,34660,1,4,0)
 ;;=4^G82.54
 ;;^UTILITY(U,$J,358.3,34660,2)
 ;;=^5004132
 ;;^UTILITY(U,$J,358.3,34661,0)
 ;;=M45.4^^160^1763^1
 ;;^UTILITY(U,$J,358.3,34661,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34661,1,3,0)
 ;;=3^Ankylosing spondylitis of thoracic region
 ;;^UTILITY(U,$J,358.3,34661,1,4,0)
 ;;=4^M45.4
 ;;^UTILITY(U,$J,358.3,34661,2)
 ;;=^5011964
 ;;^UTILITY(U,$J,358.3,34662,0)
 ;;=M47.14^^160^1763^13
 ;;^UTILITY(U,$J,358.3,34662,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34662,1,3,0)
 ;;=3^Spondylosis with myelopathy, thoracic region NEC
 ;;^UTILITY(U,$J,358.3,34662,1,4,0)
 ;;=4^M47.14
 ;;^UTILITY(U,$J,358.3,34662,2)
 ;;=^5012054
 ;;^UTILITY(U,$J,358.3,34663,0)
 ;;=M51.34^^160^1763^5
 ;;^UTILITY(U,$J,358.3,34663,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34663,1,3,0)
 ;;=3^Intervertebral disc degeneration, thoracic region NEC
 ;;^UTILITY(U,$J,358.3,34663,1,4,0)
 ;;=4^M51.34
 ;;^UTILITY(U,$J,358.3,34663,2)
 ;;=^5012251
 ;;^UTILITY(U,$J,358.3,34664,0)
 ;;=M51.24^^160^1763^7
 ;;^UTILITY(U,$J,358.3,34664,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34664,1,3,0)
 ;;=3^Intervertebral disc displacement, thoracic region NEC
 ;;^UTILITY(U,$J,358.3,34664,1,4,0)
 ;;=4^M51.24
 ;;^UTILITY(U,$J,358.3,34664,2)
 ;;=^5012247
 ;;^UTILITY(U,$J,358.3,34665,0)
 ;;=M51.04^^160^1763^6
 ;;^UTILITY(U,$J,358.3,34665,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34665,1,3,0)
 ;;=3^Intervertebral disc disorders w myelopathy, thoracic region
 ;;^UTILITY(U,$J,358.3,34665,1,4,0)
 ;;=4^M51.04
 ;;^UTILITY(U,$J,358.3,34665,2)
 ;;=^5012239
 ;;^UTILITY(U,$J,358.3,34666,0)
 ;;=M51.05^^160^1763^9
 ;;^UTILITY(U,$J,358.3,34666,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34666,1,3,0)
 ;;=3^Intvrt disc disorders w myelopathy, thoracolumbar region
 ;;^UTILITY(U,$J,358.3,34666,1,4,0)
 ;;=4^M51.05
 ;;^UTILITY(U,$J,358.3,34666,2)
 ;;=^5012240
 ;;^UTILITY(U,$J,358.3,34667,0)
 ;;=M48.04^^160^1763^11
 ;;^UTILITY(U,$J,358.3,34667,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34667,1,3,0)
 ;;=3^Spinal stenosis, thoracic region
 ;;^UTILITY(U,$J,358.3,34667,1,4,0)
 ;;=4^M48.04
 ;;^UTILITY(U,$J,358.3,34667,2)
 ;;=^5012091
 ;;^UTILITY(U,$J,358.3,34668,0)
 ;;=Q76.2^^160^1763^3
 ;;^UTILITY(U,$J,358.3,34668,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34668,1,3,0)
 ;;=3^Congenital spondylolisthesis
 ;;^UTILITY(U,$J,358.3,34668,1,4,0)
 ;;=4^Q76.2
 ;;^UTILITY(U,$J,358.3,34668,2)
 ;;=^5019003
 ;;^UTILITY(U,$J,358.3,34669,0)
 ;;=M43.10^^160^1763^12
 ;;^UTILITY(U,$J,358.3,34669,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34669,1,3,0)
 ;;=3^Spondylolisthesis, site unspecified
 ;;^UTILITY(U,$J,358.3,34669,1,4,0)
 ;;=4^M43.10
 ;;^UTILITY(U,$J,358.3,34669,2)
 ;;=^5011921
 ;;^UTILITY(U,$J,358.3,34670,0)
 ;;=G06.1^^160^1763^8
 ;;^UTILITY(U,$J,358.3,34670,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34670,1,3,0)
 ;;=3^Intraspinal abscess and granuloma
 ;;^UTILITY(U,$J,358.3,34670,1,4,0)
 ;;=4^G06.1
 ;;^UTILITY(U,$J,358.3,34670,2)
 ;;=^5003746
 ;;^UTILITY(U,$J,358.3,34671,0)
 ;;=G96.0^^160^1763^2
 ;;^UTILITY(U,$J,358.3,34671,1,0)
 ;;=^358.31IA^4^2
