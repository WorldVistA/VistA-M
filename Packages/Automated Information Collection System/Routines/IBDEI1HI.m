IBDEI1HI ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,23733,2)
 ;;=^5007246
 ;;^UTILITY(U,$J,358.3,23734,0)
 ;;=J96.22^^105^1186^8
 ;;^UTILITY(U,$J,358.3,23734,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23734,1,3,0)
 ;;=3^Acute and Chronic Respiratory Failure w/ Hypercapnia
 ;;^UTILITY(U,$J,358.3,23734,1,4,0)
 ;;=4^J96.22
 ;;^UTILITY(U,$J,358.3,23734,2)
 ;;=^5008355
 ;;^UTILITY(U,$J,358.3,23735,0)
 ;;=J96.21^^105^1186^9
 ;;^UTILITY(U,$J,358.3,23735,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23735,1,3,0)
 ;;=3^Acute and Chronic Respiratory Failure w/ Hypoxia
 ;;^UTILITY(U,$J,358.3,23735,1,4,0)
 ;;=4^J96.21
 ;;^UTILITY(U,$J,358.3,23735,2)
 ;;=^5008354
 ;;^UTILITY(U,$J,358.3,23736,0)
 ;;=I50.23^^105^1186^11
 ;;^UTILITY(U,$J,358.3,23736,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23736,1,3,0)
 ;;=3^Acute on Chronic Systolic Congestive Heart Failure
 ;;^UTILITY(U,$J,358.3,23736,1,4,0)
 ;;=4^I50.23
 ;;^UTILITY(U,$J,358.3,23736,2)
 ;;=^5007242
 ;;^UTILITY(U,$J,358.3,23737,0)
 ;;=K85.90^^105^1186^3
 ;;^UTILITY(U,$J,358.3,23737,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23737,1,3,0)
 ;;=3^Acute Pancreatitis,Unspec
 ;;^UTILITY(U,$J,358.3,23737,1,4,0)
 ;;=4^K85.90
 ;;^UTILITY(U,$J,358.3,23737,2)
 ;;=^5138761
 ;;^UTILITY(U,$J,358.3,23738,0)
 ;;=J81.0^^105^1186^4
 ;;^UTILITY(U,$J,358.3,23738,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23738,1,3,0)
 ;;=3^Acute Pulmonary Edema
 ;;^UTILITY(U,$J,358.3,23738,1,4,0)
 ;;=4^J81.0
 ;;^UTILITY(U,$J,358.3,23738,2)
 ;;=^5008295
 ;;^UTILITY(U,$J,358.3,23739,0)
 ;;=J96.02^^105^1186^5
 ;;^UTILITY(U,$J,358.3,23739,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23739,1,3,0)
 ;;=3^Acute Respiratory Failure w/ Hypercapnia
 ;;^UTILITY(U,$J,358.3,23739,1,4,0)
 ;;=4^J96.02
 ;;^UTILITY(U,$J,358.3,23739,2)
 ;;=^5008349
 ;;^UTILITY(U,$J,358.3,23740,0)
 ;;=J96.01^^105^1186^6
 ;;^UTILITY(U,$J,358.3,23740,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23740,1,3,0)
 ;;=3^Acute Respiratory Failure w/ Hypoxia
 ;;^UTILITY(U,$J,358.3,23740,1,4,0)
 ;;=4^J96.01
 ;;^UTILITY(U,$J,358.3,23740,2)
 ;;=^5008348
 ;;^UTILITY(U,$J,358.3,23741,0)
 ;;=I50.21^^105^1186^7
 ;;^UTILITY(U,$J,358.3,23741,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23741,1,3,0)
 ;;=3^Acute Systolic Congestive Heart Failure
 ;;^UTILITY(U,$J,358.3,23741,1,4,0)
 ;;=4^I50.21
 ;;^UTILITY(U,$J,358.3,23741,2)
 ;;=^5007240
 ;;^UTILITY(U,$J,358.3,23742,0)
 ;;=K70.31^^105^1186^12
 ;;^UTILITY(U,$J,358.3,23742,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23742,1,3,0)
 ;;=3^Alcohol Cirrhosis of Liver w/ Ascites
 ;;^UTILITY(U,$J,358.3,23742,1,4,0)
 ;;=4^K70.31
 ;;^UTILITY(U,$J,358.3,23742,2)
 ;;=^5008789
 ;;^UTILITY(U,$J,358.3,23743,0)
 ;;=F10.231^^105^1186^13
 ;;^UTILITY(U,$J,358.3,23743,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23743,1,3,0)
 ;;=3^Alcohol Dependence w/ Withdrawal Delirium
 ;;^UTILITY(U,$J,358.3,23743,1,4,0)
 ;;=4^F10.231
 ;;^UTILITY(U,$J,358.3,23743,2)
 ;;=^5003087
 ;;^UTILITY(U,$J,358.3,23744,0)
 ;;=K70.30^^105^1186^14
 ;;^UTILITY(U,$J,358.3,23744,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23744,1,3,0)
 ;;=3^Alcoholic Cirrhosis of Liver w/o Ascites
 ;;^UTILITY(U,$J,358.3,23744,1,4,0)
 ;;=4^K70.30
 ;;^UTILITY(U,$J,358.3,23744,2)
 ;;=^5008788
 ;;^UTILITY(U,$J,358.3,23745,0)
 ;;=J15.9^^105^1186^16
 ;;^UTILITY(U,$J,358.3,23745,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23745,1,3,0)
 ;;=3^Bacterial Pneumonia,Unspec
 ;;^UTILITY(U,$J,358.3,23745,1,4,0)
 ;;=4^J15.9
