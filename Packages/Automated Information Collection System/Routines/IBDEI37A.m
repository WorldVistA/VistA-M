IBDEI37A ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,53766,1,4,0)
 ;;=4^B19.20
 ;;^UTILITY(U,$J,358.3,53766,2)
 ;;=^331436
 ;;^UTILITY(U,$J,358.3,53767,0)
 ;;=B19.21^^253^2722^22
 ;;^UTILITY(U,$J,358.3,53767,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,53767,1,3,0)
 ;;=3^Viral hepatitis C with hepatic coma,Unspec
 ;;^UTILITY(U,$J,358.3,53767,1,4,0)
 ;;=4^B19.21
 ;;^UTILITY(U,$J,358.3,53767,2)
 ;;=^331437
 ;;^UTILITY(U,$J,358.3,53768,0)
 ;;=C22.0^^253^2722^15
 ;;^UTILITY(U,$J,358.3,53768,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,53768,1,3,0)
 ;;=3^Liver cell carcinoma
 ;;^UTILITY(U,$J,358.3,53768,1,4,0)
 ;;=4^C22.0
 ;;^UTILITY(U,$J,358.3,53768,2)
 ;;=^5000933
 ;;^UTILITY(U,$J,358.3,53769,0)
 ;;=C22.7^^253^2722^7
 ;;^UTILITY(U,$J,358.3,53769,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,53769,1,3,0)
 ;;=3^Carcinomas of liver NEC
 ;;^UTILITY(U,$J,358.3,53769,1,4,0)
 ;;=4^C22.7
 ;;^UTILITY(U,$J,358.3,53769,2)
 ;;=^5000938
 ;;^UTILITY(U,$J,358.3,53770,0)
 ;;=C22.8^^253^2722^18
 ;;^UTILITY(U,$J,358.3,53770,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,53770,1,3,0)
 ;;=3^Malignant neoplasm of liver, primary
 ;;^UTILITY(U,$J,358.3,53770,1,4,0)
 ;;=4^C22.8
 ;;^UTILITY(U,$J,358.3,53770,2)
 ;;=^5000939
 ;;^UTILITY(U,$J,358.3,53771,0)
 ;;=C22.1^^253^2722^13
 ;;^UTILITY(U,$J,358.3,53771,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,53771,1,3,0)
 ;;=3^Intrahepatic bile duct carcinoma
 ;;^UTILITY(U,$J,358.3,53771,1,4,0)
 ;;=4^C22.1
 ;;^UTILITY(U,$J,358.3,53771,2)
 ;;=^5000934
 ;;^UTILITY(U,$J,358.3,53772,0)
 ;;=C22.9^^253^2722^17
 ;;^UTILITY(U,$J,358.3,53772,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,53772,1,3,0)
 ;;=3^Malignant neoplasm of liver
 ;;^UTILITY(U,$J,358.3,53772,1,4,0)
 ;;=4^C22.9
 ;;^UTILITY(U,$J,358.3,53772,2)
 ;;=^267096
 ;;^UTILITY(U,$J,358.3,53773,0)
 ;;=C78.7^^253^2722^21
 ;;^UTILITY(U,$J,358.3,53773,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,53773,1,3,0)
 ;;=3^Secondary malig neoplasm of liver and intrahepatic bile duct
 ;;^UTILITY(U,$J,358.3,53773,1,4,0)
 ;;=4^C78.7
 ;;^UTILITY(U,$J,358.3,53773,2)
 ;;=^5001339
 ;;^UTILITY(U,$J,358.3,53774,0)
 ;;=K74.60^^253^2722^11
 ;;^UTILITY(U,$J,358.3,53774,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,53774,1,3,0)
 ;;=3^Cirrhosis of liver,Unspec
 ;;^UTILITY(U,$J,358.3,53774,1,4,0)
 ;;=4^K74.60
 ;;^UTILITY(U,$J,358.3,53774,2)
 ;;=^5008822
 ;;^UTILITY(U,$J,358.3,53775,0)
 ;;=K76.0^^253^2722^12
 ;;^UTILITY(U,$J,358.3,53775,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,53775,1,3,0)
 ;;=3^Fatty (change of) liver, not elsewhere classified
 ;;^UTILITY(U,$J,358.3,53775,1,4,0)
 ;;=4^K76.0
 ;;^UTILITY(U,$J,358.3,53775,2)
 ;;=^5008831
 ;;^UTILITY(U,$J,358.3,53776,0)
 ;;=K76.89^^253^2722^14
 ;;^UTILITY(U,$J,358.3,53776,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,53776,1,3,0)
 ;;=3^Liver Disease NEC
 ;;^UTILITY(U,$J,358.3,53776,1,4,0)
 ;;=4^K76.89
 ;;^UTILITY(U,$J,358.3,53776,2)
 ;;=^5008835
 ;;^UTILITY(U,$J,358.3,53777,0)
 ;;=K70.30^^253^2722^5
 ;;^UTILITY(U,$J,358.3,53777,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,53777,1,3,0)
 ;;=3^Alcoholic cirrhosis of liver without ascites
 ;;^UTILITY(U,$J,358.3,53777,1,4,0)
 ;;=4^K70.30
 ;;^UTILITY(U,$J,358.3,53777,2)
 ;;=^5008788
 ;;^UTILITY(U,$J,358.3,53778,0)
 ;;=K70.31^^253^2722^4
 ;;^UTILITY(U,$J,358.3,53778,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,53778,1,3,0)
 ;;=3^Alcoholic cirrhosis of liver with ascites
 ;;^UTILITY(U,$J,358.3,53778,1,4,0)
 ;;=4^K70.31
 ;;^UTILITY(U,$J,358.3,53778,2)
 ;;=^5008789
 ;;^UTILITY(U,$J,358.3,53779,0)
 ;;=K75.4^^253^2722^6
 ;;^UTILITY(U,$J,358.3,53779,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,53779,1,3,0)
 ;;=3^Autoimmune hepatitis
