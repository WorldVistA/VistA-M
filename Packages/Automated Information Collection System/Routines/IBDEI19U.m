IBDEI19U ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,21257,0)
 ;;=I21.3^^101^1028^33
 ;;^UTILITY(U,$J,358.3,21257,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21257,1,3,0)
 ;;=3^ST elevation (STEMI) myocardial infarction of unsp site
 ;;^UTILITY(U,$J,358.3,21257,1,4,0)
 ;;=4^I21.3
 ;;^UTILITY(U,$J,358.3,21257,2)
 ;;=^5007087
 ;;^UTILITY(U,$J,358.3,21258,0)
 ;;=J43.0^^101^1028^35
 ;;^UTILITY(U,$J,358.3,21258,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21258,1,3,0)
 ;;=3^Unilateral pulmonary emphysema [MacLeod's syndrome]
 ;;^UTILITY(U,$J,358.3,21258,1,4,0)
 ;;=4^J43.0
 ;;^UTILITY(U,$J,358.3,21258,2)
 ;;=^5008235
 ;;^UTILITY(U,$J,358.3,21259,0)
 ;;=I50.40^^101^1028^19
 ;;^UTILITY(U,$J,358.3,21259,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21259,1,3,0)
 ;;=3^Combined systolic and diastolic (congestive) hrt fail,Unspec
 ;;^UTILITY(U,$J,358.3,21259,1,4,0)
 ;;=4^I50.40
 ;;^UTILITY(U,$J,358.3,21259,2)
 ;;=^5007247
 ;;^UTILITY(U,$J,358.3,21260,0)
 ;;=I50.30^^101^1028^21
 ;;^UTILITY(U,$J,358.3,21260,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21260,1,3,0)
 ;;=3^Diastolic (congestive) heart failure,Unspec
 ;;^UTILITY(U,$J,358.3,21260,1,4,0)
 ;;=4^I50.30
 ;;^UTILITY(U,$J,358.3,21260,2)
 ;;=^5007243
 ;;^UTILITY(U,$J,358.3,21261,0)
 ;;=I50.20^^101^1028^34
 ;;^UTILITY(U,$J,358.3,21261,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21261,1,3,0)
 ;;=3^Systolic (congestive) heart failure,Unspec
 ;;^UTILITY(U,$J,358.3,21261,1,4,0)
 ;;=4^I50.20
 ;;^UTILITY(U,$J,358.3,21261,2)
 ;;=^5007239
 ;;^UTILITY(U,$J,358.3,21262,0)
 ;;=T84.81XA^^101^1029^4
 ;;^UTILITY(U,$J,358.3,21262,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21262,1,3,0)
 ;;=3^Embolism due to internal orthopedic prosth dev/grft, init
 ;;^UTILITY(U,$J,358.3,21262,1,4,0)
 ;;=4^T84.81XA
 ;;^UTILITY(U,$J,358.3,21262,2)
 ;;=^5055454
 ;;^UTILITY(U,$J,358.3,21263,0)
 ;;=T84.81XS^^101^1029^5
 ;;^UTILITY(U,$J,358.3,21263,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21263,1,3,0)
 ;;=3^Embolism due to internal orthopedic prosth dev/grft, sequela
 ;;^UTILITY(U,$J,358.3,21263,1,4,0)
 ;;=4^T84.81XS
 ;;^UTILITY(U,$J,358.3,21263,2)
 ;;=^5055456
 ;;^UTILITY(U,$J,358.3,21264,0)
 ;;=T84.81XD^^101^1029^6
 ;;^UTILITY(U,$J,358.3,21264,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21264,1,3,0)
 ;;=3^Embolism due to internal orthopedic prosth dev/grft, subs
 ;;^UTILITY(U,$J,358.3,21264,1,4,0)
 ;;=4^T84.81XD
 ;;^UTILITY(U,$J,358.3,21264,2)
 ;;=^5055455
 ;;^UTILITY(U,$J,358.3,21265,0)
 ;;=T84.82XA^^101^1029^7
 ;;^UTILITY(U,$J,358.3,21265,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21265,1,3,0)
 ;;=3^Fibrosis due to internal orthopedic prosth dev/grft, init
 ;;^UTILITY(U,$J,358.3,21265,1,4,0)
 ;;=4^T84.82XA
 ;;^UTILITY(U,$J,358.3,21265,2)
 ;;=^5055457
 ;;^UTILITY(U,$J,358.3,21266,0)
 ;;=T84.82XD^^101^1029^8
 ;;^UTILITY(U,$J,358.3,21266,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21266,1,3,0)
 ;;=3^Fibrosis due to internal orthopedic prosth dev/grft, subs
 ;;^UTILITY(U,$J,358.3,21266,1,4,0)
 ;;=4^T84.82XD
 ;;^UTILITY(U,$J,358.3,21266,2)
 ;;=^5055458
 ;;^UTILITY(U,$J,358.3,21267,0)
 ;;=T84.82XS^^101^1029^9
 ;;^UTILITY(U,$J,358.3,21267,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21267,1,3,0)
 ;;=3^Fibrosis due to internal orthopedic prosth dev/grft, sequela
 ;;^UTILITY(U,$J,358.3,21267,1,4,0)
 ;;=4^T84.82XS
 ;;^UTILITY(U,$J,358.3,21267,2)
 ;;=^5055459
 ;;^UTILITY(U,$J,358.3,21268,0)
 ;;=T84.83XA^^101^1029^10
 ;;^UTILITY(U,$J,358.3,21268,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21268,1,3,0)
 ;;=3^Hemorrhage due to internal orthopedic prosth dev/grft, init
 ;;^UTILITY(U,$J,358.3,21268,1,4,0)
 ;;=4^T84.83XA
