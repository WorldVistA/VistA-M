IBDEI0FX ; ; 09-AUG-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,20146,1,4,0)
 ;;=4^R94.5
 ;;^UTILITY(U,$J,358.3,20146,2)
 ;;=^5019742
 ;;^UTILITY(U,$J,358.3,20147,0)
 ;;=R94.6^^55^800^21
 ;;^UTILITY(U,$J,358.3,20147,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20147,1,3,0)
 ;;=3^Abnormal Thyroid Function Studies
 ;;^UTILITY(U,$J,358.3,20147,1,4,0)
 ;;=4^R94.6
 ;;^UTILITY(U,$J,358.3,20147,2)
 ;;=^5019743
 ;;^UTILITY(U,$J,358.3,20148,0)
 ;;=R94.7^^55^800^5
 ;;^UTILITY(U,$J,358.3,20148,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20148,1,3,0)
 ;;=3^Abnormal Endocrine Function Sutdies NEC
 ;;^UTILITY(U,$J,358.3,20148,1,4,0)
 ;;=4^R94.7
 ;;^UTILITY(U,$J,358.3,20148,2)
 ;;=^5019744
 ;;^UTILITY(U,$J,358.3,20149,0)
 ;;=R94.31^^55^800^4
 ;;^UTILITY(U,$J,358.3,20149,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20149,1,3,0)
 ;;=3^Abnormal EKG
 ;;^UTILITY(U,$J,358.3,20149,1,4,0)
 ;;=4^R94.31
 ;;^UTILITY(U,$J,358.3,20149,2)
 ;;=^5019739
 ;;^UTILITY(U,$J,358.3,20150,0)
 ;;=R97.0^^55^800^67
 ;;^UTILITY(U,$J,358.3,20150,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20150,1,3,0)
 ;;=3^Elevated Carcinoembryonic Antigen 
 ;;^UTILITY(U,$J,358.3,20150,1,4,0)
 ;;=4^R97.0
 ;;^UTILITY(U,$J,358.3,20150,2)
 ;;=^5019746
 ;;^UTILITY(U,$J,358.3,20151,0)
 ;;=R97.1^^55^800^66
 ;;^UTILITY(U,$J,358.3,20151,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20151,1,3,0)
 ;;=3^Elevated Cancer Antigen 125
 ;;^UTILITY(U,$J,358.3,20151,1,4,0)
 ;;=4^R97.1
 ;;^UTILITY(U,$J,358.3,20151,2)
 ;;=^5019747
 ;;^UTILITY(U,$J,358.3,20152,0)
 ;;=R97.2^^55^800^68
 ;;^UTILITY(U,$J,358.3,20152,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20152,1,3,0)
 ;;=3^Elevated PSA
 ;;^UTILITY(U,$J,358.3,20152,1,4,0)
 ;;=4^R97.2
 ;;^UTILITY(U,$J,358.3,20152,2)
 ;;=^5019748
 ;;^UTILITY(U,$J,358.3,20153,0)
 ;;=R97.8^^55^800^22
 ;;^UTILITY(U,$J,358.3,20153,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20153,1,3,0)
 ;;=3^Abnormal Tumor Markers NEC
 ;;^UTILITY(U,$J,358.3,20153,1,4,0)
 ;;=4^R97.8
 ;;^UTILITY(U,$J,358.3,20153,2)
 ;;=^5019749
 ;;^UTILITY(U,$J,358.3,20154,0)
 ;;=R93.8^^55^800^12
 ;;^UTILITY(U,$J,358.3,20154,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20154,1,3,0)
 ;;=3^Abnormal Findings on Dx Imaging of Body Structures
 ;;^UTILITY(U,$J,358.3,20154,1,4,0)
 ;;=4^R93.8
 ;;^UTILITY(U,$J,358.3,20154,2)
 ;;=^5019721
 ;;^UTILITY(U,$J,358.3,20155,0)
 ;;=R93.1^^55^800^14
 ;;^UTILITY(U,$J,358.3,20155,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20155,1,3,0)
 ;;=3^Abnormal Findings on Dx Imaging of Heart/Cor Circ
 ;;^UTILITY(U,$J,358.3,20155,1,4,0)
 ;;=4^R93.1
 ;;^UTILITY(U,$J,358.3,20155,2)
 ;;=^5019714
 ;;^UTILITY(U,$J,358.3,20156,0)
 ;;=R68.83^^55^800^48
 ;;^UTILITY(U,$J,358.3,20156,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20156,1,3,0)
 ;;=3^Chills w/o Fever
 ;;^UTILITY(U,$J,358.3,20156,1,4,0)
 ;;=4^R68.83
 ;;^UTILITY(U,$J,358.3,20156,2)
 ;;=^5019555
 ;;^UTILITY(U,$J,358.3,20157,0)
 ;;=R68.2^^55^800^62
 ;;^UTILITY(U,$J,358.3,20157,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20157,1,3,0)
 ;;=3^Dry Mouth,Unspec
 ;;^UTILITY(U,$J,358.3,20157,1,4,0)
 ;;=4^R68.2
 ;;^UTILITY(U,$J,358.3,20157,2)
 ;;=^5019552
 ;;^UTILITY(U,$J,358.3,20158,0)
 ;;=R09.02^^55^800^88
 ;;^UTILITY(U,$J,358.3,20158,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20158,1,3,0)
 ;;=3^Hypoxemia
 ;;^UTILITY(U,$J,358.3,20158,1,4,0)
 ;;=4^R09.02
 ;;^UTILITY(U,$J,358.3,20158,2)
 ;;=^332831
 ;;^UTILITY(U,$J,358.3,20159,0)
 ;;=R39.81^^55^800^92
 ;;^UTILITY(U,$J,358.3,20159,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20159,1,3,0)
 ;;=3^Incontinence d/t Cognitive Imprmt/Svr Disability/Mobility
 ;;^UTILITY(U,$J,358.3,20159,1,4,0)
 ;;=4^R39.81
 ;;^UTILITY(U,$J,358.3,20159,2)
 ;;=^5019349
 ;;^UTILITY(U,$J,358.3,20160,0)
 ;;=R29.6^^55^800^146
 ;;^UTILITY(U,$J,358.3,20160,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20160,1,3,0)
 ;;=3^Repeated Falls
 ;;^UTILITY(U,$J,358.3,20160,1,4,0)
 ;;=4^R29.6
 ;;^UTILITY(U,$J,358.3,20160,2)
 ;;=^5019317
 ;;^UTILITY(U,$J,358.3,20161,0)
 ;;=R44.1^^55^800^160
 ;;^UTILITY(U,$J,358.3,20161,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20161,1,3,0)
 ;;=3^Visual Hallucinations
 ;;^UTILITY(U,$J,358.3,20161,1,4,0)
 ;;=4^R44.1
 ;;^UTILITY(U,$J,358.3,20161,2)
 ;;=^5019456
 ;;^UTILITY(U,$J,358.3,20162,0)
 ;;=S43.51XA^^55^801^12
 ;;^UTILITY(U,$J,358.3,20162,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20162,1,3,0)
 ;;=3^Sprain of Right Acromioclavicular Joint
 ;;^UTILITY(U,$J,358.3,20162,1,4,0)
 ;;=4^S43.51XA
 ;;^UTILITY(U,$J,358.3,20162,2)
 ;;=^5027903
 ;;^UTILITY(U,$J,358.3,20163,0)
 ;;=S43.52XA^^55^801^1
 ;;^UTILITY(U,$J,358.3,20163,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20163,1,3,0)
 ;;=3^Sprain of Left Acromioclavicular Joint
 ;;^UTILITY(U,$J,358.3,20163,1,4,0)
 ;;=4^S43.52XA
 ;;^UTILITY(U,$J,358.3,20163,2)
 ;;=^5027906
 ;;^UTILITY(U,$J,358.3,20164,0)
 ;;=S43.421A^^55^801^17
 ;;^UTILITY(U,$J,358.3,20164,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20164,1,3,0)
 ;;=3^Sprain of Right Rotator Cuff Capsule
 ;;^UTILITY(U,$J,358.3,20164,1,4,0)
 ;;=4^S43.421A
 ;;^UTILITY(U,$J,358.3,20164,2)
 ;;=^5027879
 ;;^UTILITY(U,$J,358.3,20165,0)
 ;;=S43.422A^^55^801^6
 ;;^UTILITY(U,$J,358.3,20165,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20165,1,3,0)
 ;;=3^Sprain of Left Rotator Cuff Capsule
 ;;^UTILITY(U,$J,358.3,20165,1,4,0)
 ;;=4^S43.422A
 ;;^UTILITY(U,$J,358.3,20165,2)
 ;;=^5027882
 ;;^UTILITY(U,$J,358.3,20166,0)
 ;;=S53.401A^^55^801^14
 ;;^UTILITY(U,$J,358.3,20166,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20166,1,3,0)
 ;;=3^Sprain of Right Elbow
 ;;^UTILITY(U,$J,358.3,20166,1,4,0)
 ;;=4^S53.401A
 ;;^UTILITY(U,$J,358.3,20166,2)
 ;;=^5031361
 ;;^UTILITY(U,$J,358.3,20167,0)
 ;;=S53.402A^^55^801^3
 ;;^UTILITY(U,$J,358.3,20167,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20167,1,3,0)
 ;;=3^Sprain of Left Elbow
 ;;^UTILITY(U,$J,358.3,20167,1,4,0)
 ;;=4^S53.402A
 ;;^UTILITY(U,$J,358.3,20167,2)
 ;;=^5031364
 ;;^UTILITY(U,$J,358.3,20168,0)
 ;;=S56.011A^^55^801^55
 ;;^UTILITY(U,$J,358.3,20168,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20168,1,3,0)
 ;;=3^Strain of Right Thumb at Forearm Level Flexor Muscle/Fasc/Tendon
 ;;^UTILITY(U,$J,358.3,20168,1,4,0)
 ;;=4^S56.011A
 ;;^UTILITY(U,$J,358.3,20168,2)
 ;;=^5031568
 ;;^UTILITY(U,$J,358.3,20169,0)
 ;;=S56.012A^^55^801^36
 ;;^UTILITY(U,$J,358.3,20169,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20169,1,3,0)
 ;;=3^Strain of Left Thumb at Forearm Level Flexor Muscle/Fasc/Tendon
 ;;^UTILITY(U,$J,358.3,20169,1,4,0)
 ;;=4^S56.012A
 ;;^UTILITY(U,$J,358.3,20169,2)
 ;;=^5031571
 ;;^UTILITY(U,$J,358.3,20170,0)
 ;;=S56.111A^^55^801^43
 ;;^UTILITY(U,$J,358.3,20170,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20170,1,3,0)
 ;;=3^Strain of Right Index Finger at Forearm Level Flexor Muscle/Fasc/Tendon
 ;;^UTILITY(U,$J,358.3,20170,1,4,0)
 ;;=4^S56.111A
 ;;^UTILITY(U,$J,358.3,20170,2)
 ;;=^5031616
 ;;^UTILITY(U,$J,358.3,20171,0)
 ;;=S56.112A^^55^801^23
 ;;^UTILITY(U,$J,358.3,20171,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20171,1,3,0)
 ;;=3^Strain of Left Index Finger at Forearm Level Flexor Muscle/Fasc/Tendon
 ;;^UTILITY(U,$J,358.3,20171,1,4,0)
 ;;=4^S56.112A
 ;;^UTILITY(U,$J,358.3,20171,2)
 ;;=^5031619
 ;;^UTILITY(U,$J,358.3,20172,0)
 ;;=S56.113A^^55^801^51
 ;;^UTILITY(U,$J,358.3,20172,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20172,1,3,0)
 ;;=3^Strain of Right Middle Finger at Forearm Level Flexor Muscle/Fasc/Tendon
 ;;^UTILITY(U,$J,358.3,20172,1,4,0)
 ;;=4^S56.113A
 ;;^UTILITY(U,$J,358.3,20172,2)
 ;;=^5031622
 ;;^UTILITY(U,$J,358.3,20173,0)
 ;;=S56.114A^^55^801^31
 ;;^UTILITY(U,$J,358.3,20173,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20173,1,3,0)
 ;;=3^Strain of Left Middle Finger at Forearm Level Flexor Muscle/Fasc/Tendon
 ;;^UTILITY(U,$J,358.3,20173,1,4,0)
 ;;=4^S56.114A
 ;;^UTILITY(U,$J,358.3,20173,2)
 ;;=^5031625
 ;;^UTILITY(U,$J,358.3,20174,0)
 ;;=S56.115A^^55^801^53
 ;;^UTILITY(U,$J,358.3,20174,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20174,1,3,0)
 ;;=3^Strain of Right Ring Finger at Forearm Level Flexor Muscle/Fasc/Tendon
 ;;^UTILITY(U,$J,358.3,20174,1,4,0)
 ;;=4^S56.115A
 ;;^UTILITY(U,$J,358.3,20174,2)
 ;;=^5031628
 ;;^UTILITY(U,$J,358.3,20175,0)
 ;;=S56.417A^^55^801^45
 ;;^UTILITY(U,$J,358.3,20175,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20175,1,3,0)
 ;;=3^Strain of Right Little Finger at Forearm Level Extn Musc/Fasc/Tendon
 ;;^UTILITY(U,$J,358.3,20175,1,4,0)
 ;;=4^S56.417A
 ;;^UTILITY(U,$J,358.3,20175,2)
 ;;=^5031781
 ;;^UTILITY(U,$J,358.3,20176,0)
 ;;=S56.418A^^55^801^25
 ;;^UTILITY(U,$J,358.3,20176,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20176,1,3,0)
 ;;=3^Strain of Left Little Finger at Forearm Level Extn Muscle/Fasc/Tendon
 ;;^UTILITY(U,$J,358.3,20176,1,4,0)
 ;;=4^S56.418A
 ;;^UTILITY(U,$J,358.3,20176,2)
 ;;=^5031784
 ;;^UTILITY(U,$J,358.3,20177,0)
 ;;=S56.811A^^55^801^41
 ;;^UTILITY(U,$J,358.3,20177,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20177,1,3,0)
 ;;=3^Strain of Right Forearm Muscle/Fasc/Tendon
 ;;^UTILITY(U,$J,358.3,20177,1,4,0)
 ;;=4^S56.811A
 ;;^UTILITY(U,$J,358.3,20177,2)
 ;;=^5031862
 ;;^UTILITY(U,$J,358.3,20178,0)
 ;;=S56.812A^^55^801^21
 ;;^UTILITY(U,$J,358.3,20178,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20178,1,3,0)
 ;;=3^Strain of Left Forearm Muscle/Fasc/Tendon
 ;;^UTILITY(U,$J,358.3,20178,1,4,0)
 ;;=4^S56.812A
 ;;^UTILITY(U,$J,358.3,20178,2)
 ;;=^5031865
 ;;^UTILITY(U,$J,358.3,20179,0)
 ;;=S56.116A^^55^801^33
 ;;^UTILITY(U,$J,358.3,20179,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20179,1,3,0)
 ;;=3^Strain of Left Ring Finger at Forearm Level Flexor Muscle/Fasc/Tendon
 ;;^UTILITY(U,$J,358.3,20179,1,4,0)
 ;;=4^S56.116A
 ;;^UTILITY(U,$J,358.3,20179,2)
 ;;=^5031631
 ;;^UTILITY(U,$J,358.3,20180,0)
 ;;=S56.117A^^55^801^46
 ;;^UTILITY(U,$J,358.3,20180,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20180,1,3,0)
 ;;=3^Strain of Right Little Finger at Forearm Level Flexor Muscle/Fasc/Tendon
 ;;^UTILITY(U,$J,358.3,20180,1,4,0)
 ;;=4^S56.117A
