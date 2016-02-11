IBDEI2RR ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,46487,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,46487,1,3,0)
 ;;=3^Gastrointestinal Hemorrhage,Unspec
 ;;^UTILITY(U,$J,358.3,46487,1,4,0)
 ;;=4^K92.2
 ;;^UTILITY(U,$J,358.3,46487,2)
 ;;=^5008915
 ;;^UTILITY(U,$J,358.3,46488,0)
 ;;=K27.9^^206^2300^3
 ;;^UTILITY(U,$J,358.3,46488,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,46488,1,3,0)
 ;;=3^Peptic Ulcer w/o Hemorrhage/Perforation,Unspec Site
 ;;^UTILITY(U,$J,358.3,46488,1,4,0)
 ;;=4^K27.9
 ;;^UTILITY(U,$J,358.3,46488,2)
 ;;=^5008536
 ;;^UTILITY(U,$J,358.3,46489,0)
 ;;=K46.9^^206^2300^1
 ;;^UTILITY(U,$J,358.3,46489,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,46489,1,3,0)
 ;;=3^Abdominal Hernia w/o Obstruction/Gangrene,Unspec
 ;;^UTILITY(U,$J,358.3,46489,1,4,0)
 ;;=4^K46.9
 ;;^UTILITY(U,$J,358.3,46489,2)
 ;;=^5008623
 ;;^UTILITY(U,$J,358.3,46490,0)
 ;;=N14.0^^206^2301^1
 ;;^UTILITY(U,$J,358.3,46490,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,46490,1,3,0)
 ;;=3^Analgesic Nephropathy
 ;;^UTILITY(U,$J,358.3,46490,1,4,0)
 ;;=4^N14.0
 ;;^UTILITY(U,$J,358.3,46490,2)
 ;;=^5015590
 ;;^UTILITY(U,$J,358.3,46491,0)
 ;;=N15.0^^206^2301^2
 ;;^UTILITY(U,$J,358.3,46491,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,46491,1,3,0)
 ;;=3^Balkan Nephropathy
 ;;^UTILITY(U,$J,358.3,46491,1,4,0)
 ;;=4^N15.0
 ;;^UTILITY(U,$J,358.3,46491,2)
 ;;=^12543
 ;;^UTILITY(U,$J,358.3,46492,0)
 ;;=N18.9^^206^2301^3
 ;;^UTILITY(U,$J,358.3,46492,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,46492,1,3,0)
 ;;=3^Chr Kidney Disease,Unspec
 ;;^UTILITY(U,$J,358.3,46492,1,4,0)
 ;;=4^N18.9
 ;;^UTILITY(U,$J,358.3,46492,2)
 ;;=^332812
 ;;^UTILITY(U,$J,358.3,46493,0)
 ;;=N28.9^^206^2301^17
 ;;^UTILITY(U,$J,358.3,46493,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,46493,1,3,0)
 ;;=3^Kidney/Ureter Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,46493,1,4,0)
 ;;=4^N28.9
 ;;^UTILITY(U,$J,358.3,46493,2)
 ;;=^5015630
 ;;^UTILITY(U,$J,358.3,46494,0)
 ;;=N40.0^^206^2301^4
 ;;^UTILITY(U,$J,358.3,46494,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,46494,1,3,0)
 ;;=3^Enlarged Prostate w/o Lower Urinary Tract Symptoms
 ;;^UTILITY(U,$J,358.3,46494,1,4,0)
 ;;=4^N40.0
 ;;^UTILITY(U,$J,358.3,46494,2)
 ;;=^5015689
 ;;^UTILITY(U,$J,358.3,46495,0)
 ;;=N07.6^^206^2301^5
 ;;^UTILITY(U,$J,358.3,46495,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,46495,1,3,0)
 ;;=3^Hereditary Nephropathy w/ Dense Deposit Disease NEC
 ;;^UTILITY(U,$J,358.3,46495,1,4,0)
 ;;=4^N07.6
 ;;^UTILITY(U,$J,358.3,46495,2)
 ;;=^5015565
 ;;^UTILITY(U,$J,358.3,46496,0)
 ;;=N07.7^^206^2301^6
 ;;^UTILITY(U,$J,358.3,46496,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,46496,1,3,0)
 ;;=3^Hereditary Nephropathy w/ Diffuse Crescentic Glomerular NEC
 ;;^UTILITY(U,$J,358.3,46496,1,4,0)
 ;;=4^N07.7
 ;;^UTILITY(U,$J,358.3,46496,2)
 ;;=^5015566
 ;;^UTILITY(U,$J,358.3,46497,0)
 ;;=N07.1^^206^2301^7
 ;;^UTILITY(U,$J,358.3,46497,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,46497,1,3,0)
 ;;=3^Hereditary Nephropathy w/ Focal/Segmental Glomerular Lesions NEC
 ;;^UTILITY(U,$J,358.3,46497,1,4,0)
 ;;=4^N07.1
 ;;^UTILITY(U,$J,358.3,46497,2)
 ;;=^5015560
 ;;^UTILITY(U,$J,358.3,46498,0)
 ;;=N07.0^^206^2301^8
 ;;^UTILITY(U,$J,358.3,46498,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,46498,1,3,0)
 ;;=3^Hereditary Nephropathy w/ Minor Glomerular Abnormality NEC
 ;;^UTILITY(U,$J,358.3,46498,1,4,0)
 ;;=4^N07.0
 ;;^UTILITY(U,$J,358.3,46498,2)
 ;;=^5015559
 ;;^UTILITY(U,$J,358.3,46499,0)
 ;;=N07.8^^206^2301^9
 ;;^UTILITY(U,$J,358.3,46499,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,46499,1,3,0)
 ;;=3^Hereditary Nephropathy w/ Morphologic Lesions NEC
 ;;^UTILITY(U,$J,358.3,46499,1,4,0)
 ;;=4^N07.8
