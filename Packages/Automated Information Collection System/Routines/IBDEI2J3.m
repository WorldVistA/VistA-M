IBDEI2J3 ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,42889,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,42889,1,3,0)
 ;;=3^Leakage of cystostomy cath,Init Encntr
 ;;^UTILITY(U,$J,358.3,42889,1,4,0)
 ;;=4^T83.030A
 ;;^UTILITY(U,$J,358.3,42889,2)
 ;;=^5054971
 ;;^UTILITY(U,$J,358.3,42890,0)
 ;;=T83.090A^^162^2049^20
 ;;^UTILITY(U,$J,358.3,42890,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,42890,1,3,0)
 ;;=3^Mech compl cystostomy cath,Oth,Init Encntr
 ;;^UTILITY(U,$J,358.3,42890,1,4,0)
 ;;=4^T83.090A
 ;;^UTILITY(U,$J,358.3,42890,2)
 ;;=^5054977
 ;;^UTILITY(U,$J,358.3,42891,0)
 ;;=T83.110A^^162^2049^5
 ;;^UTILITY(U,$J,358.3,42891,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,42891,1,3,0)
 ;;=3^Breakdown (mech) urinary elec stimltr dvc,Init Encntr
 ;;^UTILITY(U,$J,358.3,42891,1,4,0)
 ;;=4^T83.110A
 ;;^UTILITY(U,$J,358.3,42891,2)
 ;;=^5054983
 ;;^UTILITY(U,$J,358.3,42892,0)
 ;;=T83.111A^^162^2049^6
 ;;^UTILITY(U,$J,358.3,42892,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,42892,1,3,0)
 ;;=3^Breakdown (mech) urinary sphnctr implnt,Init Encntr
 ;;^UTILITY(U,$J,358.3,42892,1,4,0)
 ;;=4^T83.111A
 ;;^UTILITY(U,$J,358.3,42892,2)
 ;;=^5054986
 ;;^UTILITY(U,$J,358.3,42893,0)
 ;;=T83.112A^^162^2049^7
 ;;^UTILITY(U,$J,358.3,42893,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,42893,1,3,0)
 ;;=3^Breakdown (mech) urinary stnt,Init Encntr
 ;;^UTILITY(U,$J,358.3,42893,1,4,0)
 ;;=4^T83.112A
 ;;^UTILITY(U,$J,358.3,42893,2)
 ;;=^5054989
 ;;^UTILITY(U,$J,358.3,42894,0)
 ;;=T83.118A^^162^2049^4
 ;;^UTILITY(U,$J,358.3,42894,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,42894,1,3,0)
 ;;=3^Breakdown (mech) urinary dvc/implnt,Init Encntr
 ;;^UTILITY(U,$J,358.3,42894,1,4,0)
 ;;=4^T83.118A
 ;;^UTILITY(U,$J,358.3,42894,2)
 ;;=^5054992
 ;;^UTILITY(U,$J,358.3,42895,0)
 ;;=T83.191A^^162^2049^25
 ;;^UTILITY(U,$J,358.3,42895,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,42895,1,3,0)
 ;;=3^Mech compl urinary sphinct implnt,Oth,Init Encntr
 ;;^UTILITY(U,$J,358.3,42895,1,4,0)
 ;;=4^T83.191A
 ;;^UTILITY(U,$J,358.3,42895,2)
 ;;=^5055010
 ;;^UTILITY(U,$J,358.3,42896,0)
 ;;=T83.192A^^162^2049^26
 ;;^UTILITY(U,$J,358.3,42896,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,42896,1,3,0)
 ;;=3^Mech complstnt urinary stent,Oth,Init Encntr
 ;;^UTILITY(U,$J,358.3,42896,1,4,0)
 ;;=4^T83.192A
 ;;^UTILITY(U,$J,358.3,42896,2)
 ;;=^5055013
 ;;^UTILITY(U,$J,358.3,42897,0)
 ;;=T83.198A^^162^2049^21
 ;;^UTILITY(U,$J,358.3,42897,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,42897,1,3,0)
 ;;=3^Mech compl oth urinary dvc/implnts,Init Encntr
 ;;^UTILITY(U,$J,358.3,42897,1,4,0)
 ;;=4^T83.198A
 ;;^UTILITY(U,$J,358.3,42897,2)
 ;;=^5055016
 ;;^UTILITY(U,$J,358.3,42898,0)
 ;;=T83.410A^^162^2049^3
 ;;^UTILITY(U,$J,358.3,42898,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,42898,1,3,0)
 ;;=3^Breakdown (mech) penile (implanted) prosth,Init Encntr
 ;;^UTILITY(U,$J,358.3,42898,1,4,0)
 ;;=4^T83.410A
 ;;^UTILITY(U,$J,358.3,42898,2)
 ;;=^5055040
 ;;^UTILITY(U,$J,358.3,42899,0)
 ;;=T83.418A^^162^2049^8
 ;;^UTILITY(U,$J,358.3,42899,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,42899,1,3,0)
 ;;=3^Breakdown prosth dvc/implnt/grft of genitl trct,Init Encntr
 ;;^UTILITY(U,$J,358.3,42899,1,4,0)
 ;;=4^T83.418A
 ;;^UTILITY(U,$J,358.3,42899,2)
 ;;=^5055043
 ;;^UTILITY(U,$J,358.3,42900,0)
 ;;=T83.420A^^162^2049^15
 ;;^UTILITY(U,$J,358.3,42900,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,42900,1,3,0)
 ;;=3^Dsplcmnt penile (implanted) prosth,Init Encntr
 ;;^UTILITY(U,$J,358.3,42900,1,4,0)
 ;;=4^T83.420A
 ;;^UTILITY(U,$J,358.3,42900,2)
 ;;=^5055046
 ;;^UTILITY(U,$J,358.3,42901,0)
 ;;=T83.428A^^162^2049^16
 ;;^UTILITY(U,$J,358.3,42901,1,0)
 ;;=^358.31IA^4^2
