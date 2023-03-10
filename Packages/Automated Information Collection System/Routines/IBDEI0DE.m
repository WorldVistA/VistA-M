IBDEI0DE ; ; 03-MAY-2022
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 03, 2022
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,33629,1,3,0)
 ;;=3^Tinea Barbae and Tinea Capitis
 ;;^UTILITY(U,$J,358.3,33629,1,4,0)
 ;;=4^B35.0
 ;;^UTILITY(U,$J,358.3,33629,2)
 ;;=^5000604
 ;;^UTILITY(U,$J,358.3,33630,0)
 ;;=B35.1^^105^1423^324
 ;;^UTILITY(U,$J,358.3,33630,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33630,1,3,0)
 ;;=3^Tinea Unguium
 ;;^UTILITY(U,$J,358.3,33630,1,4,0)
 ;;=4^B35.1
 ;;^UTILITY(U,$J,358.3,33630,2)
 ;;=^119748
 ;;^UTILITY(U,$J,358.3,33631,0)
 ;;=B35.6^^105^1423^321
 ;;^UTILITY(U,$J,358.3,33631,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33631,1,3,0)
 ;;=3^Tinea Cruris
 ;;^UTILITY(U,$J,358.3,33631,1,4,0)
 ;;=4^B35.6
 ;;^UTILITY(U,$J,358.3,33631,2)
 ;;=^119711
 ;;^UTILITY(U,$J,358.3,33632,0)
 ;;=B35.3^^105^1423^323
 ;;^UTILITY(U,$J,358.3,33632,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33632,1,3,0)
 ;;=3^Tinea Pedis
 ;;^UTILITY(U,$J,358.3,33632,1,4,0)
 ;;=4^B35.3
 ;;^UTILITY(U,$J,358.3,33632,2)
 ;;=^119732
 ;;^UTILITY(U,$J,358.3,33633,0)
 ;;=B35.5^^105^1423^322
 ;;^UTILITY(U,$J,358.3,33633,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33633,1,3,0)
 ;;=3^Tinea Imbricata
 ;;^UTILITY(U,$J,358.3,33633,1,4,0)
 ;;=4^B35.5
 ;;^UTILITY(U,$J,358.3,33633,2)
 ;;=^119725
 ;;^UTILITY(U,$J,358.3,33634,0)
 ;;=B35.4^^105^1423^320
 ;;^UTILITY(U,$J,358.3,33634,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33634,1,3,0)
 ;;=3^Tinea Corporis
 ;;^UTILITY(U,$J,358.3,33634,1,4,0)
 ;;=4^B35.4
 ;;^UTILITY(U,$J,358.3,33634,2)
 ;;=^119704
 ;;^UTILITY(U,$J,358.3,33635,0)
 ;;=B35.8^^105^1423^140
 ;;^UTILITY(U,$J,358.3,33635,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33635,1,3,0)
 ;;=3^Dermatophytoses,Other
 ;;^UTILITY(U,$J,358.3,33635,1,4,0)
 ;;=4^B35.8
 ;;^UTILITY(U,$J,358.3,33635,2)
 ;;=^5000606
 ;;^UTILITY(U,$J,358.3,33636,0)
 ;;=B36.9^^105^1423^312
 ;;^UTILITY(U,$J,358.3,33636,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33636,1,3,0)
 ;;=3^Superficial Mycosis,Unspec
 ;;^UTILITY(U,$J,358.3,33636,1,4,0)
 ;;=4^B36.9
 ;;^UTILITY(U,$J,358.3,33636,2)
 ;;=^5000611
 ;;^UTILITY(U,$J,358.3,33637,0)
 ;;=D69.0^^105^1423^33
 ;;^UTILITY(U,$J,358.3,33637,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33637,1,3,0)
 ;;=3^Allergic Purpura
 ;;^UTILITY(U,$J,358.3,33637,1,4,0)
 ;;=4^D69.0
 ;;^UTILITY(U,$J,358.3,33637,2)
 ;;=^5002365
 ;;^UTILITY(U,$J,358.3,33638,0)
 ;;=B00.9^^105^1423^161
 ;;^UTILITY(U,$J,358.3,33638,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33638,1,3,0)
 ;;=3^Herpesviral Infection,Unspec
 ;;^UTILITY(U,$J,358.3,33638,1,4,0)
 ;;=4^B00.9
 ;;^UTILITY(U,$J,358.3,33638,2)
 ;;=^5000480
 ;;^UTILITY(U,$J,358.3,33639,0)
 ;;=B02.9^^105^1423^331
 ;;^UTILITY(U,$J,358.3,33639,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33639,1,3,0)
 ;;=3^Zoster w/o Complications
 ;;^UTILITY(U,$J,358.3,33639,1,4,0)
 ;;=4^B02.9
 ;;^UTILITY(U,$J,358.3,33639,2)
 ;;=^5000501
 ;;^UTILITY(U,$J,358.3,33640,0)
 ;;=D17.9^^105^1423^90
 ;;^UTILITY(U,$J,358.3,33640,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33640,1,3,0)
 ;;=3^Benign Lipomatous Neop,Unspec
 ;;^UTILITY(U,$J,358.3,33640,1,4,0)
 ;;=4^D17.9
 ;;^UTILITY(U,$J,358.3,33640,2)
 ;;=^5002020
 ;;^UTILITY(U,$J,358.3,33641,0)
 ;;=E08.621^^105^1423^137
 ;;^UTILITY(U,$J,358.3,33641,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33641,1,3,0)
 ;;=3^DM d/t Underlying Condition w/ Foot Ulcer
 ;;^UTILITY(U,$J,358.3,33641,1,4,0)
 ;;=4^E08.621
 ;;^UTILITY(U,$J,358.3,33641,2)
 ;;=^5002534
 ;;^UTILITY(U,$J,358.3,33642,0)
 ;;=E09.621^^105^1423^136
 ;;^UTILITY(U,$J,358.3,33642,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33642,1,3,0)
 ;;=3^DM d/t Drug/Chemical w/ Foot Ulcer
 ;;^UTILITY(U,$J,358.3,33642,1,4,0)
 ;;=4^E09.621
 ;;^UTILITY(U,$J,358.3,33642,2)
 ;;=^5002576
 ;;^UTILITY(U,$J,358.3,33643,0)
 ;;=H05.011^^105^1423^112
 ;;^UTILITY(U,$J,358.3,33643,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33643,1,3,0)
 ;;=3^Cellulitis of Right Orbit
 ;;^UTILITY(U,$J,358.3,33643,1,4,0)
 ;;=4^H05.011
 ;;^UTILITY(U,$J,358.3,33643,2)
 ;;=^5004560
 ;;^UTILITY(U,$J,358.3,33644,0)
 ;;=H05.012^^105^1423^105
 ;;^UTILITY(U,$J,358.3,33644,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33644,1,3,0)
 ;;=3^Cellulitis of Left Orbit
 ;;^UTILITY(U,$J,358.3,33644,1,4,0)
 ;;=4^H05.012
 ;;^UTILITY(U,$J,358.3,33644,2)
 ;;=^5004561
 ;;^UTILITY(U,$J,358.3,33645,0)
 ;;=H05.013^^105^1423^99
 ;;^UTILITY(U,$J,358.3,33645,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33645,1,3,0)
 ;;=3^Cellulitis of Bilateral Orbits
 ;;^UTILITY(U,$J,358.3,33645,1,4,0)
 ;;=4^H05.013
 ;;^UTILITY(U,$J,358.3,33645,2)
 ;;=^5004562
 ;;^UTILITY(U,$J,358.3,33646,0)
 ;;=I70.331^^105^1423^51
 ;;^UTILITY(U,$J,358.3,33646,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33646,1,3,0)
 ;;=3^Athscl Bypass of Right Leg w/ Ulcer of Thigh
 ;;^UTILITY(U,$J,358.3,33646,1,4,0)
 ;;=4^I70.331
 ;;^UTILITY(U,$J,358.3,33646,2)
 ;;=^5007626
 ;;^UTILITY(U,$J,358.3,33647,0)
 ;;=I70.332^^105^1423^52
 ;;^UTILITY(U,$J,358.3,33647,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33647,1,3,0)
 ;;=3^Athscl Bypass of Right Leg w/ Ulcer of Calf
 ;;^UTILITY(U,$J,358.3,33647,1,4,0)
 ;;=4^I70.332
 ;;^UTILITY(U,$J,358.3,33647,2)
 ;;=^5007627
 ;;^UTILITY(U,$J,358.3,33648,0)
 ;;=I70.333^^105^1423^53
 ;;^UTILITY(U,$J,358.3,33648,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33648,1,3,0)
 ;;=3^Athscl Bypass of Right Leg w/ Ulcer of Ankle
 ;;^UTILITY(U,$J,358.3,33648,1,4,0)
 ;;=4^I70.333
 ;;^UTILITY(U,$J,358.3,33648,2)
 ;;=^5007628
 ;;^UTILITY(U,$J,358.3,33649,0)
 ;;=I70.334^^105^1423^54
 ;;^UTILITY(U,$J,358.3,33649,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33649,1,3,0)
 ;;=3^Athscl Bypass of Right Leg w/ Ulcer of Heel/Midfoot
 ;;^UTILITY(U,$J,358.3,33649,1,4,0)
 ;;=4^I70.334
 ;;^UTILITY(U,$J,358.3,33649,2)
 ;;=^5007629
 ;;^UTILITY(U,$J,358.3,33650,0)
 ;;=I70.335^^105^1423^55
 ;;^UTILITY(U,$J,358.3,33650,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33650,1,3,0)
 ;;=3^Athscl Bypass of Right Leg w/ Ulcer of Oth Part of Foot
 ;;^UTILITY(U,$J,358.3,33650,1,4,0)
 ;;=4^I70.335
 ;;^UTILITY(U,$J,358.3,33650,2)
 ;;=^5007630
 ;;^UTILITY(U,$J,358.3,33651,0)
 ;;=I70.341^^105^1423^50
 ;;^UTILITY(U,$J,358.3,33651,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33651,1,3,0)
 ;;=3^Athscl Bypass of Left Leg w/ Ulcer of Thigh
 ;;^UTILITY(U,$J,358.3,33651,1,4,0)
 ;;=4^I70.341
 ;;^UTILITY(U,$J,358.3,33651,2)
 ;;=^5007633
 ;;^UTILITY(U,$J,358.3,33652,0)
 ;;=I70.342^^105^1423^47
 ;;^UTILITY(U,$J,358.3,33652,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33652,1,3,0)
 ;;=3^Athscl Bypass of Left Leg w/ Ulcer of Calf
 ;;^UTILITY(U,$J,358.3,33652,1,4,0)
 ;;=4^I70.342
 ;;^UTILITY(U,$J,358.3,33652,2)
 ;;=^5007634
 ;;^UTILITY(U,$J,358.3,33653,0)
 ;;=I70.343^^105^1423^46
 ;;^UTILITY(U,$J,358.3,33653,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33653,1,3,0)
 ;;=3^Athscl Bypass of Left Leg w/ Ulcer of Ankle
 ;;^UTILITY(U,$J,358.3,33653,1,4,0)
 ;;=4^I70.343
 ;;^UTILITY(U,$J,358.3,33653,2)
 ;;=^5007635
 ;;^UTILITY(U,$J,358.3,33654,0)
 ;;=I70.344^^105^1423^48
 ;;^UTILITY(U,$J,358.3,33654,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33654,1,3,0)
 ;;=3^Athscl Bypass of Left Leg w/ Ulcer of Heel/Midfoot
 ;;^UTILITY(U,$J,358.3,33654,1,4,0)
 ;;=4^I70.344
 ;;^UTILITY(U,$J,358.3,33654,2)
 ;;=^5007636
 ;;^UTILITY(U,$J,358.3,33655,0)
 ;;=I70.345^^105^1423^49
 ;;^UTILITY(U,$J,358.3,33655,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33655,1,3,0)
 ;;=3^Athscl Bypass of Left Leg w/ Ulcer of Oth Part of Foot
 ;;^UTILITY(U,$J,358.3,33655,1,4,0)
 ;;=4^I70.345
 ;;^UTILITY(U,$J,358.3,33655,2)
 ;;=^5007637
 ;;^UTILITY(U,$J,358.3,33656,0)
 ;;=I70.431^^105^1423^41
 ;;^UTILITY(U,$J,358.3,33656,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33656,1,3,0)
 ;;=3^Athscl Autol Vein Bypass of Right Leg w/ Ulcer of Thigh
 ;;^UTILITY(U,$J,358.3,33656,1,4,0)
 ;;=4^I70.431
 ;;^UTILITY(U,$J,358.3,33656,2)
 ;;=^5007664
 ;;^UTILITY(U,$J,358.3,33657,0)
 ;;=I70.432^^105^1423^42
 ;;^UTILITY(U,$J,358.3,33657,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33657,1,3,0)
 ;;=3^Athscl Autol Vein Bypass of Right Leg w/ Ulcer of Calf
 ;;^UTILITY(U,$J,358.3,33657,1,4,0)
 ;;=4^I70.432
 ;;^UTILITY(U,$J,358.3,33657,2)
 ;;=^5007665
 ;;^UTILITY(U,$J,358.3,33658,0)
 ;;=I70.433^^105^1423^43
 ;;^UTILITY(U,$J,358.3,33658,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33658,1,3,0)
 ;;=3^Athscl Autol Vein Bypass of Right Leg w/ Ulcer of Ankle
 ;;^UTILITY(U,$J,358.3,33658,1,4,0)
 ;;=4^I70.433
 ;;^UTILITY(U,$J,358.3,33658,2)
 ;;=^5007666
 ;;^UTILITY(U,$J,358.3,33659,0)
 ;;=I70.434^^105^1423^44
 ;;^UTILITY(U,$J,358.3,33659,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33659,1,3,0)
 ;;=3^Athscl Autol Vein Bypass of Right Leg w/ Ulcer of Heel/Midfoot
 ;;^UTILITY(U,$J,358.3,33659,1,4,0)
 ;;=4^I70.434
 ;;^UTILITY(U,$J,358.3,33659,2)
 ;;=^5007667
 ;;^UTILITY(U,$J,358.3,33660,0)
 ;;=I70.435^^105^1423^45
 ;;^UTILITY(U,$J,358.3,33660,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33660,1,3,0)
 ;;=3^Athscl Autol Vein Bypass of Right Leg w/ Ulcer of Oth Part of Foot
 ;;^UTILITY(U,$J,358.3,33660,1,4,0)
 ;;=4^I70.435
 ;;^UTILITY(U,$J,358.3,33660,2)
 ;;=^5007668
 ;;^UTILITY(U,$J,358.3,33661,0)
 ;;=I70.441^^105^1423^36
 ;;^UTILITY(U,$J,358.3,33661,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33661,1,3,0)
 ;;=3^Athscl Autol Vein Bypass of Left Leg w/ Ulcer of Thigh
 ;;^UTILITY(U,$J,358.3,33661,1,4,0)
 ;;=4^I70.441
 ;;^UTILITY(U,$J,358.3,33661,2)
 ;;=^5007671
 ;;^UTILITY(U,$J,358.3,33662,0)
 ;;=I70.442^^105^1423^37
 ;;^UTILITY(U,$J,358.3,33662,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33662,1,3,0)
 ;;=3^Athscl Autol Vein Bypass of Left Leg w/ Ulcer of Calf
 ;;^UTILITY(U,$J,358.3,33662,1,4,0)
 ;;=4^I70.442
 ;;^UTILITY(U,$J,358.3,33662,2)
 ;;=^5007672
 ;;^UTILITY(U,$J,358.3,33663,0)
 ;;=I70.443^^105^1423^38
 ;;^UTILITY(U,$J,358.3,33663,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33663,1,3,0)
 ;;=3^Athscl Autol Vein Bypass of Left Leg w/ Ulcer of Ankle
 ;;^UTILITY(U,$J,358.3,33663,1,4,0)
 ;;=4^I70.443
 ;;^UTILITY(U,$J,358.3,33663,2)
 ;;=^5007673
 ;;^UTILITY(U,$J,358.3,33664,0)
 ;;=I70.444^^105^1423^39
 ;;^UTILITY(U,$J,358.3,33664,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33664,1,3,0)
 ;;=3^Athscl Autol Vein Bypass of Left Leg w/ Ulcer of Heel/Midfoot
 ;;^UTILITY(U,$J,358.3,33664,1,4,0)
 ;;=4^I70.444
 ;;^UTILITY(U,$J,358.3,33664,2)
 ;;=^5007674
 ;;^UTILITY(U,$J,358.3,33665,0)
 ;;=I70.445^^105^1423^40
 ;;^UTILITY(U,$J,358.3,33665,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33665,1,3,0)
 ;;=3^Athscl Autol Vein Bypass of Left Leg w/ Ulcer of Oth Part of Foot
 ;;^UTILITY(U,$J,358.3,33665,1,4,0)
 ;;=4^I70.445
 ;;^UTILITY(U,$J,358.3,33665,2)
 ;;=^5007675
 ;;^UTILITY(U,$J,358.3,33666,0)
 ;;=I70.531^^105^1423^61
 ;;^UTILITY(U,$J,358.3,33666,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33666,1,3,0)
 ;;=3^Athscl Nonaut Bio Bypass of Right Leg w/ Ulcer of Thigh
 ;;^UTILITY(U,$J,358.3,33666,1,4,0)
 ;;=4^I70.531
 ;;^UTILITY(U,$J,358.3,33666,2)
 ;;=^5007702
 ;;^UTILITY(U,$J,358.3,33667,0)
 ;;=I70.532^^105^1423^62
 ;;^UTILITY(U,$J,358.3,33667,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33667,1,3,0)
 ;;=3^Athscl Nonaut Bio Bypass of Right Leg w/ Ulcer of Calf
 ;;^UTILITY(U,$J,358.3,33667,1,4,0)
 ;;=4^I70.532
 ;;^UTILITY(U,$J,358.3,33667,2)
 ;;=^5007703
 ;;^UTILITY(U,$J,358.3,33668,0)
 ;;=I70.533^^105^1423^63
 ;;^UTILITY(U,$J,358.3,33668,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33668,1,3,0)
 ;;=3^Athscl Nonaut Bio Bypass of Right Leg w/ Ulcer of Ankle
 ;;^UTILITY(U,$J,358.3,33668,1,4,0)
 ;;=4^I70.533
 ;;^UTILITY(U,$J,358.3,33668,2)
 ;;=^5007704
 ;;^UTILITY(U,$J,358.3,33669,0)
 ;;=I70.534^^105^1423^64
 ;;^UTILITY(U,$J,358.3,33669,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33669,1,3,0)
 ;;=3^Athscl Nonaut Bio Bypass of Right Leg w/ Ulcer of Heel/Midfoot
 ;;^UTILITY(U,$J,358.3,33669,1,4,0)
 ;;=4^I70.534
 ;;^UTILITY(U,$J,358.3,33669,2)
 ;;=^5007705
 ;;^UTILITY(U,$J,358.3,33670,0)
 ;;=I70.535^^105^1423^65
 ;;^UTILITY(U,$J,358.3,33670,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33670,1,3,0)
 ;;=3^Athscl Nonaut Bio Bypass of Right Leg w/ Ulcer of Oth Part of Foot
 ;;^UTILITY(U,$J,358.3,33670,1,4,0)
 ;;=4^I70.535
 ;;^UTILITY(U,$J,358.3,33670,2)
 ;;=^5007706
 ;;^UTILITY(U,$J,358.3,33671,0)
 ;;=I70.541^^105^1423^56
 ;;^UTILITY(U,$J,358.3,33671,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33671,1,3,0)
 ;;=3^Athscl Nonaut Bio Bypass of Left Leg w/ Ulcer of Thigh
 ;;^UTILITY(U,$J,358.3,33671,1,4,0)
 ;;=4^I70.541
 ;;^UTILITY(U,$J,358.3,33671,2)
 ;;=^5007709
 ;;^UTILITY(U,$J,358.3,33672,0)
 ;;=I70.542^^105^1423^57
 ;;^UTILITY(U,$J,358.3,33672,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33672,1,3,0)
 ;;=3^Athscl Nonaut Bio Bypass of Left Leg w/ Ulcer of Calf
 ;;^UTILITY(U,$J,358.3,33672,1,4,0)
 ;;=4^I70.542
 ;;^UTILITY(U,$J,358.3,33672,2)
 ;;=^5007710
 ;;^UTILITY(U,$J,358.3,33673,0)
 ;;=I70.543^^105^1423^58
 ;;^UTILITY(U,$J,358.3,33673,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33673,1,3,0)
 ;;=3^Athscl Nonaut Bio Bypass of Left Leg w/ Ulcer of Ankle
 ;;^UTILITY(U,$J,358.3,33673,1,4,0)
 ;;=4^I70.543
 ;;^UTILITY(U,$J,358.3,33673,2)
 ;;=^5007711
 ;;^UTILITY(U,$J,358.3,33674,0)
 ;;=I70.544^^105^1423^59
 ;;^UTILITY(U,$J,358.3,33674,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33674,1,3,0)
 ;;=3^Athscl Nonaut Bio Bypass of Left Leg w/ Ulcer of Heel/Midfoot
 ;;^UTILITY(U,$J,358.3,33674,1,4,0)
 ;;=4^I70.544
 ;;^UTILITY(U,$J,358.3,33674,2)
 ;;=^5007712
 ;;^UTILITY(U,$J,358.3,33675,0)
 ;;=I70.545^^105^1423^60
 ;;^UTILITY(U,$J,358.3,33675,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33675,1,3,0)
 ;;=3^Athscl Nonaut Bio Bypass of Left Leg w/ Ulcer of Oth Part of Foot
 ;;^UTILITY(U,$J,358.3,33675,1,4,0)
 ;;=4^I70.545
 ;;^UTILITY(U,$J,358.3,33675,2)
 ;;=^5007713
 ;;^UTILITY(U,$J,358.3,33676,0)
 ;;=I70.631^^105^1423^71
 ;;^UTILITY(U,$J,358.3,33676,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33676,1,3,0)
 ;;=3^Athscl Nonbiol Bypass of Right Leg w/ Ulcer of Thigh
 ;;^UTILITY(U,$J,358.3,33676,1,4,0)
 ;;=4^I70.631
 ;;^UTILITY(U,$J,358.3,33676,2)
 ;;=^5007740
 ;;^UTILITY(U,$J,358.3,33677,0)
 ;;=I70.632^^105^1423^72
 ;;^UTILITY(U,$J,358.3,33677,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33677,1,3,0)
 ;;=3^Athscl Nonbiol Bypass of Right Leg w/ Ulcer of Calf
 ;;^UTILITY(U,$J,358.3,33677,1,4,0)
 ;;=4^I70.632
 ;;^UTILITY(U,$J,358.3,33677,2)
 ;;=^5007741
 ;;^UTILITY(U,$J,358.3,33678,0)
 ;;=I70.633^^105^1423^73
 ;;^UTILITY(U,$J,358.3,33678,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33678,1,3,0)
 ;;=3^Athscl Nonbiol Bypass of Right Leg w/ Ulcer of Ankle
 ;;^UTILITY(U,$J,358.3,33678,1,4,0)
 ;;=4^I70.633
 ;;^UTILITY(U,$J,358.3,33678,2)
 ;;=^5007742
 ;;^UTILITY(U,$J,358.3,33679,0)
 ;;=I70.634^^105^1423^74
 ;;^UTILITY(U,$J,358.3,33679,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33679,1,3,0)
 ;;=3^Athscl Nonbiol Bypass of Right Leg w/ Ulcer of Heel/Midfoot
 ;;^UTILITY(U,$J,358.3,33679,1,4,0)
 ;;=4^I70.634
 ;;^UTILITY(U,$J,358.3,33679,2)
 ;;=^5007743
 ;;^UTILITY(U,$J,358.3,33680,0)
 ;;=I70.635^^105^1423^75
 ;;^UTILITY(U,$J,358.3,33680,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33680,1,3,0)
 ;;=3^Athscl Nonbiol Bypass of Right Leg w/ Ulcer of Oth Part of Foot
 ;;^UTILITY(U,$J,358.3,33680,1,4,0)
 ;;=4^I70.635
 ;;^UTILITY(U,$J,358.3,33680,2)
 ;;=^5007744
 ;;^UTILITY(U,$J,358.3,33681,0)
 ;;=I70.641^^105^1423^66
 ;;^UTILITY(U,$J,358.3,33681,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33681,1,3,0)
 ;;=3^Athscl Nonbiol Bypass of Left Leg w/ Ulcer of Thigh
 ;;^UTILITY(U,$J,358.3,33681,1,4,0)
 ;;=4^I70.641
 ;;^UTILITY(U,$J,358.3,33681,2)
 ;;=^5007747
 ;;^UTILITY(U,$J,358.3,33682,0)
 ;;=I70.642^^105^1423^67
 ;;^UTILITY(U,$J,358.3,33682,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33682,1,3,0)
 ;;=3^Athscl Nonbiol Bypass of Left Leg w/ Ulcer of Calf
 ;;^UTILITY(U,$J,358.3,33682,1,4,0)
 ;;=4^I70.642
 ;;^UTILITY(U,$J,358.3,33682,2)
 ;;=^5007748
 ;;^UTILITY(U,$J,358.3,33683,0)
 ;;=I70.643^^105^1423^68
 ;;^UTILITY(U,$J,358.3,33683,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33683,1,3,0)
 ;;=3^Athscl Nonbiol Bypass of Left Leg w/ Ulcer of Ankle
 ;;^UTILITY(U,$J,358.3,33683,1,4,0)
 ;;=4^I70.643
 ;;^UTILITY(U,$J,358.3,33683,2)
 ;;=^5007749
 ;;^UTILITY(U,$J,358.3,33684,0)
 ;;=I70.644^^105^1423^69
 ;;^UTILITY(U,$J,358.3,33684,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33684,1,3,0)
 ;;=3^Athscl Nonbiol Bypass of Left Leg w/ Ulcer of Heel/Midfoot
 ;;^UTILITY(U,$J,358.3,33684,1,4,0)
 ;;=4^I70.644
 ;;^UTILITY(U,$J,358.3,33684,2)
 ;;=^5007750
 ;;^UTILITY(U,$J,358.3,33685,0)
 ;;=I70.645^^105^1423^70
 ;;^UTILITY(U,$J,358.3,33685,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33685,1,3,0)
 ;;=3^Athscl Nonbiol Bypass of Left Leg w/ Ulcer of Oth Part of Foot
 ;;^UTILITY(U,$J,358.3,33685,1,4,0)
 ;;=4^I70.645
 ;;^UTILITY(U,$J,358.3,33685,2)
 ;;=^5007751
 ;;^UTILITY(U,$J,358.3,33686,0)
 ;;=K12.0^^105^1423^298
 ;;^UTILITY(U,$J,358.3,33686,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33686,1,3,0)
 ;;=3^Recurrent Oral Aphthae
 ;;^UTILITY(U,$J,358.3,33686,1,4,0)
 ;;=4^K12.0
 ;;^UTILITY(U,$J,358.3,33686,2)
 ;;=^5008483
 ;;^UTILITY(U,$J,358.3,33687,0)
 ;;=K12.1^^105^1423^311
 ;;^UTILITY(U,$J,358.3,33687,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33687,1,3,0)
 ;;=3^Stomatitis NEC
 ;;^UTILITY(U,$J,358.3,33687,1,4,0)
 ;;=4^K12.1
 ;;^UTILITY(U,$J,358.3,33687,2)
 ;;=^5008484
 ;;^UTILITY(U,$J,358.3,33688,0)
 ;;=K12.2^^105^1423^95
 ;;^UTILITY(U,$J,358.3,33688,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33688,1,3,0)
 ;;=3^Cellulitis & Abscess of Mouth
 ;;^UTILITY(U,$J,358.3,33688,1,4,0)
 ;;=4^K12.2
 ;;^UTILITY(U,$J,358.3,33688,2)
 ;;=^5008485
 ;;^UTILITY(U,$J,358.3,33689,0)
 ;;=L02.01^^105^1423^122
 ;;^UTILITY(U,$J,358.3,33689,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33689,1,3,0)
 ;;=3^Cutaneous Abscess of Face
 ;;^UTILITY(U,$J,358.3,33689,1,4,0)
 ;;=4^L02.01
 ;;^UTILITY(U,$J,358.3,33689,2)
 ;;=^5008944
 ;;^UTILITY(U,$J,358.3,33690,0)
 ;;=L02.11^^105^1423^127
 ;;^UTILITY(U,$J,358.3,33690,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33690,1,3,0)
 ;;=3^Cutaneous Abscess of Neck
 ;;^UTILITY(U,$J,358.3,33690,1,4,0)
 ;;=4^L02.11
 ;;^UTILITY(U,$J,358.3,33690,2)
 ;;=^5008947
 ;;^UTILITY(U,$J,358.3,33691,0)
 ;;=L02.211^^105^1423^119
 ;;^UTILITY(U,$J,358.3,33691,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33691,1,3,0)
 ;;=3^Cutaneous Abscess of Abdominal Wall
 ;;^UTILITY(U,$J,358.3,33691,1,4,0)
 ;;=4^L02.211
 ;;^UTILITY(U,$J,358.3,33691,2)
 ;;=^5008950
 ;;^UTILITY(U,$J,358.3,33692,0)
 ;;=L02.212^^105^1423^120
 ;;^UTILITY(U,$J,358.3,33692,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33692,1,3,0)
 ;;=3^Cutaneous Abscess of Back
 ;;^UTILITY(U,$J,358.3,33692,1,4,0)
 ;;=4^L02.212
 ;;^UTILITY(U,$J,358.3,33692,2)
 ;;=^5008951
 ;;^UTILITY(U,$J,358.3,33693,0)
 ;;=L02.213^^105^1423^121
 ;;^UTILITY(U,$J,358.3,33693,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33693,1,3,0)
 ;;=3^Cutaneous Abscess of Chest Wall
 ;;^UTILITY(U,$J,358.3,33693,1,4,0)
 ;;=4^L02.213
 ;;^UTILITY(U,$J,358.3,33693,2)
 ;;=^5008952
 ;;^UTILITY(U,$J,358.3,33694,0)
 ;;=L02.214^^105^1423^123
 ;;^UTILITY(U,$J,358.3,33694,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33694,1,3,0)
 ;;=3^Cutaneous Abscess of Groin
