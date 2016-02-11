IBDEI25V ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,36240,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36240,1,3,0)
 ;;=3^Menopausal and female climacteric states
 ;;^UTILITY(U,$J,358.3,36240,1,4,0)
 ;;=4^N95.1
 ;;^UTILITY(U,$J,358.3,36240,2)
 ;;=^5015927
 ;;^UTILITY(U,$J,358.3,36241,0)
 ;;=N95.2^^166^1835^82
 ;;^UTILITY(U,$J,358.3,36241,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36241,1,3,0)
 ;;=3^Postmenopausal atrophic vaginitis
 ;;^UTILITY(U,$J,358.3,36241,1,4,0)
 ;;=4^N95.2
 ;;^UTILITY(U,$J,358.3,36241,2)
 ;;=^270577
 ;;^UTILITY(U,$J,358.3,36242,0)
 ;;=N95.8^^166^1835^72
 ;;^UTILITY(U,$J,358.3,36242,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36242,1,3,0)
 ;;=3^Menopausal and perimenopausal disorders
 ;;^UTILITY(U,$J,358.3,36242,1,4,0)
 ;;=4^N95.8
 ;;^UTILITY(U,$J,358.3,36242,2)
 ;;=^5015928
 ;;^UTILITY(U,$J,358.3,36243,0)
 ;;=N97.9^^166^1835^52
 ;;^UTILITY(U,$J,358.3,36243,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36243,1,3,0)
 ;;=3^Female infertility, unspecified
 ;;^UTILITY(U,$J,358.3,36243,1,4,0)
 ;;=4^N97.9
 ;;^UTILITY(U,$J,358.3,36243,2)
 ;;=^5015935
 ;;^UTILITY(U,$J,358.3,36244,0)
 ;;=R63.0^^166^1835^17
 ;;^UTILITY(U,$J,358.3,36244,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36244,1,3,0)
 ;;=3^Anorexia
 ;;^UTILITY(U,$J,358.3,36244,1,4,0)
 ;;=4^R63.0
 ;;^UTILITY(U,$J,358.3,36244,2)
 ;;=^7939
 ;;^UTILITY(U,$J,358.3,36245,0)
 ;;=R30.0^^166^1835^42
 ;;^UTILITY(U,$J,358.3,36245,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36245,1,3,0)
 ;;=3^Dysuria
 ;;^UTILITY(U,$J,358.3,36245,1,4,0)
 ;;=4^R30.0
 ;;^UTILITY(U,$J,358.3,36245,2)
 ;;=^5019322
 ;;^UTILITY(U,$J,358.3,36246,0)
 ;;=R10.9^^166^1835^1
 ;;^UTILITY(U,$J,358.3,36246,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36246,1,3,0)
 ;;=3^Abdominal Pain,Unspec
 ;;^UTILITY(U,$J,358.3,36246,1,4,0)
 ;;=4^R10.9
 ;;^UTILITY(U,$J,358.3,36246,2)
 ;;=^5019230
 ;;^UTILITY(U,$J,358.3,36247,0)
 ;;=R19.00^^166^1835^63
 ;;^UTILITY(U,$J,358.3,36247,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36247,1,3,0)
 ;;=3^Intra-abd and pelvic swelling, mass and lump, unsp site
 ;;^UTILITY(U,$J,358.3,36247,1,4,0)
 ;;=4^R19.00
 ;;^UTILITY(U,$J,358.3,36247,2)
 ;;=^5019254
 ;;^UTILITY(U,$J,358.3,36248,0)
 ;;=R92.8^^166^1835^2
 ;;^UTILITY(U,$J,358.3,36248,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36248,1,3,0)
 ;;=3^Abn and inconclusive findings on dx imaging of breast NEC
 ;;^UTILITY(U,$J,358.3,36248,1,4,0)
 ;;=4^R92.8
 ;;^UTILITY(U,$J,358.3,36248,2)
 ;;=^5019712
 ;;^UTILITY(U,$J,358.3,36249,0)
 ;;=R92.0^^166^1835^69
 ;;^UTILITY(U,$J,358.3,36249,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36249,1,3,0)
 ;;=3^Mammographic microcalcification found on dx imaging of brst
 ;;^UTILITY(U,$J,358.3,36249,1,4,0)
 ;;=4^R92.0
 ;;^UTILITY(U,$J,358.3,36249,2)
 ;;=^5019709
 ;;^UTILITY(U,$J,358.3,36250,0)
 ;;=R92.1^^166^1835^68
 ;;^UTILITY(U,$J,358.3,36250,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36250,1,3,0)
 ;;=3^Mammographic calcifcn found on diagnostic imaging of breast
 ;;^UTILITY(U,$J,358.3,36250,1,4,0)
 ;;=4^R92.1
 ;;^UTILITY(U,$J,358.3,36250,2)
 ;;=^5019710
 ;;^UTILITY(U,$J,358.3,36251,0)
 ;;=R92.2^^166^1835^58
 ;;^UTILITY(U,$J,358.3,36251,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36251,1,3,0)
 ;;=3^Inconclusive mammogram
 ;;^UTILITY(U,$J,358.3,36251,1,4,0)
 ;;=4^R92.2
 ;;^UTILITY(U,$J,358.3,36251,2)
 ;;=^5019711
 ;;^UTILITY(U,$J,358.3,36252,0)
 ;;=R87.619^^166^1835^3
 ;;^UTILITY(U,$J,358.3,36252,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36252,1,3,0)
 ;;=3^Abnormal cytolog findings in specmn from cervix uteri,Unspec
 ;;^UTILITY(U,$J,358.3,36252,1,4,0)
 ;;=4^R87.619
 ;;^UTILITY(U,$J,358.3,36252,2)
 ;;=^5019676
