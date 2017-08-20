PXRMVSTX ;SLC/PKR - Routines for building taxonomies for value sets. ;09/16/2014
 ;;2.0;CLINICAL REMINDERS;**47**;Feb 04, 2005;Build 289
 ;==========================================
BLDCODEL(VSIEN,TAXIEN) ;Populate the code list.
 N CODE,CSYSIEN,IND,JND,LEXSAB,SAVEOK,TC
 K ^TMP("PXRMCODES",$J)
 S IND=0
 F  S IND=+$O(^PXRM(802.2,VSIEN,2,IND)) Q:IND=0  D
 . S CSYSIEN=^PXRM(802.2,VSIEN,2,IND,0)
 . S LEXSAB=$P(^PXRM(802.1,CSYSIEN,0),U,4)
 .;DBIA #5679
 . S TC=$P($$CSYS^LEXU(LEXSAB),U,4)_" codes from value set (imported)"
 . S JND=0
 . F  S JND=+$O(^PXRM(802.2,VSIEN,2,IND,1,JND)) Q:JND=0  D
 .. S CODE=^PXRM(802.2,VSIEN,2,IND,1,JND,0)
 .. I $$CHKCODE(LEXSAB,CODE)=-1 Q
 .. S ^TMP("PXRMCODES",$J,TC,LEXSAB,CODE)=""
 ;Format is: ^TMP("PXRMCODES",$J,TC,CODESYS,CODE)=UID
 S SAVEOK=$$SAVETC^PXRMTXIM(TAXIEN)
 I 'SAVEOK W !,"Could not save terms."
 I SAVEOK D POSTSAVE^PXRMTXSM(TAXIEN)
 Q
 ;
 ;==========================================
BLDTAX(VSIEN) ;Build a taxonony from a value set.
 N DESC,ERRMSG,NAME,OID,TXDATA,VSNAME
 I '$$SCSYS(VSIEN) H 2 Q
 ;Get the name of the taxonomy to create.
 S NAME=$$GETNAME(VSIEN)
 I (NAME="^")!(NAME="") Q
 S OID=$P(^PXRM(802.2,VSIEN,1),U,1)
 S VDATE=$P(^PXRM(802.2,VSIEN,1),U,3)
 S DESC(1,0)="This taxonomy was automatically generated from the value set:"
 S DESC(2,0)=" "_$P(^PXRM(802.2,VSIEN,0),U,1)
 S DESC(3,0)=" OID - "_OID
 S DESC(4,0)=" Version Date - "_$$FMTE^XLFDT(VDATE)
 S TXDATA("NAME")=NAME
 S TXDATA("CLASS")="L"
 M TXDATA("DESC")=DESC
 S TXDATA("OID")=OID
 S TXDATA("VERSION DATE")=VDATE
 S TAXIEN=$$CRETAX^PXRMTXIM("E",.TXDATA,.ERRMSG)
 I TAXIEN=0 H 2 Q
 W !,"Created taxonomy ",NAME
 W !,"Populating the code list ..."
 ;Populate the code list.
 D BLDCODEL(VSIEN,TAXIEN)
 ;Initialize the Change Log.
 D INICLOG(TAXIEN,.DESC)
 H 2
 Q
 ;
 ;==========================================
CHKCODE(LEXSAB,CODE) ;Verify that a code is in the Lexicon.
 N CDATA,PDATA,RESULT
 ;DBIA #5679
 S RESULT=$$CSDATA^LEXU(CODE,LEXSAB,DT,.CDATA)
 S RESULT=$$PERIOD^LEXU(CODE,LEXSAB,.PDATA)
 I +RESULT=-1 D
 . W !,"Lexicon does not recognize the ",LEXSAB," code: ",CODE
 . W !,"It will not be added to the taxonomy."
 Q +RESULT
 ;
 ;==========================================
CMPALL(OUTTYPE) ;Find all taxonomies generated from a value set and compare
 ;the codes in the taxonomy with those in the most recent version of
 ;the value set.
 N NL,OUTPUT,TAXIEN,VSOID
 S NL=0
 S VSOID=""
 F  S VSOID=$O(^PXD(811.2,"VSOID",VSOID)) Q:VSOID=""  D
 . S TAXIEN=""
 . F  S TAXIEN=$O(^PXD(811.2,"VSOID",VSOID,TAXIEN)) Q:TAXIEN=""  D
 .. D CMPTXVS(TAXIEN,VSOID,.NL,.OUTPUT)
 I OUTTYPE="B" D BROWSE^DDBR("OUTPUT","NR","Taxonomy Value Set Code Comparison")
 I OUTTYPE="M" D
 . N IND,SUBJECT,TO
 . S SUBJECT="VALUE SETS WERE UPDATED"
 . S TO(DUZ)=""
 . K ^TMP("PXRMXMZ",$J)
 .;MailMan has a built-in width of 79.
 . F IND=1:1:NL S ^TMP("PXRMXMZ",$J,IND,0)=$E(OUTPUT(IND),1,79)
 . D SEND^PXRMMSG("PXRMXMZ",SUBJECT,.TO,DUZ)
 . K ^TMP("PXRMXMZ",$J)
 Q
 ;
 ;==========================================
CMPTXVS(TAXIEN,VSOID,NL,OUTPUT) ;For taxonomies that were generated from a
 ;value set compare the codes in the most recent version of the
 ;value set to the codes in the taxonomy.
 I $P($G(^PXD(811.2,TAXIEN,40)),U,1)'=VSOID Q
 N CODE,CODESYS,TAXNAME,TAXVDATE,UID,VDATE,VSIEN,VSNAME
 S VSIEN=$O(^PXRM(802.2,"OID",VSOID,""),-1)
 S VSNAME=$P(^PXRM(802.2,VSIEN,0),U,1)
 S VDATE=$P(^PXRM(802.2,VSIEN,1),U,3)
 S TAXNAME=$P(^PXD(811.2,TAXIEN,0),U,1)
 S TAXVDATE=$P(^PXD(811.2,TAXIEN,40),U,2)
 S NL=NL+1,OUTPUT(NL)=""
 S NL=NL+1,OUTPUT(NL)="Checking taxonomy "_TAXNAME
 S NL=NL+1,OUTPUT(NL)=" It was generated from the value set:"
 S NL=NL+1,OUTPUT(NL)="  "_VSNAME
 S NL=NL+1,OUTPUT(NL)="  OID - "_VSOID
 S NL=NL+1,OUTPUT(NL)=" The most recent version of the value set is dated "_$$FMTE^XLFDT(VDATE)_"."
 S NL=NL+1,OUTPUT(NL)=" The taxonomy was generated from the version dated "_$$FMTE^XLFDT(TAXVDATE)_"."
 I TAXVDATE'=VDATE S NL=NL+1,OUTPUT(NL)=" The comparison is being made with the most recent version of the value set."
 ;Build a list of codes in the value set in the same structure as the
 ;"AE" index in the taxonomy. ^TMP($J,"VSCODES")
 D GVSCODES(VSIEN,"VSCODES")
 K ^TMP($J,"TAXCODES")
 M ^TMP($J,"TAXCODES")=^PXD(811.2,TAXIEN,20,"AE")
 ;Compare the two lists of codes, keep the differences.
 S CODESYS=""
 F  S CODESYS=$O(^TMP($J,"TAXCODES",CODESYS)) Q:CODESYS=""  D
 . S CODE=""
 . F  S CODE=$O(^TMP($J,"TAXCODES",CODESYS,CODE)) Q:CODE=""  D
 .. I $D(^TMP($J,"VSCODES",CODESYS,CODE)) K ^TMP($J,"VSCODES",CODESYS,CODE),^TMP($J,"TAXCODES",CODESYS,CODE)
 ;
 ;Create the result output.
 I $D(^TMP($J,"TAXCODES")) D
 . S NL=NL+1,OUTPUT(NL)=""
 . S NL=NL+1,OUTPUT(NL)="The following codes are in the taxonomy but not in the value set:"
 . S CODESYS=""
 . F  S CODESYS=$O(^TMP($J,"TAXCODES",CODESYS)) Q:CODESYS=""  D
 .. S NL=NL+1,OUTPUT(NL)="Coding system "_$P($$CSYS^LEXU(CODESYS),U,4)
 .. S NL=NL+1,OUTPUT(NL)="Code                INACT UID Description"
 .. S NL=NL+1,OUTPUT(NL)="------------------  ----- --- -----------"
 .. S CODE=""
 .. F  S CODE=$O(^TMP($J,"TAXCODES",CODESYS,CODE)) Q:CODE=""  D
 ... S UID=$S($D(^PXD(811.2,TAXIEN,20,"AUID",CODESYS,CODE)):1,1:0)
 ... D CDETAILC^PXRMTXIN(CODESYS,CODE,UID,.NL,.OUTPUT)
 I $D(^TMP($J,"VSCODES")) D
 . S NL=NL+1,OUTPUT(NL)=""
 . S NL=NL+1,OUTPUT(NL)="The following codes are in the value set but not in the taxonomy:"
 . S CODESYS=""
 . F  S CODESYS=$O(^TMP($J,"VSCODES",CODESYS)) Q:CODESYS=""  D
 .. S NL=NL+1,OUTPUT(NL)="Coding system "_$P($$CSYS^LEXU(CODESYS),U,4)
 .. S NL=NL+1,OUTPUT(NL)="Code                INACT     Description"
 .. S NL=NL+1,OUTPUT(NL)="------------------  -----     -----------"
 .. S CODE=""
 .. F  S CODE=$O(^TMP($J,"VSCODES",CODESYS,CODE)) Q:CODE=""  D
 ... D CDETAILC^PXRMTXIN(CODESYS,CODE,"",.NL,.OUTPUT)
 I '$D(^TMP($J,"TAXCODES")),'$D(^TMP($J,"VSCODES")) D
 . S NL=NL+1,OUTPUT(NL)=""
 . S NL=NL+1,OUTPUT(NL)="The list of codes in the taxonomy is identical to the list of codes in the"
 . S NL=NL+1,OUTPUT(NL)="value set."
 S NL=NL+1,OUTPUT(NL)=""
 K ^TMP($J,"TAXCODES"),^TMP($J,"VSCODES")
 Q
 ;
 ;==========================================
GVSCODES(VSIEN,NODE) ;Get the codes in a value set.
 N CODE,CSYSIEN,IND,JND,LEXSAB
 K ^TMP($J,NODE)
 S IND=0
 F  S IND=+$O(^PXRM(802.2,VSIEN,2,IND)) Q:IND=0  D
 . S CSYSIEN=^PXRM(802.2,VSIEN,2,IND,0)
 . S LEXSAB=$P(^PXRM(802.1,CSYSIEN,0),U,4)
 . S JND=0
 . F  S JND=+$O(^PXRM(802.2,VSIEN,2,IND,1,JND)) Q:JND=0  D
 .. S CODE=^PXRM(802.2,VSIEN,2,IND,1,JND,0)
 .. S ^TMP($J,NODE,LEXSAB,CODE)=""
 Q
 ;
 ;==========================================
GETNAME(VSIEN) ;
 N DIR,FIELDLEN,NAME,TEXT,VSNAME,X,Y
 S VSNAME=$P(^PXRM(802.2,VSIEN,0),U,1)
 S VSNAME=$$UP^XLFSTR(VSNAME)
 S FIELDLEN=$$GET1^DID(811.2,.01,"","FIELD LENGTH")
 S DIR(0)="F"_U_"3:"_FIELDLEN_U_"K:(X?.N)!'(X'?1P.E) X"
 S DIR("A")="Please enter the taxonomy name"
 I $L(VSNAME)'>FIELDLEN S DIR("B")=VSNAME
GETNAM W ! D ^DIR
 S NAME=Y
 ;Make sure the new name is valid.
 I $D(^PXD(811.2,"B",NAME)) D  G GETNAM
 . S TEXT(1)="A taxonomy named "_NAME_" already exists!"
 . S TEXT(2)="Please choose a unique name."
 . D EN^DDIOL(.TEXT)
 I '$$VNAME^PXRMINTR(NAME) G GETNAM
 Q NAME
 ;
 ;==========================================
INICLOG(IEN,TEXT) ;Initialize the change log.
 N IENS,FDA,FDAIEN,MSG
 S IENS="+1,"_IEN_","
 S FDA(811.21,IENS,.01)=$$NOW^XLFDT
 S FDA(811.21,IENS,1)=DUZ
 S FDA(811.21,IENS,2)="TEXT"
 D UPDATE^DIE("S","FDA","FDAIEN","MSG")
 Q
 ;
 ;==========================================
SCSYS(VSIEN) ;Scan the coding systems in the value set to determine if it 
 ;contains any supported coding systems.
 N CSYSIEN,LEXSAB,OK,NCSYS,TEMP
 W !,"Scanning the coding systems used in the value set ..."
 S NCSYS=+$P(^PXRM(802.2,VSIEN,2,0),U,3)
 I NCSYS=0 D  Q 0
 . W !,"No coding systems were found, cannot create a taxonomy."
 . H 2
 S IND=0,OK=0
 F  S IND=+$O(^PXRM(802.2,VSIEN,2,IND)) Q:IND=0  D
 . S CSYSIEN=^PXRM(802.2,VSIEN,2,IND,0)
 . S TEMP=^PXRM(802.1,CSYSIEN,0)
 . S LEXSAB=$P(TEMP,U,4)
 . I LEXSAB="" W !," ",$P(TEMP,U,1)," is not a supported coding system." Q
 . I $$VCSYS^PXRMTAXD(LEXSAB) S OK=1 W !," Will import ",$P(TEMP,U,1)," codes into the taxonomy."
 I 'OK W !,"No supported coding systems were found, cannot create a taxonomy." H 2
 Q OK
 ;
