LRDPAREX ;DALOI/FHS -VALIDATE PENDING ORDER FILE PATIENT LOOKUP ; Feb 18, 2004
 ;;5.2;LAB SERVICE;**153,286**;Sep 27, 1994
 ; Special patient lookup of Lab Orders Pending File
 ; From ^LRDPAREF after patient selection
 ; Initialize array.
 ;  CDT=collection date/time
 ;  DFN=ien of patient in selected file
 ;  DOB=patient's date of birth
 ;  DPF=67^LRT(67,
 ;  LRXDPF=source file (2,67)
 ;  ERROR=0
 ;  PNM=patient name
 ;  RIEN=IEN of ^LRT(67
 ;  RPSITE=primary sending site
 ;  RSITE=sending site
 ;  RSITEN=sending site name
 ;  RUID=specimen unique identifier
 ;  SEX=patient's sex
 ;  SSN=patient's SSN
EN ;
 N DA,DIC,DIE,DIR,DIRUT,DR,DTOUT,DUOUT,DLAYGO
 S PNM=LRSD("PNM"),SSN=LRSD("SSN"),DOB=LRSD("DOB"),SEX=LRSD("SEX")
 ;
 S LRXDPF=LRSD("DPF"),LRXDFN=LRSD("DFN"),LRDPF="67^LRT(67,"
 ;
 I +LRXDPF=67,$G(LRXDFN) D  Q
 . S DFN=LRXDFN
 . D UPDATE
 ;
 I LRSD("RIEN"),'$D(^LRT(67,+LRSD("RIEN"),0))#2 S LRSD("ERROR")="16^Missing pointed to LRT(67,"_LRSD("RIEN")_",0)" Q
 ;
 I LRSD("RIEN") D  Q
 . I +LRXDPF=2,LRXDFN'=$G(^LRT(67,LRSD("RIEN"),"DPT")) S LREND=1,LRSD("ERROR")="10^Database Degrade "
 . I '$G(LREND) D UPDATE
 ;
 I 'LRSD("RIEN") S LRSD("RIEN")=$O(^LRT(67,"C",SSN,0)) I LRSD("RIEN"),$O(^(LRSD("RIEN"))) D DUP Q
 ;
 I LRSD("RIEN") D  Q
 . I '$D(^LRT(67,LRSD("RIEN"),0)) D  Q
 . . K ^LRT(67,"C",SSN,LRSD("RIEN"))
 . . S LRSD("ERROR")="13^Missing Zero Node for "_LRSD("RIEN")_" SSN X Ref Entry Removed"
 . D LINK Q:$G(LREND)
 . I +LRXDPF=2 S X="^"_$P(LRXDPF,"^",2)_LRXDFN_",""LRT"")",@X=LRSD("RIEN")
 ;
 I 'LRSD("RIEN") D SET G ERR:LREND
 S DFN=LRSD("RIEN"),LRDPF="67^LRT(67,"
END ;
 Q
 ;
 ;
SET ;Create new entry in ^LRT(67
 I +$G(LRXDPF)'=67,LRXDFN<1 D  Q
 . S LREND=1,LRSD("ERROR")="14^No LRXDFN defined"
 ;
SET1 N DIC,DIE,DA,Y
 L +^LRT(67,0):999
 S DIC(0)="L",DLAYGO=67
 S X=PNM,DIC="^LRT(67,"
 S DIC("DR")=".01////"_PNM_";.02////"_SEX_";.03////"_DOB_";.09////"_SSN
 I $G(LRSD("RACE"))'="" D RACE
 S:+LRXDPF=2 DIC("DR")=DIC("DR")_";2////"_LRXDFN
 K DD,DO
 D FILE^DICN K DLAYGO
 L -^LRT(67,0)
 I Y<1 S LREND=1,LRSB("ERROR")="11^Failure attempting to add patient to LRT(67)",LRDFN=-1 Q
 S LRSD("RIEN")=+Y S:+LRXDPF=2 ^DPT(LRXDFN,"LRT")=LRSD("RIEN")
 S (DFN,LRSD("RIEN"))=+Y S LRSD("ERROR")=""
 Q
 ;
 ;
LINK ; Create back pointer for existing LRT(67 entries
 N DA,DIC,DIE,DR
 S (DFN,DA)=LRSD("RIEN") L +^LRT(67,DA)
 S DIC(0)="LMN",DIE="^LRT(67,"
 S DR=".01////"_PNM_";.02////"_SEX_";.03////"_DOB_";.09////"_SSN
 I $G(LRSD("RACE"))'="" D RACE
 S:+LRXDPF=2 DR=DR_";2////"_LRXDFN
 S DIC=DIE D ^DIE S LREND=+$G(Y) L -^LRT(67,LRSD("RIEN"))
 I LREND S DFN=-1,LRSD("ERROR")="17^ Unable to link "_LRSD("RIEN") Q
 Q
 ;
 ;
UPDATE ; Store updated demographics
 N DA,DR,DIE,DIC,RACE
 S (DFN,DA)=LRSD("RIEN")
 S DIE="^LRT(67,"
 S DR=".01////"_PNM_";.02////"_SEX_";.03////"_DOB_";.09////"_SSN
 I $G(LRSD("RACE"))'="" D RACE
 D ^DIE S LREND=+$G(Y)
 I LREND S DFN=-1,LRSD("ERROR")="18^Unable to update demographics" Q
 Q
 ;
 ;
ERR1 W !?5,"Error1 ",!
 Q
 ;
ERR W !?5,"Error ",!
 Q
 ;
 ;
DUP ;
 S LRSD("ERROR")="15^Duplicate "_SSN_" SSN nunbers in LRT(67 ",LREND=1
 W !?5,$P(LRSD("ERROR"),U,2)
 Q
 ;
 ;
KEYIN ;
 S LRSD("ERROR")="16^Error During Manual Patient Entry"
 W !!?30,"Manual Referral Patient Entry",!!
 K DIR
 S DIR(0)="F^9:12^K:X?1""-""!(X'?1N.N)!(X?1"" "") X I $D(X),$D(^LRT(67,""C"",X)) W !!?15,X,""  Already Exist"" K X"
 S DIR("A")="Patient ID (SSN)",DIR("?")="Enter New Patient ID Nunber "
 S DIR("?",1)="9-12 Number string '-' character or duplicates are Not allowed"
 D RDDIR Q:LREND
 S (LRSD("SSN"),SSN)=Y,Y=0
 K DIR S DIR(0)="67,.01",DIR("A")="Patient Name"
 D RDDIR Q:LREND  S (LRSD("PNM"),PNM)=Y
 ;
 K DIR S DIR(0)="67,.02" D RDDIR Q:LREND  S (LRSD("SEX"),SEX)=Y
 K DIR S DIR(0)="67,.03" D RDDIR Q:LREND  S (LRSD("DOB"),DOB)=Y
 S (LRXDPF,LRSD("LRXDPF"))="67^LRT(67," D SET1
 Q
 ;
 ;
RDDIR ;
 S LREND=0
 D ^DIR
 S:$D(DUOUT)!($D(DTOUT)) LREND=1 K DIR
 S:Y="" LREND=1
 Q
 ;
 ;
RACE ; Resolve race pointer
 N RACE
 S RACE=""
 I $P(LRSD("RACE"),":",3)="" S RACE=$$CODE2PTR^DGUTL4(+LRSD("RACE"),1,1)
 I $P(LRSD("RACE"),":",3)="HL70005" S RACE=$$CODE2PTR^DGUTL4($P($P(LRSD("RACE"),":"),"-",1,2),1,2)
 I RACE>0 D
 . I $D(DR) S DR=DR_";.06////"_RACE Q
 . I $D(DIC("DR")) S DIC("DR")=DIC("DR")_";.06////"_RACE
 Q
