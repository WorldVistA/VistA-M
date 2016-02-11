IBDEI04V ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,1589,0)
 ;;=Z53.09^^14^157^21
 ;;^UTILITY(U,$J,358.3,1589,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1589,1,3,0)
 ;;=3^Proc/trtmt not crd out bec of contraindication
 ;;^UTILITY(U,$J,358.3,1589,1,4,0)
 ;;=4^Z53.09
 ;;^UTILITY(U,$J,358.3,1589,2)
 ;;=^5063093
 ;;^UTILITY(U,$J,358.3,1590,0)
 ;;=Z53.29^^14^157^23
 ;;^UTILITY(U,$J,358.3,1590,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1590,1,3,0)
 ;;=3^Proc/trtmt not crd out bec pt decision for oth reasons
 ;;^UTILITY(U,$J,358.3,1590,1,4,0)
 ;;=4^Z53.29
 ;;^UTILITY(U,$J,358.3,1590,2)
 ;;=^5063097
 ;;^UTILITY(U,$J,358.3,1591,0)
 ;;=Z53.1^^14^157^22
 ;;^UTILITY(U,$J,358.3,1591,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1591,1,3,0)
 ;;=3^Proc/trtmt not crd out bec pt belief and group pressure
 ;;^UTILITY(U,$J,358.3,1591,1,4,0)
 ;;=4^Z53.1
 ;;^UTILITY(U,$J,358.3,1591,2)
 ;;=^5063094
 ;;^UTILITY(U,$J,358.3,1592,0)
 ;;=Z53.21^^14^157^25
 ;;^UTILITY(U,$J,358.3,1592,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1592,1,3,0)
 ;;=3^Proc/trtmt not crd out d/t pt lv bef seen by hlth care prov
 ;;^UTILITY(U,$J,358.3,1592,1,4,0)
 ;;=4^Z53.21
 ;;^UTILITY(U,$J,358.3,1592,2)
 ;;=^5063096
 ;;^UTILITY(U,$J,358.3,1593,0)
 ;;=Z53.8^^14^157^24
 ;;^UTILITY(U,$J,358.3,1593,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1593,1,3,0)
 ;;=3^Proc/trtmt not crd out d/t other reasons
 ;;^UTILITY(U,$J,358.3,1593,1,4,0)
 ;;=4^Z53.8
 ;;^UTILITY(U,$J,358.3,1593,2)
 ;;=^5063098
 ;;^UTILITY(U,$J,358.3,1594,0)
 ;;=96150^^15^158^5^^^^1
 ;;^UTILITY(U,$J,358.3,1594,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1594,1,2,0)
 ;;=2^96150
 ;;^UTILITY(U,$J,358.3,1594,1,3,0)
 ;;=3^Initial Assess,Ea 15 min
 ;;^UTILITY(U,$J,358.3,1595,0)
 ;;=96151^^15^158^8^^^^1
 ;;^UTILITY(U,$J,358.3,1595,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1595,1,2,0)
 ;;=2^96151
 ;;^UTILITY(U,$J,358.3,1595,1,3,0)
 ;;=3^Re-Assess, Ea 15 min
 ;;^UTILITY(U,$J,358.3,1596,0)
 ;;=97755^^15^158^2^^^^1
 ;;^UTILITY(U,$J,358.3,1596,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1596,1,2,0)
 ;;=2^97755
 ;;^UTILITY(U,$J,358.3,1596,1,3,0)
 ;;=3^Assistive Technology Assess,ea 15min
 ;;^UTILITY(U,$J,358.3,1597,0)
 ;;=96152^^15^158^1^^^^1
 ;;^UTILITY(U,$J,358.3,1597,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1597,1,2,0)
 ;;=2^96152
 ;;^UTILITY(U,$J,358.3,1597,1,3,0)
 ;;=3^Adjustment Counseling, Ea 15min
 ;;^UTILITY(U,$J,358.3,1598,0)
 ;;=G9012^^15^158^3^^^^1
 ;;^UTILITY(U,$J,358.3,1598,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1598,1,2,0)
 ;;=2^G9012
 ;;^UTILITY(U,$J,358.3,1598,1,3,0)
 ;;=3^Case Management NEC,Ea 15 min
 ;;^UTILITY(U,$J,358.3,1599,0)
 ;;=97799^^15^158^6^^^^1
 ;;^UTILITY(U,$J,358.3,1599,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1599,1,2,0)
 ;;=2^97799
 ;;^UTILITY(U,$J,358.3,1599,1,3,0)
 ;;=3^Physical Medicine Procedure
 ;;^UTILITY(U,$J,358.3,1600,0)
 ;;=97750^^15^158^7^^^^1
 ;;^UTILITY(U,$J,358.3,1600,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1600,1,2,0)
 ;;=2^97750
 ;;^UTILITY(U,$J,358.3,1600,1,3,0)
 ;;=3^Physical Performance Test
 ;;^UTILITY(U,$J,358.3,1601,0)
 ;;=T1016^^15^158^4^^^^1
 ;;^UTILITY(U,$J,358.3,1601,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1601,1,2,0)
 ;;=2^T1016
 ;;^UTILITY(U,$J,358.3,1601,1,3,0)
 ;;=3^Case Management,Ea 15 Min
 ;;^UTILITY(U,$J,358.3,1602,0)
 ;;=97110^^15^159^8^^^^1
 ;;^UTILITY(U,$J,358.3,1602,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1602,1,2,0)
 ;;=2^97110
 ;;^UTILITY(U,$J,358.3,1602,1,3,0)
 ;;=3^Therapeutic Exercise,1> areas,ea 15min
 ;;^UTILITY(U,$J,358.3,1603,0)
 ;;=97116^^15^159^1^^^^1
 ;;^UTILITY(U,$J,358.3,1603,1,0)
 ;;=^358.31IA^3^2
