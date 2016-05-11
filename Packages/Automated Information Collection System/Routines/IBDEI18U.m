IBDEI18U ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,21141,0)
 ;;=N95.0^^84^945^48
 ;;^UTILITY(U,$J,358.3,21141,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21141,1,3,0)
 ;;=3^Postmenopausal Bleeding
 ;;^UTILITY(U,$J,358.3,21141,1,4,0)
 ;;=4^N95.0
 ;;^UTILITY(U,$J,358.3,21141,2)
 ;;=^97040
 ;;^UTILITY(U,$J,358.3,21142,0)
 ;;=N95.1^^84^945^35
 ;;^UTILITY(U,$J,358.3,21142,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21142,1,3,0)
 ;;=3^Menopausal/Female Climacteric States
 ;;^UTILITY(U,$J,358.3,21142,1,4,0)
 ;;=4^N95.1
 ;;^UTILITY(U,$J,358.3,21142,2)
 ;;=^5015927
 ;;^UTILITY(U,$J,358.3,21143,0)
 ;;=N97.0^^84^945^21
 ;;^UTILITY(U,$J,358.3,21143,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21143,1,3,0)
 ;;=3^Female Infertility Associated w/ Anovulation
 ;;^UTILITY(U,$J,358.3,21143,1,4,0)
 ;;=4^N97.0
 ;;^UTILITY(U,$J,358.3,21143,2)
 ;;=^5015931
 ;;^UTILITY(U,$J,358.3,21144,0)
 ;;=N97.9^^84^945^22
 ;;^UTILITY(U,$J,358.3,21144,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21144,1,3,0)
 ;;=3^Female Infertility,Unspec
 ;;^UTILITY(U,$J,358.3,21144,1,4,0)
 ;;=4^N97.9
 ;;^UTILITY(U,$J,358.3,21144,2)
 ;;=^5015935
 ;;^UTILITY(U,$J,358.3,21145,0)
 ;;=L29.2^^84^945^52
 ;;^UTILITY(U,$J,358.3,21145,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21145,1,3,0)
 ;;=3^Pruritus Vulvae
 ;;^UTILITY(U,$J,358.3,21145,1,4,0)
 ;;=4^L29.2
 ;;^UTILITY(U,$J,358.3,21145,2)
 ;;=^100075
 ;;^UTILITY(U,$J,358.3,21146,0)
 ;;=R92.8^^84^945^4
 ;;^UTILITY(U,$J,358.3,21146,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21146,1,3,0)
 ;;=3^Abnormal/Inconclusive Findings on Dx Imaging of Breast
 ;;^UTILITY(U,$J,358.3,21146,1,4,0)
 ;;=4^R92.8
 ;;^UTILITY(U,$J,358.3,21146,2)
 ;;=^5019712
 ;;^UTILITY(U,$J,358.3,21147,0)
 ;;=R87.619^^84^945^1
 ;;^UTILITY(U,$J,358.3,21147,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21147,1,3,0)
 ;;=3^Abnormal Cytology Findings in Specimen of Cervix Uteri,Unspec
 ;;^UTILITY(U,$J,358.3,21147,1,4,0)
 ;;=4^R87.619
 ;;^UTILITY(U,$J,358.3,21147,2)
 ;;=^5019676
 ;;^UTILITY(U,$J,358.3,21148,0)
 ;;=Z79.890^^84^945^26
 ;;^UTILITY(U,$J,358.3,21148,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21148,1,3,0)
 ;;=3^Hormone Replacement Therapy,Postmenopausal
 ;;^UTILITY(U,$J,358.3,21148,1,4,0)
 ;;=4^Z79.890
 ;;^UTILITY(U,$J,358.3,21148,2)
 ;;=^331975
 ;;^UTILITY(U,$J,358.3,21149,0)
 ;;=Z33.1^^84^945^50
 ;;^UTILITY(U,$J,358.3,21149,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21149,1,3,0)
 ;;=3^Pregnant State,Incidental
 ;;^UTILITY(U,$J,358.3,21149,1,4,0)
 ;;=4^Z33.1
 ;;^UTILITY(U,$J,358.3,21149,2)
 ;;=^5062853
 ;;^UTILITY(U,$J,358.3,21150,0)
 ;;=Z39.2^^84^945^49
 ;;^UTILITY(U,$J,358.3,21150,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21150,1,3,0)
 ;;=3^Postpartum Follow-up Routine Encounter
 ;;^UTILITY(U,$J,358.3,21150,1,4,0)
 ;;=4^Z39.2
 ;;^UTILITY(U,$J,358.3,21150,2)
 ;;=^5062906
 ;;^UTILITY(U,$J,358.3,21151,0)
 ;;=Z30.09^^84^945^10
 ;;^UTILITY(U,$J,358.3,21151,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21151,1,3,0)
 ;;=3^Counsel/Advice on Contraception Encounter
 ;;^UTILITY(U,$J,358.3,21151,1,4,0)
 ;;=4^Z30.09
 ;;^UTILITY(U,$J,358.3,21151,2)
 ;;=^5062817
 ;;^UTILITY(U,$J,358.3,21152,0)
 ;;=Z30.9^^84^945^9
 ;;^UTILITY(U,$J,358.3,21152,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21152,1,3,0)
 ;;=3^Contraceptive Management Encounter
 ;;^UTILITY(U,$J,358.3,21152,1,4,0)
 ;;=4^Z30.9
 ;;^UTILITY(U,$J,358.3,21152,2)
 ;;=^5062828
 ;;^UTILITY(U,$J,358.3,21153,0)
 ;;=N64.3^^84^945^23
 ;;^UTILITY(U,$J,358.3,21153,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21153,1,3,0)
 ;;=3^Galactorrhea Not Associated w/ Childbirth
 ;;^UTILITY(U,$J,358.3,21153,1,4,0)
 ;;=4^N64.3
