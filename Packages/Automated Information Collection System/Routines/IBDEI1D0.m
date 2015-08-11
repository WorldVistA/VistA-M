IBDEI1D0 ; ; 20-MAY-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;OCT 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,24395,2)
 ;;=Post Phlebotic Syndrome^328597
 ;;^UTILITY(U,$J,358.3,24396,0)
 ;;=428.20^^145^1525^50
 ;;^UTILITY(U,$J,358.3,24396,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,24396,1,4,0)
 ;;=4^428.20
 ;;^UTILITY(U,$J,358.3,24396,1,5,0)
 ;;=5^Heart Failure, Systolic, Unspec
 ;;^UTILITY(U,$J,358.3,24396,2)
 ;;=Heart Failure, Systolic^328594
 ;;^UTILITY(U,$J,358.3,24397,0)
 ;;=428.21^^145^1525^42
 ;;^UTILITY(U,$J,358.3,24397,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,24397,1,4,0)
 ;;=4^428.21
 ;;^UTILITY(U,$J,358.3,24397,1,5,0)
 ;;=5^Heart Failure, Acute Systolic
 ;;^UTILITY(U,$J,358.3,24397,2)
 ;;=Heart Failure, Acute Systolic^328494
 ;;^UTILITY(U,$J,358.3,24398,0)
 ;;=428.22^^145^1525^44
 ;;^UTILITY(U,$J,358.3,24398,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,24398,1,4,0)
 ;;=4^428.22
 ;;^UTILITY(U,$J,358.3,24398,1,5,0)
 ;;=5^Heart Failure, Chronic Systolic
 ;;^UTILITY(U,$J,358.3,24398,2)
 ;;=Heart Failure, Chronic Systolic^328495
 ;;^UTILITY(U,$J,358.3,24399,0)
 ;;=428.23^^145^1525^49
 ;;^UTILITY(U,$J,358.3,24399,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,24399,1,4,0)
 ;;=4^428.23
 ;;^UTILITY(U,$J,358.3,24399,1,5,0)
 ;;=5^Heart Failure, Systolic, Acute on Chronic
 ;;^UTILITY(U,$J,358.3,24399,2)
 ;;=Heart Failure, Systolic, Acute on Chronic^328496
 ;;^UTILITY(U,$J,358.3,24400,0)
 ;;=428.30^^145^1525^45
 ;;^UTILITY(U,$J,358.3,24400,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,24400,1,4,0)
 ;;=4^428.30
 ;;^UTILITY(U,$J,358.3,24400,1,5,0)
 ;;=5^Heart Failure, Diastolic
 ;;^UTILITY(U,$J,358.3,24400,2)
 ;;=Heart Failure, Diastolic^328595
 ;;^UTILITY(U,$J,358.3,24401,0)
 ;;=428.31^^145^1525^41
 ;;^UTILITY(U,$J,358.3,24401,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,24401,1,4,0)
 ;;=4^428.31
 ;;^UTILITY(U,$J,358.3,24401,1,5,0)
 ;;=5^Heart Failure, Acute Diastolic
 ;;^UTILITY(U,$J,358.3,24401,2)
 ;;=Heart Failure, Acute Diastolic^328497
 ;;^UTILITY(U,$J,358.3,24402,0)
 ;;=428.32^^145^1525^43
 ;;^UTILITY(U,$J,358.3,24402,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,24402,1,4,0)
 ;;=4^428.32
 ;;^UTILITY(U,$J,358.3,24402,1,5,0)
 ;;=5^Heart Failure, Chronic Diastolic
 ;;^UTILITY(U,$J,358.3,24402,2)
 ;;=Heart Failure, Chronic Diastolic^328498
 ;;^UTILITY(U,$J,358.3,24403,0)
 ;;=428.33^^145^1525^47
 ;;^UTILITY(U,$J,358.3,24403,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,24403,1,4,0)
 ;;=4^428.33
 ;;^UTILITY(U,$J,358.3,24403,1,5,0)
 ;;=5^Heart Failure, Diastolic, Acute on Chronic
 ;;^UTILITY(U,$J,358.3,24403,2)
 ;;=Heart Failure, Diastolic, Acute on Chronic^328499
 ;;^UTILITY(U,$J,358.3,24404,0)
 ;;=428.40^^145^1525^46
 ;;^UTILITY(U,$J,358.3,24404,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,24404,1,4,0)
 ;;=4^428.40
 ;;^UTILITY(U,$J,358.3,24404,1,5,0)
 ;;=5^Heart Failure, Diastolic& Systolic
 ;;^UTILITY(U,$J,358.3,24404,2)
 ;;=Heart Failure, Systolic and Diastolic^328596
 ;;^UTILITY(U,$J,358.3,24405,0)
 ;;=428.41^^145^1525^48
 ;;^UTILITY(U,$J,358.3,24405,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,24405,1,4,0)
 ;;=4^428.41
 ;;^UTILITY(U,$J,358.3,24405,1,5,0)
 ;;=5^Heart Failure, Systolic & Diastolic, Acute
 ;;^UTILITY(U,$J,358.3,24405,2)
 ;;=Heart Failure, Systolic & Diastolic, Acute^328500
 ;;^UTILITY(U,$J,358.3,24406,0)
 ;;=428.42^^145^1525^52
 ;;^UTILITY(U,$J,358.3,24406,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,24406,1,4,0)
 ;;=4^428.42
 ;;^UTILITY(U,$J,358.3,24406,1,5,0)
 ;;=5^Heart Failure,Systolic&Diastolic,Chronic
 ;;^UTILITY(U,$J,358.3,24406,2)
 ;;=^328501
 ;;^UTILITY(U,$J,358.3,24407,0)
 ;;=428.43^^145^1525^51
 ;;^UTILITY(U,$J,358.3,24407,1,0)
 ;;=^358.31IA^5^2
