IBDEI04T ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,1826,1,4,0)
 ;;=4^T82.818A
 ;;^UTILITY(U,$J,358.3,1826,2)
 ;;=^5054917
 ;;^UTILITY(U,$J,358.3,1827,0)
 ;;=T82.828A^^11^156^74
 ;;^UTILITY(U,$J,358.3,1827,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1827,1,3,0)
 ;;=3^Fibrosis of Vascular Prosthetic Device/Implant/Graft,Init Encntr
 ;;^UTILITY(U,$J,358.3,1827,1,4,0)
 ;;=4^T82.828A
 ;;^UTILITY(U,$J,358.3,1827,2)
 ;;=^5054923
 ;;^UTILITY(U,$J,358.3,1828,0)
 ;;=T82.868A^^11^156^93
 ;;^UTILITY(U,$J,358.3,1828,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1828,1,3,0)
 ;;=3^Thrombosis of Vascular Prosthetic Device/Implant/Graft,Init Encntr
 ;;^UTILITY(U,$J,358.3,1828,1,4,0)
 ;;=4^T82.868A
 ;;^UTILITY(U,$J,358.3,1828,2)
 ;;=^5054947
 ;;^UTILITY(U,$J,358.3,1829,0)
 ;;=I08.0^^11^157^5
 ;;^UTILITY(U,$J,358.3,1829,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1829,1,3,0)
 ;;=3^Rheumatic Disorders of Mitral and Aortic Valves
 ;;^UTILITY(U,$J,358.3,1829,1,4,0)
 ;;=4^I08.0
 ;;^UTILITY(U,$J,358.3,1829,2)
 ;;=^5007052
 ;;^UTILITY(U,$J,358.3,1830,0)
 ;;=I05.0^^11^157^8
 ;;^UTILITY(U,$J,358.3,1830,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1830,1,3,0)
 ;;=3^Rheumatic Mitral Stenosis
 ;;^UTILITY(U,$J,358.3,1830,1,4,0)
 ;;=4^I05.0
 ;;^UTILITY(U,$J,358.3,1830,2)
 ;;=^5007041
 ;;^UTILITY(U,$J,358.3,1831,0)
 ;;=I05.1^^11^157^7
 ;;^UTILITY(U,$J,358.3,1831,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1831,1,3,0)
 ;;=3^Rheumatic Mitral Insufficiency
 ;;^UTILITY(U,$J,358.3,1831,1,4,0)
 ;;=4^I05.1
 ;;^UTILITY(U,$J,358.3,1831,2)
 ;;=^269568
 ;;^UTILITY(U,$J,358.3,1832,0)
 ;;=I05.2^^11^157^9
 ;;^UTILITY(U,$J,358.3,1832,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1832,1,3,0)
 ;;=3^Rheumatic Mitral Stenosis w/ Insufficiency
 ;;^UTILITY(U,$J,358.3,1832,1,4,0)
 ;;=4^I05.2
 ;;^UTILITY(U,$J,358.3,1832,2)
 ;;=^5007042
 ;;^UTILITY(U,$J,358.3,1833,0)
 ;;=I05.8^^11^157^10
 ;;^UTILITY(U,$J,358.3,1833,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1833,1,3,0)
 ;;=3^Rheumatic Mitral Valve Diseases NEC
 ;;^UTILITY(U,$J,358.3,1833,1,4,0)
 ;;=4^I05.8
 ;;^UTILITY(U,$J,358.3,1833,2)
 ;;=^5007043
 ;;^UTILITY(U,$J,358.3,1834,0)
 ;;=I06.0^^11^157^2
 ;;^UTILITY(U,$J,358.3,1834,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1834,1,3,0)
 ;;=3^Rheumatic Aortic Stenosis
 ;;^UTILITY(U,$J,358.3,1834,1,4,0)
 ;;=4^I06.0
 ;;^UTILITY(U,$J,358.3,1834,2)
 ;;=^269573
 ;;^UTILITY(U,$J,358.3,1835,0)
 ;;=I06.1^^11^157^1
 ;;^UTILITY(U,$J,358.3,1835,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1835,1,3,0)
 ;;=3^Rheumatic Aortic Insufficiency
 ;;^UTILITY(U,$J,358.3,1835,1,4,0)
 ;;=4^I06.1
 ;;^UTILITY(U,$J,358.3,1835,2)
 ;;=^269575
 ;;^UTILITY(U,$J,358.3,1836,0)
 ;;=I06.2^^11^157^3
 ;;^UTILITY(U,$J,358.3,1836,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1836,1,3,0)
 ;;=3^Rheumatic Aortic Stenosis w/ Insufficiency
 ;;^UTILITY(U,$J,358.3,1836,1,4,0)
 ;;=4^I06.2
 ;;^UTILITY(U,$J,358.3,1836,2)
 ;;=^269577
 ;;^UTILITY(U,$J,358.3,1837,0)
 ;;=I06.8^^11^157^4
 ;;^UTILITY(U,$J,358.3,1837,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1837,1,3,0)
 ;;=3^Rheumatic Aortic Valve Diseases NEC
 ;;^UTILITY(U,$J,358.3,1837,1,4,0)
 ;;=4^I06.8
 ;;^UTILITY(U,$J,358.3,1837,2)
 ;;=^5007045
 ;;^UTILITY(U,$J,358.3,1838,0)
 ;;=I09.89^^11^157^6
 ;;^UTILITY(U,$J,358.3,1838,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1838,1,3,0)
 ;;=3^Rheumatic Heart Diseases
 ;;^UTILITY(U,$J,358.3,1838,1,4,0)
 ;;=4^I09.89
 ;;^UTILITY(U,$J,358.3,1838,2)
 ;;=^5007060
 ;;^UTILITY(U,$J,358.3,1839,0)
 ;;=I08.8^^11^157^11
 ;;^UTILITY(U,$J,358.3,1839,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1839,1,3,0)
 ;;=3^Rheumatic Multiple Valve Dieases NEC
