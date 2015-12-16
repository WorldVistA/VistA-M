IBDEI1RV ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,31293,0)
 ;;=M46.1^^180^1951^38
 ;;^UTILITY(U,$J,358.3,31293,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31293,1,3,0)
 ;;=3^Sacroiliitis NEC
 ;;^UTILITY(U,$J,358.3,31293,1,4,0)
 ;;=4^M46.1
 ;;^UTILITY(U,$J,358.3,31293,2)
 ;;=^5011980
 ;;^UTILITY(U,$J,358.3,31294,0)
 ;;=M46.02^^180^1951^39
 ;;^UTILITY(U,$J,358.3,31294,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31294,1,3,0)
 ;;=3^Spinal enthesopathy, cervical region
 ;;^UTILITY(U,$J,358.3,31294,1,4,0)
 ;;=4^M46.02
 ;;^UTILITY(U,$J,358.3,31294,2)
 ;;=^5011972
 ;;^UTILITY(U,$J,358.3,31295,0)
 ;;=M46.06^^180^1951^41
 ;;^UTILITY(U,$J,358.3,31295,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31295,1,3,0)
 ;;=3^Spinal enthesopathy, lumbar region
 ;;^UTILITY(U,$J,358.3,31295,1,4,0)
 ;;=4^M46.06
 ;;^UTILITY(U,$J,358.3,31295,2)
 ;;=^5011976
 ;;^UTILITY(U,$J,358.3,31296,0)
 ;;=M46.01^^180^1951^43
 ;;^UTILITY(U,$J,358.3,31296,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31296,1,3,0)
 ;;=3^Spinal enthesopathy, occipito-atlanto-axial region
 ;;^UTILITY(U,$J,358.3,31296,1,4,0)
 ;;=4^M46.01
 ;;^UTILITY(U,$J,358.3,31296,2)
 ;;=^5011971
 ;;^UTILITY(U,$J,358.3,31297,0)
 ;;=M46.07^^180^1951^42
 ;;^UTILITY(U,$J,358.3,31297,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31297,1,3,0)
 ;;=3^Spinal enthesopathy, lumbosacral region
 ;;^UTILITY(U,$J,358.3,31297,1,4,0)
 ;;=4^M46.07
 ;;^UTILITY(U,$J,358.3,31297,2)
 ;;=^5011977
 ;;^UTILITY(U,$J,358.3,31298,0)
 ;;=M46.05^^180^1951^45
 ;;^UTILITY(U,$J,358.3,31298,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31298,1,3,0)
 ;;=3^Spinal enthesopathy, thoracolumbar region
 ;;^UTILITY(U,$J,358.3,31298,1,4,0)
 ;;=4^M46.05
 ;;^UTILITY(U,$J,358.3,31298,2)
 ;;=^5011975
 ;;^UTILITY(U,$J,358.3,31299,0)
 ;;=M46.03^^180^1951^40
 ;;^UTILITY(U,$J,358.3,31299,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31299,1,3,0)
 ;;=3^Spinal enthesopathy, cervicothoracic region
 ;;^UTILITY(U,$J,358.3,31299,1,4,0)
 ;;=4^M46.03
 ;;^UTILITY(U,$J,358.3,31299,2)
 ;;=^5011973
 ;;^UTILITY(U,$J,358.3,31300,0)
 ;;=M46.04^^180^1951^44
 ;;^UTILITY(U,$J,358.3,31300,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31300,1,3,0)
 ;;=3^Spinal enthesopathy, thoracic region
 ;;^UTILITY(U,$J,358.3,31300,1,4,0)
 ;;=4^M46.04
 ;;^UTILITY(U,$J,358.3,31300,2)
 ;;=^5011974
 ;;^UTILITY(U,$J,358.3,31301,0)
 ;;=M48.9^^180^1951^46
 ;;^UTILITY(U,$J,358.3,31301,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31301,1,3,0)
 ;;=3^Spondylopathy, unspecified
 ;;^UTILITY(U,$J,358.3,31301,1,4,0)
 ;;=4^M48.9
 ;;^UTILITY(U,$J,358.3,31301,2)
 ;;=^5012204
 ;;^UTILITY(U,$J,358.3,31302,0)
 ;;=M47.812^^180^1951^47
 ;;^UTILITY(U,$J,358.3,31302,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31302,1,3,0)
 ;;=3^Spondyls w/o myelopathy or radiculopathy, cervical region
 ;;^UTILITY(U,$J,358.3,31302,1,4,0)
 ;;=4^M47.812
 ;;^UTILITY(U,$J,358.3,31302,2)
 ;;=^5012069
 ;;^UTILITY(U,$J,358.3,31303,0)
 ;;=M47.816^^180^1951^48
 ;;^UTILITY(U,$J,358.3,31303,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31303,1,3,0)
 ;;=3^Spondyls w/o myelopathy or radiculopathy, lumbar region
 ;;^UTILITY(U,$J,358.3,31303,1,4,0)
 ;;=4^M47.816
 ;;^UTILITY(U,$J,358.3,31303,2)
 ;;=^5012073
 ;;^UTILITY(U,$J,358.3,31304,0)
 ;;=M47.817^^180^1951^49
 ;;^UTILITY(U,$J,358.3,31304,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31304,1,3,0)
 ;;=3^Spondyls w/o myelopathy or radiculopathy, lumbosacr region
 ;;^UTILITY(U,$J,358.3,31304,1,4,0)
 ;;=4^M47.817
 ;;^UTILITY(U,$J,358.3,31304,2)
 ;;=^5012074
 ;;^UTILITY(U,$J,358.3,31305,0)
 ;;=M47.811^^180^1951^53
 ;;^UTILITY(U,$J,358.3,31305,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31305,1,3,0)
 ;;=3^Spondyls w/o myelpath or radiculopathy, occipt-atlan-ax rgn
