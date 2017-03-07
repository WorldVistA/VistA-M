VBECA7 ;DALOI/RLM - Workload API ; 8/18/04 10:40am
 ;;2.0;VBECS;;Jun 05, 2015;Build 4
 ;
 ; Note: This routine supports data exchange with an FDA registered
 ; medical device. As such, it may not be changed in any way without
 ; prior written approval from the medical device manufacturer.
 ; 
 ; Integration Agreements:
 ;  VBECS workload capture supported by IA 4627
 ; Reference to EN^MXMLPRSE supported by IA #4149
 ; Reference to $$FIND1^DIC supported by IA #2051
 ; Reference to UPDATE^DIE supported by IA #2053
 ; 
 QUIT
 ;
 ; ----------------------------------------------------------
 ;      Private Method Supports IA 4767
 ; ----------------------------------------------------------
WKLDCAP() ;
 S NEWWKLD=0
 D INITV^VBECRPCC("VBECS Workload")
 I +VBECPRMS("ERROR") S ARR("ERROR")=VBECPRMS("ERROR") Q
 S VBECPRMS("PARAMS",1,"TYPE")="STRING"
 S VBECPRMS("PARAMS",1,"VALUE")="P"
 F I=1:0 D  Q:'NEWWKLD
 . S NEWWKLD=0
 . S VBECSTAT=$$EXECUTE^VBECRPCC(.VBECPRMS)
 . S VBECY=$NA(^TMP("VBECS_XML_RES",$J))
 . K @VBECY
 . D PARSE^VBECRPC1(.VBECPRMS,VBECY)
 . I $D(@VBECY@("ERROR")) S ARR("ERROR")="1^"_@VBECY@("ERROR") S NEWWKLD=0 Q
 . D PARSE
 ;
EXIT I $D(VBERR) S ARR("ERROR")="1^Errors encountered during parse"
 K @VBECY,ATR,CBK,DIERR,ELE,FDA,OPTION,TEXT,VBECPRMS
 K VBECRES,VBECSTAT,VBECY,VBERRA,VBERRB
 Q '(+$D(ARR)) ;This will return a 1 for a successful transfer and load
PARSE ;The callbacks defined here will allow the MXMLPRSE API to place
 ;the data directly into file 6002.01
 S CBK("STARTELEMENT")="STELE^VBECA7"
 S CBK("ENDELEMENT")="ENELE^VBECA7"
 S CBK("CHARACTERS")="CHAR^VBECA7"
 S OPTION=""
 D EN^MXMLPRSE(VBECY,.CBK,.OPTION)
 Q
STELE(ELE,ATR) ;File the data for each attribute in the FDA array
 ;for use by the UPDATE^DIE Database Server API.
 I $D(ATR) D
  . I ELE["Trans",$D(ATR("id")) S FDA(1,6002.01,"+1,",.01)=ATR("id"),NEWWKLD=1
  . I $D(ATR("type")) S FDA(1,6002.01,"+1,",1)=ATR("type")
  . I $D(ATR("division")) S ATR("division")=$TR(ATR("division")," ",""),FDA(1,6002.01,"+1,",2)=$$FIND1^DIC(4,,"MX",ATR("division")) ;RLM 9/22/2010
  . I $D(ATR("accessionArea")) D
  . . S FDA(1,6002.01,"+1,",14)=ATR("accessionArea")
  . I $D(ATR("dateTime")) S FDA(1,6002.01,"+1,",3)=ATR("dateTime")
  . I $D(ATR("status")) S FDA(1,6002.01,"+1,",5)=ATR("status")
  . I $D(ATR("code")) D
  . . ;S FDA(1,6002.01,"+1,",6)=$$WKLDPTR(ATR("code"))
  . . S FDA(1,6002.01,"+1,",6)=$$WKLDPTR1(ATR("code"),ATR("method")) ;RLM 6-3-10
  . I $D(ATR("method")) D  ;RLM 6-3-10
  . . S FDA(1,6002.01,"+1,",7)=$$MTHDPTR(ATR("method")) ;RLM 6-3-10
  . I $D(ATR("multiplyFactor")) S FDA(1,6002.01,"+1,",8)=ATR("multiplyFactor")
  . I $D(ATR("dfn")) D
  . . I $D(^DPT(ATR("dfn"),-9)) S ATR("dfn")=+^DPT(ATR("dfn"),-9)
  . . I $D(^DPT(ATR("dfn"))) S FDA(1,6002.01,"+1,",9)=ATR("dfn")
  . I $D(ATR("duz")) D
  . . I $D(^VA(200,ATR("duz"))) S FDA(1,6002.01,"+1,",10)=ATR("duz")
  . I $D(ATR("accessionNumber")) S FDA(1,6002.01,"+1,",11)=ATR("accessionNumber")
  . I $D(ATR("testPerformed")) D
  . . I $D(^LAB(60,$$STRIP^XLFSTR(ATR("testPerformed")," "))) S FDA(1,6002.01,"+1,",12)=$$STRIP^XLFSTR(ATR("testPerformed")," ")
  . I ELE["Unit",$D(ATR("id")) S FDA(1,6002.01,"+1,",13)=ATR("id")
 Q
ENELE(ELE) ;Ignore the end of each element until the end of
 ;WorkloadTransactions is found.  File the data at this point.
 I ELE="WorkloadTransactions" D
  . Q:'NEWWKLD
  . D UPDATE^DIE("","FDA(1)",,"VBERR")
  . ;We'll remove the Writes and handle the errors in a different way
  . ;prior to release.
  . I $D(VBERR) D  ;W !,"An error has occurred with ID ",FDA(1,6002.01,"+1,",.01) D
  . . S (VBERRA,VBERRB,VBERRC)="" F  S VBERRA=$O(VBERR("DIERR",VBERRA)) Q:'VBERRA  F  S VBERRB=$O(VBERR("DIERR",VBERRA,"TEXT",VBERRB)) Q:'VBERRB  S VBERRC=VBERRC+1,XMTEXT(VBERRC)=VBERR("DIERR",VBERRA,"TEXT",VBERRB) K DIERR,VBERR
  . . S XMDUZ="VBECS Workload Event"
  . . S XMSUB="VBECS Workload Event"
  . . S XMTEXT="VBLN("
  . . S XMY("G.VBECS INTERFACE ADMIN")=""
  . . D ^XMD
  . . ;S (VBERRA,VBERRB)="" F  S VBERRA=$O(VBERR("DIERR",VBERRA)) Q:'VBERRA  F  S VBERRB=$O(VBERR("DIERR",VBERRA,"TEXT",VBERRB)) Q:'VBERRB  S ARR("ERROR")="1^Errors encountered during parse" W !,VBERR("DIERR",VBERRA,"TEXT",VBERRB) K DIERR,VBERR
 Q
CHAR(TEXT) ;This one isn't necessary, but we'll report an error
 ;if text is found.
 S VBERR("DIERR",999999,"TEXT",999999)="TEXT was returned unexpectedly"
 Q
WKLDPTR(CODE) ; Gets the pointer to the workload code file 64
 I $L($P(CODE,".",2))'=5 D
 . S VBSUFX=$P(CODE,".",2)
 . F I=1:1 S VBSUFX=VBSUFX_" " Q:$L(VBSUFX)=5
 . S $P(CODE,".",2)=VBSUFX
 Q $S($D(^LAM("C",CODE)):$O(^LAM("C",CODE,0)),1:0)
 Q
WKLDPTR1(CODE,CODE1) ; Gets the pointer to the workload code file 64 SWITCH TO E X-REF
 S CODE=$P(CODE,"."),CODE1=$TR(CODE1,".","") S:'CODE1 CODE1="0000"
 Q $S($D(^LAM("E",CODE_"."_CODE1)):$O(^LAM("E",CODE_"."_CODE1,0)),1:0)
 Q
MTHDPTR(CODE) ; Gets the pointer to the workload code file 64
 S LRSUF=$$FIND1^DIC(64.2,"","O","."_CODE_" ","C","","ERR")
 Q $S(LRSUF:LRSUF,1:"") ;
 ; ----------------------------------------------------------
 ;      Private Method Supports IA 4767
 ; ----------------------------------------------------------
UPDTWKLD ; Update VBECS Workload
 D UPDTWKLD^VBECA7A
 Q
TESTSET ;This sets up test data.
 Q  ;ZL VBECA7 D ZEOR,PARSE ;To test
 S ^TMP("VBEC_XML_RES",$J,1)="<BloodBank><WorkloadTransactions><Transaction id=""FIRST"" type=""P"" division=""589"" dateTime=""3040614"" status=""S""><Workload code=""Acetone"" method=""ACUTE"" multiplyFactor=""1"" />"
 S ^TMP("VBEC_XML_RES",$J,2)="<Patient dfn=""262768"" /><VbecsUser duz=""7"" /><Lab accessionNumber=""789"" testPerformed=""ABG"" /><Unit id=""A1"" /></Transaction></WorkloadTransactions>"
 Q
 ;
ZEOR ;VBECA7
