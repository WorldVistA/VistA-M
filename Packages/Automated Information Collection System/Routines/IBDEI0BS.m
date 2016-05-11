IBDEI0BS ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,5331,1,4,0)
 ;;=4^N06.0
 ;;^UTILITY(U,$J,358.3,5331,2)
 ;;=^5015549
 ;;^UTILITY(U,$J,358.3,5332,0)
 ;;=N06.1^^27^344^39
 ;;^UTILITY(U,$J,358.3,5332,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5332,1,3,0)
 ;;=3^Isolated proteinuria w/ focal & segmental glomerular lesions
 ;;^UTILITY(U,$J,358.3,5332,1,4,0)
 ;;=4^N06.1
 ;;^UTILITY(U,$J,358.3,5332,2)
 ;;=^5015550
 ;;^UTILITY(U,$J,358.3,5333,0)
 ;;=N06.2^^27^344^36
 ;;^UTILITY(U,$J,358.3,5333,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5333,1,3,0)
 ;;=3^Isolated proteinuria w/ diffuse membranous glomerulonephritis
 ;;^UTILITY(U,$J,358.3,5333,1,4,0)
 ;;=4^N06.2
 ;;^UTILITY(U,$J,358.3,5333,2)
 ;;=^5015551
 ;;^UTILITY(U,$J,358.3,5334,0)
 ;;=N06.3^^27^344^37
 ;;^UTILITY(U,$J,358.3,5334,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5334,1,3,0)
 ;;=3^Isolated proteinuria w/ diffuse mesangial prolif glomrlneph
 ;;^UTILITY(U,$J,358.3,5334,1,4,0)
 ;;=4^N06.3
 ;;^UTILITY(U,$J,358.3,5334,2)
 ;;=^5015552
 ;;^UTILITY(U,$J,358.3,5335,0)
 ;;=N06.4^^27^344^35
 ;;^UTILITY(U,$J,358.3,5335,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5335,1,3,0)
 ;;=3^Isolated proteinuria w/ diffuse endocaplry prolif glomrlneph
 ;;^UTILITY(U,$J,358.3,5335,1,4,0)
 ;;=4^N06.4
 ;;^UTILITY(U,$J,358.3,5335,2)
 ;;=^5015553
 ;;^UTILITY(U,$J,358.3,5336,0)
 ;;=N06.5^^27^344^38
 ;;^UTILITY(U,$J,358.3,5336,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5336,1,3,0)
 ;;=3^Isolated proteinuria w/ diffuse mesangiocapillary glomrlneph
 ;;^UTILITY(U,$J,358.3,5336,1,4,0)
 ;;=4^N06.5
 ;;^UTILITY(U,$J,358.3,5336,2)
 ;;=^5015554
 ;;^UTILITY(U,$J,358.3,5337,0)
 ;;=N06.6^^27^344^33
 ;;^UTILITY(U,$J,358.3,5337,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5337,1,3,0)
 ;;=3^Isolated proteinuria w/ dense deposit disease
 ;;^UTILITY(U,$J,358.3,5337,1,4,0)
 ;;=4^N06.6
 ;;^UTILITY(U,$J,358.3,5337,2)
 ;;=^5015555
 ;;^UTILITY(U,$J,358.3,5338,0)
 ;;=N06.7^^27^344^34
 ;;^UTILITY(U,$J,358.3,5338,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5338,1,3,0)
 ;;=3^Isolated proteinuria w/ diffuse crescentic glomerulonephritis
 ;;^UTILITY(U,$J,358.3,5338,1,4,0)
 ;;=4^N06.7
 ;;^UTILITY(U,$J,358.3,5338,2)
 ;;=^5015556
 ;;^UTILITY(U,$J,358.3,5339,0)
 ;;=N06.8^^27^344^41
 ;;^UTILITY(U,$J,358.3,5339,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5339,1,3,0)
 ;;=3^Isolated proteinuria w/ other morphologic lesion
 ;;^UTILITY(U,$J,358.3,5339,1,4,0)
 ;;=4^N06.8
 ;;^UTILITY(U,$J,358.3,5339,2)
 ;;=^5015557
 ;;^UTILITY(U,$J,358.3,5340,0)
 ;;=N06.9^^27^344^42
 ;;^UTILITY(U,$J,358.3,5340,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5340,1,3,0)
 ;;=3^Isolated proteinuria w/ unspecified morphologic lesion
 ;;^UTILITY(U,$J,358.3,5340,1,4,0)
 ;;=4^N06.9
 ;;^UTILITY(U,$J,358.3,5340,2)
 ;;=^5015558
 ;;^UTILITY(U,$J,358.3,5341,0)
 ;;=N07.0^^27^344^30
 ;;^UTILITY(U,$J,358.3,5341,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5341,1,3,0)
 ;;=3^Hereditary nephropathy, NEC w/ minor glomerular abnormality
 ;;^UTILITY(U,$J,358.3,5341,1,4,0)
 ;;=4^N07.0
 ;;^UTILITY(U,$J,358.3,5341,2)
 ;;=^5015559
 ;;^UTILITY(U,$J,358.3,5342,0)
 ;;=N07.1^^27^344^29
 ;;^UTILITY(U,$J,358.3,5342,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5342,1,3,0)
 ;;=3^Hereditary nephropathy, NEC w/ focal & seg glomerular lesions
 ;;^UTILITY(U,$J,358.3,5342,1,4,0)
 ;;=4^N07.1
 ;;^UTILITY(U,$J,358.3,5342,2)
 ;;=^5015560
 ;;^UTILITY(U,$J,358.3,5343,0)
 ;;=N07.2^^27^344^24
 ;;^UTILITY(U,$J,358.3,5343,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5343,1,3,0)
 ;;=3^Hereditary nephropathy, NEC w/ diffuse membranous glomrlneph
 ;;^UTILITY(U,$J,358.3,5343,1,4,0)
 ;;=4^N07.2
