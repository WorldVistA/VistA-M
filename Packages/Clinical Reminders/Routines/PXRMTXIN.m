PXRMTXIN ;SLC/PKR - Taxonomy inquiry for general use. ;02/26/2014
 ;;2.0;CLINICAL REMINDERS;**26**;Feb 04, 2005;Build 404
 ;==========================================
BTAXALL ;Taxonomy inquiry, return the formatted text OUTPUT.
 N BOP,IEN,NAME,OUTPUT,TYPE
 S TYPE=$$GTYPE
 S BOP=$$BORP^PXRMUTIL("B")
 I BOP="" Q
 S NAME=""
 F  S NAME=$O(^PXD(811.2,"B",NAME)) Q:NAME=""  D
 . S IEN=$O(^PXD(811.2,"B",NAME,""))
 . D TAXINQ(TYPE,IEN,.OUTPUT)
 . I BOP="B" D BROWSE^DDBR("OUTPUT","NR","Taxonomy Inquiry")
 . I BOP="P" D GPRINT^PXRMUTIL("OUTPUT")
 Q
 ;
 ;==========================================
BTAXINQ(IEN) ;Display a Taxonomy inquiry, defaults to the Browswer.
 N BOP,DIR0,OUTPUT,TITLE,TYPE
 I '$D(^PXD(811.2,IEN)) Q
 S TYPE=$$GTYPE
 S TITLE="Taxonomy Inquiry - "_$S(TYPE="C":"Condensed",TYPE="F":"Full",1:"")
 D TAXINQ(TYPE,IEN,.OUTPUT)
 S BOP=$$BORP^PXRMUTIL("B")
 I BOP="" Q
 I BOP="B" D BROWSE^DDBR("OUTPUT","NR",TITLE)
 I BOP="P" D GPRINT^PXRMUTIL("OUTPUT")
 Q
 ;
 ;==========================================
CDETAILC(CODESYS,CODE,UID,NL,OUTPUT) ;Get the condensed details about a code.
 N ACTDT,DESC,HIER,INACT,INACTDT,LDESC,LHIER,LTEXT,NOLEX,PDATA,TEXT
 S UID=$S(UID=1:"X",1:" ")
 D CDETAILS(CODESYS,CODE,.NOLEX,.PDATA)
 S ACTDT=1000101
 F  S ACTDT=$O(PDATA(ACTDT)) Q:ACTDT=""  D
 . S INACTDT=$P(PDATA(ACTDT),U,1)
 . S INACT=$S((ACTDT>DT):"X",(INACTDT=""):" ",(INACTDT'>DT):"X",1:" ")
 . S DESC=$S(NOLEX=1:$P(PDATA(ACTDT),U,2),1:PDATA(ACTDT,0))
 . S LDESC=$L(DESC)
 . I (LDESC>51),(CODESYS'="SCT") S DESC=$E(DESC,1,47)_"..."
 . I CODESYS="SCT" D
 .. S HIER=$$SCTHIER(CODE,ACTDT),LHIER=$L(HIER)
 .. I (LDESC+LHIER)'>50 S DESC=DESC_" "_HIER
 .. E  S DESC=$E(DESC,1,(46-LHIER))_"... "_HIER
 . S TEXT=CODE,LTEXT=$L(TEXT)
 . S TEXT=TEXT_$$REPEAT^XLFSTR(" ",(22-LTEXT))_INACT,LTEXT=$L(TEXT)
 . S TEXT=TEXT_$$REPEAT^XLFSTR(" ",(27-LTEXT))_UID,LTEXT=$L(TEXT)
 . S TEXT=TEXT_$$REPEAT^XLFSTR(" ",(30-LTEXT))_DESC
 . S NL=NL+1,OUTPUT(NL)=TEXT
 Q
 ;
 ;==========================================
CDETAILF(CODESYS,CODE,UID,NL,OUTPUT) ;Get the full details about a code.
 N ACTDT,DESC,FMTSTR,INACTDT,IND,NOLEX,NOUT,NP,PDATA,TEXT
 S FMTSTR="10L1^10C2^10C4^1C3^35L"
 S UID=$S(UID=1:"X",1:" ")
 D CDETAILS(CODESYS,CODE,.NOLEX,.PDATA)
 S ACTDT=1000101,NP=0
 F  S ACTDT=$O(PDATA(ACTDT)) Q:ACTDT=""  D
 . S NP=NP+1
 . S INACTDT=$P(PDATA(ACTDT),U,1)
 . S DESC=$S(NOLEX=1:$P(PDATA(ACTDT),U,2),1:PDATA(ACTDT,0))
 . I CODESYS="SCT" S DESC=DESC_" "_$$SCTHIER(CODE,ACTDT)
 . I NP=1 S TEXT=CODE_U_$$FMTE^XLFDT(ACTDT,"5Z")_U_$$FMTE^XLFDT(INACTDT,"5Z")_U_UID_U_DESC
 . I NP>1 S TEXT=U_$$FMTE^XLFDT(ACTDT,"5Z")_U_$$FMTE^XLFDT(INACTDT,"5Z")_U_UID_U_DESC
 . D COLFMT^PXRMTEXT(FMTSTR,TEXT," ",.NOUT,.TEXTOUT)
 . F IND=1:1:NOUT S NL=NL+1,OUTPUT(NL)=TEXTOUT(IND)
 Q
 ;
 ;==========================================
CDETAILS(CODESYS,CODE,NOLEX,PDATA) ;Get the details about a code.
 N RESULT
 ;DBIA #5679
 S RESULT=$$PERIOD^LEXU(CODE,CODESYS,.PDATA)
 S NOLEX=0
 I +RESULT=-1 D
 . S NOLEX=1
 .;DBIA #1997, #3991
 . I (CODESYS="CPC")!(CODESYS="CPT") D PERIOD^ICPTAPIU(CODE,.PDATA)
 . I (CODESYS="ICD")!(CODESYS="ICP") D PERIOD^ICDAPIU(CODE,.PDATA)
 Q
 ;
 ;==========================================
GTYPE() ;Prompt the user for the type of output.
 N DIR,POP,X,Y
 S DIR(0)="SA"_U_"C:Condensed;F:Full"
 S DIR("A")="Condensed or full inquiry? "
 S DIR("B")="C"
 D ^DIR
 I $D(DIROUT) S DTOUT=1
 I $D(DTOUT)!($D(DUOUT)) Q "F"
 Q Y
 ;
 ;==========================================
OLDINQ(IEN) ;Produce the old inquiry output for comparison during testing.
 N FLDS,HEADER,PXRMROOT,STEXT
 S FLDS="[PXRM TAXONOMY INQUIRY]"
 S HEADER="REMINDER TAXONOMY INQUIRY"
 S PXRMROOT="^PXD(811.2,"
 S STEXT="Select REMINDER TAXONOMY: "
 D SET^PXRMINQ(IEN,HEADER)
 D DISP^PXRMINQ(PXRMROOT,FLDS)
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
 ;==========================================
TAXINQ(TYPE,IEN,OUTPUT) ;Taxonomy inquiry, return the formatted text OUTPUT.
 ;Use 80 column output.
 N CHDR,CODE,CODEP,CODESYS,CODESYSN,DUPL,IND,OCL,NL,IENSTR
 N NCODES,NOUT,NPAD,NUCODES,RM,T100,TEMP,TERM,TEXT,TEXTOUT,UID,WPARRAY
 S RM=80
 I TYPE="C" D
 . S CHDR(1)="Code                INACT UID Description"
 . S CHDR(2)="------------------  ----- --- -----------"
 . ;S CHDR(1)="Code       Inactive  UID  Description"
 . ;S CHDR(2)="---------  --------  ---  -----------"
 I TYPE="F" D
 . S CHDR(1)="Code       Activation Inactivation  UID  Description"
 . S CHDR(2)="---------  ---------- ------------  ---  -----------"
 S TEMP=^PXD(811.2,IEN,0)
 S IENSTR="No. "_IEN
 S OUTPUT(1)=$$REPEAT^XLFSTR("-",RM)
 S TEXT=$P(TEMP,U,1)
 S NPAD=RM-$L(TEXT)-1
 S OUTPUT(2)=TEXT_$$RJ^XLFSTR(IENSTR,NPAD," ")
 S OUTPUT(3)=$$REPEAT^XLFSTR("-",RM)
 S OUTPUT(4)=""
 S T100=^PXD(811.2,IEN,100)
 S OUTPUT(5)="Class: "_$$GET1^DIQ(811.2,IEN,100)
 S OUTPUT(6)="Sponsor: "_$$GET1^DIQ(811.2,IEN,101)
 S OUTPUT(7)="Review Date: "_$$GET1^DIQ(811.2,IEN,102)
 S OUTPUT(8)=""
 S OUTPUT(9)="Description:"
 S NL=9
 S TEMP=$$GET1^DIQ(811.2,IEN,2,"","WPARRAY")
 I TEMP="" S NL=NL+1,OUTPUT(NL)=""
 I TEMP="WPARRAY" D
 . S IND=0
 . F  S IND=$O(WPARRAY(IND)) Q:IND=""  S NL=NL+1,OUTPUT(NL)=WPARRAY(IND)
 . K WPARRAY
 . S NL=NL+1,OUTPUT(NL)=""
 S NL=NL+1,OUTPUT(NL)="Inactive Flag: "_$$GET1^DIQ(811.2,IEN,1.6)
 S NL=NL+1,OUTPUT(NL)="Patient Data Source: "_$$GET1^DIQ(811.2,IEN,4)
 S NL=NL+1,OUTPUT(NL)="Use Inactive Problems: "_$$GET1^DIQ(811.2,IEN,10)
 ;Initialze the code counter.
 K ^TMP($J,"CC")
 S CODESYS=""
 F  S CODESYS=$O(^PXD(811.2,IEN,20,"AE",CODESYS)) Q:CODESYS=""  D
 . S (NCODES(CODESYS),NUCODES(CODESYS))=0
 .;DBIA #5679
 . I '$D(CODESYSN(CODESYS)) S CODESYSN(CODESYS)=$P($$CSYS^LEXU(CODESYS),U,4)
 ;Display the selected codes.
 S NL=NL+1,OUTPUT(NL)=""
 S NL=NL+1,OUTPUT(NL)="Selected Codes:"
 S TERM=""
 F  S TERM=$O(^PXD(811.2,IEN,20,"ATCC",TERM)) Q:TERM=""  D
 . S NL=NL+1,OUTPUT(NL)=""
 . S TEXT="Lexicon Search Term/Code: "_TERM
 . D COLFMT^PXRMTEXT(RM_"L",TEXT," ",.NOUT,.TEXTOUT)
 . F IND=1:1:NOUT S NL=NL+1,OUTPUT(NL)=TEXTOUT(IND)
 . S CODESYS=""
 . F  S CODESYS=$O(^PXD(811.2,IEN,20,"ATCC",TERM,CODESYS)) Q:CODESYS=""  D
 .. S NL=NL+1,OUTPUT(NL)=""
 ..;DBIA #5679
 .. S NL=NL+1,OUTPUT(NL)="Coding System: "_CODESYSN(CODESYS)
 .. K OCL
 .. S CODE=""
 .. F  S CODE=$O(^PXD(811.2,IEN,20,"ATCC",TERM,CODESYS,CODE)) Q:CODE=""  D
 ... S OCL(CODE_" ")=CODE_U_^PXD(811.2,IEN,20,"ATCC",TERM,CODESYS,CODE)
 ... S NCODES(CODESYS)=NCODES(CODESYS)+1
 ... S ^TMP($J,"CC",CODE)=$G(^TMP($J,"CC",CODE))+1
 ... S ^TMP($J,"CC",CODE,CODESYS,TERM)=""
 .. S CODEP=""
 .. S NL=NL+1,OUTPUT(NL)=CHDR(1)
 .. S NL=NL+1,OUTPUT(NL)=CHDR(2)
 .. F  S CODEP=$O(OCL(CODEP)) Q:CODEP=""  D
 ... S CODE=$P(OCL(CODEP),U,1),UID=$P(OCL(CODEP),U,2)
 ... I TYPE="C" D CDETAILC(CODESYS,CODE,UID,.NL,.OUTPUT)
 ... I TYPE="F" D CDETAILF(CODESYS,CODE,UID,.NL,.OUTPUT)
 . S NL=NL+1,OUTPUT(NL)=""
 ;
 ;Look for duplicated codes if there are any list them.
 S CODE=""
 F  S CODE=$O(^TMP($J,"CC",CODE)) Q:CODE=""  D
 . I ^TMP($J,"CC",CODE)>1 S DUPL(CODE)=^TMP($J,"CC",CODE)
 ;
 ;If there are duplicates count the number of unique codes.
 I $D(DUPL) D
 . S CODESYS="",NUCODES=0
 . F  S CODESYS=$O(^PXD(811.2,IEN,20,"AE",CODESYS)) Q:CODESYS=""  D
 .. S CODE=""
 .. F  S CODE=$O(^PXD(811.2,IEN,20,"AE",CODESYS,CODE)) Q:CODE=""  D
 ... S NUCODES(CODESYS)=NUCODES(CODESYS)+1,NUCODES=NUCODES+1
 ;
 S NL=NL+1,OUTPUT(NL)=""
 S NL=NL+1,OUTPUT(NL)="This taxonomy includes the following numbers of codes:"
 S CODESYS="",TEMP=0
 F  S CODESYS=$O(NCODES(CODESYS)) Q:CODESYS=""  D
 . S NL=NL+1,OUTPUT(NL)=CODESYSN(CODESYS)_": "_NCODES(CODESYS)
 . I $D(DUPL) S OUTPUT(NL)=OUTPUT(NL)_"; "_NUCODES(CODESYS)_" are unique."
 . S TEMP=TEMP+NCODES(CODESYS)
 S NL=NL+1,OUTPUT(NL)="Total number of codes: "_TEMP
 I $D(DUPL) S OUTPUT(NL)=OUTPUT(NL)_"; "_NUCODES_" are unique."
 ;
 ;If there are duplicates, list them.
 I '$D(DUPL) K ^TMP($J,"CC") Q
 S NL=NL+1,OUTPUT(NL)=""
 S NL=NL+1,OUTPUT(NL)="The following codes are included in more than one Term/Code."
 S CODE=""
 F  S CODE=$O(DUPL(CODE)) Q:CODE=""  D
 . S CODESYS=""
 . F  S CODESYS=$O(^TMP($J,"CC",CODE,CODESYS)) Q:CODESYS=""  D
 .. S NL=NL+1,OUTPUT(NL)=CODESYSN(CODESYS)_" code "_CODE_" is included "_DUPL(CODE)_" times."
 .. S NL=NL+1,OUTPUT(NL)=" Term/Code:"
 .. S TERM=""
 .. F  S TERM=$O(^TMP($J,"CC",CODE,CODESYS,TERM)) Q:TERM=""  D
 ... S NL=NL+1,OUTPUT(NL)="  "_TERM
 . S NL=NL+1,OUTPUT(NL)=""
 K ^TMP($J,"CC")
 Q
 ;
