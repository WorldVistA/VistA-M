IBDEI0TR ; ; 12-MAY-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,29937,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29937,1,3,0)
 ;;=3^Scoliosis,Other Form,Thoracic Region
 ;;^UTILITY(U,$J,358.3,29937,1,4,0)
 ;;=4^M41.84
 ;;^UTILITY(U,$J,358.3,29937,2)
 ;;=^5011885
 ;;^UTILITY(U,$J,358.3,29938,0)
 ;;=M41.85^^111^1439^37
 ;;^UTILITY(U,$J,358.3,29938,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29938,1,3,0)
 ;;=3^Scoliosis,Other Form,Thoracolumbar Region
 ;;^UTILITY(U,$J,358.3,29938,1,4,0)
 ;;=4^M41.85
 ;;^UTILITY(U,$J,358.3,29938,2)
 ;;=^5011886
 ;;^UTILITY(U,$J,358.3,29939,0)
 ;;=M41.86^^111^1439^34
 ;;^UTILITY(U,$J,358.3,29939,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29939,1,3,0)
 ;;=3^Scoliosis,Other Form,Lumbar Region
 ;;^UTILITY(U,$J,358.3,29939,1,4,0)
 ;;=4^M41.86
 ;;^UTILITY(U,$J,358.3,29939,2)
 ;;=^5011887
 ;;^UTILITY(U,$J,358.3,29940,0)
 ;;=M41.87^^111^1439^35
 ;;^UTILITY(U,$J,358.3,29940,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29940,1,3,0)
 ;;=3^Scoliosis,Other Form,Lumbosacral Region
 ;;^UTILITY(U,$J,358.3,29940,1,4,0)
 ;;=4^M41.87
 ;;^UTILITY(U,$J,358.3,29940,2)
 ;;=^5011888
 ;;^UTILITY(U,$J,358.3,29941,0)
 ;;=M48.02^^111^1439^45
 ;;^UTILITY(U,$J,358.3,29941,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29941,1,3,0)
 ;;=3^Spinal Stenosis,Cervical Region
 ;;^UTILITY(U,$J,358.3,29941,1,4,0)
 ;;=4^M48.02
 ;;^UTILITY(U,$J,358.3,29941,2)
 ;;=^5012089
 ;;^UTILITY(U,$J,358.3,29942,0)
 ;;=M48.03^^111^1439^46
 ;;^UTILITY(U,$J,358.3,29942,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29942,1,3,0)
 ;;=3^Spinal Stenosis,Cervicothoracic Region
 ;;^UTILITY(U,$J,358.3,29942,1,4,0)
 ;;=4^M48.03
 ;;^UTILITY(U,$J,358.3,29942,2)
 ;;=^5012090
 ;;^UTILITY(U,$J,358.3,29943,0)
 ;;=M48.04^^111^1439^50
 ;;^UTILITY(U,$J,358.3,29943,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29943,1,3,0)
 ;;=3^Spinal Stenosis,Thoracic Region
 ;;^UTILITY(U,$J,358.3,29943,1,4,0)
 ;;=4^M48.04
 ;;^UTILITY(U,$J,358.3,29943,2)
 ;;=^5012091
 ;;^UTILITY(U,$J,358.3,29944,0)
 ;;=M48.05^^111^1439^51
 ;;^UTILITY(U,$J,358.3,29944,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29944,1,3,0)
 ;;=3^Spinal Stenosis,Thoracolumbar Region
 ;;^UTILITY(U,$J,358.3,29944,1,4,0)
 ;;=4^M48.05
 ;;^UTILITY(U,$J,358.3,29944,2)
 ;;=^5012092
 ;;^UTILITY(U,$J,358.3,29945,0)
 ;;=M48.06^^111^1439^47
 ;;^UTILITY(U,$J,358.3,29945,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29945,1,3,0)
 ;;=3^Spinal Stenosis,Lumbar Region
 ;;^UTILITY(U,$J,358.3,29945,1,4,0)
 ;;=4^M48.06
 ;;^UTILITY(U,$J,358.3,29945,2)
 ;;=^5012093
 ;;^UTILITY(U,$J,358.3,29946,0)
 ;;=M48.07^^111^1439^48
 ;;^UTILITY(U,$J,358.3,29946,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29946,1,3,0)
 ;;=3^Spinal Stenosis,Lumbosacral Region
 ;;^UTILITY(U,$J,358.3,29946,1,4,0)
 ;;=4^M48.07
 ;;^UTILITY(U,$J,358.3,29946,2)
 ;;=^5012094
 ;;^UTILITY(U,$J,358.3,29947,0)
 ;;=M48.08^^111^1439^49
 ;;^UTILITY(U,$J,358.3,29947,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29947,1,3,0)
 ;;=3^Spinal Stenosis,Sacral & Sacrococcygeal Region
 ;;^UTILITY(U,$J,358.3,29947,1,4,0)
 ;;=4^M48.08
 ;;^UTILITY(U,$J,358.3,29947,2)
 ;;=^5012095
 ;;^UTILITY(U,$J,358.3,29948,0)
 ;;=M47.11^^111^1439^55
 ;;^UTILITY(U,$J,358.3,29948,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29948,1,3,0)
 ;;=3^Spondylosis w/ Myelopathy,Occipito-Atlanto-Axial Region
 ;;^UTILITY(U,$J,358.3,29948,1,4,0)
 ;;=4^M47.11
 ;;^UTILITY(U,$J,358.3,29948,2)
 ;;=^5012051
 ;;^UTILITY(U,$J,358.3,29949,0)
 ;;=M47.12^^111^1439^52
 ;;^UTILITY(U,$J,358.3,29949,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29949,1,3,0)
 ;;=3^Spondylosis w/ Myelopathy,Cervical Region
 ;;^UTILITY(U,$J,358.3,29949,1,4,0)
 ;;=4^M47.12
 ;;^UTILITY(U,$J,358.3,29949,2)
 ;;=^5012052
 ;;^UTILITY(U,$J,358.3,29950,0)
 ;;=M47.13^^111^1439^53
 ;;^UTILITY(U,$J,358.3,29950,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29950,1,3,0)
 ;;=3^Spondylosis w/ Myelopathy,Cervicothoracic Region
 ;;^UTILITY(U,$J,358.3,29950,1,4,0)
 ;;=4^M47.13
 ;;^UTILITY(U,$J,358.3,29950,2)
 ;;=^5012053
 ;;^UTILITY(U,$J,358.3,29951,0)
 ;;=M47.14^^111^1439^56
 ;;^UTILITY(U,$J,358.3,29951,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29951,1,3,0)
 ;;=3^Spondylosis w/ Myelopathy,Thoracic Region
 ;;^UTILITY(U,$J,358.3,29951,1,4,0)
 ;;=4^M47.14
 ;;^UTILITY(U,$J,358.3,29951,2)
 ;;=^5012054
 ;;^UTILITY(U,$J,358.3,29952,0)
 ;;=M47.15^^111^1439^57
 ;;^UTILITY(U,$J,358.3,29952,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29952,1,3,0)
 ;;=3^Spondylosis w/ Myelopathy,Thoracolumbar Region
 ;;^UTILITY(U,$J,358.3,29952,1,4,0)
 ;;=4^M47.15
 ;;^UTILITY(U,$J,358.3,29952,2)
 ;;=^5012055
 ;;^UTILITY(U,$J,358.3,29953,0)
 ;;=M47.16^^111^1439^54
 ;;^UTILITY(U,$J,358.3,29953,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29953,1,3,0)
 ;;=3^Spondylosis w/ Myelopathy,Lumbar Region
 ;;^UTILITY(U,$J,358.3,29953,1,4,0)
 ;;=4^M47.16
 ;;^UTILITY(U,$J,358.3,29953,2)
 ;;=^5012056
 ;;^UTILITY(U,$J,358.3,29954,0)
 ;;=M47.21^^111^1439^62
 ;;^UTILITY(U,$J,358.3,29954,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29954,1,3,0)
 ;;=3^Spondylosis w/ Radiculopathy,Occipto-Altanto-Axial Region
 ;;^UTILITY(U,$J,358.3,29954,1,4,0)
 ;;=4^M47.21
 ;;^UTILITY(U,$J,358.3,29954,2)
 ;;=^5012060
 ;;^UTILITY(U,$J,358.3,29955,0)
 ;;=M47.22^^111^1439^58
 ;;^UTILITY(U,$J,358.3,29955,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29955,1,3,0)
 ;;=3^Spondylosis w/ Radiculopathy,Cervical Region
 ;;^UTILITY(U,$J,358.3,29955,1,4,0)
 ;;=4^M47.22
 ;;^UTILITY(U,$J,358.3,29955,2)
 ;;=^5012061
 ;;^UTILITY(U,$J,358.3,29956,0)
 ;;=M47.23^^111^1439^59
 ;;^UTILITY(U,$J,358.3,29956,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29956,1,3,0)
 ;;=3^Spondylosis w/ Radiculopathy,Cervicothoracic Region
 ;;^UTILITY(U,$J,358.3,29956,1,4,0)
 ;;=4^M47.23
 ;;^UTILITY(U,$J,358.3,29956,2)
 ;;=^5012062
 ;;^UTILITY(U,$J,358.3,29957,0)
 ;;=M47.24^^111^1439^64
 ;;^UTILITY(U,$J,358.3,29957,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29957,1,3,0)
 ;;=3^Spondylosis w/ Radiculopathy,Thoracic Region
 ;;^UTILITY(U,$J,358.3,29957,1,4,0)
 ;;=4^M47.24
 ;;^UTILITY(U,$J,358.3,29957,2)
 ;;=^5012063
 ;;^UTILITY(U,$J,358.3,29958,0)
 ;;=M47.25^^111^1439^65
 ;;^UTILITY(U,$J,358.3,29958,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29958,1,3,0)
 ;;=3^Spondylosis w/ Radiculopathy,Thoracolumbar Region
 ;;^UTILITY(U,$J,358.3,29958,1,4,0)
 ;;=4^M47.25
 ;;^UTILITY(U,$J,358.3,29958,2)
 ;;=^5012064
 ;;^UTILITY(U,$J,358.3,29959,0)
 ;;=M47.26^^111^1439^60
 ;;^UTILITY(U,$J,358.3,29959,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29959,1,3,0)
 ;;=3^Spondylosis w/ Radiculopathy,Lumbar Region
 ;;^UTILITY(U,$J,358.3,29959,1,4,0)
 ;;=4^M47.26
 ;;^UTILITY(U,$J,358.3,29959,2)
 ;;=^5012065
 ;;^UTILITY(U,$J,358.3,29960,0)
 ;;=M47.27^^111^1439^61
 ;;^UTILITY(U,$J,358.3,29960,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29960,1,3,0)
 ;;=3^Spondylosis w/ Radiculopathy,Lumbosacral Region
 ;;^UTILITY(U,$J,358.3,29960,1,4,0)
 ;;=4^M47.27
 ;;^UTILITY(U,$J,358.3,29960,2)
 ;;=^5012066
 ;;^UTILITY(U,$J,358.3,29961,0)
 ;;=M47.28^^111^1439^63
 ;;^UTILITY(U,$J,358.3,29961,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29961,1,3,0)
 ;;=3^Spondylosis w/ Radiculopathy,Sacral & Sacrococcygeal Region
 ;;^UTILITY(U,$J,358.3,29961,1,4,0)
 ;;=4^M47.28
 ;;^UTILITY(U,$J,358.3,29961,2)
 ;;=^5012067
 ;;^UTILITY(U,$J,358.3,29962,0)
 ;;=G95.0^^111^1439^66
 ;;^UTILITY(U,$J,358.3,29962,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29962,1,3,0)
 ;;=3^Syringomyelia & Syringobulbia
 ;;^UTILITY(U,$J,358.3,29962,1,4,0)
 ;;=4^G95.0
 ;;^UTILITY(U,$J,358.3,29962,2)
 ;;=^116874
 ;;^UTILITY(U,$J,358.3,29963,0)
 ;;=H0038^^112^1440^1^^^^1
 ;;^UTILITY(U,$J,358.3,29963,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,29963,1,2,0)
 ;;=2^H0038
 ;;^UTILITY(U,$J,358.3,29963,1,3,0)
 ;;=3^Self-Help/Peer Svc,Ea 15 Min
 ;;^UTILITY(U,$J,358.3,29964,0)
 ;;=T74.11XA^^113^1441^5
 ;;^UTILITY(U,$J,358.3,29964,1,0)
 ;;=^358.31IA^4^2
