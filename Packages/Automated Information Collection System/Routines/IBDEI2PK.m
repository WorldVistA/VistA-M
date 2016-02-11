IBDEI2PK ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,45448,1,3,0)
 ;;=3^Excessive Bleeding in Premenopausal Period
 ;;^UTILITY(U,$J,358.3,45448,1,4,0)
 ;;=4^N92.4
 ;;^UTILITY(U,$J,358.3,45448,2)
 ;;=^5015911
 ;;^UTILITY(U,$J,358.3,45449,0)
 ;;=N95.0^^200^2244^48
 ;;^UTILITY(U,$J,358.3,45449,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,45449,1,3,0)
 ;;=3^Postmenopausal Bleeding
 ;;^UTILITY(U,$J,358.3,45449,1,4,0)
 ;;=4^N95.0
 ;;^UTILITY(U,$J,358.3,45449,2)
 ;;=^97040
 ;;^UTILITY(U,$J,358.3,45450,0)
 ;;=N95.1^^200^2244^35
 ;;^UTILITY(U,$J,358.3,45450,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,45450,1,3,0)
 ;;=3^Menopausal/Female Climacteric States
 ;;^UTILITY(U,$J,358.3,45450,1,4,0)
 ;;=4^N95.1
 ;;^UTILITY(U,$J,358.3,45450,2)
 ;;=^5015927
 ;;^UTILITY(U,$J,358.3,45451,0)
 ;;=N97.0^^200^2244^21
 ;;^UTILITY(U,$J,358.3,45451,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,45451,1,3,0)
 ;;=3^Female Infertility Associated w/ Anovulation
 ;;^UTILITY(U,$J,358.3,45451,1,4,0)
 ;;=4^N97.0
 ;;^UTILITY(U,$J,358.3,45451,2)
 ;;=^5015931
 ;;^UTILITY(U,$J,358.3,45452,0)
 ;;=N97.9^^200^2244^22
 ;;^UTILITY(U,$J,358.3,45452,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,45452,1,3,0)
 ;;=3^Female Infertility,Unspec
 ;;^UTILITY(U,$J,358.3,45452,1,4,0)
 ;;=4^N97.9
 ;;^UTILITY(U,$J,358.3,45452,2)
 ;;=^5015935
 ;;^UTILITY(U,$J,358.3,45453,0)
 ;;=L29.2^^200^2244^52
 ;;^UTILITY(U,$J,358.3,45453,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,45453,1,3,0)
 ;;=3^Pruritus Vulvae
 ;;^UTILITY(U,$J,358.3,45453,1,4,0)
 ;;=4^L29.2
 ;;^UTILITY(U,$J,358.3,45453,2)
 ;;=^100075
 ;;^UTILITY(U,$J,358.3,45454,0)
 ;;=R92.8^^200^2244^4
 ;;^UTILITY(U,$J,358.3,45454,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,45454,1,3,0)
 ;;=3^Abnormal/Inconclusive Findings on Dx Imaging of Breast
 ;;^UTILITY(U,$J,358.3,45454,1,4,0)
 ;;=4^R92.8
 ;;^UTILITY(U,$J,358.3,45454,2)
 ;;=^5019712
 ;;^UTILITY(U,$J,358.3,45455,0)
 ;;=R87.619^^200^2244^1
 ;;^UTILITY(U,$J,358.3,45455,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,45455,1,3,0)
 ;;=3^Abnormal Cytology Findings in Specimen of Cervix Uteri,Unspec
 ;;^UTILITY(U,$J,358.3,45455,1,4,0)
 ;;=4^R87.619
 ;;^UTILITY(U,$J,358.3,45455,2)
 ;;=^5019676
 ;;^UTILITY(U,$J,358.3,45456,0)
 ;;=Z79.890^^200^2244^26
 ;;^UTILITY(U,$J,358.3,45456,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,45456,1,3,0)
 ;;=3^Hormone Replacement Therapy,Postmenopausal
 ;;^UTILITY(U,$J,358.3,45456,1,4,0)
 ;;=4^Z79.890
 ;;^UTILITY(U,$J,358.3,45456,2)
 ;;=^331975
 ;;^UTILITY(U,$J,358.3,45457,0)
 ;;=Z33.1^^200^2244^50
 ;;^UTILITY(U,$J,358.3,45457,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,45457,1,3,0)
 ;;=3^Pregnant State,Incidental
 ;;^UTILITY(U,$J,358.3,45457,1,4,0)
 ;;=4^Z33.1
 ;;^UTILITY(U,$J,358.3,45457,2)
 ;;=^5062853
 ;;^UTILITY(U,$J,358.3,45458,0)
 ;;=Z39.2^^200^2244^49
 ;;^UTILITY(U,$J,358.3,45458,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,45458,1,3,0)
 ;;=3^Postpartum Follow-up Routine Encounter
 ;;^UTILITY(U,$J,358.3,45458,1,4,0)
 ;;=4^Z39.2
 ;;^UTILITY(U,$J,358.3,45458,2)
 ;;=^5062906
 ;;^UTILITY(U,$J,358.3,45459,0)
 ;;=Z30.09^^200^2244^10
 ;;^UTILITY(U,$J,358.3,45459,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,45459,1,3,0)
 ;;=3^Counsel/Advice on Contraception Encounter
 ;;^UTILITY(U,$J,358.3,45459,1,4,0)
 ;;=4^Z30.09
 ;;^UTILITY(U,$J,358.3,45459,2)
 ;;=^5062817
 ;;^UTILITY(U,$J,358.3,45460,0)
 ;;=Z30.9^^200^2244^9
 ;;^UTILITY(U,$J,358.3,45460,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,45460,1,3,0)
 ;;=3^Contraceptive Management Encounter
 ;;^UTILITY(U,$J,358.3,45460,1,4,0)
 ;;=4^Z30.9
 ;;^UTILITY(U,$J,358.3,45460,2)
 ;;=^5062828
 ;;^UTILITY(U,$J,358.3,45461,0)
 ;;=N64.3^^200^2244^23
