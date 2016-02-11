IBDEI223 ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,34472,0)
 ;;=M54.15^^157^1752^12
 ;;^UTILITY(U,$J,358.3,34472,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34472,1,3,0)
 ;;=3^Radiculopathy,Thoracolumbar Region
 ;;^UTILITY(U,$J,358.3,34472,1,4,0)
 ;;=4^M54.15
 ;;^UTILITY(U,$J,358.3,34472,2)
 ;;=^5012300
 ;;^UTILITY(U,$J,358.3,34473,0)
 ;;=M54.31^^157^1752^14
 ;;^UTILITY(U,$J,358.3,34473,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34473,1,3,0)
 ;;=3^Sciatica,Right Side
 ;;^UTILITY(U,$J,358.3,34473,1,4,0)
 ;;=4^M54.31
 ;;^UTILITY(U,$J,358.3,34473,2)
 ;;=^5012306
 ;;^UTILITY(U,$J,358.3,34474,0)
 ;;=M54.32^^157^1752^13
 ;;^UTILITY(U,$J,358.3,34474,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34474,1,3,0)
 ;;=3^Sciatica,Left Side
 ;;^UTILITY(U,$J,358.3,34474,1,4,0)
 ;;=4^M54.32
 ;;^UTILITY(U,$J,358.3,34474,2)
 ;;=^5012307
 ;;^UTILITY(U,$J,358.3,34475,0)
 ;;=M48.03^^157^1752^16
 ;;^UTILITY(U,$J,358.3,34475,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34475,1,3,0)
 ;;=3^Spinal Stenosis,Cervicothoracic Region
 ;;^UTILITY(U,$J,358.3,34475,1,4,0)
 ;;=4^M48.03
 ;;^UTILITY(U,$J,358.3,34475,2)
 ;;=^5012090
 ;;^UTILITY(U,$J,358.3,34476,0)
 ;;=M48.06^^157^1752^17
 ;;^UTILITY(U,$J,358.3,34476,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34476,1,3,0)
 ;;=3^Spinal Stenosis,Lumbar Region
 ;;^UTILITY(U,$J,358.3,34476,1,4,0)
 ;;=4^M48.06
 ;;^UTILITY(U,$J,358.3,34476,2)
 ;;=^5012093
 ;;^UTILITY(U,$J,358.3,34477,0)
 ;;=M48.05^^157^1752^20
 ;;^UTILITY(U,$J,358.3,34477,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34477,1,3,0)
 ;;=3^Spinal Stenosis,Thoracolumbar Region
 ;;^UTILITY(U,$J,358.3,34477,1,4,0)
 ;;=4^M48.05
 ;;^UTILITY(U,$J,358.3,34477,2)
 ;;=^5012092
 ;;^UTILITY(U,$J,358.3,34478,0)
 ;;=M47.20^^157^1752^31
 ;;^UTILITY(U,$J,358.3,34478,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34478,1,3,0)
 ;;=3^Spondylosis w/ Radiculopathy,Site Unspec
 ;;^UTILITY(U,$J,358.3,34478,1,4,0)
 ;;=4^M47.20
 ;;^UTILITY(U,$J,358.3,34478,2)
 ;;=^5012059
 ;;^UTILITY(U,$J,358.3,34479,0)
 ;;=M47.22^^157^1752^26
 ;;^UTILITY(U,$J,358.3,34479,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34479,1,3,0)
 ;;=3^Spondylosis w/ Radiculopathy,Cervical Region
 ;;^UTILITY(U,$J,358.3,34479,1,4,0)
 ;;=4^M47.22
 ;;^UTILITY(U,$J,358.3,34479,2)
 ;;=^5012061
 ;;^UTILITY(U,$J,358.3,34480,0)
 ;;=M47.23^^157^1752^27
 ;;^UTILITY(U,$J,358.3,34480,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34480,1,3,0)
 ;;=3^Spondylosis w/ Radiculopathy,Cervicothoracic Region
 ;;^UTILITY(U,$J,358.3,34480,1,4,0)
 ;;=4^M47.23
 ;;^UTILITY(U,$J,358.3,34480,2)
 ;;=^5012062
 ;;^UTILITY(U,$J,358.3,34481,0)
 ;;=M47.24^^157^1752^32
 ;;^UTILITY(U,$J,358.3,34481,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34481,1,3,0)
 ;;=3^Spondylosis w/ Radiculopathy,Thoracic Region
 ;;^UTILITY(U,$J,358.3,34481,1,4,0)
 ;;=4^M47.24
 ;;^UTILITY(U,$J,358.3,34481,2)
 ;;=^5012063
 ;;^UTILITY(U,$J,358.3,34482,0)
 ;;=M47.25^^157^1752^33
 ;;^UTILITY(U,$J,358.3,34482,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34482,1,3,0)
 ;;=3^Spondylosis w/ Radiculopathy,Thoracolumbar Region
 ;;^UTILITY(U,$J,358.3,34482,1,4,0)
 ;;=4^M47.25
 ;;^UTILITY(U,$J,358.3,34482,2)
 ;;=^5012064
 ;;^UTILITY(U,$J,358.3,34483,0)
 ;;=M47.26^^157^1752^28
 ;;^UTILITY(U,$J,358.3,34483,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34483,1,3,0)
 ;;=3^Spondylosis w/ Radiculopathy,Lumbar Region
 ;;^UTILITY(U,$J,358.3,34483,1,4,0)
 ;;=4^M47.26
 ;;^UTILITY(U,$J,358.3,34483,2)
 ;;=^5012065
 ;;^UTILITY(U,$J,358.3,34484,0)
 ;;=M47.27^^157^1752^29
 ;;^UTILITY(U,$J,358.3,34484,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34484,1,3,0)
 ;;=3^Spondylosis w/ Radiculopathy,Lumbosacral Region
