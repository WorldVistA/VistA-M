IBDEI13J ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,17615,1,3,0)
 ;;=3^Excessive Bleeding in Premenopausal Period
 ;;^UTILITY(U,$J,358.3,17615,1,4,0)
 ;;=4^N92.4
 ;;^UTILITY(U,$J,358.3,17615,2)
 ;;=^5015911
 ;;^UTILITY(U,$J,358.3,17616,0)
 ;;=N95.0^^88^895^89
 ;;^UTILITY(U,$J,358.3,17616,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17616,1,3,0)
 ;;=3^Postmenopausal Bleeding
 ;;^UTILITY(U,$J,358.3,17616,1,4,0)
 ;;=4^N95.0
 ;;^UTILITY(U,$J,358.3,17616,2)
 ;;=^97040
 ;;^UTILITY(U,$J,358.3,17617,0)
 ;;=N95.1^^88^895^69
 ;;^UTILITY(U,$J,358.3,17617,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17617,1,3,0)
 ;;=3^Menopausal/Female Climacteric States
 ;;^UTILITY(U,$J,358.3,17617,1,4,0)
 ;;=4^N95.1
 ;;^UTILITY(U,$J,358.3,17617,2)
 ;;=^5015927
 ;;^UTILITY(U,$J,358.3,17618,0)
 ;;=N97.0^^88^895^45
 ;;^UTILITY(U,$J,358.3,17618,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17618,1,3,0)
 ;;=3^Female Infertility Associated w/ Anovulation
 ;;^UTILITY(U,$J,358.3,17618,1,4,0)
 ;;=4^N97.0
 ;;^UTILITY(U,$J,358.3,17618,2)
 ;;=^5015931
 ;;^UTILITY(U,$J,358.3,17619,0)
 ;;=N97.9^^88^895^46
 ;;^UTILITY(U,$J,358.3,17619,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17619,1,3,0)
 ;;=3^Female Infertility,Unspec
 ;;^UTILITY(U,$J,358.3,17619,1,4,0)
 ;;=4^N97.9
 ;;^UTILITY(U,$J,358.3,17619,2)
 ;;=^5015935
 ;;^UTILITY(U,$J,358.3,17620,0)
 ;;=L29.2^^88^895^96
 ;;^UTILITY(U,$J,358.3,17620,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17620,1,3,0)
 ;;=3^Pruritus Vulvae
 ;;^UTILITY(U,$J,358.3,17620,1,4,0)
 ;;=4^L29.2
 ;;^UTILITY(U,$J,358.3,17620,2)
 ;;=^100075
 ;;^UTILITY(U,$J,358.3,17621,0)
 ;;=R92.8^^88^895^7
 ;;^UTILITY(U,$J,358.3,17621,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17621,1,3,0)
 ;;=3^Abnormal/Inconclusive Findings on Dx Imaging of Breast
 ;;^UTILITY(U,$J,358.3,17621,1,4,0)
 ;;=4^R92.8
 ;;^UTILITY(U,$J,358.3,17621,2)
 ;;=^5019712
 ;;^UTILITY(U,$J,358.3,17622,0)
 ;;=R87.619^^88^895^4
 ;;^UTILITY(U,$J,358.3,17622,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17622,1,3,0)
 ;;=3^Abnormal Cytology Findings in Specimen of Cervix Uteri,Unspec
 ;;^UTILITY(U,$J,358.3,17622,1,4,0)
 ;;=4^R87.619
 ;;^UTILITY(U,$J,358.3,17622,2)
 ;;=^5019676
 ;;^UTILITY(U,$J,358.3,17623,0)
 ;;=Z79.890^^88^895^56
 ;;^UTILITY(U,$J,358.3,17623,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17623,1,3,0)
 ;;=3^Hormone Replacement Therapy,Postmenopausal
 ;;^UTILITY(U,$J,358.3,17623,1,4,0)
 ;;=4^Z79.890
 ;;^UTILITY(U,$J,358.3,17623,2)
 ;;=^331975
 ;;^UTILITY(U,$J,358.3,17624,0)
 ;;=Z33.1^^88^895^94
 ;;^UTILITY(U,$J,358.3,17624,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17624,1,3,0)
 ;;=3^Pregnant State,Incidental
 ;;^UTILITY(U,$J,358.3,17624,1,4,0)
 ;;=4^Z33.1
 ;;^UTILITY(U,$J,358.3,17624,2)
 ;;=^5062853
 ;;^UTILITY(U,$J,358.3,17625,0)
 ;;=Z39.2^^88^895^90
 ;;^UTILITY(U,$J,358.3,17625,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17625,1,3,0)
 ;;=3^Postpartum Follow-up Routine Encounter
 ;;^UTILITY(U,$J,358.3,17625,1,4,0)
 ;;=4^Z39.2
 ;;^UTILITY(U,$J,358.3,17625,2)
 ;;=^5062906
 ;;^UTILITY(U,$J,358.3,17626,0)
 ;;=Z30.09^^88^895^21
 ;;^UTILITY(U,$J,358.3,17626,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17626,1,3,0)
 ;;=3^Counsel/Advice on Contraception Encounter
 ;;^UTILITY(U,$J,358.3,17626,1,4,0)
 ;;=4^Z30.09
 ;;^UTILITY(U,$J,358.3,17626,2)
 ;;=^5062817
 ;;^UTILITY(U,$J,358.3,17627,0)
 ;;=Z30.9^^88^895^20
 ;;^UTILITY(U,$J,358.3,17627,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17627,1,3,0)
 ;;=3^Contraceptive Management Encounter
