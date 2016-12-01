IBDEI01R ; ; 09-AUG-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,1749,0)
 ;;=93295^^9^132^8^^^^1
 ;;^UTILITY(U,$J,358.3,1749,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1749,1,2,0)
 ;;=2^93295
 ;;^UTILITY(U,$J,358.3,1749,1,3,0)
 ;;=3^ICD Device Interrogate Remote
 ;;^UTILITY(U,$J,358.3,1750,0)
 ;;=93283^^9^132^10^^^^1
 ;;^UTILITY(U,$J,358.3,1750,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1750,1,2,0)
 ;;=2^93283
 ;;^UTILITY(U,$J,358.3,1750,1,3,0)
 ;;=3^ICD Device Progr Eval,Dual
 ;;^UTILITY(U,$J,358.3,1751,0)
 ;;=93284^^9^132^11^^^^1
 ;;^UTILITY(U,$J,358.3,1751,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1751,1,2,0)
 ;;=2^93284
 ;;^UTILITY(U,$J,358.3,1751,1,3,0)
 ;;=3^ICD Device Progr Eval,Multi
 ;;^UTILITY(U,$J,358.3,1752,0)
 ;;=93281^^9^132^33^^^^1
 ;;^UTILITY(U,$J,358.3,1752,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1752,1,2,0)
 ;;=2^93281
 ;;^UTILITY(U,$J,358.3,1752,1,3,0)
 ;;=3^PM Device Progr Eval,Multi
 ;;^UTILITY(U,$J,358.3,1753,0)
 ;;=33227^^9^132^50^^^^1
 ;;^UTILITY(U,$J,358.3,1753,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1753,1,2,0)
 ;;=2^33227
 ;;^UTILITY(U,$J,358.3,1753,1,3,0)
 ;;=3^Remove PM Pulse Gen w/Replc PM Gen,Single
 ;;^UTILITY(U,$J,358.3,1754,0)
 ;;=33228^^9^132^48^^^^1
 ;;^UTILITY(U,$J,358.3,1754,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1754,1,2,0)
 ;;=2^33228
 ;;^UTILITY(U,$J,358.3,1754,1,3,0)
 ;;=3^Remove PM Pulse Gen w/Replc PM Gen,Dual
 ;;^UTILITY(U,$J,358.3,1755,0)
 ;;=33229^^9^132^49^^^^1
 ;;^UTILITY(U,$J,358.3,1755,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1755,1,2,0)
 ;;=2^33229
 ;;^UTILITY(U,$J,358.3,1755,1,3,0)
 ;;=3^Remove PM Pulse Gen w/Replc PM Gen,Mult
 ;;^UTILITY(U,$J,358.3,1756,0)
 ;;=33230^^9^132^18^^^^1
 ;;^UTILITY(U,$J,358.3,1756,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1756,1,2,0)
 ;;=2^33230
 ;;^UTILITY(U,$J,358.3,1756,1,3,0)
 ;;=3^Insert ICD Gen Only,Existing Single
 ;;^UTILITY(U,$J,358.3,1757,0)
 ;;=33231^^9^132^17^^^^1
 ;;^UTILITY(U,$J,358.3,1757,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1757,1,2,0)
 ;;=2^33231
 ;;^UTILITY(U,$J,358.3,1757,1,3,0)
 ;;=3^Insert ICD Gen Only,Existing Mult
 ;;^UTILITY(U,$J,358.3,1758,0)
 ;;=33233^^9^132^44^^^^1
 ;;^UTILITY(U,$J,358.3,1758,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1758,1,2,0)
 ;;=2^33233
 ;;^UTILITY(U,$J,358.3,1758,1,3,0)
 ;;=3^Removal of PM Generator Only
 ;;^UTILITY(U,$J,358.3,1759,0)
 ;;=33262^^9^132^54^^^^1
 ;;^UTILITY(U,$J,358.3,1759,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1759,1,2,0)
 ;;=2^33262
 ;;^UTILITY(U,$J,358.3,1759,1,3,0)
 ;;=3^Remv ICD Gen w/Replc PM Gen,Single
 ;;^UTILITY(U,$J,358.3,1760,0)
 ;;=33263^^9^132^52^^^^1
 ;;^UTILITY(U,$J,358.3,1760,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1760,1,2,0)
 ;;=2^33263
 ;;^UTILITY(U,$J,358.3,1760,1,3,0)
 ;;=3^Remv ICD Gen w/Replc PM Gen,Dual
 ;;^UTILITY(U,$J,358.3,1761,0)
 ;;=33264^^9^132^53^^^^1
 ;;^UTILITY(U,$J,358.3,1761,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1761,1,2,0)
 ;;=2^33264
 ;;^UTILITY(U,$J,358.3,1761,1,3,0)
 ;;=3^Remv ICD Gen w/Replc PM Gen,Multiple
 ;;^UTILITY(U,$J,358.3,1762,0)
 ;;=93286^^9^132^40^^^^1
 ;;^UTILITY(U,$J,358.3,1762,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1762,1,2,0)
 ;;=2^93286
 ;;^UTILITY(U,$J,358.3,1762,1,3,0)
 ;;=3^Pre-Op PM Device Eval w/Review&Rpt
 ;;^UTILITY(U,$J,358.3,1763,0)
 ;;=93287^^9^132^39^^^^1
 ;;^UTILITY(U,$J,358.3,1763,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1763,1,2,0)
 ;;=2^93287
 ;;^UTILITY(U,$J,358.3,1763,1,3,0)
 ;;=3^Pre-Op ICD Device Eval
 ;;^UTILITY(U,$J,358.3,1764,0)
 ;;=93290^^9^132^12^^^^1
 ;;^UTILITY(U,$J,358.3,1764,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1764,1,2,0)
 ;;=2^93290
 ;;^UTILITY(U,$J,358.3,1764,1,3,0)
 ;;=3^ICM Device Eval
 ;;^UTILITY(U,$J,358.3,1765,0)
 ;;=93293^^9^132^35^^^^1
 ;;^UTILITY(U,$J,358.3,1765,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1765,1,2,0)
 ;;=2^93293
 ;;^UTILITY(U,$J,358.3,1765,1,3,0)
 ;;=3^PM Phone R-Strip Device Eval
 ;;^UTILITY(U,$J,358.3,1766,0)
 ;;=33223^^9^132^59^^^^1
 ;;^UTILITY(U,$J,358.3,1766,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1766,1,2,0)
 ;;=2^33223
 ;;^UTILITY(U,$J,358.3,1766,1,3,0)
 ;;=3^Revision Skin Pckt, ICD
 ;;^UTILITY(U,$J,358.3,1767,0)
 ;;=33224^^9^132^25^^^^1
 ;;^UTILITY(U,$J,358.3,1767,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1767,1,2,0)
 ;;=2^33224
 ;;^UTILITY(U,$J,358.3,1767,1,3,0)
 ;;=3^Insertion of Pacing Electrode
 ;;^UTILITY(U,$J,358.3,1768,0)
 ;;=33214^^9^132^65^^^^1
 ;;^UTILITY(U,$J,358.3,1768,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1768,1,2,0)
 ;;=2^33214
 ;;^UTILITY(U,$J,358.3,1768,1,3,0)
 ;;=3^Upgrade Sng to Dual PM System
 ;;^UTILITY(U,$J,358.3,1769,0)
 ;;=33215^^9^132^57^^^^1
 ;;^UTILITY(U,$J,358.3,1769,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1769,1,2,0)
 ;;=2^33215
 ;;^UTILITY(U,$J,358.3,1769,1,3,0)
 ;;=3^Reposition Transvenous PM/ICD Lead
 ;;^UTILITY(U,$J,358.3,1770,0)
 ;;=33221^^9^132^29^^^^1
 ;;^UTILITY(U,$J,358.3,1770,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1770,1,2,0)
 ;;=2^33221
 ;;^UTILITY(U,$J,358.3,1770,1,3,0)
 ;;=3^New Pacemaker Attached to Old Leads
 ;;^UTILITY(U,$J,358.3,1771,0)
 ;;=33225^^9^132^3^^^^1
 ;;^UTILITY(U,$J,358.3,1771,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1771,1,2,0)
 ;;=2^33225
 ;;^UTILITY(U,$J,358.3,1771,1,3,0)
 ;;=3^CS Lead Implt at time of New Implt/Upgd
 ;;^UTILITY(U,$J,358.3,1772,0)
 ;;=33284^^9^132^27^^^^1
 ;;^UTILITY(U,$J,358.3,1772,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1772,1,2,0)
 ;;=2^33284
 ;;^UTILITY(U,$J,358.3,1772,1,3,0)
 ;;=3^Monitor Explant
 ;;^UTILITY(U,$J,358.3,1773,0)
 ;;=33282^^9^132^28^^^^1
 ;;^UTILITY(U,$J,358.3,1773,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1773,1,2,0)
 ;;=2^33282
 ;;^UTILITY(U,$J,358.3,1773,1,3,0)
 ;;=3^Monitor Implant
 ;;^UTILITY(U,$J,358.3,1774,0)
 ;;=33226^^9^132^4^^^^1
 ;;^UTILITY(U,$J,358.3,1774,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1774,1,2,0)
 ;;=2^33226
 ;;^UTILITY(U,$J,358.3,1774,1,3,0)
 ;;=3^CS Lead Revision
 ;;^UTILITY(U,$J,358.3,1775,0)
 ;;=92961^^9^132^6^^^^1
 ;;^UTILITY(U,$J,358.3,1775,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1775,1,2,0)
 ;;=2^92961
 ;;^UTILITY(U,$J,358.3,1775,1,3,0)
 ;;=3^Cardioversion,Internal
 ;;^UTILITY(U,$J,358.3,1776,0)
 ;;=93260^^9^132^41^^^^1
 ;;^UTILITY(U,$J,358.3,1776,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1776,1,2,0)
 ;;=2^93260
 ;;^UTILITY(U,$J,358.3,1776,1,3,0)
 ;;=3^Prgrmg Dev Eval Impltbl Sys
 ;;^UTILITY(U,$J,358.3,1777,0)
 ;;=93261^^9^132^26^^^^1
 ;;^UTILITY(U,$J,358.3,1777,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1777,1,2,0)
 ;;=2^93261
 ;;^UTILITY(U,$J,358.3,1777,1,3,0)
 ;;=3^Interrogate Subq Defib
 ;;^UTILITY(U,$J,358.3,1778,0)
 ;;=93298^^9^132^14^^^^1
 ;;^UTILITY(U,$J,358.3,1778,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1778,1,2,0)
 ;;=2^93298
 ;;^UTILITY(U,$J,358.3,1778,1,3,0)
 ;;=3^ILR Device Interrogat Remote
 ;;^UTILITY(U,$J,358.3,1779,0)
 ;;=93724^^9^132^1^^^^1
 ;;^UTILITY(U,$J,358.3,1779,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1779,1,2,0)
 ;;=2^93724
 ;;^UTILITY(U,$J,358.3,1779,1,3,0)
 ;;=3^ANALYZE PACEMAKER SYSTEM
 ;;^UTILITY(U,$J,358.3,1780,0)
 ;;=33967^^9^132^16^^^^1
 ;;^UTILITY(U,$J,358.3,1780,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1780,1,2,0)
 ;;=2^33967
 ;;^UTILITY(U,$J,358.3,1780,1,3,0)
 ;;=3^Insert IA Percut Device
 ;;^UTILITY(U,$J,358.3,1781,0)
 ;;=33236^^9^132^46^^^^1
 ;;^UTILITY(U,$J,358.3,1781,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1781,1,2,0)
 ;;=2^33236
 ;;^UTILITY(U,$J,358.3,1781,1,3,0)
 ;;=3^Remove Epi Electrode/Thoracotomy
 ;;^UTILITY(U,$J,358.3,1782,0)
 ;;=33237^^9^132^45^^^^1
 ;;^UTILITY(U,$J,358.3,1782,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1782,1,2,0)
 ;;=2^33237
 ;;^UTILITY(U,$J,358.3,1782,1,3,0)
 ;;=3^Remove Electrode/Thoracotomy Dual
 ;;^UTILITY(U,$J,358.3,1783,0)
 ;;=33249^^9^132^47^^^^1
 ;;^UTILITY(U,$J,358.3,1783,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1783,1,2,0)
 ;;=2^33249
 ;;^UTILITY(U,$J,358.3,1783,1,3,0)
 ;;=3^Remove ICD Leads/Thoracotomy
 ;;^UTILITY(U,$J,358.3,1784,0)
 ;;=92992^^9^133^1^^^^1
 ;;^UTILITY(U,$J,358.3,1784,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1784,1,2,0)
 ;;=2^92992
 ;;^UTILITY(U,$J,358.3,1784,1,3,0)
 ;;=3^Atrial Septectomy Trans Balloon (Inc Cath)
 ;;^UTILITY(U,$J,358.3,1785,0)
 ;;=92993^^9^133^21^^^^1
 ;;^UTILITY(U,$J,358.3,1785,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1785,1,2,0)
 ;;=2^92993
 ;;^UTILITY(U,$J,358.3,1785,1,3,0)
 ;;=3^Park Septostomy,Includes Cath
 ;;^UTILITY(U,$J,358.3,1786,0)
 ;;=92975^^9^133^27^^^^1
 ;;^UTILITY(U,$J,358.3,1786,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1786,1,2,0)
 ;;=2^92975
 ;;^UTILITY(U,$J,358.3,1786,1,3,0)
 ;;=3^Thrombo Cor Includes Cor Angiog
 ;;^UTILITY(U,$J,358.3,1787,0)
 ;;=92977^^9^133^28^^^^1
 ;;^UTILITY(U,$J,358.3,1787,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1787,1,2,0)
 ;;=2^92977
 ;;^UTILITY(U,$J,358.3,1787,1,3,0)
 ;;=3^Thrombo Cor,Inc Cor Angio Iv Inf
 ;;^UTILITY(U,$J,358.3,1788,0)
 ;;=92978^^9^133^6^^^^1
 ;;^UTILITY(U,$J,358.3,1788,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1788,1,2,0)
 ;;=2^92978
 ;;^UTILITY(U,$J,358.3,1788,1,3,0)
 ;;=3^Intr Vasc U/S During Diag Eval
 ;;^UTILITY(U,$J,358.3,1789,0)
 ;;=92979^^9^133^7^^^^1
 ;;^UTILITY(U,$J,358.3,1789,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1789,1,2,0)
 ;;=2^92979
 ;;^UTILITY(U,$J,358.3,1789,1,3,0)
 ;;=3^     Each Add'L Vessel (W/92978)
 ;;^UTILITY(U,$J,358.3,1790,0)
 ;;=36010^^9^133^4^^^^1
 ;;^UTILITY(U,$J,358.3,1790,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1790,1,2,0)
 ;;=2^36010
 ;;^UTILITY(U,$J,358.3,1790,1,3,0)
 ;;=3^Cath Place Svc/Ivc (Sheath)
 ;;^UTILITY(U,$J,358.3,1791,0)
 ;;=36011^^9^133^5^^^^1
 ;;^UTILITY(U,$J,358.3,1791,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1791,1,2,0)
 ;;=2^36011
 ;;^UTILITY(U,$J,358.3,1791,1,3,0)
 ;;=3^Cath Place Vein 1St Order(Sheath
 ;;^UTILITY(U,$J,358.3,1792,0)
 ;;=76930^^9^133^29^^^^1
 ;;^UTILITY(U,$J,358.3,1792,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1792,1,2,0)
 ;;=2^76930
