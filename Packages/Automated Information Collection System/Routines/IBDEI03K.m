IBDEI03K ; ; 09-AUG-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,4226,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4226,1,3,0)
 ;;=3^Pleurisy
 ;;^UTILITY(U,$J,358.3,4226,1,4,0)
 ;;=4^R09.1
 ;;^UTILITY(U,$J,358.3,4226,2)
 ;;=^95428
 ;;^UTILITY(U,$J,358.3,4227,0)
 ;;=J84.17^^20^279^19
 ;;^UTILITY(U,$J,358.3,4227,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4227,1,3,0)
 ;;=3^Interstitial Pulmonary Disease w/ Fibrosis NEC
 ;;^UTILITY(U,$J,358.3,4227,1,4,0)
 ;;=4^J84.17
 ;;^UTILITY(U,$J,358.3,4227,2)
 ;;=^5008301
 ;;^UTILITY(U,$J,358.3,4228,0)
 ;;=J98.4^^20^279^20
 ;;^UTILITY(U,$J,358.3,4228,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4228,1,3,0)
 ;;=3^Lung Disorders NEC
 ;;^UTILITY(U,$J,358.3,4228,1,4,0)
 ;;=4^J98.4
 ;;^UTILITY(U,$J,358.3,4228,2)
 ;;=^5008362
 ;;^UTILITY(U,$J,358.3,4229,0)
 ;;=G47.30^^20^279^26
 ;;^UTILITY(U,$J,358.3,4229,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4229,1,3,0)
 ;;=3^Sleep Apnea,Unspec
 ;;^UTILITY(U,$J,358.3,4229,1,4,0)
 ;;=4^G47.30
 ;;^UTILITY(U,$J,358.3,4229,2)
 ;;=^5003977
 ;;^UTILITY(U,$J,358.3,4230,0)
 ;;=R06.02^^20^279^25
 ;;^UTILITY(U,$J,358.3,4230,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4230,1,3,0)
 ;;=3^Shortness of Breath
 ;;^UTILITY(U,$J,358.3,4230,1,4,0)
 ;;=4^R06.02
 ;;^UTILITY(U,$J,358.3,4230,2)
 ;;=^5019181
 ;;^UTILITY(U,$J,358.3,4231,0)
 ;;=R06.83^^20^279^27
 ;;^UTILITY(U,$J,358.3,4231,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4231,1,3,0)
 ;;=3^Snoring
 ;;^UTILITY(U,$J,358.3,4231,1,4,0)
 ;;=4^R06.83
 ;;^UTILITY(U,$J,358.3,4231,2)
 ;;=^5019192
 ;;^UTILITY(U,$J,358.3,4232,0)
 ;;=R06.00^^20^279^18
 ;;^UTILITY(U,$J,358.3,4232,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4232,1,3,0)
 ;;=3^Dyspnea,Unspec
 ;;^UTILITY(U,$J,358.3,4232,1,4,0)
 ;;=4^R06.00
 ;;^UTILITY(U,$J,358.3,4232,2)
 ;;=^5019180
 ;;^UTILITY(U,$J,358.3,4233,0)
 ;;=R06.09^^20^279^17
 ;;^UTILITY(U,$J,358.3,4233,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4233,1,3,0)
 ;;=3^Dyspnea NEC
 ;;^UTILITY(U,$J,358.3,4233,1,4,0)
 ;;=4^R06.09
 ;;^UTILITY(U,$J,358.3,4233,2)
 ;;=^5019182
 ;;^UTILITY(U,$J,358.3,4234,0)
 ;;=R06.89^^20^279^14
 ;;^UTILITY(U,$J,358.3,4234,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4234,1,3,0)
 ;;=3^Breathing Abnormalities NEC
 ;;^UTILITY(U,$J,358.3,4234,1,4,0)
 ;;=4^R06.89
 ;;^UTILITY(U,$J,358.3,4234,2)
 ;;=^5019193
 ;;^UTILITY(U,$J,358.3,4235,0)
 ;;=R22.2^^20^279^29
 ;;^UTILITY(U,$J,358.3,4235,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4235,1,3,0)
 ;;=3^Swelling/Mass/Lump,Trunk,Localized
 ;;^UTILITY(U,$J,358.3,4235,1,4,0)
 ;;=4^R22.2
 ;;^UTILITY(U,$J,358.3,4235,2)
 ;;=^5019286
 ;;^UTILITY(U,$J,358.3,4236,0)
 ;;=R91.8^^20^279^1
 ;;^UTILITY(U,$J,358.3,4236,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4236,1,3,0)
 ;;=3^Abnormal Finding of Lung Field
 ;;^UTILITY(U,$J,358.3,4236,1,4,0)
 ;;=4^R91.8
 ;;^UTILITY(U,$J,358.3,4236,2)
 ;;=^5019708
 ;;^UTILITY(U,$J,358.3,4237,0)
 ;;=R91.1^^20^279^28
 ;;^UTILITY(U,$J,358.3,4237,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4237,1,3,0)
 ;;=3^Solitary Pulmonary Nodule
 ;;^UTILITY(U,$J,358.3,4237,1,4,0)
 ;;=4^R91.1
 ;;^UTILITY(U,$J,358.3,4237,2)
 ;;=^5019707
 ;;^UTILITY(U,$J,358.3,4238,0)
 ;;=L98.9^^20^280^1
 ;;^UTILITY(U,$J,358.3,4238,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4238,1,3,0)
 ;;=3^Skin/Subcutaneous Tissue Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,4238,1,4,0)
 ;;=4^L98.9
 ;;^UTILITY(U,$J,358.3,4238,2)
 ;;=^5009595
 ;;^UTILITY(U,$J,358.3,4239,0)
 ;;=M65.351^^20^280^8
 ;;^UTILITY(U,$J,358.3,4239,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4239,1,3,0)
 ;;=3^Trigger Finger,Right Little Finger
 ;;^UTILITY(U,$J,358.3,4239,1,4,0)
 ;;=4^M65.351
 ;;^UTILITY(U,$J,358.3,4239,2)
 ;;=^5012789
 ;;^UTILITY(U,$J,358.3,4240,0)
 ;;=M65.352^^20^280^3
 ;;^UTILITY(U,$J,358.3,4240,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4240,1,3,0)
 ;;=3^Trigger Finger,Left Little Finger
 ;;^UTILITY(U,$J,358.3,4240,1,4,0)
 ;;=4^M65.352
 ;;^UTILITY(U,$J,358.3,4240,2)
 ;;=^5012790
 ;;^UTILITY(U,$J,358.3,4241,0)
 ;;=M65.341^^20^280^10
 ;;^UTILITY(U,$J,358.3,4241,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4241,1,3,0)
 ;;=3^Trigger Finger,Right Ring Finger
 ;;^UTILITY(U,$J,358.3,4241,1,4,0)
 ;;=4^M65.341
 ;;^UTILITY(U,$J,358.3,4241,2)
 ;;=^5012786
 ;;^UTILITY(U,$J,358.3,4242,0)
 ;;=M65.342^^20^280^5
 ;;^UTILITY(U,$J,358.3,4242,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4242,1,3,0)
 ;;=3^Trigger Finger,Left Ring Finger
 ;;^UTILITY(U,$J,358.3,4242,1,4,0)
 ;;=4^M65.342
 ;;^UTILITY(U,$J,358.3,4242,2)
 ;;=^5012787
 ;;^UTILITY(U,$J,358.3,4243,0)
 ;;=M65.332^^20^280^4
 ;;^UTILITY(U,$J,358.3,4243,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4243,1,3,0)
 ;;=3^Trigger Finger,Left Middle Finger
 ;;^UTILITY(U,$J,358.3,4243,1,4,0)
 ;;=4^M65.332
 ;;^UTILITY(U,$J,358.3,4243,2)
 ;;=^5012784
 ;;^UTILITY(U,$J,358.3,4244,0)
 ;;=M65.322^^20^280^2
 ;;^UTILITY(U,$J,358.3,4244,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4244,1,3,0)
 ;;=3^Trigger Finger,Left Index Finger
 ;;^UTILITY(U,$J,358.3,4244,1,4,0)
 ;;=4^M65.322
 ;;^UTILITY(U,$J,358.3,4244,2)
 ;;=^5012781
 ;;^UTILITY(U,$J,358.3,4245,0)
 ;;=M65.331^^20^280^9
 ;;^UTILITY(U,$J,358.3,4245,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4245,1,3,0)
 ;;=3^Trigger Finger,Right Middle Finger
 ;;^UTILITY(U,$J,358.3,4245,1,4,0)
 ;;=4^M65.331
 ;;^UTILITY(U,$J,358.3,4245,2)
 ;;=^5012783
 ;;^UTILITY(U,$J,358.3,4246,0)
 ;;=M65.321^^20^280^7
 ;;^UTILITY(U,$J,358.3,4246,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4246,1,3,0)
 ;;=3^Trigger Finger,Right Index Finger
 ;;^UTILITY(U,$J,358.3,4246,1,4,0)
 ;;=4^M65.321
 ;;^UTILITY(U,$J,358.3,4246,2)
 ;;=^5012780
 ;;^UTILITY(U,$J,358.3,4247,0)
 ;;=M65.312^^20^280^6
 ;;^UTILITY(U,$J,358.3,4247,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4247,1,3,0)
 ;;=3^Trigger Finger,Left Thumb
 ;;^UTILITY(U,$J,358.3,4247,1,4,0)
 ;;=4^M65.312
 ;;^UTILITY(U,$J,358.3,4247,2)
 ;;=^5012778
 ;;^UTILITY(U,$J,358.3,4248,0)
 ;;=M65.311^^20^280^11
 ;;^UTILITY(U,$J,358.3,4248,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4248,1,3,0)
 ;;=3^Trigger Finger,Right Thumb
 ;;^UTILITY(U,$J,358.3,4248,1,4,0)
 ;;=4^M65.311
 ;;^UTILITY(U,$J,358.3,4248,2)
 ;;=^5012777
 ;;^UTILITY(U,$J,358.3,4249,0)
 ;;=E08.621^^20^281^86
 ;;^UTILITY(U,$J,358.3,4249,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4249,1,3,0)
 ;;=3^Diabetes d/t Underlying Condition w/ Foot Ulcer
 ;;^UTILITY(U,$J,358.3,4249,1,4,0)
 ;;=4^E08.621
 ;;^UTILITY(U,$J,358.3,4249,2)
 ;;=^5002534
 ;;^UTILITY(U,$J,358.3,4250,0)
 ;;=E09.621^^20^281^85
 ;;^UTILITY(U,$J,358.3,4250,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4250,1,3,0)
 ;;=3^Diabetes d/t Drug/Chemical Induced w/ Foot Ulcer
 ;;^UTILITY(U,$J,358.3,4250,1,4,0)
 ;;=4^E09.621
 ;;^UTILITY(U,$J,358.3,4250,2)
 ;;=^5002576
 ;;^UTILITY(U,$J,358.3,4251,0)
 ;;=I70.231^^20^281^22
 ;;^UTILITY(U,$J,358.3,4251,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4251,1,3,0)
 ;;=3^Athscl Native Arteries of Right Leg w/ Thigh Ulcer
 ;;^UTILITY(U,$J,358.3,4251,1,4,0)
 ;;=4^I70.231
 ;;^UTILITY(U,$J,358.3,4251,2)
 ;;=^5007588
 ;;^UTILITY(U,$J,358.3,4252,0)
 ;;=I70.232^^20^281^23
 ;;^UTILITY(U,$J,358.3,4252,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4252,1,3,0)
 ;;=3^Athscl Native Arteries of Right Leg w/ Calf Ulcer
 ;;^UTILITY(U,$J,358.3,4252,1,4,0)
 ;;=4^I70.232
 ;;^UTILITY(U,$J,358.3,4252,2)
 ;;=^5007589
 ;;^UTILITY(U,$J,358.3,4253,0)
 ;;=I70.233^^20^281^24
 ;;^UTILITY(U,$J,358.3,4253,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4253,1,3,0)
 ;;=3^Athscl Native Arteries of Right Leg w/ Ankle Ulcer
 ;;^UTILITY(U,$J,358.3,4253,1,4,0)
 ;;=4^I70.233
 ;;^UTILITY(U,$J,358.3,4253,2)
 ;;=^5007590
 ;;^UTILITY(U,$J,358.3,4254,0)
 ;;=I70.234^^20^281^25
 ;;^UTILITY(U,$J,358.3,4254,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4254,1,3,0)
 ;;=3^Athscl Native Arteries of Right Leg w/ Heel/Midfoot Ulcer
 ;;^UTILITY(U,$J,358.3,4254,1,4,0)
 ;;=4^I70.234
 ;;^UTILITY(U,$J,358.3,4254,2)
 ;;=^5007591
 ;;^UTILITY(U,$J,358.3,4255,0)
 ;;=I70.235^^20^281^26
 ;;^UTILITY(U,$J,358.3,4255,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4255,1,3,0)
 ;;=3^Athscl Native Arteries of Right Leg w/ Foot Ulcer
 ;;^UTILITY(U,$J,358.3,4255,1,4,0)
 ;;=4^I70.235
 ;;^UTILITY(U,$J,358.3,4255,2)
 ;;=^5007592
 ;;^UTILITY(U,$J,358.3,4256,0)
 ;;=I70.238^^20^281^27
 ;;^UTILITY(U,$J,358.3,4256,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4256,1,3,0)
 ;;=3^Athscl Native Arteries of Right Leg w/ Lower Leg Ulcer
 ;;^UTILITY(U,$J,358.3,4256,1,4,0)
 ;;=4^I70.238
 ;;^UTILITY(U,$J,358.3,4256,2)
 ;;=^5007593
 ;;^UTILITY(U,$J,358.3,4257,0)
 ;;=I70.239^^20^281^28
 ;;^UTILITY(U,$J,358.3,4257,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4257,1,3,0)
 ;;=3^Athscl Native Arteries of Right Leg w/ Ulcer,Unspec Site
 ;;^UTILITY(U,$J,358.3,4257,1,4,0)
 ;;=4^I70.239
 ;;^UTILITY(U,$J,358.3,4257,2)
 ;;=^5007594
 ;;^UTILITY(U,$J,358.3,4258,0)
 ;;=I70.241^^20^281^20
 ;;^UTILITY(U,$J,358.3,4258,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4258,1,3,0)
 ;;=3^Athscl Native Arteries of Left Leg w/ Thigh Ulcer
 ;;^UTILITY(U,$J,358.3,4258,1,4,0)
 ;;=4^I70.241
 ;;^UTILITY(U,$J,358.3,4258,2)
 ;;=^5007595
 ;;^UTILITY(U,$J,358.3,4259,0)
 ;;=I70.242^^20^281^16
 ;;^UTILITY(U,$J,358.3,4259,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4259,1,3,0)
 ;;=3^Athscl Native Arteries of Left Leg w/ Calf Ulcer
 ;;^UTILITY(U,$J,358.3,4259,1,4,0)
 ;;=4^I70.242
 ;;^UTILITY(U,$J,358.3,4259,2)
 ;;=^5007596
 ;;^UTILITY(U,$J,358.3,4260,0)
 ;;=I70.243^^20^281^15
 ;;^UTILITY(U,$J,358.3,4260,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4260,1,3,0)
 ;;=3^Athscl Native Arteries of Left Leg w/ Ankle Ulcer
 ;;^UTILITY(U,$J,358.3,4260,1,4,0)
 ;;=4^I70.243
 ;;^UTILITY(U,$J,358.3,4260,2)
 ;;=^5007597
 ;;^UTILITY(U,$J,358.3,4261,0)
 ;;=I70.244^^20^281^18
 ;;^UTILITY(U,$J,358.3,4261,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4261,1,3,0)
 ;;=3^Athscl Native Arteries of Left Leg w/ Heel/Midfoot Ulcer
 ;;^UTILITY(U,$J,358.3,4261,1,4,0)
 ;;=4^I70.244
 ;;^UTILITY(U,$J,358.3,4261,2)
 ;;=^5007598
