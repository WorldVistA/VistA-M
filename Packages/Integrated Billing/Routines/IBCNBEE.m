IBCNBEE ;ALB/ARH-Ins Buffer: add/edit existing entries in buffer ;1 Jun 97
 ;;2.0;INTEGRATED BILLING;**82,184,252,251,356,361,371,377,416**;21-MAR-94;Build 58
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
ADD(IBSOURCE) ; add a new buffer file entry (#355.33), sets only status (0) node data
 N IBARR,IBERR,IBIFN,IBX I '$G(IBSOURCE) S IBSOURCE=1
 ;
 S IBARR(355.33,"+1,",.01)="NOW",IBARR(355.33,"+1,",.03)=IBSOURCE
 D UPDATE^DIE("E","IBARR","IBIFN","IBERR")
 S IBX=+$G(IBIFN(1)) I $D(IBERR) S $P(IBX,U,2)=$G(IBERR("DIERR",1,"TEXT",1))
 Q IBX
 ;
STATUS(IBBUFDA,STATUS,NC,NG,NP) ; edit the status node
 ;
 N IBX,IBARR,IBIFN Q:'$G(IBBUFDA)  S IBIFN=IBBUFDA_","
 D CHK^DIE(355.33,.04,"",$G(STATUS),.IBX) Q:IBX="^"
 ;
 S IBARR(355.33,IBIFN,.04)=STATUS I STATUS="R" S (NC,NG,NP)=0
 S IBARR(355.33,IBIFN,.07)=+$G(NC),IBARR(355.33,IBIFN,.08)=+$G(NG),IBARR(355.33,IBIFN,.09)=+$G(NP)
 D FILE^DIE("E","IBARR")
 Q
 ;
INS(IBBUFDA,FLDS) ; edit the insurance company portion of a buffer file entry
 ;
 N DIC,DIE,DA,DR,X,Y,IBCNEXT1
 I $P($G(^IBA(355.33,+$G(IBBUFDA),0)),U,4)'="E" Q
 I $G(FLDS)="" S FLDS="MR"
 ;
 ; ESG - 6/18/02 - SDD 5.1.4 - Usage of Auto Match when editing
 ;     - the insurance company name in the buffer.  Also added an
 ;     - input transform (see below) to clean up the data coming in.
 ;     - fetch the current buffer ins co name
 ;
 I FLDS="MR" S IBCNEXT1=$P($G(^IBA(355.33,IBBUFDA,20)),U,1)
 ;
 S DR=$P($T(@(FLDS_"INS")+1),";;",2,9999) Q:DR=""
 ;
 I FLDS="MR" Q:$$INSNAME(IBBUFDA)<0  S DR=$P($T(@(FLDS_"INS")+1),";;",2,9999),DR=$P(DR,";",2,99999)
 ;
 S DIE="^IBA(355.33,",DA=IBBUFDA D ^DIE K DIE,DA,DR
 Q
 ;
GRP(IBBUFDA,FLDS) ; edit the group/plan portion of the buffer file entry
 ;
 N DIC,DIE,DA,DR,X,Y I $P($G(^IBA(355.33,+$G(IBBUFDA),0)),U,4)'="E" Q
 I $G(FLDS)="" S FLDS="MR"
 ;
 S DR=$P($T(@(FLDS_"GRP")+1),";;",2,9999) Q:DR=""
 S DIE="^IBA(355.33,",DA=IBBUFDA D ^DIE K DIE,DA,DR
 Q
 ;
POLICY(IBBUFDA,FLDS) ; edit the patient policy portion of the buffer file entry
 ;
 N DIC,DIE,DA,DR,X,Y,IBZZ I $P($G(^IBA(355.33,+$G(IBBUFDA),0)),U,4)'="E" Q
 I $G(FLDS)="" S FLDS="MR"
 ;
 S DR=$P($T(@(FLDS_"POL")+1),";;",2,9999) Q:DR=""
 S DIE="^IBA(355.33,",DA=IBBUFDA
 S DIE("NO^")="BACKOUTOK" D ^DIE K DIE,DA,DR Q:$D(Y)
 ;
 I FLDS="MR" D ESGHP(IBBUFDA)
 Q
 ;
ESGHP(IBBUFDA) ; sponsoring employer information
 N DIR,DIRUT,DUOUT,DTOUT,VAOA,VAERR,VA,DFN,IB60,IBE,IBEMPST,IBREL
 ;
 ; if insured is patient or spouse, ask if insured's current employer is the plan's sponsoring employer, if yes auto stuff it
 I +$G(^IBA(355.33,IBBUFDA,61)) W ! S IB60=$G(^IBA(355.33,IBBUFDA,60)) D  Q:$D(DIRUT)
 . ; sponsoring employer is current employer?
 . S DFN=+IB60,IBREL=$P(IB60,U,6),VAOA("A")=$S(IBREL="01":5,IBREL="02":6,1:"") I 'DFN!(VAOA("A")="") Q
 . D OAD^VADPT I $G(VAOA(9))="" Q
 . S DIR("?")="Enter Yes if this plan is sponsored by the "_$S(IBREL="01":"patient's",1:"spouse's")_" current employer."
 . S DIR("?",1)="Entering Yes will result in the "_$S(IBREL="01":"patient's",1:"spouse's")_" current employer data being",DIR("?",2)="added to the policy as the Sponsoring Employer data.",DIR("?",3)=""
 . S DIR("A")="Current Employer "_VAOA(9)_" Sponsors this Plan",DIR("B")="No",DIR(0)="Y" D ^DIR W ! I Y'=1 Q
 . ;
 . D DELEMP(IBBUFDA) ; delete any data already contained in these fields
 . ;
 . ; if the insured's current employer sponsors the plan then stuff that employer's address into the buffer
 . S IBE=$S(IBREL="01":.311,1:.25),IBEMPST=$P($G(^DPT(DFN,IBE)),U,15)
 . S DR="61.02///"_VAOA(9)_";61.03///"_IBEMPST_";61.06///"_$E(VAOA(1),1,30)_";61.07///"_$E(VAOA(2),1,30)
 . S DR=DR_";61.08///"_$E(VAOA(3),1,30)_";61.09///"_$E(VAOA(4),1,20)_";61.1////"_$P(VAOA(5),U,1)
 . S DR=DR_";61.11////"_$P(VAOA(11),U,1)_";61.12///"_$E(VAOA(8),1,15)
 . S DIE="^IBA(355.33,",DA=IBBUFDA D ^DIE K DIE,DA,DR
 ;
 ; if employer sponsored plan, edit buffer entry's sponsoring employer info
 I +$G(^IBA(355.33,IBBUFDA,61)) S DR="61.02:61.12",DIE="^IBA(355.33,",DA=IBBUFDA D ^DIE K DIE,DA,DR
 ;
 ; if not employer sponsored plan, delete any existing sponsoring employer data
 I $D(^IBA(355.33,IBBUFDA,61)),'$G(^IBA(355.33,IBBUFDA,61)) D DELEMP(IBBUFDA)
 Q
 ;
DELEMP(IBBUFDA) ; delete sponsoring employer data
 N DIC,DIE,DA,DR,X,Y Q:'$D(^IBA(355.33,+$G(IBBUFDA),61))
 S DR="61.02///@;61.03///@;61.04///@;61.05///@;61.06///@;61.07///@;61.08///@;61.09///@;61.10///@;61.11///@;61.12///@"
 S DIE="^IBA(355.33,",DA=IBBUFDA D ^DIE K DIE,DA,DR
 Q
 ;
INSHELP ;
 W !!,"------------------------ INSURANCE COMPANY INFORMATION -------------------------",!
 Q
GRPHELP ;
 W !!,"---------------------------- GROUP/PLAN INFORMATION ----------------------------"
 W !," The following data defines a specific Group or Plan provided by an Insurance "
 W !," Company.  This may be either a group plan with many potential members or an "
 W !," individual plan with a single member.",!
 Q
POLHELP ;
 W !!,"---------------------- POLICY AND SUBSCRIBER INFORMATION -----------------------"
 W !," The following data defines the subscriber specific policy information for a "
 W !," particular Insurance Plan.  The subscriber, the insured, and the policy holder "
 W !," all refer to the person who is a member of the plan and therefore holds the "
 W !," policy.  The patient must be covered under the plan but may not be the policy"
 W !," holder.",!
 Q
 ;
INSNAME(IBBUFDA) ;  Reset insurance company name
 N DR,DIE,DA,Y,X,IBX,IBNEW,IBNAME
 S IBX=-1
 S DR=20.01,DIE="^IBA(355.33,",DA=IBBUFDA
 D ^DIE
 I '$D(Y) S IBNEW=$$CHECK(IBBUFDA)
 I +$G(IBNEW)'<0,$G(IBNEW)'=0,$D(IBNEW) S DR=$P(DR,";",1)_"////"_IBNEW S DIE="^IBA(355.33,",DA=IBBUFDA D ^DIE K DIE,DA,DR I '$D(Y) S IBX=0
 ; BHS - 10/15/03 - If user entered a caret during $$CHECK still set
 ;                  return value to 0 so the user can edit the other
 ;                  INS fields
 I $G(IBNEW)=0!($G(IBNEW)=-1) S IBX=0
 Q IBX
 ;
CHECK(IBBUFDA) ; Select Insurance Company Name and Automatch
 ; Buffer file (#355.33), field# 20.01.
 ; ESG - 6/18/02 - SDD 5.1.4 - Usage of Auto Match when editing the
 ;       insurance company name.  Also, display the insurance company
 ;       name lookup/lister and the Auto Match lookup/lister.
 ;
 NEW IBNEW,IBNAME,AMLIST
 ;
 S IBNEW=0,IBNAME=$P($G(^IBA(355.33,$G(IBBUFDA),20)),U,1)
 I IBNAME="" G CHECKQ
 ;
 ; Perform an insurance company lookup/lister
 ; BHS - 10/15/03 - Removed quits when user enters a caret to quit the
 ;                  the ins lister or Auto Match lister
 S IBNEW=$$DICINS^IBCNBU1(IBNAME,1,10)
 I IBNEW=0!(IBNEW<0) D
 . I '$$AMLOOK^IBCNEUT1(IBNAME,1,.AMLIST) Q
 . S IBNEW=$$AMSEL^IBCNEUT1(.AMLIST)
 ;
 ; user chose a valid insurance company - possible Auto Match add
 I IBNEW'<0,IBNEW'=0 D AMADD^IBCNEUT6(X,IBCNEXT1)
 ;
CHECKQ Q IBNEW
 ;
MRINS ; Insurance Company fields asked of MCCR users in the Buffer Process options (all buffer ins fields 20.01-21.06)
 ;;20.01;20.05;20.02:20.04;21.01;I X="" S Y="@111";21.02;I X="" S Y="@111";21.03;@111;21.04:21.06
 ;
MRGRP ; Group/Plan fields asked of MCCR users in the Buffer Process options (all buffer grp fields 40.01-40.09) ;;Daou/EEN adding BIN and PCN (40.1,40.11)
 ;;40.01:40.03;40.1;40.11;40.09;40.04:40.08
 ;
MRPOL ; Patient Policy fields asked of MCCR users in the Buffer Process options (all buffer policy fields except ESGHP,60.05,60.06 60.02-61.01
 ;;60.02;60.03;60.14PT. RELATIONSHIP TO INSURED;S IBZZ=X;60.04T;I IBZZ'="18" S Y="@111";60.07///1;60.08///@;60.09///@;62.01///@;S Y="@112";@111;60.07;60.08;60.13;62.01T;@112;60.1:60.12;.03;61.01;62.02;62.03;62.04;62.05;62.06
 ;
OTINS ; Insurance Company fields asked of non-MCCR users entering buffer data from options outside IB (20.01-20.04,21.01-21.06)
 ;;20.01:20.04;21.01;I X="" S Y="@111";21.02;I X="" S Y="@111";21.03;@111;21.04:21.06
 ;
OTGRP ; Group/Plan fields asked of non-MCCR users entering buffer data from options outside IB (40.02,40.03,40.09) ;;Daou/EEN-adding BIN & PCN (40.1,40.11)
 ;;40.02;40.03;40.1;40.11;40.09
 ;
OTPOL ; Patient Policy fields asked of non-MCCR users entering buffer data from options outside IB (60.02-60.08)
 ;;60.02;60.03;60.14PT. RELATIONSHIP TO INSURED;S IBZZ=X;60.04T;I IBZZ'="18" S Y="@111";60.07///1;60.08///@;60.09///@;62.01///@;S Y="@112";@111;60.07;60.08;60.13;62.01T;@112;62.02;62.03;62.04;62.05;62.06
