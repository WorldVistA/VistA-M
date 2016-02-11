IBDEI216 ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,34029,0)
 ;;=N02.6^^154^1722^75
 ;;^UTILITY(U,$J,358.3,34029,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34029,1,3,0)
 ;;=3^Recurrent & perst hematur w/ dense deposit disease
 ;;^UTILITY(U,$J,358.3,34029,1,4,0)
 ;;=4^N02.6
 ;;^UTILITY(U,$J,358.3,34029,2)
 ;;=^5015517
 ;;^UTILITY(U,$J,358.3,34030,0)
 ;;=N02.7^^154^1722^76
 ;;^UTILITY(U,$J,358.3,34030,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34030,1,3,0)
 ;;=3^Recurrent & perst hematur w/ diffuse crescentic glomrlneph
 ;;^UTILITY(U,$J,358.3,34030,1,4,0)
 ;;=4^N02.7
 ;;^UTILITY(U,$J,358.3,34030,2)
 ;;=^5015518
 ;;^UTILITY(U,$J,358.3,34031,0)
 ;;=N02.8^^154^1722^81
 ;;^UTILITY(U,$J,358.3,34031,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34031,1,3,0)
 ;;=3^Recurrent & perst hematur w/ oth morphologic changes
 ;;^UTILITY(U,$J,358.3,34031,1,4,0)
 ;;=4^N02.8
 ;;^UTILITY(U,$J,358.3,34031,2)
 ;;=^5015519
 ;;^UTILITY(U,$J,358.3,34032,0)
 ;;=N02.9^^154^1722^82
 ;;^UTILITY(U,$J,358.3,34032,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34032,1,3,0)
 ;;=3^Recurrent & perst hematur w/ unsp morphologic changes
 ;;^UTILITY(U,$J,358.3,34032,1,4,0)
 ;;=4^N02.9
 ;;^UTILITY(U,$J,358.3,34032,2)
 ;;=^5015520
 ;;^UTILITY(U,$J,358.3,34033,0)
 ;;=N03.0^^154^1722^18
 ;;^UTILITY(U,$J,358.3,34033,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34033,1,3,0)
 ;;=3^Chr nephritic syndrome w/ minor glomerular abnormality
 ;;^UTILITY(U,$J,358.3,34033,1,4,0)
 ;;=4^N03.0
 ;;^UTILITY(U,$J,358.3,34033,2)
 ;;=^5015521
 ;;^UTILITY(U,$J,358.3,34034,0)
 ;;=N03.1^^154^1722^17
 ;;^UTILITY(U,$J,358.3,34034,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34034,1,3,0)
 ;;=3^Chr nephritic syndrome w/ focal & seg glomerular lesions
 ;;^UTILITY(U,$J,358.3,34034,1,4,0)
 ;;=4^N03.1
 ;;^UTILITY(U,$J,358.3,34034,2)
 ;;=^5015522
 ;;^UTILITY(U,$J,358.3,34035,0)
 ;;=N03.2^^154^1722^14
 ;;^UTILITY(U,$J,358.3,34035,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34035,1,3,0)
 ;;=3^Chr nephritic syndrome w/ diffuse membranous glomrlneph
 ;;^UTILITY(U,$J,358.3,34035,1,4,0)
 ;;=4^N03.2
 ;;^UTILITY(U,$J,358.3,34035,2)
 ;;=^5015523
 ;;^UTILITY(U,$J,358.3,34036,0)
 ;;=N03.3^^154^1722^15
 ;;^UTILITY(U,$J,358.3,34036,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34036,1,3,0)
 ;;=3^Chr nephritic syndrome w/ diffuse mesangial prolif glomrlneph
 ;;^UTILITY(U,$J,358.3,34036,1,4,0)
 ;;=4^N03.3
 ;;^UTILITY(U,$J,358.3,34036,2)
 ;;=^5015524
 ;;^UTILITY(U,$J,358.3,34037,0)
 ;;=N03.4^^154^1722^13
 ;;^UTILITY(U,$J,358.3,34037,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34037,1,3,0)
 ;;=3^Chr nephritic syndrome w/ diffuse endocaplry prolif glomrlneph
 ;;^UTILITY(U,$J,358.3,34037,1,4,0)
 ;;=4^N03.4
 ;;^UTILITY(U,$J,358.3,34037,2)
 ;;=^5015525
 ;;^UTILITY(U,$J,358.3,34038,0)
 ;;=N03.5^^154^1722^16
 ;;^UTILITY(U,$J,358.3,34038,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34038,1,3,0)
 ;;=3^Chr nephritic syndrome w/ diffuse mesangiocap glomrlneph
 ;;^UTILITY(U,$J,358.3,34038,1,4,0)
 ;;=4^N03.5
 ;;^UTILITY(U,$J,358.3,34038,2)
 ;;=^5015526
 ;;^UTILITY(U,$J,358.3,34039,0)
 ;;=N03.6^^154^1722^11
 ;;^UTILITY(U,$J,358.3,34039,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34039,1,3,0)
 ;;=3^Chr nephritic syndrome w/ dense deposit disease
 ;;^UTILITY(U,$J,358.3,34039,1,4,0)
 ;;=4^N03.6
 ;;^UTILITY(U,$J,358.3,34039,2)
 ;;=^5015527
 ;;^UTILITY(U,$J,358.3,34040,0)
 ;;=N03.7^^154^1722^12
 ;;^UTILITY(U,$J,358.3,34040,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34040,1,3,0)
 ;;=3^Chr nephritic syndrome w/ diffuse crescentic glomrlneph
 ;;^UTILITY(U,$J,358.3,34040,1,4,0)
 ;;=4^N03.7
 ;;^UTILITY(U,$J,358.3,34040,2)
 ;;=^5015528
