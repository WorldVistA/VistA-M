LR309 ;DALOI/CKA - LR*5.2*309 PATCH ENVIRONMENT CHECK ROUTINE ;June 10, 2008
 ;;5.2;LAB SERVICE;**309**;Sep 27, 1994;Build 23
 ; 
 ; Use of ^XPDUTL is supported by Integration Agreement: 10141
 ; Use of ^XQALERT is supported by Integration Agreement: 10081
 ; Use of ^XLFSTR is supported by Integration Agreement: 10104
 ; Use of ^XLFDT is supported by Integration Agreement: 10103
 ; Use of ^DIK is supported by Integration Agreement: 10013
 ; Use of ^XUSER is supported by Integration Agreement: 2343
 ; Use of ^XMD is supported by Integration Agreement: 10070
 ; 
EN ; Does not prevent loading of the transport global.
 ;
 N XAQMSG,XQA,MSG
 I '$G(XPDENV) D
 .S XQAMSG="Transport global for patch "_$G(XPDNM,"Unknown patch")
 .S XQAMSG=XQAMSG_" loaded on "_$$HTE^XLFDT($H)
 .S XQA("G.LMI")=""
 .D SETUP^XQALERT
 .S MSG="Sending transport global loaded alert to mail group G.LMI"
 .D BMES^XPDUTL($$CJ^XLFSTR(MSG,IOM))
 I $G(XPDENV) D
 .S XQAMSG="Installation of patch "_$G(XPDNM,"Unknown patch")
 .S XQAMSG=XQAMSG_" started on "_$$HTE^XLFDT($H)
 .S XQA("G.LMI")=""
 .D SETUP^XQALERT
 .S MSG="Sending install started alert to mail group G.LMI"
 .D BMES^XPDUTL($$CJ^XLFSTR(MSG,IOM))
 D CHECK
 I XPDENV S XPDDIQ("XPZ1","B")="YES"
 D EXIT
 Q
 ;
POST ; KIDS Post install for LR*5.2*309
 N XQA,XQAMSG,LRRES,MSG,LRRMV
 D BMES^XPDUTL($$CJ^XLFSTR("*** Post install started ***",IOM))
 D MATCH
 I $O(^XTMP("LR309",0)) D
 . D PRINT1
 . D SEND
 ; Remove the data dictionary entry for the Description field(#20)in
 ; Cytopathology sub-file(#63.09) in LAB DATA file (#63).
 D REMOVE
 ;If no data entries found in LAB DATA file #63 so it is okay to finish 
 I $O(^XTMP("LR309",""),-1)=0 D
 . K MSG
 . S MSG="No Data found in ^LR(D0,"_"""CY"""_",D1,"_"""WP"""_",0)"
 . D BMES^XPDUTL($$CJ^XLFSTR(MSG,IOM)) K MSG
 D BMES^XPDUTL($$CJ^XLFSTR("*** Post install completed ***",IOM))
 S XQAMSG="Installation of patch "_$G(XPDNM,"Unknown patch")
 S XQAMSG=XQAMSG_" completed on "_$$HTE^XLFDT($H)
 S XQA("G.LMI")=""
 D SETUP^XQALERT
 S MSG="Sending install completion alert to mail group G.LMI"
 D BMES^XPDUTL($$CJ^XLFSTR(MSG,IOM))
 Q
 ;
CHECK ; Perform environment check
 I $S('$G(IOM):1,'$G(IOSL):1,$G(U)'="^":1,1:0) D  Q
 .D BMES^XPDUTL($$CJ^XLFSTR("Terminal Device is not defined",IOM))
 .S XPDQUIT=2
 I $S('$G(DUZ):1,$D(DUZ)[0:1,$D(DUZ(0))[0:1,1:0) D  Q
 .S MSG="Please log in to set local DUZ... variables"
 .D BMES^XPDUTL($$CJ^XLFSTR(MSG,IOM)) K MSG
 .S XPDQUIT=2
 I '($$ACTIVE^XUSER(DUZ)) D  Q
 .S MSG="You are not a valid user on this system"
 .D BMES^XPDUTL($$CJ^XLFSTR(MSG,IOM)) K MSG
 .S XPDQUIT=2
 Q
 ;
EXIT ;
 I $G(XPDQUIT) D
 .D BMES^XPDUTL($$CJ^XLFSTR("--- Install Environment Check FAILED ---",IOM))
 I '$G(XPDQUIT) D
 .D BMES^XPDUTL($$CJ^XLFSTR("--- Environment Check is Ok ---",IOM))
 Q
 ;
MATCH ;
 N LRDFN,LRI,XDATA1,LRMATFND,LREDATE,MSG,X,X1,X2,LRFNAM
 N SEX,AGE,PNM,SSN,LRCNT,LRIDT,XDATA,XDATA2
 K ^XTMP("LR309")
 S X=$$FMADD^XLFDT($$NOW^XLFDT,180,0,0,0)
 S ^XTMP("LR309",0)=X_"^"_$$NOW^XLFDT_"^LR309 DATA IN DESCRIPTION FIELD (#20)IN CYTOPATHOLOGY SUB-FILE(#63.09) IN LAB DATA FILE (#63) REPORT"
 S MSG="Searching for data in DESCRIPTION field (#20) in CYTOPATHOLOGY sub-file (#63.09) in LAB DATA file (#63)."
 D BMES^XPDUTL($$CJ^XLFSTR(MSG,IOM)) K MSG
 S (LRDFN,LRMATFND,LRCNT)=0
 F  S LRDFN=$O(^LR(LRDFN)) Q:LRDFN<1  D
 .Q:'$D(^LR(LRDFN,"CY"))
 .S LRIDT=0,(XDATA,XDATA2)=""
 .K LRDPF,VADM,PNM,SSN,VA
 .D PT^LRX
 .K LRANS,LRERR
 .S LRFNAM=$$GET1^DID(1,LRDPF,"","NAME","LRANS","LRERR")
 .I $G(LRERR) S LRFNAM="UNKNOWN"
 .F  S LRIDT=$O(^LR(LRDFN,"CY",LRIDT)) Q:LRIDT<1  D
 ..I $D(^LR(LRDFN,"CY",LRIDT,"WP")) D
 ...S LREDATE=$$FMTE^XLFDT($P(^LR(LRDFN,"CY",LRIDT,"WP",0),"^",5),1)
 ...S LRMATFND=1
 ...S ^XTMP("LR309",LRDFN,"CY",LRIDT,"EDATE")=LREDATE
 ...S ^XTMP("LR309",LRDFN,"CY",LRIDT,"SRC")=LRFNAM
 ...S ^XTMP("LR309",LRDFN,"CY",LRIDT,"NAME")=PNM
 ...S ^XTMP("LR309",LRDFN,"CY",LRIDT,"SSN")=$S($G(SSN):SSN,1:"Unknown")
 ...S ^XTMP("LR309",LRDFN,"CY",LRIDT,"AGE")=$S($G(AGE):AGE,1:"Unknown")
 ...S ^XTMP("LR309",LRDFN,"CY",LRIDT,"SEX")=$S(SEX="F":"FEMALE",SEX="M":"MALE",1:"Unknown")
 ...S ^XTMP("LR309",LRDFN,"CY",LRIDT,"ACN")=$P($G(^LR(LRDFN,"CY",LRIDT,0)),U,6)
 ...M ^XTMP("LR309",LRDFN,"CY",LRIDT,"WP")=^LR(LRDFN,"CY",LRIDT,"WP")
 ...K ^LR(LRDFN,"CY",LRIDT,"WP")
 S MSG="Search finished"
 D BMES^XPDUTL($$CJ^XLFSTR(MSG,IOM)) K MSG
 I $O(^XTMP("LR309",""),-1)>0 D
 .S MSG="Data entries have been found in ^LR(D0,"_"""CY"""_",D1,"_"""WP"""_",0)"
 .D BMES^XPDUTL($$CJ^XLFSTR(MSG,IOM)) K MSG
 .S MSG(1)=" "
 .S MSG(2)="The data found is sent in a mail message to all users"
 .S MSG(3)="who hold the security keys LRLIASON and LRAPSUPER. "
 .S MSG(4)="The data will automatically be purged from the"
 .S MSG(5)="^XTMP("_"""LR309"""_", global in 180 days. "
 .S MSG(6)=" "
 .S MSG(7)=" "
 .S MSG(8)=" "
 .S MSG(9)="Data deleted from DESCRIPTION field (#20) in CYTOPATHOLOGY sub-file (#63.09) in"
 .S MSG(10)="LAB DATA file (#63)."
 .D MES^XPDUTL(.MSG)
 Q
REMOVE ;Removes the DD entry for field #20
 N DIK,DA,MSG
 S DIK="^DD(63.09,",DA=20,DA(1)=63.09 D ^DIK
 Q
RECIP ; Find recipients with LRAPSUPER key and LRLIASON key.
 S LRDUZ=0
 F  S LRDUZ=$O(^XUSEC("LRAPSUPER",LRDUZ)) Q:'LRDUZ  S XMY(LRDUZ)=""
 S LRDUZ=0
 F  S LRDUZ=$O(^XUSEC("LRLIASON",LRDUZ)) Q:'LRDUZ  S XMY(LRDUZ)=""
 K LRDUZ
 Q
PRINT1 ; Actually print the report
 K ^TMP($J)
 N LRDATA,LRPAT,LRDATE,LRDFN,LRNAM,LRACC,PNM,LRSTATE,LRIDT
 N LRLNCNT,LRI,LRPAGE,LRCURPNM,LRZTSK,LRLINE
 N LRPDF,VADM,SSN,SEX,VA
 I '$D(^XTMP("LR309")) Q
 S LRDFN=""
 S LRI=0,LRIDT=1
 S LRPAGE=0,LRLNCNT=0
 D HEADER2
 F  S LRDFN=$O(^XTMP("LR309",LRDFN)) Q:LRDFN=""  D
 . S LRIDT=""
 . K PNM,LRPDF,VADM,SSN,SEX,SSN,VA
 . D PT^LRX
 . F  S LRIDT=$O(^XTMP("LR309",LRDFN,"CY",LRIDT)) Q:LRIDT=""  D
 . . S LRACC=$P(^LR(LRDFN,"CY",LRIDT,0),U,6)
 . . I (LRI'=LRIDT) D
 . . . D PTHDR
 . . . S LRI=LRIDT  ; Flag so we do not repeat the entire patient header each time.
 . . D PRTDATA
 . . F LRI=1:1:2 S LRDATA=" " D MSG
 Q
 ;
PTHDR ; header for each new patient entry
 N LRDATA
 S LRDATA="Patient: "_^XTMP("LR309",LRDFN,"CY",LRIDT,"NAME")
 S LRDATA=LRDATA_" ("_^XTMP("LR309",LRDFN,"CY",LRIDT,"SRC")_" FILE)" D MSG
 S LRDATA=" GENDER: "_^XTMP("LR309",LRDFN,"CY",LRIDT,"SEX")
 S LRDATA=LRDATA_"    SSN: "_^XTMP("LR309",LRDFN,"CY",LRIDT,"SSN")
 S LRDATA=LRDATA_"    Accession Number: "_^XTMP("LR309",LRDFN,"CY",LRIDT,"ACN") D MSG
 S LRDATA=" AGE   : "_^XTMP("LR309",LRDFN,"CY",LRIDT,"AGE") D MSG
 S LRDATA=" " D MSG
 S LRDATA="Data Found in DESCRIPTION field (#20) in CYTOPATHOLOGY sub-file (63.09) in LAB" D MSG
 S LRDATA="DATA file (#63): " D MSG
 S LRDATA="==============================================================================" D MSG
 Q
 ;
PRTDATA ;
 N LRDATA,DIR,DIRUT,MSG
 S LRLINE=0
 F  S LRLINE=$O(^XTMP("LR309",LRDFN,"CY",LRIDT,"WP",LRLINE)) Q:LRLINE<1  D
 . S LRDATA=$G(^XTMP("LR309",LRDFN,"CY",LRIDT,"WP",LRLINE,0)) D MSG
 . S LRDATA=" " D MSG
 S LRDATA="-----------------------------------------------------------------------------" D MSG
 S LRDATA=" " D MSG
 Q
 ;
HEADER2 ; Prints header for all other pages
 N LRDATA
 S LRPAGE=LRPAGE+1
 S LRDATA="                              LR309 DATA REPORT            Page: "_LRPAGE D MSG
 S LRDATA=" " D MSG
 I (LRI=LRIDT) D
 . S LRDATA="Continuation of Patient: "_^XTMP("LR309",LRDFN,"CY",LRIDT,"NAME") D MSG
 . S LRDATA=" " D MSG
 F LRI=1:1:2 S LRDATA=" " D MSG
 Q
 ;
MSG S ^TMP($J,"LR309",LRLNCNT)=LRDATA S LRLNCNT=LRLNCNT+1
 Q 
SEND ;Send the message to users of the security keys LRLIASON and LRAPSUPER
 N DIFROM,XMY,XMSUB,XMTEXT,XMDUN
 D RECIP
 S XMSUB="LR*5.2*309 DATA REPORT"
 S XMTEXT="^TMP("_$J_",""LR309"","
 S XMDUN="LR*5.2*309"
 D ^XMD
 Q
