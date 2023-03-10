IBDEI0EI ; ; 03-MAY-2022
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 03, 2022
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,36326,1,3,0)
 ;;=3^Atrial Fibrillation,Chronic,Unspec
 ;;^UTILITY(U,$J,358.3,36326,1,4,0)
 ;;=4^I48.20
 ;;^UTILITY(U,$J,358.3,36326,2)
 ;;=^5158048
 ;;^UTILITY(U,$J,358.3,36327,0)
 ;;=I48.11^^107^1476^3
 ;;^UTILITY(U,$J,358.3,36327,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36327,1,3,0)
 ;;=3^Atrial Fibrillation,Longstanding Persistent
 ;;^UTILITY(U,$J,358.3,36327,1,4,0)
 ;;=4^I48.11
 ;;^UTILITY(U,$J,358.3,36327,2)
 ;;=^5158046
 ;;^UTILITY(U,$J,358.3,36328,0)
 ;;=I48.19^^107^1476^4
 ;;^UTILITY(U,$J,358.3,36328,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36328,1,3,0)
 ;;=3^Atrial Fibrillation,Other Persistent
 ;;^UTILITY(U,$J,358.3,36328,1,4,0)
 ;;=4^I48.19
 ;;^UTILITY(U,$J,358.3,36328,2)
 ;;=^5158047
 ;;^UTILITY(U,$J,358.3,36329,0)
 ;;=I48.21^^107^1476^5
 ;;^UTILITY(U,$J,358.3,36329,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36329,1,3,0)
 ;;=3^Atrial Fibrillation,Permanent
 ;;^UTILITY(U,$J,358.3,36329,1,4,0)
 ;;=4^I48.21
 ;;^UTILITY(U,$J,358.3,36329,2)
 ;;=^304710
 ;;^UTILITY(U,$J,358.3,36330,0)
 ;;=I12.9^^107^1476^16
 ;;^UTILITY(U,$J,358.3,36330,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36330,1,3,0)
 ;;=3^Hypertensive CKD w/ Stg 1-4 CKD
 ;;^UTILITY(U,$J,358.3,36330,1,4,0)
 ;;=4^I12.9
 ;;^UTILITY(U,$J,358.3,36330,2)
 ;;=^5007066
 ;;^UTILITY(U,$J,358.3,36331,0)
 ;;=B07.9^^107^1477^328
 ;;^UTILITY(U,$J,358.3,36331,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36331,1,3,0)
 ;;=3^Viral Wart,Unspec
 ;;^UTILITY(U,$J,358.3,36331,1,4,0)
 ;;=4^B07.9
 ;;^UTILITY(U,$J,358.3,36331,2)
 ;;=^5000519
 ;;^UTILITY(U,$J,358.3,36332,0)
 ;;=A63.0^^107^1477^35
 ;;^UTILITY(U,$J,358.3,36332,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36332,1,3,0)
 ;;=3^Anogenital (Venereal) Warts
 ;;^UTILITY(U,$J,358.3,36332,1,4,0)
 ;;=4^A63.0
 ;;^UTILITY(U,$J,358.3,36332,2)
 ;;=^5000360
 ;;^UTILITY(U,$J,358.3,36333,0)
 ;;=B35.0^^107^1477^319
 ;;^UTILITY(U,$J,358.3,36333,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36333,1,3,0)
 ;;=3^Tinea Barbae and Tinea Capitis
 ;;^UTILITY(U,$J,358.3,36333,1,4,0)
 ;;=4^B35.0
 ;;^UTILITY(U,$J,358.3,36333,2)
 ;;=^5000604
 ;;^UTILITY(U,$J,358.3,36334,0)
 ;;=B35.1^^107^1477^324
 ;;^UTILITY(U,$J,358.3,36334,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36334,1,3,0)
 ;;=3^Tinea Unguium
 ;;^UTILITY(U,$J,358.3,36334,1,4,0)
 ;;=4^B35.1
 ;;^UTILITY(U,$J,358.3,36334,2)
 ;;=^119748
 ;;^UTILITY(U,$J,358.3,36335,0)
 ;;=B35.6^^107^1477^321
 ;;^UTILITY(U,$J,358.3,36335,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36335,1,3,0)
 ;;=3^Tinea Cruris
 ;;^UTILITY(U,$J,358.3,36335,1,4,0)
 ;;=4^B35.6
 ;;^UTILITY(U,$J,358.3,36335,2)
 ;;=^119711
 ;;^UTILITY(U,$J,358.3,36336,0)
 ;;=B35.3^^107^1477^323
 ;;^UTILITY(U,$J,358.3,36336,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36336,1,3,0)
 ;;=3^Tinea Pedis
 ;;^UTILITY(U,$J,358.3,36336,1,4,0)
 ;;=4^B35.3
 ;;^UTILITY(U,$J,358.3,36336,2)
 ;;=^119732
 ;;^UTILITY(U,$J,358.3,36337,0)
 ;;=B35.5^^107^1477^322
 ;;^UTILITY(U,$J,358.3,36337,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36337,1,3,0)
 ;;=3^Tinea Imbricata
 ;;^UTILITY(U,$J,358.3,36337,1,4,0)
 ;;=4^B35.5
 ;;^UTILITY(U,$J,358.3,36337,2)
 ;;=^119725
 ;;^UTILITY(U,$J,358.3,36338,0)
 ;;=B35.4^^107^1477^320
 ;;^UTILITY(U,$J,358.3,36338,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36338,1,3,0)
 ;;=3^Tinea Corporis
 ;;^UTILITY(U,$J,358.3,36338,1,4,0)
 ;;=4^B35.4
 ;;^UTILITY(U,$J,358.3,36338,2)
 ;;=^119704
 ;;^UTILITY(U,$J,358.3,36339,0)
 ;;=B35.8^^107^1477^140
 ;;^UTILITY(U,$J,358.3,36339,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36339,1,3,0)
 ;;=3^Dermatophytoses,Other
 ;;^UTILITY(U,$J,358.3,36339,1,4,0)
 ;;=4^B35.8
 ;;^UTILITY(U,$J,358.3,36339,2)
 ;;=^5000606
 ;;^UTILITY(U,$J,358.3,36340,0)
 ;;=B36.9^^107^1477^312
 ;;^UTILITY(U,$J,358.3,36340,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36340,1,3,0)
 ;;=3^Superficial Mycosis,Unspec
 ;;^UTILITY(U,$J,358.3,36340,1,4,0)
 ;;=4^B36.9
 ;;^UTILITY(U,$J,358.3,36340,2)
 ;;=^5000611
 ;;^UTILITY(U,$J,358.3,36341,0)
 ;;=D69.0^^107^1477^33
 ;;^UTILITY(U,$J,358.3,36341,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36341,1,3,0)
 ;;=3^Allergic Purpura
 ;;^UTILITY(U,$J,358.3,36341,1,4,0)
 ;;=4^D69.0
 ;;^UTILITY(U,$J,358.3,36341,2)
 ;;=^5002365
 ;;^UTILITY(U,$J,358.3,36342,0)
 ;;=B00.9^^107^1477^161
 ;;^UTILITY(U,$J,358.3,36342,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36342,1,3,0)
 ;;=3^Herpesviral Infection,Unspec
 ;;^UTILITY(U,$J,358.3,36342,1,4,0)
 ;;=4^B00.9
 ;;^UTILITY(U,$J,358.3,36342,2)
 ;;=^5000480
 ;;^UTILITY(U,$J,358.3,36343,0)
 ;;=B02.9^^107^1477^331
 ;;^UTILITY(U,$J,358.3,36343,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36343,1,3,0)
 ;;=3^Zoster w/o Complications
 ;;^UTILITY(U,$J,358.3,36343,1,4,0)
 ;;=4^B02.9
 ;;^UTILITY(U,$J,358.3,36343,2)
 ;;=^5000501
 ;;^UTILITY(U,$J,358.3,36344,0)
 ;;=D17.9^^107^1477^90
 ;;^UTILITY(U,$J,358.3,36344,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36344,1,3,0)
 ;;=3^Benign Lipomatous Neop,Unspec
 ;;^UTILITY(U,$J,358.3,36344,1,4,0)
 ;;=4^D17.9
 ;;^UTILITY(U,$J,358.3,36344,2)
 ;;=^5002020
 ;;^UTILITY(U,$J,358.3,36345,0)
 ;;=E08.621^^107^1477^137
 ;;^UTILITY(U,$J,358.3,36345,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36345,1,3,0)
 ;;=3^DM d/t Underlying Condition w/ Foot Ulcer
 ;;^UTILITY(U,$J,358.3,36345,1,4,0)
 ;;=4^E08.621
 ;;^UTILITY(U,$J,358.3,36345,2)
 ;;=^5002534
 ;;^UTILITY(U,$J,358.3,36346,0)
 ;;=E09.621^^107^1477^136
 ;;^UTILITY(U,$J,358.3,36346,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36346,1,3,0)
 ;;=3^DM d/t Drug/Chemical w/ Foot Ulcer
 ;;^UTILITY(U,$J,358.3,36346,1,4,0)
 ;;=4^E09.621
 ;;^UTILITY(U,$J,358.3,36346,2)
 ;;=^5002576
 ;;^UTILITY(U,$J,358.3,36347,0)
 ;;=H05.011^^107^1477^112
 ;;^UTILITY(U,$J,358.3,36347,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36347,1,3,0)
 ;;=3^Cellulitis of Right Orbit
 ;;^UTILITY(U,$J,358.3,36347,1,4,0)
 ;;=4^H05.011
 ;;^UTILITY(U,$J,358.3,36347,2)
 ;;=^5004560
 ;;^UTILITY(U,$J,358.3,36348,0)
 ;;=H05.012^^107^1477^105
 ;;^UTILITY(U,$J,358.3,36348,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36348,1,3,0)
 ;;=3^Cellulitis of Left Orbit
 ;;^UTILITY(U,$J,358.3,36348,1,4,0)
 ;;=4^H05.012
 ;;^UTILITY(U,$J,358.3,36348,2)
 ;;=^5004561
 ;;^UTILITY(U,$J,358.3,36349,0)
 ;;=H05.013^^107^1477^99
 ;;^UTILITY(U,$J,358.3,36349,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36349,1,3,0)
 ;;=3^Cellulitis of Bilateral Orbits
 ;;^UTILITY(U,$J,358.3,36349,1,4,0)
 ;;=4^H05.013
 ;;^UTILITY(U,$J,358.3,36349,2)
 ;;=^5004562
 ;;^UTILITY(U,$J,358.3,36350,0)
 ;;=I70.331^^107^1477^51
 ;;^UTILITY(U,$J,358.3,36350,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36350,1,3,0)
 ;;=3^Athscl Bypass of Right Leg w/ Ulcer of Thigh
 ;;^UTILITY(U,$J,358.3,36350,1,4,0)
 ;;=4^I70.331
 ;;^UTILITY(U,$J,358.3,36350,2)
 ;;=^5007626
 ;;^UTILITY(U,$J,358.3,36351,0)
 ;;=I70.332^^107^1477^52
 ;;^UTILITY(U,$J,358.3,36351,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36351,1,3,0)
 ;;=3^Athscl Bypass of Right Leg w/ Ulcer of Calf
 ;;^UTILITY(U,$J,358.3,36351,1,4,0)
 ;;=4^I70.332
 ;;^UTILITY(U,$J,358.3,36351,2)
 ;;=^5007627
 ;;^UTILITY(U,$J,358.3,36352,0)
 ;;=I70.333^^107^1477^53
 ;;^UTILITY(U,$J,358.3,36352,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36352,1,3,0)
 ;;=3^Athscl Bypass of Right Leg w/ Ulcer of Ankle
 ;;^UTILITY(U,$J,358.3,36352,1,4,0)
 ;;=4^I70.333
 ;;^UTILITY(U,$J,358.3,36352,2)
 ;;=^5007628
 ;;^UTILITY(U,$J,358.3,36353,0)
 ;;=I70.334^^107^1477^54
 ;;^UTILITY(U,$J,358.3,36353,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36353,1,3,0)
 ;;=3^Athscl Bypass of Right Leg w/ Ulcer of Heel/Midfoot
 ;;^UTILITY(U,$J,358.3,36353,1,4,0)
 ;;=4^I70.334
 ;;^UTILITY(U,$J,358.3,36353,2)
 ;;=^5007629
 ;;^UTILITY(U,$J,358.3,36354,0)
 ;;=I70.335^^107^1477^55
 ;;^UTILITY(U,$J,358.3,36354,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36354,1,3,0)
 ;;=3^Athscl Bypass of Right Leg w/ Ulcer of Oth Part of Foot
 ;;^UTILITY(U,$J,358.3,36354,1,4,0)
 ;;=4^I70.335
 ;;^UTILITY(U,$J,358.3,36354,2)
 ;;=^5007630
 ;;^UTILITY(U,$J,358.3,36355,0)
 ;;=I70.341^^107^1477^50
 ;;^UTILITY(U,$J,358.3,36355,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36355,1,3,0)
 ;;=3^Athscl Bypass of Left Leg w/ Ulcer of Thigh
 ;;^UTILITY(U,$J,358.3,36355,1,4,0)
 ;;=4^I70.341
 ;;^UTILITY(U,$J,358.3,36355,2)
 ;;=^5007633
 ;;^UTILITY(U,$J,358.3,36356,0)
 ;;=I70.342^^107^1477^47
 ;;^UTILITY(U,$J,358.3,36356,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36356,1,3,0)
 ;;=3^Athscl Bypass of Left Leg w/ Ulcer of Calf
 ;;^UTILITY(U,$J,358.3,36356,1,4,0)
 ;;=4^I70.342
 ;;^UTILITY(U,$J,358.3,36356,2)
 ;;=^5007634
 ;;^UTILITY(U,$J,358.3,36357,0)
 ;;=I70.343^^107^1477^46
 ;;^UTILITY(U,$J,358.3,36357,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36357,1,3,0)
 ;;=3^Athscl Bypass of Left Leg w/ Ulcer of Ankle
 ;;^UTILITY(U,$J,358.3,36357,1,4,0)
 ;;=4^I70.343
 ;;^UTILITY(U,$J,358.3,36357,2)
 ;;=^5007635
 ;;^UTILITY(U,$J,358.3,36358,0)
 ;;=I70.344^^107^1477^48
 ;;^UTILITY(U,$J,358.3,36358,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36358,1,3,0)
 ;;=3^Athscl Bypass of Left Leg w/ Ulcer of Heel/Midfoot
 ;;^UTILITY(U,$J,358.3,36358,1,4,0)
 ;;=4^I70.344
 ;;^UTILITY(U,$J,358.3,36358,2)
 ;;=^5007636
 ;;^UTILITY(U,$J,358.3,36359,0)
 ;;=I70.345^^107^1477^49
 ;;^UTILITY(U,$J,358.3,36359,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36359,1,3,0)
 ;;=3^Athscl Bypass of Left Leg w/ Ulcer of Oth Part of Foot
 ;;^UTILITY(U,$J,358.3,36359,1,4,0)
 ;;=4^I70.345
 ;;^UTILITY(U,$J,358.3,36359,2)
 ;;=^5007637
 ;;^UTILITY(U,$J,358.3,36360,0)
 ;;=I70.431^^107^1477^41
 ;;^UTILITY(U,$J,358.3,36360,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36360,1,3,0)
 ;;=3^Athscl Autol Vein Bypass of Right Leg w/ Ulcer of Thigh
 ;;^UTILITY(U,$J,358.3,36360,1,4,0)
 ;;=4^I70.431
 ;;^UTILITY(U,$J,358.3,36360,2)
 ;;=^5007664
 ;;^UTILITY(U,$J,358.3,36361,0)
 ;;=I70.432^^107^1477^42
 ;;^UTILITY(U,$J,358.3,36361,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36361,1,3,0)
 ;;=3^Athscl Autol Vein Bypass of Right Leg w/ Ulcer of Calf
 ;;^UTILITY(U,$J,358.3,36361,1,4,0)
 ;;=4^I70.432
 ;;^UTILITY(U,$J,358.3,36361,2)
 ;;=^5007665
 ;;^UTILITY(U,$J,358.3,36362,0)
 ;;=I70.433^^107^1477^43
 ;;^UTILITY(U,$J,358.3,36362,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36362,1,3,0)
 ;;=3^Athscl Autol Vein Bypass of Right Leg w/ Ulcer of Ankle
 ;;^UTILITY(U,$J,358.3,36362,1,4,0)
 ;;=4^I70.433
 ;;^UTILITY(U,$J,358.3,36362,2)
 ;;=^5007666
 ;;^UTILITY(U,$J,358.3,36363,0)
 ;;=I70.434^^107^1477^44
 ;;^UTILITY(U,$J,358.3,36363,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36363,1,3,0)
 ;;=3^Athscl Autol Vein Bypass of Right Leg w/ Ulcer of Heel/Midfoot
 ;;^UTILITY(U,$J,358.3,36363,1,4,0)
 ;;=4^I70.434
 ;;^UTILITY(U,$J,358.3,36363,2)
 ;;=^5007667
 ;;^UTILITY(U,$J,358.3,36364,0)
 ;;=I70.435^^107^1477^45
 ;;^UTILITY(U,$J,358.3,36364,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36364,1,3,0)
 ;;=3^Athscl Autol Vein Bypass of Right Leg w/ Ulcer of Oth Part of Foot
 ;;^UTILITY(U,$J,358.3,36364,1,4,0)
 ;;=4^I70.435
 ;;^UTILITY(U,$J,358.3,36364,2)
 ;;=^5007668
 ;;^UTILITY(U,$J,358.3,36365,0)
 ;;=I70.441^^107^1477^36
 ;;^UTILITY(U,$J,358.3,36365,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36365,1,3,0)
 ;;=3^Athscl Autol Vein Bypass of Left Leg w/ Ulcer of Thigh
 ;;^UTILITY(U,$J,358.3,36365,1,4,0)
 ;;=4^I70.441
 ;;^UTILITY(U,$J,358.3,36365,2)
 ;;=^5007671
 ;;^UTILITY(U,$J,358.3,36366,0)
 ;;=I70.442^^107^1477^37
 ;;^UTILITY(U,$J,358.3,36366,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36366,1,3,0)
 ;;=3^Athscl Autol Vein Bypass of Left Leg w/ Ulcer of Calf
 ;;^UTILITY(U,$J,358.3,36366,1,4,0)
 ;;=4^I70.442
 ;;^UTILITY(U,$J,358.3,36366,2)
 ;;=^5007672
 ;;^UTILITY(U,$J,358.3,36367,0)
 ;;=I70.443^^107^1477^38
 ;;^UTILITY(U,$J,358.3,36367,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36367,1,3,0)
 ;;=3^Athscl Autol Vein Bypass of Left Leg w/ Ulcer of Ankle
 ;;^UTILITY(U,$J,358.3,36367,1,4,0)
 ;;=4^I70.443
 ;;^UTILITY(U,$J,358.3,36367,2)
 ;;=^5007673
 ;;^UTILITY(U,$J,358.3,36368,0)
 ;;=I70.444^^107^1477^39
 ;;^UTILITY(U,$J,358.3,36368,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36368,1,3,0)
 ;;=3^Athscl Autol Vein Bypass of Left Leg w/ Ulcer of Heel/Midfoot
 ;;^UTILITY(U,$J,358.3,36368,1,4,0)
 ;;=4^I70.444
 ;;^UTILITY(U,$J,358.3,36368,2)
 ;;=^5007674
 ;;^UTILITY(U,$J,358.3,36369,0)
 ;;=I70.445^^107^1477^40
 ;;^UTILITY(U,$J,358.3,36369,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36369,1,3,0)
 ;;=3^Athscl Autol Vein Bypass of Left Leg w/ Ulcer of Oth Part of Foot
 ;;^UTILITY(U,$J,358.3,36369,1,4,0)
 ;;=4^I70.445
 ;;^UTILITY(U,$J,358.3,36369,2)
 ;;=^5007675
 ;;^UTILITY(U,$J,358.3,36370,0)
 ;;=I70.531^^107^1477^61
 ;;^UTILITY(U,$J,358.3,36370,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36370,1,3,0)
 ;;=3^Athscl Nonaut Bio Bypass of Right Leg w/ Ulcer of Thigh
 ;;^UTILITY(U,$J,358.3,36370,1,4,0)
 ;;=4^I70.531
 ;;^UTILITY(U,$J,358.3,36370,2)
 ;;=^5007702
 ;;^UTILITY(U,$J,358.3,36371,0)
 ;;=I70.532^^107^1477^62
 ;;^UTILITY(U,$J,358.3,36371,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36371,1,3,0)
 ;;=3^Athscl Nonaut Bio Bypass of Right Leg w/ Ulcer of Calf
 ;;^UTILITY(U,$J,358.3,36371,1,4,0)
 ;;=4^I70.532
 ;;^UTILITY(U,$J,358.3,36371,2)
 ;;=^5007703
 ;;^UTILITY(U,$J,358.3,36372,0)
 ;;=I70.533^^107^1477^63
 ;;^UTILITY(U,$J,358.3,36372,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36372,1,3,0)
 ;;=3^Athscl Nonaut Bio Bypass of Right Leg w/ Ulcer of Ankle
 ;;^UTILITY(U,$J,358.3,36372,1,4,0)
 ;;=4^I70.533
 ;;^UTILITY(U,$J,358.3,36372,2)
 ;;=^5007704
 ;;^UTILITY(U,$J,358.3,36373,0)
 ;;=I70.534^^107^1477^64
 ;;^UTILITY(U,$J,358.3,36373,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36373,1,3,0)
 ;;=3^Athscl Nonaut Bio Bypass of Right Leg w/ Ulcer of Heel/Midfoot
 ;;^UTILITY(U,$J,358.3,36373,1,4,0)
 ;;=4^I70.534
 ;;^UTILITY(U,$J,358.3,36373,2)
 ;;=^5007705
 ;;^UTILITY(U,$J,358.3,36374,0)
 ;;=I70.535^^107^1477^65
 ;;^UTILITY(U,$J,358.3,36374,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36374,1,3,0)
 ;;=3^Athscl Nonaut Bio Bypass of Right Leg w/ Ulcer of Oth Part of Foot
 ;;^UTILITY(U,$J,358.3,36374,1,4,0)
 ;;=4^I70.535
 ;;^UTILITY(U,$J,358.3,36374,2)
 ;;=^5007706
 ;;^UTILITY(U,$J,358.3,36375,0)
 ;;=I70.541^^107^1477^56
 ;;^UTILITY(U,$J,358.3,36375,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36375,1,3,0)
 ;;=3^Athscl Nonaut Bio Bypass of Left Leg w/ Ulcer of Thigh
 ;;^UTILITY(U,$J,358.3,36375,1,4,0)
 ;;=4^I70.541
 ;;^UTILITY(U,$J,358.3,36375,2)
 ;;=^5007709
 ;;^UTILITY(U,$J,358.3,36376,0)
 ;;=I70.542^^107^1477^57
 ;;^UTILITY(U,$J,358.3,36376,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36376,1,3,0)
 ;;=3^Athscl Nonaut Bio Bypass of Left Leg w/ Ulcer of Calf
 ;;^UTILITY(U,$J,358.3,36376,1,4,0)
 ;;=4^I70.542
 ;;^UTILITY(U,$J,358.3,36376,2)
 ;;=^5007710
 ;;^UTILITY(U,$J,358.3,36377,0)
 ;;=I70.543^^107^1477^58
 ;;^UTILITY(U,$J,358.3,36377,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36377,1,3,0)
 ;;=3^Athscl Nonaut Bio Bypass of Left Leg w/ Ulcer of Ankle
 ;;^UTILITY(U,$J,358.3,36377,1,4,0)
 ;;=4^I70.543
 ;;^UTILITY(U,$J,358.3,36377,2)
 ;;=^5007711
 ;;^UTILITY(U,$J,358.3,36378,0)
 ;;=I70.544^^107^1477^59
 ;;^UTILITY(U,$J,358.3,36378,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36378,1,3,0)
 ;;=3^Athscl Nonaut Bio Bypass of Left Leg w/ Ulcer of Heel/Midfoot
 ;;^UTILITY(U,$J,358.3,36378,1,4,0)
 ;;=4^I70.544
 ;;^UTILITY(U,$J,358.3,36378,2)
 ;;=^5007712
 ;;^UTILITY(U,$J,358.3,36379,0)
 ;;=I70.545^^107^1477^60
 ;;^UTILITY(U,$J,358.3,36379,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36379,1,3,0)
 ;;=3^Athscl Nonaut Bio Bypass of Left Leg w/ Ulcer of Oth Part of Foot
 ;;^UTILITY(U,$J,358.3,36379,1,4,0)
 ;;=4^I70.545
 ;;^UTILITY(U,$J,358.3,36379,2)
 ;;=^5007713
 ;;^UTILITY(U,$J,358.3,36380,0)
 ;;=I70.631^^107^1477^71
 ;;^UTILITY(U,$J,358.3,36380,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36380,1,3,0)
 ;;=3^Athscl Nonbiol Bypass of Right Leg w/ Ulcer of Thigh
 ;;^UTILITY(U,$J,358.3,36380,1,4,0)
 ;;=4^I70.631
 ;;^UTILITY(U,$J,358.3,36380,2)
 ;;=^5007740
 ;;^UTILITY(U,$J,358.3,36381,0)
 ;;=I70.632^^107^1477^72
 ;;^UTILITY(U,$J,358.3,36381,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36381,1,3,0)
 ;;=3^Athscl Nonbiol Bypass of Right Leg w/ Ulcer of Calf
 ;;^UTILITY(U,$J,358.3,36381,1,4,0)
 ;;=4^I70.632
 ;;^UTILITY(U,$J,358.3,36381,2)
 ;;=^5007741
 ;;^UTILITY(U,$J,358.3,36382,0)
 ;;=I70.633^^107^1477^73
 ;;^UTILITY(U,$J,358.3,36382,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36382,1,3,0)
 ;;=3^Athscl Nonbiol Bypass of Right Leg w/ Ulcer of Ankle
 ;;^UTILITY(U,$J,358.3,36382,1,4,0)
 ;;=4^I70.633
 ;;^UTILITY(U,$J,358.3,36382,2)
 ;;=^5007742
 ;;^UTILITY(U,$J,358.3,36383,0)
 ;;=I70.634^^107^1477^74
 ;;^UTILITY(U,$J,358.3,36383,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36383,1,3,0)
 ;;=3^Athscl Nonbiol Bypass of Right Leg w/ Ulcer of Heel/Midfoot
 ;;^UTILITY(U,$J,358.3,36383,1,4,0)
 ;;=4^I70.634
 ;;^UTILITY(U,$J,358.3,36383,2)
 ;;=^5007743
 ;;^UTILITY(U,$J,358.3,36384,0)
 ;;=I70.635^^107^1477^75
 ;;^UTILITY(U,$J,358.3,36384,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36384,1,3,0)
 ;;=3^Athscl Nonbiol Bypass of Right Leg w/ Ulcer of Oth Part of Foot
 ;;^UTILITY(U,$J,358.3,36384,1,4,0)
 ;;=4^I70.635
 ;;^UTILITY(U,$J,358.3,36384,2)
 ;;=^5007744
 ;;^UTILITY(U,$J,358.3,36385,0)
 ;;=I70.641^^107^1477^66
 ;;^UTILITY(U,$J,358.3,36385,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36385,1,3,0)
 ;;=3^Athscl Nonbiol Bypass of Left Leg w/ Ulcer of Thigh
 ;;^UTILITY(U,$J,358.3,36385,1,4,0)
 ;;=4^I70.641
 ;;^UTILITY(U,$J,358.3,36385,2)
 ;;=^5007747
 ;;^UTILITY(U,$J,358.3,36386,0)
 ;;=I70.642^^107^1477^67
 ;;^UTILITY(U,$J,358.3,36386,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36386,1,3,0)
 ;;=3^Athscl Nonbiol Bypass of Left Leg w/ Ulcer of Calf
 ;;^UTILITY(U,$J,358.3,36386,1,4,0)
 ;;=4^I70.642
 ;;^UTILITY(U,$J,358.3,36386,2)
 ;;=^5007748
 ;;^UTILITY(U,$J,358.3,36387,0)
 ;;=I70.643^^107^1477^68
 ;;^UTILITY(U,$J,358.3,36387,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36387,1,3,0)
 ;;=3^Athscl Nonbiol Bypass of Left Leg w/ Ulcer of Ankle
 ;;^UTILITY(U,$J,358.3,36387,1,4,0)
 ;;=4^I70.643
 ;;^UTILITY(U,$J,358.3,36387,2)
 ;;=^5007749
 ;;^UTILITY(U,$J,358.3,36388,0)
 ;;=I70.644^^107^1477^69
 ;;^UTILITY(U,$J,358.3,36388,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36388,1,3,0)
 ;;=3^Athscl Nonbiol Bypass of Left Leg w/ Ulcer of Heel/Midfoot
 ;;^UTILITY(U,$J,358.3,36388,1,4,0)
 ;;=4^I70.644
 ;;^UTILITY(U,$J,358.3,36388,2)
 ;;=^5007750
 ;;^UTILITY(U,$J,358.3,36389,0)
 ;;=I70.645^^107^1477^70
 ;;^UTILITY(U,$J,358.3,36389,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36389,1,3,0)
 ;;=3^Athscl Nonbiol Bypass of Left Leg w/ Ulcer of Oth Part of Foot
 ;;^UTILITY(U,$J,358.3,36389,1,4,0)
 ;;=4^I70.645
 ;;^UTILITY(U,$J,358.3,36389,2)
 ;;=^5007751
 ;;^UTILITY(U,$J,358.3,36390,0)
 ;;=K12.0^^107^1477^298
 ;;^UTILITY(U,$J,358.3,36390,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36390,1,3,0)
 ;;=3^Recurrent Oral Aphthae
 ;;^UTILITY(U,$J,358.3,36390,1,4,0)
 ;;=4^K12.0
 ;;^UTILITY(U,$J,358.3,36390,2)
 ;;=^5008483
 ;;^UTILITY(U,$J,358.3,36391,0)
 ;;=K12.1^^107^1477^311
 ;;^UTILITY(U,$J,358.3,36391,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36391,1,3,0)
 ;;=3^Stomatitis NEC
