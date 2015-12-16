IBDEI0GA ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,7551,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,7551,1,4,0)
 ;;=4^428.20
 ;;^UTILITY(U,$J,358.3,7551,1,5,0)
 ;;=5^Heart Failure, Systolic, Unspec
 ;;^UTILITY(U,$J,358.3,7551,2)
 ;;=Heart Failure, Systolic^328594
 ;;^UTILITY(U,$J,358.3,7552,0)
 ;;=428.21^^35^472^42
 ;;^UTILITY(U,$J,358.3,7552,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,7552,1,4,0)
 ;;=4^428.21
 ;;^UTILITY(U,$J,358.3,7552,1,5,0)
 ;;=5^Heart Failure, Acute Systolic
 ;;^UTILITY(U,$J,358.3,7552,2)
 ;;=Heart Failure, Acute Systolic^328494
 ;;^UTILITY(U,$J,358.3,7553,0)
 ;;=428.22^^35^472^44
 ;;^UTILITY(U,$J,358.3,7553,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,7553,1,4,0)
 ;;=4^428.22
 ;;^UTILITY(U,$J,358.3,7553,1,5,0)
 ;;=5^Heart Failure, Chronic Systolic
 ;;^UTILITY(U,$J,358.3,7553,2)
 ;;=Heart Failure, Chronic Systolic^328495
 ;;^UTILITY(U,$J,358.3,7554,0)
 ;;=428.23^^35^472^49
 ;;^UTILITY(U,$J,358.3,7554,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,7554,1,4,0)
 ;;=4^428.23
 ;;^UTILITY(U,$J,358.3,7554,1,5,0)
 ;;=5^Heart Failure, Systolic, Acute on Chronic
 ;;^UTILITY(U,$J,358.3,7554,2)
 ;;=Heart Failure, Systolic, Acute on Chronic^328496
 ;;^UTILITY(U,$J,358.3,7555,0)
 ;;=428.30^^35^472^45
 ;;^UTILITY(U,$J,358.3,7555,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,7555,1,4,0)
 ;;=4^428.30
 ;;^UTILITY(U,$J,358.3,7555,1,5,0)
 ;;=5^Heart Failure, Diastolic
 ;;^UTILITY(U,$J,358.3,7555,2)
 ;;=Heart Failure, Diastolic^328595
 ;;^UTILITY(U,$J,358.3,7556,0)
 ;;=428.31^^35^472^41
 ;;^UTILITY(U,$J,358.3,7556,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,7556,1,4,0)
 ;;=4^428.31
 ;;^UTILITY(U,$J,358.3,7556,1,5,0)
 ;;=5^Heart Failure, Acute Diastolic
 ;;^UTILITY(U,$J,358.3,7556,2)
 ;;=Heart Failure, Acute Diastolic^328497
 ;;^UTILITY(U,$J,358.3,7557,0)
 ;;=428.32^^35^472^43
 ;;^UTILITY(U,$J,358.3,7557,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,7557,1,4,0)
 ;;=4^428.32
 ;;^UTILITY(U,$J,358.3,7557,1,5,0)
 ;;=5^Heart Failure, Chronic Diastolic
 ;;^UTILITY(U,$J,358.3,7557,2)
 ;;=Heart Failure, Chronic Diastolic^328498
 ;;^UTILITY(U,$J,358.3,7558,0)
 ;;=428.33^^35^472^47
 ;;^UTILITY(U,$J,358.3,7558,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,7558,1,4,0)
 ;;=4^428.33
 ;;^UTILITY(U,$J,358.3,7558,1,5,0)
 ;;=5^Heart Failure, Diastolic, Acute on Chronic
 ;;^UTILITY(U,$J,358.3,7558,2)
 ;;=Heart Failure, Diastolic, Acute on Chronic^328499
 ;;^UTILITY(U,$J,358.3,7559,0)
 ;;=428.40^^35^472^46
 ;;^UTILITY(U,$J,358.3,7559,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,7559,1,4,0)
 ;;=4^428.40
 ;;^UTILITY(U,$J,358.3,7559,1,5,0)
 ;;=5^Heart Failure, Diastolic& Systolic
 ;;^UTILITY(U,$J,358.3,7559,2)
 ;;=Heart Failure, Systolic and Diastolic^328596
 ;;^UTILITY(U,$J,358.3,7560,0)
 ;;=428.41^^35^472^48
 ;;^UTILITY(U,$J,358.3,7560,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,7560,1,4,0)
 ;;=4^428.41
 ;;^UTILITY(U,$J,358.3,7560,1,5,0)
 ;;=5^Heart Failure, Systolic & Diastolic, Acute
 ;;^UTILITY(U,$J,358.3,7560,2)
 ;;=Heart Failure, Systolic & Diastolic, Acute^328500
 ;;^UTILITY(U,$J,358.3,7561,0)
 ;;=428.42^^35^472^52
 ;;^UTILITY(U,$J,358.3,7561,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,7561,1,4,0)
 ;;=4^428.42
 ;;^UTILITY(U,$J,358.3,7561,1,5,0)
 ;;=5^Heart Failure,Systolic&Diastolic,Chronic
 ;;^UTILITY(U,$J,358.3,7561,2)
 ;;=^328501
 ;;^UTILITY(U,$J,358.3,7562,0)
 ;;=428.43^^35^472^51
 ;;^UTILITY(U,$J,358.3,7562,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,7562,1,4,0)
 ;;=4^428.43
 ;;^UTILITY(U,$J,358.3,7562,1,5,0)
 ;;=5^Heart Failure,Systolic&Diastolic
 ;;^UTILITY(U,$J,358.3,7562,2)
 ;;=^328502
 ;;^UTILITY(U,$J,358.3,7563,0)
 ;;=396.3^^35^472^10
