IBDEI25N ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,36138,2)
 ;;=^5062860
 ;;^UTILITY(U,$J,358.3,36139,0)
 ;;=Z34.82^^166^1834^21
 ;;^UTILITY(U,$J,358.3,36139,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36139,1,3,0)
 ;;=3^Suprvsn of normal pregnancy, second trimester
 ;;^UTILITY(U,$J,358.3,36139,1,4,0)
 ;;=4^Z34.82
 ;;^UTILITY(U,$J,358.3,36139,2)
 ;;=^5062861
 ;;^UTILITY(U,$J,358.3,36140,0)
 ;;=Z34.83^^166^1834^22
 ;;^UTILITY(U,$J,358.3,36140,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36140,1,3,0)
 ;;=3^Suprvsn of normal pregnancy, third trimester
 ;;^UTILITY(U,$J,358.3,36140,1,4,0)
 ;;=4^Z34.83
 ;;^UTILITY(U,$J,358.3,36140,2)
 ;;=^5062862
 ;;^UTILITY(U,$J,358.3,36141,0)
 ;;=Z33.1^^166^1834^9
 ;;^UTILITY(U,$J,358.3,36141,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36141,1,3,0)
 ;;=3^Pregnant state, incidental
 ;;^UTILITY(U,$J,358.3,36141,1,4,0)
 ;;=4^Z33.1
 ;;^UTILITY(U,$J,358.3,36141,2)
 ;;=^5062853
 ;;^UTILITY(U,$J,358.3,36142,0)
 ;;=O09.01^^166^1834^32
 ;;^UTILITY(U,$J,358.3,36142,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36142,1,3,0)
 ;;=3^Suprvsn of preg w history of infertility, first trimester
 ;;^UTILITY(U,$J,358.3,36142,1,4,0)
 ;;=4^O09.01
 ;;^UTILITY(U,$J,358.3,36142,2)
 ;;=^5016049
 ;;^UTILITY(U,$J,358.3,36143,0)
 ;;=O09.02^^166^1834^33
 ;;^UTILITY(U,$J,358.3,36143,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36143,1,3,0)
 ;;=3^Suprvsn of preg w history of infertility, second trimester
 ;;^UTILITY(U,$J,358.3,36143,1,4,0)
 ;;=4^O09.02
 ;;^UTILITY(U,$J,358.3,36143,2)
 ;;=^5016050
 ;;^UTILITY(U,$J,358.3,36144,0)
 ;;=O09.03^^166^1834^34
 ;;^UTILITY(U,$J,358.3,36144,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36144,1,3,0)
 ;;=3^Suprvsn of preg w history of infertility, third trimester
 ;;^UTILITY(U,$J,358.3,36144,1,4,0)
 ;;=4^O09.03
 ;;^UTILITY(U,$J,358.3,36144,2)
 ;;=^5016051
 ;;^UTILITY(U,$J,358.3,36145,0)
 ;;=O09.11^^166^1834^29
 ;;^UTILITY(U,$J,358.3,36145,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36145,1,3,0)
 ;;=3^Suprvsn of preg w history of ect or molar preg, first tri
 ;;^UTILITY(U,$J,358.3,36145,1,4,0)
 ;;=4^O09.11
 ;;^UTILITY(U,$J,358.3,36145,2)
 ;;=^5016053
 ;;^UTILITY(U,$J,358.3,36146,0)
 ;;=O09.12^^166^1834^30
 ;;^UTILITY(U,$J,358.3,36146,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36146,1,3,0)
 ;;=3^Suprvsn of preg w history of ect or molar preg, second tri
 ;;^UTILITY(U,$J,358.3,36146,1,4,0)
 ;;=4^O09.12
 ;;^UTILITY(U,$J,358.3,36146,2)
 ;;=^5016054
 ;;^UTILITY(U,$J,358.3,36147,0)
 ;;=O09.13^^166^1834^31
 ;;^UTILITY(U,$J,358.3,36147,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36147,1,3,0)
 ;;=3^Suprvsn of preg w history of ect or molar preg, third tri
 ;;^UTILITY(U,$J,358.3,36147,1,4,0)
 ;;=4^O09.13
 ;;^UTILITY(U,$J,358.3,36147,2)
 ;;=^5016055
 ;;^UTILITY(U,$J,358.3,36148,0)
 ;;=O09.291^^166^1834^41
 ;;^UTILITY(U,$J,358.3,36148,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36148,1,3,0)
 ;;=3^Suprvsn of preg w poor reprodctv or obstet hx, first tri
 ;;^UTILITY(U,$J,358.3,36148,1,4,0)
 ;;=4^O09.291
 ;;^UTILITY(U,$J,358.3,36148,2)
 ;;=^5016060
 ;;^UTILITY(U,$J,358.3,36149,0)
 ;;=O09.292^^166^1834^42
 ;;^UTILITY(U,$J,358.3,36149,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36149,1,3,0)
 ;;=3^Suprvsn of preg w poor reprodctv or obstet hx, second tri
 ;;^UTILITY(U,$J,358.3,36149,1,4,0)
 ;;=4^O09.292
 ;;^UTILITY(U,$J,358.3,36149,2)
 ;;=^5016061
 ;;^UTILITY(U,$J,358.3,36150,0)
 ;;=O09.293^^166^1834^43
 ;;^UTILITY(U,$J,358.3,36150,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36150,1,3,0)
 ;;=3^Suprvsn of preg w poor reprodctv or obstet hx, third tri
 ;;^UTILITY(U,$J,358.3,36150,1,4,0)
 ;;=4^O09.293
