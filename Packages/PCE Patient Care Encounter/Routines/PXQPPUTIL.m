PXQPPUTIL ;SLS/PKR - Utility for primary provider repair. ;08/14/2020
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**211**;Aug 12, 1996;Build 454
 ;
 ;ICR #3125 covers references to ^RADPT, file #70.
 ;ICR #5605 covers references to ^RARPT, file #74.
 ;===============
ASKCONTINUE() ;Ask the user if they want to continue.
 N DIR,DIRUT,X,Y
 S DIR(0)="SABX^0:NO;1:YES"
 S DIR("A")="Continue checking encounters? "
 S DIR("B")="YES"
 D ^DIR
 I $D(DIRUT) Q 0
 Q Y
 ;
 ;===============
DISCLAIMER ;Display the disclaimer.
 W !,"=============== NOTE ==============="
 W !,"This utility searches for Lab and Radiology Encounters in the specified"
 W !,"date range. Those that do not have a primary provider will be processed."
 W !,"===================================="
 W !
 Q
 ;
 ;===============
DISPIMPTEXT(VISITIEN) ;
 N CASENUM,CPT,CPTLIST,DFN,IENS,IENT,IMPTEXT,IND,INVDT,JND,MSG,NL
 N RADCPT,REPORT,RESULT,TEXT,VCPTIEN,X
 ;Find the Radiology Examination(s) for this Visit.
 I '$D(^RADPT("AVSIT",VISITIEN)) D  Q
 . S ^TMP("PXQPPR",$J,"RAD","NO EXAM",VISITIEN)=""
 . W !,"No Radiology exam can be found for Visit IEN ",VISITIEN,"."
 . W !,"Therefore, no Impresion Text can be displayed."
 . H 2
 ;Build the list of CPT codes for this encounter.
 S VCPTIEN=""
 F  S VCPTIEN=$O(^AUPNVCPT("AD",VISITIEN,VCPTIEN)) Q:VCPTIEN=""  D
 . S CPT=$P(^AUPNVCPT(VCPTIEN,0),U,1)
 . S CPTLIST(CPT)=""
 S DFN=$P(^AUPNVSIT(VISITIEN,0),U,5)
 S INVDT=$O(^RADPT("AVSIT",VISITIEN,DFN,""))
 S IENT=INVDT_","_DFN_","
 S IND=""
 F  S IND=$O(^RADPT("AVSIT",VISITIEN,DFN,INVDT,IND)) Q:IND=""  D
 . S IENS=IND_","_IENT
 . S RADCPT(IND)=$$GET1^DIQ(70.03,IENS,"2:9","","","MSG")
 . I '$D(CPTLIST(RADCPT(IND))) Q
 . S REPORT(IND)=$$GET1^DIQ(70.03,IENS,17,"I","","MSG")
 I '$D(REPORT) D  Q
 . W !,"No Radiology Reports were found for this encounter, cannot display the Impression Text."
 . H 2
 S IND="",NL=0
 F  S IND=$O(REPORT(IND)) Q:IND=""  D
 . K IMPTEXT
 . S IENS=REPORT(IND)_","
 . S NL=NL+1,TEXT(NL)=" "
 . S CASENUM=$$GET1^DIQ(74,IENS,4,"","","MSG")
 . S NL=NL+1,TEXT(NL)="Case Number - "_CASENUM
 . S NL=NL+1,TEXT(NL)="CPT Code - "_RADCPT(IND)
 . S NL=NL+1,TEXT(NL)="Impression Text:"
 . S RESULT=$$GET1^DIQ(74,IENS,300,"","IMPTEXT","MSG")
 . I RESULT'="" D
 .. S JND=0
 .. F  S JND=$O(IMPTEXT(JND)) Q:JND=""  S NL=NL+1,TEXT(NL)=IMPTEXT(JND)
 S X="IORESET"
 D ENDR^%ZISS
 D BROWSE^DDBR("TEXT","NR","Radiology Report Impression Text")
 W IORESET
 D KILL^%ZISS
 Q
 ;
 ;===============
FINDEXAM(VISITIEN) ;Try to link the Visit to the Radiology Exam.
 N CPT,CPTLIST,DFN,FDA,HLOC,IENS,IENT,IMLOC,IND,INVDT,MSG,RADCPT
 N VCPTIEN,VISITDT,TEMP
 S TEMP=^AUPNVSIT(VISITIEN,0)
 S VISITDT=$P(TEMP,U,1)
 S DFN=$P(TEMP,U,5)
 ;ICR #65
 I '$D(^RADPT("AR",VISITDT,DFN)) Q
 S HLOC=$P(TEMP,U,22)
 S INVDT=9999999.9999-VISITDT
 S IENT=INVDT_","_DFN_","
 S IMLOC=$$GET1^DIQ(70.02,IENT,"4:.01","I","","MSG")
 I IMLOC'=HLOC Q
 ;Build the list of CPT codes for this encounter.
 S VCPTIEN=""
 F  S VCPTIEN=$O(^AUPNVCPT("AD",VISITIEN,VCPTIEN)) Q:VCPTIEN=""  D
 . S CPT=$P(^AUPNVCPT(VCPTIEN,0),U,1)
 . S CPTLIST(CPT)=""
 ;Look for a match on the CPT code.
 S IND=0
 F  S IND=+$O(^RADPT(DFN,"DT",INVDT,"P",IND)) Q:IND=0  D
 . S IENS=IND_","_IENT
 . S RADCPT=$$GET1^DIQ(70.03,IENS,"2:9","I","","MSG")
 . I RADCPT="" Q
 . I '$D(CPTLIST(RADCPT)) Q
 . K FDA
 .;ICR #7186
 . S FDA(70.03,IENS,27)=VISITIEN
 . D FILE^DIE("K","FDA","MSG")
 . I '$D(MSG) S ^TMP("PXQPPR",$J,"RAD","VISIT",VISITIEN)=IENS
 Q
 ;
 ;===============
GETDATE(DEFAULT,PROMPT,MINDATE) ;Ask the user for a date.
 N DIR,DIRUT,X,Y
 S DIR(0)="D::DT:AE"
 I $G(MINDATE)>0 S DIR(0)=DIR(0)_U_MINDATE
 S DIR("A")=PROMPT
 S DIR("B")=DEFAULT
 D ^DIR
 I $D(DIRUT) S Y="^"
 Q Y
 ;
 ;===============
OPENENCOUNTER(VISITIEN) ;Open the encounter in List Manger so the primary
 ;provider can be edited.
 N PXCEEXIT,PXCEKEYS,PXCEPKG,PXCESOR,PXCEVIEN,PXCEVIEW
 N SPE,TEMP
 S TEMP=$G(^AUPNVSIT(VISITIEN,812))
 S PXCEPKG=$P(TEMP,U,2),PXCESOR=$P(TEMP,U,3)
 S PXCEKEYS="SPCD"
 S PXCEVIEN=VISITIEN
 S PXCEVIEW="P^V^"
 D EN^PXCEAE
 Q
 ;
 ;===============
PPREPAIR ;Find and repair encounters that do not have a primary provider.
 N CONTINUE,DATASOURCE,ENDDATE,LABDS,LABPKG,NPRIM,NPROV
 N PACKAGE,PORS,PRIMARY,PROVIDER,PROVIDERLIST,RADPKG,RADDS,RADPROXY
 N SC,STARTDATE,TEMP,VISITIEN,VISITDT,VPRVIEN
 K ^TMP("PXQPPR",$J)
 ;ICR #10048
 S LABPKG=$$FIND1^DIC(9.4,"","B","LAB SERVICE")
 S LABDS=$$FIND1^DIC(839.7,"","B","LAB DATA")
 S RADPKG=$$FIND1^DIC(9.4,"","B","RADIOLOGY/NUCLEAR MEDICINE")
 S RADDS=$$FIND1^DIC(839.7,"","B","RAD/NUC MED")
 S RADPROXY=$$FIND1^DIC(200,"","B","RADIOLOGY,OUTSIDE SERVICE")
 S ^TMP("PXQPPR",$J,"REPSTART")=$$NOW^XLFDT
 D DISCLAIMER
 W !,"Set the date range for searching for encounters."
 S STARTDATE=$$GETDATE("","Input the starting date")
 I STARTDATE="^" Q
 S ENDDATE=$$GETDATE("T","Input the ending date: ",STARTDATE)
 I ENDDATE="^" Q
 S ENDDATE=ENDDATE+0.235959
 S ^TMP("PXQPPR",$J,"STARTDATE")=STARTDATE
 S ^TMP("PXQPPR",$J,"ENDDATE")=ENDDATE
 S VISITDT=STARTDATE
 S CONTINUE=1
 F  S VISITDT=$O(^AUPNVSIT("B",VISITDT)) Q:(CONTINUE=0)!(VISITDT>ENDDATE)!(VISITDT="")  D
 . S VISITIEN=0
 . F  S VISITIEN=$O(^AUPNVSIT("B",VISITDT,VISITIEN)) Q:VISITIEN=""  D
 .. S SC=$P(^AUPNVSIT(VISITIEN,0),U,7)
 ..;Historical encounters do not need to be checked.
 .. I SC="E" Q
 .. S NPRIM=0
 ..;Get the list of providers for this encounter.
 .. K PROVIDERLIST
 .. S (NPROV,VPRVIEN)=0
 .. F  S VPRVIEN=+$O(^AUPNVPRV("AD",VISITIEN,VPRVIEN)) Q:VPRVIEN=0  D
 ... S NPROV=NPROV+1
 ... S TEMP=^AUPNVPRV(VPRVIEN,0)
 ... S PROVIDER=$P(TEMP,U,1)
 ... S PORS=$P(TEMP,U,4)
 ... S PROVIDERLIST(PROVIDER)=VPRVIEN_U_PORS
 ... I PORS="P" S NPRIM=NPRIM+1,PRIMARY=PROVIDER
 .. S TEMP=$G(^AUPNVSIT(VISITIEN,812))
 .. S PACKAGE=$P(TEMP,U,2)
 .. S DATASOURCE=$P(TEMP,U,3)
 .. I (PACKAGE=LABPKG)!(DATASOURCE=LABDS) D
 ... D LAB(VISITIEN,.NPRIM,.PRIMARY,.PROVIDERLIST,.CONTINUE)
 .. I (PACKAGE=RADPKG)!(DATASOURCE=RADDS) D
 ... D RAD(VISITIEN,.NPRIM,.PRIMARY,.PROVIDERLIST,RADPROXY,.CONTINUE)
 ;Report what was done.
 D REPORT^PXQPPUTILR
 ;ICR #10052
 D KILL^XUSCLEAN
 K ^TMP("PXQPPR",$J)
 Q
 ;
 ;===============
LAB(VISITIEN,NPRIM,PRIMARY,PROVIDERLIST,CONTINUE) ;Handle Lab
 ;encounters that do not have a primary provider.
 I NPRIM=1 Q
 N ENCPROV,IENS,FDA,MSG,ORDPROV,NENCPROV,NORDPROV,RESULT,TEMP,VCPTIEN
 S (NENCPROV,NORDPROV)=0
 S VCPTIEN=""
 F  S VCPTIEN=$O(^AUPNVCPT("AD",VISITIEN,VCPTIEN)) Q:VCPTIEN=""  D
 . S TEMP=$G(^AUPNVCPT(VCPTIEN,12))
 . I TEMP="" Q
 . S ORDPROV=$P(TEMP,U,2)
 . S ENCPROV=$P(TEMP,U,4)
 . I (ORDPROV'=""),('$D(ORDPROVLIST(ORDPROV))) S ORDPROVLIST(ORDPROV)="",NORDPROV=NORDPROV+1
 . I (ENCPROV'=""),('$D(ENCPROVLIST(ENCPROV))) S ENCPROVLIST(ENCPROV)="",NENCPROV=NENCPROV+1
 ;If there is only one ordering provider make sure they are primary.
 I NORDPROV=1 D
 . S ORDPROV=$O(ORDPROVLIST(""))
 . S IENS=$P(PROVIDERLIST(ORDPROV),U,1)_","
 . S FDA(9000010.06,IENS,.04)="P"
 . D FILE^DIE("K","FDA","MSG")
 . S RESULT=$S($D(MSG):FAILED,1:"SUCCESS")
 . S ^TMP("PXQPPR",$J,"LAB","SETP",VISITIEN,ORDPROV)=RESULT
 ;If the number of ordering providers is not one open the encounter for
 ;editing.
 I NORDPROV'=1 D
 . D OPENENCOUNTER(VISITIEN)
 . S ^TMP("PXQPPR",$J,"LAB","OPEN",VISITIEN)=""
 ;Ask the user if they want to continue.
 S CONTINUE=$$ASKCONTINUE
 Q
 ;
 ;===============
RAD(VISITIEN,NPRIM,PRIMARY,PROVIDERLIST,RADPROXY,CONTINUE) ;Handle Radiology
 ;encounters that ;do not have a primary provider or the primary
 ;provider is the proxy.
 ;If there is no primary provider set one.
 I NPRIM=0 D RADPRIM(VISITIEN,.PROVIDERLIST,.PRIMARY)
 ;If there is no Radiology exam linked to this Visit try to link it.
 I '$D(^RADPT("AVSIT",VISITIEN)) D FINDEXAM(VISITIEN)
 ;If the Primary Provider is the proxy go to RADPROXYPP so the
 ;user can easily edit the Primary Provider.
 I PRIMARY=RADPROXY D RADPROXYPP(VISITIEN,.CONTINUE)
 Q
 ;
 ;===============
RADPRIM(VISITIEN,PROVIDERLIST,PRIMARY) ;Set a primary provider for
 ;Radiology encounters that do not have one.
 N ENCDT,ENCPROV,IENS,FDA,MSG,ORDPROV,PERSONCLASS,RESULT,VCPTIEN
 ;Find the Encounter Provider and Ordering Provider in V CPT.
 S VCPTIEN=$O(^AUPNVCPT("AD",VISITIEN,""))
 I VCPTIEN="" Q
 S ENCPROV=$P(^AUPNVCPT(VCPTIEN,12),U,4)
 S ORDPROV=$P(^AUPNVCPT(VCPTIEN,12),U,2)
 ;If there is an existing V Provider entry for the encounter provider
 ;make it primary. If not, create a new V Provider entry.
 I (ENCPROV'=""),$D(PROVIDERLIST(ENCPROV)) D
 . I $P(PROVIDERLIST(ENCPROV),U,2)="P" Q
 . S IENS=$P(PROVIDERLIST(ENCPROV),U,1)_","
 . S FDA(9000010.06,IENS,.04)="P"
 . D FILE^DIE("K","FDA","MSG")
 . S RESULT=$S($D(MSG):FAILED,1:"SUCCESS")
 . S ^TMP("PXQPPR",$J,"RAD","SETP",VISITIEN,ENCPROV)=RESULT
 .;Make Ordering Provider secondary.
 I (ORDPROV'=""),$D(PROVIDERLIST(ORDPROV)) D
 . I $P(PROVIDERLIST(ORDPROV),U,2)="S" Q
 . S IENS=$P(PROVIDERLIST(ORDPROV),U,1)_","
 . K FDA,MSG
 . S FDA(9000010.06,IENS,.04)="S"
 . D FILE^DIE("K","FDA","MSG")
 S ENCDT=$P($G(^AUPNVCPT(VCPTIEN,12)),U,1)
 I ENCDT="" S ENCDT=$P(^AUPNVSIT(VISITIEN,0),U,1)
 ;No V Provider entry found.
 I (ENCPROV'=""),'$D(PROVIDERLIST(ENCPROV)) D
 . K FDA,MSG
 .;Get the values for Patient, Visit, Event Date and Time, Comments,
 .;Package, and Data Source from the V CPT entry.
 . S FDA(9000010.06,"+1,",.01)=ENCPROV
 . S FDA(9000010.06,"+1,",.02)=$P(^AUPNVCPT(VCPTIEN,0),U,2)
 . S FDA(9000010.06,"+1,",.03)=$P(^AUPNVCPT(VCPTIEN,0),U,3)
 . S FDA(9000010.06,"+1,",.04)="P"
 . S PERSONCLASS=$P($$GET^XUA4A72(ENCPROV,ENCDT),U,1)
 . I +PERSONCLASS>0 S FDA(9000010.06,"+1,",.06)=PERSONCLASS
 . S FDA(9000010.06,"+1,",1201)=$P($G(^AUPNVCPT(VCPTIEN,12)),U,1)
 . S FDA(9000010.06,"+1,",81101)=$G(^AUPNVCPT(VCPTIEN,811))
 . S FDA(9000010.06,"+1,",81202)=$P($G(^AUPNVCPT(VCPTIEN,812)),U,2)
 . S FDA(9000010.06,"+1,",81203)=$P($G(^AUPNVCPT(VCPTIEN,812)),U,3)
 . D UPDATE^DIE("","FDA","","MSG")
 I (ORDPROV'=""),'$D(PROVIDERLIST(ORDPROV)) D
 . K FDA,MSG
 . S FDA(9000010.06,"+1,",.01)=ORDPROV
 . S FDA(9000010.06,"+1,",.02)=$P(^AUPNVCPT(VCPTIEN,0),U,2)
 . S FDA(9000010.06,"+1,",.03)=$P(^AUPNVCPT(VCPTIEN,0),U,3)
 . S FDA(9000010.06,"+1,",.04)="S"
 . S PERSONCLASS=$P($$GET^XUA4A72(ORDPROV,ENCDT),U,1)
 . I +PERSONCLASS>0 S FDA(9000010.06,"+1,",.06)=PERSONCLASS
 . S FDA(9000010.06,"+1,",1201)=$P($G(^AUPNVCPT(VCPTIEN,12)),U,1)
 . S FDA(9000010.06,"+1,",81101)=$G(^AUPNVCPT(VCPTIEN,811))
 . S FDA(9000010.06,"+1,",81202)=$P($G(^AUPNVCPT(VCPTIEN,812)),U,2)
 . S FDA(9000010.06,"+1,",81203)=$P($G(^AUPNVCPT(VCPTIEN,812)),U,3)
 . D UPDATE^DIE("","FDA","","MSG")
 S PRIMARY=ENCPROV
 Q
 ;
 ;===============
RADPROXYPP(VISITIEN,CONTINUE) ;Radiology encounter has the proxy as the primary
 ;provider.
 ;Display the Impression Text, it should contain the name and NPI
 ;of the teleradiology provider.
 D DISPIMPTEXT(VISITIEN)
 ;Open the Encounter for editing.
 D OPENENCOUNTER(VISITIEN)
 S ^TMP("PXQPPR",$J,"RAD","PROXY",VISITIEN)=""
 ;Ask the user if they want to continue.
 S CONTINUE=$$ASKCONTINUE
 Q
 ;
 ;===============
SETONEPRIME(PROVIDERLIST) ;There is only one provider for the encounter
 ;and it is not marked primary provider, make it primary.
 N FDA,IENS,MSG,PROVIDER,RESULT
 S PROVIDER=$O(PROVIDERLIST(""))
 S IENS=$P(PROVIDERLIST(PROVIDER),U,1)_","
 S FDA(9000010.06,IENS,.04)="P"
 D FILE^DIE("K","FDA","MSG")
 S RESULT=$S($D(MSG):"FAILED",1:"SUCCESS")
 S ^TMP("PXQPPR",$J,"SET1P",IENS,PROVIDER)=RESULT
 Q
 ;
