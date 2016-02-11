IBDEI0PS ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,11812,0)
 ;;=N95.0^^68^691^48
 ;;^UTILITY(U,$J,358.3,11812,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11812,1,3,0)
 ;;=3^Postmenopausal Bleeding
 ;;^UTILITY(U,$J,358.3,11812,1,4,0)
 ;;=4^N95.0
 ;;^UTILITY(U,$J,358.3,11812,2)
 ;;=^97040
 ;;^UTILITY(U,$J,358.3,11813,0)
 ;;=N95.1^^68^691^35
 ;;^UTILITY(U,$J,358.3,11813,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11813,1,3,0)
 ;;=3^Menopausal/Female Climacteric States
 ;;^UTILITY(U,$J,358.3,11813,1,4,0)
 ;;=4^N95.1
 ;;^UTILITY(U,$J,358.3,11813,2)
 ;;=^5015927
 ;;^UTILITY(U,$J,358.3,11814,0)
 ;;=N97.0^^68^691^21
 ;;^UTILITY(U,$J,358.3,11814,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11814,1,3,0)
 ;;=3^Female Infertility Associated w/ Anovulation
 ;;^UTILITY(U,$J,358.3,11814,1,4,0)
 ;;=4^N97.0
 ;;^UTILITY(U,$J,358.3,11814,2)
 ;;=^5015931
 ;;^UTILITY(U,$J,358.3,11815,0)
 ;;=N97.9^^68^691^22
 ;;^UTILITY(U,$J,358.3,11815,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11815,1,3,0)
 ;;=3^Female Infertility,Unspec
 ;;^UTILITY(U,$J,358.3,11815,1,4,0)
 ;;=4^N97.9
 ;;^UTILITY(U,$J,358.3,11815,2)
 ;;=^5015935
 ;;^UTILITY(U,$J,358.3,11816,0)
 ;;=L29.2^^68^691^52
 ;;^UTILITY(U,$J,358.3,11816,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11816,1,3,0)
 ;;=3^Pruritus Vulvae
 ;;^UTILITY(U,$J,358.3,11816,1,4,0)
 ;;=4^L29.2
 ;;^UTILITY(U,$J,358.3,11816,2)
 ;;=^100075
 ;;^UTILITY(U,$J,358.3,11817,0)
 ;;=R92.8^^68^691^4
 ;;^UTILITY(U,$J,358.3,11817,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11817,1,3,0)
 ;;=3^Abnormal/Inconclusive Findings on Dx Imaging of Breast
 ;;^UTILITY(U,$J,358.3,11817,1,4,0)
 ;;=4^R92.8
 ;;^UTILITY(U,$J,358.3,11817,2)
 ;;=^5019712
 ;;^UTILITY(U,$J,358.3,11818,0)
 ;;=R87.619^^68^691^1
 ;;^UTILITY(U,$J,358.3,11818,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11818,1,3,0)
 ;;=3^Abnormal Cytology Findings in Specimen of Cervix Uteri,Unspec
 ;;^UTILITY(U,$J,358.3,11818,1,4,0)
 ;;=4^R87.619
 ;;^UTILITY(U,$J,358.3,11818,2)
 ;;=^5019676
 ;;^UTILITY(U,$J,358.3,11819,0)
 ;;=Z79.890^^68^691^26
 ;;^UTILITY(U,$J,358.3,11819,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11819,1,3,0)
 ;;=3^Hormone Replacement Therapy,Postmenopausal
 ;;^UTILITY(U,$J,358.3,11819,1,4,0)
 ;;=4^Z79.890
 ;;^UTILITY(U,$J,358.3,11819,2)
 ;;=^331975
 ;;^UTILITY(U,$J,358.3,11820,0)
 ;;=Z33.1^^68^691^50
 ;;^UTILITY(U,$J,358.3,11820,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11820,1,3,0)
 ;;=3^Pregnant State,Incidental
 ;;^UTILITY(U,$J,358.3,11820,1,4,0)
 ;;=4^Z33.1
 ;;^UTILITY(U,$J,358.3,11820,2)
 ;;=^5062853
 ;;^UTILITY(U,$J,358.3,11821,0)
 ;;=Z39.2^^68^691^49
 ;;^UTILITY(U,$J,358.3,11821,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11821,1,3,0)
 ;;=3^Postpartum Follow-up Routine Encounter
 ;;^UTILITY(U,$J,358.3,11821,1,4,0)
 ;;=4^Z39.2
 ;;^UTILITY(U,$J,358.3,11821,2)
 ;;=^5062906
 ;;^UTILITY(U,$J,358.3,11822,0)
 ;;=Z30.09^^68^691^10
 ;;^UTILITY(U,$J,358.3,11822,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11822,1,3,0)
 ;;=3^Counsel/Advice on Contraception Encounter
 ;;^UTILITY(U,$J,358.3,11822,1,4,0)
 ;;=4^Z30.09
 ;;^UTILITY(U,$J,358.3,11822,2)
 ;;=^5062817
 ;;^UTILITY(U,$J,358.3,11823,0)
 ;;=Z30.9^^68^691^9
 ;;^UTILITY(U,$J,358.3,11823,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11823,1,3,0)
 ;;=3^Contraceptive Management Encounter
 ;;^UTILITY(U,$J,358.3,11823,1,4,0)
 ;;=4^Z30.9
 ;;^UTILITY(U,$J,358.3,11823,2)
 ;;=^5062828
 ;;^UTILITY(U,$J,358.3,11824,0)
 ;;=N64.3^^68^691^23
 ;;^UTILITY(U,$J,358.3,11824,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11824,1,3,0)
 ;;=3^Galactorrhea Not Associated w/ Childbirth
 ;;^UTILITY(U,$J,358.3,11824,1,4,0)
 ;;=4^N64.3
