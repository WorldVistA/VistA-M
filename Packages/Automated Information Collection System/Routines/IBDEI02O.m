IBDEI02O ; ; 09-AUG-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,3042,1,4,0)
 ;;=4^I31.9
 ;;^UTILITY(U,$J,358.3,3042,2)
 ;;=^5007165
 ;;^UTILITY(U,$J,358.3,3043,0)
 ;;=I35.0^^17^214^41
 ;;^UTILITY(U,$J,358.3,3043,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3043,1,3,0)
 ;;=3^Nonrheumatic Aortic Valve Stenosis
 ;;^UTILITY(U,$J,358.3,3043,1,4,0)
 ;;=4^I35.0
 ;;^UTILITY(U,$J,358.3,3043,2)
 ;;=^5007174
 ;;^UTILITY(U,$J,358.3,3044,0)
 ;;=I35.1^^17^214^40
 ;;^UTILITY(U,$J,358.3,3044,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3044,1,3,0)
 ;;=3^Nonrheumatic Aortic Valve Insufficiency
 ;;^UTILITY(U,$J,358.3,3044,1,4,0)
 ;;=4^I35.1
 ;;^UTILITY(U,$J,358.3,3044,2)
 ;;=^5007175
 ;;^UTILITY(U,$J,358.3,3045,0)
 ;;=I35.2^^17^214^42
 ;;^UTILITY(U,$J,358.3,3045,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3045,1,3,0)
 ;;=3^Nonrheumatic Aortic Valve Stenosis w/ Insufficiency
 ;;^UTILITY(U,$J,358.3,3045,1,4,0)
 ;;=4^I35.2
 ;;^UTILITY(U,$J,358.3,3045,2)
 ;;=^5007176
 ;;^UTILITY(U,$J,358.3,3046,0)
 ;;=I35.8^^17^214^38
 ;;^UTILITY(U,$J,358.3,3046,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3046,1,3,0)
 ;;=3^Nonrheumatic Aortic Valve Disorders,Oth Type
 ;;^UTILITY(U,$J,358.3,3046,1,4,0)
 ;;=4^I35.8
 ;;^UTILITY(U,$J,358.3,3046,2)
 ;;=^5007177
 ;;^UTILITY(U,$J,358.3,3047,0)
 ;;=I35.9^^17^214^39
 ;;^UTILITY(U,$J,358.3,3047,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3047,1,3,0)
 ;;=3^Nonrheumatic Aortic Valve Disorders,Unspec
 ;;^UTILITY(U,$J,358.3,3047,1,4,0)
 ;;=4^I35.9
 ;;^UTILITY(U,$J,358.3,3047,2)
 ;;=^5007178
 ;;^UTILITY(U,$J,358.3,3048,0)
 ;;=I49.5^^17^214^50
 ;;^UTILITY(U,$J,358.3,3048,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3048,1,3,0)
 ;;=3^Sick Sinus Syndrome
 ;;^UTILITY(U,$J,358.3,3048,1,4,0)
 ;;=4^I49.5
 ;;^UTILITY(U,$J,358.3,3048,2)
 ;;=^110404
 ;;^UTILITY(U,$J,358.3,3049,0)
 ;;=I49.9^^17^214^22
 ;;^UTILITY(U,$J,358.3,3049,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3049,1,3,0)
 ;;=3^Cardiac Arrhythmia,Unspec
 ;;^UTILITY(U,$J,358.3,3049,1,4,0)
 ;;=4^I49.9
 ;;^UTILITY(U,$J,358.3,3049,2)
 ;;=^5007237
 ;;^UTILITY(U,$J,358.3,3050,0)
 ;;=I71.4^^17^214^1
 ;;^UTILITY(U,$J,358.3,3050,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3050,1,3,0)
 ;;=3^AAA w/o Rupture
 ;;^UTILITY(U,$J,358.3,3050,1,4,0)
 ;;=4^I71.4
 ;;^UTILITY(U,$J,358.3,3050,2)
 ;;=^5007789
 ;;^UTILITY(U,$J,358.3,3051,0)
 ;;=I34.0^^17^214^44
 ;;^UTILITY(U,$J,358.3,3051,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3051,1,3,0)
 ;;=3^Nonrheumatic Mitral Valve Insufficiency
 ;;^UTILITY(U,$J,358.3,3051,1,4,0)
 ;;=4^I34.0
 ;;^UTILITY(U,$J,358.3,3051,2)
 ;;=^5007169
 ;;^UTILITY(U,$J,358.3,3052,0)
 ;;=I34.8^^17^214^43
 ;;^UTILITY(U,$J,358.3,3052,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3052,1,3,0)
 ;;=3^Nonrheumatic Mitral Valve Disorders,Oth Type
 ;;^UTILITY(U,$J,358.3,3052,1,4,0)
 ;;=4^I34.8
 ;;^UTILITY(U,$J,358.3,3052,2)
 ;;=^5007172
 ;;^UTILITY(U,$J,358.3,3053,0)
 ;;=I70.211^^17^214^13
 ;;^UTILITY(U,$J,358.3,3053,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3053,1,3,0)
 ;;=3^Athscl Native Art of Right Leg w/ Intrmt Claud
 ;;^UTILITY(U,$J,358.3,3053,1,4,0)
 ;;=4^I70.211
 ;;^UTILITY(U,$J,358.3,3053,2)
 ;;=^5007578
 ;;^UTILITY(U,$J,358.3,3054,0)
 ;;=I70.212^^17^214^10
 ;;^UTILITY(U,$J,358.3,3054,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3054,1,3,0)
 ;;=3^Athscl Native Art of Left Leg w/ Intrmt Claud
 ;;^UTILITY(U,$J,358.3,3054,1,4,0)
 ;;=4^I70.212
 ;;^UTILITY(U,$J,358.3,3054,2)
 ;;=^5007579
 ;;^UTILITY(U,$J,358.3,3055,0)
 ;;=I70.213^^17^214^6
 ;;^UTILITY(U,$J,358.3,3055,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3055,1,3,0)
 ;;=3^Athscl Native Art of Bilateral Legs w/ Intrmt Claud
 ;;^UTILITY(U,$J,358.3,3055,1,4,0)
 ;;=4^I70.213
 ;;^UTILITY(U,$J,358.3,3055,2)
 ;;=^5007580
 ;;^UTILITY(U,$J,358.3,3056,0)
 ;;=I70.261^^17^214^12
 ;;^UTILITY(U,$J,358.3,3056,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3056,1,3,0)
 ;;=3^Athscl Native Art of Right Leg w/ Gangrene
 ;;^UTILITY(U,$J,358.3,3056,1,4,0)
 ;;=4^I70.261
 ;;^UTILITY(U,$J,358.3,3056,2)
 ;;=^5007603
 ;;^UTILITY(U,$J,358.3,3057,0)
 ;;=I70.262^^17^214^9
 ;;^UTILITY(U,$J,358.3,3057,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3057,1,3,0)
 ;;=3^Athscl Native Art of Left Leg w/ Gangrene
 ;;^UTILITY(U,$J,358.3,3057,1,4,0)
 ;;=4^I70.262
 ;;^UTILITY(U,$J,358.3,3057,2)
 ;;=^5007604
 ;;^UTILITY(U,$J,358.3,3058,0)
 ;;=I70.263^^17^214^7
 ;;^UTILITY(U,$J,358.3,3058,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3058,1,3,0)
 ;;=3^Athscl Native Art of Bilateral Legs w/ Gangrene
 ;;^UTILITY(U,$J,358.3,3058,1,4,0)
 ;;=4^I70.263
 ;;^UTILITY(U,$J,358.3,3058,2)
 ;;=^5007605
 ;;^UTILITY(U,$J,358.3,3059,0)
 ;;=I70.221^^17^214^14
 ;;^UTILITY(U,$J,358.3,3059,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3059,1,3,0)
 ;;=3^Athscl Native Art of Right Leg w/ Rest Pain
 ;;^UTILITY(U,$J,358.3,3059,1,4,0)
 ;;=4^I70.221
 ;;^UTILITY(U,$J,358.3,3059,2)
 ;;=^5007583
 ;;^UTILITY(U,$J,358.3,3060,0)
 ;;=I70.222^^17^214^11
 ;;^UTILITY(U,$J,358.3,3060,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3060,1,3,0)
 ;;=3^Athscl Native Art of Left Leg w/ Rest Pain
 ;;^UTILITY(U,$J,358.3,3060,1,4,0)
 ;;=4^I70.222
 ;;^UTILITY(U,$J,358.3,3060,2)
 ;;=^5007584
 ;;^UTILITY(U,$J,358.3,3061,0)
 ;;=I70.223^^17^214^8
 ;;^UTILITY(U,$J,358.3,3061,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3061,1,3,0)
 ;;=3^Athscl Native Art of Bilateral Legs w/ Rest Pain
 ;;^UTILITY(U,$J,358.3,3061,1,4,0)
 ;;=4^I70.223
 ;;^UTILITY(U,$J,358.3,3061,2)
 ;;=^5007585
 ;;^UTILITY(U,$J,358.3,3062,0)
 ;;=I73.9^^17^214^45
 ;;^UTILITY(U,$J,358.3,3062,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3062,1,3,0)
 ;;=3^PVD,Unspec
 ;;^UTILITY(U,$J,358.3,3062,1,4,0)
 ;;=4^I73.9
 ;;^UTILITY(U,$J,358.3,3062,2)
 ;;=^184182
 ;;^UTILITY(U,$J,358.3,3063,0)
 ;;=I74.3^^17^214^31
 ;;^UTILITY(U,$J,358.3,3063,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3063,1,3,0)
 ;;=3^Embolism/Thrombosis of Lower Extremity Arteries
 ;;^UTILITY(U,$J,358.3,3063,1,4,0)
 ;;=4^I74.3
 ;;^UTILITY(U,$J,358.3,3063,2)
 ;;=^5007802
 ;;^UTILITY(U,$J,358.3,3064,0)
 ;;=I72.4^^17^214^2
 ;;^UTILITY(U,$J,358.3,3064,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3064,1,3,0)
 ;;=3^Aneurysm of Lower Extremity Artery
 ;;^UTILITY(U,$J,358.3,3064,1,4,0)
 ;;=4^I72.4
 ;;^UTILITY(U,$J,358.3,3064,2)
 ;;=^269777
 ;;^UTILITY(U,$J,358.3,3065,0)
 ;;=I48.0^^17^214^16
 ;;^UTILITY(U,$J,358.3,3065,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3065,1,3,0)
 ;;=3^Atrial Fibrillation,Paroxysmal
 ;;^UTILITY(U,$J,358.3,3065,1,4,0)
 ;;=4^I48.0
 ;;^UTILITY(U,$J,358.3,3065,2)
 ;;=^90473
 ;;^UTILITY(U,$J,358.3,3066,0)
 ;;=I48.2^^17^214^15
 ;;^UTILITY(U,$J,358.3,3066,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3066,1,3,0)
 ;;=3^Atrial Fibrillation,Chronic
 ;;^UTILITY(U,$J,358.3,3066,1,4,0)
 ;;=4^I48.2
 ;;^UTILITY(U,$J,358.3,3066,2)
 ;;=^5007226
 ;;^UTILITY(U,$J,358.3,3067,0)
 ;;=I48.1^^17^214^17
 ;;^UTILITY(U,$J,358.3,3067,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3067,1,3,0)
 ;;=3^Atrial Fibrillation,Persistent
 ;;^UTILITY(U,$J,358.3,3067,1,4,0)
 ;;=4^I48.1
 ;;^UTILITY(U,$J,358.3,3067,2)
 ;;=^5007225
 ;;^UTILITY(U,$J,358.3,3068,0)
 ;;=I48.4^^17^214^18
 ;;^UTILITY(U,$J,358.3,3068,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3068,1,3,0)
 ;;=3^Atrial Flutter,Atypical
 ;;^UTILITY(U,$J,358.3,3068,1,4,0)
 ;;=4^I48.4
 ;;^UTILITY(U,$J,358.3,3068,2)
 ;;=^5007228
 ;;^UTILITY(U,$J,358.3,3069,0)
 ;;=I48.3^^17^214^19
 ;;^UTILITY(U,$J,358.3,3069,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3069,1,3,0)
 ;;=3^Atrial Flutter,Typical
 ;;^UTILITY(U,$J,358.3,3069,1,4,0)
 ;;=4^I48.3
 ;;^UTILITY(U,$J,358.3,3069,2)
 ;;=^5007227
 ;;^UTILITY(U,$J,358.3,3070,0)
 ;;=F10.239^^17^215^2
 ;;^UTILITY(U,$J,358.3,3070,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3070,1,3,0)
 ;;=3^Alcohol Dependence w/ Withdrawal,Unspec
 ;;^UTILITY(U,$J,358.3,3070,1,4,0)
 ;;=4^F10.239
 ;;^UTILITY(U,$J,358.3,3070,2)
 ;;=^5003089
 ;;^UTILITY(U,$J,358.3,3071,0)
 ;;=F10.231^^17^215^1
 ;;^UTILITY(U,$J,358.3,3071,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3071,1,3,0)
 ;;=3^Alcohol Dependence w/ Withdrawal Delirium
 ;;^UTILITY(U,$J,358.3,3071,1,4,0)
 ;;=4^F10.231
 ;;^UTILITY(U,$J,358.3,3071,2)
 ;;=^5003087
 ;;^UTILITY(U,$J,358.3,3072,0)
 ;;=R56.9^^17^215^4
 ;;^UTILITY(U,$J,358.3,3072,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3072,1,3,0)
 ;;=3^Convulsions,Unspec
 ;;^UTILITY(U,$J,358.3,3072,1,4,0)
 ;;=4^R56.9
 ;;^UTILITY(U,$J,358.3,3072,2)
 ;;=^5019524
 ;;^UTILITY(U,$J,358.3,3073,0)
 ;;=K70.30^^17^215^3
 ;;^UTILITY(U,$J,358.3,3073,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3073,1,3,0)
 ;;=3^Alcoholic Cirrhosis of Liver w/o Ascites
 ;;^UTILITY(U,$J,358.3,3073,1,4,0)
 ;;=4^K70.30
 ;;^UTILITY(U,$J,358.3,3073,2)
 ;;=^5008788
 ;;^UTILITY(U,$J,358.3,3074,0)
 ;;=K72.90^^17^215^5
 ;;^UTILITY(U,$J,358.3,3074,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3074,1,3,0)
 ;;=3^Hepatic Failure
 ;;^UTILITY(U,$J,358.3,3074,1,4,0)
 ;;=4^K72.90
 ;;^UTILITY(U,$J,358.3,3074,2)
 ;;=^5008809
 ;;^UTILITY(U,$J,358.3,3075,0)
 ;;=K72.91^^17^215^6
 ;;^UTILITY(U,$J,358.3,3075,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3075,1,3,0)
 ;;=3^Hepatic Failure w/ Coma
 ;;^UTILITY(U,$J,358.3,3075,1,4,0)
 ;;=4^K72.91
 ;;^UTILITY(U,$J,358.3,3075,2)
 ;;=^5008810
 ;;^UTILITY(U,$J,358.3,3076,0)
 ;;=J96.00^^17^216^16
 ;;^UTILITY(U,$J,358.3,3076,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3076,1,3,0)
 ;;=3^Respiratory Failure,Acute
 ;;^UTILITY(U,$J,358.3,3076,1,4,0)
 ;;=4^J96.00
 ;;^UTILITY(U,$J,358.3,3076,2)
 ;;=^5008347
 ;;^UTILITY(U,$J,358.3,3077,0)
 ;;=J96.90^^17^216^19
 ;;^UTILITY(U,$J,358.3,3077,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3077,1,3,0)
 ;;=3^Respiratory Failure,Unspec
 ;;^UTILITY(U,$J,358.3,3077,1,4,0)
 ;;=4^J96.90
 ;;^UTILITY(U,$J,358.3,3077,2)
 ;;=^5008356
 ;;^UTILITY(U,$J,358.3,3078,0)
 ;;=J96.20^^17^216^17
 ;;^UTILITY(U,$J,358.3,3078,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3078,1,3,0)
 ;;=3^Respiratory Failure,Acute/Chronic
 ;;^UTILITY(U,$J,358.3,3078,1,4,0)
 ;;=4^J96.20
