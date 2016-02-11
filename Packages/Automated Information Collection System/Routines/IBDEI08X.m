IBDEI08X ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,3628,1,4,0)
 ;;=4^N17.9
 ;;^UTILITY(U,$J,358.3,3628,2)
 ;;=^338532
 ;;^UTILITY(U,$J,358.3,3629,0)
 ;;=N19.^^28^257^15
 ;;^UTILITY(U,$J,358.3,3629,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3629,1,3,0)
 ;;=3^Kidney Failure,Unspec
 ;;^UTILITY(U,$J,358.3,3629,1,4,0)
 ;;=4^N19.
 ;;^UTILITY(U,$J,358.3,3629,2)
 ;;=^5015607
 ;;^UTILITY(U,$J,358.3,3630,0)
 ;;=N26.1^^28^257^16
 ;;^UTILITY(U,$J,358.3,3630,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3630,1,3,0)
 ;;=3^Kidney,Atrophy
 ;;^UTILITY(U,$J,358.3,3630,1,4,0)
 ;;=4^N26.1
 ;;^UTILITY(U,$J,358.3,3630,2)
 ;;=^5015620
 ;;^UTILITY(U,$J,358.3,3631,0)
 ;;=N26.2^^28^257^17
 ;;^UTILITY(U,$J,358.3,3631,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3631,1,3,0)
 ;;=3^Kidney,Page
 ;;^UTILITY(U,$J,358.3,3631,1,4,0)
 ;;=4^N26.2
 ;;^UTILITY(U,$J,358.3,3631,2)
 ;;=^5015621
 ;;^UTILITY(U,$J,358.3,3632,0)
 ;;=N27.9^^28^257^18
 ;;^UTILITY(U,$J,358.3,3632,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3632,1,3,0)
 ;;=3^Kidney,Small,Unspec
 ;;^UTILITY(U,$J,358.3,3632,1,4,0)
 ;;=4^N27.9
 ;;^UTILITY(U,$J,358.3,3632,2)
 ;;=^5015625
 ;;^UTILITY(U,$J,358.3,3633,0)
 ;;=N00.9^^28^257^19
 ;;^UTILITY(U,$J,358.3,3633,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3633,1,3,0)
 ;;=3^Nephritic Syndrome,Acute w/ Unspec Morphologic Changes
 ;;^UTILITY(U,$J,358.3,3633,1,4,0)
 ;;=4^N00.9
 ;;^UTILITY(U,$J,358.3,3633,2)
 ;;=^5015500
 ;;^UTILITY(U,$J,358.3,3634,0)
 ;;=N11.9^^28^257^21
 ;;^UTILITY(U,$J,358.3,3634,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3634,1,3,0)
 ;;=3^Nephritis,Chronic Tubulo-Interstitial,Unspec
 ;;^UTILITY(U,$J,358.3,3634,1,4,0)
 ;;=4^N11.9
 ;;^UTILITY(U,$J,358.3,3634,2)
 ;;=^5015574
 ;;^UTILITY(U,$J,358.3,3635,0)
 ;;=N10.^^28^257^20
 ;;^UTILITY(U,$J,358.3,3635,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3635,1,3,0)
 ;;=3^Nephritis,Acute Tubulo-Interstitial
 ;;^UTILITY(U,$J,358.3,3635,1,4,0)
 ;;=4^N10.
 ;;^UTILITY(U,$J,358.3,3635,2)
 ;;=^5015570
 ;;^UTILITY(U,$J,358.3,3636,0)
 ;;=N12.^^28^257^22
 ;;^UTILITY(U,$J,358.3,3636,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3636,1,3,0)
 ;;=3^Nephritis,Tubulo-Interstitial,Not Specified
 ;;^UTILITY(U,$J,358.3,3636,1,4,0)
 ;;=4^N12.
 ;;^UTILITY(U,$J,358.3,3636,2)
 ;;=^5015575
 ;;^UTILITY(U,$J,358.3,3637,0)
 ;;=N11.0^^28^257^23
 ;;^UTILITY(U,$J,358.3,3637,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3637,1,3,0)
 ;;=3^Pyelonephritis,Chronic Non-obstructive Reflux-Associated
 ;;^UTILITY(U,$J,358.3,3637,1,4,0)
 ;;=4^N11.0
 ;;^UTILITY(U,$J,358.3,3637,2)
 ;;=^5015571
 ;;^UTILITY(U,$J,358.3,3638,0)
 ;;=N11.1^^28^257^24
 ;;^UTILITY(U,$J,358.3,3638,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3638,1,3,0)
 ;;=3^Pyelonephritis,Chronic Obstructive
 ;;^UTILITY(U,$J,358.3,3638,1,4,0)
 ;;=4^N11.1
 ;;^UTILITY(U,$J,358.3,3638,2)
 ;;=^5015572
 ;;^UTILITY(U,$J,358.3,3639,0)
 ;;=N23.^^28^257^25
 ;;^UTILITY(U,$J,358.3,3639,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3639,1,3,0)
 ;;=3^Renal Colic,Unspec
 ;;^UTILITY(U,$J,358.3,3639,1,4,0)
 ;;=4^N23.
 ;;^UTILITY(U,$J,358.3,3639,2)
 ;;=^5015615
 ;;^UTILITY(U,$J,358.3,3640,0)
 ;;=Z99.2^^28^257^26
 ;;^UTILITY(U,$J,358.3,3640,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3640,1,3,0)
 ;;=3^Renal Dialysis Dependence
 ;;^UTILITY(U,$J,358.3,3640,1,4,0)
 ;;=4^Z99.2
 ;;^UTILITY(U,$J,358.3,3640,2)
 ;;=^5063758
 ;;^UTILITY(U,$J,358.3,3641,0)
 ;;=N26.9^^28^257^27
 ;;^UTILITY(U,$J,358.3,3641,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3641,1,3,0)
 ;;=3^Renal Sclerosis,Unspec
 ;;^UTILITY(U,$J,358.3,3641,1,4,0)
 ;;=4^N26.9
 ;;^UTILITY(U,$J,358.3,3641,2)
 ;;=^5015622
 ;;^UTILITY(U,$J,358.3,3642,0)
 ;;=N25.9^^28^257^28
