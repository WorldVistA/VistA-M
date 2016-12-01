IBDEI028 ; ; 09-AUG-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,2444,1,3,0)
 ;;=3^Screening for Viral Diseases
 ;;^UTILITY(U,$J,358.3,2444,1,4,0)
 ;;=4^Z11.59
 ;;^UTILITY(U,$J,358.3,2444,2)
 ;;=^5062675
 ;;^UTILITY(U,$J,358.3,2445,0)
 ;;=Z11.3^^14^179^6
 ;;^UTILITY(U,$J,358.3,2445,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2445,1,3,0)
 ;;=3^Screening for Infections w/ Sexual Mode of Transmission
 ;;^UTILITY(U,$J,358.3,2445,1,4,0)
 ;;=4^Z11.3
 ;;^UTILITY(U,$J,358.3,2445,2)
 ;;=^5062672
 ;;^UTILITY(U,$J,358.3,2446,0)
 ;;=Z11.9^^14^179^7
 ;;^UTILITY(U,$J,358.3,2446,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2446,1,3,0)
 ;;=3^Screening for Infectious/Parasitic Diseases
 ;;^UTILITY(U,$J,358.3,2446,1,4,0)
 ;;=4^Z11.9
 ;;^UTILITY(U,$J,358.3,2446,2)
 ;;=^5062678
 ;;^UTILITY(U,$J,358.3,2447,0)
 ;;=Z12.2^^14^179^13
 ;;^UTILITY(U,$J,358.3,2447,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2447,1,3,0)
 ;;=3^Screening for Malig Neop Respiratory Organs
 ;;^UTILITY(U,$J,358.3,2447,1,4,0)
 ;;=4^Z12.2
 ;;^UTILITY(U,$J,358.3,2447,2)
 ;;=^5062684
 ;;^UTILITY(U,$J,358.3,2448,0)
 ;;=Z12.4^^14^179^9
 ;;^UTILITY(U,$J,358.3,2448,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2448,1,3,0)
 ;;=3^Screening for Malig Neop Cervix
 ;;^UTILITY(U,$J,358.3,2448,1,4,0)
 ;;=4^Z12.4
 ;;^UTILITY(U,$J,358.3,2448,2)
 ;;=^5062687
 ;;^UTILITY(U,$J,358.3,2449,0)
 ;;=Z12.12^^14^179^12
 ;;^UTILITY(U,$J,358.3,2449,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2449,1,3,0)
 ;;=3^Screening for Malig Neop Rectum
 ;;^UTILITY(U,$J,358.3,2449,1,4,0)
 ;;=4^Z12.12
 ;;^UTILITY(U,$J,358.3,2449,2)
 ;;=^5062682
 ;;^UTILITY(U,$J,358.3,2450,0)
 ;;=Z12.5^^14^179^11
 ;;^UTILITY(U,$J,358.3,2450,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2450,1,3,0)
 ;;=3^Screening for Malig Neop Prostate
 ;;^UTILITY(U,$J,358.3,2450,1,4,0)
 ;;=4^Z12.5
 ;;^UTILITY(U,$J,358.3,2450,2)
 ;;=^5062688
 ;;^UTILITY(U,$J,358.3,2451,0)
 ;;=Z12.11^^14^179^10
 ;;^UTILITY(U,$J,358.3,2451,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2451,1,3,0)
 ;;=3^Screening for Malig Neop Colon
 ;;^UTILITY(U,$J,358.3,2451,1,4,0)
 ;;=4^Z12.11
 ;;^UTILITY(U,$J,358.3,2451,2)
 ;;=^5062681
 ;;^UTILITY(U,$J,358.3,2452,0)
 ;;=Z13.1^^14^179^4
 ;;^UTILITY(U,$J,358.3,2452,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2452,1,3,0)
 ;;=3^Screening for Diabetes Mellitus
 ;;^UTILITY(U,$J,358.3,2452,1,4,0)
 ;;=4^Z13.1
 ;;^UTILITY(U,$J,358.3,2452,2)
 ;;=^5062700
 ;;^UTILITY(U,$J,358.3,2453,0)
 ;;=Z13.0^^14^179^2
 ;;^UTILITY(U,$J,358.3,2453,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2453,1,3,0)
 ;;=3^Screening for Blood/Blood-Forming Organs Diseases
 ;;^UTILITY(U,$J,358.3,2453,1,4,0)
 ;;=4^Z13.0
 ;;^UTILITY(U,$J,358.3,2453,2)
 ;;=^5062699
 ;;^UTILITY(U,$J,358.3,2454,0)
 ;;=Z13.850^^14^179^15
 ;;^UTILITY(U,$J,358.3,2454,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2454,1,3,0)
 ;;=3^Screening for TBI
 ;;^UTILITY(U,$J,358.3,2454,1,4,0)
 ;;=4^Z13.850
 ;;^UTILITY(U,$J,358.3,2454,2)
 ;;=^5062717
 ;;^UTILITY(U,$J,358.3,2455,0)
 ;;=Z13.6^^14^179^3
 ;;^UTILITY(U,$J,358.3,2455,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2455,1,3,0)
 ;;=3^Screening for Cardiovascular Disorders
 ;;^UTILITY(U,$J,358.3,2455,1,4,0)
 ;;=4^Z13.6
 ;;^UTILITY(U,$J,358.3,2455,2)
 ;;=^5062707
 ;;^UTILITY(U,$J,358.3,2456,0)
 ;;=Z13.820^^14^179^14
 ;;^UTILITY(U,$J,358.3,2456,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2456,1,3,0)
 ;;=3^Screening for Osteoporosis
 ;;^UTILITY(U,$J,358.3,2456,1,4,0)
 ;;=4^Z13.820
 ;;^UTILITY(U,$J,358.3,2456,2)
 ;;=^5062713
 ;;^UTILITY(U,$J,358.3,2457,0)
 ;;=I10.^^14^180^3
 ;;^UTILITY(U,$J,358.3,2457,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2457,1,3,0)
 ;;=3^Hypertension,Essential,Primary
 ;;^UTILITY(U,$J,358.3,2457,1,4,0)
 ;;=4^I10.
 ;;^UTILITY(U,$J,358.3,2457,2)
 ;;=^5007062
 ;;^UTILITY(U,$J,358.3,2458,0)
 ;;=I25.119^^14^180^1
 ;;^UTILITY(U,$J,358.3,2458,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2458,1,3,0)
 ;;=3^Athscl Hrt Disease of Native Cor Art w/ Angina Pectoris
 ;;^UTILITY(U,$J,358.3,2458,1,4,0)
 ;;=4^I25.119
 ;;^UTILITY(U,$J,358.3,2458,2)
 ;;=^5007111
 ;;^UTILITY(U,$J,358.3,2459,0)
 ;;=I50.32^^14^180^2
 ;;^UTILITY(U,$J,358.3,2459,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2459,1,3,0)
 ;;=3^Chronic Diastolic Congestive Heart Failure
 ;;^UTILITY(U,$J,358.3,2459,1,4,0)
 ;;=4^I50.32
 ;;^UTILITY(U,$J,358.3,2459,2)
 ;;=^5007245
 ;;^UTILITY(U,$J,358.3,2460,0)
 ;;=E08.43^^14^181^6
 ;;^UTILITY(U,$J,358.3,2460,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2460,1,3,0)
 ;;=3^DM d/t Underlying Condition w/ Diabetic Auto Neuropathy
 ;;^UTILITY(U,$J,358.3,2460,1,4,0)
 ;;=4^E08.43
 ;;^UTILITY(U,$J,358.3,2460,2)
 ;;=^5002525
 ;;^UTILITY(U,$J,358.3,2461,0)
 ;;=E11.21^^14^181^2
 ;;^UTILITY(U,$J,358.3,2461,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2461,1,3,0)
 ;;=3^DM Type 2 w/ Diabetic Nephropathy
 ;;^UTILITY(U,$J,358.3,2461,1,4,0)
 ;;=4^E11.21
 ;;^UTILITY(U,$J,358.3,2461,2)
 ;;=^5002629
 ;;^UTILITY(U,$J,358.3,2462,0)
 ;;=E11.40^^14^181^3
 ;;^UTILITY(U,$J,358.3,2462,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2462,1,3,0)
 ;;=3^DM Type 2 w/ Diabetic Neuropathy
 ;;^UTILITY(U,$J,358.3,2462,1,4,0)
 ;;=4^E11.40
 ;;^UTILITY(U,$J,358.3,2462,2)
 ;;=^5002644
 ;;^UTILITY(U,$J,358.3,2463,0)
 ;;=E11.65^^14^181^4
 ;;^UTILITY(U,$J,358.3,2463,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2463,1,3,0)
 ;;=3^DM Type 2 w/ Hyperglycemia
 ;;^UTILITY(U,$J,358.3,2463,1,4,0)
 ;;=4^E11.65
 ;;^UTILITY(U,$J,358.3,2463,2)
 ;;=^5002663
 ;;^UTILITY(U,$J,358.3,2464,0)
 ;;=E11.8^^14^181^1
 ;;^UTILITY(U,$J,358.3,2464,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2464,1,3,0)
 ;;=3^DM Type 2 w/ Complications
 ;;^UTILITY(U,$J,358.3,2464,1,4,0)
 ;;=4^E11.8
 ;;^UTILITY(U,$J,358.3,2464,2)
 ;;=^5002665
 ;;^UTILITY(U,$J,358.3,2465,0)
 ;;=E11.9^^14^181^5
 ;;^UTILITY(U,$J,358.3,2465,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2465,1,3,0)
 ;;=3^DM Type 2 w/o Complications
 ;;^UTILITY(U,$J,358.3,2465,1,4,0)
 ;;=4^E11.9
 ;;^UTILITY(U,$J,358.3,2465,2)
 ;;=^5002666
 ;;^UTILITY(U,$J,358.3,2466,0)
 ;;=E13.40^^14^181^8
 ;;^UTILITY(U,$J,358.3,2466,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2466,1,3,0)
 ;;=3^DM w/ Diabetic Neuropathy,Unspec
 ;;^UTILITY(U,$J,358.3,2466,1,4,0)
 ;;=4^E13.40
 ;;^UTILITY(U,$J,358.3,2466,2)
 ;;=^5002684
 ;;^UTILITY(U,$J,358.3,2467,0)
 ;;=E13.43^^14^181^7
 ;;^UTILITY(U,$J,358.3,2467,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2467,1,3,0)
 ;;=3^DM w/ Diabetic Auto Neuropathy
 ;;^UTILITY(U,$J,358.3,2467,1,4,0)
 ;;=4^E13.43
 ;;^UTILITY(U,$J,358.3,2467,2)
 ;;=^5002687
 ;;^UTILITY(U,$J,358.3,2468,0)
 ;;=E06.3^^14^182^1
 ;;^UTILITY(U,$J,358.3,2468,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2468,1,3,0)
 ;;=3^Autoimmune Thyroiditis
 ;;^UTILITY(U,$J,358.3,2468,1,4,0)
 ;;=4^E06.3
 ;;^UTILITY(U,$J,358.3,2468,2)
 ;;=^5002495
 ;;^UTILITY(U,$J,358.3,2469,0)
 ;;=E26.09^^14^182^3
 ;;^UTILITY(U,$J,358.3,2469,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2469,1,3,0)
 ;;=3^Primary Hyperaldosteronism NEC
 ;;^UTILITY(U,$J,358.3,2469,1,4,0)
 ;;=4^E26.09
 ;;^UTILITY(U,$J,358.3,2469,2)
 ;;=^5002735
 ;;^UTILITY(U,$J,358.3,2470,0)
 ;;=E78.0^^14^182^4
 ;;^UTILITY(U,$J,358.3,2470,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2470,1,3,0)
 ;;=3^Pure Hypercholesterolemia
 ;;^UTILITY(U,$J,358.3,2470,1,4,0)
 ;;=4^E78.0
 ;;^UTILITY(U,$J,358.3,2470,2)
 ;;=^5002966
 ;;^UTILITY(U,$J,358.3,2471,0)
 ;;=E78.4^^14^182^2
 ;;^UTILITY(U,$J,358.3,2471,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2471,1,3,0)
 ;;=3^Hyperlipidemia NEC
 ;;^UTILITY(U,$J,358.3,2471,1,4,0)
 ;;=4^E78.4
 ;;^UTILITY(U,$J,358.3,2471,2)
 ;;=^5002968
 ;;^UTILITY(U,$J,358.3,2472,0)
 ;;=H91.8X9^^14^183^1
 ;;^UTILITY(U,$J,358.3,2472,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2472,1,3,0)
 ;;=3^Hearing Loss,Unspec Ear
 ;;^UTILITY(U,$J,358.3,2472,1,4,0)
 ;;=4^H91.8X9
 ;;^UTILITY(U,$J,358.3,2472,2)
 ;;=^5133555
 ;;^UTILITY(U,$J,358.3,2473,0)
 ;;=H93.13^^14^183^2
 ;;^UTILITY(U,$J,358.3,2473,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2473,1,3,0)
 ;;=3^Tinnitus,Bilateral
 ;;^UTILITY(U,$J,358.3,2473,1,4,0)
 ;;=4^H93.13
 ;;^UTILITY(U,$J,358.3,2473,2)
 ;;=^5006966
 ;;^UTILITY(U,$J,358.3,2474,0)
 ;;=H93.19^^14^183^3
 ;;^UTILITY(U,$J,358.3,2474,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2474,1,3,0)
 ;;=3^Tinnitus,Unspec Ear
 ;;^UTILITY(U,$J,358.3,2474,1,4,0)
 ;;=4^H93.19
 ;;^UTILITY(U,$J,358.3,2474,2)
 ;;=^5006967
 ;;^UTILITY(U,$J,358.3,2475,0)
 ;;=K21.0^^14^184^4
 ;;^UTILITY(U,$J,358.3,2475,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2475,1,3,0)
 ;;=3^GERD w/ Esophagitis
 ;;^UTILITY(U,$J,358.3,2475,1,4,0)
 ;;=4^K21.0
 ;;^UTILITY(U,$J,358.3,2475,2)
 ;;=^5008504
 ;;^UTILITY(U,$J,358.3,2476,0)
 ;;=K30.^^14^184^3
 ;;^UTILITY(U,$J,358.3,2476,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2476,1,3,0)
 ;;=3^Functional Dyspepsia
 ;;^UTILITY(U,$J,358.3,2476,1,4,0)
 ;;=4^K30.
 ;;^UTILITY(U,$J,358.3,2476,2)
 ;;=^5008558
 ;;^UTILITY(U,$J,358.3,2477,0)
 ;;=K50.911^^14^184^1
 ;;^UTILITY(U,$J,358.3,2477,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2477,1,3,0)
 ;;=3^Crohn's Disease w/ Rectal Bleeding,Unspec
 ;;^UTILITY(U,$J,358.3,2477,1,4,0)
 ;;=4^K50.911
 ;;^UTILITY(U,$J,358.3,2477,2)
 ;;=^5008646
 ;;^UTILITY(U,$J,358.3,2478,0)
 ;;=K51.80^^14^184^10
 ;;^UTILITY(U,$J,358.3,2478,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2478,1,3,0)
 ;;=3^Ulcerative Colitis w/o Complications NEC
 ;;^UTILITY(U,$J,358.3,2478,1,4,0)
 ;;=4^K51.80
 ;;^UTILITY(U,$J,358.3,2478,2)
 ;;=^5008687
 ;;^UTILITY(U,$J,358.3,2479,0)
 ;;=K51.819^^14^184^8
 ;;^UTILITY(U,$J,358.3,2479,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2479,1,3,0)
 ;;=3^Ulcerative Colitis w/ Unspec Complications
 ;;^UTILITY(U,$J,358.3,2479,1,4,0)
 ;;=4^K51.819
 ;;^UTILITY(U,$J,358.3,2479,2)
 ;;=^5008693
 ;;^UTILITY(U,$J,358.3,2480,0)
 ;;=K51.90^^14^184^9
 ;;^UTILITY(U,$J,358.3,2480,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2480,1,3,0)
 ;;=3^Ulcerative Colitis w/o Complications
 ;;^UTILITY(U,$J,358.3,2480,1,4,0)
 ;;=4^K51.90
