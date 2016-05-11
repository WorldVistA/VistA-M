IBDEI2D5 ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,40077,1,4,0)
 ;;=4^K74.60
 ;;^UTILITY(U,$J,358.3,40077,2)
 ;;=^5008822
 ;;^UTILITY(U,$J,358.3,40078,0)
 ;;=K76.0^^156^1950^12
 ;;^UTILITY(U,$J,358.3,40078,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40078,1,3,0)
 ;;=3^Fatty (change of) liver, not elsewhere classified
 ;;^UTILITY(U,$J,358.3,40078,1,4,0)
 ;;=4^K76.0
 ;;^UTILITY(U,$J,358.3,40078,2)
 ;;=^5008831
 ;;^UTILITY(U,$J,358.3,40079,0)
 ;;=K76.89^^156^1950^14
 ;;^UTILITY(U,$J,358.3,40079,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40079,1,3,0)
 ;;=3^Liver Disease NEC
 ;;^UTILITY(U,$J,358.3,40079,1,4,0)
 ;;=4^K76.89
 ;;^UTILITY(U,$J,358.3,40079,2)
 ;;=^5008835
 ;;^UTILITY(U,$J,358.3,40080,0)
 ;;=K70.30^^156^1950^5
 ;;^UTILITY(U,$J,358.3,40080,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40080,1,3,0)
 ;;=3^Alcoholic cirrhosis of liver without ascites
 ;;^UTILITY(U,$J,358.3,40080,1,4,0)
 ;;=4^K70.30
 ;;^UTILITY(U,$J,358.3,40080,2)
 ;;=^5008788
 ;;^UTILITY(U,$J,358.3,40081,0)
 ;;=K70.31^^156^1950^4
 ;;^UTILITY(U,$J,358.3,40081,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40081,1,3,0)
 ;;=3^Alcoholic cirrhosis of liver with ascites
 ;;^UTILITY(U,$J,358.3,40081,1,4,0)
 ;;=4^K70.31
 ;;^UTILITY(U,$J,358.3,40081,2)
 ;;=^5008789
 ;;^UTILITY(U,$J,358.3,40082,0)
 ;;=K75.4^^156^1950^6
 ;;^UTILITY(U,$J,358.3,40082,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40082,1,3,0)
 ;;=3^Autoimmune hepatitis
 ;;^UTILITY(U,$J,358.3,40082,1,4,0)
 ;;=4^K75.4
 ;;^UTILITY(U,$J,358.3,40082,2)
 ;;=^336610
 ;;^UTILITY(U,$J,358.3,40083,0)
 ;;=K74.69^^156^1950^10
 ;;^UTILITY(U,$J,358.3,40083,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40083,1,3,0)
 ;;=3^Cirrhosis of liver NEC
 ;;^UTILITY(U,$J,358.3,40083,1,4,0)
 ;;=4^K74.69
 ;;^UTILITY(U,$J,358.3,40083,2)
 ;;=^5008823
 ;;^UTILITY(U,$J,358.3,40084,0)
 ;;=K74.3^^156^1950^20
 ;;^UTILITY(U,$J,358.3,40084,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40084,1,3,0)
 ;;=3^Primary biliary cirrhosis
 ;;^UTILITY(U,$J,358.3,40084,1,4,0)
 ;;=4^K74.3
 ;;^UTILITY(U,$J,358.3,40084,2)
 ;;=^5008819
 ;;^UTILITY(U,$J,358.3,40085,0)
 ;;=K75.81^^156^1950^19
 ;;^UTILITY(U,$J,358.3,40085,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40085,1,3,0)
 ;;=3^Nonalcoholic steatohepatitis (NASH)
 ;;^UTILITY(U,$J,358.3,40085,1,4,0)
 ;;=4^K75.81
 ;;^UTILITY(U,$J,358.3,40085,2)
 ;;=K830^5008828
 ;;^UTILITY(U,$J,358.3,40086,0)
 ;;=B16.9^^156^1950^1
 ;;^UTILITY(U,$J,358.3,40086,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40086,1,3,0)
 ;;=3^Acute hepatitis B w/o delta-agent and without hepatic coma
 ;;^UTILITY(U,$J,358.3,40086,1,4,0)
 ;;=4^B16.9
 ;;^UTILITY(U,$J,358.3,40086,2)
 ;;=^5000540
 ;;^UTILITY(U,$J,358.3,40087,0)
 ;;=B18.1^^156^1950^8
 ;;^UTILITY(U,$J,358.3,40087,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40087,1,3,0)
 ;;=3^Chronic viral hepatitis B without delta-agent
 ;;^UTILITY(U,$J,358.3,40087,1,4,0)
 ;;=4^B18.1
 ;;^UTILITY(U,$J,358.3,40087,2)
 ;;=^5000547
 ;;^UTILITY(U,$J,358.3,40088,0)
 ;;=Z94.4^^156^1950^16
 ;;^UTILITY(U,$J,358.3,40088,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40088,1,3,0)
 ;;=3^Liver transplant status
 ;;^UTILITY(U,$J,358.3,40088,1,4,0)
 ;;=4^Z94.4
 ;;^UTILITY(U,$J,358.3,40088,2)
 ;;=^5063658
 ;;^UTILITY(U,$J,358.3,40089,0)
 ;;=J90.^^156^1951^12
 ;;^UTILITY(U,$J,358.3,40089,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40089,1,3,0)
 ;;=3^Pleural effusion, not elsewhere classified
 ;;^UTILITY(U,$J,358.3,40089,1,4,0)
 ;;=4^J90.
 ;;^UTILITY(U,$J,358.3,40089,2)
 ;;=^5008310
 ;;^UTILITY(U,$J,358.3,40090,0)
 ;;=C34.91^^156^1951^9
 ;;^UTILITY(U,$J,358.3,40090,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,40090,1,3,0)
 ;;=3^Malignant neoplasm of unsp part of right bronchus or lung
