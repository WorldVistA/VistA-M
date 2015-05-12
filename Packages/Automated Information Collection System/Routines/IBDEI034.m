IBDEI034 ; ; 09-FEB-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;OCT 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,3740,0)
 ;;=T83.112A^^18^176^6
 ;;^UTILITY(U,$J,358.3,3740,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3740,1,3,0)
 ;;=3^Breakdown (mech) of urinary stent,Init Encntr
 ;;^UTILITY(U,$J,358.3,3740,1,4,0)
 ;;=4^T83.112A
 ;;^UTILITY(U,$J,358.3,3740,2)
 ;;=^5054989
 ;;^UTILITY(U,$J,358.3,3741,0)
 ;;=T83.118A^^18^176^3
 ;;^UTILITY(U,$J,358.3,3741,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3741,1,3,0)
 ;;=3^Breakdown (mech) of urinary devices and implants,Init Encntr
 ;;^UTILITY(U,$J,358.3,3741,1,4,0)
 ;;=4^T83.118A
 ;;^UTILITY(U,$J,358.3,3741,2)
 ;;=^5054992
 ;;^UTILITY(U,$J,358.3,3742,0)
 ;;=T83.191A^^18^176^27
 ;;^UTILITY(U,$J,358.3,3742,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3742,1,3,0)
 ;;=3^Mech compl of urinary sphincter implant,Oth,Init Encntr
 ;;^UTILITY(U,$J,358.3,3742,1,4,0)
 ;;=4^T83.191A
 ;;^UTILITY(U,$J,358.3,3742,2)
 ;;=^5055010
 ;;^UTILITY(U,$J,358.3,3743,0)
 ;;=T83.192A^^18^176^28
 ;;^UTILITY(U,$J,358.3,3743,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3743,1,3,0)
 ;;=3^Mech compl of urinary stent,Oth,Init Encntr
 ;;^UTILITY(U,$J,358.3,3743,1,4,0)
 ;;=4^T83.192A
 ;;^UTILITY(U,$J,358.3,3743,2)
 ;;=^5055013
 ;;^UTILITY(U,$J,358.3,3744,0)
 ;;=T83.198A^^18^176^23
 ;;^UTILITY(U,$J,358.3,3744,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3744,1,3,0)
 ;;=3^Mech compl of oth urinary devices and implants,Init Encntr
 ;;^UTILITY(U,$J,358.3,3744,1,4,0)
 ;;=4^T83.198A
 ;;^UTILITY(U,$J,358.3,3744,2)
 ;;=^5055016
 ;;^UTILITY(U,$J,358.3,3745,0)
 ;;=T83.410A^^18^176^2
 ;;^UTILITY(U,$J,358.3,3745,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3745,1,3,0)
 ;;=3^Breakdown (mech) of penile (implanted) prosthesis,Init Encntr
 ;;^UTILITY(U,$J,358.3,3745,1,4,0)
 ;;=4^T83.410A
 ;;^UTILITY(U,$J,358.3,3745,2)
 ;;=^5055040
 ;;^UTILITY(U,$J,358.3,3746,0)
 ;;=T83.418A^^18^176^7
 ;;^UTILITY(U,$J,358.3,3746,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3746,1,3,0)
 ;;=3^Breakdown of prosth dev/implnt/grft of genitl trct,Init Encntr
 ;;^UTILITY(U,$J,358.3,3746,1,4,0)
 ;;=4^T83.418A
 ;;^UTILITY(U,$J,358.3,3746,2)
 ;;=^5055043
 ;;^UTILITY(U,$J,358.3,3747,0)
 ;;=T83.420A^^18^176^10
 ;;^UTILITY(U,$J,358.3,3747,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3747,1,3,0)
 ;;=3^Displacement of penile (implanted) prosthesis,Init Encntr
 ;;^UTILITY(U,$J,358.3,3747,1,4,0)
 ;;=4^T83.420A
 ;;^UTILITY(U,$J,358.3,3747,2)
 ;;=^5055046
 ;;^UTILITY(U,$J,358.3,3748,0)
 ;;=T83.428A^^18^176^11
 ;;^UTILITY(U,$J,358.3,3748,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3748,1,3,0)
 ;;=3^Displacement of prosth dev/implnt/grft of genitl trct,Init Encntr
 ;;^UTILITY(U,$J,358.3,3748,1,4,0)
 ;;=4^T83.428A
 ;;^UTILITY(U,$J,358.3,3748,2)
 ;;=^5055049
 ;;^UTILITY(U,$J,358.3,3749,0)
 ;;=T83.490A^^18^176^24
 ;;^UTILITY(U,$J,358.3,3749,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3749,1,3,0)
 ;;=3^Mech compl of penile (implanted) prosth,Oth,Init Encntr
 ;;^UTILITY(U,$J,358.3,3749,1,4,0)
 ;;=4^T83.490A
 ;;^UTILITY(U,$J,358.3,3749,2)
 ;;=^5055052
 ;;^UTILITY(U,$J,358.3,3750,0)
 ;;=T83.498A^^18^176^25
 ;;^UTILITY(U,$J,358.3,3750,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3750,1,3,0)
 ;;=3^Mech compl of prosth dev/implnt/grft of genitl trct,Oth,Init Encntr
 ;;^UTILITY(U,$J,358.3,3750,1,4,0)
 ;;=4^T83.498A
 ;;^UTILITY(U,$J,358.3,3750,2)
 ;;=^5055055
 ;;^UTILITY(U,$J,358.3,3751,0)
 ;;=N99.820^^18^176^29
 ;;^UTILITY(U,$J,358.3,3751,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3751,1,3,0)
 ;;=3^Postproc hemor/hemtom of a GU sys org fol a GU sys procedure
 ;;^UTILITY(U,$J,358.3,3751,1,4,0)
 ;;=4^N99.820
 ;;^UTILITY(U,$J,358.3,3751,2)
 ;;=^5015968
 ;;^UTILITY(U,$J,358.3,3752,0)
 ;;=T81.4XXA^^18^176^20
 ;;^UTILITY(U,$J,358.3,3752,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3752,1,3,0)
 ;;=3^Infection following a procedure,Init Encntr
 ;;^UTILITY(U,$J,358.3,3752,1,4,0)
 ;;=4^T81.4XXA
 ;;^UTILITY(U,$J,358.3,3752,2)
 ;;=^5054479
 ;;^UTILITY(U,$J,358.3,3753,0)
 ;;=K68.11^^18^176^30
 ;;^UTILITY(U,$J,358.3,3753,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3753,1,3,0)
 ;;=3^Postprocedural retroperitoneal abscess
 ;;^UTILITY(U,$J,358.3,3753,1,4,0)
 ;;=4^K68.11
 ;;^UTILITY(U,$J,358.3,3753,2)
 ;;=^5008782
 ;;^UTILITY(U,$J,358.3,3754,0)
 ;;=Z48.00^^18^176^15
 ;;^UTILITY(U,$J,358.3,3754,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3754,1,3,0)
 ;;=3^Encounter for change or removal of nonsurg wound dressing
 ;;^UTILITY(U,$J,358.3,3754,1,4,0)
 ;;=4^Z48.00
 ;;^UTILITY(U,$J,358.3,3754,2)
 ;;=^5063033
 ;;^UTILITY(U,$J,358.3,3755,0)
 ;;=Z48.01^^18^176^16
 ;;^UTILITY(U,$J,358.3,3755,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3755,1,3,0)
 ;;=3^Encounter for change or removal of surgical wound dressing
 ;;^UTILITY(U,$J,358.3,3755,1,4,0)
 ;;=4^Z48.01
 ;;^UTILITY(U,$J,358.3,3755,2)
 ;;=^5063034
 ;;^UTILITY(U,$J,358.3,3756,0)
 ;;=Z48.02^^18^176^18
 ;;^UTILITY(U,$J,358.3,3756,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3756,1,3,0)
 ;;=3^Encounter for removal of sutures
 ;;^UTILITY(U,$J,358.3,3756,1,4,0)
 ;;=4^Z48.02
 ;;^UTILITY(U,$J,358.3,3756,2)
 ;;=^5063035
 ;;^UTILITY(U,$J,358.3,3757,0)
 ;;=Z48.89^^18^176^17
 ;;^UTILITY(U,$J,358.3,3757,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3757,1,3,0)
 ;;=3^Encounter for other specified surgical aftercare
 ;;^UTILITY(U,$J,358.3,3757,1,4,0)
 ;;=4^Z48.89
 ;;^UTILITY(U,$J,358.3,3757,2)
 ;;=^5063055
 ;;^UTILITY(U,$J,358.3,3758,0)
 ;;=Z48.03^^18^176^14
 ;;^UTILITY(U,$J,358.3,3758,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3758,1,3,0)
 ;;=3^Encounter for change or removal of drains
 ;;^UTILITY(U,$J,358.3,3758,1,4,0)
 ;;=4^Z48.03
 ;;^UTILITY(U,$J,358.3,3758,2)
 ;;=^5063036
 ;;^UTILITY(U,$J,358.3,3759,0)
 ;;=Z48.816^^18^176^19
 ;;^UTILITY(U,$J,358.3,3759,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3759,1,3,0)
 ;;=3^Encounter for surgical aftcr following surg on the GU sys
 ;;^UTILITY(U,$J,358.3,3759,1,4,0)
 ;;=4^Z48.816
 ;;^UTILITY(U,$J,358.3,3759,2)
 ;;=^5063053
 ;;^UTILITY(U,$J,358.3,3760,0)
 ;;=D29.1^^18^177^3
 ;;^UTILITY(U,$J,358.3,3760,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3760,1,3,0)
 ;;=3^Benign neoplasm of prostate
 ;;^UTILITY(U,$J,358.3,3760,1,4,0)
 ;;=4^D29.1
 ;;^UTILITY(U,$J,358.3,3760,2)
 ;;=^267657
 ;;^UTILITY(U,$J,358.3,3761,0)
 ;;=N40.0^^18^177^5
 ;;^UTILITY(U,$J,358.3,3761,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3761,1,3,0)
 ;;=3^Enlarged prostate without lower urinary tract symptoms (LUTS)
 ;;^UTILITY(U,$J,358.3,3761,1,4,0)
 ;;=4^N40.0
 ;;^UTILITY(U,$J,358.3,3761,2)
 ;;=^5015689
 ;;^UTILITY(U,$J,358.3,3762,0)
 ;;=N41.0^^18^177^2
 ;;^UTILITY(U,$J,358.3,3762,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3762,1,3,0)
 ;;=3^Acute prostatitis
 ;;^UTILITY(U,$J,358.3,3762,1,4,0)
 ;;=4^N41.0
 ;;^UTILITY(U,$J,358.3,3762,2)
 ;;=^259106
 ;;^UTILITY(U,$J,358.3,3763,0)
 ;;=N41.1^^18^177^4
 ;;^UTILITY(U,$J,358.3,3763,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3763,1,3,0)
 ;;=3^Chronic prostatitis
 ;;^UTILITY(U,$J,358.3,3763,1,4,0)
 ;;=4^N41.1
 ;;^UTILITY(U,$J,358.3,3763,2)
 ;;=^186931
 ;;^UTILITY(U,$J,358.3,3764,0)
 ;;=N41.2^^18^177^1
 ;;^UTILITY(U,$J,358.3,3764,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3764,1,3,0)
 ;;=3^Abscess of prostate
 ;;^UTILITY(U,$J,358.3,3764,1,4,0)
 ;;=4^N41.2
 ;;^UTILITY(U,$J,358.3,3764,2)
 ;;=^270416
 ;;^UTILITY(U,$J,358.3,3765,0)
 ;;=D29.21^^18^178^2
 ;;^UTILITY(U,$J,358.3,3765,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3765,1,3,0)
 ;;=3^Benign neoplasm of right testis
 ;;^UTILITY(U,$J,358.3,3765,1,4,0)
 ;;=4^D29.21
 ;;^UTILITY(U,$J,358.3,3765,2)
 ;;=^5002093
 ;;^UTILITY(U,$J,358.3,3766,0)
 ;;=D29.22^^18^178^1
 ;;^UTILITY(U,$J,358.3,3766,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3766,1,3,0)
 ;;=3^Benign neoplasm of left testis
 ;;^UTILITY(U,$J,358.3,3766,1,4,0)
 ;;=4^D29.22
 ;;^UTILITY(U,$J,358.3,3766,2)
 ;;=^5002094
 ;;^UTILITY(U,$J,358.3,3767,0)
 ;;=E29.1^^18^178^12
 ;;^UTILITY(U,$J,358.3,3767,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3767,1,3,0)
 ;;=3^Testicular hypofunction
 ;;^UTILITY(U,$J,358.3,3767,1,4,0)
 ;;=4^E29.1
 ;;^UTILITY(U,$J,358.3,3767,2)
 ;;=^5002754
 ;;^UTILITY(U,$J,358.3,3768,0)
 ;;=N43.3^^18^178^9
 ;;^UTILITY(U,$J,358.3,3768,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3768,1,3,0)
 ;;=3^Hydrocele, unspec
 ;;^UTILITY(U,$J,358.3,3768,1,4,0)
 ;;=4^N43.3
 ;;^UTILITY(U,$J,358.3,3768,2)
 ;;=^5015700
 ;;^UTILITY(U,$J,358.3,3769,0)
 ;;=N45.3^^18^178^6
 ;;^UTILITY(U,$J,358.3,3769,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3769,1,3,0)
 ;;=3^Epididymo-orchitis
 ;;^UTILITY(U,$J,358.3,3769,1,4,0)
 ;;=4^N45.3
 ;;^UTILITY(U,$J,358.3,3769,2)
 ;;=^5015707
 ;;^UTILITY(U,$J,358.3,3770,0)
 ;;=N45.2^^18^178^10
 ;;^UTILITY(U,$J,358.3,3770,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3770,1,3,0)
 ;;=3^Orchitis
 ;;^UTILITY(U,$J,358.3,3770,1,4,0)
 ;;=4^N45.2
 ;;^UTILITY(U,$J,358.3,3770,2)
 ;;=^86174
 ;;^UTILITY(U,$J,358.3,3771,0)
 ;;=N45.1^^18^178^5
 ;;^UTILITY(U,$J,358.3,3771,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3771,1,3,0)
 ;;=3^Epididymitis
 ;;^UTILITY(U,$J,358.3,3771,1,4,0)
 ;;=4^N45.1
 ;;^UTILITY(U,$J,358.3,3771,2)
 ;;=^41396
 ;;^UTILITY(U,$J,358.3,3772,0)
 ;;=N43.40^^18^178^11
 ;;^UTILITY(U,$J,358.3,3772,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3772,1,3,0)
 ;;=3^Spermatocele of epididymis, unspec
 ;;^UTILITY(U,$J,358.3,3772,1,4,0)
 ;;=4^N43.40
 ;;^UTILITY(U,$J,358.3,3772,2)
 ;;=^5015701
 ;;^UTILITY(U,$J,358.3,3773,0)
 ;;=R36.1^^18^178^8
 ;;^UTILITY(U,$J,358.3,3773,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3773,1,3,0)
 ;;=3^Hematospermia
 ;;^UTILITY(U,$J,358.3,3773,1,4,0)
 ;;=4^R36.1
 ;;^UTILITY(U,$J,358.3,3773,2)
 ;;=^323546
 ;;^UTILITY(U,$J,358.3,3774,0)
 ;;=N50.9^^18^178^3
 ;;^UTILITY(U,$J,358.3,3774,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3774,1,3,0)
 ;;=3^Disorder of male genital organs, unspec
 ;;^UTILITY(U,$J,358.3,3774,1,4,0)
 ;;=4^N50.9
 ;;^UTILITY(U,$J,358.3,3774,2)
 ;;=^5015751
 ;;^UTILITY(U,$J,358.3,3775,0)
 ;;=L72.9^^18^178^7
