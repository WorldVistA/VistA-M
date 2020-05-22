IBDEI08Q ; ; 01-MAY-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 01, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,21361,1,3,0)
 ;;=3^Tinea Barbae and Tinea Capitis
 ;;^UTILITY(U,$J,358.3,21361,1,4,0)
 ;;=4^B35.0
 ;;^UTILITY(U,$J,358.3,21361,2)
 ;;=^5000604
 ;;^UTILITY(U,$J,358.3,21362,0)
 ;;=B35.1^^73^930^324
 ;;^UTILITY(U,$J,358.3,21362,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21362,1,3,0)
 ;;=3^Tinea Unguium
 ;;^UTILITY(U,$J,358.3,21362,1,4,0)
 ;;=4^B35.1
 ;;^UTILITY(U,$J,358.3,21362,2)
 ;;=^119748
 ;;^UTILITY(U,$J,358.3,21363,0)
 ;;=B35.6^^73^930^321
 ;;^UTILITY(U,$J,358.3,21363,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21363,1,3,0)
 ;;=3^Tinea Cruris
 ;;^UTILITY(U,$J,358.3,21363,1,4,0)
 ;;=4^B35.6
 ;;^UTILITY(U,$J,358.3,21363,2)
 ;;=^119711
 ;;^UTILITY(U,$J,358.3,21364,0)
 ;;=B35.3^^73^930^323
 ;;^UTILITY(U,$J,358.3,21364,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21364,1,3,0)
 ;;=3^Tinea Pedis
 ;;^UTILITY(U,$J,358.3,21364,1,4,0)
 ;;=4^B35.3
 ;;^UTILITY(U,$J,358.3,21364,2)
 ;;=^119732
 ;;^UTILITY(U,$J,358.3,21365,0)
 ;;=B35.5^^73^930^322
 ;;^UTILITY(U,$J,358.3,21365,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21365,1,3,0)
 ;;=3^Tinea Imbricata
 ;;^UTILITY(U,$J,358.3,21365,1,4,0)
 ;;=4^B35.5
 ;;^UTILITY(U,$J,358.3,21365,2)
 ;;=^119725
 ;;^UTILITY(U,$J,358.3,21366,0)
 ;;=B35.4^^73^930^320
 ;;^UTILITY(U,$J,358.3,21366,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21366,1,3,0)
 ;;=3^Tinea Corporis
 ;;^UTILITY(U,$J,358.3,21366,1,4,0)
 ;;=4^B35.4
 ;;^UTILITY(U,$J,358.3,21366,2)
 ;;=^119704
 ;;^UTILITY(U,$J,358.3,21367,0)
 ;;=B35.8^^73^930^140
 ;;^UTILITY(U,$J,358.3,21367,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21367,1,3,0)
 ;;=3^Dermatophytoses,Other
 ;;^UTILITY(U,$J,358.3,21367,1,4,0)
 ;;=4^B35.8
 ;;^UTILITY(U,$J,358.3,21367,2)
 ;;=^5000606
 ;;^UTILITY(U,$J,358.3,21368,0)
 ;;=B36.9^^73^930^312
 ;;^UTILITY(U,$J,358.3,21368,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21368,1,3,0)
 ;;=3^Superficial Mycosis,Unspec
 ;;^UTILITY(U,$J,358.3,21368,1,4,0)
 ;;=4^B36.9
 ;;^UTILITY(U,$J,358.3,21368,2)
 ;;=^5000611
 ;;^UTILITY(U,$J,358.3,21369,0)
 ;;=D69.0^^73^930^33
 ;;^UTILITY(U,$J,358.3,21369,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21369,1,3,0)
 ;;=3^Allergic Purpura
 ;;^UTILITY(U,$J,358.3,21369,1,4,0)
 ;;=4^D69.0
 ;;^UTILITY(U,$J,358.3,21369,2)
 ;;=^5002365
 ;;^UTILITY(U,$J,358.3,21370,0)
 ;;=B00.9^^73^930^161
 ;;^UTILITY(U,$J,358.3,21370,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21370,1,3,0)
 ;;=3^Herpesviral Infection,Unspec
 ;;^UTILITY(U,$J,358.3,21370,1,4,0)
 ;;=4^B00.9
 ;;^UTILITY(U,$J,358.3,21370,2)
 ;;=^5000480
 ;;^UTILITY(U,$J,358.3,21371,0)
 ;;=B02.9^^73^930^331
 ;;^UTILITY(U,$J,358.3,21371,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21371,1,3,0)
 ;;=3^Zoster w/o Complications
 ;;^UTILITY(U,$J,358.3,21371,1,4,0)
 ;;=4^B02.9
 ;;^UTILITY(U,$J,358.3,21371,2)
 ;;=^5000501
 ;;^UTILITY(U,$J,358.3,21372,0)
 ;;=D17.9^^73^930^90
 ;;^UTILITY(U,$J,358.3,21372,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21372,1,3,0)
 ;;=3^Benign Lipomatous Neop,Unspec
 ;;^UTILITY(U,$J,358.3,21372,1,4,0)
 ;;=4^D17.9
 ;;^UTILITY(U,$J,358.3,21372,2)
 ;;=^5002020
 ;;^UTILITY(U,$J,358.3,21373,0)
 ;;=E08.621^^73^930^137
 ;;^UTILITY(U,$J,358.3,21373,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21373,1,3,0)
 ;;=3^DM d/t Underlying Condition w/ Foot Ulcer
 ;;^UTILITY(U,$J,358.3,21373,1,4,0)
 ;;=4^E08.621
 ;;^UTILITY(U,$J,358.3,21373,2)
 ;;=^5002534
 ;;^UTILITY(U,$J,358.3,21374,0)
 ;;=E09.621^^73^930^136
 ;;^UTILITY(U,$J,358.3,21374,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21374,1,3,0)
 ;;=3^DM d/t Drug/Chemical w/ Foot Ulcer
 ;;^UTILITY(U,$J,358.3,21374,1,4,0)
 ;;=4^E09.621
 ;;^UTILITY(U,$J,358.3,21374,2)
 ;;=^5002576
 ;;^UTILITY(U,$J,358.3,21375,0)
 ;;=H05.011^^73^930^112
 ;;^UTILITY(U,$J,358.3,21375,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21375,1,3,0)
 ;;=3^Cellulitis of Right Orbit
 ;;^UTILITY(U,$J,358.3,21375,1,4,0)
 ;;=4^H05.011
 ;;^UTILITY(U,$J,358.3,21375,2)
 ;;=^5004560
 ;;^UTILITY(U,$J,358.3,21376,0)
 ;;=H05.012^^73^930^105
 ;;^UTILITY(U,$J,358.3,21376,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21376,1,3,0)
 ;;=3^Cellulitis of Left Orbit
 ;;^UTILITY(U,$J,358.3,21376,1,4,0)
 ;;=4^H05.012
 ;;^UTILITY(U,$J,358.3,21376,2)
 ;;=^5004561
 ;;^UTILITY(U,$J,358.3,21377,0)
 ;;=H05.013^^73^930^99
 ;;^UTILITY(U,$J,358.3,21377,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21377,1,3,0)
 ;;=3^Cellulitis of Bilateral Orbits
 ;;^UTILITY(U,$J,358.3,21377,1,4,0)
 ;;=4^H05.013
 ;;^UTILITY(U,$J,358.3,21377,2)
 ;;=^5004562
 ;;^UTILITY(U,$J,358.3,21378,0)
 ;;=I70.331^^73^930^51
 ;;^UTILITY(U,$J,358.3,21378,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21378,1,3,0)
 ;;=3^Athscl Bypass of Right Leg w/ Ulcer of Thigh
 ;;^UTILITY(U,$J,358.3,21378,1,4,0)
 ;;=4^I70.331
 ;;^UTILITY(U,$J,358.3,21378,2)
 ;;=^5007626
 ;;^UTILITY(U,$J,358.3,21379,0)
 ;;=I70.332^^73^930^52
 ;;^UTILITY(U,$J,358.3,21379,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21379,1,3,0)
 ;;=3^Athscl Bypass of Right Leg w/ Ulcer of Calf
 ;;^UTILITY(U,$J,358.3,21379,1,4,0)
 ;;=4^I70.332
 ;;^UTILITY(U,$J,358.3,21379,2)
 ;;=^5007627
 ;;^UTILITY(U,$J,358.3,21380,0)
 ;;=I70.333^^73^930^53
 ;;^UTILITY(U,$J,358.3,21380,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21380,1,3,0)
 ;;=3^Athscl Bypass of Right Leg w/ Ulcer of Ankle
 ;;^UTILITY(U,$J,358.3,21380,1,4,0)
 ;;=4^I70.333
 ;;^UTILITY(U,$J,358.3,21380,2)
 ;;=^5007628
 ;;^UTILITY(U,$J,358.3,21381,0)
 ;;=I70.334^^73^930^54
 ;;^UTILITY(U,$J,358.3,21381,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21381,1,3,0)
 ;;=3^Athscl Bypass of Right Leg w/ Ulcer of Heel/Midfoot
 ;;^UTILITY(U,$J,358.3,21381,1,4,0)
 ;;=4^I70.334
 ;;^UTILITY(U,$J,358.3,21381,2)
 ;;=^5007629
 ;;^UTILITY(U,$J,358.3,21382,0)
 ;;=I70.335^^73^930^55
 ;;^UTILITY(U,$J,358.3,21382,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21382,1,3,0)
 ;;=3^Athscl Bypass of Right Leg w/ Ulcer of Oth Part of Foot
 ;;^UTILITY(U,$J,358.3,21382,1,4,0)
 ;;=4^I70.335
 ;;^UTILITY(U,$J,358.3,21382,2)
 ;;=^5007630
 ;;^UTILITY(U,$J,358.3,21383,0)
 ;;=I70.341^^73^930^50
 ;;^UTILITY(U,$J,358.3,21383,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21383,1,3,0)
 ;;=3^Athscl Bypass of Left Leg w/ Ulcer of Thigh
 ;;^UTILITY(U,$J,358.3,21383,1,4,0)
 ;;=4^I70.341
 ;;^UTILITY(U,$J,358.3,21383,2)
 ;;=^5007633
 ;;^UTILITY(U,$J,358.3,21384,0)
 ;;=I70.342^^73^930^47
 ;;^UTILITY(U,$J,358.3,21384,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21384,1,3,0)
 ;;=3^Athscl Bypass of Left Leg w/ Ulcer of Calf
 ;;^UTILITY(U,$J,358.3,21384,1,4,0)
 ;;=4^I70.342
 ;;^UTILITY(U,$J,358.3,21384,2)
 ;;=^5007634
 ;;^UTILITY(U,$J,358.3,21385,0)
 ;;=I70.343^^73^930^46
 ;;^UTILITY(U,$J,358.3,21385,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21385,1,3,0)
 ;;=3^Athscl Bypass of Left Leg w/ Ulcer of Ankle
 ;;^UTILITY(U,$J,358.3,21385,1,4,0)
 ;;=4^I70.343
 ;;^UTILITY(U,$J,358.3,21385,2)
 ;;=^5007635
 ;;^UTILITY(U,$J,358.3,21386,0)
 ;;=I70.344^^73^930^48
 ;;^UTILITY(U,$J,358.3,21386,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21386,1,3,0)
 ;;=3^Athscl Bypass of Left Leg w/ Ulcer of Heel/Midfoot
 ;;^UTILITY(U,$J,358.3,21386,1,4,0)
 ;;=4^I70.344
 ;;^UTILITY(U,$J,358.3,21386,2)
 ;;=^5007636
 ;;^UTILITY(U,$J,358.3,21387,0)
 ;;=I70.345^^73^930^49
 ;;^UTILITY(U,$J,358.3,21387,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21387,1,3,0)
 ;;=3^Athscl Bypass of Left Leg w/ Ulcer of Oth Part of Foot
 ;;^UTILITY(U,$J,358.3,21387,1,4,0)
 ;;=4^I70.345
 ;;^UTILITY(U,$J,358.3,21387,2)
 ;;=^5007637
 ;;^UTILITY(U,$J,358.3,21388,0)
 ;;=I70.431^^73^930^41
 ;;^UTILITY(U,$J,358.3,21388,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21388,1,3,0)
 ;;=3^Athscl Autol Vein Bypass of Right Leg w/ Ulcer of Thigh
 ;;^UTILITY(U,$J,358.3,21388,1,4,0)
 ;;=4^I70.431
 ;;^UTILITY(U,$J,358.3,21388,2)
 ;;=^5007664
 ;;^UTILITY(U,$J,358.3,21389,0)
 ;;=I70.432^^73^930^42
 ;;^UTILITY(U,$J,358.3,21389,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21389,1,3,0)
 ;;=3^Athscl Autol Vein Bypass of Right Leg w/ Ulcer of Calf
 ;;^UTILITY(U,$J,358.3,21389,1,4,0)
 ;;=4^I70.432
 ;;^UTILITY(U,$J,358.3,21389,2)
 ;;=^5007665
 ;;^UTILITY(U,$J,358.3,21390,0)
 ;;=I70.433^^73^930^43
 ;;^UTILITY(U,$J,358.3,21390,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21390,1,3,0)
 ;;=3^Athscl Autol Vein Bypass of Right Leg w/ Ulcer of Ankle
 ;;^UTILITY(U,$J,358.3,21390,1,4,0)
 ;;=4^I70.433
 ;;^UTILITY(U,$J,358.3,21390,2)
 ;;=^5007666
 ;;^UTILITY(U,$J,358.3,21391,0)
 ;;=I70.434^^73^930^44
 ;;^UTILITY(U,$J,358.3,21391,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21391,1,3,0)
 ;;=3^Athscl Autol Vein Bypass of Right Leg w/ Ulcer of Heel/Midfoot
 ;;^UTILITY(U,$J,358.3,21391,1,4,0)
 ;;=4^I70.434
 ;;^UTILITY(U,$J,358.3,21391,2)
 ;;=^5007667
 ;;^UTILITY(U,$J,358.3,21392,0)
 ;;=I70.435^^73^930^45
 ;;^UTILITY(U,$J,358.3,21392,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21392,1,3,0)
 ;;=3^Athscl Autol Vein Bypass of Right Leg w/ Ulcer of Oth Part of Foot
 ;;^UTILITY(U,$J,358.3,21392,1,4,0)
 ;;=4^I70.435
 ;;^UTILITY(U,$J,358.3,21392,2)
 ;;=^5007668
 ;;^UTILITY(U,$J,358.3,21393,0)
 ;;=I70.441^^73^930^36
 ;;^UTILITY(U,$J,358.3,21393,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21393,1,3,0)
 ;;=3^Athscl Autol Vein Bypass of Left Leg w/ Ulcer of Thigh
 ;;^UTILITY(U,$J,358.3,21393,1,4,0)
 ;;=4^I70.441
 ;;^UTILITY(U,$J,358.3,21393,2)
 ;;=^5007671
 ;;^UTILITY(U,$J,358.3,21394,0)
 ;;=I70.442^^73^930^37
 ;;^UTILITY(U,$J,358.3,21394,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21394,1,3,0)
 ;;=3^Athscl Autol Vein Bypass of Left Leg w/ Ulcer of Calf
 ;;^UTILITY(U,$J,358.3,21394,1,4,0)
 ;;=4^I70.442
 ;;^UTILITY(U,$J,358.3,21394,2)
 ;;=^5007672
 ;;^UTILITY(U,$J,358.3,21395,0)
 ;;=I70.443^^73^930^38
 ;;^UTILITY(U,$J,358.3,21395,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21395,1,3,0)
 ;;=3^Athscl Autol Vein Bypass of Left Leg w/ Ulcer of Ankle
 ;;^UTILITY(U,$J,358.3,21395,1,4,0)
 ;;=4^I70.443
 ;;^UTILITY(U,$J,358.3,21395,2)
 ;;=^5007673
 ;;^UTILITY(U,$J,358.3,21396,0)
 ;;=I70.444^^73^930^39
 ;;^UTILITY(U,$J,358.3,21396,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21396,1,3,0)
 ;;=3^Athscl Autol Vein Bypass of Left Leg w/ Ulcer of Heel/Midfoot
 ;;^UTILITY(U,$J,358.3,21396,1,4,0)
 ;;=4^I70.444
 ;;^UTILITY(U,$J,358.3,21396,2)
 ;;=^5007674
 ;;^UTILITY(U,$J,358.3,21397,0)
 ;;=I70.445^^73^930^40
 ;;^UTILITY(U,$J,358.3,21397,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21397,1,3,0)
 ;;=3^Athscl Autol Vein Bypass of Left Leg w/ Ulcer of Oth Part of Foot
 ;;^UTILITY(U,$J,358.3,21397,1,4,0)
 ;;=4^I70.445
 ;;^UTILITY(U,$J,358.3,21397,2)
 ;;=^5007675
 ;;^UTILITY(U,$J,358.3,21398,0)
 ;;=I70.531^^73^930^61
 ;;^UTILITY(U,$J,358.3,21398,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21398,1,3,0)
 ;;=3^Athscl Nonaut Bio Bypass of Right Leg w/ Ulcer of Thigh
 ;;^UTILITY(U,$J,358.3,21398,1,4,0)
 ;;=4^I70.531
 ;;^UTILITY(U,$J,358.3,21398,2)
 ;;=^5007702
 ;;^UTILITY(U,$J,358.3,21399,0)
 ;;=I70.532^^73^930^62
 ;;^UTILITY(U,$J,358.3,21399,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21399,1,3,0)
 ;;=3^Athscl Nonaut Bio Bypass of Right Leg w/ Ulcer of Calf
 ;;^UTILITY(U,$J,358.3,21399,1,4,0)
 ;;=4^I70.532
 ;;^UTILITY(U,$J,358.3,21399,2)
 ;;=^5007703
 ;;^UTILITY(U,$J,358.3,21400,0)
 ;;=I70.533^^73^930^63
 ;;^UTILITY(U,$J,358.3,21400,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21400,1,3,0)
 ;;=3^Athscl Nonaut Bio Bypass of Right Leg w/ Ulcer of Ankle
 ;;^UTILITY(U,$J,358.3,21400,1,4,0)
 ;;=4^I70.533
 ;;^UTILITY(U,$J,358.3,21400,2)
 ;;=^5007704
 ;;^UTILITY(U,$J,358.3,21401,0)
 ;;=I70.534^^73^930^64
 ;;^UTILITY(U,$J,358.3,21401,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21401,1,3,0)
 ;;=3^Athscl Nonaut Bio Bypass of Right Leg w/ Ulcer of Heel/Midfoot
 ;;^UTILITY(U,$J,358.3,21401,1,4,0)
 ;;=4^I70.534
 ;;^UTILITY(U,$J,358.3,21401,2)
 ;;=^5007705
 ;;^UTILITY(U,$J,358.3,21402,0)
 ;;=I70.535^^73^930^65
 ;;^UTILITY(U,$J,358.3,21402,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21402,1,3,0)
 ;;=3^Athscl Nonaut Bio Bypass of Right Leg w/ Ulcer of Oth Part of Foot
 ;;^UTILITY(U,$J,358.3,21402,1,4,0)
 ;;=4^I70.535
 ;;^UTILITY(U,$J,358.3,21402,2)
 ;;=^5007706
 ;;^UTILITY(U,$J,358.3,21403,0)
 ;;=I70.541^^73^930^56
 ;;^UTILITY(U,$J,358.3,21403,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21403,1,3,0)
 ;;=3^Athscl Nonaut Bio Bypass of Left Leg w/ Ulcer of Thigh
 ;;^UTILITY(U,$J,358.3,21403,1,4,0)
 ;;=4^I70.541
 ;;^UTILITY(U,$J,358.3,21403,2)
 ;;=^5007709
 ;;^UTILITY(U,$J,358.3,21404,0)
 ;;=I70.542^^73^930^57
 ;;^UTILITY(U,$J,358.3,21404,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21404,1,3,0)
 ;;=3^Athscl Nonaut Bio Bypass of Left Leg w/ Ulcer of Calf
 ;;^UTILITY(U,$J,358.3,21404,1,4,0)
 ;;=4^I70.542
 ;;^UTILITY(U,$J,358.3,21404,2)
 ;;=^5007710
 ;;^UTILITY(U,$J,358.3,21405,0)
 ;;=I70.543^^73^930^58
 ;;^UTILITY(U,$J,358.3,21405,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21405,1,3,0)
 ;;=3^Athscl Nonaut Bio Bypass of Left Leg w/ Ulcer of Ankle
 ;;^UTILITY(U,$J,358.3,21405,1,4,0)
 ;;=4^I70.543
 ;;^UTILITY(U,$J,358.3,21405,2)
 ;;=^5007711
 ;;^UTILITY(U,$J,358.3,21406,0)
 ;;=I70.544^^73^930^59
 ;;^UTILITY(U,$J,358.3,21406,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21406,1,3,0)
 ;;=3^Athscl Nonaut Bio Bypass of Left Leg w/ Ulcer of Heel/Midfoot
 ;;^UTILITY(U,$J,358.3,21406,1,4,0)
 ;;=4^I70.544
 ;;^UTILITY(U,$J,358.3,21406,2)
 ;;=^5007712
 ;;^UTILITY(U,$J,358.3,21407,0)
 ;;=I70.545^^73^930^60
 ;;^UTILITY(U,$J,358.3,21407,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21407,1,3,0)
 ;;=3^Athscl Nonaut Bio Bypass of Left Leg w/ Ulcer of Oth Part of Foot
 ;;^UTILITY(U,$J,358.3,21407,1,4,0)
 ;;=4^I70.545
 ;;^UTILITY(U,$J,358.3,21407,2)
 ;;=^5007713
 ;;^UTILITY(U,$J,358.3,21408,0)
 ;;=I70.631^^73^930^71
 ;;^UTILITY(U,$J,358.3,21408,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21408,1,3,0)
 ;;=3^Athscl Nonbiol Bypass of Right Leg w/ Ulcer of Thigh
 ;;^UTILITY(U,$J,358.3,21408,1,4,0)
 ;;=4^I70.631
 ;;^UTILITY(U,$J,358.3,21408,2)
 ;;=^5007740
 ;;^UTILITY(U,$J,358.3,21409,0)
 ;;=I70.632^^73^930^72
 ;;^UTILITY(U,$J,358.3,21409,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21409,1,3,0)
 ;;=3^Athscl Nonbiol Bypass of Right Leg w/ Ulcer of Calf
 ;;^UTILITY(U,$J,358.3,21409,1,4,0)
 ;;=4^I70.632
 ;;^UTILITY(U,$J,358.3,21409,2)
 ;;=^5007741
 ;;^UTILITY(U,$J,358.3,21410,0)
 ;;=I70.633^^73^930^73
 ;;^UTILITY(U,$J,358.3,21410,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21410,1,3,0)
 ;;=3^Athscl Nonbiol Bypass of Right Leg w/ Ulcer of Ankle
 ;;^UTILITY(U,$J,358.3,21410,1,4,0)
 ;;=4^I70.633
 ;;^UTILITY(U,$J,358.3,21410,2)
 ;;=^5007742
 ;;^UTILITY(U,$J,358.3,21411,0)
 ;;=I70.634^^73^930^74
 ;;^UTILITY(U,$J,358.3,21411,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21411,1,3,0)
 ;;=3^Athscl Nonbiol Bypass of Right Leg w/ Ulcer of Heel/Midfoot
 ;;^UTILITY(U,$J,358.3,21411,1,4,0)
 ;;=4^I70.634
 ;;^UTILITY(U,$J,358.3,21411,2)
 ;;=^5007743
 ;;^UTILITY(U,$J,358.3,21412,0)
 ;;=I70.635^^73^930^75
 ;;^UTILITY(U,$J,358.3,21412,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21412,1,3,0)
 ;;=3^Athscl Nonbiol Bypass of Right Leg w/ Ulcer of Oth Part of Foot
 ;;^UTILITY(U,$J,358.3,21412,1,4,0)
 ;;=4^I70.635
 ;;^UTILITY(U,$J,358.3,21412,2)
 ;;=^5007744
 ;;^UTILITY(U,$J,358.3,21413,0)
 ;;=I70.641^^73^930^66
 ;;^UTILITY(U,$J,358.3,21413,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21413,1,3,0)
 ;;=3^Athscl Nonbiol Bypass of Left Leg w/ Ulcer of Thigh
 ;;^UTILITY(U,$J,358.3,21413,1,4,0)
 ;;=4^I70.641
 ;;^UTILITY(U,$J,358.3,21413,2)
 ;;=^5007747
 ;;^UTILITY(U,$J,358.3,21414,0)
 ;;=I70.642^^73^930^67
 ;;^UTILITY(U,$J,358.3,21414,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21414,1,3,0)
 ;;=3^Athscl Nonbiol Bypass of Left Leg w/ Ulcer of Calf
 ;;^UTILITY(U,$J,358.3,21414,1,4,0)
 ;;=4^I70.642
 ;;^UTILITY(U,$J,358.3,21414,2)
 ;;=^5007748
 ;;^UTILITY(U,$J,358.3,21415,0)
 ;;=I70.643^^73^930^68
 ;;^UTILITY(U,$J,358.3,21415,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21415,1,3,0)
 ;;=3^Athscl Nonbiol Bypass of Left Leg w/ Ulcer of Ankle
 ;;^UTILITY(U,$J,358.3,21415,1,4,0)
 ;;=4^I70.643
 ;;^UTILITY(U,$J,358.3,21415,2)
 ;;=^5007749
 ;;^UTILITY(U,$J,358.3,21416,0)
 ;;=I70.644^^73^930^69
 ;;^UTILITY(U,$J,358.3,21416,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21416,1,3,0)
 ;;=3^Athscl Nonbiol Bypass of Left Leg w/ Ulcer of Heel/Midfoot
 ;;^UTILITY(U,$J,358.3,21416,1,4,0)
 ;;=4^I70.644
 ;;^UTILITY(U,$J,358.3,21416,2)
 ;;=^5007750
 ;;^UTILITY(U,$J,358.3,21417,0)
 ;;=I70.645^^73^930^70
 ;;^UTILITY(U,$J,358.3,21417,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21417,1,3,0)
 ;;=3^Athscl Nonbiol Bypass of Left Leg w/ Ulcer of Oth Part of Foot
 ;;^UTILITY(U,$J,358.3,21417,1,4,0)
 ;;=4^I70.645
 ;;^UTILITY(U,$J,358.3,21417,2)
 ;;=^5007751
 ;;^UTILITY(U,$J,358.3,21418,0)
 ;;=K12.0^^73^930^298
 ;;^UTILITY(U,$J,358.3,21418,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21418,1,3,0)
 ;;=3^Recurrent Oral Aphthae
 ;;^UTILITY(U,$J,358.3,21418,1,4,0)
 ;;=4^K12.0
 ;;^UTILITY(U,$J,358.3,21418,2)
 ;;=^5008483
 ;;^UTILITY(U,$J,358.3,21419,0)
 ;;=K12.1^^73^930^311
 ;;^UTILITY(U,$J,358.3,21419,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21419,1,3,0)
 ;;=3^Stomatitis NEC
 ;;^UTILITY(U,$J,358.3,21419,1,4,0)
 ;;=4^K12.1
 ;;^UTILITY(U,$J,358.3,21419,2)
 ;;=^5008484
 ;;^UTILITY(U,$J,358.3,21420,0)
 ;;=K12.2^^73^930^95
 ;;^UTILITY(U,$J,358.3,21420,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21420,1,3,0)
 ;;=3^Cellulitis & Abscess of Mouth
 ;;^UTILITY(U,$J,358.3,21420,1,4,0)
 ;;=4^K12.2
 ;;^UTILITY(U,$J,358.3,21420,2)
 ;;=^5008485
 ;;^UTILITY(U,$J,358.3,21421,0)
 ;;=L02.01^^73^930^122
 ;;^UTILITY(U,$J,358.3,21421,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21421,1,3,0)
 ;;=3^Cutaneous Abscess of Face
 ;;^UTILITY(U,$J,358.3,21421,1,4,0)
 ;;=4^L02.01
 ;;^UTILITY(U,$J,358.3,21421,2)
 ;;=^5008944
 ;;^UTILITY(U,$J,358.3,21422,0)
 ;;=L02.11^^73^930^127
 ;;^UTILITY(U,$J,358.3,21422,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21422,1,3,0)
 ;;=3^Cutaneous Abscess of Neck
 ;;^UTILITY(U,$J,358.3,21422,1,4,0)
 ;;=4^L02.11
 ;;^UTILITY(U,$J,358.3,21422,2)
 ;;=^5008947
 ;;^UTILITY(U,$J,358.3,21423,0)
 ;;=L02.211^^73^930^119
 ;;^UTILITY(U,$J,358.3,21423,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21423,1,3,0)
 ;;=3^Cutaneous Abscess of Abdominal Wall
 ;;^UTILITY(U,$J,358.3,21423,1,4,0)
 ;;=4^L02.211
 ;;^UTILITY(U,$J,358.3,21423,2)
 ;;=^5008950
 ;;^UTILITY(U,$J,358.3,21424,0)
 ;;=L02.212^^73^930^120
 ;;^UTILITY(U,$J,358.3,21424,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21424,1,3,0)
 ;;=3^Cutaneous Abscess of Back
 ;;^UTILITY(U,$J,358.3,21424,1,4,0)
 ;;=4^L02.212
 ;;^UTILITY(U,$J,358.3,21424,2)
 ;;=^5008951
 ;;^UTILITY(U,$J,358.3,21425,0)
 ;;=L02.213^^73^930^121
 ;;^UTILITY(U,$J,358.3,21425,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21425,1,3,0)
 ;;=3^Cutaneous Abscess of Chest Wall
 ;;^UTILITY(U,$J,358.3,21425,1,4,0)
 ;;=4^L02.213
 ;;^UTILITY(U,$J,358.3,21425,2)
 ;;=^5008952
 ;;^UTILITY(U,$J,358.3,21426,0)
 ;;=L02.214^^73^930^123
 ;;^UTILITY(U,$J,358.3,21426,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21426,1,3,0)
 ;;=3^Cutaneous Abscess of Groin
 ;;^UTILITY(U,$J,358.3,21426,1,4,0)
 ;;=4^L02.214
 ;;^UTILITY(U,$J,358.3,21426,2)
 ;;=^5008953
 ;;^UTILITY(U,$J,358.3,21427,0)
 ;;=L02.215^^73^930^129
