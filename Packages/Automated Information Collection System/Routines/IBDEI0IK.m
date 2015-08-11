IBDEI0IK ; ; 20-MAY-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;OCT 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,9008,2)
 ;;=CA, Male Breast^267205
 ;;^UTILITY(U,$J,358.3,9009,0)
 ;;=175.0^^55^603^2
 ;;^UTILITY(U,$J,358.3,9009,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,9009,1,4,0)
 ;;=4^Ca, Male Nipple
 ;;^UTILITY(U,$J,358.3,9009,1,5,0)
 ;;=5^175.0
 ;;^UTILITY(U,$J,358.3,9009,2)
 ;;=CA, Male Nipple^267204
 ;;^UTILITY(U,$J,358.3,9010,0)
 ;;=611.1^^55^603^3
 ;;^UTILITY(U,$J,358.3,9010,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,9010,1,4,0)
 ;;=4^Gynecomastia,Male
 ;;^UTILITY(U,$J,358.3,9010,1,5,0)
 ;;=5^611.1
 ;;^UTILITY(U,$J,358.3,9010,2)
 ;;=^60454
 ;;^UTILITY(U,$J,358.3,9011,0)
 ;;=216.0^^55^604^4
 ;;^UTILITY(U,$J,358.3,9011,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,9011,1,4,0)
 ;;=4^Benign Lesion, Lip
 ;;^UTILITY(U,$J,358.3,9011,1,5,0)
 ;;=5^216.0
 ;;^UTILITY(U,$J,358.3,9011,2)
 ;;=Benign Neoplasm of Skin of Lip^267629
 ;;^UTILITY(U,$J,358.3,9012,0)
 ;;=216.1^^55^604^2
 ;;^UTILITY(U,$J,358.3,9012,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,9012,1,4,0)
 ;;=4^Benign Lesion, Eyelid
 ;;^UTILITY(U,$J,358.3,9012,1,5,0)
 ;;=5^216.1
 ;;^UTILITY(U,$J,358.3,9012,2)
 ;;=Benign Neoplasm of Skin of Eyelid^267630
 ;;^UTILITY(U,$J,358.3,9013,0)
 ;;=216.2^^55^604^1
 ;;^UTILITY(U,$J,358.3,9013,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,9013,1,4,0)
 ;;=4^Benign Lesion, Ear
 ;;^UTILITY(U,$J,358.3,9013,1,5,0)
 ;;=5^216.2
 ;;^UTILITY(U,$J,358.3,9013,2)
 ;;=Benign Neoplasm of Skin of Ear^267631
 ;;^UTILITY(U,$J,358.3,9014,0)
 ;;=216.4^^55^604^6
 ;;^UTILITY(U,$J,358.3,9014,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,9014,1,4,0)
 ;;=4^Benign Lesion, Neck
 ;;^UTILITY(U,$J,358.3,9014,1,5,0)
 ;;=5^216.4
 ;;^UTILITY(U,$J,358.3,9014,2)
 ;;=Benign Neoplasm of Skin of Neck^267633
 ;;^UTILITY(U,$J,358.3,9015,0)
 ;;=216.5^^55^604^9
 ;;^UTILITY(U,$J,358.3,9015,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,9015,1,4,0)
 ;;=4^Benign Lesion, Trunk
 ;;^UTILITY(U,$J,358.3,9015,1,5,0)
 ;;=5^216.5
 ;;^UTILITY(U,$J,358.3,9015,2)
 ;;=Benign Neoplasm of Skin of Trunk^267634
 ;;^UTILITY(U,$J,358.3,9016,0)
 ;;=216.6^^55^604^10
 ;;^UTILITY(U,$J,358.3,9016,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,9016,1,4,0)
 ;;=4^Benign Lesion, Upper Limb
 ;;^UTILITY(U,$J,358.3,9016,1,5,0)
 ;;=5^216.6
 ;;^UTILITY(U,$J,358.3,9016,2)
 ;;=Benign Neoplasm of Skin of Arm^267635
 ;;^UTILITY(U,$J,358.3,9017,0)
 ;;=216.7^^55^604^5
 ;;^UTILITY(U,$J,358.3,9017,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,9017,1,4,0)
 ;;=4^Benign Lesion, Lower Limb
 ;;^UTILITY(U,$J,358.3,9017,1,5,0)
 ;;=5^216.7
 ;;^UTILITY(U,$J,358.3,9017,2)
 ;;=Benign Neoplasm of of skin of leg^267636
 ;;^UTILITY(U,$J,358.3,9018,0)
 ;;=216.8^^55^604^8
 ;;^UTILITY(U,$J,358.3,9018,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,9018,1,4,0)
 ;;=4^Benign Lesion, Skin Other
 ;;^UTILITY(U,$J,358.3,9018,1,5,0)
 ;;=5^216.8
 ;;^UTILITY(U,$J,358.3,9018,2)
 ;;=Ben Neoplasm, Skin, Unspec^267637
 ;;^UTILITY(U,$J,358.3,9019,0)
 ;;=216.3^^55^604^3
 ;;^UTILITY(U,$J,358.3,9019,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,9019,1,4,0)
 ;;=4^Benign Lesion, Face
 ;;^UTILITY(U,$J,358.3,9019,1,5,0)
 ;;=5^216.3
 ;;^UTILITY(U,$J,358.3,9019,2)
 ;;=^267632
 ;;^UTILITY(U,$J,358.3,9020,0)
 ;;=216.9^^55^604^7
 ;;^UTILITY(U,$J,358.3,9020,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,9020,1,4,0)
 ;;=4^Benign Lesion, Skin NOS
 ;;^UTILITY(U,$J,358.3,9020,1,5,0)
 ;;=5^216.9
 ;;^UTILITY(U,$J,358.3,9020,2)
 ;;=^13314
 ;;^UTILITY(U,$J,358.3,9021,0)
 ;;=173.00^^55^605^17
 ;;^UTILITY(U,$J,358.3,9021,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,9021,1,4,0)
 ;;=4^CA Skin Lip, Unspec
 ;;^UTILITY(U,$J,358.3,9021,1,5,0)
 ;;=5^173.00
