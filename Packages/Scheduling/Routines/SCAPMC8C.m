SCAPMC8C ;BP/DJB - Convert Practitioners List to PCP/AP ; 8/4/00 2:28pm
 ;;5.3;Scheduling;**177,224**;AUG 13, 1993
 ;;1.0
 ;
PRTPC(SCTP,SCDATES,SCLIST,SCERR,SCALLHIS,ADJUSTDT) ;Convert list of providers
 ;for a position, to a list of PROV-U/PROV-P/PRECs.
 ;       PROV-U - Unprecepted provider  (PCP)
 ;       PROV-P - Precepted provider    (AP)
 ;       PREC   - Preceptor             (PCP)
 ;
 ; Input:
 ;  SCTP    - IEN of TEAM POSITION [required]
 ;  SCDATES - See PRTP^SCAPMC8
 ;  SCLIST  - Array NAME for output
 ;  SCERR   - Array NAME to store error messages.
 ;            Example: ^TMP("ORXX",$J).
 ; SCALLHIS - 1: Return unfiltered sub-array in SCLIST
 ; ADJUSTDT - 1:Adjust Start/End dates if provider if is both
 ;              precepted & unprecepted for different times periods.
 ;
 ;Output:
 ;  SCLIST(scn,"PROV-U"/"PROV-P"/"PREC",n) = array of practitioners
 ;            Format: See PRTP^SCAPMC8
 ;  SCERR() - See PRTP^SCAPMC8
 ;
 ;Returned: 1 if ok, 0 if error
 ;
 NEW RESULT,PRTPC
 ;
 S ADJUSTDT=$G(ADJUSTDT)
 ;
 ;Get list of practioners for a team position.
 S RESULT=$$PRTP^SCAPMC(.SCTP,.SCDATES,"PRTPC",.SCERR,1,.SCALLHIS)
 I 'RESULT G QUIT
 I '$D(PRTPC(0)) G QUIT
 ;
 D ADJUST ;Process returned array
QUIT Q RESULT
 ;
ADJUST ;Convert returned array to PROV-P/PROV-U/PREC array.
 ;Adjust Start/End dates if provider is both precepted & unprecepted.
 ;
 NEW DATA,DATA1,ID,NUM,NUM1
 NEW ADJEDATE,ADJSDATE,EDATE,SDATE,SDATE1
 ;
 ;Loop thru array
 S NUM=0
 F  S NUM=$O(PRTPC(NUM)) Q:'NUM  D  ;
 . KILL SDATE ;Initialize SDATE array
 . S DATA=$G(PRTPC(NUM))
 . ;If no preceptor nodes set PCP node.
 . ;Place a zero in "404.53 IEN" subscript.
 . S ID=$P(DATA,U,11)_"-0-PCP"
 . I '$D(PRTPC(NUM,"PR")) S @SCLIST@(NUM,"PROV-U",ID)=DATA Q
 . S SDATE=$P(DATA,U,9) ;...Position History Start Date
 . S EDATE=$P(DATA,U,10) ;..Position History End Date
 . ;
 . ;Loop thru "PR" nodes to find preceptor
 . S NUM1=0
 . F  S NUM1=$O(PRTPC(NUM,"PR",NUM1)) Q:'NUM1  D  ;
 . . S DATA1=$G(PRTPC(NUM,"PR",NUM1))
 . . ;Compare piece 9 & piece 14. Use later date.
 . . ;   Piece 9  - Date provider assigned
 . . ;   Piece 14 - Date position assigned.
 . . S SDATE1=$P(DATA1,U,9)
 . . I $P(DATA1,U,14)>SDATE1 S SDATE1=$P(DATA1,U,14)
 . . ;Set temp array to later find earliest preceptor Start Date.
 . . ;
 . . ;alb/rpm;Patch 224;Filter preceptors outside requested date range
 . . Q:'$$DTCHK^SCAPU1(@SCDATES@("BEGIN"),@SCDATES@("END"),0,SDATE1,$P(DATA1,U,10))
 . . ;
 . . I SDATE1 S SDATE(SDATE1)=""
 . . ;
 . . ;Set preceptor as PCP.
 . . S ID=$P(DATA1,U,11)_"-"_$P(DATA1,U,16)_"-PCP"
 . . S @SCLIST@(NUM,"PREC",ID)=DATA1
 . . Q
 . ;Get earliest preceptor Start Date
 . S SDATE1=$O(SDATE(0))
 . ;
 . ;If position date is not earlier than preceptor date, it's all AP.
 . S ID=$P(DATA,U,11)_"-0-AP"
 . I SDATE'<SDATE1 S @SCLIST@(NUM,"PROV-P",ID)=DATA Q
 . ;
 . ;If postion Start/End Dates are both earlier than preceptor date,
 . ;then it's all PCP.
 . S ID=$P(DATA,U,11)_"-0-PCP"
 . I EDATE,EDATE<SDATE1 S @SCLIST@(NUM,"PROV-U",ID)=DATA Q
 . ;
 . ;Set PCP and AP portions
 . ;
 . ;Set PCP portion
 . S ID=$P(DATA,U,11)_"-0-PCP"
 . S ADJSDATE=SDATE ;.....................Adjusted Start Date
 . S ADJEDATE=$$FMADD^XLFDT(SDATE1,-1) ;..Adjusted End Date
 . I ADJUSTDT S $P(DATA,U,10)=ADJEDATE ;..Adjust End Date
 . D  ;After AP/PCP split, recheck Start/End Dates.
 . . I ADJSDATE,ADJSDATE>@SCDATES@("END") Q  ;
 . . I ADJEDATE,ADJEDATE<@SCDATES@("BEGIN") Q  ;
 . . S @SCLIST@(NUM,"PROV-U",ID)=DATA
 . ;
 . ;Set AP portion
 . S ID=$P(DATA,U,11)_"-0-AP"
 . S ADJSDATE=SDATE1 ;..Adjusted Start Date
 . I $P(DATA,U,15),$P(DATA,U,15)<EDATE S EDATE=$P(DATA,U,15)
 . S ADJEDATE=EDATE ;...Adjusted End Date
 . I ADJUSTDT D  ;......Adjust Start/End dates
 . . S $P(DATA,U,9)=ADJSDATE
 . . S $P(DATA,U,10)=ADJEDATE
 . D  ;After AP/PCP split, recheck Start/End Dates.
 . . I ADJSDATE,ADJSDATE>@SCDATES@("END") Q  ;
 . . I ADJEDATE,ADJEDATE<@SCDATES@("BEGIN") Q  ;
 . . S @SCLIST@(NUM,"PROV-P",ID)=DATA
 ;
 Q
