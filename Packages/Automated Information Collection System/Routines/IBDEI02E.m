IBDEI02E ; ; 12-JAN-2012
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JAN 12, 2012
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,2879,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,2879,1,4,0)
 ;;=4^245.0
 ;;^UTILITY(U,$J,358.3,2879,1,5,0)
 ;;=5^Thyroiditis, Acute
 ;;^UTILITY(U,$J,358.3,2879,2)
 ;;=^2692
 ;;^UTILITY(U,$J,358.3,2880,0)
 ;;=245.1^^36^265^61
 ;;^UTILITY(U,$J,358.3,2880,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,2880,1,4,0)
 ;;=4^245.1
 ;;^UTILITY(U,$J,358.3,2880,1,5,0)
 ;;=5^Thyroiditis, Subacute
 ;;^UTILITY(U,$J,358.3,2880,2)
 ;;=^119376
 ;;^UTILITY(U,$J,358.3,2881,0)
 ;;=733.01^^36^265^54
 ;;^UTILITY(U,$J,358.3,2881,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,2881,1,4,0)
 ;;=4^733.01
 ;;^UTILITY(U,$J,358.3,2881,1,5,0)
 ;;=5^Osteoporosis, Senile
 ;;^UTILITY(U,$J,358.3,2881,2)
 ;;=Osteoporosis, Senile^87188
 ;;^UTILITY(U,$J,358.3,2882,0)
 ;;=733.02^^36^265^53
 ;;^UTILITY(U,$J,358.3,2882,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,2882,1,4,0)
 ;;=4^733.02
 ;;^UTILITY(U,$J,358.3,2882,1,5,0)
 ;;=5^Osteoporosis, Idiopathic
 ;;^UTILITY(U,$J,358.3,2882,2)
 ;;=Osteoporosis, Idiopathic^272692
 ;;^UTILITY(U,$J,358.3,2883,0)
 ;;=268.2^^36^265^49
 ;;^UTILITY(U,$J,358.3,2883,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,2883,1,4,0)
 ;;=4^268.2
 ;;^UTILITY(U,$J,358.3,2883,1,5,0)
 ;;=5^Osteomalacia
 ;;^UTILITY(U,$J,358.3,2883,2)
 ;;=Osteomalacia^87103
 ;;^UTILITY(U,$J,358.3,2884,0)
 ;;=733.90^^36^265^50
 ;;^UTILITY(U,$J,358.3,2884,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,2884,1,4,0)
 ;;=4^733.90
 ;;^UTILITY(U,$J,358.3,2884,1,5,0)
 ;;=5^Osteopenia
 ;;^UTILITY(U,$J,358.3,2884,2)
 ;;=Osteopenia^35593
 ;;^UTILITY(U,$J,358.3,2885,0)
 ;;=275.49^^36^265^55
 ;;^UTILITY(U,$J,358.3,2885,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,2885,1,4,0)
 ;;=4^275.49
 ;;^UTILITY(U,$J,358.3,2885,1,5,0)
 ;;=5^Pseudohypoparathyroidism
 ;;^UTILITY(U,$J,358.3,2885,2)
 ;;=Pseudohypparathyroidism^317904
 ;;^UTILITY(U,$J,358.3,2886,0)
 ;;=266.2^^36^265^63
 ;;^UTILITY(U,$J,358.3,2886,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,2886,1,4,0)
 ;;=4^266.2
 ;;^UTILITY(U,$J,358.3,2886,1,5,0)
 ;;=5^Vitamin B12 Deficiency
 ;;^UTILITY(U,$J,358.3,2886,2)
 ;;=Vitamin B12 Deficiency^87347
 ;;^UTILITY(U,$J,358.3,2887,0)
 ;;=268.9^^36^265^65
 ;;^UTILITY(U,$J,358.3,2887,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,2887,1,4,0)
 ;;=4^268.9
 ;;^UTILITY(U,$J,358.3,2887,1,5,0)
 ;;=5^Vitamin D Deficiency
 ;;^UTILITY(U,$J,358.3,2887,2)
 ;;=Vitamin D Deficiency^126968
 ;;^UTILITY(U,$J,358.3,2888,0)
 ;;=266.1^^36^265^64
 ;;^UTILITY(U,$J,358.3,2888,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,2888,1,4,0)
 ;;=4^266.1
 ;;^UTILITY(U,$J,358.3,2888,1,5,0)
 ;;=5^Vitamin B6 Deficiency
 ;;^UTILITY(U,$J,358.3,2888,2)
 ;;=^101683
 ;;^UTILITY(U,$J,358.3,2889,0)
 ;;=780.99^^36^265^7
 ;;^UTILITY(U,$J,358.3,2889,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,2889,1,4,0)
 ;;=4^780.99
 ;;^UTILITY(U,$J,358.3,2889,1,5,0)
 ;;=5^Cold Intolerance
 ;;^UTILITY(U,$J,358.3,2889,2)
 ;;=Cold Intolerance^328568
 ;;^UTILITY(U,$J,358.3,2890,0)
 ;;=255.41^^36^265^16
 ;;^UTILITY(U,$J,358.3,2890,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,2890,1,4,0)
 ;;=4^255.41
 ;;^UTILITY(U,$J,358.3,2890,1,5,0)
 ;;=5^Glucocorticoid Deficient
 ;;^UTILITY(U,$J,358.3,2890,2)
 ;;=^335240
 ;;^UTILITY(U,$J,358.3,2891,0)
 ;;=255.42^^36^265^46
 ;;^UTILITY(U,$J,358.3,2891,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,2891,1,4,0)
 ;;=4^255.42
 ;;^UTILITY(U,$J,358.3,2891,1,5,0)
 ;;=5^Mineralcorticoid Defcnt
 ;;^UTILITY(U,$J,358.3,2891,2)
 ;;=^335241
 ;;^UTILITY(U,$J,358.3,2892,0)
 ;;=259.50^^36^265^6
 ;;^UTILITY(U,$J,358.3,2892,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,2892,1,4,0)
 ;;=4^259.50
 ;;^UTILITY(U,$J,358.3,2892,1,5,0)
 ;;=5^Androgen Insensitivity, Unsp
 ;;^UTILITY(U,$J,358.3,2892,2)
 ;;=^336738
 ;;^UTILITY(U,$J,358.3,2893,0)
 ;;=275.5^^36^265^24
 ;;^UTILITY(U,$J,358.3,2893,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,2893,1,4,0)
 ;;=4^275.5
 ;;^UTILITY(U,$J,358.3,2893,1,5,0)
 ;;=5^Hungry Bone Syndrome
 ;;^UTILITY(U,$J,358.3,2893,2)
 ;;=^336538
 ;;^UTILITY(U,$J,358.3,2894,0)
 ;;=249.00^^36^265^58
 ;;^UTILITY(U,$J,358.3,2894,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,2894,1,4,0)
 ;;=4^249.00
 ;;^UTILITY(U,$J,358.3,2894,1,5,0)
 ;;=5^Secondary DM w/o Complication
 ;;^UTILITY(U,$J,358.3,2894,2)
 ;;=^336728
 ;;^UTILITY(U,$J,358.3,2895,0)
 ;;=249.40^^36^265^57
 ;;^UTILITY(U,$J,358.3,2895,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,2895,1,4,0)
 ;;=4^249.40
 ;;^UTILITY(U,$J,358.3,2895,1,5,0)
 ;;=5^Secondary DM w/ Renal Complication
 ;;^UTILITY(U,$J,358.3,2895,2)
 ;;=^336732
 ;;^UTILITY(U,$J,358.3,2896,0)
 ;;=249.60^^36^265^56
 ;;^UTILITY(U,$J,358.3,2896,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,2896,1,4,0)
 ;;=4^249.60
 ;;^UTILITY(U,$J,358.3,2896,1,5,0)
 ;;=5^Secondary DM w/ Neuro Complication
 ;;^UTILITY(U,$J,358.3,2896,2)
 ;;=^336734
 ;;^UTILITY(U,$J,358.3,2897,0)
 ;;=793.2^^36^266^1
 ;;^UTILITY(U,$J,358.3,2897,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,2897,1,4,0)
 ;;=4^793.2
 ;;^UTILITY(U,$J,358.3,2897,1,5,0)
 ;;=5^Abnormal Chest X-Ray, Other
 ;;^UTILITY(U,$J,358.3,2897,2)
 ;;=^273419
 ;;^UTILITY(U,$J,358.3,2898,0)
 ;;=277.6^^36^266^2
 ;;^UTILITY(U,$J,358.3,2898,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,2898,1,4,0)
 ;;=4^277.6
 ;;^UTILITY(U,$J,358.3,2898,1,5,0)
 ;;=5^Alpha-1 Antitrypsin Deficiency
 ;;^UTILITY(U,$J,358.3,2898,2)
 ;;=^87463
 ;;^UTILITY(U,$J,358.3,2899,0)
 ;;=493.92^^36^266^3
 ;;^UTILITY(U,$J,358.3,2899,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,2899,1,4,0)
 ;;=4^493.92
 ;;^UTILITY(U,$J,358.3,2899,1,5,0)
 ;;=5^Asthma, Acute Exacerbation
 ;;^UTILITY(U,$J,358.3,2899,2)
 ;;=^322001
 ;;^UTILITY(U,$J,358.3,2900,0)
 ;;=493.20^^36^266^10
 ;;^UTILITY(U,$J,358.3,2900,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,2900,1,4,0)
 ;;=4^493.20
 ;;^UTILITY(U,$J,358.3,2900,1,5,0)
 ;;=5^Copd With Asthma
 ;;^UTILITY(U,$J,358.3,2900,2)
 ;;=COPD with Asthma^269964
 ;;^UTILITY(U,$J,358.3,2901,0)
 ;;=493.91^^36^266^4
 ;;^UTILITY(U,$J,358.3,2901,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,2901,1,4,0)
 ;;=4^493.91
 ;;^UTILITY(U,$J,358.3,2901,1,5,0)
 ;;=5^Asthma, With Status Asthmat
 ;;^UTILITY(U,$J,358.3,2901,2)
 ;;=^269967
 ;;^UTILITY(U,$J,358.3,2902,0)
 ;;=491.21^^36^266^9
 ;;^UTILITY(U,$J,358.3,2902,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,2902,1,4,0)
 ;;=4^491.21
 ;;^UTILITY(U,$J,358.3,2902,1,5,0)
 ;;=5^Copd Exacerbation
 ;;^UTILITY(U,$J,358.3,2902,2)
 ;;=COPD Exacerbation^269954
 ;;^UTILITY(U,$J,358.3,2903,0)
 ;;=494.0^^36^266^6
 ;;^UTILITY(U,$J,358.3,2903,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,2903,1,4,0)
 ;;=4^494.0
 ;;^UTILITY(U,$J,358.3,2903,1,5,0)
 ;;=5^Bronchiectasis, Chronic
 ;;^UTILITY(U,$J,358.3,2903,2)
 ;;=^321990
 ;;^UTILITY(U,$J,358.3,2904,0)
 ;;=494.1^^36^266^5
 ;;^UTILITY(U,$J,358.3,2904,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,2904,1,4,0)
 ;;=4^494.1
 ;;^UTILITY(U,$J,358.3,2904,1,5,0)
 ;;=5^Bronchiectasis With Exacerb
 ;;^UTILITY(U,$J,358.3,2904,2)
 ;;=^321991
 ;;^UTILITY(U,$J,358.3,2905,0)
 ;;=496.^^36^266^11
 ;;^UTILITY(U,$J,358.3,2905,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,2905,1,4,0)
 ;;=4^496.
 ;;^UTILITY(U,$J,358.3,2905,1,5,0)
 ;;=5^Copd, General
 ;;^UTILITY(U,$J,358.3,2905,2)
 ;;=COPD, General^24355
 ;;^UTILITY(U,$J,358.3,2906,0)
 ;;=491.20^^36^266^7
 ;;^UTILITY(U,$J,358.3,2906,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,2906,1,4,0)
 ;;=4^491.20
 ;;^UTILITY(U,$J,358.3,2906,1,5,0)
 ;;=5^Chronic Asthmatic Bronchitis
 ;;^UTILITY(U,$J,358.3,2906,2)
 ;;=Chronic Asthmatic Bronchitis^269953
 ;;^UTILITY(U,$J,358.3,2907,0)
 ;;=491.9^^36^266^8
 ;;^UTILITY(U,$J,358.3,2907,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,2907,1,4,0)
 ;;=4^491.9
 ;;^UTILITY(U,$J,358.3,2907,1,5,0)
 ;;=5^Chronic Bronchitis
 ;;^UTILITY(U,$J,358.3,2907,2)
 ;;=^24359
 ;;^UTILITY(U,$J,358.3,2908,0)
 ;;=786.2^^36^266^12
 ;;^UTILITY(U,$J,358.3,2908,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,2908,1,4,0)
 ;;=4^786.2
 ;;^UTILITY(U,$J,358.3,2908,1,5,0)
 ;;=5^Cough
 ;;^UTILITY(U,$J,358.3,2908,2)
 ;;=Cough^28905
 ;;^UTILITY(U,$J,358.3,2909,0)
 ;;=786.09^^36^266^13
 ;;^UTILITY(U,$J,358.3,2909,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,2909,1,4,0)
 ;;=4^786.09
 ;;^UTILITY(U,$J,358.3,2909,1,5,0)
 ;;=5^Dyspnea
 ;;^UTILITY(U,$J,358.3,2909,2)
 ;;=Dyspnea^87547
 ;;^UTILITY(U,$J,358.3,2910,0)
 ;;=492.8^^36^266^14
 ;;^UTILITY(U,$J,358.3,2910,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,2910,1,4,0)
 ;;=4^492.8
 ;;^UTILITY(U,$J,358.3,2910,1,5,0)
 ;;=5^Emphysema
 ;;^UTILITY(U,$J,358.3,2910,2)
 ;;=Emphysema^87569
 ;;^UTILITY(U,$J,358.3,2911,0)
 ;;=487.1^^36^266^16
 ;;^UTILITY(U,$J,358.3,2911,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,2911,1,4,0)
 ;;=4^487.1
 ;;^UTILITY(U,$J,358.3,2911,1,5,0)
 ;;=5^Influenza With Other Resp Manifest
 ;;^UTILITY(U,$J,358.3,2911,2)
 ;;=^63125
 ;;^UTILITY(U,$J,358.3,2912,0)
 ;;=487.0^^36^266^15
 ;;^UTILITY(U,$J,358.3,2912,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,2912,1,4,0)
 ;;=4^487.0
 ;;^UTILITY(U,$J,358.3,2912,1,5,0)
 ;;=5^Influenza W Pneumonia
 ;;^UTILITY(U,$J,358.3,2912,2)
 ;;=^269942
 ;;^UTILITY(U,$J,358.3,2913,0)
 ;;=515.^^36^266^17
 ;;^UTILITY(U,$J,358.3,2913,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,2913,1,4,0)
 ;;=4^515.
 ;;^UTILITY(U,$J,358.3,2913,1,5,0)
 ;;=5^Interstitial Lung Disease
 ;;^UTILITY(U,$J,358.3,2913,2)
 ;;=^101072
 ;;^UTILITY(U,$J,358.3,2914,0)
 ;;=786.52^^36^266^19
 ;;^UTILITY(U,$J,358.3,2914,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,2914,1,4,0)
 ;;=4^786.52
 ;;^UTILITY(U,$J,358.3,2914,1,5,0)
 ;;=5^Painful Resp, Pleurodynia
 ;;^UTILITY(U,$J,358.3,2914,2)
 ;;=^89126
 ;;^UTILITY(U,$J,358.3,2915,0)
 ;;=511.9^^36^266^21
 ;;^UTILITY(U,$J,358.3,2915,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,2915,1,4,0)
 ;;=4^511.9
 ;;^UTILITY(U,$J,358.3,2915,1,5,0)
 ;;=5^Pleural Effusion, Unsp Type
 ;;^UTILITY(U,$J,358.3,2915,2)
 ;;=^123973
 ;;^UTILITY(U,$J,358.3,2916,0)
 ;;=511.0^^36^266^23
 ;;^UTILITY(U,$J,358.3,2916,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,2916,1,4,0)
 ;;=4^511.0
