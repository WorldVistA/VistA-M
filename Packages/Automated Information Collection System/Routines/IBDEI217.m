IBDEI217 ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,34041,0)
 ;;=N03.8^^154^1722^19
 ;;^UTILITY(U,$J,358.3,34041,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34041,1,3,0)
 ;;=3^Chr nephritic syndrome w/ other morphologic changes
 ;;^UTILITY(U,$J,358.3,34041,1,4,0)
 ;;=4^N03.8
 ;;^UTILITY(U,$J,358.3,34041,2)
 ;;=^5015529
 ;;^UTILITY(U,$J,358.3,34042,0)
 ;;=N03.9^^154^1722^20
 ;;^UTILITY(U,$J,358.3,34042,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34042,1,3,0)
 ;;=3^Chr nephritic syndrome w/ unsp morphologic changes
 ;;^UTILITY(U,$J,358.3,34042,1,4,0)
 ;;=4^N03.9
 ;;^UTILITY(U,$J,358.3,34042,2)
 ;;=^5015530
 ;;^UTILITY(U,$J,358.3,34043,0)
 ;;=N04.0^^154^1722^60
 ;;^UTILITY(U,$J,358.3,34043,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34043,1,3,0)
 ;;=3^Nephrotic syndrome w/ minor glomerular abnormality
 ;;^UTILITY(U,$J,358.3,34043,1,4,0)
 ;;=4^N04.0
 ;;^UTILITY(U,$J,358.3,34043,2)
 ;;=^5015531
 ;;^UTILITY(U,$J,358.3,34044,0)
 ;;=N04.1^^154^1722^59
 ;;^UTILITY(U,$J,358.3,34044,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34044,1,3,0)
 ;;=3^Nephrotic syndrome w/ focal & segmental glomerular lesions
 ;;^UTILITY(U,$J,358.3,34044,1,4,0)
 ;;=4^N04.1
 ;;^UTILITY(U,$J,358.3,34044,2)
 ;;=^5015532
 ;;^UTILITY(U,$J,358.3,34045,0)
 ;;=N04.2^^154^1722^56
 ;;^UTILITY(U,$J,358.3,34045,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34045,1,3,0)
 ;;=3^Nephrotic syndrome w/ diffuse membranous glomerulonephritis
 ;;^UTILITY(U,$J,358.3,34045,1,4,0)
 ;;=4^N04.2
 ;;^UTILITY(U,$J,358.3,34045,2)
 ;;=^5015533
 ;;^UTILITY(U,$J,358.3,34046,0)
 ;;=N04.3^^154^1722^57
 ;;^UTILITY(U,$J,358.3,34046,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34046,1,3,0)
 ;;=3^Nephrotic syndrome w/ diffuse mesangial prolif glomrlneph
 ;;^UTILITY(U,$J,358.3,34046,1,4,0)
 ;;=4^N04.3
 ;;^UTILITY(U,$J,358.3,34046,2)
 ;;=^5015534
 ;;^UTILITY(U,$J,358.3,34047,0)
 ;;=N04.4^^154^1722^55
 ;;^UTILITY(U,$J,358.3,34047,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34047,1,3,0)
 ;;=3^Nephrotic syndrome w/ diffuse endocaplry prolif glomrlneph
 ;;^UTILITY(U,$J,358.3,34047,1,4,0)
 ;;=4^N04.4
 ;;^UTILITY(U,$J,358.3,34047,2)
 ;;=^5015535
 ;;^UTILITY(U,$J,358.3,34048,0)
 ;;=N04.5^^154^1722^58
 ;;^UTILITY(U,$J,358.3,34048,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34048,1,3,0)
 ;;=3^Nephrotic syndrome w/ diffuse mesangiocapillary glomrlneph
 ;;^UTILITY(U,$J,358.3,34048,1,4,0)
 ;;=4^N04.5
 ;;^UTILITY(U,$J,358.3,34048,2)
 ;;=^5015536
 ;;^UTILITY(U,$J,358.3,34049,0)
 ;;=N04.6^^154^1722^53
 ;;^UTILITY(U,$J,358.3,34049,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34049,1,3,0)
 ;;=3^Nephrotic syndrome w/ dense deposit disease
 ;;^UTILITY(U,$J,358.3,34049,1,4,0)
 ;;=4^N04.6
 ;;^UTILITY(U,$J,358.3,34049,2)
 ;;=^5015537
 ;;^UTILITY(U,$J,358.3,34050,0)
 ;;=N04.7^^154^1722^54
 ;;^UTILITY(U,$J,358.3,34050,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34050,1,3,0)
 ;;=3^Nephrotic syndrome w/ diffuse crescentic glomerulonephritis
 ;;^UTILITY(U,$J,358.3,34050,1,4,0)
 ;;=4^N04.7
 ;;^UTILITY(U,$J,358.3,34050,2)
 ;;=^5015538
 ;;^UTILITY(U,$J,358.3,34051,0)
 ;;=N04.8^^154^1722^61
 ;;^UTILITY(U,$J,358.3,34051,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34051,1,3,0)
 ;;=3^Nephrotic syndrome w/ other morphologic changes
 ;;^UTILITY(U,$J,358.3,34051,1,4,0)
 ;;=4^N04.8
 ;;^UTILITY(U,$J,358.3,34051,2)
 ;;=^5015539
 ;;^UTILITY(U,$J,358.3,34052,0)
 ;;=N04.9^^154^1722^62
 ;;^UTILITY(U,$J,358.3,34052,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34052,1,3,0)
 ;;=3^Nephrotic syndrome w/ unspecified morphologic changes
 ;;^UTILITY(U,$J,358.3,34052,1,4,0)
 ;;=4^N04.9
 ;;^UTILITY(U,$J,358.3,34052,2)
 ;;=^5015540
