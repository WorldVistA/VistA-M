IBDEI0BN ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,4981,1,2,0)
 ;;=2^Scalp/Neck/Head 1.1 - 2.0 cm Benign Excision
 ;;^UTILITY(U,$J,358.3,4981,1,4,0)
 ;;=4^11422
 ;;^UTILITY(U,$J,358.3,4982,0)
 ;;=11423^^39^333^4^^^^1
 ;;^UTILITY(U,$J,358.3,4982,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4982,1,2,0)
 ;;=2^Scalp/Neck/Head 2.1 - 3.0 cm Benign Excision
 ;;^UTILITY(U,$J,358.3,4982,1,4,0)
 ;;=4^11423
 ;;^UTILITY(U,$J,358.3,4983,0)
 ;;=11424^^39^333^5^^^^1
 ;;^UTILITY(U,$J,358.3,4983,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4983,1,2,0)
 ;;=2^Scalp/Neck/Head 3.1 - 4.0 cm Benign Excision
 ;;^UTILITY(U,$J,358.3,4983,1,4,0)
 ;;=4^11424
 ;;^UTILITY(U,$J,358.3,4984,0)
 ;;=11426^^39^333^6^^^^1
 ;;^UTILITY(U,$J,358.3,4984,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4984,1,2,0)
 ;;=2^Scalp/Neck/Head > 4.0 cm Benign Excision
 ;;^UTILITY(U,$J,358.3,4984,1,4,0)
 ;;=4^11426
 ;;^UTILITY(U,$J,358.3,4985,0)
 ;;=11440^^39^334^1^^^^1
 ;;^UTILITY(U,$J,358.3,4985,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4985,1,2,0)
 ;;=2^Face/Ear/Lip 0.5 cm or less Benign Excision
 ;;^UTILITY(U,$J,358.3,4985,1,4,0)
 ;;=4^11440
 ;;^UTILITY(U,$J,358.3,4986,0)
 ;;=11441^^39^334^2^^^^1
 ;;^UTILITY(U,$J,358.3,4986,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4986,1,2,0)
 ;;=2^Face/Ear/Lip 0.6 - 1.0 cm Benign Excision
 ;;^UTILITY(U,$J,358.3,4986,1,4,0)
 ;;=4^11441
 ;;^UTILITY(U,$J,358.3,4987,0)
 ;;=11442^^39^334^3^^^^1
 ;;^UTILITY(U,$J,358.3,4987,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4987,1,2,0)
 ;;=2^Face/Ear/Lip 1.1 - 2.0 cm Benign Excision
 ;;^UTILITY(U,$J,358.3,4987,1,4,0)
 ;;=4^11442
 ;;^UTILITY(U,$J,358.3,4988,0)
 ;;=11443^^39^334^4^^^^1
 ;;^UTILITY(U,$J,358.3,4988,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4988,1,2,0)
 ;;=2^Face/Ear/Lip 2.1 - 3.0 cm Benign Excision
 ;;^UTILITY(U,$J,358.3,4988,1,4,0)
 ;;=4^11443
 ;;^UTILITY(U,$J,358.3,4989,0)
 ;;=11444^^39^334^5^^^^1
 ;;^UTILITY(U,$J,358.3,4989,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4989,1,2,0)
 ;;=2^Face/Ear/Lip 3.1 - 4.0 cm Benign Excision
 ;;^UTILITY(U,$J,358.3,4989,1,4,0)
 ;;=4^11444
 ;;^UTILITY(U,$J,358.3,4990,0)
 ;;=11446^^39^334^6^^^^1
 ;;^UTILITY(U,$J,358.3,4990,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4990,1,2,0)
 ;;=2^Face/Ear/Lip > 4.0 cm Benign Excision
 ;;^UTILITY(U,$J,358.3,4990,1,4,0)
 ;;=4^11446
 ;;^UTILITY(U,$J,358.3,4991,0)
 ;;=11400^^39^335^1^^^^1
 ;;^UTILITY(U,$J,358.3,4991,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4991,1,2,0)
 ;;=2^Trunk/Arm/Leg 0.5 cm or less Benign Excision
 ;;^UTILITY(U,$J,358.3,4991,1,4,0)
 ;;=4^11400
 ;;^UTILITY(U,$J,358.3,4992,0)
 ;;=11401^^39^335^2^^^^1
 ;;^UTILITY(U,$J,358.3,4992,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4992,1,2,0)
 ;;=2^Trunk/Arm/Leg 0.6 - 1.0 cm Benign Excision
 ;;^UTILITY(U,$J,358.3,4992,1,4,0)
 ;;=4^11401
 ;;^UTILITY(U,$J,358.3,4993,0)
 ;;=11402^^39^335^3^^^^1
 ;;^UTILITY(U,$J,358.3,4993,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4993,1,2,0)
 ;;=2^Trunk/Arm/Leg 1.1 - 2.0 cm Benign Excision
 ;;^UTILITY(U,$J,358.3,4993,1,4,0)
 ;;=4^11402
 ;;^UTILITY(U,$J,358.3,4994,0)
 ;;=11403^^39^335^4^^^^1
 ;;^UTILITY(U,$J,358.3,4994,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4994,1,2,0)
 ;;=2^Trunk/Arm/Leg 2.1 - 3.0 cm Benign Excision
 ;;^UTILITY(U,$J,358.3,4994,1,4,0)
 ;;=4^11403
 ;;^UTILITY(U,$J,358.3,4995,0)
 ;;=11404^^39^335^5^^^^1
 ;;^UTILITY(U,$J,358.3,4995,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4995,1,2,0)
 ;;=2^Trunk/Arm/Leg 3.1 - 4.0 cm Benign Excision
 ;;^UTILITY(U,$J,358.3,4995,1,4,0)
 ;;=4^11404
 ;;^UTILITY(U,$J,358.3,4996,0)
 ;;=11406^^39^335^6^^^^1
 ;;^UTILITY(U,$J,358.3,4996,1,0)
 ;;=^358.31IA^4^2
