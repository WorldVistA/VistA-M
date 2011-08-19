PRCFDO1 ;WOIFO/KCL - IFCAP/OLCS INTERFACE CONT. ;2/24/2011
V ;;5.1;IFCAP;**153**;Oct 20, 2000;Build 10
 ;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ;direct entry not permitted
 Q
 ;
EXTRACT ;Extract 1358 transactions
 ;
 ; This procedure is used to drive the process that will extract
 ; 1358 transactions for FY10 and FY11 and send them to the Online
 ; Certification System via MailMan messages. Each message will
 ; contain a maximum of 100 transaction records (200 message lines
 ; per batch).
 ;
 ; The following 1358 transaction types will be extracted
 ; and sent to OLCS:
 ;  - Initial Obligation (when a 1358 is obligated in IFCAP)
 ;  - Adjustment (increase/decrease to the 1358 obligated in IFCAP)
 ;
 ; Supported IAs:
 ;   #10103: Allows use of supported Kernel call $$NOW^XLFDT
 ;
 ;  Input: None
 ; Output: None
 ;
 N PRC2237 ;Primary 2237-pointer to #410 file
 N PRCPODT ;P.O. Date
 N PRCIEN  ;ien of record in #442 file
 N PRC442Z ;zero node of #442 record
 N PRCMSG  ;closed root msg text array
 N PRCCNT  ;msg line count
 N PRCINS  ;array containing institution data
 N PRCSTAT ;array containing extract statistics
 N PRCPARM ;parameter
 ;
 ;init vars
 S PRCPODT=3090930  ;scan start = 9/30/09
 S PRCCNT=0
 S PRCPARM="PRC OLCS 1358 EXTRACT"
 S PRCMSG=$NA(^TMP("PRCOLCS",$J))
 K @PRCMSG
 ;
 ;obtain site data and place into array
 Q:'$$GETSITE(.PRCINS)
 ;
 ;init extract statistics array
 Q:'$$INSTAT(.PRCINS,.PRCSTAT)
 ;
 ;primary loop thru purchase order creation dates
 F  S PRCPODT=$O(^PRC(442,"AB",PRCPODT)) Q:'PRCPODT  D
 . ;
 . ;secondary loop thru purchase orders for the creation date
 . S PRCIEN=0
 . F  S PRCIEN=$O(^PRC(442,"AB",PRCPODT,PRCIEN)) Q:'PRCIEN  D
 . . ;
 . . ;get zero node of #442 record
 . . S PRC442Z=$G(^PRC(442,PRCIEN,0))
 . . ;
 . . ;quit if Method of Processing '= MISC. OBLIGATION (1358)
 . . Q:$P($G(PRC442Z),U,2)'=21
 . . ;
 . . ;quit if PRIMARY 2237 (pointer to #410) is missing
 . . S PRC2237=$P($G(PRC442Z),U,12)
 . . Q:PRC2237=""
 . . ;
 . . ;get/send 1358 transaction records
 . . Q:'$$GET1358(PRCIEN,PRC2237,.PRCCNT,PRCMSG,.PRCINS,.PRCSTAT)
 ;
 ;send last partial batch of transactions if needed
 I PRCCNT>0 D
 . D MAIL^PRCFDO(PRCMSG) ;send partial batch msg
 . S PRCSTAT("BATCH")=PRCSTAT("BATCH")+1  ;batch count
 . K @PRCMSG  ;cleanup msg text array
 ;
 ;set extract finish date/time into stats array and system parameter
 S PRCSTAT("END")=$$NOW^XLFDT
 S PRCSTAT("PARM")=PRCPARM
 I $$SETPARM("SYS",PRCPARM,1,PRCSTAT("END")) D
 . S PRCSTAT("PARMADD")="Successful"
 E  S PRCSTAT("PARMADD")="***FAILED***"
 ;
 ;send extract stats msg
 D STATS(.PRCSTAT)
 ;
 ;cleanup task in ^XTMP if queued from POST2^PRC153P 
 I +$G(^XTMP("PRC153P","TASK")) K ^XTMP("PRC153P")
 Q
 ;
 ;
GET1358(PRC442R,PRC410P,PRCCNT,PRCMSG,PRCIN,PRCST) ;Get & send 1358 transaction records
 ;
 ; This procedure obtains 1358 transaction records for 1358 initial
 ; obligations and adjustments (increase/decrease). It then sends those
 ; transaction records in a batch of 100 records (200 message lines per batch).
 ;
 ; Supported IAs:
 ;  #3065  Allows use of supported Kernel call $$HLNAME^XLFNAME
 ;  #10103 Allows use of supported Kernel call $$FMTHL7^XLFDT
 ;  #10104 Allows use of supported Kernel call $$UP^XLFSTR
 ;
 ;  Input:
 ;   PRC442R - ien of record in #442 file
 ;   PRC410R - ien of record in #410 file
 ;    PRCCNT - msg line count, pass by reference
 ;    PRCMSG - closed root msg text array
 ;     PRCIN - institution data array, pass by reference
 ;     PRCST - extract statistics array, pass by reference
 ;
 ; Output:
 ;   Function Value - Returns 1 on success, 0 on failure
 ;
 N PRCLIST  ;list of #410 iens
 N PRC410   ;ien of record in #410 file
 N PRC410A  ;1358 Adjustment
 N PRC442I  ;ien of record #442.09 subfile
 N PRC7NODE ;7 node of #410 record
 N PRCAPPID ;Approving Official (ptr to #200 file)
 N PRCEVENT ;1358 event type
 N PRCDNM   ;array for call to HLNAME^XLFNAME
 N PRCOBLID ;Obligated By (ptr to #200 file)
 N PRCOBJ   ;contains 1358 transaction object
 N PRCODY0  ;zero node of #442.09 subfile record
 N PRCREQID ;Requestor (ptr to #200 file)
 N RESULT   ;function return value
 ;
 S RESULT=0
 ;
 ;quit if invalid input params
 Q:+$G(PRC442R)'>0 RESULT
 Q:+$G(PRC410P)'>0 RESULT
 ;
 ;place Facility-Name and Station-Number into 1358 transaction array
 S PRCOBJ("FACNM")=$G(PRCIN("FACNAME"))
 S PRCOBJ("FACNUM")=$G(PRCIN("FACNUMB"))
 ;
 ;loop thru OBLIGATION DATA (#442.09) multiple
 S PRC442I=0
 F  S PRC442I=$O(^PRC(442,PRC442R,10,PRC442I)) Q:'PRC442I  D
 . ;
 . ;get zero node of subfile record
 . S PRCODY0=$G(^PRC(442,PRC442R,10,PRC442I,0))
 . ;
 . ;skip entries that are not SO or AR code sheet (excludes PV)
 . Q:"^SO^AR^"'[(U_$E(PRCODY0,1,2)_U)
 . ;
 . ;1358 Adjustment (ptr to #410 file)
 . S PRC410A=$P(PRCODY0,U,11)
 . ;
 . ;associated #410 entry
 . S PRC410=$S(PRC410A]"":PRC410A,1:PRC410P)
 . ;
 . ;determine event type and if not rebuild add #410 entry to list
 . I $D(PRCLIST(PRC410)) S PRCEVENT="R" ;Rebuild
 . E  S PRCEVENT=$S(PRC410A]"":"A",1:"O"),PRCLIST(PRC410)=""
 . ;
 . ;quit if rebuild since that does not impact certifier role
 . Q:PRCEVENT="R"
 . ;
 . ;Obligation-Number
 . S PRCOBJ("OBLNUM")=$P($G(^PRC(442,PRC442R,0)),U,1)
 . ;
 . ;Transaction-Type
 . S PRCOBJ("TRANTYPE")=PRCEVENT
 . ;
 . ;Event-Date_Time (Date Signed) in HL7 format YYYYMMDDHHMMSS-XXXX
 . ;where (-XXXX is the Greenwich Mean Time offset)
 . S PRCOBJ("OBLDATE")=$$FMTHL7^XLFDT($P(PRCODY0,U,6))
 . ;concatenate '00' seconds if Date Signed was filed precisely on the hour and minute
 . I $L($P(PRCOBJ("OBLDATE"),"-"))=12 D
 . . S PRCOBJ("OBLDATE")=$P(PRCOBJ("OBLDATE"),"-")_"00-"_$P(PRCOBJ("OBLDATE"),"-",2)
 . ;
 . ;get Requestor, Approver, Obligator iens
 . S PRC7NODE=$G(^PRCS(410,PRC410,7))
 . S PRCREQID=$P(PRC7NODE,U,1)
 . S PRCAPPID=$P(PRC7NODE,U,3)
 . S PRCOBLID=$P(PRCODY0,U,2)
 . ;
 . ;set up array for call to HLNAME^XLFNAME
 . S PRCDNM("FILE")=200
 . S PRCDNM("FIELD")=.01
 . ;place Requestor, Approver, and Obligator names
 . ;in HL7 format. Name components (LAST|FIRST|MIDDLE|SUFFIX)
 . S PRCDNM("IENS")=+PRCREQID_","
 . S PRCOBJ("REQNAME")=$S(+PRCREQID>0:$$HLNAME^XLFNAME(.PRCDNM,"","|"),1:"")
 . I PRCOBJ("REQNAME")]"" S PRCOBJ("REQNAME")=$P($$UP^XLFSTR(PRCOBJ("REQNAME")),"|",1,4)
 . S PRCDNM("IENS")=+PRCAPPID_","
 . S PRCOBJ("APPNAME")=$S(+PRCAPPID>0:$$HLNAME^XLFNAME(.PRCDNM,"","|"),1:"")
 . I PRCOBJ("APPNAME")]"" S PRCOBJ("APPNAME")=$P($$UP^XLFSTR(PRCOBJ("APPNAME")),"|",1,4)
 . S PRCDNM("IENS")=+PRCOBLID_","
 . S PRCOBJ("OBLNAME")=$S(+PRCOBLID>0:$$HLNAME^XLFNAME(.PRCDNM,"","|"),1:"")
 . I PRCOBJ("OBLNAME")]"" S PRCOBJ("OBLNAME")=$P($$UP^XLFSTR(PRCOBJ("OBLNAME")),"|",1,4)
 . ;
 . ;place Requestor, Approver, and Obligator IDs in format 'Station#-UserId' 
 . S PRCOBJ("REQID")=PRCOBJ("FACNUM")_"-"_PRCREQID
 . S PRCOBJ("APPID")=PRCOBJ("FACNUM")_"-"_PRCAPPID
 . S PRCOBJ("OBLID")=PRCOBJ("FACNUM")_"-"_PRCOBLID
 . ;
 . ;validate 1358 transaction data elements, don't check
 . ;for required elements
 . Q:'$$VALID^PRCFDO(.PRCOBJ,0)
 . ;
 . ;count of initial obligations and adjustments
 . I PRCOBJ("TRANTYPE")="O" S PRCST("OBL")=PRCST("OBL")+1
 . E  S PRCST("ADJ")=PRCST("ADJ")+1
 . ;
 . ;build 1358 transaction msg
 . D BLDMSG^PRCFDO(.PRCOBJ,.PRCCNT,"^","~",PRCMSG)
 . S PRCST("SENT")=PRCST("SENT")+1  ;record count
 . ;
 . ;send 100 records per batch (= 200 lines per msg)
 . I PRCCNT=200 D
 . . D MAIL^PRCFDO(PRCMSG) ;send batch msg
 . . K @PRCMSG   ;reset msg text array
 . . S PRCCNT=0  ;reset line count for next batch
 . . S PRCST("BATCH")=PRCST("BATCH")+1  ;batch count
 ;
 S RESULT=1
 Q RESULT
 ;
 ;
STATS(PRCSTAT) ;Generate extract statistics message
 ;
 ; This procedure will generate a MailMan message containing statistics
 ; from the extract of 1358 transactions.
 ;
 ; Supported IAs:
 ;  #10104 Allows use of supported Kernel call $$RJ^XLFSTR
 ;  #10070 Allows use of supported MailMan call ^XMD
 ;
 ;  Input:
 ;   PRCSTAT - array containing the extract statistics
 ;
 ; Output: None
 ;
 N DIFROM ;protect FM package
 N XMDUZ  ;sender
 N XMSUB  ;msg subject
 N XMTEXT ;name of array (in open format) containing text of msg
 N XMY    ;recipient array
 N XMZ    ;returned msg #
 N XMMG,XMSTRIP,XMROU,XMYBLOB  ;optional MM input vars
 N PRCTXT ;msg text array
 ;
 I '$D(XMY) S XMY(.5)=""
 I +$G(PRCSTAT("USER")) S XMY(+$G(PRCSTAT("USER")))=""
 S XMSUB="PRC*5.1*153-Extract Results-Station #"_$G(PRCSTAT("FACNUM"))
 S XMDUZ="IFCAP/OLCS INTERFACE"
 S PRCTXT(1)=""
 S PRCTXT(2)="   >>>>>>>>>> Patch PRC*5.1*153-Extract 1358s Results <<<<<<<<<<"
 S PRCTXT(3)=""
 S PRCTXT(4)="        Date/Time extract job started: "_$$FMTE^XLFDT($G(PRCSTAT("START")),"1P")
 S PRCTXT(5)="        Date/Time extract job stopped: "_$$FMTE^XLFDT($G(PRCSTAT("END")),"1P")
 S PRCTXT(6)=""
 S PRCTXT(7)="          Batch messages sent to OLCS: "_$$RJ^XLFSTR($G(PRCSTAT("BATCH")),6)
 S PRCTXT(8)="       1358 transactions sent to OLCS: "_$$RJ^XLFSTR($G(PRCSTAT("SENT")),6)
 S PRCTXT(9)="                  Initial Obligations: "_$$RJ^XLFSTR($G(PRCSTAT("OBL")),6)
 S PRCTXT(10)="                          Adjustments: "_$$RJ^XLFSTR($G(PRCSTAT("ADJ")),6)
 S PRCTXT(11)=""
 S PRCTXT(12)="     PARAMETERS (#8989.5) file update: "_$G(PRCSTAT("PARMADD"))
 S PRCTXT(13)="                            Parameter: "_$G(PRCSTAT("PARM"))
 S XMTEXT="PRCTXT("
 ;send msg
 D ^XMD
 Q
 ;
 ;
INSTAT(PRCIN,PRCS) ;Initialize extract statistics array
 ;
 ; This function is used to initialize the array that will contain the
 ; extract statistics.
 ;
 ; Supported IAs:
 ;  #10103: Allows use of supported Kernel call $$NOW^XLFDT
 ;
 ;  Input:
 ;   PRCIN - Array containing Institution_Name and Station_Number, passed
 ;           by reference
 ;    PRCS - (required) Result array passed by reference
 ;
 ; Output:
 ;  Function Value - Returns 1 on success, 0 on failure
 ;            PRCS - initialized extract statistics array
 ;        
 ;                    Subscript   Description
 ;                    ---------   ------------------------------------------
 ;                    "FACNM"     Institution Name
 ;                    "FACNUM"    Station Number
 ;                    "START"     Extract start date/time
 ;                    "END"       Extract end date/time
 ;                    "BATCH"     Count of batch messages sent
 ;                    "SENT"      Count of 1358 transactions sent
 ;                    "OBL"       Initial obligations count
 ;                    "ADJ"       Adjustment event count
 ;                    "PARM"      PARAMETERS (#8989.5) file entry
 ;                    "PARMADD"   Entry added to PARAMETERS (#8989.5) file? (Y/N)
 ;                    "USER"      User queuing/running extract
 ;
 N RESULT ;function return value
 ;
 S RESULT=0
 S PRCS("FACNM")=$G(PRCIN("FACNAME"))
 S PRCS("FACNUM")=$G(PRCIN("FACNUMB"))
 S PRCS("START")=$$NOW^XLFDT
 S PRCS("END")=""
 S PRCS("BATCH")=0
 S PRCS("SENT")=0
 S PRCS("OBL")=0
 S PRCS("ADJ")=0
 S PRCS("PARM")=""
 S PRCS("PARMADD")=""
 S PRCS("USER")=$S($G(DUZ)>0:DUZ,1:"")
 ;
 S RESULT=1
 Q RESULT
 ;
 ;
GETSITE(PRCINST) ;Get site data
 ;
 ; This function is used to obtain the Institution_Name and Station_Number.
 ; The data will then be placed into an array format.
 ;
 ; Supported IAs:
 ;  #2171  Allows use of supported Kernel call $$NS^XUAF4
 ;  #2541  Allows use of supported Kernel call $$KSP^XUPARAM
 ;
 ;  Input:
 ;   PRCINST - (required) Result array passed by reference
 ;
 ; Output:
 ;  Function Value - Returns 1 on success, 0 on failure
 ;         PRCINST - Output array containing site data
 ;        
 ;                    Subscript   Description
 ;                    ----------  ----------------
 ;                    "FACNAME"   institution name
 ;                    "FACNUMB"   station number
 ;
 N RESULT   ;function return value
 N PRCSITE  ;caret-delimited string (institution_name^station_number)
 ;
 S RESULT=0
 ;
 ;retrieve Institution Name and Station Number from the site's INSTITUTION file
 S PRCSITE=$$NS^XUAF4(+$$KSP^XUPARAM("INST"))
 S PRCINST("FACNAME")=$P($G(PRCSITE),U)
 S PRCINST("FACNUMB")=$P($G(PRCSITE),U,2)
 ;
 S RESULT=1
 Q RESULT
 ;
 ;
SETPARM(PRCPENT,PRCPARM,PRCPINS,PRCPVAL) ;Add parameter value
 ;
 ; This function acts as wrapper for EN^XPAR and is used to add
 ; a new entry in the PARAMETERS (#8989.5) file.
 ;
 ; Supported IAs:
 ;  #2263: Allows use of supported Kernel call EN^XPAR
 ;
 ; Input:
 ;  PRCPENT - parameter entity
 ;  PRCPARM - PARAMETER DEFINITION name
 ;  PRCPINS - parameter instance
 ;  PRCPVAL - parameter value
 ;
 ; Output:
 ;  Function Value - Returns 1 if parameter value added, 0 otherwise
 ;
 N RESULT
 S RESULT=1
 D EN^XPAR($G(PRCPENT),$G(PRCPARM),+$G(PRCPINS),$G(PRCPVAL),.PRCMSG)
 I $G(PRCMSG) S RESULT=0
 Q RESULT
