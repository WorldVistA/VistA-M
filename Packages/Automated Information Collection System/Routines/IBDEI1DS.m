IBDEI1DS ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,23469,2)
 ;;=^100075
 ;;^UTILITY(U,$J,358.3,23470,0)
 ;;=R92.8^^87^997^4
 ;;^UTILITY(U,$J,358.3,23470,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23470,1,3,0)
 ;;=3^Abnormal/Inconclusive Findings on Dx Imaging of Breast
 ;;^UTILITY(U,$J,358.3,23470,1,4,0)
 ;;=4^R92.8
 ;;^UTILITY(U,$J,358.3,23470,2)
 ;;=^5019712
 ;;^UTILITY(U,$J,358.3,23471,0)
 ;;=R87.619^^87^997^1
 ;;^UTILITY(U,$J,358.3,23471,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23471,1,3,0)
 ;;=3^Abnormal Cytology Findings in Specimen of Cervix Uteri,Unspec
 ;;^UTILITY(U,$J,358.3,23471,1,4,0)
 ;;=4^R87.619
 ;;^UTILITY(U,$J,358.3,23471,2)
 ;;=^5019676
 ;;^UTILITY(U,$J,358.3,23472,0)
 ;;=Z79.890^^87^997^26
 ;;^UTILITY(U,$J,358.3,23472,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23472,1,3,0)
 ;;=3^Hormone Replacement Therapy,Postmenopausal
 ;;^UTILITY(U,$J,358.3,23472,1,4,0)
 ;;=4^Z79.890
 ;;^UTILITY(U,$J,358.3,23472,2)
 ;;=^331975
 ;;^UTILITY(U,$J,358.3,23473,0)
 ;;=Z33.1^^87^997^50
 ;;^UTILITY(U,$J,358.3,23473,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23473,1,3,0)
 ;;=3^Pregnant State,Incidental
 ;;^UTILITY(U,$J,358.3,23473,1,4,0)
 ;;=4^Z33.1
 ;;^UTILITY(U,$J,358.3,23473,2)
 ;;=^5062853
 ;;^UTILITY(U,$J,358.3,23474,0)
 ;;=Z39.2^^87^997^49
 ;;^UTILITY(U,$J,358.3,23474,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23474,1,3,0)
 ;;=3^Postpartum Follow-up Routine Encounter
 ;;^UTILITY(U,$J,358.3,23474,1,4,0)
 ;;=4^Z39.2
 ;;^UTILITY(U,$J,358.3,23474,2)
 ;;=^5062906
 ;;^UTILITY(U,$J,358.3,23475,0)
 ;;=Z30.09^^87^997^10
 ;;^UTILITY(U,$J,358.3,23475,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23475,1,3,0)
 ;;=3^Counsel/Advice on Contraception Encounter
 ;;^UTILITY(U,$J,358.3,23475,1,4,0)
 ;;=4^Z30.09
 ;;^UTILITY(U,$J,358.3,23475,2)
 ;;=^5062817
 ;;^UTILITY(U,$J,358.3,23476,0)
 ;;=Z30.9^^87^997^9
 ;;^UTILITY(U,$J,358.3,23476,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23476,1,3,0)
 ;;=3^Contraceptive Management Encounter
 ;;^UTILITY(U,$J,358.3,23476,1,4,0)
 ;;=4^Z30.9
 ;;^UTILITY(U,$J,358.3,23476,2)
 ;;=^5062828
 ;;^UTILITY(U,$J,358.3,23477,0)
 ;;=N64.3^^87^997^23
 ;;^UTILITY(U,$J,358.3,23477,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23477,1,3,0)
 ;;=3^Galactorrhea Not Associated w/ Childbirth
 ;;^UTILITY(U,$J,358.3,23477,1,4,0)
 ;;=4^N64.3
 ;;^UTILITY(U,$J,358.3,23477,2)
 ;;=^270460
 ;;^UTILITY(U,$J,358.3,23478,0)
 ;;=R92.2^^87^997^27
 ;;^UTILITY(U,$J,358.3,23478,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23478,1,3,0)
 ;;=3^Inconclusive Mammogram
 ;;^UTILITY(U,$J,358.3,23478,1,4,0)
 ;;=4^R92.2
 ;;^UTILITY(U,$J,358.3,23478,2)
 ;;=^5019711
 ;;^UTILITY(U,$J,358.3,23479,0)
 ;;=Z30.432^^87^997^53
 ;;^UTILITY(U,$J,358.3,23479,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23479,1,3,0)
 ;;=3^Removal of IUD
 ;;^UTILITY(U,$J,358.3,23479,1,4,0)
 ;;=4^Z30.432
 ;;^UTILITY(U,$J,358.3,23479,2)
 ;;=^5062824
 ;;^UTILITY(U,$J,358.3,23480,0)
 ;;=S31.000A^^87^998^5
 ;;^UTILITY(U,$J,358.3,23480,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23480,1,3,0)
 ;;=3^Open Wnd Low Back/Pelvis w/o Penet Retroperiton,Init,Unspec
 ;;^UTILITY(U,$J,358.3,23480,1,4,0)
 ;;=4^S31.000A
 ;;^UTILITY(U,$J,358.3,23480,2)
 ;;=^5023993
 ;;^UTILITY(U,$J,358.3,23481,0)
 ;;=S31.010A^^87^998^2
 ;;^UTILITY(U,$J,358.3,23481,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23481,1,3,0)
 ;;=3^Laceration w/o FB Low Back/Pelvis w/o Penet Retroperiton,Init
 ;;^UTILITY(U,$J,358.3,23481,1,4,0)
 ;;=4^S31.010A
 ;;^UTILITY(U,$J,358.3,23481,2)
 ;;=^5023999
 ;;^UTILITY(U,$J,358.3,23482,0)
 ;;=T07.^^87^998^4
 ;;^UTILITY(U,$J,358.3,23482,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23482,1,3,0)
 ;;=3^Multiple Injuries,Unspec
