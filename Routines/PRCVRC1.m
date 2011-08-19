PRCVRC1 ;WOIFO/BMM - silently build RIL for DynaMed ; 3/24/05 2:43pm
V ;;5.1;IFCAP;**81**;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ;^XTMP format for incoming DM data is set:
 ;^XTMP("PRCVRE*ID",0)=termination date^entry date^ Transmit message 
 ;to DynaMed for updates^date/time of this XTMP node built (debugging)
 ;^XTMP("PRCVRE*ID",0,"ERR")=Error message flag
 ;^XTMP("PRCVRE*ID",1)=Item counter/last item entered^FCP^CC^
 ;Order Control Code^Site Number^Date/Time message created^DUZ^
 ;Entered By Last Name^Entered by First Name
 ;^XTMP("PRCVRE*ID",1,n)=item #^quantity^vendor #^cost^Date Needed^
 ;DynaMed Document Number^NIF #^BOC
 ;^XTMP("PRCVRE*ID",1,n,"ERR")=error message
 ;
 ;need to validate the NIF# and BOC but not save to a file in IFCAP. 
 ;send a message back to DM if validation fails
 ;
 ;pseudocode
 ;calling routine sends PRCVRE_message ID as parameter
 ;get information from ^XTMP
 ;  validate NIF# and BOC, send back alerts if necessary
 ;look up the information on Item and Vendor that we need
 ;silently create the RIL in 410.3
 ;  first create 410.3 record using Entry Number (site-FY-qtr-
 ;    fcp-cc-txn#), 
 ;if error - make ERR node for item in ^XTMP, he needs error code,
 ;  severity, fields involved.  if error is IFCAP (FileMan API) and 
 ;  not DM, send Vic an err at top level (1-node in XTMP) and he'll 
 ;  reject entire msg.  else if FileMan API error is item-level then 
 ;  add to item-level ERR node
 ;
 ;summary info
 ;PRCVEF - error flag, set if any errors found with detail line
 ;PRCVLN1 - summary info line for record
 ;PRCVCTR - #detail line records
 ;PRCVDUZ - user DUZ
 ;PRCVIEN - new ien for RIL being created
 ;PRCVGL - global (first) subscript for ^XTMP
 ;PRCVMID - message id from PRCVGL (ID from comments above)
 ;PRCVFN, PRCVLN - user first and last name
 ;PRCVFCP - FCP
 ;PRCVHF - flag to prevent adding the header to the RIL if errors
 ;PRCVCC - CC
 ;PRCVOCC - Order Control Code
 ;PRCVST - site
 ;PRCVDT - date/time message created
 ;PRCVQTR - fiscal quarter
 ;PRCVFY - fiscal year
 ;PRCVSTR - becomes the RIL#, ST-FY-QTR-FCP-CC-TN
 ;PRCVTN - transaction#
 ;PRCVAS - data for Audit File #414.02,
 ;   PRCVAS=DN-ITM-VN-DUZ-STR-DT-$$NOW^XLFDT
 ;PRCVAH - header data for Audit File, DUZ-LN-FN-STR-DT-$$NOW
 ;
 ;detail info
 ;PRCVMC - count of detail messages that get posted to 410.3. used
 ;  to determine if any detail records were posted at all (if not
 ;  then header is deleted and no RIL is created)
 ;PRCVA - array of values to add a detail record to 410.3
 ;PRCVDTL - each detail info line w/data below
 ;PRCVEL - counter for going through the detail records
 ;PRCVNIF - NIF #
 ;PRCVBOC - budget object code
 ;PRCVLF - flag to prevent adding a line item to the RIL if errors
 ;PRCVVN - vendor name
 ;PRCVCST - item unit cost
 ;PRCVQTY - quantity
 ;PRCVITM - item #
 ;PRCVDN - DynaMed document number
 ;PRCVDTN - date needed
 ;PRCVDR - date/time RIL is created
 ;
 Q
 ;
EN(PRCVGL) ;entry point
 Q:$$GET^XPAR("SYS","PRCV COTS INVENTORY",1,"Q")'=1
 N PRCVA,PRCVAH,PRCVAS,PRCVBOC,PRCVCC,PRCVCST,PRCVCTR,PRCVDR
 N PRCVDT,PRCVDTL,PRCVDN,PRCVDTN,PRCVDUZ,PRCVEF,PRCVEL,PRCVFCP
 N PRCVFN,PRCVFY,PRCVHF,PRCVITM,PRCVIEN,PRCVLN,PRCVLN1,PRCVMID
 N PRCVMC,PRCVNIF,PRCVOCC,PRCVQTR,PRCVQTY,PRCVST,PRCVSTR,PRCVVN
 N PRCVVNM,PRCVTC,PRCVTN
 S (PRCVAH,PRCVAS,PRCVVNM,PRCVBOC,PRCVCC,PRCVFN,PRCVDR)=""
 S (PRCVCST,PRCVTC,PRCVDUZ,PRCVDT)=0,(PRCVDTL,PRCVDTN,PRCVA)=""
 S (PRCVEL,PRCVITM,PRCVLN,PRCVLN1)="",(PRCVFCP,PRCVFY,PRCVST)=0
 S (PRCVOCC,PRCVSTR,PRCVIEN)="",(PRCVNIF,PRCVQTR,PRCVQTY)=0
 S (PRCVCTR,PRCVMC,PRCVVN,PRCVTC,PRCVTN,PRCVIEN,PRCVHF)=0
 D:'$D(U) DT^DICRW
 ;check for existence of ^XTMP global, else quit
 I '$D(^XTMP(PRCVGL,0)) G EXIT
 ;get header and summary data on records, quit if undef
 S PRCVLN1=$G(^XTMP(PRCVGL,1))
 I PRCVLN1="" D  G EXIT
 . D SENDMSG^PRCVRC2(2,PRCVGL,"",1)
 ;get message id - not needed for now
 ;S PRCVMID=$P(PRCVGL,"*",2)
 ;get data for other fields from ^XTMP
 S PRCVCTR=$P(PRCVLN1,U)+1
 I +PRCVCTR=1!(PRCVCTR'=+PRCVCTR) D  S PRCVHF=1
 . D SENDMSG^PRCVRC2(1,PRCVGL,"",1)
 S PRCVDUZ=$P(PRCVLN1,U,7)
 S PRCVST=$P(PRCVLN1,U,5)
 S PRCVFCP=$P(PRCVLN1,U,2)
 I '$$CHKFCP^PRCVRC2(PRCVFCP,PRCVST) D  S PRCVHF=1
 . D SENDMSG^PRCVRC2(25,PRCVGL,"",2)
 S PRCVCC=$P(PRCVLN1,U,3)
 ;check FCP and CC
 I '$$VALIDCC^PRCSECP(PRCVST,PRCVFCP,PRCVCC) D  S PRCVHF=1
 . D SENDMSG^PRCVRC2(3,PRCVGL,"",3)
 ;S PRCVOCC=$O(PRCVLN1,U,4)     not needed
 ;Date/time message created
 S PRCVDT=$P(PRCVLN1,U,6)
 ;check that PRCVDT is not in future
 I '$$CHKDT^PRCVRC2(PRCVDT) D  S PRCVHF=1
 . D SENDMSG^PRCVRC2(4,PRCVGL,"",6)
 ;get date/time RIL created (now)
 S PRCVDR=$$NOW^XLFDT
 K PRCVA S PRCVA(410.3,"+1,",8)=PRCVDT
 S PRCVA(410.3,"+1,",4)=PRCVDR
 ;make Entry Number - in 410.3 not 410.31 multiple
 S PRCVQTR=$$GETQTR^PRCVRC2(PRCVDT)
 I 'PRCVQTR D SENDMSG^PRCVRC2(5,PRCVGL,"",6) S PRCVHF=1
 S PRCVFY=$$GETFY^PRCVRC2(PRCVDT)
 I 'PRCVFY D SENDMSG^PRCVRC2(6,PRCVGL,"",6) S PRCVHF=1
 S PRCVSTR=PRCVST_"-"_PRCVFY_"-"_PRCVQTR_"-"_PRCVFCP_"-"_PRCVCC
 S PRCVTN=$$GETTXN^PRCVRC2(PRCVSTR)
 I PRCVTN=0 D SENDMSG^PRCVRC2(7,PRCVGL,"",1) S PRCVHF=1
 S PRCVSTR=PRCVSTR_"-"_PRCVTN
 S PRCVA(410.3,"+1,",.01)=PRCVSTR
 ;validate DUZ
 S PRCVDUZ=$P(PRCVLN1,U,7)
 I '$$CHKDUZ^PRCVRC2(PRCVDUZ) D  S PRCVHF=1
 . D SENDMSG^PRCVRC2(8,PRCVGL,"",7)
 ;create new RIL entry, new IEN in PRCVIEN(1)
 I 'PRCVHF D
 . D UPDATE^DIE("","PRCVA","PRCVIEN")
 . S PRCVIEN=$G(PRCVIEN(1))
 I PRCVHF K PRCVA
 ;user info- convert last name, first name to uppercase
 S PRCVLN=$$MAKECAP^PRCVRC2($P(PRCVLN1,U,8))
 S PRCVFN=$$MAKECAP^PRCVRC2($P(PRCVLN1,U,9))
 ;create header values string for Audit file
 S PRCVAH=PRCVDUZ_"^"_$E(PRCVLN_","_PRCVFN,1,35)_"^"_PRCVSTR
 S PRCVAH=PRCVAH_"^"_PRCVDR_"^"_PRCVDT
 ;
 ;get detail records. this is done inside loop to get all XTMP
 ;nodes for this FCP/CC
 S PRCVEL=1
D1 S PRCVEL=PRCVEL+1,PRCVEF=0,PRCVAS=""
 G:PRCVEL>PRCVCTR EXIT
 S (PRCVDTL,PRCVVN)="" K PRCVA
 ;if no detail node then skip
 G:'$D(^XTMP(PRCVGL,2,PRCVEL-1)) D1
 ;detail info string
 S PRCVDTL=$G(^XTMP(PRCVGL,2,PRCVEL-1))
 ;get DynaMed doc id
 S PRCVDN=$P(PRCVDTL,U,6)
 I PRCVDN="" D  S PRCVEF=1
 . D SENDMSG^PRCVRC2(24,PRCVGL,PRCVEL-1,1)
 I $D(^PRCV(414.02,"B",PRCVDN)) D  S PRCVEF=1
 . D SENDMSG^PRCVRC2(22,PRCVGL,PRCVEL-1,6)
 S PRCVA(410.31,"+1,"_PRCVIEN_",",6)=PRCVDN
 ;Item
 S PRCVITM=$P(PRCVDTL,U)
 I '$$CHKITM^PRCVRC2(PRCVITM) D  S PRCVEF=1
 . D SENDMSG^PRCVRC2(9,PRCVGL,PRCVEL-1,1)
 S PRCVA(410.31,"+1,"_PRCVIEN_",",.01)=PRCVITM
 ;Quantity
 S PRCVQTY=$P(PRCVDTL,U,2)
 I PRCVQTY'=+PRCVQTY D  S PRCVEF=1
 . D SENDMSG^PRCVRC2(10,PRCVGL,PRCVEL-1,2)
 S PRCVA(410.31,"+1,"_PRCVIEN_",",1)=PRCVQTY
 ;Est. Item Unit Cost
 S PRCVCST=$P(PRCVDTL,U,4)
 I '(PRCVCST?.N.1".".2N) D  S PRCVEF=1
 . D SENDMSG^PRCVRC2(11,PRCVGL,PRCVEL-1,4)
 S PRCVA(410.31,"+1,"_PRCVIEN_",",3)=PRCVCST
 ;Date Needed
 S PRCVDTN=$P(PRCVDTL,U,5)
 ;check that date needed is today or in future
 I '$$CHKDTN^PRCVRC2(PRCVDTN) D  S PRCVEF=1
 . D SENDMSG^PRCVRC2(12,PRCVGL,PRCVEL-1,5)
 S PRCVA(410.31,"+1,"_PRCVIEN_",",7)=PRCVDTN
 ;Vendor # (pointer to 440)
 S PRCVVN=$P(PRCVDTL,U,3)
 I '$$CHKVEND^PRCVRC2(PRCVVN) D  S PRCVEF=1
 . D SENDMSG^PRCVRC2(13,PRCVGL,PRCVEL-1,3)
 ;check that vendor and item relate
 I '$$CHKVI^PRCVRC2(PRCVVN,PRCVITM) D  S PRCVEF=1
 . D SENDMSG^PRCVRC2(14,PRCVGL,PRCVEL-1,3)
 S PRCVA(410.31,"+1,"_PRCVIEN_",",4)=PRCVVN
 ;Vendor name
 S PRCVVNM=$$GET1^DIQ(440,PRCVVN_",",.01)
 I PRCVVNM="" D  S PRCVEF=1
 . D SENDMSG^PRCVRC2(15,PRCVGL,PRCVEL-1,3)
 S PRCVA(410.31,"+1,"_PRCVIEN_",",2)=PRCVVNM
 ;create string to add entry to Audit file 414.02
 S PRCVAS=PRCVDN_"^"_PRCVITM_"^"_PRCVVN_"^"_PRCVAH_"^"_PRCVDTN
 ;add item record to 410.3 (if no errors)
 I 'PRCVEF D
 . D UPDATE^DIE("","PRCVA")
 . I $D(^TMP("DIERR",$J)) D  Q
 . . D SENDMSG^PRCVRC2(16,PRCVGL,PRCVEL-1,6)
 . S PRCVMC=PRCVMC+1
 . ;add new item entry to DM Audit file
 . D ADDAUD^PRCVRC2(PRCVAS)
 . ;accumulate total cost
 . S PRCVTC=PRCVTC+(PRCVCST*PRCVQTY)
 ;
 S PRCVNIF=$P(PRCVDTL,U,7)
 ;validate NIF#
 I '$$CHKNIF^PRCVRC2(PRCVITM,PRCVNIF) D
 . D SENDMSG^PRCVRC2(17,PRCVGL,PRCVEL-1,7)
 S PRCVBOC=$P(PRCVDTL,U,8)
 ;validate BOC
 I '$$CHKBOC^PRCVRC2(PRCVITM,PRCVBOC) D
 . D SENDMSG^PRCVRC2(18,PRCVGL,PRCVEL-1,8)
 ;validate site/FCP/CC/BOC combination
 I '$$VALIDBOC^PRCSECP(PRCVST,PRCVFCP,PRCVCC,PRCVBOC) D
 . D SENDMSG^PRCVRC2(19,PRCVGL,PRCVEL-1,8)
D2 G D1
 ;
EXIT ;
 ;add total cost to entry
 I PRCVHF=0 D
 . K PRCVA S PRCVA(410.3,PRCVIEN_",",2)=PRCVTC
 . D UPDATE^DIE("","PRCVA")
 ;if no detail records added to RIL then kill it
 I PRCVMC=0,PRCVIEN>0 S DIK="^PRCS(410.3,",DA=PRCVIEN D ^DIK
 ;kill vars
 K PRCVA,PRCVBOC,PRCVCC,PRCVCST,PRCVCTR,PRCVDR,PRCVDT,PRCVDTL
 K PRCVDTN,PRCVDUZ,PRCVEF,PRCVEL,PRCVFCP,PRCVFN,PRCVFY,PRCVHF
 K PRCVITM,PRCVLN,PRCVLN1,PRCVMID,PRCVNIF,PRCVOCC,PRCVQTR
 K PRCVQTY,PRCVST,PRCVSTR,PRCVVN,PRCVVNM,PRCVTC,PRCVTN
 Q
 ;
