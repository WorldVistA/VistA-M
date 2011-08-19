IBCEP5B ;ALB/TMP - EDI UTILITIES for prov ID ;29-SEP-00
 ;;2.0;INTEGRATED BILLING;**137,239,232,320,348,349**;21-MAR-94;Build 46
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
NEWID(IBFILE,IBINS,IBPRV,IBPTYP,IBIEN,IBF) ; Generic add prov id
 ; at both prov (file 355.9) and ins co levels (355.91)
 ; IBFILE = 355.9 or 355.91 - the file being edited
 ; IBINS = ien of ins co (36) or *ALL* for all ins co
 ; IBPRV = vp ien of billing prov
 ; IBPTYP = ien of prov type (file 355.97)
 ; IBIEN = ien of entry being added (req'd)
 ; IBF = 1 if deleting from ins-related options, "" from prov-related
 N DIC,DIR,X,Y,Z,DA,DR,DIE,DO,DD,DLAYGO,DTOUT,DUOUT,IBQ,IBCUND,IB3559,IB35591,Q,IBDR,IBID,AFT
 S IB35591(.03)="",IBPTYP=$G(IBPTYP)
 F Z=.04,.05,.03 D  G:Z="" NEWQ
 . I $S(Z'=.03:1,1:$S('$G(IBINS):0,1:$G(IBCUND))) D  Q:Z=""
 .. N DA
 .. I Z'=.03 S DIR(0)=IBFILE_","_Z
 .. I Z=.03 D
 ... S DIR(0)="PAO^355.95:AEMQ"
 ... S DIR("S")="I $O(^IBA(355.96,""AUNIQ"","_IBINS_",Y,"_$G(IB3559(.04))_","_$G(IB3559(.05))_","_IBPTYP_",0))!($O(^IBA(355.96,""AUNIQ"","_IBINS_",Y,"_$G(IB3559(.04))_",0,"_IBPTYP_",0)))"
 ... S DIR("S")=DIR("S")_"!($O(^IBA(355.96,""AUNIQ"","_IBINS_",Y,0,"_$G(IB3559(.05))_","_IBPTYP_",0)))!($O(^IBA(355.96,""AUNIQ"","_IBINS_",Y,0,0,"_IBPTYP_",0)))"
 ... S DIR("?",1)="Care unit describes areas of service and is assigned by the payer, if",DIR("?")="  applicable.  Use Care Unit Maintenance to add or modify care units."
 .. ;
 .. I Z=.04,IBPRV["355.93",$$GET1^DIQ(355.93,+IBPRV,.02,"I")=1 D
 ... I $$GET1^DIQ(355.97,IBPTYP,.03,"I")="EI" S $P(DIR(0),U,3)="K:Y'=1 X",DIR("?")="Provider ID Qualifier selected only allows institutional (UB type) forms" Q
 ... I $$GET1^DIQ(355.97,IBPTYP,.03,"I")="TJ" S $P(DIR(0),U,3)="K:Y'=2 X",DIR("?")="Provider ID Qualifier selected only allows professional (CMS-1500) forms" Q
 ... N AFT
 ... S AFT=$$GET1^DIQ(355.97,IBPTYP,.07,"I")  ; get allowable form type for this Provider ID Type
 ... I AFT="B" S $P(DIR(0),U,3)="K:"".0.1.2.""'[("".""_Y_""."") X",DIR("?")="Provider ID Qualifier selected allows institutional, professional or both" Q
 ... I AFT="P" S $P(DIR(0),U,3)="K:Y'=2 X",DIR("?")="Provider ID Qualifier selected only allows professional (CMS-1500) forms" Q
 ... I AFT="I" S $P(DIR(0),U,3)="K:Y'=1 X",DIR("?")="Provider ID Qualifier selected only allows institutional (UB type) forms" Q
 .. ;
 .. S DA=0
 .. I Z=.04,$P($G(^IBE(355.97,+IBPTYP,0)),U,3)="1A" D SETDIR(.DIR)
 .. D ^DIR K DIR
 .. I $D(DTOUT)!$D(DUOUT) S Z="" K IB3559,IB35591 Q
 .. S IB3559(Z)=$S(Z'=.03:$P(Y,U),1:$S($P(Y,U)>0:$P(Y,U),1:"*N/A*"))
 . I Z=.05 D
 .. S IBCUND=$$CAREUN^IBCEP3(IBINS,IBPTYP,IB3559(.04),IB3559(.05),IB3559(.05)=3)
 .. S:'IBCUND!($G(IB3559(.03))=0) IB3559(.03)="*N/A*"
 .. I '$G(IBINS) S IBINS="*ALL*"
 . I Z=.03 D CAREUN^IBCEP5C
 ;
 I $D(IB3559) D
 . N Q,Z2,Z3,Z4,Z5,Z6,IBLAST,IBOK,DIR,Y,X
 . S IBLAST=0
 . D DISP^IBCEP4("Q",IBINS,IBPTYP,IB3559(.04),IB3559(.05),1)
 . W !!,"THE FOLLOWING WAS CHOSEN:"
 . S Q=0 F  S Q=$O(Q(Q)) Q:'Q  W !,?3,Q(Q)
 . I IBCUND W !,?3,"CARE UNIT: "_$$EXPAND^IBTRE(355.96,.01,IB3559(.03))
 . S Z2=IBINS,Z3=IB35591(.03),Z4=IB3559(.04),Z5=IB3559(.05),Z6=IBPTYP
 . S IBOK=1
 . ; If both forms, chk for specific
 . I 'Z4 S IBOK=$$COMBOK^IBCEP5C(IBFILE,IBPRV_U_4_U_Z2_U_Z3_U_Z4_U_Z5_U_Z6,1,$G(IBFILE)=355.91)
 . ; If specific form, chk for all
 . I IBOK,Z4 S IBOK=$$COMBOK^IBCEP5C(IBFILE,IBPRV_U_4_U_Z2_U_Z3_U_Z4_U_Z5_U_Z6,0,$G(IBFILE)=355.91)
 . ; If both care types, chk for specific
 . I IBOK,'Z5 S IBOK=$$COMBOK^IBCEP5C(IBFILE,IBPRV_U_5_U_Z2_U_Z3_U_Z4_U_Z5_U_Z6,1,$G(IBFILE)=355.91)
 . ; If specific care type, chk for all
 . I IBOK,Z5 S IBOK=$$COMBOK^IBCEP5C(IBFILE,IBPRV_U_5_U_Z2_U_Z3_U_Z4_U_Z5_U_Z6,0,$G(IBFILE)=355.91)
 . I 'IBOK K IB3559,IB35591
 . I IBOK D
 .. S DIR(0)=IBFILE_",.07"
 .. W ! D ^DIR K DIR
 .. S IBID=Y
 .. I $D(DTOUT)!$D(DUOUT) K IB3559,IB35591 S IBOK=0 Q
 .. S IBDR=$S(IBFILE=355.9:$S($G(IBINS):".02////"_IBINS_";",1:""),1:"")_$S($G(IBCUND):".03////"_$S(IB35591(.03):IB35591(.03),1:"*N/A*")_";",1:"")_".04////"_IB3559(.04)_";.05////"_IB3559(.05)_";.06////"_IBPTYP_$S(IBID'="":";.07////"_IBID,1:"")
 .. ;
 .. I $G(IBIEN) D
 ... S DR=IBDR,DA=IBIEN,DIE="^IBA("_IBFILE_","
 ... D ^DIE
 ... I $D(Y) K IB3559,IB35591 S IBOK=0
 ;
NEWQ ;
 I '$D(IB3559),$G(IBIEN) D  Q
 . N DIR,DIK,DA,X,Y
 . S DA=IBIEN,DIK="^IBA("_IBFILE_"," D ^DIK
 . S DIR(0)="EA",DIR("A",1)=$S('$G(IBOK):"",1:"PROBLEM ENCOUNTERED FILING THE RECORD - ")_"RECORD NOT ADDED",DIR("A")="PRESS ENTER to continue " W ! D ^DIR K DIR
 ;
 ; Save this for Copy ID actions
 I $G(IBIEN) D
 . I IBFILE=355.91!(IBFILE=355.9&($P($G(^IBA(IBFILE,IBIEN,0)),U)["VA(200,")) D
 .. N NEXTONE S NEXTONE=$$NEXTONE^IBCEP5A()
 .. S ^TMP("IB_EDITED_IDS",$J,NEXTONE)=IBIEN_U_"ADD"_U_IBFILE
 .. S ^TMP("IB_EDITED_IDS",$J,NEXTONE,0)=$G(^IBA(IBFILE,IBIEN,0))
 Q
 ;
CHG(IBFILE,IBDA) ; Generic call - edit prov id
 ; IBFILE = 355.9 or 355.91 (file being edited)
 ; IBDA = ien in file
 ;
 N DIR,DIE,DA,DR,IBCUCHK,IBOK,IB0,IBOLD,X,Y,Z
 F Z=1:1:3 L +^IBA(IBFILE,IBDA):5 Q:$T  W !,"Attempting to lock record"
 I '$T D  G CHGQ
 . W !,"RECORD LOCKED BY ANOTHER USER - TRY AGAIN LATER"
 . D ENTER(.DIR)
 . W ! D ^DIR K DIR W !
 S (IB0,IBOLD)=$G(^IBA(IBFILE,IBDA,0))
 G:IB0="" CHGQ
 F Z=.04,.05,.06,.03 S IBOK=$$EDIT(IBFILE,Z,IB0,IBOLD,IBDA,0) S:IBOK="*ALL*" IBOK="" Q:$P(IBOK,U,2)  S $P(IB0,U,Z*100)=$P(IBOK,U)
 I $P(IBOK,U,2) S DIR(0)="EA",DIR("A")="NO CHANGES MADE, PRESS ENTER TO CONTINUE: " W ! D ^DIR K DIR W ! G CHGQ
 S IBOK=$$EDIT(IBFILE,.07,IB0,IBOLD,IBDA,1)
 I '$P(IBOK,U,2) S $P(IB0,U,7)=$P(IBOK,U)
 I $P(IBOK,U,2)!(IB0=IBOLD) S DIR(0)="EA",DIR("A")="NO CHANGES MADE, PRESS ENTER TO CONTINUE: " W ! D ^DIR K DIR W ! G CHGQ
 S IBCUCHK=$$CUCHK^IBCEP5C(IBDA,IB0) G:IBCUCHK CHGQ
 S DR=""
 F Z=2,4:1:7,3 I $P(IB0,U,Z)'=$P(IBOLD,U,Z) S DR=DR_$S(DR'="":";",1:"")_(Z/100)_"///"_$S($P(IB0,U,Z)'="@":"/",1:"")_$P(IB0,U,Z)
 I DR'="" D
 . I IBFILE=355.91!(IBFILE=355.9&($P(IB0,U)["VA(200,")) D
 .. N NEXTONE
 .. S NEXTONE=$$NEXTONE^IBCEP5A()
 .. S ^TMP("IB_EDITED_IDS",$J,NEXTONE)=IBDA_U_"MOD"_U_IBFILE_U_IBDA
 .. S ^TMP("IB_EDITED_IDS",$J,NEXTONE,"OLD0")=IBOLD
 .. S ^TMP("IB_EDITED_IDS",$J,NEXTONE,0)=IB0
 . S DIE="^IBA("_IBFILE_",",DA=IBDA D ^DIE
CHGQ L -^IBA(IBFILE,IBDA)
 Q
 ;
DEL(IBFILE,IBDA,IBF) ; Delete prov specific ID's
 ; IBFILE = 355.9 or 355.91 for the file
 ; IBDA = ien of entry in file IBFILE
 ; IBF = 1 if deleting from ins co-related options, ""
 ;       from prov-related options
 D DEL^IBCEP5C(IBFILE,IBDA,$G(IBF))
 Q
 ;
EDIT(IBFILE,IBFLD,IB0,IBOLD,IBIEN,IBCK1) ; Generic edit flds
 Q $$EDIT^IBCEP5D($G(IBFILE),$G(IBFLD),$G(IB0),$G(IBOLD),$G(IBIEN),$G(IBCK1))
 ;
SETDIR(DIR) ; Sets dir for BLUE CROSS only UB-04 form type
 S DIR("B")="UB-04",$P(DIR(0),U,3)="K:Y'=1 X",DIR("?")="ONLY UB-04 FORM TYPE IS VALID FOR BLUE CROSS ID"
 Q
 ;
ENTER(DIR) ;
 S DIR(0)="EA",DIR("A")="PRESS ENTER TO CONTINUE: "
 Q
