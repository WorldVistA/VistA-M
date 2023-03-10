IBDEI03P ; ; 01-AUG-2022
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;AUG 01, 2022
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,8873,1,3,0)
 ;;=3^Hematuria,Microscopic,Asymptomatic
 ;;^UTILITY(U,$J,358.3,8873,1,4,0)
 ;;=4^R31.21
 ;;^UTILITY(U,$J,358.3,8873,2)
 ;;=^5139198
 ;;^UTILITY(U,$J,358.3,8874,0)
 ;;=R31.29^^45^428^59
 ;;^UTILITY(U,$J,358.3,8874,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8874,1,3,0)
 ;;=3^Hematuria,Microscopic,Other
 ;;^UTILITY(U,$J,358.3,8874,1,4,0)
 ;;=4^R31.29
 ;;^UTILITY(U,$J,358.3,8874,2)
 ;;=^5019327
 ;;^UTILITY(U,$J,358.3,8875,0)
 ;;=R39.198^^45^428^72
 ;;^UTILITY(U,$J,358.3,8875,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8875,1,3,0)
 ;;=3^Micturition,Oth Difficulties
 ;;^UTILITY(U,$J,358.3,8875,1,4,0)
 ;;=4^R39.198
 ;;^UTILITY(U,$J,358.3,8875,2)
 ;;=^5019347
 ;;^UTILITY(U,$J,358.3,8876,0)
 ;;=R39.191^^45^428^74
 ;;^UTILITY(U,$J,358.3,8876,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8876,1,3,0)
 ;;=3^Need to Immediately Re-Void
 ;;^UTILITY(U,$J,358.3,8876,1,4,0)
 ;;=4^R39.191
 ;;^UTILITY(U,$J,358.3,8876,2)
 ;;=^5139199
 ;;^UTILITY(U,$J,358.3,8877,0)
 ;;=R39.192^^45^428^73
 ;;^UTILITY(U,$J,358.3,8877,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8877,1,3,0)
 ;;=3^Micturition,Position Dependent
 ;;^UTILITY(U,$J,358.3,8877,1,4,0)
 ;;=4^R39.192
 ;;^UTILITY(U,$J,358.3,8877,2)
 ;;=^5139200
 ;;^UTILITY(U,$J,358.3,8878,0)
 ;;=R97.21^^45^428^103
 ;;^UTILITY(U,$J,358.3,8878,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8878,1,3,0)
 ;;=3^Rising PSA After Tx for Prostate CA
 ;;^UTILITY(U,$J,358.3,8878,1,4,0)
 ;;=4^R97.21
 ;;^UTILITY(U,$J,358.3,8878,2)
 ;;=^5139228
 ;;^UTILITY(U,$J,358.3,8879,0)
 ;;=N50.82^^45^428^104
 ;;^UTILITY(U,$J,358.3,8879,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8879,1,3,0)
 ;;=3^Scrotal Pain
 ;;^UTILITY(U,$J,358.3,8879,1,4,0)
 ;;=4^N50.82
 ;;^UTILITY(U,$J,358.3,8879,2)
 ;;=^5138930
 ;;^UTILITY(U,$J,358.3,8880,0)
 ;;=N50.812^^45^428^108
 ;;^UTILITY(U,$J,358.3,8880,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8880,1,3,0)
 ;;=3^Testicular Pain,Left Side
 ;;^UTILITY(U,$J,358.3,8880,1,4,0)
 ;;=4^N50.812
 ;;^UTILITY(U,$J,358.3,8880,2)
 ;;=^5138928
 ;;^UTILITY(U,$J,358.3,8881,0)
 ;;=N50.811^^45^428^109
 ;;^UTILITY(U,$J,358.3,8881,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8881,1,3,0)
 ;;=3^Testicular Pain,Right Side
 ;;^UTILITY(U,$J,358.3,8881,1,4,0)
 ;;=4^N50.811
 ;;^UTILITY(U,$J,358.3,8881,2)
 ;;=^5138927
 ;;^UTILITY(U,$J,358.3,8882,0)
 ;;=N35.919^^45^428^114
 ;;^UTILITY(U,$J,358.3,8882,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8882,1,3,0)
 ;;=3^Urethral Stricture,NOS,Male
 ;;^UTILITY(U,$J,358.3,8882,1,4,0)
 ;;=4^N35.919
 ;;^UTILITY(U,$J,358.3,8882,2)
 ;;=^5157412
 ;;^UTILITY(U,$J,358.3,8883,0)
 ;;=N35.92^^45^428^113
 ;;^UTILITY(U,$J,358.3,8883,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8883,1,3,0)
 ;;=3^Urethral Stricture,NOS,Female
 ;;^UTILITY(U,$J,358.3,8883,1,4,0)
 ;;=4^N35.92
 ;;^UTILITY(U,$J,358.3,8883,2)
 ;;=^5157413
 ;;^UTILITY(U,$J,358.3,8884,0)
 ;;=R82.81^^45^428^101
 ;;^UTILITY(U,$J,358.3,8884,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8884,1,3,0)
 ;;=3^Pyuria
 ;;^UTILITY(U,$J,358.3,8884,1,4,0)
 ;;=4^R82.81
 ;;^UTILITY(U,$J,358.3,8884,2)
 ;;=^101879
 ;;^UTILITY(U,$J,358.3,8885,0)
 ;;=N18.30^^45^428^17
 ;;^UTILITY(U,$J,358.3,8885,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8885,1,3,0)
 ;;=3^Chronic Kidney Disease,Stage 3 Unspec
 ;;^UTILITY(U,$J,358.3,8885,1,4,0)
 ;;=4^N18.30
 ;;^UTILITY(U,$J,358.3,8885,2)
 ;;=^5159286
 ;;^UTILITY(U,$J,358.3,8886,0)
 ;;=N18.31^^45^428^18
 ;;^UTILITY(U,$J,358.3,8886,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8886,1,3,0)
 ;;=3^Chronic Kidney Disease,Stage 3a
 ;;^UTILITY(U,$J,358.3,8886,1,4,0)
 ;;=4^N18.31
 ;;^UTILITY(U,$J,358.3,8886,2)
 ;;=^5159287
 ;;^UTILITY(U,$J,358.3,8887,0)
 ;;=N18.32^^45^428^19
 ;;^UTILITY(U,$J,358.3,8887,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8887,1,3,0)
 ;;=3^Chronic Kidney Disease,Stage 3b
 ;;^UTILITY(U,$J,358.3,8887,1,4,0)
 ;;=4^N18.32
 ;;^UTILITY(U,$J,358.3,8887,2)
 ;;=^5159288
 ;;^UTILITY(U,$J,358.3,8888,0)
 ;;=G44.1^^45^429^10
 ;;^UTILITY(U,$J,358.3,8888,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8888,1,3,0)
 ;;=3^Vascular Headache NEC
 ;;^UTILITY(U,$J,358.3,8888,1,4,0)
 ;;=4^G44.1
 ;;^UTILITY(U,$J,358.3,8888,2)
 ;;=^5003934
 ;;^UTILITY(U,$J,358.3,8889,0)
 ;;=G43.909^^45^429^6
 ;;^UTILITY(U,$J,358.3,8889,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8889,1,3,0)
 ;;=3^Migraine,Unspec,Not Intractable
 ;;^UTILITY(U,$J,358.3,8889,1,4,0)
 ;;=4^G43.909
 ;;^UTILITY(U,$J,358.3,8889,2)
 ;;=^5003909
 ;;^UTILITY(U,$J,358.3,8890,0)
 ;;=G44.009^^45^429^1
 ;;^UTILITY(U,$J,358.3,8890,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8890,1,3,0)
 ;;=3^Cluster Headache,Unspec,Not Intractable
 ;;^UTILITY(U,$J,358.3,8890,1,4,0)
 ;;=4^G44.009
 ;;^UTILITY(U,$J,358.3,8890,2)
 ;;=^5003921
 ;;^UTILITY(U,$J,358.3,8891,0)
 ;;=G44.40^^45^429^5
 ;;^UTILITY(U,$J,358.3,8891,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8891,1,3,0)
 ;;=3^Medication Overuse Headache,Not Intractable
 ;;^UTILITY(U,$J,358.3,8891,1,4,0)
 ;;=4^G44.40
 ;;^UTILITY(U,$J,358.3,8891,2)
 ;;=^5003947
 ;;^UTILITY(U,$J,358.3,8892,0)
 ;;=G44.89^^45^429^2
 ;;^UTILITY(U,$J,358.3,8892,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8892,1,3,0)
 ;;=3^Headache Syndrome NEC
 ;;^UTILITY(U,$J,358.3,8892,1,4,0)
 ;;=4^G44.89
 ;;^UTILITY(U,$J,358.3,8892,2)
 ;;=^5003954
 ;;^UTILITY(U,$J,358.3,8893,0)
 ;;=G44.84^^45^429^8
 ;;^UTILITY(U,$J,358.3,8893,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8893,1,3,0)
 ;;=3^Primary Exertional Headache
 ;;^UTILITY(U,$J,358.3,8893,1,4,0)
 ;;=4^G44.84
 ;;^UTILITY(U,$J,358.3,8893,2)
 ;;=^336563
 ;;^UTILITY(U,$J,358.3,8894,0)
 ;;=G44.301^^45^429^7
 ;;^UTILITY(U,$J,358.3,8894,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8894,1,3,0)
 ;;=3^Post-Traumatic Headache,Unspec,Intractable
 ;;^UTILITY(U,$J,358.3,8894,1,4,0)
 ;;=4^G44.301
 ;;^UTILITY(U,$J,358.3,8894,2)
 ;;=^5003941
 ;;^UTILITY(U,$J,358.3,8895,0)
 ;;=G44.209^^45^429^9
 ;;^UTILITY(U,$J,358.3,8895,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8895,1,3,0)
 ;;=3^Tension-Type Headache,Unspec,Not Intractable
 ;;^UTILITY(U,$J,358.3,8895,1,4,0)
 ;;=4^G44.209
 ;;^UTILITY(U,$J,358.3,8895,2)
 ;;=^5003936
 ;;^UTILITY(U,$J,358.3,8896,0)
 ;;=R51.0^^45^429^3
 ;;^UTILITY(U,$J,358.3,8896,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8896,1,3,0)
 ;;=3^Headache w/ Orthostatic Component,NEC
 ;;^UTILITY(U,$J,358.3,8896,1,4,0)
 ;;=4^R51.0
 ;;^UTILITY(U,$J,358.3,8896,2)
 ;;=^5159305
 ;;^UTILITY(U,$J,358.3,8897,0)
 ;;=R51.9^^45^429^4
 ;;^UTILITY(U,$J,358.3,8897,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8897,1,3,0)
 ;;=3^Headache,Unspec
 ;;^UTILITY(U,$J,358.3,8897,1,4,0)
 ;;=4^R51.9
 ;;^UTILITY(U,$J,358.3,8897,2)
 ;;=^5159306
 ;;^UTILITY(U,$J,358.3,8898,0)
 ;;=I30.0^^45^430^5
 ;;^UTILITY(U,$J,358.3,8898,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8898,1,3,0)
 ;;=3^Idiopathic Pericarditis,Acute Nonspec
 ;;^UTILITY(U,$J,358.3,8898,1,4,0)
 ;;=4^I30.0
 ;;^UTILITY(U,$J,358.3,8898,2)
 ;;=^5007157
 ;;^UTILITY(U,$J,358.3,8899,0)
 ;;=I34.8^^45^430^6
 ;;^UTILITY(U,$J,358.3,8899,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8899,1,3,0)
 ;;=3^Mitral Valve Disorders,Nonrheumatic Other
 ;;^UTILITY(U,$J,358.3,8899,1,4,0)
 ;;=4^I34.8
 ;;^UTILITY(U,$J,358.3,8899,2)
 ;;=^5007172
 ;;^UTILITY(U,$J,358.3,8900,0)
 ;;=I34.0^^45^430^13
 ;;^UTILITY(U,$J,358.3,8900,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8900,1,3,0)
 ;;=3^Nonrheumatic Mitral Valve Insufficiency
 ;;^UTILITY(U,$J,358.3,8900,1,4,0)
 ;;=4^I34.0
 ;;^UTILITY(U,$J,358.3,8900,2)
 ;;=^5007169
 ;;^UTILITY(U,$J,358.3,8901,0)
 ;;=I34.9^^45^430^12
 ;;^UTILITY(U,$J,358.3,8901,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8901,1,3,0)
 ;;=3^Nonrheumatic Mitral Valve Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,8901,1,4,0)
 ;;=4^I34.9
 ;;^UTILITY(U,$J,358.3,8901,2)
 ;;=^5007173
 ;;^UTILITY(U,$J,358.3,8902,0)
 ;;=I34.2^^45^430^7
 ;;^UTILITY(U,$J,358.3,8902,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8902,1,3,0)
 ;;=3^Nonrhematic Mitral Valve Stenosis
 ;;^UTILITY(U,$J,358.3,8902,1,4,0)
 ;;=4^I34.2
 ;;^UTILITY(U,$J,358.3,8902,2)
 ;;=^5007171
 ;;^UTILITY(U,$J,358.3,8903,0)
 ;;=I35.0^^45^430^10
 ;;^UTILITY(U,$J,358.3,8903,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8903,1,3,0)
 ;;=3^Nonrheumatic Aortic Valve Stenosis
 ;;^UTILITY(U,$J,358.3,8903,1,4,0)
 ;;=4^I35.0
 ;;^UTILITY(U,$J,358.3,8903,2)
 ;;=^5007174
 ;;^UTILITY(U,$J,358.3,8904,0)
 ;;=I35.1^^45^430^9
 ;;^UTILITY(U,$J,358.3,8904,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8904,1,3,0)
 ;;=3^Nonrheumatic Aortic Valve Insufficiency
 ;;^UTILITY(U,$J,358.3,8904,1,4,0)
 ;;=4^I35.1
 ;;^UTILITY(U,$J,358.3,8904,2)
 ;;=^5007175
 ;;^UTILITY(U,$J,358.3,8905,0)
 ;;=I35.2^^45^430^11
 ;;^UTILITY(U,$J,358.3,8905,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8905,1,3,0)
 ;;=3^Nonrheumatic Aortic Valve Stenosis w/ Insufficiency
 ;;^UTILITY(U,$J,358.3,8905,1,4,0)
 ;;=4^I35.2
 ;;^UTILITY(U,$J,358.3,8905,2)
 ;;=^5007176
 ;;^UTILITY(U,$J,358.3,8906,0)
 ;;=I35.9^^45^430^8
 ;;^UTILITY(U,$J,358.3,8906,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8906,1,3,0)
 ;;=3^Nonrheumatic Aortic Valve Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,8906,1,4,0)
 ;;=4^I35.9
 ;;^UTILITY(U,$J,358.3,8906,2)
 ;;=^5007178
 ;;^UTILITY(U,$J,358.3,8907,0)
 ;;=I38.^^45^430^4
 ;;^UTILITY(U,$J,358.3,8907,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8907,1,3,0)
 ;;=3^Endocarditis,Valve Unspec
 ;;^UTILITY(U,$J,358.3,8907,1,4,0)
 ;;=4^I38.
 ;;^UTILITY(U,$J,358.3,8907,2)
 ;;=^40327
 ;;^UTILITY(U,$J,358.3,8908,0)
 ;;=I05.0^^45^430^18
 ;;^UTILITY(U,$J,358.3,8908,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8908,1,3,0)
 ;;=3^Rheumatic Mitral Stenosis
 ;;^UTILITY(U,$J,358.3,8908,1,4,0)
 ;;=4^I05.0
 ;;^UTILITY(U,$J,358.3,8908,2)
 ;;=^5007041
 ;;^UTILITY(U,$J,358.3,8909,0)
 ;;=I05.8^^45^430^19
 ;;^UTILITY(U,$J,358.3,8909,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8909,1,3,0)
 ;;=3^Rheumatic Mitral Valve Disease NEC
 ;;^UTILITY(U,$J,358.3,8909,1,4,0)
 ;;=4^I05.8
 ;;^UTILITY(U,$J,358.3,8909,2)
 ;;=^5007043
 ;;^UTILITY(U,$J,358.3,8910,0)
 ;;=I05.9^^45^430^20
 ;;^UTILITY(U,$J,358.3,8910,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8910,1,3,0)
 ;;=3^Rheumatic Mitral Valve Disease,Unspec
 ;;^UTILITY(U,$J,358.3,8910,1,4,0)
 ;;=4^I05.9
 ;;^UTILITY(U,$J,358.3,8910,2)
 ;;=^5007044
 ;;^UTILITY(U,$J,358.3,8911,0)
 ;;=I07.1^^45^430^21
 ;;^UTILITY(U,$J,358.3,8911,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8911,1,3,0)
 ;;=3^Rheumatic Tricuspid Insufficiency
 ;;^UTILITY(U,$J,358.3,8911,1,4,0)
 ;;=4^I07.1
 ;;^UTILITY(U,$J,358.3,8911,2)
 ;;=^5007048
 ;;^UTILITY(U,$J,358.3,8912,0)
 ;;=I07.9^^45^430^22
 ;;^UTILITY(U,$J,358.3,8912,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8912,1,3,0)
 ;;=3^Rheumatic Tricuspid Valve Disease,Unspec
 ;;^UTILITY(U,$J,358.3,8912,1,4,0)
 ;;=4^I07.9
 ;;^UTILITY(U,$J,358.3,8912,2)
 ;;=^5007051
 ;;^UTILITY(U,$J,358.3,8913,0)
 ;;=I08.0^^45^430^16
 ;;^UTILITY(U,$J,358.3,8913,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8913,1,3,0)
 ;;=3^Rheumatic Disorders of Mitral & Aortic Valves
 ;;^UTILITY(U,$J,358.3,8913,1,4,0)
 ;;=4^I08.0
 ;;^UTILITY(U,$J,358.3,8913,2)
 ;;=^5007052
 ;;^UTILITY(U,$J,358.3,8914,0)
 ;;=I09.89^^45^430^17
 ;;^UTILITY(U,$J,358.3,8914,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8914,1,3,0)
 ;;=3^Rheumatic Heart Diseases NEC
 ;;^UTILITY(U,$J,358.3,8914,1,4,0)
 ;;=4^I09.89
 ;;^UTILITY(U,$J,358.3,8914,2)
 ;;=^5007060
 ;;^UTILITY(U,$J,358.3,8915,0)
 ;;=I47.1^^45^430^24
 ;;^UTILITY(U,$J,358.3,8915,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8915,1,3,0)
 ;;=3^Supraventricular Tachycardia
 ;;^UTILITY(U,$J,358.3,8915,1,4,0)
 ;;=4^I47.1
 ;;^UTILITY(U,$J,358.3,8915,2)
 ;;=^5007223
 ;;^UTILITY(U,$J,358.3,8916,0)
 ;;=I48.0^^45^430^15
 ;;^UTILITY(U,$J,358.3,8916,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8916,1,3,0)
 ;;=3^Paroxysmal Atrial Fibrillation
 ;;^UTILITY(U,$J,358.3,8916,1,4,0)
 ;;=4^I48.0
 ;;^UTILITY(U,$J,358.3,8916,2)
 ;;=^90473
 ;;^UTILITY(U,$J,358.3,8917,0)
 ;;=I49.5^^45^430^23
 ;;^UTILITY(U,$J,358.3,8917,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8917,1,3,0)
 ;;=3^Sick Sinus Syndrome
 ;;^UTILITY(U,$J,358.3,8917,1,4,0)
 ;;=4^I49.5
 ;;^UTILITY(U,$J,358.3,8917,2)
 ;;=^110404
 ;;^UTILITY(U,$J,358.3,8918,0)
 ;;=I49.8^^45^430^3
 ;;^UTILITY(U,$J,358.3,8918,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8918,1,3,0)
 ;;=3^Cardiac Arrhythmias
 ;;^UTILITY(U,$J,358.3,8918,1,4,0)
 ;;=4^I49.8
 ;;^UTILITY(U,$J,358.3,8918,2)
 ;;=^5007236
 ;;^UTILITY(U,$J,358.3,8919,0)
 ;;=I49.9^^45^430^2
 ;;^UTILITY(U,$J,358.3,8919,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8919,1,3,0)
 ;;=3^Cardiac Arrhythmia,Unspec
 ;;^UTILITY(U,$J,358.3,8919,1,4,0)
 ;;=4^I49.9
 ;;^UTILITY(U,$J,358.3,8919,2)
 ;;=^5007237
 ;;^UTILITY(U,$J,358.3,8920,0)
 ;;=R00.1^^45^430^1
 ;;^UTILITY(U,$J,358.3,8920,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8920,1,3,0)
 ;;=3^Bradycardia,Unspec
 ;;^UTILITY(U,$J,358.3,8920,1,4,0)
 ;;=4^R00.1
 ;;^UTILITY(U,$J,358.3,8920,2)
 ;;=^5019164
 ;;^UTILITY(U,$J,358.3,8921,0)
 ;;=I34.1^^45^430^14
 ;;^UTILITY(U,$J,358.3,8921,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8921,1,3,0)
 ;;=3^Nonrheumatic Mitral Valve Prolapse
 ;;^UTILITY(U,$J,358.3,8921,1,4,0)
 ;;=4^I34.1
 ;;^UTILITY(U,$J,358.3,8921,2)
 ;;=^5007170
 ;;^UTILITY(U,$J,358.3,8922,0)
 ;;=D68.4^^45^431^1
 ;;^UTILITY(U,$J,358.3,8922,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8922,1,3,0)
 ;;=3^Acquired Coagulation Factor Deficiency
 ;;^UTILITY(U,$J,358.3,8922,1,4,0)
 ;;=4^D68.4
 ;;^UTILITY(U,$J,358.3,8922,2)
 ;;=^2235
 ;;^UTILITY(U,$J,358.3,8923,0)
 ;;=D59.9^^45^431^2
 ;;^UTILITY(U,$J,358.3,8923,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8923,1,3,0)
 ;;=3^Acquired Hemolytic Anemia,Unspec
 ;;^UTILITY(U,$J,358.3,8923,1,4,0)
 ;;=4^D59.9
 ;;^UTILITY(U,$J,358.3,8923,2)
 ;;=^5002330
 ;;^UTILITY(U,$J,358.3,8924,0)
 ;;=C91.00^^45^431^5
 ;;^UTILITY(U,$J,358.3,8924,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8924,1,3,0)
 ;;=3^Acute Lymphoblastic Leukemia,Not in Remission
 ;;^UTILITY(U,$J,358.3,8924,1,4,0)
 ;;=4^C91.00
 ;;^UTILITY(U,$J,358.3,8924,2)
 ;;=^5001762
 ;;^UTILITY(U,$J,358.3,8925,0)
 ;;=C91.01^^45^431^4
 ;;^UTILITY(U,$J,358.3,8925,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8925,1,3,0)
 ;;=3^Acute Lymphoblastic Leukemia,In Remission
 ;;^UTILITY(U,$J,358.3,8925,1,4,0)
 ;;=4^C91.01
 ;;^UTILITY(U,$J,358.3,8925,2)
 ;;=^5001763
 ;;^UTILITY(U,$J,358.3,8926,0)
 ;;=C92.01^^45^431^7
 ;;^UTILITY(U,$J,358.3,8926,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8926,1,3,0)
 ;;=3^Acute Myeloblastic Leukemia,In Remission
 ;;^UTILITY(U,$J,358.3,8926,1,4,0)
 ;;=4^C92.01
 ;;^UTILITY(U,$J,358.3,8926,2)
 ;;=^5001790
 ;;^UTILITY(U,$J,358.3,8927,0)
 ;;=C92.00^^45^431^8
 ;;^UTILITY(U,$J,358.3,8927,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8927,1,3,0)
 ;;=3^Acute Myeloblastic Leukemia,Not in Remission
 ;;^UTILITY(U,$J,358.3,8927,1,4,0)
 ;;=4^C92.00
 ;;^UTILITY(U,$J,358.3,8927,2)
 ;;=^5001789
 ;;^UTILITY(U,$J,358.3,8928,0)
 ;;=C92.61^^45^431^9
 ;;^UTILITY(U,$J,358.3,8928,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8928,1,3,0)
 ;;=3^Acute Myeloid Leukemia w/ 11q23-Abnormality,In Remission
 ;;^UTILITY(U,$J,358.3,8928,1,4,0)
 ;;=4^C92.61
 ;;^UTILITY(U,$J,358.3,8928,2)
 ;;=^5001808
 ;;^UTILITY(U,$J,358.3,8929,0)
 ;;=C92.60^^45^431^10
 ;;^UTILITY(U,$J,358.3,8929,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8929,1,3,0)
 ;;=3^Acute Myeloid Leukemia w/ 11q23-Abnormality,Not in Remission
 ;;^UTILITY(U,$J,358.3,8929,1,4,0)
 ;;=4^C92.60
 ;;^UTILITY(U,$J,358.3,8929,2)
 ;;=^5001807
 ;;^UTILITY(U,$J,358.3,8930,0)
 ;;=C92.A1^^45^431^11
 ;;^UTILITY(U,$J,358.3,8930,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8930,1,3,0)
 ;;=3^Acute Myeloid Leukemia w/ Multilin Dysplasia,In Remission
 ;;^UTILITY(U,$J,358.3,8930,1,4,0)
 ;;=4^C92.A1
 ;;^UTILITY(U,$J,358.3,8930,2)
 ;;=^5001814
 ;;^UTILITY(U,$J,358.3,8931,0)
 ;;=C92.A0^^45^431^12
 ;;^UTILITY(U,$J,358.3,8931,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8931,1,3,0)
 ;;=3^Acute Myeloid Leukemia w/ Multilin Dysplasia,Not in Remission
 ;;^UTILITY(U,$J,358.3,8931,1,4,0)
 ;;=4^C92.A0
 ;;^UTILITY(U,$J,358.3,8931,2)
 ;;=^5001813
 ;;^UTILITY(U,$J,358.3,8932,0)
 ;;=C92.51^^45^431^13
 ;;^UTILITY(U,$J,358.3,8932,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8932,1,3,0)
 ;;=3^Acute Myelomonocytic Leukemia,In Remission
 ;;^UTILITY(U,$J,358.3,8932,1,4,0)
 ;;=4^C92.51
 ;;^UTILITY(U,$J,358.3,8932,2)
 ;;=^5001805
 ;;^UTILITY(U,$J,358.3,8933,0)
 ;;=C92.50^^45^431^14
 ;;^UTILITY(U,$J,358.3,8933,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8933,1,3,0)
 ;;=3^Acute Myelomonocytic Leukemia,Not in Remission
 ;;^UTILITY(U,$J,358.3,8933,1,4,0)
 ;;=4^C92.50
 ;;^UTILITY(U,$J,358.3,8933,2)
 ;;=^5001804
 ;;^UTILITY(U,$J,358.3,8934,0)
 ;;=C94.40^^45^431^17
 ;;^UTILITY(U,$J,358.3,8934,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8934,1,3,0)
 ;;=3^Acute Panmyelosis w/ Myelofibrosis,Not in Remission
 ;;^UTILITY(U,$J,358.3,8934,1,4,0)
 ;;=4^C94.40
 ;;^UTILITY(U,$J,358.3,8934,2)
 ;;=^5001843
 ;;^UTILITY(U,$J,358.3,8935,0)
 ;;=C94.42^^45^431^15
 ;;^UTILITY(U,$J,358.3,8935,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8935,1,3,0)
 ;;=3^Acute Panmyelosis w/ Myelofibrosis,In Relapse
 ;;^UTILITY(U,$J,358.3,8935,1,4,0)
 ;;=4^C94.42
 ;;^UTILITY(U,$J,358.3,8935,2)
 ;;=^5001845
 ;;^UTILITY(U,$J,358.3,8936,0)
 ;;=C94.41^^45^431^16
 ;;^UTILITY(U,$J,358.3,8936,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8936,1,3,0)
 ;;=3^Acute Panmyelosis w/ Myelofibrosis,In Remission
 ;;^UTILITY(U,$J,358.3,8936,1,4,0)
 ;;=4^C94.41
 ;;^UTILITY(U,$J,358.3,8936,2)
 ;;=^5001844
 ;;^UTILITY(U,$J,358.3,8937,0)
 ;;=D62.^^45^431^18
 ;;^UTILITY(U,$J,358.3,8937,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8937,1,3,0)
 ;;=3^Acute Posthemorrhagic Anemia
 ;;^UTILITY(U,$J,358.3,8937,1,4,0)
 ;;=4^D62.
 ;;^UTILITY(U,$J,358.3,8937,2)
 ;;=^267986
 ;;^UTILITY(U,$J,358.3,8938,0)
 ;;=C92.41^^45^431^19
 ;;^UTILITY(U,$J,358.3,8938,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8938,1,3,0)
 ;;=3^Acute Promyelocytic Leukemia,In Remission
 ;;^UTILITY(U,$J,358.3,8938,1,4,0)
 ;;=4^C92.41
 ;;^UTILITY(U,$J,358.3,8938,2)
 ;;=^5001802
 ;;^UTILITY(U,$J,358.3,8939,0)
 ;;=C92.40^^45^431^20
 ;;^UTILITY(U,$J,358.3,8939,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8939,1,3,0)
 ;;=3^Acute Promyelocytic Leukemia,Not in Remission
 ;;^UTILITY(U,$J,358.3,8939,1,4,0)
 ;;=4^C92.40
 ;;^UTILITY(U,$J,358.3,8939,2)
 ;;=^5001801
 ;;^UTILITY(U,$J,358.3,8940,0)
 ;;=D56.0^^45^431^21
 ;;^UTILITY(U,$J,358.3,8940,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8940,1,3,0)
 ;;=3^Alpha Thalassemia
 ;;^UTILITY(U,$J,358.3,8940,1,4,0)
 ;;=4^D56.0
 ;;^UTILITY(U,$J,358.3,8940,2)
 ;;=^340494
 ;;^UTILITY(U,$J,358.3,8941,0)
 ;;=D63.1^^45^431^23
 ;;^UTILITY(U,$J,358.3,8941,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8941,1,3,0)
 ;;=3^Anemia in Chronic Kidney Disease
 ;;^UTILITY(U,$J,358.3,8941,1,4,0)
 ;;=4^D63.1
 ;;^UTILITY(U,$J,358.3,8941,2)
 ;;=^332908
 ;;^UTILITY(U,$J,358.3,8942,0)
 ;;=D63.0^^45^431^24
 ;;^UTILITY(U,$J,358.3,8942,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8942,1,3,0)
 ;;=3^Anemia in Neoplastic Disease
