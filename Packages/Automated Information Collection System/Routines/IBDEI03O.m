IBDEI03O ; ; 12-MAY-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,3358,2)
 ;;=^5007082
 ;;^UTILITY(U,$J,358.3,3359,0)
 ;;=I20.9^^27^255^3
 ;;^UTILITY(U,$J,358.3,3359,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3359,1,3,0)
 ;;=3^Angina Pectoris,Unspec
 ;;^UTILITY(U,$J,358.3,3359,1,4,0)
 ;;=4^I20.9
 ;;^UTILITY(U,$J,358.3,3359,2)
 ;;=^5007079
 ;;^UTILITY(U,$J,358.3,3360,0)
 ;;=I21.3^^27^255^50
 ;;^UTILITY(U,$J,358.3,3360,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3360,1,3,0)
 ;;=3^STEMI Myocardial Infarction,Site Unspec
 ;;^UTILITY(U,$J,358.3,3360,1,4,0)
 ;;=4^I21.3
 ;;^UTILITY(U,$J,358.3,3360,2)
 ;;=^5007087
 ;;^UTILITY(U,$J,358.3,3361,0)
 ;;=I50.20^^27^255^53
 ;;^UTILITY(U,$J,358.3,3361,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3361,1,3,0)
 ;;=3^Systolic Congestive Heart Failure,Unspec
 ;;^UTILITY(U,$J,358.3,3361,1,4,0)
 ;;=4^I50.20
 ;;^UTILITY(U,$J,358.3,3361,2)
 ;;=^5007239
 ;;^UTILITY(U,$J,358.3,3362,0)
 ;;=I50.33^^27^255^29
 ;;^UTILITY(U,$J,358.3,3362,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3362,1,3,0)
 ;;=3^Diastolic Congestive Heart Failure,Acute/Chronic
 ;;^UTILITY(U,$J,358.3,3362,1,4,0)
 ;;=4^I50.33
 ;;^UTILITY(U,$J,358.3,3362,2)
 ;;=^5007246
 ;;^UTILITY(U,$J,358.3,3363,0)
 ;;=I49.01^^27^255^56
 ;;^UTILITY(U,$J,358.3,3363,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3363,1,3,0)
 ;;=3^Ventricular Fibrillation
 ;;^UTILITY(U,$J,358.3,3363,1,4,0)
 ;;=4^I49.01
 ;;^UTILITY(U,$J,358.3,3363,2)
 ;;=^125951
 ;;^UTILITY(U,$J,358.3,3364,0)
 ;;=R07.82^^27^255^34
 ;;^UTILITY(U,$J,358.3,3364,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3364,1,3,0)
 ;;=3^Intercostal Pain
 ;;^UTILITY(U,$J,358.3,3364,1,4,0)
 ;;=4^R07.82
 ;;^UTILITY(U,$J,358.3,3364,2)
 ;;=^5019199
 ;;^UTILITY(U,$J,358.3,3365,0)
 ;;=R07.89^^27^255^24
 ;;^UTILITY(U,$J,358.3,3365,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3365,1,3,0)
 ;;=3^Chest Pain,Other
 ;;^UTILITY(U,$J,358.3,3365,1,4,0)
 ;;=4^R07.89
 ;;^UTILITY(U,$J,358.3,3365,2)
 ;;=^5019200
 ;;^UTILITY(U,$J,358.3,3366,0)
 ;;=R07.9^^27^255^25
 ;;^UTILITY(U,$J,358.3,3366,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3366,1,3,0)
 ;;=3^Chest Pain,Unspec
 ;;^UTILITY(U,$J,358.3,3366,1,4,0)
 ;;=4^R07.9
 ;;^UTILITY(U,$J,358.3,3366,2)
 ;;=^5019201
 ;;^UTILITY(U,$J,358.3,3367,0)
 ;;=I20.0^^27^255^55
 ;;^UTILITY(U,$J,358.3,3367,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3367,1,3,0)
 ;;=3^Unstable Angina
 ;;^UTILITY(U,$J,358.3,3367,1,4,0)
 ;;=4^I20.0
 ;;^UTILITY(U,$J,358.3,3367,2)
 ;;=^5007076
 ;;^UTILITY(U,$J,358.3,3368,0)
 ;;=I44.2^^27^255^17
 ;;^UTILITY(U,$J,358.3,3368,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3368,1,3,0)
 ;;=3^Atrioventricular Block,Complete
 ;;^UTILITY(U,$J,358.3,3368,1,4,0)
 ;;=4^I44.2
 ;;^UTILITY(U,$J,358.3,3368,2)
 ;;=^259621
 ;;^UTILITY(U,$J,358.3,3369,0)
 ;;=I95.9^^27^255^33
 ;;^UTILITY(U,$J,358.3,3369,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3369,1,3,0)
 ;;=3^Hypotension,Unspec
 ;;^UTILITY(U,$J,358.3,3369,1,4,0)
 ;;=4^I95.9
 ;;^UTILITY(U,$J,358.3,3369,2)
 ;;=^5008080
 ;;^UTILITY(U,$J,358.3,3370,0)
 ;;=I31.9^^27^255^46
 ;;^UTILITY(U,$J,358.3,3370,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3370,1,3,0)
 ;;=3^Pericardium Disease,Unspec
 ;;^UTILITY(U,$J,358.3,3370,1,4,0)
 ;;=4^I31.9
 ;;^UTILITY(U,$J,358.3,3370,2)
 ;;=^5007165
 ;;^UTILITY(U,$J,358.3,3371,0)
 ;;=I35.0^^27^255^40
 ;;^UTILITY(U,$J,358.3,3371,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3371,1,3,0)
 ;;=3^Nonrheumatic Aortic Valve Stenosis
 ;;^UTILITY(U,$J,358.3,3371,1,4,0)
 ;;=4^I35.0
 ;;^UTILITY(U,$J,358.3,3371,2)
 ;;=^5007174
 ;;^UTILITY(U,$J,358.3,3372,0)
 ;;=I35.1^^27^255^39
 ;;^UTILITY(U,$J,358.3,3372,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3372,1,3,0)
 ;;=3^Nonrheumatic Aortic Valve Insufficiency
 ;;^UTILITY(U,$J,358.3,3372,1,4,0)
 ;;=4^I35.1
 ;;^UTILITY(U,$J,358.3,3372,2)
 ;;=^5007175
 ;;^UTILITY(U,$J,358.3,3373,0)
 ;;=I35.2^^27^255^41
 ;;^UTILITY(U,$J,358.3,3373,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3373,1,3,0)
 ;;=3^Nonrheumatic Aortic Valve Stenosis w/ Insufficiency
 ;;^UTILITY(U,$J,358.3,3373,1,4,0)
 ;;=4^I35.2
 ;;^UTILITY(U,$J,358.3,3373,2)
 ;;=^5007176
 ;;^UTILITY(U,$J,358.3,3374,0)
 ;;=I35.8^^27^255^37
 ;;^UTILITY(U,$J,358.3,3374,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3374,1,3,0)
 ;;=3^Nonrheumatic Aortic Valve Disorders,Oth Type
 ;;^UTILITY(U,$J,358.3,3374,1,4,0)
 ;;=4^I35.8
 ;;^UTILITY(U,$J,358.3,3374,2)
 ;;=^5007177
 ;;^UTILITY(U,$J,358.3,3375,0)
 ;;=I35.9^^27^255^38
 ;;^UTILITY(U,$J,358.3,3375,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3375,1,3,0)
 ;;=3^Nonrheumatic Aortic Valve Disorders,Unspec
 ;;^UTILITY(U,$J,358.3,3375,1,4,0)
 ;;=4^I35.9
 ;;^UTILITY(U,$J,358.3,3375,2)
 ;;=^5007178
 ;;^UTILITY(U,$J,358.3,3376,0)
 ;;=I49.5^^27^255^51
 ;;^UTILITY(U,$J,358.3,3376,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3376,1,3,0)
 ;;=3^Sick Sinus Syndrome
 ;;^UTILITY(U,$J,358.3,3376,1,4,0)
 ;;=4^I49.5
 ;;^UTILITY(U,$J,358.3,3376,2)
 ;;=^110404
 ;;^UTILITY(U,$J,358.3,3377,0)
 ;;=I49.9^^27^255^20
 ;;^UTILITY(U,$J,358.3,3377,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3377,1,3,0)
 ;;=3^Cardiac Arrhythmia,Unspec
 ;;^UTILITY(U,$J,358.3,3377,1,4,0)
 ;;=4^I49.9
 ;;^UTILITY(U,$J,358.3,3377,2)
 ;;=^5007237
 ;;^UTILITY(U,$J,358.3,3378,0)
 ;;=I71.4^^27^255^1
 ;;^UTILITY(U,$J,358.3,3378,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3378,1,3,0)
 ;;=3^AAA w/o Rupture
 ;;^UTILITY(U,$J,358.3,3378,1,4,0)
 ;;=4^I71.4
 ;;^UTILITY(U,$J,358.3,3378,2)
 ;;=^5007789
 ;;^UTILITY(U,$J,358.3,3379,0)
 ;;=I34.0^^27^255^43
 ;;^UTILITY(U,$J,358.3,3379,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3379,1,3,0)
 ;;=3^Nonrheumatic Mitral Valve Insufficiency
 ;;^UTILITY(U,$J,358.3,3379,1,4,0)
 ;;=4^I34.0
 ;;^UTILITY(U,$J,358.3,3379,2)
 ;;=^5007169
 ;;^UTILITY(U,$J,358.3,3380,0)
 ;;=I34.8^^27^255^42
 ;;^UTILITY(U,$J,358.3,3380,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3380,1,3,0)
 ;;=3^Nonrheumatic Mitral Valve Disorders,Oth Type
 ;;^UTILITY(U,$J,358.3,3380,1,4,0)
 ;;=4^I34.8
 ;;^UTILITY(U,$J,358.3,3380,2)
 ;;=^5007172
 ;;^UTILITY(U,$J,358.3,3381,0)
 ;;=I70.211^^27^255^13
 ;;^UTILITY(U,$J,358.3,3381,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3381,1,3,0)
 ;;=3^Athscl Native Art of Right Leg w/ Intrmt Claud
 ;;^UTILITY(U,$J,358.3,3381,1,4,0)
 ;;=4^I70.211
 ;;^UTILITY(U,$J,358.3,3381,2)
 ;;=^5007578
 ;;^UTILITY(U,$J,358.3,3382,0)
 ;;=I70.212^^27^255^10
 ;;^UTILITY(U,$J,358.3,3382,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3382,1,3,0)
 ;;=3^Athscl Native Art of Left Leg w/ Intrmt Claud
 ;;^UTILITY(U,$J,358.3,3382,1,4,0)
 ;;=4^I70.212
 ;;^UTILITY(U,$J,358.3,3382,2)
 ;;=^5007579
 ;;^UTILITY(U,$J,358.3,3383,0)
 ;;=I70.213^^27^255^6
 ;;^UTILITY(U,$J,358.3,3383,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3383,1,3,0)
 ;;=3^Athscl Native Art of Bilateral Legs w/ Intrmt Claud
 ;;^UTILITY(U,$J,358.3,3383,1,4,0)
 ;;=4^I70.213
 ;;^UTILITY(U,$J,358.3,3383,2)
 ;;=^5007580
 ;;^UTILITY(U,$J,358.3,3384,0)
 ;;=I70.261^^27^255^12
 ;;^UTILITY(U,$J,358.3,3384,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3384,1,3,0)
 ;;=3^Athscl Native Art of Right Leg w/ Gangrene
 ;;^UTILITY(U,$J,358.3,3384,1,4,0)
 ;;=4^I70.261
 ;;^UTILITY(U,$J,358.3,3384,2)
 ;;=^5007603
 ;;^UTILITY(U,$J,358.3,3385,0)
 ;;=I70.262^^27^255^9
 ;;^UTILITY(U,$J,358.3,3385,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3385,1,3,0)
 ;;=3^Athscl Native Art of Left Leg w/ Gangrene
 ;;^UTILITY(U,$J,358.3,3385,1,4,0)
 ;;=4^I70.262
 ;;^UTILITY(U,$J,358.3,3385,2)
 ;;=^5007604
 ;;^UTILITY(U,$J,358.3,3386,0)
 ;;=I70.263^^27^255^7
 ;;^UTILITY(U,$J,358.3,3386,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3386,1,3,0)
 ;;=3^Athscl Native Art of Bilateral Legs w/ Gangrene
 ;;^UTILITY(U,$J,358.3,3386,1,4,0)
 ;;=4^I70.263
 ;;^UTILITY(U,$J,358.3,3386,2)
 ;;=^5007605
 ;;^UTILITY(U,$J,358.3,3387,0)
 ;;=I70.221^^27^255^14
 ;;^UTILITY(U,$J,358.3,3387,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3387,1,3,0)
 ;;=3^Athscl Native Art of Right Leg w/ Rest Pain
