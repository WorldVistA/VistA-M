IBDEI0IG ; ; 09-AUG-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,23407,0)
 ;;=Z56.5^^61^902^9
 ;;^UTILITY(U,$J,358.3,23407,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23407,1,3,0)
 ;;=3^Uncongenial Work Environment
 ;;^UTILITY(U,$J,358.3,23407,1,4,0)
 ;;=4^Z56.5
 ;;^UTILITY(U,$J,358.3,23407,2)
 ;;=^5063112
 ;;^UTILITY(U,$J,358.3,23408,0)
 ;;=Z56.6^^61^902^4
 ;;^UTILITY(U,$J,358.3,23408,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23408,1,3,0)
 ;;=3^Physical & Mental Strain Related to Work,Other
 ;;^UTILITY(U,$J,358.3,23408,1,4,0)
 ;;=4^Z56.6
 ;;^UTILITY(U,$J,358.3,23408,2)
 ;;=^5063113
 ;;^UTILITY(U,$J,358.3,23409,0)
 ;;=Z56.89^^61^902^6
 ;;^UTILITY(U,$J,358.3,23409,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23409,1,3,0)
 ;;=3^Problems Related to Employment,Other
 ;;^UTILITY(U,$J,358.3,23409,1,4,0)
 ;;=4^Z56.89
 ;;^UTILITY(U,$J,358.3,23409,2)
 ;;=^5063116
 ;;^UTILITY(U,$J,358.3,23410,0)
 ;;=F64.1^^61^903^1
 ;;^UTILITY(U,$J,358.3,23410,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23410,1,3,0)
 ;;=3^Gender Dysphoria in Adolescents & Adults
 ;;^UTILITY(U,$J,358.3,23410,1,4,0)
 ;;=4^F64.1
 ;;^UTILITY(U,$J,358.3,23410,2)
 ;;=^5003647
 ;;^UTILITY(U,$J,358.3,23411,0)
 ;;=F64.8^^61^903^2
 ;;^UTILITY(U,$J,358.3,23411,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23411,1,3,0)
 ;;=3^Gender Dysphoria,Other Specified
 ;;^UTILITY(U,$J,358.3,23411,1,4,0)
 ;;=4^F64.8
 ;;^UTILITY(U,$J,358.3,23411,2)
 ;;=^5003649
 ;;^UTILITY(U,$J,358.3,23412,0)
 ;;=F64.9^^61^903^3
 ;;^UTILITY(U,$J,358.3,23412,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23412,1,3,0)
 ;;=3^Gender Dysphoria,Unspec
 ;;^UTILITY(U,$J,358.3,23412,1,4,0)
 ;;=4^F64.9
 ;;^UTILITY(U,$J,358.3,23412,2)
 ;;=^5003650
 ;;^UTILITY(U,$J,358.3,23413,0)
 ;;=Z59.2^^61^904^1
 ;;^UTILITY(U,$J,358.3,23413,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23413,1,3,0)
 ;;=3^Discord w/ Neighbor,Lodger or Landlord
 ;;^UTILITY(U,$J,358.3,23413,1,4,0)
 ;;=4^Z59.2
 ;;^UTILITY(U,$J,358.3,23413,2)
 ;;=^5063131
 ;;^UTILITY(U,$J,358.3,23414,0)
 ;;=Z59.0^^61^904^3
 ;;^UTILITY(U,$J,358.3,23414,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23414,1,3,0)
 ;;=3^Homelessness
 ;;^UTILITY(U,$J,358.3,23414,1,4,0)
 ;;=4^Z59.0
 ;;^UTILITY(U,$J,358.3,23414,2)
 ;;=^5063129
 ;;^UTILITY(U,$J,358.3,23415,0)
 ;;=Z59.1^^61^904^5
 ;;^UTILITY(U,$J,358.3,23415,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23415,1,3,0)
 ;;=3^Inadequate Housing
 ;;^UTILITY(U,$J,358.3,23415,1,4,0)
 ;;=4^Z59.1
 ;;^UTILITY(U,$J,358.3,23415,2)
 ;;=^5063130
 ;;^UTILITY(U,$J,358.3,23416,0)
 ;;=Z59.3^^61^904^9
 ;;^UTILITY(U,$J,358.3,23416,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23416,1,3,0)
 ;;=3^Problems Related to Living in Residential Institution
 ;;^UTILITY(U,$J,358.3,23416,1,4,0)
 ;;=4^Z59.3
 ;;^UTILITY(U,$J,358.3,23416,2)
 ;;=^5063132
 ;;^UTILITY(U,$J,358.3,23417,0)
 ;;=Z59.4^^61^904^7
 ;;^UTILITY(U,$J,358.3,23417,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23417,1,3,0)
 ;;=3^Lack of Adequate Food or Safe Drinking Water
 ;;^UTILITY(U,$J,358.3,23417,1,4,0)
 ;;=4^Z59.4
 ;;^UTILITY(U,$J,358.3,23417,2)
 ;;=^5063133
 ;;^UTILITY(U,$J,358.3,23418,0)
 ;;=Z59.5^^61^904^2
 ;;^UTILITY(U,$J,358.3,23418,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23418,1,3,0)
 ;;=3^Extreme Poverty
 ;;^UTILITY(U,$J,358.3,23418,1,4,0)
 ;;=4^Z59.5
 ;;^UTILITY(U,$J,358.3,23418,2)
 ;;=^5063134
 ;;^UTILITY(U,$J,358.3,23419,0)
 ;;=Z59.6^^61^904^8
 ;;^UTILITY(U,$J,358.3,23419,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23419,1,3,0)
 ;;=3^Low Income
 ;;^UTILITY(U,$J,358.3,23419,1,4,0)
 ;;=4^Z59.6
 ;;^UTILITY(U,$J,358.3,23419,2)
 ;;=^5063135
 ;;^UTILITY(U,$J,358.3,23420,0)
 ;;=Z59.7^^61^904^6
 ;;^UTILITY(U,$J,358.3,23420,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23420,1,3,0)
 ;;=3^Insufficient Social Insurance/Welfare Support
 ;;^UTILITY(U,$J,358.3,23420,1,4,0)
 ;;=4^Z59.7
 ;;^UTILITY(U,$J,358.3,23420,2)
 ;;=^5063136
 ;;^UTILITY(U,$J,358.3,23421,0)
 ;;=Z59.9^^61^904^4
 ;;^UTILITY(U,$J,358.3,23421,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23421,1,3,0)
 ;;=3^Housing/Economic Problems,Unspec
 ;;^UTILITY(U,$J,358.3,23421,1,4,0)
 ;;=4^Z59.9
 ;;^UTILITY(U,$J,358.3,23421,2)
 ;;=^5063138
 ;;^UTILITY(U,$J,358.3,23422,0)
 ;;=G21.19^^61^905^10
 ;;^UTILITY(U,$J,358.3,23422,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23422,1,3,0)
 ;;=3^Medication-Induced Parkinsonism,Other
 ;;^UTILITY(U,$J,358.3,23422,1,4,0)
 ;;=4^G21.19
 ;;^UTILITY(U,$J,358.3,23422,2)
 ;;=^5003773
 ;;^UTILITY(U,$J,358.3,23423,0)
 ;;=G21.11^^61^905^13
 ;;^UTILITY(U,$J,358.3,23423,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23423,1,3,0)
 ;;=3^Neuroleptic-Induced Parkinsonism
 ;;^UTILITY(U,$J,358.3,23423,1,4,0)
 ;;=4^G21.11
 ;;^UTILITY(U,$J,358.3,23423,2)
 ;;=^5003772
 ;;^UTILITY(U,$J,358.3,23424,0)
 ;;=G24.01^^61^905^15
 ;;^UTILITY(U,$J,358.3,23424,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23424,1,3,0)
 ;;=3^Tardive Dyskinesia
 ;;^UTILITY(U,$J,358.3,23424,1,4,0)
 ;;=4^G24.01
 ;;^UTILITY(U,$J,358.3,23424,2)
 ;;=^5003784
 ;;^UTILITY(U,$J,358.3,23425,0)
 ;;=G24.09^^61^905^16
 ;;^UTILITY(U,$J,358.3,23425,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23425,1,3,0)
 ;;=3^Tardive Dystonia
 ;;^UTILITY(U,$J,358.3,23425,1,4,0)
 ;;=4^G24.09
 ;;^UTILITY(U,$J,358.3,23425,2)
 ;;=^5003786
 ;;^UTILITY(U,$J,358.3,23426,0)
 ;;=G25.1^^61^905^11
 ;;^UTILITY(U,$J,358.3,23426,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23426,1,3,0)
 ;;=3^Medication-Induced Postural Tremor
 ;;^UTILITY(U,$J,358.3,23426,1,4,0)
 ;;=4^G25.1
 ;;^UTILITY(U,$J,358.3,23426,2)
 ;;=^5003792
 ;;^UTILITY(U,$J,358.3,23427,0)
 ;;=G25.71^^61^905^14
 ;;^UTILITY(U,$J,358.3,23427,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23427,1,3,0)
 ;;=3^Tardive Akathisia
 ;;^UTILITY(U,$J,358.3,23427,1,4,0)
 ;;=4^G25.71
 ;;^UTILITY(U,$J,358.3,23427,2)
 ;;=^5003799
 ;;^UTILITY(U,$J,358.3,23428,0)
 ;;=G25.79^^61^905^9
 ;;^UTILITY(U,$J,358.3,23428,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23428,1,3,0)
 ;;=3^Medication-Induced Movement Disorder,Other
 ;;^UTILITY(U,$J,358.3,23428,1,4,0)
 ;;=4^G25.79
 ;;^UTILITY(U,$J,358.3,23428,2)
 ;;=^5003800
 ;;^UTILITY(U,$J,358.3,23429,0)
 ;;=T43.205A^^61^905^4
 ;;^UTILITY(U,$J,358.3,23429,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23429,1,3,0)
 ;;=3^Antidepressant Discontinuation Syndrome,Init Encntr
 ;;^UTILITY(U,$J,358.3,23429,1,4,0)
 ;;=4^T43.205A
 ;;^UTILITY(U,$J,358.3,23429,2)
 ;;=^5050540
 ;;^UTILITY(U,$J,358.3,23430,0)
 ;;=T43.205D^^61^905^5
 ;;^UTILITY(U,$J,358.3,23430,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23430,1,3,0)
 ;;=3^Antidepressant Discontinuation Syndrome,Subseq Encntr
 ;;^UTILITY(U,$J,358.3,23430,1,4,0)
 ;;=4^T43.205D
 ;;^UTILITY(U,$J,358.3,23430,2)
 ;;=^5050541
 ;;^UTILITY(U,$J,358.3,23431,0)
 ;;=T43.205S^^61^905^6
 ;;^UTILITY(U,$J,358.3,23431,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23431,1,3,0)
 ;;=3^Antidepressant Discontinuation Syndrome,Sequela
 ;;^UTILITY(U,$J,358.3,23431,1,4,0)
 ;;=4^T43.205S
 ;;^UTILITY(U,$J,358.3,23431,2)
 ;;=^5050542
 ;;^UTILITY(U,$J,358.3,23432,0)
 ;;=G25.71^^61^905^7
 ;;^UTILITY(U,$J,358.3,23432,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23432,1,3,0)
 ;;=3^Medication-Induced Acute Akathisia
 ;;^UTILITY(U,$J,358.3,23432,1,4,0)
 ;;=4^G25.71
 ;;^UTILITY(U,$J,358.3,23432,2)
 ;;=^5003799
 ;;^UTILITY(U,$J,358.3,23433,0)
 ;;=G24.02^^61^905^8
 ;;^UTILITY(U,$J,358.3,23433,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23433,1,3,0)
 ;;=3^Medication-Induced Acute Dystonia
 ;;^UTILITY(U,$J,358.3,23433,1,4,0)
 ;;=4^G24.02
 ;;^UTILITY(U,$J,358.3,23433,2)
 ;;=^5003785
 ;;^UTILITY(U,$J,358.3,23434,0)
 ;;=G21.0^^61^905^12
 ;;^UTILITY(U,$J,358.3,23434,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23434,1,3,0)
 ;;=3^Neuroleptic Malignant Syndrome
 ;;^UTILITY(U,$J,358.3,23434,1,4,0)
 ;;=4^G21.0
 ;;^UTILITY(U,$J,358.3,23434,2)
 ;;=^5003771
 ;;^UTILITY(U,$J,358.3,23435,0)
 ;;=T50.905A^^61^905^1
 ;;^UTILITY(U,$J,358.3,23435,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23435,1,3,0)
 ;;=3^Adverse Effect of Medication,Other,Init Encntr
 ;;^UTILITY(U,$J,358.3,23435,1,4,0)
 ;;=4^T50.905A
 ;;^UTILITY(U,$J,358.3,23435,2)
 ;;=^5052160
 ;;^UTILITY(U,$J,358.3,23436,0)
 ;;=T50.905S^^61^905^2
 ;;^UTILITY(U,$J,358.3,23436,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23436,1,3,0)
 ;;=3^Adverse Effect of Medication,Other,Sequela
 ;;^UTILITY(U,$J,358.3,23436,1,4,0)
 ;;=4^T50.905S
 ;;^UTILITY(U,$J,358.3,23436,2)
 ;;=^5052162
 ;;^UTILITY(U,$J,358.3,23437,0)
 ;;=T50.905D^^61^905^3
 ;;^UTILITY(U,$J,358.3,23437,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23437,1,3,0)
 ;;=3^Adverse Effect of Medication,Other,Subseq Encntr
 ;;^UTILITY(U,$J,358.3,23437,1,4,0)
 ;;=4^T50.905D
 ;;^UTILITY(U,$J,358.3,23437,2)
 ;;=^5052161
 ;;^UTILITY(U,$J,358.3,23438,0)
 ;;=F42.^^61^906^5
 ;;^UTILITY(U,$J,358.3,23438,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23438,1,3,0)
 ;;=3^Obsessive-Compulsive Disorder
 ;;^UTILITY(U,$J,358.3,23438,1,4,0)
 ;;=4^F42.
 ;;^UTILITY(U,$J,358.3,23438,2)
 ;;=^5003568
 ;;^UTILITY(U,$J,358.3,23439,0)
 ;;=F45.22^^61^906^1
 ;;^UTILITY(U,$J,358.3,23439,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23439,1,3,0)
 ;;=3^Body Dysmorphic Disorder
 ;;^UTILITY(U,$J,358.3,23439,1,4,0)
 ;;=4^F45.22
 ;;^UTILITY(U,$J,358.3,23439,2)
 ;;=^5003588
 ;;^UTILITY(U,$J,358.3,23440,0)
 ;;=F63.3^^61^906^6
 ;;^UTILITY(U,$J,358.3,23440,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23440,1,3,0)
 ;;=3^Trichotillomania (Hair-Pulling Disorder)
 ;;^UTILITY(U,$J,358.3,23440,1,4,0)
 ;;=4^F63.3
 ;;^UTILITY(U,$J,358.3,23440,2)
 ;;=^5003643
 ;;^UTILITY(U,$J,358.3,23441,0)
 ;;=L98.1^^61^906^2
 ;;^UTILITY(U,$J,358.3,23441,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23441,1,3,0)
 ;;=3^Excoriation (Skin-Picking) Disorder
 ;;^UTILITY(U,$J,358.3,23441,1,4,0)
 ;;=4^L98.1
 ;;^UTILITY(U,$J,358.3,23441,2)
 ;;=^186781
 ;;^UTILITY(U,$J,358.3,23442,0)
 ;;=F42.^^61^906^3
 ;;^UTILITY(U,$J,358.3,23442,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23442,1,3,0)
 ;;=3^Hoarding Disorder
