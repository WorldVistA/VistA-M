ECUMRPC2 ;ALB/JAM;Event Capture Management Broker Utils ; 23 Jul 2008
 ;;2.0; EVENT CAPTURE ;**25,30,42,46,47,49,75,72,95**;8 May 96;Build 26
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
 ;
 ;Output Variables:-
 ;  ^TMP($J,"ECFIND",1..n - returned array
 ;     IEN of file 200^Provider Name^occupation^specialty^subspecialty
 ;
 N I,IEN,CNT,FROM,DATE,ECUTN S I=0,CNT=$S(+$G(ECNUM)>0:ECNUM,1:44)  ;KEY="PROVIDER"
 ;S FROM=$P(ECSTR,"|"),DATE=$P(ECSTR,"|",2)
 S FROM=$P(ECSTR,"|"),DATE=$P(ECSTR,"|",2),REPORT=$P(ECSTR,"|",3)
 F  Q:I'<CNT  S FROM=$O(^VA(200,"B",FROM),ECDIR) Q:FROM=""  D
 . S IEN="" F  S IEN=$O(^VA(200,"B",FROM,IEN),ECDIR) Q:'IEN  D 
 . . ;I $L(KEY),'$D(^XUSEC(KEY,+IEN)) Q
 . . ;I +$G(ALLUSERS)=0,'$$ACTIVE^XUSER(IEN) Q  ; terminated user
 . . I REPORT="R" S I=I+1,^TMP($J,"ECFIND",I)=IEN_"^"_FROM_"^" Q
 . . S ECUTN=$$GET^XUA4A72(IEN,DATE)
 . . I DATE>0,ECUTN<1 Q
 . . S I=I+1,^TMP($J,"ECFIND",I)=IEN_"^"_FROM_"^"_$P(ECUTN,"^",2,4)
 Q
LEX ; returns a list of ICD code from lexicon lookup; called from ECUMRPC1
 ;Input Variables:-
 ;  ECSTR  - APP|ECX|ECDT
 ;           application|Search string|procedure date
 ;
 ;Output Variables:-
 ;  ^TMP($J,"ECFIND",1..n - returned array
 ;     ICD9 Code^LEX description^IEN of file 80^IEN of file 757.01
 ;
 N LEX,ILST,I,IEN,ECX,APP,ECDT,ICD9,ICDIEN,DIC,ECCD
 S APP=$P(ECSTR,"|"),ECX=$P(ECSTR,"|",2),ECDT=$P(ECSTR,"|",3)
 S ECDT=$G(ECDT,DT),DIC="^ICD9("
 ;spacebar default for DUZ
 I ECX=" ",+($G(DUZ))>0 S IEN=$G(^DISV(DUZ,DIC)) I +IEN D
 .S ECCD=$$ICDDX^ICDCODE(IEN,ECDT) S:+ECCD>0 ECX=$P(ECCD,U,2)
 D CONFIG^LEXSET(APP,APP,ECDT)    ;LEX DBIA1577
 D LOOK^LEXA(ECX,APP,1,"",ECDT)   ;LEX DBIA2950
 I '$D(LEX("LIST",1)) S ^TMP($J,"ECFIND",1)="0^No matches found." Q
 ;LEX DBIA1573
 S ILST=1,IEN=+LEX("LIST",1)
 D ICD I ICDIEN<0 S ^TMP($J,"ECFIND",1)="0^No matches found." Q
 S ^TMP($J,"ECFIND",ILST)=ICD9_U_$P(LEX("LIST",1),U,2)_U_ICDIEN_U_LEX("LIST",1),I=""
 F  S I=$O(^TMP("LEXFND",$J,I)) Q:I'<0  D
 . S IEN=$O(^TMP("LEXFND",$J,I,0))
 . D ICD I ICDIEN<0 Q
 . S ILST=ILST+1
 . S ^TMP($J,"ECFIND",ILST)=ICD9_U_^TMP("LEXFND",$J,I,IEN)_U_ICDIEN_U_IEN
 I $O(^TMP($J,"ECFIND",0))="" S ^TMP($J,"ECFIND",1)="0^No matches found."
 K ^TMP("LEXFND",$J),^TMP("LEXHIT",$J)
 Q
ICD ;ICD code
 S ICD9=$$ICDONE^LEXU(IEN,ECDT)
 S ICDIEN=+$$ICDDX^ICDCODE(ICD9,ECDT)
 Q
