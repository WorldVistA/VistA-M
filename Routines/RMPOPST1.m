RMPOPST1 ;EDS/JAM,RVD - HOME OXYGEN BILLING TRANSACTIONS/POSTING,Part 2 ;7/24/98
 ;;3.0;PROSTHETICS;**29,44,55,154**;Feb 09, 1996;Build 6
 ; RVD #55  - corrected the typo (missing '^' on TMP global).
 ;
 ;Processing of 1358 and Purchase Cards to IFCAP
 Q
IFCAP ;process payment type - Purchase Card or 1358
 D @$S($P(PAYINF,U)="P":"PRHCARD",1:"1358")
 I $P(^TMP($J,FCP),U,2) D 
 . W !!,FCP,"   ...Posted" D FCPUPD ;update global ^RMPO(665.72
 K A
 Q  ;IFCAP
 ;
PRHCARD ;Processing IFCAP Purchase Card
 N DFN,PRCA,PRCB,PRCC,INDVITM,ITMSTR,RMPOA,X,CNT,CURDT,CNTR,TOTD
 S PRCA=PCTOT+FCPTOT,PRCB=IEN442,PRCC="RMPOA"
 ;Store individual patient in array RMPOA for posting
 S DFN="",TOTD=0,CNTR=0  F CNT=1:1 S DFN=$O(^TMP($J,FCP,DFN)) Q:DFN=""  D
 . S ITMSTR=^TMP($J,FCP,DFN),TOTD=TOTD+$P(ITMSTR,U),CNTR=CNTR+1
 I CNTR>0 S RMPOA(1)=$J(TOTD,10,2)_"  TOTAL PATIENTS= "_CNTR
 D EDITIC^PRCH7D(PRCA,PRCB,PRCC)
 I X="^" D  Q  ;PRHCARD
 . S $P(^TMP($J,FCP),U,2)=0,$P(^TMP($J,FCP),U,3)="Posting of PC aborted"
 . ;W "  ",$P(^TMP($J,FCP),U,3)
 S $P(^TMP($J,FCP),U,2)=1,$P(^TMP($J,FCP),U,4)=PRCA
 D NOW^%DTC S CURDT=%
 ;Update file 660 and ^RMPO(665.72 
 S DFN="" F  S DFN=$O(^TMP($J,FCP,DFN)) Q:DFN=""  D
 . S $P(^TMP($J,FCP,DFN),U,3)=1
 . D GBLUPD
 Q  ;PRHCARD
 ;
1358 ;processing IFCAP 1358
 N DFN,IEN424,BAL,CURDT,Y,PATOT,PATINF,PSTFLG,PRCSX,PATINFW
 ;Check balance on 1358
 S BAL=$$BAL(IEN442) I BAL<FCPTOT D  Q
 . S $P(^TMP($J,FCP),U,2)=0,$P(^TMP($J,FCP),U,3)="Insufficient balance"
 . ;W "  ",$P(^TMP($J,FCP),U,3)
 S PSTFLG=0,DFN=""
 F I=1:1 S DFN=$O(^TMP($J,FCP,DFN)) Q:DFN=""  D
 . S PATOT=+^TMP($J,FCP,DFN),PATINF="PAT ID "_DFN,PATINFW=$P(^TMP($J,FCP,DFN),U,2)
 . ;authorize amount to be posted
 . D NOW^%DTC S CURDT=%
 . S X=SRVORD_"^"_CURDT_"^"_PATOT_"^^"_PATINF,Y=$$AUTH(X)
 . I '+Y D  Q
 . . S $P(^TMP($J,FCP,DFN),U,3)=0,$P(^TMP($J,FCP,DFN),U,4)=$P(Y,U)_$P(Y,U,2)
 . . W !!,"Authorization failed for: ",PATINFW,!
 . . W "IFCAP reason: ",$S($P(Y,U,2)'="":$P(Y,U,2),1:$P(Y,U))
 . S IEN424=$P(Y,U,2)
 . ;post patient total to authorized IEN 424 and closeout posting
 . S PRCSX=IEN424_U_CURDT_U_PATOT_U_"HOME OXYGEN COMPLETED"
 . S Y=$$COMPST(PRCSX)
 . I '+Y D  Q
 . . S $P(^TMP($J,FCP,DFN),U,3)=0,$P(^TMP($J,FCP,DFN),U,4)=$P(Y,U,2)
 . . W !!,"Post Completion failed for: "_PATINFW,!
 . . W "IFCAP reason: "_$P(Y,U,2)
 . . W "Patient IEN(424): ",IEN424
 . S $P(^TMP($J,FCP,DFN),U,3)=1,PSTFLG=1
 . ;update file 660 for form 2319 and file ^RMPO(665.72
 . D GBLUPD
 S $P(^TMP($J,FCP),U,2)=PSTFLG
 Q  ;1358
 ;
BAL(A) ;check balance on 1358 Service Order before posting
 N TOT442
 S TOT442=$$BAL^PRCH58(A)
 Q +TOT442-$P(TOT442,U,3)  ;BAL
 ;
AUTH(X) ;create one authorization per patient to be posted
 ;return IEN of 424 if successful in Y
 N PRCS
 S PRCS("TYPE")="COUNTER"
 D EN2^PRCS58
 Q Y   ;AUTH
 ;
COMPST(PRCSX) ;Post patient transactions as complete to IEN of file 424
 D ^PRCS58CC
 Q Y  ;COMPST
 ;
GBLUPD ;Update file ^RMPO(665.72 and 660
 ;update file 660 for form 2319
 D F660^RMPOPST3
 ;update ^RMPO(665.72 with post flag
 D ITMUPD
 Q
 ;
ITMUPD ;Update global ^RMPO(665.72 with post flag for individual item
 N ITM,DASTR
 ;check if FCP was posted for patient
 I '$P(^TMP($J,FCP,DFN),U,3) Q
 K DIE,DA,DR
 S DA(2)=VDR,DA(3)=RVDT,DA(4)=SITE
 S DASTR=DA(4)_",1,"_DA(3)_",1,"_DA(2)_",""V"","
 S ITM="" F  S ITM=$O(^TMP($J,FCP,DFN,ITM)) Q:ITM=""  D
 . S DA(1)=DFN,DIE="^RMPO(665.72,"_DASTR_DA(1)_",1,",DR="8///Y",DA=ITM
 . D ^DIE
 D PATUPD
 Q  ;ITMUPD
 ;
PATUPD ;Update global ^RMPO(665.72 with post flag for patient
 N FLG,IT,X,PFLG,ISTR,DASTR
 K DIE,DA,DR
 S DA(1)=DFN,DA(2)=VDR,DA(3)=RVDT,DA(4)=SITE
 S IT=0,X=0,FLG="Y"
 F  S IT=$O(^RMPO(FIL,SITE,1,RVDT,1,VDR,"V",DFN,1,IT)) Q:'IT  D  I X Q
 . S PFLG=$P(^RMPO(FIL,SITE,1,RVDT,1,VDR,"V",DFN,1,IT,0),U,10)
 . S RP660=$P(^RMPO(FIL,SITE,1,RVDT,1,VDR,"V",DFN,1,IT,0),U,16)
 . I '$G(RP660) S FLG=""
 . I PFLG=""!(PFLG="N") D  Q
 . . I PFLG="" D
 . . . S DASTR=DA(4)_",1,"_DA(3)_",1,"_DA(2)_",""V"","_DA(1)_",1,"
 . . . S DIE="^RMPO(665.72,"_DASTR,DR="8///N",DA=IT D ^DIE
 . . S X=1,FLG="P"
 K DIE,DA,DR
 S DA(1)=VDR,DA(2)=RVDT,DA(3)=SITE,DA=DFN,DR="3///"_FLG
 S DIE="^RMPO(665.72,"_DA(3)_",1,"_DA(2)_",1,"_DA(1)_",""V"","
 D ^DIE
 Q  ;PATUPD
 ;
FCPUPD ;Update global ^RMPO(665.72 with totals for Purchase Card
 K DIE,DA,DR
 S DA=IENFCP,DA(1)=RVDT,DA(2)=SITE
 S DIE="^RMPO(665.72,"_DA(2)_",1,"_DA(1)_",2,"
 S DR=$S($P(PAYINF,U)="P":"6///"_(FCPTOT+PCTOT)_";",1:"")
 S DR=DR_"4////"_DUZ_";"_"5///"_VDR
 D ^DIE
 Q  ;FCPUPD
 ;
