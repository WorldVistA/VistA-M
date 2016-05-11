IBDEI2I0 ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,42364,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,42364,1,3,0)
 ;;=3^Abnormal/Inconclusive Findings on Dx Imaging of Breast
 ;;^UTILITY(U,$J,358.3,42364,1,4,0)
 ;;=4^R92.8
 ;;^UTILITY(U,$J,358.3,42364,2)
 ;;=^5019712
 ;;^UTILITY(U,$J,358.3,42365,0)
 ;;=R87.619^^159^2020^1
 ;;^UTILITY(U,$J,358.3,42365,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,42365,1,3,0)
 ;;=3^Abnormal Cytology Findings in Specimen of Cervix Uteri,Unspec
 ;;^UTILITY(U,$J,358.3,42365,1,4,0)
 ;;=4^R87.619
 ;;^UTILITY(U,$J,358.3,42365,2)
 ;;=^5019676
 ;;^UTILITY(U,$J,358.3,42366,0)
 ;;=Z79.890^^159^2020^26
 ;;^UTILITY(U,$J,358.3,42366,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,42366,1,3,0)
 ;;=3^Hormone Replacement Therapy,Postmenopausal
 ;;^UTILITY(U,$J,358.3,42366,1,4,0)
 ;;=4^Z79.890
 ;;^UTILITY(U,$J,358.3,42366,2)
 ;;=^331975
 ;;^UTILITY(U,$J,358.3,42367,0)
 ;;=Z33.1^^159^2020^50
 ;;^UTILITY(U,$J,358.3,42367,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,42367,1,3,0)
 ;;=3^Pregnant State,Incidental
 ;;^UTILITY(U,$J,358.3,42367,1,4,0)
 ;;=4^Z33.1
 ;;^UTILITY(U,$J,358.3,42367,2)
 ;;=^5062853
 ;;^UTILITY(U,$J,358.3,42368,0)
 ;;=Z39.2^^159^2020^49
 ;;^UTILITY(U,$J,358.3,42368,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,42368,1,3,0)
 ;;=3^Postpartum Follow-up Routine Encounter
 ;;^UTILITY(U,$J,358.3,42368,1,4,0)
 ;;=4^Z39.2
 ;;^UTILITY(U,$J,358.3,42368,2)
 ;;=^5062906
 ;;^UTILITY(U,$J,358.3,42369,0)
 ;;=Z30.09^^159^2020^10
 ;;^UTILITY(U,$J,358.3,42369,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,42369,1,3,0)
 ;;=3^Counsel/Advice on Contraception Encounter
 ;;^UTILITY(U,$J,358.3,42369,1,4,0)
 ;;=4^Z30.09
 ;;^UTILITY(U,$J,358.3,42369,2)
 ;;=^5062817
 ;;^UTILITY(U,$J,358.3,42370,0)
 ;;=Z30.9^^159^2020^9
 ;;^UTILITY(U,$J,358.3,42370,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,42370,1,3,0)
 ;;=3^Contraceptive Management Encounter
 ;;^UTILITY(U,$J,358.3,42370,1,4,0)
 ;;=4^Z30.9
 ;;^UTILITY(U,$J,358.3,42370,2)
 ;;=^5062828
 ;;^UTILITY(U,$J,358.3,42371,0)
 ;;=N64.3^^159^2020^23
 ;;^UTILITY(U,$J,358.3,42371,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,42371,1,3,0)
 ;;=3^Galactorrhea Not Associated w/ Childbirth
 ;;^UTILITY(U,$J,358.3,42371,1,4,0)
 ;;=4^N64.3
 ;;^UTILITY(U,$J,358.3,42371,2)
 ;;=^270460
 ;;^UTILITY(U,$J,358.3,42372,0)
 ;;=R92.2^^159^2020^27
 ;;^UTILITY(U,$J,358.3,42372,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,42372,1,3,0)
 ;;=3^Inconclusive Mammogram
 ;;^UTILITY(U,$J,358.3,42372,1,4,0)
 ;;=4^R92.2
 ;;^UTILITY(U,$J,358.3,42372,2)
 ;;=^5019711
 ;;^UTILITY(U,$J,358.3,42373,0)
 ;;=Z30.432^^159^2020^53
 ;;^UTILITY(U,$J,358.3,42373,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,42373,1,3,0)
 ;;=3^Removal of IUD
 ;;^UTILITY(U,$J,358.3,42373,1,4,0)
 ;;=4^Z30.432
 ;;^UTILITY(U,$J,358.3,42373,2)
 ;;=^5062824
 ;;^UTILITY(U,$J,358.3,42374,0)
 ;;=S31.000A^^159^2021^5
 ;;^UTILITY(U,$J,358.3,42374,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,42374,1,3,0)
 ;;=3^Open Wnd Low Back/Pelvis w/o Penet Retroperiton,Init,Unspec
 ;;^UTILITY(U,$J,358.3,42374,1,4,0)
 ;;=4^S31.000A
 ;;^UTILITY(U,$J,358.3,42374,2)
 ;;=^5023993
 ;;^UTILITY(U,$J,358.3,42375,0)
 ;;=S31.010A^^159^2021^2
 ;;^UTILITY(U,$J,358.3,42375,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,42375,1,3,0)
 ;;=3^Laceration w/o FB Low Back/Pelvis w/o Penet Retroperiton,Init
 ;;^UTILITY(U,$J,358.3,42375,1,4,0)
 ;;=4^S31.010A
 ;;^UTILITY(U,$J,358.3,42375,2)
 ;;=^5023999
 ;;^UTILITY(U,$J,358.3,42376,0)
 ;;=T07.^^159^2021^4
 ;;^UTILITY(U,$J,358.3,42376,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,42376,1,3,0)
 ;;=3^Multiple Injuries,Unspec
 ;;^UTILITY(U,$J,358.3,42376,1,4,0)
 ;;=4^T07.
