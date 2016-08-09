IBDEI0YB ; ; 12-MAY-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,34533,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34533,1,3,0)
 ;;=3^Analgesic Nephropathy
 ;;^UTILITY(U,$J,358.3,34533,1,4,0)
 ;;=4^N14.0
 ;;^UTILITY(U,$J,358.3,34533,2)
 ;;=^5015590
 ;;^UTILITY(U,$J,358.3,34534,0)
 ;;=N15.0^^125^1638^2
 ;;^UTILITY(U,$J,358.3,34534,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34534,1,3,0)
 ;;=3^Balkan Nephropathy
 ;;^UTILITY(U,$J,358.3,34534,1,4,0)
 ;;=4^N15.0
 ;;^UTILITY(U,$J,358.3,34534,2)
 ;;=^12543
 ;;^UTILITY(U,$J,358.3,34535,0)
 ;;=N18.9^^125^1638^3
 ;;^UTILITY(U,$J,358.3,34535,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34535,1,3,0)
 ;;=3^Chr Kidney Disease,Unspec
 ;;^UTILITY(U,$J,358.3,34535,1,4,0)
 ;;=4^N18.9
 ;;^UTILITY(U,$J,358.3,34535,2)
 ;;=^332812
 ;;^UTILITY(U,$J,358.3,34536,0)
 ;;=N28.9^^125^1638^17
 ;;^UTILITY(U,$J,358.3,34536,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34536,1,3,0)
 ;;=3^Kidney/Ureter Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,34536,1,4,0)
 ;;=4^N28.9
 ;;^UTILITY(U,$J,358.3,34536,2)
 ;;=^5015630
 ;;^UTILITY(U,$J,358.3,34537,0)
 ;;=N40.0^^125^1638^4
 ;;^UTILITY(U,$J,358.3,34537,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34537,1,3,0)
 ;;=3^Enlarged Prostate w/o Lower Urinary Tract Symptoms
 ;;^UTILITY(U,$J,358.3,34537,1,4,0)
 ;;=4^N40.0
 ;;^UTILITY(U,$J,358.3,34537,2)
 ;;=^5015689
 ;;^UTILITY(U,$J,358.3,34538,0)
 ;;=N07.6^^125^1638^5
 ;;^UTILITY(U,$J,358.3,34538,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34538,1,3,0)
 ;;=3^Hereditary Nephropathy w/ Dense Deposit Disease NEC
 ;;^UTILITY(U,$J,358.3,34538,1,4,0)
 ;;=4^N07.6
 ;;^UTILITY(U,$J,358.3,34538,2)
 ;;=^5015565
 ;;^UTILITY(U,$J,358.3,34539,0)
 ;;=N07.7^^125^1638^6
 ;;^UTILITY(U,$J,358.3,34539,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34539,1,3,0)
 ;;=3^Hereditary Nephropathy w/ Diffuse Crescentic Glomerular NEC
 ;;^UTILITY(U,$J,358.3,34539,1,4,0)
 ;;=4^N07.7
 ;;^UTILITY(U,$J,358.3,34539,2)
 ;;=^5015566
 ;;^UTILITY(U,$J,358.3,34540,0)
 ;;=N07.1^^125^1638^7
 ;;^UTILITY(U,$J,358.3,34540,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34540,1,3,0)
 ;;=3^Hereditary Nephropathy w/ Focal/Segmental Glomerular Lesions NEC
 ;;^UTILITY(U,$J,358.3,34540,1,4,0)
 ;;=4^N07.1
 ;;^UTILITY(U,$J,358.3,34540,2)
 ;;=^5015560
 ;;^UTILITY(U,$J,358.3,34541,0)
 ;;=N07.0^^125^1638^8
 ;;^UTILITY(U,$J,358.3,34541,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34541,1,3,0)
 ;;=3^Hereditary Nephropathy w/ Minor Glomerular Abnormality NEC
 ;;^UTILITY(U,$J,358.3,34541,1,4,0)
 ;;=4^N07.0
 ;;^UTILITY(U,$J,358.3,34541,2)
 ;;=^5015559
 ;;^UTILITY(U,$J,358.3,34542,0)
 ;;=N07.8^^125^1638^9
 ;;^UTILITY(U,$J,358.3,34542,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34542,1,3,0)
 ;;=3^Hereditary Nephropathy w/ Morphologic Lesions NEC
 ;;^UTILITY(U,$J,358.3,34542,1,4,0)
 ;;=4^N07.8
 ;;^UTILITY(U,$J,358.3,34542,2)
 ;;=^5015567
 ;;^UTILITY(U,$J,358.3,34543,0)
 ;;=N41.9^^125^1638^10
 ;;^UTILITY(U,$J,358.3,34543,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34543,1,3,0)
 ;;=3^Inflammatory Prostate Disease,Unspec
 ;;^UTILITY(U,$J,358.3,34543,1,4,0)
 ;;=4^N41.9
 ;;^UTILITY(U,$J,358.3,34543,2)
 ;;=^5015694
 ;;^UTILITY(U,$J,358.3,34544,0)
 ;;=N06.6^^125^1638^11
 ;;^UTILITY(U,$J,358.3,34544,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34544,1,3,0)
 ;;=3^Isolated Proteinuria w/ Dense Deposit Disease
 ;;^UTILITY(U,$J,358.3,34544,1,4,0)
 ;;=4^N06.6
 ;;^UTILITY(U,$J,358.3,34544,2)
 ;;=^5015555
 ;;^UTILITY(U,$J,358.3,34545,0)
 ;;=N06.7^^125^1638^12
 ;;^UTILITY(U,$J,358.3,34545,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34545,1,3,0)
 ;;=3^Isolated Proteinuria w/ Diffuse Crescentic Glomerulonephritis
 ;;^UTILITY(U,$J,358.3,34545,1,4,0)
 ;;=4^N06.7
 ;;^UTILITY(U,$J,358.3,34545,2)
 ;;=^5015556
 ;;^UTILITY(U,$J,358.3,34546,0)
 ;;=N06.1^^125^1638^13
 ;;^UTILITY(U,$J,358.3,34546,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34546,1,3,0)
 ;;=3^Isolated Proteinuria w/ Focal/Segmental Glomerular Lesions
 ;;^UTILITY(U,$J,358.3,34546,1,4,0)
 ;;=4^N06.1
 ;;^UTILITY(U,$J,358.3,34546,2)
 ;;=^5015550
 ;;^UTILITY(U,$J,358.3,34547,0)
 ;;=N06.0^^125^1638^14
 ;;^UTILITY(U,$J,358.3,34547,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34547,1,3,0)
 ;;=3^Isolated Proteinuria w/ Minor Glomerular Abnormality
 ;;^UTILITY(U,$J,358.3,34547,1,4,0)
 ;;=4^N06.0
 ;;^UTILITY(U,$J,358.3,34547,2)
 ;;=^5015549
 ;;^UTILITY(U,$J,358.3,34548,0)
 ;;=N06.8^^125^1638^15
 ;;^UTILITY(U,$J,358.3,34548,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34548,1,3,0)
 ;;=3^Isolated Proteinuria w/ Morphologic Lesion
 ;;^UTILITY(U,$J,358.3,34548,1,4,0)
 ;;=4^N06.8
 ;;^UTILITY(U,$J,358.3,34548,2)
 ;;=^5015557
 ;;^UTILITY(U,$J,358.3,34549,0)
 ;;=N14.3^^125^1638^24
 ;;^UTILITY(U,$J,358.3,34549,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34549,1,3,0)
 ;;=3^Nephropathy Induced by Heavy Metals
 ;;^UTILITY(U,$J,358.3,34549,1,4,0)
 ;;=4^N14.3
 ;;^UTILITY(U,$J,358.3,34549,2)
 ;;=^5015593
 ;;^UTILITY(U,$J,358.3,34550,0)
 ;;=N14.1^^125^1638^23
 ;;^UTILITY(U,$J,358.3,34550,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34550,1,3,0)
 ;;=3^Nephropathy Induced by Drug/Meds/Biol Subst
 ;;^UTILITY(U,$J,358.3,34550,1,4,0)
 ;;=4^N14.1
 ;;^UTILITY(U,$J,358.3,34550,2)
 ;;=^5015591
 ;;^UTILITY(U,$J,358.3,34551,0)
 ;;=N29.^^125^1638^16
 ;;^UTILITY(U,$J,358.3,34551,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34551,1,3,0)
 ;;=3^Kidney and Ureter Disorders in Diseases Classd Elsewhr
 ;;^UTILITY(U,$J,358.3,34551,1,4,0)
 ;;=4^N29.
 ;;^UTILITY(U,$J,358.3,34551,2)
 ;;=^5015631
 ;;^UTILITY(U,$J,358.3,34552,0)
 ;;=N15.8^^125^1638^25
 ;;^UTILITY(U,$J,358.3,34552,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34552,1,3,0)
 ;;=3^Renal Tubulo-Interstitial Diseases
 ;;^UTILITY(U,$J,358.3,34552,1,4,0)
 ;;=4^N15.8
 ;;^UTILITY(U,$J,358.3,34552,2)
 ;;=^5015595
 ;;^UTILITY(U,$J,358.3,34553,0)
 ;;=N14.4^^125^1638^26
 ;;^UTILITY(U,$J,358.3,34553,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34553,1,3,0)
 ;;=3^Toxic Nephropathy NEC
 ;;^UTILITY(U,$J,358.3,34553,1,4,0)
 ;;=4^N14.4
 ;;^UTILITY(U,$J,358.3,34553,2)
 ;;=^5015594
 ;;^UTILITY(U,$J,358.3,34554,0)
 ;;=N05.6^^125^1638^18
 ;;^UTILITY(U,$J,358.3,34554,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34554,1,3,0)
 ;;=3^Nephritic Syndrome w/ Dense Deposit Disease,Unspec
 ;;^UTILITY(U,$J,358.3,34554,1,4,0)
 ;;=4^N05.6
 ;;^UTILITY(U,$J,358.3,34554,2)
 ;;=^5015547
 ;;^UTILITY(U,$J,358.3,34555,0)
 ;;=N05.7^^125^1638^19
 ;;^UTILITY(U,$J,358.3,34555,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34555,1,3,0)
 ;;=3^Nephritic Syndrome w/ Diffuse Crescentic Glomerulonephritis,Unspec
 ;;^UTILITY(U,$J,358.3,34555,1,4,0)
 ;;=4^N05.7
 ;;^UTILITY(U,$J,358.3,34555,2)
 ;;=^5015548
 ;;^UTILITY(U,$J,358.3,34556,0)
 ;;=N05.1^^125^1638^20
 ;;^UTILITY(U,$J,358.3,34556,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34556,1,3,0)
 ;;=3^Nephritic Syndrome w/ Focal/Segmental Glomerular Lesions,Unspec
 ;;^UTILITY(U,$J,358.3,34556,1,4,0)
 ;;=4^N05.1
 ;;^UTILITY(U,$J,358.3,34556,2)
 ;;=^5015542
 ;;^UTILITY(U,$J,358.3,34557,0)
 ;;=N05.0^^125^1638^21
 ;;^UTILITY(U,$J,358.3,34557,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34557,1,3,0)
 ;;=3^Nephritic Syndrome w/ Minor Glomerular Abnormality,Unspec
 ;;^UTILITY(U,$J,358.3,34557,1,4,0)
 ;;=4^N05.0
 ;;^UTILITY(U,$J,358.3,34557,2)
 ;;=^5015541
 ;;^UTILITY(U,$J,358.3,34558,0)
 ;;=N05.8^^125^1638^22
 ;;^UTILITY(U,$J,358.3,34558,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34558,1,3,0)
 ;;=3^Nephritic Syndrome w/ Morphologic Changes,Unspec
 ;;^UTILITY(U,$J,358.3,34558,1,4,0)
 ;;=4^N05.8
 ;;^UTILITY(U,$J,358.3,34558,2)
 ;;=^5134085
 ;;^UTILITY(U,$J,358.3,34559,0)
 ;;=R59.9^^125^1639^4
 ;;^UTILITY(U,$J,358.3,34559,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34559,1,3,0)
 ;;=3^Enlarged Lymph Nodes,Unspec
 ;;^UTILITY(U,$J,358.3,34559,1,4,0)
 ;;=4^R59.9
 ;;^UTILITY(U,$J,358.3,34559,2)
 ;;=^5019531
