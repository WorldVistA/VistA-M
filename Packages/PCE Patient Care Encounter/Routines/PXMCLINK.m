PXMCLINK ;SLC/PKR - Mapped codes linking routines. ;03/08/2016
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**211**;Aug 12, 1996;Build 84
 ;
 ;==========================================
CODEPTR(CODESYS,CODE) ;Return the code pointer for CPC, CPT, and ICD codes.
 ;ICRs #1995, #3990
 I CODESYS="10D" Q $P($$CODEN^ICDCODE(CODE),"~",1)
 I CODESYS="CPC" Q $$CODEN^ICPTCOD(CODE)
 I CODESYS="CPT" Q $$CODEN^ICPTCOD(CODE)
 I CODESYS="ICD" Q $P($$CODEN^ICDCODE(CODE),"~",1)
 Q -1
 ;
 ;==========================================
CSCLIST(GBL,IEN,CODESYSL) ;Populate the coding system code list.
 N CODE,COESYS,IND,TEMP
 K CODESYSL
 S IND=0
 F  S IND=+$O(@GBL@(IEN,210,IND)) Q:IND=0  D
 . S TEMP=@GBL@(IEN,210,IND,0)
 .;Skip if there already is a Date Linked.
 . I $P(TEMP,U,4)'="" Q
 . S CODESYS=$P(TEMP,U,1),CODE=$P(TEMP,U,2)
 . I CODE'="" S CODESYSL(CODESYS,CODE)=IND
 Q
 ;
 ;==========================================
LINK(FILENUM,GBL,IEN,CODESYSL) ;Create entries in V CPT, V POV or
 ;V Standard Codes files for legacy data that has been mapped to
 ;standard codes and link them through the Mapped Source field.
 N CODE,CODEP,CODESYS,DAS,DATE,DFN,ERROR,FDA,IENS,IND,MSG
 N SRCVFILE,VFCSYS,VISITIEN
 ;
 K ^TMP("PXXMZ",$J)
 S SRCVFILE=$$SRCVFILE(FILENUM)
 I '$D(^PXRMINDX(SRCVFILE,"IP",IEN)) Q
 S IENS="+1,"
 S CODESYS="",NL=2
 F  S CODESYS=$O(CODESYSL(CODESYS)) Q:CODESYS=""  D
 . K FDA
 . S VFCSYS=$$VFCSYS(CODESYS)
 . S FDA(VFCSYS,IENS,300)=FILENUM_";"_IEN
 . I VFCSYS=9000010.71 S FDA(VFCSYS,IENS,.05)=CODESYS
 . S CODE=""
 . F  S CODE=$O(CODESYSL(CODESYS,CODE)) Q:CODE=""  D
 .. S NL=NL+1,^TMP("PXXMZ",$J,NL,0)=" "_CODESYS_"  "_CODE
 .. I VFCSYS=9000010.71 S FDA(9000010.71,IENS,.01)=CODE
 .. E  D  Q:CODEP=-1
 ... S CODEP=$$CODEPTR(CODESYS,CODE)
 ... I CODEP'=-1 S FDA(VFCSYS,IENS,.01)=CODEP
 .. S DFN=""
 .. F  S DFN=$O(^PXRMINDX(SRCVFILE,"IP",IEN,DFN)) Q:DFN=""  D
 ... S ERROR=0
 ... S FDA(VFCSYS,IENS,.02)=DFN
 ... S DATE=""
 ... F  S DATE=$O(^PXRMINDX(SRCVFILE,"IP",IEN,DFN,DATE)) Q:DATE=""  D
 .... S DAS=""
 .... F  S DAS=$O(^PXRMINDX(SRCVFILE,"IP",IEN,DFN,DATE,DAS)) Q:DAS=""  D
 ..... S VISITIEN=$$GET1^DIQ(SRCVFILE,DAS,.03,"I")
 ..... S FDA(VFCSYS,IENS,.03)=VISITIEN
 ..... K MSG
 ..... D UPDATE^DIE("S","FDA","","MSG")
 ..... I $D(MSG) D  Q
 ...... S ERROR=1
 ...... S SUBJECT="Mapped code linking failed for file #"_SRCVFILE_", IEN="_IEN_", DFN="_DFN
 ...... D SENDEMSG(SRCVFILE,IEN,SUBJECT,.MSG)
 .....;Linking complete, set the Date Linked.
 ..... S IND=CODESYSL(CODESYS,CODE)
 ..... S $P(@GBL@(IEN,210,IND,0),U,4)=$$NOW^XLFDT
 I ERROR Q
 N ENAME,GNAME,SUBJECT,FROM,TO
 D SETTF(.TO,.FROM)
 S GNAME=$$GET1^DID(FILENUM,"","","NAME")
 S ENAME=$P($G(@GBL@(IEN,0)),U,1)
 S SUBJECT=GNAME_" entry "_ENAME_" has been linked."
 S ^TMP("PXXMZ",$J,1,0)="Linking completed at "_$$FMTE^XLFDT($$NOW^XLFDT,"5Z")
 S ^TMP("PXXMZ",$J,2,0)="The following codes were linked:"
 D SEND^PXRMMSG("PXXMZ",SUBJECT,.TO,FROM)
 K ^TMP("PXXMZ",$J)
 Q
 ;
 ;==========================================
LINKALL ;Link all national exams, education topics, and health factors
 ;that have been mapped.
 N CLASS,IEN,FILENUM,GBL,GNAME,NL,NMAPPED,TEXT
 K ^TMP("PXXMZ",$J)
 S NL=1
 F FILENUM=9999999.09,9999999.15,9999999.64 D
 . S GBL=$$GET1^DID(FILENUM,"","","GLOBAL NAME")
 . S GBL=$P(GBL,"(",1)
 . S GNAME=$$GET1^DID(FILENUM,"","","NAME")
 . S NL=NL+1,^TMP("PXXMZ",$J,NL,0)=""
 . S NL=NL+1,^TMP("PXXMZ",$J,NL,0)="Linking national "_GNAME_" that have been mapped."
 . S IEN=0
 . F  S IEN=+$O(@GBL@(IEN)) Q:IEN=0  D
 .. S NMAPPED=+$P($G(@GBL@(IEN,210,0)),U,4)
 .. I NMAPPED=0 Q
 .. S CLASS=$P(@GBL@(IEN,100),U,1)
 .. I CLASS'="N" Q
 .. S NL=NL+1,^TMP("PXXMZ",$J,NL,0)=" Linking "_GNAME_": "_$P(@GBL@(IEN,0),U,1)
 .. D CSCLIST^PXMCLINK(GBL,IEN,.CODESYSL)
 .. I '$D(CODESYSL) Q
 .. D LINK^PXMCLINK(FILENUM,GBL,IEN,CODESYSL,0)
 D SEND^PXRMMSG("PXXMZ","LINKING NATIONAL PCE ENTRIES",DUZ,"PCE")
 K ^TMP("PXXMZ",$J)
 Q
 ;
 ;==========================================
MCLINK(FILENUM,IEN) ;Check for codes that have been mapped but not linked.
 ;It there are any, ask the user if they want to link them.
 N CODE,CODESYS,CODESYSL,DDS,DIR,DIR0,ENAME,GBL,GNAME,NL,NMAPPED
 N STARTDT,TEMP,TEXT,VFILENUM,X,Y
 S GBL=$$GET1^DID(FILENUM,"","","GLOBAL NAME")
 S GBL=$P(GBL,"(",1)
 S NMAPPED=+$P($G(@GBL@(IEN,210,0)),U,4)
 I NMAPPED=0 Q
 S GNAME=$$GET1^DID(FILENUM,"","","NAME")
 S ENAME=$P($G(@GBL@(IEN,0)),U,1)
 D CSCLIST^PXMCLINK(GBL,IEN,.CODESYSL)
 I '$D(CODESYSL) Q
 S TEXT(1)="The following codes have been mapped but not linked to existing"
 S TEXT(2)=ENAME_" "_GNAME_" patient data:"
 S CODESYS="",NL=2
 F  S CODESYS=$O(CODESYSL(CODESYS)) Q:CODESYS=""  D
 . S CODE=""
 . F  S CODE=$O(CODESYSL(CODESYS,CODE)) Q:CODE=""  D
 .. S NL=NL+1,TEXT(NL)=" "_CODESYS_"  "_CODE
 S NL=NL+1,TEXT(NL)=""
 D EN^DDIOL(.TEXT)
 S VFILENUM=$$SRCVFILE(FILENUM)
 I '$D(^PXRMINDX(VFILENUM,"IP",IEN)) D  Q
 . K TEXT
 . S TEXT(1)=""
 . S TEXT(2)="No patients have been given the "_GNAME_": "_ENAME
 . S TEXT(3)="there is no data to link."
 . D EN^DDIOL(.TEXT) H 2
 K DIR
 S DIR(0)="YAO",DIR("B")="Y"
 S DIR("A")="Do you want to link them? "
 D ^DIR
 I 'Y Q
 K DIR
 S DIR(0)="DAO^NOW::ERX"
 S DIR("A")="When do you want the linking job to start? "
 S DIR("B")="NOW"
 D ^DIR
 I (Y="^")!(Y="") Q
 S STARTDT=Y
 D TASKLINK(FILENUM,GBL,IEN,.CODESYSL,STARTDT)
 ;D LINK(FILENUM,GBL,IEN,.CODESYSL)
 Q
 ;
 ;==========================================
MCUNLINK(FILENUM,IEN) ;Start a task to unlink mapped codes.
 N DA,DDS,DIR,DIR0,GBL,IENS,STARTDT,NL,TEMP,TEXT,X,Y,UNLINK
 I '$D(^TMP($J,"UNLINK")) Q
 M UNLINK=^TMP($J,"UNLINK")
 K ^TMP($J,"UNLINK")
 S GBL=$$GET1^DID(FILENUM,"","","GLOBAL NAME")
 S GBL=$P(GBL,"(",1)
 S TEXT(1)="The following codes have been selected for unlinking:"
 S IENS="",NL=1
 F  S IENS=$O(UNLINK(FILENUM,IENS)) Q:IENS=""  D
 . D DA^DILF(IENS,.DA)
 . S TEMP=@GBL@(DA(1),210,DA,0)
 . S CODESYS=$P(TEMP,U,1)
 . S CODE=$P(TEMP,U,2)
 . S NL=NL+1,TEXT(NL)=" "_CODESYS_"  "_CODE
 D EN^DDIOL(.TEXT)
 K DIR
 S DIR(0)="DAO^NOW::ERX"
 S DIR("A")="When do you want the unlinking job to start? "
 S DIR("B")="NOW"
 D ^DIR
 I (Y="^")!(Y="") Q
 S STARTDT=Y
 D TASKUNLK(FILENUM,IEN,.UNLINK,STARTDT)
 ;D UNLINK^PXMCLINK(FILENUM,IEN,.UNLINK)
 Q
 ;
 ;==========================================
SENDEMSG(VFILENUM,IEN,SUBJECT,MSG) ;
 N DIERR,EMSG,FROM,NL,TO
 D SETTF(.TO,.FROM)
 K ^TMP("PXEMSG",$J)
 S NL=1,^TMP("PXEMSG",$J,NL,0)=SUBJECT
 S NL=NL+1,^TMP("PXEMSG",$J,NL,0)="The following error message was returned by FileMan:"
 D ACOPY^PXRMUTIL("MSG","EMSG()")
 S IND=0 F  S IND=$O(EMSG(IND)) Q:IND=""  S NL=NL+1,^TMP("PXEMSG",$J,NL,0)=EMSG(IND)
 D SEND^PXRMMSG("PXEMSG",SUBJECT,.TO,FROM)
 K ^TMP("PXEMSG",$J)
 Q
 ;
 ;==========================================
SETTF(TO,FROM) ;Set the TO and FROM for delivering the MailMan messages.
 N MGIEN,MGROUP
 S FROM=$$GET1^DIQ(200,DUZ,.01)
 S MGIEN=$P($G(^PX(815,1,650)),U,1)
 S TO(DUZ)=""
 I MGIEN'="" D
 . S MGROUP="G."_$$GET1^DIQ(3.8,MGIEN,.01)
 . S TO(MGROUP)=""
 Q
 ;
 ;==========================================
SRCVFILE(FILENUM) ;Given a file number return the associated V file
 ;number.
 Q $S(FILENUM=9999999.09:9000010.16,FILENUM=9999999.15:9000010.13,FILENUM=9999999.64:9000010.23,1:"")
 ;
 ;==========================================
TASKLINK(FILENUM,GBL,IEN,CODESYSL,STARTDT) ;Start a task to link
 ;mapped codes.
 K ZTSAVE
 S ZTSAVE("FILENUM")=""
 S ZTSAVE("GBL")=""
 S ZTSAVE("IEN")=""
 S ZTSAVE("CODESYSL(")=""
 S ZTRTN="TSKLINK^PXMCLINK"
 S ZTDESC="Link mapped codes for "_GBL_" IEN="_IEN
 S ZTDTH=STARTDT
 S ZTIO=""
 D ^%ZTLOAD
 I ZTSK'="" D EN^DDIOL("Task number "_ZTSK_" queued.")
 Q
 ;
 ;==========================================
TASKUNLK(FILENUM,IEN,UNLINK,STARTDT) ;Start a task to unlink mapped codes.
 K ZSTAVE
 S ZTSAVE("IEN")=""
 S ZTSAVE("FILENUM")=""
 S ZTSAVE("UNLINK(")=""
 S ZTRTN="TSKUNLK^PXMCLINK"
 S ZTDESC="Unlink mapped codes for "_GBL_" IEN="_IEN
 S ZTDTH=STARTDT
 S ZTIO=""
 D ^%ZTLOAD
 I ZTSK'="" D EN^DDIOL("Task number "_ZTSK_" queued.")
 Q
 ;
 ;==========================================
TSKLINK ;Arguments come through ZTSAVE.
 D LINK^PXMCLINK(FILENUM,GBL,IEN,.CODESYSL)
 Q
 ;
 ;==========================================
TSKUNLK ;Arguments come through ZTSAVE.
 D UNLINK^PXMCLINK(FILENUM,IEN,.UNLINK)
 Q
 ;
 ;==========================================
UNLINK(FILENUM,IEN,UNLINK) ;Check for codes that should be unlinked.
 N CODE,CODEP,CODESYS,DA,ENAME,ERROR,FROM,GBL,GNAME,IENS,KFDA,MSG,NL
 N SOURCE,SRCVFILE,SUBJECT,TEMP,TO,VFCSYS,VFIEN
 S SRCVFILE=$$SRCVFILE(FILENUM)
 S SOURCE=FILENUM_";"_IEN
 S GBL=$$GET1^DID(FILENUM,"","","GLOBAL NAME")
 S GBL=$P(GBL,"(",1)
 S GNAME=$$GET1^DID(FILENUM,"","","NAME")
 S ENAME=$P($G(@GBL@(IEN,0)),U,1)
 S SUBJECT=GNAME_" entry "_ENAME_" has been unlinked."
 S ^TMP("PXXMZ",$J,1,0)=SUBJECT
 S ^TMP("PXXMZ",$J,2,0)="The following codes were unlinked:"
 S NL=2
 S ERROR=0,IENS=""
 F  S IENS=$O(UNLINK(FILENUM,IENS)) Q:IENS=""  D
 . D DA^DILF(IENS,.DA)
 . S TEMP=@GBL@(DA(1),210,DA,0)
 . S CODESYS=$P(TEMP,U,1)
 . S CODE=$P(TEMP,U,2)
 . S VFCSYS=$$VFCSYS(CODESYS)
 . S NL=NL+1,^TMP("PXXMZ",$J,NL,0)=" "_CODESYS_" "_CODE
 . K ^TMP($J,"LIST")
 . I VFCSYS=9000010.07 D
 .. S CODEP=$$CODEPTR(CODESYS,CODE)
 .. M ^TMP($J,"LIST")=^AUPNVPOV("SC",SOURCE,CODEP)
 . I VFCSYS=9000010.18 D
 .. S CODEP=$$CODEPTR(CODESYS,CODE)
 .. M ^TMP($J,"LIST")=^AUPNVCPT("SC",SOURCE,CODEP)
 . I VFCSYS=9000010.71 M ^TMP($J,"LIST")=^AUPNVSC("SCC",SOURCE,CODESYS,CODE)
 . S VFIEN=""
 . F  S VFIEN=$O(^TMP($J,"LIST",VFIEN)) Q:VFIEN=""  D
 .. K KFDA,MSG
 .. S KFDA(VFCSYS,VFIEN_",",.01)="@"
 .. D FILE^DIE("","KFDA","MSG")
 .. I $D(MSG) D  Q
 ... S ERROR=1
 ... S SUBJECT="Mapped code unlinking failed for file #"_SRCVFILE_", IEN="_IEN_", VFIEN="_VFIEN
 ... D SENDEMSG(SRCVFILE,IEN,SUBJECT,.MSG)
 . I 'ERROR S $P(@GBL@(DA(1),210,DA,0),U,4)=""
 I 'ERROR D 
 . D SETTF(.TO,.FROM)
 . D SEND^PXRMMSG("PXXMZ",SUBJECT,.TO,"PCE MANAGEMENT")
 K ^TMP($J,"LIST"),^TMP("PXXMZ",$J)
 Q
 ;
 ;==========================================
VFCSYS(CODESYS) ;Given a coding system return the associated V file number.
 Q $S(CODESYS="CPC":9000010.18,CODESYS="CPT":9000010.18,CODESYS="ICD":9000010.07,CODESYS="10D":9000010.07,1:9000010.71)
 ;
