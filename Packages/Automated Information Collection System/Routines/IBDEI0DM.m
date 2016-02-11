IBDEI0DM ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,5933,1,3,0)
 ;;=3^Postprocedural Hemorrhage/Hematoma of Ear/Mastoid
 ;;^UTILITY(U,$J,358.3,5933,1,4,0)
 ;;=4^H95.42
 ;;^UTILITY(U,$J,358.3,5933,2)
 ;;=^5007031
 ;;^UTILITY(U,$J,358.3,5934,0)
 ;;=I97.611^^40^380^10
 ;;^UTILITY(U,$J,358.3,5934,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5934,1,3,0)
 ;;=3^Postprocedural Hemorrhage/Hematoma of Circ System Following Cardiac Bypass
 ;;^UTILITY(U,$J,358.3,5934,1,4,0)
 ;;=4^I97.611
 ;;^UTILITY(U,$J,358.3,5934,2)
 ;;=^5008100
 ;;^UTILITY(U,$J,358.3,5935,0)
 ;;=I97.62^^40^380^11
 ;;^UTILITY(U,$J,358.3,5935,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5935,1,3,0)
 ;;=3^Postprocedural Hemorrhage/Hematoma of Circ System
 ;;^UTILITY(U,$J,358.3,5935,1,4,0)
 ;;=4^I97.62
 ;;^UTILITY(U,$J,358.3,5935,2)
 ;;=^5008102
 ;;^UTILITY(U,$J,358.3,5936,0)
 ;;=K91.841^^40^380^12
 ;;^UTILITY(U,$J,358.3,5936,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5936,1,3,0)
 ;;=3^Postprocedural Hemorrhage/Hematoma of Digestive System
 ;;^UTILITY(U,$J,358.3,5936,1,4,0)
 ;;=4^K91.841
 ;;^UTILITY(U,$J,358.3,5936,2)
 ;;=^5008911
 ;;^UTILITY(U,$J,358.3,5937,0)
 ;;=N99.821^^40^380^15
 ;;^UTILITY(U,$J,358.3,5937,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5937,1,3,0)
 ;;=3^Postprocedural Hemorrhage/Hematoma of GU System
 ;;^UTILITY(U,$J,358.3,5937,1,4,0)
 ;;=4^N99.821
 ;;^UTILITY(U,$J,358.3,5937,2)
 ;;=^5015969
 ;;^UTILITY(U,$J,358.3,5938,0)
 ;;=G97.52^^40^380^17
 ;;^UTILITY(U,$J,358.3,5938,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5938,1,3,0)
 ;;=3^Postprocedural Hemorrhage/Hematoma of Nervous System
 ;;^UTILITY(U,$J,358.3,5938,1,4,0)
 ;;=4^G97.52
 ;;^UTILITY(U,$J,358.3,5938,2)
 ;;=^5004210
 ;;^UTILITY(U,$J,358.3,5939,0)
 ;;=J95.831^^40^380^18
 ;;^UTILITY(U,$J,358.3,5939,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5939,1,3,0)
 ;;=3^Postprocedural Hemorrhage/Hematoma of Respiratory System
 ;;^UTILITY(U,$J,358.3,5939,1,4,0)
 ;;=4^J95.831
 ;;^UTILITY(U,$J,358.3,5939,2)
 ;;=^5008341
 ;;^UTILITY(U,$J,358.3,5940,0)
 ;;=H95.42^^40^380^14
 ;;^UTILITY(U,$J,358.3,5940,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5940,1,3,0)
 ;;=3^Postprocedural Hemorrhage/Hematoma of Ear/Mastoid
 ;;^UTILITY(U,$J,358.3,5940,1,4,0)
 ;;=4^H95.42
 ;;^UTILITY(U,$J,358.3,5940,2)
 ;;=^5007031
 ;;^UTILITY(U,$J,358.3,5941,0)
 ;;=H59.323^^40^380^8
 ;;^UTILITY(U,$J,358.3,5941,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5941,1,3,0)
 ;;=3^Postprocedural Hemorrhage/Hematoma of Bilateral Eye/Adnexa
 ;;^UTILITY(U,$J,358.3,5941,1,4,0)
 ;;=4^H59.323
 ;;^UTILITY(U,$J,358.3,5941,2)
 ;;=^5006423
 ;;^UTILITY(U,$J,358.3,5942,0)
 ;;=H59.322^^40^380^16
 ;;^UTILITY(U,$J,358.3,5942,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5942,1,3,0)
 ;;=3^Postprocedural Hemorrhage/Hematoma of Left Eye/Adnexa
 ;;^UTILITY(U,$J,358.3,5942,1,4,0)
 ;;=4^H59.322
 ;;^UTILITY(U,$J,358.3,5942,2)
 ;;=^5006422
 ;;^UTILITY(U,$J,358.3,5943,0)
 ;;=H59.321^^40^380^19
 ;;^UTILITY(U,$J,358.3,5943,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5943,1,3,0)
 ;;=3^Postprocedural Hemorrhage/Hematoma of Right Eye/Adnexa
 ;;^UTILITY(U,$J,358.3,5943,1,4,0)
 ;;=4^H59.321
 ;;^UTILITY(U,$J,358.3,5943,2)
 ;;=^5006421
 ;;^UTILITY(U,$J,358.3,5944,0)
 ;;=L76.22^^40^380^20
 ;;^UTILITY(U,$J,358.3,5944,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5944,1,3,0)
 ;;=3^Postprocedural Hemorrhage/Hematoma of Skin
 ;;^UTILITY(U,$J,358.3,5944,1,4,0)
 ;;=4^L76.22
 ;;^UTILITY(U,$J,358.3,5944,2)
 ;;=^5009307
 ;;^UTILITY(U,$J,358.3,5945,0)
 ;;=D78.22^^40^380^21
 ;;^UTILITY(U,$J,358.3,5945,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5945,1,3,0)
 ;;=3^Postprocedural Hemorrhage/Hematoma of Spleen
