PRSPLVU ;WOIFO/SAB - LEAVE UTILITIES ;3/31/2005
 ;;4.0;PAID;**93**;Sep 21, 1995;Build 7
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 Q
 ;
LOADTOD(PPI,PRSIEN,DAY,TOD,TODD) ; Load Tour of Duty into TOD() Array
 ; input
 ;   PPI     - pay period IEN, file 458
 ;   PRSIEN  - employee IEN, file 450
 ;   DAY     - day number in PP
 ;   TOD     - array, passed by reference, will be initialized
 ;   TODD    - array, passed by reference, will be initialized
 ; output
 ;   TOD     - array updated with tour segments in following format
 ;             TOD(tour#-segment#)=
 ; start d/t (FM)^end d/t (FM)^type of time^start time(ETA)^end time(ETA)
 ; ^special code
 ;   TODD    - array updated with tour data in the following format
 ;             TODD(tour#)=
 ; earliest regular start d/t (FM)^latest regular end d/t (FM)^
 ; tour meal length (minutes)^segment # of longest regular tour segment 
 ;
 N FLD,NODE,PRSDT,PRSX,TN,TODI,TODY,TSC,TSE,TSI,TSLS,TSS,TST
 ;
 K TOD,TODD ; initialize array
 ;
 S PRSDT=$P($G(^PRST(458,PPI,1)),U,DAY)
 Q:'PRSDT
 ;
 ; loop thru both tours (#1 and #2) for the day
 F TN=1,2 D
 . S NODE=$S(TN=1:1,TN=2:4,1:"")
 . Q:NODE=""
 . S TODY=$G(^PRST(458,PPI,"E",PRSIEN,"D",DAY,NODE))
 . S TSLS(0)=0 ; init longest regular segment length (seconds)
 . ;
 . ; obtain the tour meal time
 . S FLD=$S(TN=1:2,1:10.3) ; field number corresponding to tour #1 or #2
 . S TODI=$$GET1^DIQ(458.02,DAY_","_PRSIEN_","_PPI_",",FLD,"I") ; tour of duty IEN
 . S:TODI $P(TODD(TN),U,3)=$$GET1^DIQ(457.1,TODI,2) ; tour meal (minutes)
 . ;
 . ; loop thru seven time segments of tour
 . F TSI=1:1:7 D
 . . S TSS=$P(TODY,U,(TSI-1)*3+1) ; time segment start
 . . Q:TSS=""
 . . S TSE=$P(TODY,U,(TSI-1)*3+2) ; time segment end
 . . Q:TSE=""
 . . S TSC=$P(TODY,U,(TSI-1)*3+3) ; time segment special code
 . . ; derive type of time
 . . S TST=$S(TSC:$P($G(^PRST(457.2,TSC,0)),U,2),1:"RG")
 . . ; convert times to FileMan date/time format
 . . S PRSX=$$CNVTS(PRSDT,TSS,TSE)
 . . Q:$P(PRSX,U)=""
 . . S TOD(TN_"-"_TSI)=$P(PRSX,U)_U_$P(PRSX,U,2)_U_TST_U_TSS_U_TSE_U_TSC
 . . ;
 . . ; skip remaining steps if segment is not regular time
 . . Q:TST'="RG"
 . . ;
 . . ; if earliest start time of tour is null, set it from current seg.
 . . S:$P($G(TODD(TN)),U)="" $P(TODD(TN),U)=$P(PRSX,U)
 . . ;
 . . ; if latest end time of tour is null, set it from current seg.
 . . S:$P($G(TODD(TN)),U,2)="" $P(TODD(TN),U,2)=$P(PRSX,U,2)
 . . ;
 . . ; if this segments start time is earlier, update the tour start
 . . I $P(PRSX,U)<$P(TODD(TN),U) S $P(TODD(TN),U)=$P(PRSX,U)
 . . ;
 . . ; if this segments end time is later, update the tour end
 . . I $P(PRSX,U,2)>$P(TODD(TN),U,2) S $P(TODD(TN),U,2)=$P(PRSX,U,2)
 . . ;
 . . ; compute length of the tour segment (seconds)
 . . S TSLS=$$FMDIFF^XLFDT($P(PRSX,U,2),$P(PRSX,U,1),2)
 . . ; if segment length more than longest found use it as longest found
 . . I TSLS>TSLS(0) S TSLS(0)=TSLS,$P(TODD(TN),U,4)=TSI
 Q
 ;
LOADESR(PPI,PRSIEN,DAY,ESR) ; Load ESR into ESR() Array
 ; input
 ;   PPI     - pay period IEN, file 458
 ;   PRSIEN  - employee IEN, file 450
 ;   DAY     - day number in PP
 ;   ESR     - array, passed by reference, will be initialized
 ; output
 ;   ESR     - array updated with tour segments in following format
 ;             ESR(segment #)=
 ; start d/t (FM)^end d/t (FM)^type of time^start time(ETA)^end time(ETA)
 ; ^meal (min)
 ;
 N ESRY,PRSDT,PRSX,TSE,TSI,TSM,TSS,TST
 ;
 K ESR ; initialize array
 ;
 S PRSDT=$P($G(^PRST(458,PPI,1)),U,DAY)
 Q:'PRSDT
 ;
 S ESRY=$G(^PRST(458,PPI,"E",PRSIEN,"D",DAY,5))
 ;
 ; loop thru seven time segments
 F TSI=1:1:7 D
 . S TSS=$P(ESRY,U,(TSI-1)*5+1) ; time segment start
 . Q:TSS=""
 . S TSE=$P(ESRY,U,(TSI-1)*5+2) ; time segment end
 . Q:TSE=""
 . S TST=$P(ESRY,U,(TSI-1)*5+3) ; time segment type of time
 . Q:TST=""
 . ; convert times to FileMan date/time format
 . S PRSX=$$CNVTS(PRSDT,TSS,TSE)
 . Q:$P(PRSX,U)=""
 . S TSM=$P(ESRY,U,(TSI-1)*5+5) ; time segment meal (min)
 . S ESR(TSI)=$P(PRSX,U)_U_$P(PRSX,U,2)_U_TST_U_TSS_U_TSE_U_TSM
 Q
 ;
LOADTC(PPI,PRSIEN,DAY,TC) ; Load Time Card into TC() Array
 ; input
 ;   PPI     - pay period IEN, file 458
 ;   PRSIEN  - employee IEN, file 450
 ;   DAY     - day number in PP
 ;   TC      - array, passed by reference, may contain data
 ; output
 ;   TC      - array updated with tour segments in following format
 ;             TC(segment #)=
 ; start d/t (FM)^end d/t (FM)^type of time^start time(ETA)^end time(ETA)
 ;
 N PRSDT,PRSX,TCY,TSE,TSI,TSS
 ;
 K TC ; initialize array
 ;
 S PRSDT=$P($G(^PRST(458,PPI,1)),U,DAY)
 Q:'PRSDT
 ;
 S TCY=$G(^PRST(458,PPI,"E",PRSIEN,"D",DAY,2))
 ;
 ; loop thru seven tour segments
 F TSI=1:1:7 D
 . S TSS=$P(TCY,U,(TSI-1)*3+1) ; time segment start
 . Q:TSS=""
 . S TSE=$P(TCY,U,(TSI-1)*3+2) ; time segment end
 . Q:TSE=""
 . S TST=$P(TCY,U,(TSI-1)*3+3) ; time segment type of time
 . Q:TST=""
 . ; convert times to FileMan date/time format
 . S PRSX=$$CNVTS(PRSDT,TSS,TSE)
 . Q:$P(PRSX,U)=""
 . S TC(TSI)=$P(PRSX,U)_U_$P(PRSX,U,2)_U_TST_U_TSS_U_TSE
 Q
 ;
OKALVR(LVIEN) ; OK Approve Leave Request
 ; Called by Supervisory Approvals to see if it is OK to approve a
 ; leave request
 ; Input
 ;   LVIEN  - Leave Request IEN (file 458.1)
 ; Result
 ;   string value
 ;     = 1 if OK to approve leave request
 ;     = 0 or 0^PPI if not OK to approve leave request
 ;       where PPI is the Pay Period ien (file 458)
 ;
 N D1,DAY,EPP4Y,LVY0,PP4Y,PPE,PPI,PRSIEN,PRSRET,SPP4Y,Y
 ;
 S PRSRET=1 ; initialize as OK
 ;
 I '$G(LVIEN) S PRSRET=0 Q PRSRET ; required input
 ;
 S LVY0=$G(^PRST(458.1,LVIEN,0)) ; leave request 0 node
 S PRSIEN=$P(LVY0,U,2) ; employee IEN
 ;
 ; if employee has any memos
 I $$PTP^PRSPUT3(PRSIEN) D
 . ; determine starting and ending pay periods
 . S D1=$$FMADD^XLFDT($P(LVY0,U,3),-1) D PP^PRSAPPU S SPP4Y=PP4Y ; based on leave from -1 (use -1 in case of 2-day tour)
 . S D1=$P(LVY0,U,5) D PP^PRSAPPU S EPP4Y=PP4Y ; based on leave to
 . ;
 . ; loop thru pay periods
 . S PP4Y=$O(^PRST(458,"AB",SPP4Y),-1) ; set initial value to previous PP
 . F  S PP4Y=$O(^PRST(458,"AB",PP4Y)) Q:PP4Y=""!(PP4Y]EPP4Y)  D  Q:'PRSRET
 . . S PPI=$O(^PRST(458,"AB",PP4Y,0))
 . . ;
 . . ; skip PP if not covered by memo
 . . S D1=$P($G(^PRST(458,PPI,1)),U)
 . . Q:$$MIEN^PRSPUT1(PRSIEN,D1)'>0  ; PP not covered by memo
 . . ;
 . . ; skip PP if time card status not = payroll
 . . Q:$P($G(^PRST(458,PPI,"E",PRSIEN,0)),U,2)'="P"
 . . ;
 . . ; can't approve this leave request until time card status changes
 . . S PRSRET=0_U_PPI
 ;
 Q PRSRET
 ;
CNVTS(DATE,START,END) ; Convert Time Segment
 ; input
 ; returns string with value =
 ;   Start Date/Time (FileMan internal)^End Date/Time (FileMan internal)
 ;
 N CNX,FMEND,FMSTR,PRSM,PRSRET,X,XMID,Y
 S X=START_U_END
 D CNV^PRSATIM
 S PRSM=Y
 S XMID=$S($P(PRSM,U,2)'>$P(PRSM,U):1,1:0)
 S FMSTR=$$FMADD^XLFDT(DATE,,,$P(PRSM,U))
 S FMEND=$$FMADD^XLFDT(DATE,XMID,,$P(PRSM,U,2))
 S PRSRET=FMSTR_"^"_FMEND
 ;
 Q PRSRET
 ;
FMETA(TIME) ; FileMan to ETA time
 N HRS,MIN,PM,PRSRET
 S PRSRET=""
 S TIME=$$LJ^XLFSTR(TIME,4,"0") ; add trailing 0s to fileman time
 I TIME=1200 S PRSRET="NOON"
 I TIME=2400 S PRSRET="MID"
 I PRSRET="" D
 . S PM=0
 . S HRS=$E(TIME,1,2)
 . S MIN=$E(TIME,3,4)
 . I HRS>12 S HRS=HRS-12,PM=1
 . S PRSRET=$$RJ^XLFSTR(HRS,2,"0")_":"_$$RJ^XLFSTR(MIN,2,"0")_$S(PM:"P",1:"A")
 Q PRSRET
 ;PRSPLVU
