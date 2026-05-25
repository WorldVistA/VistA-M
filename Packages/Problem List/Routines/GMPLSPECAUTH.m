GMPLSPECAUTH ;SLC/AGP,GN - Problems Special Authorities ; Nov 21, 2025@19:37
 ;;2.0;Problem List;**58**;Aug 25, 1994;Build 33
 ;
 ;  Reference to $$GETVALUE^PXSPECAUTH,$$GETZERO^PXSPECAUTH,$$FINDBYCODE^PXSPECAUTH,SETARRAY^PXSPECAUTH  in ICR #7506
 ;
 Q
SHOWSA() ;Switch to allow=1 / disallow=0, New SA indicator structure for Problem List
 Q 0
 ; =============================  API section  ===========================================
SAOFFOUT ;Code switch of JSON return true msg
 S OUTPUT("facility",":")=""""_DUZ(2)_"""" ; user logged in facility #
 S OUTPUT("patientId",":")=DFN
 S OUTPUT("success")="true"
 D ENCODE^XLFJSON("OUTPUT","RESULTS","JSONERR")
 Q
 ;
OLDSC(J) ; -- Returns name of SC field by piece number
 I '$G(J) Q ""
 I J=1.1 Q "SC"
 I J=1.16 Q "MST"
 I J=1.11 Q "AO"
 I J=1.12 Q "IR"
 I J=1.13 Q "EC"
 I J=1.15 Q "HNC"
 I J=1.17 Q "CV"
 I J=1.18 Q "SHAD"
 Q ""
 ;
SADESC(VALUE) ; SA description from SA IEN or CODE
 N ZNODE,TEXT,EXP,IEN
 Q:$G(VALUE)="" "null"
 I +VALUE S IEN=VALUE
 E  S IEN=$$FINDBYCODE^PXSPECAUTH(VALUE)
 I 'IEN S TEXT="* "_VALUE Q TEXT   ;return the passed in value, when value not found by API, as file #820 code was changed/deleted recently
 S ZNODE=$$GETZERO^PXSPECAUTH(IEN) I ZNODE="" Q "null"
 S TEXT=$TR($P(ZNODE,U,3),"&","")
 Q TEXT
 ;
GETVALUE(DEF) ;
 Q $S(DEF:"yes",DEF=0:"no",1:"unknown")
 ;
DETAIL(GMPL,IFN,GMPL1) ;Get SA info in orig format
 Q:'$$SHOWSA
 N ALLOWED,CODE,EID,EIDX,EXIT,NAME,NODE,PATIENT,SANODE,SEQ,SEQMAP,VALUE,XX,ZNODE
 S EXIT=0
 ;IF New SA nodes found, use it
 I $D(^AUPNPROB(IFN,2)) D
 .S GMPL("EXPOSURE")=0
 .S PATIENT=$P($G(^AUPNPROB(IFN,0)),U,2) Q:'PATIENT
 .D GETPATSA(PATIENT,.ALLOWED) Q:'$D(ALLOWED)
 .S EIDX=0 F  S EIDX=$O(^AUPNPROB(IFN,2,EIDX)) Q:EIDX'>0  D
 ..S NODE=$G(^AUPNPROB(IFN,2,EIDX,0)) I +$P(NODE,U)=0 Q
 ..S ZNODE=$$GETZERO^PXSPECAUTH($P(NODE,U)) I ZNODE="" Q
 ..S CODE=$P(ZNODE,U,2) Q:'$G(ALLOWED(CODE))
 ..S VALUE=$P(NODE,U,2),EXIT=1
 ..I CODE="SC" S GMPL("SC")=$$GETVALUE(VALUE) Q
 ..I VALUE D
 ...S SEQMAP(+$P(ZNODE,U,4))=$$SADESC($P(NODE,U))
 .S SEQ="" F  S SEQ=$O(SEQMAP(SEQ)) Q:'SEQ  D
 .. S XX=GMPL("EXPOSURE")+1,GMPL("EXPOSURE",XX)=SEQMAP(SEQ),GMPL("EXPOSURE")=XX
 .I $G(GMPL("SC"))="" S GMPL("SC")=$$GETVALUE("")
 Q:EXIT
 ;ELSE Old SA logic
 S GMPL("SC")=$$GETVALUE($P(GMPL1,U,10))
 S GMPL("EXPOSURE")=0
 I $P(GMPL1,U,11) S X=GMPL("EXPOSURE")+1,GMPL("EXPOSURE",X)="AGENT ORANGE",GMPL("EXPOSURE")=X
 I $P(GMPL1,U,12) S X=GMPL("EXPOSURE")+1,GMPL("EXPOSURE",X)="RADIATION",GMPL("EXPOSURE")=X
 I $P(GMPL1,U,13) S X=GMPL("EXPOSURE")+1,GMPL("EXPOSURE",X)="ENV CONTAMINANTS",GMPL("EXPOSURE")=X
 I $P(GMPL1,U,15) S X=GMPL("EXPOSURE")+1,GMPL("EXPOSURE",X)="HEAD AND/OR NECK CANCER",GMPL("EXPOSURE")=X
 I $P(GMPL1,U,16) S X=GMPL("EXPOSURE")+1,GMPL("EXPOSURE",X)="MILITARY SEXUAL TRAUMA",GMPL("EXPOSURE")=X
 I $P(GMPL1,U,17) S X=GMPL("EXPOSURE")+1,GMPL("EXPOSURE",X)="COMBAT VET",GMPL("EXPOSURE")=X
 I $P(GMPL1,U,18)&(+$$PTR^GMPLUTL4'>0) S X=GMPL("EXPOSURE")+1,GMPL("EXPOSURE",X)="SHAD",GMPL("EXPOSURE")=X
 Q
 ;
COMPARE(OLDVALUE,NEWVALUE,CODE) ;
 N ACTION
 I OLDVALUE=NEWVALUE Q ""
 I OLDVALUE="",NEWVALUE'="" S ACTION="set to"
 E  S ACTION="changed from"
 Q U_CODE_":"_OLDVALUE_U_NEWVALUE_U_ACTION_U
 ;
EDIT(IFN,GMPLORIG,GMPFLD) ;Edit
 N ECNT,EIDX,NAME,NODE
 S EIDX=0,ECNT=0 F  S EIDX=$O(^AUPNPROB(IFN,2,EIDX)) Q:EIDX'>0  D
 .S NODE=$G(^AUPNPROB(IFN,2,EIDX,0)) I +$P(NODE,U)=0 Q
 .S NAME=$$GETZERO^PXSPECAUTH($P(NODE,U)) I NAME="" Q
 .S ECNT=ECNT+1
 .S GMPLORIG(2,EIDX)=$P(NODE,U)_U_$P(NAME,U,2)_U_$P(NODE,U,2)_U_$$GETVALUE^PXSPECAUTH($P(NODE,U,2))
 S GMPLORIG(2,0)=ECNT_U
 M GMPFLD(2)=GMPLORIG(2)
 Q
 ;
SET(IFN,GMPFLD,GMPOLDIND,GMPROV,GMPORIG)  ; Update New SA multiple (2 node)only here, as old fields were updated previously by GMPLSAVE.
 ; Update also the Audit file taking into consideration both old SA fields & new, as applies.  If we get both, then new overrides old.
 N ACNT,AUDIT,CNT,EID,ERROR,FDA,FLD,ID,IDX,IENS,CODE,NODE,NOW,OVALUE,TMP,VALUE,SAORIG,SAORIG2,SAFLD,SAFLD2
 S ACNT=0,NOW=$$NOW^XLFDT()
 ; Build New SA mult structure FDA array and Update Prob file
 I $$SHOWSA,$D(GMPFLD(2))>0 D    ;version switched
 .S FDA(9000011,IFN_",",.01)=$P($G(^AUPNPROB(IFN,0)),U)
 .S IDX=0
 .F  S IDX=$O(GMPFLD(2,IDX)) Q:IDX'>0  D        ;New SA multiple
 ..S IENS="?+"_IDX_","_IFN_","
 ..S NODE=$G(GMPFLD(2,IDX)),ID=$P(NODE,U),VALUE=$P(NODE,U,3)
 ..I VALUE="" S VALUE="@"
 ..S FDA(9000011.02,IENS,.01)=ID,FDA(9000011.02,IENS,1)=VALUE
 .D UPDATE^DIE("","FDA","","ERROR")
 ; Audit SA fields if Provider is passed, which is for changes and not when New Prob
 I $G(GMPROV) D
 .D BLDSAAUDIT  ; Build SA audit xref arrays
 .S CODE="",CNT=0
 .F  S CODE=$O(SAFLD(CODE)) Q:CODE=""  D       ;Loop thru All SA field changes and values, for Audit only
 ..S VALUE=$P(SAFLD(CODE),U) Q:(VALUE'="")&(VALUE'=0)&(VALUE'=1)
 ..S EID=$$FINDBYCODE^PXSPECAUTH(CODE) Q:EID=0
 ..S CNT=CNT+1,GMPFLD(2,CNT)=EID_U_CODE_U_VALUE_U_$$GETVALUE^PXSPECAUTH(VALUE)
 ..Q:'GMPROV   ;SKIP field for audit
 ..S OLDVALUE=$P($G(SAORIG(CODE)),U)
 ..S TMP=$$COMPARE(OLDVALUE,VALUE,CODE) I TMP="" Q
 ..S ACNT=ACNT+1,AUDIT(ACNT)=IFN_"^2^"_NOW_U_DUZ_TMP_+$G(GMPROV)
 ; update Prob file with New SA multiples & Audit these updates
 S ACNT=0 F  S ACNT=$O(AUDIT(ACNT)) Q:ACNT'>0  D
 .D AUDIT^GMPLX(AUDIT(ACNT),"")      ;Audit updates
 Q
 ;
BLDSAAUDIT ; Create audit xref arrays from passed in arrays; subcript by internal CODE for comparing of old to new values
 Q:'$$SHOWSA     ;switch
 F QQ=1.1,1.11,1.12,1.13,1.15,1.16,1.17,1.18 D   ;Orig old SA fields values subscripted by Int CODE
 . S SAORIG($$OLDSC(QQ))=$P($G(GMPORIG(QQ)),U,1)
 F QQ=0:0 S QQ=$O(GMPORIG(2,QQ)) Q:'QQ  D        ;Orig SA multiple field values subscripted by Int CODE
 . S SAORIG2($P(GMPORIG(2,QQ),U,2))=$P(GMPORIG(2,QQ),U,3)
 ; Merge orig 2 internal code values back into Orig SAORIG, so orig 2 values will overwrite or create entries to SAORIG with all available orig values
 M SAORIG=SAORIG2
 ;repeat steps above, but for the New SAFLD array values
 F QQ=1.1,1.11,1.12,1.13,1.15,1.16,1.17,1.18 D
 . S SAFLD($$OLDSC(QQ))=$P($G(GMPFLD(QQ)),U,1)
 F QQ=0:0 S QQ=$O(GMPFLD(2,QQ)) Q:'QQ  D
 . S SAFLD2($P(GMPFLD(2,QQ),U,2))=$P(GMPFLD(2,QQ),U,3)
 ; Merge new multiple field values back into SAFLD
 M SAFLD=SAFLD2
 Q
 ;
SETARRAY(AR,FULLSTRUCT) ;Sets SA Instructions, called by RPC tag
 N SPECAUTH
 D SETARRAY^PXSPECAUTH(.SPECAUTH,FULLSTRUCT) M SEQMAP=SPECAUTH("specialAuthorityTypes")
 Q
 ;
SETVALUE(VALUE) ;Converts json value to Mumps value
 Q $S(VALUE="Yes":1,VALUE="No":0,1:"")
 ;
GETPATSA(DFN,SA,SA2) ;Get the patients SA indicators.  GMPL similar to PXSPECAUTH, but returns 3 additional data elements to Problem List tab. 
 N GMPSC,GMPAGTOR,GMPION,GMPGULF,GMPHNC,GMPMST,GMPCV,GMPSHD,VA,VADM
 D DEM^VADPT                ;get info for 3 additional elements
 ; The ":" tells the JSON encoder that it's already encoded, so it doesn't strip the quotes around DUZ(2) when it's just a number
 S SA2("facility",":")=""""_DUZ(2)_"""" ; user logged in facility #
 S SA2("deathIndicator")=$G(VADM(6))    ; death indicator
 S SA2("ssn4",":")=""""_VA("BID")_""""               ; need this to reconstitute GMPDFN on return
 D VADPT^GMPLX1(DFN)     ; get eligibilities Orig 8 SAs
 S SA("SC")=$P(GMPSC,U)     ; service connected
 S SA("AO")=$G(GMPAGTOR)    ; agent orange exposure
 S SA("IR")=$G(GMPION)      ; ionizing radiation exposure
 S SA("EC")=$G(GMPGULF)     ; gulf war exposure
 S SA("HNC")=$G(GMPHNC)     ; head/neck cancer
 S SA("MST")=$G(GMPMST)     ; MST
 S SA("CV")=$G(GMPCV)       ; CV
 S SA("SHAD")=$G(GMPSHD)    ; SHAD
 ;TODOBLD4  COMPACT ACT ADD BACK IN
 ;N CAVAL S CAVAL=$$ASC^PXCOMPACT(DFN),SA("ASC")=$S(CAVAL="Y":1,CAVAL="N":0,1:"")    ; ASC (COMPACT)
 Q
 ;
GETNEWSA(IFN,GMPL1,GMPLSA) ; Get Problem file Special Authorities for printing
 Q:'$$SHOWSA
 N ABBR,VAL
 I $P($G(^AUPNPROB(IFN,2,0)),U,4) D    ;new SA multiple exists, use it
 .N GMPL0,PXIEN,QQ
 .S QQ=0
 .F  S QQ=$O(^AUPNPROB(IFN,2,QQ)) Q:'QQ  D
 ..S GMPL0=$G(^AUPNPROB(IFN,2,QQ,0)),PXIEN=$P(GMPL0,U),VAL=$P(GMPL0,U,2)
 ..S ABBR=$P($$GETZERO^PXSPECAUTH(PXIEN),U,5)
 ..I ABBR="SC" S GMPLSA("SC|NSC")=$S(VAL=1:"SC",VAL=0:"NSC",1:"") Q
 ..S:VAL GMPLSA(ABBR)=""
 I '$P($G(^AUPNPROB(IFN,2,0)),U,4) D    ;old nodes of fixed SA values
 .S GMPLSA("SC|NSC")=$S(+$P(GMPL1,U,10):"SC",$P(GMPL1,U,10)=0:"NSC",1:"")
 .S:+$P(GMPL1,U,11) GMPLSA("AO")=""
 .S:+$P(GMPL1,U,12) GMPLSA("IR")=""
 .S:+$P(GMPL1,U,13) GMPLSA("EC")=""
 .S:+$P(GMPL1,U,15) GMPLSA("HNC")=""
 .S:+$P(GMPL1,U,16) GMPLSA("MST")=""
 .S:+$P(GMPL1,U,17) GMPLSA("CV")=""
 .S:+$P(GMPL1,U,18) GMPLSA("SHD")=""
 Q
 ;
EP(IFN) ;moved here from GMPLX
 N GMPLRET
 I $D(^AUPNPROB(IFN,2)) D  Q GMPLRET
 .N GMPLSAS
 .D GETNEWSA(IFN,"",.GMPLSAS)
 .S GMPLRET=$G(GMPLSAS("SC|NSC"))
 N X,GMPLSC D SCS^GMPLX1(+IFN,.GMPLSC) S X=$G(GMPLSC(1))
 Q X
 ; ============================   RPC section  ===========================================
SPECAUTHDEF(RESULTS,JSONIN) ;Return Patient Special Authorities (SA) that may be selected via a JSON serialized string.  *508
 ; Input:  JSONIN  = JSON elements: {patientId}: DFN,  
 ;                                  {loadStructure}:true/false value (optional); Load SAs rules structure
 ; Output: RESULTS = JSON elements: {code}: internal abbr, 
 ;                                  {visible}:true/false
 ;
 N ABBR,AR,CODE,DEF,DFN,DISPNAM,EIEN,ENAB,ERR,LOADSTRUCT,NODE,SEQ,SAX,SA2,PARAM
 I '$D(JSONIN) D  Q
 . S ERR("success")="false",ERR("error")="Missing 1 or more parameter elements"
 . D ENCODE^XLFJSON("ERR","RESULTS","JSONERR")
 D DECODE^XLFJSON("JSONIN","PARAM","JSONERR")
 ;get old params via JSON string for specialAuths
 S DFN=$G(PARAM("patientId"))
 ;
 I '$$SHOWSA D SAOFFOUT Q   ;True, Problem Code switch off
 ;
 S LOADSTRUCT=$S($G(PARAM("loadStructure"))="true":1,1:0)
 ;
 D GETPATSA(DFN,.SAX,.SA2) ;get patient specific SA and other indicators
 S CODE=""
 F  S CODE=$O(SA2(CODE)) Q:CODE=""  D   ;get 3 patient level elements {facility}, {deathIndicator}, {ssn4}
 . I $L($G(SA2(CODE))) S AR(CODE)=SA2(CODE)
 . E  I $D(SA2(CODE))'<10 D
 . . N SUB S SUB="" F  S SUB=$O(SA2(CODE,SUB)) Q:SUB=""  D
 . . . S AR(CODE,SUB)=SA2(CODE,SUB)
 ;
 I LOADSTRUCT D SETARRAY(.AR,1)         ;if instructions wanted
 ;
 S CODE=""
 F  S CODE=$O(SAX(CODE)) Q:CODE=""  D   ;get current indicator values
 . S EIEN=$O(^PXIND(820,"C",CODE,"")) Q:'EIEN
 . S NODE=^PXIND(820,EIEN,0),DISPNAM=$P(NODE,U,3),SEQ=$P(NODE,U,4),ABBR=$P(NODE,U,5)
 . S ENAB=$P(SAX(CODE),U),ENAB=$S(ENAB=1:"true",1:"false")
 . S DEF=$P(SAX(CODE),U,2),DEF=$$GETVALUE(DEF)
 . S AR("specialAuthority",SEQ,"code")=CODE
 . S AR("specialAuthority",SEQ,"default")=DEF
 . S AR("specialAuthority",SEQ,"visible")=ENAB
 S AR("success")="true"
 D ENCODE^XLFJSON("AR","RESULTS","JSONERR")
 Q
 ;
SETERROR(RESULTS,ERROR) ;
 N ERR,IDX
 S RESULTS("success")="false"
 I $D(ERROR)#2 S ERR=ERROR
 E  S ERR=""
 S IDX="" F  S IDX=$O(ERROR(IDX)) Q:IDX=""  D
 . I ERR'="" S ERR=ERR_$C(13)_$C(10)
 . S ERR=ERR_ERROR(IDX)
 S RESULTS("error")=ERR
 Q
 ;
PNUM(IDX) ; Returns Piece number of the old SA field
 I IDX="SC" Q 10
 I IDX="AO" Q 11
 I IDX="IR" Q 12
 I IDX="EC" Q 13
 I IDX="HNC" Q 15
 I IDX="MST" Q 16
 I IDX="CV" Q 17
 I IDX="SHAD" Q 18
 Q 0
 ;
SAFORPROBLEM(OUTPUT,ALLOWED,PIDX,PID) ; Returns Special Authorities for a problems
 N IDX,SA,PL1,PL2,SA0,CODE,PN,SAIDX,SAXREF,SAIEN,SACODE,SAVALUE
 S OUTPUT("problems",PIDX,"problemId")=PID
 S PL1=$G(^AUPNPROB(PID,1))
 S SAIDX=0,CODE=""
 F  S CODE=$O(ALLOWED(CODE)) Q:CODE=""  D
 . S SAIDX=SAIDX+1,SAXREF(CODE)=SAIDX,PN=$P(ALLOWED(CODE),U,2),SAVALUE=$P(PL1,U,PN)
 . S OUTPUT("problems",PIDX,"specialAuthority",SAIDX,"code")=CODE
 . S OUTPUT("problems",PIDX,"specialAuthority",SAIDX,"visible")=$S(+ALLOWED(CODE):"true",1:"false")
 . D SETDEFAULT
 S IDX=0 F  S IDX=$O(^AUPNPROB(PID,2,IDX)) Q:'IDX  D
 . S PL2=$G(^AUPNPROB(PID,2,IDX,0)),SAIEN=$P(PL2,U),SAVALUE=$P(PL2,U,2)
 . S SA0=$$GETZERO^PXSPECAUTH(SAIEN),SACODE=$P(SA0,U,2)
 . S SAIDX=+$G(SAXREF(SACODE)) I 'SAIDX Q
 . D SETDEFAULT
 Q
 ;
SETDEFAULT ;
 S OUTPUT("problems",PIDX,"specialAuthority",SAIDX,"default")=$S(SAVALUE=1:"yes",SAVALUE=0:"no",1:"unanswered")
 Q
 ; 
SAFORPROBLEMS(RESULTS,JSONIN) ; Returns Special Authorities for a list of problems
 N INPUT,OUTPUT,ERROR,DFN,IDX,PID,PIDX,ALLOWED,FOUND
 ;
 D DECODE^XLFJSON("JSONIN","INPUT","ERROR")
 K ^TMP("GMPLSPECAUTH SAFORPROBLEMS",$J) S RESULTS=$NA(^TMP("GMPLSPECAUTH SAFORPROBLEMS",$J))
 I 1 D
 . I $D(ERROR) D SETERROR(.OUTPUT,.ERROR) Q
 . S DFN=+$G(INPUT("patientId")) I DFN=0 D SETERROR(.OUTPUT,"Patient Id not found.") Q
 . I '$$SHOWSA D SAOFFOUT Q   ;True, Problem Code switch off
 . ;
 . S OUTPUT("patientId")=DFN
 . D GETPATSA(DFN,.ALLOWED)
 . S FOUND=0,IDX="" F  S IDX=$O(ALLOWED(IDX)) Q:IDX=""  D  Q:FOUND
 .. I +ALLOWED(IDX) S FOUND=1,$P(ALLOWED(IDX),U,2)=$$PNUM(IDX)
 . I 'FOUND Q
 . S PIDX=0,IDX="" F  S IDX=$O(INPUT("problems",IDX)) Q:IDX=""  D
 .. S PID=$G(INPUT("problems",IDX,"problemId"))
 .. I +PID,$D(^AUPNPROB(PID,0)),$P(^AUPNPROB(PID,0),U,2)=DFN D
 ... S PIDX=PIDX+1 D SAFORPROBLEM(.OUTPUT,.ALLOWED,PIDX,PID)
 I '$D(OUTPUT("success")) S OUTPUT("success")="true"
 D ENCODE^XLFJSON("OUTPUT","RESULTS","ERROR")
 Q
