IBDEI043 ; ; 01-MAY-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 01, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,9804,1,4,0)
 ;;=4^Z91.14
 ;;^UTILITY(U,$J,358.3,9804,2)
 ;;=^5063616
 ;;^UTILITY(U,$J,358.3,9805,0)
 ;;=Z91.19^^48^489^63
 ;;^UTILITY(U,$J,358.3,9805,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9805,1,3,0)
 ;;=3^Noncompliance w/ Medical Treatment & Regimen
 ;;^UTILITY(U,$J,358.3,9805,1,4,0)
 ;;=4^Z91.19
 ;;^UTILITY(U,$J,358.3,9805,2)
 ;;=^5063618
 ;;^UTILITY(U,$J,358.3,9806,0)
 ;;=Z93.1^^48^489^45
 ;;^UTILITY(U,$J,358.3,9806,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9806,1,3,0)
 ;;=3^Gastrostomy Status
 ;;^UTILITY(U,$J,358.3,9806,1,4,0)
 ;;=4^Z93.1
 ;;^UTILITY(U,$J,358.3,9806,2)
 ;;=^5063643
 ;;^UTILITY(U,$J,358.3,9807,0)
 ;;=Z93.2^^48^489^51
 ;;^UTILITY(U,$J,358.3,9807,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9807,1,3,0)
 ;;=3^Ileostomy Status
 ;;^UTILITY(U,$J,358.3,9807,1,4,0)
 ;;=4^Z93.2
 ;;^UTILITY(U,$J,358.3,9807,2)
 ;;=^5063644
 ;;^UTILITY(U,$J,358.3,9808,0)
 ;;=Z93.3^^48^489^7
 ;;^UTILITY(U,$J,358.3,9808,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9808,1,3,0)
 ;;=3^Colostomy Status
 ;;^UTILITY(U,$J,358.3,9808,1,4,0)
 ;;=4^Z93.3
 ;;^UTILITY(U,$J,358.3,9808,2)
 ;;=^5063645
 ;;^UTILITY(U,$J,358.3,9809,0)
 ;;=Z94.0^^48^489^56
 ;;^UTILITY(U,$J,358.3,9809,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9809,1,3,0)
 ;;=3^Kidney Transplant Status
 ;;^UTILITY(U,$J,358.3,9809,1,4,0)
 ;;=4^Z94.0
 ;;^UTILITY(U,$J,358.3,9809,2)
 ;;=^5063654
 ;;^UTILITY(U,$J,358.3,9810,0)
 ;;=Z94.1^^48^489^49
 ;;^UTILITY(U,$J,358.3,9810,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9810,1,3,0)
 ;;=3^Heart Transplant Status
 ;;^UTILITY(U,$J,358.3,9810,1,4,0)
 ;;=4^Z94.1
 ;;^UTILITY(U,$J,358.3,9810,2)
 ;;=^5063655
 ;;^UTILITY(U,$J,358.3,9811,0)
 ;;=Z94.2^^48^489^59
 ;;^UTILITY(U,$J,358.3,9811,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9811,1,3,0)
 ;;=3^Lung Transplant Status
 ;;^UTILITY(U,$J,358.3,9811,1,4,0)
 ;;=4^Z94.2
 ;;^UTILITY(U,$J,358.3,9811,2)
 ;;=^5063656
 ;;^UTILITY(U,$J,358.3,9812,0)
 ;;=Z94.3^^48^489^48
 ;;^UTILITY(U,$J,358.3,9812,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9812,1,3,0)
 ;;=3^Heart & Lungs Transplant Status
 ;;^UTILITY(U,$J,358.3,9812,1,4,0)
 ;;=4^Z94.3
 ;;^UTILITY(U,$J,358.3,9812,2)
 ;;=^5063657
 ;;^UTILITY(U,$J,358.3,9813,0)
 ;;=Z94.4^^48^489^58
 ;;^UTILITY(U,$J,358.3,9813,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9813,1,3,0)
 ;;=3^Liver Transplant Status
 ;;^UTILITY(U,$J,358.3,9813,1,4,0)
 ;;=4^Z94.4
 ;;^UTILITY(U,$J,358.3,9813,2)
 ;;=^5063658
 ;;^UTILITY(U,$J,358.3,9814,0)
 ;;=Z94.84^^48^489^149
 ;;^UTILITY(U,$J,358.3,9814,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9814,1,3,0)
 ;;=3^Stem Cell Transplant Status
 ;;^UTILITY(U,$J,358.3,9814,1,4,0)
 ;;=4^Z94.84
 ;;^UTILITY(U,$J,358.3,9814,2)
 ;;=^5063665
 ;;^UTILITY(U,$J,358.3,9815,0)
 ;;=Z96.21^^48^489^6
 ;;^UTILITY(U,$J,358.3,9815,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9815,1,3,0)
 ;;=3^Cochlear Implant Status
 ;;^UTILITY(U,$J,358.3,9815,1,4,0)
 ;;=4^Z96.21
 ;;^UTILITY(U,$J,358.3,9815,2)
 ;;=^5063684
 ;;^UTILITY(U,$J,358.3,9816,0)
 ;;=Z96.41^^48^489^132
 ;;^UTILITY(U,$J,358.3,9816,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9816,1,3,0)
 ;;=3^Presence of Insulin Pump
 ;;^UTILITY(U,$J,358.3,9816,1,4,0)
 ;;=4^Z96.41
 ;;^UTILITY(U,$J,358.3,9816,2)
 ;;=^5063688
 ;;^UTILITY(U,$J,358.3,9817,0)
 ;;=Z96.641^^48^489^140
 ;;^UTILITY(U,$J,358.3,9817,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9817,1,3,0)
 ;;=3^Presence of Right Artificial Hip Jt
 ;;^UTILITY(U,$J,358.3,9817,1,4,0)
 ;;=4^Z96.641
 ;;^UTILITY(U,$J,358.3,9817,2)
 ;;=^5063701
 ;;^UTILITY(U,$J,358.3,9818,0)
 ;;=Z96.642^^48^489^135
 ;;^UTILITY(U,$J,358.3,9818,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9818,1,3,0)
 ;;=3^Presence of Left Artificial Hip Jt
 ;;^UTILITY(U,$J,358.3,9818,1,4,0)
 ;;=4^Z96.642
 ;;^UTILITY(U,$J,358.3,9818,2)
 ;;=^5063702
 ;;^UTILITY(U,$J,358.3,9819,0)
 ;;=Z96.643^^48^489^119
 ;;^UTILITY(U,$J,358.3,9819,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9819,1,3,0)
 ;;=3^Presence of Artificial Hip Jt,Bilateral
 ;;^UTILITY(U,$J,358.3,9819,1,4,0)
 ;;=4^Z96.643
 ;;^UTILITY(U,$J,358.3,9819,2)
 ;;=^5063703
 ;;^UTILITY(U,$J,358.3,9820,0)
 ;;=Z96.651^^48^489^141
 ;;^UTILITY(U,$J,358.3,9820,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9820,1,3,0)
 ;;=3^Presence of Right Artificial Knee Jt
 ;;^UTILITY(U,$J,358.3,9820,1,4,0)
 ;;=4^Z96.651
 ;;^UTILITY(U,$J,358.3,9820,2)
 ;;=^5063705
 ;;^UTILITY(U,$J,358.3,9821,0)
 ;;=Z96.652^^48^489^136
 ;;^UTILITY(U,$J,358.3,9821,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9821,1,3,0)
 ;;=3^Presence of Left Artificial Knee Jt
 ;;^UTILITY(U,$J,358.3,9821,1,4,0)
 ;;=4^Z96.652
 ;;^UTILITY(U,$J,358.3,9821,2)
 ;;=^5063706
 ;;^UTILITY(U,$J,358.3,9822,0)
 ;;=Z96.653^^48^489^120
 ;;^UTILITY(U,$J,358.3,9822,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9822,1,3,0)
 ;;=3^Presence of Artificial Knee Jt,Bilateral
 ;;^UTILITY(U,$J,358.3,9822,1,4,0)
 ;;=4^Z96.653
 ;;^UTILITY(U,$J,358.3,9822,2)
 ;;=^5063707
 ;;^UTILITY(U,$J,358.3,9823,0)
 ;;=Z96.7^^48^489^125
 ;;^UTILITY(U,$J,358.3,9823,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9823,1,3,0)
 ;;=3^Presence of Bone/Tendon Implants NEC
 ;;^UTILITY(U,$J,358.3,9823,1,4,0)
 ;;=4^Z96.7
 ;;^UTILITY(U,$J,358.3,9823,2)
 ;;=^5063716
 ;;^UTILITY(U,$J,358.3,9824,0)
 ;;=Z97.11^^48^489^139
 ;;^UTILITY(U,$J,358.3,9824,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9824,1,3,0)
 ;;=3^Presence of Right Artificial Arm
 ;;^UTILITY(U,$J,358.3,9824,1,4,0)
 ;;=4^Z97.11
 ;;^UTILITY(U,$J,358.3,9824,2)
 ;;=^5063722
 ;;^UTILITY(U,$J,358.3,9825,0)
 ;;=Z97.12^^48^489^134
 ;;^UTILITY(U,$J,358.3,9825,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9825,1,3,0)
 ;;=3^Presence of Left Artificial Arm
 ;;^UTILITY(U,$J,358.3,9825,1,4,0)
 ;;=4^Z97.12
 ;;^UTILITY(U,$J,358.3,9825,2)
 ;;=^5063723
 ;;^UTILITY(U,$J,358.3,9826,0)
 ;;=Z97.13^^48^489^142
 ;;^UTILITY(U,$J,358.3,9826,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9826,1,3,0)
 ;;=3^Presence of Right Artificial Leg
 ;;^UTILITY(U,$J,358.3,9826,1,4,0)
 ;;=4^Z97.13
 ;;^UTILITY(U,$J,358.3,9826,2)
 ;;=^5063724
 ;;^UTILITY(U,$J,358.3,9827,0)
 ;;=Z97.14^^48^489^137
 ;;^UTILITY(U,$J,358.3,9827,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9827,1,3,0)
 ;;=3^Presence of Left Artificial Leg
 ;;^UTILITY(U,$J,358.3,9827,1,4,0)
 ;;=4^Z97.14
 ;;^UTILITY(U,$J,358.3,9827,2)
 ;;=^5063725
 ;;^UTILITY(U,$J,358.3,9828,0)
 ;;=Z97.15^^48^489^116
 ;;^UTILITY(U,$J,358.3,9828,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9828,1,3,0)
 ;;=3^Presence of Artificial Arms,Bilateral
 ;;^UTILITY(U,$J,358.3,9828,1,4,0)
 ;;=4^Z97.15
 ;;^UTILITY(U,$J,358.3,9828,2)
 ;;=^5063726
 ;;^UTILITY(U,$J,358.3,9829,0)
 ;;=Z97.16^^48^489^121
 ;;^UTILITY(U,$J,358.3,9829,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9829,1,3,0)
 ;;=3^Presence of Artificial Legs,Bilateral
 ;;^UTILITY(U,$J,358.3,9829,1,4,0)
 ;;=4^Z97.16
 ;;^UTILITY(U,$J,358.3,9829,2)
 ;;=^5063727
 ;;^UTILITY(U,$J,358.3,9830,0)
 ;;=Z98.61^^48^489^9
 ;;^UTILITY(U,$J,358.3,9830,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9830,1,3,0)
 ;;=3^Coronary Angioplasty Status
 ;;^UTILITY(U,$J,358.3,9830,1,4,0)
 ;;=4^Z98.61
 ;;^UTILITY(U,$J,358.3,9830,2)
 ;;=^5063742
 ;;^UTILITY(U,$J,358.3,9831,0)
 ;;=Z98.62^^48^489^66
 ;;^UTILITY(U,$J,358.3,9831,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9831,1,3,0)
 ;;=3^Peripheral Vascular Angioplasty Status w/o Graft
 ;;^UTILITY(U,$J,358.3,9831,1,4,0)
 ;;=4^Z98.62
 ;;^UTILITY(U,$J,358.3,9831,2)
 ;;=^5063743
 ;;^UTILITY(U,$J,358.3,9832,0)
 ;;=Z98.84^^48^489^4
 ;;^UTILITY(U,$J,358.3,9832,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9832,1,3,0)
 ;;=3^Bariatric Surgery Status
 ;;^UTILITY(U,$J,358.3,9832,1,4,0)
 ;;=4^Z98.84
 ;;^UTILITY(U,$J,358.3,9832,2)
 ;;=^5063749
 ;;^UTILITY(U,$J,358.3,9833,0)
 ;;=Z99.2^^48^489^147
 ;;^UTILITY(U,$J,358.3,9833,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9833,1,3,0)
 ;;=3^Renal Dialysis Dependence
 ;;^UTILITY(U,$J,358.3,9833,1,4,0)
 ;;=4^Z99.2
 ;;^UTILITY(U,$J,358.3,9833,2)
 ;;=^5063758
 ;;^UTILITY(U,$J,358.3,9834,0)
 ;;=Z99.81^^48^489^150
 ;;^UTILITY(U,$J,358.3,9834,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9834,1,3,0)
 ;;=3^Supplemental Oxygen Dependence
 ;;^UTILITY(U,$J,358.3,9834,1,4,0)
 ;;=4^Z99.81
 ;;^UTILITY(U,$J,358.3,9834,2)
 ;;=^5063760
 ;;^UTILITY(U,$J,358.3,9835,0)
 ;;=Z98.1^^48^489^2
 ;;^UTILITY(U,$J,358.3,9835,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9835,1,3,0)
 ;;=3^Arthrodesis Status
 ;;^UTILITY(U,$J,358.3,9835,1,4,0)
 ;;=4^Z98.1
 ;;^UTILITY(U,$J,358.3,9835,2)
 ;;=^5063734
 ;;^UTILITY(U,$J,358.3,9836,0)
 ;;=Z94.7^^48^489^8
 ;;^UTILITY(U,$J,358.3,9836,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9836,1,3,0)
 ;;=3^Corneal Transplant Status
 ;;^UTILITY(U,$J,358.3,9836,1,4,0)
 ;;=4^Z94.7
 ;;^UTILITY(U,$J,358.3,9836,2)
 ;;=^5063661
 ;;^UTILITY(U,$J,358.3,9837,0)
 ;;=Z83.511^^48^489^23
 ;;^UTILITY(U,$J,358.3,9837,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9837,1,3,0)
 ;;=3^Family Hx of Glaucoma
 ;;^UTILITY(U,$J,358.3,9837,1,4,0)
 ;;=4^Z83.511
 ;;^UTILITY(U,$J,358.3,9837,2)
 ;;=^5063382
 ;;^UTILITY(U,$J,358.3,9838,0)
 ;;=Z80.52^^48^489^26
 ;;^UTILITY(U,$J,358.3,9838,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9838,1,3,0)
 ;;=3^Family Hx of Malig Neop of Baldder
 ;;^UTILITY(U,$J,358.3,9838,1,4,0)
 ;;=4^Z80.52
 ;;^UTILITY(U,$J,358.3,9838,2)
 ;;=^5063352
 ;;^UTILITY(U,$J,358.3,9839,0)
 ;;=Z80.51^^48^489^29
 ;;^UTILITY(U,$J,358.3,9839,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9839,1,3,0)
 ;;=3^Family Hx of Malig Neop of Kidney
 ;;^UTILITY(U,$J,358.3,9839,1,4,0)
 ;;=4^Z80.51
 ;;^UTILITY(U,$J,358.3,9839,2)
 ;;=^321159
 ;;^UTILITY(U,$J,358.3,9840,0)
 ;;=Z83.41^^48^489^36
 ;;^UTILITY(U,$J,358.3,9840,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9840,1,3,0)
 ;;=3^Family Hx of Mult Endocrine Neoplasia Syndrome
 ;;^UTILITY(U,$J,358.3,9840,1,4,0)
 ;;=4^Z83.41
 ;;^UTILITY(U,$J,358.3,9840,2)
 ;;=^5063380
 ;;^UTILITY(U,$J,358.3,9841,0)
 ;;=Z81.8^^48^489^43
 ;;^UTILITY(U,$J,358.3,9841,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9841,1,3,0)
 ;;=3^Family Hx of Substance Abuse/Dependence,Psychoactive
 ;;^UTILITY(U,$J,358.3,9841,1,4,0)
 ;;=4^Z81.8
 ;;^UTILITY(U,$J,358.3,9841,2)
 ;;=^5063363
 ;;^UTILITY(U,$J,358.3,9842,0)
 ;;=Z81.4^^48^489^44
 ;;^UTILITY(U,$J,358.3,9842,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9842,1,3,0)
 ;;=3^Family Hx of Substance Abuse/Dependence NEC
 ;;^UTILITY(U,$J,358.3,9842,1,4,0)
 ;;=4^Z81.4
 ;;^UTILITY(U,$J,358.3,9842,2)
 ;;=^5063362
 ;;^UTILITY(U,$J,358.3,9843,0)
 ;;=Z98.0^^48^489^55
 ;;^UTILITY(U,$J,358.3,9843,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9843,1,3,0)
 ;;=3^Intestinal Bypass/Anastomosis Status
 ;;^UTILITY(U,$J,358.3,9843,1,4,0)
 ;;=4^Z98.0
 ;;^UTILITY(U,$J,358.3,9843,2)
 ;;=^5063733
 ;;^UTILITY(U,$J,358.3,9844,0)
 ;;=Z91.128^^48^489^54
 ;;^UTILITY(U,$J,358.3,9844,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9844,1,3,0)
 ;;=3^Intentional Underdose of Meds d/t Other Reasons
 ;;^UTILITY(U,$J,358.3,9844,1,4,0)
 ;;=4^Z91.128
 ;;^UTILITY(U,$J,358.3,9844,2)
 ;;=^5063613
 ;;^UTILITY(U,$J,358.3,9845,0)
 ;;=Z77.120^^48^489^60
 ;;^UTILITY(U,$J,358.3,9845,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9845,1,3,0)
 ;;=3^Mold (Toxic) Contact/Exposure
 ;;^UTILITY(U,$J,358.3,9845,1,4,0)
 ;;=4^Z77.120
 ;;^UTILITY(U,$J,358.3,9845,2)
 ;;=^5063318
 ;;^UTILITY(U,$J,358.3,9846,0)
 ;;=Z86.74^^48^489^104
 ;;^UTILITY(U,$J,358.3,9846,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9846,1,3,0)
 ;;=3^Personal Hx of Sudden Cardiac Arrest 
 ;;^UTILITY(U,$J,358.3,9846,1,4,0)
 ;;=4^Z86.74
 ;;^UTILITY(U,$J,358.3,9846,2)
 ;;=^5063478
 ;;^UTILITY(U,$J,358.3,9847,0)
 ;;=Z86.718^^48^489^111
 ;;^UTILITY(U,$J,358.3,9847,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9847,1,3,0)
 ;;=3^Personal Hx of Venous Thrombosis/Embolism (DVT)
 ;;^UTILITY(U,$J,358.3,9847,1,4,0)
 ;;=4^Z86.718
 ;;^UTILITY(U,$J,358.3,9847,2)
 ;;=^5063475
 ;;^UTILITY(U,$J,358.3,9848,0)
 ;;=Z96.1^^48^489^133
 ;;^UTILITY(U,$J,358.3,9848,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9848,1,3,0)
 ;;=3^Presence of Intraocular Lens
 ;;^UTILITY(U,$J,358.3,9848,1,4,0)
 ;;=4^Z96.1
 ;;^UTILITY(U,$J,358.3,9848,2)
 ;;=^5063682
 ;;^UTILITY(U,$J,358.3,9849,0)
 ;;=Z96.612^^48^489^138
 ;;^UTILITY(U,$J,358.3,9849,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9849,1,3,0)
 ;;=3^Presence of Left Artificial Shoulder Joint
 ;;^UTILITY(U,$J,358.3,9849,1,4,0)
 ;;=4^Z96.612
 ;;^UTILITY(U,$J,358.3,9849,2)
 ;;=^5063693
 ;;^UTILITY(U,$J,358.3,9850,0)
 ;;=Z96.611^^48^489^143
 ;;^UTILITY(U,$J,358.3,9850,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9850,1,3,0)
 ;;=3^Presence of Right Artificial Shoulder Joint
 ;;^UTILITY(U,$J,358.3,9850,1,4,0)
 ;;=4^Z96.611
 ;;^UTILITY(U,$J,358.3,9850,2)
 ;;=^5063692
 ;;^UTILITY(U,$J,358.3,9851,0)
 ;;=Z93.0^^48^489^151
 ;;^UTILITY(U,$J,358.3,9851,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9851,1,3,0)
 ;;=3^Tracheostomy Status
 ;;^UTILITY(U,$J,358.3,9851,1,4,0)
 ;;=4^Z93.0
 ;;^UTILITY(U,$J,358.3,9851,2)
 ;;=^5063642
 ;;^UTILITY(U,$J,358.3,9852,0)
 ;;=Z99.3^^48^489^156
 ;;^UTILITY(U,$J,358.3,9852,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9852,1,3,0)
 ;;=3^Wheelchair Dependence
 ;;^UTILITY(U,$J,358.3,9852,1,4,0)
 ;;=4^Z99.3
 ;;^UTILITY(U,$J,358.3,9852,2)
 ;;=^5063759
 ;;^UTILITY(U,$J,358.3,9853,0)
 ;;=Z83.42^^48^489^21
 ;;^UTILITY(U,$J,358.3,9853,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9853,1,3,0)
 ;;=3^Family Hx of Familial Hypercholesterolemia
 ;;^UTILITY(U,$J,358.3,9853,1,4,0)
 ;;=4^Z83.42
 ;;^UTILITY(U,$J,358.3,9853,2)
 ;;=^8132985
 ;;^UTILITY(U,$J,358.3,9854,0)
 ;;=Z98.890^^48^489^114
 ;;^UTILITY(U,$J,358.3,9854,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9854,1,3,0)
 ;;=3^Postprocedural States/HX of Surgery NEC
 ;;^UTILITY(U,$J,358.3,9854,1,4,0)
 ;;=4^Z98.890
 ;;^UTILITY(U,$J,358.3,9854,2)
 ;;=^5063754
 ;;^UTILITY(U,$J,358.3,9855,0)
 ;;=Z95.1^^48^489^115
 ;;^UTILITY(U,$J,358.3,9855,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9855,1,3,0)
 ;;=3^Presence of Aortocoronary Bypass
 ;;^UTILITY(U,$J,358.3,9855,1,4,0)
 ;;=4^Z95.1
 ;;^UTILITY(U,$J,358.3,9855,2)
 ;;=^5063669
 ;;^UTILITY(U,$J,358.3,9856,0)
 ;;=Z98.2^^48^489^127
 ;;^UTILITY(U,$J,358.3,9856,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9856,1,3,0)
 ;;=3^Presence of Cerebrospinal Fluid Drainage Device
 ;;^UTILITY(U,$J,358.3,9856,1,4,0)
 ;;=4^Z98.2
 ;;^UTILITY(U,$J,358.3,9856,2)
 ;;=^5063735
 ;;^UTILITY(U,$J,358.3,9857,0)
 ;;=Z97.5^^48^489^128
 ;;^UTILITY(U,$J,358.3,9857,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9857,1,3,0)
 ;;=3^Presence of Contraceptive (Intrauterine) Device
 ;;^UTILITY(U,$J,358.3,9857,1,4,0)
 ;;=4^Z97.5
 ;;^UTILITY(U,$J,358.3,9857,2)
 ;;=^5063731
 ;;^UTILITY(U,$J,358.3,9858,0)
 ;;=Z95.5^^48^489^129
 ;;^UTILITY(U,$J,358.3,9858,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9858,1,3,0)
 ;;=3^Presence of Coronary Angioplasty Implant/Graft
 ;;^UTILITY(U,$J,358.3,9858,1,4,0)
 ;;=4^Z95.5
 ;;^UTILITY(U,$J,358.3,9858,2)
 ;;=^5063673
 ;;^UTILITY(U,$J,358.3,9859,0)
 ;;=Z97.2^^48^489^130
 ;;^UTILITY(U,$J,358.3,9859,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9859,1,3,0)
 ;;=3^Presence of Dental Prosthetic Device
 ;;^UTILITY(U,$J,358.3,9859,1,4,0)
 ;;=4^Z97.2
 ;;^UTILITY(U,$J,358.3,9859,2)
 ;;=^5063728
 ;;^UTILITY(U,$J,358.3,9860,0)
 ;;=Z97.4^^48^489^131
 ;;^UTILITY(U,$J,358.3,9860,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9860,1,3,0)
 ;;=3^Presence of External Hearing Aid
 ;;^UTILITY(U,$J,358.3,9860,1,4,0)
 ;;=4^Z97.4
 ;;^UTILITY(U,$J,358.3,9860,2)
 ;;=^5063730
 ;;^UTILITY(U,$J,358.3,9861,0)
 ;;=Z96.622^^48^489^117
 ;;^UTILITY(U,$J,358.3,9861,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9861,1,3,0)
 ;;=3^Presence of Artificial Elbow Joint,Left
 ;;^UTILITY(U,$J,358.3,9861,1,4,0)
 ;;=4^Z96.622
 ;;^UTILITY(U,$J,358.3,9861,2)
 ;;=^5063696
 ;;^UTILITY(U,$J,358.3,9862,0)
 ;;=Z96.632^^48^489^122
 ;;^UTILITY(U,$J,358.3,9862,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9862,1,3,0)
 ;;=3^Presence of Artificial Wrist Joint,Left
 ;;^UTILITY(U,$J,358.3,9862,1,4,0)
 ;;=4^Z96.632
 ;;^UTILITY(U,$J,358.3,9862,2)
 ;;=^5063699
 ;;^UTILITY(U,$J,358.3,9863,0)
 ;;=Z96.621^^48^489^118
 ;;^UTILITY(U,$J,358.3,9863,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9863,1,3,0)
 ;;=3^Presence of Artificial Elbow Joint,Right
 ;;^UTILITY(U,$J,358.3,9863,1,4,0)
 ;;=4^Z96.621
 ;;^UTILITY(U,$J,358.3,9863,2)
 ;;=^5063695
 ;;^UTILITY(U,$J,358.3,9864,0)
 ;;=Z96.631^^48^489^123
 ;;^UTILITY(U,$J,358.3,9864,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9864,1,3,0)
 ;;=3^Presence of Artificial Wrist Joint,Right
 ;;^UTILITY(U,$J,358.3,9864,1,4,0)
 ;;=4^Z96.631
 ;;^UTILITY(U,$J,358.3,9864,2)
 ;;=^5063698
 ;;^UTILITY(U,$J,358.3,9865,0)
 ;;=Z93.6^^48^489^154
 ;;^UTILITY(U,$J,358.3,9865,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9865,1,3,0)
 ;;=3^Urostomy Status
 ;;^UTILITY(U,$J,358.3,9865,1,4,0)
 ;;=4^Z93.6
 ;;^UTILITY(U,$J,358.3,9865,2)
 ;;=^5063651
 ;;^UTILITY(U,$J,358.3,9866,0)
 ;;=Z95.820^^48^489^67
 ;;^UTILITY(U,$J,358.3,9866,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9866,1,3,0)
 ;;=3^Peripheral Vascular Angioplasty Status w/ Graft
 ;;^UTILITY(U,$J,358.3,9866,1,4,0)
 ;;=4^Z95.820
 ;;^UTILITY(U,$J,358.3,9866,2)
 ;;=^5063678
 ;;^UTILITY(U,$J,358.3,9867,0)
 ;;=Z95.0^^48^489^126
 ;;^UTILITY(U,$J,358.3,9867,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9867,1,3,0)
 ;;=3^Presence of Cardiac Pacemaker
 ;;^UTILITY(U,$J,358.3,9867,1,4,0)
 ;;=4^Z95.0
 ;;^UTILITY(U,$J,358.3,9867,2)
 ;;=^5063668
 ;;^UTILITY(U,$J,358.3,9868,0)
 ;;=Z95.810^^48^489^124
 ;;^UTILITY(U,$J,358.3,9868,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9868,1,3,0)
 ;;=3^Presence of Automatic Cardiac Debribrillator
 ;;^UTILITY(U,$J,358.3,9868,1,4,0)
 ;;=4^Z95.810
 ;;^UTILITY(U,$J,358.3,9868,2)
 ;;=^5063674
 ;;^UTILITY(U,$J,358.3,9869,0)
 ;;=A15.0^^48^490^85
 ;;^UTILITY(U,$J,358.3,9869,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9869,1,3,0)
 ;;=3^Tuberculosis of Lung
 ;;^UTILITY(U,$J,358.3,9869,1,4,0)
 ;;=4^A15.0
 ;;^UTILITY(U,$J,358.3,9869,2)
 ;;=^5000062
 ;;^UTILITY(U,$J,358.3,9870,0)
 ;;=B20.^^48^490^32
 ;;^UTILITY(U,$J,358.3,9870,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9870,1,3,0)
 ;;=3^HIV Disease
 ;;^UTILITY(U,$J,358.3,9870,1,4,0)
 ;;=4^B20.
 ;;^UTILITY(U,$J,358.3,9870,2)
 ;;=^5000555
 ;;^UTILITY(U,$J,358.3,9871,0)
 ;;=B02.9^^48^490^94
 ;;^UTILITY(U,$J,358.3,9871,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9871,1,3,0)
 ;;=3^Zoster w/o Complications
 ;;^UTILITY(U,$J,358.3,9871,1,4,0)
 ;;=4^B02.9
 ;;^UTILITY(U,$J,358.3,9871,2)
 ;;=^5000501
 ;;^UTILITY(U,$J,358.3,9872,0)
 ;;=A60.9^^48^490^2
 ;;^UTILITY(U,$J,358.3,9872,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9872,1,3,0)
 ;;=3^Anogenital Herpesviral Infection,Unspec
 ;;^UTILITY(U,$J,358.3,9872,1,4,0)
 ;;=4^A60.9
 ;;^UTILITY(U,$J,358.3,9872,2)
 ;;=^5000359
 ;;^UTILITY(U,$J,358.3,9873,0)
 ;;=A60.04^^48^490^35
 ;;^UTILITY(U,$J,358.3,9873,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9873,1,3,0)
 ;;=3^Herpesviral Vulvovaginitis
 ;;^UTILITY(U,$J,358.3,9873,1,4,0)
 ;;=4^A60.04
 ;;^UTILITY(U,$J,358.3,9873,2)
 ;;=^5000356
 ;;^UTILITY(U,$J,358.3,9874,0)
 ;;=A60.01^^48^490^33
