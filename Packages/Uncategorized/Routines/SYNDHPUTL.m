SYNDHPUTL ; HC/art - HealthConcourse - various utilities ;2019-11-04  5:49 PM
 ;;1.0;DHP;;Jan 17, 2017;Build 46
 ;;
 ;Original routine authored by Andrew Thompson & Ferdinand Frankson of Perspecta 2017-2019
 ;
 ; (c) OSEHRA 2019
 ; (c) Perspecta 2017-2019
 ; ZWRITE implementation (c) Sam Habiel 2019
 ; Licensed under the Apache License, Version 2.0 (the "License");
 ; you may not use this file except in compliance with the License.
 ; You may obtain a copy of the License at
 ; 
 ; http://www.apache.org/licenses/LICENSE-2.0
 ; 
 ; Unless required by applicable law or agreed to in writing, software
 ; distributed under the License is distributed on an "AS IS" BASIS,
 ; WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 ; See the License for the specific language governing permissions and
 ; limitations under the License.
 ;
 QUIT
 ;
TOJASON(ARRAY,JSONSTR) ;convert input array to JSON string
 ;input:  ARRAY - input array
 ;output: JSONSTR - JSON string
 ;ZEXCEPT: DEBUG
 ;
 N ERR,TMP
 D ENCODE^XLFJSON("ARRAY","TMP","ERR")
 I $G(DEBUG),$D(ERR) W !,">>ERROR<<" W $$ZW("ERR")
 I $G(DEBUG) W ! W $$ZW("TMP")
 ;
 S JSONSTR=""
 N IDX S IDX=""
 F  S IDX=$O(TMP(IDX)) QUIT:IDX=""  D
 . S JSONSTR=JSONSTR_$G(TMP(IDX))
 I $G(DEBUG) W ! W $$ZW("JSONSTR")
 ;
 QUIT
 ;
TOFHIR(ARRAY,FHIRARRAY) ;create FHIR tagged array from input array
 ;input:  ARRAY - input array
 ;output: FHIRARRAY - FHIR array
 ;
 ;
 QUIT
 ;
meta(fields,fileNbr) ;return field metadata
 ;input: fileNbr - file number
 ;output: fields - return array
 ;        fields(fieldNbr)=fieldName^fieldNameCC^fieldType^fieldValueSet^pointsTo
 ;ZEXCEPT: DEBUG
 ;
 n node0,fieldName,fieldNameCC,fieldType,fieldValueSet,pointsTo
 n fieldNbr s fieldNbr=0
 f  s fieldNbr=$o(^DD(fileNbr,fieldNbr)) quit:'+fieldNbr  d
 . s node0=^DD(fileNbr,fieldNbr,0)
 . s fieldName=$p(node0,U,1)
 . s fieldNameCC=$$camelCase(fieldName)
 . s fieldType=$p(node0,U,2)
 . s fieldType=$s(+fieldType:"M",fieldType["P":"P",fieldType["F":"F",fieldType["D":"D",fieldType["N":"N",fieldType["S":"S",fieldType["C":"C",fieldType["V":"V",1:"")
 . s fieldValueSet=$s(fieldType="S":$p(node0,U,3),1:"")
 . s pointsTo=$s(fieldType="P":+$p($p(node0,U,2),"P",2),1:"")
 . s fields(fieldNbr)=fieldName_U_fieldNameCC_U_fieldType_U_fieldValueSet_U_pointsTo_U
 ;
 i $g(DEBUG) w !,"fields",! W $$ZW("fields")
 ;
 QUIT
 ;
camelCase(x) ;return a string in camel case
 ;input: x - string
 ;return: camel case string
 ;
 s x=$tr(x,"`-=[]\;',./~!@#$%^&*()_+{}|:""<>?","                                 ") ;eol is out here
 s x=$$TITLE^XLFSTR(x)
 s $p(x," ",1)=$$LOW^XLFSTR($p(x," ",1))
 s x=$$STRIP^XLFSTR(x," ")
 ;
 QUIT x
 ;
PATLIST ;Get list of patients from %wd graph
 ;
 N IEN,DFN,ICN,NAME
 W !,"Patient Name",?33,"Graph IEN",?45,"DFN",?55,"ICN",!
 S IEN=0
 F  S IEN=$O(^%wd(17.040801,1,IEN)) QUIT:'+IEN  DO
 . S DFN=$$ien2dfn^SYNFUTL(IEN)
 . S ICN=$$ien2icn^SYNFUTL(IEN)
 . S NAME=$$GET1^DIQ(2,DFN_",",.01)
 . W NAME,?35,IEN,?45,DFN,?55,ICN,!
 QUIT
 ;
GETOS() ;
 ;Determine OS
 NEW ZZOS
 SET ZZOS=$$OS^%ZOSV()
 SET ZZOS=$SELECT(ZZOS["VMS":"1-VMS",ZZOS["NT":"2-MSW",ZZOS["UNIX":"3-LINUX",1:"0-")
 ;W !,ZZOS,!
 QUIT ZZOS
 ;
OPEN(ZZFILE,ZZDIR,ZZFILENM,ZZMODE) ;Open a File
 ; Inputs - ZZFILE - File tag to open
 ;          ZZDIR - Host File Directory Name
 ;          ZZFILENM - File Name
 ;          ZZMODE - Open mode - R=Read, W=Write, A=Append
 ; Output - 1 if file was opened
 ;          0 if not opened
 ;          IO - opened device designator
 ;
 NEW POP
 DO OPEN^%ZISH(ZZFILE,ZZDIR,ZZFILENM,ZZMODE)
 IF POP DO  QUIT 0
 . USE 0
 . WRITE !,"ERROR: Could not open the file: ",ZZDIR,"\",ZZFILENM,!
 . WRITE "       Ensure the directory name is valid.",!
 QUIT 1
 ;
CLOSE(ZZFILE) ;Close a File
 ; Input  - ZZFILE - File tag to close
 ; Output - none
 ;
 DO CLOSE^%ZISH(ZZFILE)
 QUIT
 ;
EOF() ;Test for EOF
 ; Input  - none
 ; Output - 1 if end of file has been reached
 ;
 QUIT $$STATUS^%ZISH
 ;
RANGECK(DATE,FROMDATE,TODATE,REV) ;Check date range
 ;Inputs: DATE - date to be compared
 ;        FROMDATE - begining of range
 ;        TODATE - end of range
 ;        REV    - Should we exclude if found?
 ;Returns: 0 - date is outside of requested date range
 ;         1 - date is within requested date range, null dates are not checked
 ;
 S REV=$G(REV,0)
 N RESULT
 IF (DATE'="")&((DATE\1)<FROMDATE)!((DATE\1)>TODATE) S RESULT=0  ;date is outside of requested date range
 E  S RESULT=1
 I REV Q 'RESULT
 Q RESULT
 ;
SETFRTO(FHIRDATE,FRDATE,TODATE,REVDATE) ; [Public] Set FROMDATE/TODATE for call above
 ; Input: FHIRDATE  - Fhir Date Expression (plain or with eq/ne/lt/gt/ge/le/ap)
 ; Output: .FROMDATE - From Date
 ;         .TODATE   - To Date
 ;         .REVDATE  - Should filter be reversed?
 ;          Sets HTTPERR if Date is invalid
 ;
 n prefix s prefix=""
 n date s date=""
 n hasPrefix s hasPrefix=$E(FHIRDATE,1,2)?2A
 i hasPrefix s prefix=$E(FHIRDATE,1,2),date=$E(FHIRDATE,3,99)
 e  s date=FHIRDATE
 i hasPrefix,"^eq^ne^lt^gt^ge^le^ap^"'[(U_prefix_U) D ERRMSG(400,"Invalid Date Prefix") QUIT
 ;
 ; Convert to FM Date
 n fmdate s fmdate=$$HL7TFM^XLFDT($tr(date,"-"))
 i fmdate=-1 D ERRMSG^SYNDHPUTL(400,"Invalid Date") QUIT
 ;
 ; Inexact Date?
 n inexactMonth,inexactDay
 s (inexactMonth,inexactDay)=0
 i $e(fmdate,4,5)="00" s inexactMonth=1
 i $e(fmdate,6,7)="00" s inexactDay=1
 ;
 ; Now set from and to for base case
 i 'inexactMonth,'inexactDay S FRDATE=fmdate,TODATE=fmdate+1-.000001       ; Add day (30/31 no matter as this is only for range checking)
 i inexactDay,'inexactMonth  S FRDATE=fmdate,TODATE=fmdate+100-.000001     ; Add month
 i inexactMonth              S FRDATE=fmdate,TODATE=fmdate+10000-.000001   ; Add year
 ;
 ; Adjust for prefixes
 i prefix="eq"  ; no change
 i prefix="ne" S REVDATE=1 ; reverse condition
 i prefix="lt" S FRDATE=0,TODATE=fmdate-.000001 ; less than, & ends before
 i prefix="gt" S FRDATE=fmdate+1,TODATE=9999999 ; greater than, & starts after
 i prefix="le" S FRDATE=0,TODATE=fmdate                       ; less than or equals
 i prefix="ge" S FRDATE=fmdate,TODATE=9999999                 ; greater than
 i prefix="ap" n diff s diff=fmdate*.001,FRDATE=FRDATE-diff,TODATE=TODATE+diff ; approximately (within 3 months)
 QUIT
 ;
GETDFN(ZZPNAME) ;Get patient's DFN
 ;Inputs - ZZPNAME - Patient name
 ;Returns - Patient DFN
 ;
 QUIT:$GET(ZZPNAME)="" "0^Missing name"
 ;
 NEW ZZDFN,ZZMSG
 SET ZZDFN=$$FIND1^DIC(2,,"BQUX",ZZPNAME,"B",,"ZZMSG")
 ;
 QUIT ZZDFN
 ;
GETIEN(ZZFILE,ZZNAME) ;Get IEN for name
 ;Inputs - ZZFILE - File number
 ;         ZZNAME - name (.01 field)
 ;Returns - IEN
 ;
 QUIT:$GET(ZZFILE)="" "0^Missing file number"
 QUIT:$GET(ZZNAME)="" "0^Missing name"
 ;
 NEW ZZIEN,ZZMSG
 SET ZZIEN=$$FIND1^DIC(ZZFILE,,"BQUX",ZZNAME,"B",,"ZZMSG")
 ;
 QUIT ZZIEN
 ;
UICN(PATIEN) ; ICN for IEN
 ;
 Q $$GET1^DIQ(2,PATIEN_",",991.1)
 ;
ICN(IEN) ; obtain ICN
 N ICN
 S ICN=$$GET1^DIQ(2,IEN_",",991.1)
 I ICN="" D
 . S ICN=$$GET1^DIQ(2,IEN_",",991.01)_"V"_$$GET1^DIQ(2,IEN_",",991.02)
 Q ICN
 ;
UICNVAL(ICN) ; validate ICN
 ; Input: ICN
 ; Returns: 0 - invalid
 ;          1 - valid
 ;
 I $G(ICN)="" Q 0
 I '$D(^DPT("AFICN",ICN)) Q 0
 QUIT 1
 ;
USCTPT(SCT) ; SNOMED CT preferred term
 ;Input: SCT - SNOMED Code
 ;Returns: SCT Preferred Term
 ;
 N LEX,PREF
 S LEX=$$CODE^LEXTRAN(SCT,"SCT")
 S PREF=""
 I $D(LEX("P")) S PREF=LEX("P")
 Q PREF
 ;
DATECNVT(DATE) ;convert DATE to Fileman format
 ;
 I $G(DATE)="" QUIT ""
 N %DT S %DT="T"
 N X S X=DATE
 N Y
 D ^%DT
 QUIT Y
 ;
FMTFHIR(FMDATE) ;Convert Fileman date to FHIR date
 ;Inputs - FMDATE - Fileman date/time
 ;Returns - FHIR Date
 ;
 QUIT:$GET(FMDATE)="" ""
 ;
 NEW FHIRDATE SET FHIRDATE=""
 ;
 I $L(FMDATE)<7 QUIT ""
 I $L(FMDATE)=7 D  QUIT FHIRDATE
 . S FHIRDATE=$E(FMDATE,1,3)+1700_"-"_$E(FMDATE,4,5)_"-"_$E(FMDATE,6,7)
 ;
 N hl7,dtm,tz
 S hl7=$$FMTHL7^XLFDT(FMDATE)
 I hl7="" QUIT ""
 I hl7=-1 QUIT -1
 S dtm=$P(hl7,"-",1)
 S tz="-"_$E($P(hl7,"-",2),1,2)_":"_$E($P(hl7,"-",2),3,4)
 S FHIRDATE=$E(hl7,1,4)_"-"_$E(hl7,5,6)_"-"_$E(hl7,7,8)_"T"_$E(hl7,9,10)_":"_$E(hl7,11,12)_":"_$S(+$E(hl7,13,14)>0:$E(hl7,13,14),1:"00")_tz
 ;
 QUIT FHIRDATE
 ;
CTRLS(X) ; strip control characters
 N I,CTRLS
 S CTRLS=""
 F I=1:1:31,127:1:190 S CTRLS=CTRLS_$C(I)
 Q $TR(X,CTRLS)
 ;
ZW(VAR) ; simulate Caché or GT.M ZW or ZWRITE fuction
 ; VAR - variable to be ZWritten
 ;
 D ZWRITE(VAR)
 QUIT:$Q "" QUIT
 ;
ZWRITE(NAME,QS,QSREP) ; Replacement for ZWRITE ; Public Proc
 ; Pass NAME by name as a closed reference. lvn and gvn are both supported.
 ; QS = Query Subscript to replace. Optional.
 ; QSREP = Query Subscrpt replacement. Optional, but must be passed if QS is.
 ;
 ; : syntax is not supported (yet)
 S QS=$G(QS),QSREP=$G(QSREP)
 I QS,'$L(QSREP) S $EC=",U-INVALID-PARAMETERS,"
 N NL ; new line
 ; E  N CRLF S CRLF=$C(13,10)_",*-3",NL=$NA(CRLF) ; Weirdness b/c we have to @NL.
 N INCEXPN S INCEXPN=""
 I $L(QSREP) S INCEXPN="S $G("_QSREP_")="_QSREP_"+1"
 N L S L=$L(NAME) ; Name length
 I $E(NAME,L-2,L)=",*)" S NAME=$E(NAME,1,L-3)_")" ; If last sub is *, remove it and close the ref
 N ORIGNAME S ORIGNAME=NAME          ;
 N ORIGQL S ORIGQL=$QL(NAME)         ; Number of subscripts in the original name
 I $D(@NAME)#2 W $S(QS:$$SUBNAME(NAME,QS,QSREP),1:NAME),"=",$$FORMAT1(@NAME),! ; Write base if it exists
 ; $QUERY through the name.
 ; Stop when we are out.
 ; Stop when the last subscript of the original name isn't the same as
 ; the last subscript of the Name.
 F  S NAME=$Q(@NAME) Q:NAME=""  Q:$NA(@ORIGNAME,ORIGQL)'=$NA(@NAME,ORIGQL)  D
 . W $S(QS:$$SUBNAME(NAME,QS,QSREP),1:NAME),"=",$$FORMAT1(@NAME),!
 QUIT
 ;
SUBNAME(N,QS,QSREP) ; Substitue subscript QS's value with QSREP in name reference N
 N VARCR S VARCR=$NA(@N,QS-1) ; Closed reference of name up to the sub we want to change
 N VAROR S VAROR=$S($E(VARCR,$L(VARCR))=")":$E(VARCR,1,$L(VARCR)-1)_",",1:VARCR_"(") ; Open ref
 N B4 S B4=$NA(@N,QS),B4=$E(B4,1,$L(B4)-1) ; Before sub piece, only used in next line
 N AF S AF=$P(N,B4,2,99) ; After sub piece
 QUIT VAROR_QSREP_AF
 ;
FORMAT1(V) ; Add quotes, replace control characters if necessary; Public $$
 ;If numeric, nothing to do.
 ;If no encoding required, then return as quoted string.
 ;Otherwise, return as an expression with $C()'s and strings.
 I +V=V Q V       ; If numeric, just return the value.
 N QT S QT=""""   ; Quote
 I $F(V,QT) D     ; chk if V contains any Quotes
 . N P S P=0                  ;position pointer into V
 . F  S P=$F(V,QT,P) Q:'P  D  ;find next "
 . . S $E(V,P-1)=QT_QT        ;double each "
 . . S P=P+1                  ;skip over new "
 I $$CCC(V) D  Q V     ; If control character is present do this and quit
 . S V=$$RCC(QT_V_QT)  ; Replace control characters in "V"
 . S:$E(V,1,3)="""""_" $E(V,1,3)="" ; Replace doubled up quotes at start
 . N L S L=$L(V) S:$E(V,L-2,L)="_""""" $E(V,L-2,L)="" ; Replace doubled up quotes at end
 Q QT_V_QT ; If no control charactrrs, quit with "V"
 ;
CCC(S) ;test if S Contains a Control Character or $C(255); Public $$
 Q:S?.E1C.E 1
 Q:$F(S,$C(255)) 1
 Q 0
 ;
RCC(NA) ;Replace control chars in NA with $C( ). Returns encoded string; Public $$
 Q:'$$CCC(NA) NA                         ;No embedded ctrl chars
 N OUT S OUT=""                          ;holds output name
 N CC S CC=0                             ;count ctrl chars in $C(
 N C255 S C255=$C(255)                   ;$C(255) which Mumps may not classify as a Control
 N C                                     ;temp hold each char
 N I F I=1:1:$L(NA) S C=$E(NA,I) D           ;for each char C in NA
 . I C'?1C,C'=C255 D  S OUT=OUT_C Q      ;not a ctrl char
 . . I CC S OUT=OUT_")_""",CC=0          ;close up $C(... if one is open
 . I CC D
 . . I CC=256 S OUT=OUT_")_$C("_$A(C),CC=0  ;max args in one $C(
 . . E  S OUT=OUT_","_$A(C)              ;add next ctrl char to $C(
 . E  S OUT=OUT_"""_$C("_$A(C)
 . S CC=CC+1
 . Q
 Q OUT
 ;
ICNPAT(ICN) ; patient for ICN
 ; Input: ICN
 ; Returns: 0 - invalid
 ;          ICN^IEN^NAME - valid
 ;
 I $G(ICN)="" Q 0
 I '$D(^DPT("AFICN",ICN)) Q 0
 N PATIEN S PATIEN=$O(^DPT("AFICN",ICN,""))
 N PATNAME S PATNAME=$$GET1^DIQ(2,PATIEN,.01)
 QUIT ICN_U_PATIEN_U_PATNAME
 ;
GETRXN(X) ; [Public] Get RxNorm code for drug IEN
 N ND S ND=$G(^PSDRUG(X,"ND"))
 I ND="" Q ""
 N PROD S PROD=$P(ND,U,3)
 I PROD="" Q
 I '$D(^PSNDF(50.68,PROD,0)) S $EC=",U-CORRUPT-DATA,"
 ;
 ; Try to get using VA asserted map in 50.68 in the Coding multiple (which has a funky format)
 N CODE S CODE=""
 D
 . N CODINGIEN F CODINGIEN=0:0 S CODINGIEN=$O(^PSNDF(50.68,PROD,11,CODINGIEN)) Q:'CODINGIEN  D
 .. N CODING S CODING=$P($G(^PSNDF(50.68,PROD,11,CODINGIEN,0)),U)
 .. I CODING'="RxNorm" QUIT
 .. N CODEIEN S CODEIEN=$O(^PSNDF(50.68,PROD,11,CODINGIEN,1,0))
 .. I 'CODEIEN Q
 .. S CODE=$P($G(^PSNDF(50.68,PROD,11,CODINGIEN,1,CODEIEN,0)),U)
 I CODE Q CODE
 ;
 ; If not, get VUID, and translate from ETS package
 N VUID S VUID=$$GET1^DIQ(50.68,PROD,"99.99")
 N OUT S OUT=$$VUI2RXN^ETSRXN(VUID)
 I OUT<1 QUIT "" ; # of entries or -1 for error.
 S CODE=$P(^TMP("ETSRXN",$J,1,0),U,2)
 Q CODE
 ;
ERRMSG(CODE,MESSAGE) ;
 ; fhir OperationOutcome
 ; ZEXCEPT: HTTPERR
 K ^TMP("HTTPERR",$J)
 S HTTPERR=CODE
 S ^TMP("HTTPERR",$J,1,"resourceType")="OperationOutcome"
 S ^TMP("HTTPERR",$J,1,"issue",1,"severity")="error"
 S ^TMP("HTTPERR",$J,1,"issue",1,"code")="processing"
 S ^TMP("HTTPERR",$J,1,"issue",1,"diagnostics")=MESSAGE
 QUIT:$Q "" QUIT
 ;
