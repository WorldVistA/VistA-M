PXRMCSU ;SLC/JVS - Code Set Version-dialog file-Utilities ;4/10/03  12:02
 ;;2.0;CLINICAL REMINDERS;;Feb 04, 2005
 ;Variable List
 ;DATECV     =Converted Date
 Q
SUB ;==============Sub Routines=============================
DT6M(DT) ;Add 180 days to DT
 N DT6M
 S DT6M=$$FMADD^XLFDT(DT,180,0,0,0)
 Q DT6M
CONV(DATE) ;Date time conversion
 N DATECV
 S DATECV=$$FMTE^XLFDT(DATE,"5Z")
 Q DATECV
CPTA(VARIEN) ; Return all data for cpt code
 ; INACDATE=Inactive date
 ; FPP     =FUTURE PRESENT PAST
 ; RETURNS CPTDATA = Whole string of information
 ;         FPPREF  = Time Reference (Null if no data)
 N INACDATE,FPP,FPPREF,CPTDATA
 S CPTDATA=$$CPT^ICPTCOD(VARIEN,$$DT6M(DT))
 S INACDATE=$P(CPTDATA,"^",8),FPPREF="" I INACDATE>0 D
 .S FPP=$S(INACDATE>DT:"Future",INACDATE<DT:"Past",INACDATE=DT:"Today",1:"Unknown")
 .S FPPREF=FPP
 Q CPTDATA_"^"_FPPREF
ICD9A(VARIEN) ; Return all data for cpt code
 ; INACDATE=Inactive date
 ; FPP     =FUTURE PRESENT PAST
 ; RETURNS CPTDATA = Whole string of information
 ;         FPPREF  = Time Reference (Null if no data)
 N INACDATE,FPP,FPPREF,ICD9DATA
 S ICD9DATA=$$ICDDX^ICDCODE(VARIEN,$$DT6M(DT))
 S INACDATE=$P(ICD9DATA,"^",12),FPPREF="" I INACDATE>0 D
 .S FPP=$S(INACDATE>DT:"Future",INACDATE<DT:"Past",INACDATE=DT:"Today",1:"Unknown")
 .S FPPREF=FPP
 Q ICD9DATA_"^"_FPPREF
CPT(VARIEN) ; Return code from IEN
 N VARCODE
 S VARCODE=$$CPT^ICPTCOD(VARIEN,$$DT6M(DT))
 S VARCODE=$P(VARCODE,"^",2)
 Q VARCODE
CPTD(VARIEN) ;Return CPT code Description from IEN
 N VARDESC
 S VARDESC=$$CPT^ICPTCOD(VARIEN,$$DT6M(DT))
 S VARDESC=$P(VARDESC,"^",3)
 Q VARDESC
ICD9(VARIEN) ; Return ICD9 (Diagnosis) Code from IEN
 N VARCODE
 S VARCODE=$$ICDDX^ICDCODE(VARIEN,$$DT6M(DT))
 S VARCODE=$P(VARCODE,"^",2)
 Q VARCODE
ICD9D(VARIEN) ; Return ICD9 (Diagnosis) Description from IEN
 N VARDESC
 S VARDESC=$$ICDDX^ICDCODE(VARIEN,$$DT6M(DT))
 S VARDESC=$P(VARDESC,"^",4)
 Q VARDESC
ICD0(VARIEN) ; Return ICD0 (Operation) Code from an IEN
 N VARCODE
 S VARCODE=$$ICDOP^ICDCODE(VARIEN,$$DT6M(DT))
 S VARCODE=$P(VARCODE,"^",2)
 Q VARCODE
ICD0D(VARIEN) ; Return ICD0 (Operation) Description from IEN
 N VARCODE
 S VARDESC=$$ICDOP^ICDCODE(VARIEN,$$DT6M(DT))
 S VARDESC=$P(VARDESC,"^",5)
 Q VARDESC
STATUS(VRSTATUS) ;RETURN STATUS FOR BOTH CPT AND ICD CODES
 N STATUS
 ;VRSTATUS = Internal form of status
 ;STATUS    = Exteral form of status
 S STATUS=$S(($P(VRSTATUS,"^",1)=1)&($P(VRSTATUS,"^",2)>0):"Active",($P(VRSTATUS,"^",1)=0)&($P(VRSTATUS,"^",2)>0):"Inactive",($P(VRSTATUS,"^",1)=0)&($P(VRSTATUS,"^",2)<0):"Unknown",1:"")
 Q STATUS
