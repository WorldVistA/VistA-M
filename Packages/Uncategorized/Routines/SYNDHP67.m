SYNDHP67 ; AFHIL/fjf/art - HealthConcourse - retrieve patient TIU notes ;07/26/2019
 ;;1.0;DHP;;Jan 17, 2017;Build 46
 ;;
 ;;Original routine authored by Andrew Thompson & Ferdinand Frankson of Perspecta 2017-2019
 ;
PATTIUI(RETSTA,DHPICN,FRDAT,TODAT,RETJSON) ; Patient TIU Notes for ICN
 ;
 ; Return patient Text Integration Utility Notes for a given patient ICN
 ;     signed progress notes
 ;     signed discharge summaries
 ;
 ; Input:
 ;   ICN     - unique patient identifier across all VistA systems
 ;   FRDAT   - from date (inclusive), optional, compared to 1201 ENTRY DATE/TIME
 ;   TODAT   - to date (inclusive), optional, compared to 1201 ENTRY DATE/TIME
 ;   RETJSON - J = Return JSON
 ;             F = Return FHIR
 ;             0 or null = Return string (default)
 ; Output:
 ;   RETSTA  - a delimited string that lists the following information
 ;      PatientICN~ResourceID|DateTime|NoteStatus|NoteConfidentiality
 ;        |NoteAuthor|NoteLine(1)^NoteLine(2)^NoteLine(3)...
 ;        ^NoteLine(n)^|LOINC Code_LOINC Name~...
 ;
 ;  Identifier will be "V"_SITE ID_FILE #_FILE IEN   i.e. V_500_8925_930
 ;
 S FRDAT=$S($G(FRDAT):$$HL7TFM^XLFDT(FRDAT),1:1000101)
 S TODAT=$S($G(TODAT):$$HL7TFM^XLFDT(TODAT),1:9991231)
 I $G(DEBUG) W !,"FRDAT: ",FRDAT,"   TODAT: ",TODAT,!
 I FRDAT>TODAT S RETSTA="-1^From date is greater than to date" QUIT
 ;
 ; validate ICN
 I $G(DHPICN)="" S RETSTA="-1^What patient?" QUIT
 I '$$UICNVAL^SYNDHPUTL(DHPICN) S RETSTA="-1^Patient identifier not recognised" QUIT
 ;
 S RETSTA=$NA(^TMP($T(+0),$J))
 K @RETSTA
 N RETCNT S RETCNT=1
 S @RETSTA@(RETCNT)=DHPICN
 N PATIEN S PATIEN=$O(^DPT("AFICN",DHPICN,""))
 I PATIEN="" S RETSTA="-1^Internal data structure error" QUIT
 ;
 N P S P="|"
 N S S S="_"
 N T S T="~"
 N NTX,NTIEN,VID,NTSTA,NTDTMFM,NTDTM,NTAUTH,NCONF,NTLS,NTL,NOTELIST
 ;
 ; get list of signed progress notes for patient
 N ZXC
 D NOTES^TIUSRVLO(.ZXC,PATIEN)
 N NTS S NTS=$NA(@ZXC)
 N NT S NT=""
 F  S NT=$O(@NTS@(NT)) Q:NT=""  D
 . S NOTELIST($P(@NTS@(NT),U,1))="P"
 ;
 ; get list of signed discharge summaries for patient
 N ZXC
 D SUMMARY^TIUSRVLO(.ZXC,PATIEN)
 N NTS S NTS=$NA(@ZXC)
 N NT S NT=""
 F  S NT=$O(@NTS@(NT)) Q:NT=""  D
 . S NOTELIST($P(@NTS@(NT),U,1))="D"
 ;
 ; set generic LOINC code required by Azure implementation of FHIR
 N NTLOINC S NTLOINC="11506-3_Provider-unspecified Progress note"
 N DSLOINC S DSLOINC="18842-5_Discharge summary"
 ;
 N TIUARRAY
 N TIUIEN S TIUIEN=""
 F  S TIUIEN=$O(NOTELIST(TIUIEN)) QUIT:TIUIEN=""  D
 . N TIU
 . D GET1TIU^SYNDHP24(.TIU,TIUIEN,0) ;get one TIU record
 . I $D(TIU("Tiu","ERROR")) M TIUARRAY("TiuNotes",TIUIEN)=TIU QUIT
 . ;I $E(RETSTA,$L(RETSTA))=U S RETSTA=$E(RETSTA,1,$L(RETSTA)-1) ; //SMH?
 . ;S NTX=@NTS@(TIUIEN)
 . S NTIEN=TIU("Tiu","tiuIen")
 . S NTDTMFM=TIU("Tiu","entryDateTimeFM")
 . QUIT:'$$RANGECK^SYNDHPUTL(NTDTMFM,FRDAT,TODAT)  ;quit if outside of requested date range
 . S RETCNT=RETCNT+1
 . S @RETSTA@(RETCNT)=T
 . S VID=TIU("Tiu","resourceId")
 . S NTSTA=TIU("Tiu","statusFHIR")
 . S NTDTM=TIU("Tiu","entryDateTimeHL7")
 . S NTAUTH=TIU("Tiu","authorDictatorId")
 . S NTAUTH=$$GET1^DIQ(200,NTAUTH_",",41.99) ;NPI
 . ; note confidentiality
 . S NCONF="N"
 . ;W !,NT,"  -  ",NTSTA,!
 . S RETCNT=RETCNT+1
 . S @RETSTA@(RETCNT)=VID_P_NTDTM_P_NTSTA_P_NCONF_P_NTAUTH_P
 . ; now get note text for non-json return
 . N ZXCV,NTLTX
 . D TGET^TIUSRVR1(.ZXCV,NTIEN)
 . I $G(DEBUG) W $$ZW^SYNDHPUTL("ZXCV")
 . S NTLS=$NA(@ZXCV)
 . S NTL=0
 . F  S NTL=$O(@NTLS@(NTL)) QUIT:NTL=""  D
 . . S NTLTX=@NTLS@(NTL)
 . . S NTLTX=$TR(NTLTX,T," ") ; Remove Tildes from text as we use it as delimiter
 . . S NTLTX=$TR(NTLTX,U," ") ; Remove Tildes from text as we use it as delimiter
 . . S RETCNT=RETCNT+1
 . . S @RETSTA@(RETCNT)=NTLTX_U
 . S RETCNT=RETCNT+1
 . S @RETSTA@(RETCNT)=P_$S(NOTELIST(TIUIEN)="D":DSLOINC,1:NTLOINC)_P
 . I NOTELIST(TIUIEN)="D" D
 . . S TIU("Tiu","loincCode")=$P(DSLOINC,S,1)
 . . S TIU("Tiu","loincDesc")=$P(DSLOINC,S,2)
 . E  D
 . . S TIU("Tiu","loincCode")=$P(NTLOINC,S,1)
 . . S TIU("Tiu","loincDesc")=$P(NTLOINC,S,2)
 . ;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< issue with new VEHU not decrypting e-sig data
 . S TIU("Tiu","signatureBlockName")=""
 . S TIU("Tiu","signatureBlockTitle")=""
 . S TIU("Tiu","cosignatureBlockName")=""
 . S TIU("Tiu","cosignatureBlockTitle")=""
 . ;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
 . M TIUARRAY("TiuNotes",TIUIEN)=TIU
 ;
 ;I $G(RETJSON)="F" D xxx  ;create array for FHIR
 ;
 I $G(RETJSON)="J"!($G(RETJSON)="F") D
 . S RETSTA=""
 . D TOJASON^SYNDHPUTL(.TIUARRAY,.RETSTA)
 . S RETSTA=$$UES^XLFJSON(RETSTA) ;change \\n to \n
 ;
 QUIT
 ;
 ; ----------- Unit Test -----------
T1 ;
 D PATTIUI(.ZXC,"5000000001V324625")
 D ZWRITE^SYNDHPUTL(ZXC)
 Q
T2 ;
 N ZXS
 D PATTIUI(.ZXS,"11004V412157")
 Q
 ;
T3 ;
 N ICN S ICN="9009373208V847154"
 N FRDAT S FRDAT=""
 N TODAT S TODAT=""
 N JSON S JSON=""
 N RETSTA
 D PATTIUI(.RETSTA,ICN,FRDAT,TODAT,JSON)
 W $$ZW^SYNDHPUTL("RETSTA")
 QUIT
 ;
T4 ;
 N ICN S ICN="9009373208V847154"
 N FRDAT S FRDAT=19960401
 N TODAT S TODAT=19970101
 N JSON S JSON=""
 N RETSTA
 D PATTIUI(.RETSTA,ICN,FRDAT,TODAT,JSON)
 W $$ZW^SYNDHPUTL("RETSTA")
 QUIT
 ;
T5 ;
 N ICN S ICN="9009373208V847154"
 N FRDAT S FRDAT=""
 N TODAT S TODAT=""
 N JSON S JSON="J"
 N RETSTA
 D PATTIUI(.RETSTA,ICN,FRDAT,TODAT,JSON)
 W $$ZW^SYNDHPUTL("RETSTA")
 QUIT
 ;
