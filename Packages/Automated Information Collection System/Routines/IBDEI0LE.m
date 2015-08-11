IBDEI0LE ; ; 20-MAY-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;OCT 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,10476,0)
 ;;=459.10^^64^684^73
 ;;^UTILITY(U,$J,358.3,10476,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,10476,1,4,0)
 ;;=4^459.10
 ;;^UTILITY(U,$J,358.3,10476,1,5,0)
 ;;=5^Post Phlebotic Syndrome
 ;;^UTILITY(U,$J,358.3,10476,2)
 ;;=Post Phlebotic Syndrome^328597
 ;;^UTILITY(U,$J,358.3,10477,0)
 ;;=428.20^^64^684^50
 ;;^UTILITY(U,$J,358.3,10477,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,10477,1,4,0)
 ;;=4^428.20
 ;;^UTILITY(U,$J,358.3,10477,1,5,0)
 ;;=5^Heart Failure, Systolic, Unspec
 ;;^UTILITY(U,$J,358.3,10477,2)
 ;;=Heart Failure, Systolic^328594
 ;;^UTILITY(U,$J,358.3,10478,0)
 ;;=428.21^^64^684^42
 ;;^UTILITY(U,$J,358.3,10478,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,10478,1,4,0)
 ;;=4^428.21
 ;;^UTILITY(U,$J,358.3,10478,1,5,0)
 ;;=5^Heart Failure, Acute Systolic
 ;;^UTILITY(U,$J,358.3,10478,2)
 ;;=Heart Failure, Acute Systolic^328494
 ;;^UTILITY(U,$J,358.3,10479,0)
 ;;=428.22^^64^684^44
 ;;^UTILITY(U,$J,358.3,10479,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,10479,1,4,0)
 ;;=4^428.22
 ;;^UTILITY(U,$J,358.3,10479,1,5,0)
 ;;=5^Heart Failure, Chronic Systolic
 ;;^UTILITY(U,$J,358.3,10479,2)
 ;;=Heart Failure, Chronic Systolic^328495
 ;;^UTILITY(U,$J,358.3,10480,0)
 ;;=428.23^^64^684^49
 ;;^UTILITY(U,$J,358.3,10480,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,10480,1,4,0)
 ;;=4^428.23
 ;;^UTILITY(U,$J,358.3,10480,1,5,0)
 ;;=5^Heart Failure, Systolic, Acute on Chronic
 ;;^UTILITY(U,$J,358.3,10480,2)
 ;;=Heart Failure, Systolic, Acute on Chronic^328496
 ;;^UTILITY(U,$J,358.3,10481,0)
 ;;=428.30^^64^684^45
 ;;^UTILITY(U,$J,358.3,10481,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,10481,1,4,0)
 ;;=4^428.30
 ;;^UTILITY(U,$J,358.3,10481,1,5,0)
 ;;=5^Heart Failure, Diastolic
 ;;^UTILITY(U,$J,358.3,10481,2)
 ;;=Heart Failure, Diastolic^328595
 ;;^UTILITY(U,$J,358.3,10482,0)
 ;;=428.31^^64^684^41
 ;;^UTILITY(U,$J,358.3,10482,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,10482,1,4,0)
 ;;=4^428.31
 ;;^UTILITY(U,$J,358.3,10482,1,5,0)
 ;;=5^Heart Failure, Acute Diastolic
 ;;^UTILITY(U,$J,358.3,10482,2)
 ;;=Heart Failure, Acute Diastolic^328497
 ;;^UTILITY(U,$J,358.3,10483,0)
 ;;=428.32^^64^684^43
 ;;^UTILITY(U,$J,358.3,10483,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,10483,1,4,0)
 ;;=4^428.32
 ;;^UTILITY(U,$J,358.3,10483,1,5,0)
 ;;=5^Heart Failure, Chronic Diastolic
 ;;^UTILITY(U,$J,358.3,10483,2)
 ;;=Heart Failure, Chronic Diastolic^328498
 ;;^UTILITY(U,$J,358.3,10484,0)
 ;;=428.33^^64^684^47
 ;;^UTILITY(U,$J,358.3,10484,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,10484,1,4,0)
 ;;=4^428.33
 ;;^UTILITY(U,$J,358.3,10484,1,5,0)
 ;;=5^Heart Failure, Diastolic, Acute on Chronic
 ;;^UTILITY(U,$J,358.3,10484,2)
 ;;=Heart Failure, Diastolic, Acute on Chronic^328499
 ;;^UTILITY(U,$J,358.3,10485,0)
 ;;=428.40^^64^684^46
 ;;^UTILITY(U,$J,358.3,10485,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,10485,1,4,0)
 ;;=4^428.40
 ;;^UTILITY(U,$J,358.3,10485,1,5,0)
 ;;=5^Heart Failure, Diastolic& Systolic
 ;;^UTILITY(U,$J,358.3,10485,2)
 ;;=Heart Failure, Systolic and Diastolic^328596
 ;;^UTILITY(U,$J,358.3,10486,0)
 ;;=428.41^^64^684^48
 ;;^UTILITY(U,$J,358.3,10486,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,10486,1,4,0)
 ;;=4^428.41
 ;;^UTILITY(U,$J,358.3,10486,1,5,0)
 ;;=5^Heart Failure, Systolic & Diastolic, Acute
 ;;^UTILITY(U,$J,358.3,10486,2)
 ;;=Heart Failure, Systolic & Diastolic, Acute^328500
 ;;^UTILITY(U,$J,358.3,10487,0)
 ;;=428.42^^64^684^52
 ;;^UTILITY(U,$J,358.3,10487,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,10487,1,4,0)
 ;;=4^428.42
 ;;^UTILITY(U,$J,358.3,10487,1,5,0)
 ;;=5^Heart Failure,Systolic&Diastolic,Chronic
