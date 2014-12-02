IBDEI0JE ; ; 12-AUG-2014
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,9495,1,4,0)
 ;;=4^428.20
 ;;^UTILITY(U,$J,358.3,9495,1,5,0)
 ;;=5^Heart Failure, Systolic, Unspec
 ;;^UTILITY(U,$J,358.3,9495,2)
 ;;=Heart Failure, Systolic^328594
 ;;^UTILITY(U,$J,358.3,9496,0)
 ;;=428.21^^67^662^42
 ;;^UTILITY(U,$J,358.3,9496,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,9496,1,4,0)
 ;;=4^428.21
 ;;^UTILITY(U,$J,358.3,9496,1,5,0)
 ;;=5^Heart Failure, Acute Systolic
 ;;^UTILITY(U,$J,358.3,9496,2)
 ;;=Heart Failure, Acute Systolic^328494
 ;;^UTILITY(U,$J,358.3,9497,0)
 ;;=428.22^^67^662^44
 ;;^UTILITY(U,$J,358.3,9497,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,9497,1,4,0)
 ;;=4^428.22
 ;;^UTILITY(U,$J,358.3,9497,1,5,0)
 ;;=5^Heart Failure, Chronic Systolic
 ;;^UTILITY(U,$J,358.3,9497,2)
 ;;=Heart Failure, Chronic Systolic^328495
 ;;^UTILITY(U,$J,358.3,9498,0)
 ;;=428.23^^67^662^49
 ;;^UTILITY(U,$J,358.3,9498,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,9498,1,4,0)
 ;;=4^428.23
 ;;^UTILITY(U,$J,358.3,9498,1,5,0)
 ;;=5^Heart Failure, Systolic, Acute on Chronic
 ;;^UTILITY(U,$J,358.3,9498,2)
 ;;=Heart Failure, Systolic, Acute on Chronic^328496
 ;;^UTILITY(U,$J,358.3,9499,0)
 ;;=428.30^^67^662^45
 ;;^UTILITY(U,$J,358.3,9499,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,9499,1,4,0)
 ;;=4^428.30
 ;;^UTILITY(U,$J,358.3,9499,1,5,0)
 ;;=5^Heart Failure, Diastolic
 ;;^UTILITY(U,$J,358.3,9499,2)
 ;;=Heart Failure, Diastolic^328595
 ;;^UTILITY(U,$J,358.3,9500,0)
 ;;=428.31^^67^662^41
 ;;^UTILITY(U,$J,358.3,9500,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,9500,1,4,0)
 ;;=4^428.31
 ;;^UTILITY(U,$J,358.3,9500,1,5,0)
 ;;=5^Heart Failure, Acute Diastolic
 ;;^UTILITY(U,$J,358.3,9500,2)
 ;;=Heart Failure, Acute Diastolic^328497
 ;;^UTILITY(U,$J,358.3,9501,0)
 ;;=428.32^^67^662^43
 ;;^UTILITY(U,$J,358.3,9501,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,9501,1,4,0)
 ;;=4^428.32
 ;;^UTILITY(U,$J,358.3,9501,1,5,0)
 ;;=5^Heart Failure, Chronic Diastolic
 ;;^UTILITY(U,$J,358.3,9501,2)
 ;;=Heart Failure, Chronic Diastolic^328498
 ;;^UTILITY(U,$J,358.3,9502,0)
 ;;=428.33^^67^662^47
 ;;^UTILITY(U,$J,358.3,9502,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,9502,1,4,0)
 ;;=4^428.33
 ;;^UTILITY(U,$J,358.3,9502,1,5,0)
 ;;=5^Heart Failure, Diastolic, Acute on Chronic
 ;;^UTILITY(U,$J,358.3,9502,2)
 ;;=Heart Failure, Diastolic, Acute on Chronic^328499
 ;;^UTILITY(U,$J,358.3,9503,0)
 ;;=428.40^^67^662^46
 ;;^UTILITY(U,$J,358.3,9503,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,9503,1,4,0)
 ;;=4^428.40
 ;;^UTILITY(U,$J,358.3,9503,1,5,0)
 ;;=5^Heart Failure, Diastolic& Systolic
 ;;^UTILITY(U,$J,358.3,9503,2)
 ;;=Heart Failure, Systolic and Diastolic^328596
 ;;^UTILITY(U,$J,358.3,9504,0)
 ;;=428.41^^67^662^48
 ;;^UTILITY(U,$J,358.3,9504,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,9504,1,4,0)
 ;;=4^428.41
 ;;^UTILITY(U,$J,358.3,9504,1,5,0)
 ;;=5^Heart Failure, Systolic & Diastolic, Acute
 ;;^UTILITY(U,$J,358.3,9504,2)
 ;;=Heart Failure, Systolic & Diastolic, Acute^328500
 ;;^UTILITY(U,$J,358.3,9505,0)
 ;;=428.42^^67^662^52
 ;;^UTILITY(U,$J,358.3,9505,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,9505,1,4,0)
 ;;=4^428.42
 ;;^UTILITY(U,$J,358.3,9505,1,5,0)
 ;;=5^Heart Failure,Systolic&Diastolic,Chronic
 ;;^UTILITY(U,$J,358.3,9505,2)
 ;;=^328501
 ;;^UTILITY(U,$J,358.3,9506,0)
 ;;=428.43^^67^662^51
 ;;^UTILITY(U,$J,358.3,9506,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,9506,1,4,0)
 ;;=4^428.43
 ;;^UTILITY(U,$J,358.3,9506,1,5,0)
 ;;=5^Heart Failure,Systolic&Diastolic
 ;;^UTILITY(U,$J,358.3,9506,2)
 ;;=^328502
 ;;^UTILITY(U,$J,358.3,9507,0)
 ;;=396.3^^67^662^10
 ;;^UTILITY(U,$J,358.3,9507,1,0)
 ;;=^358.31IA^5^2
