IBDEI1BP ; ; 01-FEB-2022
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 01, 2022
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,21390,0)
 ;;=N15.0^^70^917^2
 ;;^UTILITY(U,$J,358.3,21390,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21390,1,3,0)
 ;;=3^Balkan Nephropathy
 ;;^UTILITY(U,$J,358.3,21390,1,4,0)
 ;;=4^N15.0
 ;;^UTILITY(U,$J,358.3,21390,2)
 ;;=^12543
 ;;^UTILITY(U,$J,358.3,21391,0)
 ;;=N18.9^^70^917^3
 ;;^UTILITY(U,$J,358.3,21391,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21391,1,3,0)
 ;;=3^Chr Kidney Disease,Unspec
 ;;^UTILITY(U,$J,358.3,21391,1,4,0)
 ;;=4^N18.9
 ;;^UTILITY(U,$J,358.3,21391,2)
 ;;=^332812
 ;;^UTILITY(U,$J,358.3,21392,0)
 ;;=N28.9^^70^917^18
 ;;^UTILITY(U,$J,358.3,21392,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21392,1,3,0)
 ;;=3^Kidney/Ureter Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,21392,1,4,0)
 ;;=4^N28.9
 ;;^UTILITY(U,$J,358.3,21392,2)
 ;;=^5015630
 ;;^UTILITY(U,$J,358.3,21393,0)
 ;;=N40.0^^70^917^5
 ;;^UTILITY(U,$J,358.3,21393,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21393,1,3,0)
 ;;=3^Enlarged Prostate w/o Lower Urinary Tract Symptoms
 ;;^UTILITY(U,$J,358.3,21393,1,4,0)
 ;;=4^N40.0
 ;;^UTILITY(U,$J,358.3,21393,2)
 ;;=^5015689
 ;;^UTILITY(U,$J,358.3,21394,0)
 ;;=N07.6^^70^917^6
 ;;^UTILITY(U,$J,358.3,21394,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21394,1,3,0)
 ;;=3^Hereditary Nephropathy w/ Dense Deposit Disease NEC
 ;;^UTILITY(U,$J,358.3,21394,1,4,0)
 ;;=4^N07.6
 ;;^UTILITY(U,$J,358.3,21394,2)
 ;;=^5015565
 ;;^UTILITY(U,$J,358.3,21395,0)
 ;;=N07.7^^70^917^7
 ;;^UTILITY(U,$J,358.3,21395,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21395,1,3,0)
 ;;=3^Hereditary Nephropathy w/ Diffuse Crescentic Glomerular NEC
 ;;^UTILITY(U,$J,358.3,21395,1,4,0)
 ;;=4^N07.7
 ;;^UTILITY(U,$J,358.3,21395,2)
 ;;=^5015566
 ;;^UTILITY(U,$J,358.3,21396,0)
 ;;=N07.1^^70^917^8
 ;;^UTILITY(U,$J,358.3,21396,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21396,1,3,0)
 ;;=3^Hereditary Nephropathy w/ Focal/Segmental Glomerular Lesions NEC
 ;;^UTILITY(U,$J,358.3,21396,1,4,0)
 ;;=4^N07.1
 ;;^UTILITY(U,$J,358.3,21396,2)
 ;;=^5015560
 ;;^UTILITY(U,$J,358.3,21397,0)
 ;;=N07.0^^70^917^9
 ;;^UTILITY(U,$J,358.3,21397,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21397,1,3,0)
 ;;=3^Hereditary Nephropathy w/ Minor Glomerular Abnormality NEC
 ;;^UTILITY(U,$J,358.3,21397,1,4,0)
 ;;=4^N07.0
 ;;^UTILITY(U,$J,358.3,21397,2)
 ;;=^5015559
 ;;^UTILITY(U,$J,358.3,21398,0)
 ;;=N07.8^^70^917^10
 ;;^UTILITY(U,$J,358.3,21398,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21398,1,3,0)
 ;;=3^Hereditary Nephropathy w/ Morphologic Lesions NEC
 ;;^UTILITY(U,$J,358.3,21398,1,4,0)
 ;;=4^N07.8
 ;;^UTILITY(U,$J,358.3,21398,2)
 ;;=^5015567
 ;;^UTILITY(U,$J,358.3,21399,0)
 ;;=N41.9^^70^917^11
 ;;^UTILITY(U,$J,358.3,21399,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21399,1,3,0)
 ;;=3^Inflammatory Prostate Disease,Unspec
 ;;^UTILITY(U,$J,358.3,21399,1,4,0)
 ;;=4^N41.9
 ;;^UTILITY(U,$J,358.3,21399,2)
 ;;=^5015694
 ;;^UTILITY(U,$J,358.3,21400,0)
 ;;=N06.6^^70^917^12
 ;;^UTILITY(U,$J,358.3,21400,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21400,1,3,0)
 ;;=3^Isolated Proteinuria w/ Dense Deposit Disease
 ;;^UTILITY(U,$J,358.3,21400,1,4,0)
 ;;=4^N06.6
 ;;^UTILITY(U,$J,358.3,21400,2)
 ;;=^5015555
 ;;^UTILITY(U,$J,358.3,21401,0)
 ;;=N06.7^^70^917^13
 ;;^UTILITY(U,$J,358.3,21401,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21401,1,3,0)
 ;;=3^Isolated Proteinuria w/ Diffuse Crescentic Glomerulonephritis
 ;;^UTILITY(U,$J,358.3,21401,1,4,0)
 ;;=4^N06.7
