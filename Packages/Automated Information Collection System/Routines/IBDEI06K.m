IBDEI06K ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,2547,1,4,0)
 ;;=4^K75.81
 ;;^UTILITY(U,$J,358.3,2547,2)
 ;;=^5008828
 ;;^UTILITY(U,$J,358.3,2548,0)
 ;;=K74.0^^6^76^15
 ;;^UTILITY(U,$J,358.3,2548,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2548,1,3,0)
 ;;=3^Hepatic fibrosis
 ;;^UTILITY(U,$J,358.3,2548,1,4,0)
 ;;=4^K74.0
 ;;^UTILITY(U,$J,358.3,2548,2)
 ;;=^5008816
 ;;^UTILITY(U,$J,358.3,2549,0)
 ;;=K74.60^^6^76^12
 ;;^UTILITY(U,$J,358.3,2549,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2549,1,3,0)
 ;;=3^Cirrhosis of Liver,Unspec
 ;;^UTILITY(U,$J,358.3,2549,1,4,0)
 ;;=4^K74.60
 ;;^UTILITY(U,$J,358.3,2549,2)
 ;;=^5008822
 ;;^UTILITY(U,$J,358.3,2550,0)
 ;;=K74.69^^6^76^13
 ;;^UTILITY(U,$J,358.3,2550,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2550,1,3,0)
 ;;=3^Cirrhosis of liver NEC
 ;;^UTILITY(U,$J,358.3,2550,1,4,0)
 ;;=4^K74.69
 ;;^UTILITY(U,$J,358.3,2550,2)
 ;;=^5008823
 ;;^UTILITY(U,$J,358.3,2551,0)
 ;;=K75.0^^6^76^1
 ;;^UTILITY(U,$J,358.3,2551,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2551,1,3,0)
 ;;=3^Abscess of liver
 ;;^UTILITY(U,$J,358.3,2551,1,4,0)
 ;;=4^K75.0
 ;;^UTILITY(U,$J,358.3,2551,2)
 ;;=^5008824
 ;;^UTILITY(U,$J,358.3,2552,0)
 ;;=K70.0^^6^76^4
 ;;^UTILITY(U,$J,358.3,2552,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2552,1,3,0)
 ;;=3^Alcoholic fatty liver
 ;;^UTILITY(U,$J,358.3,2552,1,4,0)
 ;;=4^K70.0
 ;;^UTILITY(U,$J,358.3,2552,2)
 ;;=^5008784
 ;;^UTILITY(U,$J,358.3,2553,0)
 ;;=K70.10^^6^76^6
 ;;^UTILITY(U,$J,358.3,2553,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2553,1,3,0)
 ;;=3^Alcoholic hepatitis without ascites
 ;;^UTILITY(U,$J,358.3,2553,1,4,0)
 ;;=4^K70.10
 ;;^UTILITY(U,$J,358.3,2553,2)
 ;;=^5008785
 ;;^UTILITY(U,$J,358.3,2554,0)
 ;;=K70.11^^6^76^5
 ;;^UTILITY(U,$J,358.3,2554,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2554,1,3,0)
 ;;=3^Alcoholic hepatitis with ascites
 ;;^UTILITY(U,$J,358.3,2554,1,4,0)
 ;;=4^K70.11
 ;;^UTILITY(U,$J,358.3,2554,2)
 ;;=^5008786
 ;;^UTILITY(U,$J,358.3,2555,0)
 ;;=K70.30^^6^76^3
 ;;^UTILITY(U,$J,358.3,2555,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2555,1,3,0)
 ;;=3^Alcoholic cirrhosis of liver without ascites
 ;;^UTILITY(U,$J,358.3,2555,1,4,0)
 ;;=4^K70.30
 ;;^UTILITY(U,$J,358.3,2555,2)
 ;;=^5008788
 ;;^UTILITY(U,$J,358.3,2556,0)
 ;;=K70.31^^6^76^2
 ;;^UTILITY(U,$J,358.3,2556,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2556,1,3,0)
 ;;=3^Alcoholic cirrhosis of liver with ascites
 ;;^UTILITY(U,$J,358.3,2556,1,4,0)
 ;;=4^K70.31
 ;;^UTILITY(U,$J,358.3,2556,2)
 ;;=^5008789
 ;;^UTILITY(U,$J,358.3,2557,0)
 ;;=K70.9^^6^76^7
 ;;^UTILITY(U,$J,358.3,2557,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2557,1,3,0)
 ;;=3^Alcoholic liver disease, unspecified
 ;;^UTILITY(U,$J,358.3,2557,1,4,0)
 ;;=4^K70.9
 ;;^UTILITY(U,$J,358.3,2557,2)
 ;;=^5008792
 ;;^UTILITY(U,$J,358.3,2558,0)
 ;;=C22.0^^6^76^17
 ;;^UTILITY(U,$J,358.3,2558,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2558,1,3,0)
 ;;=3^Liver cell carcinoma
 ;;^UTILITY(U,$J,358.3,2558,1,4,0)
 ;;=4^C22.0
 ;;^UTILITY(U,$J,358.3,2558,2)
 ;;=^5000933
 ;;^UTILITY(U,$J,358.3,2559,0)
 ;;=C22.7^^6^76^8
 ;;^UTILITY(U,$J,358.3,2559,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2559,1,3,0)
 ;;=3^Carcinomas of Liver NEC
 ;;^UTILITY(U,$J,358.3,2559,1,4,0)
 ;;=4^C22.7
 ;;^UTILITY(U,$J,358.3,2559,2)
 ;;=^5000938
 ;;^UTILITY(U,$J,358.3,2560,0)
 ;;=C22.8^^6^76^18
 ;;^UTILITY(U,$J,358.3,2560,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2560,1,3,0)
 ;;=3^Malignant neoplasm of liver, primary, unspecified as to type
 ;;^UTILITY(U,$J,358.3,2560,1,4,0)
 ;;=4^C22.8
 ;;^UTILITY(U,$J,358.3,2560,2)
 ;;=^5000939
 ;;^UTILITY(U,$J,358.3,2561,0)
 ;;=C22.1^^6^76^16
