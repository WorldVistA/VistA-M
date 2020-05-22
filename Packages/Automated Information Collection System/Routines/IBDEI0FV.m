IBDEI0FV ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,6853,1,4,0)
 ;;=4^G44.209
 ;;^UTILITY(U,$J,358.3,6853,2)
 ;;=^5003936
 ;;^UTILITY(U,$J,358.3,6854,0)
 ;;=R51.^^56^440^6
 ;;^UTILITY(U,$J,358.3,6854,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6854,1,3,0)
 ;;=3^Headache
 ;;^UTILITY(U,$J,358.3,6854,1,4,0)
 ;;=4^R51.
 ;;^UTILITY(U,$J,358.3,6854,2)
 ;;=^5019513
 ;;^UTILITY(U,$J,358.3,6855,0)
 ;;=M99.81^^56^441^1
 ;;^UTILITY(U,$J,358.3,6855,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6855,1,3,0)
 ;;=3^Biomechanical lesions of cervial region, other
 ;;^UTILITY(U,$J,358.3,6855,1,4,0)
 ;;=4^M99.81
 ;;^UTILITY(U,$J,358.3,6855,2)
 ;;=^5015481
 ;;^UTILITY(U,$J,358.3,6856,0)
 ;;=M99.80^^56^441^2
 ;;^UTILITY(U,$J,358.3,6856,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6856,1,3,0)
 ;;=3^Biomechanical lesions of head region, other
 ;;^UTILITY(U,$J,358.3,6856,1,4,0)
 ;;=4^M99.80
 ;;^UTILITY(U,$J,358.3,6856,2)
 ;;=^5015480
 ;;^UTILITY(U,$J,358.3,6857,0)
 ;;=M50.30^^56^441^6
 ;;^UTILITY(U,$J,358.3,6857,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6857,1,3,0)
 ;;=3^Cervical Disc Degeneration,Unspec Cervical Region
 ;;^UTILITY(U,$J,358.3,6857,1,4,0)
 ;;=4^M50.30
 ;;^UTILITY(U,$J,358.3,6857,2)
 ;;=^5012227
 ;;^UTILITY(U,$J,358.3,6858,0)
 ;;=G54.2^^56^441^24
 ;;^UTILITY(U,$J,358.3,6858,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6858,1,3,0)
 ;;=3^Cervical root disorders NEC
 ;;^UTILITY(U,$J,358.3,6858,1,4,0)
 ;;=4^G54.2
 ;;^UTILITY(U,$J,358.3,6858,2)
 ;;=^5004009
 ;;^UTILITY(U,$J,358.3,6859,0)
 ;;=M54.2^^56^441^25
 ;;^UTILITY(U,$J,358.3,6859,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6859,1,3,0)
 ;;=3^Cervicalgia
 ;;^UTILITY(U,$J,358.3,6859,1,4,0)
 ;;=4^M54.2
 ;;^UTILITY(U,$J,358.3,6859,2)
 ;;=^5012304
 ;;^UTILITY(U,$J,358.3,6860,0)
 ;;=M53.0^^56^441^26
 ;;^UTILITY(U,$J,358.3,6860,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6860,1,3,0)
 ;;=3^Cervicocranial syndrome
 ;;^UTILITY(U,$J,358.3,6860,1,4,0)
 ;;=4^M53.0
 ;;^UTILITY(U,$J,358.3,6860,2)
 ;;=^21952
 ;;^UTILITY(U,$J,358.3,6861,0)
 ;;=M50.90^^56^441^8
 ;;^UTILITY(U,$J,358.3,6861,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6861,1,3,0)
 ;;=3^Cervical Disc Disorder,Unspec Cervical Region
 ;;^UTILITY(U,$J,358.3,6861,1,4,0)
 ;;=4^M50.90
 ;;^UTILITY(U,$J,358.3,6861,2)
 ;;=^5012235
 ;;^UTILITY(U,$J,358.3,6862,0)
 ;;=M50.00^^56^441^7
 ;;^UTILITY(U,$J,358.3,6862,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6862,1,3,0)
 ;;=3^Cervical Disc Disorder w/ Melopathy,Unspec Cervical Region
 ;;^UTILITY(U,$J,358.3,6862,1,4,0)
 ;;=4^M50.00
 ;;^UTILITY(U,$J,358.3,6862,2)
 ;;=^5012215
 ;;^UTILITY(U,$J,358.3,6863,0)
 ;;=M54.12^^56^441^27
 ;;^UTILITY(U,$J,358.3,6863,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6863,1,3,0)
 ;;=3^Radiculopathy, cervical region
 ;;^UTILITY(U,$J,358.3,6863,1,4,0)
 ;;=4^M54.12
 ;;^UTILITY(U,$J,358.3,6863,2)
 ;;=^5012297
 ;;^UTILITY(U,$J,358.3,6864,0)
 ;;=M99.01^^56^441^28
 ;;^UTILITY(U,$J,358.3,6864,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6864,1,3,0)
 ;;=3^Segmental and somatic dysfunction of cervical region
 ;;^UTILITY(U,$J,358.3,6864,1,4,0)
 ;;=4^M99.01
 ;;^UTILITY(U,$J,358.3,6864,2)
 ;;=^5015401
 ;;^UTILITY(U,$J,358.3,6865,0)
 ;;=M48.02^^56^441^29
 ;;^UTILITY(U,$J,358.3,6865,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6865,1,3,0)
 ;;=3^Spinal stenosis, cervical region
 ;;^UTILITY(U,$J,358.3,6865,1,4,0)
 ;;=4^M48.02
 ;;^UTILITY(U,$J,358.3,6865,2)
 ;;=^5012089
 ;;^UTILITY(U,$J,358.3,6866,0)
 ;;=M47.812^^56^441^31
