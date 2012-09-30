DGMSEUTL ;ALB/PJH,LBD - MSDS Utility Routine;12 JUN 1997 10:00 am ; 9/26/11 4:16pm
 ;;5.3;Registration;**797**;08/13/93;Build 24
 ;
 ;
MOVMSE(DFN) ;Move MSE data from .32 node to .3216 multiple in Patient file #2
 Q:'$G(DFN)  Q:$O(^DPT(DFN,.3216,0))
 N ARRAY
 D ARRAY(DFN,.ARRAY)
 I $D(ARRAY) D MSE(DFN,.ARRAY)
 Q
 ;
ARRAY(DFN,ARRAY) ;Get old format VistA data
 N DGRP,DGRPX,DGRPED,DGRPSD,DGRPBR,DGRPCO,DGRPSN,DGRPDI
 S DGRP(.32)=$G(^DPT(DFN,.32)),DGRP(.3291)=$G(^DPT(DFN,.3291))
 ;Last service episode (SL)
 D EPISODE(1,4,8)
 ;Next to last service episode (SNL)
 Q:$P(DGRP(.32),"^",19)'="Y"  D EPISODE(2,9,13)
 ;Prior episode (SNNL)
 I $P(DGRP(.32),"^",20)="Y" D EPISODE(3,14,18)
 Q
 ;
EPISODE(SUB,P1,P2) ;Get old VistA data and save
 S DGRPX=$P(DGRP(.32),U,P1,P2),DGRPCO=$P(DGRP(.3291),U,SUB)
 S DGRPDI=$P(DGRPX,U),DGRPBR=$P(DGRPX,U,2),DGRPED=$P(DGRPX,U,3)
 S DGRPSD=$P(DGRPX,U,4),DGRPSN=$P(DGRPX,U,5)
 ;Save in format of new .3216 multiple (no lock flag)
 S ARRAY(SUB)=DGRPED_U_DGRPSD_U_DGRPBR_U_DGRPCO_U_DGRPSN_U_DGRPDI_U
 Q
 ;
MSE(DFN,ARRAY,DEL) ;Copy old VistA data to new .3216 multiple
 N ECNT,DA,DIK,SUB,X
 S ECNT=0
 ;Delete existing entries
 I $G(DEL) F  S ECNT=$O(^DPT(DFN,.3216,ECNT)) Q:+ECNT'>0  D
 .S DA(1)=DFN,DA=ECNT,DIK="^DPT("_DA(1)_",.3216," D ^DIK
 ;Add service episodes
 S SUB=""
 F  S SUB=$O(ARRAY(SUB)) Q:'SUB  D
 .;Ignore if Service Entry Date is null
 .Q:'+ARRAY(SUB)
 .N DA,DIC,DD,DO,DLAYGO,FLDS,X
 .S FLDS=ARRAY(SUB)
 .S DIC="^DPT(DFN,.3216,"
 .S DIC(0)="L",DLAYGO=2
 .S DA(1)=DFN
 .S X=$P(FLDS,U) ;Entry Date
 .S DIC("DR")=".02////"_$P(FLDS,U,2) ;Separation Date
 .S DIC("DR")=DIC("DR")_";.03////"_$P(FLDS,U,3) ;Service Branch
 .S DIC("DR")=DIC("DR")_";.04////"_$P(FLDS,U,4) ;Service Component
 .S DIC("DR")=DIC("DR")_";.05////"_$P(FLDS,U,5) ;Service Number
 .S DIC("DR")=DIC("DR")_";.06////"_$P(FLDS,U,6) ;Discharge type
 .S DIC("DR")=DIC("DR")_";.07////"_$P(FLDS,U,7) ;Locked
 .D FILE^DICN
 Q
 ;
GETMSE(DFN,MSE) ;Return all records in MSE sub-file #2.3216 in MSE array
 ;Records are sorted in reverse chronological order and the second
 ;subscript is the MSE IEN in the multiple  e.g. MSE(1,4)=last
 I '$G(DFN) Q
 N I,SDT,IEN
 S SDT=""
 F I=1:1 S SDT=$O(^DPT(DFN,.3216,"B",SDT),-1) Q:'SDT  D
 .S IEN=0 F  S IEN=$O(^DPT(DFN,.3216,"B",SDT,IEN)) Q:'IEN  D
 ..I '$D(^DPT(DFN,.3216,IEN,0)) Q
 ..S MSE(I)=^DPT(DFN,.3216,IEN,0)
 ..S MSE(I,IEN)=""
 Q
 ;
LAST(DFN) ;Return last (most recent) MSE
 I '$G(DFN) Q ""
 N MSE
 D GETMSE(DFN,.MSE)
 S MSE=$O(MSE(0))
 Q $G(MSE(+MSE))
 ;
UPDMSE(DFN,DGNMSE) ;File MSE data from the HEC Z11 message
 Q:'$G(DFN)  Q:'$D(DGNMSE)
 N DGOMSE,DGTOT,DGCHG,DGN,DGO,I
 S DGTOT=0,DGN="" F  S DGN=$O(DGNMSE(DGN)) Q:'DGN  S DGTOT=DGTOT+1
 ;Get current MSE data for patient from MSE sub-file #2.3216
 D GETMSE(DFN,.DGOMSE)
 I $D(DGOMSE) D  Q:'DGCHG
 .;Compare the old and new data.  If they match, no update is needed.
 .S DGCHG=0
 .I DGTOT'=$O(DGOMSE(""),-1) S DGCHG=1 Q
 .S (DGO,DGN)=""
 .F I=1:1:DGTOT S DGO=$O(DGOMSE(DGO)),DGN=$O(DGNMSE(DGN)) D  Q:DGCHG
 ..I DGOMSE(DGO)'=DGNMSE(DGN) S DGCHG=1 Q
 ;File the new MSE data from HEC, delete old data first if it exists
 D MSE(DFN,.DGNMSE,$D(DGOMSE))
 Q
 ;
ESRDATA(DFN) ;Check if any records in .3216 are from ESR
 N IEN,LOCKED
 S IEN=0,LOCKED=0
 F  S IEN=$O(^DPT(DFN,.3216,IEN)) Q:'IEN  D  Q:LOCKED
 .;Check if record is locked
 .S LOCKED=$P($G(^DPT(DFN,.3216,IEN,0)),U,7)
 ;Return LOCKED indicating ESR data found
 Q LOCKED
 ;
WARNMSG(DFN) ;Warning Message if some episodes did not copy
 N DATA32,OLDMSE,NEWMSE,DATA
 ;If ESR data exists quit
 Q:$$ESRDATA(DFN) 0
 ;Count number of old episodes
 N LBRANCH,LDATE,SDAT,NODT
 S DATA32=$G(^DPT(DFN,.32))
 S LDATE=$P(DATA32,U,6),LBRANCH=$P(DATA32,U,5),OLDMSE=0,NODT=0
 ;If entry date or branch assume last episode exists
 I LDATE!LBRANCH S OLDMSE=OLDMSE+1 S:'LDATE NODT=1
 ;Check for second episode
 I $P(DATA32,U,19)="Y" D
 .S OLDMSE=OLDMSE+1 S:'$P(DATA32,U,11) NODT=1
 .;and third episode
 .I $P(DATA32,U,20)="Y" S OLDMSE=OLDMSE+1 S:'$P(DATA32,U,16) NODT=1
 ;
 ;If no old episodes no message is necessary
 Q:'OLDMSE 0
 ;
 ;Count number of new episodes
 S NEWMSE=0,SDAT=""
 F  S SDAT=$O(^DPT(DFN,.3216,"B",SDAT),-1) Q:'SDAT  D
 .S IEN=$O(^DPT(DFN,.3216,"B",SDAT,0)) Q:'IEN
 .S DATA=$G(^DPT(DFN,.3216,IEN,0)) Q:DATA=""
 .S NEWMSE=NEWMSE+1
 ;
 ;If number old MSEs greater than new MSEs, and service entry date
 ;is missing, return 1
 I OLDMSE>NEWMSE,NODT Q 1
 ;Otherwise, return 0
 Q 0
