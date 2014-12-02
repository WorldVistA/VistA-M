PXRMTXIM ;SLC/PKR - Taxonomy import/create routines. ;05/07/2014
 ;;2.0;CLINICAL REMINDERS;**26**;Feb 04, 2005;Build 404
 ;==========================================
CRETAX(FLAGS,TXDATA,ERRMSG) ;Create a taxonomy based on the data in TXDATA.
 ;The following TXDATA nodes are required:
 ;NAME, CLASS, and SOURCE.
 ;The SPONSOR node is optional, it is a pointer to the Sponsor file.
 ;Codes to include in the taxonomy are specified as
 ;TXDATA("CODE",CODESYS,CODEP)=FMT^UID
 ;where CODESYS is one of the following: 10D, 10P, CPT, ICD, ICP, SCT.
 ;CODEP is either the code or its IEN, except for SCT where it must be
 ;the code. FMT is "E" if CODEP is the code and "I" if it is the
 ;pointer. UID is 1 if the code can be used in a dialog and 0 or null
 ;if it cannot.
 N CDATA,CODE,CODEP,CODESYS,CODESYST,DESC,IENS,FDA,FDAIEN,FMT,MSG
 N RESULT,SAVEOK,TC,TEMP,UID
 S DESC(1,0)="This taxonomy was automatically generated from "_TXDATA("SOURCE")_"."
 S IENS="+1,"
 S FDA(811.2,IENS,.01)=TXDATA("NAME")
 S FDA(811.2,IENS,2)="DESC"
 S FDA(811.2,IENS,100)=TXDATA("CLASS")
 I $D(TXDATA("SPONSOR")) S FDA(811.2,IENS,101)=TXDATA("SPONSOR")
 D UPDATE^DIE(FLAGS,"FDA","FDAIEN","MSG")
 I $D(MSG) D  Q 0
 . N IC,EMSG,REF
 . S REF="MSG"
 . F IC=1:1 S REF=$Q(@REF) Q:REF=""  S EMSG(IC)=REF_"="_@REF
 . D BMES^XPDUTL("Could not create taxonomy named "_TXDATA("NAME"))
 . D MES^XPDUTL(.EMSG)
 K ^TMP("PXRMCODES",$J)
 S CODESYST=""
 F  S CODESYST=$O(TXDATA("CODE",CODESYST)) Q:CODESYST=""  D
 . S CODEP=""
 . F  S CODEP=$O(TXDATA("CODE",CODESYST,CODEP)) Q:CODEP=""  D
 .. S CODESYS=CODESYST
 .. S TEMP=$G(TXDATA("CODE",CODESYST,CODEP))
 .. S FMT=$P(TEMP,U,1)
 .. S UID=+$P(TEMP,U,2)
 ..;DBIA #5747
 .. I (CODESYST="10D")!(CODESYS="ICD") S RESULT=$$ICDDX^ICDEX(CODEP,DT,CODESYS,FMT)
 .. I (CODESYST="10P")!(CODESYS="ICP") S RESULT=$$ICDOP^ICDEX(CODEP,DT,CODESYS,FMT)
 ..;DBIA #1995
 .. I CODESYST="CPC" S RESULT=$$CPT^ICPTCOD(CODEP)
 .. I CODESYST="CPT" S RESULT=$$CPT^ICPTCOD(CODEP) I $P(RESULT,U,5)="H" S CODESYS="CPC"
 .. I CODESYST="SCT" S RESULT=1_U_CODEP
 .. I +RESULT=-1 S ERRMSG(CODESYS,CODEP)=$P(RESULT,U,2)  Q
 .. S CODE=$P(RESULT,U,2)
 .. K CDATA
 ..;DBIA #5679
 .. S RESULT=$$CSDATA^LEXU(CODE,CODESYS,DT,.CDATA)
 .. S TC=$P(CDATA("LEX",1),U,2)
 .. I TC="" S TC=CDATA("SYS",14,1)
 .. I TC="" S ERRMSG(CODESYS,CODE)="No description found." Q
 .. S ^TMP("PXRMCODES",$J,TC,CODESYS,CODE)=UID
 S SAVEOK=$$SAVETC^PXRMTXIM(FDAIEN(1))
 I SAVEOK D POSTSAVE^PXRMTXSM(FDAIEN(1))
 Q FDAIEN(1)
 ;
 ;==========================================
IMP(IEN) ;Import codes into a taxonomy.
 N CLASS,DIR,LOADOK,NATOK,OPTION,PXRMTIEN,SAVED,X,Y
 S CLASS=$P(^PXD(811.2,IEN,100),U,1)
 S NATOK=$S(CLASS'="N":1,1:($G(PXRMINST)=1)&($G(DUZ(0))="@"))
 I 'NATOK D  Q
 . D EN^DDIOL("Codes cannot be imported into national taxonomies!")
 . H 2
 . S VALMBCK="R"
 ;Present the menu of import choices.
 S DIR(0)="S^HF:CSV host file;"
 S DIR(0)=DIR(0)_"PA:CSV file paste;"
 S DIR(0)=DIR(0)_"TAX:Another taxonomy;"
 S DIR(0)=DIR(0)_"WEB:CSV file from a web site"
 S DIR("A")="Select the import method"
 S DIR("??")="^D HELP^PXRMTXIH"
 D ^DIR
 S OPTION=Y
 I OPTION="HF" D
 . S LOADOK=$$LOADHF("TAXIMP")
 . I LOADOK D
 .. S SAVED=$$IMPCSV(IEN,"TAXIMP")
 .. I SAVED D UPDCL(IEN,"from a host file")
 I OPTION="PA" D
 . D PASTECSV("TAXIMP")
 . S SAVED=$$IMPCSV(IEN,"TAXIMP")
 . I SAVED D UPDCL(IEN,"by pasting")
 I OPTION="TAX" D
 . D START^PXRMTXCE
 . S SAVED=$$IMPTAX(IEN,.PXRMTIEN)
 . I SAVED D UPDCL(IEN,"from other taxonomies")
 I OPTION="WEB" D
 . S LOADOK=$$LOADWEB("TAXIMP")
 . I LOADOK D
 .. S SAVED=$$IMPCSV(IEN,"TAXIMP")
 .. I SAVED D UPDCL(IEN,"from a web site")
 S VALMBCK="R"
 Q
 ;
 ;==========================================
IMPCSV(IEN,NODE) ;Import comma separated data into the Lexicon Term/Code
 ;multiple. The expected format is:
 ;LEXICON TERM/CODE,CODING SYSTEM,CODE 1,CODE 2, .... CODE N.
 I '$D(^TMP($J,NODE)) Q 0
 N ANS,CODE,CODESYS,CODESYSN,DUPL,IND,JND,KND,NCODES,NL,RESULT
 N SAVED,SAVEOK,TEMP,TERM,TEXT,TEXTOUT
 K ^TMP($J,"CC")
 S (IND,NL,SAVED)=0
 D EN^DDIOL("Starting the import process ... ")
 F  S IND=$O(^TMP($J,NODE,IND)) Q:IND=""  D
 . S TEMP=^TMP($J,NODE,IND,1)
 . I '$$ISCSV(TEMP) Q
 . S TERM=$P(TEMP,",",1)
 . I (TERM="")!(TERM="^") Q
 . S TERM=TERM_" (imported)"
 . I IND>1 S NL=NL+1,TEXTOUT(NL)=""
 . S NL=NL+1,TEXTOUT(NL)="Term/Code: "_TERM
 . S CODESYS=$P(TEMP,",",2)
 .;DBIA #5679
 . I '$D(CODESYSN(CODESYS)) S CODESYSN(CODESYS)=$P($$CSYS^LEXU(CODESYS),U,4)
 .;Make sure it is a valid Lexicon coding system.
 .;DBIA #5679
 . S RESULT=$$CSYS^LEXU(CODESYS)
 . I +RESULT=-1 D
 .. S TEXT="  Coding System: "_CODESYS_" not found in Lexicon."
 .. D EN^DDIOL(TEXT)
 . I +RESULT'=-1 D
 .. S TEXT="  Coding System: "_$P(RESULT,U,4)
 .. I '$D(NCODES(CODESYS)) S NCODES(CODESYS)=0
 . S NL=NL+1,TEXTOUT(NL)=TEXT
 . I +RESULT=-1 Q
 .;Make sure it is a valid taxonomy coding system.
 . I '$$VCODESYS^PXRMLEX(CODESYS) S NL=NL+1,TEXTOUT(NL)="  Warning taxonomies do not use "_CODESYS_" codes." Q
 . S NCODES=0
 . F JND=3:1:$L(TEMP,",") D
 .. S CODE=$P(TEMP,",",JND)
 .. S CODE=$TR(CODE," ","")
 .. I CODE="" Q
 .. S RESULT=$$PERCHK(CODE,CODESYS,TERM,.NCODES,.NL,.TEXTOUT)
 .. I +RESULT=-1 D LEXCHK(CODE,CODESYS,TERM,.NCODES,.NL,.TEXTOUT)
 .;Check for additional code only nodes in ^TMP.
 . S JND=1
 . F  S JND=$O(^TMP($J,NODE,IND,JND)) Q:JND=""  D
 .. S TEMP=^TMP($J,NODE,IND,JND)
 .. F KND=1:1:$L(TEMP,",") D
 ... S CODE=$P(TEMP,",",KND)
 ... S CODE=$TR(CODE," ","")
 ... I CODE="" Q
 ... S RESULT=$$PERCHK(CODE,CODESYS,TERM,.NCODES,.NL,.TEXTOUT)
 ... I +RESULT=-1 D LEXCHK(CODE,CODESYS,TERM,.NCODES,.NL,.TEXTOUT)
 S NL=NL+1,TEXTOUT(NL)=""
 ;Look for duplicate codes.
 S CODE=""
 F  S CODE=$O(^TMP($J,"CC",CODE)) Q:CODE=""  D
 . I ^TMP($J,"CC",CODE)>1 S DUPL(CODE)=^TMP($J,"CC",CODE)
 I $D(DUPL) D EN^DDIOL("This import contains duplicate codes.")
 I '$D(NCODES) D  Q SAVED
 . D EN^DDIOL("There are no codes to import.")
 . S VALMBCK="R"
 . H 2
 ;
 S ANS=$$ASKYN^PXRMEUT("Y","Do you want to browse the list of codes")
 I ANS D
 . S NL=NL+1,TEXTOUT(NL)=""
 . S NL=NL+1,TEXTOUT(NL)="This import includes the following numbers of codes:"
 . S CODESYS="",TEMP=0
 . F  S CODESYS=$O(NCODES(CODESYS)) Q:CODESYS=""  D
 .. S NL=NL+1,TEXTOUT(NL)=CODESYSN(CODESYS)_": "_NCODES(CODESYS)
 .. S TEMP=TEMP+NCODES(CODESYS)
 . S NL=NL+1,TEXTOUT(NL)="Total number of codes: "_TEMP
 . ;If there are duplicates, list them.
 . I $D(DUPL) D
 .. S NL=NL+1,TEXTOUT(NL)=""
 .. S NL=NL+1,TEXTOUT(NL)="The following codes are included in more than one Term/Code:"
 .. S CODE=""
 .. F  S CODE=$O(DUPL(CODE)) Q:CODE=""  D
 ... S CODESYS=""
 ... F  S CODESYS=$O(^TMP($J,"CC",CODE,CODESYS)) Q:CODESYS=""  D
 .... S NL=NL+1,TEXTOUT(NL)=CODESYSN(CODESYS)_" code "_CODE_" is included "_DUPL(CODE)_" times."
 .... S NL=NL+1,TEXTOUT(NL)=" Term/Code:"
 .... S TERM=""
 .... F  S TERM=$O(^TMP($J,"CC",CODE,CODESYS,TERM)) Q:TERM=""  D
 ..... S NL=NL+1,TEXTOUT(NL)="  "_TERM
 ... S NL=NL+1,TEXTOUT(NL)=""
 .. S NL=NL+1,TEXTOUT(NL)="After importing the codes more details can be found in the taxonomy inquiry."
 . D BROWSE^DDBR("TEXTOUT","NR","List Of Codes To Be Imported")
 S SAVED=0
 S ANS=$$ASKYN^PXRMEUT("Y","Do you want to save the imported codes")
 I ANS D
 . M ^TMP("PXRMCODES",$J)=^TMP($J,"CODES")
 . S SAVEOK=$$SAVETC(IEN)
 . I SAVEOK D POSTSAVE^PXRMTXSM(IEN) S SAVED=1
 ;
 K ^TMP($J,NODE),^TMP($J,"CC"),^TMP($J,"CODES")
 S VALMBCK="R"
 Q SAVED
 ;
 ;==========================================
IMPTAX(IEN,PXRMTIEN) ;Import codes from other taxonomies.
 ;Go through the list ask if some or all, if some then have to prompt
 ;for each term/code.
 N ANS,CODESYS,DIR,IMP,IND,JND,SAVED,SAVELIST,SAVEOK
 N TIEN,TERM,TEXT,TNAME,X,Y
 S DIR(0)="S^ALL:All codes;"
 S DIR(0)=DIR(0)_"SEL:Selected codes"
 S DIR("B")="ALL"
 S TIEN=0
 F  S TIEN=$O(PXRMTIEN(TIEN)) Q:TIEN=""  D
 . S TNAME=$P(^PXD(811.2,TIEN,0),U,1)
 . D EN^DDIOL("Ready to import codes from taxonomy "_TNAME)
 . D ^DIR
 . S ANS=Y
 . S IND=0
 . F  S IND=+$O(^PXD(811.2,TIEN,20,IND)) Q:IND=0  D
 .. S TERM=^PXD(811.2,TIEN,20,IND,0)
 .. S JND=0
 .. F  S JND=+$O(^PXD(811.2,TIEN,20,IND,1,JND)) Q:JND=0  D
 ... S CODESYS=$P(^PXD(811.2,TIEN,20,IND,1,JND,0),U,1)
 ... S IMP=$S(ANS="SEL":0,1:1)
 ... I ANS="SEL" D
 .... S TEXT(1)=""
 .... S TEXT(2)="Import codes from:"
 .... S TEXT(3)=" Term/Code - "_TERM
 .... S TEXT(4)=" Coding system - "_CODESYS
 .... D EN^DDIOL(.TEXT)
 .... S IMP=$$ASKYN^PXRMEUT("Y","Import","","")
 ... I IMP S SAVELIST(TIEN,TERM,CODESYS)=""
 S SAVED=0,TIEN=""
 F  S TIEN=$O(SAVELIST(TIEN)) Q:TIEN=""  D
 . K ^TMP("PXRMCODES",$J)
 . S TERM=""
 . F  S TERM=$O(SAVELIST(TIEN,TERM)) Q:TERM=""  D
 .. S CODESYS=""
 .. F  S CODESYS=$O(SAVELIST(TIEN,TERM,CODESYS)) Q:CODESYS=""  D
 ... M ^TMP("PXRMCODES",$J,TERM,CODESYS)=^PXD(811.2,TIEN,20,"ATCC",TERM,CODESYS)
 . S SAVEOK=$$SAVETC(IEN)
 . I SAVEOK D POSTSAVE^PXRMTXSM(IEN) S SAVED=1
 K ^TMP("PXRMCODES",$J)
 Q SAVED
 ;
 ;==========================================
ISCSV(LINE) ;Verify that LINE is in CSV format with a least 3 pieces of
 ;data.
 I $L(LINE)=0 Q 0
 N ISCSV
 S ISCSV=$S($L(LINE,",")>2:1,1:0)
 I 'ISCSV D
 . N TEXT
 . S TEXT(1)=""
 . S TEXT(2)="The following line is not in CSV format and cannot be processed:"
 . S TEXT(3)=" "_LINE
 . D EN^DDIOL(.TEXT)
 . H 1
 Q ISCSV
 ;
 ;==========================================
LEXCHK(CODE,CODESYS,TERM,NCODES,NL,TEXTOUT) ;Use $$TAX^LEX10CS
 ;to determine if code is a partial code that expands to a list of
 ;codes. Add valid codes to the list.
 N ACODE,CODEI,IND,NFOUND,RESULT,SRC,TEXT
 K ^TMP("LEXTAX",$J)
 ;DBIA #5681
 S RESULT=$$TAX^LEX10CS(CODE,CODESYS,DT,"LEXTAX",0)
 S NFOUND=+RESULT
 I NFOUND=-1 D  Q
 . S TEXT(1)="Invalid coding system code pair:"
 . S TEXT(2)=" Coding system is "_CODESYS_", code is "_CODE
 . D EN^DDIOL(.TEXT)
 . S NL=NL+1,TEXTOUT(NL)=TEXT(1)
 . S NL=NL+1,TEXTOUT(NL)=TEXT(2)
 . K ^TMP("LEXTAX",$J)
 S SRC=+$O(^TMP("LEXTAX",$J,0))
 S CODEI=""
 F  S CODEI=$O(^TMP("LEXTAX",$J,SRC,CODEI)) Q:CODEI=""  D
 . S IND=0
 . F  S IND=$O(^TMP("LEXTAX",$J,SRC,CODEI,IND)) Q:IND=""  D
 .. S ACODE=$P(^TMP("LEXTAX",$J,SRC,CODEI,IND,0),U,1)
 .. S NCODES=NCODES+1
 .. S NL=NL+1,TEXTOUT(NL)=$J(NCODES,5)_". "_ACODE
 .. S ^TMP($J,"CODES",TERM,CODESYS,ACODE)=""
 .. I '$D(^TMP($J,"CC",ACODE,CODESYS,TERM)) D
 ... S ^TMP($J,"CC",ACODE,CODESYS,TERM)=""
 ... S ^TMP($J,"CC",ACODE)=$G(^TMP($J,"CC",ACODE))+1
 ... S NCODES(CODESYS)=NCODES(CODESYS)+1
 K ^TMP("LEXTAX",$J)
 Q
 ;
 ;==========================================
LOADHF(NODEOUT) ;Load the CSV host file into ^TMP.
 ;The name of the host file should have a ".CSV" extension.
 N FILE,GBL,LHF,PATH,TEMP
 S TEMP=$$GETEHF^PXRMEXHF("CSV")
 I TEMP="" Q 0
 S PATH=$P(TEMP,U,1),FILE=$P(TEMP,U,2)
 ;Load the host file into ^TMP.
 K ^TMP($J,"HFCSV")
 S GBL="^TMP($J,""HFCSV"",1)"
 S GBL=$NA(@GBL)
 ;Load the file contents into ^TMP.
 S LHF=$$FTG^%ZISH(PATH,FILE,GBL,3)
 I LHF=0 D EN^DDIOL("The host file load failed") H 2 K ^TMP($J,"HFCSV") Q 0
 D RBLCKHF("HFCSV",NODEOUT)
 K ^TMP($J,"HFCSV")
 Q 1
 ;
 ;==========================================
LOADWEB(NODEOUT) ;Load the CSV file from a web site into ^TMP
 N DIR,HDR,IND,JND,NL1,NL2,RESULT,TEXT,URL,X,Y
 S DIR(0)="F^10:245"
 S DIR("A")="Input the url for the CSV file"
 D ^DIR
 I (Y="")!(Y=U) Q 0
 S URL=Y
 S Y=$$LOW^XLFSTR(Y)
 I $E(Y,1,5)="https" D  Q 0
 . D EN^DDIOL("The https protocol is not supported.")
 ;Load the file contents into ^TMP.
 K ^TMP($J,NODEOUT),^TMP($J,"WEBCSV")
 ;DBIA #5553
 S RESULT=$$GETURL^XTHC10(URL,10,"^TMP($J,""WEBCSV"")",.HDR)
 I $P(RESULT,U,1)'=200 D  Q 0
 . S TEXT="Could not load the csv file: "
 . S TEXT=TEXT_"Error "_$P(RESULT,U,1)_" "_$P(RESULT,U,2)
 . D EN^DDIOL(.TEXT) H 2
 . K ^TMP($J,"WEBCSV")
 D RBLCKWEB("WEBCSV",NODEOUT)
 K ^TMP($J,"WEBCSV")
 Q 1
 ;
 ;==========================================
PASTECSV(NODE) ;Paste the CSV file.
 N DONE,NL,TEMP
 K ^TMP($J,NODE)
 S DONE=0,NL=0
 D EN^DDIOL("Paste the CSV file now, press <ENTER> to finish.")
 D EN^DDIOL("","","!") H 1
 F  Q:DONE  D
 . R TEMP:10
 . I '$T S DONE=1 Q
 . I $L(TEMP)=0 S DONE=1 Q
 . S NL=NL+1,^TMP($J,NODE,NL,1)=TEMP
 Q
 ;
 ;==========================================
PERCHK(CODE,CODESYS,TERM,NCODES,NL,TEXTOUT) ;Use $$PERIOD^LEXU
 ;to verify a code is valid and add valid codes to the list.
 N PDATA,RESULT
 ;DBIA #5679
 S RESULT=$$PERIOD^LEXU(CODE,CODESYS,.PDATA)
 I +RESULT=-1 Q RESULT
 S NCODES=NCODES+1
 S NL=NL+1,TEXTOUT(NL)=$J(NCODES,5)_". "_CODE
 S ^TMP($J,"CODES",TERM,CODESYS,CODE)=""
 I '$D(^TMP($J,"CC",CODE,CODESYS,TERM)) D
 . S ^TMP($J,"CC",CODE,CODESYS,TERM)=""
 . S ^TMP($J,"CC",CODE)=$G(^TMP($J,"CC",CODE))+1
 . S NCODES(CODESYS)=NCODES(CODESYS)+1
 Q RESULT
 ;
 ;==========================================
RBLCKHF(NODEIN,NODEOUT) ;FTG^%ZISH breaks lines at 255 characters. This could
 ;put a code across two lines. Format the ^TMP array so this does not
 ;happen.
 N CHAR,IND,JND,KND,L1,NL1,NL2,TEMP
 K ^TMP($J,"NODEOUT")
 S IND="",NL1=0
 F  S IND=+$O(^TMP($J,NODEIN,IND)) Q:IND=0  D
 . S TEMP=^TMP($J,NODEIN,IND),NL1=NL1+1
 . I '$D(^TMP($J,NODEIN,IND,"OVF")) S ^TMP($J,NODEOUT,NL1,1)=TEMP Q
 . S L1="",NL2=0
 . F JND=1:1:$L(TEMP) D
 .. S CHAR=$E(TEMP,JND)
 .. S L1=L1_CHAR
 .. I $L(L1)>230,CHAR="," S NL2=NL2+1,^TMP($J,NODEOUT,NL1,NL2)=L1,L1=""
 .;Check for overflow nodes.
 . S JND=0
 . F  S JND=+$O(^TMP($J,NODEIN,IND,"OVF",JND)) Q:JND=0  D
 .. S TEMP=^TMP($J,NODEIN,IND,"OVF",JND)
 .. F KND=1:1:$L(TEMP) D
 ... S CHAR=$E(TEMP,KND)
 ... S L1=L1_CHAR
 ... I $L(L1)>230,CHAR="," S NL2=NL2+1,^TMP($J,NODEOUT,NL1,NL2)=L1,L1=""
 . I $L(L1)>0 S NL2=NL2+1,^TMP($J,NODEOUT,NL1,NL2)=L1
 Q
 ;
 ;==========================================
RBLCKWEB(NODEIN,NODEOUT) ;GETURL^XTHC10 breaks lines at 245 characters. This
 ;could break a line into two lines. Format the ^TMP array so this does
 ;not happen.
 N CHAR,IND,JND,KND,L1,LEN,NL1,NL2,TEMP
 K ^TMP($J,"NODEOUT")
 S IND="",NL1=0
 F  S IND=+$O(^TMP($J,NODEIN,IND)) Q:IND=0  D
 . S TEMP=^TMP($J,NODEIN,IND),LEN=$L(TEMP)
 . I LEN=0 S NL1=NL1+1,^TMP($J,NODEOUT,NL1,1)=TEMP Q
 . S NL1=NL1+1
 . I $D(^TMP($J,NODEIN,IND))<11 S ^TMP($J,NODEOUT,NL1,1)=$TR(TEMP,$C(13),"") Q
 . S L1="",NL2=0
 . F JND=1:1:$L(TEMP) D
 .. S CHAR=$E(TEMP,JND)
 .. I CHAR=$C(13) Q
 .. S L1=L1_CHAR
 .. I $L(L1)>230,CHAR="," S NL2=NL2+1,^TMP($J,NODEOUT,NL1,NL2)=L1,L1=""
 .;Check for overflow nodes.
 . S JND=0
 . F  S JND=+$O(^TMP($J,NODEIN,IND,JND)) Q:JND=0  D
 .. S TEMP=^TMP($J,NODEIN,IND,JND)
 .. F KND=1:1:$L(TEMP) D
 ... S CHAR=$E(TEMP,KND)
 ... I CHAR=$C(13) Q
 ... S L1=L1_CHAR
 ... I $L(L1)>230,CHAR="," S NL2=NL2+1,^TMP($J,NODEOUT,NL1,NL2)=L1,L1=""
 . I $L(L1)>0 S NL2=NL2+1,^TMP($J,NODEOUT,NL1,NL2)=L1
 Q
 ;
 ;==========================================
SAVETC(IEN) ;Save the term/code.
 N FDA,IENS,IND,MSG,SUCCESS,TC
 S IND=0,SUCCESS=1,TC=""
 F  S TC=$O(^TMP("PXRMCODES",$J,TC)) Q:TC=""  D
 .;If the Term/Code already exists skip it.
 . I $D(^PXD(811.2,IEN,20,"B",TC)) Q
 . S IND=IND+1
 . S IENS="+"_IND_","_IEN_","
 . S FDA(811.23,IENS,.01)=TC
 I '$D(FDA(811.23)) Q SUCCESS
 D UPDATE^DIE("","FDA","","MSG")
 I $D(MSG) D
 . D FULL^VALM1
 . D MES^XPDUTL("Unable to store Term/Code "_TC)
 . D AWRITE^PXRMUTIL("MSG") H 1
 . S SUCCESS=0
 Q SUCCESS
 ;
 ;==========================================
UPDCL(IEN,TEXT) ;Add an entry to the change log.
 N IENS,FDA,FDAIEN,MSG,WPTMP
 S IENS="+1,"_IEN_","
 S FDA(811.21,IENS,.01)=$$NOW^XLFDT
 S FDA(811.21,IENS,1)=DUZ
 S WPTMP(1,1,1)=" Import codes "_TEXT_"."
 S FDA(811.21,IENS,2)="WPTMP(1,1)"
 D UPDATE^DIE("S","FDA","FDAIEN","MSG")
 K DA,DDSFILE
 S DA=FDAIEN(1),DA(1)=IEN
 S DDSFILE=811.2,DDSFILE(1)=811.21
 S DR="[PXRM TAXONOMY CHANGE LOG]"
 D ^DDS
 Q
 ;
