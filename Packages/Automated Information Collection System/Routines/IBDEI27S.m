IBDEI27S ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,37557,1,4,0)
 ;;=4^M86.642
 ;;^UTILITY(U,$J,358.3,37557,2)
 ;;=^5134074
 ;;^UTILITY(U,$J,358.3,37558,0)
 ;;=M86.651^^140^1793^33
 ;;^UTILITY(U,$J,358.3,37558,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37558,1,3,0)
 ;;=3^Osteomyelitis, chron, rt thigh, oth
 ;;^UTILITY(U,$J,358.3,37558,1,4,0)
 ;;=4^M86.651
 ;;^UTILITY(U,$J,358.3,37558,2)
 ;;=^5014637
 ;;^UTILITY(U,$J,358.3,37559,0)
 ;;=M86.652^^140^1793^24
 ;;^UTILITY(U,$J,358.3,37559,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37559,1,3,0)
 ;;=3^Osteomyelitis, chron, lft thigh, oth
 ;;^UTILITY(U,$J,358.3,37559,1,4,0)
 ;;=4^M86.652
 ;;^UTILITY(U,$J,358.3,37559,2)
 ;;=^5014638
 ;;^UTILITY(U,$J,358.3,37560,0)
 ;;=M86.661^^140^1793^34
 ;;^UTILITY(U,$J,358.3,37560,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37560,1,3,0)
 ;;=3^Osteomyelitis, chron, rt tib/fib, oth
 ;;^UTILITY(U,$J,358.3,37560,1,4,0)
 ;;=4^M86.661
 ;;^UTILITY(U,$J,358.3,37560,2)
 ;;=^5014640
 ;;^UTILITY(U,$J,358.3,37561,0)
 ;;=M86.662^^140^1793^25
 ;;^UTILITY(U,$J,358.3,37561,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37561,1,3,0)
 ;;=3^Osteomyelitis, chron, lft tib/fib, oth
 ;;^UTILITY(U,$J,358.3,37561,1,4,0)
 ;;=4^M86.662
 ;;^UTILITY(U,$J,358.3,37561,2)
 ;;=^5134076
 ;;^UTILITY(U,$J,358.3,37562,0)
 ;;=M86.671^^140^1793^28
 ;;^UTILITY(U,$J,358.3,37562,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37562,1,3,0)
 ;;=3^Osteomyelitis, chron, rt ankle & foot, oth
 ;;^UTILITY(U,$J,358.3,37562,1,4,0)
 ;;=4^M86.671
 ;;^UTILITY(U,$J,358.3,37562,2)
 ;;=^5014641
 ;;^UTILITY(U,$J,358.3,37563,0)
 ;;=M86.672^^140^1793^19
 ;;^UTILITY(U,$J,358.3,37563,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37563,1,3,0)
 ;;=3^Osteomyelitis, chron, lft ankle & foot, oth
 ;;^UTILITY(U,$J,358.3,37563,1,4,0)
 ;;=4^M86.672
 ;;^UTILITY(U,$J,358.3,37563,2)
 ;;=^5014642
 ;;^UTILITY(U,$J,358.3,37564,0)
 ;;=M86.68^^140^1793^27
 ;;^UTILITY(U,$J,358.3,37564,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37564,1,3,0)
 ;;=3^Osteomyelitis, chron, oth, oth site
 ;;^UTILITY(U,$J,358.3,37564,1,4,0)
 ;;=4^M86.68
 ;;^UTILITY(U,$J,358.3,37564,2)
 ;;=^5014644
 ;;^UTILITY(U,$J,358.3,37565,0)
 ;;=M86.69^^140^1793^26
 ;;^UTILITY(U,$J,358.3,37565,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37565,1,3,0)
 ;;=3^Osteomyelitis, chron, mult sites, oth
 ;;^UTILITY(U,$J,358.3,37565,1,4,0)
 ;;=4^M86.69
 ;;^UTILITY(U,$J,358.3,37565,2)
 ;;=^5014645
 ;;^UTILITY(U,$J,358.3,37566,0)
 ;;=M86.9^^140^1793^49
 ;;^UTILITY(U,$J,358.3,37566,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37566,1,3,0)
 ;;=3^Osteomyelitis, unspec
 ;;^UTILITY(U,$J,358.3,37566,1,4,0)
 ;;=4^M86.9
 ;;^UTILITY(U,$J,358.3,37566,2)
 ;;=^5014656
 ;;^UTILITY(U,$J,358.3,37567,0)
 ;;=M90.80^^140^1793^66
 ;;^UTILITY(U,$J,358.3,37567,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37567,1,3,0)
 ;;=3^Osteopathy in dis clsfd elswhr, unsp site
 ;;^UTILITY(U,$J,358.3,37567,1,4,0)
 ;;=4^M90.80
 ;;^UTILITY(U,$J,358.3,37567,2)
 ;;=^5015168
 ;;^UTILITY(U,$J,358.3,37568,0)
 ;;=M90.811^^140^1793^63
 ;;^UTILITY(U,$J,358.3,37568,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37568,1,3,0)
 ;;=3^Osteopathy in dis clsfd elswhr, rt shldr
 ;;^UTILITY(U,$J,358.3,37568,1,4,0)
 ;;=4^M90.811
 ;;^UTILITY(U,$J,358.3,37568,2)
 ;;=^5015169
 ;;^UTILITY(U,$J,358.3,37569,0)
 ;;=M90.812^^140^1793^54
 ;;^UTILITY(U,$J,358.3,37569,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37569,1,3,0)
 ;;=3^Osteopathy in dis clsfd elswhr, lft shldr
 ;;^UTILITY(U,$J,358.3,37569,1,4,0)
 ;;=4^M90.812
 ;;^UTILITY(U,$J,358.3,37569,2)
 ;;=^5015170
 ;;^UTILITY(U,$J,358.3,37570,0)
 ;;=M90.821^^140^1793^65
 ;;^UTILITY(U,$J,358.3,37570,1,0)
 ;;=^358.31IA^4^2
