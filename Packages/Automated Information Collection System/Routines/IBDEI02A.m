IBDEI02A ; ; 01-MAY-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 01, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,5153,0)
 ;;=E09.618^^34^311^50
 ;;^UTILITY(U,$J,358.3,5153,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5153,1,3,0)
 ;;=3^Drug/chem diabetes w oth diabetic arthropathy
 ;;^UTILITY(U,$J,358.3,5153,1,4,0)
 ;;=4^E09.618
 ;;^UTILITY(U,$J,358.3,5153,2)
 ;;=^5002574
 ;;^UTILITY(U,$J,358.3,5154,0)
 ;;=E09.620^^34^311^33
 ;;^UTILITY(U,$J,358.3,5154,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5154,1,3,0)
 ;;=3^Drug/chem diabetes w diabetic dermatitis
 ;;^UTILITY(U,$J,358.3,5154,1,4,0)
 ;;=4^E09.620
 ;;^UTILITY(U,$J,358.3,5154,2)
 ;;=^5002575
 ;;^UTILITY(U,$J,358.3,5155,0)
 ;;=E09.622^^34^311^60
 ;;^UTILITY(U,$J,358.3,5155,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5155,1,3,0)
 ;;=3^Drug/chem induced diabetes mellitus w oth skin ulcer
 ;;^UTILITY(U,$J,358.3,5155,1,4,0)
 ;;=4^E09.622
 ;;^UTILITY(U,$J,358.3,5155,2)
 ;;=^5002577
 ;;^UTILITY(U,$J,358.3,5156,0)
 ;;=E09.621^^34^311^62
 ;;^UTILITY(U,$J,358.3,5156,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5156,1,3,0)
 ;;=3^Drug/chem induced diabetes mellitus with foot ulcer
 ;;^UTILITY(U,$J,358.3,5156,1,4,0)
 ;;=4^E09.621
 ;;^UTILITY(U,$J,358.3,5156,2)
 ;;=^5002576
 ;;^UTILITY(U,$J,358.3,5157,0)
 ;;=E09.628^^34^311^53
 ;;^UTILITY(U,$J,358.3,5157,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5157,1,3,0)
 ;;=3^Drug/chem diabetes w oth skin complications
 ;;^UTILITY(U,$J,358.3,5157,1,4,0)
 ;;=4^E09.628
 ;;^UTILITY(U,$J,358.3,5157,2)
 ;;=^5002578
 ;;^UTILITY(U,$J,358.3,5158,0)
 ;;=E09.630^^34^311^54
 ;;^UTILITY(U,$J,358.3,5158,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5158,1,3,0)
 ;;=3^Drug/chem diabetes w periodontal disease
 ;;^UTILITY(U,$J,358.3,5158,1,4,0)
 ;;=4^E09.630
 ;;^UTILITY(U,$J,358.3,5158,2)
 ;;=^5002579
 ;;^UTILITY(U,$J,358.3,5159,0)
 ;;=E09.638^^34^311^52
 ;;^UTILITY(U,$J,358.3,5159,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5159,1,3,0)
 ;;=3^Drug/chem diabetes w oth oral complications
 ;;^UTILITY(U,$J,358.3,5159,1,4,0)
 ;;=4^E09.638
 ;;^UTILITY(U,$J,358.3,5159,2)
 ;;=^5002580
 ;;^UTILITY(U,$J,358.3,5160,0)
 ;;=E09.65^^34^311^59
 ;;^UTILITY(U,$J,358.3,5160,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5160,1,3,0)
 ;;=3^Drug/chem induced diabetes mellitus w hyperglycemia
 ;;^UTILITY(U,$J,358.3,5160,1,4,0)
 ;;=4^E09.65
 ;;^UTILITY(U,$J,358.3,5160,2)
 ;;=^5002583
 ;;^UTILITY(U,$J,358.3,5161,0)
 ;;=E09.69^^34^311^49
 ;;^UTILITY(U,$J,358.3,5161,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5161,1,3,0)
 ;;=3^Drug/chem diabetes w oth complication
 ;;^UTILITY(U,$J,358.3,5161,1,4,0)
 ;;=4^E09.69
 ;;^UTILITY(U,$J,358.3,5161,2)
 ;;=^5002584
 ;;^UTILITY(U,$J,358.3,5162,0)
 ;;=E09.649^^34^311^39
 ;;^UTILITY(U,$J,358.3,5162,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5162,1,3,0)
 ;;=3^Drug/chem diabetes w hypoglycemia w/o coma
 ;;^UTILITY(U,$J,358.3,5162,1,4,0)
 ;;=4^E09.649
 ;;^UTILITY(U,$J,358.3,5162,2)
 ;;=^5002582
 ;;^UTILITY(U,$J,358.3,5163,0)
 ;;=E08.8^^34^311^30
 ;;^UTILITY(U,$J,358.3,5163,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5163,1,3,0)
 ;;=3^Diabetes due to underlying condition w unsp complications
 ;;^UTILITY(U,$J,358.3,5163,1,4,0)
 ;;=4^E08.8
 ;;^UTILITY(U,$J,358.3,5163,2)
 ;;=^5002543
 ;;^UTILITY(U,$J,358.3,5164,0)
 ;;=E09.8^^34^311^55
 ;;^UTILITY(U,$J,358.3,5164,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5164,1,3,0)
 ;;=3^Drug/chem diabetes w unsp complications
 ;;^UTILITY(U,$J,358.3,5164,1,4,0)
 ;;=4^E09.8
 ;;^UTILITY(U,$J,358.3,5164,2)
 ;;=^5002585
 ;;^UTILITY(U,$J,358.3,5165,0)
 ;;=E88.01^^34^312^13
 ;;^UTILITY(U,$J,358.3,5165,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5165,1,3,0)
 ;;=3^Alpha-1-antitrypsin deficiency
 ;;^UTILITY(U,$J,358.3,5165,1,4,0)
 ;;=4^E88.01
 ;;^UTILITY(U,$J,358.3,5165,2)
 ;;=^331442
 ;;^UTILITY(U,$J,358.3,5166,0)
 ;;=E71.310^^34^312^70
 ;;^UTILITY(U,$J,358.3,5166,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5166,1,3,0)
 ;;=3^Long chain/very long chain acyl CoA dehydrogenase deficiency
 ;;^UTILITY(U,$J,358.3,5166,1,4,0)
 ;;=4^E71.310
 ;;^UTILITY(U,$J,358.3,5166,2)
 ;;=^5002870
 ;;^UTILITY(U,$J,358.3,5167,0)
 ;;=E71.311^^34^312^76
 ;;^UTILITY(U,$J,358.3,5167,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5167,1,3,0)
 ;;=3^Medium chain acyl CoA dehydrogenase deficiency
 ;;^UTILITY(U,$J,358.3,5167,1,4,0)
 ;;=4^E71.311
 ;;^UTILITY(U,$J,358.3,5167,2)
 ;;=^5002871
 ;;^UTILITY(U,$J,358.3,5168,0)
 ;;=E71.312^^34^312^99
 ;;^UTILITY(U,$J,358.3,5168,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5168,1,3,0)
 ;;=3^Short chain acyl CoA dehydrogenase deficiency
 ;;^UTILITY(U,$J,358.3,5168,1,4,0)
 ;;=4^E71.312
 ;;^UTILITY(U,$J,358.3,5168,2)
 ;;=^5002872
 ;;^UTILITY(U,$J,358.3,5169,0)
 ;;=E71.313^^34^312^48
 ;;^UTILITY(U,$J,358.3,5169,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5169,1,3,0)
 ;;=3^Glutaric aciduria type II
 ;;^UTILITY(U,$J,358.3,5169,1,4,0)
 ;;=4^E71.313
 ;;^UTILITY(U,$J,358.3,5169,2)
 ;;=^5002873
 ;;^UTILITY(U,$J,358.3,5170,0)
 ;;=E71.314^^34^312^82
 ;;^UTILITY(U,$J,358.3,5170,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5170,1,3,0)
 ;;=3^Muscle carnitine palmitoyltransferase deficiency
 ;;^UTILITY(U,$J,358.3,5170,1,4,0)
 ;;=4^E71.314
 ;;^UTILITY(U,$J,358.3,5170,2)
 ;;=^5002874
 ;;^UTILITY(U,$J,358.3,5171,0)
 ;;=E71.318^^34^312^39
 ;;^UTILITY(U,$J,358.3,5171,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5171,1,3,0)
 ;;=3^Fatty-Acid Oxidation Disorders NEC
 ;;^UTILITY(U,$J,358.3,5171,1,4,0)
 ;;=4^E71.318
 ;;^UTILITY(U,$J,358.3,5171,2)
 ;;=^5002875
 ;;^UTILITY(U,$J,358.3,5172,0)
 ;;=E71.50^^34^312^89
 ;;^UTILITY(U,$J,358.3,5172,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5172,1,3,0)
 ;;=3^Peroxisomal disorder, unspecified
 ;;^UTILITY(U,$J,358.3,5172,1,4,0)
 ;;=4^E71.50
 ;;^UTILITY(U,$J,358.3,5172,2)
 ;;=^5002880
 ;;^UTILITY(U,$J,358.3,5173,0)
 ;;=E71.510^^34^312^114
 ;;^UTILITY(U,$J,358.3,5173,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5173,1,3,0)
 ;;=3^Zellweger syndrome
 ;;^UTILITY(U,$J,358.3,5173,1,4,0)
 ;;=4^E71.510
 ;;^UTILITY(U,$J,358.3,5173,2)
 ;;=^128776
 ;;^UTILITY(U,$J,358.3,5174,0)
 ;;=E71.522^^34^312^11
 ;;^UTILITY(U,$J,358.3,5174,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5174,1,3,0)
 ;;=3^Adrenomyeloneuropathy
 ;;^UTILITY(U,$J,358.3,5174,1,4,0)
 ;;=4^E71.522
 ;;^UTILITY(U,$J,358.3,5174,2)
 ;;=^276921
 ;;^UTILITY(U,$J,358.3,5175,0)
 ;;=E71.529^^34^312^113
 ;;^UTILITY(U,$J,358.3,5175,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5175,1,3,0)
 ;;=3^X-linked adrenoleukodystrophy, unspecified type
 ;;^UTILITY(U,$J,358.3,5175,1,4,0)
 ;;=4^E71.529
 ;;^UTILITY(U,$J,358.3,5175,2)
 ;;=^5002886
 ;;^UTILITY(U,$J,358.3,5176,0)
 ;;=E71.548^^34^312^90
 ;;^UTILITY(U,$J,358.3,5176,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5176,1,3,0)
 ;;=3^Peroxisomal disorders NEC
 ;;^UTILITY(U,$J,358.3,5176,1,4,0)
 ;;=4^E71.548
 ;;^UTILITY(U,$J,358.3,5176,2)
 ;;=^5002891
 ;;^UTILITY(U,$J,358.3,5177,0)
 ;;=E88.40^^34^312^78
 ;;^UTILITY(U,$J,358.3,5177,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5177,1,3,0)
 ;;=3^Mitochondrial metabolism disorder, unspecified
 ;;^UTILITY(U,$J,358.3,5177,1,4,0)
 ;;=4^E88.40
 ;;^UTILITY(U,$J,358.3,5177,2)
 ;;=^5003030
 ;;^UTILITY(U,$J,358.3,5178,0)
 ;;=E88.41^^34^312^72
 ;;^UTILITY(U,$J,358.3,5178,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5178,1,3,0)
 ;;=3^MELAS syndrome
 ;;^UTILITY(U,$J,358.3,5178,1,4,0)
 ;;=4^E88.41
 ;;^UTILITY(U,$J,358.3,5178,2)
 ;;=^278244
 ;;^UTILITY(U,$J,358.3,5179,0)
 ;;=E88.42^^34^312^73
 ;;^UTILITY(U,$J,358.3,5179,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5179,1,3,0)
 ;;=3^MERRF syndrome
 ;;^UTILITY(U,$J,358.3,5179,1,4,0)
 ;;=4^E88.42
 ;;^UTILITY(U,$J,358.3,5179,2)
 ;;=^278246
 ;;^UTILITY(U,$J,358.3,5180,0)
 ;;=E88.49^^34^312^79
 ;;^UTILITY(U,$J,358.3,5180,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5180,1,3,0)
 ;;=3^Mitochondrial metabolism disorders NEC
 ;;^UTILITY(U,$J,358.3,5180,1,4,0)
 ;;=4^E88.49
 ;;^UTILITY(U,$J,358.3,5180,2)
 ;;=^5003031
 ;;^UTILITY(U,$J,358.3,5181,0)
 ;;=H49.819^^34^312^63
 ;;^UTILITY(U,$J,358.3,5181,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5181,1,3,0)
 ;;=3^Kearns-Sayre syndrome, unspecified eye
 ;;^UTILITY(U,$J,358.3,5181,1,4,0)
 ;;=4^H49.819
 ;;^UTILITY(U,$J,358.3,5181,2)
 ;;=^5006202
 ;;^UTILITY(U,$J,358.3,5182,0)
 ;;=E66.9^^34^312^85
 ;;^UTILITY(U,$J,358.3,5182,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5182,1,3,0)
 ;;=3^Obesity, unspecified
 ;;^UTILITY(U,$J,358.3,5182,1,4,0)
 ;;=4^E66.9
 ;;^UTILITY(U,$J,358.3,5182,2)
 ;;=^5002832
 ;;^UTILITY(U,$J,358.3,5183,0)
 ;;=E66.01^^34^312^81
 ;;^UTILITY(U,$J,358.3,5183,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5183,1,3,0)
 ;;=3^Morbid (severe) obesity due to excess calories
 ;;^UTILITY(U,$J,358.3,5183,1,4,0)
 ;;=4^E66.01
 ;;^UTILITY(U,$J,358.3,5183,2)
 ;;=^5002826
 ;;^UTILITY(U,$J,358.3,5184,0)
 ;;=F51.02^^34^312^10
 ;;^UTILITY(U,$J,358.3,5184,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5184,1,3,0)
 ;;=3^Adjustment insomnia
 ;;^UTILITY(U,$J,358.3,5184,1,4,0)
 ;;=4^F51.02
 ;;^UTILITY(U,$J,358.3,5184,2)
 ;;=^5003604
 ;;^UTILITY(U,$J,358.3,5185,0)
 ;;=F32.9^^34^312^74
 ;;^UTILITY(U,$J,358.3,5185,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5185,1,3,0)
 ;;=3^Major depressive disorder, single episode, unspecified
 ;;^UTILITY(U,$J,358.3,5185,1,4,0)
 ;;=4^F32.9
 ;;^UTILITY(U,$J,358.3,5185,2)
 ;;=^5003528
 ;;^UTILITY(U,$J,358.3,5186,0)
 ;;=H53.9^^34^312^111
 ;;^UTILITY(U,$J,358.3,5186,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5186,1,3,0)
 ;;=3^Visual Disturbance,Unspec
 ;;^UTILITY(U,$J,358.3,5186,1,4,0)
 ;;=4^H53.9
 ;;^UTILITY(U,$J,358.3,5186,2)
 ;;=^124001
 ;;^UTILITY(U,$J,358.3,5187,0)
 ;;=H91.91^^34^312^53
 ;;^UTILITY(U,$J,358.3,5187,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5187,1,3,0)
 ;;=3^Hearing Loss,Right Ear,Unspec
 ;;^UTILITY(U,$J,358.3,5187,1,4,0)
 ;;=4^H91.91
 ;;^UTILITY(U,$J,358.3,5187,2)
 ;;=^5133553
 ;;^UTILITY(U,$J,358.3,5188,0)
 ;;=H91.92^^34^312^52
 ;;^UTILITY(U,$J,358.3,5188,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5188,1,3,0)
 ;;=3^Hearing Loss,Left Ear,Unspec
 ;;^UTILITY(U,$J,358.3,5188,1,4,0)
 ;;=4^H91.92
 ;;^UTILITY(U,$J,358.3,5188,2)
 ;;=^5133554
 ;;^UTILITY(U,$J,358.3,5189,0)
 ;;=H91.93^^34^312^51
 ;;^UTILITY(U,$J,358.3,5189,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5189,1,3,0)
 ;;=3^Hearing Loss,Bilateral,Unspec
 ;;^UTILITY(U,$J,358.3,5189,1,4,0)
 ;;=4^H91.93
 ;;^UTILITY(U,$J,358.3,5189,2)
 ;;=^5006944
 ;;^UTILITY(U,$J,358.3,5190,0)
 ;;=I08.0^^34^312^98
 ;;^UTILITY(U,$J,358.3,5190,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5190,1,3,0)
 ;;=3^Rheumatic disorders of both mitral and aortic valves
 ;;^UTILITY(U,$J,358.3,5190,1,4,0)
 ;;=4^I08.0
 ;;^UTILITY(U,$J,358.3,5190,2)
 ;;=^5007052
 ;;^UTILITY(U,$J,358.3,5191,0)
 ;;=I89.0^^34^312^71
 ;;^UTILITY(U,$J,358.3,5191,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5191,1,3,0)
 ;;=3^Lymphedema, not elsewhere classified
 ;;^UTILITY(U,$J,358.3,5191,1,4,0)
 ;;=4^I89.0
 ;;^UTILITY(U,$J,358.3,5191,2)
 ;;=^5008073
 ;;^UTILITY(U,$J,358.3,5192,0)
 ;;=I87.1^^34^312^29
 ;;^UTILITY(U,$J,358.3,5192,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5192,1,3,0)
 ;;=3^Compression of vein
 ;;^UTILITY(U,$J,358.3,5192,1,4,0)
 ;;=4^I87.1
 ;;^UTILITY(U,$J,358.3,5192,2)
 ;;=^269850
 ;;^UTILITY(U,$J,358.3,5193,0)
 ;;=J44.0^^34^312^25
 ;;^UTILITY(U,$J,358.3,5193,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5193,1,3,0)
 ;;=3^Chronic obstructive pulmon disease w acute lower resp infct
 ;;^UTILITY(U,$J,358.3,5193,1,4,0)
 ;;=4^J44.0
 ;;^UTILITY(U,$J,358.3,5193,2)
 ;;=^5008239
 ;;^UTILITY(U,$J,358.3,5194,0)
 ;;=J98.6^^34^312^33
 ;;^UTILITY(U,$J,358.3,5194,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5194,1,3,0)
 ;;=3^Disorders of diaphragm
 ;;^UTILITY(U,$J,358.3,5194,1,4,0)
 ;;=4^J98.6
 ;;^UTILITY(U,$J,358.3,5194,2)
 ;;=^5008364
 ;;^UTILITY(U,$J,358.3,5195,0)
 ;;=K08.109^^34^312^28
 ;;^UTILITY(U,$J,358.3,5195,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5195,1,3,0)
 ;;=3^Complete loss of teeth, unspecified cause, unspecified class
 ;;^UTILITY(U,$J,358.3,5195,1,4,0)
 ;;=4^K08.109
 ;;^UTILITY(U,$J,358.3,5195,2)
 ;;=^5008410
 ;;^UTILITY(U,$J,358.3,5196,0)
 ;;=K59.00^^34^312^30
 ;;^UTILITY(U,$J,358.3,5196,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5196,1,3,0)
 ;;=3^Constipation, unspecified
 ;;^UTILITY(U,$J,358.3,5196,1,4,0)
 ;;=4^K59.00
 ;;^UTILITY(U,$J,358.3,5196,2)
 ;;=^323537
 ;;^UTILITY(U,$J,358.3,5197,0)
 ;;=N39.0^^34^312^110
 ;;^UTILITY(U,$J,358.3,5197,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5197,1,3,0)
 ;;=3^Urinary tract infection, site not specified
 ;;^UTILITY(U,$J,358.3,5197,1,4,0)
 ;;=4^N39.0
 ;;^UTILITY(U,$J,358.3,5197,2)
 ;;=^124436
 ;;^UTILITY(U,$J,358.3,5198,0)
 ;;=N39.3^^34^312^103
 ;;^UTILITY(U,$J,358.3,5198,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5198,1,3,0)
 ;;=3^Stress incontinence (female) (male)
 ;;^UTILITY(U,$J,358.3,5198,1,4,0)
 ;;=4^N39.3
 ;;^UTILITY(U,$J,358.3,5198,2)
 ;;=^5015679
 ;;^UTILITY(U,$J,358.3,5199,0)
 ;;=L60.0^^34^312^60
 ;;^UTILITY(U,$J,358.3,5199,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5199,1,3,0)
 ;;=3^Ingrowing nail
 ;;^UTILITY(U,$J,358.3,5199,1,4,0)
 ;;=4^L60.0
 ;;^UTILITY(U,$J,358.3,5199,2)
 ;;=^5009234
 ;;^UTILITY(U,$J,358.3,5200,0)
 ;;=R26.2^^34^312^32
 ;;^UTILITY(U,$J,358.3,5200,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5200,1,3,0)
 ;;=3^Difficulty in walking, not elsewhere classified
 ;;^UTILITY(U,$J,358.3,5200,1,4,0)
 ;;=4^R26.2
 ;;^UTILITY(U,$J,358.3,5200,2)
 ;;=^5019306
 ;;^UTILITY(U,$J,358.3,5201,0)
 ;;=R40.20^^34^312^27
 ;;^UTILITY(U,$J,358.3,5201,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5201,1,3,0)
 ;;=3^Coma,Unspec
 ;;^UTILITY(U,$J,358.3,5201,1,4,0)
 ;;=4^R40.20
 ;;^UTILITY(U,$J,358.3,5201,2)
 ;;=^5019354
 ;;^UTILITY(U,$J,358.3,5202,0)
 ;;=R40.4^^34^312^108
 ;;^UTILITY(U,$J,358.3,5202,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5202,1,3,0)
 ;;=3^Transient alteration of awareness
 ;;^UTILITY(U,$J,358.3,5202,1,4,0)
 ;;=4^R40.4
 ;;^UTILITY(U,$J,358.3,5202,2)
 ;;=^5019435
 ;;^UTILITY(U,$J,358.3,5203,0)
 ;;=R44.3^^34^312^50
 ;;^UTILITY(U,$J,358.3,5203,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5203,1,3,0)
 ;;=3^Hallucinations, unspecified
 ;;^UTILITY(U,$J,358.3,5203,1,4,0)
 ;;=4^R44.3
 ;;^UTILITY(U,$J,358.3,5203,2)
 ;;=^5019458
 ;;^UTILITY(U,$J,358.3,5204,0)
 ;;=R44.0^^34^312^20
 ;;^UTILITY(U,$J,358.3,5204,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5204,1,3,0)
 ;;=3^Auditory hallucinations
 ;;^UTILITY(U,$J,358.3,5204,1,4,0)
 ;;=4^R44.0
 ;;^UTILITY(U,$J,358.3,5204,2)
 ;;=^5019455
 ;;^UTILITY(U,$J,358.3,5205,0)
 ;;=R44.2^^34^312^49
 ;;^UTILITY(U,$J,358.3,5205,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5205,1,3,0)
 ;;=3^Hallucinations NEC
 ;;^UTILITY(U,$J,358.3,5205,1,4,0)
 ;;=4^R44.2
 ;;^UTILITY(U,$J,358.3,5205,2)
 ;;=^5019457
 ;;^UTILITY(U,$J,358.3,5206,0)
 ;;=G47.30^^34^312^100
 ;;^UTILITY(U,$J,358.3,5206,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5206,1,3,0)
 ;;=3^Sleep apnea, unspecified
 ;;^UTILITY(U,$J,358.3,5206,1,4,0)
 ;;=4^G47.30
 ;;^UTILITY(U,$J,358.3,5206,2)
 ;;=^5003977
 ;;^UTILITY(U,$J,358.3,5207,0)
 ;;=R53.82^^34^312^24
 ;;^UTILITY(U,$J,358.3,5207,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5207,1,3,0)
 ;;=3^Chronic fatigue, unspecified
 ;;^UTILITY(U,$J,358.3,5207,1,4,0)
 ;;=4^R53.82
 ;;^UTILITY(U,$J,358.3,5207,2)
 ;;=^5019519
 ;;^UTILITY(U,$J,358.3,5208,0)
 ;;=R53.81^^34^312^75
 ;;^UTILITY(U,$J,358.3,5208,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5208,1,3,0)
 ;;=3^Malaise NEC
 ;;^UTILITY(U,$J,358.3,5208,1,4,0)
 ;;=4^R53.81
 ;;^UTILITY(U,$J,358.3,5208,2)
 ;;=^5019518
 ;;^UTILITY(U,$J,358.3,5209,0)
 ;;=R53.83^^34^312^38
 ;;^UTILITY(U,$J,358.3,5209,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5209,1,3,0)
 ;;=3^Fatigue NEC
 ;;^UTILITY(U,$J,358.3,5209,1,4,0)
 ;;=4^R53.83
 ;;^UTILITY(U,$J,358.3,5209,2)
 ;;=^5019520
 ;;^UTILITY(U,$J,358.3,5210,0)
 ;;=R61.^^34^312^47
 ;;^UTILITY(U,$J,358.3,5210,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5210,1,3,0)
 ;;=3^Generalized hyperhidrosis
 ;;^UTILITY(U,$J,358.3,5210,1,4,0)
 ;;=4^R61.
 ;;^UTILITY(U,$J,358.3,5210,2)
 ;;=^331970
 ;;^UTILITY(U,$J,358.3,5211,0)
 ;;=R41.82^^34^312^14
 ;;^UTILITY(U,$J,358.3,5211,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5211,1,3,0)
 ;;=3^Altered mental status, unspecified
 ;;^UTILITY(U,$J,358.3,5211,1,4,0)
 ;;=4^R41.82
 ;;^UTILITY(U,$J,358.3,5211,2)
 ;;=^5019441
 ;;^UTILITY(U,$J,358.3,5212,0)
 ;;=R27.9^^34^312^64
 ;;^UTILITY(U,$J,358.3,5212,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5212,1,3,0)
 ;;=3^Lack of Coordination,Unspec
 ;;^UTILITY(U,$J,358.3,5212,1,4,0)
 ;;=4^R27.9
 ;;^UTILITY(U,$J,358.3,5212,2)
 ;;=^5019312
 ;;^UTILITY(U,$J,358.3,5213,0)
 ;;=R27.0^^34^312^19
 ;;^UTILITY(U,$J,358.3,5213,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5213,1,3,0)
 ;;=3^Ataxia, unspecified
 ;;^UTILITY(U,$J,358.3,5213,1,4,0)
 ;;=4^R27.0
 ;;^UTILITY(U,$J,358.3,5213,2)
 ;;=^5019310
 ;;^UTILITY(U,$J,358.3,5214,0)
 ;;=R29.5^^34^312^109
 ;;^UTILITY(U,$J,358.3,5214,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5214,1,3,0)
 ;;=3^Transient paralysis
 ;;^UTILITY(U,$J,358.3,5214,1,4,0)
 ;;=4^R29.5
 ;;^UTILITY(U,$J,358.3,5214,2)
 ;;=^5019316
 ;;^UTILITY(U,$J,358.3,5215,0)
 ;;=R68.3^^34^312^26
 ;;^UTILITY(U,$J,358.3,5215,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5215,1,3,0)
 ;;=3^Clubbing of fingers
 ;;^UTILITY(U,$J,358.3,5215,1,4,0)
 ;;=4^R68.3
 ;;^UTILITY(U,$J,358.3,5215,2)
 ;;=^5019553
 ;;^UTILITY(U,$J,358.3,5216,0)
 ;;=R29.1^^34^312^77
 ;;^UTILITY(U,$J,358.3,5216,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5216,1,3,0)
 ;;=3^Meningismus
 ;;^UTILITY(U,$J,358.3,5216,1,4,0)
 ;;=4^R29.1
 ;;^UTILITY(U,$J,358.3,5216,2)
 ;;=^5019313
 ;;^UTILITY(U,$J,358.3,5217,0)
 ;;=R29.0^^34^312^107
 ;;^UTILITY(U,$J,358.3,5217,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5217,1,3,0)
 ;;=3^Tetany
 ;;^UTILITY(U,$J,358.3,5217,1,4,0)
 ;;=4^R29.0
 ;;^UTILITY(U,$J,358.3,5217,2)
 ;;=^118032
 ;;^UTILITY(U,$J,358.3,5218,0)
 ;;=R21.^^34^312^96
 ;;^UTILITY(U,$J,358.3,5218,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5218,1,3,0)
 ;;=3^Rash and other nonspecific skin eruption
 ;;^UTILITY(U,$J,358.3,5218,1,4,0)
 ;;=4^R21.
 ;;^UTILITY(U,$J,358.3,5218,2)
 ;;=^5019283
 ;;^UTILITY(U,$J,358.3,5219,0)
 ;;=R22.9^^34^312^69
 ;;^UTILITY(U,$J,358.3,5219,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5219,1,3,0)
 ;;=3^Localized swelling, mass and lump, unspecified
 ;;^UTILITY(U,$J,358.3,5219,1,4,0)
 ;;=4^R22.9
 ;;^UTILITY(U,$J,358.3,5219,2)
 ;;=^5019292
 ;;^UTILITY(U,$J,358.3,5220,0)
 ;;=R60.9^^34^312^35
 ;;^UTILITY(U,$J,358.3,5220,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5220,1,3,0)
 ;;=3^Edema, unspecified
 ;;^UTILITY(U,$J,358.3,5220,1,4,0)
 ;;=4^R60.9
 ;;^UTILITY(U,$J,358.3,5220,2)
 ;;=^5019534
 ;;^UTILITY(U,$J,358.3,5221,0)
 ;;=R60.1^^34^312^46
 ;;^UTILITY(U,$J,358.3,5221,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5221,1,3,0)
 ;;=3^Generalized edema
 ;;^UTILITY(U,$J,358.3,5221,1,4,0)
 ;;=4^R60.1
 ;;^UTILITY(U,$J,358.3,5221,2)
 ;;=^5019533
 ;;^UTILITY(U,$J,358.3,5222,0)
 ;;=R60.0^^34^312^65
 ;;^UTILITY(U,$J,358.3,5222,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5222,1,3,0)
 ;;=3^Localized edema
