IBDEI039 ; ; 12-MAY-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,2896,1,3,0)
 ;;=3^98962
 ;;^UTILITY(U,$J,358.3,2897,0)
 ;;=S9810^^19^206^1^^^^1
 ;;^UTILITY(U,$J,358.3,2897,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,2897,1,2,0)
 ;;=2^Infusion/Drug Admin per Hr
 ;;^UTILITY(U,$J,358.3,2897,1,3,0)
 ;;=3^S9810
 ;;^UTILITY(U,$J,358.3,2898,0)
 ;;=D68.318^^20^207^14
 ;;^UTILITY(U,$J,358.3,2898,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2898,1,3,0)
 ;;=3^Hemorrhagic Disorder d/t Intrinsic Circ Anticoagulants
 ;;^UTILITY(U,$J,358.3,2898,1,4,0)
 ;;=4^D68.318
 ;;^UTILITY(U,$J,358.3,2898,2)
 ;;=^340504
 ;;^UTILITY(U,$J,358.3,2899,0)
 ;;=D68.9^^20^207^12
 ;;^UTILITY(U,$J,358.3,2899,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2899,1,3,0)
 ;;=3^Coagulation Defect,Unspec
 ;;^UTILITY(U,$J,358.3,2899,1,4,0)
 ;;=4^D68.9
 ;;^UTILITY(U,$J,358.3,2899,2)
 ;;=^5002364
 ;;^UTILITY(U,$J,358.3,2900,0)
 ;;=D68.8^^20^207^13
 ;;^UTILITY(U,$J,358.3,2900,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2900,1,3,0)
 ;;=3^Coagulation Defects,Other Spec
 ;;^UTILITY(U,$J,358.3,2900,1,4,0)
 ;;=4^D68.8
 ;;^UTILITY(U,$J,358.3,2900,2)
 ;;=^5002363
 ;;^UTILITY(U,$J,358.3,2901,0)
 ;;=D68.51^^20^207^1
 ;;^UTILITY(U,$J,358.3,2901,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2901,1,3,0)
 ;;=3^Activated Protein C Resistance
 ;;^UTILITY(U,$J,358.3,2901,1,4,0)
 ;;=4^D68.51
 ;;^UTILITY(U,$J,358.3,2901,2)
 ;;=^5002358
 ;;^UTILITY(U,$J,358.3,2902,0)
 ;;=D68.59^^20^207^24
 ;;^UTILITY(U,$J,358.3,2902,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2902,1,3,0)
 ;;=3^Primary Thrombophilia
 ;;^UTILITY(U,$J,358.3,2902,1,4,0)
 ;;=4^D68.59
 ;;^UTILITY(U,$J,358.3,2902,2)
 ;;=^5002360
 ;;^UTILITY(U,$J,358.3,2903,0)
 ;;=D68.61^^20^207^5
 ;;^UTILITY(U,$J,358.3,2903,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2903,1,3,0)
 ;;=3^Antiphospholipid Syndrome
 ;;^UTILITY(U,$J,358.3,2903,1,4,0)
 ;;=4^D68.61
 ;;^UTILITY(U,$J,358.3,2903,2)
 ;;=^185421
 ;;^UTILITY(U,$J,358.3,2904,0)
 ;;=D68.62^^20^207^18
 ;;^UTILITY(U,$J,358.3,2904,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2904,1,3,0)
 ;;=3^Lupus Anticoagulant Syndrome
 ;;^UTILITY(U,$J,358.3,2904,1,4,0)
 ;;=4^D68.62
 ;;^UTILITY(U,$J,358.3,2904,2)
 ;;=^5002361
 ;;^UTILITY(U,$J,358.3,2905,0)
 ;;=I26.99^^20^207^25
 ;;^UTILITY(U,$J,358.3,2905,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2905,1,3,0)
 ;;=3^Pulmonary Embolism w/o Acute Cor Pulmonale
 ;;^UTILITY(U,$J,358.3,2905,1,4,0)
 ;;=4^I26.99
 ;;^UTILITY(U,$J,358.3,2905,2)
 ;;=^5007150
 ;;^UTILITY(U,$J,358.3,2906,0)
 ;;=I42.8^^20^207^8
 ;;^UTILITY(U,$J,358.3,2906,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2906,1,3,0)
 ;;=3^Cardiomyopathies,Other
 ;;^UTILITY(U,$J,358.3,2906,1,4,0)
 ;;=4^I42.8
 ;;^UTILITY(U,$J,358.3,2906,2)
 ;;=^5007199
 ;;^UTILITY(U,$J,358.3,2907,0)
 ;;=I42.5^^20^207^26
 ;;^UTILITY(U,$J,358.3,2907,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2907,1,3,0)
 ;;=3^Restrictive Cardiomyopathy
 ;;^UTILITY(U,$J,358.3,2907,1,4,0)
 ;;=4^I42.5
 ;;^UTILITY(U,$J,358.3,2907,2)
 ;;=^5007196
 ;;^UTILITY(U,$J,358.3,2908,0)
 ;;=I48.91^^20^207^6
 ;;^UTILITY(U,$J,358.3,2908,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2908,1,3,0)
 ;;=3^Atrial Fibrillation,Unspec
 ;;^UTILITY(U,$J,358.3,2908,1,4,0)
 ;;=4^I48.91
 ;;^UTILITY(U,$J,358.3,2908,2)
 ;;=^5007229
 ;;^UTILITY(U,$J,358.3,2909,0)
 ;;=I48.92^^20^207^7
 ;;^UTILITY(U,$J,358.3,2909,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2909,1,3,0)
 ;;=3^Atrial Flutter,Unspec
 ;;^UTILITY(U,$J,358.3,2909,1,4,0)
 ;;=4^I48.92
 ;;^UTILITY(U,$J,358.3,2909,2)
 ;;=^5007230
 ;;^UTILITY(U,$J,358.3,2910,0)
 ;;=I63.50^^20^207^9
 ;;^UTILITY(U,$J,358.3,2910,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2910,1,3,0)
 ;;=3^Cerebral Infarction d/t Occls/Stenos of Cereb Artery
 ;;^UTILITY(U,$J,358.3,2910,1,4,0)
 ;;=4^I63.50
 ;;^UTILITY(U,$J,358.3,2910,2)
 ;;=^5007343
 ;;^UTILITY(U,$J,358.3,2911,0)
 ;;=G45.9^^20^207^28
 ;;^UTILITY(U,$J,358.3,2911,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2911,1,3,0)
 ;;=3^Transient Cerebral Ischemic Attack,Unspec
 ;;^UTILITY(U,$J,358.3,2911,1,4,0)
 ;;=4^G45.9
 ;;^UTILITY(U,$J,358.3,2911,2)
 ;;=^5003959
 ;;^UTILITY(U,$J,358.3,2912,0)
 ;;=I73.9^^20^207^19
 ;;^UTILITY(U,$J,358.3,2912,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2912,1,3,0)
 ;;=3^Peripheral Vascular Disease,Unspec
 ;;^UTILITY(U,$J,358.3,2912,1,4,0)
 ;;=4^I73.9
 ;;^UTILITY(U,$J,358.3,2912,2)
 ;;=^184182
 ;;^UTILITY(U,$J,358.3,2913,0)
 ;;=I82.401^^20^207^3
 ;;^UTILITY(U,$J,358.3,2913,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2913,1,3,0)
 ;;=3^Acute Embolism/Thrombos Deep Veins Right Lower Extremity
 ;;^UTILITY(U,$J,358.3,2913,1,4,0)
 ;;=4^I82.401
 ;;^UTILITY(U,$J,358.3,2913,2)
 ;;=^5007854
 ;;^UTILITY(U,$J,358.3,2914,0)
 ;;=I82.402^^20^207^2
 ;;^UTILITY(U,$J,358.3,2914,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2914,1,3,0)
 ;;=3^Acute Embolism/Thrombos Deep Veins Left Lower Extremity
 ;;^UTILITY(U,$J,358.3,2914,1,4,0)
 ;;=4^I82.402
 ;;^UTILITY(U,$J,358.3,2914,2)
 ;;=^5007855
 ;;^UTILITY(U,$J,358.3,2915,0)
 ;;=I82.890^^20^207^4
 ;;^UTILITY(U,$J,358.3,2915,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2915,1,3,0)
 ;;=3^Acute Embolism/Thrombosis of Specified Veins
 ;;^UTILITY(U,$J,358.3,2915,1,4,0)
 ;;=4^I82.890
 ;;^UTILITY(U,$J,358.3,2915,2)
 ;;=^5007938
 ;;^UTILITY(U,$J,358.3,2916,0)
 ;;=I82.91^^20^207^10
 ;;^UTILITY(U,$J,358.3,2916,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2916,1,3,0)
 ;;=3^Chronic Embolism/Thrombosis Unspec Vein
 ;;^UTILITY(U,$J,358.3,2916,1,4,0)
 ;;=4^I82.91
 ;;^UTILITY(U,$J,358.3,2916,2)
 ;;=^5007941
 ;;^UTILITY(U,$J,358.3,2917,0)
 ;;=Z86.718^^20^207^22
 ;;^UTILITY(U,$J,358.3,2917,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2917,1,3,0)
 ;;=3^Personal Hx of Venous Thrombosis/Embolism
 ;;^UTILITY(U,$J,358.3,2917,1,4,0)
 ;;=4^Z86.718
 ;;^UTILITY(U,$J,358.3,2917,2)
 ;;=^5063475
 ;;^UTILITY(U,$J,358.3,2918,0)
 ;;=Z86.711^^20^207^21
 ;;^UTILITY(U,$J,358.3,2918,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2918,1,3,0)
 ;;=3^Personal Hx of Pulmonary Embolism
 ;;^UTILITY(U,$J,358.3,2918,1,4,0)
 ;;=4^Z86.711
 ;;^UTILITY(U,$J,358.3,2918,2)
 ;;=^5063474
 ;;^UTILITY(U,$J,358.3,2919,0)
 ;;=Z86.79^^20^207^20
 ;;^UTILITY(U,$J,358.3,2919,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2919,1,3,0)
 ;;=3^Personal Hx of Circulatory System Diseases
 ;;^UTILITY(U,$J,358.3,2919,1,4,0)
 ;;=4^Z86.79
 ;;^UTILITY(U,$J,358.3,2919,2)
 ;;=^5063479
 ;;^UTILITY(U,$J,358.3,2920,0)
 ;;=Z95.2^^20^207^23
 ;;^UTILITY(U,$J,358.3,2920,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2920,1,3,0)
 ;;=3^Presence of Prosthetic Heart Valve
 ;;^UTILITY(U,$J,358.3,2920,1,4,0)
 ;;=4^Z95.2
 ;;^UTILITY(U,$J,358.3,2920,2)
 ;;=^5063670
 ;;^UTILITY(U,$J,358.3,2921,0)
 ;;=Z79.01^^20^207^16
 ;;^UTILITY(U,$J,358.3,2921,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2921,1,3,0)
 ;;=3^Long Term (Current) Use of Anticoagulants
 ;;^UTILITY(U,$J,358.3,2921,1,4,0)
 ;;=4^Z79.01
 ;;^UTILITY(U,$J,358.3,2921,2)
 ;;=^5063330
 ;;^UTILITY(U,$J,358.3,2922,0)
 ;;=Z79.02^^20^207^17
 ;;^UTILITY(U,$J,358.3,2922,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2922,1,3,0)
 ;;=3^Long Term (Current) Use of Antithrombotics/Antiplatelets
 ;;^UTILITY(U,$J,358.3,2922,1,4,0)
 ;;=4^Z79.02
 ;;^UTILITY(U,$J,358.3,2922,2)
 ;;=^5063331
 ;;^UTILITY(U,$J,358.3,2923,0)
 ;;=I10.^^20^207^15
 ;;^UTILITY(U,$J,358.3,2923,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2923,1,3,0)
 ;;=3^Hypertension
 ;;^UTILITY(U,$J,358.3,2923,1,4,0)
 ;;=4^I10.
 ;;^UTILITY(U,$J,358.3,2923,2)
 ;;=^5007062
 ;;^UTILITY(U,$J,358.3,2924,0)
 ;;=I25.9^^20^207^11
 ;;^UTILITY(U,$J,358.3,2924,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2924,1,3,0)
 ;;=3^Chronic Ischemic Heart Disease,Unspec
 ;;^UTILITY(U,$J,358.3,2924,1,4,0)
 ;;=4^I25.9
 ;;^UTILITY(U,$J,358.3,2924,2)
 ;;=^5007144
 ;;^UTILITY(U,$J,358.3,2925,0)
 ;;=Z51.81^^20^207^27
 ;;^UTILITY(U,$J,358.3,2925,1,0)
 ;;=^358.31IA^4^2
