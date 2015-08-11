IBDEI030 ; ; 20-MAY-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;OCT 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,979,0)
 ;;=33223^^10^103^59^^^^1
 ;;^UTILITY(U,$J,358.3,979,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,979,1,2,0)
 ;;=2^33223
 ;;^UTILITY(U,$J,358.3,979,1,3,0)
 ;;=3^Revision Skin Pckt, ICD
 ;;^UTILITY(U,$J,358.3,980,0)
 ;;=33224^^10^103^25^^^^1
 ;;^UTILITY(U,$J,358.3,980,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,980,1,2,0)
 ;;=2^33224
 ;;^UTILITY(U,$J,358.3,980,1,3,0)
 ;;=3^Insertion of Pacing Electrode
 ;;^UTILITY(U,$J,358.3,981,0)
 ;;=33214^^10^103^65^^^^1
 ;;^UTILITY(U,$J,358.3,981,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,981,1,2,0)
 ;;=2^33214
 ;;^UTILITY(U,$J,358.3,981,1,3,0)
 ;;=3^Upgrade Sng to Dual PM System
 ;;^UTILITY(U,$J,358.3,982,0)
 ;;=33215^^10^103^57^^^^1
 ;;^UTILITY(U,$J,358.3,982,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,982,1,2,0)
 ;;=2^33215
 ;;^UTILITY(U,$J,358.3,982,1,3,0)
 ;;=3^Reposition Transvenous PM/ICD Lead
 ;;^UTILITY(U,$J,358.3,983,0)
 ;;=33221^^10^103^29^^^^1
 ;;^UTILITY(U,$J,358.3,983,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,983,1,2,0)
 ;;=2^33221
 ;;^UTILITY(U,$J,358.3,983,1,3,0)
 ;;=3^New Pacemaker Attached to Old Leads
 ;;^UTILITY(U,$J,358.3,984,0)
 ;;=33225^^10^103^3^^^^1
 ;;^UTILITY(U,$J,358.3,984,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,984,1,2,0)
 ;;=2^33225
 ;;^UTILITY(U,$J,358.3,984,1,3,0)
 ;;=3^CS Lead Implt at time of New Implt/Upgd
 ;;^UTILITY(U,$J,358.3,985,0)
 ;;=33284^^10^103^27^^^^1
 ;;^UTILITY(U,$J,358.3,985,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,985,1,2,0)
 ;;=2^33284
 ;;^UTILITY(U,$J,358.3,985,1,3,0)
 ;;=3^Monitor Explant
 ;;^UTILITY(U,$J,358.3,986,0)
 ;;=33282^^10^103^28^^^^1
 ;;^UTILITY(U,$J,358.3,986,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,986,1,2,0)
 ;;=2^33282
 ;;^UTILITY(U,$J,358.3,986,1,3,0)
 ;;=3^Monitor Implant
 ;;^UTILITY(U,$J,358.3,987,0)
 ;;=33226^^10^103^4^^^^1
 ;;^UTILITY(U,$J,358.3,987,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,987,1,2,0)
 ;;=2^33226
 ;;^UTILITY(U,$J,358.3,987,1,3,0)
 ;;=3^CS Lead Revision
 ;;^UTILITY(U,$J,358.3,988,0)
 ;;=92961^^10^103^6^^^^1
 ;;^UTILITY(U,$J,358.3,988,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,988,1,2,0)
 ;;=2^92961
 ;;^UTILITY(U,$J,358.3,988,1,3,0)
 ;;=3^Cardioversion,Internal
 ;;^UTILITY(U,$J,358.3,989,0)
 ;;=93260^^10^103^41^^^^1
 ;;^UTILITY(U,$J,358.3,989,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,989,1,2,0)
 ;;=2^93260
 ;;^UTILITY(U,$J,358.3,989,1,3,0)
 ;;=3^Prgrmg Dev Eval Impltbl Sys
 ;;^UTILITY(U,$J,358.3,990,0)
 ;;=93261^^10^103^26^^^^1
 ;;^UTILITY(U,$J,358.3,990,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,990,1,2,0)
 ;;=2^93261
 ;;^UTILITY(U,$J,358.3,990,1,3,0)
 ;;=3^Interrogate Subq Defib
 ;;^UTILITY(U,$J,358.3,991,0)
 ;;=93298^^10^103^14^^^^1
 ;;^UTILITY(U,$J,358.3,991,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,991,1,2,0)
 ;;=2^93298
 ;;^UTILITY(U,$J,358.3,991,1,3,0)
 ;;=3^ILR Device Interrogat Remote
 ;;^UTILITY(U,$J,358.3,992,0)
 ;;=93724^^10^103^1^^^^1
 ;;^UTILITY(U,$J,358.3,992,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,992,1,2,0)
 ;;=2^93724
 ;;^UTILITY(U,$J,358.3,992,1,3,0)
 ;;=3^ANALYZE PACEMAKER SYSTEM
 ;;^UTILITY(U,$J,358.3,993,0)
 ;;=33967^^10^103^17^^^^1
 ;;^UTILITY(U,$J,358.3,993,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,993,1,2,0)
 ;;=2^33967
 ;;^UTILITY(U,$J,358.3,993,1,3,0)
 ;;=3^Insert IA Percut Device
 ;;^UTILITY(U,$J,358.3,994,0)
 ;;=33236^^10^103^46^^^^1
 ;;^UTILITY(U,$J,358.3,994,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,994,1,2,0)
 ;;=2^33236
 ;;^UTILITY(U,$J,358.3,994,1,3,0)
 ;;=3^Remove Epi Electrode/Thoracotomy
 ;;^UTILITY(U,$J,358.3,995,0)
 ;;=33237^^10^103^45^^^^1
 ;;^UTILITY(U,$J,358.3,995,1,0)
 ;;=^358.31IA^3^2
