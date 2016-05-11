IBDEI0IM ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,8649,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,8649,1,2,0)
 ;;=2^Serial Tonometry
 ;;^UTILITY(U,$J,358.3,8649,1,3,0)
 ;;=3^92100
 ;;^UTILITY(U,$J,358.3,8650,0)
 ;;=76519^^40^467^1^^^^1
 ;;^UTILITY(U,$J,358.3,8650,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,8650,1,2,0)
 ;;=2^A-Scan,One Eye w/ Ocu Lens Power Calc
 ;;^UTILITY(U,$J,358.3,8650,1,3,0)
 ;;=3^76519
 ;;^UTILITY(U,$J,358.3,8651,0)
 ;;=76512^^40^467^3^^^^1
 ;;^UTILITY(U,$J,358.3,8651,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,8651,1,2,0)
 ;;=2^B-Scan one eye
 ;;^UTILITY(U,$J,358.3,8651,1,3,0)
 ;;=3^76512
 ;;^UTILITY(U,$J,358.3,8652,0)
 ;;=92226^^40^467^8^^^^1
 ;;^UTILITY(U,$J,358.3,8652,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,8652,1,2,0)
 ;;=2^Ext Ophthalmoscopy, Subseq
 ;;^UTILITY(U,$J,358.3,8652,1,3,0)
 ;;=3^92226
 ;;^UTILITY(U,$J,358.3,8653,0)
 ;;=92060^^40^467^20^^^^1
 ;;^UTILITY(U,$J,358.3,8653,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,8653,1,2,0)
 ;;=2^Sensorimotor Exam
 ;;^UTILITY(U,$J,358.3,8653,1,3,0)
 ;;=3^92060
 ;;^UTILITY(U,$J,358.3,8654,0)
 ;;=92240^^40^467^15^^^^1
 ;;^UTILITY(U,$J,358.3,8654,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,8654,1,2,0)
 ;;=2^ICG Angiography
 ;;^UTILITY(U,$J,358.3,8654,1,3,0)
 ;;=3^92240
 ;;^UTILITY(U,$J,358.3,8655,0)
 ;;=92065^^40^467^16^^^^1
 ;;^UTILITY(U,$J,358.3,8655,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,8655,1,2,0)
 ;;=2^Orthoptic/Pleoptic Training
 ;;^UTILITY(U,$J,358.3,8655,1,3,0)
 ;;=3^92065
 ;;^UTILITY(U,$J,358.3,8656,0)
 ;;=G0118^^40^467^13^^^^1
 ;;^UTILITY(U,$J,358.3,8656,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,8656,1,2,0)
 ;;=2^Glaucoma Screen by Tech
 ;;^UTILITY(U,$J,358.3,8656,1,3,0)
 ;;=3^G0118
 ;;^UTILITY(U,$J,358.3,8657,0)
 ;;=S9150^^40^467^7^^^^1
 ;;^UTILITY(U,$J,358.3,8657,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,8657,1,2,0)
 ;;=2^Evaluation by ocularist
 ;;^UTILITY(U,$J,358.3,8657,1,3,0)
 ;;=3^S9150
 ;;^UTILITY(U,$J,358.3,8658,0)
 ;;=76514^^40^467^5^^^^1
 ;;^UTILITY(U,$J,358.3,8658,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,8658,1,2,0)
 ;;=2^Corneal Pachymetry
 ;;^UTILITY(U,$J,358.3,8658,1,3,0)
 ;;=3^76514
 ;;^UTILITY(U,$J,358.3,8659,0)
 ;;=87809^^40^467^2^^^^1
 ;;^UTILITY(U,$J,358.3,8659,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,8659,1,2,0)
 ;;=2^Adenovirus Assay w/ Optic
 ;;^UTILITY(U,$J,358.3,8659,1,3,0)
 ;;=3^87809
 ;;^UTILITY(U,$J,358.3,8660,0)
 ;;=76513^^40^467^4^^^^1
 ;;^UTILITY(U,$J,358.3,8660,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,8660,1,2,0)
 ;;=2^B-Scan,Ant Segmnt,Water Immersion
 ;;^UTILITY(U,$J,358.3,8660,1,3,0)
 ;;=3^76513
 ;;^UTILITY(U,$J,358.3,8661,0)
 ;;=92132^^40^467^17^^^^1
 ;;^UTILITY(U,$J,358.3,8661,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,8661,1,2,0)
 ;;=2^Scan Comp Dx Imag,Ant Segmt w/ Int & Rpt
 ;;^UTILITY(U,$J,358.3,8661,1,3,0)
 ;;=3^92132
 ;;^UTILITY(U,$J,358.3,8662,0)
 ;;=92133^^40^467^18^^^^1
 ;;^UTILITY(U,$J,358.3,8662,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,8662,1,2,0)
 ;;=2^Scan Comp Dx Imag,Pstr w/ Int & Rpt,Optic Nrv
 ;;^UTILITY(U,$J,358.3,8662,1,3,0)
 ;;=3^92133
 ;;^UTILITY(U,$J,358.3,8663,0)
 ;;=92134^^40^467^19^^^^1
 ;;^UTILITY(U,$J,358.3,8663,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,8663,1,2,0)
 ;;=2^Scan Comp Dx Imag,Pstr w/ Int & Rpt,Retina
 ;;^UTILITY(U,$J,358.3,8663,1,3,0)
 ;;=3^92134
 ;;^UTILITY(U,$J,358.3,8664,0)
 ;;=B02.33^^41^468^164
 ;;^UTILITY(U,$J,358.3,8664,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8664,1,3,0)
 ;;=3^Zoster Keratitis
 ;;^UTILITY(U,$J,358.3,8664,1,4,0)
 ;;=4^B02.33
 ;;^UTILITY(U,$J,358.3,8664,2)
 ;;=^5000496
 ;;^UTILITY(U,$J,358.3,8665,0)
 ;;=B02.32^^41^468^163
