IBDEI23L ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,35583,0)
 ;;=N07.7^^134^1726^6
 ;;^UTILITY(U,$J,358.3,35583,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35583,1,3,0)
 ;;=3^Hereditary Nephropathy w/ Diffuse Crescentic Glomerular NEC
 ;;^UTILITY(U,$J,358.3,35583,1,4,0)
 ;;=4^N07.7
 ;;^UTILITY(U,$J,358.3,35583,2)
 ;;=^5015566
 ;;^UTILITY(U,$J,358.3,35584,0)
 ;;=N07.1^^134^1726^7
 ;;^UTILITY(U,$J,358.3,35584,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35584,1,3,0)
 ;;=3^Hereditary Nephropathy w/ Focal/Segmental Glomerular Lesions NEC
 ;;^UTILITY(U,$J,358.3,35584,1,4,0)
 ;;=4^N07.1
 ;;^UTILITY(U,$J,358.3,35584,2)
 ;;=^5015560
 ;;^UTILITY(U,$J,358.3,35585,0)
 ;;=N07.0^^134^1726^8
 ;;^UTILITY(U,$J,358.3,35585,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35585,1,3,0)
 ;;=3^Hereditary Nephropathy w/ Minor Glomerular Abnormality NEC
 ;;^UTILITY(U,$J,358.3,35585,1,4,0)
 ;;=4^N07.0
 ;;^UTILITY(U,$J,358.3,35585,2)
 ;;=^5015559
 ;;^UTILITY(U,$J,358.3,35586,0)
 ;;=N07.8^^134^1726^9
 ;;^UTILITY(U,$J,358.3,35586,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35586,1,3,0)
 ;;=3^Hereditary Nephropathy w/ Morphologic Lesions NEC
 ;;^UTILITY(U,$J,358.3,35586,1,4,0)
 ;;=4^N07.8
 ;;^UTILITY(U,$J,358.3,35586,2)
 ;;=^5015567
 ;;^UTILITY(U,$J,358.3,35587,0)
 ;;=N41.9^^134^1726^10
 ;;^UTILITY(U,$J,358.3,35587,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35587,1,3,0)
 ;;=3^Inflammatory Prostate Disease,Unspec
 ;;^UTILITY(U,$J,358.3,35587,1,4,0)
 ;;=4^N41.9
 ;;^UTILITY(U,$J,358.3,35587,2)
 ;;=^5015694
 ;;^UTILITY(U,$J,358.3,35588,0)
 ;;=N06.6^^134^1726^11
 ;;^UTILITY(U,$J,358.3,35588,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35588,1,3,0)
 ;;=3^Isolated Proteinuria w/ Dense Deposit Disease
 ;;^UTILITY(U,$J,358.3,35588,1,4,0)
 ;;=4^N06.6
 ;;^UTILITY(U,$J,358.3,35588,2)
 ;;=^5015555
 ;;^UTILITY(U,$J,358.3,35589,0)
 ;;=N06.7^^134^1726^12
 ;;^UTILITY(U,$J,358.3,35589,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35589,1,3,0)
 ;;=3^Isolated Proteinuria w/ Diffuse Crescentic Glomerulonephritis
 ;;^UTILITY(U,$J,358.3,35589,1,4,0)
 ;;=4^N06.7
 ;;^UTILITY(U,$J,358.3,35589,2)
 ;;=^5015556
 ;;^UTILITY(U,$J,358.3,35590,0)
 ;;=N06.1^^134^1726^13
 ;;^UTILITY(U,$J,358.3,35590,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35590,1,3,0)
 ;;=3^Isolated Proteinuria w/ Focal/Segmental Glomerular Lesions
 ;;^UTILITY(U,$J,358.3,35590,1,4,0)
 ;;=4^N06.1
 ;;^UTILITY(U,$J,358.3,35590,2)
 ;;=^5015550
 ;;^UTILITY(U,$J,358.3,35591,0)
 ;;=N06.0^^134^1726^14
 ;;^UTILITY(U,$J,358.3,35591,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35591,1,3,0)
 ;;=3^Isolated Proteinuria w/ Minor Glomerular Abnormality
 ;;^UTILITY(U,$J,358.3,35591,1,4,0)
 ;;=4^N06.0
 ;;^UTILITY(U,$J,358.3,35591,2)
 ;;=^5015549
 ;;^UTILITY(U,$J,358.3,35592,0)
 ;;=N06.8^^134^1726^15
 ;;^UTILITY(U,$J,358.3,35592,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35592,1,3,0)
 ;;=3^Isolated Proteinuria w/ Morphologic Lesion
 ;;^UTILITY(U,$J,358.3,35592,1,4,0)
 ;;=4^N06.8
 ;;^UTILITY(U,$J,358.3,35592,2)
 ;;=^5015557
 ;;^UTILITY(U,$J,358.3,35593,0)
 ;;=N14.3^^134^1726^24
 ;;^UTILITY(U,$J,358.3,35593,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35593,1,3,0)
 ;;=3^Nephropathy Induced by Heavy Metals
 ;;^UTILITY(U,$J,358.3,35593,1,4,0)
 ;;=4^N14.3
 ;;^UTILITY(U,$J,358.3,35593,2)
 ;;=^5015593
 ;;^UTILITY(U,$J,358.3,35594,0)
 ;;=N14.1^^134^1726^23
 ;;^UTILITY(U,$J,358.3,35594,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35594,1,3,0)
 ;;=3^Nephropathy Induced by Drug/Meds/Biol Subst
 ;;^UTILITY(U,$J,358.3,35594,1,4,0)
 ;;=4^N14.1
 ;;^UTILITY(U,$J,358.3,35594,2)
 ;;=^5015591
 ;;^UTILITY(U,$J,358.3,35595,0)
 ;;=N29.^^134^1726^16
