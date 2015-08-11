IBDEI1PA ; ; 20-MAY-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;OCT 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,30509,1,4,0)
 ;;=4^H95.42
 ;;^UTILITY(U,$J,358.3,30509,2)
 ;;=^5007031
 ;;^UTILITY(U,$J,358.3,30510,0)
 ;;=I97.611^^189^1918^10
 ;;^UTILITY(U,$J,358.3,30510,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30510,1,3,0)
 ;;=3^Postprocedural Hemorrhage/Hematoma of Circ System Following Cardiac Bypass
 ;;^UTILITY(U,$J,358.3,30510,1,4,0)
 ;;=4^I97.611
 ;;^UTILITY(U,$J,358.3,30510,2)
 ;;=^5008100
 ;;^UTILITY(U,$J,358.3,30511,0)
 ;;=I97.62^^189^1918^11
 ;;^UTILITY(U,$J,358.3,30511,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30511,1,3,0)
 ;;=3^Postprocedural Hemorrhage/Hematoma of Circ System
 ;;^UTILITY(U,$J,358.3,30511,1,4,0)
 ;;=4^I97.62
 ;;^UTILITY(U,$J,358.3,30511,2)
 ;;=^5008102
 ;;^UTILITY(U,$J,358.3,30512,0)
 ;;=K91.841^^189^1918^12
 ;;^UTILITY(U,$J,358.3,30512,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30512,1,3,0)
 ;;=3^Postprocedural Hemorrhage/Hematoma of Digestive System
 ;;^UTILITY(U,$J,358.3,30512,1,4,0)
 ;;=4^K91.841
 ;;^UTILITY(U,$J,358.3,30512,2)
 ;;=^5008911
 ;;^UTILITY(U,$J,358.3,30513,0)
 ;;=N99.821^^189^1918^15
 ;;^UTILITY(U,$J,358.3,30513,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30513,1,3,0)
 ;;=3^Postprocedural Hemorrhage/Hematoma of GU System
 ;;^UTILITY(U,$J,358.3,30513,1,4,0)
 ;;=4^N99.821
 ;;^UTILITY(U,$J,358.3,30513,2)
 ;;=^5015969
 ;;^UTILITY(U,$J,358.3,30514,0)
 ;;=G97.52^^189^1918^17
 ;;^UTILITY(U,$J,358.3,30514,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30514,1,3,0)
 ;;=3^Postprocedural Hemorrhage/Hematoma of Nervous System
 ;;^UTILITY(U,$J,358.3,30514,1,4,0)
 ;;=4^G97.52
 ;;^UTILITY(U,$J,358.3,30514,2)
 ;;=^5004210
 ;;^UTILITY(U,$J,358.3,30515,0)
 ;;=J95.831^^189^1918^18
 ;;^UTILITY(U,$J,358.3,30515,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30515,1,3,0)
 ;;=3^Postprocedural Hemorrhage/Hematoma of Respiratory System
 ;;^UTILITY(U,$J,358.3,30515,1,4,0)
 ;;=4^J95.831
 ;;^UTILITY(U,$J,358.3,30515,2)
 ;;=^5008341
 ;;^UTILITY(U,$J,358.3,30516,0)
 ;;=H95.42^^189^1918^14
 ;;^UTILITY(U,$J,358.3,30516,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30516,1,3,0)
 ;;=3^Postprocedural Hemorrhage/Hematoma of Ear/Mastoid
 ;;^UTILITY(U,$J,358.3,30516,1,4,0)
 ;;=4^H95.42
 ;;^UTILITY(U,$J,358.3,30516,2)
 ;;=^5007031
 ;;^UTILITY(U,$J,358.3,30517,0)
 ;;=H59.323^^189^1918^8
 ;;^UTILITY(U,$J,358.3,30517,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30517,1,3,0)
 ;;=3^Postprocedural Hemorrhage/Hematoma of Bilateral Eye/Adnexa
 ;;^UTILITY(U,$J,358.3,30517,1,4,0)
 ;;=4^H59.323
 ;;^UTILITY(U,$J,358.3,30517,2)
 ;;=^5006423
 ;;^UTILITY(U,$J,358.3,30518,0)
 ;;=H59.322^^189^1918^16
 ;;^UTILITY(U,$J,358.3,30518,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30518,1,3,0)
 ;;=3^Postprocedural Hemorrhage/Hematoma of Left Eye/Adnexa
 ;;^UTILITY(U,$J,358.3,30518,1,4,0)
 ;;=4^H59.322
 ;;^UTILITY(U,$J,358.3,30518,2)
 ;;=^5006422
 ;;^UTILITY(U,$J,358.3,30519,0)
 ;;=H59.321^^189^1918^19
 ;;^UTILITY(U,$J,358.3,30519,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30519,1,3,0)
 ;;=3^Postprocedural Hemorrhage/Hematoma of Right Eye/Adnexa
 ;;^UTILITY(U,$J,358.3,30519,1,4,0)
 ;;=4^H59.321
 ;;^UTILITY(U,$J,358.3,30519,2)
 ;;=^5006421
 ;;^UTILITY(U,$J,358.3,30520,0)
 ;;=L76.22^^189^1918^20
 ;;^UTILITY(U,$J,358.3,30520,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30520,1,3,0)
 ;;=3^Postprocedural Hemorrhage/Hematoma of Skin
 ;;^UTILITY(U,$J,358.3,30520,1,4,0)
 ;;=4^L76.22
 ;;^UTILITY(U,$J,358.3,30520,2)
 ;;=^5009307
 ;;^UTILITY(U,$J,358.3,30521,0)
 ;;=D78.22^^189^1918^21
 ;;^UTILITY(U,$J,358.3,30521,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30521,1,3,0)
 ;;=3^Postprocedural Hemorrhage/Hematoma of Spleen
