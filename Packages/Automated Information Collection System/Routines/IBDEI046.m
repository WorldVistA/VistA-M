IBDEI046 ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,1528,2)
 ;;=^5007219
 ;;^UTILITY(U,$J,358.3,1529,0)
 ;;=I49.40^^11^143^33
 ;;^UTILITY(U,$J,358.3,1529,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1529,1,3,0)
 ;;=3^Premature Depolarization,Unspec
 ;;^UTILITY(U,$J,358.3,1529,1,4,0)
 ;;=4^I49.40
 ;;^UTILITY(U,$J,358.3,1529,2)
 ;;=^5007234
 ;;^UTILITY(U,$J,358.3,1530,0)
 ;;=I49.1^^11^143^7
 ;;^UTILITY(U,$J,358.3,1530,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1530,1,3,0)
 ;;=3^Atrial Premature Depolarization
 ;;^UTILITY(U,$J,358.3,1530,1,4,0)
 ;;=4^I49.1
 ;;^UTILITY(U,$J,358.3,1530,2)
 ;;=^5007231
 ;;^UTILITY(U,$J,358.3,1531,0)
 ;;=I49.49^^11^143^32
 ;;^UTILITY(U,$J,358.3,1531,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1531,1,3,0)
 ;;=3^Premature Depolarization NEC
 ;;^UTILITY(U,$J,358.3,1531,1,4,0)
 ;;=4^I49.49
 ;;^UTILITY(U,$J,358.3,1531,2)
 ;;=^5007235
 ;;^UTILITY(U,$J,358.3,1532,0)
 ;;=I49.5^^11^143^40
 ;;^UTILITY(U,$J,358.3,1532,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1532,1,3,0)
 ;;=3^Sick Sinus Syndrome
 ;;^UTILITY(U,$J,358.3,1532,1,4,0)
 ;;=4^I49.5
 ;;^UTILITY(U,$J,358.3,1532,2)
 ;;=^110404
 ;;^UTILITY(U,$J,358.3,1533,0)
 ;;=R00.1^^11^143^9
 ;;^UTILITY(U,$J,358.3,1533,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1533,1,3,0)
 ;;=3^Bradycardia,Unspec
 ;;^UTILITY(U,$J,358.3,1533,1,4,0)
 ;;=4^R00.1
 ;;^UTILITY(U,$J,358.3,1533,2)
 ;;=^5019164
 ;;^UTILITY(U,$J,358.3,1534,0)
 ;;=T82.110A^^11^143^10
 ;;^UTILITY(U,$J,358.3,1534,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1534,1,3,0)
 ;;=3^Breakdown of Cardiac Electrode,Init Encntr
 ;;^UTILITY(U,$J,358.3,1534,1,4,0)
 ;;=4^T82.110A
 ;;^UTILITY(U,$J,358.3,1534,2)
 ;;=^5054680
 ;;^UTILITY(U,$J,358.3,1535,0)
 ;;=T82.111A^^11^143^11
 ;;^UTILITY(U,$J,358.3,1535,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1535,1,3,0)
 ;;=3^Breakdown of Cardiac Pulse Generator,Init Encntr
 ;;^UTILITY(U,$J,358.3,1535,1,4,0)
 ;;=4^T82.111A
 ;;^UTILITY(U,$J,358.3,1535,2)
 ;;=^5054683
 ;;^UTILITY(U,$J,358.3,1536,0)
 ;;=T82.120A^^11^143^17
 ;;^UTILITY(U,$J,358.3,1536,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1536,1,3,0)
 ;;=3^Displacement of Cardiac Electrode,Init Encntr
 ;;^UTILITY(U,$J,358.3,1536,1,4,0)
 ;;=4^T82.120A
 ;;^UTILITY(U,$J,358.3,1536,2)
 ;;=^5054692
 ;;^UTILITY(U,$J,358.3,1537,0)
 ;;=T82.121A^^11^143^18
 ;;^UTILITY(U,$J,358.3,1537,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1537,1,3,0)
 ;;=3^Displacement of Cardiac Pulse Generator,Init Encntr
 ;;^UTILITY(U,$J,358.3,1537,1,4,0)
 ;;=4^T82.121A
 ;;^UTILITY(U,$J,358.3,1537,2)
 ;;=^5054695
 ;;^UTILITY(U,$J,358.3,1538,0)
 ;;=T82.190A^^11^143^26
 ;;^UTILITY(U,$J,358.3,1538,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1538,1,3,0)
 ;;=3^Mech Compl of Cardiac Electrode,Init Encntr
 ;;^UTILITY(U,$J,358.3,1538,1,4,0)
 ;;=4^T82.190A
 ;;^UTILITY(U,$J,358.3,1538,2)
 ;;=^5054704
 ;;^UTILITY(U,$J,358.3,1539,0)
 ;;=T82.191A^^11^143^27
 ;;^UTILITY(U,$J,358.3,1539,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1539,1,3,0)
 ;;=3^Mech Compl of Cardiac Pulse Generator,Init Encntr
 ;;^UTILITY(U,$J,358.3,1539,1,4,0)
 ;;=4^T82.191A
 ;;^UTILITY(U,$J,358.3,1539,2)
 ;;=^5054707
 ;;^UTILITY(U,$J,358.3,1540,0)
 ;;=Z95.0^^11^143^35
 ;;^UTILITY(U,$J,358.3,1540,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1540,1,3,0)
 ;;=3^Presence of Cardiac Pacemaker
 ;;^UTILITY(U,$J,358.3,1540,1,4,0)
 ;;=4^Z95.0
 ;;^UTILITY(U,$J,358.3,1540,2)
 ;;=^5063668
 ;;^UTILITY(U,$J,358.3,1541,0)
 ;;=Z95.810^^11^143^34
 ;;^UTILITY(U,$J,358.3,1541,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1541,1,3,0)
 ;;=3^Presence of Automatic Cardiac Defibrillator
 ;;^UTILITY(U,$J,358.3,1541,1,4,0)
 ;;=4^Z95.810
