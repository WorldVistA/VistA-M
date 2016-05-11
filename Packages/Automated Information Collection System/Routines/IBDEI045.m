IBDEI045 ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,1515,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1515,1,3,0)
 ;;=3^Long QT Syndrome
 ;;^UTILITY(U,$J,358.3,1515,1,4,0)
 ;;=4^I45.81
 ;;^UTILITY(U,$J,358.3,1515,2)
 ;;=^71760
 ;;^UTILITY(U,$J,358.3,1516,0)
 ;;=I45.9^^11^143^16
 ;;^UTILITY(U,$J,358.3,1516,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1516,1,3,0)
 ;;=3^Conduction Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,1516,1,4,0)
 ;;=4^I45.9
 ;;^UTILITY(U,$J,358.3,1516,2)
 ;;=^5007218
 ;;^UTILITY(U,$J,358.3,1517,0)
 ;;=I47.1^^11^143^41
 ;;^UTILITY(U,$J,358.3,1517,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1517,1,3,0)
 ;;=3^Supraventricular Tachycardia
 ;;^UTILITY(U,$J,358.3,1517,1,4,0)
 ;;=4^I47.1
 ;;^UTILITY(U,$J,358.3,1517,2)
 ;;=^5007223
 ;;^UTILITY(U,$J,358.3,1518,0)
 ;;=I49.3^^11^143^45
 ;;^UTILITY(U,$J,358.3,1518,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1518,1,3,0)
 ;;=3^Ventricular Premature Depolarization
 ;;^UTILITY(U,$J,358.3,1518,1,4,0)
 ;;=4^I49.3
 ;;^UTILITY(U,$J,358.3,1518,2)
 ;;=^5007233
 ;;^UTILITY(U,$J,358.3,1519,0)
 ;;=I47.0^^11^143^36
 ;;^UTILITY(U,$J,358.3,1519,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1519,1,3,0)
 ;;=3^Re-entry Ventricular Arrhythmia
 ;;^UTILITY(U,$J,358.3,1519,1,4,0)
 ;;=4^I47.0
 ;;^UTILITY(U,$J,358.3,1519,2)
 ;;=^5007222
 ;;^UTILITY(U,$J,358.3,1520,0)
 ;;=I47.2^^11^143^46
 ;;^UTILITY(U,$J,358.3,1520,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1520,1,3,0)
 ;;=3^Ventricular Tachycardia
 ;;^UTILITY(U,$J,358.3,1520,1,4,0)
 ;;=4^I47.2
 ;;^UTILITY(U,$J,358.3,1520,2)
 ;;=^125976
 ;;^UTILITY(U,$J,358.3,1521,0)
 ;;=I47.9^^11^143^29
 ;;^UTILITY(U,$J,358.3,1521,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1521,1,3,0)
 ;;=3^Paroxysmal Tachycardia,Unspec
 ;;^UTILITY(U,$J,358.3,1521,1,4,0)
 ;;=4^I47.9
 ;;^UTILITY(U,$J,358.3,1521,2)
 ;;=^5007224
 ;;^UTILITY(U,$J,358.3,1522,0)
 ;;=I48.0^^11^143^28
 ;;^UTILITY(U,$J,358.3,1522,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1522,1,3,0)
 ;;=3^Paroxysmal Atrial Fibrillation
 ;;^UTILITY(U,$J,358.3,1522,1,4,0)
 ;;=4^I48.0
 ;;^UTILITY(U,$J,358.3,1522,2)
 ;;=^90473
 ;;^UTILITY(U,$J,358.3,1523,0)
 ;;=I48.1^^11^143^30
 ;;^UTILITY(U,$J,358.3,1523,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1523,1,3,0)
 ;;=3^Persistent Atrial Fibrillation
 ;;^UTILITY(U,$J,358.3,1523,1,4,0)
 ;;=4^I48.1
 ;;^UTILITY(U,$J,358.3,1523,2)
 ;;=^5007225
 ;;^UTILITY(U,$J,358.3,1524,0)
 ;;=I49.01^^11^143^43
 ;;^UTILITY(U,$J,358.3,1524,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1524,1,3,0)
 ;;=3^Ventricular Fibrillation
 ;;^UTILITY(U,$J,358.3,1524,1,4,0)
 ;;=4^I49.01
 ;;^UTILITY(U,$J,358.3,1524,2)
 ;;=^125951
 ;;^UTILITY(U,$J,358.3,1525,0)
 ;;=I49.02^^11^143^44
 ;;^UTILITY(U,$J,358.3,1525,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1525,1,3,0)
 ;;=3^Ventricular Flutter
 ;;^UTILITY(U,$J,358.3,1525,1,4,0)
 ;;=4^I49.02
 ;;^UTILITY(U,$J,358.3,1525,2)
 ;;=^265315
 ;;^UTILITY(U,$J,358.3,1526,0)
 ;;=I46.9^^11^143^14
 ;;^UTILITY(U,$J,358.3,1526,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1526,1,3,0)
 ;;=3^Cardiac Arrest,Cause Unspec
 ;;^UTILITY(U,$J,358.3,1526,1,4,0)
 ;;=4^I46.9
 ;;^UTILITY(U,$J,358.3,1526,2)
 ;;=^5007221
 ;;^UTILITY(U,$J,358.3,1527,0)
 ;;=I46.8^^11^143^13
 ;;^UTILITY(U,$J,358.3,1527,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1527,1,3,0)
 ;;=3^Cardiac Arrest d/t Underlying Condition
 ;;^UTILITY(U,$J,358.3,1527,1,4,0)
 ;;=4^I46.8
 ;;^UTILITY(U,$J,358.3,1527,2)
 ;;=^5007220
 ;;^UTILITY(U,$J,358.3,1528,0)
 ;;=I46.2^^11^143^12
 ;;^UTILITY(U,$J,358.3,1528,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1528,1,3,0)
 ;;=3^Cardiac Arrest d/t Underlying Cardiac Condition
 ;;^UTILITY(U,$J,358.3,1528,1,4,0)
 ;;=4^I46.2
