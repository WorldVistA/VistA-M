IBDEI0HC ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,7754,1,4,0)
 ;;=4^E10.29
 ;;^UTILITY(U,$J,358.3,7754,2)
 ;;=^5002591
 ;;^UTILITY(U,$J,358.3,7755,0)
 ;;=E10.21^^52^519^15
 ;;^UTILITY(U,$J,358.3,7755,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7755,1,3,0)
 ;;=3^Type 1 DM w/ Diabetic Nephropathy
 ;;^UTILITY(U,$J,358.3,7755,1,4,0)
 ;;=4^E10.21
 ;;^UTILITY(U,$J,358.3,7755,2)
 ;;=^5002589
 ;;^UTILITY(U,$J,358.3,7756,0)
 ;;=E10.22^^52^519^14
 ;;^UTILITY(U,$J,358.3,7756,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7756,1,3,0)
 ;;=3^Type 1 DM w/ Diabetic CKD
 ;;^UTILITY(U,$J,358.3,7756,1,4,0)
 ;;=4^E10.22
 ;;^UTILITY(U,$J,358.3,7756,2)
 ;;=^5002590
 ;;^UTILITY(U,$J,358.3,7757,0)
 ;;=D59.3^^52^519^3
 ;;^UTILITY(U,$J,358.3,7757,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7757,1,3,0)
 ;;=3^Hemolytic-uremic syndrome
 ;;^UTILITY(U,$J,358.3,7757,1,4,0)
 ;;=4^D59.3
 ;;^UTILITY(U,$J,358.3,7757,2)
 ;;=^55823
 ;;^UTILITY(U,$J,358.3,7758,0)
 ;;=D69.0^^52^519^4
 ;;^UTILITY(U,$J,358.3,7758,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7758,1,3,0)
 ;;=3^Henoch-Schoeniein Purpura
 ;;^UTILITY(U,$J,358.3,7758,1,4,0)
 ;;=4^D69.0
 ;;^UTILITY(U,$J,358.3,7758,2)
 ;;=^5002365
 ;;^UTILITY(U,$J,358.3,7759,0)
 ;;=M30.0^^52^519^11
 ;;^UTILITY(U,$J,358.3,7759,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7759,1,3,0)
 ;;=3^Polyarteritis nodosa
 ;;^UTILITY(U,$J,358.3,7759,1,4,0)
 ;;=4^M30.0
 ;;^UTILITY(U,$J,358.3,7759,2)
 ;;=^5011738
 ;;^UTILITY(U,$J,358.3,7760,0)
 ;;=M31.0^^52^519^5
 ;;^UTILITY(U,$J,358.3,7760,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7760,1,3,0)
 ;;=3^Hypersensitivity angiitis
 ;;^UTILITY(U,$J,358.3,7760,1,4,0)
 ;;=4^M31.0
 ;;^UTILITY(U,$J,358.3,7760,2)
 ;;=^60279
 ;;^UTILITY(U,$J,358.3,7761,0)
 ;;=M31.31^^52^519^20
 ;;^UTILITY(U,$J,358.3,7761,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7761,1,3,0)
 ;;=3^Wegener's granulomatosis w/ renal involvement
 ;;^UTILITY(U,$J,358.3,7761,1,4,0)
 ;;=4^M31.31
 ;;^UTILITY(U,$J,358.3,7761,2)
 ;;=^5011745
 ;;^UTILITY(U,$J,358.3,7762,0)
 ;;=E85.8^^52^519^1
 ;;^UTILITY(U,$J,358.3,7762,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7762,1,3,0)
 ;;=3^Amyloidosis,Other
 ;;^UTILITY(U,$J,358.3,7762,1,4,0)
 ;;=4^E85.8
 ;;^UTILITY(U,$J,358.3,7762,2)
 ;;=^334034
 ;;^UTILITY(U,$J,358.3,7763,0)
 ;;=N28.89^^52^519^6
 ;;^UTILITY(U,$J,358.3,7763,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7763,1,3,0)
 ;;=3^Kidney & Ureter Disorders,Oth Specified
 ;;^UTILITY(U,$J,358.3,7763,1,4,0)
 ;;=4^N28.89
 ;;^UTILITY(U,$J,358.3,7763,2)
 ;;=^88007
 ;;^UTILITY(U,$J,358.3,7764,0)
 ;;=E85.4^^52^519^10
 ;;^UTILITY(U,$J,358.3,7764,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7764,1,3,0)
 ;;=3^Organ-limited amyloidosis
 ;;^UTILITY(U,$J,358.3,7764,1,4,0)
 ;;=4^E85.4
 ;;^UTILITY(U,$J,358.3,7764,2)
 ;;=^5003017
 ;;^UTILITY(U,$J,358.3,7765,0)
 ;;=M32.14^^52^519^2
 ;;^UTILITY(U,$J,358.3,7765,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7765,1,3,0)
 ;;=3^Glomerular disease in systemic lupus erythematosus
 ;;^UTILITY(U,$J,358.3,7765,1,4,0)
 ;;=4^M32.14
 ;;^UTILITY(U,$J,358.3,7765,2)
 ;;=^5011757
 ;;^UTILITY(U,$J,358.3,7766,0)
 ;;=M32.15^^52^519^13
 ;;^UTILITY(U,$J,358.3,7766,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7766,1,3,0)
 ;;=3^Tubulo-interstitial neuropathy in SLE
 ;;^UTILITY(U,$J,358.3,7766,1,4,0)
 ;;=4^M32.15
 ;;^UTILITY(U,$J,358.3,7766,2)
 ;;=^5011758
 ;;^UTILITY(U,$J,358.3,7767,0)
 ;;=M34.0^^52^519^12
 ;;^UTILITY(U,$J,358.3,7767,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7767,1,3,0)
 ;;=3^Progressive systemic sclerosis
 ;;^UTILITY(U,$J,358.3,7767,1,4,0)
 ;;=4^M34.0
 ;;^UTILITY(U,$J,358.3,7767,2)
 ;;=^5011778
 ;;^UTILITY(U,$J,358.3,7768,0)
 ;;=Z87.442^^52^520^1
