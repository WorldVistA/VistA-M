PXRMTXCR ;SLC/PKR - Taxonomies, copy from a range. ;04/01/2015
 ;;2.0;CLINICAL REMINDERS;**26,47**;Feb 04, 2005;Build 289
 ;==========================================
CBDES(IEN,NODE) ;Copy the Brief Description to the description.
 I '$D(^TMP($J,NODE,"BDES")) Q
 S ^PXD(811.2,IEN,1,0)="^^1^1^"_DT_"^^"
 S ^PXD(811.2,IEN,1,1,0)=^TMP($J,NODE,"BDES")
 Q
 ;
 ;==========================================
CFRANGE(IEN,NODE) ;Copy from a range of codes to the Lexicon based structure.
 N CODE,CODEIEN,CODESYS,CSYS,CSYSIND,FDA,IENS,IND,HIGH,LOW,MSG
 N NCODES,NUID,TEMP,TERM,TERMIND,UID
 N PXRMCFR S PXRMCFR=1
 K ^TMP("PXRMCFR",$J)
 F CODESYS="ICD","ICP","CPT" D
 . S LOW=""
 . F  S LOW=$O(^TMP($J,NODE,CODESYS,LOW)) Q:LOW=""  D
 .. S HIGH=""
 .. F  S HIGH=$O(^TMP($J,NODE,CODESYS,LOW,HIGH)) Q:HIGH=""  D
 ... S TERM="Copy from "_CODESYS_" range "_LOW_" to "_HIGH
 ...;Check for existing entries for this term and remove them before
 ...;storing the new set.
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
 ;Build the 30 node.
 K PXRMCFR
 D BLD30N^PXRMTAXD(IEN)
 Q
 ;
 ;==========================================
EXCH(IEN,NODE) ;This entry point is used by Reminder Exchange to populate
 ;the Selected Codes multiple for taxonomies that were packed before
 ;the Selected Codes multiple existed.
 ;^TMP($J,NODE) is built in TAX^PXRMEXU0
 I '$D(^TMP($J,NODE)) Q
 D CBDES(IEN,NODE)
 D CFRANGE(IEN,NODE)
 K ^TMP($J,NODE)
 Q
 ;
