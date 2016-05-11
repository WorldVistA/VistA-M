IBDEI27R ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,37545,0)
 ;;=M86.18^^140^1793^10
 ;;^UTILITY(U,$J,358.3,37545,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37545,1,3,0)
 ;;=3^Osteomyelitis, acute, oth site, oth
 ;;^UTILITY(U,$J,358.3,37545,1,4,0)
 ;;=4^M86.18
 ;;^UTILITY(U,$J,358.3,37545,2)
 ;;=^5014533
 ;;^UTILITY(U,$J,358.3,37546,0)
 ;;=M86.28^^140^1793^42
 ;;^UTILITY(U,$J,358.3,37546,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37546,1,3,0)
 ;;=3^Osteomyelitis, subacute, oth site
 ;;^UTILITY(U,$J,358.3,37546,1,4,0)
 ;;=4^M86.28
 ;;^UTILITY(U,$J,358.3,37546,2)
 ;;=^5014557
 ;;^UTILITY(U,$J,358.3,37547,0)
 ;;=M86.19^^140^1793^9
 ;;^UTILITY(U,$J,358.3,37547,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37547,1,3,0)
 ;;=3^Osteomyelitis, acute, mult sites, oth
 ;;^UTILITY(U,$J,358.3,37547,1,4,0)
 ;;=4^M86.19
 ;;^UTILITY(U,$J,358.3,37547,2)
 ;;=^5014534
 ;;^UTILITY(U,$J,358.3,37548,0)
 ;;=M86.29^^140^1793^41
 ;;^UTILITY(U,$J,358.3,37548,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37548,1,3,0)
 ;;=3^Osteomyelitis, subacute, mult sites
 ;;^UTILITY(U,$J,358.3,37548,1,4,0)
 ;;=4^M86.29
 ;;^UTILITY(U,$J,358.3,37548,2)
 ;;=^5014558
 ;;^UTILITY(U,$J,358.3,37549,0)
 ;;=M86.60^^140^1793^35
 ;;^UTILITY(U,$J,358.3,37549,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37549,1,3,0)
 ;;=3^Osteomyelitis, chron, unspec site, oth
 ;;^UTILITY(U,$J,358.3,37549,1,4,0)
 ;;=4^M86.60
 ;;^UTILITY(U,$J,358.3,37549,2)
 ;;=^5014630
 ;;^UTILITY(U,$J,358.3,37550,0)
 ;;=M86.611^^140^1793^32
 ;;^UTILITY(U,$J,358.3,37550,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37550,1,3,0)
 ;;=3^Osteomyelitis, chron, rt shldr, oth
 ;;^UTILITY(U,$J,358.3,37550,1,4,0)
 ;;=4^M86.611
 ;;^UTILITY(U,$J,358.3,37550,2)
 ;;=^5014631
 ;;^UTILITY(U,$J,358.3,37551,0)
 ;;=M86.612^^140^1793^23
 ;;^UTILITY(U,$J,358.3,37551,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37551,1,3,0)
 ;;=3^Osteomyelitis, chron, lft shldr, oth
 ;;^UTILITY(U,$J,358.3,37551,1,4,0)
 ;;=4^M86.612
 ;;^UTILITY(U,$J,358.3,37551,2)
 ;;=^5014632
 ;;^UTILITY(U,$J,358.3,37552,0)
 ;;=M86.621^^140^1793^30
 ;;^UTILITY(U,$J,358.3,37552,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37552,1,3,0)
 ;;=3^Osteomyelitis, chron, rt humerus, oth
 ;;^UTILITY(U,$J,358.3,37552,1,4,0)
 ;;=4^M86.621
 ;;^UTILITY(U,$J,358.3,37552,2)
 ;;=^5014634
 ;;^UTILITY(U,$J,358.3,37553,0)
 ;;=M86.622^^140^1793^21
 ;;^UTILITY(U,$J,358.3,37553,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37553,1,3,0)
 ;;=3^Osteomyelitis, chron, lft numerus, oth
 ;;^UTILITY(U,$J,358.3,37553,1,4,0)
 ;;=4^M86.622
 ;;^UTILITY(U,$J,358.3,37553,2)
 ;;=^5134070
 ;;^UTILITY(U,$J,358.3,37554,0)
 ;;=M86.631^^140^1793^31
 ;;^UTILITY(U,$J,358.3,37554,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37554,1,3,0)
 ;;=3^Osteomyelitis, chron, rt radius & ulna, oth
 ;;^UTILITY(U,$J,358.3,37554,1,4,0)
 ;;=4^M86.631
 ;;^UTILITY(U,$J,358.3,37554,2)
 ;;=^5014635
 ;;^UTILITY(U,$J,358.3,37555,0)
 ;;=M86.632^^140^1793^22
 ;;^UTILITY(U,$J,358.3,37555,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37555,1,3,0)
 ;;=3^Osteomyelitis, chron, lft radius & ulna, oth
 ;;^UTILITY(U,$J,358.3,37555,1,4,0)
 ;;=4^M86.632
 ;;^UTILITY(U,$J,358.3,37555,2)
 ;;=^5134072
 ;;^UTILITY(U,$J,358.3,37556,0)
 ;;=M86.641^^140^1793^29
 ;;^UTILITY(U,$J,358.3,37556,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37556,1,3,0)
 ;;=3^Osteomyelitis, chron, rt hand, oth
 ;;^UTILITY(U,$J,358.3,37556,1,4,0)
 ;;=4^M86.641
 ;;^UTILITY(U,$J,358.3,37556,2)
 ;;=^5014636
 ;;^UTILITY(U,$J,358.3,37557,0)
 ;;=M86.642^^140^1793^20
 ;;^UTILITY(U,$J,358.3,37557,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37557,1,3,0)
 ;;=3^Osteomyelitis, chron, lft hand, oth
