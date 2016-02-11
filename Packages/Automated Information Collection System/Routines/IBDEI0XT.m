IBDEI0XT ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,15585,1,4,0)
 ;;=4^H95.42
 ;;^UTILITY(U,$J,358.3,15585,2)
 ;;=^5007031
 ;;^UTILITY(U,$J,358.3,15586,0)
 ;;=I97.611^^85^822^10
 ;;^UTILITY(U,$J,358.3,15586,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15586,1,3,0)
 ;;=3^Postprocedural Hemorrhage/Hematoma of Circ System Following Cardiac Bypass
 ;;^UTILITY(U,$J,358.3,15586,1,4,0)
 ;;=4^I97.611
 ;;^UTILITY(U,$J,358.3,15586,2)
 ;;=^5008100
 ;;^UTILITY(U,$J,358.3,15587,0)
 ;;=I97.62^^85^822^11
 ;;^UTILITY(U,$J,358.3,15587,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15587,1,3,0)
 ;;=3^Postprocedural Hemorrhage/Hematoma of Circ System
 ;;^UTILITY(U,$J,358.3,15587,1,4,0)
 ;;=4^I97.62
 ;;^UTILITY(U,$J,358.3,15587,2)
 ;;=^5008102
 ;;^UTILITY(U,$J,358.3,15588,0)
 ;;=K91.841^^85^822^12
 ;;^UTILITY(U,$J,358.3,15588,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15588,1,3,0)
 ;;=3^Postprocedural Hemorrhage/Hematoma of Digestive System
 ;;^UTILITY(U,$J,358.3,15588,1,4,0)
 ;;=4^K91.841
 ;;^UTILITY(U,$J,358.3,15588,2)
 ;;=^5008911
 ;;^UTILITY(U,$J,358.3,15589,0)
 ;;=N99.821^^85^822^15
 ;;^UTILITY(U,$J,358.3,15589,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15589,1,3,0)
 ;;=3^Postprocedural Hemorrhage/Hematoma of GU System
 ;;^UTILITY(U,$J,358.3,15589,1,4,0)
 ;;=4^N99.821
 ;;^UTILITY(U,$J,358.3,15589,2)
 ;;=^5015969
 ;;^UTILITY(U,$J,358.3,15590,0)
 ;;=G97.52^^85^822^17
 ;;^UTILITY(U,$J,358.3,15590,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15590,1,3,0)
 ;;=3^Postprocedural Hemorrhage/Hematoma of Nervous System
 ;;^UTILITY(U,$J,358.3,15590,1,4,0)
 ;;=4^G97.52
 ;;^UTILITY(U,$J,358.3,15590,2)
 ;;=^5004210
 ;;^UTILITY(U,$J,358.3,15591,0)
 ;;=J95.831^^85^822^18
 ;;^UTILITY(U,$J,358.3,15591,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15591,1,3,0)
 ;;=3^Postprocedural Hemorrhage/Hematoma of Respiratory System
 ;;^UTILITY(U,$J,358.3,15591,1,4,0)
 ;;=4^J95.831
 ;;^UTILITY(U,$J,358.3,15591,2)
 ;;=^5008341
 ;;^UTILITY(U,$J,358.3,15592,0)
 ;;=H95.42^^85^822^14
 ;;^UTILITY(U,$J,358.3,15592,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15592,1,3,0)
 ;;=3^Postprocedural Hemorrhage/Hematoma of Ear/Mastoid
 ;;^UTILITY(U,$J,358.3,15592,1,4,0)
 ;;=4^H95.42
 ;;^UTILITY(U,$J,358.3,15592,2)
 ;;=^5007031
 ;;^UTILITY(U,$J,358.3,15593,0)
 ;;=H59.323^^85^822^8
 ;;^UTILITY(U,$J,358.3,15593,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15593,1,3,0)
 ;;=3^Postprocedural Hemorrhage/Hematoma of Bilateral Eye/Adnexa
 ;;^UTILITY(U,$J,358.3,15593,1,4,0)
 ;;=4^H59.323
 ;;^UTILITY(U,$J,358.3,15593,2)
 ;;=^5006423
 ;;^UTILITY(U,$J,358.3,15594,0)
 ;;=H59.322^^85^822^16
 ;;^UTILITY(U,$J,358.3,15594,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15594,1,3,0)
 ;;=3^Postprocedural Hemorrhage/Hematoma of Left Eye/Adnexa
 ;;^UTILITY(U,$J,358.3,15594,1,4,0)
 ;;=4^H59.322
 ;;^UTILITY(U,$J,358.3,15594,2)
 ;;=^5006422
 ;;^UTILITY(U,$J,358.3,15595,0)
 ;;=H59.321^^85^822^19
 ;;^UTILITY(U,$J,358.3,15595,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15595,1,3,0)
 ;;=3^Postprocedural Hemorrhage/Hematoma of Right Eye/Adnexa
 ;;^UTILITY(U,$J,358.3,15595,1,4,0)
 ;;=4^H59.321
 ;;^UTILITY(U,$J,358.3,15595,2)
 ;;=^5006421
 ;;^UTILITY(U,$J,358.3,15596,0)
 ;;=L76.22^^85^822^20
 ;;^UTILITY(U,$J,358.3,15596,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15596,1,3,0)
 ;;=3^Postprocedural Hemorrhage/Hematoma of Skin
 ;;^UTILITY(U,$J,358.3,15596,1,4,0)
 ;;=4^L76.22
 ;;^UTILITY(U,$J,358.3,15596,2)
 ;;=^5009307
 ;;^UTILITY(U,$J,358.3,15597,0)
 ;;=D78.22^^85^822^21
 ;;^UTILITY(U,$J,358.3,15597,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15597,1,3,0)
 ;;=3^Postprocedural Hemorrhage/Hematoma of Spleen
