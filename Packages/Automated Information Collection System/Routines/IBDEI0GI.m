IBDEI0GI ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,7633,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7633,1,3,0)
 ;;=3^Irregular Menstruation,Unspec
 ;;^UTILITY(U,$J,358.3,7633,1,4,0)
 ;;=4^N92.6
 ;;^UTILITY(U,$J,358.3,7633,2)
 ;;=^5015913
 ;;^UTILITY(U,$J,358.3,7634,0)
 ;;=N92.5^^30^412^29
 ;;^UTILITY(U,$J,358.3,7634,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7634,1,3,0)
 ;;=3^Irregular Menstruation,Other Spec
 ;;^UTILITY(U,$J,358.3,7634,1,4,0)
 ;;=4^N92.5
 ;;^UTILITY(U,$J,358.3,7634,2)
 ;;=^5015912
 ;;^UTILITY(U,$J,358.3,7635,0)
 ;;=N92.3^^30^412^43
 ;;^UTILITY(U,$J,358.3,7635,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7635,1,3,0)
 ;;=3^Ovulation Bleeding
 ;;^UTILITY(U,$J,358.3,7635,1,4,0)
 ;;=4^N92.3
 ;;^UTILITY(U,$J,358.3,7635,2)
 ;;=^270570
 ;;^UTILITY(U,$J,358.3,7636,0)
 ;;=N89.7^^30^412^24
 ;;^UTILITY(U,$J,358.3,7636,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7636,1,3,0)
 ;;=3^Hematocolpos
 ;;^UTILITY(U,$J,358.3,7636,1,4,0)
 ;;=4^N89.7
 ;;^UTILITY(U,$J,358.3,7636,2)
 ;;=^5015889
 ;;^UTILITY(U,$J,358.3,7637,0)
 ;;=N93.8^^30^412^2
 ;;^UTILITY(U,$J,358.3,7637,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7637,1,3,0)
 ;;=3^Abnormal Uterine/Vaginal Bleeding,Other Spec
 ;;^UTILITY(U,$J,358.3,7637,1,4,0)
 ;;=4^N93.8
 ;;^UTILITY(U,$J,358.3,7637,2)
 ;;=^5015915
 ;;^UTILITY(U,$J,358.3,7638,0)
 ;;=N93.9^^30^412^3
 ;;^UTILITY(U,$J,358.3,7638,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7638,1,3,0)
 ;;=3^Abnormal Uterine/Vaginal Bleeding,Unspec
 ;;^UTILITY(U,$J,358.3,7638,1,4,0)
 ;;=4^N93.9
 ;;^UTILITY(U,$J,358.3,7638,2)
 ;;=^5015916
 ;;^UTILITY(U,$J,358.3,7639,0)
 ;;=N92.4^^30^412^19
 ;;^UTILITY(U,$J,358.3,7639,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7639,1,3,0)
 ;;=3^Excessive Bleeding in Premenopausal Period
 ;;^UTILITY(U,$J,358.3,7639,1,4,0)
 ;;=4^N92.4
 ;;^UTILITY(U,$J,358.3,7639,2)
 ;;=^5015911
 ;;^UTILITY(U,$J,358.3,7640,0)
 ;;=N95.0^^30^412^48
 ;;^UTILITY(U,$J,358.3,7640,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7640,1,3,0)
 ;;=3^Postmenopausal Bleeding
 ;;^UTILITY(U,$J,358.3,7640,1,4,0)
 ;;=4^N95.0
 ;;^UTILITY(U,$J,358.3,7640,2)
 ;;=^97040
 ;;^UTILITY(U,$J,358.3,7641,0)
 ;;=N95.1^^30^412^35
 ;;^UTILITY(U,$J,358.3,7641,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7641,1,3,0)
 ;;=3^Menopausal/Female Climacteric States
 ;;^UTILITY(U,$J,358.3,7641,1,4,0)
 ;;=4^N95.1
 ;;^UTILITY(U,$J,358.3,7641,2)
 ;;=^5015927
 ;;^UTILITY(U,$J,358.3,7642,0)
 ;;=N97.0^^30^412^21
 ;;^UTILITY(U,$J,358.3,7642,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7642,1,3,0)
 ;;=3^Female Infertility Associated w/ Anovulation
 ;;^UTILITY(U,$J,358.3,7642,1,4,0)
 ;;=4^N97.0
 ;;^UTILITY(U,$J,358.3,7642,2)
 ;;=^5015931
 ;;^UTILITY(U,$J,358.3,7643,0)
 ;;=N97.9^^30^412^22
 ;;^UTILITY(U,$J,358.3,7643,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7643,1,3,0)
 ;;=3^Female Infertility,Unspec
 ;;^UTILITY(U,$J,358.3,7643,1,4,0)
 ;;=4^N97.9
 ;;^UTILITY(U,$J,358.3,7643,2)
 ;;=^5015935
 ;;^UTILITY(U,$J,358.3,7644,0)
 ;;=L29.2^^30^412^52
 ;;^UTILITY(U,$J,358.3,7644,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7644,1,3,0)
 ;;=3^Pruritus Vulvae
 ;;^UTILITY(U,$J,358.3,7644,1,4,0)
 ;;=4^L29.2
 ;;^UTILITY(U,$J,358.3,7644,2)
 ;;=^100075
 ;;^UTILITY(U,$J,358.3,7645,0)
 ;;=R92.8^^30^412^4
 ;;^UTILITY(U,$J,358.3,7645,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7645,1,3,0)
 ;;=3^Abnormal/Inconclusive Findings on Dx Imaging of Breast
 ;;^UTILITY(U,$J,358.3,7645,1,4,0)
 ;;=4^R92.8
 ;;^UTILITY(U,$J,358.3,7645,2)
 ;;=^5019712
 ;;^UTILITY(U,$J,358.3,7646,0)
 ;;=R87.619^^30^412^1
 ;;^UTILITY(U,$J,358.3,7646,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7646,1,3,0)
 ;;=3^Abnormal Cytology Findings in Specimen of Cervix Uteri,Unspec
