PXEDUSM ;SLC/PKR - Education Topics ScreenMan routines ;12/14/2017
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**211**;Aug 12, 1996;Build 244
 ;
 ;===================================
CODEPAOC(DA) ;Code Post-Action On Change.
 N CODE,CODESYS,NEWCODE,SAVEDDS
 S CODESYS=$$GET^DDSVAL(9999999.11,.DA,.01)
 S CODE=$$GET^DDSVAL(9999999.11,.DA,1)
 ;DBIA #5746 covers kill and set of DDS.
 I $D(DDS) S SAVEDDS=DDS K DDS
 ;Call the Lexicon search.
 S NEWCODE=$$GETCODE^PXLEXS(CODESYS,CODE,DT,0)
 ;Reset the screen so ScreenMan displays properly.
 I $D(SAVEDDS) D
 . N IOAWM0,X
 . S DDS=SAVEDDS
 . S X=0 X ^%ZOSF("RM"),^%ZOSF("TYPE-AHEAD")
 . S X="IOAWM0" D ENDR^%ZISS W IOAWM0
 . D REFRESH^DDSUTL
 D PUT^DDSVAL(9999999.11,.DA,1,NEWCODE)
 Q
 ;
 ;===================================
CODEPRE(DA) ;Code pre-action.
 N CODESYS,TEXT
 S CODESYS=$$GET^DDSVAL(9999999.11,.DA,.01)
 ;DBIA #5679
 S CODESYS=$P($$CSYS^LEXU(CODESYS),U,4)
 S TEXT(1)="Input a search term or a "_CODESYS_" code."
 D EN^DDIOL(.TEXT)
 Q
 ;
 ;===================================
DELPAOC(X,DA) ;Delete field post action on change.
 N IENS
 I X=1 S IENS=$$IENS^DILF(.DA),^TMP($J,"UNLINK",9999999.09,IENS)=""
 Q
 ;
 ;===================================
DELPRE ;Delete field pre-action.
 N TEXT
 S TEXT(1)="Enter 'Y' if you want to delete this code mapping."
 S TEXT(2)="Warning - a deletion will remove all mapped source entries created"
 S TEXT(3)="as a result of this code mapping."
 D EN^DDIOL(.TEXT)
 Q
 ;
 ;===================================
FDATAVAL(IEN) ;Form Data Validation.
 ;If either MINIMUM VALUE or MAXIMUM VALUE is defined, they both must be.
 N MAX,MIN,TEXT
 S MIN=$$GET^DDSVAL(9999999.09,IEN,220)
 S MAX=$$GET^DDSVAL(9999999.09,IEN,221)
 I (MIN=""),(MAX'="") D  Q
 . S TEXT(1)="The Maximum Value is "_MAX_", but the Minimum Value is undefined."
 . S TEXT(2)="Set a Minimum Value or delete the Maximum Value."
 . D HLP^DDSUTL(.TEXT)
 . S DDSBR="MINIMUM VALUE",DDSERROR=1
 I (MIN'=""),(MAX="") D  Q
 . S TEXT(1)="The Minimum Value is "_MIN_", but the Maximum Value is undefined."
 . S TEXT(2)="Set a Maximum Value or delete the Minimum Value."
 . D HLP^DDSUTL(.TEXT)
 . S DDSBR="MAXIMUM VALUE",DDSERROR=1
 I MAX<MIN D  Q
 . S TEXT(1)="The Maximum Value cannot be less than the Minimum Value."
 . D HLP^DDSUTL(.TEXT)
 . S DDSBR="MAXIMUM VALUE",DDSERROR=1
 Q
 ;
 ;===================================
FPOSTACT(IEN) ;Form Post-Action
 N INACTIVE,INUSE,OUTPUT
 ;If the change was a deletion there is nothing else to do.
 I '$D(^AUTTEDT(IEN)) Q
 ;If the exam was inactivated check to see if it is being used.
 ;Need a new FileMan API to do this.
 S INACTIVE=$$GET^DDSVAL(9999999.09,IEN,"INACTIVE FLAG")
 Q
 ;S INUSE=$S(INACTIVE:$$INUSE^PXRMTAXD(D0,"INACT"),1:0)
 ;I INUSE D HLP^DDSUTL("$$EOP")
 Q
 ;
 ;===================================
FPOSTSAV(IEN) ;Form Post-Save.
 ;Check for mapped codes to link.
 D MCLINK^PXMCLINK(9999999.09,IEN)
 ;Check for mappings to delete and unlink.
 I $D(^TMP($J,"UNLINK",9999999.09)) D MCUNLINK^PXMCLINK(9999999.09,IEN)
 Q
 ;
 ;===================================
FPREACT(DA) ;Form pre-action
 Q
 ;
 ;===================================
LINKED(DA) ;Date Linked executable caption. This is really the display
 ;for the Linked column, the field is uneditable.
 I DA="" Q " "
 N LINKDT
 S LINKDT=$$GET^DDSVAL(9999999.11,.DA,"DATE LINKED")
 Q $S(LINKDT'="":"Y",1:"N")
 ;
 ;===================================
MCBLKPRE(DA) ;Mapped codes block pre-action.
 ;Make any mapped codes uneditable.
 N IENS,IND
 S IEN=DA(1),IND=0
 F  S IND=+$O(^AUTTEDT(IEN,210,IND)) Q:IND=0  D
 . I $P(^AUTTEDT(IEN,210,IND,0),U,2)="" Q
 . S IENS=IND_","_IEN_","
 . D UNED^DDSUTL("CODING SYSTEM","PX EDU CODE MAPPINGS BLOCK",1,1,IENS)
 . D UNED^DDSUTL("CODE","PX EDU CODE MAPPINGS BLOCK",1,1,IENS)
 . D UNED^DDSUTL("DELETE","PX EDU CODE MAPPINGS BLOCK",1,0,IENS)
 Q
 ;
 ;===================================
SMANEDIT(IEN,NEW) ;ScreenMan edit for entry IEN.
 N CLASS,DA,DDSCHANG,DDSFILE,DDSPARM,DDSSAVE,DEL,DIDEL,DIMSG,DR,DTOUT
 N HASH256,OCLOG,NATOK,SHASH256
 S CLASS=$P(^AUTTEDT(IEN,100),U,1)
 S NATOK=$S(CLASS'="N":1,1:($G(PXNAT)=1)&($G(DUZ(0))="@"))
 I 'NATOK D  Q
 . W !,"National education topics cannot be edited."
 . H 2
 . S VALMBCK="R"
 S (DDSFILE,DIDEL)=9999999.09,DDSPARM="CS"
 S DR=$S($D(^XUSEC("PX CODE MAPPING",DUZ)):"[PX EDUCATION TOPIC EDIT]",1:"[PX EDUCATION TOPIC EDIT NCM]")
 S NEW=$G(NEW)
 S SHASH256=$$FILE^XLFSHAN(256,9999999.09,IEN)
 S DA=IEN
 D ^DDS
 I $D(DIMSG) H 2
 ;If the entry is new and the user did not save, delete it.
 I NEW,$G(DDSSAVE)'=1 D DELETE^PXRMEXFI(9999999.09,IEN) Q
 ;If changes were made update the change log. If the change was a
 ;deletion skip the change log.
 S DEL=$S($D(^AUTTEDT(IEN)):0,1:1)
 I DEL D  Q
 . D BLDLIST^PXEDUMGR("PXEDUL")
 . S VALMBCK="R"
 I NEW S OCLOG=1
 E  S HASH256=$$FILE^XLFSHAN(256,9999999.09,IEN),OCLOG=$S(HASH256=SHASH256:0,1:1)
 I 'OCLOG S VALMBCK="R" Q
 ;Open the Change Log
 N IENS,FDA,FDAIEN,MSG,WPTMP
 S IENS="+1,"_IEN_","
 S FDA(9999999.1,IENS,.01)=$$NOW^XLFDT
 S FDA(9999999.1,IENS,1)=DUZ
 I NEW D
 . S WPTMP(1,1,1)=" Creation."
 . S FDA(9999999.1,IENS,2)="WPTMP(1,1)"
 D UPDATE^DIE("S","FDA","FDAIEN","MSG")
 K DA,DDSFILE
 S DA=FDAIEN(1),DA(1)=IEN
 S DDSFILE=9999999.09,DDSFILE(1)=9999999.1
 S DR="[PX EDUCATION TOPIC CHANGE LOG]"
 D ^DDS
 D BLDLIST^PXEDUMGR("PXEDUL") S VALMBCK="R"
 Q
 ;
 ;===================================
STEXCAP(DA) ;Subtopics executable caption.
 N NSUBTOP,TEXT
 S NSUBTOP=+$P($G(^AUTTEDT(DA,10,0)),U,4)
 S TEXT="SUBTOPICS: "
 I NSUBTOP=0 S TEXT=TEXT_"None defined" Q TEXT
 I NSUBTOP=1 S TEXT=TEXT_"There is 1 subtopic" Q TEXT
 I NSUBTOP>1 S TEXT=TEXT_"There are "_NSUBTOP_" subtopics"
 Q TEXT
 ;
