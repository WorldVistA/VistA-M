PXMCODES ;SLC/PKR - Mapped codes listing for inquire. ;02/26/2016
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**211**;Aug 12, 1996;Build 454
 ;
 ;Reference to LEXU supported by ICR #5679.
 ;
 ;==========================================
MCDISP(CODELIST,NL,OUTPUT) ;Mapped codes display.
 N ACTDT,CHDR,CODE,CODESYS,DATE,DESC,FMTSTR,INACTDT,IND,INDXDT
 N MAPDT,NOLEX,NOUT,NP,PDATA,RESULT,TEXT,TEXTOUT
 S FMTSTR(1)="10L1^10C2^10C2^19C2^19C2"
 S FMTSTR(2)="15L1^60L"
 S CHDR(1)="Code       Activation Inactivation       Mapped               Linked"
 S CHDR(2)="---------- ---------- ------------ -------------------  -------------------"
 S CHDR(3)="Code            Description"
 S CHDR(4)="--------------  -----------"
 S NL=NL+1,OUTPUT(NL)=""
 S NL=NL+1,OUTPUT(NL)="                    Code Mappings"
 I '$D(CODELIST) S NL=NL+1,OUTPUT(NL)="No codes are mapped" Q
 S CODESYS=""
 F  S CODESYS=$O(CODELIST(CODESYS)) Q:CODESYS=""  D
 . K DESC
 . S NL=NL+1,OUTPUT(NL)=""
 .;ICR #5679
 . S NL=NL+1,OUTPUT(NL)="Coding System: "_CODESYS_" = "_$P($$CSYS^LEXU(CODESYS),U,4)
 . S NL=NL+1,OUTPUT(NL)=CHDR(1)
 . S NL=NL+1,OUTPUT(NL)=CHDR(2)
 . S CODE=""
 . F  S CODE=$O(CODELIST(CODESYS,CODE)) Q:CODE=""  D
 .. S MAPDT=$$FMTE^XLFDT($P(CODELIST(CODESYS,CODE),U,1),"5Z")
 .. S INDXDT=$$FMTE^XLFDT($P(CODELIST(CODESYS,CODE),U,2),"5Z")
 ..;DBIA #5679
 .. K PDATA
 .. S NOLEX=0
 .. S RESULT=$$PERIOD^LEXU(CODE,CODESYS,.PDATA)
 .. I +RESULT=-1 D
 ... S NOLEX=1
 ...;DBIA #1997, #3991
 ... I (CODESYS="CPC")!(CODESYS="CPT") D PERIOD^ICPTAPIU(CODE,.PDATA)
 ... I (CODESYS="ICD")!(CODESYS="ICP") D PERIOD^ICDAPIU(CODE,.PDATA)
 .. S ACTDT=1000101,NP=0
 .. F  S ACTDT=$O(PDATA(ACTDT)) Q:ACTDT=""  D
 ... S NP=NP+1
 ... S INACTDT=$$FMTE^XLFDT($P(PDATA(ACTDT),U,1),"5Z")
 ... S DESC(CODE)=CODE_U_$S(NOLEX=1:$P(PDATA(ACTDT),U,2),1:PDATA(ACTDT,0))
 ... I CODESYS="SCT" S DESC(CODE)=DESC(CODE)_" "_$$SCTHIER(CODE,ACTDT)
 ... I NP=1 S TEXT=CODE_U_$$FMTE^XLFDT(ACTDT,"5Z")_U_INACTDT_U_MAPDT_U_INDXDT
 ... I NP>1 S TEXT=U_$$FMTE^XLFDT(ACTDT,"5Z")_U_INACTDT
 ... D COLFMT^PXRMTEXT(FMTSTR(1),TEXT," ",.NOUT,.TEXTOUT)
 ... F IND=1:1:NOUT S NL=NL+1,OUTPUT(NL)=TEXTOUT(IND)
 .;Display the code descriptions.
 . S CODE="",NP=0
 . F  S CODE=$O(DESC(CODE)) Q:CODE=""  D
 .. S NP=NP+1
 .. I NP=1 D
 ... S NL=NL+1,OUTPUT(NL)=""
 ... S NL=NL+1,OUTPUT(NL)=CHDR(3)
 ... S NL=NL+1,OUTPUT(NL)=CHDR(4)
 .. D COLFMT^PXRMTEXT(FMTSTR(2),DESC(CODE)," ",.NOUT,.TEXTOUT)
 .. F IND=1:1:NOUT S NL=NL+1,OUTPUT(NL)=TEXTOUT(IND)
 Q
 ;
 ;==========================================
SCTHIER(CODE,ACTDT) ;Return the SNOMED hierarchy.
 N FSN,HE,HIER,HS
 ;DBIA #5007
 S FSN=$$GETFSN^LEXTRAN1("SCT",CODE,ACTDT)
 S HS=$F(FSN,"(")
 S HE=$F(FSN,")",HS)
 S HIER=$E(FSN,HS-1,HE-1)
 Q HIER
 ;
