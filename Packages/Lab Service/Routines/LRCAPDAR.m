LRCAPDAR ;DALOI/FHS/RBN - LAB DSS RESULTS EXTRACT (LAR) ;6/29/12  16:42
 ;;5.2;LAB SERVICE;**143,169,258,307,326,386,385,394,399,420**;Sep 27, 1994;Build 5
 ;
 ; Call with Start Date (LRSDT)  End Date (LREDT) FileMan format
 ; Calling routine should have already purged ^LAR(64.036)
EN S:$D(ZTQUEUED) ZTREQ="@"
 I $S($G(LRSDT)'?7N:1,$G(LREDT)'?7N:1,1:0) Q
 L +^LAR(64.036):2 G:'$T END
 N DIR,DIC,DIE,X,I,LR3,LRAA,LRAD,LRAN,LRC,LRSPDT,LRSPTM,UID,Y,DLAYGO,NEXTMO,RERUN ;420
 N LRDFN,LRDN,LRY,LRNLT,LRLOINC,ARRAY,LRP8
 S DLAYGO=64
 I LRSDT>LREDT S X=LRSDT,LRSDT=LREDT,LREDT=X
 S LRX1=9999999-(LRSDT_.0001),LRX2=9999999-(LREDT_.235959)
 S:'$D(^LAR(64.036,0))#2 ^LAR(64.036,0)="LAB DSS LAR EXTRACT^64.036^2"
LR ;
 K ARRAY S ARRAY("ALL")="" D LOINC^ECXUTL6(.ARRAY) ;Build ^TMP($J,"ECXUTL6")
 S NEXTMO=$E($$FMADD^XLFDT(LREDT,1),1,5) ;420 Get next month, year and month
 S RERUN=$D(^XTMP("LRECX",NEXTMO)) ;420 Need to know if we're re-running an extract.
 D MISSED ;420 Look at skipped entries from previous month's extract
 S LRDFN=0 F  S LRDFN=$O(^LR(LRDFN)) Q:LRDFN<1  I $P($G(^LR(LRDFN,0)),U,2)=2 S LRN=^(0) D
 . S DFN=$P(LRN,U,3),LRDPF=$P(LRN,U,2)
 . S LRIDT=LRX2
 . F  S LRIDT=$O(^LR(LRDFN,"CH",LRIDT)) Q:LRIDT<1!(LRIDT>LRX1)  I $D(^(LRIDT,0)) S LRVSPEC=$P(^(0),U,5),LRN0=^(0) D
 . . I '$P(^LR(LRDFN,"CH",LRIDT,0),U,3) D SAVE Q  ;420 If accessioned and no result, put on list for next month.
 . . I RERUN I +$G(^XTMP("LRECX",NEXTMO,LRDFN,LRIDT))=1 Q  ;420 Don't consider this record as it's already been counted in the following month's extract.
 . . I RERUN I $G(ECXTL)'="LAR" K ^XTMP("LRECX",NEXTMO,LRDFN,LRIDT) ;420 If re-running the extract and it's not the untranslatable report then remove entry from next month's list as we now have a result
 . . S LRDN=0 F  S LRDN=$O(^LR(LRDFN,"CH",LRIDT,LRDN)) Q:LRDN<1  D
 . . . S LRY=$$TSTRES^LRRPU(LRDFN,"CH",LRIDT,LRDN,"",1)
 . . . S LRP8=$P(LRY,U,8)
 . . . S LRNLT=$P($P(LRP8,"!",2),";"),LRLOINC=$P($P(LRP8,"!",3),";")
 . . . Q:'(+LRLOINC)
 . . . I +$G(^TMP($J,"ECXUTL6",LRLOINC))>0 D SET
 . . I $O(LRVV(0)) D FILE
WRAP K DA,DR,DIC,DIE,DD,DO
 S (X,DINUM)=1
 S DIC="^LAR(64.036,",DIC(0)="LNM" D FILE^DICN S DA=+Y
 G:Y<1 END
 S DR="9///"_DT,DR(2,64.369)=".01///"_DT_";1///"_LRSDT_";2///"_LREDT_";3///"_$$NOW^LRAFUNC1_";4////"_$G(DUZ)
 S DIE=DIC D ^DIE G END
 Q
SET S LRVV(+$P(^TMP($J,"ECXUTL6",LRLOINC),U,2),LRDN)=$TR($E($P(LRY,U),1,20),";","-")_U_$P(LRY,U,2)_U_LRNLT_U_LRLOINC
 Q
END L -^LAR(64.036)
 K D,D0,D1,DA,DFN,DI,DIC,DIE,DR,I,II,LRDA,LRDPF,LRIDT,LRN,LRN0
 K LRNOW,LRSB,LRSP,LRTS,LRVR,LRVSPEC,LRVV,LRX1,LRX2,X,DLAYGO
 K LRDFN,D2,LRSP,LRTS,DINUM,^TMP($J,"ECXUTL6") Q
FILE K DR,DA,DIC,DIR,LRPROV
 D UID
 S LRN0T1=$P(LRN0,U),LRN0T2=$P(LRN0,U,3),LRPROV=$P(LRN0,U,10)
 S $P(LRN0,U)=$S(LRN0T2<LRN0T1:LRN0T2,1:LRN0T1)
 S X=$P(^LAR(64.036,0),U,3) S:X<2 X=2 F X=X:1 Q:'$D(^LAR(64.036,X))
 S DA=X,DIC="^LAR(64.036,",DINUM=X,DIC(0)="LNMF"
 S LRN0T1=$E($P($P(LRN0,U),".",2),1,4) S:'LRN0T1 LRN0T1=0 I LRN0T1,$E(LRN0T1,3,4)>59 S LRN0T1=$E(LRN0T1,1,2)_"59"
 S LRN0T2=$E($P($P(LRN0,U,3),".",2),1,4) S:'LRN0T2 LRN0T2=0
 S DIC("DR")="1///"_LRDPF_";2///"_DFN_";3///"_$P($P(LRN0,U),".")_";4///"_LRN0T1_";5///"_$P($P(LRN0,U,3),".")_";6///"_LRN0T2_";7///`"_LRVSPEC_";12///`"_LRPROV
 K DD,DO D FILE^DICN K DA S LRDA=Y Q:LRDA<1
 S $P(^LAR(64.036,+LRDA,0),U,9)=LRSPDT,$P(^(0),U,10)=LRSPTM
F2 S DA(1)=+LRDA
 S DIC=DIC_DA(1)_",1,"
 S DIC(0)="L",DIC("P")=$P(^DD(64.036,8,0),"^",2)
 F LRTS=0:0 S LRTS=$O(LRVV(LRTS)) Q:LRTS<1  D
 .S LRDN=0 F  S LRDN=$O(LRVV(LRTS,LRDN)) Q:LRDN<1  D DR1
 K LRVV,LRN0T1,LRN0T2
 Q
DR1 K DR,DIR,DIE S DA=+LRDA
 S DIC("DR")=".01///"_LRTS_";1///"_$P(LRVV(LRTS,LRDN),U)_";2///"_$P(LRVV(LRTS,LRDN),U,2)_";3///"_$P(LRVV(LRTS,LRDN),U,3)_";4///"_$P(LRVV(LRTS,LRDN),U,4)
 S X=LRTS
 K D0 D FILE^DICN
 Q
FIX S X=$P(^LAR(64.036,0),U,1,2) K ^LAR(64.036) S ^LAR(64.036,0)=X Q
UID ;
 S LRN0T2=$P(LRN0,U,3)
 S LRSPDT=$P($P(LRN0,U),"."),LRSPTM=$E($P($P(LRN0,U),".",2),1,4)
 D
 . I 'LRSPTM S LRSPTM=1 Q
 . I LRSPTM,$E(LRSPTM,3,4)>59 S LRSPTM=$E(LRSPTM,1,2)_"59"
 S LRN0T1=LRSPDT_"."_LRSPTM,$P(LRN0,U)=LRN0T1
 S UID=$P($G(^LR(LRDFN,"CH",LRIDT,"ORU")),U) Q:'$L(UID)
 S LRC=$Q(^LRO(68,"C",UID)) Q:$QS(LRC,3)'=UID
 S LRAA=$QS(LRC,4),LRAD=$QS(LRC,5),LRAN=$QS(LRC,6)
 D
 . N LR3,LRODT,LROODT,LRSN
 . Q:'$G(^LRO(68,LRAA,1,LRAD,1,LRAN,0))  S LR3=^(0)
 . S LRODT=$P(LR3,U,4),LRSN=$P(LR3,U,5)
 . S LROODT=$P($G(^LRO(69,LRODT,1,LRSN,0)),U,5)
 . I $G(LROODT) S $P(LRN0,U)=LROODT
 Q
 ;
SAVE ;added in patch 420, save records for next month's review if no result
 ;In this section we're saving any records that don't have a value in
 ;the date report completed field in the CHEM multiple of the LAB DATA
 ;file.  We don't save records if the user is running the lab
 ;untranslatable report.  If we're re-running the extract for the month
 ;then we don't count the record if it's been counted in a subsequent
 ;month's extract. Finally, we set the record into the XTMP global for
 ;later retrieval.  It will be deleted one year from being stored.
 I $G(ECXTL)="LAR" Q  ;Don't add to the list if running untranslatable report.
 I RERUN I +$G(^XTMP("LRECX",NEXTMO,LRDFN,LRIDT)) Q  ;Don't update an entry on the list if we've already counted it.
 I '$D(^XTMP("LRECX",NEXTMO,0)) S ^XTMP("LRECX",NEXTMO,0)=$$FMADD^XLFDT($$DT^XLFDT,365)_"^"_$$DT^XLFDT_"^"_"Accessioned tests without results"
 S ^XTMP("LRECX",NEXTMO,LRDFN,LRIDT)="" ;save specific record
 Q
 ;
MISSED ;added in patch 420, process any records missed in previous month's extract
 ;In this section we will look at the lab tests from the previous month
 ;that didn't have a result when the extract was run.  If they now have
 ;a result, they'll be counted if they match the LOINC criteria.  We 
 ;only check records in the month after they were identified as no lab
 ;test that we report on should take more than 30 days to result.  When
 ;we count a test that we previously skipped, the entry in the XTMP
 ;global is set equal to 1 to denote that we've processed this record
 ;and it shouldn't be counted in future extracts or in reruns of
 ;an extract month.
 N CURMO,LRDFN,LRN,LRDN,LRIDT,LRVSPEC,LRN0,LRY,LRP8,LRNLT,LRLOINC,LRVV
 S CURMO=$E(LRSDT,1,5) ;Year and month we're extracting
 I '$D(^XTMP("LRECX",CURMO,0)) Q  ;No records to review
 S LRDFN=0 F  S LRDFN=$O(^XTMP("LRECX",CURMO,LRDFN)) Q:LRDFN<1  I $P($G(^LR(LRDFN,0)),U,2)=2 S LRN=^(0) D
 . S DFN=$P(LRN,U,3),LRDPF=$P(LRN,U,2)
 . S LRIDT=0
 . F  S LRIDT=$O(^XTMP("LRECX",CURMO,LRDFN,LRIDT)) Q:LRIDT<1  I $D(^LR(LRDFN,"CH",LRIDT,0)),$P(^(0),U,3) S LRVSPEC=$P(^(0),U,5),LRN0=^(0) D
 . . S LRDN=0 F  S LRDN=$O(^LR(LRDFN,"CH",LRIDT,LRDN)) Q:LRDN<1  D
 . . . S LRY=$$TSTRES^LRRPU(LRDFN,"CH",LRIDT,LRDN,"",1)
 . . . S LRP8=$P(LRY,U,8)
 . . . S LRNLT=$P($P(LRP8,"!",2),";"),LRLOINC=$P($P(LRP8,"!",3),";")
 . . . Q:'(+LRLOINC)
 . . . I +$G(^TMP($J,"ECXUTL6",LRLOINC))>0 D SET
 . . I $O(LRVV(0)) D FILE I $G(ECXTL)'="LAR" S ^XTMP("LRECX",CURMO,LRDFN,LRIDT)=1 ;Mark it as counted in this month's extract
 Q
