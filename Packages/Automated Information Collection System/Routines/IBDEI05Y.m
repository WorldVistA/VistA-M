IBDEI05Y ; ; 09-AUG-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,7410,0)
 ;;=R94.7^^26^414^5
 ;;^UTILITY(U,$J,358.3,7410,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7410,1,3,0)
 ;;=3^Abnormal Endocrine Function Sutdies NEC
 ;;^UTILITY(U,$J,358.3,7410,1,4,0)
 ;;=4^R94.7
 ;;^UTILITY(U,$J,358.3,7410,2)
 ;;=^5019744
 ;;^UTILITY(U,$J,358.3,7411,0)
 ;;=R94.31^^26^414^4
 ;;^UTILITY(U,$J,358.3,7411,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7411,1,3,0)
 ;;=3^Abnormal EKG
 ;;^UTILITY(U,$J,358.3,7411,1,4,0)
 ;;=4^R94.31
 ;;^UTILITY(U,$J,358.3,7411,2)
 ;;=^5019739
 ;;^UTILITY(U,$J,358.3,7412,0)
 ;;=R97.0^^26^414^71
 ;;^UTILITY(U,$J,358.3,7412,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7412,1,3,0)
 ;;=3^Elevated Carcinoembryonic Antigen 
 ;;^UTILITY(U,$J,358.3,7412,1,4,0)
 ;;=4^R97.0
 ;;^UTILITY(U,$J,358.3,7412,2)
 ;;=^5019746
 ;;^UTILITY(U,$J,358.3,7413,0)
 ;;=R97.1^^26^414^70
 ;;^UTILITY(U,$J,358.3,7413,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7413,1,3,0)
 ;;=3^Elevated Cancer Antigen 125
 ;;^UTILITY(U,$J,358.3,7413,1,4,0)
 ;;=4^R97.1
 ;;^UTILITY(U,$J,358.3,7413,2)
 ;;=^5019747
 ;;^UTILITY(U,$J,358.3,7414,0)
 ;;=R97.2^^26^414^72
 ;;^UTILITY(U,$J,358.3,7414,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7414,1,3,0)
 ;;=3^Elevated PSA
 ;;^UTILITY(U,$J,358.3,7414,1,4,0)
 ;;=4^R97.2
 ;;^UTILITY(U,$J,358.3,7414,2)
 ;;=^5019748
 ;;^UTILITY(U,$J,358.3,7415,0)
 ;;=R97.8^^26^414^22
 ;;^UTILITY(U,$J,358.3,7415,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7415,1,3,0)
 ;;=3^Abnormal Tumor Markers NEC
 ;;^UTILITY(U,$J,358.3,7415,1,4,0)
 ;;=4^R97.8
 ;;^UTILITY(U,$J,358.3,7415,2)
 ;;=^5019749
 ;;^UTILITY(U,$J,358.3,7416,0)
 ;;=R93.8^^26^414^7
 ;;^UTILITY(U,$J,358.3,7416,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7416,1,3,0)
 ;;=3^Abnormal Finding on Dx Image of Body Structures
 ;;^UTILITY(U,$J,358.3,7416,1,4,0)
 ;;=4^R93.8
 ;;^UTILITY(U,$J,358.3,7416,2)
 ;;=^5019721
 ;;^UTILITY(U,$J,358.3,7417,0)
 ;;=R93.1^^26^414^10
 ;;^UTILITY(U,$J,358.3,7417,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7417,1,3,0)
 ;;=3^Abnormal Finding on Dx Image of Heart/Cor Circ
 ;;^UTILITY(U,$J,358.3,7417,1,4,0)
 ;;=4^R93.1
 ;;^UTILITY(U,$J,358.3,7417,2)
 ;;=^5019714
 ;;^UTILITY(U,$J,358.3,7418,0)
 ;;=R68.83^^26^414^49
 ;;^UTILITY(U,$J,358.3,7418,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7418,1,3,0)
 ;;=3^Chills w/o Fever
 ;;^UTILITY(U,$J,358.3,7418,1,4,0)
 ;;=4^R68.83
 ;;^UTILITY(U,$J,358.3,7418,2)
 ;;=^5019555
 ;;^UTILITY(U,$J,358.3,7419,0)
 ;;=R68.2^^26^414^66
 ;;^UTILITY(U,$J,358.3,7419,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7419,1,3,0)
 ;;=3^Dry Mouth,Unspec
 ;;^UTILITY(U,$J,358.3,7419,1,4,0)
 ;;=4^R68.2
 ;;^UTILITY(U,$J,358.3,7419,2)
 ;;=^5019552
 ;;^UTILITY(U,$J,358.3,7420,0)
 ;;=R09.02^^26^414^95
 ;;^UTILITY(U,$J,358.3,7420,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7420,1,3,0)
 ;;=3^Hypoxemia
 ;;^UTILITY(U,$J,358.3,7420,1,4,0)
 ;;=4^R09.02
 ;;^UTILITY(U,$J,358.3,7420,2)
 ;;=^332831
 ;;^UTILITY(U,$J,358.3,7421,0)
 ;;=R39.81^^26^414^99
 ;;^UTILITY(U,$J,358.3,7421,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7421,1,3,0)
 ;;=3^Incontinence d/t Cognitive Imprmt/Svr Disability/Mobility
 ;;^UTILITY(U,$J,358.3,7421,1,4,0)
 ;;=4^R39.81
 ;;^UTILITY(U,$J,358.3,7421,2)
 ;;=^5019349
 ;;^UTILITY(U,$J,358.3,7422,0)
 ;;=R29.6^^26^414^154
 ;;^UTILITY(U,$J,358.3,7422,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7422,1,3,0)
 ;;=3^Repeated Falls
 ;;^UTILITY(U,$J,358.3,7422,1,4,0)
 ;;=4^R29.6
 ;;^UTILITY(U,$J,358.3,7422,2)
 ;;=^5019317
 ;;^UTILITY(U,$J,358.3,7423,0)
 ;;=R44.1^^26^414^168
 ;;^UTILITY(U,$J,358.3,7423,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7423,1,3,0)
 ;;=3^Visual Hallucinations
 ;;^UTILITY(U,$J,358.3,7423,1,4,0)
 ;;=4^R44.1
 ;;^UTILITY(U,$J,358.3,7423,2)
 ;;=^5019456
 ;;^UTILITY(U,$J,358.3,7424,0)
 ;;=R41.840^^26^414^44
 ;;^UTILITY(U,$J,358.3,7424,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7424,1,3,0)
 ;;=3^Attention and Concentration Deficit
 ;;^UTILITY(U,$J,358.3,7424,1,4,0)
 ;;=4^R41.840
 ;;^UTILITY(U,$J,358.3,7424,2)
 ;;=^5019443
 ;;^UTILITY(U,$J,358.3,7425,0)
 ;;=K59.00^^26^414^58
 ;;^UTILITY(U,$J,358.3,7425,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7425,1,3,0)
 ;;=3^Constipation,Unspec
 ;;^UTILITY(U,$J,358.3,7425,1,4,0)
 ;;=4^K59.00
 ;;^UTILITY(U,$J,358.3,7425,2)
 ;;=^323537
 ;;^UTILITY(U,$J,358.3,7426,0)
 ;;=K03.81^^26^414^59
 ;;^UTILITY(U,$J,358.3,7426,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7426,1,3,0)
 ;;=3^Cracked Tooth
 ;;^UTILITY(U,$J,358.3,7426,1,4,0)
 ;;=4^K03.81
 ;;^UTILITY(U,$J,358.3,7426,2)
 ;;=^5008391
 ;;^UTILITY(U,$J,358.3,7427,0)
 ;;=E86.0^^26^414^61
 ;;^UTILITY(U,$J,358.3,7427,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7427,1,3,0)
 ;;=3^Dehydration
 ;;^UTILITY(U,$J,358.3,7427,1,4,0)
 ;;=4^E86.0
 ;;^UTILITY(U,$J,358.3,7427,2)
 ;;=^332743
 ;;^UTILITY(U,$J,358.3,7428,0)
 ;;=S02.5XXA^^26^414^83
 ;;^UTILITY(U,$J,358.3,7428,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7428,1,3,0)
 ;;=3^Fx Tooth,Traumatic,Clsd Fx,Init Encntr
 ;;^UTILITY(U,$J,358.3,7428,1,4,0)
 ;;=4^S02.5XXA
 ;;^UTILITY(U,$J,358.3,7428,2)
 ;;=^5020360
 ;;^UTILITY(U,$J,358.3,7429,0)
 ;;=K08.530^^26^414^82
 ;;^UTILITY(U,$J,358.3,7429,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7429,1,3,0)
 ;;=3^Fx Dental Restorative Material w/o Loss of Material
 ;;^UTILITY(U,$J,358.3,7429,1,4,0)
 ;;=4^K08.530
 ;;^UTILITY(U,$J,358.3,7429,2)
 ;;=^5008460
 ;;^UTILITY(U,$J,358.3,7430,0)
 ;;=K08.531^^26^414^81
 ;;^UTILITY(U,$J,358.3,7430,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7430,1,3,0)
 ;;=3^Fx Dental Restorative Material w/ Loss of Material
 ;;^UTILITY(U,$J,358.3,7430,1,4,0)
 ;;=4^K08.531
 ;;^UTILITY(U,$J,358.3,7430,2)
 ;;=^5008461
 ;;^UTILITY(U,$J,358.3,7431,0)
 ;;=R53.0^^26^414^128
 ;;^UTILITY(U,$J,358.3,7431,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7431,1,3,0)
 ;;=3^Neoplastic Related Fatigue
 ;;^UTILITY(U,$J,358.3,7431,1,4,0)
 ;;=4^R53.0
 ;;^UTILITY(U,$J,358.3,7431,2)
 ;;=^5019515
 ;;^UTILITY(U,$J,358.3,7432,0)
 ;;=R11.11^^26^414^171
 ;;^UTILITY(U,$J,358.3,7432,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7432,1,3,0)
 ;;=3^Vomiting w/o Nausea
 ;;^UTILITY(U,$J,358.3,7432,1,4,0)
 ;;=4^R11.11
 ;;^UTILITY(U,$J,358.3,7432,2)
 ;;=^5019233
 ;;^UTILITY(U,$J,358.3,7433,0)
 ;;=S43.51XA^^26^415^11
 ;;^UTILITY(U,$J,358.3,7433,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7433,1,3,0)
 ;;=3^Sprain of Right Acromioclavicular Joint
 ;;^UTILITY(U,$J,358.3,7433,1,4,0)
 ;;=4^S43.51XA
 ;;^UTILITY(U,$J,358.3,7433,2)
 ;;=^5027903
 ;;^UTILITY(U,$J,358.3,7434,0)
 ;;=S43.52XA^^26^415^2
 ;;^UTILITY(U,$J,358.3,7434,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7434,1,3,0)
 ;;=3^Sprain of Left Acromioclavicular Joint
 ;;^UTILITY(U,$J,358.3,7434,1,4,0)
 ;;=4^S43.52XA
 ;;^UTILITY(U,$J,358.3,7434,2)
 ;;=^5027906
 ;;^UTILITY(U,$J,358.3,7435,0)
 ;;=S43.421A^^26^415^16
 ;;^UTILITY(U,$J,358.3,7435,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7435,1,3,0)
 ;;=3^Sprain of Right Rotator Cuff Capsule
 ;;^UTILITY(U,$J,358.3,7435,1,4,0)
 ;;=4^S43.421A
 ;;^UTILITY(U,$J,358.3,7435,2)
 ;;=^5027879
 ;;^UTILITY(U,$J,358.3,7436,0)
 ;;=S43.422A^^26^415^7
 ;;^UTILITY(U,$J,358.3,7436,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7436,1,3,0)
 ;;=3^Sprain of Left Rotator Cuff Capsule
 ;;^UTILITY(U,$J,358.3,7436,1,4,0)
 ;;=4^S43.422A
 ;;^UTILITY(U,$J,358.3,7436,2)
 ;;=^5027882
 ;;^UTILITY(U,$J,358.3,7437,0)
 ;;=S53.401A^^26^415^13
 ;;^UTILITY(U,$J,358.3,7437,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7437,1,3,0)
 ;;=3^Sprain of Right Elbow
 ;;^UTILITY(U,$J,358.3,7437,1,4,0)
 ;;=4^S53.401A
 ;;^UTILITY(U,$J,358.3,7437,2)
 ;;=^5031361
 ;;^UTILITY(U,$J,358.3,7438,0)
 ;;=S53.402A^^26^415^4
 ;;^UTILITY(U,$J,358.3,7438,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7438,1,3,0)
 ;;=3^Sprain of Left Elbow
 ;;^UTILITY(U,$J,358.3,7438,1,4,0)
 ;;=4^S53.402A
 ;;^UTILITY(U,$J,358.3,7438,2)
 ;;=^5031364
 ;;^UTILITY(U,$J,358.3,7439,0)
 ;;=S56.011A^^26^415^53
 ;;^UTILITY(U,$J,358.3,7439,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7439,1,3,0)
 ;;=3^Strain of Right Thumb at Forearm Level Flexor Muscle/Fasc/Tendon
 ;;^UTILITY(U,$J,358.3,7439,1,4,0)
 ;;=4^S56.011A
 ;;^UTILITY(U,$J,358.3,7439,2)
 ;;=^5031568
 ;;^UTILITY(U,$J,358.3,7440,0)
 ;;=S56.012A^^26^415^35
 ;;^UTILITY(U,$J,358.3,7440,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7440,1,3,0)
 ;;=3^Strain of Left Thumb at Forearm Level Flexor Muscle/Fasc/Tendon
 ;;^UTILITY(U,$J,358.3,7440,1,4,0)
 ;;=4^S56.012A
 ;;^UTILITY(U,$J,358.3,7440,2)
 ;;=^5031571
 ;;^UTILITY(U,$J,358.3,7441,0)
 ;;=S56.111A^^26^415^41
 ;;^UTILITY(U,$J,358.3,7441,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7441,1,3,0)
 ;;=3^Strain of Right Index Finger at Forearm Level Flexor Muscle/Fasc/Tendon
 ;;^UTILITY(U,$J,358.3,7441,1,4,0)
 ;;=4^S56.111A
 ;;^UTILITY(U,$J,358.3,7441,2)
 ;;=^5031616
 ;;^UTILITY(U,$J,358.3,7442,0)
 ;;=S56.112A^^26^415^22
 ;;^UTILITY(U,$J,358.3,7442,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7442,1,3,0)
 ;;=3^Strain of Left Index Finger at Forearm Level Flexor Muscle/Fasc/Tendon
 ;;^UTILITY(U,$J,358.3,7442,1,4,0)
 ;;=4^S56.112A
 ;;^UTILITY(U,$J,358.3,7442,2)
 ;;=^5031619
 ;;^UTILITY(U,$J,358.3,7443,0)
 ;;=S56.113A^^26^415^49
 ;;^UTILITY(U,$J,358.3,7443,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7443,1,3,0)
 ;;=3^Strain of Right Middle Finger at Forearm Level Flexor Muscle/Fasc/Tendon
 ;;^UTILITY(U,$J,358.3,7443,1,4,0)
 ;;=4^S56.113A
 ;;^UTILITY(U,$J,358.3,7443,2)
 ;;=^5031622
 ;;^UTILITY(U,$J,358.3,7444,0)
 ;;=S56.114A^^26^415^30
 ;;^UTILITY(U,$J,358.3,7444,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7444,1,3,0)
 ;;=3^Strain of Left Middle Finger at Forearm Level Flexor Muscle/Fasc/Tendon
 ;;^UTILITY(U,$J,358.3,7444,1,4,0)
 ;;=4^S56.114A
 ;;^UTILITY(U,$J,358.3,7444,2)
 ;;=^5031625
 ;;^UTILITY(U,$J,358.3,7445,0)
 ;;=S56.115A^^26^415^51
 ;;^UTILITY(U,$J,358.3,7445,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7445,1,3,0)
 ;;=3^Strain of Right Ring Finger at Forearm Level Flexor Muscle/Fasc/Tendon
