IBDEI03O ; ; 20-FEB-2013
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 20, 2013
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,4494,1,5,0)
 ;;=5^216.1
 ;;^UTILITY(U,$J,358.3,4494,2)
 ;;=Benign Neoplasm of Skin of Eyelid^267630
 ;;^UTILITY(U,$J,358.3,4495,0)
 ;;=216.2^^44^312^1
 ;;^UTILITY(U,$J,358.3,4495,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,4495,1,4,0)
 ;;=4^Benign Lesion, Ear
 ;;^UTILITY(U,$J,358.3,4495,1,5,0)
 ;;=5^216.2
 ;;^UTILITY(U,$J,358.3,4495,2)
 ;;=Benign Neoplasm of Skin of Ear^267631
 ;;^UTILITY(U,$J,358.3,4496,0)
 ;;=216.4^^44^312^6
 ;;^UTILITY(U,$J,358.3,4496,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,4496,1,4,0)
 ;;=4^Benign Lesion, Neck
 ;;^UTILITY(U,$J,358.3,4496,1,5,0)
 ;;=5^216.4
 ;;^UTILITY(U,$J,358.3,4496,2)
 ;;=Benign Neoplasm of Skin of Neck^267633
 ;;^UTILITY(U,$J,358.3,4497,0)
 ;;=216.5^^44^312^8
 ;;^UTILITY(U,$J,358.3,4497,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,4497,1,4,0)
 ;;=4^Benign Lesion, Trunk
 ;;^UTILITY(U,$J,358.3,4497,1,5,0)
 ;;=5^216.5
 ;;^UTILITY(U,$J,358.3,4497,2)
 ;;=Benign Neoplasm of Skin of Trunk^267634
 ;;^UTILITY(U,$J,358.3,4498,0)
 ;;=216.6^^44^312^9
 ;;^UTILITY(U,$J,358.3,4498,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,4498,1,4,0)
 ;;=4^Benign Lesion, Upper Limb
 ;;^UTILITY(U,$J,358.3,4498,1,5,0)
 ;;=5^216.6
 ;;^UTILITY(U,$J,358.3,4498,2)
 ;;=Benign Neoplasm of Skin of Arm^267635
 ;;^UTILITY(U,$J,358.3,4499,0)
 ;;=216.7^^44^312^5
 ;;^UTILITY(U,$J,358.3,4499,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,4499,1,4,0)
 ;;=4^Benign Lesion, Lower Limb
 ;;^UTILITY(U,$J,358.3,4499,1,5,0)
 ;;=5^216.7
 ;;^UTILITY(U,$J,358.3,4499,2)
 ;;=Benign Neoplasm of of skin of leg^267636
 ;;^UTILITY(U,$J,358.3,4500,0)
 ;;=216.8^^44^312^7
 ;;^UTILITY(U,$J,358.3,4500,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,4500,1,4,0)
 ;;=4^Benign Lesion, Skin Other
 ;;^UTILITY(U,$J,358.3,4500,1,5,0)
 ;;=5^216.8
 ;;^UTILITY(U,$J,358.3,4500,2)
 ;;=Ben Neoplasm, Skin, Unspec^267637
 ;;^UTILITY(U,$J,358.3,4501,0)
 ;;=216.3^^44^312^3
 ;;^UTILITY(U,$J,358.3,4501,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,4501,1,4,0)
 ;;=4^Benign Lesion, Face
 ;;^UTILITY(U,$J,358.3,4501,1,5,0)
 ;;=5^216.3
 ;;^UTILITY(U,$J,358.3,4501,2)
 ;;=^267632
 ;;^UTILITY(U,$J,358.3,4502,0)
 ;;=173.00^^44^313^4
 ;;^UTILITY(U,$J,358.3,4502,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,4502,1,4,0)
 ;;=4^Ca Of Skin Of Lip
 ;;^UTILITY(U,$J,358.3,4502,1,5,0)
 ;;=5^173.00
 ;;^UTILITY(U,$J,358.3,4502,2)
 ;;=MALIG NEOPL SKIN LIP NOS^340596
 ;;^UTILITY(U,$J,358.3,4503,0)
 ;;=173.10^^44^313^2
 ;;^UTILITY(U,$J,358.3,4503,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,4503,1,4,0)
 ;;=4^Ca Of Skin Of Eyelid
 ;;^UTILITY(U,$J,358.3,4503,1,5,0)
 ;;=5^173.10
 ;;^UTILITY(U,$J,358.3,4503,2)
 ;;=MAL NEO EYELID/CANTH NOS^340597
 ;;^UTILITY(U,$J,358.3,4504,0)
 ;;=173.20^^44^313^1
 ;;^UTILITY(U,$J,358.3,4504,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,4504,1,4,0)
 ;;=4^Ca Of Skin Of Ear
 ;;^UTILITY(U,$J,358.3,4504,1,5,0)
 ;;=5^173.20
 ;;^UTILITY(U,$J,358.3,4504,2)
 ;;=MALIG NEO SKIN EAR NOS^340598
 ;;^UTILITY(U,$J,358.3,4505,0)
 ;;=173.30^^44^313^3
 ;;^UTILITY(U,$J,358.3,4505,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,4505,1,4,0)
 ;;=4^Ca Of Skin Of Face
 ;;^UTILITY(U,$J,358.3,4505,1,5,0)
 ;;=5^173.30
 ;;^UTILITY(U,$J,358.3,4505,2)
 ;;=MAL NEO SKN FACE NEC/NOS^340599
 ;;^UTILITY(U,$J,358.3,4506,0)
 ;;=173.40^^44^313^9
 ;;^UTILITY(U,$J,358.3,4506,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,4506,1,4,0)
 ;;=4^Ca of Skin Scalp/Neck
 ;;^UTILITY(U,$J,358.3,4506,1,5,0)
 ;;=5^173.40
 ;;^UTILITY(U,$J,358.3,4506,2)
 ;;=MAL NEO SCLP/SKN NCK NOS^340600
 ;;^UTILITY(U,$J,358.3,4507,0)
 ;;=173.50^^44^313^5
 ;;^UTILITY(U,$J,358.3,4507,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,4507,1,4,0)
 ;;=4^Ca Of Skin Of Trunk
 ;;^UTILITY(U,$J,358.3,4507,1,5,0)
 ;;=5^173.50
 ;;^UTILITY(U,$J,358.3,4507,2)
 ;;=MALIG NEO SKIN TRUNK NOS^340601
 ;;^UTILITY(U,$J,358.3,4508,0)
 ;;=173.60^^44^313^7
 ;;^UTILITY(U,$J,358.3,4508,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,4508,1,4,0)
 ;;=4^Ca of Skin Arm/Shoulder
 ;;^UTILITY(U,$J,358.3,4508,1,5,0)
 ;;=5^173.60
 ;;^UTILITY(U,$J,358.3,4508,2)
 ;;=MAL NEO SKIN UP LIMB NOS^340602
 ;;^UTILITY(U,$J,358.3,4509,0)
 ;;=173.70^^44^313^8
 ;;^UTILITY(U,$J,358.3,4509,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,4509,1,4,0)
 ;;=4^Ca of Skin Leg/Hip
 ;;^UTILITY(U,$J,358.3,4509,1,5,0)
 ;;=5^173.70
 ;;^UTILITY(U,$J,358.3,4509,2)
 ;;=MAL NEO SKN LOW LIMB NOS^340603
 ;;^UTILITY(U,$J,358.3,4510,0)
 ;;=173.80^^44^313^6
 ;;^UTILITY(U,$J,358.3,4510,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,4510,1,4,0)
 ;;=4^Ca Of Skin, Other Part
 ;;^UTILITY(U,$J,358.3,4510,1,5,0)
 ;;=5^173.80
 ;;^UTILITY(U,$J,358.3,4510,2)
 ;;=MAL NEO SKN SITE NEC/NOS^340604
 ;;^UTILITY(U,$J,358.3,4511,0)
 ;;=172.0^^44^314^6
 ;;^UTILITY(U,$J,358.3,4511,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,4511,1,4,0)
 ;;=4^ Melanoma Of Lip
 ;;^UTILITY(U,$J,358.3,4511,1,5,0)
 ;;=5^172.0
 ;;^UTILITY(U,$J,358.3,4511,2)
 ;;=Malig Melanoma of Lip^267175
 ;;^UTILITY(U,$J,358.3,4512,0)
 ;;=172.1^^44^314^3
 ;;^UTILITY(U,$J,358.3,4512,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,4512,1,4,0)
 ;;=4^ Melanoma Of Eyelid
 ;;^UTILITY(U,$J,358.3,4512,1,5,0)
 ;;=5^172.1
 ;;^UTILITY(U,$J,358.3,4512,2)
 ;;=Malig Melanoma of Eyelid^267176
 ;;^UTILITY(U,$J,358.3,4513,0)
 ;;=172.2^^44^314^2
 ;;^UTILITY(U,$J,358.3,4513,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,4513,1,4,0)
 ;;=4^ Melanoma Of Ear
 ;;^UTILITY(U,$J,358.3,4513,1,5,0)
 ;;=5^172.2
 ;;^UTILITY(U,$J,358.3,4513,2)
 ;;=Malig Melanoma of Ear^267177
 ;;^UTILITY(U,$J,358.3,4514,0)
 ;;=172.3^^44^314^4
 ;;^UTILITY(U,$J,358.3,4514,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,4514,1,4,0)
 ;;=4^ Melanoma Of Face
 ;;^UTILITY(U,$J,358.3,4514,1,5,0)
 ;;=5^172.3
 ;;^UTILITY(U,$J,358.3,4514,2)
 ;;=Malig Melanoma of Face^267178
 ;;^UTILITY(U,$J,358.3,4515,0)
 ;;=172.4^^44^314^7
 ;;^UTILITY(U,$J,358.3,4515,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,4515,1,4,0)
 ;;=4^ Melanoma Of Neck/Scalp
 ;;^UTILITY(U,$J,358.3,4515,1,5,0)
 ;;=5^172.4
 ;;^UTILITY(U,$J,358.3,4515,2)
 ;;=Malignant Melanoma of Neck^267179
 ;;^UTILITY(U,$J,358.3,4516,0)
 ;;=172.5^^44^314^9
 ;;^UTILITY(U,$J,358.3,4516,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,4516,1,4,0)
 ;;=4^ Melanoma Of Trunk
 ;;^UTILITY(U,$J,358.3,4516,1,5,0)
 ;;=5^172.5
 ;;^UTILITY(U,$J,358.3,4516,2)
 ;;=Malignant Melanoma of Trunk^267180
 ;;^UTILITY(U,$J,358.3,4517,0)
 ;;=172.6^^44^314^1
 ;;^UTILITY(U,$J,358.3,4517,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,4517,1,4,0)
 ;;=4^ Melanoma Of Arm/Shoulder
 ;;^UTILITY(U,$J,358.3,4517,1,5,0)
 ;;=5^172.6
 ;;^UTILITY(U,$J,358.3,4517,2)
 ;;=Malignant Melanoma of Arm^267181
 ;;^UTILITY(U,$J,358.3,4518,0)
 ;;=172.7^^44^314^5
 ;;^UTILITY(U,$J,358.3,4518,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,4518,1,4,0)
 ;;=4^ Melanoma Of Leg/Hip
 ;;^UTILITY(U,$J,358.3,4518,1,5,0)
 ;;=5^172.7
 ;;^UTILITY(U,$J,358.3,4518,2)
 ;;=Malignant Melanoma of Leg^267182
 ;;^UTILITY(U,$J,358.3,4519,0)
 ;;=172.8^^44^314^8
 ;;^UTILITY(U,$J,358.3,4519,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,4519,1,4,0)
 ;;=4^ Melanoma Of Skin
 ;;^UTILITY(U,$J,358.3,4519,1,5,0)
 ;;=5^172.8
 ;;^UTILITY(U,$J,358.3,4519,2)
 ;;=Malignant Melanoma of Skin^267183
 ;;^UTILITY(U,$J,358.3,4520,0)
 ;;=172.9^^44^314^10
 ;;^UTILITY(U,$J,358.3,4520,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,4520,1,4,0)
 ;;=4^Malig Melanoma Skin NOS
 ;;^UTILITY(U,$J,358.3,4520,1,5,0)
 ;;=5^172.9
 ;;^UTILITY(U,$J,358.3,4520,2)
 ;;=^75462
 ;;^UTILITY(U,$J,358.3,4521,0)
 ;;=873.8^^44^315^14
 ;;^UTILITY(U,$J,358.3,4521,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,4521,1,4,0)
 ;;=4^Laceration, Head, Nec
 ;;^UTILITY(U,$J,358.3,4521,1,5,0)
 ;;=5^873.8
 ;;^UTILITY(U,$J,358.3,4521,2)
 ;;=Laceration, Head, NEC^274970
 ;;^UTILITY(U,$J,358.3,4522,0)
 ;;=872.01^^44^315^2
 ;;^UTILITY(U,$J,358.3,4522,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,4522,1,4,0)
 ;;=4^Laceration, Auricle
 ;;^UTILITY(U,$J,358.3,4522,1,5,0)
 ;;=5^872.01
 ;;^UTILITY(U,$J,358.3,4522,2)
 ;;=Laceration, Auricle^274898
 ;;^UTILITY(U,$J,358.3,4523,0)
 ;;=873.42^^44^315^11
 ;;^UTILITY(U,$J,358.3,4523,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,4523,1,4,0)
 ;;=4^Laceration, Forehead
 ;;^UTILITY(U,$J,358.3,4523,1,5,0)
 ;;=5^873.42
 ;;^UTILITY(U,$J,358.3,4523,2)
 ;;=Laceration, Forehead^274943
 ;;^UTILITY(U,$J,358.3,4524,0)
 ;;=873.41^^44^315^5
 ;;^UTILITY(U,$J,358.3,4524,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,4524,1,4,0)
 ;;=4^Laceration, Cheek
 ;;^UTILITY(U,$J,358.3,4524,1,5,0)
 ;;=5^873.41
 ;;^UTILITY(U,$J,358.3,4524,2)
 ;;=Laceration, Cheek^274940
 ;;^UTILITY(U,$J,358.3,4525,0)
 ;;=873.44^^44^315^16
 ;;^UTILITY(U,$J,358.3,4525,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,4525,1,4,0)
 ;;=4^Laceration, Jaw/Chin
 ;;^UTILITY(U,$J,358.3,4525,1,5,0)
 ;;=5^873.44
 ;;^UTILITY(U,$J,358.3,4525,2)
 ;;=Laceration, Jaw/Chin^274947
 ;;^UTILITY(U,$J,358.3,4526,0)
 ;;=872.8^^44^315^6
 ;;^UTILITY(U,$J,358.3,4526,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,4526,1,4,0)
 ;;=4^Laceration, Ear
 ;;^UTILITY(U,$J,358.3,4526,1,5,0)
 ;;=5^872.8
 ;;^UTILITY(U,$J,358.3,4526,2)
 ;;=Laceration, Ear^274918
 ;;^UTILITY(U,$J,358.3,4527,0)
 ;;=873.40^^44^315^8
 ;;^UTILITY(U,$J,358.3,4527,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,4527,1,4,0)
 ;;=4^Laceration, Face, Nos
 ;;^UTILITY(U,$J,358.3,4527,1,5,0)
 ;;=5^873.40
 ;;^UTILITY(U,$J,358.3,4527,2)
 ;;=Laceration, Face, NOS^274939
 ;;^UTILITY(U,$J,358.3,4528,0)
 ;;=874.8^^44^315^18
 ;;^UTILITY(U,$J,358.3,4528,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,4528,1,4,0)
 ;;=4^Laceration, Neck
 ;;^UTILITY(U,$J,358.3,4528,1,5,0)
 ;;=5^874.8
 ;;^UTILITY(U,$J,358.3,4528,2)
 ;;=Laceration, Neck^274988
 ;;^UTILITY(U,$J,358.3,4529,0)
 ;;=873.20^^44^315^19
 ;;^UTILITY(U,$J,358.3,4529,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,4529,1,4,0)
 ;;=4^Laceration, Nose
 ;;^UTILITY(U,$J,358.3,4529,1,5,0)
 ;;=5^873.20
 ;;^UTILITY(U,$J,358.3,4529,2)
 ;;=Laceration, Nose^274924
