IBDEI0SU ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,12847,1,4,0)
 ;;=4^E36.01
 ;;^UTILITY(U,$J,358.3,12847,2)
 ;;=^5002779
 ;;^UTILITY(U,$J,358.3,12848,0)
 ;;=I97.711^^80^789^12
 ;;^UTILITY(U,$J,358.3,12848,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12848,1,3,0)
 ;;=3^Intraoperative Cardiac Arrest During Surgery
 ;;^UTILITY(U,$J,358.3,12848,1,4,0)
 ;;=4^I97.711
 ;;^UTILITY(U,$J,358.3,12848,2)
 ;;=^5008104
 ;;^UTILITY(U,$J,358.3,12849,0)
 ;;=I97.791^^80^789^13
 ;;^UTILITY(U,$J,358.3,12849,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12849,1,3,0)
 ;;=3^Intraoperative Cardiac Functional Disturbance During Surgery
 ;;^UTILITY(U,$J,358.3,12849,1,4,0)
 ;;=4^I97.791
 ;;^UTILITY(U,$J,358.3,12849,2)
 ;;=^5008106
 ;;^UTILITY(U,$J,358.3,12850,0)
 ;;=I97.411^^80^789^25
 ;;^UTILITY(U,$J,358.3,12850,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12850,1,3,0)
 ;;=3^Intraoperative Hemorrhage/Hematoma of Circ System During Cardiac Bypass
 ;;^UTILITY(U,$J,358.3,12850,1,4,0)
 ;;=4^I97.411
 ;;^UTILITY(U,$J,358.3,12850,2)
 ;;=^5008094
 ;;^UTILITY(U,$J,358.3,12851,0)
 ;;=I97.410^^80^789^26
 ;;^UTILITY(U,$J,358.3,12851,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12851,1,3,0)
 ;;=3^Intraoperative Hemorrhage/Hematoma of Circ System During Cardiac Cath
 ;;^UTILITY(U,$J,358.3,12851,1,4,0)
 ;;=4^I97.410
 ;;^UTILITY(U,$J,358.3,12851,2)
 ;;=^5008093
 ;;^UTILITY(U,$J,358.3,12852,0)
 ;;=I97.42^^80^789^27
 ;;^UTILITY(U,$J,358.3,12852,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12852,1,3,0)
 ;;=3^Intraoperative Hemorrhage/Hematoma of Circ System
 ;;^UTILITY(U,$J,358.3,12852,1,4,0)
 ;;=4^I97.42
 ;;^UTILITY(U,$J,358.3,12852,2)
 ;;=^5008096
 ;;^UTILITY(U,$J,358.3,12853,0)
 ;;=K91.62^^80^789^28
 ;;^UTILITY(U,$J,358.3,12853,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12853,1,3,0)
 ;;=3^Intraoperative Hemorrhage/Hematoma of Digestive System
 ;;^UTILITY(U,$J,358.3,12853,1,4,0)
 ;;=4^K91.62
 ;;^UTILITY(U,$J,358.3,12853,2)
 ;;=^5008904
 ;;^UTILITY(U,$J,358.3,12854,0)
 ;;=H95.22^^80^789^30
 ;;^UTILITY(U,$J,358.3,12854,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12854,1,3,0)
 ;;=3^Intraoperative Hemorrhage/Hematoma of Ear/Mastoid
 ;;^UTILITY(U,$J,358.3,12854,1,4,0)
 ;;=4^H95.22
 ;;^UTILITY(U,$J,358.3,12854,2)
 ;;=^5007027
 ;;^UTILITY(U,$J,358.3,12855,0)
 ;;=E36.02^^80^789^31
 ;;^UTILITY(U,$J,358.3,12855,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12855,1,3,0)
 ;;=3^Intraoperative Hemorrhage/Hematoma of Endocrine System
 ;;^UTILITY(U,$J,358.3,12855,1,4,0)
 ;;=4^E36.02
 ;;^UTILITY(U,$J,358.3,12855,2)
 ;;=^5002780
 ;;^UTILITY(U,$J,358.3,12856,0)
 ;;=H59.121^^80^789^36
 ;;^UTILITY(U,$J,358.3,12856,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12856,1,3,0)
 ;;=3^Intraoperative Hemorrhage/Hematoma of Right Eye/Adnexa
 ;;^UTILITY(U,$J,358.3,12856,1,4,0)
 ;;=4^H59.121
 ;;^UTILITY(U,$J,358.3,12856,2)
 ;;=^5006405
 ;;^UTILITY(U,$J,358.3,12857,0)
 ;;=H59.122^^80^789^33
 ;;^UTILITY(U,$J,358.3,12857,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12857,1,3,0)
 ;;=3^Intraoperative Hemorrhage/Hematoma of Left Eye/Adnexa
 ;;^UTILITY(U,$J,358.3,12857,1,4,0)
 ;;=4^H59.122
 ;;^UTILITY(U,$J,358.3,12857,2)
 ;;=^5006406
 ;;^UTILITY(U,$J,358.3,12858,0)
 ;;=H59.123^^80^789^24
 ;;^UTILITY(U,$J,358.3,12858,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12858,1,3,0)
 ;;=3^Intraoperative Hemorrhage/Hematoma of Bilateral Eyes/Adnexa
 ;;^UTILITY(U,$J,358.3,12858,1,4,0)
 ;;=4^H59.123
 ;;^UTILITY(U,$J,358.3,12858,2)
 ;;=^5006407
