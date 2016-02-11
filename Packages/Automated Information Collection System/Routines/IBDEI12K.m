IBDEI12K ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,17836,1,4,0)
 ;;=4^K70.30
 ;;^UTILITY(U,$J,358.3,17836,2)
 ;;=^5008788
 ;;^UTILITY(U,$J,358.3,17837,0)
 ;;=K70.31^^91^883^2
 ;;^UTILITY(U,$J,358.3,17837,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17837,1,3,0)
 ;;=3^Alcoholic cirrhosis of liver with ascites
 ;;^UTILITY(U,$J,358.3,17837,1,4,0)
 ;;=4^K70.31
 ;;^UTILITY(U,$J,358.3,17837,2)
 ;;=^5008789
 ;;^UTILITY(U,$J,358.3,17838,0)
 ;;=K70.9^^91^883^7
 ;;^UTILITY(U,$J,358.3,17838,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17838,1,3,0)
 ;;=3^Alcoholic liver disease, unspecified
 ;;^UTILITY(U,$J,358.3,17838,1,4,0)
 ;;=4^K70.9
 ;;^UTILITY(U,$J,358.3,17838,2)
 ;;=^5008792
 ;;^UTILITY(U,$J,358.3,17839,0)
 ;;=C22.0^^91^883^17
 ;;^UTILITY(U,$J,358.3,17839,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17839,1,3,0)
 ;;=3^Liver cell carcinoma
 ;;^UTILITY(U,$J,358.3,17839,1,4,0)
 ;;=4^C22.0
 ;;^UTILITY(U,$J,358.3,17839,2)
 ;;=^5000933
 ;;^UTILITY(U,$J,358.3,17840,0)
 ;;=C22.7^^91^883^8
 ;;^UTILITY(U,$J,358.3,17840,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17840,1,3,0)
 ;;=3^Carcinomas of Liver NEC
 ;;^UTILITY(U,$J,358.3,17840,1,4,0)
 ;;=4^C22.7
 ;;^UTILITY(U,$J,358.3,17840,2)
 ;;=^5000938
 ;;^UTILITY(U,$J,358.3,17841,0)
 ;;=C22.8^^91^883^18
 ;;^UTILITY(U,$J,358.3,17841,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17841,1,3,0)
 ;;=3^Malignant neoplasm of liver, primary, unspecified as to type
 ;;^UTILITY(U,$J,358.3,17841,1,4,0)
 ;;=4^C22.8
 ;;^UTILITY(U,$J,358.3,17841,2)
 ;;=^5000939
 ;;^UTILITY(U,$J,358.3,17842,0)
 ;;=C22.1^^91^883^16
 ;;^UTILITY(U,$J,358.3,17842,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17842,1,3,0)
 ;;=3^Intrahepatic bile duct carcinoma
 ;;^UTILITY(U,$J,358.3,17842,1,4,0)
 ;;=4^C22.1
 ;;^UTILITY(U,$J,358.3,17842,2)
 ;;=^5000934
 ;;^UTILITY(U,$J,358.3,17843,0)
 ;;=C78.7^^91^883^20
 ;;^UTILITY(U,$J,358.3,17843,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17843,1,3,0)
 ;;=3^Secondary malig neoplasm of liver and intrahepatic bile duct
 ;;^UTILITY(U,$J,358.3,17843,1,4,0)
 ;;=4^C78.7
 ;;^UTILITY(U,$J,358.3,17843,2)
 ;;=^5001339
 ;;^UTILITY(U,$J,358.3,17844,0)
 ;;=K85.9^^91^884^2
 ;;^UTILITY(U,$J,358.3,17844,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17844,1,3,0)
 ;;=3^Acute pancreatitis, unspecified
 ;;^UTILITY(U,$J,358.3,17844,1,4,0)
 ;;=4^K85.9
 ;;^UTILITY(U,$J,358.3,17844,2)
 ;;=^5008887
 ;;^UTILITY(U,$J,358.3,17845,0)
 ;;=K85.8^^91^884^1
 ;;^UTILITY(U,$J,358.3,17845,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17845,1,3,0)
 ;;=3^Acute pancreatitis NEC
 ;;^UTILITY(U,$J,358.3,17845,1,4,0)
 ;;=4^K85.8
 ;;^UTILITY(U,$J,358.3,17845,2)
 ;;=^5008886
 ;;^UTILITY(U,$J,358.3,17846,0)
 ;;=K85.3^^91^884^9
 ;;^UTILITY(U,$J,358.3,17846,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17846,1,3,0)
 ;;=3^Drug induced acute pancreatitis
 ;;^UTILITY(U,$J,358.3,17846,1,4,0)
 ;;=4^K85.3
 ;;^UTILITY(U,$J,358.3,17846,2)
 ;;=^5008885
 ;;^UTILITY(U,$J,358.3,17847,0)
 ;;=K85.2^^91^884^3
 ;;^UTILITY(U,$J,358.3,17847,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17847,1,3,0)
 ;;=3^Alcohol induced acute pancreatitis
 ;;^UTILITY(U,$J,358.3,17847,1,4,0)
 ;;=4^K85.2
 ;;^UTILITY(U,$J,358.3,17847,2)
 ;;=^5008884
 ;;^UTILITY(U,$J,358.3,17848,0)
 ;;=K85.1^^91^884^5
 ;;^UTILITY(U,$J,358.3,17848,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17848,1,3,0)
 ;;=3^Biliary acute pancreatitis
 ;;^UTILITY(U,$J,358.3,17848,1,4,0)
 ;;=4^K85.1
 ;;^UTILITY(U,$J,358.3,17848,2)
 ;;=^5008883
 ;;^UTILITY(U,$J,358.3,17849,0)
 ;;=K85.0^^91^884^10
 ;;^UTILITY(U,$J,358.3,17849,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17849,1,3,0)
 ;;=3^Idiopathic acute pancreatitis
