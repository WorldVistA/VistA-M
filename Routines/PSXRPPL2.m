PSXRPPL2 ;BIR/WPB - Print From Suspense Utilities ;06/10/08
 ;;2.0;CMOP;**65,69**;11 Apr 97;Build 60
 ;Reference to ^PSRX( supported by DBIA #1977
 ;Reference to ^PS(52.5, supported by DBIA #1978
 ;Reference to ^PSSLOCK  supported by DBIA #2789
 ;Reference to ^PSOBPSUT supported by DBIA #4701
 ;Reference to ^PSOBPSU1 supported by DBIA #4702
 ;Reference to ^PSOBPSU2 supported by DBIA #4970
 ;Reference to ^PSOREJUT supported by DBIA #4706
 ;Reference to ^PSOREJU3 supported by DBIA #5186
 ;Reference to $$DEA^IBNCPDP controlled subscription by IA 4299
 ;Reference to CHANGE^PSOSUCH1 suppored by DBIA #5427
 ;
CHKDFN(THRDT) ; use the patient 'C' index under RX multiple in file 550.2 to GET dfn to gather Patients' future RXs
 ;Input: THRDT - THROUGH DATE to run CMOP transmission
 ;
 I '$D(^PSX(550.2,PSXBAT,15,"C")) Q
 S (SBTECME)=0 K ^TMP("PSXEPHDFN",$J)
 S PSXPTNM="" F  S PSXPTNM=$O(^PSX(550.2,PSXBAT,15,"C",PSXPTNM)) Q:PSXPTNM=""  D
 . S XDFN=0 F  S XDFN=$O(^PSX(550.2,PSXBAT,"15","C",PSXPTNM,XDFN)) Q:(XDFN'>0)  D
 . . S SDT=PRTDT F  S SDT=$O(^PS(52.5,"CMP","Q",PSXTYP,PSXTDIV,SDT)),NDFN=0 Q:(SDT>PSXDTRG)!(SDT="")  D
 . . . F  S NDFN=$O(^PS(52.5,"CMP","Q",PSXTYP,PSXTDIV,SDT,NDFN)),REC=0 Q:NDFN'>0  I NDFN=XDFN D
 . . . . F  S REC=$O(^PS(52.5,"CMP","Q",PSXTYP,PSXTDIV,SDT,NDFN,REC)) Q:REC'>0  D
 . . . . . S (PSOLRX,RX)=+$$GET1^DIQ(52.5,REC,.01,"I") I 'RX Q
 . . . . . S RFL=$$GET1^DIQ(52.5,REC,9,"I") I RFL="" S RFL=$$LSTRFL^PSOBPSU1(RX)
 . . . . . I $$XMIT^PSXBPSUT(REC) D
 . . . . . . I SDT>THRDT,'$D(^TMP("PSXEPHDFN",$J,XDFN)) Q
 . . . . . . I $$PATCH^XPDUTL("PSO*7.0*148") D
 . . . . . . . I $$RETRX^PSOBPSUT(RX,RFL),SDT>DT Q
 . . . . . . . I $$DOUBLE^PSXRPPL1(RX,RFL) Q
 . . . . . . . I $$FIND^PSOREJUT(RX,RFL,,"79,88") Q
 . . . . . . . I '$$RETRX^PSOBPSUT(RX,RFL),$$ECMESTAT(RX,RFL) Q
 . . . . . . . I $$PATCH^XPDUTL("PSO*7.0*289"),'$$DUR(RX,RFL),'$$DSH(REC) Q
 . . . . . . . S DOS=$$RXFLDT^PSOBPSUT(RX,RFL) I DOS>DT S DOS=DT
 . . . . . . . D ECMESND^PSOBPSU1(RX,RFL,DOS,"PC",,1,,,,.RESP)
 . . . . . . . I $$PATCH^XPDUTL("PSO*7.0*287"),$$TRISTA^PSOREJU3(RX,RFL,.RESP,"PC") S ^TMP("PSXEPHNB",$J,RX,RFL)=$G(RESP)
 . . . . . . . I $D(RESP),'RESP S SBTECME=SBTECME+1
 . . . . .  . .S ^TMP("PSXEPHDFN",$J,XDFN)=""
 . . . . . D PSOUL^PSSLOCK(PSOLRX)
 K ^TMP("PSXEPHDFN",$J)
 I SBTECME>0 H 60+$S((SBTECME*15)>7200:7200,1:(SBTECME*15))
 Q
 ;
EPHARM ; - ePharmacy checks for third party billing
 I $$DOUBLE^PSXRPPL1(RXN,RFL) S EPHQT=1 Q
 I $$RETRX^PSOBPSUT(RXN,RFL),SDT>DT S EPHQT=1 Q
 I $$FIND^PSOREJUT(RXN,RFL,,"79,88") S EPHQT=1 Q
 I $$PATCH^XPDUTL("PSO*7.0*287"),$$TRISTA^PSOREJU3(RXN,RFL,.RESP,"PC") D EPH Q
 I $$PATCH^XPDUTL("PSO*7.0*287"),$D(^TMP("PSXEPHNB",$J,RXN,RFL)) D EPH Q
 I $$STATUS^PSOBPSUT(RXN,RFL)="IN PROGRESS" D EPH Q
 I $$PATCH^XPDUTL("PSO*7.0*289"),'$$DSH(REC) S EPHQT=1 Q
 I $$PATCH^XPDUTL("PSO*7.0*289"),'$$DUR(RXN,RFL) D EPH Q
 Q
 ;
EPH ; - Store Rx not xmitted to CMOP in XTMP file for MailMan message.
 S ^TMP("PSXEPHIN",$J,$$RXSITE^PSOBPSUT(RXN),RXN)=RFL,EPHQT=1
 Q
 ;
 ;Description:
 ;This function checks the Rx's ECME Status to determine if it's acceptable to resubmit
 ;based on reject codes associated with a previous submission. If Rx was rejected with
 ;host reject errors, and no other rejects exist, then it's OK to resubmit to ECME.
 ;Input: RX = Prescription file #52 IEN
 ; RFL = Refill number
 ;Returns: 1 = OK to resubmit
 ;0 = Don't resubmit
ECMESTAT(RX,RFL) ;
 I '$$PATCH^XPDUTL("PSO*7.0*148") Q 0
 N STATUS,HERR,CHDAT
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
 ;Description: 
 ;This function determines whether the RX SUSPENSE has a DAYS SUPPLY HOLD
 ;condition.
 ;Input: REC = Pointer to Suspense file (#52.5)
 ;Returns: 1 or 0
 ;1 (one) if ¾ of days supply has elapsed.
 ;0 (zero) is returned if ¾ of days supply has not elapsed. 
 ;
DSH(REC) ;ePharmacy API to check for 3/4 days supply hold
 N PSINSUR,PSARR,SHDT,DSHOLD,DSHDT,PS0,COMM,DIE,DA,DR,RXIEN,RFL,DAYSSUP,LSTFIL,PTDFN,IBINS,DRG
 N DEA,DEAOK,ICD,SFN,SDT
 S DSHOLD=1,PS0=^PS(52.5,REC,0),RXIEN=$P(PS0,U,1),RFL=$P(PS0,U,13)
 S LSTFIL=$$LSTRFL^PSOBPSU1(RXIEN),PTDFN=$$GET1^DIQ(52,RXIEN,"2","I")
 S IBSTAT=$$INSUR^IBBAPI(PTDFN,,"E",.IBINS,"1"),DRG=$$GET1^DIQ(52,RXIEN,"6","I")
 S (ICD,DEA)="",DEA=$$GET1^DIQ(50,DRG,3)
 I $D(^PSRX(RXIEN,"ICD",1,0)) S ICD=^PSRX(RXIEN,"ICD",1,0)
 ;
 ; Don't hold Rx where the previous fill was not ebillable
 I $$STATUS^BPSOSRX(RXIEN,LSTFIL-1)="" Q DSHOLD
 ; Don't hold when the Rx has SC/EI flagged
 I ICD[1 Q DSHOLD
 ; Don't hold rx if DEA special Handling code is non billable (i.e. has M or 0 (zero) or I, S, N, and/or 9)) without an E
 S DEAOK=$$DEA^IBNCPDP(DEA) I 'DEAOK Q DSHOLD
 ; Don't hold for zero fill renewals
 I 'LSTFIL,$$GET1^DIQ(52,RXIEN_",","PRIOR FILL DATE",,,)="" Q DSHOLD
 ; Don't hold if no insurance
 I 'IBSTAT!(IBSTAT=-1) Q DSHOLD
 ;
 S DSHDT=$$DSHDT(RXIEN) ; 3/4 of days supply date
 I DSHDT>DT S DSHOLD=0 D
 . I DSHDT'=$P(PS0,U,14) D  ; Update Suspense Hold Date and Activity Log
 . . S COMM="3/4 of Days Supply SUSPENSE HOLD until "_$$FMTE^XLFDT(DSHDT,"2D")_"."
 . . S DAYSSUP=$$LFDS(RXIEN)
 . . D RXACT^PSOBPSU2(RXIEN,RFL,COMM,"S",+$G(DUZ)) ; Update Activity Log
 . . S DR="10///^S X=DSHDT",DIE="^PS(52.5,",DA=REC D ^DIE ; File Suspense Hold Date
 . . N DA,DIE,DR,PSOX,SFN,INDT,DEAD,RXREC,SUB,XOK,OLD
 . . S DA=REC,DIE="^PS(52.5,",DR=".02///"_DSHDT D ^DIE
 . . S SFN=REC,DEAD=0,INDT=DSHDT D CHANGE^PSOSUCH1(RXIEN,RFL)
 Q DSHOLD
 ;
 ;Description: ePharmacy
 ;This function determines the date that 3/4 of the days supply for the
 ;last refill will occur.
 ;Input: RXIEN = Prescription file #52 IEN
 ;Returns: DATE/TIME value
DSHDT(RXIEN) ;
 N RXFIL,FILLDT,DAYSSUP,DSH34
 I '$D(^PSRX(RXIEN,0)) Q -1
 ;S RXFIL=$$LSTRFL^PSOBPSU1(RXIEN) ; Last Refill
 S FILLDT=$$LDPFDT(RXIEN) ; Last Dispensed Date or Prior Fill Date for renewal
 S DAYSSUP=$$LFDS(RXIEN) ; Days Supply of Last Refill
 S DSH34=DAYSSUP*.75 ; 3/4 of Days Supply
 Q $$FMADD^XLFDT(FILLDT,DSH34) ; Return today plus 3/4 of Days Supply date
 ;
 ;Description:
 ;This function returns the DAYS SUPPLY for the Latest Fill for a Prescription
 ;Input: RXIEN = Prescription file #52 IEN
 ;Returns: DAYS SUPPLY for the latest fill or -1 if RXIEN is not valid
LFDS(RXIEN) ;
 N RXFIL
 Q:'$D(^PSRX(RXIEN)) -1
 S RXFIL=$$LSTRFL^PSOBPSU1(RXIEN)
 Q $S(RXFIL=0:$P(^PSRX(RXIEN,0),U,8),1:$P(^PSRX(RXIEN,1,RXFIL,0),U,10))
 ;
LDPFDT(RXIEN) ; Returns PRIOR FILL DATE if renewal otherwise LAST DISPENSED DATE or -1 if not valid
 Q $S('$D(^PSRX(RXIEN)):-1,$$PRFDT(RXIEN):$$PRFDT(RXIEN),1:$$LDT(RXIEN))
 ;
PRFDT(RXIEN) ; Returns PRIOR FILL DATE in internal format
 Q $$GET1^DIQ(52,RXIEN_",","PRIOR FILL DATE","I",,)
 ;
LDT(RXIEN) ; Returns LAST DISPENSED DATE in internal format
 Q $$GET1^DIQ(52,RXIEN_",","LAST DISPENSED DATE","I",,)
 ;
 ;Description: ePharmacy API to check for host errors.
 ;Input: RX = Prescription file #52 IEN
 ; RFL = Refill number
 ;Returns: A value of 0 (zero) will be returned when reject codes M6, M8,
 ;NN, and 99 are present OR if on susp hold which means the prescription should not 
 ;be sent to CMOP. Otherwise, a value of 1(one) will be returned.
DUR(RX,RFL) ;
 N REJ,IDX,TXT,CODE,SHCODE,SHDT,CHDAT1
 S IDX=""
 I '$D(RFL) S RFL=$$LSTRFL^PSOBPSU1(RX)
 ; check for a previous host reject:
 ;  1 - if host reject date expired allow to print; 0 - if not expired don't print
 ;    2 - if not defined allow to continue with evaluation for new host reject
 S CHDAT1=$$CHHEDT(RX,RFL) Q:CHDAT1=1 1 Q:CHDAT1=0 0  ;Otherwise continue on to check for a new host reject
 ; If a host reject exists and no previous Susp Hold Date or log entry,
 ;    create the log entry and hold rx/fill.
 S HERR=$$HOSTREJ(RX,RFL,1)
 I HERR,SHDT="" D SHDTLOG(RX,RFL) Q 0
 Q:HERR 0
 Q 1
 ;
CHHEDT(RX,RFL) ;
 ; RX = Prescription File IEN
 ; RFL = Refill
 ;Returns: 
 ; 0 = host reject date not expired, 1 - host reject has expired, 2 - host reject not defined 
 ;
 S SHDT=$$SHDT(RX,RFL) ; Get suspense hold date for rx/refill
 I SHDT'="" Q:DT'<SHDT 1  Q 0
 Q 2
 ;
 ;Description: ePharmacy
 ;This subroutine checks an RX/FILL for Host Reject Errors returned
 ;from previous ECME submissions. The host reject errors checked are M6, M8, NN, and 99.
 ;Note that host reject errors do not pass to the pharmacy reject worklist so it's necessary
 ;to check ECME for these type errors.
 ;Input: 
 ; RX = Prescription File IEN
 ; RFL = Refill
 ; ONE = Either 1 or 0 - Defaults to 1
 ; If 1, At least ONE reject code associated with the RX/FILL must 
 ;   match either M6, M8, NN, or 99.
 ; If 0, ALL reject codes must match either M6, M8, NN, or 99
 ;Return: 
 ; RETV = 1 OR 0
 ; 1 = host reject exists based on ONE parameter
 ; 0 = no host rejects exists based on ONE parameter
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
 ;Description: This subroutine sets the EPHARMACY SUSPENSE HOLD DATE field
 ;for the rx or refill to tomorrow and adds an entry to the SUSPENSE Activity Log.
 ;Input: RX = Prescription File IEN
 ; RFL = Refill
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
 ;Description: This function returns the EPHARMACY SUSPENSE HOLD DATE field
 ;for the rx or refill
 ;Input: RX = Prescription File IEN
 ; RFL = Refill
SHDT(RX,RFL) ;
 N FILE,IENS
 I '$D(RFL) S RFL=$$LSTRFL^PSOBPSU1(RX)
 S FILE=$S(RFL=0:52,1:52.1),IENS=$S(RFL=0:RX_",",1:RFL_","_RX_",")
 Q $$GET1^DIQ(FILE,IENS,86,"I")
 ;
