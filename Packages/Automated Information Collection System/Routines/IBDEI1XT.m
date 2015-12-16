IBDEI1XT ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,34021,1,3,0)
 ;;=3^Systolic (congestive) heart failure,Unspec
 ;;^UTILITY(U,$J,358.3,34021,1,4,0)
 ;;=4^I50.20
 ;;^UTILITY(U,$J,358.3,34021,2)
 ;;=^5007239
 ;;^UTILITY(U,$J,358.3,34022,0)
 ;;=T84.81XA^^183^2015^4
 ;;^UTILITY(U,$J,358.3,34022,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34022,1,3,0)
 ;;=3^Embolism due to internal orthopedic prosth dev/grft, init
 ;;^UTILITY(U,$J,358.3,34022,1,4,0)
 ;;=4^T84.81XA
 ;;^UTILITY(U,$J,358.3,34022,2)
 ;;=^5055454
 ;;^UTILITY(U,$J,358.3,34023,0)
 ;;=T84.81XS^^183^2015^5
 ;;^UTILITY(U,$J,358.3,34023,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34023,1,3,0)
 ;;=3^Embolism due to internal orthopedic prosth dev/grft, sequela
 ;;^UTILITY(U,$J,358.3,34023,1,4,0)
 ;;=4^T84.81XS
 ;;^UTILITY(U,$J,358.3,34023,2)
 ;;=^5055456
 ;;^UTILITY(U,$J,358.3,34024,0)
 ;;=T84.81XD^^183^2015^6
 ;;^UTILITY(U,$J,358.3,34024,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34024,1,3,0)
 ;;=3^Embolism due to internal orthopedic prosth dev/grft, subs
 ;;^UTILITY(U,$J,358.3,34024,1,4,0)
 ;;=4^T84.81XD
 ;;^UTILITY(U,$J,358.3,34024,2)
 ;;=^5055455
 ;;^UTILITY(U,$J,358.3,34025,0)
 ;;=T84.82XA^^183^2015^7
 ;;^UTILITY(U,$J,358.3,34025,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34025,1,3,0)
 ;;=3^Fibrosis due to internal orthopedic prosth dev/grft, init
 ;;^UTILITY(U,$J,358.3,34025,1,4,0)
 ;;=4^T84.82XA
 ;;^UTILITY(U,$J,358.3,34025,2)
 ;;=^5055457
 ;;^UTILITY(U,$J,358.3,34026,0)
 ;;=T84.82XD^^183^2015^8
 ;;^UTILITY(U,$J,358.3,34026,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34026,1,3,0)
 ;;=3^Fibrosis due to internal orthopedic prosth dev/grft, subs
 ;;^UTILITY(U,$J,358.3,34026,1,4,0)
 ;;=4^T84.82XD
 ;;^UTILITY(U,$J,358.3,34026,2)
 ;;=^5055458
 ;;^UTILITY(U,$J,358.3,34027,0)
 ;;=T84.82XS^^183^2015^9
 ;;^UTILITY(U,$J,358.3,34027,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34027,1,3,0)
 ;;=3^Fibrosis due to internal orthopedic prosth dev/grft, sequela
 ;;^UTILITY(U,$J,358.3,34027,1,4,0)
 ;;=4^T84.82XS
 ;;^UTILITY(U,$J,358.3,34027,2)
 ;;=^5055459
 ;;^UTILITY(U,$J,358.3,34028,0)
 ;;=T84.83XA^^183^2015^10
 ;;^UTILITY(U,$J,358.3,34028,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34028,1,3,0)
 ;;=3^Hemorrhage due to internal orthopedic prosth dev/grft, init
 ;;^UTILITY(U,$J,358.3,34028,1,4,0)
 ;;=4^T84.83XA
 ;;^UTILITY(U,$J,358.3,34028,2)
 ;;=^5055460
 ;;^UTILITY(U,$J,358.3,34029,0)
 ;;=T84.83XD^^183^2015^11
 ;;^UTILITY(U,$J,358.3,34029,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34029,1,3,0)
 ;;=3^Hemorrhage due to internal orthopedic prosth dev/grft, subs
 ;;^UTILITY(U,$J,358.3,34029,1,4,0)
 ;;=4^T84.83XD
 ;;^UTILITY(U,$J,358.3,34029,2)
 ;;=^5055461
 ;;^UTILITY(U,$J,358.3,34030,0)
 ;;=T84.83XS^^183^2015^12
 ;;^UTILITY(U,$J,358.3,34030,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34030,1,3,0)
 ;;=3^Hemorrhage due to internal orthopedic prosth dev/grft, sequela
 ;;^UTILITY(U,$J,358.3,34030,1,4,0)
 ;;=4^T84.83XS
 ;;^UTILITY(U,$J,358.3,34030,2)
 ;;=^5055462
 ;;^UTILITY(U,$J,358.3,34031,0)
 ;;=T84.89XA^^183^2015^1
 ;;^UTILITY(U,$J,358.3,34031,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34031,1,3,0)
 ;;=3^Comp of internal orthopedic prosth dev/grft, init
 ;;^UTILITY(U,$J,358.3,34031,1,4,0)
 ;;=4^T84.89XA
 ;;^UTILITY(U,$J,358.3,34031,2)
 ;;=^5055472
 ;;^UTILITY(U,$J,358.3,34032,0)
 ;;=T84.89XD^^183^2015^2
 ;;^UTILITY(U,$J,358.3,34032,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34032,1,3,0)
 ;;=3^Comp of internal orthopedic prosth dev/grft, subs
 ;;^UTILITY(U,$J,358.3,34032,1,4,0)
 ;;=4^T84.89XD
 ;;^UTILITY(U,$J,358.3,34032,2)
 ;;=^5055473
 ;;^UTILITY(U,$J,358.3,34033,0)
 ;;=T84.89XS^^183^2015^3
