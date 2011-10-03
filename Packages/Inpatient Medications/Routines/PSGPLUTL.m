PSGPLUTL ;BIR/RLW-PICK LIST UTILITIES ;06 AUG 96 / 10:54 AM
 ;;5.0; INPATIENT MEDICATIONS ;**109**;16 DEC 97
 ;
PAT ; find next patient or jump to a new patient
 I $E(OK,1,1)="^"&($P(OK,"^",2)?1.A) D JUMP Q 
 S PN=$O(^PS(53.5,"AC",PSGPLG,TM,WDN,RB,PN))
 Q
 ;
JUMP ; try to find patient user wants to jump to and construct "AC" xref
 S DIC="^PS(53.5,"_PSGPLG_",1,",DIC(0)="EQZ",X=PSGP D ^DIC K DIC
 Q
 ;
LOCK(PSGPLG,APPL) ; Pick List routines use an ^XTMP node instead of locking, to allow some jobs to run concurrently on the same Pick List (PRINT and SEND TO ATC).
 ; PSGPLG=pick list number, APPL=option attempting to "lock", SETAPPL=option already in progress, APPLOK=if '1', option attempting to "lock" can proceed.
 N SETAPPL,APPLOK,SUB,PLG
 D NOW^%DTC S X1=X,X2=1 D C^%DTC S ^XTMP("PSGPL",0)=X,APPLOK=0
 ; clean up XTMP nodes left by aborted jobs (for all pick lists)
 S PLG=0 F  S PLG=$O(^XTMP("PSGPL",PLG)) Q:PLG=""  D
 .S SETAPPL=0 F  S SETAPPL=$O(^XTMP("PSGPL",PLG,SETAPPL)) Q:SETAPPL=""  D
 ..S SUB=0 F  S SUB=$O(^XTMP("PSGPL",PLG,SETAPPL,SUB)) Q:SUB=""  L +^XTMP("PSGPL",PLG,SETAPPL,SUB):1 I  K ^XTMP("PSGPL",PLG,SETAPPL,SUB) L -^XTMP("PSGPL",PLG,SETAPPL,SUB)
 I '$D(^XTMP("PSGPL",PSGPLG)) S ^XTMP("PSGPL",PSGPLG,APPL,$J)="" L +^XTMP("PSGPL",PSGPLG,APPL,$J):1 Q 1
 S SETAPPL=0 F  S SETAPPL=$O(^XTMP("PSGPL",PSGPLG,SETAPPL)) Q:SETAPPL=""  D
 .I (APPL="PSGPLR")&((SETAPPL="PSGTAP")!(SETAPPL="PSGPLR")) S ^XTMP("PSGPL",PSGPLG,APPL,$J)="" L +^XTMP("PSGPL",PSGPLG,APPL,$J):1 S:$T APPLOK=1 Q
 .I (APPL="PSGTAP")&(SETAPPL="PSGPLR") S ^XTMP("PSGPL",PSGPLG,APPL,$J)="" L +^XTMP("PSGPL",PSGPLG,APPL,$J):1 S:$T APPLOK=1 Q
 Q APPLOK
 ;
UNLOCK(PSGPLG,APPL)          ;.
 L -^XTMP("PSGPL",PSGPLG,APPL,$J) K ^XTMP("PSGPL",PSGPLG,APPL,$J)
 K:'$O(^XTMP("PSGPL",0)) ^XTMP("PSGPL")
 Q
