IBECECX1 ;BSL/DVA - BILLING  EXTRACTION AND FILING UTILITIES FOR IN PATIENT ACCUMULATOR INTERFACE ; 16 May 2022  8:47 AM
 ;;2.0;INTEGRATED BILLING;**704,769**;21-MAR-94;Build 42
 ;Per VA Directive 6402, this routine should not be modified.
 ; 
 ; Reference to ^DGPT("AAD",^DGPT( in ICR #418
 ;
 Q   ;No direct routine calls
 ;
EN(DFN) ;Retrieve existing Billing clock if present for this patient
 N IBECDT,IBECLDT,IBECFDT,IBECSTP
 S IBERR=0
 ;S IBEVFAC=+$$SITE^VASITE                             ;Event Facility
 S IBECADM=IBADMIT_.9999
 I 'DFN D NOCLOCK Q  ;bjr - No billing clock data found, set all values NULL (for now)
 ; IBIEN = IEN of billing clock
 S IBECDT=-IBECADM F  S IBECDT=$O(^IBE(351,"AIVDT",DFN,IBECDT)) D  Q:'IBECDT  Q:$G(IBCLDT)  ;Get billing clock that was active at date/time of admission
 . I 'IBECDT D NOCLOCK Q
 . S IBIEN=$O(^IBE(351,"AIVDT",DFN,IBECDT,";"),-1)    ;Get billing clock IEN
 . I IBIEN<1 D NOCLOCK Q
 . S IBECLDT=$$GET1^DIQ(351,IBIEN_",",.1,"I") I 'IBECLDT S IBECLDT=$$FMADD^XLFDT(-IBECDT,364) ;IB*2*769 - Clock end clock start +364
 . ;S IBECLDT=$$GET1^DIQ(351,IBIEN_",",.1,"I") I 'IBECLDT S IBECLDT=$$CLSDT(-IBECDT)
 . I IBECLDT,(IBECLDT<IBECADM) D NOCLOCK  Q           ;Quit if billing clock closed at time of admission
 . I $P(^IBE(351,IBIEN,0),U,4)=3 D NOCLOCK  Q         ;Don't return canceled clock
 . S IBCLDT=$P(^IBE(351,IBIEN,0),U,3)                 ;Billing clock begin date
 . K IBERROR                                          ;Clear IBERROR flag if good clock found
 . S IBSTAT=$P(^IBE(351,IBIEN,0),U,4)                 ;Status
 . S IB901=$P(^IBE(351,IBIEN,0),U,5)                  ;1st QTR Billing
 . S IB902=$P(^IBE(351,IBIEN,0),U,6)                  ;2nd QTR Billing
 . S IB903=$P(^IBE(351,IBIEN,0),U,7)                  ;3rd QTR Billing
 . S IB904=$P(^IBE(351,IBIEN,0),U,8)                  ;4th QTR Billing
 . S IBCLDAY=$P(^IBE(351,IBIEN,0),U,9)                ;Number of Inpatient days
 . S IBCLNDT=+$P(^IBE(351,IBIEN,0),U,10)              ;End date of 365 day clock
 . S IBCLNDT=$S(IBCLNDT:IBCLNDT,1:$$FMADD^XLFDT(IBCLDT,364))  ;Calc Billing Clock end date when null
 . S IBCKNUM=1                                        ;Number of billing clocks sent (FT1)
 . S IBICNUM=1                                        ;Number of billing clocks sent (FT2)
 . S IBSTN=$P($$GET1^DIQ(351,IBIEN_",",17)," ")       ;Station Number
 . S IBVRSN=+$P($$GET1^DIQ(351,IBIEN_",",17)," ",2)   ;Billing Clock version number
 ;Look for future clocks within 1 year if no past clocks found - IB*2.0*769
 I IBCLDT="" S IBECFDT=-($$FMADD^XLFDT(IBADMIT,364))_.9999,IBECSTP=-IBADMIT D
 . F  S IBECFDT=$O(^IBE(351,"AIVDT",DFN,IBECFDT)) D  Q:'IBECFDT  Q:$G(IBCLDT)  Q:IBECFDT>IBECSTP  ;Get billing clock that was active at date/time of admission
 .. I 'IBECFDT Q
 .. S IBIEN=$O(^IBE(351,"AIVDT",DFN,IBECFDT,";"),-1)    ;Get billing clock IEN
 .. I IBIEN<1 D NOCLOCK Q
 .. S IBECLDT=$$GET1^DIQ(351,IBIEN_",",.1,"I") I 'IBECLDT S IBECLDT=$$FMADD^XLFDT(-IBECFDT,364)
 .. I IBECLDT,(IBECLDT<IBECADM) D NOCLOCK Q            ;Quit if billing clock closed at time of admission
 .. I IBECLDT,(IBECLDT<DT) D NOCLOCK D  Q               ;Quit if future clock is closed
 ... S IBERROR="Billing Clock found at site #"_(DUZ(2))_" but manual review is needed"
 .. I $P(^IBE(351,IBIEN,0),U,4)=3 Q                    ;Don't return canceled clock
 .. S IBCLDT=$P(^IBE(351,IBIEN,0),U,3)                 ;Billing clock begin date
 .. K IBERROR ;Clear IBERROR flag if good clock found
 .. S IBSTAT=$P(^IBE(351,IBIEN,0),U,4)                 ;Status
 .. S IB901=$P(^IBE(351,IBIEN,0),U,5)                  ;1st QTR Billing
 .. S IB902=$P(^IBE(351,IBIEN,0),U,6)                  ;2nd QTR Billing
 .. S IB903=$P(^IBE(351,IBIEN,0),U,7)                  ;3rd QTR Billing
 .. S IB904=$P(^IBE(351,IBIEN,0),U,8)                  ;4th QTR Billing
 .. S IBCLDAY=$P(^IBE(351,IBIEN,0),U,9)                ;Number of Inpatient days
 .. S IBCLNDT=+$P(^IBE(351,IBIEN,0),U,10)              ;End date of 365 day clock
 .. S IBCLNDT=$S(IBCLNDT:IBCLNDT,1:$$FMADD^XLFDT(IBCLDT,364))    ;Calc Billing Clock end date when null
 .. S IBCKNUM=1                                        ;Number of billing clocks sent (FT1)
 .. S IBICNUM=1                                        ;Number of billing clocks sent (FT2)
 .. S IBSTN=$P($$GET1^DIQ(351,IBIEN_",",17)," ")       ;Station Number
 .. S IBVRSN=+$P($$GET1^DIQ(351,IBIEN_",",17)," ",2)   ;Billing Clock version number
 Q
 ;
INPT(DFN) ;Gather inpatient data
 ; Retrieve most recent Admission and Discharge dates from the PTF file
 N IBIEN1
 S (IBADMIT,IBDISCH)="",IBSTATION=$P($$SITE^VASITE,U,3)
 Q:'$D(^DGPT("AAD",DFN))  ;quit if nothing found
 S IBADMIT="9999999.9999",IBADMIT=$O(^DGPT("AAD",DFN,IBADMIT),-1),IBADM1=IBADMIT,IBIEN1=$O(^DGPT("AAD",DFN,IBADMIT,0)),IBDISCH=$P($G(^DGPT(IBIEN1,70)),U)
 S IBOADMIT=$$FMTHL7^XLFDT(IBADMIT),IBADMIT=$$FMTHL7^XLFDT($P(IBADMIT,"."))                ;convert admission date to HL7
 I IBDISCH'="" S IBODISCH=$$FMTHL7^XLFDT(IBDISCH),IBDISCH=$$FMTHL7^XLFDT($P(IBDISCH,"."))  ;Get discharge dates (HL7 format), no times needed
 I $G(IBNGHTSK) S IBADMIT=$$FMTHL7^XLFDT(DT-1),IBDISCH=""
 Q
 ;
CCINPT(DFN,IBADMIT) ;Gather inpatient data for CC billing
 ; Retrieve most recent Admission and Discharge dates from the PTF file
 N IBIEN1
 S IBDISCH="",IBSTATION=$P($$SITE^VASITE,U,3)
 Q:'$D(^DGPT("AAD",DFN))  ;quit if nothing found
 S IBADMIT=IBADMIT_".9999",IBADMIT=$O(^DGPT("AAD",DFN,IBADMIT),-1),IBADM1=IBADMIT I IBADMIT S IBIEN1=$O(^DGPT("AAD",DFN,IBADMIT,0)),IBDISCH=$P($G(^DGPT(IBIEN1,70)),U)
 I IBADMIT,$G(IBFR)>IBADMIT S IBADMIT=IBFR ;If bill date is greater than admit date, use bill date for query
 I IBADMIT S IBOADMIT=$$FMTHL7^XLFDT(IBADMIT),IBADMIT=$$FMTHL7^XLFDT($P(IBADMIT,"."))      ;convert admission date to HL7
 I IBDISCH,IBFR>IBDISCH S IBDISCH=IBFR ;If bill date is greater than discharge date, use bill date for query
 I IBDISCH'="" S IBODISCH=$$FMTHL7^XLFDT(IBDISCH),IBDISCH=$$FMTHL7^XLFDT($P(IBDISCH,"."))  ;Get discharge dates (HL7 format), no times needed
 Q
 ;
NOCLOCK ;Set variables if no clock found
 S (IBIEN,IEN,IBCLNDT,IB901,IB902,IB903,IB904,IBCLDAY,IBCKNUM,IBICNUM,IBSTAT,IBSTN,IBVRSN)="" S:$G(IBCLDT)="" IBCLDT=""
 S IBERROR="NO MEANS TEST BILLING CLOCK FOUND"
 Q
CLSDT(IBECDT) ;Calculate billing clock closed date taking into acct leap year
 N IBYEAR,IBMTHDAY,IBLEAP,IBECLDT
 S IBYEAR=$E(IBECDT,1,3),IBMTHDAY=$E(IBECDT,4,7)
 I IBMTHDAY<=229 S IBLEAP=$$LEAP^XLFDT3(IBYEAR)
 I IBMTHDAY>229 S IBLEAP=$$LEAP^XLFDT3(IBYEAR+1)
 I IBLEAP S IBECLDT=$$FMADD^XLFDT(IBECDT,365) Q IBECLDT
 I 'IBLEAP S IBECLDT=$$FMADD^XLFDT(IBECDT,364) Q IBECLDT
 Q IBECLDT
VRSNCHK(IB351IEN) ;Verify Version matches incoming versions
 N IBECVSN
 ;Quit if nothing to compare in IBVARRY
 Q:'$D(IBVARRY) 0
 ;CHECK VERSION ARRAY, SHOULD BE ONLY ONE SUBSCRIPT SO $O AND REVERSE $O SHOULD RETURN THE SAME RESULTS
 I $O(IBVARRY(""))'=$O(IBVARRY(";"),-1) Q 1
 ;GET CURRENT CLOCK VERSION - IF BLANK, FILE IT (FIRST CLOCK?) AND COMPARE REMAINING DSP DATA
 S IBECVSN=$$GET1^DIQ(351,IB351IEN_",",17) I IBECVSN="" D  Q 0
 .L +^IBE(351,IB351IEN):$G(DILOCKTM,5) Q:'$T
 .S DIE="^IBE(351,",DA=IB351IEN,DR="17///"_$O(IBVARRY("")) D ^DIE
 .L -^IBE(351,IB351IEN)
 ;version stored does not match the version in query indicating clock out of sync (version stored could be from Query Results)
 I $O(IBVARRY(""))'=IBECVSN Q 1
 Q 0
GETIEN(DFN,IBADM1) ;Get Means Test Billing clock (#351) file ien
 N IBECX,IBIEN,IBDA,IBDAS,IBCLDT,IBFUTCL
 S IBIEN=0
 S IBECX=-$P(IBADM1,".")_.9999 F  S IBECX=$O(^IBE(351,"AIVDT",DFN,IBECX)) Q:'IBECX  D  Q:$G(IBIEN)
 .I IBECX  S IBDA=";"  F  S IBDA=$O(^IBE(351,"AIVDT",DFN,IBECX,IBDA),-1) Q:'IBDA  Q:$G(IBIEN)  S IBDAS=IBDA_"," I $$GET1^DIQ(351,IBDAS,.04,"I")'=3  D  Q
 ..S IBCLDT=($$FMADD^XLFDT(-IBECX,364)) ;
 ..S IBIEN=IBDA
 ..I IBADM1>=IBCLDT S IBIEN=0
 I IBIEN Q IBIEN
 ;Search for future clock that this could fall under
 S IBFUTCL=$$FMADD^XLFDT(IBADM1,364) I IBFUTCL<DT Q 0
 S IBECX=-$P(IBFUTCL,".")_.9999 F  S IBECX=$O(^IBE(351,"AIVDT",DFN,IBECX)) Q:'IBECX  D  Q:$G(IBIEN)
 .I IBECX  S IBDA=";"  F  S IBDA=$O(^IBE(351,"AIVDT",DFN,IBECX,IBDA),-1) Q:'IBDA  S IBDAS=IBDA_"," I $$GET1^DIQ(351,IBDAS,.04,"I")'=3  D  Q
 ..S IBCLDT=($$FMADD^XLFDT(-IBECX,364))
 ..S IBIEN=IBDA
 ..I IBADM1>=IBCLDT S IBIEN=0
 Q IBIEN
 ;
WRAP(IBCOL1,IBCOL2,IBTEXT) ;Wrap text in IBTEXT variable
 ; Input Parameters Description:
 ;  IBCOL1: Left Column to start
 ;  IBCOL2: Cols to wrap in
 ;  IBTEXT: Text to wrap
 ;
 N IBTEXTO,IBX
 S IBX=0
 F  Q:'$L(IBTEXT)  D
 .F IBTEXTO=IBCOL2:-1:0 I $E(IBTEXT,IBTEXTO)=" " S IBX=IBX+1,IBTEXT(IBX)=""  Q
 .S:IBTEXTO<1 IBTEXTO=IBCOL2
 .S IBTEXT(IBX)=IBTEXT(IBX)_$E(IBTEXT,1,IBTEXTO)
 .S IBTEXT=$E(IBTEXT,IBTEXTO+1,$L(IBTEXT))
 Q
ERR1(IBERRMSG) ;Handle error responses for network and software failure issues
 ;
 N XMY,XMSUB,IBL,IB3513D,IBTEXT,IBX,XMDUZ,XMTEXT
 ;IB*2*769 VDIF call to MVI prior to query to ensure patient has Treating Facilities - VDIF will not return any errors for this
 ;I IBERRMSG["MVI returned no treating facilities for this patient" D UDCL Q  ;no error message necessary - just update the query sent field
 ;MAIL MESSAGE GENERATION CODE ON HOLD FOR FUTURE REQUIREMENTS
 K ^TMP($J,"IBCPYAC")
 S XMSUB="COPAY PATIENT ACCUMULATOR ISSUE"
 S XMY("G.IB PATIENT ACCUMULATOR")=""
 S IBL=0
 S IBL=IBL+1,^TMP($J,"IBCPYAC",IBL)="ERROR RECEIVED BY VDIF DURING COPAY ACCUMULATOR EVENT:"
 S IBL=IBL+1,^TMP($J,"IBCPYAC",IBL)=""
 S IBTEXT=IBERRMSG D WRAP(0,80,.IBTEXT)
 S IBX=0 F  S IBX=$O(IBTEXT(IBX)) Q:'IBX  D
 .S IBL=IBL+1,^TMP($J,"IBCPYAC",IBL)=IBTEXT(IBX)
 S IBL=IBL+1,^TMP($J,"IBCPYAC",IBL)=""
 S IBL=IBL+1,^TMP($J,"IBCPYAC",IBL)="As a result, the billing clock will not be synced up enterprise wide."
 S IBL=IBL+1,^TMP($J,"IBCPYAC",IBL)="Resolution will require an IT ticket to fix the issue(s)"
 S IBL=IBL+1,^TMP($J,"IBCPYAC",IBL)="and manual update of billing clocks."
 S IBL=IBL+1,^TMP($J,"IBCPYAC",IBL)=""
 S IBL=IBL+1,^TMP($J,"IBCPYAC",IBL)="Only one IT ticket needs to be created for an episode of care,"
 S IBL=IBL+1,^TMP($J,"IBCPYAC",IBL)="as a Mailman message will be sent daily while the error persists,"
 S IBL=IBL+1,^TMP($J,"IBCPYAC",IBL)="and the veteran remains in an inpatient setting."
 S IBL=IBL+1,^TMP($J,"IBCPYAC",IBL)=""
 S IBL=IBL+1,^TMP($J,"IBCPYAC",IBL)="When creating a ticket, please include the following:"
 S IBL=IBL+1,^TMP($J,"IBCPYAC",IBL)=""
 I $D(IBID) S IBL=IBL+1,^TMP($J,"IBCPYAC",IBL)="HLO MESSAGE ID: "_IBID
 I $D(IBERRS) S IBL=IBL+1,^TMP($J,"IBCPYAC",IBL)="STATION WITH ERROR RESPONSE: "_IBERRS
 I $D(IB351IEN) S IBL=IBL+1,^TMP($J,"IBCPYAC",IBL)="MEANS TEST BILLING CLOCK (#351) IEN: "_IB351IEN
 I $D(DFN) S IBL=IBL+1,^TMP($J,"IBCPYAC",IBL)="PATIENT DFN: "_DFN
 I $D(IBICLDTS) S IBL=IBL+1,^TMP($J,"IBCPYAC",IBL)="CLOCK START DATE: "_IBICLDTS
 I $D(IBCLDAU) S IBL=IBL+1,^TMP($J,"IBCPYAC",IBL)="CLOCK VERSION: "_IBCLDAU
 I $D(IB3513) D  ;MEANS TEST BILLING CLOCK VERIFY DATA
 . S IBL=IBL+1,^TMP($J,"IBCPYAC",IBL)="MEANS TEST BILLING CLOCK VERIFY (351.3) - RECORD IEN "_+$O(IB3513(0))
 . S IBL=IBL+1,^TMP($J,"IBCPYAC",IBL)=""
 . S IBL=IBL+1,^TMP($J,"IBCPYAC",IBL)=""
 . S IBL=IBL+1,^TMP($J,"IBCPYAC",IBL)="STATION #"_"          "_"CLOCK VERSION"
 . S IBL=IBL+1,^TMP($J,"IBCPYAC",IBL)="----------------------------------"
 . S IB3513D=0
 . F  S IB3513D=$O(IB3513(IB3513D)) Q:'IB3513D  S IBL=IBL+1,^TMP($J,"IBCPYAC",IBL)=$P(IB3513D,"^",2)_"                "_$P(IB3513D,"^",3)
 . S IBL=IBL+1,^TMP($J,"IBCPYAC",IBL)=""
 . S IBL=IBL+1,^TMP($J,"IBCPYAC",IBL)="For full Query Response details, review the logs from the MEANS TEST"
 . S IBL=IBL+1,^TMP($J,"IBCPYAC",IBL)="BILLING CLOCK VERIFY (351.3) file."
 S XMDUZ=DUZ,XMTEXT="^TMP($J,""IBCPYAC"","
 D ^XMD
 Q
 ;
ERR2(IBERRMSG) ;Handle error responses for Clock Discrepancy issues
 ;
 N XMY,XMSUB,IBL,IB3513D,IBTEXT,IBX,XMDUZ,XMTEXT
 ;IB*2*769 VDIF call to MVI prior to query to ensure patient has Treating Facilities - VDIF will not return any errors for this
 ;MAIL MESSAGE GENERATION CODE ON HOLD FOR FUTURE REQUIREMENTS
 K ^TMP($J,"IBCPYAC")
 S XMSUB="COPAY PATIENT ACCUMULATOR ISSUE"
 S XMY("G.IB PATIENT ACCUMULATOR")=""
 S IBL=0
 S IBL=IBL+1,^TMP($J,"IBCPYAC",IBL)="BILLING CLOCK DISCREPANCY FOUND BETWEEN VA FACILITIES:"
 S IBL=IBL+1,^TMP($J,"IBCPYAC",IBL)=""
 S IBTEXT=IBERRMSG D WRAP(0,80,.IBTEXT)
 S IBX=0 F  S IBX=$O(IBTEXT(IBX)) Q:'IBX  D
 .S IBL=IBL+1,^TMP($J,"IBCPYAC",IBL)=IBTEXT(IBX)
 S IBL=IBL+1,^TMP($J,"IBCPYAC",IBL)=""
 S IBL=IBL+1,^TMP($J,"IBCPYAC",IBL)="As a result, the billing clock will not be synced up enterprise wide."
 S IBL=IBL+1,^TMP($J,"IBCPYAC",IBL)="Resolution will require researching encounters at the sites listed below"
 S IBL=IBL+1,^TMP($J,"IBCPYAC",IBL)="to determine the correct clock values and manually update billing clocks."
 S IBL=IBL+1,^TMP($J,"IBCPYAC",IBL)=""
 S IBL=IBL+1,^TMP($J,"IBCPYAC",IBL)="Billing clock and error details and other sites with clocks:"
 S IBL=IBL+1,^TMP($J,"IBCPYAC",IBL)=""
 I $D(IBID) S IBL=IBL+1,^TMP($J,"IBCPYAC",IBL)="HLO MESSAGE ID: "_IBID
 I $D(IBERRS) S IBL=IBL+1,^TMP($J,"IBCPYAC",IBL)="STATION WITH ERROR RESPONSE: "_IBERRS
 I $D(IB351IEN) S IBL=IBL+1,^TMP($J,"IBCPYAC",IBL)="MEANS TEST BILLING CLOCK (#351) IEN: "_IB351IEN
 I $D(DFN) S IBL=IBL+1,^TMP($J,"IBCPYAC",IBL)="PATIENT DFN: "_DFN
 I $D(IBICLDTS) S IBL=IBL+1,^TMP($J,"IBCPYAC",IBL)="CLOCK START DATE: "_IBICLDTS
 I $D(IBCLDAU) S IBL=IBL+1,^TMP($J,"IBCPYAC",IBL)="CLOCK VERSION: "_IBCLDAU
 I $D(IB3513) D  ;MEANS TEST BILLING CLOCK VERIFY DATA
 . S IBL=IBL+1,^TMP($J,"IBCPYAC",IBL)="MEANS TEST BILLING CLOCK VERIFY (351.3) - RECORD IEN "_+$O(IB3513(0))
 . S IBL=IBL+1,^TMP($J,"IBCPYAC",IBL)=""
 . S IBL=IBL+1,^TMP($J,"IBCPYAC",IBL)=""
 . S IBL=IBL+1,^TMP($J,"IBCPYAC",IBL)="STATION #"_"          "_"CLOCK VERSION"
 . S IBL=IBL+1,^TMP($J,"IBCPYAC",IBL)="----------------------------------"
 . S IB3513D=0
 . F  S IB3513D=$O(IB3513(IB3513D)) Q:'IB3513D  S IBL=IBL+1,^TMP($J,"IBCPYAC",IBL)=$P(IB3513D,"^",2)_"                "_$P(IB3513D,"^",3)
 . S IBL=IBL+1,^TMP($J,"IBCPYAC",IBL)=""
 . S IBL=IBL+1,^TMP($J,"IBCPYAC",IBL)="For full Query Response details, review the logs from the MEANS TEST"
 . S IBL=IBL+1,^TMP($J,"IBCPYAC",IBL)="BILLING CLOCK VERIFY (351.3) file."
 S XMDUZ=DUZ,XMTEXT="^TMP($J,""IBCPYAC"","
 D ^XMD
 Q
 ;
UDCL ;Update original billing clock so nightly querys are not sent for patients without TFL's
 Q:'$G(IB351IEN)
 S $P(^IBE(351,IB351IEN,1),"^",5)=1  ;Update QUERY SENT
 Q
 ;
EDTCLCK(DFN,IBADMIT,IBCURIEN) ;Called from Billing Clock Maintenance option
 N IBTRYTIL,IBECDT,IBECLDT,IBECIEN,IBECSTDT,IBECENDT,IBECDT1,ICN,IBECADM,IBSADMIT,IBSDISCH,IBQRYDT,IBREFNUM,IBMES,HDR,IBINST,IBSTATION
 I '$$ICN^IBARXMU(DFN) S IBFLAG1=1 Q  ;Do not run query if patient does not have an ICN
 S IBTFL=$$TFL^IBARXMU(DFN,.IBTFL,2) I 'IBTFL S IBFLAG1=1 Q  ;Quit if patient has no other TFL's
 ;send clock start date ad admit date when editing billing clock
 ;D CCINPT(DFN,IBADMIT)
 S IBDISCH="",IBSTATION=$P($$SITE^VASITE,U,3),IBADM1=IBADMIT
 D MTEQRY^IBECECQ1(DFN,IBADM1)  ;Run Query
 N IBMSG,HDR,SEG,XXX,DFN,IBVARRY,IBECERR,IBECNIEN,IBID,IBICLDTS,IBDISCH
 W !,"Running Billing Clock Query, please wait."
 ;Wait clock for up to 2 minutes until DSR returned from billing clock query
 S IBFLAG1=0 S IBTRYTIL=$$FMADD^XLFDT($$NOW^XLFDT,,,2) F  Q:$$NOW^XLFDT>IBTRYTIL  Q:IBFLAG1  D
 .H 2 W "." Q:IBFLAG1  S HLMSGIEN=MSG("IEN"),IBMES=$$STARTMSG^HLOPRS(.IBMSG,HLMSGIEN,.HDR) S HLMSGIEN=$G(IBMSG("ACK BY IEN")) I HLMSGIEN D
 ..S IBERR=0,IBERRMSG=""
 ..S XXX=$$STARTMSG^HLOPRS(.IBMSG,HLMSGIEN,.HDR)
 ..F  Q:'$$NEXTSEG^HLOPRS(.IBMSG,.SEG)  S IBSEGT=$G(SEG("SEGMENT TYPE")) Q:IBSEGT=""  D
 ...I IBSEGT="MSA" D MSA1^IBECECQ1
 ...I IBSEGT="QRD" D QRDDI^IBECECQ1
 ...I IBSEGT="DSP" S:$$GET^HLOPRS(.SEG,5,1)["Billing Clock found at site #" IBERRMSG=$$GET^HLOPRS(.SEG,5,1) S IBCNT=$$GET^HLOPRS(.SEG,1,1) I IBCNT>1 D
 ....S IBSTATION=$$GET^HLOPRS(.SEG,9,1) ;Station Number
 ....I IBSTATION'="" D FIND^DIC(4,,.01,"MX",IBSTATION,,"D",,,"IBLIST","IBERR") D
 .....S IBINST=IBLIST("DILIST",1,1),IBECARY(IBINST)="" ;Institution array for error messaging
 ..;I IBERRMSG["MVI returned no treating facilities for this patient" S IBERRMSG=""
 ..;I IBERRMSG["NO MEANS TEST BILLING CLOCK FOUND" S IBERRMSG=""
 ..;I IBERRMSG["No Member found" S IBERRMSG=""  ;IB*2.0*769 Clear error message for HBM no Member response
 ..H 4 I IBERRMSG'="" S IBFLAG1=1 Q
 ..S IBECERR=0 ;IBECERR - FLAG TO DETERMINE IF VERSIONING OUT OF SYNC
 ..I IBERRMSG="" S IBECDA=$S(+IB351IEN:IB351IEN,1:$G(IBECNIEN)) I IBECDA S IBECERR=$$GET1^DIQ(351,IBECDA,18) I IBECERR="YES" D  ;DSR returned with query results - now validate the results based on clock version
 ...S IBERRMSG="Query results contain inconsistent versioning - indicating MEANS TEST BILLING CLOCKs may be out of sync."
 ..S IBFLAG1=1
 Q
