IBDEI0BO ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,4996,1,2,0)
 ;;=2^Trunk/Arm/Leg > 4.0 cm Benign Excision
 ;;^UTILITY(U,$J,358.3,4996,1,4,0)
 ;;=4^11406
 ;;^UTILITY(U,$J,358.3,4997,0)
 ;;=11640^^39^336^1^^^^1
 ;;^UTILITY(U,$J,358.3,4997,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4997,1,2,0)
 ;;=2^Face/Ear/Nose 0.5 cm or less Malig Excision
 ;;^UTILITY(U,$J,358.3,4997,1,4,0)
 ;;=4^11640
 ;;^UTILITY(U,$J,358.3,4998,0)
 ;;=11641^^39^336^1^^^^1
 ;;^UTILITY(U,$J,358.3,4998,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4998,1,2,0)
 ;;=2^Face/Ear/Nose 0.6 - 1.0 cm Malig Excision
 ;;^UTILITY(U,$J,358.3,4998,1,4,0)
 ;;=4^11641
 ;;^UTILITY(U,$J,358.3,4999,0)
 ;;=11642^^39^336^2^^^^1
 ;;^UTILITY(U,$J,358.3,4999,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4999,1,2,0)
 ;;=2^Face/Ear/Nose 1.1 - 2.0 cm Malig Excision
 ;;^UTILITY(U,$J,358.3,4999,1,4,0)
 ;;=4^11642
 ;;^UTILITY(U,$J,358.3,5000,0)
 ;;=11643^^39^336^3^^^^1
 ;;^UTILITY(U,$J,358.3,5000,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5000,1,2,0)
 ;;=2^Face/Ear/Nose 2.1 - 3.0 cm Malig Excision
 ;;^UTILITY(U,$J,358.3,5000,1,4,0)
 ;;=4^11643
 ;;^UTILITY(U,$J,358.3,5001,0)
 ;;=11644^^39^336^4^^^^1
 ;;^UTILITY(U,$J,358.3,5001,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5001,1,2,0)
 ;;=2^Face/Ear/Nose 3.1 - 4.0 cm Malig Excision
 ;;^UTILITY(U,$J,358.3,5001,1,4,0)
 ;;=4^11644
 ;;^UTILITY(U,$J,358.3,5002,0)
 ;;=11646^^39^336^6^^^^1
 ;;^UTILITY(U,$J,358.3,5002,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5002,1,2,0)
 ;;=2^Face/Ear/Nose > 4.0 cm Malig Excision
 ;;^UTILITY(U,$J,358.3,5002,1,4,0)
 ;;=4^11646
 ;;^UTILITY(U,$J,358.3,5003,0)
 ;;=11620^^39^337^1^^^^1
 ;;^UTILITY(U,$J,358.3,5003,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5003,1,2,0)
 ;;=2^Scalp/Neck/Head 0.5 cm or less Malig Excision
 ;;^UTILITY(U,$J,358.3,5003,1,4,0)
 ;;=4^11620
 ;;^UTILITY(U,$J,358.3,5004,0)
 ;;=11621^^39^337^2^^^^1
 ;;^UTILITY(U,$J,358.3,5004,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5004,1,2,0)
 ;;=2^Scalp/Neck/Head 0.6 - 1.0 cm Malig Excision
 ;;^UTILITY(U,$J,358.3,5004,1,4,0)
 ;;=4^11621
 ;;^UTILITY(U,$J,358.3,5005,0)
 ;;=11622^^39^337^3^^^^1
 ;;^UTILITY(U,$J,358.3,5005,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5005,1,2,0)
 ;;=2^Scalp/Neck/Head 1.1 - 2.0 cm Malig Excision
 ;;^UTILITY(U,$J,358.3,5005,1,4,0)
 ;;=4^11622
 ;;^UTILITY(U,$J,358.3,5006,0)
 ;;=11623^^39^337^4^^^^1
 ;;^UTILITY(U,$J,358.3,5006,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5006,1,2,0)
 ;;=2^Scalp/Neck/Head 2.1 - 3.0 cm Malig Excision
 ;;^UTILITY(U,$J,358.3,5006,1,4,0)
 ;;=4^11623
 ;;^UTILITY(U,$J,358.3,5007,0)
 ;;=11624^^39^337^5^^^^1
 ;;^UTILITY(U,$J,358.3,5007,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5007,1,2,0)
 ;;=2^Scalp/Neck/Head 3.1 - 4.0 cm Malig Excision
 ;;^UTILITY(U,$J,358.3,5007,1,4,0)
 ;;=4^11624
 ;;^UTILITY(U,$J,358.3,5008,0)
 ;;=11626^^39^337^6^^^^1
 ;;^UTILITY(U,$J,358.3,5008,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5008,1,2,0)
 ;;=2^Scalp/Neck/Head > 4.0 cm Malig Excision
 ;;^UTILITY(U,$J,358.3,5008,1,4,0)
 ;;=4^11626
 ;;^UTILITY(U,$J,358.3,5009,0)
 ;;=11600^^39^338^1^^^^1
 ;;^UTILITY(U,$J,358.3,5009,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5009,1,2,0)
 ;;=2^Trunk/Arm/Leg 0.5 cm or less Malig Excision
 ;;^UTILITY(U,$J,358.3,5009,1,4,0)
 ;;=4^11600
 ;;^UTILITY(U,$J,358.3,5010,0)
 ;;=11601^^39^338^2^^^^1
 ;;^UTILITY(U,$J,358.3,5010,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5010,1,2,0)
 ;;=2^Trunk/Arm/Leg 0.6 - 1.0 cm Malig Excision
 ;;^UTILITY(U,$J,358.3,5010,1,4,0)
 ;;=4^11601
 ;;^UTILITY(U,$J,358.3,5011,0)
 ;;=11602^^39^338^3^^^^1
 ;;^UTILITY(U,$J,358.3,5011,1,0)
 ;;=^358.31IA^4^2
