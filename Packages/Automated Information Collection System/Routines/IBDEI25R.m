IBDEI25R ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,36187,1,3,0)
 ;;=3^Trichomonal vulvovaginitis
 ;;^UTILITY(U,$J,358.3,36187,1,4,0)
 ;;=4^A59.01
 ;;^UTILITY(U,$J,358.3,36187,2)
 ;;=^121763
 ;;^UTILITY(U,$J,358.3,36188,0)
 ;;=D21.9^^166^1835^20
 ;;^UTILITY(U,$J,358.3,36188,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36188,1,3,0)
 ;;=3^Benign neoplasm of connective and other soft tissue, unsp
 ;;^UTILITY(U,$J,358.3,36188,1,4,0)
 ;;=4^D21.9
 ;;^UTILITY(U,$J,358.3,36188,2)
 ;;=^5002040
 ;;^UTILITY(U,$J,358.3,36189,0)
 ;;=D25.9^^166^1835^64
 ;;^UTILITY(U,$J,358.3,36189,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36189,1,3,0)
 ;;=3^Leiomyoma of uterus, unspecified
 ;;^UTILITY(U,$J,358.3,36189,1,4,0)
 ;;=4^D25.9
 ;;^UTILITY(U,$J,358.3,36189,2)
 ;;=^5002081
 ;;^UTILITY(U,$J,358.3,36190,0)
 ;;=D28.0^^166^1835^21
 ;;^UTILITY(U,$J,358.3,36190,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36190,1,3,0)
 ;;=3^Benign neoplasm of vulva
 ;;^UTILITY(U,$J,358.3,36190,1,4,0)
 ;;=4^D28.0
 ;;^UTILITY(U,$J,358.3,36190,2)
 ;;=^267650
 ;;^UTILITY(U,$J,358.3,36191,0)
 ;;=D06.9^^166^1835^23
 ;;^UTILITY(U,$J,358.3,36191,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36191,1,3,0)
 ;;=3^Carcinoma in situ of cervix, unspecified
 ;;^UTILITY(U,$J,358.3,36191,1,4,0)
 ;;=4^D06.9
 ;;^UTILITY(U,$J,358.3,36191,2)
 ;;=^5001941
 ;;^UTILITY(U,$J,358.3,36192,0)
 ;;=D06.0^^166^1835^24
 ;;^UTILITY(U,$J,358.3,36192,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36192,1,3,0)
 ;;=3^Carcinoma in situ of endocervix
 ;;^UTILITY(U,$J,358.3,36192,1,4,0)
 ;;=4^D06.0
 ;;^UTILITY(U,$J,358.3,36192,2)
 ;;=^5001938
 ;;^UTILITY(U,$J,358.3,36193,0)
 ;;=D06.1^^166^1835^25
 ;;^UTILITY(U,$J,358.3,36193,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36193,1,3,0)
 ;;=3^Carcinoma in situ of exocervix
 ;;^UTILITY(U,$J,358.3,36193,1,4,0)
 ;;=4^D06.1
 ;;^UTILITY(U,$J,358.3,36193,2)
 ;;=^5001939
 ;;^UTILITY(U,$J,358.3,36194,0)
 ;;=D06.7^^166^1835^26
 ;;^UTILITY(U,$J,358.3,36194,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36194,1,3,0)
 ;;=3^Carcinoma in situ of other parts of cervix
 ;;^UTILITY(U,$J,358.3,36194,1,4,0)
 ;;=4^D06.7
 ;;^UTILITY(U,$J,358.3,36194,2)
 ;;=^5001940
 ;;^UTILITY(U,$J,358.3,36195,0)
 ;;=E28.2^^166^1835^79
 ;;^UTILITY(U,$J,358.3,36195,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36195,1,3,0)
 ;;=3^Polycystic ovarian syndrome
 ;;^UTILITY(U,$J,358.3,36195,1,4,0)
 ;;=4^E28.2
 ;;^UTILITY(U,$J,358.3,36195,2)
 ;;=^5002749
 ;;^UTILITY(U,$J,358.3,36196,0)
 ;;=N60.11^^166^1835^38
 ;;^UTILITY(U,$J,358.3,36196,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36196,1,3,0)
 ;;=3^Diffuse cystic mastopathy of right breast
 ;;^UTILITY(U,$J,358.3,36196,1,4,0)
 ;;=4^N60.11
 ;;^UTILITY(U,$J,358.3,36196,2)
 ;;=^5015773
 ;;^UTILITY(U,$J,358.3,36197,0)
 ;;=N60.12^^166^1835^37
 ;;^UTILITY(U,$J,358.3,36197,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36197,1,3,0)
 ;;=3^Diffuse cystic mastopathy of left breast
 ;;^UTILITY(U,$J,358.3,36197,1,4,0)
 ;;=4^N60.12
 ;;^UTILITY(U,$J,358.3,36197,2)
 ;;=^5015774
 ;;^UTILITY(U,$J,358.3,36198,0)
 ;;=N64.4^^166^1835^70
 ;;^UTILITY(U,$J,358.3,36198,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36198,1,3,0)
 ;;=3^Mastodynia
 ;;^UTILITY(U,$J,358.3,36198,1,4,0)
 ;;=4^N64.4
 ;;^UTILITY(U,$J,358.3,36198,2)
 ;;=^5015794
 ;;^UTILITY(U,$J,358.3,36199,0)
 ;;=N63.^^166^1835^66
 ;;^UTILITY(U,$J,358.3,36199,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36199,1,3,0)
 ;;=3^Lump in Breast,Unspec
 ;;^UTILITY(U,$J,358.3,36199,1,4,0)
 ;;=4^N63.
 ;;^UTILITY(U,$J,358.3,36199,2)
 ;;=^5015791
 ;;^UTILITY(U,$J,358.3,36200,0)
 ;;=N70.01^^166^1835^12
 ;;^UTILITY(U,$J,358.3,36200,1,0)
 ;;=^358.31IA^4^2
