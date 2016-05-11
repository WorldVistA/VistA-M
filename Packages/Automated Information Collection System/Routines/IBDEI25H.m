IBDEI25H ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,36481,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36481,1,3,0)
 ;;=3^Chr Kidney Disease,Unspec
 ;;^UTILITY(U,$J,358.3,36481,1,4,0)
 ;;=4^N18.9
 ;;^UTILITY(U,$J,358.3,36481,2)
 ;;=^332812
 ;;^UTILITY(U,$J,358.3,36482,0)
 ;;=N28.9^^137^1764^17
 ;;^UTILITY(U,$J,358.3,36482,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36482,1,3,0)
 ;;=3^Kidney/Ureter Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,36482,1,4,0)
 ;;=4^N28.9
 ;;^UTILITY(U,$J,358.3,36482,2)
 ;;=^5015630
 ;;^UTILITY(U,$J,358.3,36483,0)
 ;;=N40.0^^137^1764^4
 ;;^UTILITY(U,$J,358.3,36483,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36483,1,3,0)
 ;;=3^Enlarged Prostate w/o Lower Urinary Tract Symptoms
 ;;^UTILITY(U,$J,358.3,36483,1,4,0)
 ;;=4^N40.0
 ;;^UTILITY(U,$J,358.3,36483,2)
 ;;=^5015689
 ;;^UTILITY(U,$J,358.3,36484,0)
 ;;=N07.6^^137^1764^5
 ;;^UTILITY(U,$J,358.3,36484,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36484,1,3,0)
 ;;=3^Hereditary Nephropathy w/ Dense Deposit Disease NEC
 ;;^UTILITY(U,$J,358.3,36484,1,4,0)
 ;;=4^N07.6
 ;;^UTILITY(U,$J,358.3,36484,2)
 ;;=^5015565
 ;;^UTILITY(U,$J,358.3,36485,0)
 ;;=N07.7^^137^1764^6
 ;;^UTILITY(U,$J,358.3,36485,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36485,1,3,0)
 ;;=3^Hereditary Nephropathy w/ Diffuse Crescentic Glomerular NEC
 ;;^UTILITY(U,$J,358.3,36485,1,4,0)
 ;;=4^N07.7
 ;;^UTILITY(U,$J,358.3,36485,2)
 ;;=^5015566
 ;;^UTILITY(U,$J,358.3,36486,0)
 ;;=N07.1^^137^1764^7
 ;;^UTILITY(U,$J,358.3,36486,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36486,1,3,0)
 ;;=3^Hereditary Nephropathy w/ Focal/Segmental Glomerular Lesions NEC
 ;;^UTILITY(U,$J,358.3,36486,1,4,0)
 ;;=4^N07.1
 ;;^UTILITY(U,$J,358.3,36486,2)
 ;;=^5015560
 ;;^UTILITY(U,$J,358.3,36487,0)
 ;;=N07.0^^137^1764^8
 ;;^UTILITY(U,$J,358.3,36487,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36487,1,3,0)
 ;;=3^Hereditary Nephropathy w/ Minor Glomerular Abnormality NEC
 ;;^UTILITY(U,$J,358.3,36487,1,4,0)
 ;;=4^N07.0
 ;;^UTILITY(U,$J,358.3,36487,2)
 ;;=^5015559
 ;;^UTILITY(U,$J,358.3,36488,0)
 ;;=N07.8^^137^1764^9
 ;;^UTILITY(U,$J,358.3,36488,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36488,1,3,0)
 ;;=3^Hereditary Nephropathy w/ Morphologic Lesions NEC
 ;;^UTILITY(U,$J,358.3,36488,1,4,0)
 ;;=4^N07.8
 ;;^UTILITY(U,$J,358.3,36488,2)
 ;;=^5015567
 ;;^UTILITY(U,$J,358.3,36489,0)
 ;;=N41.9^^137^1764^10
 ;;^UTILITY(U,$J,358.3,36489,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36489,1,3,0)
 ;;=3^Inflammatory Prostate Disease,Unspec
 ;;^UTILITY(U,$J,358.3,36489,1,4,0)
 ;;=4^N41.9
 ;;^UTILITY(U,$J,358.3,36489,2)
 ;;=^5015694
 ;;^UTILITY(U,$J,358.3,36490,0)
 ;;=N06.6^^137^1764^11
 ;;^UTILITY(U,$J,358.3,36490,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36490,1,3,0)
 ;;=3^Isolated Proteinuria w/ Dense Deposit Disease
 ;;^UTILITY(U,$J,358.3,36490,1,4,0)
 ;;=4^N06.6
 ;;^UTILITY(U,$J,358.3,36490,2)
 ;;=^5015555
 ;;^UTILITY(U,$J,358.3,36491,0)
 ;;=N06.7^^137^1764^12
 ;;^UTILITY(U,$J,358.3,36491,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36491,1,3,0)
 ;;=3^Isolated Proteinuria w/ Diffuse Crescentic Glomerulonephritis
 ;;^UTILITY(U,$J,358.3,36491,1,4,0)
 ;;=4^N06.7
 ;;^UTILITY(U,$J,358.3,36491,2)
 ;;=^5015556
 ;;^UTILITY(U,$J,358.3,36492,0)
 ;;=N06.1^^137^1764^13
 ;;^UTILITY(U,$J,358.3,36492,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36492,1,3,0)
 ;;=3^Isolated Proteinuria w/ Focal/Segmental Glomerular Lesions
 ;;^UTILITY(U,$J,358.3,36492,1,4,0)
 ;;=4^N06.1
 ;;^UTILITY(U,$J,358.3,36492,2)
 ;;=^5015550
 ;;^UTILITY(U,$J,358.3,36493,0)
 ;;=N06.0^^137^1764^14
 ;;^UTILITY(U,$J,358.3,36493,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36493,1,3,0)
 ;;=3^Isolated Proteinuria w/ Minor Glomerular Abnormality
