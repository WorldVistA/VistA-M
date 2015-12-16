IBDEI21C ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,35568,1,3,0)
 ;;=3^Chronic kidney disease, unspecified
 ;;^UTILITY(U,$J,358.3,35568,1,4,0)
 ;;=4^N18.9
 ;;^UTILITY(U,$J,358.3,35568,2)
 ;;=^332812
 ;;^UTILITY(U,$J,358.3,35569,0)
 ;;=N19.^^189^2054^3
 ;;^UTILITY(U,$J,358.3,35569,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35569,1,3,0)
 ;;=3^Kidney failure,Unspec
 ;;^UTILITY(U,$J,358.3,35569,1,4,0)
 ;;=4^N19.
 ;;^UTILITY(U,$J,358.3,35569,2)
 ;;=^5015607
 ;;^UTILITY(U,$J,358.3,35570,0)
 ;;=B17.11^^189^2055^2
 ;;^UTILITY(U,$J,358.3,35570,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35570,1,3,0)
 ;;=3^Acute hepatitis C with hepatic coma
 ;;^UTILITY(U,$J,358.3,35570,1,4,0)
 ;;=4^B17.11
 ;;^UTILITY(U,$J,358.3,35570,2)
 ;;=^331777
 ;;^UTILITY(U,$J,358.3,35571,0)
 ;;=B18.2^^189^2055^9
 ;;^UTILITY(U,$J,358.3,35571,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35571,1,3,0)
 ;;=3^Chronic viral hepatitis C
 ;;^UTILITY(U,$J,358.3,35571,1,4,0)
 ;;=4^B18.2
 ;;^UTILITY(U,$J,358.3,35571,2)
 ;;=^5000548
 ;;^UTILITY(U,$J,358.3,35572,0)
 ;;=B17.10^^189^2055^3
 ;;^UTILITY(U,$J,358.3,35572,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35572,1,3,0)
 ;;=3^Acute hepatitis C without hepatic coma
 ;;^UTILITY(U,$J,358.3,35572,1,4,0)
 ;;=4^B17.10
 ;;^UTILITY(U,$J,358.3,35572,2)
 ;;=^5000542
 ;;^UTILITY(U,$J,358.3,35573,0)
 ;;=B19.20^^189^2055^23
 ;;^UTILITY(U,$J,358.3,35573,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35573,1,3,0)
 ;;=3^Viral hepatitis C without hepatic coma,Unspec
 ;;^UTILITY(U,$J,358.3,35573,1,4,0)
 ;;=4^B19.20
 ;;^UTILITY(U,$J,358.3,35573,2)
 ;;=^331436
 ;;^UTILITY(U,$J,358.3,35574,0)
 ;;=B19.21^^189^2055^22
 ;;^UTILITY(U,$J,358.3,35574,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35574,1,3,0)
 ;;=3^Viral hepatitis C with hepatic coma,Unspec
 ;;^UTILITY(U,$J,358.3,35574,1,4,0)
 ;;=4^B19.21
 ;;^UTILITY(U,$J,358.3,35574,2)
 ;;=^331437
 ;;^UTILITY(U,$J,358.3,35575,0)
 ;;=C22.0^^189^2055^15
 ;;^UTILITY(U,$J,358.3,35575,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35575,1,3,0)
 ;;=3^Liver cell carcinoma
 ;;^UTILITY(U,$J,358.3,35575,1,4,0)
 ;;=4^C22.0
 ;;^UTILITY(U,$J,358.3,35575,2)
 ;;=^5000933
 ;;^UTILITY(U,$J,358.3,35576,0)
 ;;=C22.7^^189^2055^7
 ;;^UTILITY(U,$J,358.3,35576,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35576,1,3,0)
 ;;=3^Carcinomas of liver NEC
 ;;^UTILITY(U,$J,358.3,35576,1,4,0)
 ;;=4^C22.7
 ;;^UTILITY(U,$J,358.3,35576,2)
 ;;=^5000938
 ;;^UTILITY(U,$J,358.3,35577,0)
 ;;=C22.8^^189^2055^18
 ;;^UTILITY(U,$J,358.3,35577,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35577,1,3,0)
 ;;=3^Malignant neoplasm of liver, primary
 ;;^UTILITY(U,$J,358.3,35577,1,4,0)
 ;;=4^C22.8
 ;;^UTILITY(U,$J,358.3,35577,2)
 ;;=^5000939
 ;;^UTILITY(U,$J,358.3,35578,0)
 ;;=C22.1^^189^2055^13
 ;;^UTILITY(U,$J,358.3,35578,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35578,1,3,0)
 ;;=3^Intrahepatic bile duct carcinoma
 ;;^UTILITY(U,$J,358.3,35578,1,4,0)
 ;;=4^C22.1
 ;;^UTILITY(U,$J,358.3,35578,2)
 ;;=^5000934
 ;;^UTILITY(U,$J,358.3,35579,0)
 ;;=C22.9^^189^2055^17
 ;;^UTILITY(U,$J,358.3,35579,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35579,1,3,0)
 ;;=3^Malignant neoplasm of liver
 ;;^UTILITY(U,$J,358.3,35579,1,4,0)
 ;;=4^C22.9
 ;;^UTILITY(U,$J,358.3,35579,2)
 ;;=^267096
 ;;^UTILITY(U,$J,358.3,35580,0)
 ;;=C78.7^^189^2055^21
 ;;^UTILITY(U,$J,358.3,35580,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35580,1,3,0)
 ;;=3^Secondary malig neoplasm of liver and intrahepatic bile duct
 ;;^UTILITY(U,$J,358.3,35580,1,4,0)
 ;;=4^C78.7
 ;;^UTILITY(U,$J,358.3,35580,2)
 ;;=^5001339
 ;;^UTILITY(U,$J,358.3,35581,0)
 ;;=K74.60^^189^2055^11
 ;;^UTILITY(U,$J,358.3,35581,1,0)
 ;;=^358.31IA^4^2
