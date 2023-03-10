ECUMRPC2 ;ALB/JAM - Event Capture Management Broker Utils ;12/22/21  18:54
 ;;2.0;EVENT CAPTURE;**25,30,42,46,47,49,75,72,95,114,134,156**;8 May 96;Build 28
 ;
 ; Reference to $$SINFO^ICDEX supported by ICR #5747
 ; Reference to $$ICDDX^ICDEX supported by ICR #5747
 ; Reference to ^DIC(4) supported by ICR #10090
 ; Reference to ^TMP supported by SACC 2.3.2.5.1
 ; Reference to FIND^DIC supported by Fileman API #2051
 ; Reference to GET^XUA4A72 supported by ICR #1625
 ; Reference to XLFDT: $$FMADD, $$NOW supported by ICR #10103
 ; Reference to ^%ZTLOAD supported by ICR #10063
 ;
GLOC(RESULTS,ECARY) ;
 ;
 ;This broker entry point returns all active Event Capture locations
 ;        RPC: EC GETLOC
 ;INPUTS         ECARY - Contains the following subscripted elements
 ;               STAT   - Active or inactive locations (optional)
 ;               A-ctive (default), I-nactive, B-oth
 ;
 ;OUTPUTS        RESULTS - The array of active Event Capture locations.
 ;               PIECE - Description
 ;                 1     Location IEN
 ;                 2     LOC description
 ;                 3     State Abbreviation
 ;                 4     Current Location Flag
 ;                 5     Facility Type
 ;                 6     Station Number
 N LOC,STAT,CNT,CLOC,ST,NODE,ACT,ECLOC,ELOC,ECFT,ECSN
 D SETENV^ECUMRPC
 K ^TMP($J,"ECLOCATION")
 S STAT=$P($G(ECARY),U),(CNT,LOC)=0,ACT=0 S:STAT="" STAT="A"
 D GETLOC^ECL(.ECLOC)
 F  S LOC=$O(ECLOC(LOC)) Q:'LOC  S ELOC($P(ECLOC(LOC),U,2))=""
 S LOC=0
 F  S LOC=$O(^DIC(4,LOC)) Q:'LOC  S NODE=$G(^DIC(4,LOC,0)) I NODE'="" D
 . S ACT=0 ;134 Reset status before each record
 . I $P(NODE,U)="" Q
 . I ($P(NODE,U,11)="I")!($P($G(^DIC(4,LOC,99)),U,4)) S ACT=1
 . I $S(STAT="A"&(ACT):1,STAT="I"&('ACT):1,1:0) Q
 . S CLOC=$D(ELOC(LOC)),CLOC=$S(CLOC:"YES",1:"")
 . S CNT=CNT+1,ST=$P(NODE,U,2) S:ST'="" ST=$$GET1^DIQ(5,ST,1,"I")
 . S ECFT=$P($G(^DIC(4.1,+$G(^DIC(4,LOC,3)),0)),U)
 . S ECSN=$P($G(^DIC(4,LOC,99)),U)
 . S ^TMP($J,"ECLOCATION",CNT)=LOC_U_$P(NODE,U)_U_ST_U_CLOC_U_ECFT_U_ECSN
 S RESULTS=$NA(^TMP($J,"ECLOCATION"))
 Q
CPTFND(RESULTS,ECARY) ;
 ;
 ;This broker entry point does a search on a CPT string and returns
 ;a list of matches from file #81
 ;        RPC: EC GETCPTLST
 ;INPUTS      ECARY   - Contains the following subscripted elements
 ;             CPTSTR - CPT search string
 ;
 ;OUTPUTS     RESULTS - The array of cpt codes. Data pieces as follows:-
 ;             CPT ien^CPT code^Name
 ;
 N CPTSTR,ECNT,DIC,ECTG,ECER
 D SETENV^ECUMRPC
 S CPTSTR=$P(ECARY,U),ECNT=0 I CPTSTR="" Q
 K ^TMP($J,"ECPTSRCH"),^TMP("ECCPT",$J)
 D CPTSRH(81,CPTSTR)
 F  S ECNT=$O(^TMP("ECCPT",$J,"DILIST","ID",ECNT)) Q:'ECNT  D
 .S ^TMP($J,"ECPTSRCH",ECNT)=$G(^TMP("ECCPT",$J,"DILIST",2,ECNT))_U_^TMP("ECCPT",$J,"DILIST","ID",ECNT,.01)_U_^TMP("ECCPT",$J,"DILIST","ID",ECNT,2)
 K ^TMP("ECCPT",$J)
 S RESULTS=$NA(^TMP($J,"ECPTSRCH"))
 Q
 ;
PXFND(RESULTS,ECARY) ;
 ;
 ;This broker entry point does a search on a procedure string and returns
 ;a list of matches from file #81 and/or #725
 ;        RPC: EC GETPXLST
 ;INPUTS      ECARY   - Contains the following subscripted elements
 ;             PXSTR -  Procedure search string
 ;
 ;OUTPUTS     RESULTS - The array of procedures. Data pieces as follows:-
 ;             Procedure ien^Procedure code  Procedure Name
 ;
 N CPTSTR,ECNT,DIC,ECX,CNT,ECTG,ECER,PXSTR,ECSTR
 D SETENV^ECUMRPC
 S PXSTR=$P(ECARY,U),ECNT=0 I PXSTR="" Q
 K ^TMP($J,"ECPXSRCH"),^TMP("ECCPT",$J),^TMP("ECCPT1",$J)
 D
 . I $P(PXSTR,".")="A" D CPTSRH(81,$P(PXSTR,".",2)) Q
 . I $P(PXSTR,".")="B" D CPTSRH(725,$P(PXSTR,".",2)) Q
 . F ECX=81,725 D CPTSRH(ECX,PXSTR)
 F  S ECNT=$O(^TMP("ECCPT",$J,"DILIST","ID",ECNT)) Q:'ECNT  D
 .S ECID=$G(^TMP("ECCPT",$J,"DILIST",2,ECNT))_";ICPT("
 .S ECSTR=^TMP("ECCPT",$J,"DILIST","ID",ECNT,.01)_"  "_^(2)
 .S ^TMP($J,"ECPXSRCH",ECNT)=ECID_U_ECSTR
 S ECNT=0,CNT=+$O(^TMP($J,"ECPXSRCH","A"),-1)
 F  S ECNT=$O(^TMP("ECCPT1",$J,"DILIST","ID",ECNT)) Q:'ECNT  D
 .S CNT=CNT+1,ECID=$G(^TMP("ECCPT1",$J,"DILIST",2,ECNT))_";EC(725,"
 .S ECSTR=^TMP("ECCPT1",$J,"DILIST","ID",ECNT,1)_"  "_^(.01)
 .S ^TMP($J,"ECPXSRCH",CNT)=ECID_U_ECSTR
 K ^TMP("ECCPT",$J),^TMP("ECCPT1",$J)
 S RESULTS=$NA(^TMP($J,"ECPXSRCH"))
 Q
CPTSRH(FILE,CPTSTR) ;Searches either file 81 or 725 for a CPT string
 I FILE=81 D
 .D FINDIC(81,"",".01;2","M",CPTSTR,100,"","I $P($$CPT^ICPTCOD(+Y),""^"",7)","","^TMP(""ECCPT"",$J)")
 I FILE=725 D
 .D FINDIC(725,"",".01;1","M",CPTSTR,100,"","I '$P(^(0),""^"",3)","","^TMP(""ECCPT1"",$J)")
 Q
FINDIC(ECFL,ECIEN,ECFLD,ECFLG,ECVAL,ECN,ECINDX,ECSCN,ECID,ECTG,ECER) ;
 ;Find records in a file base on search string
 S ECER=$G(ECER)
 D FIND^DIC(ECFL,ECIEN,ECFLD,ECFLG,ECVAL,ECN,ECINDX,ECSCN,ECID,ECTG,ECER)
 K ECFL,ECIEN,ECFLD,ECFLG,ECVAL,ECN,ECINDX,ECSCN,ECID
 Q
PROV(ECNUM) ;Return a set of providers from the NEW PERSON file
 ;Input Variables:-
 ;  ECNUM  - # of records to return
 ;  FROM   - text to $O from
 ;  DATE   - checks for an active person class on this date (optional)
 ;  ECDIR  - $O direction
 ;  KEY    - screen users by security key (optional)
 ;  REPORT - Set to "R" to get all entries from file 200, "NLP" if
 ;           getting list of users who don't have a person class
 ;           and set to blank if only users with a person class should
 ;           be returned.
 ;  ECDSS  - IEN of DSS unit
 ;
 ;Output Variables:-
 ;  ^TMP($J,"ECFIND",1..n - returned array
 ;     IEN of file 200^Provider Name^occupation^specialty^subspecialty
 ;
 N I,IEN,CNT,FROM,DATE,ECUTN,ECDSS S I=0,CNT=$S(+$G(ECNUM)>0:ECNUM,1:44) ;134
 S FROM=$P(ECSTR,"|"),DATE=$P(ECSTR,"|",2),REPORT=$P(ECSTR,"|",3),ECDSS=$P(ECSTR,"|",4) ;134 Added DSS unit IEN to parameters
 F  Q:I'<CNT  S FROM=$O(^VA(200,"B",FROM),ECDIR) Q:FROM=""  D
 . S IEN="" F  S IEN=$O(^VA(200,"B",FROM,IEN),ECDIR) Q:'IEN  D
 . . I IEN<1 Q  ;134 Don't include special users postmaster and sharedmail
 . . I REPORT="R" S I=I+1,^TMP($J,"ECFIND",I)=IEN_"^"_FROM_"^" Q
 . . S ECUTN=$$GET^XUA4A72(IEN,DATE)
 . . I REPORT="NLP" S:ECUTN<1&($$ACTIVE^XUSER(IEN)) I=I+1,^TMP($J,"ECFIND",I)=IEN_"^"_FROM_"^" Q  ;134, if getting non-licensed providers, return all active users who aren't providers
 . . I DATE>0,ECUTN<1,'$D(^EC(722,"B",IEN)) Q  ;134 Allows for users in file 722
 . . I $D(^EC(722,"B",IEN)),$P($G(^ECD(+ECDSS,0)),U,14)'="N" Q  ;134 Only add user if they're in the file and the DSS Unit is a 'send no records' type
 . . S I=I+1,^TMP($J,"ECFIND",I)=IEN_"^"_FROM_"^"_$P(ECUTN,"^",2,4)
 Q
LEX ; returns a list of ICD code from lexicon lookup; called from ECUMRPC1
 ;Input Variables:-
 ;  ECSTR  - APP|ECX|ECDT
 ;           application|Search string|procedure date
 ;
 ;Output Variables:-
 ;  ^TMP($J,"ECFIND",1..n - returned array
 ;     ICD Code^LEX description^IEN of file 80^IEN of file 757.01
 ;
 N LEX,ILST,I,IEN,ECX,APP,ECDT,ICD,ICDIEN,DIC,ECCS,ECCD,IMP
 S ECX=$P(ECSTR,"|",2),ECDT=$P(ECSTR,"|",3)
 S ECDT=$G(ECDT,DT),DIC="^ICD9("
 ; Determine Active Coding System based on Date Of Interest
 S ECCS=$$SINFO^ICDEX("DIAG",ECDT) ; Supported by ICR #5747
 ;spacebar default for DUZ
 I ECX=" ",+($G(DUZ))>0 S IEN=$G(^DISV(DUZ,DIC)) I +IEN D
 .; Load the ICD code info - Supported by ICR 5747
 .S ECCD=$$ICDDX^ICDEX(IEN,ECDT,+ECCS,"I") S:+ECCD>0 ECX=$P(ECCD,U,2)
 S IMP=$$IMPDATE^LEXU("10D"),APP=$S(ECDT<IMP:"ICD",1:"10D") ; Supported by ICR 5679
 K ^TMP("LEXSCH",$J)
 D CONFIG^LEXSET(APP,APP,ECDT)    ;LEX DBIA1577
 D LOOK^LEXA(ECX,APP,1,"",ECDT)   ;LEX DBIA2950
 I '$D(LEX("LIST",1)) S ^TMP($J,"ECFIND",1)="0^No matches found." Q
 ;LEX DBIA1573
 S ILST=1,IEN=+LEX("LIST",1)
 D ICD I ICDIEN<0 S ^TMP($J,"ECFIND",1)="0^No matches found." Q
 S ^TMP($J,"ECFIND",ILST)=ICD_U_$P(LEX("LIST",1),U,2)_U_ICDIEN_U_LEX("LIST",1),I=""
 ; ICD10 Changed to maximum of 101 entries
 F  S I=$O(^TMP("LEXFND",$J,I)) Q:I'<0!(ILST=101)  D
 .; Loop through all the ICD codes
 .S IEN=""
 .F  S IEN=$O(^TMP("LEXFND",$J,I,IEN)) Q:'IEN  D
 ..D ICD I ICDIEN<0 Q
 ..S ILST=ILST+1
 ..S ^TMP($J,"ECFIND",ILST)=ICD_U_^TMP("LEXFND",$J,I,IEN)_U_ICDIEN_U_IEN
 I $O(^TMP($J,"ECFIND",0))="" S ^TMP($J,"ECFIND",1)="0^No matches found."
 K ^TMP("LEXFND",$J),^TMP("LEXHIT",$J)
 Q
 ;
ICD ;ICD code
 S ICD=$$ONE^LEXU(IEN,ECDT,APP) ; Supported by ICR 5679, ICD-9 and ICD-10
 S ECCS=$$SINFO^ICDEX("DIAG",ECDT) ; Supported by ICR #5747
 S ICDIEN=+$$ICDDX^ICDEX(ICD,ECDT,+ECCS,"E") ; Supported by ICR #5747
 Q
 ;
DTPD(RESULTS,ECARY) ;Delete test patient data
 ;134 Section added for deleting test patient data
 ;Input Variable
 ;   ECARY - Set to "I" to get information or "D" to delete records
 ;Output variable
 ;   RESULT - Returns account info when ECARY is "I" or success
 ;            when ECARY is "D"
 ;
 N MODE,ZTRTN,ZTIO,ZTDTH,ZTSK
 S MODE=$P(ECARY,U) Q:MODE=""
 D SETENV^ECUMRPC ;Set up minimal variables for an RPC call
 K ^TMP($J,"ECDELETE") ;Clear TMP global space
 I MODE="I" D  S RESULTS=$NA(^TMP($J,"ECDELETE")) Q
 .S $P(^TMP($J,"ECDELETE",0),U)=$S($$PROD^XUPROD=0:"Test",1:"Production") ;Is account a test or production environment
 .S $P(^TMP($J,"ECDELETE",0),U,2)=$S($G(^XMB("NETNAME"))'="":$G(^XMB("NETNAME")),1:"network name undefined") ;Get account/network name
 .S $P(^TMP($J,"ECDELETE",0),U,3)=$S($P($G(^XTMP("ECDELETE","DEL")),U)'="":$$FMTE^XLFDT($P($G(^XTMP("ECDELETE","DEL")),U)),1:"First Time") ;Date deletion last run
 .S $P(^TMP($J,"ECDELETE",0),U,4)=$S($P($G(^XTMP("ECDELETE","DEL")),U,2)'="":$$GET1^DIQ(200,$P($G(^XTMP("ECDELETE","DEL")),U,2)_",",.01),1:"") ;Get name of person who did deletion
 .S $P(^TMP($J,"ECDELETE",0),U,5)=+$P($G(^XTMP("ECDELETE","DEL")),U,3) ;Status of deletion (0 not running, 1 if running)
 ;
 ;If deleting, queue to run in the background
 I MODE="D" D  S RESULTS=$NA(^TMP($J,"ECDELETE")) Q
 .S ZTRTN="DEL^ECDTPD",ZTIO="",ZTDTH=$$NOW^XLFDT,ZTDESC="Delete test patient data from Event Capture Patient file (#721)"
 .D ^%ZTLOAD
 .S ^TMP($J,"ECDELETE",0)=$S($G(ZTSK):1,1:0) ;Return 1 if success, otherwise 0
 .I $G(ZTSK) S ^XTMP("ECDELETE",0)=$$FMADD^XLFDT($$DT^XLFDT,730)_"^"_$$DT^XLFDT_"^Info for EC test patient deletion",^XTMP("ECDELETE","DEL")=$$NOW^XLFDT_"^"_$G(DUZ,0)_"^"_1
 .Q
 Q
 ;
ECDEL(RESULTS,ECARY) ;156 - Broker entry point to delete data in Event Capture files
 ;This RPC is called when delete an entry in Event Capture files
 ;    RPC: EC DELETE ENTRY
 ;INPUTS  ECARY    - array with data to be deleted
 ;         ECARY("ECFILE")=file #
 ;         ECARY("IEN")=ien to be deleted from the file
 ;
 ;OUTPUTS RESULTS  - Success or failure to file
 ;
 N ECFILE,ECDUZ
 D SETENV^ECUMRPC
 D PARSE^ECFLRPC
 K ^TMP($J,"ECMSG")
 I $G(ECFILE)="" S ^TMP($J,"ECMSG",1)="0^File Not defined" D END^ECFLRPC Q
 S:$G(DUZ) ECDUZ=DUZ
 I ECFILE=720.3 D DELECSR^ECMDECS,END^ECFLRPC Q
 I ECFILE=724 D DELDSS^ECMDDSSU,END^ECFLRPC Q
 S ^TMP($J,"ECMSG",1)="0^Deletion Not Available"
 D KILLVAR^ECFLRPC
 S RESULTS=$NA(^TMP($J,"ECMSG"))
 Q
