RORXU002 ;HCIOFO/SG - REPORT BUILDER UTILITIES ;8/3/11 3:55pm
 ;;1.5;CLINICAL CASE REGISTRIES;**1,10,13,15,17,19,21,22,26**;Feb 17, 2006;Build 53
 ;
 ; This routine uses the following IAs:
 ;
 ; #3990   $$ICDD^ICDCODE (supported)
 ; #2050   BLD^DIALOG (supported)
 ; #2056   GETS^DIQ (supported)
 ; #2056   $$GET1^DIQ (supported)
 ; #10103  $$NOW^XLFDT  (supported)
 ; #10104  $$TRIM^XLFSTR (supported)
 ; #417    Read access to .01 field of file #40.8 (controlled)
 ; #10040  Read access to file #44 (supported)
 ; #5747   $$VLTD^ICDEX (controlled)
 ;
 ;******************************************************************************
 ;******************************************************************************
 ;                 --- ROUTINE MODIFICATION LOG ---
 ;        
 ;PKG/PATCH    DATE        DEVELOPER    MODIFICATION
 ;-----------  ----------  -----------  ----------------------------------------
 ;ROR*1.5*10   APR  2010   A SAUNDERS   Modified Lab Tests Ranges section in
 ;                                      PARAMS tag to include the 3 new reports.
 ;ROR*1.5*13   DEC  2010   A SAUNDERS   Added Division and Clinic sections in
 ;                                      PARAMS tag (pulled from RORXU006).
 ;ROR*1.5*15   JUN  2011   C RAY        Added HIV_DX
 ; 
 ;ROR*1.5*17   AUG  2011   C RAY        Modified to allow 
 ;                                      PATIENTS,OPTIONS params to have other
 ;                                      values besides boolean
 ;                                      Modified to add DATE_RANGE_4
 ;ROR*1.5*19   FEB  2012   J SCOTT      Support for ICD-10 Coding System.
 ;
 ;ROR*1.5*21   SEP 2013    T KOPP       Added flags for GENDER (SEX) selection on
 ;                                      reports in PATIENTS XML tag
 ;                                      Added ICN column if Additional Identifier
 ;                                       requested.
 ;
 ;ROR*1.5*22   FEB 2014    T KOPP       Added flags for OEF/OIF period of service
 ;                                      selection on reports in PATIENTS XML tag
 ;
 ;ROR*1.5*26   JAN 2015    T KOPP       Added flags for SVR ONLY or NO SVR ONLY
 ;                                      selection on reports in PATIENTS XML tag.
 ;                                      Suppress FIB4 header on DAA Potential
 ;                                      Candidates report if FIB-4 parameter not
 ;                                      selected
 ;
 ;******************************************************************************
 ;******************************************************************************
 Q
 ;
 ;***** SCANS THE TABLE DEFINITION (RORSRC) FOR COLUMN NAMES
 ;
 ; .TERM         Reference to a local variable where
 ;               is terminator is returned
 ;
 ; Return Values:
 ;       ""  End of definition
 ;      ...  Name of the column
 ;
COLSCAN(TERM) ;
 N CH,I,TOKEN
 F I=1:1  S TERM=$E(RORSRC,I)  Q:"(,)"[TERM
 S TOKEN=$E(RORSRC,1,I-1)
 F I=I+1:1  S CH=$E(RORSRC,I)  Q:(CH="")!("(,)"'[CH)
 S $E(RORSRC,1,I-1)=""
 Q TOKEN
 ;
 ;***** CHECKS THE FILEMAN DATE/TIME VALUE
DATE(DT) ;
 Q $S(DT>0:+DT,1:"")
 ;
 ;***** OUTPUTS THE BASIC HEADER TO THE REPORT
 ;
 ; .RORTSK       Task number and task parameters
 ;
 ; PARTAG        Reference (IEN) to the parent tag
 ;
 ; Return Values:
 ;       <0  Error code
 ;       >0  IEN of the HEADER element
 ;
HEADER(RORTSK,PARTAG) ;
 N HEADER,IENS,REGIEN,RORBUF,RORMSG,TMP,DIERR
 S HEADER=$$ADDVAL^RORTSK11(RORTSK,"HEADER",,PARTAG)
 Q:HEADER<0 HEADER
 D ADDVAL^RORTSK11(RORTSK,"DATE",$$DATE($$NOW^XLFDT),HEADER)
 D ADDVAL^RORTSK11(RORTSK,"TASK_NUMBER",RORTSK,HEADER)
 S REGIEN=+$$PARAM^RORTSK01("REGIEN")
 ;---
 S IENS=REGIEN_","
 D GETS^DIQ(798.1,IENS,"1;2","I","RORBUF","RORMSG")
 Q:$G(DIERR) $$DBS^RORERR("RORMSG",-9,,,798.1,IENS)
 S TMP=$G(RORBUF(798.1,IENS,1,"I"))
 D ADDVAL^RORTSK11(RORTSK,"UPDATED_UNTIL",$$DATE(TMP),HEADER)
 S TMP=$G(RORBUF(798.1,IENS,2,"I"))
 D ADDVAL^RORTSK11(RORTSK,"EXTRACTED_UNTIL",$$DATE(TMP),HEADER)
 Q HEADER
 ;
 ;***** PARSES THE COMMA-SEPARATED LIST
 ;
 ; .LIST         Reference to a local variable that contains a list.
 ;               Items of the list are returned as the subscripts of
 ;               this variable.
 ;
LIST(LIST) ;
 N I,TMP,VAL
 F I=1:1  S VAL=$P(LIST,",",I)  Q:VAL=""  D
 . S TMP=$$TRIM^XLFSTR(VAL)
 . S:TMP'="" LIST(TMP)=""
 Q
 ;
 ;***** COMPILES A TEXT DESCRIPTION FOR THE REPORT OPTIONS
 ;
 ; .OPTIONS      Reference to a local variable containing
 ;               the options as subscripts
 ;
 ; [DLGNUM]      Number of the dialog that contains the template
 ;               (7980000.018, by default).
 ;
 ; Return Values:
 ;      ...  Text description of the options
 ;
OPTXT(OPTIONS,DLGNUM) ;
 N I,J,NS,RORBUF,TEXT,TMP
 S:$G(DLGNUM)'>0 DLGNUM=7980000.018
 D BLD^DIALOG(DLGNUM,,,"RORBUF")
 S TEXT="",I=0
 F  S I=$O(RORBUF(I))  Q:I=""  D:$E(RORBUF(I),1)'=" "
 . S NS=0
 . F J=1:1  S TMP=$TR($P(RORBUF(I),",",J)," ")  Q:TMP=""  D
 . . S:$D(OPTIONS(TMP)) NS=2**(J-1)+NS
 . Q:'NS
 . S TMP=$$TRIM^XLFSTR($G(RORBUF(I+NS)))
 . S:TMP'="" TEXT=TEXT_", "_TMP
 Q $P(TEXT,", ",2,999)
 ;
 ;***** OUTPUTS THE PARAMETERS TO THE REPORT
 ;
 ; .RORTSK       Task number and task parameters
 ;
 ; PARTAG        Reference (IEN) to the parent tag
 ;
 ; .STDT         Start and end dates of the report
 ; .ENDT         are returned via these parameters
 ;
 ; [.FLAGS]      Flags for the $$SKIP^RORXU005 are returned via this
 ;               parameter. The "D" (skip deceased patients) and "G"
 ;               (skip pending patients) flags are always added.
 ;
 ; Return Values:
 ;       <0  Error code
 ;       >0  IEN of the PARAMETERS element
 ;
PARAMS(RORTSK,PARTAG,STDT,ENDT,FLAGS) ;
 N BUF,ELEMENT,I,LTAG,MODE,NAME,PARAMS,RC,REGIEN,RORMSG,TMP,IEN,DIERR
 S PARAMS=$$ADDVAL^RORTSK11(RORTSK,"PARAMETERS",,PARTAG)
 S RC=0,(ENDT,STDT)="",FLAGS=""
 ;
 ;=== Registry name
 S REGIEN=+$$PARAM^RORTSK01("REGIEN")
 I REGIEN>0  D  Q:RC<0 RC
 . S TMP=$P($$REGNAME^RORUTL01(REGIEN),U)
 . I TMP=""  S RC=-1  Q
 . S RC=$$ADDVAL^RORTSK11(RORTSK,"REGNAME",TMP,PARAMS)
 ;
 ;=== Alternate date ranges
 F I=2:1:4  D  Q:RC<0
 . S STDT=$$PARAM^RORTSK01("DATE_RANGE_"_I,"START")\1  Q:STDT'>0
 . S ENDT=$$PARAM^RORTSK01("DATE_RANGE_"_I,"END")\1    Q:ENDT'>0
 . S ELEMENT=$$ADDVAL^RORTSK11(RORTSK,"DATE_RANGE_"_I,,PARAMS)
 . I ELEMENT<0  S RC=+ELEMENT  Q
 . S RC=$$ADDATTR^RORTSK11(RORTSK,ELEMENT,"START",STDT)  Q:RC<0
 . S RC=$$ADDATTR^RORTSK11(RORTSK,ELEMENT,"END",ENDT)
 Q:RC<0 RC
 ;
 ;=== Main date range
 S STDT=$$PARAM^RORTSK01("DATE_RANGE","START")\1
 S ENDT=$$PARAM^RORTSK01("DATE_RANGE","END")\1
 I STDT>0,ENDT>0  D  Q:RC<0 RC
 . S ELEMENT=$$ADDVAL^RORTSK11(RORTSK,"DATE_RANGE",,PARAMS)
 . I ELEMENT<0  S RC=+ELEMENT  Q
 . S RC=$$ADDATTR^RORTSK11(RORTSK,ELEMENT,"START",STDT)  Q:RC<0
 . S RC=$$ADDATTR^RORTSK11(RORTSK,ELEMENT,"END",ENDT)
 E  S (ENDT,STDT)=""
 ;
 ;=== Task comment
 S TMP=$$PARAM^RORTSK01("TASK_COMMENT")
 D:TMP'="" ADDVAL^RORTSK11(RORTSK,"TASK_COMMENT",TMP,PARAMS)
 ;
 ;=== Clinic Selection - patch 13
 D:$D(RORTSK("PARAMS","CLINICS","C"))
 . S LTAG=$$ADDVAL^RORTSK11(RORTSK,"CLINICS",,PARAMS)  Q:LTAG'>0
 . S IEN=0
 . F  S IEN=$O(RORTSK("PARAMS","CLINICS","C",IEN))  Q:IEN'>0  D
 . . S TMP=$$GET1^DIQ(44,IEN_",",.01,,,"RORMSG")
 . . D:$G(DIERR) DBS^RORERR("RORMSG",-9,,,44,IEN_",")
 . . Q:TMP=""
 . . D ADDVAL^RORTSK11(RORTSK,"CLINIC",TMP,LTAG,,IEN)
 D:$$PARAM^RORTSK01("CLINICS","ALL")
 . S LTAG=$$ADDVAL^RORTSK11(RORTSK,"CLINICS","ALL",PARAMS)
 ;
 ;=== Division Selection - patch 13
 D:$D(RORTSK("PARAMS","DIVISIONS","C"))
 . S LTAG=$$ADDVAL^RORTSK11(RORTSK,"DIVISIONS",,PARAMS)  Q:LTAG'>0
 . S IEN=0
 . F  S IEN=$O(RORTSK("PARAMS","DIVISIONS","C",IEN))  Q:IEN'>0  D
 . . S TMP=$$GET1^DIQ(40.8,IEN_",",.01,,,"RORMSG")
 . . D:$G(DIERR) DBS^RORERR("RORMSG",-9,,,40.8,IEN_",")
 . . Q:TMP=""
 . . D ADDVAL^RORTSK11(RORTSK,"DIVISION",TMP,LTAG,,IEN)
 D:$$PARAM^RORTSK01("DIVISIONS","ALL")
 . S LTAG=$$ADDVAL^RORTSK11(RORTSK,"DIVISIONS","ALL",PARAMS)
 ;
 ;
 ;=== Patient selection and Options
 F NAME="PATIENTS","OPTIONS"  D  Q:RC<0
 . K BUF  M BUF=RORTSK("PARAMS",NAME,"A")  Q:$D(BUF)<10
 . ;--- Generate the XML tags
 . S ELEMENT=$$ADDVAL^RORTSK11(RORTSK,NAME,$$OPTXT(.BUF),PARAMS)
 . I ELEMENT'>0  S RC=ELEMENT  Q
 . S TMP=""
 . F  S TMP=$O(BUF(TMP))  Q:TMP=""  D  Q:RC<0
 . . S RC=$$ADDATTR^RORTSK11(RORTSK,ELEMENT,TMP,$G(BUF(TMP)))
 . ;--- Compile the flags
 . D:NAME="PATIENTS"
 . . S:'$D(BUF("DE_BEFORE")) FLAGS=FLAGS_"P"
 . . S:'$D(BUF("DE_DURING")) FLAGS=FLAGS_"N"
 . . S:'$D(BUF("DE_AFTER")) FLAGS=FLAGS_"F"
 . . I $D(BUF("SEX")) S FLAGS=FLAGS_$S(BUF("SEX")="M":"W",BUF("SEX")="F":"M",1:"")
 . . I $D(BUF("OEF")) D
 . . . S FLAGS=FLAGS_$S(BUF("OEF")=1:"I",BUF("OEF")=-1:"E",1:"")
 . . I $D(BUF("SVR")) S FLAGS=FLAGS_$S(BUF("SVR")=1:"S",BUF("SVR")=0:"V",1:"")
 Q:RC<0 RC
 ;
 ;=== Other Registries
 I $D(RORTSK("PARAMS","OTHER_REGISTRIES","C"))>1  D  Q:RC<0 RC
 . N NODE,REGIEN
 . S LTAG=$$ADDVAL^RORTSK11(RORTSK,"OTHER_REGISTRIES",,PARAMS)
 . I LTAG<0  S RC=+LTAG  Q
 . S NODE=$NA(RORTSK("PARAMS","OTHER_REGISTRIES","C"))
 . S REGIEN=0
 . F  S REGIEN=$O(@NODE@(REGIEN))  Q:REGIEN'>0  D  Q:RC<0
 . . S TMP=$P($$REGNAME^RORUTL01(REGIEN),U,2)
 . . S MODE=+$G(@NODE@(REGIEN))
 . . I 'MODE!(TMP="")  K @NODE@(REGIEN)  Q
 . . S TMP=TMP_" ("_$S(MODE<0:"Exclude",1:"Include")_")"
 . . S RC=$$ADDVAL^RORTSK11(RORTSK,"REGNAME",TMP,LTAG)
 . S FLAGS=FLAGS_"R"
 ;
 ;=== Local Fields
 I $D(RORTSK("PARAMS","LOCAL_FIELDS","C"))>1  D  Q:RC<0 RC
 . N NODE,IEN,IENS
 . S LTAG=$$ADDVAL^RORTSK11(RORTSK,"LOCAL_FIELDS",,PARAMS)
 . I LTAG<0  S RC=+LTAG  Q
 . S NODE=$NA(RORTSK("PARAMS","LOCAL_FIELDS","C"))
 . S IEN=0
 . F  S IEN=$O(@NODE@(IEN))  Q:IEN'>0  D  Q:RC<0
 . . S TMP=$$GET1^DIQ(799.53,IEN_",",.01,,,"RORMSG")
 . . D:$G(DIERR) DBS^RORERR("RORMSG",-9,,,799.53,IEN_",")
 . . S MODE=+$G(@NODE@(IEN))
 . . I 'MODE!(TMP="")  K @NODE@(IEN)  Q
 . . S TMP=TMP_" ("_$S(MODE<0:"Exclude",1:"Include")_")"
 . . S RC=$$ADDVAL^RORTSK11(RORTSK,"FIELD",TMP,LTAG)
 . S FLAGS=FLAGS_"O"
 ;
 ;=== Lab test ranges
 I $D(RORTSK("PARAMS","LRGRANGES","C"))>1  D  Q:RC<0 RC
 . N TYPE S TYPE=3 ;default = 3 for 'lab by range' report
 . I $G(RORTSK("EP"))["BMIRANGE" S TYPE=5 ;change to 5 if BMI
 . I $G(RORTSK("EP"))["MLDRANGE"!($G(RORTSK("EP"))["HCVDAA") S TYPE=6 ;change to 6 if MELD
 . I $G(RORTSK("EP"))["RFRANGE" S TYPE=7 ;change to 7 if Renal
 . N GRC,NODE
 . S NODE=$NA(RORTSK("PARAMS","LRGRANGES","C"))
 . S GRC=0
 . F  S GRC=$O(@NODE@(GRC))  Q:GRC'>0  D  Q:RC<0
 . . S RC=$$ITEMIEN^RORUTL09(TYPE,REGIEN,GRC,.TMP)
 . . S:RC'<0 @NODE@(GRC)=TMP
 ;
 ;=== ICD filter/group/codes
 N LEV1FILT,LEV2GRP,LEV3ICD,ICDIEN,ICDCODE,GRPNAME,FILTER,ICDDESC,RORXMLNODE,RORICDSYS
 S FILTER=$G(RORTSK("PARAMS","ICDFILT","A","FILTER"))
 I $L(FILTER)>0 D  ;quit if no ICD filter exists
 . S LEV1FILT=$$ADDVAL^RORTSK11(RORTSK,"ICDFILT",,PARAMS)
 . I LEV1FILT<0 S RC=LEV1FILT Q
 . ;add filter value to the output
 . S RC=$$ADDATTR^RORTSK11(RORTSK,LEV1FILT,"FILTER",FILTER)
 . ;if there's an ICD group, process it
 . I $D(RORTSK("PARAMS","ICDFILT","G"))>1 D  Q:RC<0
 .. S NODE=$NA(RORTSK("PARAMS","ICDFILT","G"))
 .. S GRPNAME=0,RC=0
 .. F  S GRPNAME=$O(@NODE@(GRPNAME)) Q:GRPNAME=""  D  Q:RC<0
 ... S LEV2GRP=$$ADDVAL^RORTSK11(RORTSK,"GROUP",,LEV1FILT)
 ... I LEV2GRP'>0  S RC=LEV2GRP Q 
 ... ;add group name to the output
 ... D ADDATTR^RORTSK11(RORTSK,LEV2GRP,"ID",GRPNAME)
 ... S ICDIEN=0
 ... F  S ICDIEN=$O(@NODE@(GRPNAME,"C",ICDIEN)) Q:ICDIEN'>0  D
 .... S ICDCODE=$P(@NODE@(GRPNAME,"C",ICDIEN),U,1) Q:ICDCODE=""
 .... S RORICDSYS=$P(@NODE@(GRPNAME,"C",ICDIEN),U,2)
 .... ;get diagnosis description
 .... S ICDDESC=$$VLTD^ICDEX(ICDIEN)
 .... S RORXMLNODE=$S(RORICDSYS=1:"ICD9",1:"ICD10")
 .... S LEV3ICD=$$ADDVAL^RORTSK11(RORTSK,RORXMLNODE,ICDDESC,LEV2GRP)
 .... D ADDATTR^RORTSK11(RORTSK,LEV3ICD,"ID",ICDCODE)
 ;
 ;=== get Max Date
 N MAXDT S MAXDT=$$PARAM^RORTSK01("OPTIONS","MAX_DATE")
 I $G(MAXDT)>0 D ADDVAL^RORTSK11(RORTSK,"MAX_DATE",MAXDT,PARAMS)
 ;
 ;=== get HIV_DX
 N RORMODE S RORMODE=$$PARAM^RORTSK01("HIV_DX")
 S RORMODE=$S(RORMODE=1:"Include",RORMODE=-1:"Exclude",1:"")
 I RORMODE'="" D
 . D ADDVAL^RORTSK11(RORTSK,"HIV_DX",RORMODE,PARAMS)
 . S FLAGS=FLAGS_"H"
 ;
 ;=== Defaults
 S TMP=$TR(FLAGS,"FNP")  S:$L(FLAGS)-$L(TMP)=3 FLAGS=TMP
 S FLAGS=FLAGS_"DG"
 ;
 ;=== Success
 Q PARAMS
 ;
 ;***** GENERATES TABLE DEFINITION
 ;
 ; TBLREF        Reference to the definition table in the source
 ;               code (TAG^ROUTINE). See the HEADER^RORX013 for
 ;               examples of table definitions.
 ;
 ; HEADER        IEN of the HEADER element
 ;
 ; Return Values:
 ;       <0  Error code
 ;        0  Ok
 ;
TBLDEF(TBLREF,HEADER) ;
 N COND,IT,NAME,RC,RORSRC,TBLDEF,TERM,TGET
 K ^TMP($J,"RORSELCOL")
 S TGET="S RORSRC=$T("_$P(TBLREF,"^")_"+IT^"_$P(TBLREF,"^",2)_")"
 S RC=0
 F IT=1:1  X TGET  S RORSRC=$P(RORSRC,";;",2)  Q:RORSRC=""  D  Q:RC<0
 . S COND=$$TRIM^XLFSTR($P(RORSRC,U,2,999))
 . I COND'=""  X COND  E  Q
 . S RORSRC=$$TRIM^XLFSTR($P(RORSRC,U))
 . S NAME=$$COLSCAN(.TERM)  Q:(NAME="")!(TERM'="(")
 . S TBLDEF=$$ADDVAL^RORTSK11(RORTSK,"TBLDEF",,HEADER)
 . I TBLDEF<0  S RC=TBLDEF  Q
 . D ADDATTR^RORTSK11(RORTSK,TBLDEF,"NAME",NAME)
 . D ADDATTR^RORTSK11(RORTSK,TBLDEF,"HEADER","1")
 . D ADDATTR^RORTSK11(RORTSK,TBLDEF,"FOOTER","1")
 . D TBLDEF1(TBLDEF)
 K ^TMP($J,"RORSELCOL")
 Q $S(RC<0:RC,1:0)
 ;
 ;***** GENERATES <COLUMN> ELEMENTS FROM TABLE DEFINITION (RORSRC)
 ;
 ; PTAG          IEN of the parent element
 ;
TBLDEF1(PTAG) ;
 N COLUMN,IT,NAME,OK,ROR,TERM
 F  S NAME=$$COLSCAN(.TERM)  Q:NAME=""  D  Q:")"[TERM
 . I '$D(^TMP($J,"RORSELCOL")) D  ; set up special columns selection criteria
 . . F IT=1:1 X "S ROR=$P($T(SELCOL+"_IT_"^RORXU002),"";;"",2)" Q:$P(ROR,U)=""  D
 . . . S ^TMP($J,"RORSELCOL",$P(ROR,U))=$P(ROR,U,2,999)
 . I $D(^TMP($J,"RORSELCOL",NAME)) D  Q:'OK
 . . X ^TMP($J,"RORSELCOL",NAME) S OK=$T
 . S COLUMN=$$ADDVAL^RORTSK11(RORTSK,"COLUMN",,PTAG)
 . D ADDATTR^RORTSK11(RORTSK,COLUMN,"NAME",NAME)
 . D:TERM="(" TBLDEF1(COLUMN)
 Q
 ;
 ;Setup of values in SELCOL is:
 ;name of selected optional column^statement to execute to set $T if the condition to include this field has been met
 ;
SELCOL ;selected optional fields and screen criteria is listed here
 ;;ICN^I $$PARAM^RORTSK01("PATIENTS","ICN")
 ;;FIB4^I $D(RORTSK("PARAMS","LRGRANGES","C",4))
 ;;
