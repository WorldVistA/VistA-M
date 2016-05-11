IBDEI1S3 ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,30221,1,3,0)
 ;;=3^Diffuse Large B-Cell Lymphoma,Unspec Site
 ;;^UTILITY(U,$J,358.3,30221,1,4,0)
 ;;=4^C83.30
 ;;^UTILITY(U,$J,358.3,30221,2)
 ;;=^5001571
 ;;^UTILITY(U,$J,358.3,30222,0)
 ;;=C83.80^^118^1502^66
 ;;^UTILITY(U,$J,358.3,30222,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30222,1,3,0)
 ;;=3^Non-Follicular Lymphoma,Unspec Site NEC
 ;;^UTILITY(U,$J,358.3,30222,1,4,0)
 ;;=4^C83.80
 ;;^UTILITY(U,$J,358.3,30222,2)
 ;;=^5001601
 ;;^UTILITY(U,$J,358.3,30223,0)
 ;;=C83.89^^118^1502^65
 ;;^UTILITY(U,$J,358.3,30223,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30223,1,3,0)
 ;;=3^Non-Follicular Lymphoma,Extrnod/Solid Organ Sites
 ;;^UTILITY(U,$J,358.3,30223,1,4,0)
 ;;=4^C83.89
 ;;^UTILITY(U,$J,358.3,30223,2)
 ;;=^5001610
 ;;^UTILITY(U,$J,358.3,30224,0)
 ;;=C83.90^^118^1502^68
 ;;^UTILITY(U,$J,358.3,30224,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30224,1,3,0)
 ;;=3^Non-Follicular Lymphoma,Unspec,Unspec Site
 ;;^UTILITY(U,$J,358.3,30224,1,4,0)
 ;;=4^C83.90
 ;;^UTILITY(U,$J,358.3,30224,2)
 ;;=^5001611
 ;;^UTILITY(U,$J,358.3,30225,0)
 ;;=C83.99^^118^1502^67
 ;;^UTILITY(U,$J,358.3,30225,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30225,1,3,0)
 ;;=3^Non-Follicular Lymphoma,Unspec,Extranod/Solid Organ Sites
 ;;^UTILITY(U,$J,358.3,30225,1,4,0)
 ;;=4^C83.99
 ;;^UTILITY(U,$J,358.3,30225,2)
 ;;=^5001620
 ;;^UTILITY(U,$J,358.3,30226,0)
 ;;=C84.10^^118^1502^73
 ;;^UTILITY(U,$J,358.3,30226,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30226,1,3,0)
 ;;=3^Sezary Disease,Unspec Site
 ;;^UTILITY(U,$J,358.3,30226,1,4,0)
 ;;=4^C84.10
 ;;^UTILITY(U,$J,358.3,30226,2)
 ;;=^5001631
 ;;^UTILITY(U,$J,358.3,30227,0)
 ;;=C84.19^^118^1502^72
 ;;^UTILITY(U,$J,358.3,30227,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30227,1,3,0)
 ;;=3^Sezary Disease,Extrnod/Solid Organ Sites
 ;;^UTILITY(U,$J,358.3,30227,1,4,0)
 ;;=4^C84.19
 ;;^UTILITY(U,$J,358.3,30227,2)
 ;;=^5001640
 ;;^UTILITY(U,$J,358.3,30228,0)
 ;;=C84.40^^118^1502^70
 ;;^UTILITY(U,$J,358.3,30228,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30228,1,3,0)
 ;;=3^Peripheral T-Cell Lymphoma,Unspec Site NEC
 ;;^UTILITY(U,$J,358.3,30228,1,4,0)
 ;;=4^C84.40
 ;;^UTILITY(U,$J,358.3,30228,2)
 ;;=^5001641
 ;;^UTILITY(U,$J,358.3,30229,0)
 ;;=C84.49^^118^1502^69
 ;;^UTILITY(U,$J,358.3,30229,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30229,1,3,0)
 ;;=3^Peripheral T-Cell Lymphoma,Extrnod/Solid Organ Sites NEC
 ;;^UTILITY(U,$J,358.3,30229,1,4,0)
 ;;=4^C84.49
 ;;^UTILITY(U,$J,358.3,30229,2)
 ;;=^5001650
 ;;^UTILITY(U,$J,358.3,30230,0)
 ;;=C77.0^^118^1503^14
 ;;^UTILITY(U,$J,358.3,30230,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30230,1,3,0)
 ;;=3^Secondary malignant neoplasm of nodes of head, face and neck
 ;;^UTILITY(U,$J,358.3,30230,1,4,0)
 ;;=4^C77.0
 ;;^UTILITY(U,$J,358.3,30230,2)
 ;;=^5001329
 ;;^UTILITY(U,$J,358.3,30231,0)
 ;;=C77.1^^118^1503^9
 ;;^UTILITY(U,$J,358.3,30231,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30231,1,3,0)
 ;;=3^Secondary malignant neoplasm of intrathorac nodes
 ;;^UTILITY(U,$J,358.3,30231,1,4,0)
 ;;=4^C77.1
 ;;^UTILITY(U,$J,358.3,30231,2)
 ;;=^267315
 ;;^UTILITY(U,$J,358.3,30232,0)
 ;;=C77.2^^118^1503^7
 ;;^UTILITY(U,$J,358.3,30232,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30232,1,3,0)
 ;;=3^Secondary malignant neoplasm of intra-abd nodes
 ;;^UTILITY(U,$J,358.3,30232,1,4,0)
 ;;=4^C77.2
 ;;^UTILITY(U,$J,358.3,30232,2)
 ;;=^267316
 ;;^UTILITY(U,$J,358.3,30233,0)
 ;;=C77.3^^118^1503^1
 ;;^UTILITY(U,$J,358.3,30233,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30233,1,3,0)
 ;;=3^Secondary malignant neoplasm of axilla and upper limb nodes
