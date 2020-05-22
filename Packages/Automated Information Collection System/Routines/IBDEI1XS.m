IBDEI1XS ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,30930,0)
 ;;=N06.5^^123^1597^37
 ;;^UTILITY(U,$J,358.3,30930,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30930,1,3,0)
 ;;=3^Isolated proteinuria w/ diffuse mesangiocapillary glomrlneph
 ;;^UTILITY(U,$J,358.3,30930,1,4,0)
 ;;=4^N06.5
 ;;^UTILITY(U,$J,358.3,30930,2)
 ;;=^5015554
 ;;^UTILITY(U,$J,358.3,30931,0)
 ;;=N06.6^^123^1597^32
 ;;^UTILITY(U,$J,358.3,30931,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30931,1,3,0)
 ;;=3^Isolated proteinuria w/ dense deposit disease
 ;;^UTILITY(U,$J,358.3,30931,1,4,0)
 ;;=4^N06.6
 ;;^UTILITY(U,$J,358.3,30931,2)
 ;;=^5015555
 ;;^UTILITY(U,$J,358.3,30932,0)
 ;;=N06.7^^123^1597^33
 ;;^UTILITY(U,$J,358.3,30932,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30932,1,3,0)
 ;;=3^Isolated proteinuria w/ diffuse crescentic glomerulonephritis
 ;;^UTILITY(U,$J,358.3,30932,1,4,0)
 ;;=4^N06.7
 ;;^UTILITY(U,$J,358.3,30932,2)
 ;;=^5015556
 ;;^UTILITY(U,$J,358.3,30933,0)
 ;;=N06.8^^123^1597^40
 ;;^UTILITY(U,$J,358.3,30933,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30933,1,3,0)
 ;;=3^Isolated proteinuria w/ other morphologic lesion
 ;;^UTILITY(U,$J,358.3,30933,1,4,0)
 ;;=4^N06.8
 ;;^UTILITY(U,$J,358.3,30933,2)
 ;;=^5015557
 ;;^UTILITY(U,$J,358.3,30934,0)
 ;;=N06.9^^123^1597^41
 ;;^UTILITY(U,$J,358.3,30934,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30934,1,3,0)
 ;;=3^Isolated proteinuria w/ unspecified morphologic lesion
 ;;^UTILITY(U,$J,358.3,30934,1,4,0)
 ;;=4^N06.9
 ;;^UTILITY(U,$J,358.3,30934,2)
 ;;=^5015558
 ;;^UTILITY(U,$J,358.3,30935,0)
 ;;=N07.0^^123^1597^29
 ;;^UTILITY(U,$J,358.3,30935,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30935,1,3,0)
 ;;=3^Hereditary nephropathy, NEC w/ minor glomerular abnormality
 ;;^UTILITY(U,$J,358.3,30935,1,4,0)
 ;;=4^N07.0
 ;;^UTILITY(U,$J,358.3,30935,2)
 ;;=^5015559
 ;;^UTILITY(U,$J,358.3,30936,0)
 ;;=N07.1^^123^1597^28
 ;;^UTILITY(U,$J,358.3,30936,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30936,1,3,0)
 ;;=3^Hereditary nephropathy, NEC w/ focal & seg glomerular lesions
 ;;^UTILITY(U,$J,358.3,30936,1,4,0)
 ;;=4^N07.1
 ;;^UTILITY(U,$J,358.3,30936,2)
 ;;=^5015560
 ;;^UTILITY(U,$J,358.3,30937,0)
 ;;=N07.2^^123^1597^24
 ;;^UTILITY(U,$J,358.3,30937,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30937,1,3,0)
 ;;=3^Hereditary nephropathy, NEC w/ diffuse membranous glomrlneph
 ;;^UTILITY(U,$J,358.3,30937,1,4,0)
 ;;=4^N07.2
 ;;^UTILITY(U,$J,358.3,30937,2)
 ;;=^5015561
 ;;^UTILITY(U,$J,358.3,30938,0)
 ;;=N07.3^^123^1597^25
 ;;^UTILITY(U,$J,358.3,30938,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30938,1,3,0)
 ;;=3^Hereditary nephropathy, NEC w/ diffuse mesangial prolif glomrlneph
 ;;^UTILITY(U,$J,358.3,30938,1,4,0)
 ;;=4^N07.3
 ;;^UTILITY(U,$J,358.3,30938,2)
 ;;=^5015562
 ;;^UTILITY(U,$J,358.3,30939,0)
 ;;=N07.4^^123^1597^23
 ;;^UTILITY(U,$J,358.3,30939,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30939,1,3,0)
 ;;=3^Hereditary nephropathy, NEC w/ diffus endocaplry prolif glomrlneph
 ;;^UTILITY(U,$J,358.3,30939,1,4,0)
 ;;=4^N07.4
 ;;^UTILITY(U,$J,358.3,30939,2)
 ;;=^5015563
 ;;^UTILITY(U,$J,358.3,30940,0)
 ;;=N07.5^^123^1597^26
 ;;^UTILITY(U,$J,358.3,30940,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30940,1,3,0)
 ;;=3^Hereditary nephropathy, NEC w/ diffuse mesangiocap glomrlneph
 ;;^UTILITY(U,$J,358.3,30940,1,4,0)
 ;;=4^N07.5
 ;;^UTILITY(U,$J,358.3,30940,2)
 ;;=^5015564
 ;;^UTILITY(U,$J,358.3,30941,0)
 ;;=N07.6^^123^1597^22
 ;;^UTILITY(U,$J,358.3,30941,1,0)
 ;;=^358.31IA^4^2
