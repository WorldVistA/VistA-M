ECEDF ;BIR/MAM,JPW-Enter Event Capture Data (cont'd) ;6 Mar 96
 ;;2.0; EVENT CAPTURE ;**4,5,10,13,18,23,33,72**;8 May 96
FILE ;file proc
 L +^ECH(0) S ECRN=$P(^ECH(0),"^",3)+1 I $D(^ECH(ECRN)) S $P(^ECH(0),"^",3)=$P(^(0),"^",3)+1 L -^ECH(0) G FILE
 L -^ECH(0) K DA,DD,DO,DIC S DIC(0)="L",DIC="^ECH(",X=ECRN D FILE^DICN K DIC S ECFN=+Y
 ;Ask and file CPT modifiers, ALB/JAM
 S ECCPT=$S(ECP["ICPT":+ECP,1:$P($G(^EC(725,+ECP,0)),U,5)) I ECCPT D
 . S ECMODS=$G(ECMODS)
 . S ECMODF=$$ASKMOD^ECUTL(ECCPT,ECMODS,ECDT,.ECMOD,.ECERR)
 . S:$G(ECERR) ECOUT=1 K ECMODF,ECMODS I ECOUT Q
 . S MOD="" F  S MOD=$O(ECMOD(ECCPT,MOD)) Q:MOD=""  D
 . . S MODIEN=$P(ECMOD(ECCPT,MOD),U,2) I MODIEN<0 Q
 . . K DIC,DD,DO S DIC(0)="L",DA(1)=ECFN,DIC("P")=$P(^DD(721,36,0),U,2)
 . . S X=MODIEN,DIC="^ECH("_DA(1)_","_"""MOD"""_"," D FILE^DICN
 . K MOD,MODIEN,DIC,ECMOD
 I $G(ECOUT) K ECMODS,ECMOD,ECERR D RECDEL,MSG Q
 S DIR("A")="Volume",DIR("B")=ECVOL,DIR(0)="N^^K:(X<1)!(X>99) X"
 S DIR("?")="Type a Number between 1 and 99, 0 Decimal Digits"
 D ^DIR I $D(DIRUT) K DIR D RECDEL,MSG Q
 S ECVOL=+Y,ECNULL="" K DIR
 K DA,DR,DIE S DIE("NO^")="OUTOK",DIE="^ECH(",DA=ECFN
 S DR="1////"_ECDFN_";3////"_ECL_";4////"_ECS_";5////"_ECM_";6////"_ECD_";7////"_+ECC_";9////"_ECVOL_";Q;8////"_ECNULL D ^DIE K DR
 I $D(DTOUT)!($D(Y)'=0) K DIE D RECDEL,MSG Q
 ;
 ;- Default to previous ordering section if >1 procedure entered
 S ECODFN=+$G(ECODFN)
 S ECMN=$S((ECODFN=ECDFN)&(+$G(ECOM)):$P($G(^ECC(723,ECOM,0)),"^"),1:$P($G(^ECC(723,ECM,0)),"^"))
 ;
 ;- Get ordering section, and Procedure Date/Time
 S DR="11//"_ECMN_";2////"_ECDT
 D ^DIE K DR
 I $D(DTOUT)!($D(Y)'=0)!($P(^ECH(ECFN,0),"^",3)="") K DIE D RECDEL,MSG Q
 ;
 ;- Get associated clinic
 I $$CHKDSS^ECUTL0(+$G(ECD),ECPTSTAT) D  I +$G(ECOUT) D RECDEL,MSG Q
 . S DR=$S(EC4N]"":"26//"_EC4N,1:"26")
 . D ^DIE S EC4=X K DR
 . I $D(DTOUT)!($D(Y)'=0) K DIE S ECOUT=1
 ;
 ; Get primary and multiple secondary diagnosis codes, ALB/JAM
 I $P(ECPCE,"~",2)'="N" D  I ECOUT D RECDEL,MSG Q
 . D DIAG^ECUTL2 I ECOUT Q
 . S DA=ECFN,DR=$S(ECDX]"":"20////"_ECDX,1:20) D ^DIE S ECDXY=X K DR
 . S DXS="" F  S DXS=$O(ECDXS(DXS)) Q:DXS=""  D
 . . S DXSIEN=$P(ECDXS(DXS),U) I DXSIEN<0 Q
 . . K DIC,DD,DO S DIC(0)="L",DA(1)=ECFN,DIC("P")=$P(^DD(721,38,0),U,2)
 . . S X=DXSIEN,DIC="^ECH("_DA(1)_","_"""DX"""_"," D FILE^DICN
 . K ECDXX M ECDXX=ECDXS K DXS,DXSIEN,DIC,ECDXS
 . ; Update all procedures for an encounter with same primary & second dx
 . S PXUPD=$$PXUPD^ECUTL2(ECDFN,ECDT,ECL,EC4,ECDXY,.ECDXX,ECFN)
 . K PXUPD,ECDXY,ECDXX
 S DA=ECFN
 ;
 ;- Determine patient eligibility
 I $$CHKDSS^ECUTL0(+$G(ECD),ECPTSTAT) D
 . I $$MULTELG^ECUTL0(+$G(ECDFN)) S ECELIG=+$$ELGLST^ECUTL0
 . E  S ECELIG=+$G(VAEL(1))
 K VAEL
 ;
 ;- File inpatient/outpatient status
 S DR="29////"_ECPTSTAT
 D ^DIE K DR
 ;
 ;- Ask classification questions applicable to patient and file in #721
 I $$ASKCLASS^ECUTL1(+$G(ECDFN),.ECCLFLDS,.ECOUT,ECPCE,ECPTSTAT),($O(ECCLFLDS(""))]"") D EDCLASS^ECUTL1(ECFN,.ECCLFLDS)
 I +$G(ECOUT) K DIE D RECDEL,MSG Q
 K ECCLFLDS
 ;
 ;;get provider(s) with active person class
 D ASKPRV^ECPRVMUT(ECFN,ECDT,.ECPRVARY,.ECOUT)
 I +$G(ECOUT) K DIE D RECDEL,MSG Q
 S ECFIL=$$FILPRV^ECPRVMUT(ECFN,.ECPRVARY,.ECOUT)
 K ECFIL,ECPRVARY,ECPRV,ECPRVN
 I +$G(ECOUT) K DIE D RECDEL,MSG Q
 ;
 ;- File assoc clinic from event code screen if null
 I $P($G(^ECH(ECFN,0)),"^",19)="" D
 . I $G(EC4)="" D GETCLN
 . S EC4=+$G(EC4)
 . I EC4>0 D
 .. S DA=ECFN,DR="26////^S X=EC4"
 .. D ^DIE K DA,DR,DIE
 ;
 K DA,DR,DIE,ECNULL
 ;
 ;- Set vars and default to prev ordering section if >1 proc entered
 S EC4=$P(^ECH(ECFN,0),"^",19),ECINP=$P(^(0),"^",22),ECOM=$P(^(0),"^",12),ECID=$P($G(^SC(+EC4,0)),"^",7),ECODFN=ECDFN
 ;
 I $P(ECPCE,"~",2)="N" G FILE2
 I ($P(ECPCE,"~",2)="O")&(ECINP'="O") G FILE2
 D CLIN I 'ECPCL W !!,"You should edit this patient procedure and enter an active clinic." W:'$D(ECIOFLG) !!,"Press <RET> to continue " R X:DTIME
FILE2 ;continue
 S $P(^ECH(ECFN,0),"^",13)=DUZ,$P(^(0),"^",9)=ECP,$P(^(0),"^",20)=ECID,ECINP=$P(^(0),"^",22),ECDX=+$P($G(^("P")),"^",2)
 S ECCPT=$S(ECP["EC":$P($G(^EC(725,+ECP,0)),"^",5),1:+ECP)
 S $P(^ECH(ECFN,"P"),"^")=ECCPT
 ;
 ;- Procedure Reason(s)
 I $G(ECP)]"" S ECSCR=+$O(^ECJ("AP",+ECL,+ECD,+ECC,ECP,0))
 I ECSCR>0,($P($G(^ECJ(ECSCR,"PRO")),"^",5)=1),(+$O(^ECL("AD",ECSCR,0))) D  Q:+$G(ECOUT)
 . S DIE="^ECH(",DA=ECFN,DR="34" D ^DIE K DA,DR,DIE
 . I $D(DTOUT)!($D(Y)'=0) K ECSCR D RECDEL,MSG Q
 K ECSCR
 ;
PCE ; format PCE data to send
 Q:$P(ECPCE,"~",2)="N"  I $P(ECPCE,"~",2)="O"&(ECINP'="O") Q
 D PCE^ECBEN2U
 Q
MSG ;
 W !!,"All information was not entered.  This procedure has been deleted.",!!,"Press <RET> to continue " R X:DTIME S ECOUT=1
 Q
CLIN ;check for active associated clinic
 S MSG1=1,MSG2=0
 I 'EC4 S MSG2=1
 D CLIN^ECPCEU
 I 'ECPCL D
 .W !!,"The clinic ",$S(MSG1:"associated with",1:"you selected for")," this procedure ",$S(MSG2:"has not been entered",1:"is inactive"),"."
 .W !,"Workload data cannot be sent to PCE for this procedure with ",!,$S(MSG2:"a missing",1:"an inactive")," clinic."
 S (MSG1,MSG2)=0
 Q
 ;
GETCLN ;- Get assoc clinic from event code screen
 N ECI
 I $G(EC4)="",($G(ECP)]"") D
 . S ECI=+$O(^ECJ("AP",+ECL,+ECD,+ECC,ECP,0)),EC4=+$P($G(^ECJ(+ECI,"PRO")),"^",4)
 . S EC4N=$S($P($G(^SC(+EC4,0)),"^")]"":$P(^(0),"^"),1:"")
 Q
 ;
RECDEL ; Delete record
 ;
 N DA,DIK
 S DA=ECFN,DIK="^ECH(" D ^DIK
 Q
