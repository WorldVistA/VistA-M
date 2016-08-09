IBDEI09X ; ; 12-MAY-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,9931,1,3,0)
 ;;=3^Traumatic Glaucoma,Right Eye,Indeterminate Stage
 ;;^UTILITY(U,$J,358.3,9931,1,4,0)
 ;;=4^H40.31X4
 ;;^UTILITY(U,$J,358.3,9931,2)
 ;;=^5005855
 ;;^UTILITY(U,$J,358.3,9932,0)
 ;;=H40.32X0^^51^583^133
 ;;^UTILITY(U,$J,358.3,9932,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9932,1,3,0)
 ;;=3^Traumatic Glaucoma,Left Eye,Unspec Stage
 ;;^UTILITY(U,$J,358.3,9932,1,4,0)
 ;;=4^H40.32X0
 ;;^UTILITY(U,$J,358.3,9932,2)
 ;;=^5005856
 ;;^UTILITY(U,$J,358.3,9933,0)
 ;;=H40.32X1^^51^583^130
 ;;^UTILITY(U,$J,358.3,9933,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9933,1,3,0)
 ;;=3^Traumatic Glaucoma,Left Eye,Mild Stage
 ;;^UTILITY(U,$J,358.3,9933,1,4,0)
 ;;=4^H40.32X1
 ;;^UTILITY(U,$J,358.3,9933,2)
 ;;=^5005857
 ;;^UTILITY(U,$J,358.3,9934,0)
 ;;=H40.32X2^^51^583^131
 ;;^UTILITY(U,$J,358.3,9934,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9934,1,3,0)
 ;;=3^Traumatic Glaucoma,Left Eye,Moderate Stage
 ;;^UTILITY(U,$J,358.3,9934,1,4,0)
 ;;=4^H40.32X2
 ;;^UTILITY(U,$J,358.3,9934,2)
 ;;=^5005858
 ;;^UTILITY(U,$J,358.3,9935,0)
 ;;=H40.32X3^^51^583^132
 ;;^UTILITY(U,$J,358.3,9935,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9935,1,3,0)
 ;;=3^Traumatic Glaucoma,Left Eye,Severe Stage
 ;;^UTILITY(U,$J,358.3,9935,1,4,0)
 ;;=4^H40.32X3
 ;;^UTILITY(U,$J,358.3,9935,2)
 ;;=^5133504
 ;;^UTILITY(U,$J,358.3,9936,0)
 ;;=H40.32X4^^51^583^129
 ;;^UTILITY(U,$J,358.3,9936,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9936,1,3,0)
 ;;=3^Traumatic Glaucoma,Left Eye,Indeterminate Stage
 ;;^UTILITY(U,$J,358.3,9936,1,4,0)
 ;;=4^H40.32X4
 ;;^UTILITY(U,$J,358.3,9936,2)
 ;;=^5005859
 ;;^UTILITY(U,$J,358.3,9937,0)
 ;;=H40.33X0^^51^583^128
 ;;^UTILITY(U,$J,358.3,9937,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9937,1,3,0)
 ;;=3^Traumatic Glaucoma,Bilateral,Unspec Stage
 ;;^UTILITY(U,$J,358.3,9937,1,4,0)
 ;;=4^H40.33X0
 ;;^UTILITY(U,$J,358.3,9937,2)
 ;;=^5005860
 ;;^UTILITY(U,$J,358.3,9938,0)
 ;;=H40.33X1^^51^583^125
 ;;^UTILITY(U,$J,358.3,9938,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9938,1,3,0)
 ;;=3^Traumatic Glaucoma,Bilateral,Mild Stage
 ;;^UTILITY(U,$J,358.3,9938,1,4,0)
 ;;=4^H40.33X1
 ;;^UTILITY(U,$J,358.3,9938,2)
 ;;=^5005861
 ;;^UTILITY(U,$J,358.3,9939,0)
 ;;=H40.33X2^^51^583^126
 ;;^UTILITY(U,$J,358.3,9939,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9939,1,3,0)
 ;;=3^Traumatic Glaucoma,Bilateral,Moderate Stage
 ;;^UTILITY(U,$J,358.3,9939,1,4,0)
 ;;=4^H40.33X2
 ;;^UTILITY(U,$J,358.3,9939,2)
 ;;=^5005862
 ;;^UTILITY(U,$J,358.3,9940,0)
 ;;=H40.33X3^^51^583^127
 ;;^UTILITY(U,$J,358.3,9940,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9940,1,3,0)
 ;;=3^Traumatic Glaucoma,Bilateral,Severe Stage
 ;;^UTILITY(U,$J,358.3,9940,1,4,0)
 ;;=4^H40.33X3
 ;;^UTILITY(U,$J,358.3,9940,2)
 ;;=^5005863
 ;;^UTILITY(U,$J,358.3,9941,0)
 ;;=H40.33X4^^51^583^124
 ;;^UTILITY(U,$J,358.3,9941,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9941,1,3,0)
 ;;=3^Traumatic Glaucoma,Bilateral,Indeterminate Stage
 ;;^UTILITY(U,$J,358.3,9941,1,4,0)
 ;;=4^H40.33X4
 ;;^UTILITY(U,$J,358.3,9941,2)
 ;;=^5005864
 ;;^UTILITY(U,$J,358.3,9942,0)
 ;;=H21.233^^51^583^26
 ;;^UTILITY(U,$J,358.3,9942,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9942,1,3,0)
 ;;=3^Degeneration of Iris,Bilateral
 ;;^UTILITY(U,$J,358.3,9942,1,4,0)
 ;;=4^H21.233
 ;;^UTILITY(U,$J,358.3,9942,2)
 ;;=^5005189
 ;;^UTILITY(U,$J,358.3,9943,0)
 ;;=H40.61X1^^51^583^40
 ;;^UTILITY(U,$J,358.3,9943,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9943,1,3,0)
 ;;=3^Drug-Induced Glaucoma,Right Eye,Mild Stage
 ;;^UTILITY(U,$J,358.3,9943,1,4,0)
 ;;=4^H40.61X1
 ;;^UTILITY(U,$J,358.3,9943,2)
 ;;=^5005907
 ;;^UTILITY(U,$J,358.3,9944,0)
 ;;=H40.013^^51^583^59
 ;;^UTILITY(U,$J,358.3,9944,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9944,1,3,0)
 ;;=3^Glaucoma Suspect/Open Angle w/ Borderline Findings,Low Risk,Bilateral
 ;;^UTILITY(U,$J,358.3,9944,1,4,0)
 ;;=4^H40.013
 ;;^UTILITY(U,$J,358.3,9944,2)
 ;;=^5005726
 ;;^UTILITY(U,$J,358.3,9945,0)
 ;;=H40.012^^51^583^60
 ;;^UTILITY(U,$J,358.3,9945,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9945,1,3,0)
 ;;=3^Glaucoma Suspect/Open Angle w/ Borderline Findings,Low Risk,Left Eye
 ;;^UTILITY(U,$J,358.3,9945,1,4,0)
 ;;=4^H40.012
 ;;^UTILITY(U,$J,358.3,9945,2)
 ;;=^5005725
 ;;^UTILITY(U,$J,358.3,9946,0)
 ;;=H40.011^^51^583^61
 ;;^UTILITY(U,$J,358.3,9946,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9946,1,3,0)
 ;;=3^Glaucoma Suspect/Open Angle w/ Borderline Findings,Low Risk,Right Eye
 ;;^UTILITY(U,$J,358.3,9946,1,4,0)
 ;;=4^H40.011
 ;;^UTILITY(U,$J,358.3,9946,2)
 ;;=^5005724
 ;;^UTILITY(U,$J,358.3,9947,0)
 ;;=H40.023^^51^583^84
 ;;^UTILITY(U,$J,358.3,9947,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9947,1,3,0)
 ;;=3^Open-Angle w/ Borderline Findings,Hi Risk,Bilateral
 ;;^UTILITY(U,$J,358.3,9947,1,4,0)
 ;;=4^H40.023
 ;;^UTILITY(U,$J,358.3,9947,2)
 ;;=^5005730
 ;;^UTILITY(U,$J,358.3,9948,0)
 ;;=H40.063^^51^583^108
 ;;^UTILITY(U,$J,358.3,9948,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9948,1,3,0)
 ;;=3^Primary Angle-Closure w/o Glaucoma Damage,Bilateral
 ;;^UTILITY(U,$J,358.3,9948,1,4,0)
 ;;=4^H40.063
 ;;^UTILITY(U,$J,358.3,9948,2)
 ;;=^5005746
 ;;^UTILITY(U,$J,358.3,9949,0)
 ;;=H40.243^^51^583^113
 ;;^UTILITY(U,$J,358.3,9949,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9949,1,3,0)
 ;;=3^Residual Stage Angle-Closure Glaucoma,Bilateral
 ;;^UTILITY(U,$J,358.3,9949,1,4,0)
 ;;=4^H40.243
 ;;^UTILITY(U,$J,358.3,9949,2)
 ;;=^5005845
 ;;^UTILITY(U,$J,358.3,9950,0)
 ;;=H40.043^^51^583^121
 ;;^UTILITY(U,$J,358.3,9950,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9950,1,3,0)
 ;;=3^Steroid Responder,Bilateral
 ;;^UTILITY(U,$J,358.3,9950,1,4,0)
 ;;=4^H40.043
 ;;^UTILITY(U,$J,358.3,9950,2)
 ;;=^5005738
 ;;^UTILITY(U,$J,358.3,9951,0)
 ;;=B02.39^^51^584^10
 ;;^UTILITY(U,$J,358.3,9951,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9951,1,3,0)
 ;;=3^Herpes Zoster Eye Disease NEC
 ;;^UTILITY(U,$J,358.3,9951,1,4,0)
 ;;=4^B02.39
 ;;^UTILITY(U,$J,358.3,9951,2)
 ;;=^5000498
 ;;^UTILITY(U,$J,358.3,9952,0)
 ;;=B00.59^^51^584^9
 ;;^UTILITY(U,$J,358.3,9952,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9952,1,3,0)
 ;;=3^Herpes Viral Eye Disease NEC
 ;;^UTILITY(U,$J,358.3,9952,1,4,0)
 ;;=4^B00.59
 ;;^UTILITY(U,$J,358.3,9952,2)
 ;;=^5000476
 ;;^UTILITY(U,$J,358.3,9953,0)
 ;;=B25.9^^51^584^8
 ;;^UTILITY(U,$J,358.3,9953,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9953,1,3,0)
 ;;=3^Cytomegaloviral Disease,Unspec
 ;;^UTILITY(U,$J,358.3,9953,1,4,0)
 ;;=4^B25.9
 ;;^UTILITY(U,$J,358.3,9953,2)
 ;;=^5000560
 ;;^UTILITY(U,$J,358.3,9954,0)
 ;;=H32.^^51^584^6
 ;;^UTILITY(U,$J,358.3,9954,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9954,1,3,0)
 ;;=3^Chorioretinal Disorders in Diseases Classified Elsewhere
 ;;^UTILITY(U,$J,358.3,9954,1,4,0)
 ;;=4^H32.
 ;;^UTILITY(U,$J,358.3,9954,2)
 ;;=^5005489
 ;;^UTILITY(U,$J,358.3,9955,0)
 ;;=B39.9^^51^584^11
 ;;^UTILITY(U,$J,358.3,9955,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9955,1,3,0)
 ;;=3^Histoplasmosis,Unspec
 ;;^UTILITY(U,$J,358.3,9955,1,4,0)
 ;;=4^B39.9
 ;;^UTILITY(U,$J,358.3,9955,2)
 ;;=^5000638
 ;;^UTILITY(U,$J,358.3,9956,0)
 ;;=B83.0^^51^584^25
 ;;^UTILITY(U,$J,358.3,9956,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9956,1,3,0)
 ;;=3^Visceral Larva Migrans
 ;;^UTILITY(U,$J,358.3,9956,1,4,0)
 ;;=4^B83.0
 ;;^UTILITY(U,$J,358.3,9956,2)
 ;;=^5000799
 ;;^UTILITY(U,$J,358.3,9957,0)
 ;;=B58.01^^51^584^24
 ;;^UTILITY(U,$J,358.3,9957,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9957,1,3,0)
 ;;=3^Toxoplasma Chorioretinitis
 ;;^UTILITY(U,$J,358.3,9957,1,4,0)
 ;;=4^B58.01
 ;;^UTILITY(U,$J,358.3,9957,2)
 ;;=^5000724
 ;;^UTILITY(U,$J,358.3,9958,0)
 ;;=H44.001^^51^584^22
 ;;^UTILITY(U,$J,358.3,9958,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9958,1,3,0)
 ;;=3^Purulent Endophthalmitis,Right Eye,Unspec
 ;;^UTILITY(U,$J,358.3,9958,1,4,0)
 ;;=4^H44.001
