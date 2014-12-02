PXRMTXCR ;SLC/PKR - Taxonomies, copy from a range. ;05/07/2014
 ;;2.0;CLINICAL REMINDERS;**26**;Feb 04, 2005;Build 404
 ;==========================================
BLDCFR(IEN,NODE) ;Build the range, selectable diagnosis, and selectable
 ;procedure lists.
 N CODE,CODEIEN,CODESYS,HIGH,IND,LOW,TNODE,TEMP
 K ^TMP($J,NODE)
 F CODESYS="ICD","ICP","CPT" D
 . S TNODE=$S(CODESYS="ICD":80,CODESYS="ICP":80.1,CODESYS="CPT":81)
 . S IND=0
 . F  S IND=+$O(^PXD(811.2,IEN,TNODE,IND)) Q:IND=0  D
 .. S TEMP=^PXD(811.2,IEN,TNODE,IND,0)
 .. S LOW=$P(TEMP,U,1),HIGH=$P(TEMP,U,2)
 .. I HIGH="" S HIGH=LOW
 .. S ^TMP($J,NODE,CODESYS,LOW,HIGH)=""
 ;
 S IND=0
 F  S IND=+$O(^PXD(811.2,IEN,"SDX",IND)) Q:IND=0  D
 . S CODEIEN=$P(^PXD(811.2,IEN,"SDX",IND,0),U,1)
 .;DBIA #5747
 . S TEMP=$$ICDDX^ICDEX(CODEIEN,DT,"ICD","I")
 . S CODE=$P(TEMP,U,2)
 . S ^TMP($J,NODE,"SDX",CODE)=TEMP
 S IND=0
 F  S IND=+$O(^PXD(811.2,IEN,"SPR",IND)) Q:IND=0  D
 . S CODEIEN=$P(^PXD(811.2,IEN,"SPR",IND,0),U,1)
 .;DBIA #1995-A
 . S TEMP=$$CPT^ICPTCOD(CODEIEN)
 . S CODE=$P(TEMP,U,2)
 . S ^TMP($J,NODE,"SPR",CODE)=TEMP
 Q
 ;
 ;==========================================
CFR(IEN) ;Combine building selectable lists and copy from range.
 D BLDCFR(IEN,"CFR")
 D CFRANGE(IEN,"CFR")
 Q
 ;
 ;==========================================
CFRANGE(IEN,NODE) ;Copy from a range of codes to the Lexicon based structure.
 N CODE,CODEIEN,CODESYS,CSYS,CSYSIND,FDA,IENS,IND,HIGH,LOW,MSG
 N NCODES,NUID,TEMP,TERM,TERMIND,UID
 K ^TMP("PXRMCFR",$J)
 F CODESYS="ICD","ICP","CPT" D
 . S LOW=""
 . F  S LOW=$O(^TMP($J,NODE,CODESYS,LOW)) Q:LOW=""  D
 .. S HIGH=""
 .. F  S HIGH=$O(^TMP($J,NODE,CODESYS,LOW,HIGH)) Q:HIGH=""  D
 ... S TERM="Copy from "_CODESYS_" range "_LOW_" to "_HIGH
 ...;Check for existing entries for this term and remove them before
 ...; storing the new set.
 ... I $D(^PXD(811.2,IEN,20,"B",TERM)) D
 .... S TERMIND=$O(^PXD(811.2,IEN,20,"B",TERM,""))
 .... S IENS=TERMIND_","_IEN_","
 .... S FDA(811.23,IENS,.01)="@"
 .... D FILE^DIE("","FDA","MSG")
 ... S CODE=LOW
 ... F  Q:(CODE]HIGH)!(CODE="")  D
 ....;DBIA #1997, #3991
 .... S TEMP=$S(CODESYS="CPT":$$STATCHK^ICPTAPIU(CODE,""),1:$$STATCHK^ICDAPIU(CODE,""))
 .... S CODEIEN=$P(TEMP,U,2)
 .... I CODEIEN=-1 D  Q
 ..... D MES^XPDUTL(" Warning - "_CODESYS_" code "_CODE_" is not valid.")
 ..... S CODE=$S(CODESYS="CPT":$$NEXT^ICPTAPIU(CODE),1:$$NEXT^ICDAPIU(CODE))
 .... S UID=0
 ....;Mark as Use in Dialog if the code is marked as selectable.
 .... I CODESYS="ICD",$D(^TMP($J,NODE,"SDX",CODE)) S UID=1
 .... I CODESYS="CPT",$D(^TMP($J,NODE,"SPR",CODE)) S UID=1
 .... S ^TMP("PXRMCFR",$J,TERM,CODESYS,CODE)=UID
 .... S ^TMP($J,NODE,"STORED",CODESYS,CODE)=""
 .... S CODE=$S(CODESYS="CPT":$$NEXT^ICPTAPIU(CODE),1:$$NEXT^ICDAPIU(CODE))
 ;
 ;Get selectable codes that are not in a range.
 S TERM="Copy from selectable diagnosis"
 ;Check for existing entries for this term and remove them before
 ;storing the new set.
 I $D(^PXD(811.2,IEN,20,"B",TERM)) D
 . S TERMIND=$O(^PXD(811.2,IEN,20,"B",TERM,""))
 . S IENS=TERMIND_","_IEN_","
 . S FDA(811.23,IENS,.01)="@"
 . D FILE^DIE("","FDA","MSG")
 S CODE=""
 F  S CODE=$O(^TMP($J,NODE,"SDX",CODE)) Q:CODE=""  D
 .;Don't store codes that have already been stored.
 . I $D(^TMP($J,NODE,"STORED","ICD",CODE)) Q
 . S TEMP=^TMP($J,NODE,"SDX",CODE)
 . I $P(TEMP,U,1)=-1 D  Q
 .. D MES^XPDUTL(" Warning - selectable code "_CODE_" is not valid.")
 . S ^TMP("PXRMCFR",$J,TERM,"ICD",CODE)=1
 ;
 S TERM="Copy from selectable procedure"
 ;Check for existing entries for this term and remove them before
 ;storing the new set.
 I $D(^PXD(811.2,IEN,20,"B",TERM)) D
 . S TERMIND=$O(^PXD(811.2,IEN,20,"B",TERM,""))
 . S IENS=TERMIND_","_IEN_","
 . S FDA(811.23,IENS,.01)="@"
 . D FILE^DIE("","FDA","MSG")
 S CODE=""
 F  S CODE=$O(^TMP($J,NODE,"SPR",CODE)) Q:CODE=""  D
 .;Don't store codes that have already been stored.
 . I $D(^TMP($J,NODE,"STORED","CPT",CODE)) Q
 . S TEMP=^TMP($J,NODE,"SPR",CODE)
 . I $P(TEMP,U,1)=-1 D  Q
 .. D MES^XPDUTL(" Warning - selectable procedure "_CODE_" is not valid.")
 . S ^TMP("PXRMCFR",$J,TERM,"CPT",CODE)=1
 ;
 ;The pointer based system did not differentiate between CPC and CPT
 ;codes, do that here.
 S TERM=""
 F  S TERM=$O(^TMP("PXRMCFR",$J,TERM)) Q:TERM=""  D
 . I '$D(^TMP("PXRMCFR",$J,TERM,"CPT")) Q
 . S CODE=""
 . F  S CODE=$O(^TMP("PXRMCFR",$J,TERM,"CPT",CODE)) Q:CODE=""  D
 ..;DBIA #1995
 .. S CSYS=$P($$CPT^ICPTCOD(CODE),U,5)
 .. I CSYS="C" Q
 .. S ^TMP("PXRMCFR",$J,TERM,"CPC",CODE)=^TMP("PXRMCFR",$J,TERM,"CPT",CODE)
 ;Remove extraneous CPT codes.
 S TERM=""
 F  S TERM=$O(^TMP("PXRMCFR",$J,TERM)) Q:TERM=""  D
 . I '$D(^TMP("PXRMCFR",$J,TERM,"CPC")) Q
 . S CODE=""
 . F  S CODE=$O(^TMP("PXRMCFR",$J,TERM,"CPC",CODE)) Q:CODE=""  D
 .. K ^TMP("PXRMCFR",$J,TERM,"CPT",CODE)
 K ^TMP($J,NODE)
 ;
 ;Build the FDA and file it for each range.
 S TERM="",TERMIND=0
 F  S TERM=$O(^TMP("PXRMCFR",$J,TERM)) Q:TERM=""  D
 . K FDA,MSG
 . S TERMIND=TERMIND+1
 . S IENS="+"_TERMIND_","_IEN_","
 . S FDA(811.23,IENS,.01)=TERM
 . S CODESYS="",CSYSIND=TERMIND
 . F  S CODESYS=$O(^TMP("PXRMCFR",$J,TERM,CODESYS)) Q:CODESYS=""  D
 .. S CSYSIND=CSYSIND+1
 .. S CODE="",(NCODES,NUID)=0
 .. F  S CODE=$O(^TMP("PXRMCFR",$J,TERM,CODESYS,CODE)) Q:CODE=""  D
 ... S NCODES=NCODES+1
 ... S IENS="+"_(NCODES+CSYSIND)_",+"_CSYSIND_",+"_TERMIND_","_IEN_","
 ... S UID=^TMP("PXRMCFR",$J,TERM,CODESYS,CODE)
 ... I UID=1 S NUID=NUID+1
 ... S FDA(811.2312,IENS,.01)=CODE
 ... S FDA(811.2312,IENS,1)=UID
 .. S IENS="+"_CSYSIND_",+"_TERMIND_","_IEN_","
 .. S FDA(811.231,IENS,.01)=CODESYS
 .. S FDA(811.231,IENS,1)=NCODES
 .. S FDA(811.231,IENS,3)=NUID
 . D UPDATE^DIE("","FDA","","MSG")
 K ^TMP("PXRMCFR",$J)
 D CNTCHK(IEN)
 Q
 ;
 ;==========================================
CNTCHK(IEN) ;Compare the number of codes stored under the old pointer
 ;structure with the number in the new structure.
 N CODE,CODEIEN,NCPC,NCPT,NICD,NICD0,NICD9,NICP,NICPT,TEMP,TERM,TEXT
 K ^TMP($J,"CPT"),^TMP($J,"ICD"),^TMP($J,"ICP")
 ;Rebuild the expansion to make sure it is current.
 D EXPAND^PXRMBXTL(IEN,"")
 S TEMP=$G(^PXD(811.3,IEN,0))
 S NICD0=+$P(TEMP,U,3),NICD9=+$P(TEMP,U,5),NICPT=+$P(TEMP,U,7)
 S (NCPC,NCPT,NICD,NICP)=0
 I NICD0>0 D
 . S TERM=""
 . F  S TERM=$O(^PXD(811.2,IEN,20,"ATCC",TERM)) Q:TERM=""  D
 .. I $E(TERM,1,13)'="Copy from ICP" Q
 .. S CODE=""
 .. F  S CODE=$O(^PXD(811.2,IEN,20,"ATCC",TERM,"ICP",CODE)) Q:CODE=""  D
 ... S CODEIEN=^PXD(811.2,IEN,20,"AE","ICP",CODE)
 ... S ^TMP($J,"ICP",CODEIEN)=CODE
 .;Count the unqiue entries.
 . S CODEIEN=""
 . F  S CODEIEN=$O(^TMP($J,"ICP",CODEIEN)) Q:CODEIEN=""  S NICP=NICP+1
 I NICD9>0 D
 . S TERM=""
 . F  S TERM=$O(^PXD(811.2,IEN,20,"ATCC",TERM)) Q:TERM=""  D
 .. I $E(TERM,1,13)'="Copy from ICD" Q
 .. S CODE=""
 .. F  S CODE=$O(^PXD(811.2,IEN,20,"ATCC",TERM,"ICD",CODE)) Q:CODE=""  D
 ... S CODEIEN=^PXD(811.2,IEN,20,"AE","ICD",CODE)
 ... S ^TMP($J,"ICD",CODEIEN)=CODE
 .;Count the unqiue entries.
 . S CODEIEN=""
 . F  S CODEIEN=$O(^TMP($J,"ICD",CODEIEN)) Q:CODEIEN=""  S NICD=NICD+1
 I NICPT>0 D
 . S TERM=""
 . F  S TERM=$O(^PXD(811.2,IEN,20,"ATCC",TERM)) Q:TERM=""  D
 .. I $E(TERM,1,13)'="Copy from CPT" Q
 .. S CODE=""
 .. F  S CODE=$O(^PXD(811.2,IEN,20,"ATCC",TERM,"CPC",CODE)) Q:CODE=""  D
 ... S NCPC=NCPC+1
 ... S CODEIEN=^PXD(811.2,IEN,20,"AE","CPC",CODE)
 ... S ^TMP($J,"CPT",CODEIEN)=CODE
 .. S CODE=""
 .. F  S CODE=$O(^PXD(811.2,IEN,20,"ATCC",TERM,"CPT",CODE)) Q:CODE=""  D
 ... S CODEIEN=^PXD(811.2,IEN,20,"AE","CPT",CODE)
 ... S ^TMP($J,"CPT",CODEIEN)=CODE
 .;Count the unqiue entries.
 . S CODEIEN=""
 . F  S CODEIEN=$O(^TMP($J,"CPT",CODEIEN)) Q:CODEIEN=""  S NCPT=NCPT+1
 I (NICD0>0),(NICD0'=NICP) D
 . S TEXT(1)="Encountered a problem moving ICD-9 operation/procedure codes to the new structure."
 . S TEXT(2)=" For taxonomy "_$P(^PXD(811.2,IEN,0),U,1)_" ("_IEN_")."
 . S TEXT(3)=" Original number of codes: "_NICD0
 . S TEXT(4)=" Number of copied codes: "_NICP
 . D MES^XPDUTL(.TEXT)
 I (NICD9>0),(NICD9'=NICD) D
 . K TEXT
 . S TEXT(1)="Encountered a problem moving ICD-9 diagnosis codes to the new structure."
 . S TEXT(2)=" For taxonomy "_$P(^PXD(811.2,IEN,0),U,1)_" ("_IEN_")."
 . S TEXT(3)=" Original number of codes: "_NICD9
 . S TEXT(4)=" Number of copied codes: "_NICD
 . D MES^XPDUTL(.TEXT)
 I (NICPT>0),(NICPT'=NCPT) D
 . K TEXT
 . S TEXT(1)="Encountered a problem moving CPT codes to the new structure."
 . S TEXT(2)=" For taxonomy "_$P(^PXD(811.2,IEN,0),U,1)_" ("_IEN_")."
 . S TEXT(3)=" Original number of codes: "_NICPT
 . S TEXT(4)=" Number of copied codes: "_(NCPC+NCPT)
 . D MES^XPDUTL(.TEXT)
 K ^TMP($J,"CPT"),^TMP($J,"ICD"),^TMP($J,"ICP")
 Q
 ;
 ;==========================================
CPALL ;Do a range of codes copy for all taxonomies.
 N IEN,NAME
 D BMES^XPDUTL("Copying ranges of codes for all taxonomies.")
 S NAME=""
 F  S NAME=$O(^PXD(811.2,"B",NAME)) Q:NAME=""  D
 . S IEN=$O(^PXD(811.2,"B",NAME,""))
 . D MES^XPDUTL("Copy codes for taxonomy "_NAME_" (IEN="_IEN_")")
 . D CFR(IEN)
 K ^TMP($J,"PXRMDLG")
 Q
 ;
 ;==========================================
EXCH(IEN,NODE) ;This entry point is used by Reminder Exchange to populate
 ;the Selected Codes multiple for taxonomies that were packed before
 ;the Selected Codes multiple existed.
 ;^TMP($J,NODE) is built in TAX^PXRMEXU0
 I '$D(^TMP($J,NODE)) Q
 D CFRANGE(IEN,NODE)
 Q
 ;
