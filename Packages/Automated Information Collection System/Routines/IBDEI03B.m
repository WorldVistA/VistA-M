IBDEI03B ; ; 12-MAY-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,2954,1,4,0)
 ;;=4^J45.909
 ;;^UTILITY(U,$J,358.3,2954,2)
 ;;=^5008256
 ;;^UTILITY(U,$J,358.3,2955,0)
 ;;=J44.9^^20^212^3
 ;;^UTILITY(U,$J,358.3,2955,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2955,1,3,0)
 ;;=3^COPD
 ;;^UTILITY(U,$J,358.3,2955,1,4,0)
 ;;=4^J44.9
 ;;^UTILITY(U,$J,358.3,2955,2)
 ;;=^5008241
 ;;^UTILITY(U,$J,358.3,2956,0)
 ;;=J18.9^^20^212^5
 ;;^UTILITY(U,$J,358.3,2956,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2956,1,3,0)
 ;;=3^Pneumonia,Unspec Organism
 ;;^UTILITY(U,$J,358.3,2956,1,4,0)
 ;;=4^J18.9
 ;;^UTILITY(U,$J,358.3,2956,2)
 ;;=^95632
 ;;^UTILITY(U,$J,358.3,2957,0)
 ;;=J30.9^^20^212^1
 ;;^UTILITY(U,$J,358.3,2957,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2957,1,3,0)
 ;;=3^Allergic Rhinitis,Unspec
 ;;^UTILITY(U,$J,358.3,2957,1,4,0)
 ;;=4^J30.9
 ;;^UTILITY(U,$J,358.3,2957,2)
 ;;=^5008205
 ;;^UTILITY(U,$J,358.3,2958,0)
 ;;=J15.9^^20^212^4
 ;;^UTILITY(U,$J,358.3,2958,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2958,1,3,0)
 ;;=3^Pneumonia,Bacterial
 ;;^UTILITY(U,$J,358.3,2958,1,4,0)
 ;;=4^J15.9
 ;;^UTILITY(U,$J,358.3,2958,2)
 ;;=^5008178
 ;;^UTILITY(U,$J,358.3,2959,0)
 ;;=C61.^^20^213^30
 ;;^UTILITY(U,$J,358.3,2959,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2959,1,3,0)
 ;;=3^Malig Neo of Prostate
 ;;^UTILITY(U,$J,358.3,2959,1,4,0)
 ;;=4^C61.
 ;;^UTILITY(U,$J,358.3,2959,2)
 ;;=^267239
 ;;^UTILITY(U,$J,358.3,2960,0)
 ;;=E55.9^^20^213^38
 ;;^UTILITY(U,$J,358.3,2960,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2960,1,3,0)
 ;;=3^Vitamin D Deficiency,Unspec
 ;;^UTILITY(U,$J,358.3,2960,1,4,0)
 ;;=4^E55.9
 ;;^UTILITY(U,$J,358.3,2960,2)
 ;;=^5002799
 ;;^UTILITY(U,$J,358.3,2961,0)
 ;;=D63.1^^20^213^8
 ;;^UTILITY(U,$J,358.3,2961,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2961,1,3,0)
 ;;=3^Anemia in Chr Kidney Disease
 ;;^UTILITY(U,$J,358.3,2961,1,4,0)
 ;;=4^D63.1
 ;;^UTILITY(U,$J,358.3,2961,2)
 ;;=^332908
 ;;^UTILITY(U,$J,358.3,2962,0)
 ;;=D63.8^^20^213^7
 ;;^UTILITY(U,$J,358.3,2962,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2962,1,3,0)
 ;;=3^Anemia in Chr Diseases Classified Elsewhere
 ;;^UTILITY(U,$J,358.3,2962,1,4,0)
 ;;=4^D63.8
 ;;^UTILITY(U,$J,358.3,2962,2)
 ;;=^5002343
 ;;^UTILITY(U,$J,358.3,2963,0)
 ;;=D64.9^^20^213^9
 ;;^UTILITY(U,$J,358.3,2963,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2963,1,3,0)
 ;;=3^Anemia,Unspec
 ;;^UTILITY(U,$J,358.3,2963,1,4,0)
 ;;=4^D64.9
 ;;^UTILITY(U,$J,358.3,2963,2)
 ;;=^5002351
 ;;^UTILITY(U,$J,358.3,2964,0)
 ;;=F52.21^^20^213^29
 ;;^UTILITY(U,$J,358.3,2964,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2964,1,3,0)
 ;;=3^Male Erectile Disorder
 ;;^UTILITY(U,$J,358.3,2964,1,4,0)
 ;;=4^F52.21
 ;;^UTILITY(U,$J,358.3,2964,2)
 ;;=^5003620
 ;;^UTILITY(U,$J,358.3,2965,0)
 ;;=F17.200^^20^213^33
 ;;^UTILITY(U,$J,358.3,2965,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2965,1,3,0)
 ;;=3^Nicotine Dependence,Unspec
 ;;^UTILITY(U,$J,358.3,2965,1,4,0)
 ;;=4^F17.200
 ;;^UTILITY(U,$J,358.3,2965,2)
 ;;=^5003360
 ;;^UTILITY(U,$J,358.3,2966,0)
 ;;=F17.210^^20^213^32
 ;;^UTILITY(U,$J,358.3,2966,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2966,1,3,0)
 ;;=3^Nicotine Dependence,Cigarettes
 ;;^UTILITY(U,$J,358.3,2966,1,4,0)
 ;;=4^F17.210
 ;;^UTILITY(U,$J,358.3,2966,2)
 ;;=^5003365
 ;;^UTILITY(U,$J,358.3,2967,0)
 ;;=K21.9^^20^213^18
 ;;^UTILITY(U,$J,358.3,2967,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2967,1,3,0)
 ;;=3^GERD w/o Esophagitis
 ;;^UTILITY(U,$J,358.3,2967,1,4,0)
 ;;=4^K21.9
 ;;^UTILITY(U,$J,358.3,2967,2)
 ;;=^5008505
 ;;^UTILITY(U,$J,358.3,2968,0)
 ;;=N18.6^^20^213^13
 ;;^UTILITY(U,$J,358.3,2968,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2968,1,3,0)
 ;;=3^ESRD
 ;;^UTILITY(U,$J,358.3,2968,1,4,0)
 ;;=4^N18.6
 ;;^UTILITY(U,$J,358.3,2968,2)
 ;;=^303986
 ;;^UTILITY(U,$J,358.3,2969,0)
 ;;=N40.0^^20^213^15
 ;;^UTILITY(U,$J,358.3,2969,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2969,1,3,0)
 ;;=3^Enlarged Prostate w/o Lower Urinary Tract Symptoms
 ;;^UTILITY(U,$J,358.3,2969,1,4,0)
 ;;=4^N40.0
 ;;^UTILITY(U,$J,358.3,2969,2)
 ;;=^5015689
 ;;^UTILITY(U,$J,358.3,2970,0)
 ;;=R82.5^^20^213^14
 ;;^UTILITY(U,$J,358.3,2970,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2970,1,3,0)
 ;;=3^Elevated Urine Levels of Drug/Meds/Bio Subst
 ;;^UTILITY(U,$J,358.3,2970,1,4,0)
 ;;=4^R82.5
 ;;^UTILITY(U,$J,358.3,2970,2)
 ;;=^5019605
 ;;^UTILITY(U,$J,358.3,2971,0)
 ;;=R82.6^^20^213^3
 ;;^UTILITY(U,$J,358.3,2971,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2971,1,3,0)
 ;;=3^Abnormal Urine Levels of Non-Medicinal Subs
 ;;^UTILITY(U,$J,358.3,2971,1,4,0)
 ;;=4^R82.6
 ;;^UTILITY(U,$J,358.3,2971,2)
 ;;=^5019606
 ;;^UTILITY(U,$J,358.3,2972,0)
 ;;=R89.2^^20^213^1
 ;;^UTILITY(U,$J,358.3,2972,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2972,1,3,0)
 ;;=3^Abnormal Drug/Meds/Bio Subs Level in Org/Tiss Specimens
 ;;^UTILITY(U,$J,358.3,2972,1,4,0)
 ;;=4^R89.2
 ;;^UTILITY(U,$J,358.3,2972,2)
 ;;=^5019696
 ;;^UTILITY(U,$J,358.3,2973,0)
 ;;=R89.3^^20^213^2
 ;;^UTILITY(U,$J,358.3,2973,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2973,1,3,0)
 ;;=3^Abnormal Non-Medicinal Level in Org/Tiss Specimens
 ;;^UTILITY(U,$J,358.3,2973,1,4,0)
 ;;=4^R89.3
 ;;^UTILITY(U,$J,358.3,2973,2)
 ;;=^5019697
 ;;^UTILITY(U,$J,358.3,2974,0)
 ;;=T50.995A^^20^213^4
 ;;^UTILITY(U,$J,358.3,2974,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2974,1,3,0)
 ;;=3^Adverse Effect of Drug/Meds/Bio Subs,Init Encounter
 ;;^UTILITY(U,$J,358.3,2974,1,4,0)
 ;;=4^T50.995A
 ;;^UTILITY(U,$J,358.3,2974,2)
 ;;=^5052178
 ;;^UTILITY(U,$J,358.3,2975,0)
 ;;=Z88.9^^20^213^6
 ;;^UTILITY(U,$J,358.3,2975,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2975,1,3,0)
 ;;=3^Allergy Status to Unspec Drug/Meds/Bio Subs
 ;;^UTILITY(U,$J,358.3,2975,1,4,0)
 ;;=4^Z88.9
 ;;^UTILITY(U,$J,358.3,2975,2)
 ;;=^5063530
 ;;^UTILITY(U,$J,358.3,2976,0)
 ;;=Z91.19^^20^213^34
 ;;^UTILITY(U,$J,358.3,2976,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2976,1,3,0)
 ;;=3^Noncompliance w/ Medical Treatment/Regimen
 ;;^UTILITY(U,$J,358.3,2976,1,4,0)
 ;;=4^Z91.19
 ;;^UTILITY(U,$J,358.3,2976,2)
 ;;=^5063618
 ;;^UTILITY(U,$J,358.3,2977,0)
 ;;=H54.7^^20^213^37
 ;;^UTILITY(U,$J,358.3,2977,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2977,1,3,0)
 ;;=3^Visual Loss,Unspec
 ;;^UTILITY(U,$J,358.3,2977,1,4,0)
 ;;=4^H54.7
 ;;^UTILITY(U,$J,358.3,2977,2)
 ;;=^5006368
 ;;^UTILITY(U,$J,358.3,2978,0)
 ;;=Z79.2^^20^213^25
 ;;^UTILITY(U,$J,358.3,2978,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2978,1,3,0)
 ;;=3^Long Term (Current) Use of Antibiotics
 ;;^UTILITY(U,$J,358.3,2978,1,4,0)
 ;;=4^Z79.2
 ;;^UTILITY(U,$J,358.3,2978,2)
 ;;=^321546
 ;;^UTILITY(U,$J,358.3,2979,0)
 ;;=Z79.1^^20^213^27
 ;;^UTILITY(U,$J,358.3,2979,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2979,1,3,0)
 ;;=3^Long Term (Current) Use of NSAID
 ;;^UTILITY(U,$J,358.3,2979,1,4,0)
 ;;=4^Z79.1
 ;;^UTILITY(U,$J,358.3,2979,2)
 ;;=^5063332
 ;;^UTILITY(U,$J,358.3,2980,0)
 ;;=Z79.52^^20^213^28
 ;;^UTILITY(U,$J,358.3,2980,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2980,1,3,0)
 ;;=3^Long Term (Current) Use of Systemic Steroids
 ;;^UTILITY(U,$J,358.3,2980,1,4,0)
 ;;=4^Z79.52
 ;;^UTILITY(U,$J,358.3,2980,2)
 ;;=^5063336
 ;;^UTILITY(U,$J,358.3,2981,0)
 ;;=Z79.82^^20^213^26
 ;;^UTILITY(U,$J,358.3,2981,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2981,1,3,0)
 ;;=3^Long Term (Current) Use of Aspirin
 ;;^UTILITY(U,$J,358.3,2981,1,4,0)
 ;;=4^Z79.82
 ;;^UTILITY(U,$J,358.3,2981,2)
 ;;=^5063340
 ;;^UTILITY(U,$J,358.3,2982,0)
 ;;=Z79.899^^20^213^24
 ;;^UTILITY(U,$J,358.3,2982,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2982,1,3,0)
 ;;=3^Long Term (Current) Drug Therapy
 ;;^UTILITY(U,$J,358.3,2982,1,4,0)
 ;;=4^Z79.899
 ;;^UTILITY(U,$J,358.3,2982,2)
 ;;=^5063343
 ;;^UTILITY(U,$J,358.3,2983,0)
 ;;=Z71.0^^20^213^20
 ;;^UTILITY(U,$J,358.3,2983,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2983,1,3,0)
 ;;=3^Health Services to Consult on Behalf of Another Person
