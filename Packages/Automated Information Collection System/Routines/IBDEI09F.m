IBDEI09F ; ; 01-MAY-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 01, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,23065,0)
 ;;=R93.2^^73^952^9
 ;;^UTILITY(U,$J,358.3,23065,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23065,1,3,0)
 ;;=3^Abnormal Finding on Dx Image of Liver/Biliary Tract
 ;;^UTILITY(U,$J,358.3,23065,1,4,0)
 ;;=4^R93.2
 ;;^UTILITY(U,$J,358.3,23065,2)
 ;;=^5019715
 ;;^UTILITY(U,$J,358.3,23066,0)
 ;;=R93.3^^73^952^7
 ;;^UTILITY(U,$J,358.3,23066,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23066,1,3,0)
 ;;=3^Abnormal Finding on Dx Image of Digestive Tract Part
 ;;^UTILITY(U,$J,358.3,23066,1,4,0)
 ;;=4^R93.3
 ;;^UTILITY(U,$J,358.3,23066,2)
 ;;=^5019716
 ;;^UTILITY(U,$J,358.3,23067,0)
 ;;=R93.5^^73^952^6
 ;;^UTILITY(U,$J,358.3,23067,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23067,1,3,0)
 ;;=3^Abnormal Finding on Dx Image of Abdominal Regions
 ;;^UTILITY(U,$J,358.3,23067,1,4,0)
 ;;=4^R93.5
 ;;^UTILITY(U,$J,358.3,23067,2)
 ;;=^5019718
 ;;^UTILITY(U,$J,358.3,23068,0)
 ;;=R93.6^^73^952^8
 ;;^UTILITY(U,$J,358.3,23068,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23068,1,3,0)
 ;;=3^Abnormal Finding on Dx Image of Limbs
 ;;^UTILITY(U,$J,358.3,23068,1,4,0)
 ;;=4^R93.6
 ;;^UTILITY(U,$J,358.3,23068,2)
 ;;=^5019719
 ;;^UTILITY(U,$J,358.3,23069,0)
 ;;=R94.4^^73^952^19
 ;;^UTILITY(U,$J,358.3,23069,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23069,1,3,0)
 ;;=3^Abnormal Kidney Function Studies
 ;;^UTILITY(U,$J,358.3,23069,1,4,0)
 ;;=4^R94.4
 ;;^UTILITY(U,$J,358.3,23069,2)
 ;;=^5019741
 ;;^UTILITY(U,$J,358.3,23070,0)
 ;;=R94.5^^73^952^20
 ;;^UTILITY(U,$J,358.3,23070,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23070,1,3,0)
 ;;=3^Abnormal Liver Function Studies
 ;;^UTILITY(U,$J,358.3,23070,1,4,0)
 ;;=4^R94.5
 ;;^UTILITY(U,$J,358.3,23070,2)
 ;;=^5019742
 ;;^UTILITY(U,$J,358.3,23071,0)
 ;;=R94.6^^73^952^24
 ;;^UTILITY(U,$J,358.3,23071,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23071,1,3,0)
 ;;=3^Abnormal Thyroid Function Studies
 ;;^UTILITY(U,$J,358.3,23071,1,4,0)
 ;;=4^R94.6
 ;;^UTILITY(U,$J,358.3,23071,2)
 ;;=^5019743
 ;;^UTILITY(U,$J,358.3,23072,0)
 ;;=R94.7^^73^952^5
 ;;^UTILITY(U,$J,358.3,23072,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23072,1,3,0)
 ;;=3^Abnormal Endocrine Function Studies NEC
 ;;^UTILITY(U,$J,358.3,23072,1,4,0)
 ;;=4^R94.7
 ;;^UTILITY(U,$J,358.3,23072,2)
 ;;=^5019744
 ;;^UTILITY(U,$J,358.3,23073,0)
 ;;=R94.31^^73^952^4
 ;;^UTILITY(U,$J,358.3,23073,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23073,1,3,0)
 ;;=3^Abnormal EKG
 ;;^UTILITY(U,$J,358.3,23073,1,4,0)
 ;;=4^R94.31
 ;;^UTILITY(U,$J,358.3,23073,2)
 ;;=^5019739
 ;;^UTILITY(U,$J,358.3,23074,0)
 ;;=R97.0^^73^952^72
 ;;^UTILITY(U,$J,358.3,23074,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23074,1,3,0)
 ;;=3^Elevated Carcinoembryonic Antigen 
 ;;^UTILITY(U,$J,358.3,23074,1,4,0)
 ;;=4^R97.0
 ;;^UTILITY(U,$J,358.3,23074,2)
 ;;=^5019746
 ;;^UTILITY(U,$J,358.3,23075,0)
 ;;=R97.1^^73^952^71
 ;;^UTILITY(U,$J,358.3,23075,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23075,1,3,0)
 ;;=3^Elevated Cancer Antigen 125
 ;;^UTILITY(U,$J,358.3,23075,1,4,0)
 ;;=4^R97.1
 ;;^UTILITY(U,$J,358.3,23075,2)
 ;;=^5019747
 ;;^UTILITY(U,$J,358.3,23076,0)
 ;;=R97.8^^73^952^25
 ;;^UTILITY(U,$J,358.3,23076,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23076,1,3,0)
 ;;=3^Abnormal Tumor Markers NEC
 ;;^UTILITY(U,$J,358.3,23076,1,4,0)
 ;;=4^R97.8
 ;;^UTILITY(U,$J,358.3,23076,2)
 ;;=^5019749
 ;;^UTILITY(U,$J,358.3,23077,0)
 ;;=R93.1^^73^952^17
 ;;^UTILITY(U,$J,358.3,23077,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23077,1,3,0)
 ;;=3^Abnormal Findings on Dx Imaging of Heart/Cor Circ
 ;;^UTILITY(U,$J,358.3,23077,1,4,0)
 ;;=4^R93.1
 ;;^UTILITY(U,$J,358.3,23077,2)
 ;;=^5019714
 ;;^UTILITY(U,$J,358.3,23078,0)
 ;;=R68.83^^73^952^52
 ;;^UTILITY(U,$J,358.3,23078,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23078,1,3,0)
 ;;=3^Chills w/o Fever
 ;;^UTILITY(U,$J,358.3,23078,1,4,0)
 ;;=4^R68.83
 ;;^UTILITY(U,$J,358.3,23078,2)
 ;;=^5019555
 ;;^UTILITY(U,$J,358.3,23079,0)
 ;;=R68.2^^73^952^67
 ;;^UTILITY(U,$J,358.3,23079,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23079,1,3,0)
 ;;=3^Dry Mouth,Unspec
 ;;^UTILITY(U,$J,358.3,23079,1,4,0)
 ;;=4^R68.2
 ;;^UTILITY(U,$J,358.3,23079,2)
 ;;=^5019552
 ;;^UTILITY(U,$J,358.3,23080,0)
 ;;=R09.02^^73^952^93
 ;;^UTILITY(U,$J,358.3,23080,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23080,1,3,0)
 ;;=3^Hypoxemia
 ;;^UTILITY(U,$J,358.3,23080,1,4,0)
 ;;=4^R09.02
 ;;^UTILITY(U,$J,358.3,23080,2)
 ;;=^332831
 ;;^UTILITY(U,$J,358.3,23081,0)
 ;;=R39.81^^73^952^97
 ;;^UTILITY(U,$J,358.3,23081,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23081,1,3,0)
 ;;=3^Incontinence d/t Cognitive Imprmt/Svr Disability/Mobility
 ;;^UTILITY(U,$J,358.3,23081,1,4,0)
 ;;=4^R39.81
 ;;^UTILITY(U,$J,358.3,23081,2)
 ;;=^5019349
 ;;^UTILITY(U,$J,358.3,23082,0)
 ;;=R29.6^^73^952^152
 ;;^UTILITY(U,$J,358.3,23082,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23082,1,3,0)
 ;;=3^Repeated Falls
 ;;^UTILITY(U,$J,358.3,23082,1,4,0)
 ;;=4^R29.6
 ;;^UTILITY(U,$J,358.3,23082,2)
 ;;=^5019317
 ;;^UTILITY(U,$J,358.3,23083,0)
 ;;=R44.1^^73^952^167
 ;;^UTILITY(U,$J,358.3,23083,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23083,1,3,0)
 ;;=3^Visual Hallucinations
 ;;^UTILITY(U,$J,358.3,23083,1,4,0)
 ;;=4^R44.1
 ;;^UTILITY(U,$J,358.3,23083,2)
 ;;=^5019456
 ;;^UTILITY(U,$J,358.3,23084,0)
 ;;=R93.422^^73^952^11
 ;;^UTILITY(U,$J,358.3,23084,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23084,1,3,0)
 ;;=3^Abnormal Finding on Dx Image,Left Kidney
 ;;^UTILITY(U,$J,358.3,23084,1,4,0)
 ;;=4^R93.422
 ;;^UTILITY(U,$J,358.3,23084,2)
 ;;=^5139225
 ;;^UTILITY(U,$J,358.3,23085,0)
 ;;=R93.421^^73^952^14
 ;;^UTILITY(U,$J,358.3,23085,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23085,1,3,0)
 ;;=3^Abnormal Finding on Dx Image,Right Kidney
 ;;^UTILITY(U,$J,358.3,23085,1,4,0)
 ;;=4^R93.421
 ;;^UTILITY(U,$J,358.3,23085,2)
 ;;=^5139224
 ;;^UTILITY(U,$J,358.3,23086,0)
 ;;=R93.49^^73^952^12
 ;;^UTILITY(U,$J,358.3,23086,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23086,1,3,0)
 ;;=3^Abnormal Finding on Dx Image,Oth Urinary Organs
 ;;^UTILITY(U,$J,358.3,23086,1,4,0)
 ;;=4^R93.49
 ;;^UTILITY(U,$J,358.3,23086,2)
 ;;=^5139227
 ;;^UTILITY(U,$J,358.3,23087,0)
 ;;=R93.41^^73^952^13
 ;;^UTILITY(U,$J,358.3,23087,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23087,1,3,0)
 ;;=3^Abnormal Finding on Dx Image,Renal Pelvis/Ureter/Bladder
 ;;^UTILITY(U,$J,358.3,23087,1,4,0)
 ;;=4^R93.41
 ;;^UTILITY(U,$J,358.3,23087,2)
 ;;=^5139223
 ;;^UTILITY(U,$J,358.3,23088,0)
 ;;=R97.20^^73^952^73
 ;;^UTILITY(U,$J,358.3,23088,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23088,1,3,0)
 ;;=3^Elevated PSA
 ;;^UTILITY(U,$J,358.3,23088,1,4,0)
 ;;=4^R97.20
 ;;^UTILITY(U,$J,358.3,23088,2)
 ;;=^334262
 ;;^UTILITY(U,$J,358.3,23089,0)
 ;;=R97.21^^73^952^153
 ;;^UTILITY(U,$J,358.3,23089,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23089,1,3,0)
 ;;=3^Rising PSA After Tx of Prostate CA
 ;;^UTILITY(U,$J,358.3,23089,1,4,0)
 ;;=4^R97.21
 ;;^UTILITY(U,$J,358.3,23089,2)
 ;;=^5139228
 ;;^UTILITY(U,$J,358.3,23090,0)
 ;;=K08.89^^73^952^64
 ;;^UTILITY(U,$J,358.3,23090,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23090,1,3,0)
 ;;=3^Disorder of Teeth/Supporting Structures,Oth Specified
 ;;^UTILITY(U,$J,358.3,23090,1,4,0)
 ;;=4^K08.89
 ;;^UTILITY(U,$J,358.3,23090,2)
 ;;=^5008467
 ;;^UTILITY(U,$J,358.3,23091,0)
 ;;=R82.79^^73^952^31
 ;;^UTILITY(U,$J,358.3,23091,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23091,1,3,0)
 ;;=3^Abnormal Urine Microbiological Findings
 ;;^UTILITY(U,$J,358.3,23091,1,4,0)
 ;;=4^R82.79
 ;;^UTILITY(U,$J,358.3,23091,2)
 ;;=^5139222
 ;;^UTILITY(U,$J,358.3,23092,0)
 ;;=K08.9^^73^952^65
 ;;^UTILITY(U,$J,358.3,23092,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23092,1,3,0)
 ;;=3^Disorder of Teeth/Supporting Structures,Unspec
 ;;^UTILITY(U,$J,358.3,23092,1,4,0)
 ;;=4^K08.9
 ;;^UTILITY(U,$J,358.3,23092,2)
 ;;=^5008468
 ;;^UTILITY(U,$J,358.3,23093,0)
 ;;=R93.89^^73^952^15
 ;;^UTILITY(U,$J,358.3,23093,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23093,1,3,0)
 ;;=3^Abnormal Finding on Dx Imaging of Oth Body Structures
 ;;^UTILITY(U,$J,358.3,23093,1,4,0)
 ;;=4^R93.89
 ;;^UTILITY(U,$J,358.3,23093,2)
 ;;=^5157477
 ;;^UTILITY(U,$J,358.3,23094,0)
 ;;=R82.998^^73^952^28
 ;;^UTILITY(U,$J,358.3,23094,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23094,1,3,0)
 ;;=3^Abnormal Urine Findings,Other
 ;;^UTILITY(U,$J,358.3,23094,1,4,0)
 ;;=4^R82.998
 ;;^UTILITY(U,$J,358.3,23094,2)
 ;;=^5157472
 ;;^UTILITY(U,$J,358.3,23095,0)
 ;;=R82.89^^73^952^27
 ;;^UTILITY(U,$J,358.3,23095,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23095,1,3,0)
 ;;=3^Abnormal Urine Cytology/Histology Findings,Other
 ;;^UTILITY(U,$J,358.3,23095,1,4,0)
 ;;=4^R82.89
 ;;^UTILITY(U,$J,358.3,23095,2)
 ;;=^5158142
 ;;^UTILITY(U,$J,358.3,23096,0)
 ;;=R82.81^^73^952^150
 ;;^UTILITY(U,$J,358.3,23096,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23096,1,3,0)
 ;;=3^Pyuria
 ;;^UTILITY(U,$J,358.3,23096,1,4,0)
 ;;=4^R82.81
 ;;^UTILITY(U,$J,358.3,23096,2)
 ;;=^101879
 ;;^UTILITY(U,$J,358.3,23097,0)
 ;;=S43.51XA^^73^953^12
 ;;^UTILITY(U,$J,358.3,23097,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23097,1,3,0)
 ;;=3^Sprain of Right Acromioclavicular Joint
 ;;^UTILITY(U,$J,358.3,23097,1,4,0)
 ;;=4^S43.51XA
 ;;^UTILITY(U,$J,358.3,23097,2)
 ;;=^5027903
 ;;^UTILITY(U,$J,358.3,23098,0)
 ;;=S43.52XA^^73^953^1
 ;;^UTILITY(U,$J,358.3,23098,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23098,1,3,0)
 ;;=3^Sprain of Left Acromioclavicular Joint
 ;;^UTILITY(U,$J,358.3,23098,1,4,0)
 ;;=4^S43.52XA
 ;;^UTILITY(U,$J,358.3,23098,2)
 ;;=^5027906
 ;;^UTILITY(U,$J,358.3,23099,0)
 ;;=S43.421A^^73^953^17
 ;;^UTILITY(U,$J,358.3,23099,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23099,1,3,0)
 ;;=3^Sprain of Right Rotator Cuff Capsule
 ;;^UTILITY(U,$J,358.3,23099,1,4,0)
 ;;=4^S43.421A
 ;;^UTILITY(U,$J,358.3,23099,2)
 ;;=^5027879
 ;;^UTILITY(U,$J,358.3,23100,0)
 ;;=S43.422A^^73^953^6
 ;;^UTILITY(U,$J,358.3,23100,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23100,1,3,0)
 ;;=3^Sprain of Left Rotator Cuff Capsule
 ;;^UTILITY(U,$J,358.3,23100,1,4,0)
 ;;=4^S43.422A
 ;;^UTILITY(U,$J,358.3,23100,2)
 ;;=^5027882
 ;;^UTILITY(U,$J,358.3,23101,0)
 ;;=S53.401A^^73^953^14
 ;;^UTILITY(U,$J,358.3,23101,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23101,1,3,0)
 ;;=3^Sprain of Right Elbow
 ;;^UTILITY(U,$J,358.3,23101,1,4,0)
 ;;=4^S53.401A
 ;;^UTILITY(U,$J,358.3,23101,2)
 ;;=^5031361
 ;;^UTILITY(U,$J,358.3,23102,0)
 ;;=S53.402A^^73^953^3
 ;;^UTILITY(U,$J,358.3,23102,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23102,1,3,0)
 ;;=3^Sprain of Left Elbow
 ;;^UTILITY(U,$J,358.3,23102,1,4,0)
 ;;=4^S53.402A
 ;;^UTILITY(U,$J,358.3,23102,2)
 ;;=^5031364
 ;;^UTILITY(U,$J,358.3,23103,0)
 ;;=S56.011A^^73^953^55
 ;;^UTILITY(U,$J,358.3,23103,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23103,1,3,0)
 ;;=3^Strain of Right Thumb at Forearm Level Flexor Muscle/Fasc/Tendon
 ;;^UTILITY(U,$J,358.3,23103,1,4,0)
 ;;=4^S56.011A
 ;;^UTILITY(U,$J,358.3,23103,2)
 ;;=^5031568
 ;;^UTILITY(U,$J,358.3,23104,0)
 ;;=S56.012A^^73^953^36
 ;;^UTILITY(U,$J,358.3,23104,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23104,1,3,0)
 ;;=3^Strain of Left Thumb at Forearm Level Flexor Muscle/Fasc/Tendon
 ;;^UTILITY(U,$J,358.3,23104,1,4,0)
 ;;=4^S56.012A
 ;;^UTILITY(U,$J,358.3,23104,2)
 ;;=^5031571
 ;;^UTILITY(U,$J,358.3,23105,0)
 ;;=S56.111A^^73^953^43
 ;;^UTILITY(U,$J,358.3,23105,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23105,1,3,0)
 ;;=3^Strain of Right Index Finger at Forearm Level Flexor Muscle/Fasc/Tendon
 ;;^UTILITY(U,$J,358.3,23105,1,4,0)
 ;;=4^S56.111A
 ;;^UTILITY(U,$J,358.3,23105,2)
 ;;=^5031616
 ;;^UTILITY(U,$J,358.3,23106,0)
 ;;=S56.112A^^73^953^23
 ;;^UTILITY(U,$J,358.3,23106,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23106,1,3,0)
 ;;=3^Strain of Left Index Finger at Forearm Level Flexor Muscle/Fasc/Tendon
 ;;^UTILITY(U,$J,358.3,23106,1,4,0)
 ;;=4^S56.112A
 ;;^UTILITY(U,$J,358.3,23106,2)
 ;;=^5031619
 ;;^UTILITY(U,$J,358.3,23107,0)
 ;;=S56.113A^^73^953^51
 ;;^UTILITY(U,$J,358.3,23107,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23107,1,3,0)
 ;;=3^Strain of Right Middle Finger at Forearm Level Flexor Muscle/Fasc/Tendon
 ;;^UTILITY(U,$J,358.3,23107,1,4,0)
 ;;=4^S56.113A
 ;;^UTILITY(U,$J,358.3,23107,2)
 ;;=^5031622
 ;;^UTILITY(U,$J,358.3,23108,0)
 ;;=S56.114A^^73^953^31
 ;;^UTILITY(U,$J,358.3,23108,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23108,1,3,0)
 ;;=3^Strain of Left Middle Finger at Forearm Level Flexor Muscle/Fasc/Tendon
 ;;^UTILITY(U,$J,358.3,23108,1,4,0)
 ;;=4^S56.114A
 ;;^UTILITY(U,$J,358.3,23108,2)
 ;;=^5031625
 ;;^UTILITY(U,$J,358.3,23109,0)
 ;;=S56.115A^^73^953^53
 ;;^UTILITY(U,$J,358.3,23109,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23109,1,3,0)
 ;;=3^Strain of Right Ring Finger at Forearm Level Flexor Muscle/Fasc/Tendon
 ;;^UTILITY(U,$J,358.3,23109,1,4,0)
 ;;=4^S56.115A
 ;;^UTILITY(U,$J,358.3,23109,2)
 ;;=^5031628
 ;;^UTILITY(U,$J,358.3,23110,0)
 ;;=S56.417A^^73^953^45
 ;;^UTILITY(U,$J,358.3,23110,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23110,1,3,0)
 ;;=3^Strain of Right Little Finger at Forearm Level Extn Musc/Fasc/Tendon
 ;;^UTILITY(U,$J,358.3,23110,1,4,0)
 ;;=4^S56.417A
 ;;^UTILITY(U,$J,358.3,23110,2)
 ;;=^5031781
 ;;^UTILITY(U,$J,358.3,23111,0)
 ;;=S56.418A^^73^953^25
 ;;^UTILITY(U,$J,358.3,23111,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23111,1,3,0)
 ;;=3^Strain of Left Little Finger at Forearm Level Extn Muscle/Fasc/Tendon
 ;;^UTILITY(U,$J,358.3,23111,1,4,0)
 ;;=4^S56.418A
 ;;^UTILITY(U,$J,358.3,23111,2)
 ;;=^5031784
 ;;^UTILITY(U,$J,358.3,23112,0)
 ;;=S56.811A^^73^953^41
 ;;^UTILITY(U,$J,358.3,23112,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23112,1,3,0)
 ;;=3^Strain of Right Forearm Muscle/Fasc/Tendon
 ;;^UTILITY(U,$J,358.3,23112,1,4,0)
 ;;=4^S56.811A
 ;;^UTILITY(U,$J,358.3,23112,2)
 ;;=^5031862
 ;;^UTILITY(U,$J,358.3,23113,0)
 ;;=S56.812A^^73^953^21
 ;;^UTILITY(U,$J,358.3,23113,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23113,1,3,0)
 ;;=3^Strain of Left Forearm Muscle/Fasc/Tendon
 ;;^UTILITY(U,$J,358.3,23113,1,4,0)
 ;;=4^S56.812A
 ;;^UTILITY(U,$J,358.3,23113,2)
 ;;=^5031865
 ;;^UTILITY(U,$J,358.3,23114,0)
 ;;=S56.116A^^73^953^33
 ;;^UTILITY(U,$J,358.3,23114,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23114,1,3,0)
 ;;=3^Strain of Left Ring Finger at Forearm Level Flexor Muscle/Fasc/Tendon
 ;;^UTILITY(U,$J,358.3,23114,1,4,0)
 ;;=4^S56.116A
 ;;^UTILITY(U,$J,358.3,23114,2)
 ;;=^5031631
 ;;^UTILITY(U,$J,358.3,23115,0)
 ;;=S56.117A^^73^953^46
 ;;^UTILITY(U,$J,358.3,23115,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23115,1,3,0)
 ;;=3^Strain of Right Little Finger at Forearm Level Flexor Muscle/Fasc/Tendon
 ;;^UTILITY(U,$J,358.3,23115,1,4,0)
 ;;=4^S56.117A
 ;;^UTILITY(U,$J,358.3,23115,2)
 ;;=^5031634
 ;;^UTILITY(U,$J,358.3,23116,0)
 ;;=S56.118A^^73^953^26
 ;;^UTILITY(U,$J,358.3,23116,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23116,1,3,0)
 ;;=3^Strain of Left Little Finger at Forearm Level Flexor Muscle/Fasc/Tendon
 ;;^UTILITY(U,$J,358.3,23116,1,4,0)
 ;;=4^S56.118A
 ;;^UTILITY(U,$J,358.3,23116,2)
 ;;=^5031637
 ;;^UTILITY(U,$J,358.3,23117,0)
 ;;=S56.211A^^73^953^40
 ;;^UTILITY(U,$J,358.3,23117,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23117,1,3,0)
 ;;=3^Strain of Right Forearm Flexor Muscle/Fasc/Tendon
 ;;^UTILITY(U,$J,358.3,23117,1,4,0)
 ;;=4^S56.211A
 ;;^UTILITY(U,$J,358.3,23117,2)
 ;;=^5031691
 ;;^UTILITY(U,$J,358.3,23118,0)
 ;;=S56.212A^^73^953^20
 ;;^UTILITY(U,$J,358.3,23118,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23118,1,3,0)
 ;;=3^Strain of Left Forearm Flexor Muscle/Fasc/Tendon
 ;;^UTILITY(U,$J,358.3,23118,1,4,0)
 ;;=4^S56.212A
 ;;^UTILITY(U,$J,358.3,23118,2)
 ;;=^5031694
 ;;^UTILITY(U,$J,358.3,23119,0)
 ;;=S56.311A^^73^953^56
 ;;^UTILITY(U,$J,358.3,23119,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23119,1,3,0)
 ;;=3^Strain of Right Thumb at Forearm Level Extn/Abdr Muscle/Fasc/Tendon
 ;;^UTILITY(U,$J,358.3,23119,1,4,0)
 ;;=4^S56.311A
 ;;^UTILITY(U,$J,358.3,23119,2)
 ;;=^5031715
 ;;^UTILITY(U,$J,358.3,23120,0)
 ;;=S56.312A^^73^953^35
 ;;^UTILITY(U,$J,358.3,23120,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23120,1,3,0)
 ;;=3^Strain of Left Thumb at Forearm Level Extn/Abdr Muscle/Fasc/Tendon
 ;;^UTILITY(U,$J,358.3,23120,1,4,0)
 ;;=4^S56.312A
 ;;^UTILITY(U,$J,358.3,23120,2)
 ;;=^5031718
 ;;^UTILITY(U,$J,358.3,23121,0)
 ;;=S56.411A^^73^953^44
 ;;^UTILITY(U,$J,358.3,23121,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23121,1,3,0)
 ;;=3^Strain of Right Index Finger at Forearm Level Extensor Muscle/Fasc/Tendon
 ;;^UTILITY(U,$J,358.3,23121,1,4,0)
 ;;=4^S56.411A
 ;;^UTILITY(U,$J,358.3,23121,2)
 ;;=^5031763
 ;;^UTILITY(U,$J,358.3,23122,0)
 ;;=S56.412A^^73^953^24
 ;;^UTILITY(U,$J,358.3,23122,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23122,1,3,0)
 ;;=3^Strain of Left Index Finger at Forearm Level Extensor Muscle/Fasc/Tendon
 ;;^UTILITY(U,$J,358.3,23122,1,4,0)
 ;;=4^S56.412A
 ;;^UTILITY(U,$J,358.3,23122,2)
 ;;=^5031766
 ;;^UTILITY(U,$J,358.3,23123,0)
 ;;=S56.413A^^73^953^52
 ;;^UTILITY(U,$J,358.3,23123,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23123,1,3,0)
 ;;=3^Strain of Right Middle Finger at Forearm Level Extensor Muscle/Fasc/Tendon
 ;;^UTILITY(U,$J,358.3,23123,1,4,0)
 ;;=4^S56.413A
 ;;^UTILITY(U,$J,358.3,23123,2)
 ;;=^5031769
 ;;^UTILITY(U,$J,358.3,23124,0)
 ;;=S56.414A^^73^953^32
 ;;^UTILITY(U,$J,358.3,23124,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23124,1,3,0)
 ;;=3^Strain of Left Middle Finger at Forearm Levle Extensor Muscle/Fasc/Tendon
 ;;^UTILITY(U,$J,358.3,23124,1,4,0)
 ;;=4^S56.414A
 ;;^UTILITY(U,$J,358.3,23124,2)
 ;;=^5031772
 ;;^UTILITY(U,$J,358.3,23125,0)
 ;;=S56.415A^^73^953^54
 ;;^UTILITY(U,$J,358.3,23125,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23125,1,3,0)
 ;;=3^Strain of Right Ring Finger at Forearm Level Extensor Muscle/Fasc/Tendon
 ;;^UTILITY(U,$J,358.3,23125,1,4,0)
 ;;=4^S56.415A
 ;;^UTILITY(U,$J,358.3,23125,2)
 ;;=^5031775
 ;;^UTILITY(U,$J,358.3,23126,0)
 ;;=S56.416A^^73^953^34
 ;;^UTILITY(U,$J,358.3,23126,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23126,1,3,0)
 ;;=3^Strain of Left Ring Finger at Forearm Level Extensor Muscle/Fasc/Tendon
 ;;^UTILITY(U,$J,358.3,23126,1,4,0)
 ;;=4^S56.416A
 ;;^UTILITY(U,$J,358.3,23126,2)
 ;;=^5031778
 ;;^UTILITY(U,$J,358.3,23127,0)
 ;;=S66.912A^^73^953^22
 ;;^UTILITY(U,$J,358.3,23127,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23127,1,3,0)
 ;;=3^Strain of Left Hand Muscle/Fasc/Tendon,Unspec
 ;;^UTILITY(U,$J,358.3,23127,1,4,0)
 ;;=4^S66.912A
 ;;^UTILITY(U,$J,358.3,23127,2)
 ;;=^5036534
 ;;^UTILITY(U,$J,358.3,23128,0)
 ;;=S66.911A^^73^953^42
 ;;^UTILITY(U,$J,358.3,23128,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23128,1,3,0)
 ;;=3^Strain of Right Hand Muscle/Fasc/Tendon,Unspec
 ;;^UTILITY(U,$J,358.3,23128,1,4,0)
 ;;=4^S66.911A
 ;;^UTILITY(U,$J,358.3,23128,2)
 ;;=^5036531
 ;;^UTILITY(U,$J,358.3,23129,0)
 ;;=S63.501A^^73^953^18
 ;;^UTILITY(U,$J,358.3,23129,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23129,1,3,0)
 ;;=3^Sprain of Right Wrist
 ;;^UTILITY(U,$J,358.3,23129,1,4,0)
 ;;=4^S63.501A
 ;;^UTILITY(U,$J,358.3,23129,2)
 ;;=^5035583
