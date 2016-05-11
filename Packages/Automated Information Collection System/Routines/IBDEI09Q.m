IBDEI09Q ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,4308,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4308,1,3,0)
 ;;=3^Dermatitis,Allergic Contact d/t Metals
 ;;^UTILITY(U,$J,358.3,4308,1,4,0)
 ;;=4^L23.0
 ;;^UTILITY(U,$J,358.3,4308,2)
 ;;=^5009115
 ;;^UTILITY(U,$J,358.3,4309,0)
 ;;=B00.1^^21^272^10
 ;;^UTILITY(U,$J,358.3,4309,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4309,1,3,0)
 ;;=3^Dermatitis,Herpes Simplex
 ;;^UTILITY(U,$J,358.3,4309,1,4,0)
 ;;=4^B00.1
 ;;^UTILITY(U,$J,358.3,4309,2)
 ;;=^5000468
 ;;^UTILITY(U,$J,358.3,4310,0)
 ;;=L24.0^^21^272^13
 ;;^UTILITY(U,$J,358.3,4310,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4310,1,3,0)
 ;;=3^Dermatitis,Irritant Contact d/t Detergents
 ;;^UTILITY(U,$J,358.3,4310,1,4,0)
 ;;=4^L24.0
 ;;^UTILITY(U,$J,358.3,4310,2)
 ;;=^5009126
 ;;^UTILITY(U,$J,358.3,4311,0)
 ;;=L24.81^^21^272^14
 ;;^UTILITY(U,$J,358.3,4311,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4311,1,3,0)
 ;;=3^Dermatitis,Irritant Contact d/t Metals
 ;;^UTILITY(U,$J,358.3,4311,1,4,0)
 ;;=4^L24.81
 ;;^UTILITY(U,$J,358.3,4311,2)
 ;;=^5009134
 ;;^UTILITY(U,$J,358.3,4312,0)
 ;;=L24.2^^21^272^15
 ;;^UTILITY(U,$J,358.3,4312,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4312,1,3,0)
 ;;=3^Dermatitis,Irritant Contact d/t Solvents
 ;;^UTILITY(U,$J,358.3,4312,1,4,0)
 ;;=4^L24.2
 ;;^UTILITY(U,$J,358.3,4312,2)
 ;;=^5009128
 ;;^UTILITY(U,$J,358.3,4313,0)
 ;;=E08.620^^21^272^22
 ;;^UTILITY(U,$J,358.3,4313,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4313,1,3,0)
 ;;=3^Diabetes d/t Underlying Condition w/ DM Dermatitis
 ;;^UTILITY(U,$J,358.3,4313,1,4,0)
 ;;=4^E08.620
 ;;^UTILITY(U,$J,358.3,4313,2)
 ;;=^5002533
 ;;^UTILITY(U,$J,358.3,4314,0)
 ;;=E08.621^^21^272^24
 ;;^UTILITY(U,$J,358.3,4314,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4314,1,3,0)
 ;;=3^Diabetes d/t Underlying Conditions w/ Foot Ulcer
 ;;^UTILITY(U,$J,358.3,4314,1,4,0)
 ;;=4^E08.621
 ;;^UTILITY(U,$J,358.3,4314,2)
 ;;=^5002534
 ;;^UTILITY(U,$J,358.3,4315,0)
 ;;=T81.33XA^^21^272^27
 ;;^UTILITY(U,$J,358.3,4315,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4315,1,3,0)
 ;;=3^Disruption Traumatic Inj/Wound Repair,Init Encntr
 ;;^UTILITY(U,$J,358.3,4315,1,4,0)
 ;;=4^T81.33XA
 ;;^UTILITY(U,$J,358.3,4315,2)
 ;;=^5054476
 ;;^UTILITY(U,$J,358.3,4316,0)
 ;;=L60.3^^21^272^30
 ;;^UTILITY(U,$J,358.3,4316,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4316,1,3,0)
 ;;=3^Dystrophic Nails
 ;;^UTILITY(U,$J,358.3,4316,1,4,0)
 ;;=4^L60.3
 ;;^UTILITY(U,$J,358.3,4316,2)
 ;;=^5009236
 ;;^UTILITY(U,$J,358.3,4317,0)
 ;;=M71.30^^21^272^25
 ;;^UTILITY(U,$J,358.3,4317,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4317,1,3,0)
 ;;=3^Digital Mucous Cyst
 ;;^UTILITY(U,$J,358.3,4317,1,4,0)
 ;;=4^M71.30
 ;;^UTILITY(U,$J,358.3,4317,2)
 ;;=^5013149
 ;;^UTILITY(U,$J,358.3,4318,0)
 ;;=L30.4^^21^273^9
 ;;^UTILITY(U,$J,358.3,4318,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4318,1,3,0)
 ;;=3^Erythema Intertrigo
 ;;^UTILITY(U,$J,358.3,4318,1,4,0)
 ;;=4^L30.4
 ;;^UTILITY(U,$J,358.3,4318,2)
 ;;=^5009157
 ;;^UTILITY(U,$J,358.3,4319,0)
 ;;=R60.0^^21^273^6
 ;;^UTILITY(U,$J,358.3,4319,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4319,1,3,0)
 ;;=3^Edema,Localized
 ;;^UTILITY(U,$J,358.3,4319,1,4,0)
 ;;=4^R60.0
 ;;^UTILITY(U,$J,358.3,4319,2)
 ;;=^5019532
 ;;^UTILITY(U,$J,358.3,4320,0)
 ;;=L53.0^^21^273^13
 ;;^UTILITY(U,$J,358.3,4320,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4320,1,3,0)
 ;;=3^Erythema Toxic
 ;;^UTILITY(U,$J,358.3,4320,1,4,0)
 ;;=4^L53.0
 ;;^UTILITY(U,$J,358.3,4320,2)
 ;;=^5009207
 ;;^UTILITY(U,$J,358.3,4321,0)
 ;;=L53.1^^21^273^8
 ;;^UTILITY(U,$J,358.3,4321,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4321,1,3,0)
 ;;=3^Erythema Annulare Centrifugum
