IBDEI0DC ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,5800,1,4,0)
 ;;=4^M47.817
 ;;^UTILITY(U,$J,358.3,5800,2)
 ;;=^5012074
 ;;^UTILITY(U,$J,358.3,5801,0)
 ;;=M47.811^^40^376^32
 ;;^UTILITY(U,$J,358.3,5801,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5801,1,3,0)
 ;;=3^Spondylosis w/o Myelopathy/Radiculopathy,Occipito/Atlanto/Axial Region
 ;;^UTILITY(U,$J,358.3,5801,1,4,0)
 ;;=4^M47.811
 ;;^UTILITY(U,$J,358.3,5801,2)
 ;;=^5012068
 ;;^UTILITY(U,$J,358.3,5802,0)
 ;;=M47.818^^40^376^33
 ;;^UTILITY(U,$J,358.3,5802,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5802,1,3,0)
 ;;=3^Spondylosis w/o Myelopathy/Radiculopathy,Sacral/Sacrococcygeal Region
 ;;^UTILITY(U,$J,358.3,5802,1,4,0)
 ;;=4^M47.818
 ;;^UTILITY(U,$J,358.3,5802,2)
 ;;=^5012075
 ;;^UTILITY(U,$J,358.3,5803,0)
 ;;=M47.814^^40^376^34
 ;;^UTILITY(U,$J,358.3,5803,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5803,1,3,0)
 ;;=3^Spondylosis w/o Myelopathy/Radiculopathy,Thoracic Region
 ;;^UTILITY(U,$J,358.3,5803,1,4,0)
 ;;=4^M47.814
 ;;^UTILITY(U,$J,358.3,5803,2)
 ;;=^5012071
 ;;^UTILITY(U,$J,358.3,5804,0)
 ;;=M47.815^^40^376^35
 ;;^UTILITY(U,$J,358.3,5804,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5804,1,3,0)
 ;;=3^Spondylosis w/o Myelopathy/Radiculopathy,Thoracolumbar Region
 ;;^UTILITY(U,$J,358.3,5804,1,4,0)
 ;;=4^M47.815
 ;;^UTILITY(U,$J,358.3,5804,2)
 ;;=^5012072
 ;;^UTILITY(U,$J,358.3,5805,0)
 ;;=S08.111A^^40^377^3
 ;;^UTILITY(U,$J,358.3,5805,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5805,1,3,0)
 ;;=3^Complete Traumatic Amputation of Right Ear,Init Encntr
 ;;^UTILITY(U,$J,358.3,5805,1,4,0)
 ;;=4^S08.111A
 ;;^UTILITY(U,$J,358.3,5805,2)
 ;;=^5021251
 ;;^UTILITY(U,$J,358.3,5806,0)
 ;;=S08.112A^^40^377^2
 ;;^UTILITY(U,$J,358.3,5806,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5806,1,3,0)
 ;;=3^Complete Traumatic Amputation of Left Ear,Init Encntr
 ;;^UTILITY(U,$J,358.3,5806,1,4,0)
 ;;=4^S08.112A
 ;;^UTILITY(U,$J,358.3,5806,2)
 ;;=^5021254
 ;;^UTILITY(U,$J,358.3,5807,0)
 ;;=S08.0XXA^^40^377^1
 ;;^UTILITY(U,$J,358.3,5807,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5807,1,3,0)
 ;;=3^Avulsion of Scalp,Init Encntr
 ;;^UTILITY(U,$J,358.3,5807,1,4,0)
 ;;=4^S08.0XXA
 ;;^UTILITY(U,$J,358.3,5807,2)
 ;;=^5021248
 ;;^UTILITY(U,$J,358.3,5808,0)
 ;;=S09.90XA^^40^377^6
 ;;^UTILITY(U,$J,358.3,5808,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5808,1,3,0)
 ;;=3^Injury of Head,Unspec,Init Encntr
 ;;^UTILITY(U,$J,358.3,5808,1,4,0)
 ;;=4^S09.90XA
 ;;^UTILITY(U,$J,358.3,5808,2)
 ;;=^5021332
 ;;^UTILITY(U,$J,358.3,5809,0)
 ;;=S09.8XXA^^40^377^5
 ;;^UTILITY(U,$J,358.3,5809,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5809,1,3,0)
 ;;=3^Injury of Head NEC,Init Encntr
 ;;^UTILITY(U,$J,358.3,5809,1,4,0)
 ;;=4^S09.8XXA
 ;;^UTILITY(U,$J,358.3,5809,2)
 ;;=^5021329
 ;;^UTILITY(U,$J,358.3,5810,0)
 ;;=S08.89XA^^40^377^7
 ;;^UTILITY(U,$J,358.3,5810,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5810,1,3,0)
 ;;=3^Traumatic Amputation of Parts of Head NEC,Init Encntr
 ;;^UTILITY(U,$J,358.3,5810,1,4,0)
 ;;=4^S08.89XA
 ;;^UTILITY(U,$J,358.3,5810,2)
 ;;=^5021275
 ;;^UTILITY(U,$J,358.3,5811,0)
 ;;=S09.93XA^^40^377^4
 ;;^UTILITY(U,$J,358.3,5811,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5811,1,3,0)
 ;;=3^Injury of Face,Unspec,Init Encntr
 ;;^UTILITY(U,$J,358.3,5811,1,4,0)
 ;;=4^S09.93XA
 ;;^UTILITY(U,$J,358.3,5811,2)
 ;;=^5021341
 ;;^UTILITY(U,$J,358.3,5812,0)
 ;;=M79.671^^40^378^13
 ;;^UTILITY(U,$J,358.3,5812,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5812,1,3,0)
 ;;=3^Right Foot Pain
 ;;^UTILITY(U,$J,358.3,5812,1,4,0)
 ;;=4^M79.671
 ;;^UTILITY(U,$J,358.3,5812,2)
 ;;=^5013350
 ;;^UTILITY(U,$J,358.3,5813,0)
 ;;=M79.675^^40^378^9
