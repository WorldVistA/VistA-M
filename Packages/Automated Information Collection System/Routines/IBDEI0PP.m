IBDEI0PP ; ; 09-AUG-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,34048,2)
 ;;=^5002534
 ;;^UTILITY(U,$J,358.3,34049,0)
 ;;=E09.621^^100^1496^133
 ;;^UTILITY(U,$J,358.3,34049,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34049,1,3,0)
 ;;=3^DM d/t Drug/Chemical w/ Foot Ulcer
 ;;^UTILITY(U,$J,358.3,34049,1,4,0)
 ;;=4^E09.621
 ;;^UTILITY(U,$J,358.3,34049,2)
 ;;=^5002576
 ;;^UTILITY(U,$J,358.3,34050,0)
 ;;=H05.011^^100^1496^110
 ;;^UTILITY(U,$J,358.3,34050,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34050,1,3,0)
 ;;=3^Cellulitis of Right Orbit
 ;;^UTILITY(U,$J,358.3,34050,1,4,0)
 ;;=4^H05.011
 ;;^UTILITY(U,$J,358.3,34050,2)
 ;;=^5004560
 ;;^UTILITY(U,$J,358.3,34051,0)
 ;;=H05.012^^100^1496^103
 ;;^UTILITY(U,$J,358.3,34051,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34051,1,3,0)
 ;;=3^Cellulitis of Left Orbit
 ;;^UTILITY(U,$J,358.3,34051,1,4,0)
 ;;=4^H05.012
 ;;^UTILITY(U,$J,358.3,34051,2)
 ;;=^5004561
 ;;^UTILITY(U,$J,358.3,34052,0)
 ;;=H05.013^^100^1496^97
 ;;^UTILITY(U,$J,358.3,34052,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34052,1,3,0)
 ;;=3^Cellulitis of Bilateral Orbits
 ;;^UTILITY(U,$J,358.3,34052,1,4,0)
 ;;=4^H05.013
 ;;^UTILITY(U,$J,358.3,34052,2)
 ;;=^5004562
 ;;^UTILITY(U,$J,358.3,34053,0)
 ;;=I70.331^^100^1496^50
 ;;^UTILITY(U,$J,358.3,34053,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34053,1,3,0)
 ;;=3^Athscl Bypass of Right Leg w/ Ulcer of Thigh
 ;;^UTILITY(U,$J,358.3,34053,1,4,0)
 ;;=4^I70.331
 ;;^UTILITY(U,$J,358.3,34053,2)
 ;;=^5007626
 ;;^UTILITY(U,$J,358.3,34054,0)
 ;;=I70.332^^100^1496^51
 ;;^UTILITY(U,$J,358.3,34054,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34054,1,3,0)
 ;;=3^Athscl Bypass of Right Leg w/ Ulcer of Calf
 ;;^UTILITY(U,$J,358.3,34054,1,4,0)
 ;;=4^I70.332
 ;;^UTILITY(U,$J,358.3,34054,2)
 ;;=^5007627
 ;;^UTILITY(U,$J,358.3,34055,0)
 ;;=I70.333^^100^1496^52
 ;;^UTILITY(U,$J,358.3,34055,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34055,1,3,0)
 ;;=3^Athscl Bypass of Right Leg w/ Ulcer of Ankle
 ;;^UTILITY(U,$J,358.3,34055,1,4,0)
 ;;=4^I70.333
 ;;^UTILITY(U,$J,358.3,34055,2)
 ;;=^5007628
 ;;^UTILITY(U,$J,358.3,34056,0)
 ;;=I70.334^^100^1496^53
 ;;^UTILITY(U,$J,358.3,34056,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34056,1,3,0)
 ;;=3^Athscl Bypass of Right Leg w/ Ulcer of Heel/Midfoot
 ;;^UTILITY(U,$J,358.3,34056,1,4,0)
 ;;=4^I70.334
 ;;^UTILITY(U,$J,358.3,34056,2)
 ;;=^5007629
 ;;^UTILITY(U,$J,358.3,34057,0)
 ;;=I70.335^^100^1496^54
 ;;^UTILITY(U,$J,358.3,34057,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34057,1,3,0)
 ;;=3^Athscl Bypass of Right Leg w/ Ulcer of Oth Part of Foot
 ;;^UTILITY(U,$J,358.3,34057,1,4,0)
 ;;=4^I70.335
 ;;^UTILITY(U,$J,358.3,34057,2)
 ;;=^5007630
 ;;^UTILITY(U,$J,358.3,34058,0)
 ;;=I70.341^^100^1496^49
 ;;^UTILITY(U,$J,358.3,34058,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34058,1,3,0)
 ;;=3^Athscl Bypass of Left Leg w/ Ulcer of Thigh
 ;;^UTILITY(U,$J,358.3,34058,1,4,0)
 ;;=4^I70.341
 ;;^UTILITY(U,$J,358.3,34058,2)
 ;;=^5007633
 ;;^UTILITY(U,$J,358.3,34059,0)
 ;;=I70.342^^100^1496^46
 ;;^UTILITY(U,$J,358.3,34059,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34059,1,3,0)
 ;;=3^Athscl Bypass of Left Leg w/ Ulcer of Calf
 ;;^UTILITY(U,$J,358.3,34059,1,4,0)
 ;;=4^I70.342
 ;;^UTILITY(U,$J,358.3,34059,2)
 ;;=^5007634
 ;;^UTILITY(U,$J,358.3,34060,0)
 ;;=I70.343^^100^1496^45
 ;;^UTILITY(U,$J,358.3,34060,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34060,1,3,0)
 ;;=3^Athscl Bypass of Left Leg w/ Ulcer of Ankle
 ;;^UTILITY(U,$J,358.3,34060,1,4,0)
 ;;=4^I70.343
 ;;^UTILITY(U,$J,358.3,34060,2)
 ;;=^5007635
 ;;^UTILITY(U,$J,358.3,34061,0)
 ;;=I70.344^^100^1496^47
 ;;^UTILITY(U,$J,358.3,34061,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34061,1,3,0)
 ;;=3^Athscl Bypass of Left Leg w/ Ulcer of Heel/Midfoot
 ;;^UTILITY(U,$J,358.3,34061,1,4,0)
 ;;=4^I70.344
 ;;^UTILITY(U,$J,358.3,34061,2)
 ;;=^5007636
 ;;^UTILITY(U,$J,358.3,34062,0)
 ;;=I70.345^^100^1496^48
 ;;^UTILITY(U,$J,358.3,34062,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34062,1,3,0)
 ;;=3^Athscl Bypass of Left Leg w/ Ulcer of Oth Part of Foot
 ;;^UTILITY(U,$J,358.3,34062,1,4,0)
 ;;=4^I70.345
 ;;^UTILITY(U,$J,358.3,34062,2)
 ;;=^5007637
 ;;^UTILITY(U,$J,358.3,34063,0)
 ;;=I70.431^^100^1496^40
 ;;^UTILITY(U,$J,358.3,34063,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34063,1,3,0)
 ;;=3^Athscl Autol Vein Bypass of Right Leg w/ Ulcer of Thigh
 ;;^UTILITY(U,$J,358.3,34063,1,4,0)
 ;;=4^I70.431
 ;;^UTILITY(U,$J,358.3,34063,2)
 ;;=^5007664
 ;;^UTILITY(U,$J,358.3,34064,0)
 ;;=I70.432^^100^1496^41
 ;;^UTILITY(U,$J,358.3,34064,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34064,1,3,0)
 ;;=3^Athscl Autol Vein Bypass of Right Leg w/ Ulcer of Calf
 ;;^UTILITY(U,$J,358.3,34064,1,4,0)
 ;;=4^I70.432
 ;;^UTILITY(U,$J,358.3,34064,2)
 ;;=^5007665
 ;;^UTILITY(U,$J,358.3,34065,0)
 ;;=I70.433^^100^1496^42
 ;;^UTILITY(U,$J,358.3,34065,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34065,1,3,0)
 ;;=3^Athscl Autol Vein Bypass of Right Leg w/ Ulcer of Ankle
 ;;^UTILITY(U,$J,358.3,34065,1,4,0)
 ;;=4^I70.433
 ;;^UTILITY(U,$J,358.3,34065,2)
 ;;=^5007666
 ;;^UTILITY(U,$J,358.3,34066,0)
 ;;=I70.434^^100^1496^43
 ;;^UTILITY(U,$J,358.3,34066,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34066,1,3,0)
 ;;=3^Athscl Autol Vein Bypass of Right Leg w/ Ulcer of Heel/Midfoot
 ;;^UTILITY(U,$J,358.3,34066,1,4,0)
 ;;=4^I70.434
 ;;^UTILITY(U,$J,358.3,34066,2)
 ;;=^5007667
 ;;^UTILITY(U,$J,358.3,34067,0)
 ;;=I70.435^^100^1496^44
 ;;^UTILITY(U,$J,358.3,34067,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34067,1,3,0)
 ;;=3^Athscl Autol Vein Bypass of Right Leg w/ Ulcer of Oth Part of Foot
 ;;^UTILITY(U,$J,358.3,34067,1,4,0)
 ;;=4^I70.435
 ;;^UTILITY(U,$J,358.3,34067,2)
 ;;=^5007668
 ;;^UTILITY(U,$J,358.3,34068,0)
 ;;=I70.441^^100^1496^35
 ;;^UTILITY(U,$J,358.3,34068,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34068,1,3,0)
 ;;=3^Athscl Autol Vein Bypass of Left Leg w/ Ulcer of Thigh
 ;;^UTILITY(U,$J,358.3,34068,1,4,0)
 ;;=4^I70.441
 ;;^UTILITY(U,$J,358.3,34068,2)
 ;;=^5007671
 ;;^UTILITY(U,$J,358.3,34069,0)
 ;;=I70.442^^100^1496^36
 ;;^UTILITY(U,$J,358.3,34069,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34069,1,3,0)
 ;;=3^Athscl Autol Vein Bypass of Left Leg w/ Ulcer of Calf
 ;;^UTILITY(U,$J,358.3,34069,1,4,0)
 ;;=4^I70.442
 ;;^UTILITY(U,$J,358.3,34069,2)
 ;;=^5007672
 ;;^UTILITY(U,$J,358.3,34070,0)
 ;;=I70.443^^100^1496^37
 ;;^UTILITY(U,$J,358.3,34070,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34070,1,3,0)
 ;;=3^Athscl Autol Vein Bypass of Left Leg w/ Ulcer of Ankle
 ;;^UTILITY(U,$J,358.3,34070,1,4,0)
 ;;=4^I70.443
 ;;^UTILITY(U,$J,358.3,34070,2)
 ;;=^5007673
 ;;^UTILITY(U,$J,358.3,34071,0)
 ;;=I70.444^^100^1496^38
 ;;^UTILITY(U,$J,358.3,34071,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34071,1,3,0)
 ;;=3^Athscl Autol Vein Bypass of Left Leg w/ Ulcer of Heel/Midfoot
 ;;^UTILITY(U,$J,358.3,34071,1,4,0)
 ;;=4^I70.444
 ;;^UTILITY(U,$J,358.3,34071,2)
 ;;=^5007674
 ;;^UTILITY(U,$J,358.3,34072,0)
 ;;=I70.445^^100^1496^39
 ;;^UTILITY(U,$J,358.3,34072,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34072,1,3,0)
 ;;=3^Athscl Autol Vein Bypass of Left Leg w/ Ulcer of Oth Part of Foot
 ;;^UTILITY(U,$J,358.3,34072,1,4,0)
 ;;=4^I70.445
 ;;^UTILITY(U,$J,358.3,34072,2)
 ;;=^5007675
 ;;^UTILITY(U,$J,358.3,34073,0)
 ;;=I70.531^^100^1496^60
 ;;^UTILITY(U,$J,358.3,34073,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34073,1,3,0)
 ;;=3^Athscl Nonaut Bio Bypass of Right Leg w/ Ulcer of Thigh
 ;;^UTILITY(U,$J,358.3,34073,1,4,0)
 ;;=4^I70.531
 ;;^UTILITY(U,$J,358.3,34073,2)
 ;;=^5007702
 ;;^UTILITY(U,$J,358.3,34074,0)
 ;;=I70.532^^100^1496^61
 ;;^UTILITY(U,$J,358.3,34074,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34074,1,3,0)
 ;;=3^Athscl Nonaut Bio Bypass of Right Leg w/ Ulcer of Calf
 ;;^UTILITY(U,$J,358.3,34074,1,4,0)
 ;;=4^I70.532
 ;;^UTILITY(U,$J,358.3,34074,2)
 ;;=^5007703
 ;;^UTILITY(U,$J,358.3,34075,0)
 ;;=I70.533^^100^1496^62
 ;;^UTILITY(U,$J,358.3,34075,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34075,1,3,0)
 ;;=3^Athscl Nonaut Bio Bypass of Right Leg w/ Ulcer of Ankle
 ;;^UTILITY(U,$J,358.3,34075,1,4,0)
 ;;=4^I70.533
 ;;^UTILITY(U,$J,358.3,34075,2)
 ;;=^5007704
 ;;^UTILITY(U,$J,358.3,34076,0)
 ;;=I70.534^^100^1496^63
 ;;^UTILITY(U,$J,358.3,34076,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34076,1,3,0)
 ;;=3^Athscl Nonaut Bio Bypass of Right Leg w/ Ulcer of Heel/Midfoot
 ;;^UTILITY(U,$J,358.3,34076,1,4,0)
 ;;=4^I70.534
 ;;^UTILITY(U,$J,358.3,34076,2)
 ;;=^5007705
 ;;^UTILITY(U,$J,358.3,34077,0)
 ;;=I70.535^^100^1496^64
 ;;^UTILITY(U,$J,358.3,34077,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34077,1,3,0)
 ;;=3^Athscl Nonaut Bio Bypass of Right Leg w/ Ulcer of Oth Part of Foot
 ;;^UTILITY(U,$J,358.3,34077,1,4,0)
 ;;=4^I70.535
 ;;^UTILITY(U,$J,358.3,34077,2)
 ;;=^5007706
 ;;^UTILITY(U,$J,358.3,34078,0)
 ;;=I70.541^^100^1496^55
 ;;^UTILITY(U,$J,358.3,34078,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34078,1,3,0)
 ;;=3^Athscl Nonaut Bio Bypass of Left Leg w/ Ulcer of Thigh
 ;;^UTILITY(U,$J,358.3,34078,1,4,0)
 ;;=4^I70.541
 ;;^UTILITY(U,$J,358.3,34078,2)
 ;;=^5007709
 ;;^UTILITY(U,$J,358.3,34079,0)
 ;;=I70.542^^100^1496^56
 ;;^UTILITY(U,$J,358.3,34079,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34079,1,3,0)
 ;;=3^Athscl Nonaut Bio Bypass of Left Leg w/ Ulcer of Calf
 ;;^UTILITY(U,$J,358.3,34079,1,4,0)
 ;;=4^I70.542
 ;;^UTILITY(U,$J,358.3,34079,2)
 ;;=^5007710
 ;;^UTILITY(U,$J,358.3,34080,0)
 ;;=I70.543^^100^1496^57
 ;;^UTILITY(U,$J,358.3,34080,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34080,1,3,0)
 ;;=3^Athscl Nonaut Bio Bypass of Left Leg w/ Ulcer of Ankle
 ;;^UTILITY(U,$J,358.3,34080,1,4,0)
 ;;=4^I70.543
 ;;^UTILITY(U,$J,358.3,34080,2)
 ;;=^5007711
 ;;^UTILITY(U,$J,358.3,34081,0)
 ;;=I70.544^^100^1496^58
 ;;^UTILITY(U,$J,358.3,34081,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34081,1,3,0)
 ;;=3^Athscl Nonaut Bio Bypass of Left Leg w/ Ulcer of Heel/Midfoot
