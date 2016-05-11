IBDEI05Y ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,2448,1,3,0)
 ;;=3^Cervicocranial syndrome
 ;;^UTILITY(U,$J,358.3,2448,1,4,0)
 ;;=4^M53.0
 ;;^UTILITY(U,$J,358.3,2448,2)
 ;;=^21952
 ;;^UTILITY(U,$J,358.3,2449,0)
 ;;=M50.90^^15^188^5
 ;;^UTILITY(U,$J,358.3,2449,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2449,1,3,0)
 ;;=3^Cervical disc disorder, unsp, unspecified cervical region
 ;;^UTILITY(U,$J,358.3,2449,1,4,0)
 ;;=4^M50.90
 ;;^UTILITY(U,$J,358.3,2449,2)
 ;;=^5012235
 ;;^UTILITY(U,$J,358.3,2450,0)
 ;;=M50.00^^15^188^4
 ;;^UTILITY(U,$J,358.3,2450,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2450,1,3,0)
 ;;=3^Cervical disc disorder with myelopathy, unsp cervical region
 ;;^UTILITY(U,$J,358.3,2450,1,4,0)
 ;;=4^M50.00
 ;;^UTILITY(U,$J,358.3,2450,2)
 ;;=^5012215
 ;;^UTILITY(U,$J,358.3,2451,0)
 ;;=M54.12^^15^188^10
 ;;^UTILITY(U,$J,358.3,2451,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2451,1,3,0)
 ;;=3^Radiculopathy, cervical region
 ;;^UTILITY(U,$J,358.3,2451,1,4,0)
 ;;=4^M54.12
 ;;^UTILITY(U,$J,358.3,2451,2)
 ;;=^5012297
 ;;^UTILITY(U,$J,358.3,2452,0)
 ;;=M99.01^^15^188^11
 ;;^UTILITY(U,$J,358.3,2452,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2452,1,3,0)
 ;;=3^Segmental and somatic dysfunction of cervical region
 ;;^UTILITY(U,$J,358.3,2452,1,4,0)
 ;;=4^M99.01
 ;;^UTILITY(U,$J,358.3,2452,2)
 ;;=^5015401
 ;;^UTILITY(U,$J,358.3,2453,0)
 ;;=M48.02^^15^188^12
 ;;^UTILITY(U,$J,358.3,2453,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2453,1,3,0)
 ;;=3^Spinal stenosis, cervical region
 ;;^UTILITY(U,$J,358.3,2453,1,4,0)
 ;;=4^M48.02
 ;;^UTILITY(U,$J,358.3,2453,2)
 ;;=^5012089
 ;;^UTILITY(U,$J,358.3,2454,0)
 ;;=M47.812^^15^188^14
 ;;^UTILITY(U,$J,358.3,2454,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2454,1,3,0)
 ;;=3^Spondylosis w/o myelopathy or radiculopathy, cervical region
 ;;^UTILITY(U,$J,358.3,2454,1,4,0)
 ;;=4^M47.812
 ;;^UTILITY(U,$J,358.3,2454,2)
 ;;=^5012069
 ;;^UTILITY(U,$J,358.3,2455,0)
 ;;=S13.9XXA^^15^188^15
 ;;^UTILITY(U,$J,358.3,2455,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2455,1,3,0)
 ;;=3^Sprain of joints/ligaments of unsp parts of neck, init
 ;;^UTILITY(U,$J,358.3,2455,1,4,0)
 ;;=4^S13.9XXA
 ;;^UTILITY(U,$J,358.3,2455,2)
 ;;=^5022037
 ;;^UTILITY(U,$J,358.3,2456,0)
 ;;=M43.12^^15^188^13
 ;;^UTILITY(U,$J,358.3,2456,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2456,1,3,0)
 ;;=3^Spondylolisthesis,Cervical Region
 ;;^UTILITY(U,$J,358.3,2456,1,4,0)
 ;;=4^M43.12
 ;;^UTILITY(U,$J,358.3,2456,2)
 ;;=^5011923
 ;;^UTILITY(U,$J,358.3,2457,0)
 ;;=M50.22^^15^188^6
 ;;^UTILITY(U,$J,358.3,2457,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2457,1,3,0)
 ;;=3^Cervical disc displacement, mid-cervical region
 ;;^UTILITY(U,$J,358.3,2457,1,4,0)
 ;;=4^M50.22
 ;;^UTILITY(U,$J,358.3,2457,2)
 ;;=^5012225
 ;;^UTILITY(U,$J,358.3,2458,0)
 ;;=M99.88^^15^189^1
 ;;^UTILITY(U,$J,358.3,2458,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2458,1,3,0)
 ;;=3^Biomechanical lesions of rib cage
 ;;^UTILITY(U,$J,358.3,2458,1,4,0)
 ;;=4^M99.88
 ;;^UTILITY(U,$J,358.3,2458,2)
 ;;=^5015488
 ;;^UTILITY(U,$J,358.3,2459,0)
 ;;=M99.82^^15^189^2
 ;;^UTILITY(U,$J,358.3,2459,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2459,1,3,0)
 ;;=3^Biomechanical lesions of thoracic region
 ;;^UTILITY(U,$J,358.3,2459,1,4,0)
 ;;=4^M99.82
 ;;^UTILITY(U,$J,358.3,2459,2)
 ;;=^5015482
 ;;^UTILITY(U,$J,358.3,2460,0)
 ;;=M51.24^^15^189^5
 ;;^UTILITY(U,$J,358.3,2460,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2460,1,3,0)
 ;;=3^Intervertebral disc displacement, thoracic region
 ;;^UTILITY(U,$J,358.3,2460,1,4,0)
 ;;=4^M51.24
 ;;^UTILITY(U,$J,358.3,2460,2)
 ;;=^5012247
 ;;^UTILITY(U,$J,358.3,2461,0)
 ;;=M51.34^^15^189^3
