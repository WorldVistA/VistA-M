IBDEI035 ; ; 09-FEB-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;OCT 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,3775,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3775,1,3,0)
 ;;=3^Follicular cyst of skin and subcut tissue, unspec
 ;;^UTILITY(U,$J,358.3,3775,1,4,0)
 ;;=4^L72.9
 ;;^UTILITY(U,$J,358.3,3775,2)
 ;;=^5009283
 ;;^UTILITY(U,$J,358.3,3776,0)
 ;;=R60.9^^18^178^4
 ;;^UTILITY(U,$J,358.3,3776,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3776,1,3,0)
 ;;=3^Edema, unspec
 ;;^UTILITY(U,$J,358.3,3776,1,4,0)
 ;;=4^R60.9
 ;;^UTILITY(U,$J,358.3,3776,2)
 ;;=^5019534
 ;;^UTILITY(U,$J,358.3,3777,0)
 ;;=N34.1^^18^179^3
 ;;^UTILITY(U,$J,358.3,3777,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3777,1,3,0)
 ;;=3^Nonspecific urethritis
 ;;^UTILITY(U,$J,358.3,3777,1,4,0)
 ;;=4^N34.1
 ;;^UTILITY(U,$J,358.3,3777,2)
 ;;=^5015655
 ;;^UTILITY(U,$J,358.3,3778,0)
 ;;=N34.3^^18^179^6
 ;;^UTILITY(U,$J,358.3,3778,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3778,1,3,0)
 ;;=3^Urethral syndrome, unspec
 ;;^UTILITY(U,$J,358.3,3778,1,4,0)
 ;;=4^N34.3
 ;;^UTILITY(U,$J,358.3,3778,2)
 ;;=^5015656
 ;;^UTILITY(U,$J,358.3,3779,0)
 ;;=N35.9^^18^179^5
 ;;^UTILITY(U,$J,358.3,3779,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3779,1,3,0)
 ;;=3^Urethral stricture, unspec
 ;;^UTILITY(U,$J,358.3,3779,1,4,0)
 ;;=4^N35.9
 ;;^UTILITY(U,$J,358.3,3779,2)
 ;;=^5015671
 ;;^UTILITY(U,$J,358.3,3780,0)
 ;;=N36.2^^18^179^4
 ;;^UTILITY(U,$J,358.3,3780,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3780,1,3,0)
 ;;=3^Urethral caruncle
 ;;^UTILITY(U,$J,358.3,3780,1,4,0)
 ;;=4^N36.2
 ;;^UTILITY(U,$J,358.3,3780,2)
 ;;=^265500
 ;;^UTILITY(U,$J,358.3,3781,0)
 ;;=N36.42^^18^179^2
 ;;^UTILITY(U,$J,358.3,3781,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3781,1,3,0)
 ;;=3^Intrinsic sphincter deficiency (ISD)
 ;;^UTILITY(U,$J,358.3,3781,1,4,0)
 ;;=4^N36.42
 ;;^UTILITY(U,$J,358.3,3781,2)
 ;;=^5015674
 ;;^UTILITY(U,$J,358.3,3782,0)
 ;;=N36.43^^18^179^1
 ;;^UTILITY(U,$J,358.3,3782,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3782,1,3,0)
 ;;=3^Comb hypermobility of urethra and intrinsic sphinc defic
 ;;^UTILITY(U,$J,358.3,3782,1,4,0)
 ;;=4^N36.43
 ;;^UTILITY(U,$J,358.3,3782,2)
 ;;=^5015675
 ;;^UTILITY(U,$J,358.3,3783,0)
 ;;=E10.40^^19^180^78
 ;;^UTILITY(U,$J,358.3,3783,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3783,1,3,0)
 ;;=3^Diabetes Type 1 w/ Diabetic Neuropathy,Unspec
 ;;^UTILITY(U,$J,358.3,3783,1,4,0)
 ;;=4^E10.40
 ;;^UTILITY(U,$J,358.3,3783,2)
 ;;=^5002604
 ;;^UTILITY(U,$J,358.3,3784,0)
 ;;=E10.42^^19^180^79
 ;;^UTILITY(U,$J,358.3,3784,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3784,1,3,0)
 ;;=3^Diabetes Type 1 w/ Diabetic Polyneuropathy
 ;;^UTILITY(U,$J,358.3,3784,1,4,0)
 ;;=4^E10.42
 ;;^UTILITY(U,$J,358.3,3784,2)
 ;;=^5002606
 ;;^UTILITY(U,$J,358.3,3785,0)
 ;;=E10.43^^19^180^76
 ;;^UTILITY(U,$J,358.3,3785,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3785,1,3,0)
 ;;=3^Diabetes Type 1 w/ Diabetic Autonomic Polyneuropathy
 ;;^UTILITY(U,$J,358.3,3785,1,4,0)
 ;;=4^E10.43
 ;;^UTILITY(U,$J,358.3,3785,2)
 ;;=^5002607
 ;;^UTILITY(U,$J,358.3,3786,0)
 ;;=E10.51^^19^180^74
 ;;^UTILITY(U,$J,358.3,3786,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3786,1,3,0)
 ;;=3^Diabetes Type 1 w/ Diab Peripheral Angiopathy w/o Gangrene
 ;;^UTILITY(U,$J,358.3,3786,1,4,0)
 ;;=4^E10.51
 ;;^UTILITY(U,$J,358.3,3786,2)
 ;;=^5002610
 ;;^UTILITY(U,$J,358.3,3787,0)
 ;;=E10.52^^19^180^75
 ;;^UTILITY(U,$J,358.3,3787,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3787,1,3,0)
 ;;=3^Diabetes Type 1 w/ Diab Peripheral Angiopathy w/ Gangrene
 ;;^UTILITY(U,$J,358.3,3787,1,4,0)
 ;;=4^E10.52
 ;;^UTILITY(U,$J,358.3,3787,2)
 ;;=^5002611
 ;;^UTILITY(U,$J,358.3,3788,0)
 ;;=E10.610^^19^180^73
 ;;^UTILITY(U,$J,358.3,3788,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3788,1,3,0)
 ;;=3^Diabetes Type 1 w/ Diab Neuropathic Arthropathy
 ;;^UTILITY(U,$J,358.3,3788,1,4,0)
 ;;=4^E10.610
 ;;^UTILITY(U,$J,358.3,3788,2)
 ;;=^5002613
 ;;^UTILITY(U,$J,358.3,3789,0)
 ;;=E10.620^^19^180^77
 ;;^UTILITY(U,$J,358.3,3789,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3789,1,3,0)
 ;;=3^Diabetes Type 1 w/ Diabetic Dermatitis
 ;;^UTILITY(U,$J,358.3,3789,1,4,0)
 ;;=4^E10.620
 ;;^UTILITY(U,$J,358.3,3789,2)
 ;;=^5002615
 ;;^UTILITY(U,$J,358.3,3790,0)
 ;;=E10.621^^19^180^80
 ;;^UTILITY(U,$J,358.3,3790,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3790,1,3,0)
 ;;=3^Diabetes Type 1 w/ Foot Ulcer
 ;;^UTILITY(U,$J,358.3,3790,1,4,0)
 ;;=4^E10.621
 ;;^UTILITY(U,$J,358.3,3790,2)
 ;;=^5002616
 ;;^UTILITY(U,$J,358.3,3791,0)
 ;;=E10.622^^19^180^85
 ;;^UTILITY(U,$J,358.3,3791,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3791,1,3,0)
 ;;=3^Diabetes Type 1 w/ Skin Ulcer
 ;;^UTILITY(U,$J,358.3,3791,1,4,0)
 ;;=4^E10.622
 ;;^UTILITY(U,$J,358.3,3791,2)
 ;;=^5002617
 ;;^UTILITY(U,$J,358.3,3792,0)
 ;;=E10.630^^19^180^84
 ;;^UTILITY(U,$J,358.3,3792,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3792,1,3,0)
 ;;=3^Diabetes Type 1 w/ Peridontal Disease
 ;;^UTILITY(U,$J,358.3,3792,1,4,0)
 ;;=4^E10.630
 ;;^UTILITY(U,$J,358.3,3792,2)
 ;;=^5002619
 ;;^UTILITY(U,$J,358.3,3793,0)
 ;;=E10.641^^19^180^82
 ;;^UTILITY(U,$J,358.3,3793,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3793,1,3,0)
 ;;=3^Diabetes Type 1 w/ Hypoglycemia w/ Coma
 ;;^UTILITY(U,$J,358.3,3793,1,4,0)
 ;;=4^E10.641
 ;;^UTILITY(U,$J,358.3,3793,2)
 ;;=^5002621
 ;;^UTILITY(U,$J,358.3,3794,0)
 ;;=E10.649^^19^180^83
 ;;^UTILITY(U,$J,358.3,3794,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3794,1,3,0)
 ;;=3^Diabetes Type 1 w/ Hypoglycemia w/o Coma
 ;;^UTILITY(U,$J,358.3,3794,1,4,0)
 ;;=4^E10.649
 ;;^UTILITY(U,$J,358.3,3794,2)
 ;;=^5002622
 ;;^UTILITY(U,$J,358.3,3795,0)
 ;;=E10.65^^19^180^81
 ;;^UTILITY(U,$J,358.3,3795,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3795,1,3,0)
 ;;=3^Diabetes Type 1 w/ Hyperglycemia
 ;;^UTILITY(U,$J,358.3,3795,1,4,0)
 ;;=4^E10.65
 ;;^UTILITY(U,$J,358.3,3795,2)
 ;;=^5002623
 ;;^UTILITY(U,$J,358.3,3796,0)
 ;;=E11.40^^19^180^92
 ;;^UTILITY(U,$J,358.3,3796,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3796,1,3,0)
 ;;=3^Diabetes Type 2 w/ Diabetic Neuropathy,Unspec
 ;;^UTILITY(U,$J,358.3,3796,1,4,0)
 ;;=4^E11.40
 ;;^UTILITY(U,$J,358.3,3796,2)
 ;;=^5002644
 ;;^UTILITY(U,$J,358.3,3797,0)
 ;;=E11.42^^19^180^93
 ;;^UTILITY(U,$J,358.3,3797,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3797,1,3,0)
 ;;=3^Diabetes Type 2 w/ Diabetic Polyneuropathy
 ;;^UTILITY(U,$J,358.3,3797,1,4,0)
 ;;=4^E11.42
 ;;^UTILITY(U,$J,358.3,3797,2)
 ;;=^5002646
 ;;^UTILITY(U,$J,358.3,3798,0)
 ;;=E11.43^^19^180^86
 ;;^UTILITY(U,$J,358.3,3798,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3798,1,3,0)
 ;;=3^Diabetes Type 2 w/ Diab Autonomic Polyneuropathy
 ;;^UTILITY(U,$J,358.3,3798,1,4,0)
 ;;=4^E11.43
 ;;^UTILITY(U,$J,358.3,3798,2)
 ;;=^5002647
 ;;^UTILITY(U,$J,358.3,3799,0)
 ;;=E11.49^^19^180^87
 ;;^UTILITY(U,$J,358.3,3799,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3799,1,3,0)
 ;;=3^Diabetes Type 2 w/ Diab Neurological Complications
 ;;^UTILITY(U,$J,358.3,3799,1,4,0)
 ;;=4^E11.49
 ;;^UTILITY(U,$J,358.3,3799,2)
 ;;=^5002649
 ;;^UTILITY(U,$J,358.3,3800,0)
 ;;=E11.51^^19^180^89
 ;;^UTILITY(U,$J,358.3,3800,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3800,1,3,0)
 ;;=3^Diabetes Type 2 w/ Diab Peripheral Angiopathy w/o Gangrene
 ;;^UTILITY(U,$J,358.3,3800,1,4,0)
 ;;=4^E11.51
 ;;^UTILITY(U,$J,358.3,3800,2)
 ;;=^5002650
 ;;^UTILITY(U,$J,358.3,3801,0)
 ;;=E11.52^^19^180^90
 ;;^UTILITY(U,$J,358.3,3801,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3801,1,3,0)
 ;;=3^Diabetes Type 2 w/ Diab Peripheral Angiopathy w/ Gangrene
 ;;^UTILITY(U,$J,358.3,3801,1,4,0)
 ;;=4^E11.52
 ;;^UTILITY(U,$J,358.3,3801,2)
 ;;=^5002651
 ;;^UTILITY(U,$J,358.3,3802,0)
 ;;=E11.610^^19^180^88
 ;;^UTILITY(U,$J,358.3,3802,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3802,1,3,0)
 ;;=3^Diabetes Type 2 w/ Diab Neuropathic Arthropathy
 ;;^UTILITY(U,$J,358.3,3802,1,4,0)
 ;;=4^E11.610
 ;;^UTILITY(U,$J,358.3,3802,2)
 ;;=^5002653
 ;;^UTILITY(U,$J,358.3,3803,0)
 ;;=E11.620^^19^180^91
 ;;^UTILITY(U,$J,358.3,3803,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3803,1,3,0)
 ;;=3^Diabetes Type 2 w/ Diabetic Dermatitis
 ;;^UTILITY(U,$J,358.3,3803,1,4,0)
 ;;=4^E11.620
 ;;^UTILITY(U,$J,358.3,3803,2)
 ;;=^5002655
 ;;^UTILITY(U,$J,358.3,3804,0)
 ;;=E11.621^^19^180^94
 ;;^UTILITY(U,$J,358.3,3804,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3804,1,3,0)
 ;;=3^Diabetes Type 2 w/ Foot Ulcer
 ;;^UTILITY(U,$J,358.3,3804,1,4,0)
 ;;=4^E11.621
 ;;^UTILITY(U,$J,358.3,3804,2)
 ;;=^5002656
 ;;^UTILITY(U,$J,358.3,3805,0)
 ;;=E11.622^^19^180^99
 ;;^UTILITY(U,$J,358.3,3805,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3805,1,3,0)
 ;;=3^Diabetes Type 2 w/ Skin Ulcer
 ;;^UTILITY(U,$J,358.3,3805,1,4,0)
 ;;=4^E11.622
 ;;^UTILITY(U,$J,358.3,3805,2)
 ;;=^5002657
 ;;^UTILITY(U,$J,358.3,3806,0)
 ;;=E11.630^^19^180^98
 ;;^UTILITY(U,$J,358.3,3806,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3806,1,3,0)
 ;;=3^Diabetes Type 2 w/ Periodontal Disease
 ;;^UTILITY(U,$J,358.3,3806,1,4,0)
 ;;=4^E11.630
 ;;^UTILITY(U,$J,358.3,3806,2)
 ;;=^5002659
 ;;^UTILITY(U,$J,358.3,3807,0)
 ;;=E11.641^^19^180^96
 ;;^UTILITY(U,$J,358.3,3807,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3807,1,3,0)
 ;;=3^Diabetes Type 2 w/ Hypoglycemia w/ Coma
 ;;^UTILITY(U,$J,358.3,3807,1,4,0)
 ;;=4^E11.641
 ;;^UTILITY(U,$J,358.3,3807,2)
 ;;=^5002661
 ;;^UTILITY(U,$J,358.3,3808,0)
 ;;=E11.649^^19^180^97
 ;;^UTILITY(U,$J,358.3,3808,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3808,1,3,0)
 ;;=3^Diabetes Type 2 w/ Hypoglycemia w/o Coma
 ;;^UTILITY(U,$J,358.3,3808,1,4,0)
 ;;=4^E11.649
 ;;^UTILITY(U,$J,358.3,3808,2)
 ;;=^5002662
 ;;^UTILITY(U,$J,358.3,3809,0)
 ;;=E11.65^^19^180^95
 ;;^UTILITY(U,$J,358.3,3809,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3809,1,3,0)
 ;;=3^Diabetes Type 2 w/ Hyperglycemia
 ;;^UTILITY(U,$J,358.3,3809,1,4,0)
 ;;=4^E11.65
 ;;^UTILITY(U,$J,358.3,3809,2)
 ;;=^5002663
 ;;^UTILITY(U,$J,358.3,3810,0)
 ;;=G56.41^^19^180^59
 ;;^UTILITY(U,$J,358.3,3810,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3810,1,3,0)
 ;;=3^Causalgia Rt Upper Limb
