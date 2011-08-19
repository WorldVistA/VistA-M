FBFHLX ;WOIFO/SAB-TRANSMIT HL7 MESSAGES TO FPPS ;10/8/2003
 ;;3.5;FEE BASIS;**61**;JULY 18, 2003
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 Q
 ;
EN ; Entry Point
 ;   may be called by scheduled option as non-interactive task
 ;   may be called by user menu option as interactive task
 ;
 N FBMODE,FBQUIT
 S FBQUIT=0
 ;
 ; Determine Mode - (A)LL PENDING or BY SELECTED (I)NVOICE
 I $E(IOST,1,2)'="C-" S FBMODE="A" ; non-interactive is always ALL
 I $E(IOST,1,2)="C-" D
 . ; ask mode
 . W !,"This option transmits HL7 messages to FPPS for EDI invoices."
 . S DIR(0)="S^I:By Specified Invoice;A:All Pending Invoices"
 . S DIR("A")="Select Transmission Option"
 . S DIR("?",1)="Enter I to transmit a single invoice or A to transmit"
 . S DIR("?",2)="all pending invoices.  If I is entered then you will be"
 . S DIR("?",3)="asked to select the invoice."
 . S DIR("?",4)=""
 . S DIR("?")="Enter a code from the list."
 . D ^DIR K DIR I $D(DIRUT) S FBQUIT=1 Q
 . S FBMODE=Y
 . ; confirm all
 . I FBMODE="A" D
 . . S DIR(0)="Y",DIR("A")="Transmit all pending invoices now"
 . . D ^DIR K DIR I 'Y!$D(DIRUT) S FBQUIT=1 Q
 Q:FBQUIT
 ;
 I FBMODE="A" D ALL
 I FBMODE="I" D BYINV
 ;
 Q
 ;
ALL ; Transmit All Pending Invoices (interactive and non-interactive)
 ; input
 ;   FBQUIT - boolean value (0 or 1), true if process should stop
 ; output
 ;   FBQUIT - may change value
 ;
 N FBCNT,FBERR,FBHL,FBQDA,FBSTA,FBTTYP,FBXL,FBXMIT,HLFS,HLECH
 ;
 ; init
 S FBXL=20 ; last line used for message text (save 20 lines for header)
 S FBCNT("PENDT")=0 ; count of pending invoices that were transmitted
 S FBCNT("PENDE")=0 ; count of pending invoices that had exception
 ;
 ; save time that process started
 S FBXMIT("START")=$$NOW^XLFDT()
 I $E(IOST,1,2)="C-" W !!,"Starting Process..."
 ;
 ; initialize HL variables
 D INIT^HLFNC2("FB FEE TO FPPS EVENT",.FBHL)
 I $G(FBHL) D
 . S FBQUIT=1
 . D PTXT^FBFHLX1(.FBXL,"Error: Unable to initialize HL variables.")
 . D PTXT^FBFHLX1(.FBXL,FBHL)
 E  D
 . S HLFS=FBHL("FS")
 . S HLECH=FBHL("ECH")
 ;
 ; check for transmitted invoices w/o commit ACK
 S FBXMIT("ACK")=$$NOW^XLFDT()
 I 'FBQUIT,$E(IOST,1,2)="C-" W !!,"Checking for acknowledgements..."
 I 'FBQUIT D CHKACK^FBFHLX1
 ;
 S FBXMIT("SEND")=$$NOW^XLFDT()
 I 'FBQUIT,$E(IOST,1,2)="C-" W !!,"Transmitting Pending Invoices..."
 ; loop thru pending invoices and transmit
 S FBQDA=0 F  S FBQDA=$O(^FBHL(163.5,"AC",0,FBQDA)) Q:'FBQDA!FBQUIT  D
 . ; check for taskman quit request
 . I $D(ZTQUEUED),$$S^%ZTLOAD S ZTSTOP=1,FBQUIT=1 Q
 . ; try to transmit invoice
 . D INVOICE
 . ; update counters based on result
 . I FBERR S FBCNT("PENDE")=FBCNT("PENDE")+1
 . E  S FBCNT("PENDT")=FBCNT("PENDT")+1
 ;
 ; save time that process ended
 S FBXMIT("END")=$$NOW^XLFDT()
 I $E(IOST,1,2)="C-" W !!,"Process complete. Sending Summary Message to G.FEE..."
 ;
 ; build and send summary mail message to G.FEE
 D SUMMSG^FBFHLX1
 ;
 ; clean-up
 K ^TMP($J,"FBE"),^TMP($J,"FBNA"),^TMP($J,"FBW"),^TMP($J,"FBX")
 ;
 Q
 ;
BYINV ; Transmit Selected Invoices (interactive)
 ;
 N FBAAIN,FBERR,FBHL,FBQDA,FBSTA,FBTTYP,FBX,HLFS,HLECH
 ;
 ; initialize HL variables
 D INIT^HLFNC2("FB FEE TO FPPS EVENT",.FBHL)
 I $G(FBHL) D  Q
 . W !,$C(7),"ERROR: Couldn't initialize HL variables!"
 . W !,FBHL
 S HLFS=FBHL("FS")
 S HLECH=FBHL("ECH")
 ;
 ; select invoice
 F  Q:FBQUIT  D
 . S DIC="^FBHL(163.5,",DIC(0)="AEQM"
 . D ^DIC I Y'>0 S FBQUIT=1 Q
 . S FBQDA=+Y
 . ;
 . ; get invoice number and switch to last entry for invoice
 . S FBAAIN=$P($G(^FBHL(163.5,FBQDA,0)),U)
 . S FBQDA=$$LAST^FBFHLU(FBAAIN)
 . I 'FBQDA W !,"Error, invalid data for invoice ",FBAAIN," in file 163.5" Q
 . S FBQY=$G(^FBHL(163.5,FBQDA,0))
 . ;
 . ; confirm
 . S FBX=$S($P(FBQY,U,3)=0:"",1:"re-")
 . S DIR(0)="Y"
 . S DIR("A")="Do you want to "_FBX_"transmit invoice "_FBAAIN
 . D ^DIR K DIR S:$D(DIRUT) FBQUIT=1 I 'Y Q
 . ;
 . ; if re-transmit then create a new pending entry for invoice
 . I FBX="re-" D
 . . D FILEQUE^FBFHLL(FBAAIN,$P(FBQY,U,2))
 . . S FBQDA=$$LAST^FBFHLU(FBAAIN)
 . . I FBQDA S FBQY=$G(^FBHL(163.5,FBQDA,0))
 . . E  S FBQY=""
 . ;
 . ; check that pending entry was added
 . I FBX="re-",$P(FBQY,U,3)'=0 D  Q
 . . W !,"Error adding entry to file 163.5. Can't re-transmit invoice."
 . ;
 . ; transmit specified invoice
 . D INVOICE
 . ;
 . ; report success or failure of transmit
 . I FBERR=0 W !,"Invoice has been transmitted to the HL7 package.",!!
 . I FBERR=1 D
 . . N FBL
 . . W $C(7),!,"Problems prevented transmission of the invoice."
 . . S FBL=0 F  S FBL=$O(^TMP($J,"FBE",FBAAIN,FBL)) Q:'FBL  D
 . . . W !,"  ",$G(^TMP($J,"FBE",FBAAIN,FBL))
 . . W !
 . ;
 . ; clean up after transmit
 . K ^TMP($J,"FBE",FBAAIN)
 . K ^TMP($J,"FBW",FBAAIN)
 ;
 Q
 ;
INVOICE ; transmit invoice
 ; input
 ;   FBQDA - ien of entry in file 163.5 to transmit, required
 ; output
 ;   FBERR - error flag (0 or 1), true if error prevented transmit
 ;   FBSTA  - station number in transmitted message (may be null if err)
 ;   FBTTYP - transaction type in transmitted message (may be null)
 ;   ^TMP($J,"FBE",invoice number,#) - any exceptions
 ;   ^TMP($J,"FBW",invoice number,#) - any warnings
 ;
 ; N FBAAIN,FBD,FBFILE,FBRESULT,FBQY
 ;
 ; initialize
 S FBERR=0
 S FBSTA=""
 S FBTTYP=""
 ;
 ; check for required input
 I '$G(FBQDA) S FBERR=1 Q
 ;
 ; lock record
 L +^FBHL(163.5,FBQDA):10
 I '$T D  Q
 . S FBERR=1
 . S FBAAIN=+$P($G(^FBHL(163.5,FBQDA,0)),U)
 . I FBAAIN D POST^FBFHLU(FBAAIN,"E","Couldn't Lock Entry "_FBQDA_" in File 163.5.")
 ;
 ; get invoice number and file number
 I 'FBERR D
 . N FBQY
 . S FBQY=$G(^FBHL(163.5,FBQDA,0))
 . S FBAAIN=+$P(FBQY,U)
 . I 'FBAAIN D
 . . S FBERR=1
 . . D POST^FBFHLU(0,"E","Couldn't determine invoice # for entry "_FBQDA_" in file 163.5.")
 . Q:FBERR
 . S FBFILE=$P(FBQY,U,2)
 . I "^3^5^9^"'[(U_FBFILE_U) D
 . . S FBERR=1
 . . D POST^FBFHLU(FBAAIN,"E","Invalid File # for entry "_FBQDA_" in file 163.5.")
 ;
 ; gather invoice data
 I 'FBERR D @("EN^FBFHLD"_FBFILE) I $D(^TMP($J,"FBE",FBAAIN)) S FBERR=1
 S FBTTYP=$P($G(FBD(0,"INV")),U,2)
 S FBSTA=$P($G(FBD(0,"INV")),U,3)
 ;
 ; build HL segments
 I 'FBERR D EN^FBFHLS I $D(^TMP($J,"FBE",FBAAIN)) S FBERR=1
 ;
 ; generate HL message
 I 'FBERR D
 . K FBRESULT
 . D GENERATE^HLMA("FB FEE TO FPPS EVENT","GM",1,.FBRESULT)
 . I +$P(FBRESULT,U,2) D
 . . S FBERR=1
 . . D POST^FBFHLU(FBAAIN,"E","HL ERR:"_$P(FBRESULT,U,3))
 ;
 ; update file 163.5
 I 'FBERR D
 . N FBFDA
 . S FBFDA(163.5,FBQDA_",",2)="1" ; set status = transmitted
 . S FBFDA(163.5,FBQDA_",",3)=$P(FBRESULT,U) ; message ID
 . S FBFDA(163.5,FBQDA_",",4)=$$NOW^XLFDT() ; message date/time
 . S FBFDA(163.5,FBQDA_",",5)=FBTTYP ; transaction type
 . S FBFDA(163.5,FBQDA_",",6)=FBSTA ; station number
 . I $D(FBFDA) D FILE^DIE("","FBFDA")
 . ;
 . ; store HL segments in word-processing field
 . D MOVEHL
 . D WP^DIE(163.5,FBQDA_",",7,"","^TMP($J,""FBHLSEG"")")
 . K ^TMP($J,"FBHLSEG")
 ;
 ; unlock record
 L -^FBHL(163.5,FBQDA)
 ;
 ; clean-up
 K ^TMP("HLS",$J)
 Q
 ;
MOVEHL ; Copy HL segment data into word-processing style array
 ; input
 ; ^TMP("HLS",$J, array
 ; output
 ; ^TMP($J,"HLSEG",#)=line of text
 ;  there will be a blank line after each segment
 ;
 N FBI,FBII,FBL
 K ^TMP($J,"FBHLSEG")
 S FBL=0
 S FBI=0 F  S FBI=$O(^TMP("HLS",$J,FBI)) Q:'FBI  D
 . S FBL=FBL+1,^TMP($J,"FBHLSEG",FBL)=$G(^TMP("HLS",$J,FBI))
 . S FBII=0 F  S FBII=$O(^TMP("HLS",$J,FBI,FBII)) Q:'FBII  D
 . . S FBL=FBL+1,^TMP($J,"FBHLSEG",FBL)=$G(^TMP("HLS",$J,FBI,FBII))
 . S FBL=FBL+1,^TMP($J,"FBHLSEG",FBL)=""
 Q
 ;
 ;FBFHLX
