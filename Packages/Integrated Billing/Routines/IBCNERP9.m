IBCNERP9 ;DAOU/BHS - eIV STATISTICAL REPORT PRINT ;12-JUN-2002
 ;;2.0;INTEGRATED BILLING;**184,271,416,506,528,621,687**;21-MAR-94;Build 88
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ; eIV - Insurance Verification Interface
 ;
 ; Input variables from IBCNERP7:
 ;  IBCNERTN = "IBCNERP7"
 ; **IBCNESPC array ONLY passed by reference
 ;  IBCNESPC("BEGDTM") = Start Date/Time for date/time report range
 ;  IBCNESPC("ENDDTM") = End Date/Time for date/time report range
 ;  IBCNESPC("SECTS") = 1 - All, includes all sections OR
 ;   list of one or more of the following:
 ;   2 - Outgoing Data, Inquiry Transmission data,
 ;   3 - Incoming Data, Inquiry Response data,
 ;   4 - General Data, Insurance Buffer data,
 ;   Communication Failures, Outstanding Inquiries
 ;   IBCNESPC("MM") = "", do not generate MailMan message OR
 ;                    MAILGROUP, mailgroup to send MailMan message to
 ;                               based on IB site parameter
 ;   Assumes report data exists in ^TMP($J,IBCNERTN,...)
 ;   Based on IBCNESPC("SECTS") parameter the following scratch globals
 ;   will be built
 ;   1 OR contains 2 --> 
 ;    ^TMP($J,RTN,"OUT")=TotInq^InsBufExtSubtotal^PreRegExtSubtotal^...
 ;                       NonVerifInsExtSubtotal^NoActInsExtSubtotal
 ;   1 OR contains 3 --> 
 ;    ^TMP($J,RTN,"IN")=TotResp^InsBufExtSubtotal^PreRegExtSubtotal^...
 ;                       NonVerifInsExtSubtotal^NoActInsExtSubtotal
 ;   1 OR contains 4 --> 
 ;    ^TMP($J,RTN,"CUR")=TotOutstandingInq^TotInqRetries^...
 ;                       TotInqCommFailure^TotInsBufVerified^...
 ;                       ManVerifedSubtotal^eIVProcessedSubtotal...
 ;                       TotInsBufUnverified^! InsBufSubtotal^...
 ;                       ? InsBufSubtotal^- InsBufSubtotal^...
 ;                       Other InsBufSubtotal^TQReadyToTransmit^...
 ;                       TQHold^TQRetry
 ;    and ^TMP($J,RTN","PYR",APP,PAYER NAME,IEN of file 365.12)="" ;IB*2*687
 ;    IBOUT = "E" for Excel or "R" for report format
 ;
 ;  ckb-IB*2*687  Added APP to incorporate IIU into this rpt; corrected
 ;           references from Nationally active & locally active to
 ;           Nationally and Locally enabled. Utilized "TXT" to consolidate
 ;           display code of different labels.
 Q
 ;
EN(IBCNERTN,IBCNESPC,IBOUT) ; Entry pt
 N CRT,MAXCNT,IBPXT,IBPGC,IBBDT,IBEDT,IBSCT,IBMM,RETRY,OUTINQ,ATTEMPT
 N X,Y,DIR,DTOUT,DUOUT,LIN,IBMBI,IBQUERY
 ;
 S IBBDT=$G(IBCNESPC("BEGDTM")),IBEDT=$G(IBCNESPC("ENDDTM"))
 S IBSCT=$G(IBCNESPC("SECTS")),IBMM=$G(IBCNESPC("MM"))
 ;
 S (IBPXT,IBPGC,CRT,MAXCNT)=0
 ;
 ; Determine IO parameters if output device is NOT MailMan message
 I IBMM="" D
 . I IOST["C-" S MAXCNT=IOSL-3,CRT=1 Q
 . S MAXCNT=IOSL-6,CRT=0
 ;
 D PRINT(IBCNERTN,IBBDT,IBEDT,IBSCT,IBMM,.IBPGC,.IBPXT,MAXCNT,CRT,IBOUT)
 I $G(ZTSTOP)!IBPXT G EXIT
 I CRT,IBPGC>0,'$D(ZTQUEUED) D  G EXIT
 . I MAXCNT<51 F LIN=1:1:(MAXCNT-$Y) W !
 . S DIR(0)="E" D ^DIR K DIR
 ;
EXIT ; Exit pt
 Q
 ;
PRINT(RTN,BDT,EDT,SCT,MM,PGC,PXT,MAX,CRT,IBOUT) ; Print data
 N APP,EORMSG,NONEMSG,LINECT,DISPDATA,HDRDATA,OFFSET,TMP,DTMRNG,SITE ;IB*2*687
 ;
 S LINECT=0
 ;
 ; Build End-Of-Report Message for display
 S EORMSG="*** END OF REPORT ***"
 S OFFSET=80-$L(EORMSG)\2
 S EORMSG=$$FO^IBCNEUT1(EORMSG,OFFSET+$L(EORMSG),"R")
 ; Build No-Data-Found Message for display
 S NONEMSG="* * * N O  D A T A  F O U N D * * *"
 S OFFSET=80-$L(NONEMSG)\2
 S NONEMSG=$$FO^IBCNEUT1(NONEMSG,OFFSET+$L(NONEMSG),"R")
 ; Build Site for display
 S SITE=$P($$SITE^VASITE,U,2)
 ; Build Date/Time Range for display
 ;  Starting date/time
 S TMP=$$FMTE^XLFDT(BDT,"5Z")
 S DTMRNG=$P(TMP,"@")_" "_$P(TMP,"@",2)
 ;  Ending date/time
 S TMP=$$FMTE^XLFDT(EDT,"5Z")
 S DTMRNG=DTMRNG_" - "_$P(TMP,"@")_" "_$P(TMP,"@",2)
 ;
 ; Print hdr to DISPDATA for MailMan message ONLY
 I IBOUT="R" D HEADER(.HDRDATA,.PGC,.PXT,MAX,CRT,SITE,DTMRNG,MM)
 I MM'="" M DISPDATA=HDRDATA S LINECT=+$O(DISPDATA(""),-1)
 I MM="" KILL HDRDATA
 ;
 ; If global does not exist - display No Data message
 I '$D(^TMP($J,RTN)) S LINECT=LINECT+1,DISPDATA(LINECT)=NONEMSG G PRINT2
 ;
 ; Display Outgoing Data - if selected
 I SCT=1!(SCT[2) D  I PXT!$G(ZTSTOP) G PRINTX
 . D DATA(.DISPDATA,.LINECT,RTN,"OUT",MM,IBOUT)
 ;
 ; Display Incoming Data - if selected
 I SCT=1!(SCT[3) D  I PXT!$G(ZTSTOP) G PRINTX
 . D DATA(.DISPDATA,.LINECT,RTN,"IN",MM,IBOUT)
 ;
 ; Display General Data - if selected
 I SCT=1!(SCT[4) D  I PXT!$G(ZTSTOP) G PRINTX
 . D DATA(.DISPDATA,.LINECT,RTN,"CUR",MM,IBOUT)
 . ;ckb-IB*2*687 - Get display data for both EIV and IIU payers
 . F APP="EIV","IIU" D
 . . D DATA(.DISPDATA,.LINECT,RTN,"PYR",MM,IBOUT)
 . . D DATA(.DISPDATA,.LINECT,RTN,"FLG",MM,IBOUT)
 ;
PRINT2 S LINECT=LINECT+1
 S DISPDATA(LINECT)=EORMSG
 ;
 I MM="" D LINE(.DISPDATA,.PGC,.PXT,MAX,CRT,SITE,DTMRNG,MM)
 ; Generate MailMan message, if flag is set
 I MM'="" D MSG^IBCNEUT5(MM,"** eIV Statistical Rpt **","DISPDATA(")
 ;
PRINTX ; PRINT exit pt
 Q
 ;
LINE(DISPDATA,PGC,PXT,MAX,CRT,SITE,DTMRNG,MM) ; Print line of data
 N CT,II,ARRAY,NWPG
 ;
 S NWPG=0
 S CT=+$O(DISPDATA(""),-1)
 I $Y+1+CT>MAX,PGC>1 D HEADER(.ARRAY,.PGC,.PXT,MAX,CRT,SITE,DTMRNG,MM) S NWPG=1 I PXT!$G(ZTSTOP) G LINEX
 F II=1:1:CT D  Q:PXT!$G(ZTSTOP)
 . I $Y+1>MAX!('PGC) D HEADER(.ARRAY,.PGC,.PXT,MAX,CRT,SITE,DTMRNG,MM) S NWPG=1 I PXT!$G(ZTSTOP) Q
 . I 'NWPG!(NWPG&($D(DISPDATA(II)))) I $G(DISPDATA(II))'="" W !,?1,DISPDATA(II)
 . I NWPG S NWPG=0
LINEX ; LINE exit pt
 Q
 ;
DATA(DISPDATA,LINECT,RTN,TYPE,MM,IBOUT) ; Format lines of data to be printed
 ; IB*528 - baa : added code to output to Excel 
 N DASHES,PEND,RPTDATA,CT,DEFINQ,INSCOS,PAYERS,QUEINQ,TXT,TYPE1
 ;
 S $P(DASHES,"=",14)="",TYPE1=TYPE ; IB*2*621
 I LINECT>0,MM="" S LINECT=LINECT+1,DISPDATA(LINECT)=""
 ;
 ; Copy report data to local variable
 S RPTDATA=$G(^TMP($J,RTN,TYPE))      ; does not work for "PYR"
 ; Outgoing and Incoming Totals
 I TYPE="OUT"!(TYPE="IN") D  S:IBOUT="R" LINECT=LINECT+1,DISPDATA(LINECT)=" " G DATAX  ; IB*2*621 
 . S LINECT=LINECT+1
 . I IBOUT="R" S DISPDATA(LINECT)=$$FO^IBCNEUT1($S(TYPE="OUT":"Outgoing Data (Inquiries Sent)",1:"Incoming Data (Responses Received)"),46)_$$FO^IBCNEUT1(+$P(RPTDATA,U,1),14,"R") ; IB*2*621 
 . I IBOUT="E" S DISPDATA(LINECT)=$S(TYPE="OUT":"OUTGOING DATA",1:"INCOMING DATA")_U_+$P(RPTDATA,U,1)
 . S LINECT=LINECT+1
 . I IBOUT="R" S DISPDATA(LINECT)=DASHES ; IB*2*621
 . F CT=1:1:5 D  ; Updated for IB*2*621
 . . N TYPE ; 
 . . I TYPE1="IN" S TYPE=$S(CT=1:"Insurance Buffer",CT=2:"Appointment",CT=3:"Electronic Insurance Coverage Discovery (EICD)",CT=4:"EICD-Triggered eInsurance Verification",CT=5:"MBI Response")
 . . I TYPE1="OUT" S TYPE=$S(CT=1:"Insurance Buffer",CT=2:"Appointment",CT=3:"Electronic Insurance Coverage Discovery (EICD)",CT=4:"EICD-Triggered eInsurance Verification",CT=5:"MBI Inquiry")
 . . S LINECT=LINECT+1
 . . I IBOUT="E" S DISPDATA(LINECT)=TYPE_U_+$P(RPTDATA,U,CT+1)
 . . I IBOUT="R" S DISPDATA(LINECT)=$$FO^IBCNEUT1("   "_TYPE,50)_$$FO^IBCNEUT1(+$P(RPTDATA,U,CT+1),25,"R")
 ;
 ; General Data
 I TYPE="CUR" D  G DATAX
 . S LINECT=LINECT+1 ; IB*2*621 - Added Status Label
 . I IBOUT="R" S DISPDATA(LINECT)="Current Status",LINECT=LINECT+1,DISPDATA(LINECT)="=============="
 . I IBOUT="E" S DISPDATA(LINECT)="CURRENT STATUS"
 . ;
 . ; IB*2*621 - Updated Responses pending for EICD
 . S PEND=+$P(RPTDATA,U,1)
 . S LINECT=LINECT+1
 . S TXT="Responses Pending"
 . I IBOUT="E" S DISPDATA(LINECT)=TXT_U_PEND
 . I IBOUT="R" S DISPDATA(LINECT)=$$FO^IBCNEUT1(TXT_":",46)_$$FO^IBCNEUT1(PEND,14,"R")
 . ;
 . S PEND=+$P(RPTDATA,U,17)
 . S LINECT=LINECT+1
 . S TXT="Insurance Buffer"
 . I IBOUT="E" S DISPDATA(LINECT)=TXT_U_PEND
 . I IBOUT="R" S DISPDATA(LINECT)=$$FO^IBCNEUT1("   "_TXT,60)_$$FO^IBCNEUT1(PEND,15,"R")
 . ;
 . S PEND=+$P(RPTDATA,U,18)
 . S LINECT=LINECT+1
 . S TXT="Appointment"
 . I IBOUT="E" S DISPDATA(LINECT)=TXT_U_PEND
 . I IBOUT="R" S DISPDATA(LINECT)=$$FO^IBCNEUT1("   "_TXT,60)_$$FO^IBCNEUT1(PEND,15,"R")
 . ;
 . S PEND=+$P(RPTDATA,U,19)
 . S LINECT=LINECT+1
 . S TXT="Electronic Insurance Coverage Discovery (EICD)"
 . I IBOUT="E" S DISPDATA(LINECT)=TXT_U_PEND
 . I IBOUT="R" S DISPDATA(LINECT)=$$FO^IBCNEUT1("   "_TXT,60)_$$FO^IBCNEUT1(PEND,15,"R")
 . ;
 . S PEND=+$P(RPTDATA,U,20)
 . S LINECT=LINECT+1
 . S TXT="EICD-Triggered eInsurance Verification"
 . I IBOUT="E" S DISPDATA(LINECT)=TXT_U_PEND
 . I IBOUT="R" S DISPDATA(LINECT)=$$FO^IBCNEUT1("   "_TXT,60)_$$FO^IBCNEUT1(PEND,15,"R")
 . ;
 . S PEND=+$P(RPTDATA,U,21)
 . S LINECT=LINECT+1
 . S TXT="MBI Inquiry"
 . I IBOUT="E" S DISPDATA(LINECT)=TXT_U_PEND
 . I IBOUT="R" S DISPDATA(LINECT)=$$FO^IBCNEUT1("   "_TXT,60)_$$FO^IBCNEUT1(PEND,15,"R")
 . ;
 . S QUEINQ=+$P(RPTDATA,U,2)
 . S LINECT=LINECT+1
 . S TXT="Queued Inquiries"
 . I IBOUT="E" S DISPDATA(LINECT)=TXT_U_QUEINQ
 . I IBOUT="R" S DISPDATA(LINECT)=$$FO^IBCNEUT1(TXT_":",46)_$$FO^IBCNEUT1(QUEINQ,14,"R")
 . ;
 . S DEFINQ=+$P(RPTDATA,U,3)
 . S LINECT=LINECT+1
 . S TXT="Deferred Inquiries:"
 . I IBOUT="E" S DISPDATA(LINECT)=TXT_U_DEFINQ
 . I IBOUT="R" S DISPDATA(LINECT)=$$FO^IBCNEUT1(TXT,46)_$$FO^IBCNEUT1(DEFINQ,14,"R")
 . ;
 . S INSCOS=+$P(RPTDATA,U,4)
 . S LINECT=LINECT+1
 . S TXT="Insurance Companies w/o National ID"
 . I IBOUT="E" S DISPDATA(LINECT)=TXT_U_INSCOS
 . I IBOUT="R" S DISPDATA(LINECT)=$$FO^IBCNEUT1(TXT_":",46)_$$FO^IBCNEUT1(INSCOS,14,"R")
 . ;
 . ;ckb-IB*2*687 - Changed the wording from "Disabled Locally".
 . S PAYERS=+$P(RPTDATA,U,5)
 . S LINECT=LINECT+1
 . S TXT="eIV Payers 'Locally Enabled' is NO"
 . I IBOUT="E" S DISPDATA(LINECT)=TXT_U_PAYERS
 . I IBOUT="R" S DISPDATA(LINECT)=$$FO^IBCNEUT1(TXT_":",46)_$$FO^IBCNEUT1(PAYERS,14,"R")
 . I IBOUT="R" S LINECT=LINECT+1
 . ;
 . ;ckb-IB*2*687 - Added this to the report.
 . S PAYERS=+$P(RPTDATA,U,22)
 . S LINECT=LINECT+1
 . S TXT="IIU Payers 'Receive IIU Data' is NO:"
 . I IBOUT="E" S DISPDATA(LINECT)=TXT_U_PAYERS
 . I IBOUT="R" S DISPDATA(LINECT)=$$FO^IBCNEUT1(TXT,46)_$$FO^IBCNEUT1(PAYERS,14,"R")
 . I IBOUT="R" S LINECT=LINECT+1,DISPDATA(LINECT)=" "
 . ;
 . ; Insurance Buffer statistics
 . S LINECT=LINECT+1
 . S TXT="Insurance Buffer Entries:"
 . I IBOUT="E" S DISPDATA(LINECT)=TXT_" "_U_($P(RPTDATA,U,6)+$P(RPTDATA,U,9))
 . I IBOUT="R" S DISPDATA(LINECT)=$$FO^IBCNEUT1(TXT_" ",46)_$$FO^IBCNEUT1(($P(RPTDATA,U,6)+$P(RPTDATA,U,9)),14,"R") ; IB*2*621
 . ;
 . ; *,+,#,! or -  symbol entries - User action required
 . S LINECT=LINECT+1
 . S TXT="User Action Required"
 . I IBOUT="E" S DISPDATA(LINECT)=TXT_U_+$P(RPTDATA,U,6)
 . I IBOUT="R" S DISPDATA(LINECT)=$$FO^IBCNEUT1("  "_TXT_": ",46)_$$FO^IBCNEUT1(+$P(RPTDATA,U,6),22,"R")
 . I IBOUT="R" F CT=8,15,16,13,10,11 D  ; IB*2*621
 . . S LINECT=LINECT+1
 . . S TYPE="    # of "
 . . ;I CT=7 S TXT="* entries (User Verified policy)" ;ckb-IB*2*687 - This line should have been commented out years ago.
 . . I CT=8 S TXT="+ entries (Payer indicated Active policy)"
 . . I CT=10 S TXT="# entries (Policy status undetermined)"
 . . I CT=11 S TXT="! entries (eIV needs user assistance for entry)"
 . . I CT=13 S TXT="- entries (Payer indicated Inactive policy)"
 . . I CT=15 S TXT="$ entries (Escalated, Active policy)"
 . . I CT=16 S TXT="% entries (MBI value received)" ; IB*2*621
 . . S TYPE=TYPE_TXT
 . . S DISPDATA(LINECT)=$$FO^IBCNEUT1(TYPE,56)_$$FO^IBCNEUT1(+$P(RPTDATA,U,CT),19,"R")
 . ;
 . S LINECT=LINECT+1
 . S TXT="Entries Awaiting Processing"
 . I IBOUT="E" S DISPDATA(LINECT)=TXT_U_+$P(RPTDATA,U,9)
 . I IBOUT="R" S DISPDATA(LINECT)=$$FO^IBCNEUT1("  "_TXT_": ",46)_$$FO^IBCNEUT1(+$P(RPTDATA,U,9),22,"R")
 . ;
 . S LINECT=LINECT+1
 . S TXT="# of ? entries (eIV is waiting for a response)"
 . I IBOUT="E" S DISPDATA(LINECT)=TXT_U_+$P(RPTDATA,U,12)
 . I IBOUT="R" S DISPDATA(LINECT)=$$FO^IBCNEUT1("    "_TXT,56)_$$FO^IBCNEUT1(+$P(RPTDATA,U,12),19,"R")
 . ;
 . S LINECT=LINECT+1
 . S TXT="# of blank entries (yet to be processed or accepted)"
 . I IBOUT="E" S DISPDATA(LINECT)=TXT_U_+$P(RPTDATA,U,14)
 . I IBOUT="R" S DISPDATA(LINECT)=$$FO^IBCNEUT1("    "_TXT,56)_$$FO^IBCNEUT1(+$P(RPTDATA,U,14),19,"R")
 ;
 S LINECT=LINECT+1 ; IB*2*621-Blank Line 
 I IBOUT="R" S DISPDATA(LINECT)=" " ; IB*2*621 
 ; New Payers added to File 365.12
 ;ckb-IB*2*687 - Modified code below to include APP (EIV or IIU)
 I TYPE="PYR" I APP="EIV" D  G DATAX
 . ; Payers added to file 365.12
 . D DATAX
 . S LINECT=LINECT+1 ; IB*2*621
 . I IBOUT="E" S DISPDATA(LINECT)="PAYER ACTIVITY (During Report Date Range)" ; IB*2*621
 . I IBOUT="R" S DISPDATA(LINECT)="Payer Activity (During Report Date Range)" ; IB*2*621
 . I IBOUT="R" S LINECT=LINECT+1,DISPDATA(LINECT)="=============="
 . S LINECT=LINECT+1
 . S DISPDATA(LINECT)="New eIV Payers received:" ; IB*2*621
 . S LINECT=LINECT+1
 . I IBOUT="R" S DISPDATA(LINECT)="------------------------"
 . S LINECT=LINECT+1
 . I '$D(^TMP($J,RTN,TYPE,APP)) S DISPDATA(LINECT)=" No new eIV Payers added" Q
 . ;ckb-IB*2*687 - Modified the Edit description for New eIV Payers received.
 . S DISPDATA(LINECT)=" Please link the associated active insurance companies to these payers at your"
 . S LINECT=LINECT+1,DISPDATA(LINECT)=" earliest convenience. Locally enable the payers after you link insurance"
 . S LINECT=LINECT+1,DISPDATA(LINECT)=" companies to them. For further details regarding this process, please refer"
 . S LINECT=LINECT+1,DISPDATA(LINECT)=" to the Electronic Insurance Verification User Guide."
 . D BLDPYR ;IB*2*687
 . ;ckb-IB*2*687 Modified FLG from A to NE and T to AU
 I TYPE="FLG" I APP="EIV" D  G DATAX ; IB*2*621 Added Payer Received
 . N DATA,PNAME,Z,FLG
 . F FLG="NE","AU" D
 . . I FLG="NE" D
 . . . I IBOUT="R" S DISPDATA(LINECT)=" "
 . . . ;ckb-IB*2*687 - Changed the text to be printed from "National Payers - ACTIVE flag changes at FSC:".
 . . . S LINECT=LINECT+1,DISPDATA(LINECT)="eIV Payers - FSC changed the 'Nationally Enabled' field:"
 . . . I IBOUT="R" S LINECT=LINECT+1,DISPDATA(LINECT)="--------------------------------------------------------"
 . . . Q
 . . I FLG="AU" D
 . . . I IBOUT="R" S LINECT=LINECT+1,DISPDATA(LINECT)=" "
 . . . ;ckb-IB*2*687 - Changed the text to be printed from "Nationally Active Payers - TRUSTED flag changes at FSC:".
 . . . S LINECT=LINECT+1,DISPDATA(LINECT)="eIV Payers - FSC changed the 'Auto Update' field:"
 . . . I IBOUT="R" S LINECT=LINECT+1,DISPDATA(LINECT)="-------------------------------------------------"
 . . . Q
 . . I '$D(^TMP($J,RTN,"CUR","FLAGS",APP,FLG)) D  Q
 . . . S LINECT=LINECT+1,DISPDATA(LINECT)=" No information available",LINECT=LINECT+1
 . . D BLDFLG ;ckb-IB*2*687 - added to be used to by eIV and IIU Payers to build flag log info.
 . . Q
 ;ckb-IB*2*687 - Add IIU Payers info to report.
 I TYPE="PYR" I APP="IIU" D  G DATAX
 . S LINECT=LINECT+1
 . S DISPDATA(LINECT)="New IIU Payers received:"
 . S LINECT=LINECT+1
 . I IBOUT="R" S DISPDATA(LINECT)="------------------------"
 . S LINECT=LINECT+1
 . I '$D(^TMP($J,RTN,TYPE,APP)) S DISPDATA(LINECT)=" No new IIU Payers added" Q
 . S DISPDATA(LINECT)=" Please review the payer linking for the associated active insurance companies"
 . S LINECT=LINECT+1,DISPDATA(LINECT)=" to these payers at your earliest convenience. To receive incoming IIU records"
 . S LINECT=LINECT+1,DISPDATA(LINECT)=" from other VAMCs into your buffer, turn ON the 'Receive IIU Data' field for"
 . S LINECT=LINECT+1,DISPDATA(LINECT)=" the payers. For further details regarding this process, please refer to the"
 . S LINECT=LINECT+1,DISPDATA(LINECT)=" Electronic Insurance Verification User Guide."
 . D BLDPYR
 ;
 I TYPE="FLG" I APP="IIU" D  G DATAX
 . N DATA,PNAME,Z
 . I IBOUT="R" S LINECT=LINECT+1,DISPDATA(LINECT)=" "
 . S DISPDATA(LINECT)="IIU Payers - FSC changed the 'Nationally Enabled' field:"
 . I IBOUT="R" S LINECT=LINECT+1,DISPDATA(LINECT)="--------------------------------------------------------"
 . I '$D(^TMP($J,RTN,"CUR","FLAGS",APP,"NE")) D
 . . S LINECT=LINECT+1,DISPDATA(LINECT)=" No information available",LINECT=LINECT+1
 . . S DISPDATA(LINECT)=" "
 . S FLG="NE"
 . D BLDFLG
 . Q
 ;ckb-IB*2*687 End of rewrite due to APP variable. All IIU logic is new with this patch.
DATAX ; DATA exit pt
 S LINECT=LINECT+1
 S DISPDATA(LINECT)=""
 Q
 ;
 ;ckb - Added with IB*2*687
BLDFLG ; Build the data display of the eIV/IIU Payers flags (Nationally Enabled and/or Auto Update) info.
 S PNAME="" F  S PNAME=$O(^TMP($J,RTN,"CUR","FLAGS",APP,FLG,PNAME)) Q:PNAME=""  D
 . S Z="" F  S Z=$O(^TMP($J,RTN,"CUR","FLAGS",APP,FLG,PNAME,Z)) Q:Z=""  D
 . . S DATA=$G(^TMP($J,RTN,"CUR","FLAGS",APP,FLG,PNAME,Z))
 . . S LINECT=LINECT+1
 . . I IBOUT="E" S DISPDATA(LINECT)=PNAME_U_$P(DATA,U)_U_$P(DATA,U,2)
 . . I IBOUT="R" S DISPDATA(LINECT)=$$FO^IBCNEUT1(" "_PNAME,47)_$$FO^IBCNEUT1($P(DATA,U),19)_" Set: "_$P(DATA,U,2)
 Q
 ; 
 ;ckb - Added with IB*2*687
BLDPYR ; Build the data display of the New eIV/IIU Payers info. 
 N PYR,PIEN
 S PYR="" F  S PYR=$O(^TMP($J,RTN,TYPE,APP,PYR)) Q:PYR=""  D
 . S PIEN="" F  S PIEN=$O(^TMP($J,RTN,TYPE,APP,PYR,PIEN)) Q:'PIEN  D
 . . S LINECT=LINECT+1
 . . I IBOUT="E" S DISPDATA(LINECT)=PYR Q
 . . I IBOUT="R" S DISPDATA(LINECT)="   "_PYR
 Q
 ;
HEADER(HDRDATA,PGC,PXT,MAX,CRT,SITE,DTMRNG,MM) ; Print header info for each pg
 ;ckb IB*2*687-Moved from another routine that is no longer assoc w/ this rpt.
 N CT,HDRCT,LIN,HDR
 ;
 ; Prompt to print next page for reports to the screen
 I CRT,PGC>0,'$D(ZTQUEUED) D  I PXT G HEADERX
 . I MAX<51 F LIN=1:1:(MAX-$Y) W !
 . S DIR(0)="E" D ^DIR K DIR
 . I $D(DTOUT)!$D(DUOUT) S PXT=1 Q
 I $D(ZTQUEUED),$$S^%ZTLOAD() S ZTSTOP=1 G HEADERX
 ;
 ; Update page ct
 S PGC=PGC+1
 ;
 ; Update header based on MailMan message flag
 S HDRCT=0
 S HDRCT=HDRCT+1,HDRDATA(HDRCT)="eIV Statistical Report"_$$FO^IBCNEUT1($$FMTE^XLFDT($$NOW^XLFDT,1)_"  Page: "_PGC,56,"R")
 ;S HDRDATA(HDRCT)=$$FO^IBCNEUT1(SITE,(80-$L(SITE)\2)+$L(SITE),"R"),HDRCT=HDRCT+1
 S HDR="Report Timeframe: "_DTMRNG ; IB*2*621 
 S HDRCT=HDRCT+1,HDRDATA(HDRCT)=$$FO^IBCNEUT1(HDR,(80-$L(HDR)\2)+$L(HDR),"R") ; IB*2*621 
 S HDRCT=HDRCT+1,HDRDATA(HDRCT)="" ; IB*2*621 
 ;
 I MM S HDRCT=HDRCT+1,HDRDATA(HDRCT)=""
 ; Only write out Header for non-MailMan message output
 I MM="" W @IOF F CT=1:1:HDRCT W !,?1,HDRDATA(CT)
 ;
HEADERX ; HEADER exit pt
 Q
