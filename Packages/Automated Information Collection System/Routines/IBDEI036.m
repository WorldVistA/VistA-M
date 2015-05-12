IBDEI036 ; ; 09-FEB-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;OCT 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,3810,1,4,0)
 ;;=4^G56.41
 ;;^UTILITY(U,$J,358.3,3810,2)
 ;;=^5004030
 ;;^UTILITY(U,$J,358.3,3811,0)
 ;;=G56.42^^19^180^58
 ;;^UTILITY(U,$J,358.3,3811,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3811,1,3,0)
 ;;=3^Causalgia Lt Upper Limb
 ;;^UTILITY(U,$J,358.3,3811,1,4,0)
 ;;=4^G56.42
 ;;^UTILITY(U,$J,358.3,3811,2)
 ;;=^5004031
 ;;^UTILITY(U,$J,358.3,3812,0)
 ;;=I65.21^^19^180^124
 ;;^UTILITY(U,$J,358.3,3812,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3812,1,3,0)
 ;;=3^Occlusion & Stenosis Rt Carotid Artery
 ;;^UTILITY(U,$J,358.3,3812,1,4,0)
 ;;=4^I65.21
 ;;^UTILITY(U,$J,358.3,3812,2)
 ;;=^5007360
 ;;^UTILITY(U,$J,358.3,3813,0)
 ;;=I65.22^^19^180^123
 ;;^UTILITY(U,$J,358.3,3813,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3813,1,3,0)
 ;;=3^Occlusion & Stenosis Lt Carotid Artery
 ;;^UTILITY(U,$J,358.3,3813,1,4,0)
 ;;=4^I65.22
 ;;^UTILITY(U,$J,358.3,3813,2)
 ;;=^5007361
 ;;^UTILITY(U,$J,358.3,3814,0)
 ;;=I65.23^^19^180^122
 ;;^UTILITY(U,$J,358.3,3814,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3814,1,3,0)
 ;;=3^Occlusion & Stenosis Bilateral Carotid Arteries
 ;;^UTILITY(U,$J,358.3,3814,1,4,0)
 ;;=4^I65.23
 ;;^UTILITY(U,$J,358.3,3814,2)
 ;;=^5007362
 ;;^UTILITY(U,$J,358.3,3815,0)
 ;;=I63.131^^19^180^66
 ;;^UTILITY(U,$J,358.3,3815,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3815,1,3,0)
 ;;=3^Cerebral Infarc d/t Rt Carotid Artery Embolism
 ;;^UTILITY(U,$J,358.3,3815,1,4,0)
 ;;=4^I63.131
 ;;^UTILITY(U,$J,358.3,3815,2)
 ;;=^5007308
 ;;^UTILITY(U,$J,358.3,3816,0)
 ;;=I63.132^^19^180^64
 ;;^UTILITY(U,$J,358.3,3816,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3816,1,3,0)
 ;;=3^Cerebral Infarc d/t Lt Carotid Artery Embolism
 ;;^UTILITY(U,$J,358.3,3816,1,4,0)
 ;;=4^I63.132
 ;;^UTILITY(U,$J,358.3,3816,2)
 ;;=^5007309
 ;;^UTILITY(U,$J,358.3,3817,0)
 ;;=I63.231^^19^180^67
 ;;^UTILITY(U,$J,358.3,3817,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3817,1,3,0)
 ;;=3^Cerebral Infarc d/t Rt Carotid Artery Occls/Stenosis
 ;;^UTILITY(U,$J,358.3,3817,1,4,0)
 ;;=4^I63.231
 ;;^UTILITY(U,$J,358.3,3817,2)
 ;;=^5007316
 ;;^UTILITY(U,$J,358.3,3818,0)
 ;;=I63.232^^19^180^65
 ;;^UTILITY(U,$J,358.3,3818,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3818,1,3,0)
 ;;=3^Cerebral Infarc d/t Lt Carotid Artery Occls/Stenosis
 ;;^UTILITY(U,$J,358.3,3818,1,4,0)
 ;;=4^I63.232
 ;;^UTILITY(U,$J,358.3,3818,2)
 ;;=^5007317
 ;;^UTILITY(U,$J,358.3,3819,0)
 ;;=I63.9^^19^180^68
 ;;^UTILITY(U,$J,358.3,3819,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3819,1,3,0)
 ;;=3^Cerebral Infarction,Unspec
 ;;^UTILITY(U,$J,358.3,3819,1,4,0)
 ;;=4^I63.9
 ;;^UTILITY(U,$J,358.3,3819,2)
 ;;=^5007355
 ;;^UTILITY(U,$J,358.3,3820,0)
 ;;=I70.211^^19^180^52
 ;;^UTILITY(U,$J,358.3,3820,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3820,1,3,0)
 ;;=3^Athscl of Rt Leg w/ Intrmt Claud
 ;;^UTILITY(U,$J,358.3,3820,1,4,0)
 ;;=4^I70.211
 ;;^UTILITY(U,$J,358.3,3820,2)
 ;;=^5007578
 ;;^UTILITY(U,$J,358.3,3821,0)
 ;;=I70.212^^19^180^45
 ;;^UTILITY(U,$J,358.3,3821,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3821,1,3,0)
 ;;=3^Athscl of Lt Leg w/ Intrmt Claud
 ;;^UTILITY(U,$J,358.3,3821,1,4,0)
 ;;=4^I70.212
 ;;^UTILITY(U,$J,358.3,3821,2)
 ;;=^5007579
 ;;^UTILITY(U,$J,358.3,3822,0)
 ;;=I70.213^^19^180^42
 ;;^UTILITY(U,$J,358.3,3822,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3822,1,3,0)
 ;;=3^Athscl Bilateral Legs w/ Intrmt Claud
 ;;^UTILITY(U,$J,358.3,3822,1,4,0)
 ;;=4^I70.213
 ;;^UTILITY(U,$J,358.3,3822,2)
 ;;=^5007580
 ;;^UTILITY(U,$J,358.3,3823,0)
 ;;=I70.221^^19^180^53
 ;;^UTILITY(U,$J,358.3,3823,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3823,1,3,0)
 ;;=3^Athscl of Rt Leg w/ Rest Pain
 ;;^UTILITY(U,$J,358.3,3823,1,4,0)
 ;;=4^I70.221
 ;;^UTILITY(U,$J,358.3,3823,2)
 ;;=^5007583
 ;;^UTILITY(U,$J,358.3,3824,0)
 ;;=I70.232^^19^180^55
 ;;^UTILITY(U,$J,358.3,3824,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3824,1,3,0)
 ;;=3^Athscl of Rt Leg w/ Ulceration of Calf
 ;;^UTILITY(U,$J,358.3,3824,1,4,0)
 ;;=4^I70.232
 ;;^UTILITY(U,$J,358.3,3824,2)
 ;;=^5007589
 ;;^UTILITY(U,$J,358.3,3825,0)
 ;;=I70.233^^19^180^54
 ;;^UTILITY(U,$J,358.3,3825,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3825,1,3,0)
 ;;=3^Athscl of Rt Leg w/ Ulceration of Ankle
 ;;^UTILITY(U,$J,358.3,3825,1,4,0)
 ;;=4^I70.233
 ;;^UTILITY(U,$J,358.3,3825,2)
 ;;=^5007590
 ;;^UTILITY(U,$J,358.3,3826,0)
 ;;=I70.234^^19^180^56
 ;;^UTILITY(U,$J,358.3,3826,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3826,1,3,0)
 ;;=3^Athscl of Rt Leg w/ Ulceration of Heel & Midfoot
 ;;^UTILITY(U,$J,358.3,3826,1,4,0)
 ;;=4^I70.234
 ;;^UTILITY(U,$J,358.3,3826,2)
 ;;=^5007591
 ;;^UTILITY(U,$J,358.3,3827,0)
 ;;=I70.235^^19^180^57
 ;;^UTILITY(U,$J,358.3,3827,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3827,1,3,0)
 ;;=3^Athscl of Rt Leg w/ Ulceration of Oth Part of Foot
 ;;^UTILITY(U,$J,358.3,3827,1,4,0)
 ;;=4^I70.235
 ;;^UTILITY(U,$J,358.3,3827,2)
 ;;=^5007592
 ;;^UTILITY(U,$J,358.3,3828,0)
 ;;=I70.261^^19^180^51
 ;;^UTILITY(U,$J,358.3,3828,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3828,1,3,0)
 ;;=3^Athscl of Rt Leg w/ Gangrene
 ;;^UTILITY(U,$J,358.3,3828,1,4,0)
 ;;=4^I70.261
 ;;^UTILITY(U,$J,358.3,3828,2)
 ;;=^5007603
 ;;^UTILITY(U,$J,358.3,3829,0)
 ;;=I70.241^^19^180^50
 ;;^UTILITY(U,$J,358.3,3829,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3829,1,3,0)
 ;;=3^Athscl of Lt Leg w/ Ulceration of Thigh
 ;;^UTILITY(U,$J,358.3,3829,1,4,0)
 ;;=4^I70.241
 ;;^UTILITY(U,$J,358.3,3829,2)
 ;;=^5007595
 ;;^UTILITY(U,$J,358.3,3830,0)
 ;;=I70.242^^19^180^47
 ;;^UTILITY(U,$J,358.3,3830,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3830,1,3,0)
 ;;=3^Athscl of Lt Leg w/ Ulceration of Calf
 ;;^UTILITY(U,$J,358.3,3830,1,4,0)
 ;;=4^I70.242
 ;;^UTILITY(U,$J,358.3,3830,2)
 ;;=^5007596
 ;;^UTILITY(U,$J,358.3,3831,0)
 ;;=I70.243^^19^180^46
 ;;^UTILITY(U,$J,358.3,3831,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3831,1,3,0)
 ;;=3^Athscl of Lt Leg w/ Ulceration of Ankle
 ;;^UTILITY(U,$J,358.3,3831,1,4,0)
 ;;=4^I70.243
 ;;^UTILITY(U,$J,358.3,3831,2)
 ;;=^5007597
 ;;^UTILITY(U,$J,358.3,3832,0)
 ;;=I70.244^^19^180^48
 ;;^UTILITY(U,$J,358.3,3832,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3832,1,3,0)
 ;;=3^Athscl of Lt Leg w/ Ulceration of Heel & Midfoot
 ;;^UTILITY(U,$J,358.3,3832,1,4,0)
 ;;=4^I70.244
 ;;^UTILITY(U,$J,358.3,3832,2)
 ;;=^5007598
 ;;^UTILITY(U,$J,358.3,3833,0)
 ;;=I70.245^^19^180^49
 ;;^UTILITY(U,$J,358.3,3833,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3833,1,3,0)
 ;;=3^Athscl of Lt Leg w/ Ulceration of Oth Part of Foot
 ;;^UTILITY(U,$J,358.3,3833,1,4,0)
 ;;=4^I70.245
 ;;^UTILITY(U,$J,358.3,3833,2)
 ;;=^5007599
 ;;^UTILITY(U,$J,358.3,3834,0)
 ;;=I70.262^^19^180^44
 ;;^UTILITY(U,$J,358.3,3834,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3834,1,3,0)
 ;;=3^Athscl of Lt Leg w/ Gangrene
 ;;^UTILITY(U,$J,358.3,3834,1,4,0)
 ;;=4^I70.262
 ;;^UTILITY(U,$J,358.3,3834,2)
 ;;=^5007604
 ;;^UTILITY(U,$J,358.3,3835,0)
 ;;=I70.263^^19^180^43
 ;;^UTILITY(U,$J,358.3,3835,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3835,1,3,0)
 ;;=3^Athscl of Bilateral Legs w/ Gangrene
 ;;^UTILITY(U,$J,358.3,3835,1,4,0)
 ;;=4^I70.263
 ;;^UTILITY(U,$J,358.3,3835,2)
 ;;=^5007605
 ;;^UTILITY(U,$J,358.3,3836,0)
 ;;=I71.2^^19^180^137
 ;;^UTILITY(U,$J,358.3,3836,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3836,1,3,0)
 ;;=3^Thoracic Aortic Aneurysm w/o Rupture
 ;;^UTILITY(U,$J,358.3,3836,1,4,0)
 ;;=4^I71.2
 ;;^UTILITY(U,$J,358.3,3836,2)
 ;;=^5007787
 ;;^UTILITY(U,$J,358.3,3837,0)
 ;;=I71.3^^19^180^33
 ;;^UTILITY(U,$J,358.3,3837,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3837,1,3,0)
 ;;=3^Abdominal Aortic Aneurysm w/ Rupture
 ;;^UTILITY(U,$J,358.3,3837,1,4,0)
 ;;=4^I71.3
 ;;^UTILITY(U,$J,358.3,3837,2)
 ;;=^5007788
 ;;^UTILITY(U,$J,358.3,3838,0)
 ;;=I71.4^^19^180^34
 ;;^UTILITY(U,$J,358.3,3838,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3838,1,3,0)
 ;;=3^Abdominal Aortic Aneurysm w/o Rupture
 ;;^UTILITY(U,$J,358.3,3838,1,4,0)
 ;;=4^I71.4
 ;;^UTILITY(U,$J,358.3,3838,2)
 ;;=^5007789
 ;;^UTILITY(U,$J,358.3,3839,0)
 ;;=I71.5^^19^180^138
 ;;^UTILITY(U,$J,358.3,3839,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3839,1,3,0)
 ;;=3^Thoracoabdominal Aortic Aneurysm w/ Rupture
 ;;^UTILITY(U,$J,358.3,3839,1,4,0)
 ;;=4^I71.5
 ;;^UTILITY(U,$J,358.3,3839,2)
 ;;=^5007790
 ;;^UTILITY(U,$J,358.3,3840,0)
 ;;=I71.6^^19^180^139
 ;;^UTILITY(U,$J,358.3,3840,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3840,1,3,0)
 ;;=3^Thoracoabdominal Aortic Aneurysm w/o Rupture
 ;;^UTILITY(U,$J,358.3,3840,1,4,0)
 ;;=4^I71.6
 ;;^UTILITY(U,$J,358.3,3840,2)
 ;;=^5007791
 ;;^UTILITY(U,$J,358.3,3841,0)
 ;;=I72.2^^19^180^38
 ;;^UTILITY(U,$J,358.3,3841,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3841,1,3,0)
 ;;=3^Aneurysm of Renal Artery
 ;;^UTILITY(U,$J,358.3,3841,1,4,0)
 ;;=4^I72.2
 ;;^UTILITY(U,$J,358.3,3841,2)
 ;;=^269773
 ;;^UTILITY(U,$J,358.3,3842,0)
 ;;=I72.3^^19^180^36
 ;;^UTILITY(U,$J,358.3,3842,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3842,1,3,0)
 ;;=3^Aneurysm of Iliac Artery
 ;;^UTILITY(U,$J,358.3,3842,1,4,0)
 ;;=4^I72.3
 ;;^UTILITY(U,$J,358.3,3842,2)
 ;;=^269775
 ;;^UTILITY(U,$J,358.3,3843,0)
 ;;=I72.4^^19^180^37
 ;;^UTILITY(U,$J,358.3,3843,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3843,1,3,0)
 ;;=3^Aneurysm of Lower Extremity Artery
 ;;^UTILITY(U,$J,358.3,3843,1,4,0)
 ;;=4^I72.4
 ;;^UTILITY(U,$J,358.3,3843,2)
 ;;=^269777
 ;;^UTILITY(U,$J,358.3,3844,0)
 ;;=I72.0^^19^180^35
 ;;^UTILITY(U,$J,358.3,3844,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3844,1,3,0)
 ;;=3^Aneurysm of Carotid Artery
 ;;^UTILITY(U,$J,358.3,3844,1,4,0)
 ;;=4^I72.0
 ;;^UTILITY(U,$J,358.3,3844,2)
 ;;=^5007793
 ;;^UTILITY(U,$J,358.3,3845,0)
 ;;=I73.00^^19^180^135
 ;;^UTILITY(U,$J,358.3,3845,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3845,1,3,0)
 ;;=3^Raynaud's Syndrome w/o Gangrene
 ;;^UTILITY(U,$J,358.3,3845,1,4,0)
 ;;=4^I73.00
 ;;^UTILITY(U,$J,358.3,3845,2)
 ;;=^5007796
 ;;^UTILITY(U,$J,358.3,3846,0)
 ;;=I73.9^^19^180^125
