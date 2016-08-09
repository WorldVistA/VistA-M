IBDEI06S ; ; 12-MAY-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,6684,1,4,0)
 ;;=4^Z51.81
 ;;^UTILITY(U,$J,358.3,6684,2)
 ;;=^5063064
 ;;^UTILITY(U,$J,358.3,6685,0)
 ;;=Z02.79^^42^483^11
 ;;^UTILITY(U,$J,358.3,6685,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6685,1,3,0)
 ;;=3^Issue of Medical Certificate NEC
 ;;^UTILITY(U,$J,358.3,6685,1,4,0)
 ;;=4^Z02.79
 ;;^UTILITY(U,$J,358.3,6685,2)
 ;;=^5062641
 ;;^UTILITY(U,$J,358.3,6686,0)
 ;;=Z76.0^^42^483^12
 ;;^UTILITY(U,$J,358.3,6686,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6686,1,3,0)
 ;;=3^Issue of Repeat Prescription
 ;;^UTILITY(U,$J,358.3,6686,1,4,0)
 ;;=4^Z76.0
 ;;^UTILITY(U,$J,358.3,6686,2)
 ;;=^5063297
 ;;^UTILITY(U,$J,358.3,6687,0)
 ;;=Z04.9^^42^483^3
 ;;^UTILITY(U,$J,358.3,6687,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6687,1,3,0)
 ;;=3^Exam & Observation for Unsp Reason
 ;;^UTILITY(U,$J,358.3,6687,1,4,0)
 ;;=4^Z04.9
 ;;^UTILITY(U,$J,358.3,6687,2)
 ;;=^5062666
 ;;^UTILITY(U,$J,358.3,6688,0)
 ;;=Z02.2^^42^483^4
 ;;^UTILITY(U,$J,358.3,6688,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6688,1,3,0)
 ;;=3^Exam for Admission to Residential Institution
 ;;^UTILITY(U,$J,358.3,6688,1,4,0)
 ;;=4^Z02.2
 ;;^UTILITY(U,$J,358.3,6688,2)
 ;;=^5062635
 ;;^UTILITY(U,$J,358.3,6689,0)
 ;;=Z02.4^^42^483^5
 ;;^UTILITY(U,$J,358.3,6689,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6689,1,3,0)
 ;;=3^Exam for Driving License
 ;;^UTILITY(U,$J,358.3,6689,1,4,0)
 ;;=4^Z02.4
 ;;^UTILITY(U,$J,358.3,6689,2)
 ;;=^5062637
 ;;^UTILITY(U,$J,358.3,6690,0)
 ;;=Z00.5^^42^483^7
 ;;^UTILITY(U,$J,358.3,6690,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6690,1,3,0)
 ;;=3^Exam of Potential Donor of Organ/Tissue
 ;;^UTILITY(U,$J,358.3,6690,1,4,0)
 ;;=4^Z00.5
 ;;^UTILITY(U,$J,358.3,6690,2)
 ;;=^5062607
 ;;^UTILITY(U,$J,358.3,6691,0)
 ;;=Z02.3^^42^483^6
 ;;^UTILITY(U,$J,358.3,6691,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6691,1,3,0)
 ;;=3^Exam for Recruitment to Armed Forces
 ;;^UTILITY(U,$J,358.3,6691,1,4,0)
 ;;=4^Z02.3
 ;;^UTILITY(U,$J,358.3,6691,2)
 ;;=^5062636
 ;;^UTILITY(U,$J,358.3,6692,0)
 ;;=Z02.89^^42^483^1
 ;;^UTILITY(U,$J,358.3,6692,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6692,1,3,0)
 ;;=3^Admin Exam NEC
 ;;^UTILITY(U,$J,358.3,6692,1,4,0)
 ;;=4^Z02.89
 ;;^UTILITY(U,$J,358.3,6692,2)
 ;;=^5062645
 ;;^UTILITY(U,$J,358.3,6693,0)
 ;;=Z00.8^^42^483^8
 ;;^UTILITY(U,$J,358.3,6693,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6693,1,3,0)
 ;;=3^General Exam NEC
 ;;^UTILITY(U,$J,358.3,6693,1,4,0)
 ;;=4^Z00.8
 ;;^UTILITY(U,$J,358.3,6693,2)
 ;;=^5062611
 ;;^UTILITY(U,$J,358.3,6694,0)
 ;;=Z02.1^^42^483^14
 ;;^UTILITY(U,$J,358.3,6694,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6694,1,3,0)
 ;;=3^Pre-Employment Exam
 ;;^UTILITY(U,$J,358.3,6694,1,4,0)
 ;;=4^Z02.1
 ;;^UTILITY(U,$J,358.3,6694,2)
 ;;=^5062634
 ;;^UTILITY(U,$J,358.3,6695,0)
 ;;=Z01.810^^42^483^2
 ;;^UTILITY(U,$J,358.3,6695,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6695,1,3,0)
 ;;=3^Cardiovascular Preprocedural Exam
 ;;^UTILITY(U,$J,358.3,6695,1,4,0)
 ;;=4^Z01.810
 ;;^UTILITY(U,$J,358.3,6695,2)
 ;;=^5062625
 ;;^UTILITY(U,$J,358.3,6696,0)
 ;;=Z01.811^^42^483^16
 ;;^UTILITY(U,$J,358.3,6696,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6696,1,3,0)
 ;;=3^Respiratory Preprocedural Exam
 ;;^UTILITY(U,$J,358.3,6696,1,4,0)
 ;;=4^Z01.811
 ;;^UTILITY(U,$J,358.3,6696,2)
 ;;=^5062626
 ;;^UTILITY(U,$J,358.3,6697,0)
 ;;=Z01.812^^42^483^13
 ;;^UTILITY(U,$J,358.3,6697,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6697,1,3,0)
 ;;=3^Lab Preprocedural Exam
 ;;^UTILITY(U,$J,358.3,6697,1,4,0)
 ;;=4^Z01.812
 ;;^UTILITY(U,$J,358.3,6697,2)
 ;;=^5062627
 ;;^UTILITY(U,$J,358.3,6698,0)
 ;;=Z01.818^^42^483^15
 ;;^UTILITY(U,$J,358.3,6698,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6698,1,3,0)
 ;;=3^Preprocedural Exam NEC
 ;;^UTILITY(U,$J,358.3,6698,1,4,0)
 ;;=4^Z01.818
 ;;^UTILITY(U,$J,358.3,6698,2)
 ;;=^5062628
 ;;^UTILITY(U,$J,358.3,6699,0)
 ;;=Z71.0^^42^483^9
 ;;^UTILITY(U,$J,358.3,6699,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6699,1,3,0)
 ;;=3^Hlth Service to Consult on Behalf of Another
 ;;^UTILITY(U,$J,358.3,6699,1,4,0)
 ;;=4^Z71.0
 ;;^UTILITY(U,$J,358.3,6699,2)
 ;;=^5063242
 ;;^UTILITY(U,$J,358.3,6700,0)
 ;;=Z59.8^^42^483^10
 ;;^UTILITY(U,$J,358.3,6700,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6700,1,3,0)
 ;;=3^Housing/Economic Circumstance Problems
 ;;^UTILITY(U,$J,358.3,6700,1,4,0)
 ;;=4^Z59.8
 ;;^UTILITY(U,$J,358.3,6700,2)
 ;;=^5063137
 ;;^UTILITY(U,$J,358.3,6701,0)
 ;;=I20.0^^42^484^14
 ;;^UTILITY(U,$J,358.3,6701,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6701,1,3,0)
 ;;=3^Unstable Angina
 ;;^UTILITY(U,$J,358.3,6701,1,4,0)
 ;;=4^I20.0
 ;;^UTILITY(U,$J,358.3,6701,2)
 ;;=^5007076
 ;;^UTILITY(U,$J,358.3,6702,0)
 ;;=I25.110^^42^484^7
 ;;^UTILITY(U,$J,358.3,6702,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6702,1,3,0)
 ;;=3^Athscl Hrt Dis of Native Cor Art w/ Unstable Ang Pctrs
 ;;^UTILITY(U,$J,358.3,6702,1,4,0)
 ;;=4^I25.110
 ;;^UTILITY(U,$J,358.3,6702,2)
 ;;=^5007108
 ;;^UTILITY(U,$J,358.3,6703,0)
 ;;=I25.700^^42^484^12
 ;;^UTILITY(U,$J,358.3,6703,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6703,1,3,0)
 ;;=3^Athscl of CABG,Unspec w/ Unstable Angina Pectoris
 ;;^UTILITY(U,$J,358.3,6703,1,4,0)
 ;;=4^I25.700
 ;;^UTILITY(U,$J,358.3,6703,2)
 ;;=^5007117
 ;;^UTILITY(U,$J,358.3,6704,0)
 ;;=I25.2^^42^484^13
 ;;^UTILITY(U,$J,358.3,6704,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6704,1,3,0)
 ;;=3^Old Myocardial Infarction
 ;;^UTILITY(U,$J,358.3,6704,1,4,0)
 ;;=4^I25.2
 ;;^UTILITY(U,$J,358.3,6704,2)
 ;;=^259884
 ;;^UTILITY(U,$J,358.3,6705,0)
 ;;=I20.8^^42^484^2
 ;;^UTILITY(U,$J,358.3,6705,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6705,1,3,0)
 ;;=3^Angina Pectoris,Oth Forms
 ;;^UTILITY(U,$J,358.3,6705,1,4,0)
 ;;=4^I20.8
 ;;^UTILITY(U,$J,358.3,6705,2)
 ;;=^5007078
 ;;^UTILITY(U,$J,358.3,6706,0)
 ;;=I20.1^^42^484^1
 ;;^UTILITY(U,$J,358.3,6706,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6706,1,3,0)
 ;;=3^Angina Pectoris w/ Documented Spasm
 ;;^UTILITY(U,$J,358.3,6706,1,4,0)
 ;;=4^I20.1
 ;;^UTILITY(U,$J,358.3,6706,2)
 ;;=^5007077
 ;;^UTILITY(U,$J,358.3,6707,0)
 ;;=I25.119^^42^484^5
 ;;^UTILITY(U,$J,358.3,6707,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6707,1,3,0)
 ;;=3^Athscl HRT Dis of Native Cor Art w/ Ang Pctrs,Unspec
 ;;^UTILITY(U,$J,358.3,6707,1,4,0)
 ;;=4^I25.119
 ;;^UTILITY(U,$J,358.3,6707,2)
 ;;=^5007111
 ;;^UTILITY(U,$J,358.3,6708,0)
 ;;=I25.701^^42^484^9
 ;;^UTILITY(U,$J,358.3,6708,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6708,1,3,0)
 ;;=3^Athscl of CABG,Unspec w/ Angina Pectoris w/ Documented Spasm
 ;;^UTILITY(U,$J,358.3,6708,1,4,0)
 ;;=4^I25.701
 ;;^UTILITY(U,$J,358.3,6708,2)
 ;;=^5007118
 ;;^UTILITY(U,$J,358.3,6709,0)
 ;;=I25.708^^42^484^10
 ;;^UTILITY(U,$J,358.3,6709,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6709,1,3,0)
 ;;=3^Athscl of CABG,Unspec w/ Oth Angina Pectoris
 ;;^UTILITY(U,$J,358.3,6709,1,4,0)
 ;;=4^I25.708
 ;;^UTILITY(U,$J,358.3,6709,2)
 ;;=^5007119
 ;;^UTILITY(U,$J,358.3,6710,0)
 ;;=I20.9^^42^484^3
 ;;^UTILITY(U,$J,358.3,6710,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6710,1,3,0)
 ;;=3^Angina Pectoris,Unspec
 ;;^UTILITY(U,$J,358.3,6710,1,4,0)
 ;;=4^I20.9
 ;;^UTILITY(U,$J,358.3,6710,2)
 ;;=^5007079
 ;;^UTILITY(U,$J,358.3,6711,0)
 ;;=I25.729^^42^484^4
 ;;^UTILITY(U,$J,358.3,6711,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6711,1,3,0)
 ;;=3^Athscl Autologous Artery CABG w/ Unspec Angina Pectoris
 ;;^UTILITY(U,$J,358.3,6711,1,4,0)
 ;;=4^I25.729
 ;;^UTILITY(U,$J,358.3,6711,2)
 ;;=^5133561
 ;;^UTILITY(U,$J,358.3,6712,0)
 ;;=I25.709^^42^484^11
 ;;^UTILITY(U,$J,358.3,6712,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6712,1,3,0)
 ;;=3^Athscl of CABG,Unspec w/ Unspec Angina Pectoris
 ;;^UTILITY(U,$J,358.3,6712,1,4,0)
 ;;=4^I25.709
 ;;^UTILITY(U,$J,358.3,6712,2)
 ;;=^5007120
 ;;^UTILITY(U,$J,358.3,6713,0)
 ;;=I25.10^^42^484^6
