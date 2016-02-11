IBDEI3C3 ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,56023,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,56023,1,3,0)
 ;;=3^Abnormal/Inconclusive Findings on Dx Imaging of Breast
 ;;^UTILITY(U,$J,358.3,56023,1,4,0)
 ;;=4^R92.8
 ;;^UTILITY(U,$J,358.3,56023,2)
 ;;=^5019712
 ;;^UTILITY(U,$J,358.3,56024,0)
 ;;=R87.619^^256^2791^1
 ;;^UTILITY(U,$J,358.3,56024,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,56024,1,3,0)
 ;;=3^Abnormal Cytology Findings in Specimen of Cervix Uteri,Unspec
 ;;^UTILITY(U,$J,358.3,56024,1,4,0)
 ;;=4^R87.619
 ;;^UTILITY(U,$J,358.3,56024,2)
 ;;=^5019676
 ;;^UTILITY(U,$J,358.3,56025,0)
 ;;=Z79.890^^256^2791^26
 ;;^UTILITY(U,$J,358.3,56025,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,56025,1,3,0)
 ;;=3^Hormone Replacement Therapy,Postmenopausal
 ;;^UTILITY(U,$J,358.3,56025,1,4,0)
 ;;=4^Z79.890
 ;;^UTILITY(U,$J,358.3,56025,2)
 ;;=^331975
 ;;^UTILITY(U,$J,358.3,56026,0)
 ;;=Z33.1^^256^2791^50
 ;;^UTILITY(U,$J,358.3,56026,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,56026,1,3,0)
 ;;=3^Pregnant State,Incidental
 ;;^UTILITY(U,$J,358.3,56026,1,4,0)
 ;;=4^Z33.1
 ;;^UTILITY(U,$J,358.3,56026,2)
 ;;=^5062853
 ;;^UTILITY(U,$J,358.3,56027,0)
 ;;=Z39.2^^256^2791^49
 ;;^UTILITY(U,$J,358.3,56027,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,56027,1,3,0)
 ;;=3^Postpartum Follow-up Routine Encounter
 ;;^UTILITY(U,$J,358.3,56027,1,4,0)
 ;;=4^Z39.2
 ;;^UTILITY(U,$J,358.3,56027,2)
 ;;=^5062906
 ;;^UTILITY(U,$J,358.3,56028,0)
 ;;=Z30.09^^256^2791^10
 ;;^UTILITY(U,$J,358.3,56028,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,56028,1,3,0)
 ;;=3^Counsel/Advice on Contraception Encounter
 ;;^UTILITY(U,$J,358.3,56028,1,4,0)
 ;;=4^Z30.09
 ;;^UTILITY(U,$J,358.3,56028,2)
 ;;=^5062817
 ;;^UTILITY(U,$J,358.3,56029,0)
 ;;=Z30.9^^256^2791^9
 ;;^UTILITY(U,$J,358.3,56029,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,56029,1,3,0)
 ;;=3^Contraceptive Management Encounter
 ;;^UTILITY(U,$J,358.3,56029,1,4,0)
 ;;=4^Z30.9
 ;;^UTILITY(U,$J,358.3,56029,2)
 ;;=^5062828
 ;;^UTILITY(U,$J,358.3,56030,0)
 ;;=N64.3^^256^2791^23
 ;;^UTILITY(U,$J,358.3,56030,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,56030,1,3,0)
 ;;=3^Galactorrhea Not Associated w/ Childbirth
 ;;^UTILITY(U,$J,358.3,56030,1,4,0)
 ;;=4^N64.3
 ;;^UTILITY(U,$J,358.3,56030,2)
 ;;=^270460
 ;;^UTILITY(U,$J,358.3,56031,0)
 ;;=R92.2^^256^2791^27
 ;;^UTILITY(U,$J,358.3,56031,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,56031,1,3,0)
 ;;=3^Inconclusive Mammogram
 ;;^UTILITY(U,$J,358.3,56031,1,4,0)
 ;;=4^R92.2
 ;;^UTILITY(U,$J,358.3,56031,2)
 ;;=^5019711
 ;;^UTILITY(U,$J,358.3,56032,0)
 ;;=Z30.432^^256^2791^53
 ;;^UTILITY(U,$J,358.3,56032,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,56032,1,3,0)
 ;;=3^Removal of IUD
 ;;^UTILITY(U,$J,358.3,56032,1,4,0)
 ;;=4^Z30.432
 ;;^UTILITY(U,$J,358.3,56032,2)
 ;;=^5062824
 ;;^UTILITY(U,$J,358.3,56033,0)
 ;;=S31.000A^^256^2792^5
 ;;^UTILITY(U,$J,358.3,56033,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,56033,1,3,0)
 ;;=3^Open Wnd Low Back/Pelvis w/o Penet Retroperiton,Init,Unspec
 ;;^UTILITY(U,$J,358.3,56033,1,4,0)
 ;;=4^S31.000A
 ;;^UTILITY(U,$J,358.3,56033,2)
 ;;=^5023993
 ;;^UTILITY(U,$J,358.3,56034,0)
 ;;=S31.010A^^256^2792^2
 ;;^UTILITY(U,$J,358.3,56034,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,56034,1,3,0)
 ;;=3^Laceration w/o FB Low Back/Pelvis w/o Penet Retroperiton,Init
 ;;^UTILITY(U,$J,358.3,56034,1,4,0)
 ;;=4^S31.010A
 ;;^UTILITY(U,$J,358.3,56034,2)
 ;;=^5023999
 ;;^UTILITY(U,$J,358.3,56035,0)
 ;;=T07.^^256^2792^4
 ;;^UTILITY(U,$J,358.3,56035,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,56035,1,3,0)
 ;;=3^Multiple Injuries,Unspec
 ;;^UTILITY(U,$J,358.3,56035,1,4,0)
 ;;=4^T07.
