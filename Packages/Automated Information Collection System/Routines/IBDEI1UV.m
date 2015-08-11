IBDEI1UV ; ; 20-MAY-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;OCT 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,33063,0)
 ;;=T31.0^^191^1964^50
 ;;^UTILITY(U,$J,358.3,33063,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33063,1,3,0)
 ;;=3^Burns involving less than 10% of body surface
 ;;^UTILITY(U,$J,358.3,33063,1,4,0)
 ;;=4^T31.0
 ;;^UTILITY(U,$J,358.3,33063,2)
 ;;=^5048924
 ;;^UTILITY(U,$J,358.3,33064,0)
 ;;=T31.10^^191^1964^51
 ;;^UTILITY(U,$J,358.3,33064,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33064,1,3,0)
 ;;=3^Burns of 10-19% of body surfc w 0% to 9% 3rd degree burns
 ;;^UTILITY(U,$J,358.3,33064,1,4,0)
 ;;=4^T31.10
 ;;^UTILITY(U,$J,358.3,33064,2)
 ;;=^5048925
 ;;^UTILITY(U,$J,358.3,33065,0)
 ;;=S90.424A^^191^1964^16
 ;;^UTILITY(U,$J,358.3,33065,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33065,1,3,0)
 ;;=3^Blister (nontherm), rt lsr toe(s), init enc
 ;;^UTILITY(U,$J,358.3,33065,1,4,0)
 ;;=4^S90.424A
 ;;^UTILITY(U,$J,358.3,33065,2)
 ;;=^5043916
 ;;^UTILITY(U,$J,358.3,33066,0)
 ;;=S90.425A^^191^1964^13
 ;;^UTILITY(U,$J,358.3,33066,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33066,1,3,0)
 ;;=3^Blister (nontherm), lft lsr toe(s), init enc
 ;;^UTILITY(U,$J,358.3,33066,1,4,0)
 ;;=4^S90.425A
 ;;^UTILITY(U,$J,358.3,33066,2)
 ;;=^5043919
 ;;^UTILITY(U,$J,358.3,33067,0)
 ;;=S90.821A^^191^1964^14
 ;;^UTILITY(U,$J,358.3,33067,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33067,1,3,0)
 ;;=3^Blister (nontherm), rt ft, init enc
 ;;^UTILITY(U,$J,358.3,33067,1,4,0)
 ;;=4^S90.821A
 ;;^UTILITY(U,$J,358.3,33067,2)
 ;;=^5044060
 ;;^UTILITY(U,$J,358.3,33068,0)
 ;;=S90.822A^^191^1964^11
 ;;^UTILITY(U,$J,358.3,33068,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33068,1,3,0)
 ;;=3^Blister (nontherm), lft ft, init enc
 ;;^UTILITY(U,$J,358.3,33068,1,4,0)
 ;;=4^S90.822A
 ;;^UTILITY(U,$J,358.3,33068,2)
 ;;=^5044063
 ;;^UTILITY(U,$J,358.3,33069,0)
 ;;=D81.819^^191^1964^2
 ;;^UTILITY(U,$J,358.3,33069,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33069,1,3,0)
 ;;=3^Biotin-Dependent Carboxylase Deficiency,Unspec
 ;;^UTILITY(U,$J,358.3,33069,1,4,0)
 ;;=4^D81.819
 ;;^UTILITY(U,$J,358.3,33069,2)
 ;;=^5002424
 ;;^UTILITY(U,$J,358.3,33070,0)
 ;;=L03.032^^191^1965^5
 ;;^UTILITY(U,$J,358.3,33070,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33070,1,3,0)
 ;;=3^Cellulitis of left toe
 ;;^UTILITY(U,$J,358.3,33070,1,4,0)
 ;;=4^L03.032
 ;;^UTILITY(U,$J,358.3,33070,2)
 ;;=^5009026
 ;;^UTILITY(U,$J,358.3,33071,0)
 ;;=L03.031^^191^1965^6
 ;;^UTILITY(U,$J,358.3,33071,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33071,1,3,0)
 ;;=3^Cellulitis of right toe
 ;;^UTILITY(U,$J,358.3,33071,1,4,0)
 ;;=4^L03.031
 ;;^UTILITY(U,$J,358.3,33071,2)
 ;;=^5009025
 ;;^UTILITY(U,$J,358.3,33072,0)
 ;;=L94.8^^191^1965^18
 ;;^UTILITY(U,$J,358.3,33072,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33072,1,3,0)
 ;;=3^Connective tissue disorders, localized, oth,spec
 ;;^UTILITY(U,$J,358.3,33072,1,4,0)
 ;;=4^L94.8
 ;;^UTILITY(U,$J,358.3,33072,2)
 ;;=^5009474
 ;;^UTILITY(U,$J,358.3,33073,0)
 ;;=M24.571^^191^1965^21
 ;;^UTILITY(U,$J,358.3,33073,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33073,1,3,0)
 ;;=3^Contracture, right ankle
 ;;^UTILITY(U,$J,358.3,33073,1,4,0)
 ;;=4^M24.571
 ;;^UTILITY(U,$J,358.3,33073,2)
 ;;=^5011420
 ;;^UTILITY(U,$J,358.3,33074,0)
 ;;=M24.572^^191^1965^19
 ;;^UTILITY(U,$J,358.3,33074,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33074,1,3,0)
 ;;=3^Contracture, left ankle
 ;;^UTILITY(U,$J,358.3,33074,1,4,0)
 ;;=4^M24.572
 ;;^UTILITY(U,$J,358.3,33074,2)
 ;;=^5011421
 ;;^UTILITY(U,$J,358.3,33075,0)
 ;;=M24.574^^191^1965^22
 ;;^UTILITY(U,$J,358.3,33075,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33075,1,3,0)
 ;;=3^Contracture, right foot
