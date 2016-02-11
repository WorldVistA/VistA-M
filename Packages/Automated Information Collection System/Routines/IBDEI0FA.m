IBDEI0FA ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,6734,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6734,1,3,0)
 ;;=3^Dermatitis,Allergic Contact d/t Animal Dander
 ;;^UTILITY(U,$J,358.3,6734,1,4,0)
 ;;=4^L23.81
 ;;^UTILITY(U,$J,358.3,6734,2)
 ;;=^5009123
 ;;^UTILITY(U,$J,358.3,6735,0)
 ;;=L23.0^^46^446^5
 ;;^UTILITY(U,$J,358.3,6735,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6735,1,3,0)
 ;;=3^Dermatitis,Allergic Contact d/t Metals
 ;;^UTILITY(U,$J,358.3,6735,1,4,0)
 ;;=4^L23.0
 ;;^UTILITY(U,$J,358.3,6735,2)
 ;;=^5009115
 ;;^UTILITY(U,$J,358.3,6736,0)
 ;;=B00.1^^46^446^10
 ;;^UTILITY(U,$J,358.3,6736,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6736,1,3,0)
 ;;=3^Dermatitis,Herpes Simplex
 ;;^UTILITY(U,$J,358.3,6736,1,4,0)
 ;;=4^B00.1
 ;;^UTILITY(U,$J,358.3,6736,2)
 ;;=^5000468
 ;;^UTILITY(U,$J,358.3,6737,0)
 ;;=L24.0^^46^446^13
 ;;^UTILITY(U,$J,358.3,6737,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6737,1,3,0)
 ;;=3^Dermatitis,Irritant Contact d/t Detergents
 ;;^UTILITY(U,$J,358.3,6737,1,4,0)
 ;;=4^L24.0
 ;;^UTILITY(U,$J,358.3,6737,2)
 ;;=^5009126
 ;;^UTILITY(U,$J,358.3,6738,0)
 ;;=L24.81^^46^446^14
 ;;^UTILITY(U,$J,358.3,6738,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6738,1,3,0)
 ;;=3^Dermatitis,Irritant Contact d/t Metals
 ;;^UTILITY(U,$J,358.3,6738,1,4,0)
 ;;=4^L24.81
 ;;^UTILITY(U,$J,358.3,6738,2)
 ;;=^5009134
 ;;^UTILITY(U,$J,358.3,6739,0)
 ;;=L24.2^^46^446^15
 ;;^UTILITY(U,$J,358.3,6739,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6739,1,3,0)
 ;;=3^Dermatitis,Irritant Contact d/t Solvents
 ;;^UTILITY(U,$J,358.3,6739,1,4,0)
 ;;=4^L24.2
 ;;^UTILITY(U,$J,358.3,6739,2)
 ;;=^5009128
 ;;^UTILITY(U,$J,358.3,6740,0)
 ;;=E08.620^^46^446^22
 ;;^UTILITY(U,$J,358.3,6740,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6740,1,3,0)
 ;;=3^Diabetes d/t Underlying Condition w/ DM Dermatitis
 ;;^UTILITY(U,$J,358.3,6740,1,4,0)
 ;;=4^E08.620
 ;;^UTILITY(U,$J,358.3,6740,2)
 ;;=^5002533
 ;;^UTILITY(U,$J,358.3,6741,0)
 ;;=E08.621^^46^446^24
 ;;^UTILITY(U,$J,358.3,6741,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6741,1,3,0)
 ;;=3^Diabetes d/t Underlying Conditions w/ Foot Ulcer
 ;;^UTILITY(U,$J,358.3,6741,1,4,0)
 ;;=4^E08.621
 ;;^UTILITY(U,$J,358.3,6741,2)
 ;;=^5002534
 ;;^UTILITY(U,$J,358.3,6742,0)
 ;;=T81.33XA^^46^446^27
 ;;^UTILITY(U,$J,358.3,6742,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6742,1,3,0)
 ;;=3^Disruption Traumatic Inj/Wound Repair,Init Encntr
 ;;^UTILITY(U,$J,358.3,6742,1,4,0)
 ;;=4^T81.33XA
 ;;^UTILITY(U,$J,358.3,6742,2)
 ;;=^5054476
 ;;^UTILITY(U,$J,358.3,6743,0)
 ;;=L60.3^^46^446^30
 ;;^UTILITY(U,$J,358.3,6743,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6743,1,3,0)
 ;;=3^Dystrophic Nails
 ;;^UTILITY(U,$J,358.3,6743,1,4,0)
 ;;=4^L60.3
 ;;^UTILITY(U,$J,358.3,6743,2)
 ;;=^5009236
 ;;^UTILITY(U,$J,358.3,6744,0)
 ;;=M71.30^^46^446^25
 ;;^UTILITY(U,$J,358.3,6744,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6744,1,3,0)
 ;;=3^Digital Mucous Cyst
 ;;^UTILITY(U,$J,358.3,6744,1,4,0)
 ;;=4^M71.30
 ;;^UTILITY(U,$J,358.3,6744,2)
 ;;=^5013149
 ;;^UTILITY(U,$J,358.3,6745,0)
 ;;=L30.4^^46^447^9
 ;;^UTILITY(U,$J,358.3,6745,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6745,1,3,0)
 ;;=3^Erythema Intertrigo
 ;;^UTILITY(U,$J,358.3,6745,1,4,0)
 ;;=4^L30.4
 ;;^UTILITY(U,$J,358.3,6745,2)
 ;;=^5009157
 ;;^UTILITY(U,$J,358.3,6746,0)
 ;;=R60.0^^46^447^6
 ;;^UTILITY(U,$J,358.3,6746,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6746,1,3,0)
 ;;=3^Edema,Localized
 ;;^UTILITY(U,$J,358.3,6746,1,4,0)
 ;;=4^R60.0
 ;;^UTILITY(U,$J,358.3,6746,2)
 ;;=^5019532
 ;;^UTILITY(U,$J,358.3,6747,0)
 ;;=L53.0^^46^447^13
 ;;^UTILITY(U,$J,358.3,6747,1,0)
 ;;=^358.31IA^4^2
