IBDEI017 ; ; 01-MAY-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 01, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,2407,0)
 ;;=96171^^22^182^5^^^^1
 ;;^UTILITY(U,$J,358.3,2407,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2407,1,2,0)
 ;;=2^96171
 ;;^UTILITY(U,$J,358.3,2407,1,3,0)
 ;;=3^Hlth/Behav Intrvn,Fam w/o Pt,Ea Addl 15 min
 ;;^UTILITY(U,$J,358.3,2408,0)
 ;;=99366^^22^183^1^^^^1
 ;;^UTILITY(U,$J,358.3,2408,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2408,1,2,0)
 ;;=2^99366
 ;;^UTILITY(U,$J,358.3,2408,1,3,0)
 ;;=3^Interdisc. Team Mtg. w/Pt w/o Physician
 ;;^UTILITY(U,$J,358.3,2409,0)
 ;;=99368^^22^183^3^^^^1
 ;;^UTILITY(U,$J,358.3,2409,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2409,1,2,0)
 ;;=2^99368
 ;;^UTILITY(U,$J,358.3,2409,1,3,0)
 ;;=3^Interdisc. Team Mtg. w/o Pt w/o Physician
 ;;^UTILITY(U,$J,358.3,2410,0)
 ;;=99367^^22^183^2^^^^1
 ;;^UTILITY(U,$J,358.3,2410,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2410,1,2,0)
 ;;=2^99367
 ;;^UTILITY(U,$J,358.3,2410,1,3,0)
 ;;=3^Interdisc. Mtg w/o Pt w/ Physician
 ;;^UTILITY(U,$J,358.3,2411,0)
 ;;=99600^^22^184^1^^^^1
 ;;^UTILITY(U,$J,358.3,2411,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2411,1,2,0)
 ;;=2^99600
 ;;^UTILITY(U,$J,358.3,2411,1,3,0)
 ;;=3^Home Visit by Nonphysician
 ;;^UTILITY(U,$J,358.3,2412,0)
 ;;=H52.521^^23^185^58
 ;;^UTILITY(U,$J,358.3,2412,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2412,1,3,0)
 ;;=3^Paresis of Accommodation,Right Eye
 ;;^UTILITY(U,$J,358.3,2412,1,4,0)
 ;;=4^H52.521
 ;;^UTILITY(U,$J,358.3,2412,2)
 ;;=^5006282
 ;;^UTILITY(U,$J,358.3,2413,0)
 ;;=H52.522^^23^185^57
 ;;^UTILITY(U,$J,358.3,2413,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2413,1,3,0)
 ;;=3^Paresis of Accommodation,Left Eye
 ;;^UTILITY(U,$J,358.3,2413,1,4,0)
 ;;=4^H52.522
 ;;^UTILITY(U,$J,358.3,2413,2)
 ;;=^5006283
 ;;^UTILITY(U,$J,358.3,2414,0)
 ;;=H52.523^^23^185^56
 ;;^UTILITY(U,$J,358.3,2414,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2414,1,3,0)
 ;;=3^Paresis of Accommodation,Bilateral
 ;;^UTILITY(U,$J,358.3,2414,1,4,0)
 ;;=4^H52.523
 ;;^UTILITY(U,$J,358.3,2414,2)
 ;;=^5006284
 ;;^UTILITY(U,$J,358.3,2415,0)
 ;;=H53.141^^23^185^67
 ;;^UTILITY(U,$J,358.3,2415,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2415,1,3,0)
 ;;=3^Visual Discomfort,Right Eye
 ;;^UTILITY(U,$J,358.3,2415,1,4,0)
 ;;=4^H53.141
 ;;^UTILITY(U,$J,358.3,2415,2)
 ;;=^5006317
 ;;^UTILITY(U,$J,358.3,2416,0)
 ;;=H53.142^^23^185^66
 ;;^UTILITY(U,$J,358.3,2416,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2416,1,3,0)
 ;;=3^Visual Discomfort,Left Eye
 ;;^UTILITY(U,$J,358.3,2416,1,4,0)
 ;;=4^H53.142
 ;;^UTILITY(U,$J,358.3,2416,2)
 ;;=^5006318
 ;;^UTILITY(U,$J,358.3,2417,0)
 ;;=H53.143^^23^185^65
 ;;^UTILITY(U,$J,358.3,2417,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2417,1,3,0)
 ;;=3^Visual Discomfort,Bilateral
 ;;^UTILITY(U,$J,358.3,2417,1,4,0)
 ;;=4^H53.143
 ;;^UTILITY(U,$J,358.3,2417,2)
 ;;=^5006319
 ;;^UTILITY(U,$J,358.3,2418,0)
 ;;=H53.19^^23^185^69
 ;;^UTILITY(U,$J,358.3,2418,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2418,1,3,0)
 ;;=3^Visual Disturbances,Subjective
 ;;^UTILITY(U,$J,358.3,2418,1,4,0)
 ;;=4^H53.19
 ;;^UTILITY(U,$J,358.3,2418,2)
 ;;=^5006321
 ;;^UTILITY(U,$J,358.3,2419,0)
 ;;=H53.2^^23^185^30
 ;;^UTILITY(U,$J,358.3,2419,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2419,1,3,0)
 ;;=3^Diplopia
 ;;^UTILITY(U,$J,358.3,2419,1,4,0)
 ;;=4^H53.2
 ;;^UTILITY(U,$J,358.3,2419,2)
 ;;=^35208
 ;;^UTILITY(U,$J,358.3,2420,0)
 ;;=H53.30^^23^185^3
 ;;^UTILITY(U,$J,358.3,2420,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2420,1,3,0)
 ;;=3^Binocular Vision Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,2420,1,4,0)
 ;;=4^H53.30
 ;;^UTILITY(U,$J,358.3,2420,2)
 ;;=^5006322
 ;;^UTILITY(U,$J,358.3,2421,0)
 ;;=H53.34^^23^185^4
 ;;^UTILITY(U,$J,358.3,2421,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2421,1,3,0)
 ;;=3^Binocular Vision,Suppression
 ;;^UTILITY(U,$J,358.3,2421,1,4,0)
 ;;=4^H53.34
 ;;^UTILITY(U,$J,358.3,2421,2)
 ;;=^5006323
 ;;^UTILITY(U,$J,358.3,2422,0)
 ;;=H53.33^^23^185^61
 ;;^UTILITY(U,$J,358.3,2422,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2422,1,3,0)
 ;;=3^Simultaneous Visual Perception w/o Fusion
 ;;^UTILITY(U,$J,358.3,2422,1,4,0)
 ;;=4^H53.33
 ;;^UTILITY(U,$J,358.3,2422,2)
 ;;=^268841
 ;;^UTILITY(U,$J,358.3,2423,0)
 ;;=H53.31^^23^185^59
 ;;^UTILITY(U,$J,358.3,2423,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2423,1,3,0)
 ;;=3^Retinal Correspondence,Abnormal
 ;;^UTILITY(U,$J,358.3,2423,1,4,0)
 ;;=4^H53.31
 ;;^UTILITY(U,$J,358.3,2423,2)
 ;;=^268844
 ;;^UTILITY(U,$J,358.3,2424,0)
 ;;=H53.40^^23^185^76
 ;;^UTILITY(U,$J,358.3,2424,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2424,1,3,0)
 ;;=3^Visual Field Defects,Unspec
 ;;^UTILITY(U,$J,358.3,2424,1,4,0)
 ;;=4^H53.40
 ;;^UTILITY(U,$J,358.3,2424,2)
 ;;=^5006324
 ;;^UTILITY(U,$J,358.3,2425,0)
 ;;=H53.411^^23^185^26
 ;;^UTILITY(U,$J,358.3,2425,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2425,1,3,0)
 ;;=3^Central Area Scotoma,Right Eye
 ;;^UTILITY(U,$J,358.3,2425,1,4,0)
 ;;=4^H53.411
 ;;^UTILITY(U,$J,358.3,2425,2)
 ;;=^5006325
 ;;^UTILITY(U,$J,358.3,2426,0)
 ;;=H53.412^^23^185^25
 ;;^UTILITY(U,$J,358.3,2426,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2426,1,3,0)
 ;;=3^Central Area Scotoma,Left Eye
 ;;^UTILITY(U,$J,358.3,2426,1,4,0)
 ;;=4^H53.412
 ;;^UTILITY(U,$J,358.3,2426,2)
 ;;=^5006326
 ;;^UTILITY(U,$J,358.3,2427,0)
 ;;=H53.413^^23^185^24
 ;;^UTILITY(U,$J,358.3,2427,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2427,1,3,0)
 ;;=3^Central Area Scotoma,Bilateral
 ;;^UTILITY(U,$J,358.3,2427,1,4,0)
 ;;=4^H53.413
 ;;^UTILITY(U,$J,358.3,2427,2)
 ;;=^5006327
 ;;^UTILITY(U,$J,358.3,2428,0)
 ;;=H53.451^^23^185^75
 ;;^UTILITY(U,$J,358.3,2428,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2428,1,3,0)
 ;;=3^Visual Field Defect,Localized,Right Eye
 ;;^UTILITY(U,$J,358.3,2428,1,4,0)
 ;;=4^H53.451
 ;;^UTILITY(U,$J,358.3,2428,2)
 ;;=^5006337
 ;;^UTILITY(U,$J,358.3,2429,0)
 ;;=H53.452^^23^185^74
 ;;^UTILITY(U,$J,358.3,2429,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2429,1,3,0)
 ;;=3^Visual Field Defect,Localized,Left Eye
 ;;^UTILITY(U,$J,358.3,2429,1,4,0)
 ;;=4^H53.452
 ;;^UTILITY(U,$J,358.3,2429,2)
 ;;=^5006338
 ;;^UTILITY(U,$J,358.3,2430,0)
 ;;=H53.453^^23^185^73
 ;;^UTILITY(U,$J,358.3,2430,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2430,1,3,0)
 ;;=3^Visual Field Defect,Localized,Bilateral
 ;;^UTILITY(U,$J,358.3,2430,1,4,0)
 ;;=4^H53.453
 ;;^UTILITY(U,$J,358.3,2430,2)
 ;;=^5006339
 ;;^UTILITY(U,$J,358.3,2431,0)
 ;;=H53.481^^23^185^72
 ;;^UTILITY(U,$J,358.3,2431,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2431,1,3,0)
 ;;=3^Visual Field Contraction,Right Eye
 ;;^UTILITY(U,$J,358.3,2431,1,4,0)
 ;;=4^H53.481
 ;;^UTILITY(U,$J,358.3,2431,2)
 ;;=^5006344
 ;;^UTILITY(U,$J,358.3,2432,0)
 ;;=H53.482^^23^185^71
 ;;^UTILITY(U,$J,358.3,2432,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2432,1,3,0)
 ;;=3^Visual Field Contraction,Left Eye
 ;;^UTILITY(U,$J,358.3,2432,1,4,0)
 ;;=4^H53.482
 ;;^UTILITY(U,$J,358.3,2432,2)
 ;;=^5006345
 ;;^UTILITY(U,$J,358.3,2433,0)
 ;;=H53.483^^23^185^70
 ;;^UTILITY(U,$J,358.3,2433,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2433,1,3,0)
 ;;=3^Visual Field Contraction,Bilateral
 ;;^UTILITY(U,$J,358.3,2433,1,4,0)
 ;;=4^H53.483
 ;;^UTILITY(U,$J,358.3,2433,2)
 ;;=^5006346
 ;;^UTILITY(U,$J,358.3,2434,0)
 ;;=H53.461^^23^185^35
 ;;^UTILITY(U,$J,358.3,2434,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2434,1,3,0)
 ;;=3^Homonymous Bilateral Field Defects,Right Side
 ;;^UTILITY(U,$J,358.3,2434,1,4,0)
 ;;=4^H53.461
 ;;^UTILITY(U,$J,358.3,2434,2)
 ;;=^5006341
 ;;^UTILITY(U,$J,358.3,2435,0)
 ;;=H53.462^^23^185^34
 ;;^UTILITY(U,$J,358.3,2435,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2435,1,3,0)
 ;;=3^Homonymous Bilateral Field Defects,Left Side
 ;;^UTILITY(U,$J,358.3,2435,1,4,0)
 ;;=4^H53.462
 ;;^UTILITY(U,$J,358.3,2435,2)
 ;;=^5006342
 ;;^UTILITY(U,$J,358.3,2436,0)
 ;;=H53.47^^23^185^33
 ;;^UTILITY(U,$J,358.3,2436,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2436,1,3,0)
 ;;=3^Heteronymous Bilateral Field Defects
 ;;^UTILITY(U,$J,358.3,2436,1,4,0)
 ;;=4^H53.47
 ;;^UTILITY(U,$J,358.3,2436,2)
 ;;=^268847
 ;;^UTILITY(U,$J,358.3,2437,0)
 ;;=H53.60^^23^185^55
 ;;^UTILITY(U,$J,358.3,2437,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2437,1,3,0)
 ;;=3^Night Blindness,Unspec
 ;;^UTILITY(U,$J,358.3,2437,1,4,0)
 ;;=4^H53.60
 ;;^UTILITY(U,$J,358.3,2437,2)
 ;;=^5006353
 ;;^UTILITY(U,$J,358.3,2438,0)
 ;;=H53.62^^23^185^54
 ;;^UTILITY(U,$J,358.3,2438,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2438,1,3,0)
 ;;=3^Night Blindness,Acquired
 ;;^UTILITY(U,$J,358.3,2438,1,4,0)
 ;;=4^H53.62
 ;;^UTILITY(U,$J,358.3,2438,2)
 ;;=^265401
 ;;^UTILITY(U,$J,358.3,2439,0)
 ;;=H53.61^^23^185^29
 ;;^UTILITY(U,$J,358.3,2439,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2439,1,3,0)
 ;;=3^Dark Adaptation Curve,Abnormal
 ;;^UTILITY(U,$J,358.3,2439,1,4,0)
 ;;=4^H53.61
 ;;^UTILITY(U,$J,358.3,2439,2)
 ;;=^268858
 ;;^UTILITY(U,$J,358.3,2440,0)
 ;;=H53.9^^23^185^68
 ;;^UTILITY(U,$J,358.3,2440,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2440,1,3,0)
 ;;=3^Visual Disturbance,Unspec
 ;;^UTILITY(U,$J,358.3,2440,1,4,0)
 ;;=4^H53.9
 ;;^UTILITY(U,$J,358.3,2440,2)
 ;;=^124001
 ;;^UTILITY(U,$J,358.3,2441,0)
 ;;=H54.40^^23^185^23
 ;;^UTILITY(U,$J,358.3,2441,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2441,1,3,0)
 ;;=3^Blindness,One Eye,Unspec Eye
 ;;^UTILITY(U,$J,358.3,2441,1,4,0)
 ;;=4^H54.40
 ;;^UTILITY(U,$J,358.3,2441,2)
 ;;=^5006362
 ;;^UTILITY(U,$J,358.3,2442,0)
 ;;=H54.61^^23^185^63
 ;;^UTILITY(U,$J,358.3,2442,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2442,1,3,0)
 ;;=3^Unqualified Visual Loss Rt Eye,Normal Vision Lt Eye
 ;;^UTILITY(U,$J,358.3,2442,1,4,0)
 ;;=4^H54.61
 ;;^UTILITY(U,$J,358.3,2442,2)
 ;;=^5006367
 ;;^UTILITY(U,$J,358.3,2443,0)
 ;;=H54.62^^23^185^62
 ;;^UTILITY(U,$J,358.3,2443,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2443,1,3,0)
 ;;=3^Unqualified Visual Loss Lt Eye,Normal Vision Rt Eye
 ;;^UTILITY(U,$J,358.3,2443,1,4,0)
 ;;=4^H54.62
 ;;^UTILITY(U,$J,358.3,2443,2)
 ;;=^5133520
 ;;^UTILITY(U,$J,358.3,2444,0)
 ;;=H54.7^^23^185^77
 ;;^UTILITY(U,$J,358.3,2444,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2444,1,3,0)
 ;;=3^Visual Loss,Unspec
 ;;^UTILITY(U,$J,358.3,2444,1,4,0)
 ;;=4^H54.7
 ;;^UTILITY(U,$J,358.3,2444,2)
 ;;=^5006368
 ;;^UTILITY(U,$J,358.3,2445,0)
 ;;=H54.8^^23^185^37
 ;;^UTILITY(U,$J,358.3,2445,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2445,1,3,0)
 ;;=3^Legal Blindness,USA Definition
 ;;^UTILITY(U,$J,358.3,2445,1,4,0)
 ;;=4^H54.8
 ;;^UTILITY(U,$J,358.3,2445,2)
 ;;=^5006369
 ;;^UTILITY(U,$J,358.3,2446,0)
 ;;=H51.11^^23^185^28
 ;;^UTILITY(U,$J,358.3,2446,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2446,1,3,0)
 ;;=3^Convergence Insufficiency
 ;;^UTILITY(U,$J,358.3,2446,1,4,0)
 ;;=4^H51.11
 ;;^UTILITY(U,$J,358.3,2446,2)
 ;;=^5006251
 ;;^UTILITY(U,$J,358.3,2447,0)
 ;;=H51.12^^23^185^27
 ;;^UTILITY(U,$J,358.3,2447,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2447,1,3,0)
 ;;=3^Convergence Excess
 ;;^UTILITY(U,$J,358.3,2447,1,4,0)
 ;;=4^H51.12
 ;;^UTILITY(U,$J,358.3,2447,2)
 ;;=^5006252
 ;;^UTILITY(U,$J,358.3,2448,0)
 ;;=H51.9^^23^185^1
 ;;^UTILITY(U,$J,358.3,2448,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2448,1,3,0)
 ;;=3^Binocular Movement Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,2448,1,4,0)
 ;;=4^H51.9
 ;;^UTILITY(U,$J,358.3,2448,2)
 ;;=^5006258
 ;;^UTILITY(U,$J,358.3,2449,0)
 ;;=H51.8^^23^185^2
 ;;^UTILITY(U,$J,358.3,2449,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2449,1,3,0)
 ;;=3^Binocular Movement Disorders,Oth Spec
 ;;^UTILITY(U,$J,358.3,2449,1,4,0)
 ;;=4^H51.8
 ;;^UTILITY(U,$J,358.3,2449,2)
 ;;=^5006257
 ;;^UTILITY(U,$J,358.3,2450,0)
 ;;=H55.81^^23^185^60
 ;;^UTILITY(U,$J,358.3,2450,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2450,1,3,0)
 ;;=3^Saccadic Eye Movements
 ;;^UTILITY(U,$J,358.3,2450,1,4,0)
 ;;=4^H55.81
 ;;^UTILITY(U,$J,358.3,2450,2)
 ;;=^5006373
 ;;^UTILITY(U,$J,358.3,2451,0)
 ;;=H55.89^^23^185^36
 ;;^UTILITY(U,$J,358.3,2451,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2451,1,3,0)
 ;;=3^Irregular Eye Movements
 ;;^UTILITY(U,$J,358.3,2451,1,4,0)
 ;;=4^H55.89
 ;;^UTILITY(U,$J,358.3,2451,2)
 ;;=^5006374
 ;;^UTILITY(U,$J,358.3,2452,0)
 ;;=H54.3^^23^185^64
 ;;^UTILITY(U,$J,358.3,2452,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2452,1,3,0)
 ;;=3^Unqualified Visual Loss,Both Eyes
 ;;^UTILITY(U,$J,358.3,2452,1,4,0)
 ;;=4^H54.3
 ;;^UTILITY(U,$J,358.3,2452,2)
 ;;=^268886
 ;;^UTILITY(U,$J,358.3,2453,0)
 ;;=H54.1213^^23^185^38
 ;;^UTILITY(U,$J,358.3,2453,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2453,1,3,0)
 ;;=3^Low Vision Rt Eye Category 1,Blindness Lt Eye Category 3
 ;;^UTILITY(U,$J,358.3,2453,1,4,0)
 ;;=4^H54.1213
 ;;^UTILITY(U,$J,358.3,2453,2)
 ;;=^5151353
 ;;^UTILITY(U,$J,358.3,2454,0)
 ;;=H54.1214^^23^185^39
 ;;^UTILITY(U,$J,358.3,2454,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2454,1,3,0)
 ;;=3^Low Vision Rt Eye Category 1,Blindness Lt Eye Category 4
 ;;^UTILITY(U,$J,358.3,2454,1,4,0)
 ;;=4^H54.1214
 ;;^UTILITY(U,$J,358.3,2454,2)
 ;;=^5151354
 ;;^UTILITY(U,$J,358.3,2455,0)
 ;;=H54.1215^^23^185^40
 ;;^UTILITY(U,$J,358.3,2455,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2455,1,3,0)
 ;;=3^Low Vision Rt Eye Category 1,Blindness Lt Eye Category 5
 ;;^UTILITY(U,$J,358.3,2455,1,4,0)
 ;;=4^H54.1215
 ;;^UTILITY(U,$J,358.3,2455,2)
 ;;=^5151355
 ;;^UTILITY(U,$J,358.3,2456,0)
 ;;=H54.1223^^23^185^46
 ;;^UTILITY(U,$J,358.3,2456,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2456,1,3,0)
 ;;=3^Low Vision Rt Eye Category 2,Blindness Lt Eye Category 3
 ;;^UTILITY(U,$J,358.3,2456,1,4,0)
 ;;=4^H54.1223
 ;;^UTILITY(U,$J,358.3,2456,2)
 ;;=^5151356
 ;;^UTILITY(U,$J,358.3,2457,0)
 ;;=H54.1224^^23^185^47
 ;;^UTILITY(U,$J,358.3,2457,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2457,1,3,0)
 ;;=3^Low Vision Rt Eye Category 2,Blindness Lt Eye Category 4
 ;;^UTILITY(U,$J,358.3,2457,1,4,0)
 ;;=4^H54.1224
 ;;^UTILITY(U,$J,358.3,2457,2)
 ;;=^5151357
 ;;^UTILITY(U,$J,358.3,2458,0)
 ;;=H54.1225^^23^185^48
 ;;^UTILITY(U,$J,358.3,2458,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2458,1,3,0)
 ;;=3^Low Vision Rt Eye Category 2,Blindness Lt Eye Category 5
 ;;^UTILITY(U,$J,358.3,2458,1,4,0)
 ;;=4^H54.1225
 ;;^UTILITY(U,$J,358.3,2458,2)
 ;;=^5151358
 ;;^UTILITY(U,$J,358.3,2459,0)
 ;;=H54.1131^^23^185^8
 ;;^UTILITY(U,$J,358.3,2459,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2459,1,3,0)
 ;;=3^Blindness Rt Eye Category 3,Low Vision Lt Eye Category 1
 ;;^UTILITY(U,$J,358.3,2459,1,4,0)
 ;;=4^H54.1131
 ;;^UTILITY(U,$J,358.3,2459,2)
 ;;=^5151347
 ;;^UTILITY(U,$J,358.3,2460,0)
 ;;=H54.1132^^23^185^9
 ;;^UTILITY(U,$J,358.3,2460,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2460,1,3,0)
 ;;=3^Blindness Rt Eye Category 3,Low Vision Lt Eye Category 2
 ;;^UTILITY(U,$J,358.3,2460,1,4,0)
 ;;=4^H54.1132
 ;;^UTILITY(U,$J,358.3,2460,2)
 ;;=^5151348
 ;;^UTILITY(U,$J,358.3,2461,0)
 ;;=H54.1141^^23^185^14
 ;;^UTILITY(U,$J,358.3,2461,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2461,1,3,0)
 ;;=3^Blindness Rt Eye Category 4,Low Vision Lt Eye Category 1
 ;;^UTILITY(U,$J,358.3,2461,1,4,0)
 ;;=4^H54.1141
 ;;^UTILITY(U,$J,358.3,2461,2)
 ;;=^5151349
 ;;^UTILITY(U,$J,358.3,2462,0)
 ;;=H54.1142^^23^185^15
 ;;^UTILITY(U,$J,358.3,2462,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2462,1,3,0)
 ;;=3^Blindness Rt Eye Category 4,Low Vision Lt Eye Category 2
 ;;^UTILITY(U,$J,358.3,2462,1,4,0)
 ;;=4^H54.1142
 ;;^UTILITY(U,$J,358.3,2462,2)
 ;;=^5151350
 ;;^UTILITY(U,$J,358.3,2463,0)
 ;;=H54.1151^^23^185^20
 ;;^UTILITY(U,$J,358.3,2463,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2463,1,3,0)
 ;;=3^Blindness Rt Eye Category 5,Low Vision Lt Eye Category 1
 ;;^UTILITY(U,$J,358.3,2463,1,4,0)
 ;;=4^H54.1151
 ;;^UTILITY(U,$J,358.3,2463,2)
 ;;=^5151351
 ;;^UTILITY(U,$J,358.3,2464,0)
 ;;=H54.1152^^23^185^21
 ;;^UTILITY(U,$J,358.3,2464,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2464,1,3,0)
 ;;=3^Blindness Rt Eye Category 5,Low Vision Lt Eye Category 2
 ;;^UTILITY(U,$J,358.3,2464,1,4,0)
 ;;=4^H54.1152
 ;;^UTILITY(U,$J,358.3,2464,2)
 ;;=^5151352
 ;;^UTILITY(U,$J,358.3,2465,0)
 ;;=H54.413A^^23^185^10
 ;;^UTILITY(U,$J,358.3,2465,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2465,1,3,0)
 ;;=3^Blindness Rt Eye Category 3,Normal Vision Lt Eye
 ;;^UTILITY(U,$J,358.3,2465,1,4,0)
 ;;=4^H54.413A
 ;;^UTILITY(U,$J,358.3,2465,2)
 ;;=^5151363
 ;;^UTILITY(U,$J,358.3,2466,0)
 ;;=H54.414A^^23^185^16
 ;;^UTILITY(U,$J,358.3,2466,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2466,1,3,0)
 ;;=3^Blindness Rt Eye Category 4,Normal Vision Lt Eye
 ;;^UTILITY(U,$J,358.3,2466,1,4,0)
 ;;=4^H54.414A
 ;;^UTILITY(U,$J,358.3,2466,2)
 ;;=^5151364
 ;;^UTILITY(U,$J,358.3,2467,0)
 ;;=H54.415A^^23^185^22
 ;;^UTILITY(U,$J,358.3,2467,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2467,1,3,0)
 ;;=3^Blindness Rt Eye Category 5,Normal Vision Lt Eye
 ;;^UTILITY(U,$J,358.3,2467,1,4,0)
 ;;=4^H54.415A
 ;;^UTILITY(U,$J,358.3,2467,2)
 ;;=^5151365
 ;;^UTILITY(U,$J,358.3,2468,0)
 ;;=H54.0X33^^23^185^5
 ;;^UTILITY(U,$J,358.3,2468,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2468,1,3,0)
 ;;=3^Blindness Rt Eye Category 3,Blindness Lt Eye Category 3
 ;;^UTILITY(U,$J,358.3,2468,1,4,0)
 ;;=4^H54.0X33
 ;;^UTILITY(U,$J,358.3,2468,2)
 ;;=^5151338
 ;;^UTILITY(U,$J,358.3,2469,0)
 ;;=H54.0X34^^23^185^6
 ;;^UTILITY(U,$J,358.3,2469,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2469,1,3,0)
 ;;=3^Blindness Rt Eye Category 3,Blindness Lt Eye Category 4
 ;;^UTILITY(U,$J,358.3,2469,1,4,0)
 ;;=4^H54.0X34
 ;;^UTILITY(U,$J,358.3,2469,2)
 ;;=^5151339
 ;;^UTILITY(U,$J,358.3,2470,0)
 ;;=H54.0X35^^23^185^7
 ;;^UTILITY(U,$J,358.3,2470,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2470,1,3,0)
 ;;=3^Blindness Rt Eye Category 3,Blindness Lt Eye Category 5
 ;;^UTILITY(U,$J,358.3,2470,1,4,0)
 ;;=4^H54.0X35
 ;;^UTILITY(U,$J,358.3,2470,2)
 ;;=^5151340
 ;;^UTILITY(U,$J,358.3,2471,0)
 ;;=H54.0X43^^23^185^11
 ;;^UTILITY(U,$J,358.3,2471,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2471,1,3,0)
 ;;=3^Blindness Rt Eye Category 4,Blindness Lt Eye Category 3
 ;;^UTILITY(U,$J,358.3,2471,1,4,0)
 ;;=4^H54.0X43
 ;;^UTILITY(U,$J,358.3,2471,2)
 ;;=^5151341
 ;;^UTILITY(U,$J,358.3,2472,0)
 ;;=H54.0X44^^23^185^12
 ;;^UTILITY(U,$J,358.3,2472,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2472,1,3,0)
 ;;=3^Blindness Rt Eye Category 4,Blindness Lt Eye Category 4
 ;;^UTILITY(U,$J,358.3,2472,1,4,0)
 ;;=4^H54.0X44
 ;;^UTILITY(U,$J,358.3,2472,2)
 ;;=^5151342
 ;;^UTILITY(U,$J,358.3,2473,0)
 ;;=H54.0X45^^23^185^13
 ;;^UTILITY(U,$J,358.3,2473,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2473,1,3,0)
 ;;=3^Blindness Rt Eye Category 4,Blindness Lt Eye Category 5
 ;;^UTILITY(U,$J,358.3,2473,1,4,0)
 ;;=4^H54.0X45
 ;;^UTILITY(U,$J,358.3,2473,2)
 ;;=^5151343
 ;;^UTILITY(U,$J,358.3,2474,0)
 ;;=H54.0X53^^23^185^17
 ;;^UTILITY(U,$J,358.3,2474,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2474,1,3,0)
 ;;=3^Blindness Rt Eye Category 5,Blindness Lt Eye Category 3
 ;;^UTILITY(U,$J,358.3,2474,1,4,0)
 ;;=4^H54.0X53
 ;;^UTILITY(U,$J,358.3,2474,2)
 ;;=^5151344
 ;;^UTILITY(U,$J,358.3,2475,0)
 ;;=H54.0X54^^23^185^18
 ;;^UTILITY(U,$J,358.3,2475,1,0)
 ;;=^358.31IA^4^2
