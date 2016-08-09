IBDEI060 ; ; 12-MAY-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,5806,1,3,0)
 ;;=3^Diabetes Type 1 w/ Diabetic Ophthalmic Complication NEC
 ;;^UTILITY(U,$J,358.3,5806,1,4,0)
 ;;=4^E10.39
 ;;^UTILITY(U,$J,358.3,5806,2)
 ;;=^5002603
 ;;^UTILITY(U,$J,358.3,5807,0)
 ;;=E10.10^^36^407^37
 ;;^UTILITY(U,$J,358.3,5807,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5807,1,3,0)
 ;;=3^Diabetes Type 1 w/ Ketoacidosis w/o Coma
 ;;^UTILITY(U,$J,358.3,5807,1,4,0)
 ;;=4^E10.10
 ;;^UTILITY(U,$J,358.3,5807,2)
 ;;=^5002587
 ;;^UTILITY(U,$J,358.3,5808,0)
 ;;=E10.21^^36^407^22
 ;;^UTILITY(U,$J,358.3,5808,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5808,1,3,0)
 ;;=3^Diabetes Type 1 w/ Diabetic Nephropathy
 ;;^UTILITY(U,$J,358.3,5808,1,4,0)
 ;;=4^E10.21
 ;;^UTILITY(U,$J,358.3,5808,2)
 ;;=^5002589
 ;;^UTILITY(U,$J,358.3,5809,0)
 ;;=E10.311^^36^407^30
 ;;^UTILITY(U,$J,358.3,5809,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5809,1,3,0)
 ;;=3^Diabetes Type 1 w/ Diabetic Retinopathy w/ Macular Edema
 ;;^UTILITY(U,$J,358.3,5809,1,4,0)
 ;;=4^E10.311
 ;;^UTILITY(U,$J,358.3,5809,2)
 ;;=^5002592
 ;;^UTILITY(U,$J,358.3,5810,0)
 ;;=E10.319^^36^407^31
 ;;^UTILITY(U,$J,358.3,5810,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5810,1,3,0)
 ;;=3^Diabetes Type 1 w/ Diabetic Retinopathy w/o Macular Edema
 ;;^UTILITY(U,$J,358.3,5810,1,4,0)
 ;;=4^E10.319
 ;;^UTILITY(U,$J,358.3,5810,2)
 ;;=^5002593
 ;;^UTILITY(U,$J,358.3,5811,0)
 ;;=E10.321^^36^407^38
 ;;^UTILITY(U,$J,358.3,5811,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5811,1,3,0)
 ;;=3^Diabetes Type 1 w/ Mild Nonprlf Diabetic Retinopathy w/ Macular Edema
 ;;^UTILITY(U,$J,358.3,5811,1,4,0)
 ;;=4^E10.321
 ;;^UTILITY(U,$J,358.3,5811,2)
 ;;=^5002594
 ;;^UTILITY(U,$J,358.3,5812,0)
 ;;=E10.329^^36^407^39
 ;;^UTILITY(U,$J,358.3,5812,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5812,1,3,0)
 ;;=3^Diabetes Type 1 w/ Mild Nonprlf Diabetic Retinopathy w/o Macular Edema
 ;;^UTILITY(U,$J,358.3,5812,1,4,0)
 ;;=4^E10.329
 ;;^UTILITY(U,$J,358.3,5812,2)
 ;;=^5002595
 ;;^UTILITY(U,$J,358.3,5813,0)
 ;;=E10.341^^36^407^46
 ;;^UTILITY(U,$J,358.3,5813,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5813,1,3,0)
 ;;=3^Diabetes Type 1 w/ Severe Nonprlf Diabetic Retinopathy w/ Macular Edema
 ;;^UTILITY(U,$J,358.3,5813,1,4,0)
 ;;=4^E10.341
 ;;^UTILITY(U,$J,358.3,5813,2)
 ;;=^5002598
 ;;^UTILITY(U,$J,358.3,5814,0)
 ;;=E10.349^^36^407^47
 ;;^UTILITY(U,$J,358.3,5814,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5814,1,3,0)
 ;;=3^Diabetes Type 1 w/ Severe Nonprlf Diabetic Retinopathy w/o Macular Edema
 ;;^UTILITY(U,$J,358.3,5814,1,4,0)
 ;;=4^E10.349
 ;;^UTILITY(U,$J,358.3,5814,2)
 ;;=^5002599
 ;;^UTILITY(U,$J,358.3,5815,0)
 ;;=E10.51^^36^407^27
 ;;^UTILITY(U,$J,358.3,5815,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5815,1,3,0)
 ;;=3^Diabetes Type 1 w/ Diabetic Peripheral Angiopathy w/o Gangrene
 ;;^UTILITY(U,$J,358.3,5815,1,4,0)
 ;;=4^E10.51
 ;;^UTILITY(U,$J,358.3,5815,2)
 ;;=^5002610
 ;;^UTILITY(U,$J,358.3,5816,0)
 ;;=E10.52^^36^407^28
 ;;^UTILITY(U,$J,358.3,5816,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5816,1,3,0)
 ;;=3^Diabetes Type 1 w/ Diabetic Peripheral Angiopathy w/ Gangrene
 ;;^UTILITY(U,$J,358.3,5816,1,4,0)
 ;;=4^E10.52
 ;;^UTILITY(U,$J,358.3,5816,2)
 ;;=^5002611
 ;;^UTILITY(U,$J,358.3,5817,0)
 ;;=E10.622^^36^407^49
 ;;^UTILITY(U,$J,358.3,5817,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5817,1,3,0)
 ;;=3^Diabetes Type 1 w/ Skin Ulcer NEC
 ;;^UTILITY(U,$J,358.3,5817,1,4,0)
 ;;=4^E10.622
 ;;^UTILITY(U,$J,358.3,5817,2)
 ;;=^5002617
 ;;^UTILITY(U,$J,358.3,5818,0)
 ;;=E10.628^^36^407^48
 ;;^UTILITY(U,$J,358.3,5818,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5818,1,3,0)
 ;;=3^Diabetes Type 1 w/ Skin Complication NEC
 ;;^UTILITY(U,$J,358.3,5818,1,4,0)
 ;;=4^E10.628
 ;;^UTILITY(U,$J,358.3,5818,2)
 ;;=^5002618
 ;;^UTILITY(U,$J,358.3,5819,0)
 ;;=E10.630^^36^407^43
 ;;^UTILITY(U,$J,358.3,5819,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5819,1,3,0)
 ;;=3^Diabetes Type 1 w/ Periodontal Disease
 ;;^UTILITY(U,$J,358.3,5819,1,4,0)
 ;;=4^E10.630
 ;;^UTILITY(U,$J,358.3,5819,2)
 ;;=^5002619
 ;;^UTILITY(U,$J,358.3,5820,0)
 ;;=E10.638^^36^407^42
 ;;^UTILITY(U,$J,358.3,5820,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5820,1,3,0)
 ;;=3^Diabetes Type 1 w/ Oral Complication NEC
 ;;^UTILITY(U,$J,358.3,5820,1,4,0)
 ;;=4^E10.638
 ;;^UTILITY(U,$J,358.3,5820,2)
 ;;=^5002620
 ;;^UTILITY(U,$J,358.3,5821,0)
 ;;=E10.649^^36^407^35
 ;;^UTILITY(U,$J,358.3,5821,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5821,1,3,0)
 ;;=3^Diabetes Type 1 w/ Hypoglycemia w/o Coma
 ;;^UTILITY(U,$J,358.3,5821,1,4,0)
 ;;=4^E10.649
 ;;^UTILITY(U,$J,358.3,5821,2)
 ;;=^5002622
 ;;^UTILITY(U,$J,358.3,5822,0)
 ;;=E10.65^^36^407^33
 ;;^UTILITY(U,$J,358.3,5822,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5822,1,3,0)
 ;;=3^Diabetes Type 1 w/ Hyperglycemia
 ;;^UTILITY(U,$J,358.3,5822,1,4,0)
 ;;=4^E10.65
 ;;^UTILITY(U,$J,358.3,5822,2)
 ;;=^5002623
 ;;^UTILITY(U,$J,358.3,5823,0)
 ;;=E10.8^^36^407^51
 ;;^UTILITY(U,$J,358.3,5823,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5823,1,3,0)
 ;;=3^Diabetes Type 1 w/ Unspec Complications
 ;;^UTILITY(U,$J,358.3,5823,1,4,0)
 ;;=4^E10.8
 ;;^UTILITY(U,$J,358.3,5823,2)
 ;;=^5002625
 ;;^UTILITY(U,$J,358.3,5824,0)
 ;;=99201^^37^408^1
 ;;^UTILITY(U,$J,358.3,5824,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,5824,1,1,0)
 ;;=1^Problem Focus
 ;;^UTILITY(U,$J,358.3,5824,1,2,0)
 ;;=2^99201
 ;;^UTILITY(U,$J,358.3,5825,0)
 ;;=99202^^37^408^2
 ;;^UTILITY(U,$J,358.3,5825,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,5825,1,1,0)
 ;;=1^Expanded Problem Focus
 ;;^UTILITY(U,$J,358.3,5825,1,2,0)
 ;;=2^99202
 ;;^UTILITY(U,$J,358.3,5826,0)
 ;;=99203^^37^408^3
 ;;^UTILITY(U,$J,358.3,5826,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,5826,1,1,0)
 ;;=1^Detailed
 ;;^UTILITY(U,$J,358.3,5826,1,2,0)
 ;;=2^99203
 ;;^UTILITY(U,$J,358.3,5827,0)
 ;;=99204^^37^408^4
 ;;^UTILITY(U,$J,358.3,5827,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,5827,1,1,0)
 ;;=1^Comprehensive, Moderate
 ;;^UTILITY(U,$J,358.3,5827,1,2,0)
 ;;=2^99204
 ;;^UTILITY(U,$J,358.3,5828,0)
 ;;=99205^^37^408^5
 ;;^UTILITY(U,$J,358.3,5828,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,5828,1,1,0)
 ;;=1^Comprehensive, High
 ;;^UTILITY(U,$J,358.3,5828,1,2,0)
 ;;=2^99205
 ;;^UTILITY(U,$J,358.3,5829,0)
 ;;=99211^^37^409^1
 ;;^UTILITY(U,$J,358.3,5829,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,5829,1,1,0)
 ;;=1^Brief Visit
 ;;^UTILITY(U,$J,358.3,5829,1,2,0)
 ;;=2^99211
 ;;^UTILITY(U,$J,358.3,5830,0)
 ;;=99212^^37^409^2
 ;;^UTILITY(U,$J,358.3,5830,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,5830,1,1,0)
 ;;=1^Problem Focus
 ;;^UTILITY(U,$J,358.3,5830,1,2,0)
 ;;=2^99212
 ;;^UTILITY(U,$J,358.3,5831,0)
 ;;=99213^^37^409^3
 ;;^UTILITY(U,$J,358.3,5831,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,5831,1,1,0)
 ;;=1^Expanded Problem Focus
 ;;^UTILITY(U,$J,358.3,5831,1,2,0)
 ;;=2^99213
 ;;^UTILITY(U,$J,358.3,5832,0)
 ;;=99214^^37^409^4
 ;;^UTILITY(U,$J,358.3,5832,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,5832,1,1,0)
 ;;=1^Detailed
 ;;^UTILITY(U,$J,358.3,5832,1,2,0)
 ;;=2^99214
 ;;^UTILITY(U,$J,358.3,5833,0)
 ;;=99215^^37^409^5
 ;;^UTILITY(U,$J,358.3,5833,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,5833,1,1,0)
 ;;=1^Comprehensive
 ;;^UTILITY(U,$J,358.3,5833,1,2,0)
 ;;=2^99215
 ;;^UTILITY(U,$J,358.3,5834,0)
 ;;=99241^^37^410^1
 ;;^UTILITY(U,$J,358.3,5834,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,5834,1,1,0)
 ;;=1^Problem Focus
 ;;^UTILITY(U,$J,358.3,5834,1,2,0)
 ;;=2^99241
 ;;^UTILITY(U,$J,358.3,5835,0)
 ;;=99242^^37^410^2
 ;;^UTILITY(U,$J,358.3,5835,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,5835,1,1,0)
 ;;=1^Expanded Problem Focus
 ;;^UTILITY(U,$J,358.3,5835,1,2,0)
 ;;=2^99242
 ;;^UTILITY(U,$J,358.3,5836,0)
 ;;=99243^^37^410^3
 ;;^UTILITY(U,$J,358.3,5836,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,5836,1,1,0)
 ;;=1^Detailed
