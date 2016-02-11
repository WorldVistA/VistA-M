IBDEI1US ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,31026,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31026,1,3,0)
 ;;=3^Abnormal/Inconclusive Findings on Dx Imaging of Breast
 ;;^UTILITY(U,$J,358.3,31026,1,4,0)
 ;;=4^R92.8
 ;;^UTILITY(U,$J,358.3,31026,2)
 ;;=^5019712
 ;;^UTILITY(U,$J,358.3,31027,0)
 ;;=R87.619^^135^1388^1
 ;;^UTILITY(U,$J,358.3,31027,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31027,1,3,0)
 ;;=3^Abnormal Cytology Findings in Specimen of Cervix Uteri,Unspec
 ;;^UTILITY(U,$J,358.3,31027,1,4,0)
 ;;=4^R87.619
 ;;^UTILITY(U,$J,358.3,31027,2)
 ;;=^5019676
 ;;^UTILITY(U,$J,358.3,31028,0)
 ;;=Z79.890^^135^1388^26
 ;;^UTILITY(U,$J,358.3,31028,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31028,1,3,0)
 ;;=3^Hormone Replacement Therapy,Postmenopausal
 ;;^UTILITY(U,$J,358.3,31028,1,4,0)
 ;;=4^Z79.890
 ;;^UTILITY(U,$J,358.3,31028,2)
 ;;=^331975
 ;;^UTILITY(U,$J,358.3,31029,0)
 ;;=Z33.1^^135^1388^50
 ;;^UTILITY(U,$J,358.3,31029,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31029,1,3,0)
 ;;=3^Pregnant State,Incidental
 ;;^UTILITY(U,$J,358.3,31029,1,4,0)
 ;;=4^Z33.1
 ;;^UTILITY(U,$J,358.3,31029,2)
 ;;=^5062853
 ;;^UTILITY(U,$J,358.3,31030,0)
 ;;=Z39.2^^135^1388^49
 ;;^UTILITY(U,$J,358.3,31030,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31030,1,3,0)
 ;;=3^Postpartum Follow-up Routine Encounter
 ;;^UTILITY(U,$J,358.3,31030,1,4,0)
 ;;=4^Z39.2
 ;;^UTILITY(U,$J,358.3,31030,2)
 ;;=^5062906
 ;;^UTILITY(U,$J,358.3,31031,0)
 ;;=Z30.09^^135^1388^10
 ;;^UTILITY(U,$J,358.3,31031,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31031,1,3,0)
 ;;=3^Counsel/Advice on Contraception Encounter
 ;;^UTILITY(U,$J,358.3,31031,1,4,0)
 ;;=4^Z30.09
 ;;^UTILITY(U,$J,358.3,31031,2)
 ;;=^5062817
 ;;^UTILITY(U,$J,358.3,31032,0)
 ;;=Z30.9^^135^1388^9
 ;;^UTILITY(U,$J,358.3,31032,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31032,1,3,0)
 ;;=3^Contraceptive Management Encounter
 ;;^UTILITY(U,$J,358.3,31032,1,4,0)
 ;;=4^Z30.9
 ;;^UTILITY(U,$J,358.3,31032,2)
 ;;=^5062828
 ;;^UTILITY(U,$J,358.3,31033,0)
 ;;=N64.3^^135^1388^23
 ;;^UTILITY(U,$J,358.3,31033,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31033,1,3,0)
 ;;=3^Galactorrhea Not Associated w/ Childbirth
 ;;^UTILITY(U,$J,358.3,31033,1,4,0)
 ;;=4^N64.3
 ;;^UTILITY(U,$J,358.3,31033,2)
 ;;=^270460
 ;;^UTILITY(U,$J,358.3,31034,0)
 ;;=R92.2^^135^1388^27
 ;;^UTILITY(U,$J,358.3,31034,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31034,1,3,0)
 ;;=3^Inconclusive Mammogram
 ;;^UTILITY(U,$J,358.3,31034,1,4,0)
 ;;=4^R92.2
 ;;^UTILITY(U,$J,358.3,31034,2)
 ;;=^5019711
 ;;^UTILITY(U,$J,358.3,31035,0)
 ;;=Z30.432^^135^1388^53
 ;;^UTILITY(U,$J,358.3,31035,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31035,1,3,0)
 ;;=3^Removal of IUD
 ;;^UTILITY(U,$J,358.3,31035,1,4,0)
 ;;=4^Z30.432
 ;;^UTILITY(U,$J,358.3,31035,2)
 ;;=^5062824
 ;;^UTILITY(U,$J,358.3,31036,0)
 ;;=S31.000A^^135^1389^5
 ;;^UTILITY(U,$J,358.3,31036,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31036,1,3,0)
 ;;=3^Open Wnd Low Back/Pelvis w/o Penet Retroperiton,Init,Unspec
 ;;^UTILITY(U,$J,358.3,31036,1,4,0)
 ;;=4^S31.000A
 ;;^UTILITY(U,$J,358.3,31036,2)
 ;;=^5023993
 ;;^UTILITY(U,$J,358.3,31037,0)
 ;;=S31.010A^^135^1389^2
 ;;^UTILITY(U,$J,358.3,31037,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31037,1,3,0)
 ;;=3^Laceration w/o FB Low Back/Pelvis w/o Penet Retroperiton,Init
 ;;^UTILITY(U,$J,358.3,31037,1,4,0)
 ;;=4^S31.010A
 ;;^UTILITY(U,$J,358.3,31037,2)
 ;;=^5023999
 ;;^UTILITY(U,$J,358.3,31038,0)
 ;;=T07.^^135^1389^4
 ;;^UTILITY(U,$J,358.3,31038,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31038,1,3,0)
 ;;=3^Multiple Injuries,Unspec
 ;;^UTILITY(U,$J,358.3,31038,1,4,0)
 ;;=4^T07.
