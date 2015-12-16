IBDEI1X3 ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,33700,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33700,1,3,0)
 ;;=3^Female Infertility,Unspec
 ;;^UTILITY(U,$J,358.3,33700,1,4,0)
 ;;=4^N97.9
 ;;^UTILITY(U,$J,358.3,33700,2)
 ;;=^5015935
 ;;^UTILITY(U,$J,358.3,33701,0)
 ;;=L29.1^^182^2008^50
 ;;^UTILITY(U,$J,358.3,33701,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33701,1,3,0)
 ;;=3^Pruritus Scroti
 ;;^UTILITY(U,$J,358.3,33701,1,4,0)
 ;;=4^L29.1
 ;;^UTILITY(U,$J,358.3,33701,2)
 ;;=^5009150
 ;;^UTILITY(U,$J,358.3,33702,0)
 ;;=L29.2^^182^2008^51
 ;;^UTILITY(U,$J,358.3,33702,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33702,1,3,0)
 ;;=3^Pruritus Vulvae
 ;;^UTILITY(U,$J,358.3,33702,1,4,0)
 ;;=4^L29.2
 ;;^UTILITY(U,$J,358.3,33702,2)
 ;;=^100075
 ;;^UTILITY(U,$J,358.3,33703,0)
 ;;=R92.8^^182^2008^4
 ;;^UTILITY(U,$J,358.3,33703,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33703,1,3,0)
 ;;=3^Abnormal/Inconclusive Findings on Dx Imaging of Breast
 ;;^UTILITY(U,$J,358.3,33703,1,4,0)
 ;;=4^R92.8
 ;;^UTILITY(U,$J,358.3,33703,2)
 ;;=^5019712
 ;;^UTILITY(U,$J,358.3,33704,0)
 ;;=R87.619^^182^2008^1
 ;;^UTILITY(U,$J,358.3,33704,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33704,1,3,0)
 ;;=3^Abnormal Cytology Findings in Specimen of Cervix Uteri,Unspec
 ;;^UTILITY(U,$J,358.3,33704,1,4,0)
 ;;=4^R87.619
 ;;^UTILITY(U,$J,358.3,33704,2)
 ;;=^5019676
 ;;^UTILITY(U,$J,358.3,33705,0)
 ;;=Z79.890^^182^2008^25
 ;;^UTILITY(U,$J,358.3,33705,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33705,1,3,0)
 ;;=3^Hormone Replacement Therapy,Postmenopausal
 ;;^UTILITY(U,$J,358.3,33705,1,4,0)
 ;;=4^Z79.890
 ;;^UTILITY(U,$J,358.3,33705,2)
 ;;=^331975
 ;;^UTILITY(U,$J,358.3,33706,0)
 ;;=Z33.1^^182^2008^48
 ;;^UTILITY(U,$J,358.3,33706,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33706,1,3,0)
 ;;=3^Pregnant State,Incidental
 ;;^UTILITY(U,$J,358.3,33706,1,4,0)
 ;;=4^Z33.1
 ;;^UTILITY(U,$J,358.3,33706,2)
 ;;=^5062853
 ;;^UTILITY(U,$J,358.3,33707,0)
 ;;=Z39.2^^182^2008^47
 ;;^UTILITY(U,$J,358.3,33707,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33707,1,3,0)
 ;;=3^Postpartum Follow-up Routine Encounter
 ;;^UTILITY(U,$J,358.3,33707,1,4,0)
 ;;=4^Z39.2
 ;;^UTILITY(U,$J,358.3,33707,2)
 ;;=^5062906
 ;;^UTILITY(U,$J,358.3,33708,0)
 ;;=Z30.09^^182^2008^10
 ;;^UTILITY(U,$J,358.3,33708,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33708,1,3,0)
 ;;=3^Counsel/Advice on Contraception Encounter
 ;;^UTILITY(U,$J,358.3,33708,1,4,0)
 ;;=4^Z30.09
 ;;^UTILITY(U,$J,358.3,33708,2)
 ;;=^5062817
 ;;^UTILITY(U,$J,358.3,33709,0)
 ;;=Z30.9^^182^2008^9
 ;;^UTILITY(U,$J,358.3,33709,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33709,1,3,0)
 ;;=3^Contraceptive Management Encounter
 ;;^UTILITY(U,$J,358.3,33709,1,4,0)
 ;;=4^Z30.9
 ;;^UTILITY(U,$J,358.3,33709,2)
 ;;=^5062828
 ;;^UTILITY(U,$J,358.3,33710,0)
 ;;=S31.000A^^182^2009^6
 ;;^UTILITY(U,$J,358.3,33710,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33710,1,3,0)
 ;;=3^Open Wnd Low Back/Pelvis w/o Penet Retroperiton,Init,Unspec
 ;;^UTILITY(U,$J,358.3,33710,1,4,0)
 ;;=4^S31.000A
 ;;^UTILITY(U,$J,358.3,33710,2)
 ;;=^5023993
 ;;^UTILITY(U,$J,358.3,33711,0)
 ;;=S31.050A^^182^2009^5
 ;;^UTILITY(U,$J,358.3,33711,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33711,1,3,0)
 ;;=3^Open Bite Low Back/Pelvis w/o Penet Retroperiton,Init
 ;;^UTILITY(U,$J,358.3,33711,1,4,0)
 ;;=4^S31.050A
 ;;^UTILITY(U,$J,358.3,33711,2)
 ;;=^5024017
 ;;^UTILITY(U,$J,358.3,33712,0)
 ;;=S31.030A^^182^2009^7
 ;;^UTILITY(U,$J,358.3,33712,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33712,1,3,0)
 ;;=3^Puncture Wnd w/o FB Low Back/Pelvis w/o Penet Retroperiton,Init
 ;;^UTILITY(U,$J,358.3,33712,1,4,0)
 ;;=4^S31.030A
