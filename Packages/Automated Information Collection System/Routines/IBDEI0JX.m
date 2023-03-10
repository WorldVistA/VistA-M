IBDEI0JX ; ; 01-FEB-2022
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 01, 2022
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,8964,1,3,0)
 ;;=3^Tick-Borne Viral Encephalitis,Other
 ;;^UTILITY(U,$J,358.3,8964,1,4,0)
 ;;=4^A84.89
 ;;^UTILITY(U,$J,358.3,8964,2)
 ;;=^5159072
 ;;^UTILITY(U,$J,358.3,8965,0)
 ;;=A84.9^^39^403^86
 ;;^UTILITY(U,$J,358.3,8965,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8965,1,3,0)
 ;;=3^Tick-Borne Viral Encephalitis,Unspec
 ;;^UTILITY(U,$J,358.3,8965,1,4,0)
 ;;=4^A84.9
 ;;^UTILITY(U,$J,358.3,8965,2)
 ;;=^5000426
 ;;^UTILITY(U,$J,358.3,8966,0)
 ;;=Z11.52^^39^403^17
 ;;^UTILITY(U,$J,358.3,8966,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8966,1,3,0)
 ;;=3^COVID-19 Screening
 ;;^UTILITY(U,$J,358.3,8966,1,4,0)
 ;;=4^Z11.52
 ;;^UTILITY(U,$J,358.3,8966,2)
 ;;=^5160186
 ;;^UTILITY(U,$J,358.3,8967,0)
 ;;=Z20.822^^39^403^21
 ;;^UTILITY(U,$J,358.3,8967,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8967,1,3,0)
 ;;=3^Contact with & Suspected Exposure to COVID-19
 ;;^UTILITY(U,$J,358.3,8967,1,4,0)
 ;;=4^Z20.822
 ;;^UTILITY(U,$J,358.3,8967,2)
 ;;=^5160187
 ;;^UTILITY(U,$J,358.3,8968,0)
 ;;=Z86.16^^39^403^68
 ;;^UTILITY(U,$J,358.3,8968,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8968,1,3,0)
 ;;=3^Personal Hx of COVID-19
 ;;^UTILITY(U,$J,358.3,8968,1,4,0)
 ;;=4^Z86.16
 ;;^UTILITY(U,$J,358.3,8968,2)
 ;;=^5160188
 ;;^UTILITY(U,$J,358.3,8969,0)
 ;;=K70.0^^39^404^3
 ;;^UTILITY(U,$J,358.3,8969,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8969,1,3,0)
 ;;=3^Alcoholic Fatty Liver
 ;;^UTILITY(U,$J,358.3,8969,1,4,0)
 ;;=4^K70.0
 ;;^UTILITY(U,$J,358.3,8969,2)
 ;;=^5008784
 ;;^UTILITY(U,$J,358.3,8970,0)
 ;;=K70.11^^39^404^7
 ;;^UTILITY(U,$J,358.3,8970,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8970,1,3,0)
 ;;=3^Alcoholic Hepatitis w/ Ascites
 ;;^UTILITY(U,$J,358.3,8970,1,4,0)
 ;;=4^K70.11
 ;;^UTILITY(U,$J,358.3,8970,2)
 ;;=^5008786
 ;;^UTILITY(U,$J,358.3,8971,0)
 ;;=K70.10^^39^404^8
 ;;^UTILITY(U,$J,358.3,8971,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8971,1,3,0)
 ;;=3^Alcoholic Hepatitis w/o Ascites
 ;;^UTILITY(U,$J,358.3,8971,1,4,0)
 ;;=4^K70.10
 ;;^UTILITY(U,$J,358.3,8971,2)
 ;;=^5008785
 ;;^UTILITY(U,$J,358.3,8972,0)
 ;;=K70.2^^39^404^4
 ;;^UTILITY(U,$J,358.3,8972,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8972,1,3,0)
 ;;=3^Alcoholic Fibrosis & Sclerosis of Liver
 ;;^UTILITY(U,$J,358.3,8972,1,4,0)
 ;;=4^K70.2
 ;;^UTILITY(U,$J,358.3,8972,2)
 ;;=^5008787
 ;;^UTILITY(U,$J,358.3,8973,0)
 ;;=K70.30^^39^404^2
 ;;^UTILITY(U,$J,358.3,8973,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8973,1,3,0)
 ;;=3^Alcoholic Cirrhosis of Liver w/o Ascites
 ;;^UTILITY(U,$J,358.3,8973,1,4,0)
 ;;=4^K70.30
 ;;^UTILITY(U,$J,358.3,8973,2)
 ;;=^5008788
 ;;^UTILITY(U,$J,358.3,8974,0)
 ;;=K70.31^^39^404^1
 ;;^UTILITY(U,$J,358.3,8974,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8974,1,3,0)
 ;;=3^Alcoholic Cirrhosis of Liver w/ Ascites
 ;;^UTILITY(U,$J,358.3,8974,1,4,0)
 ;;=4^K70.31
 ;;^UTILITY(U,$J,358.3,8974,2)
 ;;=^5008789
 ;;^UTILITY(U,$J,358.3,8975,0)
 ;;=K70.9^^39^404^9
 ;;^UTILITY(U,$J,358.3,8975,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8975,1,3,0)
 ;;=3^Alcoholic Liver Disease,Unspec
 ;;^UTILITY(U,$J,358.3,8975,1,4,0)
 ;;=4^K70.9
 ;;^UTILITY(U,$J,358.3,8975,2)
 ;;=^5008792
 ;;^UTILITY(U,$J,358.3,8976,0)
 ;;=K70.40^^39^404^6
 ;;^UTILITY(U,$J,358.3,8976,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8976,1,3,0)
 ;;=3^Alcoholic Hepatic Failure w/o Coma
 ;;^UTILITY(U,$J,358.3,8976,1,4,0)
 ;;=4^K70.40
 ;;^UTILITY(U,$J,358.3,8976,2)
 ;;=^5008790
