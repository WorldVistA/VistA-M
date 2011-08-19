PRSPEAA ;WOIFO/SAB - Ext. Absence Autopost for PT Physician ;4/6/2005
 ;;4.0;PAID;**93**;Sep 21, 1995;Build 7
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 Q
 ;
PEAPP(PRSIEN,PPI,DAYN) ; Post Extended Absences for a Pay Period (or day)
 ; This API auto posts all extended absences for a specific employee
 ; and pay period.  It is called during the creation of an employee time
 ; card when a new pay period is opened or when an employee timecard is
 ; added to an existing pay period.
 ;
 ; Input
 ;   PRSIEN - Employee IEN (file 450), should be PTP with active memo
 ;   PPI    - Pay Period IEN (file 458)
 ;   DAYN   - (optional) Day # within PPI to only post that day
 ;
 ; Note: Timecard is assumed to be locked prior to calling this API.
 ;
 N EAIEN,EAY0,PEREND,PERSTR,PPD1,PPD14,PRSX,TDT,Y
 S DAYN=$G(DAYN)
 ;
 ; Determine pay period dates
 S Y=$G(^PRST(458,PPI,1))
 S PRSX=$S(DAYN:DAYN,1:1) ; if passed use day# instead of 1st day in PP
 S PPD1=$P(Y,U,PRSX) ; 1st day of PP
 S PRSX=$S(DAYN:DAYN,1:14) ; if passed use day# instead of last day in PP
 S PPD14=$P(Y,U,PRSX) ; Last day of PP
 K PRSX
 Q:PPD1=""
 ;Q:PPD14<DT  ; EA only autoposted from curent date and forward
 ;
 ; loop thru extended absences for employee by reverse end date until
 ; end date is before the pay period or no more end dates
 S TDT=9999999 ; initial to date for loop
 F  S TDT=$O(^PRST(458.4,"AEE",PRSIEN,TDT),-1) Q:'TDT!(TDT<PPD1)  D
 . ; loop thru extended absences
 . S EAIEN=0
 . S EAIEN=$O(^PRST(458.4,"AEE",PRSIEN,TDT,EAIEN)) Q:'EAIEN  D
 . . S EAY0=$G(^PRST(458.4,EAIEN,0)) ; extended absense 0 node
 . . Q:$P(EAY0,U)>PPD14  ; skip if start date after pay period
 . . Q:$P(EAY0,U,6)'="A"  ; skip if status not active
 . . ;
 . . ; extended absence overlaps the pay period
 . . ; determine start and end dates to post as absence
 . . ;   period end is lesser of absence to date and PP end
 . . S PEREND=$S($P(EAY0,U,2)<PPD14:$P(EAY0,U,2),1:PPD14)
 . . ;Q:PEREND<DT  ; period ended before current day so can't auto post
 . . ;   period start is greater of absence from date and PP start
 . . S PERSTR=$S($P(EAY0,U)>PPD1:$P(EAY0,U),1:PPD1)
 . . ;I PERSTR<DT S PERSTR=DT ; don't auto post EA to days before current
 . . ;
 . . ; call API to post absence to appropriate ESR days
 . . D PEA(PRSIEN,PERSTR,PEREND)
 Q
 ;
CEA(PRSIEN,S1,E1,S2,E2) ; Update ESR when Extended Absence is changed
 ; This API updates the ESRs when the date range of an extended
 ; absence is changed.
 ;
 ; input
 ;   PRSIEN - Employee IEN (file 450)
 ;   S1     - old Start Date (FileMan internal)
 ;   E1     - old End Date (FileMan internal)
 ;   S2     - new Start Date (FileMan internal)
 ;   E2     - new End Date (FileMan internal)
 ;
 Q:'$G(PRSIEN)
 Q:'$G(S1)
 Q:'$G(E1)
 Q:'$G(S2)
 Q:'$G(E2)
 ;
 N X1,X2
 ;
 ; post/unpost impacted ranges
 ;
 ; if new start is less than old start then days from new start to
 ; lesser of new end and old start-1 were changed from not covered to
 ;  covered.
 I S2<S1 D
 . S X1=S2
 . S X2=$S(E2<(S1-1):E2,1:S1-1)
 . D PEA(PRSIEN,X1,X2)
 ;
 ; if new start is greater than old start then days from old start to
 ; lesser of old end and new start-1 were changed from covered to not
 ; covered.
 I S2>S1 D
 . S X1=S1
 . S X2=$S(E1<(S2-1):E1,1:S2-1)
 . D UEA(PRSIEN,X1,X2)
 ;
 ; if new end is greater than old end then days from greater of old
 ; end+1 and new start to new end were changed from not covered to
 ; covered.
 I E2>E1 D
 . S X1=$S(E1+1>S2:E1+1,1:S2)
 . S X2=E2
 . D PEA(PRSIEN,X1,X2)
 ;
 ; if new end is less than old end then days from greater of new end+1
 ; and old start to old end were changed from covered to not covered.
 I E2<E1 D
 . S X1=$S(E2+1>S1:E2+1,1:S1)
 . S X2=E1
 . D UEA(PRSIEN,X1,X2)
 ;
 Q
 ;
PEA(PRSIEN,PERSTR,PEREND) ; Post Extended Absence
 ; Called during open next pay period process (by PEAPP above) to post
 ;   one extended absence to a single pay period.
 ; Called by Enter option to post one new extended absence to all
 ;   opened pay periods.
 ; Called by Edit option (by CEA above) to post one extended
 ;   absence to all opened pay periods when an extended absence is
 ;   edited such that some days originally not covered by the absence
 ;   are now covered.
 ; Input
 ;   PRSIEN - Employee IEN (file 450)
 ;   PERSTR - Start of absence period to post (FileMan date)
 ;   PEREND - End of absence period to post (FileMan date)
 ; Output
 ;   None
 ;
 ; Note: All applicable timecards are assumed to be locked prior to
 ;       calling this API.
 ;
 Q:('$G(PRSIEN))!($G(PERSTR)'?7N)!($G(PEREND)'?7N)  ; required inputs
 N D1,DAY,EPP4Y,PP4Y,PPDN,PPDNB,PPDTB,PPDNE,PPDTE,PPE,PPI,PRSFDA,SPP4Y,Y
 ;
 ; determine starting and ending pay periods
 S D1=PERSTR D PP^PRSAPPU S SPP4Y=PP4Y
 S D1=PEREND D PP^PRSAPPU S EPP4Y=PP4Y
 Q:SPP4Y=""
 Q:EPP4Y=""
 ;
 ; loop thru pay periods
 S PP4Y=$O(^PRST(458,"AB",SPP4Y),-1) ; set initial value to previous PP
 F  S PP4Y=$O(^PRST(458,"AB",PP4Y)) Q:PP4Y=""!(PP4Y]EPP4Y)  D
 . S PPI=$O(^PRST(458,"AB",PP4Y,0))
 . ; quit if pay period not covered by memo
 . S D1=$P($G(^PRST(458,PPI,1)),U)
 . Q:$$MIEN^PRSPUT1(PRSIEN,D1)'>0
 . ;
 . ; determine begin and end day numbers within pay period
 . S Y=$G(^PRST(458,PPI,1))
 . ; begin day is greater of period start date and 1st PP day
 . S PPDTB=$S($P(Y,U,1)>PERSTR:$P(Y,U,1),1:PERSTR)
 . S PPDNB=$P($G(^PRST(458,"AD",PPDTB)),U,2) ; begin day number in PP
 . ; end day is lesser of period end date and last PP day
 . S PPDTE=$S(PEREND>$P(Y,U,14):$P(Y,U,14),1:PEREND)
 . S PPDNE=$P($G(^PRST(458,"AD",PPDTE)),U,2) ; end day number in PP
 . ;
 . ; loop thru applicable days in PP
 . S PPDN=PPDNB-1 ; initial PP day number for loop
 . F  S PPDN=$O(^PRST(458,PPI,"E",PRSIEN,"D",PPDN)) Q:'PPDN!(PPDN>PPDNE)  D
 . . ; skip day if not a scheduled tour
 . . Q:$P($G(^PRST(458,PPI,"E",PRSIEN,"D",PPDN,1)),U)=""
 . . ; skip day if regular time already posted to ESR
 . . Q:$G(^PRST(458,PPI,"E",PRSIEN,"D",PPDN,5))["RG"
 . . ; skip day if ESR already signed or approved
 . . Q:"^4^5^"[(U_$P($G(^PRST(458,PPI,"E",PRSIEN,"D",PPDN,7)),U)_U)
 . . ;
 . . ; mark ESR day as signed
 . . K PRSFDA
 . . S IENS=PPDN_","_PRSIEN_","_PPI_","
 . . S PRSFDA(458.02,IENS,146)="4" ; status = signed
 . . S PRSFDA(458.02,IENS,147)=$$NOW^XLFDT() ; signed d/t
 . . S PRSFDA(458.02,IENS,149)="2" ; signed method = extended absence
 . . D FILE^DIE("","PRSFDA") D MSG^DIALOG()
 ;
 Q
 ;
UEA(PRSIEN,PERSTR,PEREND) ; Unpost Extended Absence
 ; Called by Cancel option to unpost one new extended absence from
 ;   opened pay periods.
 ; Called by Edit option (by CEA above) to unpost one extended
 ;   absence to all opened pay periods when an extended absence is
 ;   edited such that some days originally covered by the absence
 ;   are now not covered.
 ; Input
 ;   PRSIEN - Employee IEN (file 450)
 ;   PERSTR - Start of absence period (FileMan date)
 ;   PEREND - End of absence period (FileMan date)
 ; Output
 ; 
 ; Note: All applicable timecards are assumed to be locked prior to
 ;       calling this API.
 ;
 Q:('$G(PRSIEN))!($G(PERSTR)'?7N)!($G(PEREND)'?7N)  ; required inputs
 N D1,DAY,EPP4Y,PP4Y,PPDN,PPDNB,PPDTB,PPDNE,PPDTE,PPE,PPI,PRSFDA,SPP4Y,Y
 ;
 ; determine starting and ending pay periods
 S D1=PERSTR D PP^PRSAPPU S SPP4Y=PP4Y
 S D1=PEREND D PP^PRSAPPU S EPP4Y=PP4Y
 Q:SPP4Y=""
 Q:EPP4Y=""
 ;
 ; loop thru pay periods
 S PP4Y=$O(^PRST(458,"AB",SPP4Y),-1) ; set initial value to previous PP
 F  S PP4Y=$O(^PRST(458,"AB",PP4Y)) Q:PP4Y=""!(PP4Y]EPP4Y)  D
 . S PPI=$O(^PRST(458,"AB",PP4Y,0))
 . ; quit if pay period not covered by memo
 . S D1=$P($G(^PRST(458,PPI,1)),U)
 . Q:$$MIEN^PRSPUT1(PRSIEN,D1)'>0
 . ;
 . ; determine begin and end day numbers within pay period
 . S Y=$G(^PRST(458,PPI,1))
 . ; begin day is greater of period start date and 1st PP day
 . S PPDTB=$S($P(Y,U,1)>PERSTR:$P(Y,U,1),1:PERSTR)
 . S PPDNB=$P($G(^PRST(458,"AD",PPDTB)),U,2) ; begin day number in PP
 . ; end day is lesser of period end date and last PP day
 . S PPDTE=$S(PEREND>$P(Y,U,14):$P(Y,U,14),1:PEREND)
 . S PPDNE=$P($G(^PRST(458,"AD",PPDTE)),U,2) ; end day number in PP
 . ;
 . ; loop thru applicable days in PP
 . S PPDN=PPDNB-1 ; initial PP day number for loop
 . F  S PPDN=$O(^PRST(458,PPI,"E",PRSIEN,"D",PPDN)) Q:'PPDN!(PPDN>PPDNE)  D
 . . ; skip day if not a scheduled tour
 . . Q:$P($G(^PRST(458,PPI,"E",PRSIEN,"D",PPDN,1)),U)=""
 . . ; skip day if regular time already posted to ESR
 . . Q:$G(^PRST(458,PPI,"E",PRSIEN,"D",PPDN,5))["RG"
 . . ; skip day if ESR not signed or approved
 . . Q:"^4^5^"'[(U_$P($G(^PRST(458,PPI,"E",PRSIEN,"D",PPDN,7)),U)_U)
 . . ; skip day if ESR was not auto signed by extended absence
 . . Q:$P($G(^PRST(458,PPI,"E",PRSIEN,"D",PPDN,7)),U,3)'=2
 . . ;
 . . ; if ESR status was approved then remove the time card day posting
 . . I $P($G(^PRST(458,PPI,"E",PRSIEN,"D",PPDN,7)),U)=5 S X=$$CLRTCDY^PRSPSAPU(PPI,PRSIEN,PPDN) K X
 . . ;
 . . ; update ESR day
 . . K PRSFDA
 . . S IENS=PPDN_","_PRSIEN_","_PPI_","
 . . S PRSFDA(458.02,IENS,146)=$S($TR($G(^PRST(458,PPI,"E",PRSIEN,"D",PPDN,5)),"^")'="":2,1:1) ; status = pending (if time posted) or not started
 . . S PRSFDA(458.02,IENS,147)="@" ; remove signed d/t stamp
 . . S PRSFDA(458.02,IENS,149)="@" ; remove last signed method
 . . D FILE^DIE("","PRSFDA") D MSG^DIALOG()
 ;
 Q
 ;
 ;PRSPEAA
