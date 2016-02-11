IBDEI1AM ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,21600,0)
 ;;=S72.022S^^101^1033^11
 ;;^UTILITY(U,$J,358.3,21600,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21600,1,3,0)
 ;;=3^Displaced epiphy fx of left femur, sequela
 ;;^UTILITY(U,$J,358.3,21600,1,4,0)
 ;;=4^S72.022S
 ;;^UTILITY(U,$J,358.3,21600,2)
 ;;=^5037152
 ;;^UTILITY(U,$J,358.3,21601,0)
 ;;=S72.024S^^101^1033^58
 ;;^UTILITY(U,$J,358.3,21601,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21601,1,3,0)
 ;;=3^Nondisp epiphy fx of right femur, sequela
 ;;^UTILITY(U,$J,358.3,21601,1,4,0)
 ;;=4^S72.024S
 ;;^UTILITY(U,$J,358.3,21601,2)
 ;;=^5037184
 ;;^UTILITY(U,$J,358.3,21602,0)
 ;;=S72.025S^^101^1033^57
 ;;^UTILITY(U,$J,358.3,21602,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21602,1,3,0)
 ;;=3^Nondisp epiphy fx of left femur, sequela
 ;;^UTILITY(U,$J,358.3,21602,1,4,0)
 ;;=4^S72.025S
 ;;^UTILITY(U,$J,358.3,21602,2)
 ;;=^5037200
 ;;^UTILITY(U,$J,358.3,21603,0)
 ;;=S72.031S^^101^1033^28
 ;;^UTILITY(U,$J,358.3,21603,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21603,1,3,0)
 ;;=3^Displaced midcervical fx of right femur, sequela
 ;;^UTILITY(U,$J,358.3,21603,1,4,0)
 ;;=4^S72.031S
 ;;^UTILITY(U,$J,358.3,21603,2)
 ;;=^5037232
 ;;^UTILITY(U,$J,358.3,21604,0)
 ;;=S72.032S^^101^1033^27
 ;;^UTILITY(U,$J,358.3,21604,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21604,1,3,0)
 ;;=3^Displaced midcervical fx of left femur, sequela
 ;;^UTILITY(U,$J,358.3,21604,1,4,0)
 ;;=4^S72.032S
 ;;^UTILITY(U,$J,358.3,21604,2)
 ;;=^5037248
 ;;^UTILITY(U,$J,358.3,21605,0)
 ;;=S72.034S^^101^1033^74
 ;;^UTILITY(U,$J,358.3,21605,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21605,1,3,0)
 ;;=3^Nondisp midcervical fx of right femur, sequela
 ;;^UTILITY(U,$J,358.3,21605,1,4,0)
 ;;=4^S72.034S
 ;;^UTILITY(U,$J,358.3,21605,2)
 ;;=^5037280
 ;;^UTILITY(U,$J,358.3,21606,0)
 ;;=S72.035S^^101^1033^73
 ;;^UTILITY(U,$J,358.3,21606,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21606,1,3,0)
 ;;=3^Nondisp midcervical fx of left femur, sequela
 ;;^UTILITY(U,$J,358.3,21606,1,4,0)
 ;;=4^S72.035S
 ;;^UTILITY(U,$J,358.3,21606,2)
 ;;=^5037296
 ;;^UTILITY(U,$J,358.3,21607,0)
 ;;=S72.041S^^101^1033^6
 ;;^UTILITY(U,$J,358.3,21607,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21607,1,3,0)
 ;;=3^Displaced base of neck fx of right femur, sequela
 ;;^UTILITY(U,$J,358.3,21607,1,4,0)
 ;;=4^S72.041S
 ;;^UTILITY(U,$J,358.3,21607,2)
 ;;=^5037328
 ;;^UTILITY(U,$J,358.3,21608,0)
 ;;=S72.042S^^101^1033^5
 ;;^UTILITY(U,$J,358.3,21608,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21608,1,3,0)
 ;;=3^Displaced base of neck fx of left femur, sequela
 ;;^UTILITY(U,$J,358.3,21608,1,4,0)
 ;;=4^S72.042S
 ;;^UTILITY(U,$J,358.3,21608,2)
 ;;=^5037344
 ;;^UTILITY(U,$J,358.3,21609,0)
 ;;=S72.044S^^101^1033^52
 ;;^UTILITY(U,$J,358.3,21609,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21609,1,3,0)
 ;;=3^Nondisp base of neck fx of right femur, sequela
 ;;^UTILITY(U,$J,358.3,21609,1,4,0)
 ;;=4^S72.044S
 ;;^UTILITY(U,$J,358.3,21609,2)
 ;;=^5037376
 ;;^UTILITY(U,$J,358.3,21610,0)
 ;;=S72.061S^^101^1033^4
 ;;^UTILITY(U,$J,358.3,21610,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21610,1,3,0)
 ;;=3^Displaced articular fx of head of right femur, sequela
 ;;^UTILITY(U,$J,358.3,21610,1,4,0)
 ;;=4^S72.061S
 ;;^UTILITY(U,$J,358.3,21610,2)
 ;;=^5037461
 ;;^UTILITY(U,$J,358.3,21611,0)
 ;;=S72.062S^^101^1033^3
 ;;^UTILITY(U,$J,358.3,21611,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21611,1,3,0)
 ;;=3^Displaced articular fx of head of left femur, sequela
 ;;^UTILITY(U,$J,358.3,21611,1,4,0)
 ;;=4^S72.062S
 ;;^UTILITY(U,$J,358.3,21611,2)
 ;;=^5037477
 ;;^UTILITY(U,$J,358.3,21612,0)
 ;;=S72.064S^^101^1033^50
