PXMCLINK ;SLC/PKR - Mapped codes linking and unlinking routines. ;12/14/2017
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**211**;Aug 12, 1996;Build 244
 ;
 ;==========================================
ASSOVFILE(FILENUM) ;Given a PCE data type file number return the associated
 ;V file number.
 Q $S(FILENUM=9999999.09:9000010.16,FILENUM=9999999.15:9000010.13,FILENUM=9999999.64:9000010.23,1:"")
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
DELCHK(CODESYSL) ;When there are mappings that are being deleted,
 ;if they are also on the list to link remove them from the list to
 ;link.
 N CODE,CODESYS,DA,GBL,IENS,TEMP,UNLINK
 M UNLINK=^TMP($J,"UNLINK")
 S GBL=$$GET1^DID(FILENUM,"","","GLOBAL NAME")
 S GBL=$P(GBL,"(",1)
 S IENS=""
 F  S IENS=$O(UNLINK(FILENUM,IENS)) Q:IENS=""  D
 . D DA^DILF(IENS,.DA)
 . S TEMP=@GBL@(DA(1),210,DA,0)
 . S CODESYS=$P(TEMP,U,1)
 . S CODE=$P(TEMP,U,2)
 . K CODESYSL(CODESYS,CODE)
 Q
 ;
 ;==========================================
DELMC(FILENUM,CODESYS,CODE,IENS) ;Delete a mapped code.
 ;Before deletion save the mapped code in the Deleted Code Mappings
 ;multiple.
 N ADDIENS,CMSFN,DCMSFN,FDA,KFDA,IEN,MSG,SUBJECT
 S IEN=$P(IENS,",",2)
 S ADDIENS="+1,"_IEN_","
 S DCMSFN=+$$GET1^DID(FILENUM,"DELETED CODE MAPPINGS","","SPECIFIER")
 S FDA(DCMSFN,ADDIENS,.01)=CODESYS
 S FDA(DCMSFN,ADDIENS,1)=CODE
 S FDA(DCMSFN,ADDIENS,2)=$$NOW^XLFDT
 S FDA(DCMSFN,ADDIENS,3)=DUZ
 D UPDATE^DIE("","FDA","","MSG")
 I $D(DIERR) D  Q
 . N TEXT
 . S TEXT(1)="IENS="_IENS
 . S TEXT(2)="CODESYS="_CODESYS_", CODE="_CODE
 . S SUBJECT="Mapped code copy before deletion failed for file #"_FILENUM
 . D SENDEMSG(SUBJECT,.MSG,.TEXT)
 S CMSFN=+$$GET1^DID(FILENUM,"CODE MAPPINGS","","SPECIFIER")
 S KFDA(CMSFN,IENS,.01)="@"
 D FILE^DIE("","KFDA","MSG")
 I $D(DIERR) D  Q
 . N TEXT
 . S TEXT(1)="IENS="_IENS
 . S TEXT(2)="CODESYS="_CODESYS_", CODE="_CODE
 . S SUBJECT="Mapped code deletion failed for file #"_FILENUM
 . D SENDEMSG(SUBJECT,.MSG,.TEXT)
 Q
 ;
 ;==========================================
LINK(FILENUM,GBL,IEN,CODESYSL) ;Create entries in V Standard Codes file for
 ;legacy data that has been mapped to standard codes and link them
 ;through the Mapped Source field.
 ;FILENUM is the file number of the data type file.
 ;GBL is the corresponding global
 ;IEN is the internal entry number of the data type.
 ;CODESYSL is the list of mapped codes: (CODESYS,CODE)
 N ASSOVFILE,CODE,CODEDT,CODEIEN,CODESYS,DAS,DATE,DFN,ERROR,FDA,FDAIEN
 N FROM,IENS,IND,MSG,MSOURCE,NUMACT,NUMINACT,NL,SUBJECT,TO
 N VCODFNUM,VFDATA,VISITIEN
 K ^TMP("PXXMZ",$J)
 S ASSOVFILE=$$ASSOVFILE(FILENUM)
 I '$D(^PXRMINDX(ASSOVFILE,"IP",IEN)) Q
 S MSOURCE=FILENUM_";"_IEN
 S IENS="+1,"
 S CODESYS="",NL=2
 S VCODFNUM=9000010.71
 F  S CODESYS=$O(CODESYSL(CODESYS)) Q:CODESYS=""  D
 . K FDA
 . S FDA(VCODFNUM,IENS,300)=MSOURCE
 . S FDA(VCODFNUM,IENS,.05)=CODESYS
 . S CODE=""
 . F  S CODE=$O(CODESYSL(CODESYS,CODE)) Q:CODE=""  D
 .. S NUMACT(CODESYS,CODE)=0
 .. S NUMINACT(CODESYS,CODE)=0
 .. S FDA(VCODFNUM,IENS,.01)=CODE
 .. S DFN=""
 .. F  S DFN=$O(^PXRMINDX(ASSOVFILE,"IP",IEN,DFN)) Q:DFN=""  D
 ... S ERROR=0
 ... S FDA(VCODFNUM,IENS,.02)=DFN
 ... S DATE=""
 ... F  S DATE=$O(^PXRMINDX(ASSOVFILE,"IP",IEN,DFN,DATE)) Q:DATE=""  D
 ....;If the mapped code is not active on the date of the source entry
 ....;do not make the V-Standard Codes entry.
 .... I '$$ISCACT^PXLEX(CODESYS,CODE,DATE) D  Q
 ..... S NUMINACT(CODESYS,CODE)=NUMINACT(CODESYS,CODE)+1
 .... S NUMACT(CODESYS,CODE)=NUMACT(CODESYS,CODE)+1
 .... S DAS=""
 .... F  S DAS=$O(^PXRMINDX(ASSOVFILE,"IP",IEN,DFN,DATE,DAS)) Q:DAS=""  D
 ..... D VFDATA(VCODFNUM,ASSOVFILE,DAS,IENS,.FDA)
 .....;If the code is a duplicate do not add it.
 ..... S VISITIEN=FDA(VCODFNUM,IENS,.03)
 ..... S CODEDT=FDA(VCODFNUM,IENS,1201)
 ..... I CODEDT="" S CODEDT=$P(^AUPNVSIT(VISITIEN,0),U,1)
 ..... I $$VSCDUP^PXKMCODE(CODESYS,CODE,VISITIEN,CODEDT,MSOURCE) Q
 ..... K FDAIEN,MSG
 ..... D UPDATE^DIE("S","FDA","FDAIEN","MSG")
 ..... I $D(DIERR) D  Q
 ...... S ERROR=1
 ...... S SUBJECT="Mapped code linking failed for file #"_FILENUM_", IEN="_IEN_", DFN="_DFN
 ...... D SENDEMSG(SUBJECT,.MSG)
 .....;Fire PXK VISIT DATA EVENT for the addition of a code.
 ..... D ADDEVENT^PXMCEVNT(VCODFNUM,FDAIEN(1))
 I ERROR K ^TMP("PXXMZ",$J) Q
 N ENAME,GNAME,LINKDT
 D SETTF(.TO,.FROM)
 S GNAME=$$GET1^DID(FILENUM,"","","NAME")
 S ENAME=$P($G(@GBL@(IEN,0)),U,1)
 S SUBJECT=GNAME_" entry "_ENAME_" has been linked."
 S LINKDT=$$NOW^XLFDT
 S ^TMP("PXXMZ",$J,1,0)="Linking completed at "_$$FMTE^XLFDT(LINKDT,"5Z")
 S ^TMP("PXXMZ",$J,2,0)="The following codes were linked:"
 S CODESYS=""
 F  S CODESYS=$O(CODESYSL(CODESYS)) Q:CODESYS=""  D
 . S CODE=""
 . F  S CODE=$O(CODESYSL(CODESYS,CODE)) Q:CODE=""  D
 ..;Set the Date Linked.
 .. S IND=CODESYSL(CODESYS,CODE)
 .. S $P(@GBL@(IEN,210,IND,0),U,4)=LINKDT
 .. S NL=NL+1,^TMP("PXXMZ",$J,NL,0)=" "_CODESYS_":  "_CODE
 .. I NUMACT(CODESYS,CODE)>0 D
 ... S NL=NL+1,^TMP("PXXMZ",$J,NL,0)=" There were "_NUMACT(CODESYS,CODE)_" instances on dates where the code was active."
 .. I NUMINACT(CODESYS,CODE)>0 D
 ... S NL=NL+1,^TMP("PXXMZ",$J,NL,0)=" There were "_NUMINACT(CODESYS,CODE)_" instances on dates where the code was inactive."
 .. S NL=NL+1,^TMP("PXXMZ",$J,NL,0)=""
 D SEND^PXMSG("PXXMZ",SUBJECT,.TO,FROM)
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
 D SEND^PXMSG("PXXMZ","LINKING NATIONAL PCE ENTRIES",DUZ,"PCE")
 K ^TMP("PXXMZ",$J)
 Q
 ;
 ;==========================================
MCLINK(FILENUM,IEN) ;Check for codes that have been mapped but not linked,
 ;called from ScreenMan form post-save.
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
 I $D(^TMP($J,"UNLINK",FILENUM)) D DELCHK(.CODESYSL)
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
 S VFILENUM=$$ASSOVFILE(FILENUM)
 I '$D(^PXRMINDX(VFILENUM,"IP",IEN)) D  Q
 . K TEXT
 . S TEXT(1)=""
 . S TEXT(2)="No patients have been given the "_GNAME_": "_ENAME
 . S TEXT(3)="there is no data to link."
 . D EN^DDIOL(.TEXT) H 3
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
MCUNLINK(FILENUM,IEN) ;Start a task to unlink mapped codes, called from
 ;ScreenMan form post-save.
 ;FILENUM is the file number of the data type file.
 ;IEN is the internal entry number of the data type.
 N DA,DDS,DIR,DIR0,GBL,IENS,STARTDT,NL,TEMP,TEXT,X,Y,UNLINK
 I '$D(^TMP($J,"UNLINK")) Q
 M UNLINK=^TMP($J,"UNLINK")
 K ^TMP($J,"UNLINK")
 S GBL=$$GET1^DID(FILENUM,"","","GLOBAL NAME")
 S GBL=$P(GBL,"(",1)
 S TEXT(1)="The following codes have been selected for deletion and unlinking:"
 S IENS="",NL=1
 F  S IENS=$O(UNLINK(FILENUM,IENS)) Q:IENS=""  D
 . D DA^DILF(IENS,.DA)
 . S TEMP=@GBL@(DA(1),210,DA,0)
 . S CODESYS=$P(TEMP,U,1)
 . S CODE=$P(TEMP,U,2)
 . S NL=NL+1,TEXT(NL)=" "_CODESYS_"  "_CODE
 . D DELMC(FILENUM,CODESYS,CODE,IENS)
 S NL=NL+1,TEXT(NL)=""
 S NL=NL+1,TEXT(NL)="This process will also check all the deleted code mappings for this entry"
 S NL=NL+1,TEXT(NL)="to make sure they are completely unlinked."
 D EN^DDIOL(.TEXT)
 S STARTDT=$$NOW^XLFDT
 D TASKUNLK(FILENUM,IEN,STARTDT)
 ;D UNLINK^PXMCLINK(FILENUM,IEN)
 Q
 ;
 ;==========================================
SENDEMSG(SUBJECT,FMMSG,ADDTEXT) ;
 N IND,EMSG,FROM,NL,TO
 ;A FileMan error has occurred and we are sending an error message, so  
 ;cleanup the FileMan error variables.
 D CLEAN^DILF
 D SETTF(.TO,.FROM)
 K ^TMP("PXEMSG",$J)
 S NL=1,^TMP("PXEMSG",$J,NL,0)=SUBJECT
 I $D(ADDTEXT) D
 . S IND=0
 . F  S IND=$O(ADDTEXT(IND)) Q:IND=""  D
 .. S NL=NL+1,^TMP("PXEMSG",$J,NL,0)=ADDTEXT(IND)
 S NL=NL+1,^TMP("PXEMSG",$J,NL,0)="The following error message was returned by FileMan:"
 D ACOPY^PXUTIL("FMMSG","EMSG()")
 S IND=0 F  S IND=$O(EMSG(IND)) Q:IND=""  S NL=NL+1,^TMP("PXEMSG",$J,NL,0)=EMSG(IND)
 D SEND^PXMSG("PXEMSG",SUBJECT,.TO,FROM)
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
TASKLINK(FILENUM,GBL,IEN,CODESYSL,STARTDT) ;Start a task to link
 ;mapped codes.
 N ZTREQ,ZTSAVE,ZTSK,ZTIO,ZTDTH,ZTRTN
 S ZTREQ="@"
 S ZTSAVE("FILENUM")=""
 S ZTSAVE("GBL")=""
 S ZTSAVE("IEN")=""
 S ZTSAVE("CODESYSL(")=""
 S ZTRTN="TSKLINK^PXMCLINK"
 S ZTDESC="Link mapped codes for "_GBL_" IEN="_IEN
 S ZTDTH=STARTDT
 S ZTIO=""
 D ^%ZTLOAD
 I ZTSK'="" W !,"Task number ",ZTSK," queued." H 3
 Q
 ;
 ;==========================================
TASKUNLK(FILENUM,IEN,STARTDT) ;Start a task to unlink mapped codes.
 N ZTREQ,ZTSAVE,ZTSK,ZTIO,ZTDTH,ZTRTN
 S ZTREQ="@"
 S ZTSAVE("IEN")=""
 S ZTSAVE("FILENUM")=""
 S ZTRTN="TSKUNLK^PXMCLINK"
 S ZTDESC="Unlink mapped codes for "_GBL_" IEN="_IEN
 S ZTDTH=STARTDT
 S ZTIO=""
 D ^%ZTLOAD
 I ZTSK'="" W !,"Task number ",ZTSK," queued." H 3
 Q
 ;
 ;==========================================
TSKLINK ;Arguments come through ZTSAVE.
 D LINK^PXMCLINK(FILENUM,GBL,IEN,.CODESYSL)
 Q
 ;
 ;==========================================
TSKUNLK ;Arguments come through ZTSAVE.
 D UNLINK^PXMCLINK(FILENUM,IEN)
 Q
 ;
 ;==========================================
UNLINK(FILENUM,IEN) ;Check for codes that should be unlinked.
 ;FILENUM is the file number of the data type file.
 ;IEN is the internal entry number of the data type.
 ;UNLINK is the list of V-file entries to delete.
 N ASSOVFILE,CODE,CODEIEN,CODESYS,DA,ENAME,ERROR,FROM,GBL,GNAME,IENS
 N IND,KFDA,MSG,NL,NUMUNL,SCC,SOURCE,SUBJECT,TEMP,TO,UNLINKDT
 N VCODFNUM,VSCIEN,ZNODE
 S ASSOVFILE=$$ASSOVFILE(FILENUM)
 S SOURCE=FILENUM_";"_IEN
 S GBL=$$GET1^DID(FILENUM,"","","GLOBAL NAME")
 S GBL=$P(GBL,"(",1)
 S GNAME=$$GET1^DID(FILENUM,"","","NAME")
 S ENAME=$P($G(@GBL@(IEN,0)),U,1)
 S SUBJECT="Code mapping(s) for "_GNAME_" entry "_ENAME_" have been deleted and unlinked."
 K ^TMP("PXXMZ",$J)
 S ^TMP("PXXMZ",$J,1,0)=SUBJECT
 S ^TMP("PXXMZ",$J,2,0)="The following codes were deleted and unlinked:"
 S (ERROR,IND)=0,NL=2,VCODFNUM=9000010.71
 F  S IND=+$O(@GBL@(IEN,230,IND)) Q:IND=0  D
 . S TEMP=@GBL@(IEN,230,IND,0)
 .;If there is a MSE Removal Date this entry is already done.
 . I $P(TEMP,U,5)'="" Q
 . S CODESYS=$P(TEMP,U,1)
 . S CODE=$P(TEMP,U,2)
 . S ERROR=0
 . S NUMUNL=0
 . S NL=NL+1,^TMP("PXXMZ",$J,NL,0)=" "_CODESYS_" "_CODE
 . S UNLINKDT=$$NOW^XLFDT
 . K SCC
 . M SCC=^AUPNVSC("SCC",SOURCE,CODESYS,CODE)
 . S VSCIEN=""
 . F  S VSCIEN=$O(SCC(VSCIEN)) Q:VSCIEN=""  D
 .. S ZNODE=^AUPNVSC(VSCIEN,0)
 .. K KFDA,MSG
 .. S KFDA(VCODFNUM,VSCIEN_",",.01)="@"
 .. D FILE^DIE("","KFDA","MSG")
 .. I '$D(DIERR) S NUMUNL=NUMUNL+1 D DELEVENT^PXMCEVNT(VCODFNUM,VSCIEN,ZNODE)
 .. I $D(DIERR) D
 ... S ERROR=1
 ... S SUBJECT="Mapped code unlinking failed for file #"_FILENUM_", IEN="_IEN_", VSCIEN="_VSCIEN
 ... D SENDEMSG(SUBJECT,.MSG)
 . I 'ERROR D
 .. S $P(@GBL@(IEN,230,IND,0),U,5)=UNLINKDT
 .. S NL=NL+1,^TMP("PXXMZ",$J,NL,0)=" "_NUMUNL_" V Standard Codes entries were removed."
 .. S NL=NL+1,^TMP("PXXMZ",$J,NL,0)=""
 I 'ERROR D 
 . D SETTF(.TO,.FROM)
 . D SEND^PXMSG("PXXMZ",SUBJECT,.TO,"PCE MANAGEMENT")
 K ^TMP($J,"LIST"),^TMP("PXXMZ",$J)
 Q
 ;
 ;==========================================
VFDATA(VCODFNUM,ASSOVFILE,IEN,IENS,FDA) ;Load the additional V-file data into
 ;the FDA.
 S FDA(VCODFNUM,IENS,.03)=$$GET1^DIQ(ASSOVFILE,IEN,.03,"I")
 S FDA(VCODFNUM,IENS,1201)=$$GET1^DIQ(ASSOVFILE,IEN,1201,"I")
 S FDA(VCODFNUM,IENS,1202)=$$GET1^DIQ(ASSOVFILE,IEN,1202,"I")
 S FDA(VCODFNUM,IENS,1204)=$$GET1^DIQ(ASSOVFILE,IEN,1204,"I")
 S FDA(VCODFNUM,IENS,81202)=$$GET1^DIQ(ASSOVFILE,IEN,81202,"I")
 S FDA(VCODFNUM,IENS,81203)=$$GET1^DIQ(ASSOVFILE,IEN,81203,"I")
 Q
 ;
