IBDEI03P ; ; 20-FEB-2013
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 20, 2013
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,4530,0)
 ;;=873.0^^44^315^20
 ;;^UTILITY(U,$J,358.3,4530,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,4530,1,4,0)
 ;;=4^Laceration, Scalp
 ;;^UTILITY(U,$J,358.3,4530,1,5,0)
 ;;=5^873.0
 ;;^UTILITY(U,$J,358.3,4530,2)
 ;;=Laceration, Scalp^274921
 ;;^UTILITY(U,$J,358.3,4531,0)
 ;;=880.02^^44^315^3
 ;;^UTILITY(U,$J,358.3,4531,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,4531,1,4,0)
 ;;=4^Laceration, Axilla
 ;;^UTILITY(U,$J,358.3,4531,1,5,0)
 ;;=5^880.02
 ;;^UTILITY(U,$J,358.3,4531,2)
 ;;=Laceration, Axilla^275027
 ;;^UTILITY(U,$J,358.3,4532,0)
 ;;=877.0^^44^315^4
 ;;^UTILITY(U,$J,358.3,4532,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,4532,1,4,0)
 ;;=4^Laceration, Buttock
 ;;^UTILITY(U,$J,358.3,4532,1,5,0)
 ;;=5^877.0
 ;;^UTILITY(U,$J,358.3,4532,2)
 ;;=Laceration, Buttock^274999
 ;;^UTILITY(U,$J,358.3,4533,0)
 ;;=879.4^^44^315^12
 ;;^UTILITY(U,$J,358.3,4533,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,4533,1,4,0)
 ;;=4^Laceration, Groin/Inguinal
 ;;^UTILITY(U,$J,358.3,4533,1,5,0)
 ;;=5^879.4
 ;;^UTILITY(U,$J,358.3,4533,2)
 ;;=Laceration, Groin/Inguinal^275017
 ;;^UTILITY(U,$J,358.3,4534,0)
 ;;=884.0^^44^315^1
 ;;^UTILITY(U,$J,358.3,4534,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,4534,1,4,0)
 ;;=4^Laceration, Arm Nos
 ;;^UTILITY(U,$J,358.3,4534,1,5,0)
 ;;=5^884.0
 ;;^UTILITY(U,$J,358.3,4534,2)
 ;;=Laceration, Arm NOS^275064
 ;;^UTILITY(U,$J,358.3,4535,0)
 ;;=883.0^^44^315^9
 ;;^UTILITY(U,$J,358.3,4535,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,4535,1,4,0)
 ;;=4^Laceration, Finger
 ;;^UTILITY(U,$J,358.3,4535,1,5,0)
 ;;=5^883.0
 ;;^UTILITY(U,$J,358.3,4535,2)
 ;;=Laceration, Finger^275060
 ;;^UTILITY(U,$J,358.3,4536,0)
 ;;=881.01^^44^315^7
 ;;^UTILITY(U,$J,358.3,4536,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,4536,1,4,0)
 ;;=4^Laceration, Elbow
 ;;^UTILITY(U,$J,358.3,4536,1,5,0)
 ;;=5^881.01
 ;;^UTILITY(U,$J,358.3,4536,2)
 ;;=Laceration, Elbow^275045
 ;;^UTILITY(U,$J,358.3,4537,0)
 ;;=882.0^^44^315^13
 ;;^UTILITY(U,$J,358.3,4537,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,4537,1,4,0)
 ;;=4^Laceration, Hand
 ;;^UTILITY(U,$J,358.3,4537,1,5,0)
 ;;=5^882.0
 ;;^UTILITY(U,$J,358.3,4537,2)
 ;;=Laceration, Hand^275056
 ;;^UTILITY(U,$J,358.3,4538,0)
 ;;=881.02^^44^315^23
 ;;^UTILITY(U,$J,358.3,4538,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,4538,1,4,0)
 ;;=4^Laceration, Wrist
 ;;^UTILITY(U,$J,358.3,4538,1,5,0)
 ;;=5^881.02
 ;;^UTILITY(U,$J,358.3,4538,2)
 ;;=Laceration, Wrist^275046
 ;;^UTILITY(U,$J,358.3,4539,0)
 ;;=880.00^^44^315^21
 ;;^UTILITY(U,$J,358.3,4539,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,4539,1,4,0)
 ;;=4^Laceration, Shoulder
 ;;^UTILITY(U,$J,358.3,4539,1,5,0)
 ;;=5^880.00
 ;;^UTILITY(U,$J,358.3,4539,2)
 ;;=Laceration, Shoulder^275025
 ;;^UTILITY(U,$J,358.3,4540,0)
 ;;=890.0^^44^315^15
 ;;^UTILITY(U,$J,358.3,4540,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,4540,1,4,0)
 ;;=4^Laceration, Hip/Thigh
 ;;^UTILITY(U,$J,358.3,4540,1,5,0)
 ;;=5^890.0
 ;;^UTILITY(U,$J,358.3,4540,2)
 ;;=Laceration, Hip/Thigh^275083
 ;;^UTILITY(U,$J,358.3,4541,0)
 ;;=891.0^^44^315^17
 ;;^UTILITY(U,$J,358.3,4541,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,4541,1,4,0)
 ;;=4^Laceration, Knee/Leg/Ankle
 ;;^UTILITY(U,$J,358.3,4541,1,5,0)
 ;;=5^891.0
 ;;^UTILITY(U,$J,358.3,4541,2)
 ;;=Laceration, Knee/Leg/Ankle^275087
 ;;^UTILITY(U,$J,358.3,4542,0)
 ;;=893.0^^44^315^22
 ;;^UTILITY(U,$J,358.3,4542,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,4542,1,4,0)
 ;;=4^Laceration, Toe
 ;;^UTILITY(U,$J,358.3,4542,1,5,0)
 ;;=5^893.0
 ;;^UTILITY(U,$J,358.3,4542,2)
 ;;=Laceration, Toe^275095
 ;;^UTILITY(U,$J,358.3,4543,0)
 ;;=892.0^^44^315^10
 ;;^UTILITY(U,$J,358.3,4543,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,4543,1,4,0)
 ;;=4^Laceration, Foot
 ;;^UTILITY(U,$J,358.3,4543,1,5,0)
 ;;=5^892.0
 ;;^UTILITY(U,$J,358.3,4543,2)
 ;;=Laceration, Fott^275091
 ;;^UTILITY(U,$J,358.3,4544,0)
 ;;=209.31^^44^316^1
 ;;^UTILITY(U,$J,358.3,4544,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,4544,1,4,0)
 ;;=4^Merkel Cell CA-Face
 ;;^UTILITY(U,$J,358.3,4544,1,5,0)
 ;;=5^209.31
 ;;^UTILITY(U,$J,358.3,4544,2)
 ;;=^338212
 ;;^UTILITY(U,$J,358.3,4545,0)
 ;;=209.32^^44^316^2
 ;;^UTILITY(U,$J,358.3,4545,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,4545,1,4,0)
 ;;=4^Merkel Cell CA-Sclp/Neck
 ;;^UTILITY(U,$J,358.3,4545,1,5,0)
 ;;=5^209.32
 ;;^UTILITY(U,$J,358.3,4545,2)
 ;;=^338213
 ;;^UTILITY(U,$J,358.3,4546,0)
 ;;=209.33^^44^316^3
 ;;^UTILITY(U,$J,358.3,4546,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,4546,1,4,0)
 ;;=4^Merkel Cell CA-Upper Limb
 ;;^UTILITY(U,$J,358.3,4546,1,5,0)
 ;;=5^209.33
 ;;^UTILITY(U,$J,358.3,4546,2)
 ;;=^338214
 ;;^UTILITY(U,$J,358.3,4547,0)
 ;;=209.34^^44^316^4
 ;;^UTILITY(U,$J,358.3,4547,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,4547,1,4,0)
 ;;=4^Merkel Cell CA-Lower Limb
 ;;^UTILITY(U,$J,358.3,4547,1,5,0)
 ;;=5^209.34
 ;;^UTILITY(U,$J,358.3,4547,2)
 ;;=^338215
 ;;^UTILITY(U,$J,358.3,4548,0)
 ;;=209.35^^44^316^5
 ;;^UTILITY(U,$J,358.3,4548,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,4548,1,4,0)
 ;;=4^Merkel Cell-Trunk
 ;;^UTILITY(U,$J,358.3,4548,1,5,0)
 ;;=5^209.35
 ;;^UTILITY(U,$J,358.3,4548,2)
 ;;=^338216
 ;;^UTILITY(U,$J,358.3,4549,0)
 ;;=209.36^^44^316^6
 ;;^UTILITY(U,$J,358.3,4549,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,4549,1,4,0)
 ;;=4^Merkel Cell CA-Oth Sites
 ;;^UTILITY(U,$J,358.3,4549,1,5,0)
 ;;=5^209.36
 ;;^UTILITY(U,$J,358.3,4549,2)
 ;;=^338217
 ;;^UTILITY(U,$J,358.3,4550,0)
 ;;=V67.09^^44^317^11
 ;;^UTILITY(U,$J,358.3,4550,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,4550,1,4,0)
 ;;=4^F/U exam, Following Surg
 ;;^UTILITY(U,$J,358.3,4550,1,5,0)
 ;;=5^V67.09
 ;;^UTILITY(U,$J,358.3,4550,2)
 ;;=F/U exam, completed treatment^322080
 ;;^UTILITY(U,$J,358.3,4551,0)
 ;;=V58.42^^44^317^1
 ;;^UTILITY(U,$J,358.3,4551,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,4551,1,4,0)
 ;;=4^Aftercare after CA surgery
 ;;^UTILITY(U,$J,358.3,4551,1,5,0)
 ;;=5^V58.42
 ;;^UTILITY(U,$J,358.3,4551,2)
 ;;=Aftercare after CA surgery^295530
 ;;^UTILITY(U,$J,358.3,4552,0)
 ;;=V58.73^^44^317^5
 ;;^UTILITY(U,$J,358.3,4552,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,4552,1,4,0)
 ;;=4^Aftercare after Vasc Surg
 ;;^UTILITY(U,$J,358.3,4552,1,5,0)
 ;;=5^V58.73
 ;;^UTILITY(U,$J,358.3,4552,2)
 ;;=Aftercare after Vasc Surg^295530
 ;;^UTILITY(U,$J,358.3,4553,0)
 ;;=V58.74^^44^317^3
 ;;^UTILITY(U,$J,358.3,4553,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,4553,1,4,0)
 ;;=4^Aftercare after Lung Surg
 ;;^UTILITY(U,$J,358.3,4553,1,5,0)
 ;;=5^V58.74
 ;;^UTILITY(U,$J,358.3,4553,2)
 ;;=Aftercare after Lung Surg^295530
 ;;^UTILITY(U,$J,358.3,4554,0)
 ;;=V58.77^^44^317^4
 ;;^UTILITY(U,$J,358.3,4554,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,4554,1,4,0)
 ;;=4^Aftercare after Skin Surg
 ;;^UTILITY(U,$J,358.3,4554,1,5,0)
 ;;=5^V58.77
 ;;^UTILITY(U,$J,358.3,4554,2)
 ;;=Aftercare after Skin Surg^295530
 ;;^UTILITY(U,$J,358.3,4555,0)
 ;;=V58.75^^44^317^2
 ;;^UTILITY(U,$J,358.3,4555,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,4555,1,4,0)
 ;;=4^Aftercare after GI Surgery
 ;;^UTILITY(U,$J,358.3,4555,1,5,0)
 ;;=5^V58.75
 ;;^UTILITY(U,$J,358.3,4555,2)
 ;;=Aftercare after GI Surgery^295530
 ;;^UTILITY(U,$J,358.3,4556,0)
 ;;=V58.31^^44^317^12
 ;;^UTILITY(U,$J,358.3,4556,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,4556,1,4,0)
 ;;=4^Removal Surg Dressing
 ;;^UTILITY(U,$J,358.3,4556,1,5,0)
 ;;=5^V58.31
 ;;^UTILITY(U,$J,358.3,4556,2)
 ;;=^334216
 ;;^UTILITY(U,$J,358.3,4557,0)
 ;;=V58.30^^44^317^10
 ;;^UTILITY(U,$J,358.3,4557,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,4557,1,4,0)
 ;;=4^Change/Remove Dressing
 ;;^UTILITY(U,$J,358.3,4557,1,5,0)
 ;;=5^V58.30
 ;;^UTILITY(U,$J,358.3,4557,2)
 ;;=^334215
 ;;^UTILITY(U,$J,358.3,4558,0)
 ;;=V58.32^^44^317^13
 ;;^UTILITY(U,$J,358.3,4558,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,4558,1,4,0)
 ;;=4^Removal Sutures
 ;;^UTILITY(U,$J,358.3,4558,1,5,0)
 ;;=5^V58.32
 ;;^UTILITY(U,$J,358.3,4558,2)
 ;;=^334217
 ;;^UTILITY(U,$J,358.3,4559,0)
 ;;=V58.71^^44^317^9
 ;;^UTILITY(U,$J,358.3,4559,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,4559,1,4,0)
 ;;=4^Aftercare,Sense Organ Surg
 ;;^UTILITY(U,$J,358.3,4559,1,5,0)
 ;;=5^V58.71
 ;;^UTILITY(U,$J,358.3,4559,2)
 ;;=^328689
 ;;^UTILITY(U,$J,358.3,4560,0)
 ;;=V58.72^^44^317^8
 ;;^UTILITY(U,$J,358.3,4560,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,4560,1,4,0)
 ;;=4^Aftercare,Nervous Sys Surg
 ;;^UTILITY(U,$J,358.3,4560,1,5,0)
 ;;=5^V58.72
 ;;^UTILITY(U,$J,358.3,4560,2)
 ;;=^328690
 ;;^UTILITY(U,$J,358.3,4561,0)
 ;;=V58.76^^44^317^6
 ;;^UTILITY(U,$J,358.3,4561,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,4561,1,4,0)
 ;;=4^Aftercare,GU Surg
 ;;^UTILITY(U,$J,358.3,4561,1,5,0)
 ;;=5^V58.76
 ;;^UTILITY(U,$J,358.3,4561,2)
 ;;=^328694
 ;;^UTILITY(U,$J,358.3,4562,0)
 ;;=V58.78^^44^317^7
 ;;^UTILITY(U,$J,358.3,4562,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,4562,1,4,0)
 ;;=4^Aftercare,Musculos Surg
 ;;^UTILITY(U,$J,358.3,4562,1,5,0)
 ;;=5^V58.78
 ;;^UTILITY(U,$J,358.3,4562,2)
 ;;=^328696
 ;;^UTILITY(U,$J,358.3,4563,0)
 ;;=443.9^^44^318^15
 ;;^UTILITY(U,$J,358.3,4563,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,4563,1,4,0)
 ;;=4^PVD
 ;;^UTILITY(U,$J,358.3,4563,1,5,0)
 ;;=5^443.9
 ;;^UTILITY(U,$J,358.3,4563,2)
 ;;=PVD^184182
 ;;^UTILITY(U,$J,358.3,4564,0)
 ;;=441.4^^44^318^3
 ;;^UTILITY(U,$J,358.3,4564,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,4564,1,4,0)
 ;;=4^Aneurysm,Abdom Aortic
 ;;^UTILITY(U,$J,358.3,4564,1,5,0)
 ;;=5^441.4
 ;;^UTILITY(U,$J,358.3,4564,2)
 ;;=^269769
 ;;^UTILITY(U,$J,358.3,4565,0)
 ;;=444.22^^44^318^10
 ;;^UTILITY(U,$J,358.3,4565,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,4565,1,4,0)
 ;;=4^Embolism/Thrombosis LE
 ;;^UTILITY(U,$J,358.3,4565,1,5,0)
 ;;=5^444.22
 ;;^UTILITY(U,$J,358.3,4565,2)
 ;;=^269790
 ;;^UTILITY(U,$J,358.3,4566,0)
 ;;=454.9^^44^318^16
 ;;^UTILITY(U,$J,358.3,4566,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,4566,1,4,0)
 ;;=4^Varicose Vein
