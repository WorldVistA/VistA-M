IBDEI101 ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,17582,0)
 ;;=31505^^92^1098^5^^^^1
 ;;^UTILITY(U,$J,358.3,17582,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,17582,1,2,0)
 ;;=2^31505
 ;;^UTILITY(U,$J,358.3,17582,1,3,0)
 ;;=3^Laryngoscopy, Indirect
 ;;^UTILITY(U,$J,358.3,17583,0)
 ;;=31575^^92^1098^3^^^^1
 ;;^UTILITY(U,$J,358.3,17583,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,17583,1,2,0)
 ;;=2^31575
 ;;^UTILITY(U,$J,358.3,17583,1,3,0)
 ;;=3^Laryngoscopy, Fiberoptic
 ;;^UTILITY(U,$J,358.3,17584,0)
 ;;=31579^^92^1098^4^^^^1
 ;;^UTILITY(U,$J,358.3,17584,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,17584,1,2,0)
 ;;=2^31579
 ;;^UTILITY(U,$J,358.3,17584,1,3,0)
 ;;=3^Laryngoscopy, Fiberoptic W Stroboscopy
 ;;^UTILITY(U,$J,358.3,17585,0)
 ;;=92520^^92^1098^1^^^^1
 ;;^UTILITY(U,$J,358.3,17585,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,17585,1,2,0)
 ;;=2^92520
 ;;^UTILITY(U,$J,358.3,17585,1,3,0)
 ;;=3^Laryngeal Function Studies
 ;;^UTILITY(U,$J,358.3,17586,0)
 ;;=92614^^92^1098^2^^^^1
 ;;^UTILITY(U,$J,358.3,17586,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,17586,1,2,0)
 ;;=2^92614
 ;;^UTILITY(U,$J,358.3,17586,1,3,0)
 ;;=3^Laryngoscopic Sensory Test
 ;;^UTILITY(U,$J,358.3,17587,0)
 ;;=92511^^92^1099^2^^^^1
 ;;^UTILITY(U,$J,358.3,17587,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,17587,1,2,0)
 ;;=2^92511
 ;;^UTILITY(U,$J,358.3,17587,1,3,0)
 ;;=3^Nasopharyngoscopy
 ;;^UTILITY(U,$J,358.3,17588,0)
 ;;=92512^^92^1099^1^^^^1
 ;;^UTILITY(U,$J,358.3,17588,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,17588,1,2,0)
 ;;=2^92512
 ;;^UTILITY(U,$J,358.3,17588,1,3,0)
 ;;=3^Nasal Function Studies
 ;;^UTILITY(U,$J,358.3,17589,0)
 ;;=92610^^92^1100^3^^^^1
 ;;^UTILITY(U,$J,358.3,17589,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,17589,1,2,0)
 ;;=2^92610
 ;;^UTILITY(U,$J,358.3,17589,1,3,0)
 ;;=3^Evaluate Swallowing Function
 ;;^UTILITY(U,$J,358.3,17590,0)
 ;;=92611^^92^1100^8^^^^1
 ;;^UTILITY(U,$J,358.3,17590,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,17590,1,2,0)
 ;;=2^92611
 ;;^UTILITY(U,$J,358.3,17590,1,3,0)
 ;;=3^Motion Fluoroscopy/Swallow
 ;;^UTILITY(U,$J,358.3,17591,0)
 ;;=92612^^92^1100^2^^^^1
 ;;^UTILITY(U,$J,358.3,17591,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,17591,1,2,0)
 ;;=2^92612
 ;;^UTILITY(U,$J,358.3,17591,1,3,0)
 ;;=3^Endoscopy Swallow Tst (Fees)
 ;;^UTILITY(U,$J,358.3,17592,0)
 ;;=92616^^92^1100^7^^^^1
 ;;^UTILITY(U,$J,358.3,17592,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,17592,1,2,0)
 ;;=2^92616
 ;;^UTILITY(U,$J,358.3,17592,1,3,0)
 ;;=3^Flx Fiberop Endosc Swllw Stdy,Laryng Snsry,Cine Tst
 ;;^UTILITY(U,$J,358.3,17593,0)
 ;;=92613^^92^1100^1^^^^1
 ;;^UTILITY(U,$J,358.3,17593,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,17593,1,2,0)
 ;;=2^92613
 ;;^UTILITY(U,$J,358.3,17593,1,3,0)
 ;;=3^Endo Swallow Tst,Interp & Rpt Only
 ;;^UTILITY(U,$J,358.3,17594,0)
 ;;=92614^^92^1100^4^^^^1
 ;;^UTILITY(U,$J,358.3,17594,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,17594,1,2,0)
 ;;=2^92614
 ;;^UTILITY(U,$J,358.3,17594,1,3,0)
 ;;=3^Flx Fiberop Endosc Eval,Laryng Snsry Tst,Cine/Vid
 ;;^UTILITY(U,$J,358.3,17595,0)
 ;;=92615^^92^1100^5^^^^1
 ;;^UTILITY(U,$J,358.3,17595,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,17595,1,2,0)
 ;;=2^92615
 ;;^UTILITY(U,$J,358.3,17595,1,3,0)
 ;;=3^Flx Fiberop Endosc Eval,Laryng Snsry Tst,I&R Only
 ;;^UTILITY(U,$J,358.3,17596,0)
 ;;=92617^^92^1100^6^^^^1
 ;;^UTILITY(U,$J,358.3,17596,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,17596,1,2,0)
 ;;=2^92617
 ;;^UTILITY(U,$J,358.3,17596,1,3,0)
 ;;=3^Flx Fiberop Endosc Swllw Stdy,Laryng,I&R Only
 ;;^UTILITY(U,$J,358.3,17597,0)
 ;;=92507^^92^1101^2^^^^1
 ;;^UTILITY(U,$J,358.3,17597,1,0)
 ;;=^358.31IA^3^2
