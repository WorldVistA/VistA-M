IBDEI35H ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,50304,1,3,0)
 ;;=3^Oral Mucositis,Unspec
 ;;^UTILITY(U,$J,358.3,50304,1,4,0)
 ;;=4^K12.30
 ;;^UTILITY(U,$J,358.3,50304,2)
 ;;=^5008486
 ;;^UTILITY(U,$J,358.3,50305,0)
 ;;=J30.1^^193^2489^10
 ;;^UTILITY(U,$J,358.3,50305,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,50305,1,3,0)
 ;;=3^Allergic Rhinitis d/t Pollen
 ;;^UTILITY(U,$J,358.3,50305,1,4,0)
 ;;=4^J30.1
 ;;^UTILITY(U,$J,358.3,50305,2)
 ;;=^269906
 ;;^UTILITY(U,$J,358.3,50306,0)
 ;;=R09.81^^193^2489^18
 ;;^UTILITY(U,$J,358.3,50306,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,50306,1,3,0)
 ;;=3^Nasal Congestion
 ;;^UTILITY(U,$J,358.3,50306,1,4,0)
 ;;=4^R09.81
 ;;^UTILITY(U,$J,358.3,50306,2)
 ;;=^5019203
 ;;^UTILITY(U,$J,358.3,50307,0)
 ;;=I69.928^^193^2489^22
 ;;^UTILITY(U,$J,358.3,50307,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,50307,1,3,0)
 ;;=3^Speech/Lang Deficit Following Cerebvasc Disease
 ;;^UTILITY(U,$J,358.3,50307,1,4,0)
 ;;=4^I69.928
 ;;^UTILITY(U,$J,358.3,50307,2)
 ;;=^5007557
 ;;^UTILITY(U,$J,358.3,50308,0)
 ;;=I69.328^^193^2489^23
 ;;^UTILITY(U,$J,358.3,50308,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,50308,1,3,0)
 ;;=3^Speech/Lang Deficit Following Cerebvasc Infarc
 ;;^UTILITY(U,$J,358.3,50308,1,4,0)
 ;;=4^I69.328
 ;;^UTILITY(U,$J,358.3,50308,2)
 ;;=^5007495
 ;;^UTILITY(U,$J,358.3,50309,0)
 ;;=H81.4^^193^2489^25
 ;;^UTILITY(U,$J,358.3,50309,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,50309,1,3,0)
 ;;=3^Vertigo of Central Origin
 ;;^UTILITY(U,$J,358.3,50309,1,4,0)
 ;;=4^H81.4
 ;;^UTILITY(U,$J,358.3,50309,2)
 ;;=^269484
 ;;^UTILITY(U,$J,358.3,50310,0)
 ;;=E04.0^^193^2490^21
 ;;^UTILITY(U,$J,358.3,50310,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,50310,1,3,0)
 ;;=3^Nontoxic Diffuse Goiter
 ;;^UTILITY(U,$J,358.3,50310,1,4,0)
 ;;=4^E04.0
 ;;^UTILITY(U,$J,358.3,50310,2)
 ;;=^5002477
 ;;^UTILITY(U,$J,358.3,50311,0)
 ;;=E04.1^^193^2490^23
 ;;^UTILITY(U,$J,358.3,50311,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,50311,1,3,0)
 ;;=3^Nontoxic Single Thyroid Nodule
 ;;^UTILITY(U,$J,358.3,50311,1,4,0)
 ;;=4^E04.1
 ;;^UTILITY(U,$J,358.3,50311,2)
 ;;=^5002478
 ;;^UTILITY(U,$J,358.3,50312,0)
 ;;=E04.2^^193^2490^22
 ;;^UTILITY(U,$J,358.3,50312,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,50312,1,3,0)
 ;;=3^Nontoxic Multinodular Goiter
 ;;^UTILITY(U,$J,358.3,50312,1,4,0)
 ;;=4^E04.2
 ;;^UTILITY(U,$J,358.3,50312,2)
 ;;=^267790
 ;;^UTILITY(U,$J,358.3,50313,0)
 ;;=E01.1^^193^2490^17
 ;;^UTILITY(U,$J,358.3,50313,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,50313,1,3,0)
 ;;=3^Iodine-Deficiency Related Multinodular (Endemic) Goiter
 ;;^UTILITY(U,$J,358.3,50313,1,4,0)
 ;;=4^E01.1
 ;;^UTILITY(U,$J,358.3,50313,2)
 ;;=^5002465
 ;;^UTILITY(U,$J,358.3,50314,0)
 ;;=E05.00^^193^2490^39
 ;;^UTILITY(U,$J,358.3,50314,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,50314,1,3,0)
 ;;=3^Thyrotoxicosis w/ Diffuse Goiter w/o Thyrotoxic Crisis
 ;;^UTILITY(U,$J,358.3,50314,1,4,0)
 ;;=4^E05.00
 ;;^UTILITY(U,$J,358.3,50314,2)
 ;;=^5002481
 ;;^UTILITY(U,$J,358.3,50315,0)
 ;;=E05.01^^193^2490^38
 ;;^UTILITY(U,$J,358.3,50315,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,50315,1,3,0)
 ;;=3^Thyrotoxicosis w/ Diffuse Goiter w/ Thyrotoxic Crisis/Storm
 ;;^UTILITY(U,$J,358.3,50315,1,4,0)
 ;;=4^E05.01
 ;;^UTILITY(U,$J,358.3,50315,2)
 ;;=^5002482
 ;;^UTILITY(U,$J,358.3,50316,0)
 ;;=E05.90^^193^2490^41
 ;;^UTILITY(U,$J,358.3,50316,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,50316,1,3,0)
 ;;=3^Thyrotoxicosis,Unspec w/o Thyrotoxic Crisis/Storm
