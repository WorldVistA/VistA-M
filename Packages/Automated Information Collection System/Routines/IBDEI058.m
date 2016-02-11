IBDEI058 ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,1776,1,2,0)
 ;;=2^33215
 ;;^UTILITY(U,$J,358.3,1776,1,3,0)
 ;;=3^Reposition Transvenous PM/ICD Lead
 ;;^UTILITY(U,$J,358.3,1777,0)
 ;;=33221^^17^169^29^^^^1
 ;;^UTILITY(U,$J,358.3,1777,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1777,1,2,0)
 ;;=2^33221
 ;;^UTILITY(U,$J,358.3,1777,1,3,0)
 ;;=3^New Pacemaker Attached to Old Leads
 ;;^UTILITY(U,$J,358.3,1778,0)
 ;;=33225^^17^169^3^^^^1
 ;;^UTILITY(U,$J,358.3,1778,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1778,1,2,0)
 ;;=2^33225
 ;;^UTILITY(U,$J,358.3,1778,1,3,0)
 ;;=3^CS Lead Implt at time of New Implt/Upgd
 ;;^UTILITY(U,$J,358.3,1779,0)
 ;;=33284^^17^169^27^^^^1
 ;;^UTILITY(U,$J,358.3,1779,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1779,1,2,0)
 ;;=2^33284
 ;;^UTILITY(U,$J,358.3,1779,1,3,0)
 ;;=3^Monitor Explant
 ;;^UTILITY(U,$J,358.3,1780,0)
 ;;=33282^^17^169^28^^^^1
 ;;^UTILITY(U,$J,358.3,1780,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1780,1,2,0)
 ;;=2^33282
 ;;^UTILITY(U,$J,358.3,1780,1,3,0)
 ;;=3^Monitor Implant
 ;;^UTILITY(U,$J,358.3,1781,0)
 ;;=33226^^17^169^4^^^^1
 ;;^UTILITY(U,$J,358.3,1781,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1781,1,2,0)
 ;;=2^33226
 ;;^UTILITY(U,$J,358.3,1781,1,3,0)
 ;;=3^CS Lead Revision
 ;;^UTILITY(U,$J,358.3,1782,0)
 ;;=92961^^17^169^6^^^^1
 ;;^UTILITY(U,$J,358.3,1782,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1782,1,2,0)
 ;;=2^92961
 ;;^UTILITY(U,$J,358.3,1782,1,3,0)
 ;;=3^Cardioversion,Internal
 ;;^UTILITY(U,$J,358.3,1783,0)
 ;;=93260^^17^169^41^^^^1
 ;;^UTILITY(U,$J,358.3,1783,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1783,1,2,0)
 ;;=2^93260
 ;;^UTILITY(U,$J,358.3,1783,1,3,0)
 ;;=3^Prgrmg Dev Eval Impltbl Sys
 ;;^UTILITY(U,$J,358.3,1784,0)
 ;;=93261^^17^169^26^^^^1
 ;;^UTILITY(U,$J,358.3,1784,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1784,1,2,0)
 ;;=2^93261
 ;;^UTILITY(U,$J,358.3,1784,1,3,0)
 ;;=3^Interrogate Subq Defib
 ;;^UTILITY(U,$J,358.3,1785,0)
 ;;=93298^^17^169^14^^^^1
 ;;^UTILITY(U,$J,358.3,1785,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1785,1,2,0)
 ;;=2^93298
 ;;^UTILITY(U,$J,358.3,1785,1,3,0)
 ;;=3^ILR Device Interrogat Remote
 ;;^UTILITY(U,$J,358.3,1786,0)
 ;;=93724^^17^169^1^^^^1
 ;;^UTILITY(U,$J,358.3,1786,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1786,1,2,0)
 ;;=2^93724
 ;;^UTILITY(U,$J,358.3,1786,1,3,0)
 ;;=3^ANALYZE PACEMAKER SYSTEM
 ;;^UTILITY(U,$J,358.3,1787,0)
 ;;=33967^^17^169^17^^^^1
 ;;^UTILITY(U,$J,358.3,1787,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1787,1,2,0)
 ;;=2^33967
 ;;^UTILITY(U,$J,358.3,1787,1,3,0)
 ;;=3^Insert IA Percut Device
 ;;^UTILITY(U,$J,358.3,1788,0)
 ;;=33236^^17^169^46^^^^1
 ;;^UTILITY(U,$J,358.3,1788,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1788,1,2,0)
 ;;=2^33236
 ;;^UTILITY(U,$J,358.3,1788,1,3,0)
 ;;=3^Remove Epi Electrode/Thoracotomy
 ;;^UTILITY(U,$J,358.3,1789,0)
 ;;=33237^^17^169^45^^^^1
 ;;^UTILITY(U,$J,358.3,1789,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1789,1,2,0)
 ;;=2^33237
 ;;^UTILITY(U,$J,358.3,1789,1,3,0)
 ;;=3^Remove Electrode/Thoracotomy Dual
 ;;^UTILITY(U,$J,358.3,1790,0)
 ;;=33249^^17^169^47^^^^1
 ;;^UTILITY(U,$J,358.3,1790,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1790,1,2,0)
 ;;=2^33249
 ;;^UTILITY(U,$J,358.3,1790,1,3,0)
 ;;=3^Remove ICD Leads/Thoracotomy
 ;;^UTILITY(U,$J,358.3,1791,0)
 ;;=92992^^17^170^1^^^^1
 ;;^UTILITY(U,$J,358.3,1791,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1791,1,2,0)
 ;;=2^92992
 ;;^UTILITY(U,$J,358.3,1791,1,3,0)
 ;;=3^Atrial Septectomy Trans Balloon (Inc Cath)
 ;;^UTILITY(U,$J,358.3,1792,0)
 ;;=92993^^17^170^21^^^^1
 ;;^UTILITY(U,$J,358.3,1792,1,0)
 ;;=^358.31IA^3^2
