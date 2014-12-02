IBDEI0GJ ; ; 12-AUG-2014
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,8030,1,3,0)
 ;;=3^Edema, Cornea
 ;;^UTILITY(U,$J,358.3,8030,1,4,0)
 ;;=4^371.20
 ;;^UTILITY(U,$J,358.3,8030,2)
 ;;=Edema, Cornea^28394
 ;;^UTILITY(U,$J,358.3,8031,0)
 ;;=371.00^^58^605^90
 ;;^UTILITY(U,$J,358.3,8031,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8031,1,3,0)
 ;;=3^Opacity, Corneal
 ;;^UTILITY(U,$J,358.3,8031,1,4,0)
 ;;=4^371.00
 ;;^UTILITY(U,$J,358.3,8031,2)
 ;;=Corneal Opacity^28398
 ;;^UTILITY(U,$J,358.3,8032,0)
 ;;=371.43^^58^605^9
 ;;^UTILITY(U,$J,358.3,8032,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8032,1,3,0)
 ;;=3^Band Keratopathy
 ;;^UTILITY(U,$J,358.3,8032,1,4,0)
 ;;=4^371.43
 ;;^UTILITY(U,$J,358.3,8032,2)
 ;;=Band Keratopathy^268979
 ;;^UTILITY(U,$J,358.3,8033,0)
 ;;=710.2^^58^605^113
 ;;^UTILITY(U,$J,358.3,8033,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8033,1,3,0)
 ;;=3^Sjogren's Disease
 ;;^UTILITY(U,$J,358.3,8033,1,4,0)
 ;;=4^710.2
 ;;^UTILITY(U,$J,358.3,8033,2)
 ;;=Sjogren's Disease^192145
 ;;^UTILITY(U,$J,358.3,8034,0)
 ;;=374.20^^58^605^79
 ;;^UTILITY(U,$J,358.3,8034,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8034,1,3,0)
 ;;=3^Lagophthalmos
 ;;^UTILITY(U,$J,358.3,8034,1,4,0)
 ;;=4^374.20
 ;;^UTILITY(U,$J,358.3,8034,2)
 ;;=Lagophthalmos^265452
 ;;^UTILITY(U,$J,358.3,8035,0)
 ;;=372.72^^58^605^49
 ;;^UTILITY(U,$J,358.3,8035,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8035,1,3,0)
 ;;=3^Hemorrhage, Conjunctival
 ;;^UTILITY(U,$J,358.3,8035,1,4,0)
 ;;=4^372.72
 ;;^UTILITY(U,$J,358.3,8035,2)
 ;;=Hemorrhage, Conjunctival^27538
 ;;^UTILITY(U,$J,358.3,8036,0)
 ;;=077.8^^58^605^16
 ;;^UTILITY(U,$J,358.3,8036,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8036,1,3,0)
 ;;=3^Conjunctivitis, Viral
 ;;^UTILITY(U,$J,358.3,8036,1,4,0)
 ;;=4^077.8
 ;;^UTILITY(U,$J,358.3,8036,2)
 ;;=Conjunctivitis, Viral^88239
 ;;^UTILITY(U,$J,358.3,8037,0)
 ;;=372.54^^58^605^15
 ;;^UTILITY(U,$J,358.3,8037,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8037,1,3,0)
 ;;=3^Concretions, Conjunctival
 ;;^UTILITY(U,$J,358.3,8037,1,4,0)
 ;;=4^372.54
 ;;^UTILITY(U,$J,358.3,8037,2)
 ;;=...Concretions, Conjunctival^269038
 ;;^UTILITY(U,$J,358.3,8038,0)
 ;;=930.9^^58^605^45
 ;;^UTILITY(U,$J,358.3,8038,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8038,1,3,0)
 ;;=3^Foreign Body, External Eye
 ;;^UTILITY(U,$J,358.3,8038,1,4,0)
 ;;=4^930.9
 ;;^UTILITY(U,$J,358.3,8038,2)
 ;;=Foreign Body, External Eye^275489
 ;;^UTILITY(U,$J,358.3,8039,0)
 ;;=372.51^^58^605^101
 ;;^UTILITY(U,$J,358.3,8039,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8039,1,3,0)
 ;;=3^Pinguecula
 ;;^UTILITY(U,$J,358.3,8039,1,4,0)
 ;;=4^372.51
 ;;^UTILITY(U,$J,358.3,8039,2)
 ;;=Pinguecula^265525
 ;;^UTILITY(U,$J,358.3,8040,0)
 ;;=379.00^^58^605^40
 ;;^UTILITY(U,$J,358.3,8040,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8040,1,3,0)
 ;;=3^Episcleritis
 ;;^UTILITY(U,$J,358.3,8040,1,4,0)
 ;;=4^379.00
 ;;^UTILITY(U,$J,358.3,8040,2)
 ;;=...^108564
 ;;^UTILITY(U,$J,358.3,8041,0)
 ;;=372.40^^58^605^104
 ;;^UTILITY(U,$J,358.3,8041,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8041,1,3,0)
 ;;=3^Pterygium
 ;;^UTILITY(U,$J,358.3,8041,1,4,0)
 ;;=4^372.40
 ;;^UTILITY(U,$J,358.3,8041,2)
 ;;=Pterygium^100819
 ;;^UTILITY(U,$J,358.3,8042,0)
 ;;=694.4^^58^605^96
 ;;^UTILITY(U,$J,358.3,8042,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8042,1,3,0)
 ;;=3^Pemphigus
 ;;^UTILITY(U,$J,358.3,8042,1,4,0)
 ;;=4^694.4
 ;;^UTILITY(U,$J,358.3,8042,2)
 ;;=Pemphigus^91124
 ;;^UTILITY(U,$J,358.3,8043,0)
 ;;=224.3^^58^605^10
 ;;^UTILITY(U,$J,358.3,8043,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8043,1,3,0)
 ;;=3^Benign Neopl Conjunctiva
 ;;^UTILITY(U,$J,358.3,8043,1,4,0)
 ;;=4^224.3
