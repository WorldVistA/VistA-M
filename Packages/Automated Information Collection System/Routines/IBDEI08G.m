IBDEI08G ; ; 12-MAY-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,8401,1,3,0)
 ;;=3^Abnormal Finding on Dx Image of Digestive Tract Part
 ;;^UTILITY(U,$J,358.3,8401,1,4,0)
 ;;=4^R93.3
 ;;^UTILITY(U,$J,358.3,8401,2)
 ;;=^5019716
 ;;^UTILITY(U,$J,358.3,8402,0)
 ;;=R93.4^^42^510^14
 ;;^UTILITY(U,$J,358.3,8402,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8402,1,3,0)
 ;;=3^Abnormal Finding on Dx Image of Urinary Organs
 ;;^UTILITY(U,$J,358.3,8402,1,4,0)
 ;;=4^R93.4
 ;;^UTILITY(U,$J,358.3,8402,2)
 ;;=^5019717
 ;;^UTILITY(U,$J,358.3,8403,0)
 ;;=R93.5^^42^510^6
 ;;^UTILITY(U,$J,358.3,8403,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8403,1,3,0)
 ;;=3^Abnormal Finding on Dx Image of Abdominal Regions
 ;;^UTILITY(U,$J,358.3,8403,1,4,0)
 ;;=4^R93.5
 ;;^UTILITY(U,$J,358.3,8403,2)
 ;;=^5019718
 ;;^UTILITY(U,$J,358.3,8404,0)
 ;;=R93.6^^42^510^11
 ;;^UTILITY(U,$J,358.3,8404,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8404,1,3,0)
 ;;=3^Abnormal Finding on Dx Image of Limbs
 ;;^UTILITY(U,$J,358.3,8404,1,4,0)
 ;;=4^R93.6
 ;;^UTILITY(U,$J,358.3,8404,2)
 ;;=^5019719
 ;;^UTILITY(U,$J,358.3,8405,0)
 ;;=R94.4^^42^510^16
 ;;^UTILITY(U,$J,358.3,8405,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8405,1,3,0)
 ;;=3^Abnormal Kidney Function Studies
 ;;^UTILITY(U,$J,358.3,8405,1,4,0)
 ;;=4^R94.4
 ;;^UTILITY(U,$J,358.3,8405,2)
 ;;=^5019741
 ;;^UTILITY(U,$J,358.3,8406,0)
 ;;=R94.5^^42^510^17
 ;;^UTILITY(U,$J,358.3,8406,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8406,1,3,0)
 ;;=3^Abnormal Liver Function Studies
 ;;^UTILITY(U,$J,358.3,8406,1,4,0)
 ;;=4^R94.5
 ;;^UTILITY(U,$J,358.3,8406,2)
 ;;=^5019742
 ;;^UTILITY(U,$J,358.3,8407,0)
 ;;=R94.6^^42^510^21
 ;;^UTILITY(U,$J,358.3,8407,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8407,1,3,0)
 ;;=3^Abnormal Thyroid Function Studies
 ;;^UTILITY(U,$J,358.3,8407,1,4,0)
 ;;=4^R94.6
 ;;^UTILITY(U,$J,358.3,8407,2)
 ;;=^5019743
 ;;^UTILITY(U,$J,358.3,8408,0)
 ;;=R94.7^^42^510^5
 ;;^UTILITY(U,$J,358.3,8408,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8408,1,3,0)
 ;;=3^Abnormal Endocrine Function Sutdies NEC
 ;;^UTILITY(U,$J,358.3,8408,1,4,0)
 ;;=4^R94.7
 ;;^UTILITY(U,$J,358.3,8408,2)
 ;;=^5019744
 ;;^UTILITY(U,$J,358.3,8409,0)
 ;;=R94.31^^42^510^4
 ;;^UTILITY(U,$J,358.3,8409,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8409,1,3,0)
 ;;=3^Abnormal EKG
 ;;^UTILITY(U,$J,358.3,8409,1,4,0)
 ;;=4^R94.31
 ;;^UTILITY(U,$J,358.3,8409,2)
 ;;=^5019739
 ;;^UTILITY(U,$J,358.3,8410,0)
 ;;=R97.0^^42^510^71
 ;;^UTILITY(U,$J,358.3,8410,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8410,1,3,0)
 ;;=3^Elevated Carcinoembryonic Antigen 
 ;;^UTILITY(U,$J,358.3,8410,1,4,0)
 ;;=4^R97.0
 ;;^UTILITY(U,$J,358.3,8410,2)
 ;;=^5019746
 ;;^UTILITY(U,$J,358.3,8411,0)
 ;;=R97.1^^42^510^70
 ;;^UTILITY(U,$J,358.3,8411,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8411,1,3,0)
 ;;=3^Elevated Cancer Antigen 125
 ;;^UTILITY(U,$J,358.3,8411,1,4,0)
 ;;=4^R97.1
 ;;^UTILITY(U,$J,358.3,8411,2)
 ;;=^5019747
 ;;^UTILITY(U,$J,358.3,8412,0)
 ;;=R97.2^^42^510^72
 ;;^UTILITY(U,$J,358.3,8412,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8412,1,3,0)
 ;;=3^Elevated PSA
 ;;^UTILITY(U,$J,358.3,8412,1,4,0)
 ;;=4^R97.2
 ;;^UTILITY(U,$J,358.3,8412,2)
 ;;=^5019748
 ;;^UTILITY(U,$J,358.3,8413,0)
 ;;=R97.8^^42^510^22
 ;;^UTILITY(U,$J,358.3,8413,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8413,1,3,0)
 ;;=3^Abnormal Tumor Markers NEC
 ;;^UTILITY(U,$J,358.3,8413,1,4,0)
 ;;=4^R97.8
 ;;^UTILITY(U,$J,358.3,8413,2)
 ;;=^5019749
 ;;^UTILITY(U,$J,358.3,8414,0)
 ;;=R93.8^^42^510^7
 ;;^UTILITY(U,$J,358.3,8414,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8414,1,3,0)
 ;;=3^Abnormal Finding on Dx Image of Body Structures
 ;;^UTILITY(U,$J,358.3,8414,1,4,0)
 ;;=4^R93.8
 ;;^UTILITY(U,$J,358.3,8414,2)
 ;;=^5019721
 ;;^UTILITY(U,$J,358.3,8415,0)
 ;;=R93.1^^42^510^10
 ;;^UTILITY(U,$J,358.3,8415,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8415,1,3,0)
 ;;=3^Abnormal Finding on Dx Image of Heart/Cor Circ
 ;;^UTILITY(U,$J,358.3,8415,1,4,0)
 ;;=4^R93.1
 ;;^UTILITY(U,$J,358.3,8415,2)
 ;;=^5019714
 ;;^UTILITY(U,$J,358.3,8416,0)
 ;;=R68.83^^42^510^49
 ;;^UTILITY(U,$J,358.3,8416,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8416,1,3,0)
 ;;=3^Chills w/o Fever
 ;;^UTILITY(U,$J,358.3,8416,1,4,0)
 ;;=4^R68.83
 ;;^UTILITY(U,$J,358.3,8416,2)
 ;;=^5019555
 ;;^UTILITY(U,$J,358.3,8417,0)
 ;;=R68.2^^42^510^66
 ;;^UTILITY(U,$J,358.3,8417,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8417,1,3,0)
 ;;=3^Dry Mouth,Unspec
 ;;^UTILITY(U,$J,358.3,8417,1,4,0)
 ;;=4^R68.2
 ;;^UTILITY(U,$J,358.3,8417,2)
 ;;=^5019552
 ;;^UTILITY(U,$J,358.3,8418,0)
 ;;=R09.02^^42^510^95
 ;;^UTILITY(U,$J,358.3,8418,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8418,1,3,0)
 ;;=3^Hypoxemia
 ;;^UTILITY(U,$J,358.3,8418,1,4,0)
 ;;=4^R09.02
 ;;^UTILITY(U,$J,358.3,8418,2)
 ;;=^332831
 ;;^UTILITY(U,$J,358.3,8419,0)
 ;;=R39.81^^42^510^99
 ;;^UTILITY(U,$J,358.3,8419,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8419,1,3,0)
 ;;=3^Incontinence d/t Cognitive Imprmt/Svr Disability/Mobility
 ;;^UTILITY(U,$J,358.3,8419,1,4,0)
 ;;=4^R39.81
 ;;^UTILITY(U,$J,358.3,8419,2)
 ;;=^5019349
 ;;^UTILITY(U,$J,358.3,8420,0)
 ;;=R29.6^^42^510^154
 ;;^UTILITY(U,$J,358.3,8420,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8420,1,3,0)
 ;;=3^Repeated Falls
 ;;^UTILITY(U,$J,358.3,8420,1,4,0)
 ;;=4^R29.6
 ;;^UTILITY(U,$J,358.3,8420,2)
 ;;=^5019317
 ;;^UTILITY(U,$J,358.3,8421,0)
 ;;=R44.1^^42^510^168
 ;;^UTILITY(U,$J,358.3,8421,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8421,1,3,0)
 ;;=3^Visual Hallucinations
 ;;^UTILITY(U,$J,358.3,8421,1,4,0)
 ;;=4^R44.1
 ;;^UTILITY(U,$J,358.3,8421,2)
 ;;=^5019456
 ;;^UTILITY(U,$J,358.3,8422,0)
 ;;=R41.840^^42^510^44
 ;;^UTILITY(U,$J,358.3,8422,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8422,1,3,0)
 ;;=3^Attention and Concentration Deficit
 ;;^UTILITY(U,$J,358.3,8422,1,4,0)
 ;;=4^R41.840
 ;;^UTILITY(U,$J,358.3,8422,2)
 ;;=^5019443
 ;;^UTILITY(U,$J,358.3,8423,0)
 ;;=K59.00^^42^510^58
 ;;^UTILITY(U,$J,358.3,8423,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8423,1,3,0)
 ;;=3^Constipation,Unspec
 ;;^UTILITY(U,$J,358.3,8423,1,4,0)
 ;;=4^K59.00
 ;;^UTILITY(U,$J,358.3,8423,2)
 ;;=^323537
 ;;^UTILITY(U,$J,358.3,8424,0)
 ;;=K03.81^^42^510^59
 ;;^UTILITY(U,$J,358.3,8424,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8424,1,3,0)
 ;;=3^Cracked Tooth
 ;;^UTILITY(U,$J,358.3,8424,1,4,0)
 ;;=4^K03.81
 ;;^UTILITY(U,$J,358.3,8424,2)
 ;;=^5008391
 ;;^UTILITY(U,$J,358.3,8425,0)
 ;;=E86.0^^42^510^61
 ;;^UTILITY(U,$J,358.3,8425,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8425,1,3,0)
 ;;=3^Dehydration
 ;;^UTILITY(U,$J,358.3,8425,1,4,0)
 ;;=4^E86.0
 ;;^UTILITY(U,$J,358.3,8425,2)
 ;;=^332743
 ;;^UTILITY(U,$J,358.3,8426,0)
 ;;=S02.5XXA^^42^510^83
 ;;^UTILITY(U,$J,358.3,8426,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8426,1,3,0)
 ;;=3^Fx Tooth,Traumatic,Clsd Fx,Init Encntr
 ;;^UTILITY(U,$J,358.3,8426,1,4,0)
 ;;=4^S02.5XXA
 ;;^UTILITY(U,$J,358.3,8426,2)
 ;;=^5020360
 ;;^UTILITY(U,$J,358.3,8427,0)
 ;;=K08.530^^42^510^82
 ;;^UTILITY(U,$J,358.3,8427,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8427,1,3,0)
 ;;=3^Fx Dental Restorative Material w/o Loss of Material
 ;;^UTILITY(U,$J,358.3,8427,1,4,0)
 ;;=4^K08.530
 ;;^UTILITY(U,$J,358.3,8427,2)
 ;;=^5008460
 ;;^UTILITY(U,$J,358.3,8428,0)
 ;;=K08.531^^42^510^81
 ;;^UTILITY(U,$J,358.3,8428,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8428,1,3,0)
 ;;=3^Fx Dental Restorative Material w/ Loss of Material
 ;;^UTILITY(U,$J,358.3,8428,1,4,0)
 ;;=4^K08.531
 ;;^UTILITY(U,$J,358.3,8428,2)
 ;;=^5008461
 ;;^UTILITY(U,$J,358.3,8429,0)
 ;;=R53.0^^42^510^128
 ;;^UTILITY(U,$J,358.3,8429,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8429,1,3,0)
 ;;=3^Neoplastic Related Fatigue
 ;;^UTILITY(U,$J,358.3,8429,1,4,0)
 ;;=4^R53.0
 ;;^UTILITY(U,$J,358.3,8429,2)
 ;;=^5019515
 ;;^UTILITY(U,$J,358.3,8430,0)
 ;;=R11.11^^42^510^171
 ;;^UTILITY(U,$J,358.3,8430,1,0)
 ;;=^358.31IA^4^2
