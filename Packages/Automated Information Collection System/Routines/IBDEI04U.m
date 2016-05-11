IBDEI04U ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,1839,1,4,0)
 ;;=4^I08.8
 ;;^UTILITY(U,$J,358.3,1839,2)
 ;;=^5007056
 ;;^UTILITY(U,$J,358.3,1840,0)
 ;;=T82.9XXA^^11^158^2
 ;;^UTILITY(U,$J,358.3,1840,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1840,1,3,0)
 ;;=3^Complication of Cardiac/Vascular Prosthetic Device/Implant/Graft,Init Encntr
 ;;^UTILITY(U,$J,358.3,1840,1,4,0)
 ;;=4^T82.9XXA
 ;;^UTILITY(U,$J,358.3,1840,2)
 ;;=^5054956
 ;;^UTILITY(U,$J,358.3,1841,0)
 ;;=T82.857A^^11^158^9
 ;;^UTILITY(U,$J,358.3,1841,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1841,1,3,0)
 ;;=3^Stenosis of Cardiac Prosthetic Device/Implant/Graft,Init Encntr
 ;;^UTILITY(U,$J,358.3,1841,1,4,0)
 ;;=4^T82.857A
 ;;^UTILITY(U,$J,358.3,1841,2)
 ;;=^5054938
 ;;^UTILITY(U,$J,358.3,1842,0)
 ;;=T82.867A^^11^158^10
 ;;^UTILITY(U,$J,358.3,1842,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1842,1,3,0)
 ;;=3^Thrombosis of Cardiac Prosthetic Device/Implant/Graft,Init Encntr
 ;;^UTILITY(U,$J,358.3,1842,1,4,0)
 ;;=4^T82.867A
 ;;^UTILITY(U,$J,358.3,1842,2)
 ;;=^5054944
 ;;^UTILITY(U,$J,358.3,1843,0)
 ;;=T82.897A^^11^158^3
 ;;^UTILITY(U,$J,358.3,1843,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1843,1,3,0)
 ;;=3^Complications of Cardiac Prosthetic Device/Implant/Graft,Init Encntr
 ;;^UTILITY(U,$J,358.3,1843,1,4,0)
 ;;=4^T82.897A
 ;;^UTILITY(U,$J,358.3,1843,2)
 ;;=^5054950
 ;;^UTILITY(U,$J,358.3,1844,0)
 ;;=T82.817A^^11^158^4
 ;;^UTILITY(U,$J,358.3,1844,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1844,1,3,0)
 ;;=3^Ebolism of Cardiac Prosthetic Device/Implant/Graft,Init Encntr
 ;;^UTILITY(U,$J,358.3,1844,1,4,0)
 ;;=4^T82.817A
 ;;^UTILITY(U,$J,358.3,1844,2)
 ;;=^5054914
 ;;^UTILITY(U,$J,358.3,1845,0)
 ;;=T82.827A^^11^158^5
 ;;^UTILITY(U,$J,358.3,1845,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1845,1,3,0)
 ;;=3^Fibrosis of Cardiac Prosthetic Device/Implant/Graft,Init Encntr
 ;;^UTILITY(U,$J,358.3,1845,1,4,0)
 ;;=4^T82.827A
 ;;^UTILITY(U,$J,358.3,1845,2)
 ;;=^5054920
 ;;^UTILITY(U,$J,358.3,1846,0)
 ;;=T82.837A^^11^158^6
 ;;^UTILITY(U,$J,358.3,1846,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1846,1,3,0)
 ;;=3^Hemorrhage of Cardiac Prosthetic Device/Implant/Graft,Init Encntr
 ;;^UTILITY(U,$J,358.3,1846,1,4,0)
 ;;=4^T82.837A
 ;;^UTILITY(U,$J,358.3,1846,2)
 ;;=^5054926
 ;;^UTILITY(U,$J,358.3,1847,0)
 ;;=T82.847A^^11^158^7
 ;;^UTILITY(U,$J,358.3,1847,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1847,1,3,0)
 ;;=3^Pain from Cardiac Prosthetic Device/Implant/Graft,Init Encntr
 ;;^UTILITY(U,$J,358.3,1847,1,4,0)
 ;;=4^T82.847A
 ;;^UTILITY(U,$J,358.3,1847,2)
 ;;=^5054932
 ;;^UTILITY(U,$J,358.3,1848,0)
 ;;=Z45.09^^11^158^1
 ;;^UTILITY(U,$J,358.3,1848,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1848,1,3,0)
 ;;=3^Adjustment/Management of Cardiac Device
 ;;^UTILITY(U,$J,358.3,1848,1,4,0)
 ;;=4^Z45.09
 ;;^UTILITY(U,$J,358.3,1848,2)
 ;;=^5062997
 ;;^UTILITY(U,$J,358.3,1849,0)
 ;;=Z01.810^^11^158^8
 ;;^UTILITY(U,$J,358.3,1849,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1849,1,3,0)
 ;;=3^Preporcedural Cardiovascular Examination
 ;;^UTILITY(U,$J,358.3,1849,1,4,0)
 ;;=4^Z01.810
 ;;^UTILITY(U,$J,358.3,1849,2)
 ;;=^5062625
 ;;^UTILITY(U,$J,358.3,1850,0)
 ;;=G90.01^^11^159^1
 ;;^UTILITY(U,$J,358.3,1850,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1850,1,3,0)
 ;;=3^Carotid Sinus Syncope
 ;;^UTILITY(U,$J,358.3,1850,1,4,0)
 ;;=4^G90.01
 ;;^UTILITY(U,$J,358.3,1850,2)
 ;;=^5004160
 ;;^UTILITY(U,$J,358.3,1851,0)
 ;;=R55.^^11^159^2
 ;;^UTILITY(U,$J,358.3,1851,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1851,1,3,0)
 ;;=3^Syncope and Collapse
 ;;^UTILITY(U,$J,358.3,1851,1,4,0)
 ;;=4^R55.
