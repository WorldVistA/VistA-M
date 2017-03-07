VBECRPCE ;HOIFO/BNT-Lookup PROVIDERS based on DIVISION ;22 March 2004
 ;;2.0;VBEC;;Jun 05, 2015;Build 4
 ;
 ; Note: This routine supports data exchange with an FDA registered
 ; medical device. As such, it may not be changed in any way without
 ; prior written approval from the medical device manufacturer.
 ; 
 ; Integration Agreements:
 ; Reference DBIA 10076 - XUSEC GLOBAL READ
 ; Reference DBIA 10060 - NEW PERSON FILE
 ; Reference DBIA 10090 - INSTITUTION FILE
 ; Reference DBIA 2051  - LIST^DIC
 ; Reference to $$UP^XLFSTR is supported by IA: 10104
 ; Reference to $$FIND1^DIC supported by IA #2051
 ; Reference to $$FIND1^DIC supported by IA #2051
 ; Reference to ^DIC(4 supported by IA #10090
 ;
 ; This routine should not be called from the top.
 QUIT
 ;
 ; ----------------------------------------------------------------
 ;       Private Method supports IA 4617
 ; ----------------------------------------------------------------
PROVIDER(RESULTS,DIV,DATA) ;
 ; Look up and return all active providers by division
 ;
 ; Input: RESULTS = Passed by reference used to return data to VistALink
 ;                  as XML.
 ;        DIV     = (Required) Station number of Division used to
 ;                   locate providers
 ;        DATA    = (Optional) Text string used to perform lookup. If
 ;                   null, will return all providers for division.
 ;
 ; Screen Logic:  Only returns users from file 200 that hold the
 ;                PROVIDER Security Key, do not have a TERMINATION
 ;                DATE prior to the current date, and have access to
 ;                the Division passed in the DIV parameter.
 ;
 ;
 S VBECCNT=0
 S RESULTS=$NA(^TMP("VBECS_PROVIDERS",$J))
 K @RESULTS
 D BEGROOT^VBECRPC("Providers")
 ;
 ; Get INSTITUTION file pointer for DIV parameter.
 K ERR S DIVIEN=$$FIND1^DIC(4,,"QX",.DIV,"D",,"ERR")
 I $D(ERR) D  Q
 . D ADD^VBECRPC("<Record count='0' >")
 . D ERROR^VBECRPC(ERR("DIERR",1,"TEXT",1))
 . D ENDROOT^VBECRPC("Record"),ENDROOT^VBECRPC("Providers")
 . Q
 ; Perform the search
 D PRVSRCH(DATA,DIVIEN)
 ;
 D ENDROOT^VBECRPC("Providers")
 D KILL
 Q
 ;
PRVSRCH(DATA,DIVIEN) ;
 ; Get list of PROVIDER's based on DATA and DIVIEN input
 ;             
 ;
 N DD,ERR
 I '$D(VBECCNT) S VBECCNT=0
 S DD=200
 I $D(DATA) S DATA=$$UP^XLFSTR(DATA)
 S SCREEN="I $$PRVSCR^VBECRPCE(+Y)"
 D LIST^DIC(DD,"","@;.01","P","","",.DATA,"B",.SCREEN,"","","ERR")
 I $D(ERR) D  Q
 . D ADD^VBECRPC("<Record count='0' >")
 . D ERROR^VBECRPC(ERR("DIERR",1,"TEXT",1))
 . D ENDROOT^VBECRPC("Record")
 . Q
 ;
 D ADD^VBECRPC("<Record count='"_$$CHARCHK^XOBVLIB(+$P(^TMP("DILIST",$J,0),U))_"' >")
 S X=0
 F  S X=$O(^TMP("DILIST",$J,X)) Q:X=""  D
 . D BEGROOT^VBECRPC("Provider")
 . D ADD^VBECRPC("<ProviderIEN>"_$$CHARCHK^XOBVLIB(+$P(^TMP("DILIST",$J,X,0),U))_"</ProviderIEN>")
 . D ADD^VBECRPC("<ProviderName>"_$$CHARCHK^XOBVLIB($P(^TMP("DILIST",$J,X,0),U,2))_"</ProviderName>")
 . D ENDROOT^VBECRPC("Provider")
 . Q
 D ENDROOT^VBECRPC("Record")
 Q
 ;
PRVSCR(IEN) ; Screens for valid providers
 Q:(IEN']"")!(IEN<0)!('$D(^XUSEC("PROVIDER",IEN))) 0
 Q:'$D(^VA(200,IEN,2,"B",DIVIEN)) 0
 Q $$ACTIVE^XUSER(IEN)
 ;
KILL ; Kill variables
 K VBECCNT,DIVIEN
 K ^TMP("DILIST",$J)
 Q
