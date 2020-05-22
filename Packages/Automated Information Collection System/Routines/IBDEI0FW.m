IBDEI0FW ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,6866,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6866,1,3,0)
 ;;=3^Spondylosis w/o myelopathy or radiculopathy, cervical region
 ;;^UTILITY(U,$J,358.3,6866,1,4,0)
 ;;=4^M47.812
 ;;^UTILITY(U,$J,358.3,6866,2)
 ;;=^5012069
 ;;^UTILITY(U,$J,358.3,6867,0)
 ;;=S13.9XXA^^56^441^32
 ;;^UTILITY(U,$J,358.3,6867,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6867,1,3,0)
 ;;=3^Sprain of joints/ligaments of unsp parts of neck, init
 ;;^UTILITY(U,$J,358.3,6867,1,4,0)
 ;;=4^S13.9XXA
 ;;^UTILITY(U,$J,358.3,6867,2)
 ;;=^5022037
 ;;^UTILITY(U,$J,358.3,6868,0)
 ;;=M43.12^^56^441^30
 ;;^UTILITY(U,$J,358.3,6868,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6868,1,3,0)
 ;;=3^Spondylolisthesis,Cervical Region
 ;;^UTILITY(U,$J,358.3,6868,1,4,0)
 ;;=4^M43.12
 ;;^UTILITY(U,$J,358.3,6868,2)
 ;;=^5011923
 ;;^UTILITY(U,$J,358.3,6869,0)
 ;;=M50.321^^56^441^3
 ;;^UTILITY(U,$J,358.3,6869,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6869,1,3,0)
 ;;=3^Cervical Disc Degeneration at C4-C5
 ;;^UTILITY(U,$J,358.3,6869,1,4,0)
 ;;=4^M50.321
 ;;^UTILITY(U,$J,358.3,6869,2)
 ;;=^5138821
 ;;^UTILITY(U,$J,358.3,6870,0)
 ;;=M50.322^^56^441^4
 ;;^UTILITY(U,$J,358.3,6870,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6870,1,3,0)
 ;;=3^Cervical Disc Degeneration at C5-C6
 ;;^UTILITY(U,$J,358.3,6870,1,4,0)
 ;;=4^M50.322
 ;;^UTILITY(U,$J,358.3,6870,2)
 ;;=^5138822
 ;;^UTILITY(U,$J,358.3,6871,0)
 ;;=M50.323^^56^441^5
 ;;^UTILITY(U,$J,358.3,6871,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6871,1,3,0)
 ;;=3^Cervical Disc Degeneration at C6-C7
 ;;^UTILITY(U,$J,358.3,6871,1,4,0)
 ;;=4^M50.323
 ;;^UTILITY(U,$J,358.3,6871,2)
 ;;=^5138823
 ;;^UTILITY(U,$J,358.3,6872,0)
 ;;=M50.821^^56^441^11
 ;;^UTILITY(U,$J,358.3,6872,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6872,1,3,0)
 ;;=3^Cervical Disc Disorders at C4-C5,Other
 ;;^UTILITY(U,$J,358.3,6872,1,4,0)
 ;;=4^M50.821
 ;;^UTILITY(U,$J,358.3,6872,2)
 ;;=^5138825
 ;;^UTILITY(U,$J,358.3,6873,0)
 ;;=M50.822^^56^441^15
 ;;^UTILITY(U,$J,358.3,6873,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6873,1,3,0)
 ;;=3^Cervical Disc Disorders at C5-C6,Other
 ;;^UTILITY(U,$J,358.3,6873,1,4,0)
 ;;=4^M50.822
 ;;^UTILITY(U,$J,358.3,6873,2)
 ;;=^5138826
 ;;^UTILITY(U,$J,358.3,6874,0)
 ;;=M50.823^^56^441^19
 ;;^UTILITY(U,$J,358.3,6874,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6874,1,3,0)
 ;;=3^Cervical Disc Disorders at C6-C7,Other
 ;;^UTILITY(U,$J,358.3,6874,1,4,0)
 ;;=4^M50.823
 ;;^UTILITY(U,$J,358.3,6874,2)
 ;;=^5138827
 ;;^UTILITY(U,$J,358.3,6875,0)
 ;;=M50.921^^56^441^12
 ;;^UTILITY(U,$J,358.3,6875,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6875,1,3,0)
 ;;=3^Cervical Disc Disorders at C4-C5,Unspec
 ;;^UTILITY(U,$J,358.3,6875,1,4,0)
 ;;=4^M50.921
 ;;^UTILITY(U,$J,358.3,6875,2)
 ;;=^5138829
 ;;^UTILITY(U,$J,358.3,6876,0)
 ;;=M50.922^^56^441^16
 ;;^UTILITY(U,$J,358.3,6876,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6876,1,3,0)
 ;;=3^Cervical Disc Disorders at C5-C6,Unspec
 ;;^UTILITY(U,$J,358.3,6876,1,4,0)
 ;;=4^M50.922
 ;;^UTILITY(U,$J,358.3,6876,2)
 ;;=^5138830
 ;;^UTILITY(U,$J,358.3,6877,0)
 ;;=M50.923^^56^441^20
 ;;^UTILITY(U,$J,358.3,6877,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6877,1,3,0)
 ;;=3^Cervical Disc Disorders at C6-C7,Unspec
 ;;^UTILITY(U,$J,358.3,6877,1,4,0)
 ;;=4^M50.923
 ;;^UTILITY(U,$J,358.3,6877,2)
 ;;=^5138831
 ;;^UTILITY(U,$J,358.3,6878,0)
 ;;=M50.021^^56^441^9
 ;;^UTILITY(U,$J,358.3,6878,1,0)
 ;;=^358.31IA^4^2
