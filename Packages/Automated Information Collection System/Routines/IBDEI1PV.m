IBDEI1PV ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,27429,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,27429,1,2,0)
 ;;=2^H0020
 ;;^UTILITY(U,$J,358.3,27429,1,3,0)
 ;;=3^Methadone Administration &/or Svc by Lincensed Program
 ;;^UTILITY(U,$J,358.3,27430,0)
 ;;=H0025^^112^1330^2^^^^1
 ;;^UTILITY(U,$J,358.3,27430,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,27430,1,2,0)
 ;;=2^H0025
 ;;^UTILITY(U,$J,358.3,27430,1,3,0)
 ;;=3^Addictions Health Prevention/Education
 ;;^UTILITY(U,$J,358.3,27431,0)
 ;;=H0030^^112^1330^4^^^^1
 ;;^UTILITY(U,$J,358.3,27431,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,27431,1,2,0)
 ;;=2^H0030
 ;;^UTILITY(U,$J,358.3,27431,1,3,0)
 ;;=3^Addictions Hotline Services
 ;;^UTILITY(U,$J,358.3,27432,0)
 ;;=T1016^^112^1331^1^^^^1
 ;;^UTILITY(U,$J,358.3,27432,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,27432,1,2,0)
 ;;=2^T1016
 ;;^UTILITY(U,$J,358.3,27432,1,3,0)
 ;;=3^Case Management per 15min
 ;;^UTILITY(U,$J,358.3,27433,0)
 ;;=96372^^112^1332^1^^^^1
 ;;^UTILITY(U,$J,358.3,27433,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,27433,1,2,0)
 ;;=2^96372
 ;;^UTILITY(U,$J,358.3,27433,1,3,0)
 ;;=3^Ther/Proph/Diag Inj SC/IM
 ;;^UTILITY(U,$J,358.3,27434,0)
 ;;=96374^^112^1332^2^^^^1
 ;;^UTILITY(U,$J,358.3,27434,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,27434,1,2,0)
 ;;=2^96374
 ;;^UTILITY(U,$J,358.3,27434,1,3,0)
 ;;=3^Ther/Proph/Diag Inj IV Push
 ;;^UTILITY(U,$J,358.3,27435,0)
 ;;=96376^^112^1332^3^^^^1
 ;;^UTILITY(U,$J,358.3,27435,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,27435,1,2,0)
 ;;=2^96376
 ;;^UTILITY(U,$J,358.3,27435,1,3,0)
 ;;=3^Tx/Pro/Dx Inj,ea addl sequential IVP of Same Drug-Add-on
 ;;^UTILITY(U,$J,358.3,27436,0)
 ;;=J2680^^112^1333^3^^^^1
 ;;^UTILITY(U,$J,358.3,27436,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,27436,1,2,0)
 ;;=2^J2680
 ;;^UTILITY(U,$J,358.3,27436,1,3,0)
 ;;=3^Fluphenazine Decanoate up to 25mg
 ;;^UTILITY(U,$J,358.3,27437,0)
 ;;=J1631^^112^1333^4^^^^1
 ;;^UTILITY(U,$J,358.3,27437,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,27437,1,2,0)
 ;;=2^J1631
 ;;^UTILITY(U,$J,358.3,27437,1,3,0)
 ;;=3^Haloperidol Decanoate per 50mg
 ;;^UTILITY(U,$J,358.3,27438,0)
 ;;=J2315^^112^1333^5^^^^1
 ;;^UTILITY(U,$J,358.3,27438,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,27438,1,2,0)
 ;;=2^J2315
 ;;^UTILITY(U,$J,358.3,27438,1,3,0)
 ;;=3^Naltrexone,Depot Form 1mg
 ;;^UTILITY(U,$J,358.3,27439,0)
 ;;=J2426^^112^1333^7^^^^1
 ;;^UTILITY(U,$J,358.3,27439,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,27439,1,2,0)
 ;;=2^J2426
 ;;^UTILITY(U,$J,358.3,27439,1,3,0)
 ;;=3^Paliperidone Palmitate Extend Release per 1mg
 ;;^UTILITY(U,$J,358.3,27440,0)
 ;;=J2794^^112^1333^8^^^^1
 ;;^UTILITY(U,$J,358.3,27440,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,27440,1,2,0)
 ;;=2^J2794
 ;;^UTILITY(U,$J,358.3,27440,1,3,0)
 ;;=3^Risperidone Long Act per 0.5mg
 ;;^UTILITY(U,$J,358.3,27441,0)
 ;;=J2315^^112^1333^9^^^^1
 ;;^UTILITY(U,$J,358.3,27441,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,27441,1,2,0)
 ;;=2^J2315
 ;;^UTILITY(U,$J,358.3,27441,1,3,0)
 ;;=3^Vivitrol 1mg
 ;;^UTILITY(U,$J,358.3,27442,0)
 ;;=J0401^^112^1333^1^^^^1
 ;;^UTILITY(U,$J,358.3,27442,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,27442,1,2,0)
 ;;=2^J0401
 ;;^UTILITY(U,$J,358.3,27442,1,3,0)
 ;;=3^Aripiprazole Ext Rel 1mg
 ;;^UTILITY(U,$J,358.3,27443,0)
 ;;=J2358^^112^1333^6^^^^1
 ;;^UTILITY(U,$J,358.3,27443,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,27443,1,2,0)
 ;;=2^J2358
