HMPPTRPC ;ASMR/MBS,CK - Patient Select RPC;May 15, 2016 14:15
 ;;2.0;ENTERPRISE HEALTH MANAGEMENT PLATFORM;**1,2**;May 15, 2016;Build 28
 ;Per VA Directive 6402, this routine should not be modified.
 ; ROUTINE          IA#
 ; XLFSTR          10104
 ; XLFSTR          10104
 ; VADPT           10061
 ; MPIF001          2701
 ; ORQPT2
 ; XLFDT
 ; DIC
 ;
 Q
SELECT(RET,CRIT,SEARCH) ; Returns patient information based on search
 N I,DFN,DFNS,HMPCNT,ICN,PID,CRITFND
 S RET(1)="" ; Default to empty string return
 I $G(SEARCH)="" S RET(1)="-1^No patient specified." Q
 I $G(CRIT)="" S RET(1)="-1^No search critera specified." Q
 S CRIT=$$UP^XLFSTR(CRIT),CRITFND=0 ; CRITFND will be 1 if we matched the CRIT to a criteria
 I CRIT="LAST5" D SRLAST5(SEARCH) S CRITFND=1 ; Search by last5
 I CRIT="NAME" D SRNAME(SEARCH) S CRITFND=1 ; Search by (partial) name
 I CRIT="ICN" S DFNS(1)=$$GETDFN^MPIF001(SEARCH),ICN=SEARCH,CRITFND=1 ; ICN
 I CRIT="PID" S DFNS(1)=$P(SEARCH,";",2),PID=SEARCH,CRITFND=1 ; PID - assume 2nd piece is DFN for *this* server
 I $G(PID)]"",$P(PID,";")'=$$SYS^HMPUTILS S RET(1)="-1^Can only resolve pid for local site." Q
 ;If we couldn't match a search criteria, return an error
 I 'CRITFND S RET(1)="-1^Invalid search criteria requested" Q
 I +$G(DFNS(1))=-1 S RET(1)="" Q
 S HMPCNT="" F  S HMPCNT=$O(DFNS(HMPCNT)) Q:HMPCNT=""  S DFN=DFNS(HMPCNT) D
 . N ICN,SENS,SSN,DOB,FULLNAME,FAMNAME,DISPNAME,SUMMARY,GNDRCODE,LAST4,LAST5,PID,GNDRNAME,VADM,GVNNAME
 . I $$GET1^DIQ(2,DFN,".01")="" Q  ; Skip entries that don't match a valid DFN (mostly useful if CRIT was "PID")
 . D DEM^VADPT
 . ;DE3160 If no icn for patient then set ICN="" so that an extra field in return data does not get returned.
 . S ICN=$$GETICN^MPIF001(DFN) I ICN<0 S ICN=""
 . S SENS=$S($$EN1^ORQPT2(DFN)=1:"true",1:"false")
 . S DOB=$TR($$FMTE^XLFDT(+$P($P($G(VADM(3)),U),"."),"7DZ"),"/","")
 . S FULLNAME=$G(VADM(1))
 . S FAMNAME=$P(FULLNAME,",",1),GVNNAME=$P(FULLNAME,",",2,99)
 . S DISPNAME=$$FRSTCPS(FULLNAME),SUMMARY=DISPNAME
 . S GNDRCODE="urn:va:pat-gender:"_$P($G(VADM(5)),U),GNDRNAME=$P($G(VADM(5)),U,2)
 . S LAST4=$P($P($G(VADM(2)),U,2),"-",3),LAST5=$E(FAMNAME,1)_LAST4,SSN="*****"_LAST4
 . S PID=$$SYS^HMPUTILS_";"_DFN
 . S RET(HMPCNT)=FULLNAME_U_FAMNAME_U_GVNNAME_U_DISPNAME_U_GNDRCODE_U_GNDRNAME_U_SSN_U_LAST4_U_LAST5_U_DOB_U_SENS_U_DFN
 . S RET(HMPCNT)=RET(HMPCNT)_U_PID_U_ICN_U_SUMMARY
 Q
SRLAST5(SEARCH) ; Search for patients by last5
 D FIND(SEARCH,"BS5")
 Q
SRNAME(SEARCH) ; Search for patients by name
 D FIND(SEARCH,"")
 Q
FIND(SEARCH,XREF) ; Find patients that match search term in x-ref
 N HMPFIND,HMPERR
 D FIND^DIC(2,,"@","P",SEARCH,,XREF,,,"HMPFIND","HMPERR")
 F I=1:1:+$G(HMPFIND("DILIST",0)) S DFNS(I)=HMPFIND("DILIST",I,0)
 Q
FRSTCPS(IN) ; Formats patient's name to begin each word with a capital and the rest lowercase
 N FRSTCHAR,OUT
 S FRSTCHAR=1,OUT=""
 F I=1:1:$L(IN) D
 . N CHAR S CHAR=$E($E(IN,I))
 . I $$ISALPHA(CHAR) D  Q
 . . I FRSTCHAR S OUT=OUT_CHAR,FRSTCHAR=0 Q
 . . S OUT=OUT_$$LOW^XLFSTR(CHAR)
 . ;otherwise, non-alphabetic character
 . S OUT=OUT_CHAR,FRSTCHAR=1
 Q OUT
ISALPHA(CHAR) ;
 Q CHAR?1A
 ;
