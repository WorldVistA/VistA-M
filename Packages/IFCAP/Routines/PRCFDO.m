PRCFDO ;WOIFO/KCL,MM - IFCAP/OLCS INTERFACE ;2/24/2011
V ;;5.1;IFCAP;**153**;Oct 20, 2000;Build 10
 ;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ;direct entry not permitted
 Q
 ;
OLCSMSG ;Generate 1358 transaction message
 ;
 ; This procedure is called when the following events occur in IFCAP:
 ;  - OBLIGATION event (when a new 1358 transaction is obligated)
 ;  - ADJUSTMENT event (when an increase/decrease adjustment 
 ;                      transaction is obligated)
 ;
 ; It will act as a driver for building and sending a 1358 transaction
 ; message to the Online Certification System via MailMan.
 ;
 ;  Input: None
 ; Output: None
 ;
 N PRCCNT  ;msg text line counter
 N PRCDATA ;1358 data elements array
 N PRCMSG  ;closed root array of MailMan text lines
 ;
 ;get 1358 transaction data elements
 Q:'$$OLCSDATA(.PRCDATA)
 ;
 ;validate 1358 transaction data elements, don't
 ;check for required elements
 Q:'$$VALID(.PRCDATA,0)
 ;
 ;build 1358 transaction msg
 S PRCMSG=$NA(^TMP("PRCOLCS",$J))
 K @PRCMSG
 S PRCCNT=0
 D BLDMSG(.PRCDATA,.PRCCNT,"^","~",PRCMSG)
 ;
 ;send 1358 transaction msg
 D MAIL(PRCMSG)
 ;
 ;cleanup
 K PRCDATA
 K @PRCMSG
 Q
 ;
 ;
OLCSDATA(PRCDF) ;Get 1358 data elements
 ;
 ; This function is used to place 1358 transaction data elements into
 ; an array format.
 ;
 ; Supported IAs:
 ;  The following IAs allow use of supported Kernel calls:
 ;  #2171  $$NS^XUAF4
 ;  #2541  $$KSP^XUPARAM
 ;  #3065  $$HLNAME^XLFNAME
 ;  #10103 $$FMTHL7^XLFDT
 ;  #10104 $$UP^XLFSTR
 ;
 ;  Input:
 ;   PRCDF - (required) Result array passed by reference
 ;
 ; Output:
 ;  Function Value - Returns 1 on success, 0 on failure
 ;           PRCDF - Output array containing 1358 transaction data elements
 ;        
 ;             Subscript   Data Element
 ;             ---------   ------------
 ;             "FACNM"     Facility-Name
 ;             "FACNUM"    Station-Number
 ;             "OBLNUM"    Obligation-Number
 ;             "TRANTYPE"  Transaction-Type
 ;             "OBLDATE"   Event-Date-Time
 ;             "REQNAME"   Requestor-Name
 ;             "REQID"     Requestor-ID
 ;             "APPNAME"   Approver-Name
 ;             "APPID"     Approver-ID
 ;             "OBLNAME"   Obligator-Name
 ;             "OBLID"     Obligator-ID
 ;
 N PRCDFNUM ;station #
 N PRCDNM   ;array for call to HLNAME^XLFNAME
 N PRCSITE  ;institution_name^station_number
 N PRCREQID ;Requestor DUZ
 N PRCAPPID ;Approving Official DUZ
 N PRCOBLID ;Obligator DUZ
 N PRCOBLD  ;Date Signed from Obligation Data multiple
 N PRCSUB   ;array subscripts
 N RESULT   ;function result
 ;
 S RESULT=0
 ;
 ;init output array
 K PRCDF S PRCDF=""
 F PRCSUB="FACNM","FACNUM","OBLNUM","TRANTYPE","OBLDATE","REQNAME","REQID","APPNAME","APPID","OBLNAME","OBLID" S PRCDF(PRCSUB)=""
 ;
 ;Facility-Name and Station-Number
 S PRCSITE=$$NS^XUAF4(+$$KSP^XUPARAM("INST"))
 S PRCDF("FACNM")=$P($G(PRCSITE),"^")
 S PRCDFNUM=$P($G(PRCSITE),"^",2)
 S PRCDF("FACNUM")=PRCDFNUM
 ;
 ;Obligation-Number from file #442 record 
 S PRCDF("OBLNUM")=$P($G(PO(0)),"^")
 ;
 ;Transaction-Type (O=Obligated & A=Adjustment)
 S PRCDF("TRANTYPE")=$S($G(PRCFSC)=1:"O",1:"A")
 ;
 ;Event-Date_Time (Date Signed) in HL7 format YYYYMMDDHHMMSS-XXXX
 ;where (-XXXX is the Greenwich Mean Time offset)
 S PRCOBLD=$$OBL(+PO,PRCDF("TRANTYPE"),$G(TRDA))
 S PRCDF("OBLDATE")=$$FMTHL7^XLFDT($G(PRCOBLD))
 ;concatenate '00' seconds if Date Signed was filed precisely on the hour and minute
 I $L($P(PRCDF("OBLDATE"),"-"))=12 D
 . S PRCDF("OBLDATE")=$P(PRCDF("OBLDATE"),"-")_"00-"_$P(PRCDF("OBLDATE"),"-",2)
 ;
 ;get Requestor, Approver, and Obligator iens
 ;TRNODE(7) contains Requestor (#40) from file #410 record
 S PRCREQID=$P($G(TRNODE(7)),"^")
 ;TRNODE(7) contains Approving Official (#42) from file #410 record
 S PRCAPPID=$P($G(TRNODE(7)),"^",3)
 ;Obligator=DUZ
 S PRCOBLID=+$G(PRC("PER"))
 ;
 ;set up array for call to HLNAME^XLFNAME
 S PRCDNM("FILE")=200
 S PRCDNM("FIELD")=.01
 ;place Requestor, Approver, and Obligator names
 ;in HL7 format. Name components (LAST|FIRST|MIDDLE|SUFFIX)
 S PRCDNM("IENS")=+PRCREQID_","
 S PRCDF("REQNAME")=$S(+PRCREQID>0:$$HLNAME^XLFNAME(.PRCDNM,"","|"),1:"")
 I PRCDF("REQNAME")]"" S PRCDF("REQNAME")=$P($$UP^XLFSTR(PRCDF("REQNAME")),"|",1,4)
 S PRCDNM("IENS")=+PRCAPPID_","
 S PRCDF("APPNAME")=$S(+PRCAPPID>0:$$HLNAME^XLFNAME(.PRCDNM,"","|"),1:"")
 I PRCDF("APPNAME")]"" S PRCDF("APPNAME")=$P($$UP^XLFSTR(PRCDF("APPNAME")),"|",1,4)
 S PRCDNM("IENS")=+PRCOBLID_","
 S PRCDF("OBLNAME")=$S(+PRCOBLID>0:$$HLNAME^XLFNAME(.PRCDNM,"","|"),1:"")
 I PRCDF("OBLNAME")]"" S PRCDF("OBLNAME")=$P($$UP^XLFSTR(PRCDF("OBLNAME")),"|",1,4)
 ;
 ;place Requestor, Approver, and Obligator IDs in format 'Station#-UserId' 
 S PRCDF("REQID")=PRCDFNUM_"-"_PRCREQID
 S PRCDF("APPID")=PRCDFNUM_"-"_PRCAPPID
 S PRCDF("OBLID")=PRCDFNUM_"-"_PRCOBLID
 ;
 S RESULT=1
 Q RESULT
 ;
 ;
OBL(POIEN,TRANTYPE,PRCF410) ;Get Date Signed for current obligation
 ;
 ;  Input:
 ;      POIEN - (required) IEN in Procurement & Accounting Transactions (#442) file
 ;   TRANTYPE - (required) 'O'bligated or 'A'djustment
 ;    PRCF410 - IEN in Control Point Activity (#410)          
 ;
 ; Output:
 ;  PRCFDS - Date Signed (#5) field in Obligation Data (#442.09) multiple in PRC(442)
 ;
 N PRCFI,PRCFDS
 S PRCFDS=""
 I +$G(PO)'>0 Q PRCFDS
 I $G(TRANTYPE)="" Q PRCFDS
 S PRCF410=$G(PRCF410)
 S PRCFI=0
 ;Loop through Obligation Data multiple
 F  S PRCFI=$O(^PRC(442,+PO,10,PRCFI)) Q:PRCFI'>0  D  Q:PRCFDS'=""
 .N PRCF0
 .S PRCF0=$G(^PRC(442,+PO,10,PRCFI,0))
 .;Skip entries that are not SO or AR code sheets (excludes PV)
 .Q:"^SO^AR^"'[("^"_$E(PRCF0,1,2)_"^")
 .;If transaction type is for the new 1358 obligation, 1358 Adjustment field
 .;will be null and transaction type will be set to 'O'bligation.
 .I $P(PRCF0,"^",11)="",(TRANTYPE="O") D
 ..;Date Signed (#5) field for initial obligation
 ..S PRCFDS=$P(PRCF0,"^",6)
 .;If 1358 Adjustment field is defined and transaction type set to
 .;'A'djustment, compare 410 IEN in 1358 Adjustment field with 410 
 .;IEN for current obligation.
 .I $P(PRCF0,"^",11)'="",(TRANTYPE="A") D
 ..I $P(PRCF0,"^",11)'=+PRCF410 Q
 ..;Date Signed field for current adjustment obligation
 ..S PRCFDS=$P(PRCF0,"^",6)
 Q PRCFDS
 ;
 ;
VALID(PRCDF,PRCREQ,PRCER) ;Validate 1358 transaction array
 ;
 ; This function performs validation checks on elements in the 1358 transaction array.
 ;
 ;  Input:
 ;    PRCDF - array containing 1358 transaction data elements, passed by reference
 ;   PRCREQ - (optional) check for required data elements? 1=Yes|0=No default=1
 ;
 ; Output:
 ;   Function Value - Returns 1 if validation checks passed, 0 otherwise
 ;            PRCER - (optional) if validation checks fail, an error message
 ;                    is returned, pass by reference
 ;
 N PRCTXT ;temporary error text
 N RESULT ;function result
 ;
 ;init vars
 S (PRCER,PRCTXT)=""
 S PRCREQ=$S($G(PRCREQ)=0:0,1:1)
 ;
 S RESULT=1
 ;
 ;if needed, check for required data elements
 I PRCREQ D
 . S PRCTXT="data element is missing."
 . I $G(PRCDF("FACNM"))="" S RESULT=0,PRCER="Facility-Name "_PRCTXT Q
 . I $G(PRCDF("FACNUM"))="" S RESULT=0,PRCER="Station-Number "_PRCTXT Q
 . I $G(PRCDF("OBLNUM"))="" S RESULT=0,PRCER="Obligation-Number "_PRCTXT Q
 . I $G(PRCDF("TRANTYPE"))="" S RESULT=0,PRCER="Transaction-Type "_PRCTXT Q
 . I $G(PRCDF("OBLDATE"))="" S RESULT=0,PRCER="Event-Date-Time "_PRCTXT Q
 . I $G(PRCDF("REQNAME"))="" S RESULT=0,PRCER="Requestor-Name "_PRCTXT Q
 . I $G(PRCDF("REQID"))="" S RESULT=0,PRCER="Requestor-ID "_PRCTXT Q
 . I $G(PRCDF("APPNAME"))="" S RESULT=0,PRCER="Approver-Name "_PRCTXT Q
 . I $G(PRCDF("APPID"))="" S RESULT=0,PRCER="Approver-ID "_PRCTXT Q
 . I $G(PRCDF("OBLNAME"))="" S RESULT=0,PRCER="Obligator-Name "_PRCTXT Q
 . I $G(PRCDF("OBLID"))="" S RESULT=0,PRCER="Obligator-ID "_PRCTXT Q
 ;
 ;if error not encountered, check max field lengths
 I RESULT D
 . S PRCTXT="exceeds maximum field length."
 . I $L($G(PRCDF("FACNM")))>30 S RESULT=0,PRCER="Facility-Name "_PRCTXT Q
 . I $L($G(PRCDF("FACNUM")))>3 S RESULT=0,PRCER="Station-Number "_PRCTXT Q
 . I $L($G(PRCDF("OBLNUM")))>10 S RESULT=0,PRCER="Obligation-Number "_PRCTXT Q
 . I $L($G(PRCDF("TRANTYPE")))>1 S RESULT=0,PRCER="Transaction-Type "_PRCTXT Q
 . I $L($G(PRCDF("OBLDATE")))>19 S RESULT=0,PRCER="Event-Date-Time "_PRCTXT Q
 . I $L($G(PRCDF("REQNAME")))>35 S RESULT=0,PRCER="Requestor-Name "_PRCTXT Q
 . I $L($G(PRCDF("REQID")))>16 S RESULT=0,PRCER="Requestor-ID "_PRCTXT Q
 . I $L($G(PRCDF("APPNAME")))>35 S RESULT=0,PRCER="Approver-Name "_PRCTXT Q
 . I $L($G(PRCDF("APPID")))>16 S RESULT=0,PRCER="Approver-ID "_PRCTXT Q
 . I $L($G(PRCDF("OBLNAME")))>35 S RESULT=0,PRCER="Obligator-Name "_PRCTXT Q
 . I $L($G(PRCDF("OBLID")))>16 S RESULT=0,PRCER="Obligator-ID "_PRCTXT Q
 ;
 ;if error not encountered, check for valid set of codes
 I RESULT D
 . S PRCTXT="contains an invalid set of codes."
 . I ($G(PRCDF("TRANTYPE"))'="O")&($G(PRCDF("TRANTYPE"))'="A") S RESULT=0,PRCER="Transaction-Type "_PRCTXT Q
 ;
 Q RESULT
 ;
 ;
BLDMSG(PRCDFA,PRCCTR,PRCDEL,PRCEOR,PRCXMTXT) ;Build 1358 transaction message
 ;
 ; This procedure is used to build a 1358 transaction message.
 ;
 ;  Input:
 ;   PRCDFA - (required) array containing 1358 transaction data elements
 ;   PRCCTR - as number of lines in message, passed by reference
 ;   PRCDEL - data field delimiter, default="^"
 ;   PRCEOR - end of record indicator, default="~"
 ;
 ; Output:
 ;  PRCXMTXT - array of MailMan text lines
 ;
 N PRCREC ;temp var containing record line
 ;
 ;set default field delimiter and end of record indicator if not passed
 S:$G(PRCDEL)']"" PRCDEL="^"
 S:$G(PRCEOR)']"" PRCEOR="~"
 ;
 ;msg line count
 S PRCCTR=+$G(PRCCTR)
 ;
 ;build Line 1 of 1358 transaction record
 ;Station Name^Station Number^1358 Obligation #^Transaction Type^Event Date/Time^
 S PRCREC=PRCDFA("FACNM")_PRCDEL_PRCDFA("FACNUM")_PRCDEL_PRCDFA("OBLNUM")_PRCDEL
 S PRCREC=PRCREC_PRCDFA("TRANTYPE")_PRCDEL_PRCDFA("OBLDATE")_PRCDEL
 ;
 ;add line to msg
 D ADDLINE(PRCREC,.PRCCTR,PRCXMTXT)
 K PRCREC
 ;
 ;build Line 2 of 1358 transaction record
 ;Requestor Name^Requestor ID^Approver Name^Approver ID^Obligation Name^Obligation ID
 S PRCREC=PRCDFA("REQNAME")_PRCDEL_PRCDFA("REQID")_PRCDEL_PRCDFA("APPNAME")_PRCDEL
 S PRCREC=PRCREC_PRCDFA("APPID")_PRCDEL_PRCDFA("OBLNAME")_PRCDEL_PRCDFA("OBLID")_PRCDEL
 ;
 ;add end of record indicator
 S PRCREC=PRCREC_PRCEOR
 ;
 ;add line to msg
 D ADDLINE(PRCREC,.PRCCTR,PRCXMTXT)
 K PRCREC
 Q
 ;
 ;
ADDLINE(PRCTEXT,PRCNT,PRCXMTXT) ;Add lines of text to message array
 ;
 ;  Input:
 ;   PRCTEXT - as line of text to be inserted into msg
 ;     PRCNT - as number of lines in msg, passed by reference
 ;
 ; Output:
 ;   PRCXMTXT - array containing msg text
 ;
 S PRCNT=PRCNT+1
 S @PRCXMTXT@(PRCNT)=PRCTEXT
 Q
 ;
 ;
MAIL(PRCXMTXT) ;Send 1358 transaction mail message
 ;
 ; * Send messages to production queue Q-OLP.MED.VA.GOV
 ;    [If PRC*5.1*153 installed in a production account]
 ;
 ; * Send messages to mail group G.OLP
 ;    [If PRC*5.1*153 installed in a test account
 ;       AND
 ;     Nationally released version of PRC*5.1*153 is not installed]
 ;
 ; * Do not send messages
 ;    [If PRC*5.1*153 installed in a test account
 ;       AND
 ;     Nationally released version of PRC*5.1*153 is installed]
 ;
 ; Supported IAs:
 ;  #10070: Allows use of supported MailMan call ^XMD
 ;   #2054: Allows use of supported FM call $$OREF^DILF
 ;   #4440: Allows use of supported Kernel call $$PROD^XUPROD
 ;  #10141: Allows use of supported Kernel call $$INSTALDT^XPDUTL
 ;
 ;  Input:
 ;   PRCXMTXT - array containing message text
 ;
 ; Output: None
 ;
 N DIFROM  ;protect FM package
 N XMDUZ   ;sender
 N XMSUB   ;subj
 N XMTEXT  ;name of array (in open format) containing text of msg
 N XMY     ;recipient array
 N XMZ     ;returned msg #
 N XMMG,XMSTRIP,XMROU,XMYBLOB  ;optional MM input vars
 N PRCACCT ;account
 N PRCREC  ;recipient
 ;
 D
 . ;quit if production account
 . I $$PROD^XUPROD S PRCACCT=1 Q
 . ;
 . ;otherwise, retrieve all dates/times that an install was performed
 . ;and determine if nationally released version of patch was installed
 . N PRCINST,PRCINST1
 . S PRCINST1=""
 . S PRCINST=$$INSTALDT^XPDUTL("PRC*5.1*153",.PRCINST)
 . I +PRCINST>0 D
 . . N PRCINSTD S PRCINSTD=0
 . . ;loop thru install dates/times
 . . F  S PRCINSTD=$O(PRCINST(PRCINSTD)) Q:'PRCINSTD  D  Q:PRCINST1="P"
 . . . N PRCINST0
 . . . S PRCINST0=$G(PRCINST(PRCINSTD))
 . . . I +$P(PRCINST0,"^",2)>0 S PRCINST1="P" Q
 . . . S PRCINST1="T"
 . S PRCACCT=$S(PRCINST1="T":2,1:0)
 ;
 S PRCREC=$S(PRCACCT=1:"XXX@Q-OLP.MED.VA.GOV",PRCACCT=2:"G.OLP",1:0)
 Q:PRCREC=0
 ;
 S XMY(PRCREC)=""
 S XMSUB="1358 TRANSACTION"
 S XMDUZ="IFCAP/OLCS INTERFACE"
 S XMTEXT=$$OREF^DILF(PRCXMTXT)
 ;
 ;send
 D ^XMD
 Q
