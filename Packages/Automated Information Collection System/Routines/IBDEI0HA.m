IBDEI0HA ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,7729,1,4,0)
 ;;=4^N06.3
 ;;^UTILITY(U,$J,358.3,7729,2)
 ;;=^5015552
 ;;^UTILITY(U,$J,358.3,7730,0)
 ;;=N06.4^^52^518^35
 ;;^UTILITY(U,$J,358.3,7730,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7730,1,3,0)
 ;;=3^Isolated proteinuria w/ diffuse endocaplry prolif glomrlneph
 ;;^UTILITY(U,$J,358.3,7730,1,4,0)
 ;;=4^N06.4
 ;;^UTILITY(U,$J,358.3,7730,2)
 ;;=^5015553
 ;;^UTILITY(U,$J,358.3,7731,0)
 ;;=N06.5^^52^518^38
 ;;^UTILITY(U,$J,358.3,7731,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7731,1,3,0)
 ;;=3^Isolated proteinuria w/ diffuse mesangiocapillary glomrlneph
 ;;^UTILITY(U,$J,358.3,7731,1,4,0)
 ;;=4^N06.5
 ;;^UTILITY(U,$J,358.3,7731,2)
 ;;=^5015554
 ;;^UTILITY(U,$J,358.3,7732,0)
 ;;=N06.6^^52^518^33
 ;;^UTILITY(U,$J,358.3,7732,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7732,1,3,0)
 ;;=3^Isolated proteinuria w/ dense deposit disease
 ;;^UTILITY(U,$J,358.3,7732,1,4,0)
 ;;=4^N06.6
 ;;^UTILITY(U,$J,358.3,7732,2)
 ;;=^5015555
 ;;^UTILITY(U,$J,358.3,7733,0)
 ;;=N06.7^^52^518^34
 ;;^UTILITY(U,$J,358.3,7733,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7733,1,3,0)
 ;;=3^Isolated proteinuria w/ diffuse crescentic glomerulonephritis
 ;;^UTILITY(U,$J,358.3,7733,1,4,0)
 ;;=4^N06.7
 ;;^UTILITY(U,$J,358.3,7733,2)
 ;;=^5015556
 ;;^UTILITY(U,$J,358.3,7734,0)
 ;;=N06.8^^52^518^41
 ;;^UTILITY(U,$J,358.3,7734,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7734,1,3,0)
 ;;=3^Isolated proteinuria w/ other morphologic lesion
 ;;^UTILITY(U,$J,358.3,7734,1,4,0)
 ;;=4^N06.8
 ;;^UTILITY(U,$J,358.3,7734,2)
 ;;=^5015557
 ;;^UTILITY(U,$J,358.3,7735,0)
 ;;=N06.9^^52^518^42
 ;;^UTILITY(U,$J,358.3,7735,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7735,1,3,0)
 ;;=3^Isolated proteinuria w/ unspecified morphologic lesion
 ;;^UTILITY(U,$J,358.3,7735,1,4,0)
 ;;=4^N06.9
 ;;^UTILITY(U,$J,358.3,7735,2)
 ;;=^5015558
 ;;^UTILITY(U,$J,358.3,7736,0)
 ;;=N07.0^^52^518^30
 ;;^UTILITY(U,$J,358.3,7736,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7736,1,3,0)
 ;;=3^Hereditary nephropathy, NEC w/ minor glomerular abnormality
 ;;^UTILITY(U,$J,358.3,7736,1,4,0)
 ;;=4^N07.0
 ;;^UTILITY(U,$J,358.3,7736,2)
 ;;=^5015559
 ;;^UTILITY(U,$J,358.3,7737,0)
 ;;=N07.1^^52^518^29
 ;;^UTILITY(U,$J,358.3,7737,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7737,1,3,0)
 ;;=3^Hereditary nephropathy, NEC w/ focal & seg glomerular lesions
 ;;^UTILITY(U,$J,358.3,7737,1,4,0)
 ;;=4^N07.1
 ;;^UTILITY(U,$J,358.3,7737,2)
 ;;=^5015560
 ;;^UTILITY(U,$J,358.3,7738,0)
 ;;=N07.2^^52^518^24
 ;;^UTILITY(U,$J,358.3,7738,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7738,1,3,0)
 ;;=3^Hereditary nephropathy, NEC w/ diffuse membranous glomrlneph
 ;;^UTILITY(U,$J,358.3,7738,1,4,0)
 ;;=4^N07.2
 ;;^UTILITY(U,$J,358.3,7738,2)
 ;;=^5015561
 ;;^UTILITY(U,$J,358.3,7739,0)
 ;;=N07.3^^52^518^25
 ;;^UTILITY(U,$J,358.3,7739,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7739,1,3,0)
 ;;=3^Hereditary nephropathy, NEC w/ diffuse mesangial prolif glomrlneph
 ;;^UTILITY(U,$J,358.3,7739,1,4,0)
 ;;=4^N07.3
 ;;^UTILITY(U,$J,358.3,7739,2)
 ;;=^5015562
 ;;^UTILITY(U,$J,358.3,7740,0)
 ;;=N07.3^^52^518^26
 ;;^UTILITY(U,$J,358.3,7740,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7740,1,3,0)
 ;;=3^Hereditary nephropathy, NEC w/ diffuse mesangial prolif glomrlneph
 ;;^UTILITY(U,$J,358.3,7740,1,4,0)
 ;;=4^N07.3
 ;;^UTILITY(U,$J,358.3,7740,2)
 ;;=^5015562
 ;;^UTILITY(U,$J,358.3,7741,0)
 ;;=N07.4^^52^518^23
 ;;^UTILITY(U,$J,358.3,7741,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7741,1,3,0)
 ;;=3^Hereditary nephropathy, NEC w/ diffus endocaplry prolif glomrlneph
 ;;^UTILITY(U,$J,358.3,7741,1,4,0)
 ;;=4^N07.4
