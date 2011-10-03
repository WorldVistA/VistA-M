PXRMEXU5 ; SLC/PKR - Reminder exchange KIDS utilities, #5. ;03/07/2010
 ;;2.0;CLINICAL REMINDERS;**12,16**;Feb 04, 2005;Build 119
 ;==================================================
BMTABLE(MTABLE,IENROOT,DIQOUT,FDA) ;Build the table for merging
 ;GETS^DIQOUT indexes into the FDA. The merge table has the form:
 ;MTABLE(IENSD)=IENSF. IENSD is the DIQOUT iens and IENSF is the
 ;FDA iens. MTABLE provides a direct replacement of IENSD to IENSF.
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
LOIEN(FILENUM) ;Find the first open ien in a global.
 N GBL,I1,I2,OIEN
 S GBL=$$GET1^DID(FILENUM,"","","GLOBAL NAME")_"I1)"
 S OIEN=-1
 S (I1,I2)=0
 F  S I1=+$O(@GBL) Q:(OIEN>0)!(I1=0)  D
 . I ((I1-I2)>1)!(I1="") S OIEN=I2+1 Q
 . S I2=I1
 I OIEN=-1 S OIEN=I2+1
 Q OIEN
 ;
 ;==================================================
MERGE(FILENUM,IEN,FIELD,FDA,IENROOT) ;Merge existing site entries into
 ;the FDA that is loaded from Exchange.
 ;FILENUM - the file number
 ;IEN - internal entry number
 ;FIELD - semicolon separated list of fields.
 ;These the are arguments for GETS^DIQ, see that documentation for 
 ;more information.
 ;FDA and IENROOT are the FDA and IENROOT for UPDATE^DIE. These
 ;are already setup with the contents of the packed reminder before
 ;this routine is called.
 ;The default is to merge any nodes of the FDA with the nodes
 ;already existing at the site. If MODE="R" then the existing nodes
 ;will be replaced with the nodes already in the FDA.
 N DIQOUT,IENSD,IENSF,IND,IND1,IND2,IND2S,IND3,LE,MSG,MTABLE
 N SITE,TIENROOT
 S IENS=IEN_","
 D GETS^DIQ(FILENUM,IENS,FIELD,"N","DIQOUT","MSG")
 I $D(MSG) D  Q
 . N ETEXT,FILENAME
 . S FILENAME=$$GET1^DID(FILENUM,"","","NAME")
 . S ETEXT="GETS^DIQ failed for "_FILENAME_" entry "_IEN_", it returned the following error message:"
 . W !,ETEXT
 . D AWRITE^PXRMUTIL("MSG")
 . H 2
 . K MSG
 ;If there is nothing to merge quit.
 I '$D(DIQOUT) Q
 ;Clean up DIQOUT remove null entries and change pointers to the resolved
 ;form.
 D CLDIQOUT^PXRMEXPU(.DIQOUT)
 ;If there is nothing left to merge quit.
 I '$D(DIQOUT) Q
 ;Build the merge table.
 D BMTABLE(.MTABLE,.IENROOT,.DIQOUT,.FDA)
 ;Do the merge
 S FILENUM=""
 F  S FILENUM=$O(DIQOUT(FILENUM)) Q:FILENUM=""  D
 . S IENSD=""
 . F  S IENSD=$O(DIQOUT(FILENUM,IENSD)) Q:IENSD=""  D
 .. S IENSF=MTABLE(FILENUM,IENSD)
 .. S FIELD=""
 .. F  S FIELD=$O(DIQOUT(FILENUM,IENSD,FIELD)) Q:FIELD=""  D
 ... S FDA(FILENUM,IENSF,FIELD)=DIQOUT(FILENUM,IENSD,FIELD)
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
NONULL(PXRMRIEN) ;Set any lines with a length of 0 equal to a space
 ;so KIDS will not delete them.
 N IND
 S IND=0
 F  S IND=+$O(^PXD(811.8,PXRMRIEN,100,IND)) Q:IND=0  D
 . I $L(^PXD(811.8,PXRMRIEN,100,IND,0))=0 S ^PXD(811.8,PXRMRIEN,100,IND,0)=" "
 Q
 ;
 ;==================================================
POSTKIDS(PXRMRIEN) ;Change all ACK characters in node 100 of Exchange
 ;File entry PXRMRIEN back to "^".
 N ACK,UPA
 S ACK=$C(6)
 S UPA="^"
 D REPCHAR(PXRMRIEN,ACK,UPA)
 Q
 ;
 ;==================================================
PREKIDS(PXRMRIEN) ;Change all "^" characters in node 100 of Exchange
 ;File entry PXRMRIEN so that KIDS does not truncate lines when it
 ;installs the file.
 N ACK,UPA
 S ACK=$C(6)
 S UPA="^"
 D REPCHAR(PXRMRIEN,UPA,ACK)
 D NONULL(PXRMRIEN)
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
ROC(FDA) ;
 N ACTION,IEN,IENS,OI,OOI,TEXT
 S ACTION="",IENS=""
 F  S IENS=$O(FDA(801.02,IENS)) Q:IENS=""  D  I ACTION="Q" K FDA S PXRMDONE=1
 .S TEXT=""
 .S (OI,OOI)=FDA(801.02,IENS,.01)
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
 ..I ACTION="D" K FDA(801.02,IENS,.01) Q
 ..S DIC=101.43
 ..S DIC(0)="AEMNQ"
 ..;S DIC("S")="I $$FILESCR^PXRMDLG6(Y,FILENUM)=1"
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
 ..S OI=$P(Y,U,2)
 ..S FDA(801.02,IENS,.01)=OI
 .;I OI'=OOI D
 .;.S ^TMP("PXRMEXIA",$J,"DIAF",$P(IENS,",",1),ABBR_"."_OOI)=ABBR_"."_OI
 Q
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
