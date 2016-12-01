IBDEI05F ; ; 09-AUG-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,6713,1,3,0)
 ;;=3^Underdose of Med Regiment d/t Age-Related Debility
 ;;^UTILITY(U,$J,358.3,6713,1,4,0)
 ;;=4^Z91.130
 ;;^UTILITY(U,$J,358.3,6713,2)
 ;;=^5063614
 ;;^UTILITY(U,$J,358.3,6714,0)
 ;;=Z91.138^^26^403^147
 ;;^UTILITY(U,$J,358.3,6714,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6714,1,3,0)
 ;;=3^Underdose of Med Regiment for Other Reason
 ;;^UTILITY(U,$J,358.3,6714,1,4,0)
 ;;=4^Z91.138
 ;;^UTILITY(U,$J,358.3,6714,2)
 ;;=^5063615
 ;;^UTILITY(U,$J,358.3,6715,0)
 ;;=Z91.14^^26^403^71
 ;;^UTILITY(U,$J,358.3,6715,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6715,1,3,0)
 ;;=3^Noncompliance w/ Medication Regimen
 ;;^UTILITY(U,$J,358.3,6715,1,4,0)
 ;;=4^Z91.14
 ;;^UTILITY(U,$J,358.3,6715,2)
 ;;=^5063616
 ;;^UTILITY(U,$J,358.3,6716,0)
 ;;=Z91.19^^26^403^70
 ;;^UTILITY(U,$J,358.3,6716,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6716,1,3,0)
 ;;=3^Noncompliance w/ Medical Treatment & Regimen
 ;;^UTILITY(U,$J,358.3,6716,1,4,0)
 ;;=4^Z91.19
 ;;^UTILITY(U,$J,358.3,6716,2)
 ;;=^5063618
 ;;^UTILITY(U,$J,358.3,6717,0)
 ;;=Z93.1^^26^403^52
 ;;^UTILITY(U,$J,358.3,6717,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6717,1,3,0)
 ;;=3^Gastrostomy Status
 ;;^UTILITY(U,$J,358.3,6717,1,4,0)
 ;;=4^Z93.1
 ;;^UTILITY(U,$J,358.3,6717,2)
 ;;=^5063643
 ;;^UTILITY(U,$J,358.3,6718,0)
 ;;=Z93.2^^26^403^58
 ;;^UTILITY(U,$J,358.3,6718,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6718,1,3,0)
 ;;=3^Ileostomy Status
 ;;^UTILITY(U,$J,358.3,6718,1,4,0)
 ;;=4^Z93.2
 ;;^UTILITY(U,$J,358.3,6718,2)
 ;;=^5063644
 ;;^UTILITY(U,$J,358.3,6719,0)
 ;;=Z93.3^^26^403^15
 ;;^UTILITY(U,$J,358.3,6719,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6719,1,3,0)
 ;;=3^Colostomy Status
 ;;^UTILITY(U,$J,358.3,6719,1,4,0)
 ;;=4^Z93.3
 ;;^UTILITY(U,$J,358.3,6719,2)
 ;;=^5063645
 ;;^UTILITY(U,$J,358.3,6720,0)
 ;;=Z94.0^^26^403^63
 ;;^UTILITY(U,$J,358.3,6720,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6720,1,3,0)
 ;;=3^Kidney Transplant Status
 ;;^UTILITY(U,$J,358.3,6720,1,4,0)
 ;;=4^Z94.0
 ;;^UTILITY(U,$J,358.3,6720,2)
 ;;=^5063654
 ;;^UTILITY(U,$J,358.3,6721,0)
 ;;=Z94.1^^26^403^56
 ;;^UTILITY(U,$J,358.3,6721,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6721,1,3,0)
 ;;=3^Heart Transplant Status
 ;;^UTILITY(U,$J,358.3,6721,1,4,0)
 ;;=4^Z94.1
 ;;^UTILITY(U,$J,358.3,6721,2)
 ;;=^5063655
 ;;^UTILITY(U,$J,358.3,6722,0)
 ;;=Z94.2^^26^403^66
 ;;^UTILITY(U,$J,358.3,6722,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6722,1,3,0)
 ;;=3^Lung Transplant Status
 ;;^UTILITY(U,$J,358.3,6722,1,4,0)
 ;;=4^Z94.2
 ;;^UTILITY(U,$J,358.3,6722,2)
 ;;=^5063656
 ;;^UTILITY(U,$J,358.3,6723,0)
 ;;=Z94.3^^26^403^55
 ;;^UTILITY(U,$J,358.3,6723,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6723,1,3,0)
 ;;=3^Heart & Lungs Transplant Status
 ;;^UTILITY(U,$J,358.3,6723,1,4,0)
 ;;=4^Z94.3
 ;;^UTILITY(U,$J,358.3,6723,2)
 ;;=^5063657
 ;;^UTILITY(U,$J,358.3,6724,0)
 ;;=Z94.4^^26^403^65
 ;;^UTILITY(U,$J,358.3,6724,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6724,1,3,0)
 ;;=3^Liver Transplant Status
 ;;^UTILITY(U,$J,358.3,6724,1,4,0)
 ;;=4^Z94.4
 ;;^UTILITY(U,$J,358.3,6724,2)
 ;;=^5063658
 ;;^UTILITY(U,$J,358.3,6725,0)
 ;;=Z94.84^^26^403^143
 ;;^UTILITY(U,$J,358.3,6725,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6725,1,3,0)
 ;;=3^Stem Cell Transplant Status
 ;;^UTILITY(U,$J,358.3,6725,1,4,0)
 ;;=4^Z94.84
 ;;^UTILITY(U,$J,358.3,6725,2)
 ;;=^5063665
 ;;^UTILITY(U,$J,358.3,6726,0)
 ;;=Z96.21^^26^403^14
 ;;^UTILITY(U,$J,358.3,6726,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6726,1,3,0)
 ;;=3^Cochlear Implant Status
 ;;^UTILITY(U,$J,358.3,6726,1,4,0)
 ;;=4^Z96.21
 ;;^UTILITY(U,$J,358.3,6726,2)
 ;;=^5063684
 ;;^UTILITY(U,$J,358.3,6727,0)
 ;;=Z96.41^^26^403^126
 ;;^UTILITY(U,$J,358.3,6727,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6727,1,3,0)
 ;;=3^Presence of Insulin Pump
 ;;^UTILITY(U,$J,358.3,6727,1,4,0)
 ;;=4^Z96.41
 ;;^UTILITY(U,$J,358.3,6727,2)
 ;;=^5063688
 ;;^UTILITY(U,$J,358.3,6728,0)
 ;;=Z96.641^^26^403^134
 ;;^UTILITY(U,$J,358.3,6728,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6728,1,3,0)
 ;;=3^Presence of Right Artificial Hip Jt
 ;;^UTILITY(U,$J,358.3,6728,1,4,0)
 ;;=4^Z96.641
 ;;^UTILITY(U,$J,358.3,6728,2)
 ;;=^5063701
 ;;^UTILITY(U,$J,358.3,6729,0)
 ;;=Z96.642^^26^403^129
 ;;^UTILITY(U,$J,358.3,6729,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6729,1,3,0)
 ;;=3^Presence of Left Artificial Hip Jt
 ;;^UTILITY(U,$J,358.3,6729,1,4,0)
 ;;=4^Z96.642
 ;;^UTILITY(U,$J,358.3,6729,2)
 ;;=^5063702
 ;;^UTILITY(U,$J,358.3,6730,0)
 ;;=Z96.643^^26^403^121
 ;;^UTILITY(U,$J,358.3,6730,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6730,1,3,0)
 ;;=3^Presence of Artificial Hip Jt,Bilateral
 ;;^UTILITY(U,$J,358.3,6730,1,4,0)
 ;;=4^Z96.643
 ;;^UTILITY(U,$J,358.3,6730,2)
 ;;=^5063703
 ;;^UTILITY(U,$J,358.3,6731,0)
 ;;=Z96.651^^26^403^135
 ;;^UTILITY(U,$J,358.3,6731,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6731,1,3,0)
 ;;=3^Presence of Right Artificial Knee Jt
 ;;^UTILITY(U,$J,358.3,6731,1,4,0)
 ;;=4^Z96.651
 ;;^UTILITY(U,$J,358.3,6731,2)
 ;;=^5063705
 ;;^UTILITY(U,$J,358.3,6732,0)
 ;;=Z96.652^^26^403^130
 ;;^UTILITY(U,$J,358.3,6732,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6732,1,3,0)
 ;;=3^Presence of Left Artificial Knee Jt
 ;;^UTILITY(U,$J,358.3,6732,1,4,0)
 ;;=4^Z96.652
 ;;^UTILITY(U,$J,358.3,6732,2)
 ;;=^5063706
 ;;^UTILITY(U,$J,358.3,6733,0)
 ;;=Z96.653^^26^403^122
 ;;^UTILITY(U,$J,358.3,6733,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6733,1,3,0)
 ;;=3^Presence of Artificial Knee Jt,Bilateral
 ;;^UTILITY(U,$J,358.3,6733,1,4,0)
 ;;=4^Z96.653
 ;;^UTILITY(U,$J,358.3,6733,2)
 ;;=^5063707
 ;;^UTILITY(U,$J,358.3,6734,0)
 ;;=Z96.7^^26^403^125
 ;;^UTILITY(U,$J,358.3,6734,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6734,1,3,0)
 ;;=3^Presence of Bone/Tendon Implants NEC
 ;;^UTILITY(U,$J,358.3,6734,1,4,0)
 ;;=4^Z96.7
 ;;^UTILITY(U,$J,358.3,6734,2)
 ;;=^5063716
 ;;^UTILITY(U,$J,358.3,6735,0)
 ;;=Z97.11^^26^403^133
 ;;^UTILITY(U,$J,358.3,6735,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6735,1,3,0)
 ;;=3^Presence of Right Artificial Arm
 ;;^UTILITY(U,$J,358.3,6735,1,4,0)
 ;;=4^Z97.11
 ;;^UTILITY(U,$J,358.3,6735,2)
 ;;=^5063722
 ;;^UTILITY(U,$J,358.3,6736,0)
 ;;=Z97.12^^26^403^128
 ;;^UTILITY(U,$J,358.3,6736,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6736,1,3,0)
 ;;=3^Presence of Left Artificial Arm
 ;;^UTILITY(U,$J,358.3,6736,1,4,0)
 ;;=4^Z97.12
 ;;^UTILITY(U,$J,358.3,6736,2)
 ;;=^5063723
 ;;^UTILITY(U,$J,358.3,6737,0)
 ;;=Z97.13^^26^403^136
 ;;^UTILITY(U,$J,358.3,6737,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6737,1,3,0)
 ;;=3^Presence of Right Artificial Leg
 ;;^UTILITY(U,$J,358.3,6737,1,4,0)
 ;;=4^Z97.13
 ;;^UTILITY(U,$J,358.3,6737,2)
 ;;=^5063724
 ;;^UTILITY(U,$J,358.3,6738,0)
 ;;=Z97.14^^26^403^131
 ;;^UTILITY(U,$J,358.3,6738,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6738,1,3,0)
 ;;=3^Presence of Left Artificial Leg
 ;;^UTILITY(U,$J,358.3,6738,1,4,0)
 ;;=4^Z97.14
 ;;^UTILITY(U,$J,358.3,6738,2)
 ;;=^5063725
 ;;^UTILITY(U,$J,358.3,6739,0)
 ;;=Z97.15^^26^403^123
 ;;^UTILITY(U,$J,358.3,6739,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6739,1,3,0)
 ;;=3^Presence of Bilateral Artificial Arms
 ;;^UTILITY(U,$J,358.3,6739,1,4,0)
 ;;=4^Z97.15
 ;;^UTILITY(U,$J,358.3,6739,2)
 ;;=^5063726
 ;;^UTILITY(U,$J,358.3,6740,0)
 ;;=Z97.16^^26^403^124
 ;;^UTILITY(U,$J,358.3,6740,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6740,1,3,0)
 ;;=3^Presence of Bilateral Artificial Legs
 ;;^UTILITY(U,$J,358.3,6740,1,4,0)
 ;;=4^Z97.16
 ;;^UTILITY(U,$J,358.3,6740,2)
 ;;=^5063727
 ;;^UTILITY(U,$J,358.3,6741,0)
 ;;=Z98.61^^26^403^17
 ;;^UTILITY(U,$J,358.3,6741,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6741,1,3,0)
 ;;=3^Coronary Angioplasty Status
 ;;^UTILITY(U,$J,358.3,6741,1,4,0)
 ;;=4^Z98.61
 ;;^UTILITY(U,$J,358.3,6741,2)
 ;;=^5063742
 ;;^UTILITY(U,$J,358.3,6742,0)
 ;;=Z98.62^^26^403^73
 ;;^UTILITY(U,$J,358.3,6742,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6742,1,3,0)
 ;;=3^Peripheral Vascular Angioplasty Status
 ;;^UTILITY(U,$J,358.3,6742,1,4,0)
 ;;=4^Z98.62
 ;;^UTILITY(U,$J,358.3,6742,2)
 ;;=^5063743
 ;;^UTILITY(U,$J,358.3,6743,0)
 ;;=Z98.84^^26^403^12
 ;;^UTILITY(U,$J,358.3,6743,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6743,1,3,0)
 ;;=3^Bariatric Surgery Status
 ;;^UTILITY(U,$J,358.3,6743,1,4,0)
 ;;=4^Z98.84
 ;;^UTILITY(U,$J,358.3,6743,2)
 ;;=^5063749
 ;;^UTILITY(U,$J,358.3,6744,0)
 ;;=Z99.2^^26^403^141
 ;;^UTILITY(U,$J,358.3,6744,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6744,1,3,0)
 ;;=3^Renal Dialysis Dependence
 ;;^UTILITY(U,$J,358.3,6744,1,4,0)
 ;;=4^Z99.2
 ;;^UTILITY(U,$J,358.3,6744,2)
 ;;=^5063758
 ;;^UTILITY(U,$J,358.3,6745,0)
 ;;=Z99.81^^26^403^144
 ;;^UTILITY(U,$J,358.3,6745,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6745,1,3,0)
 ;;=3^Supplemental Oxygen Dependence
 ;;^UTILITY(U,$J,358.3,6745,1,4,0)
 ;;=4^Z99.81
 ;;^UTILITY(U,$J,358.3,6745,2)
 ;;=^5063760
 ;;^UTILITY(U,$J,358.3,6746,0)
 ;;=Z90.79^^26^403^2
 ;;^UTILITY(U,$J,358.3,6746,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6746,1,3,0)
 ;;=3^Acquired Absence of Genital Organs NEC
 ;;^UTILITY(U,$J,358.3,6746,1,4,0)
 ;;=4^Z90.79
 ;;^UTILITY(U,$J,358.3,6746,2)
 ;;=^5063596
 ;;^UTILITY(U,$J,358.3,6747,0)
 ;;=Z90.5^^26^403^3
 ;;^UTILITY(U,$J,358.3,6747,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6747,1,3,0)
 ;;=3^Acquired Absence of Kidney
 ;;^UTILITY(U,$J,358.3,6747,1,4,0)
 ;;=4^Z90.5
 ;;^UTILITY(U,$J,358.3,6747,2)
 ;;=^5063590
 ;;^UTILITY(U,$J,358.3,6748,0)
 ;;=Z90.2^^26^403^6
 ;;^UTILITY(U,$J,358.3,6748,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6748,1,3,0)
 ;;=3^Acquired Absence of Lung (part of)
 ;;^UTILITY(U,$J,358.3,6748,1,4,0)
 ;;=4^Z90.2
 ;;^UTILITY(U,$J,358.3,6748,2)
 ;;=^5063585
 ;;^UTILITY(U,$J,358.3,6749,0)
 ;;=Z98.1^^26^403^10
 ;;^UTILITY(U,$J,358.3,6749,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6749,1,3,0)
 ;;=3^Arthrodesis Status
 ;;^UTILITY(U,$J,358.3,6749,1,4,0)
 ;;=4^Z98.1
 ;;^UTILITY(U,$J,358.3,6749,2)
 ;;=^5063734
