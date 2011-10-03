PRSPLVA ;WOIFO/SAB - AUTOPOST LEAVE FOR PART-TIME PHY. WITH MEMO ;4/6/2005
 ;;4.0;PAID;**93**;Sep 21, 1995;Build 7
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 Q
 ;
PLPP(PRSIEN,PPI,DAYN) ; Post Leave for a Pay Period (or day)
 ; Called by the open next PP option to post leave to one new pay period
 ; for one part-time physician.
 ; Called by the enter/edit tour option to re-post leave to one
 ; pay period when a tour is changed.
 ; Input
 ;   PRSIEN - Employee IEN (file 450), should be PTP with active memo
 ;   PPI    - Pay Period IEN (file 458)
 ;   DAYN   - (optional) day # within pay period to only post that day
 ;
 N LVIEN,LVY0,PPD1,PPD15,PRSX,RPPD1,RTDT,Y
 S DAYN=$G(DAYN)
 ;
 ; Determine pay period dates
 S Y=$G(^PRST(458,PPI,1))
 S PRSX=$S(DAYN:DAYN,1:1) ; if passed use day # instead of 1st PP day
 S PPD1=$P(Y,U,PRSX) ; 1st day of PP
 S RPPD1=9999999-PPD1 ; reverse 1st day of PP
 S PRSX=$S(DAYN:DAYN,1:14) ; if passed use day # instead of last PP day
 S PPD15=$$FMADD^XLFDT($P(Y,U,PRSX),1) ; Last day of PP+1
 ; (use day 15 to include leave that starts on 2nd day of 2-day tour and
 ;  would be posted on the prior day)
 K PRSX
 Q:PPD1=""
 ;
 ; loop thru leave requests for employee by reverse to date until
 ; to date is before the pay period or no more to dates
 S RTDT=""
 F  S RTDT=$O(^PRST(458.1,"AD",PRSIEN,RTDT)) Q:'RTDT!(RTDT>RPPD1)  D
 . ; loop thru requests
 . S LVIEN=0
 . S LVIEN=$O(^PRST(458.1,"AD",PRSIEN,RTDT,LVIEN)) Q:'LVIEN  D
 . . S LVY0=$G(^PRST(458.1,LVIEN,0)) ; leave request 0 node
 . . Q:$P(LVY0,U,3)>PPD15  ; skip if from date after pay period+1
 . . Q:$P(LVY0,U,9)'="A"  ; skip if status not approved
 . . ;
 . . ; approved request may overlap PP so post the leave request
 . . D PLR(LVIEN,PPI,DAYN)
 Q
 ;
PLR(LVIEN,SPPI,DAYN,PRSEX) ; Post Leave Request
 ; Called during open next pay period process (by PLPP above) to post
 ;   one leave request to a single pay period.
 ; Called during Supervisory Approvals process to post one leave request
 ;   to all opened pay periods.
 ; Input
 ;   LVIEN  - Leave Request IEN (file 458.1)
 ;   SPPI   - Pay Period IEN (file 458) or Null Value if for all.
 ;   DAYN   - (optional) day # within SPPI or null value
 ;   PRSEX - Passed by reference, will be initialized (killed)
 ; Output
 ;   PRSEX - passed by reference, only defined if the leave was not
 ;           posted to the ESR and should not be approved because the
 ;           leave is not currently on the time card and it has a status
 ;           of Payroll.  This exception should only be applicable when
 ;           auto post is called by the supervisory approval of leave.
 ;
 ;
 ; Note: All applicable time cards are assumed to be locked prior to
 ;       calling this API.
 ;
 Q:'$G(LVIEN)  ; required input
 S SPPI=$G(SPPI)
 ;
 N D1,DAY,EDN,EPP4Y,FATAL,LVDTE,LVDTS,LVY0,PP4Y,PPDN,PPDNB
 N PPDTB,PPDNE,PPDTE,PPE,PPI,PRSFDA,PRSIEN,PRSX,SDN,SPP4Y,TCST,TCUNPOST,Y
 ;
 K PRSEX
 ;
 S DAYN=$G(DAYN)
 S LVY0=$G(^PRST(458.1,LVIEN,0)) ; leave request 0 node
 S PRSIEN=$P(LVY0,U,2) ; employee IEN
 D
 . N CNX,PRSM,X,Y
 . S X=$P(LVY0,U,4)_U_$P(LVY0,U,6)
 . D CNV^PRSATIM
 . S PRSM=Y
 . S LVDTS=$$FMADD^XLFDT($P(LVY0,U,3),,,$P(PRSM,U,1)) ; leave d/t start
 . S LVDTE=$$FMADD^XLFDT($P(LVY0,U,5),,,$P(PRSM,U,2)) ; leave d/t end
 ;
 ; determine starting and ending pay periods
 ;   if single pay period specified
 I $G(SPPI) D
 . S D1=$P(^PRST(458,SPPI,1),U) D PP^PRSAPPU S (SPP4Y,EPP4Y)=PP4Y
 ;   if no pay period specified
 I '$G(SPPI) D
 . S D1=$$FMADD^XLFDT($P(LVY0,U,3),-1) D PP^PRSAPPU S SPP4Y=PP4Y ; based on leave from -1 (use -1 in case of 2-day tour)
 . S D1=$P(LVY0,U,5) D PP^PRSAPPU S EPP4Y=PP4Y ; based on leave to
 ;
 ; loop thru pay periods
 S PP4Y=$O(^PRST(458,"AB",SPP4Y),-1) ; set initial value to previous PP
 F  S PP4Y=$O(^PRST(458,"AB",PP4Y)) Q:PP4Y=""!(PP4Y]EPP4Y)  D
 . S PPI=$O(^PRST(458,"AB",PP4Y,0))
 . ;
 . ; check status of memo
 . S D1=$P($G(^PRST(458,PPI,1)),U)
 . S PRSX=$$MIEN^PRSPUT1(PRSIEN,D1)
 . Q:PRSX'>0  ; skip if pay period is not covered by memo
 . Q:$P(PRSX,U,2)=4  ; skip if memo is reconciled
 . K PRSX
 . ;
 . ; obtain time card status
 . S TCST=$P($G(^PRST(458,PPI,"E",PRSIEN,0)),U,2)
 . ;
 . ; determine begin and end day numbers within pay period
 . S PPY1=$G(^PRST(458,PPI,1))
 . ; begin day is greater of leave from date-1 and 1st PP day
 . S PRSX=$S(DAYN:DAYN,1:1) ; if passed use day # instead of 1st PP day
 . S SDT=$S($P(PPY1,U,PRSX)>$$FMADD^XLFDT($P(LVY0,U,3),-1):$P(PPY1,U,PRSX),1:$$FMADD^XLFDT($P(LVY0,U,3),-1))
 . S SDN=$P($G(^PRST(458,"AD",SDT)),U,2) ; start day number
 . ; end day is lesser of leave request to date and last PP day
 . S PRSX=$S(DAYN:DAYN,1:14) ; if passed use day # instead of last PP day
 . S EDT=$S($P(LVY0,U,5)>$P(PPY1,U,PRSX):$P(PPY1,U,PRSX),1:$P(LVY0,U,5))
 . S EDN=$P($G(^PRST(458,"AD",EDT)),U,2) ; end day number
 . K PPY1,PRSX,SDT,EDT
 . ;
 . ; loop thru applicable days in PP
 . S PPDN=SDN-1 ; initial PP day number for loop
 . F  S PPDN=$O(^PRST(458,PPI,"E",PRSIEN,"D",PPDN)) Q:'PPDN!(PPDN>EDN)  D PDAY^PRSPLVA1
 ;
 ; handle fatal exception and quit without updating file 458
 I $G(FATAL) S PRSEX=$P(FATAL,U,2) Q
 ;
 ; clear appropriate time card days
 S PPI="" F  S PPI=$O(TCUNPOST(PPI)) Q:'PPI  D
 . S PPDN="" F  S PPDN=$O(TCUNPOST(PPI,PPDN)) Q:'PPDN  D
 . . N X
 . . S X=$$CLRTCDY^PRSPSAPU(PPI,PRSIEN,PPDN)
 ;
 ; update the ESR
 I $D(PRSFDA) D FILE^DIE("","PRSFDA") D MSG^DIALOG()
 ;
 Q
 ;
ULR(LVY0) ; Unpost Leave Request
 ; Called by the Edit Leave Request and Cancel Leave Request options
 ;   to unpost one leave request from all opened pay periods.
 ; Input
 ;   LVIEN  - Leave Request 0 Node (before edit) (see file 458.1)
 ; 
 ; Note: All applicable time cards are assumed to be locked prior to
 ;       calling this API.
 ;
 Q:$G(LVY0)=""  ; required input
 ;
 N D1,DAY,EDN,EPP4Y,LVDTE,LVDTS,PP4Y,PPDN,PPDNB
 N PPDTB,PPDNE,PPDTE,PPE,PPI,PRSFDA,PRSIEN,SDN,SPP4Y,Y
 ;
 S PRSIEN=$P(LVY0,U,2) ; employee IEN
 D
 . N CNX,PRSM,X,Y
 . S X=$P(LVY0,U,4)_U_$P(LVY0,U,6)
 . D CNV^PRSATIM
 . S PRSM=Y
 . S LVDTS=$$FMADD^XLFDT($P(LVY0,U,3),,,$P(PRSM,U,1)) ; leave d/t start
 . S LVDTE=$$FMADD^XLFDT($P(LVY0,U,5),,,$P(PRSM,U,2)) ; leave d/t end
 ;
 ; determine starting and ending pay periods
 S D1=$$FMADD^XLFDT($P(LVY0,U,3),-1) D PP^PRSAPPU S SPP4Y=PP4Y ; based on leave from -1 (use -1 in case of 2-day tour)
 S D1=$P(LVY0,U,5) D PP^PRSAPPU S EPP4Y=PP4Y ; based on leave to
 ;
 ; loop thru pay periods
 S PP4Y=$O(^PRST(458,"AB",SPP4Y),-1) ; set initial value to previous PP
 F  S PP4Y=$O(^PRST(458,"AB",PP4Y)) Q:PP4Y=""!(PP4Y]EPP4Y)  D
 . S PPI=$O(^PRST(458,"AB",PP4Y,0))
 . ;
 . ; check status of memo
 . S D1=$P($G(^PRST(458,PPI,1)),U)
 . S PRSX=$$MIEN^PRSPUT1(PRSIEN,D1)
 . Q:PRSX'>0  ; skip if pay period is not covered by memo
 . Q:$P(PRSX,U,2)=4  ; skip if memo is reconciled
 . K PRSX
 . ;
 . ; determine begin and end day numbers within pay period
 . S PPY1=$G(^PRST(458,PPI,1))
 . ; begin day is greater of leave from date-1 and 1st PP day
 . S SDT=$S($P(PPY1,U,1)>$$FMADD^XLFDT($P(LVY0,U,3),-1):$P(PPY1,U,1),1:$$FMADD^XLFDT($P(LVY0,U,3),-1))
 . S SDN=$P($G(^PRST(458,"AD",SDT)),U,2) ; start day number
 . ; end day is lesser of leave request to date and last PP day
 . S EDT=$S($P(LVY0,U,5)>$P(PPY1,U,14):$P(PPY1,U,14),1:$P(LVY0,U,5))
 . S EDN=$P($G(^PRST(458,"AD",EDT)),U,2) ; end day number
 . K PPY1,SDT,EDT
 . ;
 . ; loop thru applicable days in PP
 . S PPDN=SDN-1 ; initial PP day number for loop
 . F  S PPDN=$O(^PRST(458,PPI,"E",PRSIEN,"D",PPDN)) Q:'PPDN!(PPDN>EDN)  D PDAY^PRSPLVA2
 ;
 ; update the ESR
 I $D(PRSFDA) D FILE^DIE("S","PRSFDA") D MSG^DIALOG()
 ;
 ; Call API BURP^PRSPESR2 to 'burp' the ESR for any unposted days.
 ; loop thru iens in PRSFDA(), get node 5, use burp, if result different
 ; then save result back in node 5
 I $D(PRSFDA) D
 . N PPDIENS,PPDN,PPI,PRSIEN,PRSX,PRSY
 . ; loop thru iens (days)
 . S PPDIENS="" F  S PPDIENS=$O(PRSFDA(458.02,PPDIENS)) Q:PPDIENS=""  D
 . . S PPDN=$P(PPDIENS,",",1)
 . . S PRSIEN=$P(PPDIENS,",",2)
 . . S PPI=$P(PPDIENS,",",3)
 . . S PRSX=$G(^PRST(458,PPI,"E",PRSIEN,"D",PPDN,5))
 . . S PRSY=$$BURP^PRSPESR2(PRSX)
 . . I PRSX'=PRSY S ^PRST(458,PPI,"E",PRSIEN,"D",PPDN,5)=PRSY
 ;
 Q
 ;
 ;PRSPLVA
