IBDEI02C ; ; 12-MAY-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,1882,1,4,0)
 ;;=4^I47.1
 ;;^UTILITY(U,$J,358.3,1882,2)
 ;;=^5007223
 ;;^UTILITY(U,$J,358.3,1883,0)
 ;;=I49.3^^14^153^49
 ;;^UTILITY(U,$J,358.3,1883,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1883,1,3,0)
 ;;=3^Ventricular Premature Depolarization
 ;;^UTILITY(U,$J,358.3,1883,1,4,0)
 ;;=4^I49.3
 ;;^UTILITY(U,$J,358.3,1883,2)
 ;;=^5007233
 ;;^UTILITY(U,$J,358.3,1884,0)
 ;;=I47.0^^14^153^40
 ;;^UTILITY(U,$J,358.3,1884,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1884,1,3,0)
 ;;=3^Re-entry Ventricular Arrhythmia
 ;;^UTILITY(U,$J,358.3,1884,1,4,0)
 ;;=4^I47.0
 ;;^UTILITY(U,$J,358.3,1884,2)
 ;;=^5007222
 ;;^UTILITY(U,$J,358.3,1885,0)
 ;;=I47.2^^14^153^50
 ;;^UTILITY(U,$J,358.3,1885,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1885,1,3,0)
 ;;=3^Ventricular Tachycardia
 ;;^UTILITY(U,$J,358.3,1885,1,4,0)
 ;;=4^I47.2
 ;;^UTILITY(U,$J,358.3,1885,2)
 ;;=^125976
 ;;^UTILITY(U,$J,358.3,1886,0)
 ;;=I47.9^^14^153^34
 ;;^UTILITY(U,$J,358.3,1886,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1886,1,3,0)
 ;;=3^Paroxysmal Tachycardia,Unspec
 ;;^UTILITY(U,$J,358.3,1886,1,4,0)
 ;;=4^I47.9
 ;;^UTILITY(U,$J,358.3,1886,2)
 ;;=^5007224
 ;;^UTILITY(U,$J,358.3,1887,0)
 ;;=I48.0^^14^153^33
 ;;^UTILITY(U,$J,358.3,1887,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1887,1,3,0)
 ;;=3^Paroxysmal Atrial Fibrillation
 ;;^UTILITY(U,$J,358.3,1887,1,4,0)
 ;;=4^I48.0
 ;;^UTILITY(U,$J,358.3,1887,2)
 ;;=^90473
 ;;^UTILITY(U,$J,358.3,1888,0)
 ;;=I48.1^^14^153^7
 ;;^UTILITY(U,$J,358.3,1888,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1888,1,3,0)
 ;;=3^Atrial Fibrillation,Persistent
 ;;^UTILITY(U,$J,358.3,1888,1,4,0)
 ;;=4^I48.1
 ;;^UTILITY(U,$J,358.3,1888,2)
 ;;=^5007225
 ;;^UTILITY(U,$J,358.3,1889,0)
 ;;=I49.01^^14^153^47
 ;;^UTILITY(U,$J,358.3,1889,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1889,1,3,0)
 ;;=3^Ventricular Fibrillation
 ;;^UTILITY(U,$J,358.3,1889,1,4,0)
 ;;=4^I49.01
 ;;^UTILITY(U,$J,358.3,1889,2)
 ;;=^125951
 ;;^UTILITY(U,$J,358.3,1890,0)
 ;;=I49.02^^14^153^48
 ;;^UTILITY(U,$J,358.3,1890,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1890,1,3,0)
 ;;=3^Ventricular Flutter
 ;;^UTILITY(U,$J,358.3,1890,1,4,0)
 ;;=4^I49.02
 ;;^UTILITY(U,$J,358.3,1890,2)
 ;;=^265315
 ;;^UTILITY(U,$J,358.3,1891,0)
 ;;=I46.9^^14^153^17
 ;;^UTILITY(U,$J,358.3,1891,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1891,1,3,0)
 ;;=3^Cardiac Arrest,Cause Unspec
 ;;^UTILITY(U,$J,358.3,1891,1,4,0)
 ;;=4^I46.9
 ;;^UTILITY(U,$J,358.3,1891,2)
 ;;=^5007221
 ;;^UTILITY(U,$J,358.3,1892,0)
 ;;=I46.8^^14^153^16
 ;;^UTILITY(U,$J,358.3,1892,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1892,1,3,0)
 ;;=3^Cardiac Arrest d/t Underlying Condition
 ;;^UTILITY(U,$J,358.3,1892,1,4,0)
 ;;=4^I46.8
 ;;^UTILITY(U,$J,358.3,1892,2)
 ;;=^5007220
 ;;^UTILITY(U,$J,358.3,1893,0)
 ;;=I46.2^^14^153^15
 ;;^UTILITY(U,$J,358.3,1893,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1893,1,3,0)
 ;;=3^Cardiac Arrest d/t Underlying Cardiac Condition
 ;;^UTILITY(U,$J,358.3,1893,1,4,0)
 ;;=4^I46.2
 ;;^UTILITY(U,$J,358.3,1893,2)
 ;;=^5007219
 ;;^UTILITY(U,$J,358.3,1894,0)
 ;;=I49.40^^14^153^37
 ;;^UTILITY(U,$J,358.3,1894,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1894,1,3,0)
 ;;=3^Premature Depolarization,Unspec
 ;;^UTILITY(U,$J,358.3,1894,1,4,0)
 ;;=4^I49.40
 ;;^UTILITY(U,$J,358.3,1894,2)
 ;;=^5007234
 ;;^UTILITY(U,$J,358.3,1895,0)
 ;;=I49.1^^14^153^10
 ;;^UTILITY(U,$J,358.3,1895,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1895,1,3,0)
 ;;=3^Atrial Premature Depolarization
 ;;^UTILITY(U,$J,358.3,1895,1,4,0)
 ;;=4^I49.1
 ;;^UTILITY(U,$J,358.3,1895,2)
 ;;=^5007231
 ;;^UTILITY(U,$J,358.3,1896,0)
 ;;=I49.49^^14^153^36
 ;;^UTILITY(U,$J,358.3,1896,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1896,1,3,0)
 ;;=3^Premature Depolarization NEC
 ;;^UTILITY(U,$J,358.3,1896,1,4,0)
 ;;=4^I49.49
 ;;^UTILITY(U,$J,358.3,1896,2)
 ;;=^5007235
 ;;^UTILITY(U,$J,358.3,1897,0)
 ;;=I49.5^^14^153^44
 ;;^UTILITY(U,$J,358.3,1897,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1897,1,3,0)
 ;;=3^Sick Sinus Syndrome
 ;;^UTILITY(U,$J,358.3,1897,1,4,0)
 ;;=4^I49.5
 ;;^UTILITY(U,$J,358.3,1897,2)
 ;;=^110404
 ;;^UTILITY(U,$J,358.3,1898,0)
 ;;=R00.1^^14^153^12
 ;;^UTILITY(U,$J,358.3,1898,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1898,1,3,0)
 ;;=3^Bradycardia,Unspec
 ;;^UTILITY(U,$J,358.3,1898,1,4,0)
 ;;=4^R00.1
 ;;^UTILITY(U,$J,358.3,1898,2)
 ;;=^5019164
 ;;^UTILITY(U,$J,358.3,1899,0)
 ;;=T82.110A^^14^153^13
 ;;^UTILITY(U,$J,358.3,1899,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1899,1,3,0)
 ;;=3^Breakdown of Cardiac Electrode,Init Encntr
 ;;^UTILITY(U,$J,358.3,1899,1,4,0)
 ;;=4^T82.110A
 ;;^UTILITY(U,$J,358.3,1899,2)
 ;;=^5054680
 ;;^UTILITY(U,$J,358.3,1900,0)
 ;;=T82.111A^^14^153^14
 ;;^UTILITY(U,$J,358.3,1900,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1900,1,3,0)
 ;;=3^Breakdown of Cardiac Pulse Generator,Init Encntr
 ;;^UTILITY(U,$J,358.3,1900,1,4,0)
 ;;=4^T82.111A
 ;;^UTILITY(U,$J,358.3,1900,2)
 ;;=^5054683
 ;;^UTILITY(U,$J,358.3,1901,0)
 ;;=T82.120A^^14^153^22
 ;;^UTILITY(U,$J,358.3,1901,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1901,1,3,0)
 ;;=3^Displacement of Cardiac Electrode,Init Encntr
 ;;^UTILITY(U,$J,358.3,1901,1,4,0)
 ;;=4^T82.120A
 ;;^UTILITY(U,$J,358.3,1901,2)
 ;;=^5054692
 ;;^UTILITY(U,$J,358.3,1902,0)
 ;;=T82.121A^^14^153^23
 ;;^UTILITY(U,$J,358.3,1902,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1902,1,3,0)
 ;;=3^Displacement of Cardiac Pulse Generator,Init Encntr
 ;;^UTILITY(U,$J,358.3,1902,1,4,0)
 ;;=4^T82.121A
 ;;^UTILITY(U,$J,358.3,1902,2)
 ;;=^5054695
 ;;^UTILITY(U,$J,358.3,1903,0)
 ;;=T82.190A^^14^153^31
 ;;^UTILITY(U,$J,358.3,1903,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1903,1,3,0)
 ;;=3^Mech Compl of Cardiac Electrode,Init Encntr
 ;;^UTILITY(U,$J,358.3,1903,1,4,0)
 ;;=4^T82.190A
 ;;^UTILITY(U,$J,358.3,1903,2)
 ;;=^5054704
 ;;^UTILITY(U,$J,358.3,1904,0)
 ;;=T82.191A^^14^153^32
 ;;^UTILITY(U,$J,358.3,1904,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1904,1,3,0)
 ;;=3^Mech Compl of Cardiac Pulse Generator,Init Encntr
 ;;^UTILITY(U,$J,358.3,1904,1,4,0)
 ;;=4^T82.191A
 ;;^UTILITY(U,$J,358.3,1904,2)
 ;;=^5054707
 ;;^UTILITY(U,$J,358.3,1905,0)
 ;;=Z95.0^^14^153^39
 ;;^UTILITY(U,$J,358.3,1905,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1905,1,3,0)
 ;;=3^Presence of Cardiac Pacemaker
 ;;^UTILITY(U,$J,358.3,1905,1,4,0)
 ;;=4^Z95.0
 ;;^UTILITY(U,$J,358.3,1905,2)
 ;;=^5063668
 ;;^UTILITY(U,$J,358.3,1906,0)
 ;;=Z95.810^^14^153^38
 ;;^UTILITY(U,$J,358.3,1906,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1906,1,3,0)
 ;;=3^Presence of Automatic Cardiac Defibrillator
 ;;^UTILITY(U,$J,358.3,1906,1,4,0)
 ;;=4^Z95.810
 ;;^UTILITY(U,$J,358.3,1906,2)
 ;;=^5063674
 ;;^UTILITY(U,$J,358.3,1907,0)
 ;;=Z45.010^^14^153^20
 ;;^UTILITY(U,$J,358.3,1907,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1907,1,3,0)
 ;;=3^Check/Test Cardiac Pacemaker Pulse Generator
 ;;^UTILITY(U,$J,358.3,1907,1,4,0)
 ;;=4^Z45.010
 ;;^UTILITY(U,$J,358.3,1907,2)
 ;;=^5062994
 ;;^UTILITY(U,$J,358.3,1908,0)
 ;;=Z45.018^^14^153^6
 ;;^UTILITY(U,$J,358.3,1908,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1908,1,3,0)
 ;;=3^Adjust/Manage Cardiac Pacemaker Parts
 ;;^UTILITY(U,$J,358.3,1908,1,4,0)
 ;;=4^Z45.018
 ;;^UTILITY(U,$J,358.3,1908,2)
 ;;=^5062995
 ;;^UTILITY(U,$J,358.3,1909,0)
 ;;=Z45.02^^14^153^5
 ;;^UTILITY(U,$J,358.3,1909,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1909,1,3,0)
 ;;=3^Adjust/Manage Automatic Implantable Cardiac Defibrillator
 ;;^UTILITY(U,$J,358.3,1909,1,4,0)
 ;;=4^Z45.02
 ;;^UTILITY(U,$J,358.3,1909,2)
 ;;=^5062996
 ;;^UTILITY(U,$J,358.3,1910,0)
 ;;=I48.3^^14^153^9
 ;;^UTILITY(U,$J,358.3,1910,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1910,1,3,0)
 ;;=3^Atrial Flutter,Typical
 ;;^UTILITY(U,$J,358.3,1910,1,4,0)
 ;;=4^I48.3
 ;;^UTILITY(U,$J,358.3,1910,2)
 ;;=^5007227
 ;;^UTILITY(U,$J,358.3,1911,0)
 ;;=I48.4^^14^153^8
