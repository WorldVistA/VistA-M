IBDEI0UY ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,14515,0)
 ;;=N95.0^^53^609^48
 ;;^UTILITY(U,$J,358.3,14515,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14515,1,3,0)
 ;;=3^Postmenopausal Bleeding
 ;;^UTILITY(U,$J,358.3,14515,1,4,0)
 ;;=4^N95.0
 ;;^UTILITY(U,$J,358.3,14515,2)
 ;;=^97040
 ;;^UTILITY(U,$J,358.3,14516,0)
 ;;=N95.1^^53^609^35
 ;;^UTILITY(U,$J,358.3,14516,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14516,1,3,0)
 ;;=3^Menopausal/Female Climacteric States
 ;;^UTILITY(U,$J,358.3,14516,1,4,0)
 ;;=4^N95.1
 ;;^UTILITY(U,$J,358.3,14516,2)
 ;;=^5015927
 ;;^UTILITY(U,$J,358.3,14517,0)
 ;;=N97.0^^53^609^21
 ;;^UTILITY(U,$J,358.3,14517,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14517,1,3,0)
 ;;=3^Female Infertility Associated w/ Anovulation
 ;;^UTILITY(U,$J,358.3,14517,1,4,0)
 ;;=4^N97.0
 ;;^UTILITY(U,$J,358.3,14517,2)
 ;;=^5015931
 ;;^UTILITY(U,$J,358.3,14518,0)
 ;;=N97.9^^53^609^22
 ;;^UTILITY(U,$J,358.3,14518,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14518,1,3,0)
 ;;=3^Female Infertility,Unspec
 ;;^UTILITY(U,$J,358.3,14518,1,4,0)
 ;;=4^N97.9
 ;;^UTILITY(U,$J,358.3,14518,2)
 ;;=^5015935
 ;;^UTILITY(U,$J,358.3,14519,0)
 ;;=L29.2^^53^609^52
 ;;^UTILITY(U,$J,358.3,14519,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14519,1,3,0)
 ;;=3^Pruritus Vulvae
 ;;^UTILITY(U,$J,358.3,14519,1,4,0)
 ;;=4^L29.2
 ;;^UTILITY(U,$J,358.3,14519,2)
 ;;=^100075
 ;;^UTILITY(U,$J,358.3,14520,0)
 ;;=R92.8^^53^609^4
 ;;^UTILITY(U,$J,358.3,14520,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14520,1,3,0)
 ;;=3^Abnormal/Inconclusive Findings on Dx Imaging of Breast
 ;;^UTILITY(U,$J,358.3,14520,1,4,0)
 ;;=4^R92.8
 ;;^UTILITY(U,$J,358.3,14520,2)
 ;;=^5019712
 ;;^UTILITY(U,$J,358.3,14521,0)
 ;;=R87.619^^53^609^1
 ;;^UTILITY(U,$J,358.3,14521,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14521,1,3,0)
 ;;=3^Abnormal Cytology Findings in Specimen of Cervix Uteri,Unspec
 ;;^UTILITY(U,$J,358.3,14521,1,4,0)
 ;;=4^R87.619
 ;;^UTILITY(U,$J,358.3,14521,2)
 ;;=^5019676
 ;;^UTILITY(U,$J,358.3,14522,0)
 ;;=Z79.890^^53^609^26
 ;;^UTILITY(U,$J,358.3,14522,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14522,1,3,0)
 ;;=3^Hormone Replacement Therapy,Postmenopausal
 ;;^UTILITY(U,$J,358.3,14522,1,4,0)
 ;;=4^Z79.890
 ;;^UTILITY(U,$J,358.3,14522,2)
 ;;=^331975
 ;;^UTILITY(U,$J,358.3,14523,0)
 ;;=Z33.1^^53^609^50
 ;;^UTILITY(U,$J,358.3,14523,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14523,1,3,0)
 ;;=3^Pregnant State,Incidental
 ;;^UTILITY(U,$J,358.3,14523,1,4,0)
 ;;=4^Z33.1
 ;;^UTILITY(U,$J,358.3,14523,2)
 ;;=^5062853
 ;;^UTILITY(U,$J,358.3,14524,0)
 ;;=Z39.2^^53^609^49
 ;;^UTILITY(U,$J,358.3,14524,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14524,1,3,0)
 ;;=3^Postpartum Follow-up Routine Encounter
 ;;^UTILITY(U,$J,358.3,14524,1,4,0)
 ;;=4^Z39.2
 ;;^UTILITY(U,$J,358.3,14524,2)
 ;;=^5062906
 ;;^UTILITY(U,$J,358.3,14525,0)
 ;;=Z30.09^^53^609^10
 ;;^UTILITY(U,$J,358.3,14525,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14525,1,3,0)
 ;;=3^Counsel/Advice on Contraception Encounter
 ;;^UTILITY(U,$J,358.3,14525,1,4,0)
 ;;=4^Z30.09
 ;;^UTILITY(U,$J,358.3,14525,2)
 ;;=^5062817
 ;;^UTILITY(U,$J,358.3,14526,0)
 ;;=Z30.9^^53^609^9
 ;;^UTILITY(U,$J,358.3,14526,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14526,1,3,0)
 ;;=3^Contraceptive Management Encounter
 ;;^UTILITY(U,$J,358.3,14526,1,4,0)
 ;;=4^Z30.9
 ;;^UTILITY(U,$J,358.3,14526,2)
 ;;=^5062828
 ;;^UTILITY(U,$J,358.3,14527,0)
 ;;=N64.3^^53^609^23
 ;;^UTILITY(U,$J,358.3,14527,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14527,1,3,0)
 ;;=3^Galactorrhea Not Associated w/ Childbirth
 ;;^UTILITY(U,$J,358.3,14527,1,4,0)
 ;;=4^N64.3
