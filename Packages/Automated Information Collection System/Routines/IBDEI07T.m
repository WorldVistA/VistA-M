IBDEI07T ; ; 12-MAY-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,7735,1,4,0)
 ;;=4^Z97.12
 ;;^UTILITY(U,$J,358.3,7735,2)
 ;;=^5063723
 ;;^UTILITY(U,$J,358.3,7736,0)
 ;;=Z97.13^^42^499^136
 ;;^UTILITY(U,$J,358.3,7736,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7736,1,3,0)
 ;;=3^Presence of Right Artificial Leg
 ;;^UTILITY(U,$J,358.3,7736,1,4,0)
 ;;=4^Z97.13
 ;;^UTILITY(U,$J,358.3,7736,2)
 ;;=^5063724
 ;;^UTILITY(U,$J,358.3,7737,0)
 ;;=Z97.14^^42^499^131
 ;;^UTILITY(U,$J,358.3,7737,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7737,1,3,0)
 ;;=3^Presence of Left Artificial Leg
 ;;^UTILITY(U,$J,358.3,7737,1,4,0)
 ;;=4^Z97.14
 ;;^UTILITY(U,$J,358.3,7737,2)
 ;;=^5063725
 ;;^UTILITY(U,$J,358.3,7738,0)
 ;;=Z97.15^^42^499^123
 ;;^UTILITY(U,$J,358.3,7738,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7738,1,3,0)
 ;;=3^Presence of Bilateral Artificial Arms
 ;;^UTILITY(U,$J,358.3,7738,1,4,0)
 ;;=4^Z97.15
 ;;^UTILITY(U,$J,358.3,7738,2)
 ;;=^5063726
 ;;^UTILITY(U,$J,358.3,7739,0)
 ;;=Z97.16^^42^499^124
 ;;^UTILITY(U,$J,358.3,7739,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7739,1,3,0)
 ;;=3^Presence of Bilateral Artificial Legs
 ;;^UTILITY(U,$J,358.3,7739,1,4,0)
 ;;=4^Z97.16
 ;;^UTILITY(U,$J,358.3,7739,2)
 ;;=^5063727
 ;;^UTILITY(U,$J,358.3,7740,0)
 ;;=Z98.61^^42^499^17
 ;;^UTILITY(U,$J,358.3,7740,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7740,1,3,0)
 ;;=3^Coronary Angioplasty Status
 ;;^UTILITY(U,$J,358.3,7740,1,4,0)
 ;;=4^Z98.61
 ;;^UTILITY(U,$J,358.3,7740,2)
 ;;=^5063742
 ;;^UTILITY(U,$J,358.3,7741,0)
 ;;=Z98.62^^42^499^73
 ;;^UTILITY(U,$J,358.3,7741,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7741,1,3,0)
 ;;=3^Peripheral Vascular Angioplasty Status
 ;;^UTILITY(U,$J,358.3,7741,1,4,0)
 ;;=4^Z98.62
 ;;^UTILITY(U,$J,358.3,7741,2)
 ;;=^5063743
 ;;^UTILITY(U,$J,358.3,7742,0)
 ;;=Z98.84^^42^499^12
 ;;^UTILITY(U,$J,358.3,7742,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7742,1,3,0)
 ;;=3^Bariatric Surgery Status
 ;;^UTILITY(U,$J,358.3,7742,1,4,0)
 ;;=4^Z98.84
 ;;^UTILITY(U,$J,358.3,7742,2)
 ;;=^5063749
 ;;^UTILITY(U,$J,358.3,7743,0)
 ;;=Z99.2^^42^499^141
 ;;^UTILITY(U,$J,358.3,7743,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7743,1,3,0)
 ;;=3^Renal Dialysis Dependence
 ;;^UTILITY(U,$J,358.3,7743,1,4,0)
 ;;=4^Z99.2
 ;;^UTILITY(U,$J,358.3,7743,2)
 ;;=^5063758
 ;;^UTILITY(U,$J,358.3,7744,0)
 ;;=Z99.81^^42^499^144
 ;;^UTILITY(U,$J,358.3,7744,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7744,1,3,0)
 ;;=3^Supplemental Oxygen Dependence
 ;;^UTILITY(U,$J,358.3,7744,1,4,0)
 ;;=4^Z99.81
 ;;^UTILITY(U,$J,358.3,7744,2)
 ;;=^5063760
 ;;^UTILITY(U,$J,358.3,7745,0)
 ;;=Z90.79^^42^499^2
 ;;^UTILITY(U,$J,358.3,7745,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7745,1,3,0)
 ;;=3^Acquired Absence of Genital Organs NEC
 ;;^UTILITY(U,$J,358.3,7745,1,4,0)
 ;;=4^Z90.79
 ;;^UTILITY(U,$J,358.3,7745,2)
 ;;=^5063596
 ;;^UTILITY(U,$J,358.3,7746,0)
 ;;=Z90.5^^42^499^3
 ;;^UTILITY(U,$J,358.3,7746,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7746,1,3,0)
 ;;=3^Acquired Absence of Kidney
 ;;^UTILITY(U,$J,358.3,7746,1,4,0)
 ;;=4^Z90.5
 ;;^UTILITY(U,$J,358.3,7746,2)
 ;;=^5063590
 ;;^UTILITY(U,$J,358.3,7747,0)
 ;;=Z90.2^^42^499^6
 ;;^UTILITY(U,$J,358.3,7747,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7747,1,3,0)
 ;;=3^Acquired Absence of Lung (part of)
 ;;^UTILITY(U,$J,358.3,7747,1,4,0)
 ;;=4^Z90.2
 ;;^UTILITY(U,$J,358.3,7747,2)
 ;;=^5063585
 ;;^UTILITY(U,$J,358.3,7748,0)
 ;;=Z98.1^^42^499^10
 ;;^UTILITY(U,$J,358.3,7748,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7748,1,3,0)
 ;;=3^Arthrodesis Status
 ;;^UTILITY(U,$J,358.3,7748,1,4,0)
 ;;=4^Z98.1
 ;;^UTILITY(U,$J,358.3,7748,2)
 ;;=^5063734
 ;;^UTILITY(U,$J,358.3,7749,0)
 ;;=Z94.7^^42^499^16
 ;;^UTILITY(U,$J,358.3,7749,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7749,1,3,0)
 ;;=3^Corneal Transplant Status
 ;;^UTILITY(U,$J,358.3,7749,1,4,0)
 ;;=4^Z94.7
 ;;^UTILITY(U,$J,358.3,7749,2)
 ;;=^5063661
 ;;^UTILITY(U,$J,358.3,7750,0)
 ;;=Z83.511^^42^499^30
 ;;^UTILITY(U,$J,358.3,7750,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7750,1,3,0)
 ;;=3^Family Hx of Glaucoma
 ;;^UTILITY(U,$J,358.3,7750,1,4,0)
 ;;=4^Z83.511
 ;;^UTILITY(U,$J,358.3,7750,2)
 ;;=^5063382
 ;;^UTILITY(U,$J,358.3,7751,0)
 ;;=Z80.52^^42^499^33
 ;;^UTILITY(U,$J,358.3,7751,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7751,1,3,0)
 ;;=3^Family Hx of Malig Neop of Baldder
 ;;^UTILITY(U,$J,358.3,7751,1,4,0)
 ;;=4^Z80.52
 ;;^UTILITY(U,$J,358.3,7751,2)
 ;;=^5063352
 ;;^UTILITY(U,$J,358.3,7752,0)
 ;;=Z80.51^^42^499^36
 ;;^UTILITY(U,$J,358.3,7752,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7752,1,3,0)
 ;;=3^Family Hx of Malig Neop of Kidney
 ;;^UTILITY(U,$J,358.3,7752,1,4,0)
 ;;=4^Z80.51
 ;;^UTILITY(U,$J,358.3,7752,2)
 ;;=^321159
 ;;^UTILITY(U,$J,358.3,7753,0)
 ;;=Z83.41^^42^499^43
 ;;^UTILITY(U,$J,358.3,7753,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7753,1,3,0)
 ;;=3^Family Hx of Mult Endocrine Neoplasia Syndrome
 ;;^UTILITY(U,$J,358.3,7753,1,4,0)
 ;;=4^Z83.41
 ;;^UTILITY(U,$J,358.3,7753,2)
 ;;=^5063380
 ;;^UTILITY(U,$J,358.3,7754,0)
 ;;=Z81.8^^42^499^50
 ;;^UTILITY(U,$J,358.3,7754,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7754,1,3,0)
 ;;=3^Family Hx of Substance Abuse/Dependence,Psychoactive
 ;;^UTILITY(U,$J,358.3,7754,1,4,0)
 ;;=4^Z81.8
 ;;^UTILITY(U,$J,358.3,7754,2)
 ;;=^5063363
 ;;^UTILITY(U,$J,358.3,7755,0)
 ;;=Z81.4^^42^499^51
 ;;^UTILITY(U,$J,358.3,7755,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7755,1,3,0)
 ;;=3^Family Hx of Substance Abuse/Dependence NEC
 ;;^UTILITY(U,$J,358.3,7755,1,4,0)
 ;;=4^Z81.4
 ;;^UTILITY(U,$J,358.3,7755,2)
 ;;=^5063362
 ;;^UTILITY(U,$J,358.3,7756,0)
 ;;=Z98.0^^42^499^62
 ;;^UTILITY(U,$J,358.3,7756,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7756,1,3,0)
 ;;=3^Intestinal Bypass/Anastomosis Status
 ;;^UTILITY(U,$J,358.3,7756,1,4,0)
 ;;=4^Z98.0
 ;;^UTILITY(U,$J,358.3,7756,2)
 ;;=^5063733
 ;;^UTILITY(U,$J,358.3,7757,0)
 ;;=Z91.128^^42^499^61
 ;;^UTILITY(U,$J,358.3,7757,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7757,1,3,0)
 ;;=3^Intentional Underdose of Meds d/t Other Reasons
 ;;^UTILITY(U,$J,358.3,7757,1,4,0)
 ;;=4^Z91.128
 ;;^UTILITY(U,$J,358.3,7757,2)
 ;;=^5063613
 ;;^UTILITY(U,$J,358.3,7758,0)
 ;;=Z77.120^^42^499^67
 ;;^UTILITY(U,$J,358.3,7758,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7758,1,3,0)
 ;;=3^Mold (Toxic) Contact/Exposure
 ;;^UTILITY(U,$J,358.3,7758,1,4,0)
 ;;=4^Z77.120
 ;;^UTILITY(U,$J,358.3,7758,2)
 ;;=^5063318
 ;;^UTILITY(U,$J,358.3,7759,0)
 ;;=Z86.74^^42^499^110
 ;;^UTILITY(U,$J,358.3,7759,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7759,1,3,0)
 ;;=3^Personal Hx of Sudden Cardiac Arrest 
 ;;^UTILITY(U,$J,358.3,7759,1,4,0)
 ;;=4^Z86.74
 ;;^UTILITY(U,$J,358.3,7759,2)
 ;;=^5063478
 ;;^UTILITY(U,$J,358.3,7760,0)
 ;;=Z86.718^^42^499^117
 ;;^UTILITY(U,$J,358.3,7760,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7760,1,3,0)
 ;;=3^Personal Hx of Venous Thrombosis/Embolism (DVT)
 ;;^UTILITY(U,$J,358.3,7760,1,4,0)
 ;;=4^Z86.718
 ;;^UTILITY(U,$J,358.3,7760,2)
 ;;=^5063475
 ;;^UTILITY(U,$J,358.3,7761,0)
 ;;=Z96.1^^42^499^127
 ;;^UTILITY(U,$J,358.3,7761,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7761,1,3,0)
 ;;=3^Presence of Intraocular Lens
 ;;^UTILITY(U,$J,358.3,7761,1,4,0)
 ;;=4^Z96.1
 ;;^UTILITY(U,$J,358.3,7761,2)
 ;;=^5063682
 ;;^UTILITY(U,$J,358.3,7762,0)
 ;;=Z96.612^^42^499^132
 ;;^UTILITY(U,$J,358.3,7762,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7762,1,3,0)
 ;;=3^Presence of Left Artificial Shoulder Joint
 ;;^UTILITY(U,$J,358.3,7762,1,4,0)
 ;;=4^Z96.612
 ;;^UTILITY(U,$J,358.3,7762,2)
 ;;=^5063693
 ;;^UTILITY(U,$J,358.3,7763,0)
 ;;=Z96.611^^42^499^137
 ;;^UTILITY(U,$J,358.3,7763,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7763,1,3,0)
 ;;=3^Presence of Right Artificial Shoulder Joint
 ;;^UTILITY(U,$J,358.3,7763,1,4,0)
 ;;=4^Z96.611
 ;;^UTILITY(U,$J,358.3,7763,2)
 ;;=^5063692
 ;;^UTILITY(U,$J,358.3,7764,0)
 ;;=Z93.0^^42^499^145
