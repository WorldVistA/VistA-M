IBDEI02S ; ; 12-AUG-2014
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,911,1,2,0)
 ;;=2^92570
 ;;^UTILITY(U,$J,358.3,911,1,3,0)
 ;;=3^Acoustic Immittance Testing
 ;;^UTILITY(U,$J,358.3,912,0)
 ;;=92558^^12^99^17^^^^1
 ;;^UTILITY(U,$J,358.3,912,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,912,1,2,0)
 ;;=2^92558
 ;;^UTILITY(U,$J,358.3,912,1,3,0)
 ;;=3^Evoked Otoacoustic Emmissions,Scrn,Auto
 ;;^UTILITY(U,$J,358.3,913,0)
 ;;=92611^^12^99^25^^^^1
 ;;^UTILITY(U,$J,358.3,913,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,913,1,2,0)
 ;;=2^92611
 ;;^UTILITY(U,$J,358.3,913,1,3,0)
 ;;=3^Motion Fluoroscopic Eval Swallowing
 ;;^UTILITY(U,$J,358.3,914,0)
 ;;=92612^^12^99^20^^^^1
 ;;^UTILITY(U,$J,358.3,914,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,914,1,2,0)
 ;;=2^92612
 ;;^UTILITY(U,$J,358.3,914,1,3,0)
 ;;=3^Flexible Fiberoptic Eval Swallowing
 ;;^UTILITY(U,$J,358.3,915,0)
 ;;=92626^^12^99^15^^^^1
 ;;^UTILITY(U,$J,358.3,915,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,915,1,2,0)
 ;;=2^92626
 ;;^UTILITY(U,$J,358.3,915,1,3,0)
 ;;=3^Eval Aud Rehab Status
 ;;^UTILITY(U,$J,358.3,916,0)
 ;;=92627^^12^99^16^^^^1
 ;;^UTILITY(U,$J,358.3,916,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,916,1,2,0)
 ;;=2^92627
 ;;^UTILITY(U,$J,358.3,916,1,3,0)
 ;;=3^Eval Aud Status Rehab,ea addl
 ;;^UTILITY(U,$J,358.3,917,0)
 ;;=92613^^12^99^21^^^^1
 ;;^UTILITY(U,$J,358.3,917,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,917,1,2,0)
 ;;=2^92613
 ;;^UTILITY(U,$J,358.3,917,1,3,0)
 ;;=3^Flex Fib Eval Swallow,Interp/Rpt Only
 ;;^UTILITY(U,$J,358.3,918,0)
 ;;=92614^^12^99^22^^^^1
 ;;^UTILITY(U,$J,358.3,918,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,918,1,2,0)
 ;;=2^92614
 ;;^UTILITY(U,$J,358.3,918,1,3,0)
 ;;=3^Laryngoscopic Sensory Test,Video
 ;;^UTILITY(U,$J,358.3,919,0)
 ;;=92615^^12^99^23^^^^1
 ;;^UTILITY(U,$J,358.3,919,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,919,1,2,0)
 ;;=2^92615
 ;;^UTILITY(U,$J,358.3,919,1,3,0)
 ;;=3^Laryngoscopic Sensory Tst,Interp&Rpt Only
 ;;^UTILITY(U,$J,358.3,920,0)
 ;;=92560^^12^99^9^^^^1
 ;;^UTILITY(U,$J,358.3,920,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,920,1,2,0)
 ;;=2^92560
 ;;^UTILITY(U,$J,358.3,920,1,3,0)
 ;;=3^Bekesy Audiometry,Screening
 ;;^UTILITY(U,$J,358.3,921,0)
 ;;=92561^^12^99^8^^^^1
 ;;^UTILITY(U,$J,358.3,921,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,921,1,2,0)
 ;;=2^92561
 ;;^UTILITY(U,$J,358.3,921,1,3,0)
 ;;=3^Bekesy Audiometry,Diagnostic
 ;;^UTILITY(U,$J,358.3,922,0)
 ;;=92616^^12^99^18^^^^1
 ;;^UTILITY(U,$J,358.3,922,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,922,1,2,0)
 ;;=2^92616
 ;;^UTILITY(U,$J,358.3,922,1,3,0)
 ;;=3^Flex Fbroptic Eval Swal/Laryng Sens Tst-Video
 ;;^UTILITY(U,$J,358.3,923,0)
 ;;=92617^^12^99^19^^^^1
 ;;^UTILITY(U,$J,358.3,923,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,923,1,2,0)
 ;;=2^92617
 ;;^UTILITY(U,$J,358.3,923,1,3,0)
 ;;=3^Flex Fbroptic Eval Laryng Tst-Interp/Rpt
 ;;^UTILITY(U,$J,358.3,924,0)
 ;;=92551^^12^100^3^^^^1
 ;;^UTILITY(U,$J,358.3,924,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,924,1,2,0)
 ;;=2^92551
 ;;^UTILITY(U,$J,358.3,924,1,3,0)
 ;;=3^Pure Tone Hearing Test, Air
 ;;^UTILITY(U,$J,358.3,925,0)
 ;;=V5008^^12^100^2^^^^1
 ;;^UTILITY(U,$J,358.3,925,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,925,1,2,0)
 ;;=2^V5008
 ;;^UTILITY(U,$J,358.3,925,1,3,0)
 ;;=3^Hearing Screening
 ;;^UTILITY(U,$J,358.3,926,0)
 ;;=92550^^12^100^4^^^^1
 ;;^UTILITY(U,$J,358.3,926,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,926,1,2,0)
 ;;=2^92550
 ;;^UTILITY(U,$J,358.3,926,1,3,0)
 ;;=3^Tympanometry & Reflex Threshold
 ;;^UTILITY(U,$J,358.3,927,0)
 ;;=V5010^^12^100^1^^^^1
 ;;^UTILITY(U,$J,358.3,927,1,0)
 ;;=^358.31IA^3^2
