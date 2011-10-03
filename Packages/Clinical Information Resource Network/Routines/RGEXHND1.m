RGEXHND1 ;BAY/ALS-MPI/PD EXCEPTION HANDLING UTILITY ;10/08/99
 ;;1.0;CLINICAL INFO RESOURCE NETWORK;**3,12,19,23,43,45,52,57**;30 Apr 99;Build 2
DTLIST ;List exceptions by date
 K ^TMP("RGEXC",$J)
 I '$D(RGBG) S VALMBG=1
 ;**45 list exception 234 first regardless of date - Primary View Reject
 S EXCDT="",EXCTYP=234,(CNT,IEN)=0
 F  S IEN=$O(^RGHL7(991.1,"ASTAT","0",EXCTYP,IEN)) Q:'IEN  D
 .S IEN2=0
 .F  S IEN2=$O(^RGHL7(991.1,"ASTAT","0",EXCTYP,IEN,IEN2)) Q:'IEN2  D
 ..S EXCDT=$P(^RGHL7(991.1,IEN,0),"^",3)
 ..D ADDREC
 ;**57 MPIC_1893 Only exception type 234 remains, rest are obsolete
 ;S EXCDT="",EXCTYP=""
 ;F  S EXCDT=$O(^RGHL7(991.1,"AD",EXCDT)) Q:'EXCDT  D
 ;. S IEN=0
 ;. F  S IEN=$O(^RGHL7(991.1,"AD",EXCDT,IEN)) Q:'IEN  D
 ;.. S NUM="" S NUM=$P($G(^RGHL7(991.1,IEN,1,0)),"^",4) Q:NUM<1  D
 ;... S IEN2=0
 ;... F  S IEN2=$O(^RGHL7(991.1,IEN,1,IEN2)) Q:'IEN2  D
 ;.... S EXCTYP=$P(^RGHL7(991.1,IEN,1,IEN2,0),"^",3)
 ;....;don't include 234 below; those were done first (above).
 ;.... I EXCTYP=218 D ADDREC  ;**45;**52 MPIC_772 remove 215, 216 & 217
 K I,NUM,EXCDT,EXCTYP,RGBG
 IF CNT<1 D NDATA
 Q
 ;
NDATA ; There is no data matching the criteria
 S CNT=CNT+1,STRING=""
 S STRING=$$SETSTR^VALM1("There were no exceptions found.",STRING,5,35)
 S ^TMP("RGEXC",$J,CNT,0)=STRING
 S ^TMP("RGEXC",$J,"IDX",CNT,CNT)=""
 S VALMCNT=CNT
 Q
EXCLST ;List exceptions by type
 K ^TMP("RGEXC",$J)
 S CNT=0,EXCDT="",EXCTYP=""
 I '$D(RGBG) S VALMBG=1
 F  S EXCTYP=$O(^RGHL7(991.1,"AC",EXCTYP)) Q:'EXCTYP  D
 . I EXCTYP=234 D  ;**45;**52 MPIC_772 remove 215, 216 & 217;**57 MPIC_1893 remove 218
 .. S IEN=0
 .. F  S IEN=$O(^RGHL7(991.1,"AC",EXCTYP,IEN)) Q:'IEN  D
 ... S NUM="" S NUM=$P($G(^RGHL7(991.1,IEN,1,0)),"^",4) Q:NUM<1  D
 .... S IEN2=0
 .... F  S IEN2=$O(^RGHL7(991.1,"AC",EXCTYP,IEN,IEN2)) Q:'IEN2  D
 ..... S EXCDT=$P($G(^RGHL7(991.1,IEN,0)),"^",3) Q:'EXCDT
 ..... D ADDREC
 IF CNT<1 D NDATA
 K RGBG
 Q
PATLST ;List exceptions by patient
 K ^TMP("RGEXC",$J),^TMP("RGEX01",$J)
 S CNT=0,EXCDT="",EXCTYP="",NDX=0,NAME=""
 I '$D(RGBG) S VALMBG=1
 F  S EXCTYP=$O(^RGHL7(991.1,"ADFN",EXCTYP)) Q:'EXCTYP  D
 . I EXCTYP=234 D  ;**45;**52 MPIC_772 remove 215, 216 & 217;**57 MPIC_1893 remove 218
 .. S DFN=""
 .. F  S DFN=$O(^RGHL7(991.1,"ADFN",EXCTYP,DFN)) Q:'DFN  D
 ... S IEN=0
 ... F  S IEN=$O(^RGHL7(991.1,"ADFN",EXCTYP,DFN,IEN)) Q:'IEN  D
 .... S IEN2=0
 .... F  S IEN2=$O(^RGHL7(991.1,"ADFN",EXCTYP,DFN,IEN,IEN2)) Q:'IEN2  D
 ..... S EXCDT=$P($G(^RGHL7(991.1,IEN,0)),"^",3) Q:'EXCDT
 ..... D DEM^VADPT S NAME=VADM(1) Q:NAME=""
 ..... S NDX=NDX+1
 ..... S ^TMP("RGEX01",$J,NAME,NDX)=$G(VADM(1))_"^"_IEN_"^"_IEN2_"^"_EXCTYP_"^"_EXCDT
 D PATTMP
 IF CNT<1 D NDATA
 K DFN,RGBG
 Q
PATTMP ;
 S NM=""
 F  S NM=$O(^TMP("RGEX01",$J,NM)) Q:NM=""  D
 . S NDX=0
 . F  S NDX=$O(^TMP("RGEX01",$J,NM,NDX)) Q:'NDX  D
 .. S IEN=$P(^TMP("RGEX01",$J,NM,NDX),"^",2)
 .. S IEN2=$P(^TMP("RGEX01",$J,NM,NDX),"^",3)
 .. S EXCTYP=$P(^TMP("RGEX01",$J,NM,NDX),"^",4)
 .. S EXCDT=$P(^TMP("RGEX01",$J,NM,NDX),"^",5)
 .. D ADDREC
 K NDX,NM,NAME
 Q
SELTYP ; List all exceptions of type selected by user
 S EXCTYPE="",FLAG=0,ETYPE=""
 I '$D(RGBG) S VALMBG=1
 K DIR,Y,DIC
 S DIR("A")="Enter an exception type to view: ",DIR("B")=234 ;**57 MPIC_1893 Only exception type 234 remains, rest are obsolete
 S DIR(0)="SAM^234:Primary View Reject" ;**43;**45;**52 MPIC_772 remove 215, 216 & 217 ;**57 MPIC_1893 remove 218
 S DIR("?")="^D HLPSEL^RGEXHND1"
 D ^DIR
 I Y<1 S RGSORT="SD" D SORT^RGEX01  Q
 Q:$D(DUOUT)!$D(DTOUT)
 S EXCTYPE=+Y,ETYPE=$P(^RGHL7(991.11,EXCTYPE,10),"^",1)
 I EXCTYPE=234 S FLAG=1 ;**43;**45;**52 MPIC_772 remove 215, 216 & 217 ;**57 MPIC_1893 remove 218
 I FLAG=1 D ADDSEL
 E  I FLAG=0 D
 . W !,"Not a valid selection."
 . D SELTYP
 K FLAG,Y,DIR,DIC,DTOUT,DUOUT,RGBG
 Q
ADDSEL ;called by SELTYP
 K ^TMP("RGEXC",$J)
 S CNT=0,EXCDT="",EXCTYP=""
 F  S EXCTYP=$O(^RGHL7(991.1,"AC",EXCTYP)) Q:'EXCTYP  D
 . I EXCTYP=EXCTYPE D
 .. S IEN=0
 .. F  S IEN=$O(^RGHL7(991.1,"AC",EXCTYP,IEN)) Q:'IEN  D
 ... S IEN2=0
 ... F  S IEN2=$O(^RGHL7(991.1,"AC",EXCTYP,IEN,IEN2)) Q:'IEN2  D
 .... S EXCDT=$P($G(^RGHL7(991.1,IEN,0)),"^",3) Q:'EXCDT  ;**43
 .... D ADDREC
 I CNT<1 D
 . W !,"There are no "_ETYPE
 . W !,"exceptions that need processing."
 . D SELTYP
 Q
HLPSEL ;
 D FULL^VALM1
 ;W !,"The following exception types are handled by this option:"
 ;W !,"Primary View Reject",?50,"(234)"
 S VALMBCK="R"
 Q
ADDREC ;
 S ETEXT="",RGDFN="",ICN="",RGNM="",STAT="",DOD=""
 S ETEXT=$P($G(^RGHL7(991.11,EXCTYP,10)),"^",1)
 S RGDFN=$P(^RGHL7(991.1,IEN,1,IEN2,0),"^",4) Q:'RGDFN
 S STAT=$P($G(^RGHL7(991.1,IEN,1,IEN2,0)),"^",5)
 S ICN=+$$GETICN^MPIF001(RGDFN)
 S HOME=$$SITE^VASITE()
 I (STAT<1)!(STAT="") D
 .;Only list exceptions that are Not Processed
 .; only list patients with local ICN, or for exception 234 ;**52 MPIC_772 remove 215, 216 & 217;**57 MPIC_1893 remove 218
 . I $E(ICN,1,3)=$E($P(HOME,"^",3),1,3)!(ICN<0)!(EXCTYP=234) D  ;**43,**45,**52,**57
 .. S DFN=RGDFN D DEM^VADPT
 .. S RGNM=VADM(1)
 .. S RGSSN=$P($G(VADM(2)),"^",1)
 .. S DOB=$G(VADM(3)) I DOB="" S DOB="^"
 .. S DOD=$P($P($G(VADM(6)),"^",2),"@",1)
 .. S EXDATE=$P($$FMTE^XLFDT(EXCDT,2),"@",1)
 .. S CNT=CNT+1
 .. S STRING=""
 .. I ICN<0 S ICN=""
 .. S STRING=$$SETSTR^VALM1(CNT,STRING,1,4)
 .. S STRING=$$SETSTR^VALM1($E(RGNM,1,22),STRING,6,21)
 .. S STRING=$$SETSTR^VALM1(RGSSN,STRING,28,10)
 .. S STRING=$$SETSTR^VALM1(EXDATE,STRING,39,8)
 .. S STRING=$$SETSTR^VALM1(ETEXT,STRING,49,32)
 .. S ^TMP("RGEXC",$J,CNT,0)=STRING
 .. S ^TMP("RGEXC",$J,"IDX",CNT,CNT)=""
 .. S ^TMP("RGEXC",$J,CNT,"DATA")=RGNM_"^"_RGSSN_"^"_$P($$FMTE^XLFDT(EXCDT),"@",1)_"^"_ETEXT_"^"_DFN_"^"_ICN_"^"_DOB_"^"_STAT_"^"_IEN_"^"_IEN2_"^"_CNT_"^"_DOD
 S VALMCNT=CNT
 K RGDFN,RGNM,RGSSN,EXDATE,ETEXT,ICN,DOB,STAT,VADM,HOME,STRING,DOD
 Q
SELECT ;
 I $G(STRING)["no exceptions found" D SORT^RGEX01  Q
 N VALMY
 D EN^VALM2(XQORNOD(0),"OS")
 I '$D(VALMY) Q
 S VALMCNT=CNT
 S DATA="",CNT=""
 S CNT=$O(VALMY(0))
 S DATA=$G(^TMP("RGEXC",$J,CNT,"DATA"))
 I '$D(DATA) S CNT=0 Q
 D CLEAN^VALM10
 D EN^RGEX03(DATA)
 I RGSORT="VT" D
 . K @VALMAR
 . D ADDSEL
 E  I RGSORT'="VT" D SORT^RGEX01
 ;
 Q
QUIT ;
