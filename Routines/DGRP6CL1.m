DGRP6CL1 ;ALB/TMK - REGISTRATION SCREEN 6 FLDS Conflict loc (cont) ; 09/15/2005
 ;;5.3;Registration;**689,764**;Aug 13, 1993;Build 16
 ;
DELCFL(DFN) ; Delete all existing OEF/OIF episodes for a patient
 ; DFN = patient ien
 N DA,DIK,X,Y,DG
 S DG=0 F  S DG=$O(^DPT(DFN,.3215,DG)) Q:'DG  I $G(^(DG,0))'="" S DA(1)=DFN,DA=DG,DIK="^DPT("_DA(1)_",.3215," D ^DIK
 Q
 ;
EDCFL(DFN,IEN,VEDIT) ; Edit OEF/OIF conflict from/to dates only or delete entry
 N DIE,DA,X,Y,DR,DIPA
 I $G(VEDIT)=2 W !!,"WARNING - THIS CONFLICT IS INCONSISTENT WITH MILITARY SERVICE DATA",!
 Q:$P($G(^DPT(DFN,.3215,IEN,0)),U,4)
 S DIPA(.01)=+$G(^DPT(DFN,.3215,IEN,0))
 S DA(1)=DFN,DA=IEN,DIE="^DPT("_DA(1)_",.3215,",DR=".05///NOW;@10;.01;I X'=DIPA(.01) S Y=""@50"";.02R;.03R;S Y=""@99"";@50;D NOCHG^DGRP6CL1;.01////"_$G(DIPA(.01))_";S Y=""@10"";@99"
 D ^DIE
 Q
 ;
ADDCFL(DFN,DGY,DGCONF,SRC) ; Add a new OEF/OIF conflict entry
 ; DFN = patient ien
 ; DGY = 1 for OIF, 2 for OEF, 3 for UNKNOWN OEF/OIF
 ; DGCONF = the conflict record being added (OEF/OIF/ UNKNOWN OEF/OIF)
 ; SRC = 1 if HEC data (locked) or 0 if site entered
 ;   If SRC is passed by reference, it must contain the values needed
 ;   to 'stuff' a new record into the file at the fld # subscript level
 ;   SRC(.02)=from dt  SRC(.03)=to dt  SRC(.04)=1 if HEC source of data
 ;   SRC("OK") is returned as 1 if filing was successful or as the
 ;       reason why the data was not filed if unsuccessful
 ;
 N DGFORCE,DIC,DA,DO,DD,X,Y,DIR,DIK,Z0
 S DGFORCE=$S($O(SRC("")):1,1:0)
 I DGFORCE,('$G(SRC(.01))!'$G(SRC(.02))!'$G(SRC(.03))) S SRC("OK")="MISSING DATA" Q
 S X=DGY,DIC("DR")=".05///NOW;.04////"_+$G(SRC)
 Q:'X
 I 'DGFORCE D
 . W !!,"Adding NEW "_DGCONF_" conflict data ...",!
 . S DIC("DR")=DIC("DR")_";.06////"_$S($G(DUZ(2)):DUZ(2),1:+$$SITE^VASITE())_";.02R;.03R"
 ;
 I DGFORCE D
 . S DIC("DR")=DIC("DR")_";.02///"_SRC(.02)_";.03///"_SRC(.03)
 ;
 S DIC(0)="L",DA(1)=DFN,DIC="^DPT("_DA(1)_",.3215," K DO,DD D FILE^DICN
 S Z0=$G(^DPT(DFN,.3215,+Y,0))
 I Z0'="",'$P(Z0,U,2)!'$P(Z0,U,3) D  Q
 . S DA=+Y,DA(1)=DFN,DIK="^DPT("_DA(1)_",.3215," D ^DIK
 . I DGFORCE S SRC("OK")="DATA NOT FILED - BAD DATA"
 . I 'DGFORCE S DIR("A",1)="BAD DATA ENCOUNTERED.  NO NEW CONFLICT DATA FILED.",DIR("A")="PRESS RETURN TO CONTINUE: ",DIR(0)="EA" D ^DIR K DIR
 I DGFORCE,'$D(SRC("OK")) S SRC("OK")=1
 Q
 ;
CKDT(DGCONF,DGMSE,DGPOSS) ; Check dates for conflict in DGCONF(DGCONF)=
 ; fr date^to date are valid against military service episodes (DGMSE)
 ; for the patient and if no dates, if the MSE's would support that
 ; conflict being entered.
 ; Assume DFN exists
 ; FUNCTION returns
 ;     DGCONF(DGCONF,1)=1 if MSE inconsistency found,0 if none
 ;     Also returns DGPOSS(DGCONF) if patient has no dates for the
 ;       conflict, but the MSE's indicate entry of the conflict would
 ;       not be inconsistent.
 ;
 N Z,CRNG,DGOK,FAIL
 S CRNG=$$GETCNFDT^DGRPDT(DGCONF)
 I $TR($G(DGCONF(DGCONF)),U)="" D  Q  ; Conflict pd not prev entered
 . S:$S(DGCONF="OEF"!(DGCONF="OIF")!(DGCONF="UNK"):0,1:1) DGCONF(DGCONF)=""
 . ; Check if conflict period COULD be valid based on MSE
 . S Z=0 F  S Z=$O(DGMSE(Z)) Q:'Z  D  Q:$D(DGPOSS(DGCONF))
 .. I $S($P(DGMSE(Z),U)>$P(CRNG,U,2):1,$P(DGMSE(Z),U,2)<$P(CRNG,U):1,1:0) Q  ; Not within valid for the mil svc pd for pt
 .. S DGPOSS(DGCONF)=""
 . ;
 S DGOK=1
 I $O(DGMSE(""))="" S DGOK=0,FAIL=1
 I DGOK F Z=0,1 I '$$VALCON^DGRPMS(DFN,DGCONF,$S($P(DGCONF(DGCONF),U,Z+1):$P(DGCONF(DGCONF),U,Z+1),1:DT),Z,.FAIL) S DGOK=0 Q
 S DGCONF(DGCONF,1)=$S(DGOK:"",$G(FAIL):1,1:0) ; MSE Inconsistency flag
 ;
 Q
 ;
NOCHG ;Only from,to dates can be chged on locally entered OEF/OIF conflict data
 N DIR,X,Y
 S DIR("A",1)="You may not change this field - but you may delete it",DIR("A")="Press RETURN to continue ",DIR(0)="EA" W ! D ^DIR K DIR W !
 Q
 ;
HELP(SET) ;Help text for reader prompt for conflict to add/edit/delete
 N Z,Z0
 W !!,"Those conflicts with a number enclosed in brackets ""[]"" are valid",!,"for the veteran while those enclosed in arrows ""<>"" are not.",!
 W !,$J("",5),"Select one of the following:",!
 F Z=1:1:$L(SET,";") S Z0=$P(SET,";",Z) I Z0'="" W !,$J("",15),$E($P(Z0,":")_$J("",10),1,10)_$P(Z0,":",2)
 W !
 N DIR,X,Y
 S DIR(0)="EA",DIR("A")="PRESS RETURN TO CONTINUE: " D ^DIR
 Q
 ;
LOOPCNF(DGCONF,DGPOSS,DIR) ; Loop thru non-OEF/OIF conflicts
 ; DGCONF,DGPOSS = arrays from DGRP6CL containing conflict data
 ; Returns DIR array for screen display of conflicts
 N LOOP,DGX,DGX1
 S DGX="VIET;4;Vietnam^LEB;5;Lebanon^GREN;6;Grenada^PAN;7;Panama^GULF;8;Gulf War^SOM;9;Somalia^YUG;10;Yugoslavia"
 F LOOP=1:1 Q:$P(DGX,U,LOOP)=""  S DGX1=$P(DGX,U,LOOP) D
 . S DGCONF=$P(DGX1,";"),DG=$$ISVALID^DGRP6CL2(.DGCONF,.DGPOSS) I $G(DGCONF(DGCONF,"VEDIT")) S DIR(0)=DIR(0)_$P(DGX1,";",2)_":"_$P(DGX1,";",3)_";"
 . S DGCT=DGCT+1,DIR("A",DGCT)=$S($G(DGCONF(DGCONF,1)):"***",1:"   ")_$E(DG,1)_$P(DGX1,";",2)_$E(DG,2)_$S($L($P(DGX1,";",2))<2:" ",1:"")_" -"_$J("",11-$L($P(DGX1,";",3)))_$P(DGX1,";",3)_": "
 . I $P(DGX1,";",2)=4 S DIR("A",DGCT)=DIR("A",DGCT)_$$YN^DGRP6CL(DG321,1)_$J("",6)_$E($$DAT^DGRP6CL(DG321,4,13)_$J("",12),1,12)_$E($$DAT^DGRP6CL(DG321,5,11)_$J("",12),1,12)
 . I $P(DGX1,";",2)=5 S DIR("A",DGCT)=DIR("A",DGCT)_$$YN^DGRP6CL(DG322,1)_$J("",6)_$E($$DAT^DGRP6CL(DG322,2,13)_$J("",12),1,12)_$E($$DAT^DGRP6CL(DG322,3,11)_$J("",12),1,12)
 . I $P(DGX1,";",2)=6 S DIR("A",DGCT)=DIR("A",DGCT)_$$YN^DGRP6CL(DG322,4)_$J("",6)_$E($$DAT^DGRP6CL(DG322,5,13)_$J("",12),1,12)_$E($$DAT^DGRP6CL(DG322,6,11)_$J("",12),1,12)
 . I $P(DGX1,";",2)=7 S DIR("A",DGCT)=DIR("A",DGCT)_$$YN^DGRP6CL(DG322,7)_$J("",6)_$E($$DAT^DGRP6CL(DG322,8,13)_$J("",12),1,12)_$E($$DAT^DGRP6CL(DG322,9,11)_$J("",12),1,12)
 . I $P(DGX1,";",2)=8 S DIR("A",DGCT)=DIR("A",DGCT)_$$YN^DGRP6CL(DG322,10)_$J("",6)_$E($$DAT^DGRP6CL(DG322,11,13)_$J("",12),1,12)_$E($$DAT^DGRP6CL(DG322,12,11)_$J("",12),1,12)
 . I $P(DGX1,";",2)=9 S DIR("A",DGCT)=DIR("A",DGCT)_$$YN^DGRP6CL(DG322,16)_$J("",6)_$E($$DAT^DGRP6CL(DG322,17,13)_$J("",12),1,12)_$E($$DAT^DGRP6CL(DG322,18,11)_$J("",12),1,12)
 . I $P(DGX1,";",2)=10 S DIR("A",DGCT)=DIR("A",DGCT)_$$YN^DGRP6CL(DG322,19)_$J("",6)_$E($$DAT^DGRP6CL(DG322,20,13)_$J("",12),1,12)_$E($$DAT^DGRP6CL(DG322,21,11)_$J("",12),1,12)
 ;
 Q
 ;
