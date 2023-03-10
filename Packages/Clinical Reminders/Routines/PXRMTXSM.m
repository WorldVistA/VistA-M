PXRMTXSM ;SLC/PKR - Reminder Taxonomy ScreenMan routines ;06/14/2022
 ;;2.0;CLINICAL REMINDERS;**26,47,42,65**;Feb 04, 2005;Build 438
 ;
 ;===============
CODELIST(TAXIEN) ;See if the temporary list of selected codes exists,
 ;if it does not and codes have been stored in the taxonomy
 ;then build it.
 I $D(^TMP("PXRMCODES",$J)) Q
 I '$D(^PXD(811.2,TAXIEN,20,"ATCC")) Q
 M ^TMP("PXRMCODES",$J)=^PXD(811.2,TAXIEN,20,"ATC")
 M ^TMP("PXRMCODES",$J)=^PXD(811.2,TAXIEN,20,"ATCC")
 Q
 ;
 ;===============
EXETCCAP(DA) ;Executable caption for code search.
 N TC
 S TC=$$GET^DDSVAL(811.23,.DA,.01,"","E")
 I $L(TC)>57 S TC=$E(TC,1,54)_"..."
 Q " Term/Code: "_TC_" "
 ;
 ;===============
FDATAVAL(IEN) ;Form Data Validation.
 ;If either MINIMUM VALUE or MAXIMUM VALUE is defined, they both must be.
 N MAX,MAXDEC,MIN,PROMPT,TEXT,UCUM,UDISPLAY
 S MIN=$$GET^DDSVAL(811.2,IEN,220)
 S MAX=$$GET^DDSVAL(811.2,IEN,221)
 S MAXDEC=$$GET^DDSVAL(811.2,IEN,222)
 S UCUM=$$GET^DDSVAL(811.2,IEN,223)
 S PROMPT=$$GET^DDSVAL(811.2,IEN,224)
 S UDISPLAY=$$GET^DDSVAL(811.2,IEN,225)
 I (MIN=""),(MAX=""),(MAXDEC=""),(UCUM=""),(PROMPT=""),(UDISPLAY="") G SPONCLASS
 ;If any of the measurement fields are defined they all must be.
 I (MIN="")!(MAX="")!(MAXDEC="")!(UCUM="")!(PROMPT="")!(UDISPLAY="") D  Q
 . S TEXT="If any of the measurement fields are defined, they all must be."
 . D HLP^DDSUTL(.TEXT)
 . S DDSBR="MINIMUM VALUE",DDSERROR=1
 I MAX<MIN D  Q
 . S TEXT="The Maximum Value cannot be less than the Minimum Value."
 . D HLP^DDSUTL(.TEXT)
 . S DDSBR="MAXIMUM VALUE",DDSERROR=1
SPONCLASS ;Make sure the Class of the Sponsor matches that of the Taxonomy.
 N CLASS,ERROR,NAME,SCLASS,SIEN
 S CLASS=$$GET^DDSVAL(811.2,IEN,100,.ERROR,"I")
 S SIEN=$$GET^DDSVAL(811.2,IEN,101,.ERROR,"I")
 S SCLASS=$S(SIEN="":"",1:$$GET1^DIQ(811.6,SIEN,100,"I"))
 I (SCLASS'=""),(SCLASS'=CLASS) D
 . S TEXT="Sponsor Class is "_SCLASS_", Taxonomy Class is "_CLASS_" they must match!"
 . D HLP^DDSUTL(.TEXT)
 . S DDSBR="CLASS",DDSERROR=1
 ;If the Name starts with VA- make sure the Class is National.
 S NAME=$$GET^DDSVAL(811.2,IEN,.01,.ERROR,"I")
 I $E(NAME,1,3)="VA-",CLASS'="N" D
 . S TEXT="Name starts with 'VA-', but the Class is not National."
 . D HLP^DDSUTL(.TEXT)
 . S DDSBR="NAME",DDSERROR=1
 Q
 ;
 ;===============
LEXSRCH(DA,CODESYS) ;Branch for Lexicon Term/Code search.
 ;selection.
 N PXRMLEXV,SAVEDDS,TAXIEN,TERM
 ;These PXRM variables are used in the List Manager Lexicon search.
 N PXRMBGS,PXRMLEXV
 K ^TMP("PXRMLEXTC",$J)
 S ^TMP("PXRMLEXTC",$J,"CODESYS")=CODESYS
 S (^TMP("PXRMLEXTC",$J,"LEX TERM"),TERM)=$$GET^DDSVAL(811.23,.DA,.01,"","E")
 S (^TMP("PXRMLEXTC",$J,"TAX IEN"),TAXIEN)=DA(1)
 ;DBIA #5746 covers kill and set of DDS.
 I $D(DDS) S SAVEDDS=DDS K DDS
 D EN^VALM("PXRM LEXICON SELECT")
 K ^TMP("PXRMLEXTC",$J)
 ;Reset the screen so ScreenMan displays properly.
 I $D(SAVEDDS) D
 . N IOAWM0,X
 . S DDS=SAVEDDS
 . S X=0 X ^%ZOSF("RM"),^%ZOSF("TYPE-AHEAD")
 . S X="IOAWM0" D ENDR^%ZISS W IOAWM0
 . D REFRESH^DDSUTL
 Q
 ;
 ;===============
LTCPAOC(DA) ;Lexicon Term/Code post-action on change.
 N NTC,OTC,TEXT
 S NTC=$$GET^DDSVAL(811.23,.DA,"TERM/CODE")
 S OTC=$G(^PXD(811.2,DA(1),20,DA,0))
 I ($L(OTC)>0),(NTC'=OTC) D
 . S TEXT(1)="Overwriting a search Term/Code is not allowed!"
 . S TEXT(2)="To replace a search term delete the existing one first."
 . S TEXT(3)="$$EOP"
 . D HLP^DDSUTL(.TEXT)
 . D PUT^DDSVAL(811.23,.DA,"TERM/CODE",OTC)
 Q
 ;
 ;===============
NUMCODES(DA) ;Executable caption to display the number of selected codes
 ;for Lexicon Term/Code.
 ;^TMP("PXRMCODES",$J) will have the value from the current editing
 ;session so check it first.
 I DA="" Q $$REPEAT^XLFSTR(" ",30)
 N TERM
 S TERM=$$GET^DDSVAL(811.23,.DA,.01,"","E")
 I TERM="" Q $$REPEAT^XLFSTR(" ",30)
 N CODESYS,COUNT,ERROR,IND,NUID,NUM,TEMP,TEXT,UID
 S CODESYS=""
 F  S CODESYS=$O(^TMP("PXRMCODES",$J,TERM,CODESYS)) Q:CODESYS=""  D
 . S CODE="",(NUID,NUM)=0
 . F  S CODE=$O(^TMP("PXRMCODES",$J,TERM,CODESYS,CODE)) Q:CODE=""  D
 .. S NUM=NUM+1
 .. S UID=^TMP("PXRMCODES",$J,TERM,CODESYS,CODE)
 .. I UID=1 S NUID=NUID+1
 . S COUNT(CODESYS)=NUM
 . S NUID(CODESYS)=NUID
 ;If nothing was found for this term in ^TMP("PXRMCODES"), check for
 ;stored values.
 S IND=0
 F  S IND=+$O(^PXD(811.2,DA(1),20,DA,1,IND)) Q:IND=0  D
 . S TEMP=^PXD(811.2,DA(1),20,DA,1,IND,0)
 . S CODESYS=$P(TEMP,U,1),NUM=$P(TEMP,U,2),NUID=$P(TEMP,U,3)
 .;If COUNT is already defined for this CODESYS don't get the stored
 .;values.
 . I $D(COUNT(CODESYS))!(NUM=0) Q
 . S COUNT(CODESYS)=NUM
 . S NUID(CODESYS)=NUID
 I '$D(COUNT) Q "None"_$$REPEAT^XLFSTR(" ",26)
 S (CODESYS,TEXT)=""
 F  S CODESYS=$O(COUNT(CODESYS)) Q:CODESYS=""  D
 . S TEXT=TEXT_CODESYS_":"_COUNT(CODESYS)
 . I NUID(CODESYS)>0 S TEXT=TEXT_":"_NUID(CODESYS)
 . S TEXT=TEXT_" "
 S NUM=$L(TEXT)
 I NUM<30 S TEXT=TEXT_$$REPEAT^XLFSTR(" ",(30-NUM))
 Q TEXT
 ;
 ;===============
POSTACT(D0) ;Form Post Action
 ;DX and DY should not be newed or killed, control by ScreenMan
 N INACTIVE,INUSE,OUTPUT
 K ^TMP("PXRMCODES",$J)
 ;If the change was a deletion there is nothing else to do.
 I '$D(^PXD(811.2,D0)) Q
 ;If the taxonomy was inactivated check to see if it is being used.
 S INACTIVE=$$GET^DDSVAL(811.2,D0,"INACTIVE FLAG")
 S INUSE=$S(INACTIVE:$$INUSE^PXRMTAXD(D0,"INACT"),1:0)
 I INUSE D HLP^DDSUTL("$$EOP")
 ;Check for dialog problems.
 D TAXEDITC^PXRMDTAX(D0,.OUTPUT)
 I $D(OUTPUT) D
 . D BROWSE^DDBR("OUTPUT","NR","Problems with dialogs using this taxonomy.")
 . I $D(DDS) D REFRESH^DDSUTL S DY=IOSL-7,DX=0 X IOXY S $Y=DY,$X=DX
 Q
 ;
 ;===============
POSTSAVE(IEN) ;Form Post Save. Store changes in lists of codes.
 N CODE,CODESYS,CSYSIND,DELTERM,FDA,KCSYSIND,KFDA,MSG,NSEL,NUID,PDS
 N TEMP,TERM,TERMIND,TEXT,UID
 S TERM="",TERMIND=0
 F  S TERM=$O(^TMP("PXRMCODES",$J,TERM)) Q:TERM=""  D
 .;If this term has been deleted, skip the rest.
 . I '$D(^PXD(811.2,IEN,20,"B",TERM)) Q
 . S TERMIND=$O(^PXD(811.2,IEN,20,"B",TERM,""))
 . S DELTERM=$G(^TMP("PXRMCODES",$J,TERM))
 . I DELTERM="@" D  Q
 .. S IENS=TERMIND_","_IEN_","
 .. S KFDA(811.23,IENS,.01)="@"
 .. D FILE^DIE("","KFDA","MSG")
 . S CODESYS="",CSYSIND=TERMIND
 . F  S CODESYS=$O(^TMP("PXRMCODES",$J,TERM,CODESYS)) Q:CODESYS=""  D
 ..;Check for existing entries for this term and this coding system.
 ..;If there are any remove them before storing the new set.
 .. I $D(^PXD(811.2,IEN,20,"ATC",TERM,CODESYS)) D
 ... S KCSYSIND=$P(^PXD(811.2,IEN,20,"ATC",TERM,CODESYS),U,2)
 ... S IENS=KCSYSIND_","_TERMIND_","_IEN_","
 ... S KFDA(811.231,IENS,.01)="@"
 ... D FILE^DIE("","KFDA","MSG")
 .. S CSYSIND=CSYSIND+1
 .. S (NSEL,NUID)=0,CODE=""
 .. F  S CODE=$O(^TMP("PXRMCODES",$J,TERM,CODESYS,CODE)) Q:CODE=""  D
 ... S NSEL=NSEL+1
 ... S UID=^TMP("PXRMCODES",$J,TERM,CODESYS,CODE)
 ... I UID=1 S NUID=NUID+1
 ... S IENS="+"_(NSEL+CSYSIND)_",+"_CSYSIND_","_TERMIND_","_IEN_","
 ... S FDA(811.2312,IENS,.01)=CODE
 ... S FDA(811.2312,IENS,1)=UID
 .. I NSEL>0 D
 ... S IENS="+"_CSYSIND_","_TERMIND_","_IEN_","
 ... S FDA(811.231,IENS,.01)=CODESYS
 ... S FDA(811.231,IENS,1)=NSEL
 ... S FDA(811.231,IENS,3)=NUID
 ... S CSYSIND=NSEL+CSYSIND
 . I $D(FDA) D UPDATE^DIE("","FDA","","MSG")
 . I $D(MSG) D
 .. S TEXT(1)="Error storing codes for term "_TERM
 .. S TEXT(2)=" coding system "_CODESYS
 .. D EN^DDIOL(.TEXT)
 .. D AWRITE^PXRMUTIL("MSG")
 .. H 2
 K ^TMP("PXRMCODES",$J)
 ;Reset the 811.23 0 node so holes are not left.
 I $D(^PXD(811.2,IEN,20)) S $P(^PXD(811.2,IEN,20,0),U,3)=0
 ;Make sure Patient Data Source index is built.
 S PDS=$$GET^DDSVAL(811.2,IEN,"PATIENT DATA SOURCE")
 I PDS="" D SPDS^PXRMPDS(IEN,PDS)
 Q
 ;
 ;===============
SMANEDIT(IEN,NEW,FORM) ;ScreenMan edit for entry IEN.
 N CLASS,DA,DDSCHANG,DDSFILE,DDSPARM,DDSSAVE,DEL,DIDEL,DIMSG,DR,DTOUT
 N HASH256,OCLOG,NATOK,SHASH256
 S (DDSFILE,DIDEL)=811.2,DDSPARM="CS",DR="["_FORM_"]"
 S CLASS=$P(^PXD(811.2,IEN,100),U,1)
 S NATOK=$S(CLASS'="N":1,1:($G(PXRMINST)=1)&($G(DUZ(0))="@"))
 I 'NATOK D  Q
 . W !,"National taxonomies cannot be edited."
 . H 2
 . S VALMBCK="R"
 S NEW=$G(NEW)
 ;These ^TMP entries are used by the Lexicon display to store the 
 ;results of the search and selection. Initializing them here minimizes
 ;the number of Lexicon searches.
 K ^TMP("PXRMCODES",$J),^TMP("PXRMLEXS",$J),^TMP("PXRMTEXT",$J)
 ;Initialize the code list.
 D CODELIST(IEN)
 S SHASH256=$$FILE^XLFSHAN(256,811.2,IEN)
 S DA=IEN
 D ^DDS
 K ^TMP("PXRMCODES",$J),^TMP("PXRMLEXS",$J),^TMP("PXRMTEXT",$J)
 I $D(DIMSG) H 2
 ;If the entry is new and the user did not save, delete it.
 I NEW,$G(DDSSAVE)'=1 D DELETE^PXRMEXFI(811.2,IEN) Q
 ;If changes were made update the change log and rebuild the
 ;List Manager list. However, if the change was a deletion skip
 ;the change log.
 S DEL=$S($D(^PXD(811.2,IEN)):0,1:1)
 I DEL&(FORM="PXRM TAXONOMY EDIT") D  Q
 . D BLDLIST^PXRMTAXL("PXRMTAXL")
 . S VALMBCK="R"
 I NEW S OCLOG=1
 E  S HASH256=$$FILE^XLFSHAN(256,811.2,IEN),OCLOG=$S(HASH256=SHASH256:0,1:1)
 I 'OCLOG S VALMBCK="R" Q
 ;Open the Change Log
 N IENS,FDA,FDAIEN,MSG,WPTMP
 S IENS="+1,"_IEN_","
 S FDA(811.21,IENS,.01)=$$NOW^XLFDT
 S FDA(811.21,IENS,1)=DUZ
 I NEW D
 . S WPTMP(1,1,1)=" Creation."
 . S FDA(811.21,IENS,2)="WPTMP(1,1)"
 D UPDATE^DIE("S","FDA","FDAIEN","MSG")
 K DA,DDSFILE
 S DA=FDAIEN(1),DA(1)=IEN
 S DDSFILE=811.2,DDSFILE(1)=811.21
 S DR="[PXRM TAXONOMY CHANGE LOG]"
 D ^DDS
 I (FORM="PXRM TAXONOMY EDIT") D BLDLIST^PXRMTAXL("PXRMTAXL") S VALMBCK="R"
 Q
 ;
 ;===============
VEALLSEL(DA) ;Branch for View/edit all selected codes.
 ;selection.
 N PXRMLEXV,SAVEDDS
 K ^TMP("PXRMTAX",$J)
 S ^TMP("PXRMTAX",$J,"TAXIEN")=DA
 ;DBIA #5746 covers kill and set of DDS.
 I $D(DDS) S SAVEDDS=DDS K DDS
 D EN^VALM("PXRM TAXONOMY ALL SELECTED")
 K ^TMP("PXRMTAX",$J)
 ;Reset the screen so ScreenMan displays properly.
 I $D(SAVEDDS) D
 . N IOAWM0,X
 . S DDS=SAVEDDS
 . S X=0 X ^%ZOSF("RM"),^%ZOSF("TYPE-AHEAD")
 . S X="IOAWM0" D ENDR^%ZISS W IOAWM0
 . D REFRESH^DDSUTL
 Q
 ;
