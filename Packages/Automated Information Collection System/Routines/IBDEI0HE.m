IBDEI0HE ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,7783,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7783,1,2,0)
 ;;=2^X-Ray Chart Consultation
 ;;^UTILITY(U,$J,358.3,7783,1,3,0)
 ;;=3^76140
 ;;^UTILITY(U,$J,358.3,7784,0)
 ;;=90885^^54^526^1^^^^1
 ;;^UTILITY(U,$J,358.3,7784,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,7784,1,2,0)
 ;;=2^Chart Consult
 ;;^UTILITY(U,$J,358.3,7784,1,3,0)
 ;;=3^90885
 ;;^UTILITY(U,$J,358.3,7785,0)
 ;;=N17.1^^55^527^2
 ;;^UTILITY(U,$J,358.3,7785,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7785,1,3,0)
 ;;=3^Acute kidney failure w/ acute cortical necrosis
 ;;^UTILITY(U,$J,358.3,7785,1,4,0)
 ;;=4^N17.1
 ;;^UTILITY(U,$J,358.3,7785,2)
 ;;=^5015599
 ;;^UTILITY(U,$J,358.3,7786,0)
 ;;=N17.2^^55^527^3
 ;;^UTILITY(U,$J,358.3,7786,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7786,1,3,0)
 ;;=3^Acute kidney failure w/ medullary necrosis
 ;;^UTILITY(U,$J,358.3,7786,1,4,0)
 ;;=4^N17.2
 ;;^UTILITY(U,$J,358.3,7786,2)
 ;;=^5015600
 ;;^UTILITY(U,$J,358.3,7787,0)
 ;;=N17.8^^55^527^1
 ;;^UTILITY(U,$J,358.3,7787,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7787,1,3,0)
 ;;=3^Acute Kidney Failure NEC
 ;;^UTILITY(U,$J,358.3,7787,1,4,0)
 ;;=4^N17.8
 ;;^UTILITY(U,$J,358.3,7787,2)
 ;;=^5015601
 ;;^UTILITY(U,$J,358.3,7788,0)
 ;;=N17.9^^55^527^4
 ;;^UTILITY(U,$J,358.3,7788,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7788,1,3,0)
 ;;=3^Acute kidney failure, unspecified
 ;;^UTILITY(U,$J,358.3,7788,1,4,0)
 ;;=4^N17.9
 ;;^UTILITY(U,$J,358.3,7788,2)
 ;;=^338532
 ;;^UTILITY(U,$J,358.3,7789,0)
 ;;=I09.9^^55^528^23
 ;;^UTILITY(U,$J,358.3,7789,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7789,1,3,0)
 ;;=3^Rheumatic heart disease, unspecified
 ;;^UTILITY(U,$J,358.3,7789,1,4,0)
 ;;=4^I09.9
 ;;^UTILITY(U,$J,358.3,7789,2)
 ;;=^5007061
 ;;^UTILITY(U,$J,358.3,7790,0)
 ;;=I10.^^55^528^15
 ;;^UTILITY(U,$J,358.3,7790,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7790,1,3,0)
 ;;=3^Essential (primary) hypertension
 ;;^UTILITY(U,$J,358.3,7790,1,4,0)
 ;;=4^I10.
 ;;^UTILITY(U,$J,358.3,7790,2)
 ;;=^5007062
 ;;^UTILITY(U,$J,358.3,7791,0)
 ;;=I21.3^^55^528^25
 ;;^UTILITY(U,$J,358.3,7791,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7791,1,3,0)
 ;;=3^ST elevation (STEMI) myocardial infarction of unsp site
 ;;^UTILITY(U,$J,358.3,7791,1,4,0)
 ;;=4^I21.3
 ;;^UTILITY(U,$J,358.3,7791,2)
 ;;=^5007087
 ;;^UTILITY(U,$J,358.3,7792,0)
 ;;=I25.2^^55^528^20
 ;;^UTILITY(U,$J,358.3,7792,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7792,1,3,0)
 ;;=3^Old myocardial infarction
 ;;^UTILITY(U,$J,358.3,7792,1,4,0)
 ;;=4^I25.2
 ;;^UTILITY(U,$J,358.3,7792,2)
 ;;=^259884
 ;;^UTILITY(U,$J,358.3,7793,0)
 ;;=I20.9^^55^528^4
 ;;^UTILITY(U,$J,358.3,7793,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7793,1,3,0)
 ;;=3^Angina pectoris, unspecified
 ;;^UTILITY(U,$J,358.3,7793,1,4,0)
 ;;=4^I20.9
 ;;^UTILITY(U,$J,358.3,7793,2)
 ;;=^5007079
 ;;^UTILITY(U,$J,358.3,7794,0)
 ;;=I25.10^^55^528^6
 ;;^UTILITY(U,$J,358.3,7794,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7794,1,3,0)
 ;;=3^Athscl heart disease of native coronary artery w/o ang pctrs
 ;;^UTILITY(U,$J,358.3,7794,1,4,0)
 ;;=4^I25.10
 ;;^UTILITY(U,$J,358.3,7794,2)
 ;;=^5007107
 ;;^UTILITY(U,$J,358.3,7795,0)
 ;;=I25.5^^55^528^17
 ;;^UTILITY(U,$J,358.3,7795,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7795,1,3,0)
 ;;=3^Ischemic cardiomyopathy
 ;;^UTILITY(U,$J,358.3,7795,1,4,0)
 ;;=4^I25.5
 ;;^UTILITY(U,$J,358.3,7795,2)
 ;;=^5007115
 ;;^UTILITY(U,$J,358.3,7796,0)
 ;;=I25.89^^55^528^12
 ;;^UTILITY(U,$J,358.3,7796,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7796,1,3,0)
 ;;=3^Chronic Ischemic Heart Disease NEC
 ;;^UTILITY(U,$J,358.3,7796,1,4,0)
 ;;=4^I25.89
