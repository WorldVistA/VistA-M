IBDEI01Q ; ; 01-MAY-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 01, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,3777,2)
 ;;=^5015577
 ;;^UTILITY(U,$J,358.3,3778,0)
 ;;=N13.30^^33^276^13
 ;;^UTILITY(U,$J,358.3,3778,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3778,1,3,0)
 ;;=3^Hydronephrosis,Unspec
 ;;^UTILITY(U,$J,358.3,3778,1,4,0)
 ;;=4^N13.30
 ;;^UTILITY(U,$J,358.3,3778,2)
 ;;=^5015578
 ;;^UTILITY(U,$J,358.3,3779,0)
 ;;=N13.39^^33^276^12
 ;;^UTILITY(U,$J,358.3,3779,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3779,1,3,0)
 ;;=3^Hydronephrosis,Other
 ;;^UTILITY(U,$J,358.3,3779,1,4,0)
 ;;=4^N13.39
 ;;^UTILITY(U,$J,358.3,3779,2)
 ;;=^5015579
 ;;^UTILITY(U,$J,358.3,3780,0)
 ;;=R33.9^^33^276^16
 ;;^UTILITY(U,$J,358.3,3780,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3780,1,3,0)
 ;;=3^Urinary Retention,Unspec
 ;;^UTILITY(U,$J,358.3,3780,1,4,0)
 ;;=4^R33.9
 ;;^UTILITY(U,$J,358.3,3780,2)
 ;;=^5019332
 ;;^UTILITY(U,$J,358.3,3781,0)
 ;;=I75.81^^33^276^8
 ;;^UTILITY(U,$J,358.3,3781,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3781,1,3,0)
 ;;=3^Atheroembolism of Kidney
 ;;^UTILITY(U,$J,358.3,3781,1,4,0)
 ;;=4^I75.81
 ;;^UTILITY(U,$J,358.3,3781,2)
 ;;=^328516
 ;;^UTILITY(U,$J,358.3,3782,0)
 ;;=R34.^^33^276^7
 ;;^UTILITY(U,$J,358.3,3782,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3782,1,3,0)
 ;;=3^Anuria and Oliguria
 ;;^UTILITY(U,$J,358.3,3782,1,4,0)
 ;;=4^R34.
 ;;^UTILITY(U,$J,358.3,3782,2)
 ;;=^5019333
 ;;^UTILITY(U,$J,358.3,3783,0)
 ;;=K76.7^^33^276^9
 ;;^UTILITY(U,$J,358.3,3783,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3783,1,3,0)
 ;;=3^Hepatorenal Syndrome
 ;;^UTILITY(U,$J,358.3,3783,1,4,0)
 ;;=4^K76.7
 ;;^UTILITY(U,$J,358.3,3783,2)
 ;;=^56497
 ;;^UTILITY(U,$J,358.3,3784,0)
 ;;=N00.0^^33^277^8
 ;;^UTILITY(U,$J,358.3,3784,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3784,1,3,0)
 ;;=3^Acute nephritic syndrome w/ minor glomerular abnormality
 ;;^UTILITY(U,$J,358.3,3784,1,4,0)
 ;;=4^N00.0
 ;;^UTILITY(U,$J,358.3,3784,2)
 ;;=^5015491
 ;;^UTILITY(U,$J,358.3,3785,0)
 ;;=N00.1^^33^277^7
 ;;^UTILITY(U,$J,358.3,3785,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3785,1,3,0)
 ;;=3^Acute nephritic syndrome w/ focal and segmental glomerular lesions
 ;;^UTILITY(U,$J,358.3,3785,1,4,0)
 ;;=4^N00.1
 ;;^UTILITY(U,$J,358.3,3785,2)
 ;;=^5015492
 ;;^UTILITY(U,$J,358.3,3786,0)
 ;;=N00.2^^33^277^4
 ;;^UTILITY(U,$J,358.3,3786,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3786,1,3,0)
 ;;=3^Acute nephritic syndrome w/ diffuse membranous glomrlneph
 ;;^UTILITY(U,$J,358.3,3786,1,4,0)
 ;;=4^N00.2
 ;;^UTILITY(U,$J,358.3,3786,2)
 ;;=^5015493
 ;;^UTILITY(U,$J,358.3,3787,0)
 ;;=N00.3^^33^277^5
 ;;^UTILITY(U,$J,358.3,3787,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3787,1,3,0)
 ;;=3^Acute nephritic syndrome w/ diffuse mesangial prolif glomrlneph
 ;;^UTILITY(U,$J,358.3,3787,1,4,0)
 ;;=4^N00.3
 ;;^UTILITY(U,$J,358.3,3787,2)
 ;;=^5015494
 ;;^UTILITY(U,$J,358.3,3788,0)
 ;;=N00.4^^33^277^3
 ;;^UTILITY(U,$J,358.3,3788,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3788,1,3,0)
 ;;=3^Acute nephritic syndrome w/ diffuse endocaplry prolif glomrlneph
 ;;^UTILITY(U,$J,358.3,3788,1,4,0)
 ;;=4^N00.4
 ;;^UTILITY(U,$J,358.3,3788,2)
 ;;=^5015495
 ;;^UTILITY(U,$J,358.3,3789,0)
 ;;=N00.5^^33^277^6
 ;;^UTILITY(U,$J,358.3,3789,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3789,1,3,0)
 ;;=3^Acute nephritic syndrome w/ diffuse mesangiocap glomrlneph
 ;;^UTILITY(U,$J,358.3,3789,1,4,0)
 ;;=4^N00.5
 ;;^UTILITY(U,$J,358.3,3789,2)
 ;;=^5015496
 ;;^UTILITY(U,$J,358.3,3790,0)
 ;;=N00.6^^33^277^1
 ;;^UTILITY(U,$J,358.3,3790,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3790,1,3,0)
 ;;=3^Acute nephritic syndrome w/ dense deposit disease
 ;;^UTILITY(U,$J,358.3,3790,1,4,0)
 ;;=4^N00.6
 ;;^UTILITY(U,$J,358.3,3790,2)
 ;;=^5015497
 ;;^UTILITY(U,$J,358.3,3791,0)
 ;;=N00.7^^33^277^2
 ;;^UTILITY(U,$J,358.3,3791,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3791,1,3,0)
 ;;=3^Acute nephritic syndrome w/ diffuse crescentic glomrlneph
 ;;^UTILITY(U,$J,358.3,3791,1,4,0)
 ;;=4^N00.7
 ;;^UTILITY(U,$J,358.3,3791,2)
 ;;=^5015498
 ;;^UTILITY(U,$J,358.3,3792,0)
 ;;=N00.8^^33^277^9
 ;;^UTILITY(U,$J,358.3,3792,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3792,1,3,0)
 ;;=3^Acute nephritic syndrome w/ other morphologic changes
 ;;^UTILITY(U,$J,358.3,3792,1,4,0)
 ;;=4^N00.8
 ;;^UTILITY(U,$J,358.3,3792,2)
 ;;=^5015499
 ;;^UTILITY(U,$J,358.3,3793,0)
 ;;=N00.9^^33^277^10
 ;;^UTILITY(U,$J,358.3,3793,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3793,1,3,0)
 ;;=3^Acute nephritic syndrome w/ unsp morphologic changes
 ;;^UTILITY(U,$J,358.3,3793,1,4,0)
 ;;=4^N00.9
 ;;^UTILITY(U,$J,358.3,3793,2)
 ;;=^5015500
 ;;^UTILITY(U,$J,358.3,3794,0)
 ;;=N01.0^^33^277^69
 ;;^UTILITY(U,$J,358.3,3794,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3794,1,3,0)
 ;;=3^Rapidly progr neph synd w/ minor glomerular abnlt
 ;;^UTILITY(U,$J,358.3,3794,1,4,0)
 ;;=4^N01.0
 ;;^UTILITY(U,$J,358.3,3794,2)
 ;;=^5015501
 ;;^UTILITY(U,$J,358.3,3795,0)
 ;;=N01.1^^33^277^68
 ;;^UTILITY(U,$J,358.3,3795,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3795,1,3,0)
 ;;=3^Rapidly progr neph synd w/ focal & seg glomerular lesions
 ;;^UTILITY(U,$J,358.3,3795,1,4,0)
 ;;=4^N01.1
 ;;^UTILITY(U,$J,358.3,3795,2)
 ;;=^5015502
 ;;^UTILITY(U,$J,358.3,3796,0)
 ;;=N01.2^^33^277^66
 ;;^UTILITY(U,$J,358.3,3796,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3796,1,3,0)
 ;;=3^Rapidly progr neph synd w/ diffuse membranous glomrlneph
 ;;^UTILITY(U,$J,358.3,3796,1,4,0)
 ;;=4^N01.2
 ;;^UTILITY(U,$J,358.3,3796,2)
 ;;=^5015503
 ;;^UTILITY(U,$J,358.3,3797,0)
 ;;=N01.3^^33^277^64
 ;;^UTILITY(U,$J,358.3,3797,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3797,1,3,0)
 ;;=3^Rapidly progr neph synd w/ diffus mesangial prolif glomrlneph
 ;;^UTILITY(U,$J,358.3,3797,1,4,0)
 ;;=4^N01.3
 ;;^UTILITY(U,$J,358.3,3797,2)
 ;;=^5015504
 ;;^UTILITY(U,$J,358.3,3798,0)
 ;;=N01.4^^33^277^63
 ;;^UTILITY(U,$J,358.3,3798,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3798,1,3,0)
 ;;=3^Rapidly progr neph synd w/ diffus endocaplry prolif glomrlneph
 ;;^UTILITY(U,$J,358.3,3798,1,4,0)
 ;;=4^N01.4
 ;;^UTILITY(U,$J,358.3,3798,2)
 ;;=^5015505
 ;;^UTILITY(U,$J,358.3,3799,0)
 ;;=N01.5^^33^277^67
 ;;^UTILITY(U,$J,358.3,3799,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3799,1,3,0)
 ;;=3^Rapidly progr neph synd w/ diffuse mesangiocap glomrlneph
 ;;^UTILITY(U,$J,358.3,3799,1,4,0)
 ;;=4^N01.5
 ;;^UTILITY(U,$J,358.3,3799,2)
 ;;=^5015506
 ;;^UTILITY(U,$J,358.3,3800,0)
 ;;=N01.6^^33^277^62
 ;;^UTILITY(U,$J,358.3,3800,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3800,1,3,0)
 ;;=3^Rapidly progr neph synd w/ dense deposit disease
 ;;^UTILITY(U,$J,358.3,3800,1,4,0)
 ;;=4^N01.6
 ;;^UTILITY(U,$J,358.3,3800,2)
 ;;=^5015507
 ;;^UTILITY(U,$J,358.3,3801,0)
 ;;=N01.7^^33^277^65
 ;;^UTILITY(U,$J,358.3,3801,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3801,1,3,0)
 ;;=3^Rapidly progr neph synd w/ diffuse crescentic glomrlneph
 ;;^UTILITY(U,$J,358.3,3801,1,4,0)
 ;;=4^N01.7
 ;;^UTILITY(U,$J,358.3,3801,2)
 ;;=^5015508
 ;;^UTILITY(U,$J,358.3,3802,0)
 ;;=N01.8^^33^277^70
 ;;^UTILITY(U,$J,358.3,3802,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3802,1,3,0)
 ;;=3^Rapidly progr neph synd w/ oth morphologic changes
 ;;^UTILITY(U,$J,358.3,3802,1,4,0)
 ;;=4^N01.8
 ;;^UTILITY(U,$J,358.3,3802,2)
 ;;=^5015509
 ;;^UTILITY(U,$J,358.3,3803,0)
 ;;=N01.9^^33^277^71
 ;;^UTILITY(U,$J,358.3,3803,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3803,1,3,0)
 ;;=3^Rapidly progr neph synd w/ unsp morphologic changes
 ;;^UTILITY(U,$J,358.3,3803,1,4,0)
 ;;=4^N01.9
 ;;^UTILITY(U,$J,358.3,3803,2)
 ;;=^5015510
 ;;^UTILITY(U,$J,358.3,3804,0)
 ;;=N02.0^^33^277^79
 ;;^UTILITY(U,$J,358.3,3804,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3804,1,3,0)
 ;;=3^Recurrent & perst hematur w/ minor glomerular abnlt
 ;;^UTILITY(U,$J,358.3,3804,1,4,0)
 ;;=4^N02.0
 ;;^UTILITY(U,$J,358.3,3804,2)
 ;;=^5015511
 ;;^UTILITY(U,$J,358.3,3805,0)
 ;;=N02.1^^33^277^78
 ;;^UTILITY(U,$J,358.3,3805,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3805,1,3,0)
 ;;=3^Recurrent & perst hematur w/ focal & seg glomerular lesions
 ;;^UTILITY(U,$J,358.3,3805,1,4,0)
 ;;=4^N02.1
 ;;^UTILITY(U,$J,358.3,3805,2)
 ;;=^5015512
 ;;^UTILITY(U,$J,358.3,3806,0)
 ;;=N02.2^^33^277^76
 ;;^UTILITY(U,$J,358.3,3806,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3806,1,3,0)
 ;;=3^Recurrent & perst hematur w/ diffuse membranous glomrlneph
 ;;^UTILITY(U,$J,358.3,3806,1,4,0)
 ;;=4^N02.2
 ;;^UTILITY(U,$J,358.3,3806,2)
 ;;=^5015513
 ;;^UTILITY(U,$J,358.3,3807,0)
 ;;=N02.3^^33^277^73
 ;;^UTILITY(U,$J,358.3,3807,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3807,1,3,0)
 ;;=3^Recur & perst hematur w/ diffus mesangial prolif glomrlneph
 ;;^UTILITY(U,$J,358.3,3807,1,4,0)
 ;;=4^N02.3
 ;;^UTILITY(U,$J,358.3,3807,2)
 ;;=^5015514
 ;;^UTILITY(U,$J,358.3,3808,0)
 ;;=N02.4^^33^277^72
 ;;^UTILITY(U,$J,358.3,3808,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3808,1,3,0)
 ;;=3^Recur & perst hematur w/ diffus endocaplry prolif glomrlneph
 ;;^UTILITY(U,$J,358.3,3808,1,4,0)
 ;;=4^N02.4
 ;;^UTILITY(U,$J,358.3,3808,2)
 ;;=^5015515
 ;;^UTILITY(U,$J,358.3,3809,0)
 ;;=N02.5^^33^277^77
 ;;^UTILITY(U,$J,358.3,3809,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3809,1,3,0)
 ;;=3^Recurrent & perst hematur w/ diffuse mesangiocap glomrlneph
 ;;^UTILITY(U,$J,358.3,3809,1,4,0)
 ;;=4^N02.5
 ;;^UTILITY(U,$J,358.3,3809,2)
 ;;=^5015516
 ;;^UTILITY(U,$J,358.3,3810,0)
 ;;=N02.6^^33^277^74
 ;;^UTILITY(U,$J,358.3,3810,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3810,1,3,0)
 ;;=3^Recurrent & perst hematur w/ dense deposit disease
 ;;^UTILITY(U,$J,358.3,3810,1,4,0)
 ;;=4^N02.6
 ;;^UTILITY(U,$J,358.3,3810,2)
 ;;=^5015517
 ;;^UTILITY(U,$J,358.3,3811,0)
 ;;=N02.7^^33^277^75
 ;;^UTILITY(U,$J,358.3,3811,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3811,1,3,0)
 ;;=3^Recurrent & perst hematur w/ diffuse crescentic glomrlneph
 ;;^UTILITY(U,$J,358.3,3811,1,4,0)
 ;;=4^N02.7
 ;;^UTILITY(U,$J,358.3,3811,2)
 ;;=^5015518
 ;;^UTILITY(U,$J,358.3,3812,0)
 ;;=N02.8^^33^277^80
 ;;^UTILITY(U,$J,358.3,3812,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3812,1,3,0)
 ;;=3^Recurrent & perst hematur w/ oth morphologic changes
 ;;^UTILITY(U,$J,358.3,3812,1,4,0)
 ;;=4^N02.8
 ;;^UTILITY(U,$J,358.3,3812,2)
 ;;=^5015519
 ;;^UTILITY(U,$J,358.3,3813,0)
 ;;=N02.9^^33^277^81
 ;;^UTILITY(U,$J,358.3,3813,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3813,1,3,0)
 ;;=3^Recurrent & perst hematur w/ unsp morphologic changes
 ;;^UTILITY(U,$J,358.3,3813,1,4,0)
 ;;=4^N02.9
 ;;^UTILITY(U,$J,358.3,3813,2)
 ;;=^5015520
 ;;^UTILITY(U,$J,358.3,3814,0)
 ;;=N03.0^^33^277^18
 ;;^UTILITY(U,$J,358.3,3814,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3814,1,3,0)
 ;;=3^Chr nephritic syndrome w/ minor glomerular abnormality
 ;;^UTILITY(U,$J,358.3,3814,1,4,0)
 ;;=4^N03.0
 ;;^UTILITY(U,$J,358.3,3814,2)
 ;;=^5015521
 ;;^UTILITY(U,$J,358.3,3815,0)
 ;;=N03.1^^33^277^17
 ;;^UTILITY(U,$J,358.3,3815,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3815,1,3,0)
 ;;=3^Chr nephritic syndrome w/ focal & seg glomerular lesions
 ;;^UTILITY(U,$J,358.3,3815,1,4,0)
 ;;=4^N03.1
 ;;^UTILITY(U,$J,358.3,3815,2)
 ;;=^5015522
 ;;^UTILITY(U,$J,358.3,3816,0)
 ;;=N03.2^^33^277^14
 ;;^UTILITY(U,$J,358.3,3816,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3816,1,3,0)
 ;;=3^Chr nephritic syndrome w/ diffuse membranous glomrlneph
 ;;^UTILITY(U,$J,358.3,3816,1,4,0)
 ;;=4^N03.2
 ;;^UTILITY(U,$J,358.3,3816,2)
 ;;=^5015523
 ;;^UTILITY(U,$J,358.3,3817,0)
 ;;=N03.3^^33^277^15
 ;;^UTILITY(U,$J,358.3,3817,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3817,1,3,0)
 ;;=3^Chr nephritic syndrome w/ diffuse mesangial prolif glomrlneph
 ;;^UTILITY(U,$J,358.3,3817,1,4,0)
 ;;=4^N03.3
 ;;^UTILITY(U,$J,358.3,3817,2)
 ;;=^5015524
 ;;^UTILITY(U,$J,358.3,3818,0)
 ;;=N03.4^^33^277^13
 ;;^UTILITY(U,$J,358.3,3818,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3818,1,3,0)
 ;;=3^Chr nephritic syndrome w/ diffuse endocaplry prolif glomrlneph
 ;;^UTILITY(U,$J,358.3,3818,1,4,0)
 ;;=4^N03.4
 ;;^UTILITY(U,$J,358.3,3818,2)
 ;;=^5015525
 ;;^UTILITY(U,$J,358.3,3819,0)
 ;;=N03.5^^33^277^16
 ;;^UTILITY(U,$J,358.3,3819,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3819,1,3,0)
 ;;=3^Chr nephritic syndrome w/ diffuse mesangiocap glomrlneph
 ;;^UTILITY(U,$J,358.3,3819,1,4,0)
 ;;=4^N03.5
 ;;^UTILITY(U,$J,358.3,3819,2)
 ;;=^5015526
 ;;^UTILITY(U,$J,358.3,3820,0)
 ;;=N03.6^^33^277^11
 ;;^UTILITY(U,$J,358.3,3820,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3820,1,3,0)
 ;;=3^Chr nephritic syndrome w/ dense deposit disease
 ;;^UTILITY(U,$J,358.3,3820,1,4,0)
 ;;=4^N03.6
 ;;^UTILITY(U,$J,358.3,3820,2)
 ;;=^5015527
 ;;^UTILITY(U,$J,358.3,3821,0)
 ;;=N03.7^^33^277^12
 ;;^UTILITY(U,$J,358.3,3821,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3821,1,3,0)
 ;;=3^Chr nephritic syndrome w/ diffuse crescentic glomrlneph
 ;;^UTILITY(U,$J,358.3,3821,1,4,0)
 ;;=4^N03.7
 ;;^UTILITY(U,$J,358.3,3821,2)
 ;;=^5015528
 ;;^UTILITY(U,$J,358.3,3822,0)
 ;;=N03.8^^33^277^19
 ;;^UTILITY(U,$J,358.3,3822,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3822,1,3,0)
 ;;=3^Chr nephritic syndrome w/ other morphologic changes
 ;;^UTILITY(U,$J,358.3,3822,1,4,0)
 ;;=4^N03.8
 ;;^UTILITY(U,$J,358.3,3822,2)
 ;;=^5015529
 ;;^UTILITY(U,$J,358.3,3823,0)
 ;;=N03.9^^33^277^20
 ;;^UTILITY(U,$J,358.3,3823,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3823,1,3,0)
 ;;=3^Chr nephritic syndrome w/ unsp morphologic changes
 ;;^UTILITY(U,$J,358.3,3823,1,4,0)
 ;;=4^N03.9
 ;;^UTILITY(U,$J,358.3,3823,2)
 ;;=^5015530
 ;;^UTILITY(U,$J,358.3,3824,0)
 ;;=N04.0^^33^277^59
 ;;^UTILITY(U,$J,358.3,3824,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3824,1,3,0)
 ;;=3^Nephrotic syndrome w/ minor glomerular abnormality
 ;;^UTILITY(U,$J,358.3,3824,1,4,0)
 ;;=4^N04.0
 ;;^UTILITY(U,$J,358.3,3824,2)
 ;;=^5015531
 ;;^UTILITY(U,$J,358.3,3825,0)
 ;;=N04.1^^33^277^58
 ;;^UTILITY(U,$J,358.3,3825,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3825,1,3,0)
 ;;=3^Nephrotic syndrome w/ focal & segmental glomerular lesions
 ;;^UTILITY(U,$J,358.3,3825,1,4,0)
 ;;=4^N04.1
 ;;^UTILITY(U,$J,358.3,3825,2)
 ;;=^5015532
 ;;^UTILITY(U,$J,358.3,3826,0)
 ;;=N04.2^^33^277^55
 ;;^UTILITY(U,$J,358.3,3826,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3826,1,3,0)
 ;;=3^Nephrotic syndrome w/ diffuse membranous glomerulonephritis
 ;;^UTILITY(U,$J,358.3,3826,1,4,0)
 ;;=4^N04.2
 ;;^UTILITY(U,$J,358.3,3826,2)
 ;;=^5015533
 ;;^UTILITY(U,$J,358.3,3827,0)
 ;;=N04.3^^33^277^56
 ;;^UTILITY(U,$J,358.3,3827,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3827,1,3,0)
 ;;=3^Nephrotic syndrome w/ diffuse mesangial prolif glomrlneph
 ;;^UTILITY(U,$J,358.3,3827,1,4,0)
 ;;=4^N04.3
 ;;^UTILITY(U,$J,358.3,3827,2)
 ;;=^5015534
 ;;^UTILITY(U,$J,358.3,3828,0)
 ;;=N04.4^^33^277^54
 ;;^UTILITY(U,$J,358.3,3828,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3828,1,3,0)
 ;;=3^Nephrotic syndrome w/ diffuse endocaplry prolif glomrlneph
 ;;^UTILITY(U,$J,358.3,3828,1,4,0)
 ;;=4^N04.4
 ;;^UTILITY(U,$J,358.3,3828,2)
 ;;=^5015535
 ;;^UTILITY(U,$J,358.3,3829,0)
 ;;=N04.5^^33^277^57
 ;;^UTILITY(U,$J,358.3,3829,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3829,1,3,0)
 ;;=3^Nephrotic syndrome w/ diffuse mesangiocapillary glomrlneph
 ;;^UTILITY(U,$J,358.3,3829,1,4,0)
 ;;=4^N04.5
 ;;^UTILITY(U,$J,358.3,3829,2)
 ;;=^5015536
 ;;^UTILITY(U,$J,358.3,3830,0)
 ;;=N04.6^^33^277^52
 ;;^UTILITY(U,$J,358.3,3830,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3830,1,3,0)
 ;;=3^Nephrotic syndrome w/ dense deposit disease
 ;;^UTILITY(U,$J,358.3,3830,1,4,0)
 ;;=4^N04.6
 ;;^UTILITY(U,$J,358.3,3830,2)
 ;;=^5015537
 ;;^UTILITY(U,$J,358.3,3831,0)
 ;;=N04.7^^33^277^53
 ;;^UTILITY(U,$J,358.3,3831,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3831,1,3,0)
 ;;=3^Nephrotic syndrome w/ diffuse crescentic glomerulonephritis
 ;;^UTILITY(U,$J,358.3,3831,1,4,0)
 ;;=4^N04.7
 ;;^UTILITY(U,$J,358.3,3831,2)
 ;;=^5015538
 ;;^UTILITY(U,$J,358.3,3832,0)
 ;;=N04.8^^33^277^60
 ;;^UTILITY(U,$J,358.3,3832,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3832,1,3,0)
 ;;=3^Nephrotic syndrome w/ other morphologic changes
 ;;^UTILITY(U,$J,358.3,3832,1,4,0)
 ;;=4^N04.8
 ;;^UTILITY(U,$J,358.3,3832,2)
 ;;=^5015539
 ;;^UTILITY(U,$J,358.3,3833,0)
 ;;=N04.9^^33^277^61
 ;;^UTILITY(U,$J,358.3,3833,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3833,1,3,0)
 ;;=3^Nephrotic syndrome w/ unspecified morphologic changes
 ;;^UTILITY(U,$J,358.3,3833,1,4,0)
 ;;=4^N04.9
 ;;^UTILITY(U,$J,358.3,3833,2)
 ;;=^5015540
 ;;^UTILITY(U,$J,358.3,3834,0)
 ;;=N05.0^^33^277^49
 ;;^UTILITY(U,$J,358.3,3834,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3834,1,3,0)
 ;;=3^Nephritic syndrome unspec w/ minor glomerular abnormality
 ;;^UTILITY(U,$J,358.3,3834,1,4,0)
 ;;=4^N05.0
 ;;^UTILITY(U,$J,358.3,3834,2)
 ;;=^5015541
 ;;^UTILITY(U,$J,358.3,3835,0)
 ;;=N05.1^^33^277^48
 ;;^UTILITY(U,$J,358.3,3835,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3835,1,3,0)
 ;;=3^Nephritic syndrome unspec w/ focal & segmental glomerular lesions
 ;;^UTILITY(U,$J,358.3,3835,1,4,0)
 ;;=4^N05.1
 ;;^UTILITY(U,$J,358.3,3835,2)
 ;;=^5015542
 ;;^UTILITY(U,$J,358.3,3836,0)
 ;;=N05.2^^33^277^45
 ;;^UTILITY(U,$J,358.3,3836,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3836,1,3,0)
 ;;=3^Nephritic syndrome unspec w/ diffuse membranous glomrlneph
 ;;^UTILITY(U,$J,358.3,3836,1,4,0)
 ;;=4^N05.2
 ;;^UTILITY(U,$J,358.3,3836,2)
 ;;=^5015543
 ;;^UTILITY(U,$J,358.3,3837,0)
 ;;=N05.3^^33^277^46
 ;;^UTILITY(U,$J,358.3,3837,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3837,1,3,0)
 ;;=3^Nephritic syndrome unspec w/ diffuse mesangial prolif glomrlneph
 ;;^UTILITY(U,$J,358.3,3837,1,4,0)
 ;;=4^N05.3
 ;;^UTILITY(U,$J,358.3,3837,2)
 ;;=^5015544
 ;;^UTILITY(U,$J,358.3,3838,0)
 ;;=N05.4^^33^277^44
 ;;^UTILITY(U,$J,358.3,3838,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3838,1,3,0)
 ;;=3^Nephritic syndrome unspec w/ diffuse endocaplry prolif glomrlneph
 ;;^UTILITY(U,$J,358.3,3838,1,4,0)
 ;;=4^N05.4
 ;;^UTILITY(U,$J,358.3,3838,2)
 ;;=^5015545
 ;;^UTILITY(U,$J,358.3,3839,0)
 ;;=N05.5^^33^277^47
 ;;^UTILITY(U,$J,358.3,3839,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3839,1,3,0)
 ;;=3^Nephritic syndrome unspec w/ diffuse mesangiocap glomrlneph
 ;;^UTILITY(U,$J,358.3,3839,1,4,0)
 ;;=4^N05.5
 ;;^UTILITY(U,$J,358.3,3839,2)
 ;;=^5015546
 ;;^UTILITY(U,$J,358.3,3840,0)
 ;;=N05.6^^33^277^42
 ;;^UTILITY(U,$J,358.3,3840,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3840,1,3,0)
 ;;=3^Nephritic syndrome unspec w/ dense deposit disease
 ;;^UTILITY(U,$J,358.3,3840,1,4,0)
 ;;=4^N05.6
 ;;^UTILITY(U,$J,358.3,3840,2)
 ;;=^5015547
 ;;^UTILITY(U,$J,358.3,3841,0)
 ;;=N05.7^^33^277^43
 ;;^UTILITY(U,$J,358.3,3841,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3841,1,3,0)
 ;;=3^Nephritic syndrome unspec w/ diffuse crescentic glomrlneph
 ;;^UTILITY(U,$J,358.3,3841,1,4,0)
 ;;=4^N05.7
 ;;^UTILITY(U,$J,358.3,3841,2)
 ;;=^5015548
 ;;^UTILITY(U,$J,358.3,3842,0)
 ;;=N05.8^^33^277^50
 ;;^UTILITY(U,$J,358.3,3842,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3842,1,3,0)
 ;;=3^Nephritic syndrome unspec w/ oth morphologic changes
 ;;^UTILITY(U,$J,358.3,3842,1,4,0)
 ;;=4^N05.8
 ;;^UTILITY(U,$J,358.3,3842,2)
 ;;=^5134085
 ;;^UTILITY(U,$J,358.3,3843,0)
 ;;=N05.9^^33^277^51
