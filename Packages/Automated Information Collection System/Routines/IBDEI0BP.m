IBDEI0BP ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,5294,1,4,0)
 ;;=4^N02.3
 ;;^UTILITY(U,$J,358.3,5294,2)
 ;;=^5015514
 ;;^UTILITY(U,$J,358.3,5295,0)
 ;;=N02.4^^27^344^73
 ;;^UTILITY(U,$J,358.3,5295,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5295,1,3,0)
 ;;=3^Recur & perst hematur w/ diffus endocaplry prolif glomrlneph
 ;;^UTILITY(U,$J,358.3,5295,1,4,0)
 ;;=4^N02.4
 ;;^UTILITY(U,$J,358.3,5295,2)
 ;;=^5015515
 ;;^UTILITY(U,$J,358.3,5296,0)
 ;;=N02.5^^27^344^78
 ;;^UTILITY(U,$J,358.3,5296,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5296,1,3,0)
 ;;=3^Recurrent & perst hematur w/ diffuse mesangiocap glomrlneph
 ;;^UTILITY(U,$J,358.3,5296,1,4,0)
 ;;=4^N02.5
 ;;^UTILITY(U,$J,358.3,5296,2)
 ;;=^5015516
 ;;^UTILITY(U,$J,358.3,5297,0)
 ;;=N02.6^^27^344^75
 ;;^UTILITY(U,$J,358.3,5297,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5297,1,3,0)
 ;;=3^Recurrent & perst hematur w/ dense deposit disease
 ;;^UTILITY(U,$J,358.3,5297,1,4,0)
 ;;=4^N02.6
 ;;^UTILITY(U,$J,358.3,5297,2)
 ;;=^5015517
 ;;^UTILITY(U,$J,358.3,5298,0)
 ;;=N02.7^^27^344^76
 ;;^UTILITY(U,$J,358.3,5298,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5298,1,3,0)
 ;;=3^Recurrent & perst hematur w/ diffuse crescentic glomrlneph
 ;;^UTILITY(U,$J,358.3,5298,1,4,0)
 ;;=4^N02.7
 ;;^UTILITY(U,$J,358.3,5298,2)
 ;;=^5015518
 ;;^UTILITY(U,$J,358.3,5299,0)
 ;;=N02.8^^27^344^81
 ;;^UTILITY(U,$J,358.3,5299,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5299,1,3,0)
 ;;=3^Recurrent & perst hematur w/ oth morphologic changes
 ;;^UTILITY(U,$J,358.3,5299,1,4,0)
 ;;=4^N02.8
 ;;^UTILITY(U,$J,358.3,5299,2)
 ;;=^5015519
 ;;^UTILITY(U,$J,358.3,5300,0)
 ;;=N02.9^^27^344^82
 ;;^UTILITY(U,$J,358.3,5300,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5300,1,3,0)
 ;;=3^Recurrent & perst hematur w/ unsp morphologic changes
 ;;^UTILITY(U,$J,358.3,5300,1,4,0)
 ;;=4^N02.9
 ;;^UTILITY(U,$J,358.3,5300,2)
 ;;=^5015520
 ;;^UTILITY(U,$J,358.3,5301,0)
 ;;=N03.0^^27^344^18
 ;;^UTILITY(U,$J,358.3,5301,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5301,1,3,0)
 ;;=3^Chr nephritic syndrome w/ minor glomerular abnormality
 ;;^UTILITY(U,$J,358.3,5301,1,4,0)
 ;;=4^N03.0
 ;;^UTILITY(U,$J,358.3,5301,2)
 ;;=^5015521
 ;;^UTILITY(U,$J,358.3,5302,0)
 ;;=N03.1^^27^344^17
 ;;^UTILITY(U,$J,358.3,5302,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5302,1,3,0)
 ;;=3^Chr nephritic syndrome w/ focal & seg glomerular lesions
 ;;^UTILITY(U,$J,358.3,5302,1,4,0)
 ;;=4^N03.1
 ;;^UTILITY(U,$J,358.3,5302,2)
 ;;=^5015522
 ;;^UTILITY(U,$J,358.3,5303,0)
 ;;=N03.2^^27^344^14
 ;;^UTILITY(U,$J,358.3,5303,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5303,1,3,0)
 ;;=3^Chr nephritic syndrome w/ diffuse membranous glomrlneph
 ;;^UTILITY(U,$J,358.3,5303,1,4,0)
 ;;=4^N03.2
 ;;^UTILITY(U,$J,358.3,5303,2)
 ;;=^5015523
 ;;^UTILITY(U,$J,358.3,5304,0)
 ;;=N03.3^^27^344^15
 ;;^UTILITY(U,$J,358.3,5304,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5304,1,3,0)
 ;;=3^Chr nephritic syndrome w/ diffuse mesangial prolif glomrlneph
 ;;^UTILITY(U,$J,358.3,5304,1,4,0)
 ;;=4^N03.3
 ;;^UTILITY(U,$J,358.3,5304,2)
 ;;=^5015524
 ;;^UTILITY(U,$J,358.3,5305,0)
 ;;=N03.4^^27^344^13
 ;;^UTILITY(U,$J,358.3,5305,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5305,1,3,0)
 ;;=3^Chr nephritic syndrome w/ diffuse endocaplry prolif glomrlneph
 ;;^UTILITY(U,$J,358.3,5305,1,4,0)
 ;;=4^N03.4
 ;;^UTILITY(U,$J,358.3,5305,2)
 ;;=^5015525
 ;;^UTILITY(U,$J,358.3,5306,0)
 ;;=N03.5^^27^344^16
 ;;^UTILITY(U,$J,358.3,5306,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5306,1,3,0)
 ;;=3^Chr nephritic syndrome w/ diffuse mesangiocap glomrlneph
 ;;^UTILITY(U,$J,358.3,5306,1,4,0)
 ;;=4^N03.5
 ;;^UTILITY(U,$J,358.3,5306,2)
 ;;=^5015526
