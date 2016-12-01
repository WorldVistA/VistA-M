IBDEI063 ; ; 09-AUG-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,7586,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7586,1,3,0)
 ;;=3^Hematocolpos
 ;;^UTILITY(U,$J,358.3,7586,1,4,0)
 ;;=4^N89.7
 ;;^UTILITY(U,$J,358.3,7586,2)
 ;;=^5015889
 ;;^UTILITY(U,$J,358.3,7587,0)
 ;;=N93.8^^26^418^2
 ;;^UTILITY(U,$J,358.3,7587,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7587,1,3,0)
 ;;=3^Abnormal Uterine/Vaginal Bleeding,Other Spec
 ;;^UTILITY(U,$J,358.3,7587,1,4,0)
 ;;=4^N93.8
 ;;^UTILITY(U,$J,358.3,7587,2)
 ;;=^5015915
 ;;^UTILITY(U,$J,358.3,7588,0)
 ;;=N93.9^^26^418^3
 ;;^UTILITY(U,$J,358.3,7588,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7588,1,3,0)
 ;;=3^Abnormal Uterine/Vaginal Bleeding,Unspec
 ;;^UTILITY(U,$J,358.3,7588,1,4,0)
 ;;=4^N93.9
 ;;^UTILITY(U,$J,358.3,7588,2)
 ;;=^5015916
 ;;^UTILITY(U,$J,358.3,7589,0)
 ;;=N92.4^^26^418^19
 ;;^UTILITY(U,$J,358.3,7589,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7589,1,3,0)
 ;;=3^Excessive Bleeding in Premenopausal Period
 ;;^UTILITY(U,$J,358.3,7589,1,4,0)
 ;;=4^N92.4
 ;;^UTILITY(U,$J,358.3,7589,2)
 ;;=^5015911
 ;;^UTILITY(U,$J,358.3,7590,0)
 ;;=N95.0^^26^418^48
 ;;^UTILITY(U,$J,358.3,7590,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7590,1,3,0)
 ;;=3^Postmenopausal Bleeding
 ;;^UTILITY(U,$J,358.3,7590,1,4,0)
 ;;=4^N95.0
 ;;^UTILITY(U,$J,358.3,7590,2)
 ;;=^97040
 ;;^UTILITY(U,$J,358.3,7591,0)
 ;;=N95.1^^26^418^35
 ;;^UTILITY(U,$J,358.3,7591,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7591,1,3,0)
 ;;=3^Menopausal/Female Climacteric States
 ;;^UTILITY(U,$J,358.3,7591,1,4,0)
 ;;=4^N95.1
 ;;^UTILITY(U,$J,358.3,7591,2)
 ;;=^5015927
 ;;^UTILITY(U,$J,358.3,7592,0)
 ;;=N97.0^^26^418^21
 ;;^UTILITY(U,$J,358.3,7592,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7592,1,3,0)
 ;;=3^Female Infertility Associated w/ Anovulation
 ;;^UTILITY(U,$J,358.3,7592,1,4,0)
 ;;=4^N97.0
 ;;^UTILITY(U,$J,358.3,7592,2)
 ;;=^5015931
 ;;^UTILITY(U,$J,358.3,7593,0)
 ;;=N97.9^^26^418^22
 ;;^UTILITY(U,$J,358.3,7593,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7593,1,3,0)
 ;;=3^Female Infertility,Unspec
 ;;^UTILITY(U,$J,358.3,7593,1,4,0)
 ;;=4^N97.9
 ;;^UTILITY(U,$J,358.3,7593,2)
 ;;=^5015935
 ;;^UTILITY(U,$J,358.3,7594,0)
 ;;=L29.2^^26^418^52
 ;;^UTILITY(U,$J,358.3,7594,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7594,1,3,0)
 ;;=3^Pruritus Vulvae
 ;;^UTILITY(U,$J,358.3,7594,1,4,0)
 ;;=4^L29.2
 ;;^UTILITY(U,$J,358.3,7594,2)
 ;;=^100075
 ;;^UTILITY(U,$J,358.3,7595,0)
 ;;=R92.8^^26^418^4
 ;;^UTILITY(U,$J,358.3,7595,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7595,1,3,0)
 ;;=3^Abnormal/Inconclusive Findings on Dx Imaging of Breast
 ;;^UTILITY(U,$J,358.3,7595,1,4,0)
 ;;=4^R92.8
 ;;^UTILITY(U,$J,358.3,7595,2)
 ;;=^5019712
 ;;^UTILITY(U,$J,358.3,7596,0)
 ;;=R87.619^^26^418^1
 ;;^UTILITY(U,$J,358.3,7596,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7596,1,3,0)
 ;;=3^Abnormal Cytology Findings in Specimen of Cervix Uteri,Unspec
 ;;^UTILITY(U,$J,358.3,7596,1,4,0)
 ;;=4^R87.619
 ;;^UTILITY(U,$J,358.3,7596,2)
 ;;=^5019676
 ;;^UTILITY(U,$J,358.3,7597,0)
 ;;=Z79.890^^26^418^26
 ;;^UTILITY(U,$J,358.3,7597,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7597,1,3,0)
 ;;=3^Hormone Replacement Therapy,Postmenopausal
 ;;^UTILITY(U,$J,358.3,7597,1,4,0)
 ;;=4^Z79.890
 ;;^UTILITY(U,$J,358.3,7597,2)
 ;;=^331975
 ;;^UTILITY(U,$J,358.3,7598,0)
 ;;=Z33.1^^26^418^50
 ;;^UTILITY(U,$J,358.3,7598,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7598,1,3,0)
 ;;=3^Pregnant State,Incidental
 ;;^UTILITY(U,$J,358.3,7598,1,4,0)
 ;;=4^Z33.1
 ;;^UTILITY(U,$J,358.3,7598,2)
 ;;=^5062853
 ;;^UTILITY(U,$J,358.3,7599,0)
 ;;=Z39.2^^26^418^49
 ;;^UTILITY(U,$J,358.3,7599,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7599,1,3,0)
 ;;=3^Postpartum Follow-up Routine Encounter
 ;;^UTILITY(U,$J,358.3,7599,1,4,0)
 ;;=4^Z39.2
 ;;^UTILITY(U,$J,358.3,7599,2)
 ;;=^5062906
 ;;^UTILITY(U,$J,358.3,7600,0)
 ;;=Z30.09^^26^418^10
 ;;^UTILITY(U,$J,358.3,7600,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7600,1,3,0)
 ;;=3^Counsel/Advice on Contraception Encounter
 ;;^UTILITY(U,$J,358.3,7600,1,4,0)
 ;;=4^Z30.09
 ;;^UTILITY(U,$J,358.3,7600,2)
 ;;=^5062817
 ;;^UTILITY(U,$J,358.3,7601,0)
 ;;=Z30.9^^26^418^9
 ;;^UTILITY(U,$J,358.3,7601,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7601,1,3,0)
 ;;=3^Contraceptive Management Encounter
 ;;^UTILITY(U,$J,358.3,7601,1,4,0)
 ;;=4^Z30.9
 ;;^UTILITY(U,$J,358.3,7601,2)
 ;;=^5062828
 ;;^UTILITY(U,$J,358.3,7602,0)
 ;;=N64.3^^26^418^23
 ;;^UTILITY(U,$J,358.3,7602,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7602,1,3,0)
 ;;=3^Galactorrhea Not Associated w/ Childbirth
 ;;^UTILITY(U,$J,358.3,7602,1,4,0)
 ;;=4^N64.3
 ;;^UTILITY(U,$J,358.3,7602,2)
 ;;=^270460
 ;;^UTILITY(U,$J,358.3,7603,0)
 ;;=R92.2^^26^418^27
 ;;^UTILITY(U,$J,358.3,7603,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7603,1,3,0)
 ;;=3^Inconclusive Mammogram
 ;;^UTILITY(U,$J,358.3,7603,1,4,0)
 ;;=4^R92.2
 ;;^UTILITY(U,$J,358.3,7603,2)
 ;;=^5019711
 ;;^UTILITY(U,$J,358.3,7604,0)
 ;;=Z30.432^^26^418^53
 ;;^UTILITY(U,$J,358.3,7604,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7604,1,3,0)
 ;;=3^Removal of IUD
 ;;^UTILITY(U,$J,358.3,7604,1,4,0)
 ;;=4^Z30.432
 ;;^UTILITY(U,$J,358.3,7604,2)
 ;;=^5062824
 ;;^UTILITY(U,$J,358.3,7605,0)
 ;;=S31.000A^^26^419^13
 ;;^UTILITY(U,$J,358.3,7605,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7605,1,3,0)
 ;;=3^Open Wnd Low Back/Pelvis w/o Penet Retroperiton,Init,Unspec
 ;;^UTILITY(U,$J,358.3,7605,1,4,0)
 ;;=4^S31.000A
 ;;^UTILITY(U,$J,358.3,7605,2)
 ;;=^5023993
 ;;^UTILITY(U,$J,358.3,7606,0)
 ;;=S31.010A^^26^419^10
 ;;^UTILITY(U,$J,358.3,7606,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7606,1,3,0)
 ;;=3^Laceration w/o FB Low Back/Pelvis w/o Penet Retroperiton,Init
 ;;^UTILITY(U,$J,358.3,7606,1,4,0)
 ;;=4^S31.010A
 ;;^UTILITY(U,$J,358.3,7606,2)
 ;;=^5023999
 ;;^UTILITY(U,$J,358.3,7607,0)
 ;;=T07.^^26^419^12
 ;;^UTILITY(U,$J,358.3,7607,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7607,1,3,0)
 ;;=3^Multiple Injuries,Unspec
 ;;^UTILITY(U,$J,358.3,7607,1,4,0)
 ;;=4^T07.
 ;;^UTILITY(U,$J,358.3,7607,2)
 ;;=^5046377
 ;;^UTILITY(U,$J,358.3,7608,0)
 ;;=L08.89^^26^419^11
 ;;^UTILITY(U,$J,358.3,7608,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7608,1,3,0)
 ;;=3^Local Infections Skin/Subcutaneous Tissue,Oth Spec
 ;;^UTILITY(U,$J,358.3,7608,1,4,0)
 ;;=4^L08.89
 ;;^UTILITY(U,$J,358.3,7608,2)
 ;;=^5009081
 ;;^UTILITY(U,$J,358.3,7609,0)
 ;;=T14.90^^26^419^3
 ;;^UTILITY(U,$J,358.3,7609,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7609,1,3,0)
 ;;=3^Injury,Unspec
 ;;^UTILITY(U,$J,358.3,7609,1,4,0)
 ;;=4^T14.90
 ;;^UTILITY(U,$J,358.3,7609,2)
 ;;=^5046379
 ;;^UTILITY(U,$J,358.3,7610,0)
 ;;=S91.002A^^26^419^14
 ;;^UTILITY(U,$J,358.3,7610,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7610,1,3,0)
 ;;=3^Open Wound,Left Ankle,Unspec
 ;;^UTILITY(U,$J,358.3,7610,1,4,0)
 ;;=4^S91.002A
 ;;^UTILITY(U,$J,358.3,7610,2)
 ;;=^5044132
 ;;^UTILITY(U,$J,358.3,7611,0)
 ;;=S91.302A^^26^419^15
 ;;^UTILITY(U,$J,358.3,7611,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7611,1,3,0)
 ;;=3^Open Wound,Left Foot,Unspec
 ;;^UTILITY(U,$J,358.3,7611,1,4,0)
 ;;=4^S91.302A
 ;;^UTILITY(U,$J,358.3,7611,2)
 ;;=^5044317
 ;;^UTILITY(U,$J,358.3,7612,0)
 ;;=S51.802A^^26^419^16
 ;;^UTILITY(U,$J,358.3,7612,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7612,1,3,0)
 ;;=3^Open Wound,Left Forearm,Unspec
 ;;^UTILITY(U,$J,358.3,7612,1,4,0)
 ;;=4^S51.802A
 ;;^UTILITY(U,$J,358.3,7612,2)
 ;;=^5028662
 ;;^UTILITY(U,$J,358.3,7613,0)
 ;;=S91.102A^^26^419^17
 ;;^UTILITY(U,$J,358.3,7613,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7613,1,3,0)
 ;;=3^Open Wound,Left Great Toe w/o Damage to Nail,Unspec
 ;;^UTILITY(U,$J,358.3,7613,1,4,0)
 ;;=4^S91.102A
 ;;^UTILITY(U,$J,358.3,7613,2)
 ;;=^5044171
 ;;^UTILITY(U,$J,358.3,7614,0)
 ;;=S61.402A^^26^419^18
 ;;^UTILITY(U,$J,358.3,7614,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7614,1,3,0)
 ;;=3^Open Wound,Left Hand,Unspec
 ;;^UTILITY(U,$J,358.3,7614,1,4,0)
 ;;=4^S61.402A
 ;;^UTILITY(U,$J,358.3,7614,2)
 ;;=^5032984
 ;;^UTILITY(U,$J,358.3,7615,0)
 ;;=S71.002A^^26^419^19
 ;;^UTILITY(U,$J,358.3,7615,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7615,1,3,0)
 ;;=3^Open Wound,Left Hip,Unspec
 ;;^UTILITY(U,$J,358.3,7615,1,4,0)
 ;;=4^S71.002A
 ;;^UTILITY(U,$J,358.3,7615,2)
 ;;=^5036972
 ;;^UTILITY(U,$J,358.3,7616,0)
 ;;=S91.104A^^26^419^30
 ;;^UTILITY(U,$J,358.3,7616,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7616,1,3,0)
 ;;=3^Open Wound,Right Lesser Toe(s) w/o Damage to nail,Unspec
 ;;^UTILITY(U,$J,358.3,7616,1,4,0)
 ;;=4^S91.104A
 ;;^UTILITY(U,$J,358.3,7616,2)
 ;;=^5044174
 ;;^UTILITY(U,$J,358.3,7617,0)
 ;;=S81.802A^^26^419^21
 ;;^UTILITY(U,$J,358.3,7617,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7617,1,3,0)
 ;;=3^Open Wound,Left Lower Leg,Unspec
 ;;^UTILITY(U,$J,358.3,7617,1,4,0)
 ;;=4^S81.802A
 ;;^UTILITY(U,$J,358.3,7617,2)
 ;;=^5040068
 ;;^UTILITY(U,$J,358.3,7618,0)
 ;;=S41.102A^^26^419^23
 ;;^UTILITY(U,$J,358.3,7618,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7618,1,3,0)
 ;;=3^Open Wound,Left Upper Arm,Unspec
 ;;^UTILITY(U,$J,358.3,7618,1,4,0)
 ;;=4^S41.102A
 ;;^UTILITY(U,$J,358.3,7618,2)
 ;;=^5026333
 ;;^UTILITY(U,$J,358.3,7619,0)
 ;;=S91.001A^^26^419^24
 ;;^UTILITY(U,$J,358.3,7619,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7619,1,3,0)
 ;;=3^Open Wound,Right Ankle,Unspec
 ;;^UTILITY(U,$J,358.3,7619,1,4,0)
 ;;=4^S91.001A
 ;;^UTILITY(U,$J,358.3,7619,2)
 ;;=^5044129
 ;;^UTILITY(U,$J,358.3,7620,0)
 ;;=S91.301A^^26^419^25
 ;;^UTILITY(U,$J,358.3,7620,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7620,1,3,0)
 ;;=3^Open Wound,Right Foot,Unspec
 ;;^UTILITY(U,$J,358.3,7620,1,4,0)
 ;;=4^S91.301A
 ;;^UTILITY(U,$J,358.3,7620,2)
 ;;=^5044314
 ;;^UTILITY(U,$J,358.3,7621,0)
 ;;=S51.801A^^26^419^26
 ;;^UTILITY(U,$J,358.3,7621,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7621,1,3,0)
 ;;=3^Open Wound,Right Forearm,Unspec
 ;;^UTILITY(U,$J,358.3,7621,1,4,0)
 ;;=4^S51.801A
 ;;^UTILITY(U,$J,358.3,7621,2)
 ;;=^5028659
 ;;^UTILITY(U,$J,358.3,7622,0)
 ;;=S91.101A^^26^419^27
