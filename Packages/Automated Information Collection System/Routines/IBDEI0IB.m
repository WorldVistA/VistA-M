IBDEI0IB ; ; 12-AUG-2014
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,8920,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,8920,1,4,0)
 ;;=4^BCC Skin,Arm/Shoulder
 ;;^UTILITY(U,$J,358.3,8920,1,5,0)
 ;;=5^173.61
 ;;^UTILITY(U,$J,358.3,8920,2)
 ;;=^340482
 ;;^UTILITY(U,$J,358.3,8921,0)
 ;;=173.62^^61^628^19
 ;;^UTILITY(U,$J,358.3,8921,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,8921,1,4,0)
 ;;=4^SCC Skin,Arm/Shoulder
 ;;^UTILITY(U,$J,358.3,8921,1,5,0)
 ;;=5^173.62
 ;;^UTILITY(U,$J,358.3,8921,2)
 ;;=^340483
 ;;^UTILITY(U,$J,358.3,8922,0)
 ;;=173.71^^61^628^5
 ;;^UTILITY(U,$J,358.3,8922,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,8922,1,4,0)
 ;;=4^BCC Skin,Leg/Hip
 ;;^UTILITY(U,$J,358.3,8922,1,5,0)
 ;;=5^173.71
 ;;^UTILITY(U,$J,358.3,8922,2)
 ;;=^340485
 ;;^UTILITY(U,$J,358.3,8923,0)
 ;;=173.72^^61^628^23
 ;;^UTILITY(U,$J,358.3,8923,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,8923,1,4,0)
 ;;=4^SCC Skin,Leg/Hip
 ;;^UTILITY(U,$J,358.3,8923,1,5,0)
 ;;=5^173.72
 ;;^UTILITY(U,$J,358.3,8923,2)
 ;;=^340486
 ;;^UTILITY(U,$J,358.3,8924,0)
 ;;=239.2^^61^628^9
 ;;^UTILITY(U,$J,358.3,8924,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,8924,1,4,0)
 ;;=4^Bone/Skin Neoplasm NOS
 ;;^UTILITY(U,$J,358.3,8924,1,5,0)
 ;;=5^239.2
 ;;^UTILITY(U,$J,358.3,8924,2)
 ;;=^267783
 ;;^UTILITY(U,$J,358.3,8925,0)
 ;;=172.0^^61^629^6
 ;;^UTILITY(U,$J,358.3,8925,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,8925,1,4,0)
 ;;=4^ Melanoma Of Lip
 ;;^UTILITY(U,$J,358.3,8925,1,5,0)
 ;;=5^172.0
 ;;^UTILITY(U,$J,358.3,8925,2)
 ;;=Malig Melanoma of Lip^267175
 ;;^UTILITY(U,$J,358.3,8926,0)
 ;;=172.1^^61^629^3
 ;;^UTILITY(U,$J,358.3,8926,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,8926,1,4,0)
 ;;=4^ Melanoma Of Eyelid
 ;;^UTILITY(U,$J,358.3,8926,1,5,0)
 ;;=5^172.1
 ;;^UTILITY(U,$J,358.3,8926,2)
 ;;=Malig Melanoma of Eyelid^267176
 ;;^UTILITY(U,$J,358.3,8927,0)
 ;;=172.2^^61^629^2
 ;;^UTILITY(U,$J,358.3,8927,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,8927,1,4,0)
 ;;=4^ Melanoma Of Ear
 ;;^UTILITY(U,$J,358.3,8927,1,5,0)
 ;;=5^172.2
 ;;^UTILITY(U,$J,358.3,8927,2)
 ;;=Malig Melanoma of Ear^267177
 ;;^UTILITY(U,$J,358.3,8928,0)
 ;;=172.3^^61^629^4
 ;;^UTILITY(U,$J,358.3,8928,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,8928,1,4,0)
 ;;=4^ Melanoma Of Face
 ;;^UTILITY(U,$J,358.3,8928,1,5,0)
 ;;=5^172.3
 ;;^UTILITY(U,$J,358.3,8928,2)
 ;;=Malig Melanoma of Face^267178
 ;;^UTILITY(U,$J,358.3,8929,0)
 ;;=172.4^^61^629^7
 ;;^UTILITY(U,$J,358.3,8929,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,8929,1,4,0)
 ;;=4^ Melanoma Of Neck/Scalp
 ;;^UTILITY(U,$J,358.3,8929,1,5,0)
 ;;=5^172.4
 ;;^UTILITY(U,$J,358.3,8929,2)
 ;;=Malignant Melanoma of Neck^267179
 ;;^UTILITY(U,$J,358.3,8930,0)
 ;;=172.5^^61^629^9
 ;;^UTILITY(U,$J,358.3,8930,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,8930,1,4,0)
 ;;=4^ Melanoma Of Trunk
 ;;^UTILITY(U,$J,358.3,8930,1,5,0)
 ;;=5^172.5
 ;;^UTILITY(U,$J,358.3,8930,2)
 ;;=Malignant Melanoma of Trunk^267180
 ;;^UTILITY(U,$J,358.3,8931,0)
 ;;=172.6^^61^629^1
 ;;^UTILITY(U,$J,358.3,8931,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,8931,1,4,0)
 ;;=4^ Melanoma Of Arm/Shoulder
 ;;^UTILITY(U,$J,358.3,8931,1,5,0)
 ;;=5^172.6
 ;;^UTILITY(U,$J,358.3,8931,2)
 ;;=Malignant Melanoma of Arm^267181
 ;;^UTILITY(U,$J,358.3,8932,0)
 ;;=172.7^^61^629^5
 ;;^UTILITY(U,$J,358.3,8932,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,8932,1,4,0)
 ;;=4^ Melanoma Of Leg/Hip
 ;;^UTILITY(U,$J,358.3,8932,1,5,0)
 ;;=5^172.7
 ;;^UTILITY(U,$J,358.3,8932,2)
 ;;=Malignant Melanoma of Leg^267182
 ;;^UTILITY(U,$J,358.3,8933,0)
 ;;=172.8^^61^629^8
 ;;^UTILITY(U,$J,358.3,8933,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,8933,1,4,0)
 ;;=4^ Melanoma Of Skin
