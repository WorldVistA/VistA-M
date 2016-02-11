IBDEI097 ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,3762,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3762,1,3,0)
 ;;=3^Osteolysis,Unspec Site
 ;;^UTILITY(U,$J,358.3,3762,1,4,0)
 ;;=4^M89.50
 ;;^UTILITY(U,$J,358.3,3762,2)
 ;;=^5015037
 ;;^UTILITY(U,$J,358.3,3763,0)
 ;;=M83.9^^28^258^121
 ;;^UTILITY(U,$J,358.3,3763,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3763,1,3,0)
 ;;=3^Osteomalacia,Unspec
 ;;^UTILITY(U,$J,358.3,3763,1,4,0)
 ;;=4^M83.9
 ;;^UTILITY(U,$J,358.3,3763,2)
 ;;=^5013565
 ;;^UTILITY(U,$J,358.3,3764,0)
 ;;=M86.9^^28^258^122
 ;;^UTILITY(U,$J,358.3,3764,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3764,1,3,0)
 ;;=3^Osteomyelitis,Unspec
 ;;^UTILITY(U,$J,358.3,3764,1,4,0)
 ;;=4^M86.9
 ;;^UTILITY(U,$J,358.3,3764,2)
 ;;=^5014656
 ;;^UTILITY(U,$J,358.3,3765,0)
 ;;=M87.9^^28^258^123
 ;;^UTILITY(U,$J,358.3,3765,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3765,1,3,0)
 ;;=3^Osteonecrosis,Unspec
 ;;^UTILITY(U,$J,358.3,3765,1,4,0)
 ;;=4^M87.9
 ;;^UTILITY(U,$J,358.3,3765,2)
 ;;=^5014873
 ;;^UTILITY(U,$J,358.3,3766,0)
 ;;=M89.60^^28^258^124
 ;;^UTILITY(U,$J,358.3,3766,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3766,1,3,0)
 ;;=3^Osteopathy after Poliomyelitis,Unspec Site
 ;;^UTILITY(U,$J,358.3,3766,1,4,0)
 ;;=4^M89.60
 ;;^UTILITY(U,$J,358.3,3766,2)
 ;;=^5015061
 ;;^UTILITY(U,$J,358.3,3767,0)
 ;;=M90.80^^28^258^125
 ;;^UTILITY(U,$J,358.3,3767,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3767,1,3,0)
 ;;=3^Osteopathy in Dieseases Classified Elsewhere
 ;;^UTILITY(U,$J,358.3,3767,1,4,0)
 ;;=4^M90.80
 ;;^UTILITY(U,$J,358.3,3767,2)
 ;;=^5015168
 ;;^UTILITY(U,$J,358.3,3768,0)
 ;;=M80.00XA^^28^258^127
 ;;^UTILITY(U,$J,358.3,3768,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3768,1,3,0)
 ;;=3^Osteoporosis,Age-Related Fx,Unspec Site,Init Encntr
 ;;^UTILITY(U,$J,358.3,3768,1,4,0)
 ;;=4^M80.00XA
 ;;^UTILITY(U,$J,358.3,3768,2)
 ;;=^5013363
 ;;^UTILITY(U,$J,358.3,3769,0)
 ;;=M80.00XG^^28^258^128
 ;;^UTILITY(U,$J,358.3,3769,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3769,1,3,0)
 ;;=3^Osteoporosis,Age-Related Fx,Unspec Site,Delayed Healing
 ;;^UTILITY(U,$J,358.3,3769,1,4,0)
 ;;=4^M80.00XG
 ;;^UTILITY(U,$J,358.3,3769,2)
 ;;=^5013365
 ;;^UTILITY(U,$J,358.3,3770,0)
 ;;=M80.00XP^^28^258^129
 ;;^UTILITY(U,$J,358.3,3770,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3770,1,3,0)
 ;;=3^Osteoporosis,Age-Related Fx,Unspec Site,Malunion
 ;;^UTILITY(U,$J,358.3,3770,1,4,0)
 ;;=4^M80.00XP
 ;;^UTILITY(U,$J,358.3,3770,2)
 ;;=^5013367
 ;;^UTILITY(U,$J,358.3,3771,0)
 ;;=M80.00XK^^28^258^130
 ;;^UTILITY(U,$J,358.3,3771,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3771,1,3,0)
 ;;=3^Osteoporosis,Age-Related Fx,Unspec Site,Nonunion
 ;;^UTILITY(U,$J,358.3,3771,1,4,0)
 ;;=4^M80.00XK
 ;;^UTILITY(U,$J,358.3,3771,2)
 ;;=^5013366
 ;;^UTILITY(U,$J,358.3,3772,0)
 ;;=M80.00XD^^28^258^131
 ;;^UTILITY(U,$J,358.3,3772,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3772,1,3,0)
 ;;=3^Osteoporosis,Age-Related Fx,Unspec Site,Routine Healing
 ;;^UTILITY(U,$J,358.3,3772,1,4,0)
 ;;=4^M80.00XD
 ;;^UTILITY(U,$J,358.3,3772,2)
 ;;=^5013364
 ;;^UTILITY(U,$J,358.3,3773,0)
 ;;=M80.00XS^^28^258^132
 ;;^UTILITY(U,$J,358.3,3773,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3773,1,3,0)
 ;;=3^Osteoporosis,Age-Related Fx,Unspec Site,Sequela
 ;;^UTILITY(U,$J,358.3,3773,1,4,0)
 ;;=4^M80.00XS
 ;;^UTILITY(U,$J,358.3,3773,2)
 ;;=^5013368
 ;;^UTILITY(U,$J,358.3,3774,0)
 ;;=M81.0^^28^258^126
 ;;^UTILITY(U,$J,358.3,3774,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3774,1,3,0)
 ;;=3^Osteoporosis,Age-Related
 ;;^UTILITY(U,$J,358.3,3774,1,4,0)
 ;;=4^M81.0
 ;;^UTILITY(U,$J,358.3,3774,2)
 ;;=^5013555
 ;;^UTILITY(U,$J,358.3,3775,0)
 ;;=Z87.310^^28^258^137
