IBDEI37B ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,53779,1,4,0)
 ;;=4^K75.4
 ;;^UTILITY(U,$J,358.3,53779,2)
 ;;=^336610
 ;;^UTILITY(U,$J,358.3,53780,0)
 ;;=K74.69^^253^2722^10
 ;;^UTILITY(U,$J,358.3,53780,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,53780,1,3,0)
 ;;=3^Cirrhosis of liver NEC
 ;;^UTILITY(U,$J,358.3,53780,1,4,0)
 ;;=4^K74.69
 ;;^UTILITY(U,$J,358.3,53780,2)
 ;;=^5008823
 ;;^UTILITY(U,$J,358.3,53781,0)
 ;;=K74.3^^253^2722^20
 ;;^UTILITY(U,$J,358.3,53781,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,53781,1,3,0)
 ;;=3^Primary biliary cirrhosis
 ;;^UTILITY(U,$J,358.3,53781,1,4,0)
 ;;=4^K74.3
 ;;^UTILITY(U,$J,358.3,53781,2)
 ;;=^5008819
 ;;^UTILITY(U,$J,358.3,53782,0)
 ;;=K75.81^^253^2722^19
 ;;^UTILITY(U,$J,358.3,53782,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,53782,1,3,0)
 ;;=3^Nonalcoholic steatohepatitis (NASH)
 ;;^UTILITY(U,$J,358.3,53782,1,4,0)
 ;;=4^K75.81
 ;;^UTILITY(U,$J,358.3,53782,2)
 ;;=K830^5008828
 ;;^UTILITY(U,$J,358.3,53783,0)
 ;;=B16.9^^253^2722^1
 ;;^UTILITY(U,$J,358.3,53783,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,53783,1,3,0)
 ;;=3^Acute hepatitis B w/o delta-agent and without hepatic coma
 ;;^UTILITY(U,$J,358.3,53783,1,4,0)
 ;;=4^B16.9
 ;;^UTILITY(U,$J,358.3,53783,2)
 ;;=^5000540
 ;;^UTILITY(U,$J,358.3,53784,0)
 ;;=B18.1^^253^2722^8
 ;;^UTILITY(U,$J,358.3,53784,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,53784,1,3,0)
 ;;=3^Chronic viral hepatitis B without delta-agent
 ;;^UTILITY(U,$J,358.3,53784,1,4,0)
 ;;=4^B18.1
 ;;^UTILITY(U,$J,358.3,53784,2)
 ;;=^5000547
 ;;^UTILITY(U,$J,358.3,53785,0)
 ;;=Z94.4^^253^2722^16
 ;;^UTILITY(U,$J,358.3,53785,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,53785,1,3,0)
 ;;=3^Liver transplant status
 ;;^UTILITY(U,$J,358.3,53785,1,4,0)
 ;;=4^Z94.4
 ;;^UTILITY(U,$J,358.3,53785,2)
 ;;=^5063658
 ;;^UTILITY(U,$J,358.3,53786,0)
 ;;=J90.^^253^2723^12
 ;;^UTILITY(U,$J,358.3,53786,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,53786,1,3,0)
 ;;=3^Pleural effusion, not elsewhere classified
 ;;^UTILITY(U,$J,358.3,53786,1,4,0)
 ;;=4^J90.
 ;;^UTILITY(U,$J,358.3,53786,2)
 ;;=^5008310
 ;;^UTILITY(U,$J,358.3,53787,0)
 ;;=C34.91^^253^2723^9
 ;;^UTILITY(U,$J,358.3,53787,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,53787,1,3,0)
 ;;=3^Malignant neoplasm of unsp part of right bronchus or lung
 ;;^UTILITY(U,$J,358.3,53787,1,4,0)
 ;;=4^C34.91
 ;;^UTILITY(U,$J,358.3,53787,2)
 ;;=^5000967
 ;;^UTILITY(U,$J,358.3,53788,0)
 ;;=C34.92^^253^2723^8
 ;;^UTILITY(U,$J,358.3,53788,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,53788,1,3,0)
 ;;=3^Malignant neoplasm of unsp part of left bronchus or lung
 ;;^UTILITY(U,$J,358.3,53788,1,4,0)
 ;;=4^C34.92
 ;;^UTILITY(U,$J,358.3,53788,2)
 ;;=^5000968
 ;;^UTILITY(U,$J,358.3,53789,0)
 ;;=C34.01^^253^2723^7
 ;;^UTILITY(U,$J,358.3,53789,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,53789,1,3,0)
 ;;=3^Malignant neoplasm of right main bronchus
 ;;^UTILITY(U,$J,358.3,53789,1,4,0)
 ;;=4^C34.01
 ;;^UTILITY(U,$J,358.3,53789,2)
 ;;=^5000958
 ;;^UTILITY(U,$J,358.3,53790,0)
 ;;=C34.02^^253^2723^1
 ;;^UTILITY(U,$J,358.3,53790,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,53790,1,3,0)
 ;;=3^Malignant neoplasm of left main bronchus
 ;;^UTILITY(U,$J,358.3,53790,1,4,0)
 ;;=4^C34.02
 ;;^UTILITY(U,$J,358.3,53790,2)
 ;;=^5000959
 ;;^UTILITY(U,$J,358.3,53791,0)
 ;;=C34.11^^253^2723^11
 ;;^UTILITY(U,$J,358.3,53791,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,53791,1,3,0)
 ;;=3^Malignant neoplasm of upper lobe, right bronchus or lung
 ;;^UTILITY(U,$J,358.3,53791,1,4,0)
 ;;=4^C34.11
 ;;^UTILITY(U,$J,358.3,53791,2)
 ;;=^5000961
 ;;^UTILITY(U,$J,358.3,53792,0)
 ;;=C34.12^^253^2723^10
