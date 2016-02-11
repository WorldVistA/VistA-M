IBDEI0E7 ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,6198,0)
 ;;=E36.01^^40^386^29
 ;;^UTILITY(U,$J,358.3,6198,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6198,1,3,0)
 ;;=3^Intraoperative Hemorrhage/Hematoma of Endocrine System Organ/Structure
 ;;^UTILITY(U,$J,358.3,6198,1,4,0)
 ;;=4^E36.01
 ;;^UTILITY(U,$J,358.3,6198,2)
 ;;=^5002779
 ;;^UTILITY(U,$J,358.3,6199,0)
 ;;=I97.711^^40^386^12
 ;;^UTILITY(U,$J,358.3,6199,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6199,1,3,0)
 ;;=3^Intraoperative Cardiac Arrest During Surgery
 ;;^UTILITY(U,$J,358.3,6199,1,4,0)
 ;;=4^I97.711
 ;;^UTILITY(U,$J,358.3,6199,2)
 ;;=^5008104
 ;;^UTILITY(U,$J,358.3,6200,0)
 ;;=I97.791^^40^386^13
 ;;^UTILITY(U,$J,358.3,6200,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6200,1,3,0)
 ;;=3^Intraoperative Cardiac Functional Disturbance During Surgery
 ;;^UTILITY(U,$J,358.3,6200,1,4,0)
 ;;=4^I97.791
 ;;^UTILITY(U,$J,358.3,6200,2)
 ;;=^5008106
 ;;^UTILITY(U,$J,358.3,6201,0)
 ;;=I97.411^^40^386^25
 ;;^UTILITY(U,$J,358.3,6201,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6201,1,3,0)
 ;;=3^Intraoperative Hemorrhage/Hematoma of Circ System During Cardiac Bypass
 ;;^UTILITY(U,$J,358.3,6201,1,4,0)
 ;;=4^I97.411
 ;;^UTILITY(U,$J,358.3,6201,2)
 ;;=^5008094
 ;;^UTILITY(U,$J,358.3,6202,0)
 ;;=I97.410^^40^386^26
 ;;^UTILITY(U,$J,358.3,6202,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6202,1,3,0)
 ;;=3^Intraoperative Hemorrhage/Hematoma of Circ System During Cardiac Cath
 ;;^UTILITY(U,$J,358.3,6202,1,4,0)
 ;;=4^I97.410
 ;;^UTILITY(U,$J,358.3,6202,2)
 ;;=^5008093
 ;;^UTILITY(U,$J,358.3,6203,0)
 ;;=I97.42^^40^386^27
 ;;^UTILITY(U,$J,358.3,6203,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6203,1,3,0)
 ;;=3^Intraoperative Hemorrhage/Hematoma of Circ System
 ;;^UTILITY(U,$J,358.3,6203,1,4,0)
 ;;=4^I97.42
 ;;^UTILITY(U,$J,358.3,6203,2)
 ;;=^5008096
 ;;^UTILITY(U,$J,358.3,6204,0)
 ;;=K91.62^^40^386^28
 ;;^UTILITY(U,$J,358.3,6204,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6204,1,3,0)
 ;;=3^Intraoperative Hemorrhage/Hematoma of Digestive System
 ;;^UTILITY(U,$J,358.3,6204,1,4,0)
 ;;=4^K91.62
 ;;^UTILITY(U,$J,358.3,6204,2)
 ;;=^5008904
 ;;^UTILITY(U,$J,358.3,6205,0)
 ;;=H95.22^^40^386^30
 ;;^UTILITY(U,$J,358.3,6205,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6205,1,3,0)
 ;;=3^Intraoperative Hemorrhage/Hematoma of Ear/Mastoid
 ;;^UTILITY(U,$J,358.3,6205,1,4,0)
 ;;=4^H95.22
 ;;^UTILITY(U,$J,358.3,6205,2)
 ;;=^5007027
 ;;^UTILITY(U,$J,358.3,6206,0)
 ;;=E36.02^^40^386^31
 ;;^UTILITY(U,$J,358.3,6206,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6206,1,3,0)
 ;;=3^Intraoperative Hemorrhage/Hematoma of Endocrine System
 ;;^UTILITY(U,$J,358.3,6206,1,4,0)
 ;;=4^E36.02
 ;;^UTILITY(U,$J,358.3,6206,2)
 ;;=^5002780
 ;;^UTILITY(U,$J,358.3,6207,0)
 ;;=H59.121^^40^386^36
 ;;^UTILITY(U,$J,358.3,6207,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6207,1,3,0)
 ;;=3^Intraoperative Hemorrhage/Hematoma of Right Eye/Adnexa
 ;;^UTILITY(U,$J,358.3,6207,1,4,0)
 ;;=4^H59.121
 ;;^UTILITY(U,$J,358.3,6207,2)
 ;;=^5006405
 ;;^UTILITY(U,$J,358.3,6208,0)
 ;;=H59.122^^40^386^33
 ;;^UTILITY(U,$J,358.3,6208,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6208,1,3,0)
 ;;=3^Intraoperative Hemorrhage/Hematoma of Left Eye/Adnexa
 ;;^UTILITY(U,$J,358.3,6208,1,4,0)
 ;;=4^H59.122
 ;;^UTILITY(U,$J,358.3,6208,2)
 ;;=^5006406
 ;;^UTILITY(U,$J,358.3,6209,0)
 ;;=H59.123^^40^386^24
 ;;^UTILITY(U,$J,358.3,6209,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6209,1,3,0)
 ;;=3^Intraoperative Hemorrhage/Hematoma of Bilateral Eyes/Adnexa
 ;;^UTILITY(U,$J,358.3,6209,1,4,0)
 ;;=4^H59.123
 ;;^UTILITY(U,$J,358.3,6209,2)
 ;;=^5006407
 ;;^UTILITY(U,$J,358.3,6210,0)
 ;;=N99.62^^40^386^32
