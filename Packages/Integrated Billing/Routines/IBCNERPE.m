IBCNERPE ;DAOU/BHS - IBCNE eIV RESPONSE REPORT (cont'd); 03-JUN-2002
 ;;2.0;INTEGRATED BILLING;**271,300,416,438,497,506,519,521,659,702,806**;21-MAR-94;Build 19
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ; Must call at tag
 Q
 ;
 ; This tag is only called from IBCNERP2
 ;
GETDATA(IEN,RPTDATA) ; Retrieve response data
 ; Init
 N %,CNPTR,CT,DIW,DIWI,DIWT,DIWTC,DIWX,DN,EACT,ELOC,ESRC,ETXT,DQUAL,DTYPE,FUTDT,IENS,II,LOOP,NODE0,PC,TQIEN,Z
 ;
 N IBI,IBTD1,IBTD2,IBTDT S (IBI,IBTD1,IBTD2,IBTDT)=""  ;IB*806/DTG for hl7 date change
 N IBSA,IBSADDR,IBSCTY,IBSUBER,IBSUBGET  ;IB*806/DTG for adding subscriber address
 ; Insured Info from eIV Response #365
 S RPTDATA(0)=$G(^IBCN(365,IEN,0)),TQIEN=$P(RPTDATA(0),U,5)
 ; Trans dates to ext format
 S $P(RPTDATA(0),U,7)=$$FMTE^XLFDT($P(RPTDATA(0),U,7)\1,"5Z")
 S RPTDATA(1)=$G(^IBCN(365,IEN,1))
 ; Trans ext values for SET of CODES values
 S IENS=IEN_","
 S $P(RPTDATA(1),U,8)=$$GET1^DIQ(365,IENS,1.08,"E")   ; Whose Ins
 S $P(RPTDATA(1),U,13)=$$GET1^DIQ(365,IENS,1.13,"E")  ; COB
 ;
 ;IB*2*702/ckb - Convert Pt Rel code to English
 ; Pt Rel to Sub
 ;S RPTDATA(8)=$$GET1^DIQ(365,IENS,8.01,"E")   ; Pt Rel to Sub
 N PTREL,PTRIEN
 S PTRIEN=$$GET1^DIQ(365,IENS,8.01,"I")  ;Pt. Rel to Sub - HIPAA
 S PTREL=$$GET1^DIQ(365.037,PTRIEN_",",.02,"E")
 S RPTDATA(8)=PTREL
 ;IB*2*702/ckb - end
 ;
 ;IB*806/DTG adding in the subscriber address (365,5), error text (365,4)
 ; if there is data, other wise null
 ;RPTDATA(50,1)=subscriber address line 1 sp subscriber address line 2 sp subscriber city sp subscriber state subscriber zip
 ;RPTDATA(50,2)=subsriber address country ^ subscriber address subdivision
 ;RPTDATA(50,3)-error text
 D GETS^DIQ(365,IENS,"4.01;5.01:5.07","IEN","IBSUBGET","IBSUBER")
 S IBSADDR=$G(IBSUBGET(365,IENS,5.01,"E"))
 S IBSA=$G(IBSUBGET(365,IENS,5.02,"E")) I IBSA'="" S IBSADDR=IBSADDR_" "_IBSA
 S IBSCTY=$G(IBSUBGET(365,IENS,5.03,"E"))
 S IBSA=$G(IBSUBGET(365,IENS,5.04,"I")),IBSA=$S(IBSA:$P($G(^DIC(5,IBSA,0)),U,2),1:"")
 ; IB*806/DTG correct address display setup
 I IBSCTY'=""!(IBSA'="")!($G(IBSUBGET(365,IENS,5.05,"E"))'="") D
 . S IBSCTY=IBSCTY_" "_IBSA_" "_$G(IBSUBGET(365,IENS,5.05,"E"))
 S RPTDATA(50,1)="" I IBSADDR'=""!(IBSCTY'="") S RPTDATA(50,1)=IBSADDR_U_IBSCTY
 S RPTDATA(50,2)="" I $G(IBSUBGET(365,IENS,5.06,"E"))'=""!($G(IBSUBGET(365,IENS,5.07,"E"))'="") D
 . S RPTDATA(50,2)=$G(IBSUBGET(365,IENS,5.06,"E"))_U_$G(IBSUBGET(365,IENS,5.07,"E"))
 S RPTDATA(50,3)=$G(IBSUBGET(365,IENS,4.01,"E"))
 ; IB*806/DTG end add of subscriber address, Error Text
 ;
 ; Trans err actions/codes to ext
 S $P(RPTDATA(1),U,14)=$$X12^IBCNERP2(365.017,$P(RPTDATA(1),U,14))
 S $P(RPTDATA(1),U,15)=$$X12^IBCNERP2(365.018,$P(RPTDATA(1),U,15))
 ; Trans dates to ext format - check format
 F PC=2,9:1:12,16,17,19 S $P(RPTDATA(1),U,PC)=$$FMTE^XLFDT($P(RPTDATA(1),U,PC),"5Z")
 ;
 ; Loop thru mult Contact segs
 S CT=0
 F  S CT=$O(^IBCN(365,IEN,3,CT)) Q:'CT  D
 .S RPTDATA(3,CT)=$G(^IBCN(365,IEN,3,CT,0))
 .; Obtain the various Communication Text fields
 .F II=1:1:3 S RPTDATA(3,CT,II)=$G(^IBCN(365,IEN,3,CT,II))
 .; Disp. blank if NOT SPECIFIED
 . I $P(RPTDATA(3,CT),U)="NOT SPECIFIED" S $P(RPTDATA(3,CT),U)=""
 .; Comm Qual #1-3
 .F II=1:1:3 D
 ..S CNPTR=$$X12^IBCNERP2(365.021,$P(RPTDATA(3,CT),U,II*2))
 ..I CNPTR'="" S RPTDATA(3,CT,II)=CNPTR_": "_$G(RPTDATA(3,CT,II))
 ;
 ; Subscriber level dates (ZTP segments)
 S CT=0 F  S CT=$O(^IBCN(365,IEN,7,CT)) Q:'CT  D
 .S NODE0=$G(^IBCN(365,IEN,7,CT,0))
 .S DQUAL=$P(NODE0,U,3) I 'DQUAL Q
 .S LOOP=$$GET1^DIQ(365.027,$P(NODE0,U,4)_",",.01)
 .S DTYPE=$S(LOOP["C":"S",LOOP["D":"P",1:"O")
 .;IB*806/DTG Change hl7 date to external date
 .;S RPTDATA(7,DTYPE,CT)=$$X12^IBCNERP2(365.026,DQUAL)_U_$P(NODE0,U,2)
 . S RPTDATA(7,DTYPE,CT)=$$X12^IBCNERP2(365.026,DQUAL) D  S RPTDATA(7,DTYPE,CT)=RPTDATA(7,DTYPE,CT)_U_IBTDT
 .. S IBTDT="",IBTD1=$P(NODE0,U,2) I IBTD1="" Q
 .. S IBTD1=$TR(IBTD1," ","")
 .. S IBTD2=$$FMTE^XLFDT($$HL7TFM^XLFDT($P(IBTD1,"-",1)),"5Z")
 .. S IBTD3=$$FMTE^XLFDT($$HL7TFM^XLFDT($P(IBTD1,"-",2)),"5Z")
 .. I IBTD3="-1" S IBTD3=""  ;IB*806/dtg Payers sometimes send bad dates ie:99991231
 .. I IBTD2="-1" S IBTD2=""
 .. S IBTDT=IBTD2 I IBTD1["-" S IBTDT=IBTDT_" - "_IBTD3
 ;
 ; Reject reasons
 S CT=0 F  S CT=$O(^IBCN(365,IEN,6,CT)) Q:'CT  D
 .S NODE0=$G(^IBCN(365,IEN,6,CT,0)) I '$P(NODE0,U,3) Q
 .S ETXT=$$X12^IBCNERP2(365.017,$P(NODE0,U,3))
 .S ELOC=$P(NODE0,U,2) S:ELOC="" ELOC="N/A"
 .S EACT=$$X12^IBCNERP2(365.018,$P(NODE0,U,4)) S:EACT="" EACT="N/A"
 .S LOOP=$$X12^IBCNERP2(365.027,$P(NODE0,U,5)) S:LOOP="" LOOP="N/A"
 .S ESRC=$P(NODE0,U,6) S:ESRC="" ESRC="N/A"
 .;IB*2*497   modify existing line below to retrieve external value of ERROR CODE and ACTION CODE
 . ;and build as part of the composite string at RPTDATA(6,CT).
 .S RPTDATA(6,CT)=ELOC_U_$$GET1^DIQ(365.017,$P(NODE0,U,3)_",",.01)_U_ETXT_U_$$GET1^DIQ(365.018,$P(NODE0,U,4)_",",.01)_U_EACT_U_LOOP_U_ESRC
 .; IB*2*497  retrieve additional messages
 .S Z=0 F  S Z=$O(^IBCN(365,IEN,6,CT,1,Z)) Q:'Z  S RPTDATA(6,CT,"AMSG",Z)=$P($G(^IBCN(365,IEN,6,CT,1,Z,0)),U)
 .Q
 ;
 ; Subscriber Data
 S RPTDATA(13)=$G(^IBCN(365,IEN,13))
 ;
 ; Group Data
 S RPTDATA(14)=$G(^IBCN(365,IEN,14))
 ;
FUTDT I TQIEN D  ; If there is a future date, display it
 . S FUTDT=$P($G(^IBCN(365.1,TQIEN,0)),U,9) Q:FUTDT=""
 . S II=$O(RPTDATA(5,""),-1)+1
 . S RPTDATA(5,II)=" ",II=II+1
 . S RPTDATA(5,II)="Inquiry will be automatically resubmitted on "_$$FMTE^XLFDT(FUTDT,"5Z")_"."
 ;
GETDATX ; GETDATA exit point
 Q
 ;
 ; This tag is only called from IBCNERP3
 ;
DATA(DISPDATA)  ;  Build disp lines
 ; IB*806/DJW Restructured this tag for readability and maintenance; Dropped SSN
 N LCT,CT,SEGCT,ITEM,CT2,NTCT,CNCT,ERCT,RPTDATA,DCT,DTYPE
 ; Merge into local array
 M RPTDATA=^TMP($J,RTN,SORT1,SORT2,CNT)
 ; Build
 S LCT=1,ITEM=$$FO^IBCNEUT1($$LBL^IBCNERP2(365,13.01),17,"R")_$P(RPTDATA(13),U,1) D WRAPIT(ITEM,.LCT,.DISPDATA,74,17) ;Insured/Subscriber's Name
 S LCT=LCT+1,ITEM=$$FO^IBCNEUT1($$LBL^IBCNERP2(365,13.02),17,"R")_$P(RPTDATA(13),U,2) D WRAPIT(ITEM,.LCT,.DISPDATA,74,17) ;Subscriber ID
 S LCT=LCT+1,DISPDATA(LCT)=$$FO^IBCNEUT1($$LBL^IBCNERP2(365,1.02),17,"R")_$P(RPTDATA(1),U,2)                   ;Insured/Subscriber DOB
 ;S LCT=LCT+1,DISPDATA(LCT)=$$FO^IBCNEUT1($$LBL^IBCNERP2(365,1.03),17,"R")_$$FO^IBCNEUT1($P(RPTDATA(1),U,3),20) ; SSN
 S DISPDATA(LCT)=DISPDATA(LCT)_$$FO^IBCNEUT1($$LBL^IBCNERP2(365,1.04),32,"R")_$P(RPTDATA(1),U,4)                ;Insured/Subscriber Sex
 ;
 S LCT=LCT+1,ITEM=$$FO^IBCNEUT1($$LBL^IBCNERP2(365,14.01),17,"R")_$P(RPTDATA(14),U,1) D WRAPIT(ITEM,.LCT,.DISPDATA,74,17) ;Group Name
 S LCT=LCT+1,ITEM=$$FO^IBCNEUT1($$LBL^IBCNERP2(365,14.02),17,"R")_$P(RPTDATA(14),U,2) D WRAPIT(ITEM,.LCT,.DISPDATA,74,17) ;Group Number
 S LCT=LCT+1,DISPDATA(LCT)=$$FO^IBCNEUT1($$LBL^IBCNERP2(365,1.08),17,"R")_$$FO^IBCNEUT1($P(RPTDATA(1),U,8),14)  ;Whose Insurance
 S DISPDATA(LCT)=DISPDATA(LCT)_$$FO^IBCNEUT1("HIPAA Relationship to Sub: ",28,"R")_RPTDATA(8)                   ;PT. Relationship HIPAA
 S LCT=LCT+1,DISPDATA(LCT)=$$FO^IBCNEUT1($$LBL^IBCNERP2(365,1.18),17,"R")_$$FO^IBCNEUT1($P(RPTDATA(1),U,18),20) ;Member ID
 S DISPDATA(LCT)=DISPDATA(LCT)_$$FO^IBCNEUT1($$LBL^IBCNERP2(365,1.13),22,"R")_$P(RPTDATA(1),U,13)               ;COB
 S LCT=LCT+1,DISPDATA(LCT)=$$FO^IBCNEUT1($$LBL^IBCNERP2(365,1.1),17,"R")_$$FO^IBCNEUT1($P(RPTDATA(1),U,10),20) ;Service Dt
 S DISPDATA(LCT)=DISPDATA(LCT)_$$FO^IBCNEUT1($$LBL^IBCNERP2(365,1.16),22,"R")_$P(RPTDATA(1),U,16)              ;Dt of Death
 S LCT=LCT+1,DISPDATA(LCT)=$$FO^IBCNEUT1($$LBL^IBCNERP2(365,1.11),17,"R")_$$FO^IBCNEUT1($P(RPTDATA(1),U,11),20) ; Effective Dt
 S DISPDATA(LCT)=DISPDATA(LCT)_$$FO^IBCNEUT1($$LBL^IBCNERP2(365,1.17),22,"R")_$P(RPTDATA(1),U,17)              ;Certification Dt
 S LCT=LCT+1,DISPDATA(LCT)=$$FO^IBCNEUT1($$LBL^IBCNERP2(365,1.12),17,"R")_$$FO^IBCNEUT1($P(RPTDATA(1),U,12),20) ;Expiration Dt
 S DISPDATA(LCT)=DISPDATA(LCT)_$$FO^IBCNEUT1($$LBL^IBCNERP2(365,1.19),22,"R")_$P(RPTDATA(1),U,19)              ;Payer Updated Policy
 S LCT=LCT+1,DISPDATA(LCT)=$$FO^IBCNEUT1($$LBL^IBCNERP2(365,.07),17,"R")_$$FO^IBCNEUT1($P(RPTDATA(0),U,7),20) ;Response Dt/ Dt/Time Received
 S DISPDATA(LCT)=DISPDATA(LCT)_$$FO^IBCNEUT1($$LBL^IBCNERP2(365,.09),22,"R")_$P(RPTDATA(0),U,9)               ;Trace #
 ;IB*806/DTG display subscriber address 5.01,5.02,5.03,5.04,5.05,5.06,5.07
 I $P($G(RPTDATA(50,1)),U,1)'=""!($P($G(RPTDATA(50,1)),U,2)'="") D
 . S LCT=LCT+1,DISPDATA(LCT)=$$FO^IBCNEUT1("Sub Address: ",17,"R")_$P($G(RPTDATA(50,1)),U,1)  ; Subscriber Address
 . S LCT=LCT+1,DISPDATA(LCT)=$$FO^IBCNEUT1("",17,"R")_$P($G(RPTDATA(50,1)),U,2)  ; Subscriber Address city/state/zip
 I $P($G(RPTDATA(50,2)),U,1)'="" S LCT=LCT+1,DISPDATA(LCT)=$$FO^IBCNEUT1("Country: ",17,"R")_$P($G(RPTDATA(50,2)),U,1)  ;subscriber country
 I $P($G(RPTDATA(50,2)),U,2)'="" S LCT=LCT+1,DISPDATA(LCT)=$$FO^IBCNEUT1("Subdivision: ",17,"R")_$P($G(RPTDATA(50,2)),U,2)  ;subscriber subdivision
 ;
 I $G(RPTDATA(50,3))'="" D
 . S LCT=LCT+1,DISPDATA(LCT)=""
 . S LCT=LCT+1,DISPDATA(LCT)=$$FO^IBCNEUT1("Error Text: ",17,"R")_$G(RPTDATA(50,3))   ; IB*806/DTG error text
 ;
 ;IB*806/DTG removed policy number
 ;S LCT=LCT+1,DISPDATA(LCT)=$$FO^IBCNEUT1($$LBL^IBCNERP2(365,1.2),17,"R")_$$FO^IBCNEUT1($P(RPTDATA(1),U,20),20) ;Policy #
 ;
 ; Dates
 F DTYPE="S","P","O" D
 .I '$D(RPTDATA(7,DTYPE)) Q
 .S LCT=LCT+1,DISPDATA(LCT)=""
 .S LCT=LCT+1,DISPDATA(LCT)=$S(DTYPE="S":"Subscriber",DTYPE="P":"Patient",1:"Other")_" Dates:"
 .S LCT=LCT+1,DISPDATA(LCT)=$S(DTYPE="S":"----------",DTYPE="P":"-------",1:"-----")_"------"
 .S DCT="" F  S DCT=$O(RPTDATA(7,DTYPE,DCT)) Q:DCT=""  D
 ..;S LCT=LCT+1,DISPDATA(LCT)=$$FO^IBCNEUT1($P(RPTDATA(7,DTYPE,DCT),U)_": ",40)_$P(RPTDATA(7,DTYPE,DCT),U,2)
 ..S LCT=LCT+1,DISPDATA(LCT)=$E($P(RPTDATA(7,DTYPE,DCT),U),1,60)_":  "_$P(RPTDATA(7,DTYPE,DCT),U,2)
 ;
 ; Contacts
CONT ;
 ; IB*806 Restructured this tag
 N TEXT
 S CNCT=+$O(RPTDATA(3,""),-1) I 'CNCT G ERR
 S LCT=LCT+1,DISPDATA(LCT)=""
 S LCT=LCT+1,DISPDATA(LCT)="CONTACT INFORMATION:"
 S LCT=LCT+1,DISPDATA(LCT)="--------------------"
 ; Build
 F CT=1:1:CNCT D
 . S SEGCT=$O(RPTDATA(3,CT,""),-1)
 . S TEXT=""
 . I $L($P(RPTDATA(3,CT),U,1)) S TEXT=$P(RPTDATA(3,CT),U,1)
 . I $L(TEXT) S LCT=LCT+1,DISPDATA(LCT)="Contact Person: "_TEXT,TEXT=""  ;IB*806/DTG separate the contact person from the communication
  . F CT2=1:1:SEGCT S ITEM=$G(RPTDATA(3,CT,CT2)) D
 . . Q:'$L(ITEM)
 . . S TEXT=$S($L(TEXT):" "_TEXT_",  ",1:" ")_ITEM
 . . F  D  Q:'$L(TEXT)
 . . . S LCT=LCT+1,DISPDATA(LCT)=$E(TEXT,1,74)
 . . . I $L(TEXT)>74 S TEXT=$E(TEXT,75,$L(TEXT)) Q
 . . . S TEXT=""
 ;
 ; Err Info
ERR S ERCT=+$O(RPTDATA(6,""),-1) I 'ERCT G DATAX
 S LCT=LCT+1,DISPDATA(LCT)=""
 S LCT=LCT+1,DISPDATA(LCT)="ERROR INFORMATION:"
 S LCT=LCT+1,DISPDATA(LCT)=""
 F CT=1:1:ERCT D
 . ; IB*497 changed setting DISPDATA(LCT) below
 .S LCT=LCT+1,DISPDATA(LCT)="Reject Reason Code: "_$P(RPTDATA(6,CT),U,2)
 .S LCT=LCT+1,DISPDATA(LCT)="Reject Reason Text: "_$P(RPTDATA(6,CT),U,3)
 .S LCT=LCT+1,DISPDATA(LCT)="Action Code:   "_$P(RPTDATA(6,CT),U,4)
 .S LCT=LCT+1,DISPDATA(LCT)="Action Code Text: "_$P(RPTDATA(6,CT),U,5)
 .S LCT=LCT+1,DISPDATA(LCT)="HIPAA Loop:    "_$P(RPTDATA(6,CT),U,6)
 .S LCT=LCT+1,DISPDATA(LCT)="HL7 Location:  "_$P(RPTDATA(6,CT),U)
 .S LCT=LCT+1,DISPDATA(LCT)="Error Source:  "_$P(RPTDATA(6,CT),U,7)
 .I $D(RPTDATA(6,CT,"AMSG")) D
 ..I ERCT>0 S LCT=LCT+1,DISPDATA(LCT)=""  ; IB*506
 ..S LCT=LCT+1,DISPDATA(LCT)="Additional Messages:"
 ..S LCT=LCT+1,DISPDATA(LCT)=""
 ..S Z=0 F  S Z=$O(RPTDATA(6,CT,"AMSG",Z)) Q:'Z  S LCT=LCT+1,DISPDATA(LCT)=RPTDATA(6,CT,"AMSG",Z)
 ..Q
 .S LCT=LCT+1,DISPDATA(LCT)=""
 ;
DATAX ;
 ;IB*2.0*659/TAZ - Restuctured to get Response IEN that was used previously
 ;N RIBVDA,RSPIENS
 ;S RIBVDA=$P(RPTDATA(0),U,4)
 ;S RSPIENS=$O(^IBCN(365,"AF",+$G(RIBVDA),""),-1)
 N RSPIENS
 S RSPIENS=RPTDATA("RSPIENS")
 ;
 ; Disp Future Date and Misc. Comments
 I $O(RPTDATA(5,0))'="" D
 . F CT=1:1:+$O(RPTDATA(5,""),-1) D
 .. S LCT=LCT+1,DISPDATA(LCT)=" "_$$FO^IBCNEUT1("",7,"R")_$G(RPTDATA(5,CT))
 ;
 ; /IB*2.0*506 Beginning
 ; Added the Elig. Ben. info to print at the end of the patient's display on the e-IV Response Report.
 S LCT=LCT+1,DISPDATA(LCT)=" "
 K ^TMP("EIV RESP. EB DATA",$J)
 N VALMEVL    ; Important as the INIT^IBCNES kills an array we need to keep if VALMEVL is defined  (IB*519)
 ; save off certain VALM variables because call to IBCNES changes them and throws off page counter when returning to EE screen (IB*519)
 ; IB*2.0*521/ZEB use $G to prevent crash when report is run from outside of a ListMan context
 I $G(VALMCNT) N IBVLSV S IBVLSV=VALMCNT_U_$G(VALM("LINES"))_U_$G(^TMP("IBCNBLE",$J,VALMCNT,0))
 D INIT^IBCNES(365.02,RSPIENS_",","A",1,"EIV RESP. EB DATA")
 N TCTR
 S TCTR=""
 F  S TCTR=$O(^TMP("EIV RESP. EB DATA",$J,"DISP",TCTR)) Q:TCTR=""  D
 . S LCT=LCT+1,DISPDATA(LCT)=$$FO^IBCNEUT1($G(^TMP("EIV RESP. EB DATA",$J,"DISP",TCTR,0)),76)
 ; restore VALM page-counter values to pre-IBCNES values (IB*519)
 ; IB*2.0*521/ZEB use $G to prevent crash when report is run from outside of a ListMan context
 I $G(IBVLSV) S VALM("LINES")=$P(IBVLSV,U,2),VALMCNT=$P(IBVLSV,U),^TMP("IBCNBLE",$J,VALMCNT,0)=$P(IBVLSV,U,3) K IBVLSV
 ; /IB*2.0*506 End
 ;
 Q
 ;
WRAPIT(ITEM,RCTR,DARRAY,MAX,INDENT) ; Module to wrap text into a display array.
 ;   ITEM = Text to be wrapped.
 ;   RCTR = Current Record counter.
 ;   DARRAY = Current Display Array.
 ;   MAX = Maximum number of characters for one line before wrapping.
 ;   INDENT = Character position to indent extra text when wrapping.
 ;
 N TXT,I,SPACE
 S TXT=ITEM,$P(SPACE," ",INDENT)=" "
 F  D  Q:'$L(TXT)
 .S DARRAY(RCTR)=$E(TXT,1,MAX)
 .S TXT=$E(TXT,MAX+1,$L(TXT)) Q:'$L(TXT)
 .S RCTR=RCTR+1
 .S TXT=SPACE_TXT
 Q
