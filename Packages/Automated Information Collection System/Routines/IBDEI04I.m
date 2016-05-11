IBDEI04I ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,1684,1,3,0)
 ;;=3^Long Term Current Use of Anticoagulants
 ;;^UTILITY(U,$J,358.3,1684,1,4,0)
 ;;=4^Z79.01
 ;;^UTILITY(U,$J,358.3,1684,2)
 ;;=^5063330
 ;;^UTILITY(U,$J,358.3,1685,0)
 ;;=I10.^^11^149^3
 ;;^UTILITY(U,$J,358.3,1685,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1685,1,3,0)
 ;;=3^Hypertension,Essential
 ;;^UTILITY(U,$J,358.3,1685,1,4,0)
 ;;=4^I10.
 ;;^UTILITY(U,$J,358.3,1685,2)
 ;;=^5007062
 ;;^UTILITY(U,$J,358.3,1686,0)
 ;;=I11.0^^11^149^6
 ;;^UTILITY(U,$J,358.3,1686,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1686,1,3,0)
 ;;=3^Hypertensive Heart Disease w/ Heart Failure
 ;;^UTILITY(U,$J,358.3,1686,1,4,0)
 ;;=4^I11.0
 ;;^UTILITY(U,$J,358.3,1686,2)
 ;;=^5007063
 ;;^UTILITY(U,$J,358.3,1687,0)
 ;;=I11.9^^11^149^7
 ;;^UTILITY(U,$J,358.3,1687,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1687,1,3,0)
 ;;=3^Hypertensive Heart Disease w/o Heart Failure
 ;;^UTILITY(U,$J,358.3,1687,1,4,0)
 ;;=4^I11.9
 ;;^UTILITY(U,$J,358.3,1687,2)
 ;;=^5007064
 ;;^UTILITY(U,$J,358.3,1688,0)
 ;;=I15.8^^11^149^5
 ;;^UTILITY(U,$J,358.3,1688,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1688,1,3,0)
 ;;=3^Hypertension,Secondary
 ;;^UTILITY(U,$J,358.3,1688,1,4,0)
 ;;=4^I15.8
 ;;^UTILITY(U,$J,358.3,1688,2)
 ;;=^5007074
 ;;^UTILITY(U,$J,358.3,1689,0)
 ;;=I15.0^^11^149^4
 ;;^UTILITY(U,$J,358.3,1689,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1689,1,3,0)
 ;;=3^Hypertension,Renovascular
 ;;^UTILITY(U,$J,358.3,1689,1,4,0)
 ;;=4^I15.0
 ;;^UTILITY(U,$J,358.3,1689,2)
 ;;=^5007071
 ;;^UTILITY(U,$J,358.3,1690,0)
 ;;=I70.1^^11^149^1
 ;;^UTILITY(U,$J,358.3,1690,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1690,1,3,0)
 ;;=3^Atherosclerosis of Renal Artery
 ;;^UTILITY(U,$J,358.3,1690,1,4,0)
 ;;=4^I70.1
 ;;^UTILITY(U,$J,358.3,1690,2)
 ;;=^269760
 ;;^UTILITY(U,$J,358.3,1691,0)
 ;;=R03.0^^11^149^2
 ;;^UTILITY(U,$J,358.3,1691,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1691,1,3,0)
 ;;=3^Elevated B/P Reading w/o HTN Diagnosis
 ;;^UTILITY(U,$J,358.3,1691,1,4,0)
 ;;=4^R03.0
 ;;^UTILITY(U,$J,358.3,1691,2)
 ;;=^5019171
 ;;^UTILITY(U,$J,358.3,1692,0)
 ;;=I95.1^^11^149^10
 ;;^UTILITY(U,$J,358.3,1692,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1692,1,3,0)
 ;;=3^Orthostatic Hypotension
 ;;^UTILITY(U,$J,358.3,1692,1,4,0)
 ;;=4^I95.1
 ;;^UTILITY(U,$J,358.3,1692,2)
 ;;=^60741
 ;;^UTILITY(U,$J,358.3,1693,0)
 ;;=I95.2^^11^149^8
 ;;^UTILITY(U,$J,358.3,1693,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1693,1,3,0)
 ;;=3^Hypotension d/t Drugs
 ;;^UTILITY(U,$J,358.3,1693,1,4,0)
 ;;=4^I95.2
 ;;^UTILITY(U,$J,358.3,1693,2)
 ;;=^5008077
 ;;^UTILITY(U,$J,358.3,1694,0)
 ;;=I95.81^^11^149^11
 ;;^UTILITY(U,$J,358.3,1694,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1694,1,3,0)
 ;;=3^Postprocedural Hypotension
 ;;^UTILITY(U,$J,358.3,1694,1,4,0)
 ;;=4^I95.81
 ;;^UTILITY(U,$J,358.3,1694,2)
 ;;=^5008078
 ;;^UTILITY(U,$J,358.3,1695,0)
 ;;=I95.9^^11^149^9
 ;;^UTILITY(U,$J,358.3,1695,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1695,1,3,0)
 ;;=3^Hypotension,Unspec
 ;;^UTILITY(U,$J,358.3,1695,1,4,0)
 ;;=4^I95.9
 ;;^UTILITY(U,$J,358.3,1695,2)
 ;;=^5008080
 ;;^UTILITY(U,$J,358.3,1696,0)
 ;;=B25.9^^11^150^5
 ;;^UTILITY(U,$J,358.3,1696,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1696,1,3,0)
 ;;=3^CMV Disease,Unspec
 ;;^UTILITY(U,$J,358.3,1696,1,4,0)
 ;;=4^B25.9
 ;;^UTILITY(U,$J,358.3,1696,2)
 ;;=^5000560
 ;;^UTILITY(U,$J,358.3,1697,0)
 ;;=I30.1^^11^150^7
 ;;^UTILITY(U,$J,358.3,1697,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1697,1,3,0)
 ;;=3^Infective Pericarditis
 ;;^UTILITY(U,$J,358.3,1697,1,4,0)
 ;;=4^I30.1
 ;;^UTILITY(U,$J,358.3,1697,2)
 ;;=^5007158
