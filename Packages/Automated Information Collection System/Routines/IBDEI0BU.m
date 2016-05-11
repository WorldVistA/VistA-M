IBDEI0BU ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,5356,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5356,1,3,0)
 ;;=3^Type 2 DM w/ Oth Diabetic Kidney Complications
 ;;^UTILITY(U,$J,358.3,5356,1,4,0)
 ;;=4^E11.29
 ;;^UTILITY(U,$J,358.3,5356,2)
 ;;=^5002631
 ;;^UTILITY(U,$J,358.3,5357,0)
 ;;=E11.21^^27^345^19
 ;;^UTILITY(U,$J,358.3,5357,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5357,1,3,0)
 ;;=3^Type 2 DM w/ Diabetic nephropathy
 ;;^UTILITY(U,$J,358.3,5357,1,4,0)
 ;;=4^E11.21
 ;;^UTILITY(U,$J,358.3,5357,2)
 ;;=^5002629
 ;;^UTILITY(U,$J,358.3,5358,0)
 ;;=E11.22^^27^345^18
 ;;^UTILITY(U,$J,358.3,5358,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5358,1,3,0)
 ;;=3^Type 2 DM w/ Diabetic CKD
 ;;^UTILITY(U,$J,358.3,5358,1,4,0)
 ;;=4^E11.22
 ;;^UTILITY(U,$J,358.3,5358,2)
 ;;=^5002630
 ;;^UTILITY(U,$J,358.3,5359,0)
 ;;=E10.29^^27^345^17
 ;;^UTILITY(U,$J,358.3,5359,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5359,1,3,0)
 ;;=3^Type 1 DM w/ Oth Diabetic Kidney Complications
 ;;^UTILITY(U,$J,358.3,5359,1,4,0)
 ;;=4^E10.29
 ;;^UTILITY(U,$J,358.3,5359,2)
 ;;=^5002591
 ;;^UTILITY(U,$J,358.3,5360,0)
 ;;=E10.21^^27^345^16
 ;;^UTILITY(U,$J,358.3,5360,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5360,1,3,0)
 ;;=3^Type 1 DM w/ Diabetic Nephropathy
 ;;^UTILITY(U,$J,358.3,5360,1,4,0)
 ;;=4^E10.21
 ;;^UTILITY(U,$J,358.3,5360,2)
 ;;=^5002589
 ;;^UTILITY(U,$J,358.3,5361,0)
 ;;=E10.22^^27^345^15
 ;;^UTILITY(U,$J,358.3,5361,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5361,1,3,0)
 ;;=3^Type 1 DM w/ Diabetic CKD
 ;;^UTILITY(U,$J,358.3,5361,1,4,0)
 ;;=4^E10.22
 ;;^UTILITY(U,$J,358.3,5361,2)
 ;;=^5002590
 ;;^UTILITY(U,$J,358.3,5362,0)
 ;;=D59.3^^27^345^3
 ;;^UTILITY(U,$J,358.3,5362,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5362,1,3,0)
 ;;=3^Hemolytic-uremic syndrome
 ;;^UTILITY(U,$J,358.3,5362,1,4,0)
 ;;=4^D59.3
 ;;^UTILITY(U,$J,358.3,5362,2)
 ;;=^55823
 ;;^UTILITY(U,$J,358.3,5363,0)
 ;;=D69.0^^27^345^4
 ;;^UTILITY(U,$J,358.3,5363,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5363,1,3,0)
 ;;=3^Henoch-Schoeniein Purpura
 ;;^UTILITY(U,$J,358.3,5363,1,4,0)
 ;;=4^D69.0
 ;;^UTILITY(U,$J,358.3,5363,2)
 ;;=^5002365
 ;;^UTILITY(U,$J,358.3,5364,0)
 ;;=M30.0^^27^345^11
 ;;^UTILITY(U,$J,358.3,5364,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5364,1,3,0)
 ;;=3^Polyarteritis nodosa
 ;;^UTILITY(U,$J,358.3,5364,1,4,0)
 ;;=4^M30.0
 ;;^UTILITY(U,$J,358.3,5364,2)
 ;;=^5011738
 ;;^UTILITY(U,$J,358.3,5365,0)
 ;;=M31.0^^27^345^5
 ;;^UTILITY(U,$J,358.3,5365,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5365,1,3,0)
 ;;=3^Hypersensitivity angiitis
 ;;^UTILITY(U,$J,358.3,5365,1,4,0)
 ;;=4^M31.0
 ;;^UTILITY(U,$J,358.3,5365,2)
 ;;=^60279
 ;;^UTILITY(U,$J,358.3,5366,0)
 ;;=M31.31^^27^345^21
 ;;^UTILITY(U,$J,358.3,5366,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5366,1,3,0)
 ;;=3^Wegener's granulomatosis w/ renal involvement
 ;;^UTILITY(U,$J,358.3,5366,1,4,0)
 ;;=4^M31.31
 ;;^UTILITY(U,$J,358.3,5366,2)
 ;;=^5011745
 ;;^UTILITY(U,$J,358.3,5367,0)
 ;;=E85.8^^27^345^1
 ;;^UTILITY(U,$J,358.3,5367,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5367,1,3,0)
 ;;=3^Amyloidosis,Other
 ;;^UTILITY(U,$J,358.3,5367,1,4,0)
 ;;=4^E85.8
 ;;^UTILITY(U,$J,358.3,5367,2)
 ;;=^334034
 ;;^UTILITY(U,$J,358.3,5368,0)
 ;;=N28.89^^27^345^6
 ;;^UTILITY(U,$J,358.3,5368,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5368,1,3,0)
 ;;=3^Kidney & Ureter Disorders,Oth Specified
 ;;^UTILITY(U,$J,358.3,5368,1,4,0)
 ;;=4^N28.89
 ;;^UTILITY(U,$J,358.3,5368,2)
 ;;=^88007
 ;;^UTILITY(U,$J,358.3,5369,0)
 ;;=E85.4^^27^345^10
 ;;^UTILITY(U,$J,358.3,5369,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5369,1,3,0)
 ;;=3^Organ-limited amyloidosis
