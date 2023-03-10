PSXRPPL2 ;BIR/WPB - Print From Suspense Utilities ;06/10/08
 ;;2.0;CMOP;**65,69,73,74,79,81,83,87,91,92,93**;11 Apr 97;Build 12
 ; Reference to ^PSRX( in ICR #1977
 ; Reference to ^PS(52.5, in ICR #1978
 ; Reference to ^PSSLOCK  in ICR #2789
 ; Reference to ^PSOBPSUT in ICR #4701
 ; Reference to ^PSOBPSU1 in ICR #4702
 ; Reference to ^PSOBPSU2 in ICR #4970
 ; Reference to ^PSOBPSU4 in ICR #7212
 ; Reference to ^PSOREJUT in ICR #4706
 ; Reference to ^PSOREJU3 in ICR #5186
 ; Reference to CHANGE^PSOSUCH1 in ICR #5427
 ; Reference to PREVRX^PSOREJP2 in ICR #5912
 ; Reference to $$BILLABLE^IBNCPDP in ICR #6243
 ; Reference to LOG^BPSOSL in ICR #6764
 ; Reference to IEN59^BPSOSRX in ICR #4412
 ;
 ; CHKDFN makes a second pass through the suspense queue, looking for
 ; any additional prescriptions for patients who already have an Rx
 ; included in the current batch.  To accomplish this, it loops through
 ; all the patients in the batch - ^PSX(550.2,Batch,15,"C",Name,DFN) -
 ; and then loops through the suspense queue, starting with the day
 ; after the through date used by SBTECME^PSXRPPL1 and going through
 ; that date plus the 'look ahead' date in the site parameters (see
 ; DRIV^PSXRSUS).  The logic inside the loops is largely identical to
 ; that in SBTECME^PSXRPPL1.
 ;
CHKDFN(THRDT) ;
 ;Input: THRDT - THROUGH DATE to run CMOP transmission
 ;
 ; This procedure assumes the following variables to exist:
 ;   PRTDT = Transmit/Print data through this date
 ;   PSXBAT = Batch, pointer to file#550.2, CMOP Transmission
 ;   PSXDTRG = Pull ahead through date
 ;   PSXTDIV = Division
 ;   PSXTYP = "C" if running for Controlled Substance, "N" otherwise
 ;
 N PSOLRX,PSXPTNM,REC,RESP,RFL,RX,SBTECME,SDT,XDFN
 ;
 ; If there are no prescriptions in the current batch, then Quit.
 ;
 I '$D(^PSX(550.2,PSXBAT,15,"C")) Q
 ;
 S SBTECME=0
 K ^TMP("PSXEPHDFN",$J)
 S PSXPTNM=""
 F  S PSXPTNM=$O(^PSX(550.2,PSXBAT,15,"C",PSXPTNM)) Q:PSXPTNM=""  D
 . S XDFN=0
 . F  S XDFN=$O(^PSX(550.2,PSXBAT,"15","C",PSXPTNM,XDFN)) Q:(XDFN'>0)  D
 . . S SDT=PRTDT
 . . F  S SDT=$O(^PS(52.5,"CMP","Q",PSXTYP,PSXTDIV,SDT)) Q:(SDT>PSXDTRG)!(SDT="")  D
 . . . S REC=0
 . . . F  S REC=$O(^PS(52.5,"CMP","Q",PSXTYP,PSXTDIV,SDT,XDFN,REC)) Q:REC'>0  D
 . . . . S (PSOLRX,RX)=+$$GET1^DIQ(52.5,REC,.01,"I") I 'RX Q
 . . . . S RFL=$$GET1^DIQ(52.5,REC,9,"I") I RFL="" S RFL=$$LSTRFL^PSOBPSU1(RX)
 . . . . I $$XMIT^PSXBPSUT(REC) D
 . . . . . I SDT>THRDT,'$D(^TMP("PSXEPHDFN",$J,XDFN)) Q
 . . . . . I $$PATCH^XPDUTL("PSO*7.0*148") D
 . . . . . . I $$RETRX^PSOBPSUT(RX,RFL),SDT>DT Q
 . . . . . . I $$DOUBLE^PSXRPPL1(RX,RFL) Q
 . . . . . . I $$FIND^PSOREJUT(RX,RFL,,"79,88,943",,1) Q
 . . . . . . ;
 . . . . . . ; If TRI/CVA and the Rx already has a closed eT/eC
 . . . . . . ; pseudo-reject, then do not send another claim.
 . . . . . . ;
 . . . . . . I $$TRICVANB^PSXRPPL1(RX,RFL) D  Q
 . . . . . . . D LOG^BPSOSL($$IEN59^BPSOSRX(RX,RFL),$T(+0)_"-CHKDFN, $$TRICVANB returned 1")  ; ICR #4412,6764
 . . . . . . ;
 . . . . . . I '$$RETRX^PSOBPSUT(RX,RFL),$$ECMESTAT(RX,RFL) Q
 . . . . . . I $$PATCH^XPDUTL("PSO*7.0*289"),'$$DUR(RX,RFL),'$$DSH(REC,1) Q
 . . . . . . ;
 . . . . . . ; ECMESND^PSOBPSU1 initiates the claim submission process.
 . . . . . . ;
 . . . . . . D ECMESND^PSOBPSU1(RX,RFL,"","PC",,1,,,,.RESP)
 . . . . . . ;
 . . . . . . D LOG^BPSOSL($$IEN59^BPSOSRX(RX,RFL),$T(+0)_"-CHKDFN, RESP="_$G(RESP))  ; ICR #4412,6764
 . . . . . . ;
 . . . . . . I $G(RESP)'["IN PROGRESS",$$PATCH^XPDUTL("PSO*7.0*287"),$$TRISTA^PSOREJU3(RX,RFL,.RESP,"PC") S ^TMP("PSXEPHNB",$J,RX,RFL)=$G(RESP)
 . . . . . . ;
 . . . . . . I $D(RESP),'RESP S SBTECME=SBTECME+1
 . . . . . . S ^TMP("PSXEPHDFN",$J,XDFN)=""
 . . . . D PSOUL^PSSLOCK(PSOLRX)
 K ^TMP("PSXEPHDFN",$J)
 I SBTECME>0 H 60+$S((SBTECME*15)>7200:7200,1:(SBTECME*15))
 Q
 ;
 ; EPHARM is called only by GETDATA^PSXRPPL.  The variable EPHQT is
 ; Newed in GETDATA.  If EPHQT is set to 1 here, then GETDATA does
 ; not continue processing the current Rx/Fill; this Rx/Fill will
 ; not be sent to CMOP if EPHQT is set to 1 here.
 ;
EPHARM ; - ePharmacy checks for third party billing
 ;
 ; If CMOP is still processing the previous fill ($$DOUBLE), or if the
 ; RE-TRANSMIT flag is 'Yes' and the send date is in the future, or if
 ; this prescription has an unresolved 79,88,943, or RRR reject, then
 ; Set EPHQT to 1 and Quit.  This Rx/Fill will not be sent to CMOP.
 ;
 I $$DOUBLE^PSXRPPL1(RXN,RFL) S EPHQT=1 Q
 I $$RETRX^PSOBPSUT(RXN,RFL),SDT>DT S EPHQT=1 Q
 I $$FIND^PSOREJUT(RXN,RFL,,"79,88,943",,1) S EPHQT=1 Q
 ;
 ; If an Open/Unresolved eC/eT reject on claim, don't send to CMOP.
 I $$ECETREJ(RXN) D EPH Q
 ;
 ; $$TRISTA performs checks specific to TRICARE/CHAMPVA.  If the claim
 ; was rejected or is still "IN PROGRESS", or if it is non-billable,
 ; then add this Rx to the ^TMP("PSXEPHIN") array and quit.
 ;
 I $$PATCH^XPDUTL("PSO*7.0*287"),$$TRISTA^PSOREJU3(RXN,RFL,.RESP,"PC") D EPH Q
 I $$PATCH^XPDUTL("PSO*7.0*287"),$D(^TMP("PSXEPHNB",$J,RXN,RFL)) D EPH Q
 ;
 ; If the claim is still "IN PROGRESS", then add this Rx to the
 ; ^TMP("PSXEPHIN") array and quit.
 ;
 I $$STATUS^PSOBPSUT(RXN,RFL)="IN PROGRESS" D EPH Q
 ;
 ; If this Prescription violates the 3/4 supply (i.e. if it is too soon
 ; to refill), then Set EPHQT to 1 and Quit.  This Rx/Fill will not be
 ; sent to CMOP.
 ;
 I $$PATCH^XPDUTL("PSO*7.0*289"),'$$DSH(REC,0) D  S EPHQT=1 Q
 . D LOG^BPSOSL($$IEN59^BPSOSRX(RXN,RFL),$T(+0)_"-EPHARM, Failed DSH")  ; ICR #4412,6764
 ;
 ; If there is a host reject for this Rx/Fill, then add this Rx to the
 ; ^TMP("PSXEPHIN") array and quit.
 ;
 I $$PATCH^XPDUTL("PSO*7.0*289"),'$$DUR(RXN,RFL) D EPH Q
 Q
 ;
 ; EPH is called only by EPHARM, above.  It adds a prescriptions to the
 ; ^TMP("PSXEPHIN") array.  Of those Prescriptions not sent to the CMOP
 ; facility and left in the suspense queue, some are added to this
 ; array.  Those in this array will be listed in the email sent to users
 ; indicating that they were left in the queue (see ^PSXBPSMS).  That
 ; email states these Rxs were not transmitted to the CMOP facility
 ; because either a) a response from the payer was not received, or b)
 ; the Rx is non-billable.
 ;
EPH ; - Store Rx not xmitted to CMOP in XTMP file for MailMan message.
 S ^TMP("PSXEPHIN",$J,$$RXSITE^PSOBPSUT(RXN),RXN)=RFL,EPHQT=1
 Q
 ;
 ; ECMESTAT checks the Rx's ECME Status to determine if it's acceptable
 ; to resubmit based on reject codes associated with a previous
 ; submission.  If Rx was rejected with host reject errors, and no other
 ; rejects exist, then it's OK to resubmit to ECME.
 ;Input: RX = Prescription file #52 IEN
 ; RFL = Refill number
 ;Returns: 1 = OK to resubmit
 ;0 = Don't resubmit
 ;
ECMESTAT(RX,RFL) ;
 I '$$PATCH^XPDUTL("PSO*7.0*148") Q 0
 N CHDAT,HERR,PSXECET,PSXIEN,PSXREJ,STATUS
 ;
 ; If an Open/Unresolved eC/eT reject on claim, don't resubmit
 I $$ECETREJ(RX) Q 0
 ;
 S STATUS=$$STATUS^PSOBPSUT(RX,RFL)
 ; Never submitted before, OK to resubmit
 I STATUS=""!(STATUS["UNSTRANDED") Q 1
 ; If status other than E REJECTED, don't resubmit
 I STATUS'="E REJECTED" Q 0
 ; check for a previous host reject:
 ;  1 - if host reject date expired allow to print; 0 - if not expired don't print
 ;    2 - if not defined allow to continue with evaluation for new host reject
 S CHDAT=$$CHHEDT(RX,RFL) Q:CHDAT=1 1 Q:CHDAT=0 0
 ;*****************************************************************************************************
 ;   NOTE: MAKE SURE THAT IGNORED REJECTS WILL PROCESS WHENEVER MODIFICATIONS ARE MADE TO HOST REJECT 
 ;         Ignored rejects are handled by default when this subroutine Q 0 at the end.
 ;*****************************************************************************************************
 ; check host rejects
 S HERR=$$HOSTREJ(RX,RFL,0)
 I HERR&(CHDAT=2) D SHDTLOG(RX,RFL) Q 0  ;Host reject and no suspense hold date defined yet; define it and don't resubmit
 I HERR&(CHDAT) Q 1  ;Host reject & suspense hold date has expired; resubmit
 Q 0  ;NOTE - IF YOU CHANGE THIS Q 0, IGNORED REJECTS WILL RESUBMIT AND REJECT AGAIN WHICH IS VERY BAD.
 ;
 ; DSH determines whether a prescription has a 3/4 days supply hold
 ; condition.
 ;   Input: REC = Pointer to Suspense file (#52.5)
 ;          ACT = 1 or 0, indicating whether an entry should be made
 ;                in the activity log if the 3/4 logic is bypassed.
 ;   Returns: 1 or 0
 ;     1 (one) if 3/4 of days supply has elapsed.
 ;     0 (zero) if 3/4 of days supply has not elapsed.
 ;
DSH(REC,ACT) ;ePharmacy API to check for 3/4 days supply hold
 ;
 N COMM,DA,DAYSSUP,DIE,DR,DSHDT,DSHOLD
 N PREVRX,PSARR,PSINSUR,PSXCOMMENT,RFL,RXIEN,SDT,SFN,SHDT
 ;
 S DSHOLD=1
 S RXIEN=$$GET1^DIQ(52.5,REC,.01,"I")
 S RFL=$$GET1^DIQ(52.5,REC,9,"I")
 I RFL="" S RFL=$$LSTRFL^PSOBPSU1(RXIEN)
 ;
 ; If the Rx/Fill is not e-billable, then Quit out.
 ;
 I '$$EBILLABLE^PSOSULB2(RXIEN,RFL) Q DSHOLD
 ;
 ; If the Bypass 3/4 Day Supply flag is set to "YES", then Quit with
 ; 1 after adding a comment to the Activity Log.
 ;
 I $$FLAG^PSOBPSU4(RXIEN,RFL)="YES" D  Q DSHOLD  ; ICR #7212
 . I '$G(ACT) Q
 . S PSXCOMMENT="3/4 Day Supply logic bypassed during CMOP processing"
 . D RXACT^PSOBPSU2(RXIEN,RFL,PSXCOMMENT,"S",DUZ)
 . Q
 ;
 S DSHDT=$$DSHDT(RXIEN,RFL) ; 3/4 of days supply date
 S PREVRX=$P(DSHDT,U,2)
 S DSHDT=$P(DSHDT,U)
 I DSHDT>DT S DSHOLD=0 D
 . I DSHDT'=$$GET1^DIQ(52.5,REC,10,"I") D  ; Update Suspense Hold Date and Activity Log
 . . ; If a previous Rx is used in the 3/4 days' supply calculation,
 . . ; capture that Rx in the activity log.
 . . S COMM="3/4 of Days Supply SUSPENSE HOLD until "_$$FMTE^XLFDT(DSHDT,"2D")
 . . I PREVRX'="" S COMM=COMM_" (prior Rx "_PREVRX_")"
 . . S COMM=COMM_"."
 . . S DAYSSUP=$$LFDS(RXIEN)
 . . D RXACT^PSOBPSU2(RXIEN,RFL,COMM,"S",+$G(DUZ)) ; Update Activity Log
 . . S DR="10///^S X=DSHDT",DIE="^PS(52.5,",DA=REC D ^DIE ; File Suspense Hold Date
 . . N DA,DIE,DR,PSOX,SFN,INDT,DEAD,SUB,XOK,OLD
 . . S DA=REC,DIE="^PS(52.5,",DR=".02///"_DSHDT D ^DIE
 . . S SFN=REC,DEAD=0,INDT=DSHDT D CHANGE^PSOSUCH1(RXIEN,RFL)
 . . Q
 . Q
 ;
 Q DSHOLD
 ;
DSHDT(RXIEN,RFL) ; ePharmacy function to determine the 3/4 of the days supply date
 ; Input: RXIEN = Prescription file #52 ien
 ;          RFL = fill#
 ; Returns: DATE value of last date of service plus 3/4 of days supply
 ;         PREVRX = Previous Rx if PREVRX^PSOREJP2 identified one that
 ;                  should be used in the 3/4 days' supply calculation.
 ;
 N FILLDT,DAYSSUP,DSH34,PREVRX
 I '$D(^PSRX(RXIEN,0)) Q -1
 I $G(RFL)="" Q -1
 ;
 D PREVRX^PSOREJP2(RXIEN,RFL,,.FILLDT,.DAYSSUP,.PREVRX)
 I FILLDT="" Q -1
 ;
 S DSH34=DAYSSUP*.75 ; 3/4 of Days Supply
 S:DSH34["." DSH34=(DSH34+1)\1
 ; Return last date of service plus 3/4 of Days Supply date
 ; and the previous Rx used in the calculation, if any.
 Q $$FMADD^XLFDT(FILLDT,DSH34)_U_PREVRX
 ;
 ; LFDS returns the DAYS SUPPLY for the latest fill for a prescription.
 ; Input: RXIEN = Prescription file #52 IEN
 ; Returns: DAYS SUPPLY for the latest fill
 ;          -1 if RXIEN is not valid
LFDS(RXIEN) ;
 N RXFIL
 Q:'$D(^PSRX(RXIEN)) -1
 S RXFIL=$$LSTRFL^PSOBPSU1(RXIEN)
 Q $S(RXFIL=0:$P(^PSRX(RXIEN,0),U,8),1:$P(^PSRX(RXIEN,1,RXFIL,0),U,10))
 ;
 ; DUR checks for host errors and the suspense hold date.
 ; Input:
 ;   RX = Prescription file #52 IEN
 ;  RFL = Refill number
 ; Returns: A value of 0 (zero) will be returned when reject code M6,
 ; M8, NN, or 99 are present OR if on susp hold which means the
 ; prescription should not be sent to CMOP.
 ; Otherwise, a value of 1(one) will be returned.
DUR(RX,RFL) ;
 N REJ,IDX,TXT,CODE,SHCODE,SHDT,CHDAT1
 S IDX=""
 I '$D(RFL) S RFL=$$LSTRFL^PSOBPSU1(RX)
 ;
 ; check for a previous host reject:
 ;  0 - host reject date not expired; don't print
 ;  1 - host reject date expired; allow to print
 ;  2 - host reject not define; allow to continue with evaluation
 ;      for new host reject
 S CHDAT1=$$CHHEDT(RX,RFL)
 I CHDAT1=1 Q 1
 I CHDAT1=0 Q 0
 ;
 ; If a host reject exists and no previous Susp Hold Date or log entry,
 ;    create the log entry and hold rx/fill.
 S HERR=$$HOSTREJ(RX,RFL,1)
 I HERR,SHDT="" D SHDTLOG(RX,RFL)
 I HERR Q 0
 Q 1
 ;
CHHEDT(RX,RFL) ;
 ; RX = Prescription File IEN
 ; RFL = Refill
 ;Returns: 
 ; 0 = host reject date not expired
 ; 1 = host reject has expired
 ; 2 = host reject not defined 
 ;
 S SHDT=$$SHDT(RX,RFL) ; Get suspense hold date for rx/refill
 I SHDT'="" Q:DT'<SHDT 1 Q 0
 Q 2
 ;
 ; HOSTREJ checks an RX/FILL for Host Reject Errors returned from
 ; previous ECME submissions.  The host reject errors checked are M6,
 ; M8, NN, and 99.  Host reject errors do not pass to the pharmacy
 ; worklist so it's necessary to check ECME for these type errors.
 ; Input: 
 ;    RX = Prescription File IEN
 ;   RFL = Refill
 ;   ONE = Either 1 or 0 - Defaults to 1
 ;     If 1, At least ONE reject code associated with the RX/FILL must 
 ;     match either M6, M8, NN, or 99.
 ;     If 0, ALL reject codes must match either M6, M8, NN, or 99
 ; Return:
 ;  RETV = 1 OR 0
 ;     1 = host reject exists based on ONE parameter
 ;     0 = no host rejects exists based on ONE parameter
HOSTREJ(RX,RFL,ONE) ;
 N REJ,IDX,TXT,CODE,HRCODE,HRQUIT,RETV
 S IDX="",(RETV,HRQUIT)=0
 I ONE="" S ONE=1
 D DUR1^BPSNCPD3(RX,RFL,.REJ) ; Get reject list from last submission
 F  S IDX=$O(REJ(IDX)) Q:IDX=""  D  Q:HRQUIT
 . S TXT=$G(REJ(IDX,"REJ CODE LST"))
 . F I=1:1:$L(TXT,",") S CODE=$P(TXT,",",I) D  Q:HRQUIT
 . . F HRCODE="M6","M8","NN",99 D  Q:HRQUIT
 . . . I CODE=HRCODE S RETV=1 I ONE S HRQUIT=1 Q
 . . . I CODE'=HRCODE,RETV=1 S RETV=0,HRQUIT=1 Q
 Q RETV
 ;
 ; SHDTLOG sets the EPHARMACY SUSPENSE HOLD DATE field for the rx or
 ; refill to tomorrow and adds an entry to the SUSPENSE Activity Log.
 ; Input:  RX = Prescription File IEN
 ;        RFL = Refill
SHDTLOG(RX,RFL) ;
 N DA,DIE,DR,COMM,SHDT
 I '$D(RFL) S RFL=$$LSTRFL^PSOBPSU1(RX)
 S SHDT=$$FMADD^XLFDT(DT,1)
 S COMM="SUSPENSE HOLD until "_$$FMTE^XLFDT(SHDT,"2D")_" due to host reject error."
 I RFL=0 S DA=RX,DIE="^PSRX(",DR="86///"_SHDT D ^DIE
 E  S DA=RFL,DA(1)=RX,DIE="^PSRX("_DA(1)_",1,",DR="86///"_SHDT D ^DIE
 D RXACT^PSOBPSU2(RX,RFL,COMM,"S",+$G(DUZ)) ; Create Activity Log entry
 Q
 ;
 ; SHDT returns the EPHARMACY SUSPENSE HOLD DATE field for the rx or
 ; the refill
 ; Input:  RX = Prescription File IEN
 ;        RFL = Refill
SHDT(RX,RFL) ;
 N FILE,IENS
 I '$D(RFL) S RFL=$$LSTRFL^PSOBPSU1(RX)
 S FILE=$S(RFL=0:52,1:52.1),IENS=$S(RFL=0:RX_",",1:RFL_","_RX_",")
 Q $$GET1^DIQ(FILE,IENS,86,"I")
 ;
 ;
 ; ECETREJ checks for open/unresolved eC/eT reject on the Rx
 ; Input: (r) RX - Prescription IEN
 ; Output: 0 - No open/unresovled eC/eT Reject on Rx
 ;         1 - Open/unresolved eC/eT Reject on Rx
ECETREJ(RX) ;
 N PSXECET,PSXIEN,PSXREJ
 S PSXREJ=0
 F PSXECET="eC","eT" S PSXIEN="" D
 . F  S PSXIEN=$O(^PSRX(RX,"REJ","B",PSXECET,PSXIEN)) Q:'PSXIEN  D
 . . I $$GET1^DIQ(52.25,PSXIEN_","_RX,9,"I")=0 S PSXREJ=1
 Q PSXREJ
 ;
