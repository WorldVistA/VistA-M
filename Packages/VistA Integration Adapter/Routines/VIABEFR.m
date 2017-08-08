VIABEFR ;AAC/JMC - VIA EFR RPCs ;05/17/2016
 ;;1.0;VISTA INTEGRATION ADAPTER;**9**;06-FEB-2014;Build 1
 ;
 ;The following RPC is in support of the Embedded Fragment Registry (EFR). This RPC reads data from the
 ;RESEARCH File #67.1 and the LAB DATA File #63. 
 ;
 ; RPC VIAB EFR
 ; ICR 2052     Database Server API: Data Dictionary Utilities
 ; ICR 6743     VIAB LAB [File 63, "CH" node] (private)
 ; ICR 6476     RESEARCH [File #67.1, fields #.01,9,63] (private)
 ;
 Q
 ;
EN(RESULT,VIA) ; entry point for RPC
 D PARSE(.VIA)
 D TMP
 D DTCHK
 D LAB671
 D KVAR
 Q
 ;
PARSE(VIA) ; -- array parsing to parameters and initializing variables
 ;Input parameters
 ;        VIA("FROM")=value to start from in Files #67.1 & #63.04 [optional]
 ;        VIA("SDATE")=Start Date for search [optional]
 ;        VIA("EDATE")=End Date for search [optional]
 ;        VIA("IDS")=List of Patient Identifiers separated by a semicolon [optional]
 ;        VIA("FIELDS")=list of extra fields to return data, separate by semicolon (;)[optional]
 ;           Example:  VIA("FIELDS")="631807;631568;631567;631007;631808;631798;631799;631800;631801;631809"
 ;        VIA("MAX")=n [optional]
 N SFLDS,IFLDS,I,X
 S VIAFIELDS=$G(VIA("FIELDS"))
 S VIAMAX=$G(VIA("MAX")) I VIAMAX>1000 S VIAMAX=1000
 I $G(VIAMAX)="" S VIAMAX=1000
 S VIAFROM=$G(VIA("FROM"))
 S VIABFRM=VIAFROM
 S VIASDT=$G(VIA("SDATE"))
 S VIAEDT=$G(VIA("EDATE"))
 S VIAIDS=$G(VIA("IDS"))
 Q 
 ;
TMP ; -- temporary environment variables sets until kernel tools arrives
 IF '$G(DUZ) D
 . S DUZ=.5,DUZ(0)="@",U="^",DTIME=300
 . D NOW^%DTC S DT=X
 Q
 ;
LAB671 ; -- returns a list of lab identifiers from RESEARCH File #67.1
 ; Builds the ^TMP("VIABEFR",$J) array
 ;  ^TMP("VIABEFR",$J,1)="[Data"] or if there is an error ^TMP("VIABEFR",$J,1)="[Errors"]
 ;  ^TMP("VIABEFR",$J,n)=67.1:IEN^.01 NAME^9 IDENTIFIER^63 LABORATORY REFERENCE
 ;              where n is a numeric value starting from 2
 ;
 N VIACNT,VIA671,IENS,QFLG,LRIEN,VIAC,XREF,STR671
 K ^TMP("VIABEFR",$J)
 S VIAC=1,(VIACNT,QFLG)=0
 S ^TMP("VIABEFR",$J,1)="[Data]"
 I VIAIDS'="" D IDS Q
 I VIAFROM'="" S VIAFROM=$$STRTFRM() I VIAFROM="" D  Q
 . S ^TMP("VIABEFR",$J,1)="[Errors]"
 . S ^TMP("VIABEFR",$J,2)="Starting Entry not found" K RESULT S RESULT=$NA(^TMP("VIABEFR",$J)) Q
 S XREF=$S(VIAFROM'="":VIAFROM,1:"")
 F  S XREF=$O(^LRT(67.1,"B",XREF)) Q:XREF=""  D  I QFLG Q
 . S IENS=0 F  S IENS=$O(^LRT(67.1,"B",XREF,IENS)) Q:'IENS  D  I QFLG Q
 . . S LRIEN=$$GET1^DIQ(67.1,IENS,63,"I") I LRIEN="" Q
 . . S $P(VIA671,U)=$$GET1^DIQ(67.1,IENS,.01,"I"),$P(VIA671,U,9)=$$GET1^DIQ(67.1,IENS,9,"I")
 . . S STR671="67.1:"_IENS_U_$P(VIA671,U)_U_$P(VIA671,U,9)_U_LRIEN
 . . D LAB6304
 K RESULT
 S RESULT=$NA(^TMP("VIABEFR",$J))
 Q
 ; 
IDS ; -- return lab results for list of identifiers
 N VIAID,I,X,Y
 ; parse identifiers into array
 F I=1:1:$L(VIAIDS,";") S Y=$P(VIAIDS,";",I) I Y'="" S VIAID(Y)=""
 S XREF="" F  S XREF=$O(VIAID(XREF)) Q:XREF=""  D:$D(^LRT(67.1,"C",XREF))  I QFLG Q
 . S IENS=0 F  S IENS=$O(^LRT(67.1,"C",XREF,IENS)) Q:'IENS  D  I QFLG Q
 . . S LRIEN=$$GET1^DIQ(67.1,IENS,63,"I") I LRIEN="" Q
 . . S $P(VIA671,U)=$$GET1^DIQ(67.1,IENS,.01,"I"),$P(VIA671,U,9)=$$GET1^DIQ(67.1,IENS,9,"I")
 . . S STR671="67.1:"_IENS_U_$P(VIA671,U)_U_$P(VIA671,U,9)_U_LRIEN
 . . D LAB6304
 K RESULT
 S RESULT=$NA(^TMP("VIABEFR",$J))
 Q
 ;
LAB6304 ; -- Using the LAB IEN from File #67.1, get data from LAB DATA File #63.04
 ; Builds ^TMP("VIABEFR",$J,n)=list of standard fields returned by the RPC. n is a numeric value.
 ;        ^TMP("VIABEFR",$J,n+1)=63:04:IEN^.01 DATE/TIME SPECIMEN TAKEN^.06 ACCESSION^.03 DATE REPORT COMPLETED
 ;        ^TMP("VIABEFR",$J,n+2)=4 CREATININE
 ;        ^TMP("VIABEFR",$J,n+3)=31 COPPER
 ;        ^TMP("VIABEFR",$J,n+4)=32 ZINC
 ;        ^TMP("VIABEFR",$J,n+5)=33 ARSENIC
 ;        ^TMP("VIABEFR",$J,n+6)=35 LEAD (SK)
 ;        ^TMP("VIABEFR",$J,n+7)=101 CADMIUM
 ;        ^TMP("VIABEFR",$J,n+8)=106 CHROMIUM
 ;        ^TMP("VIABEFR",$J,n+9)=108 COBALT
 ;        ^TMP("VIABEFR",$J,n+10)=116 MANGANESE (SK)
 ;        ^TMP("VIABEFR",$J,n+11)=205 ALUMINUM
 ;        ^TMP("VIABEFR",$J,n+12)=322 NICKEL (SK)
 ;        ^TMP("VIABEFR",$J,n+13)=750 IRON
 ;        ^TMP("VIABEFR",$J,n+14)=797 VOLUME
 ;        ^TMP("VIABEFR",$J,n+15)=840 ELAPSED TIME
 ; VIAEFLDS - custom fields passed in as input parameter and returned by the RPC are stored after the standard fields.
 ;        ^TMP("VIABEFR",$J,n+16)=TESTNAME;NUMBER^RESULT
 ;
 N X,VIAEFLDS,VIASFLDS,VIASFLDS1,VIASTR,IVDT,J,FLD,F671,VIAVAL
 S VIASFLDS=".01;.06;.03",VIASFLDS1="4;31;32;33;35;101;106;108;116;205;322;750;797;840",F671=1
 S VIAEFLDS=VIAFIELDS,IVDT=$S(VIABFRM'="":$P($P(VIABFRM,"^",2),",",2),1:VIASDT)
 F  S IVDT=$O(^LR(LRIEN,"CH",IVDT)) Q:'IVDT  Q:(IVDT>VIAEDT)  D  I VIACNT>VIAMAX S QFLG=1 D SETFRM Q
 . I F671 S VIAC=VIAC+1,^TMP("VIABEFR",$J,VIAC)=STR671,VIACNT=VIACNT+1,F671=0
 . S VIAVAL="",VIACNT=VIACNT+1
 . F J=1:1:$L(VIASFLDS,";") S FLD=$P(VIASFLDS,";",J) I FLD'="" D
 . . S VIASTR=$$GET1^DIQ(63.04,IVDT_","_LRIEN_",",FLD,"I")
 . . S VIAVAL=VIAVAL_$S(VIAVAL="":"",1:"^")_VIASTR
 . S VIAC=VIAC+1,^TMP("VIABEFR",$J,VIAC)="63.04:"_IVDT_"^"_VIAVAL
 . ; get data for remaining standard fields; get entire node since these are stored in non-standard FileMan format.
 . F J=1:1:$L(VIASFLDS1,";") S FLD=$P(VIASFLDS1,";",J) I FLD'="" D STMP
 . ; get data for additional fields passed in input parameter
 . F J=1:1:$L(VIAEFLDS,";") S FLD=$P(VIAEFLDS,";",J) I FLD'="" D STMP
 Q
 ;
STMP ;set ^TMP("VIAEFR"
 N FLDNM,VIASTR
 D FIELD^DID(63.04,FLD,,"LABEL","VIALB") S FLDNM=$$UP^XLFSTR($G(VIALB("LABEL")))
 S VIASTR=$G(^LR(LRIEN,"CH",IVDT,FLD))
 I VIASTR'="" S VIAC=VIAC+1,^TMP("VIABEFR",$J,VIAC)=FLDNM_";"_FLD_"^"_VIASTR
 K VIALB
 Q
 ;
STRTFRM() ; find where to start File 67.1 search
 N STR
 S STR=$P($P(VIAFROM,U),",")
 I $D(^LRT(67.1,"B",STR)) S VIAFROM=$O(^LRT(67.1,"B",STR),-1) Q VIAFROM
 S STR=$G(^LRT(67.1,+$P($P(VIAFROM,U),",",2),0)) I STR'="" S VIAFROM=$O(^LRT(67.1,"B",STR),-1) Q VIAFROM
 Q ""
 ;
SETFRM ; entry to start list.
 S VIAC=VIAC+1,^TMP("VIABEFR",$J,VIAC)="[Misc]"
 S VIAC=VIAC+1,^TMP("VIABEFR",$J,VIAC)="MORE"_U_$P(VIA671,U)_","_IENS_U_LRIEN_","_$G(IVDT)
 Q
 ;
DTCHK ;check/set date
 I $G(VIAEDT)<$G(VIASDT) S X=$G(VIAEDT),VIAEDT=$G(VIASDT),VIASDT=X
 I $G(VIAEDT) S VIAEDT=$S($L(VIAEDT,".")=2:VIAEDT+.000001,1:VIAEDT+1)
 S VIASDT=$S($G(VIASDT):9999999-VIASDT,1:9999999),VIAEDT=$S($G(VIAEDT):9999999-VIAEDT,1:1)
 S X=VIAEDT,VIAEDT=VIASDT,VIASDT=X
 Q
 ;
KVAR ;Clean-up
 K VIAFIELDS,VIAEDT,VIAMAX,VIASDT,VIAFROM,VIABFRM,VIAIDS,X,Y
 Q
 ;
