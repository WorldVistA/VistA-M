PRSPLVA1 ;WOIFO/SAB - AUTOPOST LEAVE FOR PTP (CONT) ;03/30/2005
 ;;4.0;PAID;**93**;Sep 21, 1995;Build 7
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 Q
 ;
PDAY ; Process Day (within Pay Period loop)
 ; called from PRSPLVA
 ; input variables LVDTE,LVDTS,LVY0,PPDN,PPI,PRSIEN,PRSFDA(),
 ;   TCST,TCUNPOST()
 ; output variable
 ;   FATAL  = 1^PPI, only defined if fatal exception occurred
 ;   PRSFDA() may be updated with additional data to post to ESR
 ;   TCUNPOST() may be updated with another day to unpost from timecard
 ;
 N ESR,ESRRG,ESRLVM,ESRST,FOUND,OVERLAP,PPDIENS,PRSDT,PRSX
 N PSTDTE,PSTDTS,PSTMEAL,PSTSEG,PSTTYP,SEGI,TC,TOD,TODD,TODL,TOURLV
 N TSE,TSID,TSS,TSY
 ;
 ; skip day if not a scheduled tour
 Q:$P($G(^PRST(458,PPI,"E",PRSIEN,"D",PPDN,1)),U)=""
 ;
 S PPDIENS=PPDN_","_PRSIEN_","_PPI_","
 ;
 S PRSDT=$P($G(^PRST(458,PPI,1)),U,PPDN) ; FileMan date of day number
 ;
 ; load tour segments from both tours into arrays TOD() and TODD()
 D LOADTOD^PRSPLVU(PPI,PRSIEN,PPDN,.TOD,.TODD)
 ;
 ; load ESR segments into array ESR()
 D LOADESR^PRSPLVU(PPI,PRSIEN,PPDN,.ESR)
 ;
 ; load time card segments into array TC()
 D LOADTC^PRSPLVU(PPI,PRSIEN,PPDN,.TC)
 ;
 ; determine leave postings
 ; loop thru tour segments
 S TSID="" F  S TSID=$O(TOD(TSID)) Q:TSID=""  D  Q:$G(FATAL)
 . S TSY=TOD(TSID)
 . S TSS=$P(TSY,U)
 . S TSE=$P(TSY,U,2)
 . ; skip if tour seg. end < OR = to leave start
 . Q:TSE'>LVDTS
 . ; skip if tour seg. start > OR = to leave end
 . Q:TSS'<LVDTE
 . ;
 . ; leave overlaps tour segment
 . ;
 . ; determine posting times
 . ; posting start is greater of leave start and tour seg. start
 . S PSTDTS=$S(LVDTS>TSS:LVDTS,1:TSS)
 . ; posting end is lesser of leave end and tour seg. end
 . S PSTDTE=$S(LVDTE<TSE:LVDTE,1:TSE)
 . ;
 . ; determine type of time to post
 . S PSTTYP=$P(LVY0,U,7)
 . I $P(TSY,U,3)'="RG","TR TV"'[PSTTYP S PSTTYP="UN"
 . ;
 . S PSTMEAL=0 ; init meal time
 . ;
 . ; if leave is within or equal to the tour segment then calculate
 . ; a meal based on the user-specified leave request hours
 . I LVDTS'<TSS,LVDTE'>TSE D
 . . N CLM,FLD,TODI,TODN
 . . Q:$P(TSY,U,3)'="RG"
 . . S CLM=($$FMDIFF^XLFDT(LVDTE,LVDTS,2))/60 ; calc lv length min
 . . S PSTMEAL=CLM-($P(LVY0,U,15)*60)
 . . I PSTMEAL<0 S PSTMEAL=0 Q  ; must be positive or zero
 . . I PSTMEAL#15 S PSTMEAL=0 Q  ; must be multiple of 15
 . . ; must not exceed meal time for TOD
 . . S TODN=$P(TSID,"-",1) ; determine tour # (1 or 2) for segment
 . . I PSTMEAL>$P($G(TODD(TODN)),U,3) S PSTMEAL=$P($G(TODD(TODN)),U,3)
 . ;
 . ; if meal was not set based on leave request hours then check if it
 . ; can be set based on tour info
 . I PSTMEAL=0 D
 . . N TODN
 . . S TODN=$P(TSID,"-",1) ; tour # (1 or 2)
 . . ; quit if tour does not have a meal
 . . Q:$P($G(TODD(TODN)),U,3)'>0
 . . ; quit if segment # currently being processed is not the longest
 . . ; (better to place meal in the longest segment when more than one)
 . . Q:$P($G(TODD(TODN)),U,4)'=$P(TSID,"-",2)
 . . ; quit if leave started after tour began
 . . Q:LVDTS>$P($G(TODD(TODN)),U,1)
 . . ; quit if leave ended before tour ended
 . . Q:LVDTE<$P($G(TODD(TODN)),U,2)
 . . ; since leave covers the entire tour - set meal time based on tour
 . . S PSTMEAL=$P($G(TODD(TODN)),U,3)
 . ;
 . ; skip if proposed posting covered by holiday excused on ESR
 . S FOUND=0
 . ;   loop thru ESR segments
 . S SEGI="" F  S SEGI=$O(ESR(SEGI)) Q:SEGI=""  D  Q:FOUND
 . . N ESRY
 . . S ESRY=ESR(SEGI)
 . . Q:$P(ESRY,U,3)'="HX"  ; quit if not holiday ex
 . . I PSTDTS'<$P(ESRY,U),PSTDTE'>$P(ESRY,U,2) S FOUND=1
 . Q:FOUND  ; skip because posting is within HX (holiday excused)
 . ;
 . ; skip if proposed posting is already on the ESR
 . S FOUND=0
 . ;   loop thru ESR segments
 . S SEGI="" F  S SEGI=$O(ESR(SEGI)) Q:SEGI=""  D  Q:FOUND
 . . N ESRY
 . . S ESRY=ESR(SEGI)
 . . Q:$P(ESRY,U,3)'=PSTTYP  ; quit if same type
 . . I PSTDTS'<$P(ESRY,U),PSTDTE'>$P(ESRY,U,2) S FOUND=1
 . Q:FOUND  ; skip because posting is already covered on ESR
 . ;
 . ; if time card status = "P" and proposed posting in not on the
 . ; current time card then record a fatal exception and quit
 . ;   loop thru time card exception segments
 . I TCST="P" D  I 'FOUND S FATAL="1^"_PPI Q 
 . . S FOUND=0
 . . S SEGI="" F  S SEGI=$O(TC(SEGI)) Q:SEGI=""  D  Q:FOUND
 . . . N TCY
 . . . S TCY=TC(SEGI)
 . . . Q:$P(TCY,U,3)'=PSTTYP  ; quit if not same type
 . . . I PSTDTS'<$P(TCY,U),PSTDTE'>$P(TCY,U,2) S FOUND=1
 . ;
 . ; OK to add posting to FDA array
 . ;
 . ;   review ESR and FDA to determine next open segment
 . S PSTSEG=0 F SEGI=1:1:7 I '$D(ESR(SEGI)) S PSTSEG=SEGI Q
 . ;
 . ; if segment not available then report exception and skip?
 . Q:'PSTSEG
 . ;
 . ; add posting to FDA() array and ESR() array
 . S PRSFDA(458.02,PPDIENS,(PSTSEG-1)*5+110)=$$FMETA^PRSPLVU($P(PSTDTS,".",2)) ; start time
 . S PRSFDA(458.02,PPDIENS,(PSTSEG-1)*5+111)=$$FMETA^PRSPLVU($P(PSTDTE,".",2)) ; stop time
 . S PRSFDA(458.02,PPDIENS,(PSTSEG-1)*5+112)=PSTTYP ; type time
 . S PRSFDA(458.02,PPDIENS,(PSTSEG-1)*5+114)=PSTMEAL ; meal
 . S ESR(PSTSEG)=PSTDTS_U_PSTDTE_U_PSTTYP_U_PRSFDA(458.02,PPDIENS,(PSTSEG-1)*5+110)_U_PRSFDA(458.02,PPDIENS,(PSTSEG-1)*5+111)_U_PSTMEAL
 ;
 ; quit if fatal exception
 Q:$G(FATAL)
 ;
 ; quit if nothing will be posted to ESR day
 Q:'$D(PRSFDA(458.02,PPDIENS))
 ;
 ; obtain current ESR daily status
 S ESRST=$P($G(^PRST(458,PPI,"E",PRSIEN,"D",PPDN,7)),U)
 ; 
 ; determine proposed new status of ESR day
 ;
 ;   determine if any ESR time segments overlap
 ;     (some types of time are excluded from check)
 S OVERLAP=0
 S SEGI=0 F  S SEGI=$O(ESR(SEGI)) Q:'SEGI  D
 . N SEGJ,SEGX,SEGY
 . S SEGX=ESR(SEGI)
 . Q:"ON SB UN"[$P(SEGX,U,3)
 . S SEGJ=SEGI F  S SEGJ=$O(ESR(SEGJ)) Q:'SEGJ  D
 . . S SEGY=ESR(SEGJ)
 . . Q:"ON SB UN"[$P(SEGY,U,3)
 . . Q:$P(SEGX,U,2)'>$P(SEGY,U,1)
 . . Q:$P(SEGX,U,1)'<$P(SEGY,U,2)
 . . S OVERLAP=1
 ;
 ;   determine if entire tour covered by leave
 S PRSX=$G(^PRST(458,PPI,"E",PRSIEN,"D",PPDN,0))
 S TODL=$P(PRSX,U,8)+$P(PRSX,U,14) ; tour of duty length in hours
 ;     loop thru ESR segments to add up leave
 S ESRLVM=0 ; leave in minutes
 S SEGI="" F  S SEGI=$O(ESR(SEGI)) Q:SEGI=""  D
 . N ESRY,SEGLVM
 . S ESRY=ESR(SEGI)
 . Q:"AL SL WP CU AA ML RL NL CB AD DL"'[$P(ESRY,U,3)
 . S SEGLVM=($$FMDIFF^XLFDT($P(ESRY,U,2),$P(ESRY,U,1),2)/60)-$P(ESRY,U,6)
 . S ESRLVM=ESRLVM+SEGLVM
 S TOURLV=$S((ESRLVM/60)'<TODL:1,1:0) ; true if tour covered by leave
 ;
 ;   determine if any RG time on ESR
 S ESRRG=$S($G(^PRST(458,PPI,"E",PRSIEN,"D",PPDN,5))["RG":1,1:0)
 ;
 ;   if not started/pending/resubmit and no RG, no overlaps, and
 ;   tour covered by leave then auto sign based on leave. Otherwise,
 ;   if not started then change to pending
 I "^1^2^3^"[(U_ESRST_U) D
 . N SIGNED
 . S SIGNED=0
 . I 'ESRRG,'OVERLAP,TOURLV D
 . . S PRSFDA(458.02,PPDIENS,146)="4" ; status = signed
 . . S PRSFDA(458.02,PPDIENS,147)=$$NOW^XLFDT() ; signed d/t
 . . S PRSFDA(458.02,PPDIENS,149)="3" ; signed method = leave request
 . . S SIGNED=1
 . I 'SIGNED,ESRST=1 S PRSFDA(458.02,PPDIENS,146)="2" ; status = pending
 ;
 ;   if signed or approved and no overlap then re-sign.  Otherwise
 ;   change to pending.
 I "^4^5^"[(U_ESRST_U) D
 . ;
 . I 'OVERLAP D
 . . S PRSFDA(458.02,PPDIENS,146)="4" ; status = signed
 . . S PRSFDA(458.02,PPDIENS,147)=$$NOW^XLFDT() ; signed d/t
 . . ; if tour covered by leave and method is extended absence then
 . . ; change signed method to leave
 . . I TOURLV,$P($G(^PRST(458,PPI,"E",PRSIEN,"D",PPDN,7)),U,3)=2 S PRSFDA(458.02,PPDIENS,149)="3"
 . ;
 . I OVERLAP D
 . . S PRSFDA(458.02,PPDIENS,146)="2" ; status = pending
 . . S PRSFDA(458.02,PPDIENS,147)="@" ; delete signed d/t
 . . S PRSFDA(458.02,PPDIENS,149)="@" ; delete signed method
 . ;
 . ; if day was approved and time card status = T then add to unpost list
 . I ESRST=5,TCST="T" S TCUNPOST(PPI,PPDN)=""
 ;
 Q
 ;
 ;PRSPLVA1
