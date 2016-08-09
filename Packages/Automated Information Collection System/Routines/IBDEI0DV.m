IBDEI0DV ; ; 12-MAY-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,13865,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13865,1,3,0)
 ;;=3^Herpesviral Infection,Unspec
 ;;^UTILITY(U,$J,358.3,13865,1,4,0)
 ;;=4^B00.9
 ;;^UTILITY(U,$J,358.3,13865,2)
 ;;=^5000480
 ;;^UTILITY(U,$J,358.3,13866,0)
 ;;=B02.9^^61^729^291
 ;;^UTILITY(U,$J,358.3,13866,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13866,1,3,0)
 ;;=3^Zoster w/o Complications
 ;;^UTILITY(U,$J,358.3,13866,1,4,0)
 ;;=4^B02.9
 ;;^UTILITY(U,$J,358.3,13866,2)
 ;;=^5000501
 ;;^UTILITY(U,$J,358.3,13867,0)
 ;;=D17.9^^61^729^89
 ;;^UTILITY(U,$J,358.3,13867,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13867,1,3,0)
 ;;=3^Benign Lipomatous Neop,Unspec
 ;;^UTILITY(U,$J,358.3,13867,1,4,0)
 ;;=4^D17.9
 ;;^UTILITY(U,$J,358.3,13867,2)
 ;;=^5002020
 ;;^UTILITY(U,$J,358.3,13868,0)
 ;;=E08.621^^61^729^134
 ;;^UTILITY(U,$J,358.3,13868,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13868,1,3,0)
 ;;=3^DM d/t Underlying Condition w/ Foot Ulcer
 ;;^UTILITY(U,$J,358.3,13868,1,4,0)
 ;;=4^E08.621
 ;;^UTILITY(U,$J,358.3,13868,2)
 ;;=^5002534
 ;;^UTILITY(U,$J,358.3,13869,0)
 ;;=E09.621^^61^729^133
 ;;^UTILITY(U,$J,358.3,13869,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13869,1,3,0)
 ;;=3^DM d/t Drug/Chemical w/ Foot Ulcer
 ;;^UTILITY(U,$J,358.3,13869,1,4,0)
 ;;=4^E09.621
 ;;^UTILITY(U,$J,358.3,13869,2)
 ;;=^5002576
 ;;^UTILITY(U,$J,358.3,13870,0)
 ;;=H05.011^^61^729^110
 ;;^UTILITY(U,$J,358.3,13870,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13870,1,3,0)
 ;;=3^Cellulitis of Right Orbit
 ;;^UTILITY(U,$J,358.3,13870,1,4,0)
 ;;=4^H05.011
 ;;^UTILITY(U,$J,358.3,13870,2)
 ;;=^5004560
 ;;^UTILITY(U,$J,358.3,13871,0)
 ;;=H05.012^^61^729^103
 ;;^UTILITY(U,$J,358.3,13871,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13871,1,3,0)
 ;;=3^Cellulitis of Left Orbit
 ;;^UTILITY(U,$J,358.3,13871,1,4,0)
 ;;=4^H05.012
 ;;^UTILITY(U,$J,358.3,13871,2)
 ;;=^5004561
 ;;^UTILITY(U,$J,358.3,13872,0)
 ;;=H05.013^^61^729^97
 ;;^UTILITY(U,$J,358.3,13872,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13872,1,3,0)
 ;;=3^Cellulitis of Bilateral Orbits
 ;;^UTILITY(U,$J,358.3,13872,1,4,0)
 ;;=4^H05.013
 ;;^UTILITY(U,$J,358.3,13872,2)
 ;;=^5004562
 ;;^UTILITY(U,$J,358.3,13873,0)
 ;;=I70.331^^61^729^50
 ;;^UTILITY(U,$J,358.3,13873,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13873,1,3,0)
 ;;=3^Athscl Bypass of Right Leg w/ Ulcer of Thigh
 ;;^UTILITY(U,$J,358.3,13873,1,4,0)
 ;;=4^I70.331
 ;;^UTILITY(U,$J,358.3,13873,2)
 ;;=^5007626
 ;;^UTILITY(U,$J,358.3,13874,0)
 ;;=I70.332^^61^729^51
 ;;^UTILITY(U,$J,358.3,13874,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13874,1,3,0)
 ;;=3^Athscl Bypass of Right Leg w/ Ulcer of Calf
 ;;^UTILITY(U,$J,358.3,13874,1,4,0)
 ;;=4^I70.332
 ;;^UTILITY(U,$J,358.3,13874,2)
 ;;=^5007627
 ;;^UTILITY(U,$J,358.3,13875,0)
 ;;=I70.333^^61^729^52
 ;;^UTILITY(U,$J,358.3,13875,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13875,1,3,0)
 ;;=3^Athscl Bypass of Right Leg w/ Ulcer of Ankle
 ;;^UTILITY(U,$J,358.3,13875,1,4,0)
 ;;=4^I70.333
 ;;^UTILITY(U,$J,358.3,13875,2)
 ;;=^5007628
 ;;^UTILITY(U,$J,358.3,13876,0)
 ;;=I70.334^^61^729^53
 ;;^UTILITY(U,$J,358.3,13876,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13876,1,3,0)
 ;;=3^Athscl Bypass of Right Leg w/ Ulcer of Heel/Midfoot
 ;;^UTILITY(U,$J,358.3,13876,1,4,0)
 ;;=4^I70.334
 ;;^UTILITY(U,$J,358.3,13876,2)
 ;;=^5007629
 ;;^UTILITY(U,$J,358.3,13877,0)
 ;;=I70.335^^61^729^54
 ;;^UTILITY(U,$J,358.3,13877,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13877,1,3,0)
 ;;=3^Athscl Bypass of Right Leg w/ Ulcer of Oth Part of Foot
 ;;^UTILITY(U,$J,358.3,13877,1,4,0)
 ;;=4^I70.335
 ;;^UTILITY(U,$J,358.3,13877,2)
 ;;=^5007630
 ;;^UTILITY(U,$J,358.3,13878,0)
 ;;=I70.341^^61^729^49
 ;;^UTILITY(U,$J,358.3,13878,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13878,1,3,0)
 ;;=3^Athscl Bypass of Left Leg w/ Ulcer of Thigh
 ;;^UTILITY(U,$J,358.3,13878,1,4,0)
 ;;=4^I70.341
 ;;^UTILITY(U,$J,358.3,13878,2)
 ;;=^5007633
 ;;^UTILITY(U,$J,358.3,13879,0)
 ;;=I70.342^^61^729^46
 ;;^UTILITY(U,$J,358.3,13879,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13879,1,3,0)
 ;;=3^Athscl Bypass of Left Leg w/ Ulcer of Calf
 ;;^UTILITY(U,$J,358.3,13879,1,4,0)
 ;;=4^I70.342
 ;;^UTILITY(U,$J,358.3,13879,2)
 ;;=^5007634
 ;;^UTILITY(U,$J,358.3,13880,0)
 ;;=I70.343^^61^729^45
 ;;^UTILITY(U,$J,358.3,13880,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13880,1,3,0)
 ;;=3^Athscl Bypass of Left Leg w/ Ulcer of Ankle
 ;;^UTILITY(U,$J,358.3,13880,1,4,0)
 ;;=4^I70.343
 ;;^UTILITY(U,$J,358.3,13880,2)
 ;;=^5007635
 ;;^UTILITY(U,$J,358.3,13881,0)
 ;;=I70.344^^61^729^47
 ;;^UTILITY(U,$J,358.3,13881,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13881,1,3,0)
 ;;=3^Athscl Bypass of Left Leg w/ Ulcer of Heel/Midfoot
 ;;^UTILITY(U,$J,358.3,13881,1,4,0)
 ;;=4^I70.344
 ;;^UTILITY(U,$J,358.3,13881,2)
 ;;=^5007636
 ;;^UTILITY(U,$J,358.3,13882,0)
 ;;=I70.345^^61^729^48
 ;;^UTILITY(U,$J,358.3,13882,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13882,1,3,0)
 ;;=3^Athscl Bypass of Left Leg w/ Ulcer of Oth Part of Foot
 ;;^UTILITY(U,$J,358.3,13882,1,4,0)
 ;;=4^I70.345
 ;;^UTILITY(U,$J,358.3,13882,2)
 ;;=^5007637
 ;;^UTILITY(U,$J,358.3,13883,0)
 ;;=I70.431^^61^729^40
 ;;^UTILITY(U,$J,358.3,13883,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13883,1,3,0)
 ;;=3^Athscl Autol Vein Bypass of Right Leg w/ Ulcer of Thigh
 ;;^UTILITY(U,$J,358.3,13883,1,4,0)
 ;;=4^I70.431
 ;;^UTILITY(U,$J,358.3,13883,2)
 ;;=^5007664
 ;;^UTILITY(U,$J,358.3,13884,0)
 ;;=I70.432^^61^729^41
 ;;^UTILITY(U,$J,358.3,13884,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13884,1,3,0)
 ;;=3^Athscl Autol Vein Bypass of Right Leg w/ Ulcer of Calf
 ;;^UTILITY(U,$J,358.3,13884,1,4,0)
 ;;=4^I70.432
 ;;^UTILITY(U,$J,358.3,13884,2)
 ;;=^5007665
 ;;^UTILITY(U,$J,358.3,13885,0)
 ;;=I70.433^^61^729^42
 ;;^UTILITY(U,$J,358.3,13885,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13885,1,3,0)
 ;;=3^Athscl Autol Vein Bypass of Right Leg w/ Ulcer of Ankle
 ;;^UTILITY(U,$J,358.3,13885,1,4,0)
 ;;=4^I70.433
 ;;^UTILITY(U,$J,358.3,13885,2)
 ;;=^5007666
 ;;^UTILITY(U,$J,358.3,13886,0)
 ;;=I70.434^^61^729^43
 ;;^UTILITY(U,$J,358.3,13886,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13886,1,3,0)
 ;;=3^Athscl Autol Vein Bypass of Right Leg w/ Ulcer of Heel/Midfoot
 ;;^UTILITY(U,$J,358.3,13886,1,4,0)
 ;;=4^I70.434
 ;;^UTILITY(U,$J,358.3,13886,2)
 ;;=^5007667
 ;;^UTILITY(U,$J,358.3,13887,0)
 ;;=I70.435^^61^729^44
 ;;^UTILITY(U,$J,358.3,13887,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13887,1,3,0)
 ;;=3^Athscl Autol Vein Bypass of Right Leg w/ Ulcer of Oth Part of Foot
 ;;^UTILITY(U,$J,358.3,13887,1,4,0)
 ;;=4^I70.435
 ;;^UTILITY(U,$J,358.3,13887,2)
 ;;=^5007668
 ;;^UTILITY(U,$J,358.3,13888,0)
 ;;=I70.441^^61^729^35
 ;;^UTILITY(U,$J,358.3,13888,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13888,1,3,0)
 ;;=3^Athscl Autol Vein Bypass of Left Leg w/ Ulcer of Thigh
 ;;^UTILITY(U,$J,358.3,13888,1,4,0)
 ;;=4^I70.441
 ;;^UTILITY(U,$J,358.3,13888,2)
 ;;=^5007671
 ;;^UTILITY(U,$J,358.3,13889,0)
 ;;=I70.442^^61^729^36
 ;;^UTILITY(U,$J,358.3,13889,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13889,1,3,0)
 ;;=3^Athscl Autol Vein Bypass of Left Leg w/ Ulcer of Calf
 ;;^UTILITY(U,$J,358.3,13889,1,4,0)
 ;;=4^I70.442
 ;;^UTILITY(U,$J,358.3,13889,2)
 ;;=^5007672
 ;;^UTILITY(U,$J,358.3,13890,0)
 ;;=I70.443^^61^729^37
 ;;^UTILITY(U,$J,358.3,13890,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13890,1,3,0)
 ;;=3^Athscl Autol Vein Bypass of Left Leg w/ Ulcer of Ankle
 ;;^UTILITY(U,$J,358.3,13890,1,4,0)
 ;;=4^I70.443
 ;;^UTILITY(U,$J,358.3,13890,2)
 ;;=^5007673
 ;;^UTILITY(U,$J,358.3,13891,0)
 ;;=I70.444^^61^729^38
 ;;^UTILITY(U,$J,358.3,13891,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13891,1,3,0)
 ;;=3^Athscl Autol Vein Bypass of Left Leg w/ Ulcer of Heel/Midfoot
 ;;^UTILITY(U,$J,358.3,13891,1,4,0)
 ;;=4^I70.444
