IBDEI0H4 ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,7654,1,3,0)
 ;;=3^AKI,Other
 ;;^UTILITY(U,$J,358.3,7654,1,4,0)
 ;;=4^N17.8
 ;;^UTILITY(U,$J,358.3,7654,2)
 ;;=^5015601
 ;;^UTILITY(U,$J,358.3,7655,0)
 ;;=N17.9^^52^517^5
 ;;^UTILITY(U,$J,358.3,7655,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7655,1,3,0)
 ;;=3^AKI,Unspec
 ;;^UTILITY(U,$J,358.3,7655,1,4,0)
 ;;=4^N17.9
 ;;^UTILITY(U,$J,358.3,7655,2)
 ;;=^338532
 ;;^UTILITY(U,$J,358.3,7656,0)
 ;;=R39.2^^52^517^15
 ;;^UTILITY(U,$J,358.3,7656,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7656,1,3,0)
 ;;=3^Pre-Renal Uremia
 ;;^UTILITY(U,$J,358.3,7656,1,4,0)
 ;;=4^R39.2
 ;;^UTILITY(U,$J,358.3,7656,2)
 ;;=^5019348
 ;;^UTILITY(U,$J,358.3,7657,0)
 ;;=N13.9^^52^517^14
 ;;^UTILITY(U,$J,358.3,7657,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7657,1,3,0)
 ;;=3^Obstructive and Reflux Uropathy,Unspec
 ;;^UTILITY(U,$J,358.3,7657,1,4,0)
 ;;=4^N13.9
 ;;^UTILITY(U,$J,358.3,7657,2)
 ;;=^5015589
 ;;^UTILITY(U,$J,358.3,7658,0)
 ;;=N13.1^^52^517^11
 ;;^UTILITY(U,$J,358.3,7658,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7658,1,3,0)
 ;;=3^Hydronephrosis w/ Ureteral Stricture NEC
 ;;^UTILITY(U,$J,358.3,7658,1,4,0)
 ;;=4^N13.1
 ;;^UTILITY(U,$J,358.3,7658,2)
 ;;=^5015576
 ;;^UTILITY(U,$J,358.3,7659,0)
 ;;=N13.2^^52^517^10
 ;;^UTILITY(U,$J,358.3,7659,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7659,1,3,0)
 ;;=3^Hydronephrosis w/ Renal and Ureteral Calculous Obstruction
 ;;^UTILITY(U,$J,358.3,7659,1,4,0)
 ;;=4^N13.2
 ;;^UTILITY(U,$J,358.3,7659,2)
 ;;=^5015577
 ;;^UTILITY(U,$J,358.3,7660,0)
 ;;=N13.30^^52^517^13
 ;;^UTILITY(U,$J,358.3,7660,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7660,1,3,0)
 ;;=3^Hydronephrosis,Unspec
 ;;^UTILITY(U,$J,358.3,7660,1,4,0)
 ;;=4^N13.30
 ;;^UTILITY(U,$J,358.3,7660,2)
 ;;=^5015578
 ;;^UTILITY(U,$J,358.3,7661,0)
 ;;=N13.39^^52^517^12
 ;;^UTILITY(U,$J,358.3,7661,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7661,1,3,0)
 ;;=3^Hydronephrosis,Other
 ;;^UTILITY(U,$J,358.3,7661,1,4,0)
 ;;=4^N13.39
 ;;^UTILITY(U,$J,358.3,7661,2)
 ;;=^5015579
 ;;^UTILITY(U,$J,358.3,7662,0)
 ;;=R33.9^^52^517^16
 ;;^UTILITY(U,$J,358.3,7662,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7662,1,3,0)
 ;;=3^Urinary Retention,Unspec
 ;;^UTILITY(U,$J,358.3,7662,1,4,0)
 ;;=4^R33.9
 ;;^UTILITY(U,$J,358.3,7662,2)
 ;;=^5019332
 ;;^UTILITY(U,$J,358.3,7663,0)
 ;;=I75.81^^52^517^8
 ;;^UTILITY(U,$J,358.3,7663,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7663,1,3,0)
 ;;=3^Atheroembolism of Kidney
 ;;^UTILITY(U,$J,358.3,7663,1,4,0)
 ;;=4^I75.81
 ;;^UTILITY(U,$J,358.3,7663,2)
 ;;=^328516
 ;;^UTILITY(U,$J,358.3,7664,0)
 ;;=R34.^^52^517^7
 ;;^UTILITY(U,$J,358.3,7664,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7664,1,3,0)
 ;;=3^Anuria and Oliguria
 ;;^UTILITY(U,$J,358.3,7664,1,4,0)
 ;;=4^R34.
 ;;^UTILITY(U,$J,358.3,7664,2)
 ;;=^5019333
 ;;^UTILITY(U,$J,358.3,7665,0)
 ;;=K76.7^^52^517^9
 ;;^UTILITY(U,$J,358.3,7665,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7665,1,3,0)
 ;;=3^Hepatorenal Syndrome
 ;;^UTILITY(U,$J,358.3,7665,1,4,0)
 ;;=4^K76.7
 ;;^UTILITY(U,$J,358.3,7665,2)
 ;;=^56497
 ;;^UTILITY(U,$J,358.3,7666,0)
 ;;=N00.0^^52^518^8
 ;;^UTILITY(U,$J,358.3,7666,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7666,1,3,0)
 ;;=3^Acute nephritic syndrome w/ minor glomerular abnormality
 ;;^UTILITY(U,$J,358.3,7666,1,4,0)
 ;;=4^N00.0
 ;;^UTILITY(U,$J,358.3,7666,2)
 ;;=^5015491
 ;;^UTILITY(U,$J,358.3,7667,0)
 ;;=N00.1^^52^518^7
 ;;^UTILITY(U,$J,358.3,7667,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7667,1,3,0)
 ;;=3^Acute nephritic syndrome w/ focal and segmental glomerular lesions
 ;;^UTILITY(U,$J,358.3,7667,1,4,0)
 ;;=4^N00.1
