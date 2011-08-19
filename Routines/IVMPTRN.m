IVMPTRN ;ALB/MLI,SEK,RTK,BRM,BAJ,LBD - IVM BACKGROUND JOB/TRANSMISSIONS TO IVM CENTER; 10/28/2005 ; 1/20/10 12:00pm
 ;;2.0;INCOME VERIFICATION MATCH;**1,9,11,12,17,28,34,74,79,89,105,143**;JUL 8,1996;Build 1
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ; This routine is run nightly to send HL7 messages to the IVM Center for
 ; processing.
 ;
BGJ ; - IVM Nightly Background Job
 ;
 ;for tests being held for the future, make them primary if now effective
 D FUTUREMT,FUTURERX
 ;
 ; - retransmit enrollment/eligibility queries with no reply
 D BATCH^DGENQRY1
 ;
 ; - retransmit income test (financial) queries with no reply
 D MONITOR^IVMCQ2
 ;
 ; - current year and previous year
 S IVMCURYR=$$LYR^DGMTSCU1(DT),IVMPREYR=$$LYR^DGMTSCU1(IVMCURYR)
 ;
 ;
 ; - Master Query Processing
 ;
 ; - respond to Master Query for previous year, if necessary
 S IVMREC=$$QRY(IVMPREYR) I IVMREC D RESP(IVMPREYR,+IVMREC),END
 ;
 ; - respond to Master Query for current year, if necessary
 S IVMREC=$$QRY(IVMCURYR) I IVMREC D RESP(IVMCURYR,+IVMREC),END
 ;
 ; - send regular 'nightly' transmissions
 D REG,END
 ;
 ; - perform retransmission processing
 D ENTRY^IVMPTRN4,END
 ;
 ; - process billing activity
 D EN^IVMPTRN5
 ;
 ; - auto-upload address changes from #301.5 if >14 days old
 ; - auto-delete non address changes from #301.5 if >30 days old
 N ADDRDT S ADDRDT(0)=30,ADDRDT(1)=14 D EN^IVMLDEMC(.ADDRDT)
 ;
END ; - cleanup
 I $D(ZTQUEUED) S ZTREQ="@"
 K DA,DFN,DIE,DIK,DR,IVMCT,IVMDA,IVMDT,IVMGTOT,IVMINCYR,IVMINS,IVMMTDT
 K IVMNODE,IVMPAT,IVMPID,IVMQDT,IVMREC,IVMSTAT,X,%,VAFPID,IVMPREYR,IVMIY
 D CLEAN^IVMUFNC
 K ^TMP($J,"CC")
 Q
 ;
REG ; Creates FULL query transmission for patient's
 ;         that exist in file (#301.5) "ATR" x-ref
 ;
 ;
 ; - initialize variables for HL7/IVM
 S HLMTN="ORU"
 S HLEID="VAMC "_$P($$SITE^VASITE,"^",3)_" "_HLMTN_"-Z07 SERVER"
 S HLEID=$O(^ORD(101,"B",HLEID,0))
 K ^TMP($J,"CC") ;refresh Consistency Check counter
 D INIT^IVMUFNC(HLEID,.HL)
 ;
 ; - roll thru ATR x-ref for patients that require transmission
 K IVMQUERY("LTD"),IVMQUERY("OVIS") ;Variables needed to open/close last visit date and outpt visit QUERIES
 S IVMIY=0
 F  S IVMIY=$O(^IVM(301.5,"ATR",0,IVMIY)) Q:'IVMIY  D
 .S IVMDA=0
 .F  S IVMDA=$O(^IVM(301.5,"ATR",0,IVMIY,IVMDA)) Q:'IVMDA  D
 ..;
 ..N EVENTS
 ..; - get node, income year, dfn
 ..S IVMNODE=$G(^IVM(301.5,+IVMDA,0)),IVMDT=+$P(IVMNODE,"^",2),DFN=+IVMNODE
 ..I 'DFN!'IVMDT Q
 ..;
 ..Q:($$STATUS^IVMPLOG(IVMDA,.EVENTS)=1)
 ..;
 ..S IVMMTDT=$$GETMTDT(DFN,IVMDT)  ;IVM*2*143
 ..;
 ..; - prepare FULL transmission
 ..D FULL^IVMPTRN7(DFN,IVMMTDT,.EVENTS,.IVMCT,.IVMGTOT,,,,.IVMQUERY)
 ;
 ; After all transmissions send Bulletin of inconsistency check totals
 D EN^IVMPBUL
 ;
 F Z="LTD","OVIS" I $G(IVMQUERY(Z)) D CLOSE^SDQ(IVMQUERY(Z)) K IVMQUERY(Z)
 ; - transmit remaining records
 D
 .N IVMEVENT
 .; event code for Full Data Transmission
 .S IVMEVENT="Z07"
 .D FILE^IVMPTRN3
 Q
 ;
RESP(IVMINCYR,IVMREC) ; Response to the Master Query.
 ;
 ; Input: IVMINCYR -  The income year for which the query was sent
 ;        IVMREC   -  Internal entry number of query to be updated
 ;
 N DFN,IVMDA,IVMMTDT,DA,DR,DIE,EVENTS
 ;
 ; - initialize variables for HL7/IVM
 S HLMTN="ORF"
 S HLEID="VAMC "_$P($$SITE^VASITE,"^",3)_" "_HLMTN_"-Z07 SERVER"
 S HLEID=$O(^ORD(101,"B",HLEID,0))
 D INIT^IVMUFNC(HLEID,.HL)
 ;
 ; - roll thru AYR x-ref
 F DFN=0:0 S DFN=$O(^IVM(301.5,"AYR",IVMINCYR,DFN)) Q:'DFN  D
 .F IVMDA=0:0 S IVMDA=$O(^IVM(301.5,"AYR",IVMINCYR,DFN,IVMDA)) Q:'IVMDA  D
 ..;
 ..; - check for STOP FLAG in file #301.5.
 ..I '$$CLOSED^IVMPLOG(IVMDA) D
 ...;
 ...; if means test was deleted, -10000 could be entered as income year
 ...; in ^IVM(301.5.  close case if deleted.
 ...S IVMMTDT=$P($$LST^DGMTU(DFN,($E(IVMINCYR,1,3)+1)_"1231.9999"),"^",2)
 ...I IVMMTDT="" D CLOSE^IVMPTRN1(IVMINCYR,DFN,1,3) Q
 ...;
 ...;get EVENTS() array
 ...I $$STATUS^IVMPLOG(+IVMDA,.EVENTS)
 ...;
 ...; - prepare FULL transmission
 ...; note: 6th parameter is IVMFLL (=1 to include MSA segment)
 ...D FULL^IVMPTRN7(DFN,IVMMTDT,.EVENTS,.IVMCT,.IVMGTOT,1,,$G(IVMREC),.IVMQUERY)
 ;
 ; - transmit remaining records
 D
 .N IVMEVENT
 .; event code for Full Data Transmission
 .S IVMEVENT="Z07"
 .D FILE1^IVMPTRN3  ; added for v1.6 because of MSA segment (note: the original call was to FILE^IVMPTRN3)
 ;
 ;
 ; - update multiple in file #301.9. Stuff (.03) field with date/time
 ;   of FULL query transmission.
 S DIE="^IVM(301.9,1,10,",DA=+IVMREC,DA(1)=1,DR=".03////"_$$NOW^XLFDT D ^DIE
 Q
 ;
QRY(YEAR) ; See if Master Query has been satisfied for YEAR.
 ;  Input: YEAR - The income year being checked
 ;
 ; Output: 1^2, where   1 =  0, if query does not need a response
 ;                          >0, if query needs a response (value
 ;                              equal to ien of sub-file entry
 ;                              in #301.9
 ;                      2 =  0, if the request has not been received
 ;                           1, if the request has been received
 N IVM,X,Y,Z
 I '$G(YEAR) S X="0^0" G QRYQ
 S Y=$O(^IVM(301.9,1,10,"AB",YEAR,"")) I 'Y S X="0^0" G QRYQ
 S IVM=$O(^IVM(301.9,1,10,"AB",YEAR,Y,0)) I 'IVM S X="0^0" G QRYQ
 S Z=$P($G(^IVM(301.9,1,10,+IVM,0)),"^",3)
 S X=$S(Z:0,1:IVM)_"^1"
QRYQ Q X
 ;
FUTUREMT ;
 ;Find future tests, and if now effective then make them primary.  Will
 ;call the MT event driver unless NOT required, in which case the status
 ;will have the status will be changed to NO LONGER REQUIRED
 ;and may auto-create a Rx copay test
 ;
 N FDATE,IVMPAT,MTIEN,NODE,DFN,DATA
 ;
 S FDATE=0
 F  S FDATE=$O(^IVM(301.5,"AC",FDATE)) Q:('FDATE)  Q:(FDATE>DT)  D
 .S IVMPAT=0
 .F  S IVMPAT=$O(^IVM(301.5,"AC",FDATE,IVMPAT)) Q:'IVMPAT  D
 ..S MTIEN=$O(^IVM(301.5,"AC",FDATE,IVMPAT,""),-1)
 ..I '$$FUTURECK("AC",FDATE,IVMPAT,MTIEN) K ^IVM(301.5,"AC",FDATE,IVMPAT,MTIEN)
 ..K DATA S DATA(.06)="" I $$UPD^DGENDBS(301.5,IVMPAT,.DATA)
 ..S DFN=+$G(^IVM(301.5,IVMPAT,0))
 ..I DFN S NODE=$$LST^DGMTU(DFN,DT_.9999,1) I $E($P(NODE,"^",2),1,3)=$E(DT,1,3),$P(NODE,"^",4)'="","R"'=$P(NODE,"^",4) K ^IVM(301.5,"AC",FDATE,IVMPAT,MTIEN) Q
 ..D MTPRIME^DGMTU4(MTIEN)
 Q
 ;
FUTURERX ;
 ;Find future COPAY tests, and if now effective then make it primary.
 ;Will change the status to NO LONGER APPLICABLE if the vet is not
 ;subject to pharmacy copayments
 ;
 N FDATE,IVMPAT,MTIEN,NODE,DFN,DATA
 ;
 S FDATE=0
 F  S FDATE=$O(^IVM(301.5,"AD",FDATE)) Q:('FDATE)  Q:(FDATE>DT)  D
 .S IVMPAT=0
 .F  S IVMPAT=$O(^IVM(301.5,"AD",FDATE,IVMPAT)) Q:'IVMPAT  D
 ..S MTIEN=$O(^IVM(301.5,"AD",FDATE,IVMPAT,""),-1)
 ..I '$$FUTURECK("AD",FDATE,IVMPAT,MTIEN) K ^IVM(301.5,"AD",FDATE,IVMPAT,MTIEN)
 ..K DATA S DATA(.07)="" I $$UPD^DGENDBS(301.5,IVMPAT,.DATA)
 ..S DFN=+$G(^IVM(301.5,IVMPAT,0))
 ..I DFN S NODE=$$LST^DGMTU(DFN,DT_.9999,2) I $E($P(NODE,"^",2),1,3)=$E(DT,1,3),$P(NODE,"^",4)'="" K ^IVM(301.5,"AD",FDATE,IVMPAT,MTIEN) Q
 ..D RXPRIME^DGMTU4(MTIEN)
 Q
 ;
FUTURECK(TYPE,FDATE,IVMPAT,MTIEN) ;
 ; Check the Future MT or CP xref for a valid income test entry,
 ; and Delete all invalid xref entries.
 N VALID,MTREC S VALID=1,MTREC=0
 ;
 ; Remove duplicate entries from cross reference, leaving last entry
 F  S MTREC=$O(^IVM(301.5,TYPE,FDATE,IVMPAT,MTREC)) Q:(MTREC=MTIEN!('MTREC))  K ^IVM(301.5,TYPE,FDATE,IVMPAT,MTREC)
 ;
 I '$D(^IVM(301.5,IVMPAT,0)) S VALID=0 Q VALID
 I '$D(^DGMT(408.31,MTIEN,0)) S VALID=0 Q VALID
 I FDATE'=+(^DGMT(408.31,MTIEN,0)) S VALID=0 Q VALID
 ;
 Q VALID
 ;
GETMTDT(DFN,IVMDT) ;Get date of primary Means Test or RX Copay Test (IVM*2*143)
 N IDT,MT,MTDT,MTSTA,RX,RXDT,RXSTA
 I '$G(DFN)!('$G(IVMDT)) Q ""
 S IDT=($E(IVMDT,1,3)+1)_"1231.9999"
 ;Get most recent primary MT
 S MT=$$LST^DGMTU(DFN,IDT,1),MTDT=$P(MT,"^",2),MTSTA=$P(MT,"^",4)
 ;Get most recent primary RX Copay Test
 S RX=$$LST^DGMTU(DFN,IDT,2),RXDT=$P(RX,"^",2),RXSTA=$P(RX,"^",4)
 ;If there's no RX Copay Test, then return the Means Test date.
 I 'RXDT Q MTDT
 ;If the RX Copay Test date is greater than or equal to the Means
 ;Test date, and the RX Copay Test status is Exempt, Non-Exempt,
 ;or Pending Adjudication, then return the RX Copay Test date.
 I RXDT'<MTDT,("^E^M^P^"[("^"_RXSTA_"^")) Q RXDT
 ;Otherwise, return the Means Test date.
 Q MTDT
