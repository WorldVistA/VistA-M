IBDEI2GJ ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,39244,1,3,0)
 ;;=3^Oral Mucositis,Unspec
 ;;^UTILITY(U,$J,358.3,39244,1,4,0)
 ;;=4^K12.30
 ;;^UTILITY(U,$J,358.3,39244,2)
 ;;=^5008486
 ;;^UTILITY(U,$J,358.3,39245,0)
 ;;=J30.1^^152^1992^10
 ;;^UTILITY(U,$J,358.3,39245,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39245,1,3,0)
 ;;=3^Allergic Rhinitis d/t Pollen
 ;;^UTILITY(U,$J,358.3,39245,1,4,0)
 ;;=4^J30.1
 ;;^UTILITY(U,$J,358.3,39245,2)
 ;;=^269906
 ;;^UTILITY(U,$J,358.3,39246,0)
 ;;=R09.81^^152^1992^18
 ;;^UTILITY(U,$J,358.3,39246,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39246,1,3,0)
 ;;=3^Nasal Congestion
 ;;^UTILITY(U,$J,358.3,39246,1,4,0)
 ;;=4^R09.81
 ;;^UTILITY(U,$J,358.3,39246,2)
 ;;=^5019203
 ;;^UTILITY(U,$J,358.3,39247,0)
 ;;=I69.928^^152^1992^22
 ;;^UTILITY(U,$J,358.3,39247,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39247,1,3,0)
 ;;=3^Speech/Lang Deficit Following Cerebvasc Disease
 ;;^UTILITY(U,$J,358.3,39247,1,4,0)
 ;;=4^I69.928
 ;;^UTILITY(U,$J,358.3,39247,2)
 ;;=^5007557
 ;;^UTILITY(U,$J,358.3,39248,0)
 ;;=I69.328^^152^1992^23
 ;;^UTILITY(U,$J,358.3,39248,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39248,1,3,0)
 ;;=3^Speech/Lang Deficit Following Cerebvasc Infarc
 ;;^UTILITY(U,$J,358.3,39248,1,4,0)
 ;;=4^I69.328
 ;;^UTILITY(U,$J,358.3,39248,2)
 ;;=^5007495
 ;;^UTILITY(U,$J,358.3,39249,0)
 ;;=H81.4^^152^1992^25
 ;;^UTILITY(U,$J,358.3,39249,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39249,1,3,0)
 ;;=3^Vertigo of Central Origin
 ;;^UTILITY(U,$J,358.3,39249,1,4,0)
 ;;=4^H81.4
 ;;^UTILITY(U,$J,358.3,39249,2)
 ;;=^269484
 ;;^UTILITY(U,$J,358.3,39250,0)
 ;;=E04.0^^152^1993^21
 ;;^UTILITY(U,$J,358.3,39250,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39250,1,3,0)
 ;;=3^Nontoxic Diffuse Goiter
 ;;^UTILITY(U,$J,358.3,39250,1,4,0)
 ;;=4^E04.0
 ;;^UTILITY(U,$J,358.3,39250,2)
 ;;=^5002477
 ;;^UTILITY(U,$J,358.3,39251,0)
 ;;=E04.1^^152^1993^23
 ;;^UTILITY(U,$J,358.3,39251,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39251,1,3,0)
 ;;=3^Nontoxic Single Thyroid Nodule
 ;;^UTILITY(U,$J,358.3,39251,1,4,0)
 ;;=4^E04.1
 ;;^UTILITY(U,$J,358.3,39251,2)
 ;;=^5002478
 ;;^UTILITY(U,$J,358.3,39252,0)
 ;;=E04.2^^152^1993^22
 ;;^UTILITY(U,$J,358.3,39252,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39252,1,3,0)
 ;;=3^Nontoxic Multinodular Goiter
 ;;^UTILITY(U,$J,358.3,39252,1,4,0)
 ;;=4^E04.2
 ;;^UTILITY(U,$J,358.3,39252,2)
 ;;=^267790
 ;;^UTILITY(U,$J,358.3,39253,0)
 ;;=E01.1^^152^1993^17
 ;;^UTILITY(U,$J,358.3,39253,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39253,1,3,0)
 ;;=3^Iodine-Deficiency Related Multinodular (Endemic) Goiter
 ;;^UTILITY(U,$J,358.3,39253,1,4,0)
 ;;=4^E01.1
 ;;^UTILITY(U,$J,358.3,39253,2)
 ;;=^5002465
 ;;^UTILITY(U,$J,358.3,39254,0)
 ;;=E05.00^^152^1993^39
 ;;^UTILITY(U,$J,358.3,39254,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39254,1,3,0)
 ;;=3^Thyrotoxicosis w/ Diffuse Goiter w/o Thyrotoxic Crisis
 ;;^UTILITY(U,$J,358.3,39254,1,4,0)
 ;;=4^E05.00
 ;;^UTILITY(U,$J,358.3,39254,2)
 ;;=^5002481
 ;;^UTILITY(U,$J,358.3,39255,0)
 ;;=E05.01^^152^1993^38
 ;;^UTILITY(U,$J,358.3,39255,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39255,1,3,0)
 ;;=3^Thyrotoxicosis w/ Diffuse Goiter w/ Thyrotoxic Crisis/Storm
 ;;^UTILITY(U,$J,358.3,39255,1,4,0)
 ;;=4^E05.01
 ;;^UTILITY(U,$J,358.3,39255,2)
 ;;=^5002482
 ;;^UTILITY(U,$J,358.3,39256,0)
 ;;=E05.90^^152^1993^41
 ;;^UTILITY(U,$J,358.3,39256,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39256,1,3,0)
 ;;=3^Thyrotoxicosis,Unspec w/o Thyrotoxic Crisis/Storm
