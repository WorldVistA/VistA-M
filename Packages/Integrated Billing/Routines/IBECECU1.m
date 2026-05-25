IBECECU1 ;BSL/DVA-BILLING  SEND/RECEIVE DFT HL7 MESSAGES PATIENT ACCUMULATOR INTERFACE -  SEND/RECEIVE A DFT UPDATE TO/FROM OTHER SITES ; 08 Jul 2022  9:21 AM
 ;;2.0;INTEGRATED BILLING;**704,769**;21-MAR-94;Build 42
 ;Per VA Directive 6402, this routine should not be modified.
 ; This routine will manage the 365 Inpatient stay clock
 ;
 ;IA#    Supports
 ;------ -------------------------------------------------
 ; Reference to $STARTMSG^HLOPRS,$$NEXTSEG^HLOPRS,$$GET^HLOPRS in ICR #4718
 ; Reference to $$ADDSEG^HLOAPI,SET^HLOAPI in ICR #4722
 ; Reference to $$SENDONE^HLOAPI1 in ICR #4717
 ; Reference to $$GETDFN^MPIF001 in ICR #2701
 ;
 ; ; ; This will fire off an update (active 365 day clock) entry in file #351,
 ;      - First when a new entry (clock) is started
 ;      - Every quarter when the income amounts are entered
 ;      - then when the Pt is discharged.
 ;Sample message:
 ; MSH|^~\&|IBECEAC-SEND|537^HL7.CHICAGO-WEST.DOMAIN.EXT:5591^DNS|IBECEAC-RCV|200VDIF^:^DNS|20250507123217-0400||DFT^P03^DFT_P03|537 12661900|T^|2.3|||AL|NE|USA
 ; EVN|P03|20250507123217-0400
 ; PID|1||1013742761V568744||LNAME^FNAME
 ; FT1|537&4|20250201|1|100|15|0|0|100|20260131||||corrected
 ;
 Q   ;No direct routine calls
 ;
EN(DFN,IBCLDA,IBUPVRSN) ; OUTGOING DFT PRIMARY ENTRY POINT
 ; IBCLDA - IEN FROM 351
 ;CALLED FROM ^IBAUTL3 (CLADD [new] AND CLUPD [updates])
 ;IBCLDA = 351 ien
 ;IBUPVRSN = flag to determine if process should update clock version
 N X,PARMS,SEG,MSG,VALUE,FIELD,QRYNUM,NAME,ERROR,XXX,WHOTO,IBACBCLK,IBADM,IBDISCH,IBADMIT,IBICN,IBQIEN,IBIEN
 N IBCLDT,IBSTAT,IB901,IB902,IB903,IB904,IBCLDAY,IBCLNDT,IBNADM,IBNAME,IBSITE,IBSOC,IBECVRSN,IBVNUM,IBVRSN,IBTFL
 ;
 S IBTFL=$$TFL^IBARXMU(DFN,.IBTFL,2) Q:'IBTFL  ;Do not send DFT if patient is not in any other Treating Facilities, IB*2*769
 I $P($G(^IBE(351,IBCLDA,1)),U,5)="" Q
 I $$GET1^DIQ(351,IBCLDA_",",18,"I") Q  ;Don't send DFT if clock is out of sync - IB*2*769
 D INPT^IBECECX1(DFN) ;Get admit/discharge dates
 S IBECVRSN=$$GET1^DIQ(351,IBCLDA_",",17) I IBECVRSN S IBVNUM=$P(IBECVRSN," ",2) D
 .I $G(IBUPVRSN) S IBECVRSN=IBSTATION_" "_(IBVNUM+1),DA=IBCLDA,DIE="^IBE(351,",DR="17///^S X=IBECVRSN" D ^DIE ;Set version number - IB*2.0*769
 I 'IBECVRSN S IBECVRSN=IBSTATION_" 1",DA=IBCLDA,DIE="^IBE(351,",DR="17///^S X=IBECVRSN" D ^DIE ;Set version number - IB*2.0*769
 S NAME=$$GET1^DIQ(2,DFN_",",.01)
 ;S IBCORRECT=$S($D(IBCORRECT):IBCORRECT,1:"null")
 D MSH,PARSE,EVN,PID Q:'IBICN  ;Do not send Message if no Patient ICN
 D FT1,SEND
 Q
 ;
 ;
MSH ; Build outgoing MSH Segment
 N PARMS K ^TMP("DFT")
 S PARMS("COUNTRY")="USA"
 S PARMS("MESSAGE TYPE")="DFT"
 S PARMS("EVENT")="P03"
 S PARMS("SENDING APPLICATION")="IBECEAC-SEND"
 S PARMS("VERSION")="2.3"
 S PARMS("MESSAGE STRUCTURE")="DFT_P03" ;IB*20*769 - Add message structure per VDIF request
 S MSG="^TMP(DFT"
 S X=$$NEWMSG^HLOAPI(.PARMS,.MSG,.ERROR)
 Q
EVN ;
 S VALUE="EVN",FIELD=0 D SET^HLOAPI(.SEG,VALUE,FIELD)
 S VALUE="P03",FIELD=1 D SET^HLOAPI(.SEG,VALUE,FIELD)
 D NOW^%DTC S %P1=% S VALUE=$$FMTHL7^XLFDT(%P1),FIELD=2
 D SET^HLOAPI(.SEG,VALUE,FIELD)
 S X=$$ADDSEG^HLOAPI(.MSG,.SEG,.ERROR)
 Q
PID ; Build outgoing PID Segment
 S VALUE="PID",FIELD=0 D SET^HLOAPI(.SEG,VALUE,FIELD)
 D SET^HLOAPI(.SEG,1,1)
 ;Set ICN field
 S IBICN=$$ICN^IBARXMU(DFN) Q:'IBICN                  ;Do not send Message if no Patient ICN
 S VALUE=IBICN,FIELD=3
 D SET^HLOAPI(.SEG,VALUE,FIELD)
 ;;Set Name
 S NAME=$$GET1^DIQ(2,DFN_",",.01)
 S VALUE=$P(NAME,",",1),FIELD=5 D SET^HLOAPI(.SEG,VALUE,FIELD,1)
 S VALUE=$P(NAME,",",2),FIELD=5 D SET^HLOAPI(.SEG,VALUE,FIELD,2)
 S X=$$ADDSEG^HLOAPI(.MSG,.SEG,.ERROR)
 Q
 ;
FT1 ; Build FT1 Outgoing segment
 D SET^HLOAPI(.SEG,"FT1",0)
 I $G(IBSTN) D
 .D SET^HLOAPI(.SEG,IBSTN,1,0)   ;STATION # for Clock Version 
 .D SET^HLOAPI(.SEG,IBVRSN,1,0,2)  ;incremental Clock Version 
 D SET^HLOAPI(.SEG,+IBCLDT,2)   ;Billing clock begin date
 D SET^HLOAPI(.SEG,+IBSTAT,3)   ;Billing clock Status
 D SET^HLOAPI(.SEG,+IB901,4)    ;1ST QTR CHARGES
 D SET^HLOAPI(.SEG,+IB902,5)    ;2ND QTR CHARGES
 D SET^HLOAPI(.SEG,+IB903,6)    ;3RD QTR CHARGES
 D SET^HLOAPI(.SEG,+IB904,7)    ;4TH QTR CHARGES
 D SET^HLOAPI(.SEG,+IBCLDAY,8)  ;Number of Inpatient days
 D SET^HLOAPI(.SEG,+IBCLNDT,9)  ;End of 365 day clock
 I $D(IBCORRECT) D SET^HLOAPI(.SEG,IBCORRECT,16)  ;Corrected status
 S X=$$ADDSEG^HLOAPI(.MSG,.SEG,.ERROR)
 Q
SEND ;SEND MESSAGE AND QUIT
 S WHOTO("RECEIVING APPLICATION")="IBECEAC-RCV"
 S WHOTO("STATION NUMBER")="200VDIF"
 S WHOTO("MIDDLEWARE LINK NAME")="IBECEC-DFT"
 S PARMS("SENDING APPLICATION")="IBECEAC-SEND"
 S PARMS("APP ACK RESPONSE")="DFTACK^IBECECU1"
 S XXX=$$SENDONE^HLOAPI1(.MSG,.PARMS,.WHOTO,.ERROR)
 Q
 ;
 ;-----------------------------------------------INCOMING DFT ------------------
RECV ; INCOMING DFT PRIMARY ENTRY POINT
 N DFN,IBHDR,IBMSG,SEG,IBSEGT,IBSTAT,IBWHAT,ICN,MSGTYPE,IBIEN,DATEQ,ERR,IBAEVNT,IBEVOCC,IBQRYS,IBUPDT,IBISTN,IBIVRSN
 N IBI901,IBI902,IBI903,IBI904,IBICKDT,IBICLDAY,IBICLDT,IBICNAL,IBISTAT,IBACTC,IBICNUM,IBDA,IBCBDT,IBSNDST,IBDA1,IBERROR
 N IBFVRSN,IB351IEN
 S ERR=0,IBSTAT=$$STARTMSG^HLOPRS(.IBMSG,HLMSGIEN,.IBHDR)
 S IBIEN=HLMSGIEN
 I 'IBSTAT  S IBERROR="Unable to start parse of message" D MSA  Q
 I "DFT"'[IBHDR("MESSAGE TYPE") S IBERROR="Incorrect message type" D MSA  Q
 ;
 F  Q:'$$NEXTSEG^HLOPRS(.IBMSG,.SEG)  S IBSEGT=$G(SEG("SEGMENT TYPE")) Q:IBSEGT=""  D
 . I IBSEGT="PID" D PIDI
 . I IBSEGT="FT1" D FT1I
 I 'DFN  S IBERROR="Unable to find patient" D MSA  Q
 I '$G(IBICLDT) S IBERROR="DFT missing clock data" D MSA  Q  ;Quit if no billing clocks returned
 S IBSNDST=$G(IBMSG("HDR","SENDING FACILITY",1))
 S IBDA=";"  F  S IBDA=$O(^IBE(351,"AIVDT",DFN,-IBICLDT,IBDA),-1) Q:'IBDA  Q:$G(IBCBDT)  D
 .Q:$$GET1^DIQ(351,IBDA_",",.04,"I")=3  ;IB*2.0*769 - Quit if clock found is Canceled
 .S IBCBDT=$$GET1^DIQ(351,IBDA_",",.03,"I")
 .S IBQRYS=$$GET1^DIQ(351,IBDA_",",16,"I")
 .S IBDA1=IBDA
 S IBUPDT=0
 I $G(IBCBDT)=IBICLDT D  Q  ;Update record and send app ack if current Billing Clock Start Date matches incoming Billing Clock Start Date
 .D UPDATE(IBDA1)
 .I 'IBUPDT S IBERROR="Unable to update existing MEANS TEST BILLING CLOCK at remote site"
 .D MSA
 .Q
 I $G(IBCBDT)'=IBICLDT D  ;File data in 351 and send app ack
 .D NEWREC
 .I 'IBUPDT S IBERROR="Unable to create new MEANS TEST BILLING CLOCK at remote site"
 .D MSA
 Q
 ;
PIDI ;Parse Incoming PID Segment
 ;S IBICN=$$GET^HLOPRS(.SEG,1,1)     ;Alternate Patient ID (DFN)
 S IBICNAL=$$GET^HLOPRS(.SEG,3,1)     ;Patient ICN
 S DFN=$$DFN^IBARXMU(IBICNAL)         ;Patient DFN
 S IBNAME=$$GET^HLOPRS(.SEG,5,1)    ;Pt name
 Q
 ;Get data from HL7 message from QRD and DSP
FT1I ;Parse Incoming FT1 Segment, assumes one record only
 ;                                     Get new 365 day clock data
 S IBISTN=$$GET^HLOPRS(.SEG,1,0)      ;Clock Version - Station Number
 S IBIVRSN=$$GET^HLOPRS(.SEG,1,0,2)     ;Clock Version #
 S IBFVRSN=IBISTN_" "_IBIVRSN         ;Full billing clock version
 S IBICLDT=$$GET^HLOPRS(.SEG,2,1)     ;Billing clock start date
 S IBICLDT=$$HL7TFM^XLFDT(IBICLDT)    ;convert HL7 date to FM
 S IBISTAT=$$GET^HLOPRS(.SEG,3,1)     ;Status of clock
 S IBI901=$$GET^HLOPRS(.SEG,4,1)      ;1ST QTR CHARGES
 S IBI902=$$GET^HLOPRS(.SEG,5,1)      ;2ND QTR CHARGES
 S IBI903=$$GET^HLOPRS(.SEG,6,1)      ;3RD QTR CHARGES
 S IBI904=$$GET^HLOPRS(.SEG,7,1)      ;4TH QTR CHARGES
 S IBICLDAY=$$GET^HLOPRS(.SEG,8,1)    ;Inpatient Days on the received clock
 S IBICKDT=$$GET^HLOPRS(.SEG,9,1)     ;Clock end date
 S:IBICKDT IBICKDT=$$HL7TFM^XLFDT(IBICKDT)    ;convert HL7 date to FM
 I IBISTAT=1,IBICKDT,IBICKDT<DT S IBISTAT=2 ;IB*2.0*769 - Update Status to closed if clock end date is in the past
 Q
PARSE ;  Get the updated clock data to send via DFT
 N IBARRAY,IBERR
 ; Get the values of the new IBE(351)  entry
 D GETS^DIQ(351,IBCLDA_",","**","I","IBARRAY","IBERR")
 S IBSITE=$$SITE^IBATUTL                    ;Site number
 S IBCLDT=IBARRAY(351,IBCLDA_",",.03,"I")   ;Clock start date
 S IBCLDT=$$FMTHL7^XLFDT(IBCLDT)            ;convert HL7 date to FM
 S IBSTAT=IBARRAY(351,IBCLDA_",",.04,"I")   ;Status
 S IB901=IBARRAY(351,IBCLDA_",",.05,"I")    ;1st QTR CHARGES
 S IB902=IBARRAY(351,IBCLDA_",",.06,"I")    ;2nd QTR CHARGES
 S IB903=IBARRAY(351,IBCLDA_",",.07,"I")    ;3rd QTR CHARGES
 S IB904=IBARRAY(351,IBCLDA_",",.08,"I")    ;4th QTR CHARGES
 S IBCLDAY=IBARRAY(351,IBCLDA_",",.09,"I")  ;Number of inpatient days
 S IBCLNDT=IBARRAY(351,IBCLDA_",",.1,"I")   ;End date of the clock
 I 'IBCLNDT S IBCLNDT=$$FMADD^XLFDT($$HL7TFM^XLFDT(IBCLDT),364)    ;Calc Billing Clock end date when null
 S IBCLNDT=$$FMTHL7^XLFDT(IBCLNDT)          ;convert HL7 date to FM
 S IBSTN=$P($$GET1^DIQ(351,IBCLDA_",",17)," ")       ;Station Number
 S IBVRSN=+$P($$GET1^DIQ(351,IBCLDA_",",17)," ",2)   ;Billing Clock version number
 Q
 ;
NEWREC ;Create a new entry in file 351
 L +^IBE(351,0):$G(DILOCKTM,5) Q:'$T
 N DIC,IBFDA,IEN,IENS,X,Y,IEN351,IBDUZ,IBDTUP,IBREASON,DIE,DA,DR,IBBEGDT
 S DIC="^IBE(351,",DIC(0)=""
 S X=$P($G(^IBE(351,+$P($G(^IBE(351,0)),U,3),0)),U,1)+1 ;IB*2.0*769 - Protect global for 1st entry into file
 ;IB*769 - IBECNIEN used in DSR response processing to update Clock Version if one doesn't currently exist
 D FILE^DICN S (IENS,IEN)=$P(Y,U,1),(DA,IBECNIEN)=$P(Y,U,1) S IENS=IENS_","
 ;IBFDA(FILE#,"IENS",FIELD#)="VALUE"
 I $G(IBICNAL)'="" S DFN=$$GETDFN^MPIF001(IBICNAL)
 I DFN=""  L -^IBE(351,0) Q
 S IBFDA(351,IENS,.02)=DFN
 ;
 ;Need to do aggregation of incoming clock with local data on Query Responses (DSR)
 I $G(IBAGG)=1 D AGGR  ;Has this data been aggregated with local data
 S IBBEGDT=IBICLDT S:$G(IBCBDT) IBBEGDT=$S(IBICLDT>IBCBDT:IBCBDT,1:IBICLDT) ;Use earlier date for new admission - IB*2.0*769
 S IBFDA(351,IENS,.03)=$G(IBBEGDT)
 S IEN351=0 F  S IEN351=$O(^IBE(351,"ACT",DFN,IEN351)) Q:IEN351=""  D  ;loop through "current" clock xref
 . Q:$G(IBICLNDT)  ;Quit if incoming clock is closed
 . I $$GET1^DIQ(351,IEN351_",",.04,"I")=1 D
 .. S DIE="^IBE(351,",DA=IEN351,DR=".04///3;"
 .. S IBDUZ=$G(DUZ,.5),DR=DR_";13////^S X=IBDUZ"
 .. S IBDTUP=$$NOW^XLFDT,DR=DR_";14///^S X=IBDTUP",DR=DR_";14///^S X=IBDTUP"
 .. I $G(IBCNT) S IBREASON=$S($G(IBSNDST)'="":"Billing Clock update from Sta #"_IBSNDST,1:"Billing Clock update from Query"),DR=DR_";15///^S X=IBREASON"
 .. I '$G(IBCNT) S IBREASON="Billing Clock update from Query"
 .. D ^DIE ;Use fileman to properly delete ACT x-ref
 .. K DIE,DA,DR
 I $G(IBISTAT)'=2 S IBISTAT=$S(IBISTAT=3:3,'$G(IBICLNDT):1,$G(IBICLNDT)<=DT:2,1:1) ;IB*2.0*769 - calculate status
 S IBFDA(351,IENS,.04)=$G(IBISTAT)
 S IBFDA(351,IENS,.05)=$G(IBI901)
 S IBFDA(351,IENS,.06)=$G(IBI902)
 S IBFDA(351,IENS,.07)=$G(IBI903)
 S IBFDA(351,IENS,.08)=$G(IBI904)
 S IBFDA(351,IENS,.09)=$G(IBICLDAY)
 S:$G(IBICKDT)<=DT IBFDA(351,IENS,.1)=IBICKDT
 S IBFDA(351,IENS,15)=$S($G(IBSNDST)'="":"Billing Clock update from Sta #"_IBSNDST,1:"Billing Clock update from Query")
 S IBFDA(351,IENS,11)=.5
 S IBFDA(351,IENS,12)=$$NOW^XLFDT
 S IBFDA(351,IENS,13)=.5
 S IBFDA(351,IENS,14)=$$NOW^XLFDT
 S IBFDA(351,IENS,16)=1 ;Set query sent field for aggregated date stored
 I $G(IBFVRSN) S IBFDA(351,IENS,17)=IBFVRSN
 D FILE^DIE(,"IBFDA","IBERR")
 I '$D(IBERR) S IBUPDT=1,IB351IEN=+IENS ;Update successful positive app ack
 I $$GET1^DIQ(351,IENS,15)["-Edit Begin Date via CLOCK MAINT" S DIE="^IBE(351,",DA=$P(IENS,","),DR="15///@" D ^DIE ;IB*2.0*769 - Clear clock edit comment if still exists after update
 L -^IBE(351,0)
 ;
AGGR  ;Data has been aggregated at VDIF, but may not have taken into account local data
 ;
 N NODE,IBDA,NODE0,AGG,IBSTDT,IBFLG,IBECLK,IBRCLK,IBSYCLK
 S AGG=0
 ;1. If no active local clock quit 
 ;2. If local active clock and the start dates are not the same, aggregate
 ;3. If local active clock and start dates are the same, and days inpatient are Less than query, aggregate
 ;4. If local active clock and start dates are the same, and days inpatient are greater than query, quit
 ;
 ;get local clock data (#351)
 ;S NODE=$S(IBICLNDT:-IBICLNDT_.9999,1:-DT_.9999)
 ;F  S NODE=$O(^IBE(351,"AIVDT",DFN,NODE)) Q:'NODE  Q:$G(IBFLG)  D
 ;.S IBDA=";" F  S IBDA=$O(^IBE(351,"AIVDT",DFN,NODE,IBDA),-1) Q:'IBDA  I $P(^IBE(351,IBDA,0),U,4),$P(^IBE(351,IBDA,0),U,4)<3 S IBFLG=1 Q
 ;Q:'$G(IBDA)
 Q:'$G(IB351IEN)
 S NODE0=^IBE(351,IB351IEN,0)
 ;IB*2*769 - Remove start date check as clocks should still be aggregated
 ;Q:$P(NODE0,"^",3)<IBICLDT
 S IBSTDT=$P(NODE0,"^",3) ;use earliest billing clock if local
 I +$P(NODE0,"^",11)=IBICLDT S IBSYCLK=IBICLDT ;IB*2.0*769 - Use original clock date for incoming compare
 I '$G(IBSYCLK) S IBSYCLK=IBSTDT
 S IBECLK=IBSYCLK_U_$P(NODE0,U,5,9),IBRCLK=+IBICLDT_U_+IBI901_U_+IBI902_U_+IBI903_U_+IBI904_U_+IBICLDAY
 I (IBECLK'=IBRCLK) S AGG=1
 Q:'AGG
 ;I $G(IBICLNDT)<DT ;D MULTCLK - For future Cerner work
 ;Aggregate the incoming clock and the active clock
 S IBICLDAY=IBICLDAY+($P(NODE0,"^",9))
 S IBI901=IBI901+($P(NODE0,"^",5))
 S IBI902=IBI902+($P(NODE0,"^",6))
 S IBI903=IBI903+($P(NODE0,"^",7))
 S IBI904=IBI904+($P(NODE0,"^",8))
 I IBSTDT<IBICLDT S IBICLDT=IBSTDT ;use earliest billing clock if local
 Q
 ;
UPDATE(IBDA)  ;Update records when Billing Clock start date is the same
 N DIE,DA,IBDTUP,IBDUZ,IBBEGDT
 I $G(IBAGG)=1 D AGGR ;Local data needs to be aggregated with incoming clocks to update clock date if needed
 S IBBEGDT=IBICLDT S:$G(IBCBDT) IBBEGDT=$S(IBICLDT>IBCBDT:IBCBDT,1:IBICLDT) ;Use earlier date for new admission - IB*2.0*769
 L +^IBE(351,IBDA):$G(DILOCKTM,5) Q:'$T
 S DIE="^IBE(351,",DA=IBDA,DR=".03///^S X=IBBEGDT"
 I $G(IBISTAT)'=2 S IBISTAT=$S(IBISTAT=3:3,'$G(IBICLNDT):1,$G(IBICLNDT)<=DT:2,1:1) ;IB*2.0*769 - calculate status
 S DR=DR_";.04///^S X=IBISTAT"
 S DR=DR_";.05///"_+IBI901
 S DR=DR_";.06///"_+IBI902
 S DR=DR_";.07///"_+IBI903
 S DR=DR_";.08///"_+IBI904
 S DR=DR_";.09///"_+IBICLDAY
 S:IBICKDT<=DT DR=DR_";.1///^S X=IBICKDT"
 S IBDUZ=$G(DUZ,.5),DR=DR_";13////^S X=IBDUZ"
 S IBDTUP=$$NOW^XLFDT,DR=DR_";14///^S X=IBDTUP"
 S IBREASON=$S($G(IBSNDST)'="":"Billing Clock update from Sta #"_IBSNDST,1:"Billing Clock update from Query"),DR=DR_";15///^S X=IBREASON"
 S DR=DR_";16///1" ;Set query sent field for aggregated date stored
 I $G(IBFVRSN) S DR=DR_";17///^S X=IBFVRSN"
 D ^DIE
 I $$GET1^DIQ(351,IBDA_",",15)["-Edit Begin Date via CLOCK MAINT" S DIE="^IBE(351,",DA=IBDA,DR="15///@" D ^DIE ;IB*2.0*769 - Clear clock edit comment if still exists after update
 L -^IBE(351,DA)
 S IBUPDT=1
 Q
MSA ;Build and send App Ack
 ;RRA IB*2*769
 I IBSNDST=$$GCRNSITE^VAFCCRNR Q  ;Don't send Ack for Cerner sites
 N IBPARMS,IBACK,IBERR,IBX
 S IBPARMS("ACK CODE")=$S('$D(IBERROR):"AA",1:"AE")
 I $D(IBERROR) S IBPARMS("ERROR MESSAGE")=$G(IBERROR)
 S IBPARMS("MESSAGE TYPE")="ACK"
 S IBPARMS("COUNTRY")="USA"
 S IBPARMS("VERSION")="2.3"
 S IBX=$$ACK^HLOAPI2(.IBMSG,.IBPARMS,.IBACK,.IBERR)
 S IBX=$$SENDACK^HLOAPI2(.IBACK,.IBERR)
 Q
 ;
DFTACK ;process app ack
 ;IB*2*769
 ;MSH|^~\&|IBECEAC-RCV|554^HL7.DENVER.DOMAIN.EXT:5754^DNS|IBECEAC-SEND|537^HL7.CHICAGO-WEST.DOMAIN.EXT:5591^DNS|20250513145255-0600||ACK^P03^ACK|554 22000060|T^|2.3|||AL|NE|USA
 ;MSA|AE|537 12661932|Unable to update existing MEANS TEST BILLING CLOCK at remote site
 N IBSTAT,IBHDR,IBSEG,IBACK,IBID,IBERR,IBERRS,IB351IEN,IB778,IBICLDTS,IBCLDAU
 S IBSTAT=$$STARTMSG^HLOPRS(.IBMSG,HLMSGIEN,.IBHDR)
 Q:'$$NEXTSEG^HLOPRS(.IBMSG,.IBSEG)
 S IBACK=$$GET^HLOPRS(.IBSEG,1,1)
 ;ONLY PROCESS NEGATIVE ACK'S - QUIT IF AA
 Q:IBACK="AA"
 ;GET MESSAGE ID
 S IBID=$$GET^HLOPRS(.IBSEG,2,1)
 ;MESSAGE SHOULD ONLY BE GENERATED FOR SITE THAT SENT THE DFT
 ;IF THIS SITE IS NOT THE SITE THAT SENT THE DFT THEN QUIT PROCESSING
 Q:'+IBID=$P($$SITE^VASITE,"^",3)
 ;GET ERROR AND SITE
 S IBERR=$$GET^HLOPRS(.IBSEG,3,1)  ;error message
 S IBERRS=+IBMSG("HDR","SENDING FACILITY",1)  ;station sending the error back
 D GETDET
 D ERR1^IBECECX1(IBERR)
 ;UPDATE SYNC ERROR FIELD TO PREVENT BILLING EVENTS
 I +IB351IEN D
 .L +^IBE(351,IB351IEN):$G(DILOCKTM,5) Q:'$T
 .S DIE="^IBE(351,",DA=IB351IEN,DR="18///1" D ^DIE
 .L -^IBE(351,IB351IEN)
 Q
GETDET ;get outgoing DFT details based on returned App Ack Message ID
 N IB778,IBSTAT,IBMSG,IBHDR,SEG
 S IB778=$P(IBID," ",2) ;OUTGOING DFT 778 IEN
 S IBSTAT=$$STARTMSG^HLOPRS(.IBMSG,IB778,.IBHDR)
 F  Q:'$$NEXTSEG^HLOPRS(.IBMSG,.SEG)  S IBSEGT=$G(SEG("SEGMENT TYPE")) Q:IBSEGT=""  D
 . I IBSEGT="PID" D PIDI
 . I IBSEGT="FT1" D FT1I
 S IBICLDTS=IBICLDT ;CLOCK START DATE FOR ERROR MESSAGE
 S IBCLDAU=IBFVRSN ;CLOCK VERSION FOR ERROR MESSAGE
 D INPT^IBECECX1(DFN) ;Get inpatient admit data
 S IB351IEN=$$GETIEN^IBECECX1(DFN,IBICLDTS)  ;GET CLOCK IEN USING CLOCK BEGIN DATE AND PT DFN
 I $$GET1^DIQ(351,IB351IEN_",",17)'=IBCLDAU S IB351IEN="UNABLE TO IDENTIFY BILLING CLOCK IEN" ;MISMATCH IN VERSION INFO - PASS BACK MESSAGE
 Q
