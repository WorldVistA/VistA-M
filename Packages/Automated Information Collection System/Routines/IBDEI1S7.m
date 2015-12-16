IBDEI1S7 ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,31444,1,3,0)
 ;;=3^Stiffness of right elbow, not elsewhere classified
 ;;^UTILITY(U,$J,358.3,31444,1,4,0)
 ;;=4^M25.621
 ;;^UTILITY(U,$J,358.3,31444,2)
 ;;=^5011624
 ;;^UTILITY(U,$J,358.3,31445,0)
 ;;=M25.674^^180^1956^60
 ;;^UTILITY(U,$J,358.3,31445,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31445,1,3,0)
 ;;=3^Stiffness of right foot, not elsewhere classified
 ;;^UTILITY(U,$J,358.3,31445,1,4,0)
 ;;=4^M25.674
 ;;^UTILITY(U,$J,358.3,31445,2)
 ;;=^5011642
 ;;^UTILITY(U,$J,358.3,31446,0)
 ;;=M25.641^^180^1956^61
 ;;^UTILITY(U,$J,358.3,31446,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31446,1,3,0)
 ;;=3^Stiffness of right hand, not elsewhere classified
 ;;^UTILITY(U,$J,358.3,31446,1,4,0)
 ;;=4^M25.641
 ;;^UTILITY(U,$J,358.3,31446,2)
 ;;=^5011630
 ;;^UTILITY(U,$J,358.3,31447,0)
 ;;=M25.651^^180^1956^62
 ;;^UTILITY(U,$J,358.3,31447,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31447,1,3,0)
 ;;=3^Stiffness of right hip, not elsewhere classified
 ;;^UTILITY(U,$J,358.3,31447,1,4,0)
 ;;=4^M25.651
 ;;^UTILITY(U,$J,358.3,31447,2)
 ;;=^5011633
 ;;^UTILITY(U,$J,358.3,31448,0)
 ;;=M25.661^^180^1956^63
 ;;^UTILITY(U,$J,358.3,31448,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31448,1,3,0)
 ;;=3^Stiffness of right knee, not elsewhere classified
 ;;^UTILITY(U,$J,358.3,31448,1,4,0)
 ;;=4^M25.661
 ;;^UTILITY(U,$J,358.3,31448,2)
 ;;=^5011636
 ;;^UTILITY(U,$J,358.3,31449,0)
 ;;=M25.611^^180^1956^64
 ;;^UTILITY(U,$J,358.3,31449,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31449,1,3,0)
 ;;=3^Stiffness of right shoulder, not elsewhere classified
 ;;^UTILITY(U,$J,358.3,31449,1,4,0)
 ;;=4^M25.611
 ;;^UTILITY(U,$J,358.3,31449,2)
 ;;=^5011621
 ;;^UTILITY(U,$J,358.3,31450,0)
 ;;=M25.631^^180^1956^65
 ;;^UTILITY(U,$J,358.3,31450,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31450,1,3,0)
 ;;=3^Stiffness of right wrist, not elsewhere classified
 ;;^UTILITY(U,$J,358.3,31450,1,4,0)
 ;;=4^M25.631
 ;;^UTILITY(U,$J,358.3,31450,2)
 ;;=^5011627
 ;;^UTILITY(U,$J,358.3,31451,0)
 ;;=S96.912A^^180^1956^66
 ;;^UTILITY(U,$J,358.3,31451,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31451,1,3,0)
 ;;=3^Strain of unsp msl/tnd at ank/ft level, left foot, init
 ;;^UTILITY(U,$J,358.3,31451,1,4,0)
 ;;=4^S96.912A
 ;;^UTILITY(U,$J,358.3,31451,2)
 ;;=^5137751
 ;;^UTILITY(U,$J,358.3,31452,0)
 ;;=S96.911A^^180^1956^67
 ;;^UTILITY(U,$J,358.3,31452,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31452,1,3,0)
 ;;=3^Strain of unsp msl/tnd at ank/ft level, right foot, init
 ;;^UTILITY(U,$J,358.3,31452,1,4,0)
 ;;=4^S96.911A
 ;;^UTILITY(U,$J,358.3,31452,2)
 ;;=^5137750
 ;;^UTILITY(U,$J,358.3,31453,0)
 ;;=S56.912A^^180^1956^68
 ;;^UTILITY(U,$J,358.3,31453,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31453,1,3,0)
 ;;=3^Strain of unsp musc/fasc/tend at forarm lv, left arm, init
 ;;^UTILITY(U,$J,358.3,31453,1,4,0)
 ;;=4^S56.912A
 ;;^UTILITY(U,$J,358.3,31453,2)
 ;;=^5135514
 ;;^UTILITY(U,$J,358.3,31454,0)
 ;;=S56.911A^^180^1956^69
 ;;^UTILITY(U,$J,358.3,31454,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31454,1,3,0)
 ;;=3^Strain of unsp musc/fasc/tend at forarm lv, right arm, init
 ;;^UTILITY(U,$J,358.3,31454,1,4,0)
 ;;=4^S56.911A
 ;;^UTILITY(U,$J,358.3,31454,2)
 ;;=^5135513
 ;;^UTILITY(U,$J,358.3,31455,0)
 ;;=S22.9XXS^^180^1957^1
 ;;^UTILITY(U,$J,358.3,31455,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31455,1,3,0)
 ;;=3^Fracture of bony thorax, part unspecified, sequela
 ;;^UTILITY(U,$J,358.3,31455,1,4,0)
 ;;=4^S22.9XXS
 ;;^UTILITY(U,$J,358.3,31455,2)
 ;;=^5023158
 ;;^UTILITY(U,$J,358.3,31456,0)
 ;;=S42.92XS^^180^1957^6
 ;;^UTILITY(U,$J,358.3,31456,1,0)
 ;;=^358.31IA^4^2
