IBDEI1AR ; ; 01-FEB-2022
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 01, 2022
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,20950,1,3,0)
 ;;=3^Spondylosis w/ Myelopathy,Cervical Region
 ;;^UTILITY(U,$J,358.3,20950,1,4,0)
 ;;=4^M47.12
 ;;^UTILITY(U,$J,358.3,20950,2)
 ;;=^5012052
 ;;^UTILITY(U,$J,358.3,20951,0)
 ;;=M47.13^^67^893^22
 ;;^UTILITY(U,$J,358.3,20951,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20951,1,3,0)
 ;;=3^Spondylosis w/ Myelopathy,Cervicothoracic Region
 ;;^UTILITY(U,$J,358.3,20951,1,4,0)
 ;;=4^M47.13
 ;;^UTILITY(U,$J,358.3,20951,2)
 ;;=^5012053
 ;;^UTILITY(U,$J,358.3,20952,0)
 ;;=M47.16^^67^893^23
 ;;^UTILITY(U,$J,358.3,20952,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20952,1,3,0)
 ;;=3^Spondylosis w/ Myelopathy,Lumbar Region
 ;;^UTILITY(U,$J,358.3,20952,1,4,0)
 ;;=4^M47.16
 ;;^UTILITY(U,$J,358.3,20952,2)
 ;;=^5012056
 ;;^UTILITY(U,$J,358.3,20953,0)
 ;;=M47.14^^67^893^25
 ;;^UTILITY(U,$J,358.3,20953,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20953,1,3,0)
 ;;=3^Spondylosis w/ Myelopathy,Thoracic Region
 ;;^UTILITY(U,$J,358.3,20953,1,4,0)
 ;;=4^M47.14
 ;;^UTILITY(U,$J,358.3,20953,2)
 ;;=^5012054
 ;;^UTILITY(U,$J,358.3,20954,0)
 ;;=M47.20^^67^893^31
 ;;^UTILITY(U,$J,358.3,20954,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20954,1,3,0)
 ;;=3^Spondylosis w/ Radiculopathy,Site Unspec
 ;;^UTILITY(U,$J,358.3,20954,1,4,0)
 ;;=4^M47.20
 ;;^UTILITY(U,$J,358.3,20954,2)
 ;;=^5012059
 ;;^UTILITY(U,$J,358.3,20955,0)
 ;;=M47.15^^67^893^26
 ;;^UTILITY(U,$J,358.3,20955,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20955,1,3,0)
 ;;=3^Spondylosis w/ Myelopathy,Thoracolumbar Region
 ;;^UTILITY(U,$J,358.3,20955,1,4,0)
 ;;=4^M47.15
 ;;^UTILITY(U,$J,358.3,20955,2)
 ;;=^5012055
 ;;^UTILITY(U,$J,358.3,20956,0)
 ;;=M47.22^^67^893^27
 ;;^UTILITY(U,$J,358.3,20956,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20956,1,3,0)
 ;;=3^Spondylosis w/ Radiculopathy,Cervical Region
 ;;^UTILITY(U,$J,358.3,20956,1,4,0)
 ;;=4^M47.22
 ;;^UTILITY(U,$J,358.3,20956,2)
 ;;=^5012061
 ;;^UTILITY(U,$J,358.3,20957,0)
 ;;=M47.23^^67^893^28
 ;;^UTILITY(U,$J,358.3,20957,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20957,1,3,0)
 ;;=3^Spondylosis w/ Radiculopathy,Cervicothoracic Region
 ;;^UTILITY(U,$J,358.3,20957,1,4,0)
 ;;=4^M47.23
 ;;^UTILITY(U,$J,358.3,20957,2)
 ;;=^5012062
 ;;^UTILITY(U,$J,358.3,20958,0)
 ;;=M47.26^^67^893^29
 ;;^UTILITY(U,$J,358.3,20958,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20958,1,3,0)
 ;;=3^Spondylosis w/ Radiculopathy,Lumbar Region
 ;;^UTILITY(U,$J,358.3,20958,1,4,0)
 ;;=4^M47.26
 ;;^UTILITY(U,$J,358.3,20958,2)
 ;;=^5012065
 ;;^UTILITY(U,$J,358.3,20959,0)
 ;;=M47.27^^67^893^30
 ;;^UTILITY(U,$J,358.3,20959,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20959,1,3,0)
 ;;=3^Spondylosis w/ Radiculopathy,Lumbosacral Region
 ;;^UTILITY(U,$J,358.3,20959,1,4,0)
 ;;=4^M47.27
 ;;^UTILITY(U,$J,358.3,20959,2)
 ;;=^5012066
 ;;^UTILITY(U,$J,358.3,20960,0)
 ;;=M47.20^^67^893^32
 ;;^UTILITY(U,$J,358.3,20960,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20960,1,3,0)
 ;;=3^Spondylosis w/ Radiculopathy,Site Unspec
 ;;^UTILITY(U,$J,358.3,20960,1,4,0)
 ;;=4^M47.20
 ;;^UTILITY(U,$J,358.3,20960,2)
 ;;=^5012059
 ;;^UTILITY(U,$J,358.3,20961,0)
 ;;=M47.24^^67^893^33
 ;;^UTILITY(U,$J,358.3,20961,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20961,1,3,0)
 ;;=3^Spondylosis w/ Radiculopathy,Thoracic Region
 ;;^UTILITY(U,$J,358.3,20961,1,4,0)
 ;;=4^M47.24
 ;;^UTILITY(U,$J,358.3,20961,2)
 ;;=^5012063
 ;;^UTILITY(U,$J,358.3,20962,0)
 ;;=M47.25^^67^893^34
