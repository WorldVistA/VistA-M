IBDEI1FW ; ; 01-FEB-2022
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 01, 2022
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,23287,1,3,0)
 ;;=3^Arthropathy, unspecified
 ;;^UTILITY(U,$J,358.3,23287,1,4,0)
 ;;=4^M12.9
 ;;^UTILITY(U,$J,358.3,23287,2)
 ;;=^5010666
 ;;^UTILITY(U,$J,358.3,23288,0)
 ;;=M15.3^^78^1005^37
 ;;^UTILITY(U,$J,358.3,23288,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23288,1,3,0)
 ;;=3^Secondary multiple arthritis
 ;;^UTILITY(U,$J,358.3,23288,1,4,0)
 ;;=4^M15.3
 ;;^UTILITY(U,$J,358.3,23288,2)
 ;;=^5010765
 ;;^UTILITY(U,$J,358.3,23289,0)
 ;;=M15.8^^78^1005^28
 ;;^UTILITY(U,$J,358.3,23289,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23289,1,3,0)
 ;;=3^Polyosteoarthritis, other
 ;;^UTILITY(U,$J,358.3,23289,1,4,0)
 ;;=4^M15.8
 ;;^UTILITY(U,$J,358.3,23289,2)
 ;;=^5010767
 ;;^UTILITY(U,$J,358.3,23290,0)
 ;;=M46.90^^78^1005^38
 ;;^UTILITY(U,$J,358.3,23290,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23290,1,3,0)
 ;;=3^Spondylopathy inflammatory, site unspec
 ;;^UTILITY(U,$J,358.3,23290,1,4,0)
 ;;=4^M46.90
 ;;^UTILITY(U,$J,358.3,23290,2)
 ;;=^5012030
 ;;^UTILITY(U,$J,358.3,23291,0)
 ;;=M47.819^^78^1005^39
 ;;^UTILITY(U,$J,358.3,23291,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23291,1,3,0)
 ;;=3^Spondylosis w/o myelopathy/radiculopathy, site unspec
 ;;^UTILITY(U,$J,358.3,23291,1,4,0)
 ;;=4^M47.819
 ;;^UTILITY(U,$J,358.3,23291,2)
 ;;=^5012076
 ;;^UTILITY(U,$J,358.3,23292,0)
 ;;=M51.9^^78^1005^8
 ;;^UTILITY(U,$J,358.3,23292,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23292,1,3,0)
 ;;=3^Intervertebral disc disorder, thoracic, thoracolumbar & lumbar
 ;;^UTILITY(U,$J,358.3,23292,1,4,0)
 ;;=4^M51.9
 ;;^UTILITY(U,$J,358.3,23292,2)
 ;;=^5012263
 ;;^UTILITY(U,$J,358.3,23293,0)
 ;;=M54.10^^78^1005^33
 ;;^UTILITY(U,$J,358.3,23293,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23293,1,3,0)
 ;;=3^Radiculopathy,Unspec Site
 ;;^UTILITY(U,$J,358.3,23293,1,4,0)
 ;;=4^M54.10
 ;;^UTILITY(U,$J,358.3,23293,2)
 ;;=^5012295
 ;;^UTILITY(U,$J,358.3,23294,0)
 ;;=M54.2^^78^1005^3
 ;;^UTILITY(U,$J,358.3,23294,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23294,1,3,0)
 ;;=3^Cervicalgia
 ;;^UTILITY(U,$J,358.3,23294,1,4,0)
 ;;=4^M54.2
 ;;^UTILITY(U,$J,358.3,23294,2)
 ;;=^5012304
 ;;^UTILITY(U,$J,358.3,23295,0)
 ;;=M54.31^^78^1005^36
 ;;^UTILITY(U,$J,358.3,23295,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23295,1,3,0)
 ;;=3^Sciatica, right side
 ;;^UTILITY(U,$J,358.3,23295,1,4,0)
 ;;=4^M54.31
 ;;^UTILITY(U,$J,358.3,23295,2)
 ;;=^5012306
 ;;^UTILITY(U,$J,358.3,23296,0)
 ;;=M54.32^^78^1005^35
 ;;^UTILITY(U,$J,358.3,23296,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23296,1,3,0)
 ;;=3^Sciatica, left side
 ;;^UTILITY(U,$J,358.3,23296,1,4,0)
 ;;=4^M54.32
 ;;^UTILITY(U,$J,358.3,23296,2)
 ;;=^5012307
 ;;^UTILITY(U,$J,358.3,23297,0)
 ;;=M54.9^^78^1005^4
 ;;^UTILITY(U,$J,358.3,23297,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23297,1,3,0)
 ;;=3^Dorsalgia, unspecified
 ;;^UTILITY(U,$J,358.3,23297,1,4,0)
 ;;=4^M54.9
 ;;^UTILITY(U,$J,358.3,23297,2)
 ;;=^5012314
 ;;^UTILITY(U,$J,358.3,23298,0)
 ;;=M77.9^^78^1005^5
 ;;^UTILITY(U,$J,358.3,23298,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23298,1,3,0)
 ;;=3^Enthesopathy, unspecified
 ;;^UTILITY(U,$J,358.3,23298,1,4,0)
 ;;=4^M77.9
 ;;^UTILITY(U,$J,358.3,23298,2)
 ;;=^5013319
 ;;^UTILITY(U,$J,358.3,23299,0)
 ;;=M71.50^^78^1005^2
 ;;^UTILITY(U,$J,358.3,23299,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23299,1,3,0)
 ;;=3^Bursitis NEC, unspec site
 ;;^UTILITY(U,$J,358.3,23299,1,4,0)
 ;;=4^M71.50
