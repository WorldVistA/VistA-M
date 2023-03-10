IBDEI017 ; ; 01-AUG-2022
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;AUG 01, 2022
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,2393,1,4,0)
 ;;=4^I97.0
 ;;^UTILITY(U,$J,358.3,2393,2)
 ;;=^5008082
 ;;^UTILITY(U,$J,358.3,2394,0)
 ;;=I97.110^^20^150^59
 ;;^UTILITY(U,$J,358.3,2394,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2394,1,3,0)
 ;;=3^Postprocedural Cardiac Insufficiency Following Cardiac Surgery
 ;;^UTILITY(U,$J,358.3,2394,1,4,0)
 ;;=4^I97.110
 ;;^UTILITY(U,$J,358.3,2394,2)
 ;;=^5008083
 ;;^UTILITY(U,$J,358.3,2395,0)
 ;;=T86.20^^20^150^23
 ;;^UTILITY(U,$J,358.3,2395,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2395,1,3,0)
 ;;=3^Complication of Heart Transplant,Unspec
 ;;^UTILITY(U,$J,358.3,2395,1,4,0)
 ;;=4^T86.20
 ;;^UTILITY(U,$J,358.3,2395,2)
 ;;=^5055713
 ;;^UTILITY(U,$J,358.3,2396,0)
 ;;=T86.21^^20^150^39
 ;;^UTILITY(U,$J,358.3,2396,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2396,1,3,0)
 ;;=3^Heart Transplant Rejection
 ;;^UTILITY(U,$J,358.3,2396,1,4,0)
 ;;=4^T86.21
 ;;^UTILITY(U,$J,358.3,2396,2)
 ;;=^5055714
 ;;^UTILITY(U,$J,358.3,2397,0)
 ;;=T86.22^^20^150^37
 ;;^UTILITY(U,$J,358.3,2397,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2397,1,3,0)
 ;;=3^Heart Transplant Failure
 ;;^UTILITY(U,$J,358.3,2397,1,4,0)
 ;;=4^T86.22
 ;;^UTILITY(U,$J,358.3,2397,2)
 ;;=^5055715
 ;;^UTILITY(U,$J,358.3,2398,0)
 ;;=T86.23^^20^150^38
 ;;^UTILITY(U,$J,358.3,2398,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2398,1,3,0)
 ;;=3^Heart Transplant Infection
 ;;^UTILITY(U,$J,358.3,2398,1,4,0)
 ;;=4^T86.23
 ;;^UTILITY(U,$J,358.3,2398,2)
 ;;=^5055716
 ;;^UTILITY(U,$J,358.3,2399,0)
 ;;=T86.290^^20^150^13
 ;;^UTILITY(U,$J,358.3,2399,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2399,1,3,0)
 ;;=3^Cardiac Allograft Vasculopathy
 ;;^UTILITY(U,$J,358.3,2399,1,4,0)
 ;;=4^T86.290
 ;;^UTILITY(U,$J,358.3,2399,2)
 ;;=^5055717
 ;;^UTILITY(U,$J,358.3,2400,0)
 ;;=T86.298^^20^150^28
 ;;^UTILITY(U,$J,358.3,2400,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2400,1,3,0)
 ;;=3^Complications of Heart Transplant NEC
 ;;^UTILITY(U,$J,358.3,2400,1,4,0)
 ;;=4^T86.298
 ;;^UTILITY(U,$J,358.3,2400,2)
 ;;=^5055718
 ;;^UTILITY(U,$J,358.3,2401,0)
 ;;=T86.30^^20^150^24
 ;;^UTILITY(U,$J,358.3,2401,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2401,1,3,0)
 ;;=3^Complication of Heart-Lung Transplant,Unspec
 ;;^UTILITY(U,$J,358.3,2401,1,4,0)
 ;;=4^T86.30
 ;;^UTILITY(U,$J,358.3,2401,2)
 ;;=^5055719
 ;;^UTILITY(U,$J,358.3,2402,0)
 ;;=T86.39^^20^150^29
 ;;^UTILITY(U,$J,358.3,2402,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2402,1,3,0)
 ;;=3^Complications of Heart-Lung Transplant NEC
 ;;^UTILITY(U,$J,358.3,2402,1,4,0)
 ;;=4^T86.39
 ;;^UTILITY(U,$J,358.3,2402,2)
 ;;=^5055723
 ;;^UTILITY(U,$J,358.3,2403,0)
 ;;=T86.31^^20^150^44
 ;;^UTILITY(U,$J,358.3,2403,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2403,1,3,0)
 ;;=3^Heart-Lung Transplant Rejection
 ;;^UTILITY(U,$J,358.3,2403,1,4,0)
 ;;=4^T86.31
 ;;^UTILITY(U,$J,358.3,2403,2)
 ;;=^5055720
 ;;^UTILITY(U,$J,358.3,2404,0)
 ;;=T86.32^^20^150^42
 ;;^UTILITY(U,$J,358.3,2404,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2404,1,3,0)
 ;;=3^Heart-Lung Transplant Failure
 ;;^UTILITY(U,$J,358.3,2404,1,4,0)
 ;;=4^T86.32
 ;;^UTILITY(U,$J,358.3,2404,2)
 ;;=^5055721
 ;;^UTILITY(U,$J,358.3,2405,0)
 ;;=T86.33^^20^150^43
 ;;^UTILITY(U,$J,358.3,2405,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2405,1,3,0)
 ;;=3^Heart-Lung Transplant Infection
 ;;^UTILITY(U,$J,358.3,2405,1,4,0)
 ;;=4^T86.33
 ;;^UTILITY(U,$J,358.3,2405,2)
 ;;=^5055722
 ;;^UTILITY(U,$J,358.3,2406,0)
 ;;=T86.810^^20^150^51
 ;;^UTILITY(U,$J,358.3,2406,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2406,1,3,0)
 ;;=3^Lung Transplant Rejection
 ;;^UTILITY(U,$J,358.3,2406,1,4,0)
 ;;=4^T86.810
 ;;^UTILITY(U,$J,358.3,2406,2)
 ;;=^5055730
 ;;^UTILITY(U,$J,358.3,2407,0)
 ;;=T86.811^^20^150^50
 ;;^UTILITY(U,$J,358.3,2407,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2407,1,3,0)
 ;;=3^Lung Transplant Failure
 ;;^UTILITY(U,$J,358.3,2407,1,4,0)
 ;;=4^T86.811
 ;;^UTILITY(U,$J,358.3,2407,2)
 ;;=^5055731
 ;;^UTILITY(U,$J,358.3,2408,0)
 ;;=T86.819^^20^150^26
 ;;^UTILITY(U,$J,358.3,2408,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2408,1,3,0)
 ;;=3^Complication of Lung Transplant,Unspec
 ;;^UTILITY(U,$J,358.3,2408,1,4,0)
 ;;=4^T86.819
 ;;^UTILITY(U,$J,358.3,2408,2)
 ;;=^5137975
 ;;^UTILITY(U,$J,358.3,2409,0)
 ;;=T86.818^^20^150^25
 ;;^UTILITY(U,$J,358.3,2409,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2409,1,3,0)
 ;;=3^Complication of Lung Transplant NEC
 ;;^UTILITY(U,$J,358.3,2409,1,4,0)
 ;;=4^T86.818
 ;;^UTILITY(U,$J,358.3,2409,2)
 ;;=^5055733
 ;;^UTILITY(U,$J,358.3,2410,0)
 ;;=Z94.1^^20^150^40
 ;;^UTILITY(U,$J,358.3,2410,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2410,1,3,0)
 ;;=3^Heart Transplant Status
 ;;^UTILITY(U,$J,358.3,2410,1,4,0)
 ;;=4^Z94.1
 ;;^UTILITY(U,$J,358.3,2410,2)
 ;;=^5063655
 ;;^UTILITY(U,$J,358.3,2411,0)
 ;;=Z94.3^^20^150^41
 ;;^UTILITY(U,$J,358.3,2411,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2411,1,3,0)
 ;;=3^Heart and Lungs Transplant Status
 ;;^UTILITY(U,$J,358.3,2411,1,4,0)
 ;;=4^Z94.3
 ;;^UTILITY(U,$J,358.3,2411,2)
 ;;=^5063657
 ;;^UTILITY(U,$J,358.3,2412,0)
 ;;=Z48.21^^20^150^8
 ;;^UTILITY(U,$J,358.3,2412,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2412,1,3,0)
 ;;=3^Aftercare Following Heart Transplant
 ;;^UTILITY(U,$J,358.3,2412,1,4,0)
 ;;=4^Z48.21
 ;;^UTILITY(U,$J,358.3,2412,2)
 ;;=^5063038
 ;;^UTILITY(U,$J,358.3,2413,0)
 ;;=Z48.280^^20^150^9
 ;;^UTILITY(U,$J,358.3,2413,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2413,1,3,0)
 ;;=3^Aftercare Following Heart-Lung Transplant
 ;;^UTILITY(U,$J,358.3,2413,1,4,0)
 ;;=4^Z48.280
 ;;^UTILITY(U,$J,358.3,2413,2)
 ;;=^5063042
 ;;^UTILITY(U,$J,358.3,2414,0)
 ;;=I50.41^^20^150^1
 ;;^UTILITY(U,$J,358.3,2414,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2414,1,3,0)
 ;;=3^Acute Combined Systolic & Diastolic Hrt Failure
 ;;^UTILITY(U,$J,358.3,2414,1,4,0)
 ;;=4^I50.41
 ;;^UTILITY(U,$J,358.3,2414,2)
 ;;=^5007248
 ;;^UTILITY(U,$J,358.3,2415,0)
 ;;=I50.30^^20^150^2
 ;;^UTILITY(U,$J,358.3,2415,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2415,1,3,0)
 ;;=3^Acute Diastolic Heart Failure
 ;;^UTILITY(U,$J,358.3,2415,1,4,0)
 ;;=4^I50.30
 ;;^UTILITY(U,$J,358.3,2415,2)
 ;;=^5007243
 ;;^UTILITY(U,$J,358.3,2416,0)
 ;;=I50.33^^20^150^5
 ;;^UTILITY(U,$J,358.3,2416,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2416,1,3,0)
 ;;=3^Acute on Chronic Diastolic Heart Failure
 ;;^UTILITY(U,$J,358.3,2416,1,4,0)
 ;;=4^I50.33
 ;;^UTILITY(U,$J,358.3,2416,2)
 ;;=^5007246
 ;;^UTILITY(U,$J,358.3,2417,0)
 ;;=I50.23^^20^150^7
 ;;^UTILITY(U,$J,358.3,2417,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2417,1,3,0)
 ;;=3^Acute on Chronic Systolic Heart Failure
 ;;^UTILITY(U,$J,358.3,2417,1,4,0)
 ;;=4^I50.23
 ;;^UTILITY(U,$J,358.3,2417,2)
 ;;=^5007242
 ;;^UTILITY(U,$J,358.3,2418,0)
 ;;=I50.21^^20^150^4
 ;;^UTILITY(U,$J,358.3,2418,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2418,1,3,0)
 ;;=3^Acute Systolic Heart Failure
 ;;^UTILITY(U,$J,358.3,2418,1,4,0)
 ;;=4^I50.21
 ;;^UTILITY(U,$J,358.3,2418,2)
 ;;=^5007240
 ;;^UTILITY(U,$J,358.3,2419,0)
 ;;=I50.42^^20^150^18
 ;;^UTILITY(U,$J,358.3,2419,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2419,1,3,0)
 ;;=3^Chronic Combined Systolic & Diastolic Heart Failure
 ;;^UTILITY(U,$J,358.3,2419,1,4,0)
 ;;=4^I50.42
 ;;^UTILITY(U,$J,358.3,2419,2)
 ;;=^5007249
 ;;^UTILITY(U,$J,358.3,2420,0)
 ;;=I50.32^^20^150^19
 ;;^UTILITY(U,$J,358.3,2420,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2420,1,3,0)
 ;;=3^Chronic Diastolic Heart Failure
 ;;^UTILITY(U,$J,358.3,2420,1,4,0)
 ;;=4^I50.32
 ;;^UTILITY(U,$J,358.3,2420,2)
 ;;=^5007245
 ;;^UTILITY(U,$J,358.3,2421,0)
 ;;=I13.0^^20^150^34
 ;;^UTILITY(U,$J,358.3,2421,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2421,1,3,0)
 ;;=3^HTN Hrt & CKD w/ Hrt Failure,Stg 1-4 CKD
 ;;^UTILITY(U,$J,358.3,2421,1,4,0)
 ;;=4^I13.0
 ;;^UTILITY(U,$J,358.3,2421,2)
 ;;=^5007067
 ;;^UTILITY(U,$J,358.3,2422,0)
 ;;=I13.2^^20^150^35
 ;;^UTILITY(U,$J,358.3,2422,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2422,1,3,0)
 ;;=3^HTN Hrt & CKD w/ Hrt Failure,Stg 5 or ESRD
 ;;^UTILITY(U,$J,358.3,2422,1,4,0)
 ;;=4^I13.2
 ;;^UTILITY(U,$J,358.3,2422,2)
 ;;=^5007070
 ;;^UTILITY(U,$J,358.3,2423,0)
 ;;=I11.0^^20^150^46
 ;;^UTILITY(U,$J,358.3,2423,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2423,1,3,0)
 ;;=3^Hypertensive Hrt Disease w/ Heart Failure
 ;;^UTILITY(U,$J,358.3,2423,1,4,0)
 ;;=4^I11.0
 ;;^UTILITY(U,$J,358.3,2423,2)
 ;;=^5007063
 ;;^UTILITY(U,$J,358.3,2424,0)
 ;;=I09.81^^20^150^69
 ;;^UTILITY(U,$J,358.3,2424,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2424,1,3,0)
 ;;=3^Rheumatic Hrt Failure
 ;;^UTILITY(U,$J,358.3,2424,1,4,0)
 ;;=4^I09.81
 ;;^UTILITY(U,$J,358.3,2424,2)
 ;;=^5007059
 ;;^UTILITY(U,$J,358.3,2425,0)
 ;;=I50.813^^20^150^6
 ;;^UTILITY(U,$J,358.3,2425,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2425,1,3,0)
 ;;=3^Acute on Chronic Right Heart Failure
 ;;^UTILITY(U,$J,358.3,2425,1,4,0)
 ;;=4^I50.813
 ;;^UTILITY(U,$J,358.3,2425,2)
 ;;=^5151387
 ;;^UTILITY(U,$J,358.3,2426,0)
 ;;=I50.811^^20^150^3
 ;;^UTILITY(U,$J,358.3,2426,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2426,1,3,0)
 ;;=3^Acute Right Heart Failure
 ;;^UTILITY(U,$J,358.3,2426,1,4,0)
 ;;=4^I50.811
 ;;^UTILITY(U,$J,358.3,2426,2)
 ;;=^5151385
 ;;^UTILITY(U,$J,358.3,2427,0)
 ;;=I50.82^^20^150^12
 ;;^UTILITY(U,$J,358.3,2427,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2427,1,3,0)
 ;;=3^Biventricular Heart Failure
 ;;^UTILITY(U,$J,358.3,2427,1,4,0)
 ;;=4^I50.82
 ;;^UTILITY(U,$J,358.3,2427,2)
 ;;=^5151389
 ;;^UTILITY(U,$J,358.3,2428,0)
 ;;=I50.812^^20^150^20
 ;;^UTILITY(U,$J,358.3,2428,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2428,1,3,0)
 ;;=3^Chronic Right Heart Failure
 ;;^UTILITY(U,$J,358.3,2428,1,4,0)
 ;;=4^I50.812
 ;;^UTILITY(U,$J,358.3,2428,2)
 ;;=^5151386
 ;;^UTILITY(U,$J,358.3,2429,0)
 ;;=I50.84^^20^150^33
 ;;^UTILITY(U,$J,358.3,2429,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2429,1,3,0)
 ;;=3^End Stage Heart Failure
 ;;^UTILITY(U,$J,358.3,2429,1,4,0)
 ;;=4^I50.84
 ;;^UTILITY(U,$J,358.3,2429,2)
 ;;=^5151391
 ;;^UTILITY(U,$J,358.3,2430,0)
 ;;=I50.83^^20^150^45
 ;;^UTILITY(U,$J,358.3,2430,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2430,1,3,0)
 ;;=3^High Output Heart Failure
 ;;^UTILITY(U,$J,358.3,2430,1,4,0)
 ;;=4^I50.83
 ;;^UTILITY(U,$J,358.3,2430,2)
 ;;=^5151390
 ;;^UTILITY(U,$J,358.3,2431,0)
 ;;=I27.21^^20^150^63
 ;;^UTILITY(U,$J,358.3,2431,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2431,1,3,0)
 ;;=3^Pulmonary Arterial Hypertension
 ;;^UTILITY(U,$J,358.3,2431,1,4,0)
 ;;=4^I27.21
 ;;^UTILITY(U,$J,358.3,2431,2)
 ;;=^5151377
 ;;^UTILITY(U,$J,358.3,2432,0)
 ;;=I27.22^^20^150^66
 ;;^UTILITY(U,$J,358.3,2432,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2432,1,3,0)
 ;;=3^Pulmonary HTN d/t Left Heart Disease
 ;;^UTILITY(U,$J,358.3,2432,1,4,0)
 ;;=4^I27.22
 ;;^UTILITY(U,$J,358.3,2432,2)
 ;;=^5151378
 ;;^UTILITY(U,$J,358.3,2433,0)
 ;;=I50.814^^20^150^70
 ;;^UTILITY(U,$J,358.3,2433,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2433,1,3,0)
 ;;=3^Right Heart Failure d/t Left Heart Failure
 ;;^UTILITY(U,$J,358.3,2433,1,4,0)
 ;;=4^I50.814
 ;;^UTILITY(U,$J,358.3,2433,2)
 ;;=^5151388
 ;;^UTILITY(U,$J,358.3,2434,0)
 ;;=I50.22^^20^150^21
 ;;^UTILITY(U,$J,358.3,2434,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2434,1,3,0)
 ;;=3^Chronic Systolic Heart Failure
 ;;^UTILITY(U,$J,358.3,2434,1,4,0)
 ;;=4^I50.22
 ;;^UTILITY(U,$J,358.3,2434,2)
 ;;=^5007241
 ;;^UTILITY(U,$J,358.3,2435,0)
 ;;=I25.10^^20^151^2
 ;;^UTILITY(U,$J,358.3,2435,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2435,1,3,0)
 ;;=3^Athscl Hrt Disease of Native Coronary Artery w/o Ang Pctrs
 ;;^UTILITY(U,$J,358.3,2435,1,4,0)
 ;;=4^I25.10
 ;;^UTILITY(U,$J,358.3,2435,2)
 ;;=^5007107
 ;;^UTILITY(U,$J,358.3,2436,0)
 ;;=I25.110^^20^151^3
 ;;^UTILITY(U,$J,358.3,2436,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2436,1,3,0)
 ;;=3^Athscl Hrt Disease of Native Coronary Artery w/ Unstable Ang Pctrs
 ;;^UTILITY(U,$J,358.3,2436,1,4,0)
 ;;=4^I25.110
 ;;^UTILITY(U,$J,358.3,2436,2)
 ;;=^5007108
 ;;^UTILITY(U,$J,358.3,2437,0)
 ;;=I25.111^^20^151^4
 ;;^UTILITY(U,$J,358.3,2437,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2437,1,3,0)
 ;;=3^Athscl Hrt Disease of Native Coronary Artery w/ Ang Pctrs w/ Spasm
 ;;^UTILITY(U,$J,358.3,2437,1,4,0)
 ;;=4^I25.111
 ;;^UTILITY(U,$J,358.3,2437,2)
 ;;=^5007109
 ;;^UTILITY(U,$J,358.3,2438,0)
 ;;=I25.118^^20^151^5
 ;;^UTILITY(U,$J,358.3,2438,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2438,1,3,0)
 ;;=3^Athscl Hrt Disease of Native Coronary Artery w/ Oth Ang Pctrs
 ;;^UTILITY(U,$J,358.3,2438,1,4,0)
 ;;=4^I25.118
 ;;^UTILITY(U,$J,358.3,2438,2)
 ;;=^5007110
 ;;^UTILITY(U,$J,358.3,2439,0)
 ;;=I25.119^^20^151^6
 ;;^UTILITY(U,$J,358.3,2439,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2439,1,3,0)
 ;;=3^Athscl Hrt Disease of Native Coronary Artery w/ Unspec Ang Pctrs
 ;;^UTILITY(U,$J,358.3,2439,1,4,0)
 ;;=4^I25.119
 ;;^UTILITY(U,$J,358.3,2439,2)
 ;;=^5007111
 ;;^UTILITY(U,$J,358.3,2440,0)
 ;;=I25.810^^20^151^1
 ;;^UTILITY(U,$J,358.3,2440,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2440,1,3,0)
 ;;=3^Atherosclerosis of CABG w/o Angina Pectoris
 ;;^UTILITY(U,$J,358.3,2440,1,4,0)
 ;;=4^I25.810
 ;;^UTILITY(U,$J,358.3,2440,2)
 ;;=^5007141
 ;;^UTILITY(U,$J,358.3,2441,0)
 ;;=I25.82^^20^151^10
 ;;^UTILITY(U,$J,358.3,2441,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2441,1,3,0)
 ;;=3^Total Occlusion of Coronary Artery,Chronic
 ;;^UTILITY(U,$J,358.3,2441,1,4,0)
 ;;=4^I25.82
 ;;^UTILITY(U,$J,358.3,2441,2)
 ;;=^335262
 ;;^UTILITY(U,$J,358.3,2442,0)
 ;;=I25.83^^20^151^8
 ;;^UTILITY(U,$J,358.3,2442,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2442,1,3,0)
 ;;=3^Coronary Atherosclerosis d/t Lipid Rich Plaque
 ;;^UTILITY(U,$J,358.3,2442,1,4,0)
 ;;=4^I25.83
 ;;^UTILITY(U,$J,358.3,2442,2)
 ;;=^336601
 ;;^UTILITY(U,$J,358.3,2443,0)
 ;;=I25.84^^20^151^7
 ;;^UTILITY(U,$J,358.3,2443,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2443,1,3,0)
 ;;=3^Coronary Atherosclerosis d/t Calcified Coronary Lesion
 ;;^UTILITY(U,$J,358.3,2443,1,4,0)
 ;;=4^I25.84
 ;;^UTILITY(U,$J,358.3,2443,2)
 ;;=^340518
 ;;^UTILITY(U,$J,358.3,2444,0)
 ;;=I25.89^^20^151^9
 ;;^UTILITY(U,$J,358.3,2444,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2444,1,3,0)
 ;;=3^Ischemic Heart Disease,Chronic NEC
 ;;^UTILITY(U,$J,358.3,2444,1,4,0)
 ;;=4^I25.89
 ;;^UTILITY(U,$J,358.3,2444,2)
 ;;=^269679
 ;;^UTILITY(U,$J,358.3,2445,0)
 ;;=E66.9^^20^152^5
 ;;^UTILITY(U,$J,358.3,2445,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2445,1,3,0)
 ;;=3^Obesity,Unspec
 ;;^UTILITY(U,$J,358.3,2445,1,4,0)
 ;;=4^E66.9
 ;;^UTILITY(U,$J,358.3,2445,2)
 ;;=^5002832
 ;;^UTILITY(U,$J,358.3,2446,0)
 ;;=R60.9^^20^152^4
 ;;^UTILITY(U,$J,358.3,2446,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2446,1,3,0)
 ;;=3^Edema,Unspec
 ;;^UTILITY(U,$J,358.3,2446,1,4,0)
 ;;=4^R60.9
 ;;^UTILITY(U,$J,358.3,2446,2)
 ;;=^5019534
 ;;^UTILITY(U,$J,358.3,2447,0)
 ;;=R00.2^^20^152^7
 ;;^UTILITY(U,$J,358.3,2447,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2447,1,3,0)
 ;;=3^Palpitations
 ;;^UTILITY(U,$J,358.3,2447,1,4,0)
 ;;=4^R00.2
 ;;^UTILITY(U,$J,358.3,2447,2)
 ;;=^5019165
 ;;^UTILITY(U,$J,358.3,2448,0)
 ;;=R01.1^^20^152^2
 ;;^UTILITY(U,$J,358.3,2448,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2448,1,3,0)
 ;;=3^Cardiac Murmur,Unspec
 ;;^UTILITY(U,$J,358.3,2448,1,4,0)
 ;;=4^R01.1
 ;;^UTILITY(U,$J,358.3,2448,2)
 ;;=^5019169
 ;;^UTILITY(U,$J,358.3,2449,0)
 ;;=R06.01^^20^152^6
 ;;^UTILITY(U,$J,358.3,2449,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2449,1,3,0)
 ;;=3^Orthopnea
 ;;^UTILITY(U,$J,358.3,2449,1,4,0)
 ;;=4^R06.01
 ;;^UTILITY(U,$J,358.3,2449,2)
 ;;=^186737
 ;;^UTILITY(U,$J,358.3,2450,0)
 ;;=R06.81^^20^152^1
 ;;^UTILITY(U,$J,358.3,2450,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2450,1,3,0)
 ;;=3^Apnea NEC
 ;;^UTILITY(U,$J,358.3,2450,1,4,0)
 ;;=4^R06.81
 ;;^UTILITY(U,$J,358.3,2450,2)
 ;;=^5019190
 ;;^UTILITY(U,$J,358.3,2451,0)
 ;;=R42.^^20^152^3
 ;;^UTILITY(U,$J,358.3,2451,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2451,1,3,0)
 ;;=3^Dizziness and Giddiness
 ;;^UTILITY(U,$J,358.3,2451,1,4,0)
 ;;=4^R42.
 ;;^UTILITY(U,$J,358.3,2451,2)
 ;;=^5019450
 ;;^UTILITY(U,$J,358.3,2452,0)
 ;;=R06.02^^20^152^8
 ;;^UTILITY(U,$J,358.3,2452,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2452,1,3,0)
 ;;=3^Shortness of Breath
 ;;^UTILITY(U,$J,358.3,2452,1,4,0)
 ;;=4^R06.02
 ;;^UTILITY(U,$J,358.3,2452,2)
 ;;=^5019181
 ;;^UTILITY(U,$J,358.3,2453,0)
 ;;=I25.2^^20^153^5
 ;;^UTILITY(U,$J,358.3,2453,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2453,1,3,0)
 ;;=3^Old MI
 ;;^UTILITY(U,$J,358.3,2453,1,4,0)
 ;;=4^I25.2
 ;;^UTILITY(U,$J,358.3,2453,2)
 ;;=^259884
 ;;^UTILITY(U,$J,358.3,2454,0)
 ;;=Z95.2^^20^153^8
 ;;^UTILITY(U,$J,358.3,2454,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2454,1,3,0)
 ;;=3^Presence of Prosthetic Heart Valve
 ;;^UTILITY(U,$J,358.3,2454,1,4,0)
 ;;=4^Z95.2
 ;;^UTILITY(U,$J,358.3,2454,2)
 ;;=^5063670
 ;;^UTILITY(U,$J,358.3,2455,0)
 ;;=Z95.1^^20^153^6
 ;;^UTILITY(U,$J,358.3,2455,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2455,1,3,0)
 ;;=3^Presence of Aortocoronary Bypass Graft
 ;;^UTILITY(U,$J,358.3,2455,1,4,0)
 ;;=4^Z95.1
 ;;^UTILITY(U,$J,358.3,2455,2)
 ;;=^5063669
 ;;^UTILITY(U,$J,358.3,2456,0)
 ;;=Z98.61^^20^153^1
 ;;^UTILITY(U,$J,358.3,2456,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2456,1,3,0)
 ;;=3^Coronary Angioplasty Status
 ;;^UTILITY(U,$J,358.3,2456,1,4,0)
 ;;=4^Z98.61
 ;;^UTILITY(U,$J,358.3,2456,2)
 ;;=^5063742
 ;;^UTILITY(U,$J,358.3,2457,0)
 ;;=Z95.2^^20^153^9
 ;;^UTILITY(U,$J,358.3,2457,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2457,1,3,0)
 ;;=3^Presence of Prosthetic Heart Valve
 ;;^UTILITY(U,$J,358.3,2457,1,4,0)
 ;;=4^Z95.2
 ;;^UTILITY(U,$J,358.3,2457,2)
 ;;=^5063670
 ;;^UTILITY(U,$J,358.3,2458,0)
 ;;=Z95.3^^20^153^10
 ;;^UTILITY(U,$J,358.3,2458,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2458,1,3,0)
 ;;=3^Presence of Xenogenic Heart Valve
 ;;^UTILITY(U,$J,358.3,2458,1,4,0)
 ;;=4^Z95.3
 ;;^UTILITY(U,$J,358.3,2458,2)
 ;;=^5063671
 ;;^UTILITY(U,$J,358.3,2459,0)
 ;;=Z95.4^^20^153^7
 ;;^UTILITY(U,$J,358.3,2459,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2459,1,3,0)
 ;;=3^Presence of Heart Valve Replacement NEC
 ;;^UTILITY(U,$J,358.3,2459,1,4,0)
 ;;=4^Z95.4
 ;;^UTILITY(U,$J,358.3,2459,2)
 ;;=^5063672
 ;;^UTILITY(U,$J,358.3,2460,0)
 ;;=Z79.01^^20^153^4
 ;;^UTILITY(U,$J,358.3,2460,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2460,1,3,0)
 ;;=3^Long Term Current Use of Anticoagulants
 ;;^UTILITY(U,$J,358.3,2460,1,4,0)
 ;;=4^Z79.01
 ;;^UTILITY(U,$J,358.3,2460,2)
 ;;=^5063330
 ;;^UTILITY(U,$J,358.3,2461,0)
 ;;=Z83.438^^20^153^3
 ;;^UTILITY(U,$J,358.3,2461,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2461,1,3,0)
 ;;=3^Family Hx of Familial Comb Hyperlipidemia
 ;;^UTILITY(U,$J,358.3,2461,1,4,0)
 ;;=4^Z83.438
 ;;^UTILITY(U,$J,358.3,2461,2)
 ;;=^5157632
 ;;^UTILITY(U,$J,358.3,2462,0)
 ;;=Z83.430^^20^153^2
 ;;^UTILITY(U,$J,358.3,2462,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2462,1,3,0)
 ;;=3^Family Hx of Elevated Lipoprotein(a)
 ;;^UTILITY(U,$J,358.3,2462,1,4,0)
 ;;=4^Z83.430
