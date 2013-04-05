IBDEI06C ; ; 20-FEB-2013
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 20, 2013
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,8274,1,5,0)
 ;;=5^Hypothyroid, Postsurgical
 ;;^UTILITY(U,$J,358.3,8274,2)
 ;;=^267814
 ;;^UTILITY(U,$J,358.3,8275,0)
 ;;=244.2^^74^624^42
 ;;^UTILITY(U,$J,358.3,8275,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,8275,1,4,0)
 ;;=4^244.2
 ;;^UTILITY(U,$J,358.3,8275,1,5,0)
 ;;=5^Hypothyroid Due To Iodine Rx
 ;;^UTILITY(U,$J,358.3,8275,2)
 ;;=^267817
 ;;^UTILITY(U,$J,358.3,8276,0)
 ;;=244.9^^74^624^44
 ;;^UTILITY(U,$J,358.3,8276,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,8276,1,4,0)
 ;;=4^244.9
 ;;^UTILITY(U,$J,358.3,8276,1,5,0)
 ;;=5^Hypothyroid, Unspec Cause
 ;;^UTILITY(U,$J,358.3,8276,2)
 ;;=^123752
 ;;^UTILITY(U,$J,358.3,8277,0)
 ;;=245.0^^74^624^60
 ;;^UTILITY(U,$J,358.3,8277,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,8277,1,4,0)
 ;;=4^245.0
 ;;^UTILITY(U,$J,358.3,8277,1,5,0)
 ;;=5^Thyroiditis, Acute
 ;;^UTILITY(U,$J,358.3,8277,2)
 ;;=^2692
 ;;^UTILITY(U,$J,358.3,8278,0)
 ;;=245.1^^74^624^61
 ;;^UTILITY(U,$J,358.3,8278,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,8278,1,4,0)
 ;;=4^245.1
 ;;^UTILITY(U,$J,358.3,8278,1,5,0)
 ;;=5^Thyroiditis, Subacute
 ;;^UTILITY(U,$J,358.3,8278,2)
 ;;=^119376
 ;;^UTILITY(U,$J,358.3,8279,0)
 ;;=733.01^^74^624^54
 ;;^UTILITY(U,$J,358.3,8279,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,8279,1,4,0)
 ;;=4^733.01
 ;;^UTILITY(U,$J,358.3,8279,1,5,0)
 ;;=5^Osteoporosis, Senile
 ;;^UTILITY(U,$J,358.3,8279,2)
 ;;=Osteoporosis, Senile^87188
 ;;^UTILITY(U,$J,358.3,8280,0)
 ;;=733.02^^74^624^53
 ;;^UTILITY(U,$J,358.3,8280,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,8280,1,4,0)
 ;;=4^733.02
 ;;^UTILITY(U,$J,358.3,8280,1,5,0)
 ;;=5^Osteoporosis, Idiopathic
 ;;^UTILITY(U,$J,358.3,8280,2)
 ;;=Osteoporosis, Idiopathic^272692
 ;;^UTILITY(U,$J,358.3,8281,0)
 ;;=268.2^^74^624^49
 ;;^UTILITY(U,$J,358.3,8281,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,8281,1,4,0)
 ;;=4^268.2
 ;;^UTILITY(U,$J,358.3,8281,1,5,0)
 ;;=5^Osteomalacia
 ;;^UTILITY(U,$J,358.3,8281,2)
 ;;=Osteomalacia^87103
 ;;^UTILITY(U,$J,358.3,8282,0)
 ;;=733.90^^74^624^50
 ;;^UTILITY(U,$J,358.3,8282,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,8282,1,4,0)
 ;;=4^733.90
 ;;^UTILITY(U,$J,358.3,8282,1,5,0)
 ;;=5^Osteopenia
 ;;^UTILITY(U,$J,358.3,8282,2)
 ;;=Osteopenia^35593
 ;;^UTILITY(U,$J,358.3,8283,0)
 ;;=275.49^^74^624^55
 ;;^UTILITY(U,$J,358.3,8283,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,8283,1,4,0)
 ;;=4^275.49
 ;;^UTILITY(U,$J,358.3,8283,1,5,0)
 ;;=5^Pseudohypoparathyroidism
 ;;^UTILITY(U,$J,358.3,8283,2)
 ;;=Pseudohypparathyroidism^317904
 ;;^UTILITY(U,$J,358.3,8284,0)
 ;;=266.2^^74^624^63
 ;;^UTILITY(U,$J,358.3,8284,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,8284,1,4,0)
 ;;=4^266.2
 ;;^UTILITY(U,$J,358.3,8284,1,5,0)
 ;;=5^Vitamin B12 Deficiency
 ;;^UTILITY(U,$J,358.3,8284,2)
 ;;=Vitamin B12 Deficiency^87347
 ;;^UTILITY(U,$J,358.3,8285,0)
 ;;=268.9^^74^624^65
 ;;^UTILITY(U,$J,358.3,8285,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,8285,1,4,0)
 ;;=4^268.9
 ;;^UTILITY(U,$J,358.3,8285,1,5,0)
 ;;=5^Vitamin D Deficiency
 ;;^UTILITY(U,$J,358.3,8285,2)
 ;;=Vitamin D Deficiency^126968
 ;;^UTILITY(U,$J,358.3,8286,0)
 ;;=266.1^^74^624^64
 ;;^UTILITY(U,$J,358.3,8286,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,8286,1,4,0)
 ;;=4^266.1
 ;;^UTILITY(U,$J,358.3,8286,1,5,0)
 ;;=5^Vitamin B6 Deficiency
 ;;^UTILITY(U,$J,358.3,8286,2)
 ;;=^101683
 ;;^UTILITY(U,$J,358.3,8287,0)
 ;;=780.99^^74^624^7
 ;;^UTILITY(U,$J,358.3,8287,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,8287,1,4,0)
 ;;=4^780.99
 ;;^UTILITY(U,$J,358.3,8287,1,5,0)
 ;;=5^Cold Intolerance
 ;;^UTILITY(U,$J,358.3,8287,2)
 ;;=Cold Intolerance^328568
 ;;^UTILITY(U,$J,358.3,8288,0)
 ;;=255.41^^74^624^16
 ;;^UTILITY(U,$J,358.3,8288,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,8288,1,4,0)
 ;;=4^255.41
 ;;^UTILITY(U,$J,358.3,8288,1,5,0)
 ;;=5^Glucocorticoid Deficient
 ;;^UTILITY(U,$J,358.3,8288,2)
 ;;=^335240
 ;;^UTILITY(U,$J,358.3,8289,0)
 ;;=255.42^^74^624^46
 ;;^UTILITY(U,$J,358.3,8289,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,8289,1,4,0)
 ;;=4^255.42
 ;;^UTILITY(U,$J,358.3,8289,1,5,0)
 ;;=5^Mineralcorticoid Defcnt
 ;;^UTILITY(U,$J,358.3,8289,2)
 ;;=^335241
 ;;^UTILITY(U,$J,358.3,8290,0)
 ;;=259.50^^74^624^6
 ;;^UTILITY(U,$J,358.3,8290,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,8290,1,4,0)
 ;;=4^259.50
 ;;^UTILITY(U,$J,358.3,8290,1,5,0)
 ;;=5^Androgen Insensitivity, Unsp
 ;;^UTILITY(U,$J,358.3,8290,2)
 ;;=^336738
 ;;^UTILITY(U,$J,358.3,8291,0)
 ;;=275.5^^74^624^24
 ;;^UTILITY(U,$J,358.3,8291,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,8291,1,4,0)
 ;;=4^275.5
 ;;^UTILITY(U,$J,358.3,8291,1,5,0)
 ;;=5^Hungry Bone Syndrome
 ;;^UTILITY(U,$J,358.3,8291,2)
 ;;=^336538
 ;;^UTILITY(U,$J,358.3,8292,0)
 ;;=249.00^^74^624^58
 ;;^UTILITY(U,$J,358.3,8292,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,8292,1,4,0)
 ;;=4^249.00
 ;;^UTILITY(U,$J,358.3,8292,1,5,0)
 ;;=5^Secondary DM w/o Complication
 ;;^UTILITY(U,$J,358.3,8292,2)
 ;;=^336728
 ;;^UTILITY(U,$J,358.3,8293,0)
 ;;=249.40^^74^624^57
 ;;^UTILITY(U,$J,358.3,8293,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,8293,1,4,0)
 ;;=4^249.40
 ;;^UTILITY(U,$J,358.3,8293,1,5,0)
 ;;=5^Secondary DM w/ Renal Complication
 ;;^UTILITY(U,$J,358.3,8293,2)
 ;;=^336732
 ;;^UTILITY(U,$J,358.3,8294,0)
 ;;=249.60^^74^624^56
 ;;^UTILITY(U,$J,358.3,8294,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,8294,1,4,0)
 ;;=4^249.60
 ;;^UTILITY(U,$J,358.3,8294,1,5,0)
 ;;=5^Secondary DM w/ Neuro Complication
 ;;^UTILITY(U,$J,358.3,8294,2)
 ;;=^336734
 ;;^UTILITY(U,$J,358.3,8295,0)
 ;;=793.2^^74^625^1
 ;;^UTILITY(U,$J,358.3,8295,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,8295,1,4,0)
 ;;=4^793.2
 ;;^UTILITY(U,$J,358.3,8295,1,5,0)
 ;;=5^Abnormal Chest X-Ray, Other
 ;;^UTILITY(U,$J,358.3,8295,2)
 ;;=^273419
 ;;^UTILITY(U,$J,358.3,8296,0)
 ;;=277.6^^74^625^2
 ;;^UTILITY(U,$J,358.3,8296,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,8296,1,4,0)
 ;;=4^277.6
 ;;^UTILITY(U,$J,358.3,8296,1,5,0)
 ;;=5^Alpha-1 Antitrypsin Deficiency
 ;;^UTILITY(U,$J,358.3,8296,2)
 ;;=^87463
 ;;^UTILITY(U,$J,358.3,8297,0)
 ;;=493.92^^74^625^3
 ;;^UTILITY(U,$J,358.3,8297,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,8297,1,4,0)
 ;;=4^493.92
 ;;^UTILITY(U,$J,358.3,8297,1,5,0)
 ;;=5^Asthma, Acute Exacerbation
 ;;^UTILITY(U,$J,358.3,8297,2)
 ;;=^322001
 ;;^UTILITY(U,$J,358.3,8298,0)
 ;;=493.20^^74^625^10
 ;;^UTILITY(U,$J,358.3,8298,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,8298,1,4,0)
 ;;=4^493.20
 ;;^UTILITY(U,$J,358.3,8298,1,5,0)
 ;;=5^Copd With Asthma
 ;;^UTILITY(U,$J,358.3,8298,2)
 ;;=COPD with Asthma^269964
 ;;^UTILITY(U,$J,358.3,8299,0)
 ;;=493.91^^74^625^4
 ;;^UTILITY(U,$J,358.3,8299,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,8299,1,4,0)
 ;;=4^493.91
 ;;^UTILITY(U,$J,358.3,8299,1,5,0)
 ;;=5^Asthma, With Status Asthmat
 ;;^UTILITY(U,$J,358.3,8299,2)
 ;;=^269967
 ;;^UTILITY(U,$J,358.3,8300,0)
 ;;=491.21^^74^625^9
 ;;^UTILITY(U,$J,358.3,8300,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,8300,1,4,0)
 ;;=4^491.21
 ;;^UTILITY(U,$J,358.3,8300,1,5,0)
 ;;=5^Copd Exacerbation
 ;;^UTILITY(U,$J,358.3,8300,2)
 ;;=COPD Exacerbation^269954
 ;;^UTILITY(U,$J,358.3,8301,0)
 ;;=494.0^^74^625^6
 ;;^UTILITY(U,$J,358.3,8301,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,8301,1,4,0)
 ;;=4^494.0
 ;;^UTILITY(U,$J,358.3,8301,1,5,0)
 ;;=5^Bronchiectasis, Chronic
 ;;^UTILITY(U,$J,358.3,8301,2)
 ;;=^321990
 ;;^UTILITY(U,$J,358.3,8302,0)
 ;;=494.1^^74^625^5
 ;;^UTILITY(U,$J,358.3,8302,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,8302,1,4,0)
 ;;=4^494.1
 ;;^UTILITY(U,$J,358.3,8302,1,5,0)
 ;;=5^Bronchiectasis With Exacerb
 ;;^UTILITY(U,$J,358.3,8302,2)
 ;;=^321991
 ;;^UTILITY(U,$J,358.3,8303,0)
 ;;=496.^^74^625^11
 ;;^UTILITY(U,$J,358.3,8303,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,8303,1,4,0)
 ;;=4^496.
 ;;^UTILITY(U,$J,358.3,8303,1,5,0)
 ;;=5^Copd, General
 ;;^UTILITY(U,$J,358.3,8303,2)
 ;;=COPD, General^24355
 ;;^UTILITY(U,$J,358.3,8304,0)
 ;;=491.20^^74^625^7
 ;;^UTILITY(U,$J,358.3,8304,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,8304,1,4,0)
 ;;=4^491.20
 ;;^UTILITY(U,$J,358.3,8304,1,5,0)
 ;;=5^Chronic Asthmatic Bronchitis
 ;;^UTILITY(U,$J,358.3,8304,2)
 ;;=Chronic Asthmatic Bronchitis^269953
 ;;^UTILITY(U,$J,358.3,8305,0)
 ;;=491.9^^74^625^8
 ;;^UTILITY(U,$J,358.3,8305,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,8305,1,4,0)
 ;;=4^491.9
 ;;^UTILITY(U,$J,358.3,8305,1,5,0)
 ;;=5^Chronic Bronchitis
 ;;^UTILITY(U,$J,358.3,8305,2)
 ;;=^24359
 ;;^UTILITY(U,$J,358.3,8306,0)
 ;;=786.2^^74^625^12
 ;;^UTILITY(U,$J,358.3,8306,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,8306,1,4,0)
 ;;=4^786.2
 ;;^UTILITY(U,$J,358.3,8306,1,5,0)
 ;;=5^Cough
 ;;^UTILITY(U,$J,358.3,8306,2)
 ;;=Cough^28905
 ;;^UTILITY(U,$J,358.3,8307,0)
 ;;=786.09^^74^625^13
 ;;^UTILITY(U,$J,358.3,8307,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,8307,1,4,0)
 ;;=4^786.09
 ;;^UTILITY(U,$J,358.3,8307,1,5,0)
 ;;=5^Dyspnea
 ;;^UTILITY(U,$J,358.3,8307,2)
 ;;=Dyspnea^87547
 ;;^UTILITY(U,$J,358.3,8308,0)
 ;;=492.8^^74^625^14
 ;;^UTILITY(U,$J,358.3,8308,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,8308,1,4,0)
 ;;=4^492.8
 ;;^UTILITY(U,$J,358.3,8308,1,5,0)
 ;;=5^Emphysema
 ;;^UTILITY(U,$J,358.3,8308,2)
 ;;=Emphysema^87569
 ;;^UTILITY(U,$J,358.3,8309,0)
 ;;=487.1^^74^625^16
 ;;^UTILITY(U,$J,358.3,8309,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,8309,1,4,0)
 ;;=4^487.1
 ;;^UTILITY(U,$J,358.3,8309,1,5,0)
 ;;=5^Influenza With Other Resp Manifest
 ;;^UTILITY(U,$J,358.3,8309,2)
 ;;=^63125
 ;;^UTILITY(U,$J,358.3,8310,0)
 ;;=487.0^^74^625^15
 ;;^UTILITY(U,$J,358.3,8310,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,8310,1,4,0)
 ;;=4^487.0
 ;;^UTILITY(U,$J,358.3,8310,1,5,0)
 ;;=5^Influenza W Pneumonia
 ;;^UTILITY(U,$J,358.3,8310,2)
 ;;=^269942
 ;;^UTILITY(U,$J,358.3,8311,0)
 ;;=515.^^74^625^17
 ;;^UTILITY(U,$J,358.3,8311,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,8311,1,4,0)
 ;;=4^515.
 ;;^UTILITY(U,$J,358.3,8311,1,5,0)
 ;;=5^Interstitial Lung Disease
