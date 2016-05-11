IBDEI22B ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,34980,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34980,1,3,0)
 ;;=3^Abnormal/Inconclusive Findings on Dx Imaging of Breast
 ;;^UTILITY(U,$J,358.3,34980,1,4,0)
 ;;=4^R92.8
 ;;^UTILITY(U,$J,358.3,34980,2)
 ;;=^5019712
 ;;^UTILITY(U,$J,358.3,34981,0)
 ;;=R87.619^^131^1696^1
 ;;^UTILITY(U,$J,358.3,34981,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34981,1,3,0)
 ;;=3^Abnormal Cytology Findings in Specimen of Cervix Uteri,Unspec
 ;;^UTILITY(U,$J,358.3,34981,1,4,0)
 ;;=4^R87.619
 ;;^UTILITY(U,$J,358.3,34981,2)
 ;;=^5019676
 ;;^UTILITY(U,$J,358.3,34982,0)
 ;;=Z79.890^^131^1696^26
 ;;^UTILITY(U,$J,358.3,34982,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34982,1,3,0)
 ;;=3^Hormone Replacement Therapy,Postmenopausal
 ;;^UTILITY(U,$J,358.3,34982,1,4,0)
 ;;=4^Z79.890
 ;;^UTILITY(U,$J,358.3,34982,2)
 ;;=^331975
 ;;^UTILITY(U,$J,358.3,34983,0)
 ;;=Z33.1^^131^1696^50
 ;;^UTILITY(U,$J,358.3,34983,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34983,1,3,0)
 ;;=3^Pregnant State,Incidental
 ;;^UTILITY(U,$J,358.3,34983,1,4,0)
 ;;=4^Z33.1
 ;;^UTILITY(U,$J,358.3,34983,2)
 ;;=^5062853
 ;;^UTILITY(U,$J,358.3,34984,0)
 ;;=Z39.2^^131^1696^49
 ;;^UTILITY(U,$J,358.3,34984,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34984,1,3,0)
 ;;=3^Postpartum Follow-up Routine Encounter
 ;;^UTILITY(U,$J,358.3,34984,1,4,0)
 ;;=4^Z39.2
 ;;^UTILITY(U,$J,358.3,34984,2)
 ;;=^5062906
 ;;^UTILITY(U,$J,358.3,34985,0)
 ;;=Z30.09^^131^1696^10
 ;;^UTILITY(U,$J,358.3,34985,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34985,1,3,0)
 ;;=3^Counsel/Advice on Contraception Encounter
 ;;^UTILITY(U,$J,358.3,34985,1,4,0)
 ;;=4^Z30.09
 ;;^UTILITY(U,$J,358.3,34985,2)
 ;;=^5062817
 ;;^UTILITY(U,$J,358.3,34986,0)
 ;;=Z30.9^^131^1696^9
 ;;^UTILITY(U,$J,358.3,34986,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34986,1,3,0)
 ;;=3^Contraceptive Management Encounter
 ;;^UTILITY(U,$J,358.3,34986,1,4,0)
 ;;=4^Z30.9
 ;;^UTILITY(U,$J,358.3,34986,2)
 ;;=^5062828
 ;;^UTILITY(U,$J,358.3,34987,0)
 ;;=N64.3^^131^1696^23
 ;;^UTILITY(U,$J,358.3,34987,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34987,1,3,0)
 ;;=3^Galactorrhea Not Associated w/ Childbirth
 ;;^UTILITY(U,$J,358.3,34987,1,4,0)
 ;;=4^N64.3
 ;;^UTILITY(U,$J,358.3,34987,2)
 ;;=^270460
 ;;^UTILITY(U,$J,358.3,34988,0)
 ;;=R92.2^^131^1696^27
 ;;^UTILITY(U,$J,358.3,34988,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34988,1,3,0)
 ;;=3^Inconclusive Mammogram
 ;;^UTILITY(U,$J,358.3,34988,1,4,0)
 ;;=4^R92.2
 ;;^UTILITY(U,$J,358.3,34988,2)
 ;;=^5019711
 ;;^UTILITY(U,$J,358.3,34989,0)
 ;;=Z30.432^^131^1696^53
 ;;^UTILITY(U,$J,358.3,34989,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34989,1,3,0)
 ;;=3^Removal of IUD
 ;;^UTILITY(U,$J,358.3,34989,1,4,0)
 ;;=4^Z30.432
 ;;^UTILITY(U,$J,358.3,34989,2)
 ;;=^5062824
 ;;^UTILITY(U,$J,358.3,34990,0)
 ;;=S31.000A^^131^1697^5
 ;;^UTILITY(U,$J,358.3,34990,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34990,1,3,0)
 ;;=3^Open Wnd Low Back/Pelvis w/o Penet Retroperiton,Init,Unspec
 ;;^UTILITY(U,$J,358.3,34990,1,4,0)
 ;;=4^S31.000A
 ;;^UTILITY(U,$J,358.3,34990,2)
 ;;=^5023993
 ;;^UTILITY(U,$J,358.3,34991,0)
 ;;=S31.010A^^131^1697^2
 ;;^UTILITY(U,$J,358.3,34991,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34991,1,3,0)
 ;;=3^Laceration w/o FB Low Back/Pelvis w/o Penet Retroperiton,Init
 ;;^UTILITY(U,$J,358.3,34991,1,4,0)
 ;;=4^S31.010A
 ;;^UTILITY(U,$J,358.3,34991,2)
 ;;=^5023999
 ;;^UTILITY(U,$J,358.3,34992,0)
 ;;=T07.^^131^1697^4
 ;;^UTILITY(U,$J,358.3,34992,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,34992,1,3,0)
 ;;=3^Multiple Injuries,Unspec
 ;;^UTILITY(U,$J,358.3,34992,1,4,0)
 ;;=4^T07.
