IBDEI0MX ; ; 12-MAY-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,23121,2)
 ;;=^5019570
 ;;^UTILITY(U,$J,358.3,23122,0)
 ;;=R79.1^^89^1058^3
 ;;^UTILITY(U,$J,358.3,23122,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23122,1,3,0)
 ;;=3^Abnormal Coagulation Profile
 ;;^UTILITY(U,$J,358.3,23122,1,4,0)
 ;;=4^R79.1
 ;;^UTILITY(U,$J,358.3,23122,2)
 ;;=^5019591
 ;;^UTILITY(U,$J,358.3,23123,0)
 ;;=R82.5^^89^1058^69
 ;;^UTILITY(U,$J,358.3,23123,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23123,1,3,0)
 ;;=3^Elevated Urine Levels of Drug/Meds/Biol Subst
 ;;^UTILITY(U,$J,358.3,23123,1,4,0)
 ;;=4^R82.5
 ;;^UTILITY(U,$J,358.3,23123,2)
 ;;=^5019605
 ;;^UTILITY(U,$J,358.3,23124,0)
 ;;=R82.6^^89^1058^26
 ;;^UTILITY(U,$J,358.3,23124,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23124,1,3,0)
 ;;=3^Abnormal Urine Levels of Subst of Nonmed Source
 ;;^UTILITY(U,$J,358.3,23124,1,4,0)
 ;;=4^R82.6
 ;;^UTILITY(U,$J,358.3,23124,2)
 ;;=^5019606
 ;;^UTILITY(U,$J,358.3,23125,0)
 ;;=R82.7^^89^1058^27
 ;;^UTILITY(U,$J,358.3,23125,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23125,1,3,0)
 ;;=3^Abnormal Urine Microbiological Findings
 ;;^UTILITY(U,$J,358.3,23125,1,4,0)
 ;;=4^R82.7
 ;;^UTILITY(U,$J,358.3,23125,2)
 ;;=^5019607
 ;;^UTILITY(U,$J,358.3,23126,0)
 ;;=R82.8^^89^1058^23
 ;;^UTILITY(U,$J,358.3,23126,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23126,1,3,0)
 ;;=3^Abnormal Urine Cytology/Histology Findings
 ;;^UTILITY(U,$J,358.3,23126,1,4,0)
 ;;=4^R82.8
 ;;^UTILITY(U,$J,358.3,23126,2)
 ;;=^5019608
 ;;^UTILITY(U,$J,358.3,23127,0)
 ;;=R82.90^^89^1058^25
 ;;^UTILITY(U,$J,358.3,23127,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23127,1,3,0)
 ;;=3^Abnormal Urine Findings,Unspec
 ;;^UTILITY(U,$J,358.3,23127,1,4,0)
 ;;=4^R82.90
 ;;^UTILITY(U,$J,358.3,23127,2)
 ;;=^5019609
 ;;^UTILITY(U,$J,358.3,23128,0)
 ;;=R82.91^^89^1058^49
 ;;^UTILITY(U,$J,358.3,23128,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23128,1,3,0)
 ;;=3^Chromoabnormalities of Urine NEC
 ;;^UTILITY(U,$J,358.3,23128,1,4,0)
 ;;=4^R82.91
 ;;^UTILITY(U,$J,358.3,23128,2)
 ;;=^5019610
 ;;^UTILITY(U,$J,358.3,23129,0)
 ;;=R82.99^^89^1058^24
 ;;^UTILITY(U,$J,358.3,23129,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23129,1,3,0)
 ;;=3^Abnormal Urine Findings NEC
 ;;^UTILITY(U,$J,358.3,23129,1,4,0)
 ;;=4^R82.99
 ;;^UTILITY(U,$J,358.3,23129,2)
 ;;=^5019611
 ;;^UTILITY(U,$J,358.3,23130,0)
 ;;=R89.9^^89^1058^19
 ;;^UTILITY(U,$J,358.3,23130,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23130,1,3,0)
 ;;=3^Abnormal Organ/Tissue Specimen Findings,Unspec
 ;;^UTILITY(U,$J,358.3,23130,1,4,0)
 ;;=4^R89.9
 ;;^UTILITY(U,$J,358.3,23130,2)
 ;;=^5019702
 ;;^UTILITY(U,$J,358.3,23131,0)
 ;;=R90.0^^89^1058^98
 ;;^UTILITY(U,$J,358.3,23131,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23131,1,3,0)
 ;;=3^Intracranial Space-Occupying Lesion Dx Imaging of Central Nervous System
 ;;^UTILITY(U,$J,358.3,23131,1,4,0)
 ;;=4^R90.0
 ;;^UTILITY(U,$J,358.3,23131,2)
 ;;=^5019703
 ;;^UTILITY(U,$J,358.3,23132,0)
 ;;=R90.89^^89^1058^13
 ;;^UTILITY(U,$J,358.3,23132,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23132,1,3,0)
 ;;=3^Abnormal Findings on Dx Imaging of Central Nervous System NEC
 ;;^UTILITY(U,$J,358.3,23132,1,4,0)
 ;;=4^R90.89
 ;;^UTILITY(U,$J,358.3,23132,2)
 ;;=^5019706
 ;;^UTILITY(U,$J,358.3,23133,0)
 ;;=R91.8^^89^1058^18
 ;;^UTILITY(U,$J,358.3,23133,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23133,1,3,0)
 ;;=3^Abnormal Nonspecific Lung Field Finding NEC
 ;;^UTILITY(U,$J,358.3,23133,1,4,0)
 ;;=4^R91.8
 ;;^UTILITY(U,$J,358.3,23133,2)
 ;;=^5019708
 ;;^UTILITY(U,$J,358.3,23134,0)
 ;;=R92.0^^89^1058^117
 ;;^UTILITY(U,$J,358.3,23134,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23134,1,3,0)
 ;;=3^Mammographic Microcalcification on Dx Image of Breast
 ;;^UTILITY(U,$J,358.3,23134,1,4,0)
 ;;=4^R92.0
 ;;^UTILITY(U,$J,358.3,23134,2)
 ;;=^5019709
 ;;^UTILITY(U,$J,358.3,23135,0)
 ;;=R92.1^^89^1058^116
 ;;^UTILITY(U,$J,358.3,23135,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23135,1,3,0)
 ;;=3^Mammographic Calcification on Dx Image of Breast
 ;;^UTILITY(U,$J,358.3,23135,1,4,0)
 ;;=4^R92.1
 ;;^UTILITY(U,$J,358.3,23135,2)
 ;;=^5019710
 ;;^UTILITY(U,$J,358.3,23136,0)
 ;;=R92.2^^89^1058^91
 ;;^UTILITY(U,$J,358.3,23136,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23136,1,3,0)
 ;;=3^Inconclusive Mammogram
 ;;^UTILITY(U,$J,358.3,23136,1,4,0)
 ;;=4^R92.2
 ;;^UTILITY(U,$J,358.3,23136,2)
 ;;=^5019711
 ;;^UTILITY(U,$J,358.3,23137,0)
 ;;=R93.0^^89^1058^10
 ;;^UTILITY(U,$J,358.3,23137,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23137,1,3,0)
 ;;=3^Abnormal Finding on Dx Image of Skull/Head NEC
 ;;^UTILITY(U,$J,358.3,23137,1,4,0)
 ;;=4^R93.0
 ;;^UTILITY(U,$J,358.3,23137,2)
 ;;=^5019713
 ;;^UTILITY(U,$J,358.3,23138,0)
 ;;=R93.2^^89^1058^9
 ;;^UTILITY(U,$J,358.3,23138,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23138,1,3,0)
 ;;=3^Abnormal Finding on Dx Image of Liver/Biliary Tract
 ;;^UTILITY(U,$J,358.3,23138,1,4,0)
 ;;=4^R93.2
 ;;^UTILITY(U,$J,358.3,23138,2)
 ;;=^5019715
 ;;^UTILITY(U,$J,358.3,23139,0)
 ;;=R93.3^^89^1058^7
 ;;^UTILITY(U,$J,358.3,23139,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23139,1,3,0)
 ;;=3^Abnormal Finding on Dx Image of Digestive Tract Part
 ;;^UTILITY(U,$J,358.3,23139,1,4,0)
 ;;=4^R93.3
 ;;^UTILITY(U,$J,358.3,23139,2)
 ;;=^5019716
 ;;^UTILITY(U,$J,358.3,23140,0)
 ;;=R93.4^^89^1058^11
 ;;^UTILITY(U,$J,358.3,23140,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23140,1,3,0)
 ;;=3^Abnormal Finding on Dx Image of Urinary Organs
 ;;^UTILITY(U,$J,358.3,23140,1,4,0)
 ;;=4^R93.4
 ;;^UTILITY(U,$J,358.3,23140,2)
 ;;=^5019717
 ;;^UTILITY(U,$J,358.3,23141,0)
 ;;=R93.5^^89^1058^6
 ;;^UTILITY(U,$J,358.3,23141,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23141,1,3,0)
 ;;=3^Abnormal Finding on Dx Image of Abdominal Regions
 ;;^UTILITY(U,$J,358.3,23141,1,4,0)
 ;;=4^R93.5
 ;;^UTILITY(U,$J,358.3,23141,2)
 ;;=^5019718
 ;;^UTILITY(U,$J,358.3,23142,0)
 ;;=R93.6^^89^1058^8
 ;;^UTILITY(U,$J,358.3,23142,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23142,1,3,0)
 ;;=3^Abnormal Finding on Dx Image of Limbs
 ;;^UTILITY(U,$J,358.3,23142,1,4,0)
 ;;=4^R93.6
 ;;^UTILITY(U,$J,358.3,23142,2)
 ;;=^5019719
 ;;^UTILITY(U,$J,358.3,23143,0)
 ;;=R94.4^^89^1058^16
 ;;^UTILITY(U,$J,358.3,23143,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23143,1,3,0)
 ;;=3^Abnormal Kidney Function Studies
 ;;^UTILITY(U,$J,358.3,23143,1,4,0)
 ;;=4^R94.4
 ;;^UTILITY(U,$J,358.3,23143,2)
 ;;=^5019741
 ;;^UTILITY(U,$J,358.3,23144,0)
 ;;=R94.5^^89^1058^17
 ;;^UTILITY(U,$J,358.3,23144,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23144,1,3,0)
 ;;=3^Abnormal Liver Function Studies
 ;;^UTILITY(U,$J,358.3,23144,1,4,0)
 ;;=4^R94.5
 ;;^UTILITY(U,$J,358.3,23144,2)
 ;;=^5019742
 ;;^UTILITY(U,$J,358.3,23145,0)
 ;;=R94.6^^89^1058^21
 ;;^UTILITY(U,$J,358.3,23145,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23145,1,3,0)
 ;;=3^Abnormal Thyroid Function Studies
 ;;^UTILITY(U,$J,358.3,23145,1,4,0)
 ;;=4^R94.6
 ;;^UTILITY(U,$J,358.3,23145,2)
 ;;=^5019743
 ;;^UTILITY(U,$J,358.3,23146,0)
 ;;=R94.7^^89^1058^5
 ;;^UTILITY(U,$J,358.3,23146,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23146,1,3,0)
 ;;=3^Abnormal Endocrine Function Sutdies NEC
 ;;^UTILITY(U,$J,358.3,23146,1,4,0)
 ;;=4^R94.7
 ;;^UTILITY(U,$J,358.3,23146,2)
 ;;=^5019744
 ;;^UTILITY(U,$J,358.3,23147,0)
 ;;=R94.31^^89^1058^4
 ;;^UTILITY(U,$J,358.3,23147,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23147,1,3,0)
 ;;=3^Abnormal EKG
 ;;^UTILITY(U,$J,358.3,23147,1,4,0)
 ;;=4^R94.31
 ;;^UTILITY(U,$J,358.3,23147,2)
 ;;=^5019739
 ;;^UTILITY(U,$J,358.3,23148,0)
 ;;=R97.0^^89^1058^67
 ;;^UTILITY(U,$J,358.3,23148,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23148,1,3,0)
 ;;=3^Elevated Carcinoembryonic Antigen 
 ;;^UTILITY(U,$J,358.3,23148,1,4,0)
 ;;=4^R97.0
 ;;^UTILITY(U,$J,358.3,23148,2)
 ;;=^5019746
 ;;^UTILITY(U,$J,358.3,23149,0)
 ;;=R97.1^^89^1058^66
