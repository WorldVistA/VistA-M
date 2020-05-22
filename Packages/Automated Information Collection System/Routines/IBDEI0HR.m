IBDEI0HR ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,7732,1,3,0)
 ;;=3^Right Heart Failure,Acute
 ;;^UTILITY(U,$J,358.3,7732,1,4,0)
 ;;=4^I50.811
 ;;^UTILITY(U,$J,358.3,7732,2)
 ;;=^5151385
 ;;^UTILITY(U,$J,358.3,7733,0)
 ;;=I50.812^^63^498^70
 ;;^UTILITY(U,$J,358.3,7733,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7733,1,3,0)
 ;;=3^Right Heart Failure,Chronic
 ;;^UTILITY(U,$J,358.3,7733,1,4,0)
 ;;=4^I50.812
 ;;^UTILITY(U,$J,358.3,7733,2)
 ;;=^5151386
 ;;^UTILITY(U,$J,358.3,7734,0)
 ;;=I50.813^^63^498^69
 ;;^UTILITY(U,$J,358.3,7734,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7734,1,3,0)
 ;;=3^Right Heart Failure,Acute on Chronic
 ;;^UTILITY(U,$J,358.3,7734,1,4,0)
 ;;=4^I50.813
 ;;^UTILITY(U,$J,358.3,7734,2)
 ;;=^5151387
 ;;^UTILITY(U,$J,358.3,7735,0)
 ;;=I50.814^^63^498^67
 ;;^UTILITY(U,$J,358.3,7735,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7735,1,3,0)
 ;;=3^Right Heart Failure d/t Left Heart Failure
 ;;^UTILITY(U,$J,358.3,7735,1,4,0)
 ;;=4^I50.814
 ;;^UTILITY(U,$J,358.3,7735,2)
 ;;=^5151388
 ;;^UTILITY(U,$J,358.3,7736,0)
 ;;=I48.20^^63^498^19
 ;;^UTILITY(U,$J,358.3,7736,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7736,1,3,0)
 ;;=3^Atrial Fibrillation,Chronic,Unspec
 ;;^UTILITY(U,$J,358.3,7736,1,4,0)
 ;;=4^I48.20
 ;;^UTILITY(U,$J,358.3,7736,2)
 ;;=^5158048
 ;;^UTILITY(U,$J,358.3,7737,0)
 ;;=I48.21^^63^498^22
 ;;^UTILITY(U,$J,358.3,7737,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7737,1,3,0)
 ;;=3^Atrial Fibrillation,Permanent
 ;;^UTILITY(U,$J,358.3,7737,1,4,0)
 ;;=4^I48.21
 ;;^UTILITY(U,$J,358.3,7737,2)
 ;;=^304710
 ;;^UTILITY(U,$J,358.3,7738,0)
 ;;=I48.11^^63^498^20
 ;;^UTILITY(U,$J,358.3,7738,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7738,1,3,0)
 ;;=3^Atrial Fibrillation,Longstanding Persistent
 ;;^UTILITY(U,$J,358.3,7738,1,4,0)
 ;;=4^I48.11
 ;;^UTILITY(U,$J,358.3,7738,2)
 ;;=^5158046
 ;;^UTILITY(U,$J,358.3,7739,0)
 ;;=I48.19^^63^498^18
 ;;^UTILITY(U,$J,358.3,7739,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7739,1,3,0)
 ;;=3^Atrial Fibrillation,Chronic
 ;;^UTILITY(U,$J,358.3,7739,1,4,0)
 ;;=4^I48.19
 ;;^UTILITY(U,$J,358.3,7739,2)
 ;;=^5158047
 ;;^UTILITY(U,$J,358.3,7740,0)
 ;;=F10.239^^63^499^2
 ;;^UTILITY(U,$J,358.3,7740,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7740,1,3,0)
 ;;=3^Alcohol Dependence w/ Withdrawal,Unspec
 ;;^UTILITY(U,$J,358.3,7740,1,4,0)
 ;;=4^F10.239
 ;;^UTILITY(U,$J,358.3,7740,2)
 ;;=^5003089
 ;;^UTILITY(U,$J,358.3,7741,0)
 ;;=F10.231^^63^499^1
 ;;^UTILITY(U,$J,358.3,7741,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7741,1,3,0)
 ;;=3^Alcohol Dependence w/ Withdrawal Delirium
 ;;^UTILITY(U,$J,358.3,7741,1,4,0)
 ;;=4^F10.231
 ;;^UTILITY(U,$J,358.3,7741,2)
 ;;=^5003087
 ;;^UTILITY(U,$J,358.3,7742,0)
 ;;=R56.9^^63^499^4
 ;;^UTILITY(U,$J,358.3,7742,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7742,1,3,0)
 ;;=3^Convulsions,Unspec
 ;;^UTILITY(U,$J,358.3,7742,1,4,0)
 ;;=4^R56.9
 ;;^UTILITY(U,$J,358.3,7742,2)
 ;;=^5019524
 ;;^UTILITY(U,$J,358.3,7743,0)
 ;;=K70.30^^63^499^3
 ;;^UTILITY(U,$J,358.3,7743,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7743,1,3,0)
 ;;=3^Alcoholic Cirrhosis of Liver w/o Ascites
 ;;^UTILITY(U,$J,358.3,7743,1,4,0)
 ;;=4^K70.30
 ;;^UTILITY(U,$J,358.3,7743,2)
 ;;=^5008788
 ;;^UTILITY(U,$J,358.3,7744,0)
 ;;=K72.90^^63^499^5
 ;;^UTILITY(U,$J,358.3,7744,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7744,1,3,0)
 ;;=3^Hepatic Failure
 ;;^UTILITY(U,$J,358.3,7744,1,4,0)
 ;;=4^K72.90
