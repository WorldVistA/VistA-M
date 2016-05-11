IBDEI04J ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,1698,0)
 ;;=I30.0^^11^150^1
 ;;^UTILITY(U,$J,358.3,1698,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1698,1,3,0)
 ;;=3^Acute Nonspecific Idiopathic Pericarditis
 ;;^UTILITY(U,$J,358.3,1698,1,4,0)
 ;;=4^I30.0
 ;;^UTILITY(U,$J,358.3,1698,2)
 ;;=^5007157
 ;;^UTILITY(U,$J,358.3,1699,0)
 ;;=I33.0^^11^150^3
 ;;^UTILITY(U,$J,358.3,1699,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1699,1,3,0)
 ;;=3^Acute/Subacute Infective Endocarditis
 ;;^UTILITY(U,$J,358.3,1699,1,4,0)
 ;;=4^I33.0
 ;;^UTILITY(U,$J,358.3,1699,2)
 ;;=^5007167
 ;;^UTILITY(U,$J,358.3,1700,0)
 ;;=I33.9^^11^150^2
 ;;^UTILITY(U,$J,358.3,1700,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1700,1,3,0)
 ;;=3^Acute/Subacute Endocarditis,Unspec
 ;;^UTILITY(U,$J,358.3,1700,1,4,0)
 ;;=4^I33.9
 ;;^UTILITY(U,$J,358.3,1700,2)
 ;;=^5007168
 ;;^UTILITY(U,$J,358.3,1701,0)
 ;;=I31.0^^11^150^4
 ;;^UTILITY(U,$J,358.3,1701,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1701,1,3,0)
 ;;=3^Adhesive Pericarditis,Chronic
 ;;^UTILITY(U,$J,358.3,1701,1,4,0)
 ;;=4^I31.0
 ;;^UTILITY(U,$J,358.3,1701,2)
 ;;=^5007161
 ;;^UTILITY(U,$J,358.3,1702,0)
 ;;=I31.1^^11^150^6
 ;;^UTILITY(U,$J,358.3,1702,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1702,1,3,0)
 ;;=3^Constrictive Pericarditis,Chronic
 ;;^UTILITY(U,$J,358.3,1702,1,4,0)
 ;;=4^I31.1
 ;;^UTILITY(U,$J,358.3,1702,2)
 ;;=^5007162
 ;;^UTILITY(U,$J,358.3,1703,0)
 ;;=E78.0^^11^151^5
 ;;^UTILITY(U,$J,358.3,1703,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1703,1,3,0)
 ;;=3^Pure Hypercholesterolemia
 ;;^UTILITY(U,$J,358.3,1703,1,4,0)
 ;;=4^E78.0
 ;;^UTILITY(U,$J,358.3,1703,2)
 ;;=^5002966
 ;;^UTILITY(U,$J,358.3,1704,0)
 ;;=E78.1^^11^151^6
 ;;^UTILITY(U,$J,358.3,1704,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1704,1,3,0)
 ;;=3^Pure Hyperglyceridemia
 ;;^UTILITY(U,$J,358.3,1704,1,4,0)
 ;;=4^E78.1
 ;;^UTILITY(U,$J,358.3,1704,2)
 ;;=^101303
 ;;^UTILITY(U,$J,358.3,1705,0)
 ;;=E78.2^^11^151^4
 ;;^UTILITY(U,$J,358.3,1705,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1705,1,3,0)
 ;;=3^Mixed Hyperlipidemia
 ;;^UTILITY(U,$J,358.3,1705,1,4,0)
 ;;=4^E78.2
 ;;^UTILITY(U,$J,358.3,1705,2)
 ;;=^78424
 ;;^UTILITY(U,$J,358.3,1706,0)
 ;;=E78.4^^11^151^1
 ;;^UTILITY(U,$J,358.3,1706,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1706,1,3,0)
 ;;=3^Hyperlipidemia NEC
 ;;^UTILITY(U,$J,358.3,1706,1,4,0)
 ;;=4^E78.4
 ;;^UTILITY(U,$J,358.3,1706,2)
 ;;=^5002968
 ;;^UTILITY(U,$J,358.3,1707,0)
 ;;=E78.5^^11^151^2
 ;;^UTILITY(U,$J,358.3,1707,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1707,1,3,0)
 ;;=3^Hyperlipidemia,Unspec
 ;;^UTILITY(U,$J,358.3,1707,1,4,0)
 ;;=4^E78.5
 ;;^UTILITY(U,$J,358.3,1707,2)
 ;;=^5002969
 ;;^UTILITY(U,$J,358.3,1708,0)
 ;;=E78.6^^11^151^3
 ;;^UTILITY(U,$J,358.3,1708,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1708,1,3,0)
 ;;=3^Lipoprotein Deficiency
 ;;^UTILITY(U,$J,358.3,1708,1,4,0)
 ;;=4^E78.6
 ;;^UTILITY(U,$J,358.3,1708,2)
 ;;=^5002970
 ;;^UTILITY(U,$J,358.3,1709,0)
 ;;=I22.0^^11^152^7
 ;;^UTILITY(U,$J,358.3,1709,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1709,1,3,0)
 ;;=3^Subsequent STEMI of Anterior Wall
 ;;^UTILITY(U,$J,358.3,1709,1,4,0)
 ;;=4^I22.0
 ;;^UTILITY(U,$J,358.3,1709,2)
 ;;=^5007089
 ;;^UTILITY(U,$J,358.3,1710,0)
 ;;=I21.09^^11^152^2
 ;;^UTILITY(U,$J,358.3,1710,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1710,1,3,0)
 ;;=3^STEMI Involving Coronary Artery of Anterior Wall
 ;;^UTILITY(U,$J,358.3,1710,1,4,0)
 ;;=4^I21.09
 ;;^UTILITY(U,$J,358.3,1710,2)
 ;;=^5007082
 ;;^UTILITY(U,$J,358.3,1711,0)
 ;;=I21.02^^11^152^4
 ;;^UTILITY(U,$J,358.3,1711,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1711,1,3,0)
 ;;=3^STEMI Involving Left Anterior Descending Coronary Artery
