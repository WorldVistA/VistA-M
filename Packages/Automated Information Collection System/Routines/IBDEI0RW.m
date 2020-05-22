IBDEI0RW ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,12441,1,4,0)
 ;;=4^M47.816
 ;;^UTILITY(U,$J,358.3,12441,2)
 ;;=^5012073
 ;;^UTILITY(U,$J,358.3,12442,0)
 ;;=M47.817^^80^779^31
 ;;^UTILITY(U,$J,358.3,12442,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12442,1,3,0)
 ;;=3^Spondylosis w/o Myelopathy/Radiculopathy,Lumbosacral Region
 ;;^UTILITY(U,$J,358.3,12442,1,4,0)
 ;;=4^M47.817
 ;;^UTILITY(U,$J,358.3,12442,2)
 ;;=^5012074
 ;;^UTILITY(U,$J,358.3,12443,0)
 ;;=M47.811^^80^779^32
 ;;^UTILITY(U,$J,358.3,12443,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12443,1,3,0)
 ;;=3^Spondylosis w/o Myelopathy/Radiculopathy,Occipito/Atlanto/Axial Region
 ;;^UTILITY(U,$J,358.3,12443,1,4,0)
 ;;=4^M47.811
 ;;^UTILITY(U,$J,358.3,12443,2)
 ;;=^5012068
 ;;^UTILITY(U,$J,358.3,12444,0)
 ;;=M47.818^^80^779^33
 ;;^UTILITY(U,$J,358.3,12444,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12444,1,3,0)
 ;;=3^Spondylosis w/o Myelopathy/Radiculopathy,Sacral/Sacrococcygeal Region
 ;;^UTILITY(U,$J,358.3,12444,1,4,0)
 ;;=4^M47.818
 ;;^UTILITY(U,$J,358.3,12444,2)
 ;;=^5012075
 ;;^UTILITY(U,$J,358.3,12445,0)
 ;;=M47.814^^80^779^34
 ;;^UTILITY(U,$J,358.3,12445,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12445,1,3,0)
 ;;=3^Spondylosis w/o Myelopathy/Radiculopathy,Thoracic Region
 ;;^UTILITY(U,$J,358.3,12445,1,4,0)
 ;;=4^M47.814
 ;;^UTILITY(U,$J,358.3,12445,2)
 ;;=^5012071
 ;;^UTILITY(U,$J,358.3,12446,0)
 ;;=M47.815^^80^779^35
 ;;^UTILITY(U,$J,358.3,12446,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12446,1,3,0)
 ;;=3^Spondylosis w/o Myelopathy/Radiculopathy,Thoracolumbar Region
 ;;^UTILITY(U,$J,358.3,12446,1,4,0)
 ;;=4^M47.815
 ;;^UTILITY(U,$J,358.3,12446,2)
 ;;=^5012072
 ;;^UTILITY(U,$J,358.3,12447,0)
 ;;=S08.111A^^80^780^3
 ;;^UTILITY(U,$J,358.3,12447,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12447,1,3,0)
 ;;=3^Complete Traumatic Amputation of Right Ear,Init Encntr
 ;;^UTILITY(U,$J,358.3,12447,1,4,0)
 ;;=4^S08.111A
 ;;^UTILITY(U,$J,358.3,12447,2)
 ;;=^5021251
 ;;^UTILITY(U,$J,358.3,12448,0)
 ;;=S08.112A^^80^780^2
 ;;^UTILITY(U,$J,358.3,12448,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12448,1,3,0)
 ;;=3^Complete Traumatic Amputation of Left Ear,Init Encntr
 ;;^UTILITY(U,$J,358.3,12448,1,4,0)
 ;;=4^S08.112A
 ;;^UTILITY(U,$J,358.3,12448,2)
 ;;=^5021254
 ;;^UTILITY(U,$J,358.3,12449,0)
 ;;=S08.0XXA^^80^780^1
 ;;^UTILITY(U,$J,358.3,12449,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12449,1,3,0)
 ;;=3^Avulsion of Scalp,Init Encntr
 ;;^UTILITY(U,$J,358.3,12449,1,4,0)
 ;;=4^S08.0XXA
 ;;^UTILITY(U,$J,358.3,12449,2)
 ;;=^5021248
 ;;^UTILITY(U,$J,358.3,12450,0)
 ;;=S09.90XA^^80^780^6
 ;;^UTILITY(U,$J,358.3,12450,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12450,1,3,0)
 ;;=3^Injury of Head,Unspec,Init Encntr
 ;;^UTILITY(U,$J,358.3,12450,1,4,0)
 ;;=4^S09.90XA
 ;;^UTILITY(U,$J,358.3,12450,2)
 ;;=^5021332
 ;;^UTILITY(U,$J,358.3,12451,0)
 ;;=S09.8XXA^^80^780^5
 ;;^UTILITY(U,$J,358.3,12451,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12451,1,3,0)
 ;;=3^Injury of Head NEC,Init Encntr
 ;;^UTILITY(U,$J,358.3,12451,1,4,0)
 ;;=4^S09.8XXA
 ;;^UTILITY(U,$J,358.3,12451,2)
 ;;=^5021329
 ;;^UTILITY(U,$J,358.3,12452,0)
 ;;=S08.89XA^^80^780^7
 ;;^UTILITY(U,$J,358.3,12452,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12452,1,3,0)
 ;;=3^Traumatic Amputation of Parts of Head NEC,Init Encntr
 ;;^UTILITY(U,$J,358.3,12452,1,4,0)
 ;;=4^S08.89XA
 ;;^UTILITY(U,$J,358.3,12452,2)
 ;;=^5021275
 ;;^UTILITY(U,$J,358.3,12453,0)
 ;;=S09.93XA^^80^780^4
