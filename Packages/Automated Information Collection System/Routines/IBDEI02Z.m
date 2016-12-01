IBDEI02Z ; ; 09-AUG-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,3473,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3473,1,3,0)
 ;;=3^Acute Diastolic Heart Failure
 ;;^UTILITY(U,$J,358.3,3473,1,4,0)
 ;;=4^I50.31
 ;;^UTILITY(U,$J,358.3,3473,2)
 ;;=^5007244
 ;;^UTILITY(U,$J,358.3,3474,0)
 ;;=I50.32^^20^255^13
 ;;^UTILITY(U,$J,358.3,3474,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3474,1,3,0)
 ;;=3^Chronic Diastolic Heart Failure
 ;;^UTILITY(U,$J,358.3,3474,1,4,0)
 ;;=4^I50.32
 ;;^UTILITY(U,$J,358.3,3474,2)
 ;;=^5007245
 ;;^UTILITY(U,$J,358.3,3475,0)
 ;;=I50.33^^20^255^6
 ;;^UTILITY(U,$J,358.3,3475,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3475,1,3,0)
 ;;=3^Acute on Chronic Diastolic Heart Failure
 ;;^UTILITY(U,$J,358.3,3475,1,4,0)
 ;;=4^I50.33
 ;;^UTILITY(U,$J,358.3,3475,2)
 ;;=^5007246
 ;;^UTILITY(U,$J,358.3,3476,0)
 ;;=I50.21^^20^255^4
 ;;^UTILITY(U,$J,358.3,3476,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3476,1,3,0)
 ;;=3^Acute Systolic Heart Failure
 ;;^UTILITY(U,$J,358.3,3476,1,4,0)
 ;;=4^I50.21
 ;;^UTILITY(U,$J,358.3,3476,2)
 ;;=^5007240
 ;;^UTILITY(U,$J,358.3,3477,0)
 ;;=I50.22^^20^255^14
 ;;^UTILITY(U,$J,358.3,3477,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3477,1,3,0)
 ;;=3^Chronic Systolic Heart Failure
 ;;^UTILITY(U,$J,358.3,3477,1,4,0)
 ;;=4^I50.22
 ;;^UTILITY(U,$J,358.3,3477,2)
 ;;=^5007241
 ;;^UTILITY(U,$J,358.3,3478,0)
 ;;=I50.23^^20^255^7
 ;;^UTILITY(U,$J,358.3,3478,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3478,1,3,0)
 ;;=3^Acute on Chronic Systolic Heart Failure
 ;;^UTILITY(U,$J,358.3,3478,1,4,0)
 ;;=4^I50.23
 ;;^UTILITY(U,$J,358.3,3478,2)
 ;;=^5007242
 ;;^UTILITY(U,$J,358.3,3479,0)
 ;;=I50.20^^20^255^28
 ;;^UTILITY(U,$J,358.3,3479,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3479,1,3,0)
 ;;=3^Systolic Heart Failure,Unspec
 ;;^UTILITY(U,$J,358.3,3479,1,4,0)
 ;;=4^I50.20
 ;;^UTILITY(U,$J,358.3,3479,2)
 ;;=^5007239
 ;;^UTILITY(U,$J,358.3,3480,0)
 ;;=I65.23^^20^255^23
 ;;^UTILITY(U,$J,358.3,3480,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3480,1,3,0)
 ;;=3^Occlusion/Stenosis of Bilateral Carotid Arteries
 ;;^UTILITY(U,$J,358.3,3480,1,4,0)
 ;;=4^I65.23
 ;;^UTILITY(U,$J,358.3,3480,2)
 ;;=^5007362
 ;;^UTILITY(U,$J,358.3,3481,0)
 ;;=I65.22^^20^255^24
 ;;^UTILITY(U,$J,358.3,3481,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3481,1,3,0)
 ;;=3^Occlusion/Stenosis of Left Carotid Artery
 ;;^UTILITY(U,$J,358.3,3481,1,4,0)
 ;;=4^I65.22
 ;;^UTILITY(U,$J,358.3,3481,2)
 ;;=^5007361
 ;;^UTILITY(U,$J,358.3,3482,0)
 ;;=I65.21^^20^255^26
 ;;^UTILITY(U,$J,358.3,3482,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3482,1,3,0)
 ;;=3^Occlusion/Stenosis of Right Carotid Artery
 ;;^UTILITY(U,$J,358.3,3482,1,4,0)
 ;;=4^I65.21
 ;;^UTILITY(U,$J,358.3,3482,2)
 ;;=^5007360
 ;;^UTILITY(U,$J,358.3,3483,0)
 ;;=I65.8^^20^255^25
 ;;^UTILITY(U,$J,358.3,3483,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3483,1,3,0)
 ;;=3^Occlusion/Stenosis of Precerebral Arteries NEC
 ;;^UTILITY(U,$J,358.3,3483,1,4,0)
 ;;=4^I65.8
 ;;^UTILITY(U,$J,358.3,3483,2)
 ;;=^5007364
 ;;^UTILITY(U,$J,358.3,3484,0)
 ;;=I70.211^^20^255^11
 ;;^UTILITY(U,$J,358.3,3484,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3484,1,3,0)
 ;;=3^Athscl Native Arteries of Right Leg w/ Intrmt Claud
 ;;^UTILITY(U,$J,358.3,3484,1,4,0)
 ;;=4^I70.211
 ;;^UTILITY(U,$J,358.3,3484,2)
 ;;=^5007578
 ;;^UTILITY(U,$J,358.3,3485,0)
 ;;=I70.212^^20^255^10
 ;;^UTILITY(U,$J,358.3,3485,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3485,1,3,0)
 ;;=3^Athscl Native Arteries of Left Leg w/ Intrmt Claud
 ;;^UTILITY(U,$J,358.3,3485,1,4,0)
 ;;=4^I70.212
 ;;^UTILITY(U,$J,358.3,3485,2)
 ;;=^5007579
 ;;^UTILITY(U,$J,358.3,3486,0)
 ;;=I70.213^^20^255^9
 ;;^UTILITY(U,$J,358.3,3486,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3486,1,3,0)
 ;;=3^Athscl Native Arteries of Bilateral Legs w/ Intrmt Claud
 ;;^UTILITY(U,$J,358.3,3486,1,4,0)
 ;;=4^I70.213
 ;;^UTILITY(U,$J,358.3,3486,2)
 ;;=^5007580
 ;;^UTILITY(U,$J,358.3,3487,0)
 ;;=I71.2^^20^255^29
 ;;^UTILITY(U,$J,358.3,3487,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3487,1,3,0)
 ;;=3^Thoracic Aortic Aneurysm w/o Rupture
 ;;^UTILITY(U,$J,358.3,3487,1,4,0)
 ;;=4^I71.2
 ;;^UTILITY(U,$J,358.3,3487,2)
 ;;=^5007787
 ;;^UTILITY(U,$J,358.3,3488,0)
 ;;=I71.4^^20^255^1
 ;;^UTILITY(U,$J,358.3,3488,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3488,1,3,0)
 ;;=3^Abdominal Aortic Aneurysm w/o Rupture
 ;;^UTILITY(U,$J,358.3,3488,1,4,0)
 ;;=4^I71.4
 ;;^UTILITY(U,$J,358.3,3488,2)
 ;;=^5007789
 ;;^UTILITY(U,$J,358.3,3489,0)
 ;;=I73.9^^20^255^27
 ;;^UTILITY(U,$J,358.3,3489,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3489,1,3,0)
 ;;=3^Peripheral Vascular Disease,Unspec
 ;;^UTILITY(U,$J,358.3,3489,1,4,0)
 ;;=4^I73.9
 ;;^UTILITY(U,$J,358.3,3489,2)
 ;;=^184182
 ;;^UTILITY(U,$J,358.3,3490,0)
 ;;=I74.2^^20^255^21
 ;;^UTILITY(U,$J,358.3,3490,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3490,1,3,0)
 ;;=3^Embolism/Thrombosis of Upper Extremity Arteries
 ;;^UTILITY(U,$J,358.3,3490,1,4,0)
 ;;=4^I74.2
 ;;^UTILITY(U,$J,358.3,3490,2)
 ;;=^5007801
 ;;^UTILITY(U,$J,358.3,3491,0)
 ;;=I74.3^^20^255^19
 ;;^UTILITY(U,$J,358.3,3491,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3491,1,3,0)
 ;;=3^Embolism/Thrombosis of Lower Extremity Arteries
 ;;^UTILITY(U,$J,358.3,3491,1,4,0)
 ;;=4^I74.3
 ;;^UTILITY(U,$J,358.3,3491,2)
 ;;=^5007802
 ;;^UTILITY(U,$J,358.3,3492,0)
 ;;=I82.402^^20^255^18
 ;;^UTILITY(U,$J,358.3,3492,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3492,1,3,0)
 ;;=3^Embolism/Thrombosis of Left Lower Extrem Deep Veins,Acute
 ;;^UTILITY(U,$J,358.3,3492,1,4,0)
 ;;=4^I82.402
 ;;^UTILITY(U,$J,358.3,3492,2)
 ;;=^5007855
 ;;^UTILITY(U,$J,358.3,3493,0)
 ;;=I82.401^^20^255^20
 ;;^UTILITY(U,$J,358.3,3493,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3493,1,3,0)
 ;;=3^Embolism/Thrombosis of Right Lower Extrem Deep Veins,Acute
 ;;^UTILITY(U,$J,358.3,3493,1,4,0)
 ;;=4^I82.401
 ;;^UTILITY(U,$J,358.3,3493,2)
 ;;=^5007854
 ;;^UTILITY(U,$J,358.3,3494,0)
 ;;=I82.403^^20^255^17
 ;;^UTILITY(U,$J,358.3,3494,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3494,1,3,0)
 ;;=3^Embolism/Thrombosis of Bilateral Lower Extrem Deep Veins,Acute
 ;;^UTILITY(U,$J,358.3,3494,1,4,0)
 ;;=4^I82.403
 ;;^UTILITY(U,$J,358.3,3494,2)
 ;;=^5007856
 ;;^UTILITY(U,$J,358.3,3495,0)
 ;;=K70.30^^20^256^2
 ;;^UTILITY(U,$J,358.3,3495,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3495,1,3,0)
 ;;=3^Alcoholic Cirrhosis of Liver w/o Ascites
 ;;^UTILITY(U,$J,358.3,3495,1,4,0)
 ;;=4^K70.30
 ;;^UTILITY(U,$J,358.3,3495,2)
 ;;=^5008788
 ;;^UTILITY(U,$J,358.3,3496,0)
 ;;=K70.31^^20^256^1
 ;;^UTILITY(U,$J,358.3,3496,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3496,1,3,0)
 ;;=3^Alcoholic Cirrhosis of Liver w/ Ascites
 ;;^UTILITY(U,$J,358.3,3496,1,4,0)
 ;;=4^K70.31
 ;;^UTILITY(U,$J,358.3,3496,2)
 ;;=^5008789
 ;;^UTILITY(U,$J,358.3,3497,0)
 ;;=K74.60^^20^256^5
 ;;^UTILITY(U,$J,358.3,3497,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3497,1,3,0)
 ;;=3^Cirrhosis of Liver,Unspec
 ;;^UTILITY(U,$J,358.3,3497,1,4,0)
 ;;=4^K74.60
 ;;^UTILITY(U,$J,358.3,3497,2)
 ;;=^5008822
 ;;^UTILITY(U,$J,358.3,3498,0)
 ;;=K74.69^^20^256^4
 ;;^UTILITY(U,$J,358.3,3498,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3498,1,3,0)
 ;;=3^Cirrhosis of Liver NEC
 ;;^UTILITY(U,$J,358.3,3498,1,4,0)
 ;;=4^K74.69
 ;;^UTILITY(U,$J,358.3,3498,2)
 ;;=^5008823
 ;;^UTILITY(U,$J,358.3,3499,0)
 ;;=K70.2^^20^256^3
 ;;^UTILITY(U,$J,358.3,3499,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3499,1,3,0)
 ;;=3^Alcoholic Fibrosis/Sclerosis of Liver
 ;;^UTILITY(U,$J,358.3,3499,1,4,0)
 ;;=4^K70.2
 ;;^UTILITY(U,$J,358.3,3499,2)
 ;;=^5008787
 ;;^UTILITY(U,$J,358.3,3500,0)
 ;;=K74.0^^20^256^6
 ;;^UTILITY(U,$J,358.3,3500,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3500,1,3,0)
 ;;=3^Hepatic Fibrosis
 ;;^UTILITY(U,$J,358.3,3500,1,4,0)
 ;;=4^K74.0
 ;;^UTILITY(U,$J,358.3,3500,2)
 ;;=^5008816
 ;;^UTILITY(U,$J,358.3,3501,0)
 ;;=K74.2^^20^256^7
 ;;^UTILITY(U,$J,358.3,3501,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3501,1,3,0)
 ;;=3^Hepatic Fibrosis w/ Hepatic Sclerosis
 ;;^UTILITY(U,$J,358.3,3501,1,4,0)
 ;;=4^K74.2
 ;;^UTILITY(U,$J,358.3,3501,2)
 ;;=^5008818
 ;;^UTILITY(U,$J,358.3,3502,0)
 ;;=K74.1^^20^256^8
 ;;^UTILITY(U,$J,358.3,3502,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3502,1,3,0)
 ;;=3^Hepatic Sclerosis
 ;;^UTILITY(U,$J,358.3,3502,1,4,0)
 ;;=4^K74.1
 ;;^UTILITY(U,$J,358.3,3502,2)
 ;;=^5008817
 ;;^UTILITY(U,$J,358.3,3503,0)
 ;;=K52.2^^20^257^1
 ;;^UTILITY(U,$J,358.3,3503,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3503,1,3,0)
 ;;=3^Allergic/Dietetic Gastroenteritis/Colitis
 ;;^UTILITY(U,$J,358.3,3503,1,4,0)
 ;;=4^K52.2
 ;;^UTILITY(U,$J,358.3,3503,2)
 ;;=^5008701
 ;;^UTILITY(U,$J,358.3,3504,0)
 ;;=K52.89^^20^257^2
 ;;^UTILITY(U,$J,358.3,3504,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3504,1,3,0)
 ;;=3^Noninfective Gastroenteritis/Colitis NEC
 ;;^UTILITY(U,$J,358.3,3504,1,4,0)
 ;;=4^K52.89
 ;;^UTILITY(U,$J,358.3,3504,2)
 ;;=^5008703
 ;;^UTILITY(U,$J,358.3,3505,0)
 ;;=K51.90^^20^257^9
 ;;^UTILITY(U,$J,358.3,3505,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3505,1,3,0)
 ;;=3^Ulcerative Colitis w/o Complications,Unspec
 ;;^UTILITY(U,$J,358.3,3505,1,4,0)
 ;;=4^K51.90
 ;;^UTILITY(U,$J,358.3,3505,2)
 ;;=^5008694
 ;;^UTILITY(U,$J,358.3,3506,0)
 ;;=K51.919^^20^257^8
 ;;^UTILITY(U,$J,358.3,3506,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3506,1,3,0)
 ;;=3^Ulcerative Colitis w/ Unspec Complications,Unspec
 ;;^UTILITY(U,$J,358.3,3506,1,4,0)
 ;;=4^K51.919
 ;;^UTILITY(U,$J,358.3,3506,2)
 ;;=^5008700
 ;;^UTILITY(U,$J,358.3,3507,0)
 ;;=K51.912^^20^257^5
 ;;^UTILITY(U,$J,358.3,3507,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3507,1,3,0)
 ;;=3^Ulcerative Colitis w/ Intestinal Obstruction,Unspec
 ;;^UTILITY(U,$J,358.3,3507,1,4,0)
 ;;=4^K51.912
 ;;^UTILITY(U,$J,358.3,3507,2)
 ;;=^5008696
 ;;^UTILITY(U,$J,358.3,3508,0)
 ;;=K51.913^^20^257^4
 ;;^UTILITY(U,$J,358.3,3508,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3508,1,3,0)
 ;;=3^Ulcerative Colitis w/ Fistula,Unspec
