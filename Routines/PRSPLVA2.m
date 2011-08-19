PRSPLVA2 ;WOIFO/SAB - AUTOPOST LEAVE FOR PTP (CONT) ;3/30/2005
 ;;4.0;PAID;**93**;Sep 21, 1995;Build 7
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 Q
 ;
PDAY ; Process Day (within Pay Period loop of Unpost feature)
 ; called from PRSPLVA
 ; input variables LVDTE,LVDTS,LVY0,PPDN,PPI,PRSIEN,PRSFDA(),
 ; output variable
 ;   PRSFDA() may be updated with additional data to post to ESR
 ;
 N ESR,ESRHX,ESRRG,ESRLVM,ESRST,FOUND,OVERLAP,PPDIENS,PRSDT,PRSX
 N PSTDTE,PSTDTS,PSTMEAL,PSTSEG,PSTTYP,SEGI,TOD,TODD,TODL,TOURLV
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
 ; determine leave postings
 ; loop thru tour segments
 S TSID="" F  S TSID=$O(TOD(TSID)) Q:TSID=""  D
 . S TSY=TOD(TSID)
 . S TSS=$P(TSY,U)
 . S TSE=$P(TSY,U,2)
 . ; skip if tour seg. end < leave start
 . Q:TSE<LVDTS
 . ; skip if tour seg. start > leave end
 . Q:TSS>LVDTE
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
 . S PSTMEAL=0 ; init
 . ;
 . ; if leave is within or equal to the tour segment then calculate
 . ; a meal based on the leave request hours
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
 . ; find current leave posting on the ESR
 . S FOUND=0
 . ;   loop thru ESR segments
 . S SEGI="" F  S SEGI=$O(ESR(SEGI)) Q:SEGI=""  D  Q:FOUND
 . . N ESRY
 . . S ESRY=ESR(SEGI)
 . . Q:$P(ESRY,U,3)'=PSTTYP  ; quit if not same type
 . . I PSTDTS=$P(ESRY,U),PSTDTE=$P(ESRY,U,2) S FOUND=1
 . Q:'FOUND  ; skip because posting is not on the ESR
 . S PSTSEG=SEGI
 . ;
 . ; OK to add unposting to FDA array
 . ;
 . ; add unposting to FDA() array and ESR() array
 . S PRSFDA(458.02,PPDIENS,(PSTSEG-1)*5+110)="@" ; start time
 . S PRSFDA(458.02,PPDIENS,(PSTSEG-1)*5+111)="@" ; stop time
 . S PRSFDA(458.02,PPDIENS,(PSTSEG-1)*5+112)="@" ; type time
 . S PRSFDA(458.02,PPDIENS,(PSTSEG-1)*5+114)="@" ; meal
 . K ESR(PSTSEG)
 ;
 ; quit if nothing will be unposted from the ESR day
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
 ;   determine if any HX time on ESR
 S ESRHX=$S($G(^PRST(458,PPI,"E",PRSIEN,"D",PPDN,5))["HX":1,1:0)
 ;
 ; determine appropriate status for day
 D
 . ; if current status = signed and current method = manual then re-sign
 . ; by manual and quit block
 . I ESRST=4,$P($G(^PRST(458,PPI,"E",PRSIEN,"D",PPDN,7)),U,3)=1 D  Q
 . . S PRSFDA(458.02,PPDIENS,146)="4" ; status = signed
 . . S PRSFDA(458.02,PPDIENS,147)=$$NOW^XLFDT() ; signed d/t
 . . S PRSFDA(458.02,PPDIENS,149)="1" ; signed method = manual
 . ;
 . ; if day covered by holiday, no RG, no overlap then re-sign by holiday
 . ; and quit block
 . I ESRHX,'ESRRG,'OVERLAP D  Q
 . . S PRSFDA(458.02,PPDIENS,146)="4" ; status = signed
 . . S PRSFDA(458.02,PPDIENS,147)=$$NOW^XLFDT() ; signed d/t
 . . S PRSFDA(458.02,PPDIENS,149)="4" ; signed method = holiday
 . ;
 . ; if tour covered by leave, no RG, no overlap, then re-sign by leave
 . ; and quit block
 . I TOURLV,'ESRRG,'OVERLAP D  Q
 . . S PRSFDA(458.02,PPDIENS,146)="4" ; status = signed
 . . S PRSFDA(458.02,PPDIENS,147)=$$NOW^XLFDT() ; signed d/t
 . . S PRSFDA(458.02,PPDIENS,149)="3" ; signed method = leave
 . ;
 . ; if day covered by extended absence, no RG, no overlap, then re-sign
 . ; by EA and quit block
 . I $$CONFLICT^PRSPEAU(PRSIEN,PRSDT),'ESRRG,'OVERLAP D  Q
 . . S PRSFDA(458.02,PPDIENS,146)="4" ; status = signed
 . . S PRSFDA(458.02,PPDIENS,147)=$$NOW^XLFDT() ; signed d/t
 . . S PRSFDA(458.02,PPDIENS,149)="2" ; signed method = EA
 . ;
 . ; day will not be signed
 . ;
 . ; if day previously signed then clear out signed fields
 . I ESRST="4" D
 . . S PRSFDA(458.02,PPDIENS,147)="@" ; delete signed d/t
 . . S PRSFDA(458.02,PPDIENS,149)="@" ; delete signed method
 . ;
 . ; set status = resubmit (if that was current) or pending (if segment)
 . ; or not started
 . S PRSFDA(458.02,PPDIENS,146)=$S(ESRST="3":"3",$O(ESR(0)):"2",1:"1")
 Q
 ;
 ;PRSPLVA2
