IBDEI2EJ ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,38335,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38335,1,3,0)
 ;;=3^Fracture of oth skull & facial bones, right side, sequela
 ;;^UTILITY(U,$J,358.3,38335,1,4,0)
 ;;=4^S02.81XS
 ;;^UTILITY(U,$J,358.3,38335,2)
 ;;=^5139528
 ;;^UTILITY(U,$J,358.3,38336,0)
 ;;=S02.81XA^^149^1947^17
 ;;^UTILITY(U,$J,358.3,38336,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38336,1,3,0)
 ;;=3^Fracture of oth skull & facial bones, right side, init
 ;;^UTILITY(U,$J,358.3,38336,1,4,0)
 ;;=4^S02.81XA
 ;;^UTILITY(U,$J,358.3,38336,2)
 ;;=^5139523
 ;;^UTILITY(U,$J,358.3,38337,0)
 ;;=S02.81XD^^149^1947^18
 ;;^UTILITY(U,$J,358.3,38337,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38337,1,3,0)
 ;;=3^Fracture of oth skull & facial bones, right side, healing/subs
 ;;^UTILITY(U,$J,358.3,38337,1,4,0)
 ;;=4^S02.81XD
 ;;^UTILITY(U,$J,358.3,38337,2)
 ;;=^5139525
 ;;^UTILITY(U,$J,358.3,38338,0)
 ;;=S02.82XA^^149^1947^14
 ;;^UTILITY(U,$J,358.3,38338,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38338,1,3,0)
 ;;=3^Fracture of oth skull & facial bones, left side, init
 ;;^UTILITY(U,$J,358.3,38338,1,4,0)
 ;;=4^S02.82XA
 ;;^UTILITY(U,$J,358.3,38338,2)
 ;;=^5139529
 ;;^UTILITY(U,$J,358.3,38339,0)
 ;;=S02.82XD^^149^1947^15
 ;;^UTILITY(U,$J,358.3,38339,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38339,1,3,0)
 ;;=3^Fracture of oth skull & facial bones, left side, healing/subs
 ;;^UTILITY(U,$J,358.3,38339,1,4,0)
 ;;=4^S02.82XD
 ;;^UTILITY(U,$J,358.3,38339,2)
 ;;=^5139531
 ;;^UTILITY(U,$J,358.3,38340,0)
 ;;=S02.82XS^^149^1947^16
 ;;^UTILITY(U,$J,358.3,38340,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38340,1,3,0)
 ;;=3^Fracture of oth skull & facial bones, left side, sequela
 ;;^UTILITY(U,$J,358.3,38340,1,4,0)
 ;;=4^S02.82XS
 ;;^UTILITY(U,$J,358.3,38340,2)
 ;;=^5139534
 ;;^UTILITY(U,$J,358.3,38341,0)
 ;;=S06.0X0A^^149^1948^7
 ;;^UTILITY(U,$J,358.3,38341,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38341,1,3,0)
 ;;=3^Concussion w/o LOC, initial encounter
 ;;^UTILITY(U,$J,358.3,38341,1,4,0)
 ;;=4^S06.0X0A
 ;;^UTILITY(U,$J,358.3,38341,2)
 ;;=^5020666
 ;;^UTILITY(U,$J,358.3,38342,0)
 ;;=S06.0X1A^^149^1948^1
 ;;^UTILITY(U,$J,358.3,38342,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38342,1,3,0)
 ;;=3^Concussion w LOC of 30 minutes or less, init
 ;;^UTILITY(U,$J,358.3,38342,1,4,0)
 ;;=4^S06.0X1A
 ;;^UTILITY(U,$J,358.3,38342,2)
 ;;=^5020669
 ;;^UTILITY(U,$J,358.3,38343,0)
 ;;=S06.0X0D^^149^1948^9
 ;;^UTILITY(U,$J,358.3,38343,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38343,1,3,0)
 ;;=3^Concussion w/o LOC, subs encntr
 ;;^UTILITY(U,$J,358.3,38343,1,4,0)
 ;;=4^S06.0X0D
 ;;^UTILITY(U,$J,358.3,38343,2)
 ;;=^5020667
 ;;^UTILITY(U,$J,358.3,38344,0)
 ;;=S06.0X1D^^149^1948^2
 ;;^UTILITY(U,$J,358.3,38344,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38344,1,3,0)
 ;;=3^Concussion w LOC of 30 minutes or less, subs
 ;;^UTILITY(U,$J,358.3,38344,1,4,0)
 ;;=4^S06.0X1D
 ;;^UTILITY(U,$J,358.3,38344,2)
 ;;=^5020670
 ;;^UTILITY(U,$J,358.3,38345,0)
 ;;=S06.0X0S^^149^1948^8
 ;;^UTILITY(U,$J,358.3,38345,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38345,1,3,0)
 ;;=3^Concussion w/o LOC, sequela
 ;;^UTILITY(U,$J,358.3,38345,1,4,0)
 ;;=4^S06.0X0S
 ;;^UTILITY(U,$J,358.3,38345,2)
 ;;=^5020668
 ;;^UTILITY(U,$J,358.3,38346,0)
 ;;=S06.0X1S^^149^1948^3
 ;;^UTILITY(U,$J,358.3,38346,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38346,1,3,0)
 ;;=3^Concussion w LOC of 30 minutes or less, sequela
