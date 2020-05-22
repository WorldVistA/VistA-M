IBDEI105 ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,16116,1,4,0)
 ;;=4^R09.82
 ;;^UTILITY(U,$J,358.3,16116,2)
 ;;=^97058
 ;;^UTILITY(U,$J,358.3,16117,0)
 ;;=K12.30^^88^871^20
 ;;^UTILITY(U,$J,358.3,16117,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16117,1,3,0)
 ;;=3^Oral Mucositis,Unspec
 ;;^UTILITY(U,$J,358.3,16117,1,4,0)
 ;;=4^K12.30
 ;;^UTILITY(U,$J,358.3,16117,2)
 ;;=^5008486
 ;;^UTILITY(U,$J,358.3,16118,0)
 ;;=J30.1^^88^871^10
 ;;^UTILITY(U,$J,358.3,16118,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16118,1,3,0)
 ;;=3^Allergic Rhinitis d/t Pollen
 ;;^UTILITY(U,$J,358.3,16118,1,4,0)
 ;;=4^J30.1
 ;;^UTILITY(U,$J,358.3,16118,2)
 ;;=^269906
 ;;^UTILITY(U,$J,358.3,16119,0)
 ;;=R09.81^^88^871^18
 ;;^UTILITY(U,$J,358.3,16119,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16119,1,3,0)
 ;;=3^Nasal Congestion
 ;;^UTILITY(U,$J,358.3,16119,1,4,0)
 ;;=4^R09.81
 ;;^UTILITY(U,$J,358.3,16119,2)
 ;;=^5019203
 ;;^UTILITY(U,$J,358.3,16120,0)
 ;;=I69.928^^88^871^22
 ;;^UTILITY(U,$J,358.3,16120,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16120,1,3,0)
 ;;=3^Speech/Lang Deficit Following Cerebvasc Disease
 ;;^UTILITY(U,$J,358.3,16120,1,4,0)
 ;;=4^I69.928
 ;;^UTILITY(U,$J,358.3,16120,2)
 ;;=^5007557
 ;;^UTILITY(U,$J,358.3,16121,0)
 ;;=I69.328^^88^871^23
 ;;^UTILITY(U,$J,358.3,16121,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16121,1,3,0)
 ;;=3^Speech/Lang Deficit Following Cerebvasc Infarc
 ;;^UTILITY(U,$J,358.3,16121,1,4,0)
 ;;=4^I69.328
 ;;^UTILITY(U,$J,358.3,16121,2)
 ;;=^5007495
 ;;^UTILITY(U,$J,358.3,16122,0)
 ;;=H81.4^^88^871^25
 ;;^UTILITY(U,$J,358.3,16122,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16122,1,3,0)
 ;;=3^Vertigo of Central Origin
 ;;^UTILITY(U,$J,358.3,16122,1,4,0)
 ;;=4^H81.4
 ;;^UTILITY(U,$J,358.3,16122,2)
 ;;=^269484
 ;;^UTILITY(U,$J,358.3,16123,0)
 ;;=E04.0^^88^872^21
 ;;^UTILITY(U,$J,358.3,16123,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16123,1,3,0)
 ;;=3^Nontoxic Diffuse Goiter
 ;;^UTILITY(U,$J,358.3,16123,1,4,0)
 ;;=4^E04.0
 ;;^UTILITY(U,$J,358.3,16123,2)
 ;;=^5002477
 ;;^UTILITY(U,$J,358.3,16124,0)
 ;;=E04.1^^88^872^23
 ;;^UTILITY(U,$J,358.3,16124,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16124,1,3,0)
 ;;=3^Nontoxic Single Thyroid Nodule
 ;;^UTILITY(U,$J,358.3,16124,1,4,0)
 ;;=4^E04.1
 ;;^UTILITY(U,$J,358.3,16124,2)
 ;;=^5002478
 ;;^UTILITY(U,$J,358.3,16125,0)
 ;;=E04.2^^88^872^22
 ;;^UTILITY(U,$J,358.3,16125,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16125,1,3,0)
 ;;=3^Nontoxic Multinodular Goiter
 ;;^UTILITY(U,$J,358.3,16125,1,4,0)
 ;;=4^E04.2
 ;;^UTILITY(U,$J,358.3,16125,2)
 ;;=^267790
 ;;^UTILITY(U,$J,358.3,16126,0)
 ;;=E01.1^^88^872^17
 ;;^UTILITY(U,$J,358.3,16126,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16126,1,3,0)
 ;;=3^Iodine-Deficiency Related Multinodular (Endemic) Goiter
 ;;^UTILITY(U,$J,358.3,16126,1,4,0)
 ;;=4^E01.1
 ;;^UTILITY(U,$J,358.3,16126,2)
 ;;=^5002465
 ;;^UTILITY(U,$J,358.3,16127,0)
 ;;=E05.00^^88^872^39
 ;;^UTILITY(U,$J,358.3,16127,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16127,1,3,0)
 ;;=3^Thyrotoxicosis w/ Diffuse Goiter w/o Thyrotoxic Crisis
 ;;^UTILITY(U,$J,358.3,16127,1,4,0)
 ;;=4^E05.00
 ;;^UTILITY(U,$J,358.3,16127,2)
 ;;=^5002481
 ;;^UTILITY(U,$J,358.3,16128,0)
 ;;=E05.01^^88^872^38
 ;;^UTILITY(U,$J,358.3,16128,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16128,1,3,0)
 ;;=3^Thyrotoxicosis w/ Diffuse Goiter w/ Thyrotoxic Crisis/Storm
 ;;^UTILITY(U,$J,358.3,16128,1,4,0)
 ;;=4^E05.01
