IBDEI07K ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,2966,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2966,1,3,0)
 ;;=3^GB & Bile Duct Calculus w/o Cholecyst w/ Obstruction
 ;;^UTILITY(U,$J,358.3,2966,1,4,0)
 ;;=4^K80.71
 ;;^UTILITY(U,$J,358.3,2966,2)
 ;;=^5133640
 ;;^UTILITY(U,$J,358.3,2967,0)
 ;;=K82.9^^28^245^32
 ;;^UTILITY(U,$J,358.3,2967,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2967,1,3,0)
 ;;=3^Gallbladder Disease,Unspec
 ;;^UTILITY(U,$J,358.3,2967,1,4,0)
 ;;=4^K82.9
 ;;^UTILITY(U,$J,358.3,2967,2)
 ;;=^5008875
 ;;^UTILITY(U,$J,358.3,2968,0)
 ;;=R14.1^^28^245^33
 ;;^UTILITY(U,$J,358.3,2968,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2968,1,3,0)
 ;;=3^Gas Pain
 ;;^UTILITY(U,$J,358.3,2968,1,4,0)
 ;;=4^R14.1
 ;;^UTILITY(U,$J,358.3,2968,2)
 ;;=^5019241
 ;;^UTILITY(U,$J,358.3,2969,0)
 ;;=A09.^^28^245^34
 ;;^UTILITY(U,$J,358.3,2969,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2969,1,3,0)
 ;;=3^Gastroenteritis & Colitis,Infectious,Unspec
 ;;^UTILITY(U,$J,358.3,2969,1,4,0)
 ;;=4^A09.
 ;;^UTILITY(U,$J,358.3,2969,2)
 ;;=^5000061
 ;;^UTILITY(U,$J,358.3,2970,0)
 ;;=K52.9^^28^245^35
 ;;^UTILITY(U,$J,358.3,2970,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2970,1,3,0)
 ;;=3^Gastroenteritis & Colitis,Noninfectious,Unspec
 ;;^UTILITY(U,$J,358.3,2970,1,4,0)
 ;;=4^K52.9
 ;;^UTILITY(U,$J,358.3,2970,2)
 ;;=^5008704
 ;;^UTILITY(U,$J,358.3,2971,0)
 ;;=K21.0^^28^245^30
 ;;^UTILITY(U,$J,358.3,2971,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2971,1,3,0)
 ;;=3^GERD w/ Esophagitis
 ;;^UTILITY(U,$J,358.3,2971,1,4,0)
 ;;=4^K21.0
 ;;^UTILITY(U,$J,358.3,2971,2)
 ;;=^5008504
 ;;^UTILITY(U,$J,358.3,2972,0)
 ;;=K21.9^^28^245^31
 ;;^UTILITY(U,$J,358.3,2972,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2972,1,3,0)
 ;;=3^GERD w/o Esophagitis
 ;;^UTILITY(U,$J,358.3,2972,1,4,0)
 ;;=4^K21.9
 ;;^UTILITY(U,$J,358.3,2972,2)
 ;;=^5008505
 ;;^UTILITY(U,$J,358.3,2973,0)
 ;;=K64.4^^28^245^36
 ;;^UTILITY(U,$J,358.3,2973,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2973,1,3,0)
 ;;=3^Hemorrhoidal Skin Tags,Residual
 ;;^UTILITY(U,$J,358.3,2973,1,4,0)
 ;;=4^K64.4
 ;;^UTILITY(U,$J,358.3,2973,2)
 ;;=^269834
 ;;^UTILITY(U,$J,358.3,2974,0)
 ;;=K64.8^^28^245^37
 ;;^UTILITY(U,$J,358.3,2974,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2974,1,3,0)
 ;;=3^Hemorrhoids,Other
 ;;^UTILITY(U,$J,358.3,2974,1,4,0)
 ;;=4^K64.8
 ;;^UTILITY(U,$J,358.3,2974,2)
 ;;=^5008774
 ;;^UTILITY(U,$J,358.3,2975,0)
 ;;=K64.5^^28^245^38
 ;;^UTILITY(U,$J,358.3,2975,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2975,1,3,0)
 ;;=3^Hemorrhoids,Perianal Venous Thrombosis
 ;;^UTILITY(U,$J,358.3,2975,1,4,0)
 ;;=4^K64.5
 ;;^UTILITY(U,$J,358.3,2975,2)
 ;;=^5008773
 ;;^UTILITY(U,$J,358.3,2976,0)
 ;;=K70.9^^28^245^46
 ;;^UTILITY(U,$J,358.3,2976,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2976,1,3,0)
 ;;=3^Hepatic Liver Disease,Alcoholic,Unspec
 ;;^UTILITY(U,$J,358.3,2976,1,4,0)
 ;;=4^K70.9
 ;;^UTILITY(U,$J,358.3,2976,2)
 ;;=^5008792
 ;;^UTILITY(U,$J,358.3,2977,0)
 ;;=K75.9^^28^245^47
 ;;^UTILITY(U,$J,358.3,2977,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2977,1,3,0)
 ;;=3^Hepatic Liver Disease,Inflammatory,Unspec
 ;;^UTILITY(U,$J,358.3,2977,1,4,0)
 ;;=4^K75.9
 ;;^UTILITY(U,$J,358.3,2977,2)
 ;;=^5008830
 ;;^UTILITY(U,$J,358.3,2978,0)
 ;;=K71.9^^28^245^48
 ;;^UTILITY(U,$J,358.3,2978,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2978,1,3,0)
 ;;=3^Hepatic Liver Disease,Toxic,Unspec
 ;;^UTILITY(U,$J,358.3,2978,1,4,0)
 ;;=4^K71.9
 ;;^UTILITY(U,$J,358.3,2978,2)
 ;;=^5008804
 ;;^UTILITY(U,$J,358.3,2979,0)
 ;;=K76.9^^28^245^49
 ;;^UTILITY(U,$J,358.3,2979,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2979,1,3,0)
 ;;=3^Hepatic Liver Disease,Unspec
