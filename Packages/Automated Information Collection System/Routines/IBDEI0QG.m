IBDEI0QG ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,12395,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12395,1,3,0)
 ;;=3^Alcoholic cirrhosis of liver with ascites
 ;;^UTILITY(U,$J,358.3,12395,1,4,0)
 ;;=4^K70.31
 ;;^UTILITY(U,$J,358.3,12395,2)
 ;;=^5008789
 ;;^UTILITY(U,$J,358.3,12396,0)
 ;;=K70.9^^50^560^7
 ;;^UTILITY(U,$J,358.3,12396,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12396,1,3,0)
 ;;=3^Alcoholic liver disease, unspecified
 ;;^UTILITY(U,$J,358.3,12396,1,4,0)
 ;;=4^K70.9
 ;;^UTILITY(U,$J,358.3,12396,2)
 ;;=^5008792
 ;;^UTILITY(U,$J,358.3,12397,0)
 ;;=C22.0^^50^560^17
 ;;^UTILITY(U,$J,358.3,12397,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12397,1,3,0)
 ;;=3^Liver cell carcinoma
 ;;^UTILITY(U,$J,358.3,12397,1,4,0)
 ;;=4^C22.0
 ;;^UTILITY(U,$J,358.3,12397,2)
 ;;=^5000933
 ;;^UTILITY(U,$J,358.3,12398,0)
 ;;=C22.7^^50^560^8
 ;;^UTILITY(U,$J,358.3,12398,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12398,1,3,0)
 ;;=3^Carcinomas of Liver NEC
 ;;^UTILITY(U,$J,358.3,12398,1,4,0)
 ;;=4^C22.7
 ;;^UTILITY(U,$J,358.3,12398,2)
 ;;=^5000938
 ;;^UTILITY(U,$J,358.3,12399,0)
 ;;=C22.8^^50^560^18
 ;;^UTILITY(U,$J,358.3,12399,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12399,1,3,0)
 ;;=3^Malignant neoplasm of liver, primary, unspecified as to type
 ;;^UTILITY(U,$J,358.3,12399,1,4,0)
 ;;=4^C22.8
 ;;^UTILITY(U,$J,358.3,12399,2)
 ;;=^5000939
 ;;^UTILITY(U,$J,358.3,12400,0)
 ;;=C22.1^^50^560^16
 ;;^UTILITY(U,$J,358.3,12400,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12400,1,3,0)
 ;;=3^Intrahepatic bile duct carcinoma
 ;;^UTILITY(U,$J,358.3,12400,1,4,0)
 ;;=4^C22.1
 ;;^UTILITY(U,$J,358.3,12400,2)
 ;;=^5000934
 ;;^UTILITY(U,$J,358.3,12401,0)
 ;;=C78.7^^50^560^20
 ;;^UTILITY(U,$J,358.3,12401,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12401,1,3,0)
 ;;=3^Secondary malig neoplasm of liver and intrahepatic bile duct
 ;;^UTILITY(U,$J,358.3,12401,1,4,0)
 ;;=4^C78.7
 ;;^UTILITY(U,$J,358.3,12401,2)
 ;;=^5001339
 ;;^UTILITY(U,$J,358.3,12402,0)
 ;;=K85.9^^50^561^2
 ;;^UTILITY(U,$J,358.3,12402,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12402,1,3,0)
 ;;=3^Acute pancreatitis, unspecified
 ;;^UTILITY(U,$J,358.3,12402,1,4,0)
 ;;=4^K85.9
 ;;^UTILITY(U,$J,358.3,12402,2)
 ;;=^5008887
 ;;^UTILITY(U,$J,358.3,12403,0)
 ;;=K85.8^^50^561^1
 ;;^UTILITY(U,$J,358.3,12403,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12403,1,3,0)
 ;;=3^Acute pancreatitis NEC
 ;;^UTILITY(U,$J,358.3,12403,1,4,0)
 ;;=4^K85.8
 ;;^UTILITY(U,$J,358.3,12403,2)
 ;;=^5008886
 ;;^UTILITY(U,$J,358.3,12404,0)
 ;;=K85.3^^50^561^9
 ;;^UTILITY(U,$J,358.3,12404,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12404,1,3,0)
 ;;=3^Drug induced acute pancreatitis
 ;;^UTILITY(U,$J,358.3,12404,1,4,0)
 ;;=4^K85.3
 ;;^UTILITY(U,$J,358.3,12404,2)
 ;;=^5008885
 ;;^UTILITY(U,$J,358.3,12405,0)
 ;;=K85.2^^50^561^3
 ;;^UTILITY(U,$J,358.3,12405,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12405,1,3,0)
 ;;=3^Alcohol induced acute pancreatitis
 ;;^UTILITY(U,$J,358.3,12405,1,4,0)
 ;;=4^K85.2
 ;;^UTILITY(U,$J,358.3,12405,2)
 ;;=^5008884
 ;;^UTILITY(U,$J,358.3,12406,0)
 ;;=K85.1^^50^561^5
 ;;^UTILITY(U,$J,358.3,12406,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12406,1,3,0)
 ;;=3^Biliary acute pancreatitis
 ;;^UTILITY(U,$J,358.3,12406,1,4,0)
 ;;=4^K85.1
 ;;^UTILITY(U,$J,358.3,12406,2)
 ;;=^5008883
 ;;^UTILITY(U,$J,358.3,12407,0)
 ;;=K85.0^^50^561^10
 ;;^UTILITY(U,$J,358.3,12407,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12407,1,3,0)
 ;;=3^Idiopathic acute pancreatitis
 ;;^UTILITY(U,$J,358.3,12407,1,4,0)
 ;;=4^K85.0
 ;;^UTILITY(U,$J,358.3,12407,2)
 ;;=^5008882
 ;;^UTILITY(U,$J,358.3,12408,0)
 ;;=B25.2^^50^561^8
