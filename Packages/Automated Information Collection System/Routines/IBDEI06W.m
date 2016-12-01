IBDEI06W ; ; 09-AUG-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,8629,2)
 ;;=^5005740
 ;;^UTILITY(U,$J,358.3,8630,0)
 ;;=H40.052^^31^463^2
 ;;^UTILITY(U,$J,358.3,8630,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8630,1,3,0)
 ;;=3^Ocular Hypertension,Left Eye
 ;;^UTILITY(U,$J,358.3,8630,1,4,0)
 ;;=4^H40.052
 ;;^UTILITY(U,$J,358.3,8630,2)
 ;;=^5005741
 ;;^UTILITY(U,$J,358.3,8631,0)
 ;;=H40.053^^31^463^3
 ;;^UTILITY(U,$J,358.3,8631,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8631,1,3,0)
 ;;=3^Ocular Hypertension,Bilateral
 ;;^UTILITY(U,$J,358.3,8631,1,4,0)
 ;;=4^H40.053
 ;;^UTILITY(U,$J,358.3,8631,2)
 ;;=^5005742
 ;;^UTILITY(U,$J,358.3,8632,0)
 ;;=H40.011^^31^463^4
 ;;^UTILITY(U,$J,358.3,8632,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8632,1,3,0)
 ;;=3^Glaucoma Suspect,Low Risk,Right Eye
 ;;^UTILITY(U,$J,358.3,8632,1,4,0)
 ;;=4^H40.011
 ;;^UTILITY(U,$J,358.3,8632,2)
 ;;=^5005724
 ;;^UTILITY(U,$J,358.3,8633,0)
 ;;=H40.012^^31^463^5
 ;;^UTILITY(U,$J,358.3,8633,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8633,1,3,0)
 ;;=3^Glaucoma Suspect,Low Risk,Left Eye
 ;;^UTILITY(U,$J,358.3,8633,1,4,0)
 ;;=4^H40.012
 ;;^UTILITY(U,$J,358.3,8633,2)
 ;;=^5005725
 ;;^UTILITY(U,$J,358.3,8634,0)
 ;;=H40.013^^31^463^6
 ;;^UTILITY(U,$J,358.3,8634,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8634,1,3,0)
 ;;=3^Glaucoma Suspect,Low Risk,Bilateral
 ;;^UTILITY(U,$J,358.3,8634,1,4,0)
 ;;=4^H40.013
 ;;^UTILITY(U,$J,358.3,8634,2)
 ;;=^5005726
 ;;^UTILITY(U,$J,358.3,8635,0)
 ;;=H40.023^^31^463^7
 ;;^UTILITY(U,$J,358.3,8635,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8635,1,3,0)
 ;;=3^Glaucoma Suspect,High Risk,Bilateral
 ;;^UTILITY(U,$J,358.3,8635,1,4,0)
 ;;=4^H40.023
 ;;^UTILITY(U,$J,358.3,8635,2)
 ;;=^5005730
 ;;^UTILITY(U,$J,358.3,8636,0)
 ;;=H40.11X1^^31^463^8
 ;;^UTILITY(U,$J,358.3,8636,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8636,1,3,0)
 ;;=3^Primary Open-Angle Glaucoma,Mild Stage
 ;;^UTILITY(U,$J,358.3,8636,1,4,0)
 ;;=4^H40.11X1
 ;;^UTILITY(U,$J,358.3,8636,2)
 ;;=^5005754
 ;;^UTILITY(U,$J,358.3,8637,0)
 ;;=H40.11X2^^31^463^9
 ;;^UTILITY(U,$J,358.3,8637,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8637,1,3,0)
 ;;=3^Primary Open-Angle Glaucoma,Moderate Stage
 ;;^UTILITY(U,$J,358.3,8637,1,4,0)
 ;;=4^H40.11X2
 ;;^UTILITY(U,$J,358.3,8637,2)
 ;;=^5005755
 ;;^UTILITY(U,$J,358.3,8638,0)
 ;;=H40.11X3^^31^463^10
 ;;^UTILITY(U,$J,358.3,8638,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8638,1,3,0)
 ;;=3^Primary Open-Angle Glaucoma,Severe Stage
 ;;^UTILITY(U,$J,358.3,8638,1,4,0)
 ;;=4^H40.11X3
 ;;^UTILITY(U,$J,358.3,8638,2)
 ;;=^5005756
 ;;^UTILITY(U,$J,358.3,8639,0)
 ;;=H40.1211^^31^463^11
 ;;^UTILITY(U,$J,358.3,8639,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8639,1,3,0)
 ;;=3^Low-Tension Glaucoma,Mild,Right Eye
 ;;^UTILITY(U,$J,358.3,8639,1,4,0)
 ;;=4^H40.1211
 ;;^UTILITY(U,$J,358.3,8639,2)
 ;;=^5005759
 ;;^UTILITY(U,$J,358.3,8640,0)
 ;;=H40.1221^^31^463^12
 ;;^UTILITY(U,$J,358.3,8640,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8640,1,3,0)
 ;;=3^Low-Tension Glaucoma,Mild,Left Eye
 ;;^UTILITY(U,$J,358.3,8640,1,4,0)
 ;;=4^H40.1221
 ;;^UTILITY(U,$J,358.3,8640,2)
 ;;=^5005764
 ;;^UTILITY(U,$J,358.3,8641,0)
 ;;=H40.1231^^31^463^13
 ;;^UTILITY(U,$J,358.3,8641,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8641,1,3,0)
 ;;=3^Low-Tension Glaucoma,Mild,Bilateral
 ;;^UTILITY(U,$J,358.3,8641,1,4,0)
 ;;=4^H40.1231
 ;;^UTILITY(U,$J,358.3,8641,2)
 ;;=^5005768
 ;;^UTILITY(U,$J,358.3,8642,0)
 ;;=H40.1233^^31^463^14
 ;;^UTILITY(U,$J,358.3,8642,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8642,1,3,0)
 ;;=3^Low-Tension Glaucoma,Severe,Bilateral
 ;;^UTILITY(U,$J,358.3,8642,1,4,0)
 ;;=4^H40.1233
 ;;^UTILITY(U,$J,358.3,8642,2)
 ;;=^5005770
 ;;^UTILITY(U,$J,358.3,8643,0)
 ;;=H47.231^^31^463^15
 ;;^UTILITY(U,$J,358.3,8643,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8643,1,3,0)
 ;;=3^Glaucomatous Optic Atrophy,Right Eye
 ;;^UTILITY(U,$J,358.3,8643,1,4,0)
 ;;=4^H47.231
 ;;^UTILITY(U,$J,358.3,8643,2)
 ;;=^5006131
 ;;^UTILITY(U,$J,358.3,8644,0)
 ;;=H47.232^^31^463^16
 ;;^UTILITY(U,$J,358.3,8644,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8644,1,3,0)
 ;;=3^Glaucomatous Optic Atrophy,Left Eye
 ;;^UTILITY(U,$J,358.3,8644,1,4,0)
 ;;=4^H47.232
 ;;^UTILITY(U,$J,358.3,8644,2)
 ;;=^5006132
 ;;^UTILITY(U,$J,358.3,8645,0)
 ;;=H47.233^^31^463^17
 ;;^UTILITY(U,$J,358.3,8645,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8645,1,3,0)
 ;;=3^Glaucomatous Optic Atrophy,Bilateral
 ;;^UTILITY(U,$J,358.3,8645,1,4,0)
 ;;=4^H47.233
 ;;^UTILITY(U,$J,358.3,8645,2)
 ;;=^5006133
 ;;^UTILITY(U,$J,358.3,8646,0)
 ;;=H40.011^^31^463^18
 ;;^UTILITY(U,$J,358.3,8646,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8646,1,3,0)
 ;;=3^Open Angle w/ Boderline Findings,Low Risk,Right Eye
 ;;^UTILITY(U,$J,358.3,8646,1,4,0)
 ;;=4^H40.011
 ;;^UTILITY(U,$J,358.3,8646,2)
 ;;=^5005724
 ;;^UTILITY(U,$J,358.3,8647,0)
 ;;=H40.012^^31^463^19
 ;;^UTILITY(U,$J,358.3,8647,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8647,1,3,0)
 ;;=3^Open Angle w/ Boderline Findings,Low Risk,Left Eye
 ;;^UTILITY(U,$J,358.3,8647,1,4,0)
 ;;=4^H40.012
 ;;^UTILITY(U,$J,358.3,8647,2)
 ;;=^5005725
 ;;^UTILITY(U,$J,358.3,8648,0)
 ;;=H40.013^^31^463^20
 ;;^UTILITY(U,$J,358.3,8648,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8648,1,3,0)
 ;;=3^Open Angle w/ Boderline Findings,Low Risk,Bilateral
 ;;^UTILITY(U,$J,358.3,8648,1,4,0)
 ;;=4^H40.013
 ;;^UTILITY(U,$J,358.3,8648,2)
 ;;=^5005726
 ;;^UTILITY(U,$J,358.3,8649,0)
 ;;=H40.023^^31^463^21
 ;;^UTILITY(U,$J,358.3,8649,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8649,1,3,0)
 ;;=3^Open Angle w/ Boderline Findings,High Risk,Bilateral
 ;;^UTILITY(U,$J,358.3,8649,1,4,0)
 ;;=4^H40.023
 ;;^UTILITY(U,$J,358.3,8649,2)
 ;;=^5005730
 ;;^UTILITY(U,$J,358.3,8650,0)
 ;;=Z83.511^^31^463^22
 ;;^UTILITY(U,$J,358.3,8650,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8650,1,3,0)
 ;;=3^Family Hx of Glaucoma
 ;;^UTILITY(U,$J,358.3,8650,1,4,0)
 ;;=4^Z83.511
 ;;^UTILITY(U,$J,358.3,8650,2)
 ;;=^5063382
 ;;^UTILITY(U,$J,358.3,8651,0)
 ;;=H59.41^^31^463^23
 ;;^UTILITY(U,$J,358.3,8651,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8651,1,3,0)
 ;;=3^Blebitis,Stage 1
 ;;^UTILITY(U,$J,358.3,8651,1,4,0)
 ;;=4^H59.41
 ;;^UTILITY(U,$J,358.3,8651,2)
 ;;=^5006426
 ;;^UTILITY(U,$J,358.3,8652,0)
 ;;=H59.42^^31^463^24
 ;;^UTILITY(U,$J,358.3,8652,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8652,1,3,0)
 ;;=3^Blebitis,Stage 2
 ;;^UTILITY(U,$J,358.3,8652,1,4,0)
 ;;=4^H59.42
 ;;^UTILITY(U,$J,358.3,8652,2)
 ;;=^5006427
 ;;^UTILITY(U,$J,358.3,8653,0)
 ;;=H59.43^^31^463^25
 ;;^UTILITY(U,$J,358.3,8653,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8653,1,3,0)
 ;;=3^Blebitis,Stage 3
 ;;^UTILITY(U,$J,358.3,8653,1,4,0)
 ;;=4^H59.43
 ;;^UTILITY(U,$J,358.3,8653,2)
 ;;=^5006428
 ;;^UTILITY(U,$J,358.3,8654,0)
 ;;=H40.031^^31^464^1
 ;;^UTILITY(U,$J,358.3,8654,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8654,1,3,0)
 ;;=3^Anatomical Narrow Angle,Right Eye
 ;;^UTILITY(U,$J,358.3,8654,1,4,0)
 ;;=4^H40.031
 ;;^UTILITY(U,$J,358.3,8654,2)
 ;;=^5005732
 ;;^UTILITY(U,$J,358.3,8655,0)
 ;;=H40.032^^31^464^2
 ;;^UTILITY(U,$J,358.3,8655,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8655,1,3,0)
 ;;=3^Anatomical Narrow Angle,Left Eye
 ;;^UTILITY(U,$J,358.3,8655,1,4,0)
 ;;=4^H40.032
 ;;^UTILITY(U,$J,358.3,8655,2)
 ;;=^5005733
 ;;^UTILITY(U,$J,358.3,8656,0)
 ;;=H40.033^^31^464^3
 ;;^UTILITY(U,$J,358.3,8656,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8656,1,3,0)
 ;;=3^Anatomical Narrow Angle,Bilateral
 ;;^UTILITY(U,$J,358.3,8656,1,4,0)
 ;;=4^H40.033
 ;;^UTILITY(U,$J,358.3,8656,2)
 ;;=^5005734
 ;;^UTILITY(U,$J,358.3,8657,0)
 ;;=H40.061^^31^464^4
 ;;^UTILITY(U,$J,358.3,8657,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8657,1,3,0)
 ;;=3^Primary Angle Closure w/o Damage,Right Eye
 ;;^UTILITY(U,$J,358.3,8657,1,4,0)
 ;;=4^H40.061
 ;;^UTILITY(U,$J,358.3,8657,2)
 ;;=^5005744
 ;;^UTILITY(U,$J,358.3,8658,0)
 ;;=H40.062^^31^464^5
 ;;^UTILITY(U,$J,358.3,8658,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8658,1,3,0)
 ;;=3^Primary Angle Closure w/o Damage,Left Eye
 ;;^UTILITY(U,$J,358.3,8658,1,4,0)
 ;;=4^H40.062
 ;;^UTILITY(U,$J,358.3,8658,2)
 ;;=^5005745
 ;;^UTILITY(U,$J,358.3,8659,0)
 ;;=H40.063^^31^464^6
 ;;^UTILITY(U,$J,358.3,8659,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8659,1,3,0)
 ;;=3^Primary Angle Closure w/o Damage,Bilateral
 ;;^UTILITY(U,$J,358.3,8659,1,4,0)
 ;;=4^H40.063
 ;;^UTILITY(U,$J,358.3,8659,2)
 ;;=^5005746
 ;;^UTILITY(U,$J,358.3,8660,0)
 ;;=H40.20X1^^31^464^7
 ;;^UTILITY(U,$J,358.3,8660,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8660,1,3,0)
 ;;=3^Angle-Closure Glaucoma,Primary,Mild Stage
 ;;^UTILITY(U,$J,358.3,8660,1,4,0)
 ;;=4^H40.20X1
 ;;^UTILITY(U,$J,358.3,8660,2)
 ;;=^5005814
 ;;^UTILITY(U,$J,358.3,8661,0)
 ;;=H40.20X2^^31^464^8
 ;;^UTILITY(U,$J,358.3,8661,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8661,1,3,0)
 ;;=3^Angle-Closure Glaucoma,Primary,Moderate Stage
 ;;^UTILITY(U,$J,358.3,8661,1,4,0)
 ;;=4^H40.20X2
 ;;^UTILITY(U,$J,358.3,8661,2)
 ;;=^5005815
 ;;^UTILITY(U,$J,358.3,8662,0)
 ;;=H40.20X3^^31^464^9
 ;;^UTILITY(U,$J,358.3,8662,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8662,1,3,0)
 ;;=3^Angle-Closure Glaucoma,Primary,Severe Stage
 ;;^UTILITY(U,$J,358.3,8662,1,4,0)
 ;;=4^H40.20X3
 ;;^UTILITY(U,$J,358.3,8662,2)
 ;;=^5005816
 ;;^UTILITY(U,$J,358.3,8663,0)
 ;;=H40.2211^^31^464^10
 ;;^UTILITY(U,$J,358.3,8663,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8663,1,3,0)
 ;;=3^Angle-Closure Glaucoma,Chronic,Mild,Right Eye
 ;;^UTILITY(U,$J,358.3,8663,1,4,0)
 ;;=4^H40.2211
 ;;^UTILITY(U,$J,358.3,8663,2)
 ;;=^5005823
 ;;^UTILITY(U,$J,358.3,8664,0)
 ;;=H40.2221^^31^464^11
 ;;^UTILITY(U,$J,358.3,8664,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8664,1,3,0)
 ;;=3^Angle-Closure Glaucoma,Chronic,Mild,Left Eye
 ;;^UTILITY(U,$J,358.3,8664,1,4,0)
 ;;=4^H40.2221
 ;;^UTILITY(U,$J,358.3,8664,2)
 ;;=^5005828
 ;;^UTILITY(U,$J,358.3,8665,0)
 ;;=H40.2231^^31^464^12
 ;;^UTILITY(U,$J,358.3,8665,1,0)
 ;;=^358.31IA^4^2
