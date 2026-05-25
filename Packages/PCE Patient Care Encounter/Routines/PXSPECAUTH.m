PXSPECAUTH ;ISL/AGP/GSN - Special Authorities APIs and RPCs ;Nov 06, 2025@13:07:01
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**244**;Aug 12, 1996;Build 37
 ;
 ; Reference to DECODE^XLFJSON, ENCODE^XLFJSON in ICR #6682
 Q
 ; ============================= Begin API section ===========================================
 ;
FINDBYNAME(NAME) ; Return the SA file ien from the NAME passed in.
 Q +$O(^PXIND(820,"B",NAME,""))
 ;
FINDBYCODE(CODE) ; Return the SA file ien from the CODE passed in.
 Q +$O(^PXIND(820,"C",CODE,""))  ;return ien
 ;
GETDISPLAYNAME(IEN) ; Return the SA Display name via the SA file ien passed in.
 Q $$GET1^DIQ(820,IEN_",",3)
 ;
GETVALUE(DEF) ; Return the SA JSON field value from the Fileman value passed in.
 Q $S(DEF="1":"Yes",DEF="0":"No",1:"Unanswered")
 ;
GETCODE(IEN) ;
 Q $P($G(^PXIND(820,IEN,0)),U,2)
 ;
GETZERO(IEN) ; Return the entire 0 node of the SA file via ien.
 Q $G(^PXIND(820,IEN,0))
 ;
SETARRAY(AR,FULLSTRUCT) ; Return JSON field values for the SAs optionally return the full structure of business rules.
 N ACTN,CODE,EXCLUDE,HLPLN,IEN,JSONERR,NODE,PKGNAME,QQ,RR,SA,SEQ,WHENVAL
 S CODE=""
 F  S CODE=$O(^PXIND(820,"C",CODE)) Q:CODE=""  D                                       ;Get base values
 .S IEN=$O(^PXIND(820,"C",CODE,0)) Q:'IEN
 .S NODE=^PXIND(820,IEN,0),SEQ=$P(NODE,U,4)
 .S AR("specialAuthorityTypes",SEQ,"code")=CODE
 .S AR("specialAuthorityTypes",SEQ,"disabled")=$S($P(NODE,U,8)=1:"true",1:"false")
 .S AR("specialAuthorityTypes",SEQ,"id")=IEN
 .S AR("specialAuthorityTypes",SEQ,"abbreviation")=$P(NODE,U,5)
 .S AR("specialAuthorityTypes",SEQ,"displayName")=$P(NODE,U,3)
 .S AR("specialAuthorityTypes",SEQ,"sequence")=SEQ
 .S AR("specialAuthorityTypes",SEQ,"default")=$$GETVALUE($P(NODE,U,7))
 .I '+$G(FULLSTRUCT) Q
 .S HLPLN=0
 .F  S HLPLN=$O(^PXIND(820,IEN,3,HLPLN)) Q:'HLPLN  D                                   ;Get Help lines
 ..S AR("specialAuthorityTypes",SEQ,"description","\",HLPLN)=^PXIND(820,IEN,3,HLPLN,0)_$C(13)_$C(10)
 .S QQ=0
 .F QQ=0:0 S QQ=$O(^PXIND(820,IEN,2,QQ)) Q:'QQ  D                                      ;Get the whenValueIs value for SAs
 ..S WHENVAL=$$GET1^DIQ(820.02,QQ_","_IEN_",",.01)
 ..S AR("specialAuthorityTypes",SEQ,"valueChangeActions",QQ,"whenValueIs")=WHENVAL
 ..S RR=0
 ..F  S RR=$O(^PXIND(820,IEN,2,QQ,1,RR)) Q:'RR  D                                      ;Get the actions to perform on the linked SAs
 ...S ACTN=$$GET1^DIQ(820.021,RR_","_QQ_","_IEN_",",.01)
 ...S AR("specialAuthorityTypes",SEQ,"valueChangeActions",QQ,"actions",RR)=ACTN
 ..S RR=0
 ..F  S RR=$O(^PXIND(820,IEN,2,QQ,2,RR)) Q:'RR  D                                      ;Get linked SAs
 ...S SA=$$GET1^DIQ(820.022,RR_","_QQ_","_IEN_",",.01,"I"),SA=$$GET1^DIQ(820,SA,2)      ;linked SA abbr code
 ...S AR("specialAuthorityTypes",SEQ,"valueChangeActions",QQ,"linkedSpecialAuthorities",RR)=SA
 .S QQ=0
 .F  S QQ=$O(^PXIND(820,IEN,1,QQ)) Q:'QQ  D                                            ;Get Package name and exclusion flag
 ..S PKGNAME=$$GET1^DIQ(820.01,QQ_","_IEN_",",.01)
 ..S EXCLUDE=$$GET1^DIQ(820.01,QQ_","_IEN_",",1,"I"),EXCLUDE=$S(EXCLUDE="1":"true",1:"false")
 ..S AR("specialAuthorityTypes",SEQ,"package",QQ,"name")=PKGNAME
 ..S AR("specialAuthorityTypes",SEQ,"package",QQ,"excluded")=EXCLUDE
 Q
 ;
GETSADEF(RESULTS,INPUTS) ; Get SAs for a patient per Location and/or Visit
 N CAVALUE,CODE,DFN,DATETIME,LOADSTRUCT,LOC,NODE,SEQMAP,SPECAUTH,VST
 S DFN=+$G(INPUTS("patientId")),DATETIME=$G(INPUTS("dateTime"))
 S LOADSTRUCT=$S($G(INPUTS("loadStructure"))="true":1,1:0)
 S LOC=+$G(INPUTS("location")),VST=+$G(INPUTS("visitIen"))
 D SETARRAY(.SPECAUTH,LOADSTRUCT)
 M SEQMAP=SPECAUTH("specialAuthorityTypes")
 N AR,CNT,SEQ
 ;
 D GETPATSA(DFN,DATETIME,LOC,VST,.AR) ;get patient specific SA indicators
 ;
 S SEQ=0,CNT=0 F  S SEQ=$O(SEQMAP(SEQ)) Q:SEQ'>0  D
 .S CNT=CNT+1
 .I LOADSTRUCT M RESULTS("specialAuthority",CNT)=SEQMAP(SEQ)
 .I 'LOADSTRUCT D
 ..S RESULTS("specialAuthority",CNT,"code")=SEQMAP(SEQ,"code")
 ..S RESULTS("specialAuthority",CNT,"visible")="false"
 ..S RESULTS("specialAuthority",CNT,"default")=SEQMAP(SEQ,"default")
 .I '$D(AR(SEQMAP(SEQ,"code"))) Q
 .I SEQMAP(SEQ,"disabled")="true" Q
 .S NODE=$G(AR(SEQMAP(SEQ,"code")))
 .I $P(NODE,U)=1 S RESULTS("specialAuthority",CNT,"visible")="true"
 .I $P(NODE,U,2)=0 S RESULTS("specialAuthority",CNT,"default")="no"
 .I $P(NODE,U,2)=1 S RESULTS("specialAuthority",CNT,"default")="yes"
 I $G(INPUTS("returnSequenceMap"))="true" M RESULTS("sequenceMap")=SEQMAP
 Q
 ;
GETPATSA(DFN,ATM,LOC,VST,PXARRAY) ;Get the patients SA indicators
 N CODE,DATE,INSTDT,NODE0,ORGSA,PCELOC,SCVAL
 ;S PCELOC=+$$GET^XPAR("ALL","PX SA USE LOC FOR ENCOUNTERS")   ;Location feature switch for PCE
 ;S:'PCELOC LOC=""
 D SCCOND^PXUTLSCC(DFN,ATM,+$G(LOC),+$G(VST),.PXARRAY) I +$G(VST)=0 Q
 D GETSAFORVISIT(.ORGSA,VST)
 S CODE="" F  S CODE=$O(PXARRAY(CODE)) Q:CODE=""  D
 .I $G(ORGSA(CODE))=""!($G(ORGSA(CODE))=-1) Q
 .S PXARRAY(CODE)=1_U_ORGSA(CODE)
 S SCVAL=$G(PXARRAY("SC")) I +SCVAL=0!($P(SCVAL,U,2)=0) Q
 I '$$INSTALDT^XPDUTL("PX*1.0*244",.INSTDT) Q
 S DATE=$O(INSTDT("")) I DATE'>0 Q
 S NODE0=$G(^AUPNVSIT(VST,0)) I +$P(NODE0,U)=0 Q
 I $$FMDIFF^XLFDT(DATE,$P(NODE0,U),2)<1 Q
 S PXARRAY("AO")=0,PXARRAY("IR")=0,PXARRAY("EC")=0
 Q
 ;
ISACTIVECODE(CODE) ;
 N IDX
 S IDX=+$O(^PXIND(820,"C",CODE,"")) I IDX'>0 Q 0
 I +$P($G(^PXIND(820,IDX,0)),U,8)=1 Q 0
 Q 1
 ;
 ;; ============================= End API section  ===========================================
 ;
BLDFDA(FDA,IEN,SAS,ISVPOV) ;
 ;If called from DATA2PCE API SAS format is SAS("AO")=1/0
 ;If called from ListManager Check out SAS format is SAS(1)="2;AO^1/0"
 N FN,ID,IDX,IENS,NODE,SAIDX,VALUE,X
 S FN=$S(ISVPOV:9000010.08,1:9000010.01)
 S IDX=0 F  S IDX=$O(SAS(IDX)) Q:IDX'>0  D
 .S NODE=SAS(IDX,0),ID=+$P(NODE,U),VALUE=$P(NODE,U,2) I ID=0 Q
 .S SAIDX=$S(ISVPOV:+$O(^AUPNVPOV(IEN,900,"B",ID,"")),1:+$O(^AUPNVSIT(IEN,900,"B",ID,"")))
 .I SAIDX=0 S SAIDX=$$SETNEWSA(IEN,ID,ISVPOV) I 'SAIDX Q
 .S IENS=SAIDX_","_IEN_","
 .S FDA(FN,IENS,.01)=ID
 .S FDA(FN,IENS,1)=$S(VALUE'="":VALUE,1:-1)
 I $D(FDA),'ISVPOV D
 .F X=80001:1:80008 S FDA(9000010,IEN_",",X)="@"
 .F X=80011:1:80018 S FDA(9000010,IEN_",",X)="@"
 Q
 ;
 ;BLDFDAENTRY(FDA,ID,VISIT,VALUE) ;
 ;N IDX,IENS
 ;S IDX=+$O(^AUPNVSIT(VISIT,900,"B",ID,""))
 ;I IDX=0 S IDX=$$SETNEWSA(VISIT,ID) I 'IDX Q
 ;I IDX>0 S IENS=IDX_","_VISIT_","
 ;S FDA(9000010.01,IENS,.01)=ID
 ;S FDA(9000010.01,IENS,1)=$S(VALUE'="":VALUE,1:"@")
 ;Q
 ;
CONVERTTOPCE(RESULTS,SAS) ;
 N CNT,CODE,ID
 S CNT=0,CODE="" F  S CODE=$O(SAS(CODE)) Q:CODE=""  D
 .S ID=+$O(^PXIND(820,"C",CODE,"")) I ID=0 Q
 .S CNT=CNT+1,RESULTS(CNT,0)=ID_U_SAS(CODE)
 S RESULTS=$S(CNT>0:CNT,1:"")
 Q
 ;
GETSAFORVISITDET(NODE900,NODE800,VISIT) ;
 N TEMP
 D GETSAFORVISIT(.TEMP,VISIT)
 D SETOLD800(.NODE800,.TEMP,0)
 D CONVERTTOPCE(.NODE900,.TEMP)
 Q
 ;
GETSAFORVISIT(RESULTS,VISIT) ;
 N CODE,DATE,IDX,INSTDT,NODE,X
 S IDX=0 F  S IDX=$O(^AUPNVSIT(VISIT,900,IDX)) Q:IDX'>0  D
 .S NODE=$G(^AUPNVSIT(VISIT,900,IDX,0)) I +$P(NODE,U)=0 Q
 .S CODE=$P($G(^PXIND(820,$P(NODE,U),0)),U,2) I CODE="" Q
 .S RESULTS(CODE)=$P(NODE,U,2)
 I $D(RESULTS) Q
 S NODE=$G(^AUPNVSIT(VISIT,800))
 F X=1:1:8 D
 .S CODE=$$NODETOCODE(X) I CODE="" Q
 .I $P(NODE,U,X)="",+$P(NODE,U,(X+10))=0 Q
 .S RESULTS(CODE)=$P(NODE,U,X)
 I '$D(RESULTS) Q
 S SCVAL=$G(RESULTS("SC")) I +SCVAL=0!($P(SCVAL,U,2)=0) Q
 ;S INSTDT(DT)=1
 I '$$INSTALDT^XPDUTL("PX*1.0*244",.INSTDT) Q
 S DATE=$O(INSTDT("")) I DATE'>0 Q
 S NODE0=$G(^AUPNVSIT(VISIT,0)) I +$P(NODE0,U)=0 Q
 I $$FMDIFF^XLFDT(DATE,$P(NODE0,U),2)<1 Q
 K RESULTS("AO"),RESULTS("IR"),RESULTS("EC")
 Q
 ;
GETSAFORVPOVDET(NODE900,NODE800,VPOV) ;
 N TEMP
 D GETSAFORVPOV(.TEMP,VPOV)
 D SETOLD800(.NODE800,.TEMP,1)
 D CONVERTTOPCE(.NODE900,.TEMP)
 Q
 ;
GETSAFORVPOV(RESULTS,VPOV) ;
 N CODE,FOUND,IDX,NODE,X
 S IDX=0,FOUND=0 F  S IDX=$O(^AUPNVPOV(VPOV,900,IDX)) Q:IDX'>0  D
 .S NODE=$G(^AUPNVPOV(VPOV,900,IDX,0)) I +$P(NODE,U)=0 Q
 .S CODE=$P($G(^PXIND(820,$P(NODE,U),0)),U,2) I CODE="" Q
 .S RESULTS(CODE)=$P(NODE,U,2) I +$P(NODE,U,2)>-1 S FOUND=1
 I $D(RESULTS),FOUND=1 Q
 S NODE=$G(^AUPNVPOV(VPOV,800))
 F X=1:1:8 D
 .S CODE=$$NODETOCODE(X) I CODE="" Q
 .I $P(NODE,U,X)="" Q
 .S RESULTS(CODE)=$P(NODE,U,X)
 Q
 ;
SAVALUEFORVISIT(VISIT,CODE) ;
 N SAS
 D GETSAFORVISIT(.SAS,VISIT)
 Q $G(SAS(CODE))
 ;
SETOLD800(RESULT,SAS,ISVPOV) ;
 N PIECE,CODE
 S RESULT=$S(+$G(ISVPOV):"^^^^^^^",1:"^^^^^^^^^^^^^^^^^")
 I '$D(SAS) Q
 S CODE="" F  S CODE=$O(SAS(CODE)) Q:CODE=""  D
 .S PIECE=$$SCMAP(CODE) I PIECE=0 Q
 .S $P(RESULT,U,PIECE)=$S(SAS(CODE)>-1:SAS(CODE),1:"") I ISVPOV Q
 .S $P(RESULT,U,(PIECE+10))=0
 Q
 ;
UPDATEROMVISIT(PXARRAY,VST) ;
 N NODE,PIECE,SA,TMP,VALUE
 S NODE=$G(^AUPNVSIT(VST,800))
 S SA="" F  S SA=$O(PXARRAY(SA)) Q:SA=""  D
 .S PIECE=$$SCMAP(SA) I PIECE=0 Q
 .S VALUE=$P(NODE,U,PIECE),TMP=PXARRAY(SA) I VALUE="" Q
 .I SA="AO"!(SA="IR")!(SA="EC") S TMP=1_U_VALUE S PXARRAY(SA)=TMP Q
 Q
 ;
NODETOCODE(J) ;
 I J=1 Q "SC"
 I J=2 Q "AO"
 I J=3 Q "IR"
 I J=4 Q "EC"
 I J=5 Q "MST"
 I J=6 Q "HNC"
 I J=7 Q "CV"
 I J=8 Q "SHAD"
 Q ""
 ;
SCMAP(J) ;
 I $G(J)="" Q 0
 I J="SC" Q 1
 I J="AO" Q 2
 I J="IR" Q 3
 I J="EC" Q 4
 I J="MST" Q 5
 I J="HNC" Q 6
 I J="CV" Q 7
 I J="SHAD" Q 8
 Q 0
 ;
SETVALUE(VALUE) ;
 Q $S(VALUE="Yes":1,VALUE="No":0,1:"")
 ;
SETNEWSA(IEN,SA,ISVPOV) ;
 N DA,DIC,X,Y
 S DIC(0)="F",DA(1)=IEN
 S DIC=$S(ISVPOV:"^AUPNVPOV(",1:"^AUPNVSIT(")_DA(1)_",900,",X=SA
 D FILE^DICN
 Q +$G(Y)
 ;
 ; ============================ Begin  RPC section  ===========================================
SPECAUTHSTRUCT(RESULTS) ;Return valid Special Authorities (SA) rules structure defined in file #820.
 ; Input:  None.
 ; Output: RESULTS = JSON elements: {code}:internal abbr,{abbreviation}:external abbr code,{displayName}:Name,{sequence}:display sequence,{default}:Yes/No/Unanswered
 ;                                  {whenValueIs}:value this SA code,{actions}:action to take on a linked SA code,{linkedSpecialAuthorities}:a linked SA code
 N AR,JSONERR
 D SETARRAY(.AR,1)
 D ENCODE^XLFJSON("AR","RESULTS","JSONERR")
 Q
 ;
SPECAUTHDEF(RESULTS,JSONIN) ;Return Patient Special Authorities (SA) that may be selected via a JSON serialized string.  *508
 ; Input:  JSONIN  = JSON elements: {patientId}:orig DFN, {dateTime}:orig ATM, {location}:orig LOC, {visitIen}:orig VST,
 ;                                  {loadStructure}:true/false value (optional); Load SAs rules structure
 ; Output: RESULTS = JSON elements: {code}: internal abbr,{visible}:true/false,{default}:Yes/No/Unanswered
 ;
 N AR,ERR,PARAM
 I '$D(JSONIN) D  Q
 . S ERR("success")="false",ERR("error")="Missing 1 or more parameter elements"
 . D ENCODE^XLFJSON("ERR","RESULTS","JSONERR")
 D DECODE^XLFJSON("JSONIN","PARAM","JSONERR")
 D GETSADEF(.AR,.PARAM)
 S AR("success")="true"
 D ENCODE^XLFJSON("AR","RESULTS","JSONERR")
 Q
 ;
 ; ============================ End  RPC section  ===========================================
