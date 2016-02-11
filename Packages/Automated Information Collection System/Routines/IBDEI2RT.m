IBDEI2RT ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,46512,1,3,0)
 ;;=3^Nephritic Syndrome w/ Diffuse Crescentic Glomerulonephritis,Unspec
 ;;^UTILITY(U,$J,358.3,46512,1,4,0)
 ;;=4^N05.7
 ;;^UTILITY(U,$J,358.3,46512,2)
 ;;=^5015548
 ;;^UTILITY(U,$J,358.3,46513,0)
 ;;=N05.1^^206^2301^20
 ;;^UTILITY(U,$J,358.3,46513,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,46513,1,3,0)
 ;;=3^Nephritic Syndrome w/ Focal/Segmental Glomerular Lesions,Unspec
 ;;^UTILITY(U,$J,358.3,46513,1,4,0)
 ;;=4^N05.1
 ;;^UTILITY(U,$J,358.3,46513,2)
 ;;=^5015542
 ;;^UTILITY(U,$J,358.3,46514,0)
 ;;=N05.0^^206^2301^21
 ;;^UTILITY(U,$J,358.3,46514,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,46514,1,3,0)
 ;;=3^Nephritic Syndrome w/ Minor Glomerular Abnormality,Unspec
 ;;^UTILITY(U,$J,358.3,46514,1,4,0)
 ;;=4^N05.0
 ;;^UTILITY(U,$J,358.3,46514,2)
 ;;=^5015541
 ;;^UTILITY(U,$J,358.3,46515,0)
 ;;=N05.8^^206^2301^22
 ;;^UTILITY(U,$J,358.3,46515,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,46515,1,3,0)
 ;;=3^Nephritic Syndrome w/ Morphologic Changes,Unspec
 ;;^UTILITY(U,$J,358.3,46515,1,4,0)
 ;;=4^N05.8
 ;;^UTILITY(U,$J,358.3,46515,2)
 ;;=^5134085
 ;;^UTILITY(U,$J,358.3,46516,0)
 ;;=R59.9^^206^2302^4
 ;;^UTILITY(U,$J,358.3,46516,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,46516,1,3,0)
 ;;=3^Enlarged Lymph Nodes,Unspec
 ;;^UTILITY(U,$J,358.3,46516,1,4,0)
 ;;=4^R59.9
 ;;^UTILITY(U,$J,358.3,46516,2)
 ;;=^5019531
 ;;^UTILITY(U,$J,358.3,46517,0)
 ;;=R59.1^^206^2302^2
 ;;^UTILITY(U,$J,358.3,46517,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,46517,1,3,0)
 ;;=3^Enlarged Lymph Nodes,Generalized
 ;;^UTILITY(U,$J,358.3,46517,1,4,0)
 ;;=4^R59.1
 ;;^UTILITY(U,$J,358.3,46517,2)
 ;;=^5019530
 ;;^UTILITY(U,$J,358.3,46518,0)
 ;;=R59.0^^206^2302^3
 ;;^UTILITY(U,$J,358.3,46518,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,46518,1,3,0)
 ;;=3^Enlarged Lymph Nodes,Localized
 ;;^UTILITY(U,$J,358.3,46518,1,4,0)
 ;;=4^R59.0
 ;;^UTILITY(U,$J,358.3,46518,2)
 ;;=^5019529
 ;;^UTILITY(U,$J,358.3,46519,0)
 ;;=Z79.01^^206^2302^5
 ;;^UTILITY(U,$J,358.3,46519,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,46519,1,3,0)
 ;;=3^Long Term Use of Anticoagulants
 ;;^UTILITY(U,$J,358.3,46519,1,4,0)
 ;;=4^Z79.01
 ;;^UTILITY(U,$J,358.3,46519,2)
 ;;=^5063330
 ;;^UTILITY(U,$J,358.3,46520,0)
 ;;=D64.9^^206^2302^1
 ;;^UTILITY(U,$J,358.3,46520,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,46520,1,3,0)
 ;;=3^Anemia,Unspec
 ;;^UTILITY(U,$J,358.3,46520,1,4,0)
 ;;=4^D64.9
 ;;^UTILITY(U,$J,358.3,46520,2)
 ;;=^5002351
 ;;^UTILITY(U,$J,358.3,46521,0)
 ;;=R79.9^^206^2303^1
 ;;^UTILITY(U,$J,358.3,46521,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,46521,1,3,0)
 ;;=3^Abnormal Finding of Blood Chemistry,Unspec
 ;;^UTILITY(U,$J,358.3,46521,1,4,0)
 ;;=4^R79.9
 ;;^UTILITY(U,$J,358.3,46521,2)
 ;;=^5019594
 ;;^UTILITY(U,$J,358.3,46522,0)
 ;;=R78.71^^206^2303^2
 ;;^UTILITY(U,$J,358.3,46522,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,46522,1,3,0)
 ;;=3^Abnormal Lead Level in Blood
 ;;^UTILITY(U,$J,358.3,46522,1,4,0)
 ;;=4^R78.71
 ;;^UTILITY(U,$J,358.3,46522,2)
 ;;=^5019586
 ;;^UTILITY(U,$J,358.3,46523,0)
 ;;=R79.0^^206^2303^3
 ;;^UTILITY(U,$J,358.3,46523,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,46523,1,3,0)
 ;;=3^Abnormal Level of Blood Mineral
 ;;^UTILITY(U,$J,358.3,46523,1,4,0)
 ;;=4^R79.0
 ;;^UTILITY(U,$J,358.3,46523,2)
 ;;=^5019590
 ;;^UTILITY(U,$J,358.3,46524,0)
 ;;=R78.79^^206^2303^4
 ;;^UTILITY(U,$J,358.3,46524,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,46524,1,3,0)
 ;;=3^Abnormal Level of Heavy Metals in Blood
 ;;^UTILITY(U,$J,358.3,46524,1,4,0)
 ;;=4^R78.79
 ;;^UTILITY(U,$J,358.3,46524,2)
 ;;=^5019587
 ;;^UTILITY(U,$J,358.3,46525,0)
 ;;=K74.0^^206^2303^7
