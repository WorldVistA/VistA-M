IBDEI06O ; ; 20-MAY-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;OCT 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,2925,0)
 ;;=175.9^^26^240^1
 ;;^UTILITY(U,$J,358.3,2925,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,2925,1,4,0)
 ;;=4^Ca, Male Breast
 ;;^UTILITY(U,$J,358.3,2925,1,5,0)
 ;;=5^175.9
 ;;^UTILITY(U,$J,358.3,2925,2)
 ;;=CA, Male Breast^267205
 ;;^UTILITY(U,$J,358.3,2926,0)
 ;;=175.0^^26^240^2
 ;;^UTILITY(U,$J,358.3,2926,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,2926,1,4,0)
 ;;=4^Ca, Male Nipple
 ;;^UTILITY(U,$J,358.3,2926,1,5,0)
 ;;=5^175.0
 ;;^UTILITY(U,$J,358.3,2926,2)
 ;;=CA, Male Nipple^267204
 ;;^UTILITY(U,$J,358.3,2927,0)
 ;;=611.1^^26^240^3
 ;;^UTILITY(U,$J,358.3,2927,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,2927,1,4,0)
 ;;=4^Gynecomastia,Male
 ;;^UTILITY(U,$J,358.3,2927,1,5,0)
 ;;=5^611.1
 ;;^UTILITY(U,$J,358.3,2927,2)
 ;;=^60454
 ;;^UTILITY(U,$J,358.3,2928,0)
 ;;=216.0^^26^241^4
 ;;^UTILITY(U,$J,358.3,2928,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,2928,1,4,0)
 ;;=4^Benign Lesion, Lip
 ;;^UTILITY(U,$J,358.3,2928,1,5,0)
 ;;=5^216.0
 ;;^UTILITY(U,$J,358.3,2928,2)
 ;;=Benign Neoplasm of Skin of Lip^267629
 ;;^UTILITY(U,$J,358.3,2929,0)
 ;;=216.1^^26^241^2
 ;;^UTILITY(U,$J,358.3,2929,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,2929,1,4,0)
 ;;=4^Benign Lesion, Eyelid
 ;;^UTILITY(U,$J,358.3,2929,1,5,0)
 ;;=5^216.1
 ;;^UTILITY(U,$J,358.3,2929,2)
 ;;=Benign Neoplasm of Skin of Eyelid^267630
 ;;^UTILITY(U,$J,358.3,2930,0)
 ;;=216.2^^26^241^1
 ;;^UTILITY(U,$J,358.3,2930,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,2930,1,4,0)
 ;;=4^Benign Lesion, Ear
 ;;^UTILITY(U,$J,358.3,2930,1,5,0)
 ;;=5^216.2
 ;;^UTILITY(U,$J,358.3,2930,2)
 ;;=Benign Neoplasm of Skin of Ear^267631
 ;;^UTILITY(U,$J,358.3,2931,0)
 ;;=216.4^^26^241^6
 ;;^UTILITY(U,$J,358.3,2931,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,2931,1,4,0)
 ;;=4^Benign Lesion, Neck
 ;;^UTILITY(U,$J,358.3,2931,1,5,0)
 ;;=5^216.4
 ;;^UTILITY(U,$J,358.3,2931,2)
 ;;=Benign Neoplasm of Skin of Neck^267633
 ;;^UTILITY(U,$J,358.3,2932,0)
 ;;=216.5^^26^241^9
 ;;^UTILITY(U,$J,358.3,2932,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,2932,1,4,0)
 ;;=4^Benign Lesion, Trunk
 ;;^UTILITY(U,$J,358.3,2932,1,5,0)
 ;;=5^216.5
 ;;^UTILITY(U,$J,358.3,2932,2)
 ;;=Benign Neoplasm of Skin of Trunk^267634
 ;;^UTILITY(U,$J,358.3,2933,0)
 ;;=216.6^^26^241^10
 ;;^UTILITY(U,$J,358.3,2933,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,2933,1,4,0)
 ;;=4^Benign Lesion, Upper Limb
 ;;^UTILITY(U,$J,358.3,2933,1,5,0)
 ;;=5^216.6
 ;;^UTILITY(U,$J,358.3,2933,2)
 ;;=Benign Neoplasm of Skin of Arm^267635
 ;;^UTILITY(U,$J,358.3,2934,0)
 ;;=216.7^^26^241^5
 ;;^UTILITY(U,$J,358.3,2934,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,2934,1,4,0)
 ;;=4^Benign Lesion, Lower Limb
 ;;^UTILITY(U,$J,358.3,2934,1,5,0)
 ;;=5^216.7
 ;;^UTILITY(U,$J,358.3,2934,2)
 ;;=Benign Neoplasm of of skin of leg^267636
 ;;^UTILITY(U,$J,358.3,2935,0)
 ;;=216.8^^26^241^8
 ;;^UTILITY(U,$J,358.3,2935,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,2935,1,4,0)
 ;;=4^Benign Lesion, Skin Other
 ;;^UTILITY(U,$J,358.3,2935,1,5,0)
 ;;=5^216.8
 ;;^UTILITY(U,$J,358.3,2935,2)
 ;;=Ben Neoplasm, Skin, Unspec^267637
 ;;^UTILITY(U,$J,358.3,2936,0)
 ;;=216.3^^26^241^3
 ;;^UTILITY(U,$J,358.3,2936,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,2936,1,4,0)
 ;;=4^Benign Lesion, Face
 ;;^UTILITY(U,$J,358.3,2936,1,5,0)
 ;;=5^216.3
 ;;^UTILITY(U,$J,358.3,2936,2)
 ;;=^267632
 ;;^UTILITY(U,$J,358.3,2937,0)
 ;;=216.9^^26^241^7
 ;;^UTILITY(U,$J,358.3,2937,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,2937,1,4,0)
 ;;=4^Benign Lesion, Skin NOS
 ;;^UTILITY(U,$J,358.3,2937,1,5,0)
 ;;=5^216.9
 ;;^UTILITY(U,$J,358.3,2937,2)
 ;;=^13314
