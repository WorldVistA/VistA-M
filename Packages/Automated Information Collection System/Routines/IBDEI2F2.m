IBDEI2F2 ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,40582,1,3,0)
 ;;=3^Burn of rt ankl, third degree, init enc
 ;;^UTILITY(U,$J,358.3,40582,1,4,0)
 ;;=4^T25.311A
 ;;^UTILITY(U,$J,358.3,40582,2)
 ;;=^5048586
 ;;^UTILITY(U,$J,358.3,40583,0)
 ;;=T25.312A^^189^2082^20
 ;;^UTILITY(U,$J,358.3,40583,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40583,1,3,0)
 ;;=3^Burn of lft ankl, third degree, init enc
 ;;^UTILITY(U,$J,358.3,40583,1,4,0)
 ;;=4^T25.312A
 ;;^UTILITY(U,$J,358.3,40583,2)
 ;;=^5048589
 ;;^UTILITY(U,$J,358.3,40584,0)
 ;;=T24.331A^^189^2082^44
 ;;^UTILITY(U,$J,358.3,40584,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40584,1,3,0)
 ;;=3^Burn of rt lwr leg, third degree, init enc
 ;;^UTILITY(U,$J,358.3,40584,1,4,0)
 ;;=4^T24.331A
 ;;^UTILITY(U,$J,358.3,40584,2)
 ;;=^5048316
 ;;^UTILITY(U,$J,358.3,40585,0)
 ;;=T24.332A^^189^2082^28
 ;;^UTILITY(U,$J,358.3,40585,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40585,1,3,0)
 ;;=3^Burn of lft lwr leg, third degree, init enc
 ;;^UTILITY(U,$J,358.3,40585,1,4,0)
 ;;=4^T24.332A
 ;;^UTILITY(U,$J,358.3,40585,2)
 ;;=^5048319
 ;;^UTILITY(U,$J,358.3,40586,0)
 ;;=T31.0^^189^2082^50
 ;;^UTILITY(U,$J,358.3,40586,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40586,1,3,0)
 ;;=3^Burns involving less than 10% of body surface
 ;;^UTILITY(U,$J,358.3,40586,1,4,0)
 ;;=4^T31.0
 ;;^UTILITY(U,$J,358.3,40586,2)
 ;;=^5048924
 ;;^UTILITY(U,$J,358.3,40587,0)
 ;;=T31.10^^189^2082^51
 ;;^UTILITY(U,$J,358.3,40587,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40587,1,3,0)
 ;;=3^Burns of 10-19% of body surfc w 0% to 9% 3rd degree burns
 ;;^UTILITY(U,$J,358.3,40587,1,4,0)
 ;;=4^T31.10
 ;;^UTILITY(U,$J,358.3,40587,2)
 ;;=^5048925
 ;;^UTILITY(U,$J,358.3,40588,0)
 ;;=S90.424A^^189^2082^16
 ;;^UTILITY(U,$J,358.3,40588,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40588,1,3,0)
 ;;=3^Blister (nontherm), rt lsr toe(s), init enc
 ;;^UTILITY(U,$J,358.3,40588,1,4,0)
 ;;=4^S90.424A
 ;;^UTILITY(U,$J,358.3,40588,2)
 ;;=^5043916
 ;;^UTILITY(U,$J,358.3,40589,0)
 ;;=S90.425A^^189^2082^13
 ;;^UTILITY(U,$J,358.3,40589,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40589,1,3,0)
 ;;=3^Blister (nontherm), lft lsr toe(s), init enc
 ;;^UTILITY(U,$J,358.3,40589,1,4,0)
 ;;=4^S90.425A
 ;;^UTILITY(U,$J,358.3,40589,2)
 ;;=^5043919
 ;;^UTILITY(U,$J,358.3,40590,0)
 ;;=S90.821A^^189^2082^14
 ;;^UTILITY(U,$J,358.3,40590,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40590,1,3,0)
 ;;=3^Blister (nontherm), rt ft, init enc
 ;;^UTILITY(U,$J,358.3,40590,1,4,0)
 ;;=4^S90.821A
 ;;^UTILITY(U,$J,358.3,40590,2)
 ;;=^5044060
 ;;^UTILITY(U,$J,358.3,40591,0)
 ;;=S90.822A^^189^2082^11
 ;;^UTILITY(U,$J,358.3,40591,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40591,1,3,0)
 ;;=3^Blister (nontherm), lft ft, init enc
 ;;^UTILITY(U,$J,358.3,40591,1,4,0)
 ;;=4^S90.822A
 ;;^UTILITY(U,$J,358.3,40591,2)
 ;;=^5044063
 ;;^UTILITY(U,$J,358.3,40592,0)
 ;;=D81.819^^189^2082^2
 ;;^UTILITY(U,$J,358.3,40592,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40592,1,3,0)
 ;;=3^Biotin-Dependent Carboxylase Deficiency,Unspec
 ;;^UTILITY(U,$J,358.3,40592,1,4,0)
 ;;=4^D81.819
 ;;^UTILITY(U,$J,358.3,40592,2)
 ;;=^5002424
 ;;^UTILITY(U,$J,358.3,40593,0)
 ;;=L03.032^^189^2083^5
 ;;^UTILITY(U,$J,358.3,40593,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40593,1,3,0)
 ;;=3^Cellulitis of left toe
 ;;^UTILITY(U,$J,358.3,40593,1,4,0)
 ;;=4^L03.032
 ;;^UTILITY(U,$J,358.3,40593,2)
 ;;=^5009026
 ;;^UTILITY(U,$J,358.3,40594,0)
 ;;=L03.031^^189^2083^6
 ;;^UTILITY(U,$J,358.3,40594,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40594,1,3,0)
 ;;=3^Cellulitis of right toe
 ;;^UTILITY(U,$J,358.3,40594,1,4,0)
 ;;=4^L03.031
