IBDEI2BO ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,37109,2)
 ;;=^5010141
 ;;^UTILITY(U,$J,358.3,37110,0)
 ;;=M06.871^^146^1912^40
 ;;^UTILITY(U,$J,358.3,37110,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37110,1,3,0)
 ;;=3^Arthritis, Rheum, rt ank & ft, oth, spec
 ;;^UTILITY(U,$J,358.3,37110,1,4,0)
 ;;=4^M06.871
 ;;^UTILITY(U,$J,358.3,37110,2)
 ;;=^5010140
 ;;^UTILITY(U,$J,358.3,37111,0)
 ;;=M06.89^^146^1912^39
 ;;^UTILITY(U,$J,358.3,37111,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37111,1,3,0)
 ;;=3^Arthritis, Rheum, multpl sites, oth, spec
 ;;^UTILITY(U,$J,358.3,37111,1,4,0)
 ;;=4^M06.89
 ;;^UTILITY(U,$J,358.3,37111,2)
 ;;=^5010144
 ;;^UTILITY(U,$J,358.3,37112,0)
 ;;=M05.9^^146^1912^35
 ;;^UTILITY(U,$J,358.3,37112,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37112,1,3,0)
 ;;=3^Arthritis, Rheum w/ Rheum Factor, unspec
 ;;^UTILITY(U,$J,358.3,37112,1,4,0)
 ;;=4^M05.9
 ;;^UTILITY(U,$J,358.3,37112,2)
 ;;=^5010046
 ;;^UTILITY(U,$J,358.3,37113,0)
 ;;=M05.89^^146^1912^33
 ;;^UTILITY(U,$J,358.3,37113,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37113,1,3,0)
 ;;=3^Arthritis, Rheum w/ Rheum Factor, multpl sites, oth
 ;;^UTILITY(U,$J,358.3,37113,1,4,0)
 ;;=4^M05.89
 ;;^UTILITY(U,$J,358.3,37113,2)
 ;;=^5010045
 ;;^UTILITY(U,$J,358.3,37114,0)
 ;;=M05.872^^146^1912^32
 ;;^UTILITY(U,$J,358.3,37114,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37114,1,3,0)
 ;;=3^Arthritis, Rheum w/ Rheum Factor, lft ank & ft
 ;;^UTILITY(U,$J,358.3,37114,1,4,0)
 ;;=4^M05.872
 ;;^UTILITY(U,$J,358.3,37114,2)
 ;;=^5010043
 ;;^UTILITY(U,$J,358.3,37115,0)
 ;;=M05.871^^146^1912^34
 ;;^UTILITY(U,$J,358.3,37115,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37115,1,3,0)
 ;;=3^Arthritis, Rheum w/ Rheum Factor, rt ank & ft
 ;;^UTILITY(U,$J,358.3,37115,1,4,0)
 ;;=4^M05.871
 ;;^UTILITY(U,$J,358.3,37115,2)
 ;;=^5010042
 ;;^UTILITY(U,$J,358.3,37116,0)
 ;;=M12.571^^146^1912^47
 ;;^UTILITY(U,$J,358.3,37116,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37116,1,3,0)
 ;;=3^Arthropathy, Traumatic, rt ank & ft
 ;;^UTILITY(U,$J,358.3,37116,1,4,0)
 ;;=4^M12.571
 ;;^UTILITY(U,$J,358.3,37116,2)
 ;;=^5010637
 ;;^UTILITY(U,$J,358.3,37117,0)
 ;;=M12.572^^146^1912^46
 ;;^UTILITY(U,$J,358.3,37117,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37117,1,3,0)
 ;;=3^Arthropathy, Traumatic, lft ank & ft
 ;;^UTILITY(U,$J,358.3,37117,1,4,0)
 ;;=4^M12.572
 ;;^UTILITY(U,$J,358.3,37117,2)
 ;;=^5010638
 ;;^UTILITY(U,$J,358.3,37118,0)
 ;;=S80.811A^^146^1912^10
 ;;^UTILITY(U,$J,358.3,37118,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37118,1,3,0)
 ;;=3^Abrasion, rt lwr leg, init enc
 ;;^UTILITY(U,$J,358.3,37118,1,4,0)
 ;;=4^S80.811A
 ;;^UTILITY(U,$J,358.3,37118,2)
 ;;=^5039960
 ;;^UTILITY(U,$J,358.3,37119,0)
 ;;=S80.812A^^146^1912^5
 ;;^UTILITY(U,$J,358.3,37119,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37119,1,3,0)
 ;;=3^Abrasion, lft lwr leg, init enc
 ;;^UTILITY(U,$J,358.3,37119,1,4,0)
 ;;=4^S80.812A
 ;;^UTILITY(U,$J,358.3,37119,2)
 ;;=^5039963
 ;;^UTILITY(U,$J,358.3,37120,0)
 ;;=S90.511A^^146^1912^6
 ;;^UTILITY(U,$J,358.3,37120,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37120,1,3,0)
 ;;=3^Abrasion, rt ank, init enc
 ;;^UTILITY(U,$J,358.3,37120,1,4,0)
 ;;=4^S90.511A
 ;;^UTILITY(U,$J,358.3,37120,2)
 ;;=^5043997
 ;;^UTILITY(U,$J,358.3,37121,0)
 ;;=S90.512A^^146^1912^1
 ;;^UTILITY(U,$J,358.3,37121,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37121,1,3,0)
 ;;=3^Abrasion, lft ank, init enc
 ;;^UTILITY(U,$J,358.3,37121,1,4,0)
 ;;=4^S90.512A
