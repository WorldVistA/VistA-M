PXAIIMMV ;ISL/PKR - VALIDATE IMMUNIZATION DATA ;04/16/2018
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**199,209,210,211**;Aug 12, 1996;Build 244
 ;
ERRSET ;Set the rest of the error data.
 S STOP=1
 S PXAERRF=1
 S PXADI("DIALOG")=8390001.001
 S PXAERR(7)="IMMUNIZATION"
 Q
 ;
VAL ;Validate the input data.
 I $G(PXAA("IMMUN"))="" D  Q
 . S PXAERR(9)="IMMUNIZATION"
 . S PXAERR(12)="You are missing the name of the immunization"
 . D ERRSET
 ;
 ;If this is a deletion no further verification is required.
 I $G(PXAA("DELETE"))=1 Q
 ;
 ;Check that it is a valid pointer.
 I '$D(^AUTTIMM(PXAA("IMMUN"))) D  Q
 . S PXAERR(9)="IMMUNIZATION"
 . S PXAERR(11)=PXAA("IMMUN")
 . S PXAERR(12)="The Immunization pointer is not valid."
 . D ERRSET
 ;
 ;Check that it is active. Inactive immunizations that are marked
 ;Selectable for Historic can be used for historical encounters.
 ;I $P(^AUTTIMM(PXAA("IMMUN"),0),U,7)=1 D
 I '$$IMMSEL^PXVUTIL(PXAA("IMMUN"),PXAVISIT,$G(PXAA("EVENT D/T"))) D
 . S PXAERR(9)="INACTIVE"
 . S PXAERR(11)=PXAA("IMMUN")
 . S PXAERR(12)="The Immunization is inactive."
 . D ERRSET
 ;
 ;If Series is input validate it.
 I $G(PXAA("SERIES"))'="",'$$SET^PXAIVAL(9000010.11,"SERIES",.04,PXAA("SERIES"),.PXAERR) D  Q
 . D ERRSET
 ;
 ;If Reaction is input validate it.
 I $G(PXAA("REACTION"))'="",'$$SET^PXAIVAL(9000010.11,"REACTION",.06,PXAA("REACTION"),.PXAERR) D  Q
 . D ERRSET
 ;
 ;If Contraindicated is input validate it.
 I $G(PXAA("CONTRAINDICATED"))'="",'$$SET^PXAIVAL(9000010.11,"CONTRAINDICATED",.07,PXAA("CONTRAINDICATED"),.PXAERR) D  Q
 . D ERRSET
 ;
 ;If an Override Reason is passed verify it.
 I $G(PXAA("OVERRIDE REASON"))'="",'$$TEXT^PXAIVAL("OVERRIDE REASON",PXAA("OVERRIDE REASON"),3,245,.PXAERR) D  Q
 . D ERRSET
 ;
 ;If an Ordering Provider is passed verify it is valid.
 I $G(PXAA("ORD PROVIDER"))'="",'$$PRV^PXAIVAL(PXAA("ORD PROVIDER"),"ORD",.PXAA,.PXAERR,PXAVISIT) D  Q
 . D ERRSET
 ;
 ;If an Encounter Provider is passed verify it is valid.
 I $G(PXAA("ENC PROVIDER"))'="",'$$PRV^PXAIVAL(PXAA("ENC PROVIDER"),"ENC",.PXAA,.PXAERR,PXAVISIT) D  Q
 . D ERRSET
 ;
 ;If Event D/T is input verify it is a valid FileMan date and not a
 ;future date.
 I $G(PXAA("EVENT D/T"))'="",'$$EVENTDT^PXAIVAL(PXAA("EVENT D/T"),"T",.PXAERR) D  Q
 . D ERRSET
 ;
 ;If a Comment is passed verify it.
 I $G(PXAA("COMMENT"))'="",'$$TEXT^PXAIVAL("COMMENT",PXAA("COMMENT"),1,245,.PXAERR) D  Q
 . D ERRSET
 ;
 ;If PKG is input verify it.
 I $G(PXAA("PKG"))'="" D
 . N PKG
 . S PKG=$$VPKG^PXAIVAL(PXAA("PKG"),.PXAERR)
 . I PKG=0 S PXAERR(9)="PKG" D ERRSET Q
 . S PXAA("PKG")=PKG
 I $G(STOP)=1 Q
 ;
 ;If SOURCE is input verify it.
 I $G(PXAA("SOURCE"))'="" D
 . N SRC
 . S SRC=$$VSOURCE^PXAIVAL(PXAA("SOURCE"),.PXAERR)
 . I SRC=0 S PXAERR(9)="SOURCE" D ERRSET Q
 . S PXAA("SOURCE")=SRC
 I $G(STOP)=1 Q
 ;
 ;If Lot Num is input validate it.
 I $G(PXAA("LOT NUM"))'="",'$D(^AUTTIML(PXAA("LOT NUM"),0)) D  Q
 . S PXAERR(9)="LOT NUM"
 . S PXAERR(11)=PXAA("LOT NUM")
 . S PXAERR(12)=PXAA("LOT NUM")_" is not a valid pointer to the Immunization Lot file #9999999.41."
 . D ERRSET
 ;
 ;If Info Source is input validate it.
 I $G(PXAA("INFO SOURCE"))'="",'$D(^PXV(920.2,PXAA("INFO SOURCE"),0)) D  Q
 . S PXAERR(9)="INFO SOURCE"
 . S PXAERR(11)=PXAA("INFO SOURCE")
 . S PXAERR(12)=PXAA("INFO SOURCE")_" is not a valid pointer to the Immunization Info Source file #920.1."
 . D ERRSET
 ;
 ;If Admin Route is input validate it.
 I $G(PXAA("ADMIN ROUTE"))'="",'$D(^PXV(920.2,PXAA("ADMIN ROUTE"),0)) D  Q
 . S PXAERR(9)="ADMIN ROUTE"
 . S PXAERR(11)=PXAA("ADMIN ROUTE")
 . S PXAERR(12)=PXAA("ADMIN ROUTE")_" is not a valid pointer to the Imm Adminstration Route file #920.2."
 . D ERRSET
 ;
 ;If Anatomic Loc is input validate it.
 I $G(PXAA("ANATOMIC LOC"))'="",'$D(^PXV(920.3,PXAA("ANATOMIC LOC"),0)) D  Q
 . S PXAERR(9)="ANATOMIC LOC"
 . S PXAERR(11)=PXAA("ANATOMIC LOC")
 . S PXAERR(12)=PXAA("ANATOMIC LOC")_" is not a valid pointer to the Imm Adminstration Site file #920.3."
 . D ERRSET
 ;
 ;If Dose is input validate it.
 I $G(PXAA("DOSE"))'="",+PXAA("DOSE")'=PXAA("DOSE")!(PXAA("DOSE")>999)!(PXAA("DOSE")<0)!(PXAA("DOSE")?.E1"."3N.N) D  Q
 . S PXAERR(9)="DOSE"
 . S PXAERR(11)=PXAA("DOSE")
 . S PXAERR(12)=PXAA("DOSE")_" is not a number between 0 and 999 with 2 fractional digits."
 . D ERRSET
 ;
 ;If Dose Units is input validate it.
 I $G(PXAA("DOSE UNITS"))'="" D
 . N UNITS
 . S UNITS=$$UCUMCODE^LEXMUCUM(PXAA("DOSE UNITS"))
 . I $P(UNITS,U,1)="{unit not defined}" D
 .. S PXAERR(9)="DOSE UNITS"
 .. S PXAERR(11)=PXAA("DOSE UNITS")
 .. S PXAERR(12)=PXAA("DOSE UNITS")_" is not a valid pointer to UCUM Codes file #757.5."
 .. D ERRSET
 I $G(STOP)=1 Q
 ;
 ;If Vaccine Information Statements are input validate them.
 I $D(PXAA("VIS")) D
 . N DATE,ERRORD,ERRORV,SEQ,VIS
 . S (ERRORD,ERRORV,SEQ)=0
 . F  S SEQ=+$O(PXAA("VIS",SEQ)) Q:SEQ=0  D
 .. S VIS=$P(PXAA("VIS",SEQ,0),U,1)
 .. I VIS="@" Q
 .. I VIS="" S ERRORV=1,PXAERR(12)="SEQ #"_SEQ_": The Vaccine Information Statement pointer is null."
 .. I (ERRORV=0),'$D(^AUTTIVIS(VIS,0)) S ERROR=1,PXAERR(12)="SEQ #"_SEQ_": "_VIS_" is not a valid pointer to the Vaccine Information Statement file #920."
 .. S DATE=$P(PXAA("VIS",SEQ,0),U,2)
 .. I DATE="" S ERRORD=1,PXAERR(13)="SEQ #"_SEQ_": Date Offered/Given is null."
 .. I (ERRORD=0),($$VFMDATE^PXDATE(DATE,"PX")=-1) S ERRORD=1,PXAERR(13)="SEQ #"_SEQ_": "_DATE_" is not a valid Date Offered/Given."
 .. I (ERRORD=0),$$FUTURE^PXDATE(DATE) S ERRORD=1,PXAERR(13)="SEQ #"_SEQ_": "_DATE_" is not a valid Date Offered/Given, it is the future."
 . I (ERRORD=1)!(ERRORV=1) S PXAERR(9)="VIS" D ERRSET
 I $G(STOP)=1 Q
 ;
 ;Remarks is word-processing, no validation required.
 ;
 ;Check for diagnosis input and return a warning.
 N DIAGNUM,DIAGSTR,NDIAG
 S NDIAG=0
 F DIAGNUM=1:1:8 D
 . S DIAGSTR="DIAGNOSIS"_$S(DIAGNUM>1:" "_DIAGNUM,1:"")
 . I $G(PXAA(DIAGSTR))]"" S NDIAG=NDIAG+1
 I NDIAG>0 D
 . S PXADI("DIALOG")=8390001.002
 . S PXAERRF=1
 . S PXAERR(9)="DIAGNOSIS"
 . S PXAERR(12)="As of patch PX*1*211 diagnoses cannot be stored in V IMMUNIZATION."
 Q
 ;
 ; Validate VIMM 2.0 fields
 N PXFLD,PXFLDNAME,PXFLDNUM,PXVAL,PXFILE,PXOK,PXNEWVAL,PXSEQ,PXVIS
 ;
 F PXFLD="SERIES^.04","LOT NUM^1207","INFO SOURCE^1301","ADMIN ROUTE^1302","ANATOMIC LOC^1303","ORD PROVIDER^1202","DOSE UNITS^1313" D
 . ;
 . S PXFLDNAME=$P(PXFLD,"^",1)
 . S PXFLDNUM=$P(PXFLD,"^",2)
 . ;
 . S PXVAL=$G(PXAA(PXFLDNAME))
 . I PXVAL="" Q
 . ;
 . S PXFILE=9000010.11
 . S PXOK=$$VALFLD(PXFILE,PXFLDNUM,PXVAL)
 . I PXOK D
 . . S PXNEWVAL=$P(PXOK,"^",2)
 . . I PXNEWVAL'="" S PXAA(PXFLDNAME)=PXNEWVAL
 . I 'PXOK D
 . . D ERRMSG(8390001.002,0,PXVAL,PXFLDNAME)
 . . K PXAA(PXFLDNAME) ; Don't file this field, as it's invalid
 ;
 ; Check VIS Multiple
 S PXFLDNAME="VIS"
 S PXFLDNUM=.01
 ;
 I $G(PXAA(PXFLDNAME))="@" Q
 ;
 S PXSEQ=0
 F  S PXSEQ=$O(PXAA(PXFLDNAME,PXSEQ)) Q:'PXSEQ  D
 . ;
 . S PXVAL=$P($G(PXAA(PXFLDNAME,PXSEQ,0)),U,1)
 . I PXVAL="" K PXAA(PXFLDNAME,PXSEQ) Q
 . ;
 . S PXFILE=9000010.112
 . S PXOK=$$VALFLD(PXFILE,PXFLDNUM,PXVAL)
 . I 'PXOK D
 . . D ERRMSG(8390001.002,0,PXVAL,PXFLDNAME)
 . . K PXAA(PXFLDNAME,PXSEQ) ; Don't file this field, as it's invalid
 ;
 Q
 ;
VALFLD(PXFILE,PXFLDNUM,PXVAL) ;
 ;
 ; Validate field and return:
 ;
 ;    1   - Field is valid
 ;    1^X - Field is valid, but was external value.
 ;          The function will return the internal
 ;          value in the 2nd piece (X).
 ;    0   - Field is invalid
 ;
 N PXOK,PXEXT,PXCODES,PXI,PXX,PXCODE,PXCODEVAL,PXTEMP
 ;
 S PXOK=1
 ;
 I PXVAL="@" Q PXOK
 ;
 S PXEXT=$$EXTERNAL^DILFD(PXFILE,PXFLDNUM,,PXVAL,"PXERR")  ;using this to get around input transform
 I PXFILE=9000010.11,PXFLDNUM=1313 D
 . N PXRSLT,PXERR
 . D CHK^DIE(PXFILE,PXFLDNUM,"E","`"_PXVAL,.PXRSLT,"PXERR")
 . S PXEXT=$G(PXRSLT(0))
 . I $G(PXRSLT)="^" S PXEXT=""
 S PXOK=(PXEXT'="")
 ;
 ; If value is not valid, and field is set-of-codes,
 ; check to see if external value was passed in.
 ; If that was the case, set PXOK to 1,
 ; and return internal value in 2nd piece of PXOK
 I 'PXOK,($$GET1^DID(PXFILE,PXFLDNUM,,"TYPE",,"PXERR")="SET") D
 . S PXCODES=$$GET1^DID(PXFILE,PXFLDNUM,,"POINTER",,"PXERR")
 . F PXI=1:1:$L(PXCODES,";") D
 . . S PXX=$P(PXCODES,";",PXI)
 . . S PXCODE=$P(PXX,":",1)
 . . S PXCODEVAL=$P(PXX,":",2)
 . . I PXCODE=""!(PXCODEVAL="") Q
 . . S PXTEMP(PXCODEVAL)=PXCODE
 . S PXCODE=$G(PXTEMP(PXVAL))
 . I PXCODE'="" S PXOK="1^"_PXCODE
 ;
 Q PXOK
 ;
ERRMSG(PXDLG,PXSTOP,PXVAL,PXFLDNAME) ;
 S STOP=$G(PXSTOP,0)
 S PXAERRF=1
 S PXADI("DIALOG")=$G(PXDLG,"8390001.002")
 I $G(PXAERR(9))'="" D
 . S PXAERR(9)=PXAERR(9)_", "
 . S PXAERR(11)=PXAERR(11)_", "
 . S PXAERR(12)=PXAERR(12)_" "
 S PXAERR(9)=$G(PXAERR(9))_PXFLDNAME
 S PXAERR(11)=$G(PXAERR(11))_PXVAL
 S PXAERR(12)=$G(PXAERR(12))_"'"_PXVAL_"' is not a valid value for field "_PXFLDNAME_"."
 Q
 ;
