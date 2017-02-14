VBECRPCM ;HOIFO/BNT - MAINTENANCE USE CASE RPCs ; 10/21/05 10:17am
 ;;2.0;VBEC;;Jun 05, 2015;Build 4
 ;
 ; Note: This routine supports data exchange with an FDA registered
 ; medical device. As such, it may not be changed in any way without
 ; prior written approval from the medical device manufacturer.
 ; 
 ; Integration Agreements:
 ; Reference DBIA 2343  - $$ACTIVE^XUSER
 ; Reference DBIA 10060 - NEW PERSON FILE
 ; Reference DBIA 4090  - $$CHARCHK^XOBVLIB
 ; Reference DBIA 10076 - XUSEC GLOBAL READ
 ; Reference DBIA 10090 - INSTITUTION FILE FILEMAN READ
 ; Reference DBIA 2817  - MEDICAL CENTER DIVISION FILE "AD" X-REF
 ; Reference DBIA 1963  - ACCESSION FILE GLOBAL READ
 ; Reference to GETS^DIQ() supported by IA #2056
 ; Reference to LIST^DIC supported by DBIA #2051
 ; Call to ^VA(200 is supported by IA: 10060
 ; Call to GETS^DIQ is supported by IA: 2056
 ; Reference to ^DIC(4 supported by IA #10090
 ; Reference to ^DG(40.8 supported by IA #2817
 ; Reference to ^LRO(68 supported by IA #1963
 ; 
 ;
 QUIT
 ;
 ; ---------------------------------------------------------------
 ;      Private Method supports IA 4608
 ; ---------------------------------------------------------------
BBUSER(RESULTS) ; Look up and return all BB users
 ;
 ;
 ; Input: RESULTS = Passed by reference used to return data to VistALink
 ;                  as XML.
 ;
 ; Screen Logic:  Only returns users from file 200 that hold either the
 ;                LRBLOODBANK or LRBLSUPER Security Key and do not have a
 ;                TERMINATION DATE prior to the current date.
 ;
 ;S VBECCNT=0
 ;S RESULTS=$NA(^TMP("VBECS_USER",$J))
 ;K @RESULTS
 ;D BEGROOT^VBECRPC("BloodBankUsers")
 ;
 ;D USRSRCH
 ;
 ;D ENDROOT^VBECRPC("BloodBankUsers")
 N VBIEN,VBXUSEC,CNT,VBXU,VBU
 S RESULTS=$NA(^TMP("BBUSERS",$J)),VBECCNT=0
 K @RESULTS
 D BEGROOT^VBECRPC("BloodBankUsers")
 D ADD^VBECRPC("<Record count='0' >")
 F VBXUSEC="LRBLOODBANK","LRBLSUPER" S VBXU=0 F  S VBXU=$O(^XUSEC(VBXUSEC,VBXU)) Q:VBXU=""  D
 . Q:'+$$ACTIVE^XUSER(VBXU)
 . S VBU(VBXU)=""
 . Q
 S (CNT,VBIEN)=0
 F  S VBIEN=$O(VBU(VBIEN)) Q:VBIEN=""  D
 . S CNT=CNT+1
 . D BEGROOT^VBECRPC("BloodBankUser")
 . D ADD^VBECRPC("<UserName>"_$$CHARCHK^XOBVLIB($P(^VA(200,VBIEN,0),"^",1))_"</UserName>")
 . D ADD^VBECRPC("<UserDUZ>"_$$CHARCHK^XOBVLIB(VBIEN)_"</UserDUZ>")
 . D ADD^VBECRPC("<UserInitials>"_$$CHARCHK^XOBVLIB($P(^VA(200,VBIEN,0),"^",2))_"</UserInitials>")
 . D BBUSRDIV(VBIEN)
 . D ENDROOT^VBECRPC("BloodBankUser")
 S @RESULTS@(2)="<Record count='"_CNT_"' >"
 D ENDROOT^VBECRPC("Record")
 D ENDROOT^VBECRPC("BloodBankUsers")
 K VBECCNT
 Q
 ;
USRSRCH ; Search for valid Blood Bank users
 ;
 N DD,DIVSUB,VBUSRDUZ,VBUSRNME,VBUSRINI,IENS,BBUSRDIV,DIVERR
 S DD=200,DIVSUB="200.02"
 S SCREEN="I $$USRSCR^VBECRPCM(+Y)"
 D LIST^DIC(DD,"","@;.01;1","P","","","","",.SCREEN,"","","ERR")
 ;
 D ADD^VBECRPC("<Record count='"_$$CHARCHK^XOBVLIB(+$P(^TMP("DILIST",$J,0),U))_"' >")
 S X=0
 F  S X=$O(^TMP("DILIST",$J,X)) Q:X=""  D
 . D BEGROOT^VBECRPC("BloodBankUser")
 . ; User Name
 . S VBUSRNME=$P(^TMP("DILIST",$J,X,0),U,2)
 . ; User DUZ
 . S VBUSRDUZ=+$P(^TMP("DILIST",$J,X,0),U)
 . ; User Initials
 . S VBUSRINI=$P(^TMP("DILIST",$J,X,0),U,3)
 . ;
 . D ADD^VBECRPC("<UserName>"_$$CHARCHK^XOBVLIB(VBUSRNME)_"</UserName>")
 . D ADD^VBECRPC("<UserDUZ>"_$$CHARCHK^XOBVLIB(VBUSRDUZ)_"</UserDUZ>")
 . D ADD^VBECRPC("<UserInitials>"_$$CHARCHK^XOBVLIB(VBUSRINI)_"</UserInitials>")
 . ;
 . ; Get all Divisions for this user.
 . D BBUSRDIV(VBUSRDUZ)
 . ;
 . D ENDROOT^VBECRPC("BloodBankUser")
 . Q
 D ENDROOT^VBECRPC("Record")
 Q
 ;
BBUSRDIV(VBDUZ) ; Gets the divisions for the user and creates the XML
 ;
 N X,DIV,DIVIEN,OUT
 ; Must be active user
 S X=$$DIV4^XUSER(.DIV,VBDUZ)
 Q:'X
 D BEGROOT^VBECRPC("Divisions")
 S DIV=0
 F  S DIV=$O(DIV(DIV)) Q:DIV=""  D
 . D GETDIV(.OUT,DIV)
 . I '+$P(OUT,U) S ERR=$P(OUT,U,2) D ERROR(ERR) Q
 . Q:'$D(OUT)
 . S DIVIEN=DIV_","
 . ; Check if division is active
 . I $G(OUT(4,DIVIEN,101))=1 Q
 . ;
 . ;D BEGROOT^VBECRPC("Division")
 . ;D ADD^VBECRPC("<DivisionName>"_$$CHARCHK^XOBVLIB(OUT(4,DIVIEN,.01))_"</DivisionName>")
 . D ADD^VBECRPC("<Division divisionCode="""_$$CHARCHK^XOBVLIB(OUT(4,DIVIEN,99))_""" />")
 . ;D ENDROOT^VBECRPC("Division")
 . Q
 D ENDROOT^VBECRPC("Divisions")
 Q
 ;
USRSCR(IEN) ; Screens for valid Blood Bank Users
 Q:(IEN']"")!(IEN<0) 0
 Q:('$D(^XUSEC("LRBLOODBANK",IEN)))&('$D(^XUSEC("LRBLSUPER",IEN))) 0
 Q +$$ACTIVE^XUSER(IEN)
 ;
 ; ---------------------------------------------------------------
 ;      Private Method supports IA 4609
 ; ---------------------------------------------------------------
DIV(RESULTS) ; Lookup and return all Divisions associated with a medical center
 ;
 N DD,OUT,ERR,DIV,DIVIEN
 S VBECCNT=0
 S RESULTS=$NA(^TMP("VBECS_DIVISIONS",$J))
 K @RESULTS
 D BEGROOT^VBECRPC("Divisions")
 ;
 S DIV=0
 F  S DIV=$O(^DG(40.8,"AD",DIV)) Q:DIV=""  D  Q:$D(ERR)
 . D GETDIV(.OUT,DIV)
 . I '+$P(OUT,U) S ERR=$P(OUT,U,2) D ERROR(ERR) Q
 . Q:'$D(OUT)
 . S DIVIEN=DIV_","
 . ; See DR - 1670 / VistA MR 006
 . ; Removed check if division is a medical center
 . ; Added screen for station numbers greater than 5
 . I $L(OUT(4,DIVIEN,99))>5 Q
 . I $G(OUT(4,DIVIEN,99))="" Q
 . ; Check if division is active
 . I $G(OUT(4,DIVIEN,101))=1 Q
 . D BEGROOT^VBECRPC("Division")
 . D ADD^VBECRPC("<DivisionCode>"_$$CHARCHK^XOBVLIB(OUT(4,DIVIEN,99))_"</DivisionCode>")
 . D ADD^VBECRPC("<DivisionName>"_$$CHARCHK^XOBVLIB(OUT(4,DIVIEN,.01))_"</DivisionName>")
 . D ENDROOT^VBECRPC("Division")
 D ENDROOT^VBECRPC("Divisions")
 ;
 K VBECCNT
 Q
 ;
GETDIV(OUT,INST) ;
 ; Returns data associated with a Division represented by the
 ; Institution pointer
 ;
 ; Input:    OUT  = Passed by reference used to return array
 ;           INST = Pointer to Institution file
 ;
 ; Returns:  Output from LIST^DIC in the OUT array containing data from
 ;           fields .01, 99 and 101
 ;
 N ERR
 S OUT="1^"
 I INST']"" S OUT="0^Pointer to Institutuion file not found"
 I INST'["," S INST=INST_","
 D GETS^DIQ(4,INST,".01;99;101",,"OUT","ERR")
 I $D(ERR) S OUT="0^"_ERR("DIERR",1,"TEXT",1)
 Q
 ;
 ; ---------------------------------------------------------------
 ;      Private Method Supports IA 4607
 ; ---------------------------------------------------------------
ACNAREA(RESULTS) ; Gets the Blood Bank Accession Areas from the Accession file
 ; Supporst MUC_02 Configure Division
 ;
 N X,VBECARY
 S (VBECCNT,X)=0
 S RESULTS=$NA(^TMP("VBECS_ACCESSION_AREAS",$J))
 K @RESULTS
 D BEGROOT^VBECRPC("AccessionAreas")
 F  S X=$O(^LRO(68,X)) Q:X'?1N.N  D
 . Q:$P(^LRO(68,X,0),"^",2)'="BB" 
 . S VBECARY(X)=$P(^LRO(68,X,0),"^")
 . D BEGROOT^VBECRPC("AccessionArea")
 . D ADD^VBECRPC("<AccessionAreaName>"_$$CHARCHK^XOBVLIB($P(^LRO(68,X,0),"^"))_"</AccessionAreaName>")
 . D ADD^VBECRPC("<AccessionAreaId>"_$$CHARCHK^XOBVLIB(X)_"</AccessionAreaId>")
 . D ENDROOT^VBECRPC("AccessionArea")
 D ENDROOT^VBECRPC("AccessionAreas")
 ;
 K VBECCNT
 Q
 ;       
ERROR(TEXT) ;
 D ERROR^VBECRPC(TEXT)
 Q
