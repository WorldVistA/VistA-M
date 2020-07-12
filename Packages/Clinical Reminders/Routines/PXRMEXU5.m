PXRMEXU5 ;SLC/PKR - Reminder exchange KIDS utilities, #5. ;May 30, 2018@10:11
 ;;2.0;CLINICAL REMINDERS;**12,16,18,22,45**;Feb 04, 2005;Build 566
 ;==================================================
BMTABLE(MTABLE,IENROOT,DIQOUT,FDA) ;Build the table for merging
 ;GETS^DIQOUT indexes into the FDA. The merge table has the form:
 ;MTABLE(IENSD)=IENSF. IENSD is the DIQOUT IENs and IENSF is the
 ;FDA IENs. MTABLE provides a direct replacement of IENSD to IENSF.
 N FILENUM,IEN,IENS,IENSD,IENRF,IENSF,IND,LAST,LEN,NULLF,TOPFN
 S FILENUM=$O(FDA(""),-1),IENS=$O(FDA(FILENUM,""),-1)
 S LAST=+$P(IENS,",",1)
 ;Initialize the merge table by looking for identical entries in
 ;DIQOUT and FDA. First create the top level entry.
 S NULLF=0
 S FILENUM=$O(DIQOUT(""))
 S IENSD=$O(DIQOUT(FILENUM,""))
 S LEN=$L(IENSD,",")-1
 S IENS=$P(IENSD,",",LEN)_","
 ;DBIA #2631
 F IND=1:1:LEN-1 S FILENUM=$G(^DD(FILENUM,0,"UP"))
 S TOPFN=FILENUM
 S IENSF=$O(FDA(TOPFN,""))
 S MTABLE(TOPFN,IENS)=IENSF
 ;Build all the entries below the top level.
 S FILENUM=TOPFN
 F  S FILENUM=$O(DIQOUT(FILENUM)) Q:FILENUM=""  D
 . S IENSD=""
 . F  S IENSD=$O(DIQOUT(FILENUM,IENSD)) Q:IENSD=""  D
 .. S MTABLE(FILENUM,IENSD)=""
 .. I '$D(FDA(FILENUM)) S NULLF=1 Q
 ..;Look for matches based on identical .01s
 .. S IENSF=""
 .. F  S IENSF=$O(FDA(FILENUM,IENSF)) Q:IENSF=""  D
 ... I $G(DIQOUT(FILENUM,IENSD,.01))=$G(FDA(FILENUM,IENSF,.01)) S MTABLE(FILENUM,IENSD)=IENSF
 ... E  S NULLF=1
 ;Entries that are equal to null at this point don't have a
 ;corresponding FDA entry.
 I 'NULLF Q
 S FILENUM=""
 F  S FILENUM=$O(FDA(FILENUM)) Q:FILENUM=""  D
 . S IENSF=""
 . F  S IENSF=$O(FDA(FILENUM,IENSF)) Q:IENSF=""  D
 .. S IND=+IENSF
 .. I IENROOT(IND)'="" S IENRF(FILENUM,IENROOT(IND))=IND
 ;IENRF keeps track of the IENROOT entries by file number.
 S FILENUM=""
 F  S FILENUM=$O(MTABLE(FILENUM)) Q:FILENUM=""  D
 . S IENSD=""
 . F  S IENSD=$O(MTABLE(FILENUM,IENSD)) Q:IENSD=""  D
 .. I MTABLE(FILENUM,IENSD)'="" Q
 .. D MMTAB(.MTABLE,.IENROOT,.LAST,FILENUM,IENSD,.IENRF)
 Q
 ;
 ;==================================================
DIALOGGF(FDA,IENROOT) ;
 N FOUND,IEN,LIEN,NAME,PKGIEN,PREFIX,TEMP
 S IENS="" F  S IENS=$O(FDA(801.46,IENS)) Q:IENS=""  D
 .S TEMP=$G(FDA(801.46,IENS,2)) I TEMP="" Q
 .S NAME=$P(TEMP,U),PREFIX=$P(TEMP,U,2)
 .I NAME=""!(PREFIX="") Q
 .S FOUND=0,LIEN=0
 .S IEN=0 F  S IEN=$O(^DIC(9.4,"B",NAME,IEN)) Q:IEN'>0!(FOUND=1)  D
 ..I $D(^DIC(9.4,"C",PREFIX,IEN)) S LIEN=IEN,FOUND=1 Q
 .I LIEN'>0 Q
 .S FDA(801.46,IENS,2)="`"_LIEN
 Q
 ;
 ;==================================================
DLINKSAV(FDA) ; save dialog entry to temp global to prevent recurrisve install.
 N EXIST,IENS,DIAL,NAME
 S IENS="" F  S IENS=$O(FDA(801.48,IENS)) Q:IENS=""  D
 .S NAME=FDA(801.48,IENS,.01)
 .S DIAL=FDA(801.48,IENS,1)
 .S EXIST=$$EXISTS^PXRMEXIU(801.41,DIAL,"") I +EXIST>0 Q
 .S ^TMP("PXRM DIALOG LINK FILE",$J,NAME)=DIAL
 .K FDA(801.48,IENS,1)
 Q
 ;
 ;==================================================
DLINKSET ; reset file dialog entry to link file
 N DA,DIE,DIEN,DIK,DNAME,DR,LIEN,LNAME
 S LNAME="" F  S LNAME=$O(^TMP("PXRM DIALOG LINK FILE",$J,LNAME)) Q:LNAME=""  D
 .S LIEN=$$EXISTS^PXRMEXIU(801.48,LNAME,"") I +LIEN'>0 Q
 .S DNAME=$G(^TMP("PXRM DIALOG LINK FILE",$J,LNAME)) I DNAME="" Q
 .S DIEN=$$EXISTS^PXRMEXIU(801.41,DNAME,"") I +DIEN'>0 Q
 .;Set link type to dialog pointer.
 .S DR="1///^S X=DNAME",DIE="^PXRMD(801.48,",DA=LIEN
 .D ^DIE
 Q
 ;
 ;==================================================
EXCHINCK(EXNAME,DPACKED) ;Given the name and the date packed of an Exchange
 ;entry return:
 ; -1 if the entry does not exist
 ;  0 if it has never been installed
 ;  1^installation date/time 
 I $G(EXNAME)="" Q -1
 I $G(DPACKED)="" Q -1
 N DTP,IEN,IND,LASTINDT
 D DT^DILF("ST",DPACKED,.DTP)
 S IEN=+$O(^PXD(811.8,"B",EXNAME,DTP,""))
 I IEN=0 Q -1
 S IND=+$O(^PXD(811.8,IEN,130,"B"),-1)
 I IND=0 Q 0
 S LASTINDT=$P(^PXD(811.8,IEN,130,IND,0),U,1)
 Q 1_U_LASTINDT
 ;
 ;==================================================
LOIEN(FILENUM,START) ;Find the first open IEN in a global. If the optional
 ;parameter START is present then start there looking for the first
 ;open IEN.
 N GBL,I1,I2,OIEN
 S GBL=$$GET1^DID(FILENUM,"","","GLOBAL NAME")_"I1)"
 S OIEN=-1
 S (I1,I2)=0
 S (I1,I2)=$S($G(START)>0:START,1:0)
 F  S I1=+$O(@GBL) Q:(OIEN>0)!(I1=0)  D
 . I ((I1-I2)>1)!(I1="") S OIEN=I2+1 Q
 . S I2=I1
 I OIEN=-1 S OIEN=I2+1
 Q OIEN
 ;
 ;==================================================
MOU(FILENUM,IEN,FIELD,FDA,IENROOT,ACTION,WPTMP) ;Merge or update existing site
 ;entries into the FDA that is loaded from Exchange.
 ;FILENUM - the file number
 ;IEN - internal entry number
 ;FIELD - semicolon separated list of fields.
 ;These the are arguments for GETS^DIQ, see that documentation for 
 ;more information.
 ;FDA and IENROOT are the FDA and IENROOT for UPDATE^DIE. These
 ;are already setup with the contents of the packed reminder before
 ;this routine is called.
 N DIQOUT,IENS,IENSD,IENSF,IND,IND1,IND2,IND2S,IND3,FNUM,LE,MSG,MTABLE
 N SITE,TIENROOT
 S IENS=IEN_","
 D GETS^DIQ(FILENUM,IENS,FIELD,"N","DIQOUT","MSG")
 I $D(MSG) D  Q
 . N ETEXT,FILENAME
 . S FILENAME=$$GET1^DID(FILENUM,"","","NAME")
 . S ETEXT="In MOU^PXRMEXU5 GETS^DIQ failed for "_FILENAME_" entry "_IEN_", it returned the following error message:"
 . W !,ETEXT
 . D AWRITE^PXRMUTIL("MSG")
 . H 2
 ;If there is nothing to merge quit.
 I '$D(DIQOUT) Q
 ;Clean up DIQOUT remove null entries and change pointers to the resolved
 ;form.
 D CLDIQOUT^PXRMEXPU(.DIQOUT)
 D RMEH^PXRMEXPU(FILENUM,.DIQOUT,1)
 ;If there is nothing left to merge quit.
 I '$D(DIQOUT) Q
 ;Build the merge table.
 D BMTABLE(.MTABLE,.IENROOT,.DIQOUT,.FDA)
 ;Do the merge or update.
 S FNUM=""
 F  S FNUM=$O(DIQOUT(FNUM)) Q:FNUM=""  D
 . S IENSD=""
 . F  S IENSD=$O(DIQOUT(FNUM,IENSD)) Q:IENSD=""  D
 .. S IENSF=MTABLE(FNUM,IENSD)
 ..;This is how update works for terms.
 .. I (ACTION="U"),$D(FDA(FNUM,IENSF,.01)) Q
 .. S FIELD=""
 .. F  S FIELD=$O(DIQOUT(FNUM,IENSD,FIELD)) Q:FIELD=""  D
 ... I DIQOUT(FNUM,IENSD,FIELD)["WP-start" D WORDPROC(FNUM,IENSD,FIELD,.DIQOUT,.WPTMP)
 ... S FDA(FNUM,IENSF,FIELD)=DIQOUT(FNUM,IENSD,FIELD)
 Q
 ;
 ;==================================================
MMTAB(MTABLE,IENROOT,LAST,FILENUM,IENS,IENRF) ;Generate a merge table entry.
 N IENRL,FNUP,UP,UPIENS
 S UP=$P(IENS,",",2,99)
 ;DBIA #2631
 S FNUP=$G(^DD(FILENUM,0,"UP"))
 S UPIENS=MTABLE(FNUP,UP)
 S LAST=LAST+1
 S MTABLE(FILENUM,IENS)="+"_LAST_","_UPIENS
 S IENRL=$O(IENRF(FILENUM,""),-1)+1
 S IENROOT(LAST)=IENRL,IENRF(FILENUM,IENRL)=LAST
 Q
 ;
 ;==================================================
REPCHAR(PXRMRIEN,CHAR1,CHAR2) ;Replace CHAR1 with CHAR2 for all lines in node
 ;100 of entry PXRMRIEN of the Exchange File.
 N IND,LINE
 S IND=0
 F  S IND=+$O(^PXD(811.8,PXRMRIEN,100,IND)) Q:IND=0  D
 . S LINE=$TR(^PXD(811.8,PXRMRIEN,100,IND,0),CHAR1,CHAR2)
 . S ^PXD(811.8,PXRMRIEN,100,IND,0)=LINE
 Q
 ;
 ;==================================================
ROC(FDA,IENROOT) ;For Reminder Order Checks.
 N ACTION,IEN,IENS,NODE,OI,OOI,TEXT
 S ACTION="",IENS=""
 I $D(FDA(801.02)) D ROCCONV(.FDA,.IENROOT) K FDA(801.02)
 F  S IENS=$O(FDA(801.015,IENS)) Q:IENS=""  D  I ACTION="Q" K FDA S PXRMDONE=1
 .S NODE=FDA(801.015,IENS,.01) I NODE'["OI" Q
 .S TEXT=""
 .S (OI,OOI)=$P(NODE,".",2)
 .S IEN=$$EXISTS^PXRMEXIU(101.43,OI)
 .I IEN>0,$G(^ORD(101.43,IEN,.1))'="" D
 ..S IEN=0
 ..S TEXT="ORDERABLE ITEM  entry "_OI_" is inactive."
 .I IEN=0 D
 ..;Get replacement
 ..I TEXT="" S TEXT="ORDERABLE ITEM  entry "_OI_" does not exist."
 ..N DIC,DIR,DUOUT,MSG,X,Y
 ..S MSG(1)=" "
 ..S MSG(2)=TEXT
 ..D MES^XPDUTL(.MSG)
 ..S ACTION=$$GETACT^PXRMEXIU("DPQ",.DIR) I ACTION="S" S ACTION="Q"
 ..I ACTION="Q" Q
 ..I ACTION="D" K FDA(801.015,IENS,.01) Q
 ..S DIC=101.43
 ..S DIC(0)="AEMNQ"
 ..S Y=-1
 ..F  Q:+Y'=-1  D
 ...;If this is being called during a KIDS install we need echoing on.
 ...I $D(XPDNM) X ^%ZOSF("EON")
 ...D ^DIC
 ...I $D(XPDNM) X ^%ZOSF("EOFF")
 ...;If this is being called during a KIDS install we need echoing on.
 ...I $D(DUOUT) S Y="" Q
 ...I Y=-1 D BMES^XPDUTL("You must input a replacement!")
 ..I Y="" S ACTION="Q" Q
 ..S OI=$P(Y,U,2) K IEN
 ..S FDA(801.015,IENS,.01)=$P(NODE,"`")_"`"_OI
 .I IEN>0 S FDA(801.015,IENS,.01)="OI.`"_IEN
 Q
 ;
 ;==================================================
ROCCONV(FDA,IENROOT) ;handle converting pre-patch 45 packed file to new structure
 N CNT,IEN,IENS,IEN1,IENL,LIST,OI,OIIEN
 ;build list of orderable items
 S IEN1=0
 S IENS="",IENL="" F  S IENS=$O(FDA(801.02,IENS)) Q:IENS=""  D
 .I $G(FDA(801.02,IENS,.01))="" Q
 .S OI=FDA(801.02,IENS,.01)
 .S OIIEN=$$FIND1^DIC(101.43,"","BXU",OI)
 .I +OIIEN'>0 D BMES^XPDUTL("Error mapping Orderable Item: "_OI_" to new file structure.") Q
 .S FDA(801.015,IENS,.01)="OI."_OI
 S IENS="",CNT=0 F  S IENS=$O(FDA(801.015,IENS)) Q:IENS=""  D
 .S CNT=CNT+1
 .I $G(FDA(801.015,IENS,.01))'["OI" Q
 .S IEN=+$P(IENS,",")
 .S IENROOT(IEN)=CNT
 ;S LIST(FDA(801.02,IENS,.01))="",IENL=IENS
 ;find last Item List IENS
 ;S IEN=$P(IENL,",",2)
 ;I $D(FDA(801.015)) D
 ;.S IENL=$O(FDA(801.015,""),-1) I IENL="" Q
 ;.S IEN1=+$P(IENS,","),IEN=$P(IENS,",",2)
 ;;add Orderable Items to ITEMLIST FDA
 ;S OI="" F  S OI=$O(LIST(OI)) Q:OI=""  D
 ;.S OIIEN=$$FIND1^DIC(101.43,"","BXU",OI)
 ;.I +OIIEN'>0 D BMES^XPDUTL("Error mapping Orderable Item: "_OI_" to new file structure.") Q
 ;.S IEN1=IEN+1
 ;.S FDA(801.02,"+"_IEN1_",+"_IEN_",",.01)="OI.`"_OIIEN
 Q
 ;
 ;==================================================
ROCR(FDA) ;
 N IENS
 S IENS="" F  S IENS=$O(FDA(801.1,IENS)) Q:IENS=""  D
 .I '$G(PXRMINST) S FDA(801.1,IENS,2)="I"
 Q
 ;
 ;==================================================
TIU(IEN,ARRAY,SUB) ;
 I $D(^TMP($J,SUB,IEN))>0 Q
 N CNT,ERROR,OUTPUT
 S OUTPUT=$NA(^TMP($J,SUB,IEN))
 I $G(ARRAY(IEN,9))="" Q
 S CNT=1 S @OUTPUT@(CNT)="TIU Object: "_$G(ARRAY(IEN,.01))
 S CNT=CNT+1,@OUTPUT@(CNT)="Object Method: "_$G(ARRAY(IEN,9))
 S CNT=CNT+1,@OUTPUT@(CNT)=""
 Q
 ;
 ;==================================================
WORDPROC(FILENUM,IENSD,FIELD,DIQOUT,WPTMP) ;
 N I3,NL
 S NL=$P(DIQOUT(FILENUM,IENSD,FIELD),"~",2)
 F I3=1:1:NL S WPTMP(FILENUM,+FIELD,I3)=DIQOUT(FILENUM,IENSD,FIELD,I3)
 S DIQOUT(FILENUM,IENSD,FIELD)="WPTMP("_FILENUM_","_+FIELD_")"
 Q
 ;
