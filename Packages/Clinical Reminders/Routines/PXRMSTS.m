PXRMSTS ;SLC/PKR,AGP - Master File Server event handling routines. ;07/29/2010
 ;;2.0;CLINICAL REMINDERS;**12,17,18**;Feb 04, 2005;Build 152
 ;==============================
AERRMSG(EMSG,NL) ;Add the UPDATE^DIE error message.
 N ERRMSG,IND
 D ACOPY^PXRMUTIL("MSG","ERRMSG()")
 S IND=0
 F  S IND=$O(ERRMSG(IND)) Q:IND=""  S NL=NL+1,^TMP("PXRMXMZ",$J,NL,0)=ERRMSG(IND)
 Q
 ;
 ;==============================
ATFND(IEN,FI,REP,NL) ;Add the replacement as a new finding to the term.
 N DA,DIK,EMSG,GBL,NEWFI,TEXT
 S GBL=$P($$GET1^DID($P(REP,";",2),"","","GLOBAL NAME"),U,2)
 S NEWFI=$P(REP,";",1)_";"_GBL
 ;If this finding already exists don't add it again.
 I $D(^PXRMD(811.5,IEN,20,"B",NEWFI)) Q
 S DA(1)=IEN,DIK="^PXRMD(811.5,"_IEN_",20,"
 D SETSTART^PXRMCOPY(DIK)
 S DA=$$GETFOIEN^PXRMCOPY(DIK)
 M ^PXRMD(811.5,IEN,20,DA)=^PXRMD(811.5,IEN,20,FI)
 S $P(^PXRMD(811.5,IEN,20,DA,0),U,1)=NEWFI
 D IX^DIK
 S NL=NL+1,^TMP("PXRMXMZ",$J,NL,0)="   Replacement added as finding number "_DA
 S TEXT(1)="STS protocol automated update."
 S TEXT(2)="Replacement added as finding number "_DA_"."
 D UPEHIST^PXRMUTIL(811.5,IEN,.TEXT,.EMSG)
 I $D(EMSG) D
 . S NL=NL+1,^TMP("PXRMXMZ",$J,NL,0)="  Edit history update failed."
 . D AERRMSG(.EMSG,.NL)
 Q
 ;
 ;==============================
BLDDLGTM(SUB) ;Build an index of dialog finding usage.
 N AFIND,AIEN,FIELD,FIEN,FIND,GBL,IEN,MH,NODE,ORD,TYPE
 S IEN=0 F  S IEN=$O(^PXRMD(801.41,IEN)) Q:IEN'>0  D
 .S TYPE=$P($G(^PXRMD(801.41,IEN,0)),U,4)
 .I TYPE'="E",TYPE'="G",TYPE'="S" Q
 .S NODE=$G(^PXRMD(801.41,IEN,1))
 .S FIND=$P(NODE,U,5)
 .S ORD=$P(NODE,U,7)
 .I FIND'="" D
 ..S FIEN=$P(FIND,";"),GBL=$P(FIND,";",2)
 ..S ^TMP($J,SUB,GBL,FIEN,IEN,15)=""
 .I ORD'="" S ^TMP($J,SUB,"ORD(101.43,",ORD,IEN,17)=""
 .S MH=$P($G(^PXRMD(801.41,IEN,50)),U)
 .I MH'="" S ^TMP($J,SUB,"YTT(601.71,",MH,IEN,119)=""
 .S AFIND=0
 .F  S AFIND=$O(^PXRMD(801.41,IEN,3,"B",AFIND)) Q:AFIND=""  D
 ..S AIEN=$O(^PXRMD(801.41,IEN,3,"B",AFIND,"")) Q:AIEN'>0
 ..S FIEN=$P(AFIND,";"),GBL=$P(AFIND,";",2)
 ..S ^TMP($J,SUB,GBL,FIEN,IEN,18,AIEN)=""
 Q
 ;
 ;==============================
BLDDLGEH(MSG,IEN,TEXT) ;
 N CNT
 I '$D(MSG(IEN)) S MSG(IEN,1)=TEXT Q
 S CNT=""
 S CNT=$O(MSG(IEN,CNT),-1)
 S CNT=CNT+1,MSG(IEN,CNT)=TEXT
 Q
 ;
 ;==============================
DEF(FILENUM,GBL,FIEN,REP,MAPACT,NL) ;Search all reminder definitions
 ;for any  that are using this finding, defined by the global (GBL) and
 ;the IEN (FIEN).
 N DEF,FI,IEN,TERM
 S NL=NL+1,^TMP("PXRMXMZ",$J,NL,0)=""
 S NL=NL+1,^TMP("PXRMXMZ",$J,NL,0)=" It is used in the following definitions:"
 I '$D(^TMP($J,"FDATA",FILENUM,FIEN,"DEF")) S NL=NL+1,^TMP("PXRMXMZ",$J,NL,0)="  None" Q
 S TERM=$S(MAPACT="M":$$GENTERM(FILENUM,FIEN,REP,.NL),1:0)
 S IEN=0
 F  S IEN=$O(^TMP($J,"FDATA",FILENUM,FIEN,"DEF",IEN)) Q:IEN=""  D
 . S DEF=$P(^PXD(811.9,IEN,0),U,1)
 . S NL=NL+1,^TMP("PXRMXMZ",$J,NL,0)=""
 . S NL=NL+1,^TMP("PXRMXMZ",$J,NL,0)="  "_DEF_" IEN="_IEN
 . S FI=""
 . F  S FI=$O(^TMP($J,"FDATA",FILENUM,FIEN,"DEF",IEN,FI)) Q:FI=""  D
 .. S NL=NL+1,^TMP("PXRMXMZ",$J,NL,0)="   Finding number "_FI
 .. I MAPACT="M",TERM>0 D RFWT(IEN,FI,TERM,.NL)
 Q
 ;
 ;==================================================================
DIALOG(FILENUM,GBL,FIEN,REPA,REPB,MAPACT,DSUB,DLGUNMP,STATUS,NL) ;
 S NL=NL+1,^TMP("PXRMXMZ",$J,NL,0)=""
 N AIEN,DA,DIE,DISABLE,DISTXT,DR,DIEN,EDITHIS,EDTEXT,FIELD,FIELDNAM
 N FILESTAT,FINDNAME,ISLOCK,LOCK,NAME,NODE,TEXT,TYPE
 ;
 I MAPACT'="U" S NL=NL+1,^TMP("PXRMXMZ",$J,NL,0)=" It is used in the following dialogs:"
 ;
 ;Unmapped write a message listing what dialog item contains the original
 ;term
 I DLGUNMP=1 D  Q
 .S NL=NL+1,^TMP("PXRMXMZ",$J,NL,0)=" The original term is used in the following dialogs:"
 .I '$D(^TMP($J,DSUB,GBL,+REPB)) S NL=NL+1,^TMP("PXRMXMZ",$J,NL,0)="  None" Q
 .S DA=0
 .F  S DA=$O(^TMP($J,DSUB,GBL,+REPB,DA)) Q:DA'>0  D
 ..S NODE=$G(^PXRMD(801.41,DA,0))
 ..S NAME=$P(NODE,U)
 ..S ISLOCK=$S(+$P(NODE,U,3)>0:1,1:0)
 ..S TYPE=$P(NODE,U,4)
 ..S DISTXT=$S(ISLOCK=1:" (DISABLED) ",1:" ")
 ..S TEXT="Dialog "_$S(TYPE="E":"element",TYPE="G":"group",TYPE="S":"result group",1:"item")
 ..S TEXT="  "_TEXT_" "_NAME_DISTXT_"IEN="_DA
 ..S NL=NL+1,^TMP("PXRMXMZ",$J,NL,0)=TEXT
 ;
 I '$D(^TMP($J,DSUB,GBL,FIEN)) S NL=NL+1,^TMP("PXRMXMZ",$J,NL,0)="  None" Q
 S DIE="^PXRMD(801.41,",DISABLE=1
 S DR="3////^S X=DISABLE"
 ;DBIA #4640
 S FILESTAT=+$$GETSTAT^HDISVF01(FILENUM)
 S LOCK=$S(FILESTAT=6:1,1:0)
 ;
 ;No replacement list dialog names, if file status of 6 disable the 
 ;dialog items if the term is inactive
 I MAPACT="N" D  G DIALOGX
 .S DA=0
 .F  S DA=$O(^TMP($J,DSUB,GBL,FIEN,DA)) Q:DA'>0  D
 ..S NODE=$G(^PXRMD(801.41,DA,0))
 ..S NAME=$P(NODE,U)
 ..S ISLOCK=$S(+$P(NODE,U,3)>0:1,1:0)
 ..S TYPE=$P(NODE,U,4)
 ..S DISTXT=$S(ISLOCK=1:" (DISABLED) ",1:" ")
 ..S TEXT="Dialog "_$S(TYPE="E":"element",TYPE="G":"group",TYPE="S":"result group",1:"item")
 ..;
 ..;File in state 6, dialog item not already disable, and finding item
 ..;is inactive
 ..I LOCK=1,ISLOCK=0,+STATUS=0 D
 ...S DISTXT=" (MADE INACTIVE) "
 ...D ^DIE
 ...S FINDNAME=$$GET1^DIQ(FILENUM,FIEN,.01,"","","")
 ...S EDTEXT="Disabled for inactive item "_FINDNAME
 ...D BLDDLGEH(.EDITHIS,DA,EDTEXT)
 ..S TEXT="  "_TEXT_" "_NAME_DISTXT_"IEN="_DA
 ..S NL=NL+1,^TMP("PXRMXMZ",$J,NL,0)=TEXT
 ;
 ;Do if MAPACT="M", only update items if file status is 6.
 I FILESTAT'=6 Q
 ;I FILESTAT'=6,FILESTAT'=7 Q
 S DA=0
 F  S DA=$O(^TMP($J,DSUB,GBL,FIEN,DA)) Q:DA'>0  D
 .S NAME=$P(^PXRMD(801.41,DA,0),U)
 .S TYPE=$P(^PXRMD(801.41,DA,0),U,4)
 .S TEXT="Dialog "_$S(TYPE="E":"element",TYPE="G":"group",TYPE="S":"result group",1:"item")_" "_NAME
 .S NL=NL+1,^TMP("PXRMXMZ",$J,NL,0)="  "_TEXT
 .;
 .S FIELD=0
 .F  S FIELD=$O(^TMP($J,DSUB,GBL,FIEN,DA,FIELD)) Q:FIELD'>0  D
 ..;additional loop for additional findings
 ..I FIELD=18 D  Q
 ...S AIEN=0
 ...F  S AIEN=$O(^TMP($J,DSUB,GBL,FIEN,DA,FIELD,AIEN)) Q:AIEN'>0  D
 ....D DIALUPD(FIEN,+REPA,GBL,FIELD,DA,AIEN,FILENUM,"Additional Finding item",.EDITHIS)
 ....S NL=NL+1,^TMP("PXRMXMZ",$J,NL,0)="   Additional Finding item was replaced."
 ..;
 ..S FIELDNAM=$S(FIELD=15:"Finding Item",FIELD=17:"Orderable Item",FIELD=119:"MH Test",1:" ")
 ..D DIALUPD(FIEN,+REPA,GBL,FIELD,DA,0,FILENUM,FIELDNAM,.EDITHIS)
 ..S NL=NL+1,^TMP("PXRMXMZ",$J,NL,0)="    "_FIELDNAM_" was replaced."
 ;
DIALOGX ;
 I '$D(EDITHIS) Q
 N CNT,EMSG,MESTXT
 S DA="" F  S DA=$O(EDITHIS(DA)) Q:DA'>0  D
 .K EMSG,MESTXT
 .S CNT=0 F  S CNT=$O(EDITHIS(DA,CNT)) Q:CNT'>0  S MESTXT(CNT)=EDITHIS(DA,CNT)
 .D UPEHIST^PXRMUTIL(801.41,DA,.MESTXT,.EMSG)
 .I $D(EMSG) D
 ..S NL=NL+1,^TMP("PXRMXMZ",$J,NL,0)="  Edit history update failed."
 ..D AERRMSG(.EMSG,.NL)
 Q
 ;
 ;==================================================================
DIALUPD(OLDVALUE,NEWVALUE,GBL,FIELD,DIEN,FIEN,FILENUM,FIELDNAM,EDITHIST) ;
 N EMSG,FDA,FIENS,FILE,NEWNAME,OLDNAME,TEXT
 S FILE=$S(FIEN>0:801.4118,1:801.41)
 I FILE=801.4118 S FIELD=.01
 S FIENS=$S(FIEN>0:FIEN_","_DIEN_",",1:DIEN_",")
 S FDA(FILE,FIENS,FIELD)=NEWVALUE_";"_GBL
 D UPDATE^DIE("","FDA","","EMSG")
 I $D(MSG) D  Q
 . S NL=NL+1,^TMP("PXRMXMZ",$J,NL,0)="  Dialog update failed."
 . D AERRMSG(.EMSG,.NL)
 S OLDNAME=$$GET1^DIQ(FILENUM,OLDVALUE,.01,"","","")
 S NEWNAME=$$GET1^DIQ(FILENUM,NEWVALUE,.01,"","","")
 S TEXT=FIELDNAM_" value "_OLDNAME_" replaced by "_NEWNAME_" for data mapping"
 D BLDDLGEH(.EDITHIST,DIEN,TEXT)
 Q
 ;
 ;==============================
ERROR(EVENT,NL) ;Error
 N IND
 S NL=NL+1,^TMP("PXRMXMZ",$J,NL,0)="An error occurred; error message text is -"
 S NL=NL+1,^TMP("PXRMXMZ",$J,NL,0)=" "_^XTMP(EVENT,"ERROR")
 S IND=0
 F  S IND=$O(^XTMP(EVENT,"ERROR",IND)) Q:IND=""  D
 . S NL=NL+1,^TMP("PXRMXMZ",$J,NL,0)=" "_^XTMP(EVENT,"ERROR",IND)
 Q
 ;
 ;==============================
EVDRVR ;Event driver for STS events.
 N DEFL,DIAL,DLGUNMP,FIEN,FIENS,FILENUM,FILES,FSTAT,GBL,MAPACT,NL
 N REPA,REPB,STATUS,TYPE
 S ZTREQ="@"
 K ^TMP($J,"DLG FIND"),^TMP($J,"FDATA"),^TMP($J,"PXRM DIALOGS"),^TMP("PXRMXMZ",$J)
 D BLDDLGTM("DLG FIND")
 S NL=1,^TMP("PXRMXMZ",$J,NL,0)="Protocol event summary:"
 ;Check for error.
 I $D(^XTMP(EVENT,"ERROR")) D ERROR(EVENT,.NL) G SEND
 S FILENUM=0
 F  S FILENUM=$O(^XTMP(EVENT,FILENUM)) Q:FILENUM=""  D
 .;Skip the STANDARD TERMINOLOGY VERSION FILE, it is not relevant
 .;for Clinical Reminders.
 . I FILENUM=4.009 Q
 . S FSTAT=$P($$GETSTAT^HDISVF01(FILENUM),U,1)
 . S GBL=$P($$GET1^DID(FILENUM,"","","GLOBAL NAME"),U,2)
 . S TYPE=""
 . F  S TYPE=$O(^XTMP(EVENT,FILENUM,TYPE)) Q:TYPE=""  D
 .. I TYPE="STATUS" Q
 .. S FIEN=""
 .. F  S FIEN=$O(^XTMP(EVENT,FILENUM,TYPE,FIEN)) Q:FIEN=""  D
 ...;Call processing routines.
 ... S FIENS=FIEN_","
 ...;DBIA #4631
 ... S STATUS=$$GETSTAT^XTID(FILENUM,"",FIENS)
 ... I $P(STATUS,U,3)="" S $P(STATUS,U,3)="UNDEFINED"
 ... I TYPE="NEW" D NEW(EVENT,FILENUM,FIEN,STATUS,.NL) Q
 ... I TYPE="BEFORE" Q
 ... I TYPE'="AFTER" D UNKNOWN(TYPE,.NL) Q
 ... S REPA=$G(^XTMP(EVENT,FILENUM,"AFTER",FIEN,"INHERITS FROM"))
 ... S REPB=$G(^XTMP(EVENT,FILENUM,"BEFORE",FIEN,"INHERITS FROM"))
 ...;MAP ACTION can be M (map) or U (unmap) or N (none).
 ...;Set the map action for displaying the status.
 ... S MAPACT=$S(REPA=REPB:"N",REPA'=(FIEN_";"_FILENUM):"M",1:"U")
 ... D STATUSTX(MAPACT,FILENUM,FIEN,REPA,REPB,STATUS,.NL)
 ... S DLGUNMP=$S(MAPACT="U":1,1:0)
 ...;Unless the file status is 6 do not do any automatic replacements.
 ... S MAPACT=$S(FSTAT'=6:"N",1:MAPACT)
 ...;Process the lists, doing replacements updates etc. and generate
 ...;a MailMan message describing what was done.
 ... D DEFLIST^PXRMFRPT(FILENUM,GBL,FIEN,"FDATA")
 ... D DEF(FILENUM,GBL,FIEN,REPA,MAPACT,.NL)
 ... D TERMLIST^PXRMFRPT(FILENUM,GBL,FIEN,"FDATA")
 ... D TERM(FILENUM,GBL,FIEN,REPA,MAPACT,.NL)
 ... D DIALOG(FILENUM,GBL,FIEN,REPA,REPB,MAPACT,"DLG FIND",DLGUNMP,STATUS,.NL)
 ;
 ;Deliver the MailMan message.
SEND D SEND^PXRMMSG("PXRMXMZ",SUBJECT,"",DUZ)
 K ^TMP($J,"DLG FIND"),^TMP($J,"FDATA"),^TMP($J,"PXRM DIALOGS"),^TMP("PXRMXMZ",$J),^XTMP(EVENT)
 Q
 ;
 ;==============================
GENTERM(FILENUM,IEN,REP,NL) ;Generate a term that contains the original
 ;definition finding and its replacement as mapped findings.
 N EMSG,FDA,FINDING,ROOT,TEMP,TEXT,TIEN,TIENS,TNAME,WPTMP
 S TNAME=$$GENTNAME(FILENUM,IEN)
 S TEMP="^PXRMD(811.5,"
 D SETSTART^PXRMCOPY(TEMP)
 S TIEN=$$GETFOIEN^PXRMCOPY(TEMP)
 S TIENS="+"_TIEN_","
 S FINDING=REP
 S ROOT=$P($$ROOT^DILFD(FILENUM),"^",2)
 S $P(FINDING,";",2)=ROOT
 S FDA(811.5,TIENS,.01)=TNAME
 S FDA(811.5,TIENS,.04)=DT
 S FDA(811.5,TIENS,100)="L"
 S FDA(811.5,TIENS,1)="WPTMP(1,1)"
 S WPTMP(1,1,1)="Autogenerated during STS protocol processing."
 S FDA(811.52,"+1,"_TIENS,.01)=FIEN_";"_ROOT
 S FDA(811.52,"+2,"_TIENS,.01)=FINDING
 S FDA(811.53,"+3,"_TIENS,.01)=$$NOW^XLFDT
 S FDA(811.53,"+3,"_TIENS,1)=$G(DUZ)
 S FDA(811.53,"+3,"_TIENS,2)="WPTMP(1,1)"
 D UPDATE^DIE("","FDA","","EMSG")
 I $D(EMSG) D  Q 0
 . S NL=NL+1,^TMP("PXRMXMZ",$J,NL,0)="  Term creation failed."
 . D AERRMSG(.EMSG,.NL)
 Q TIEN_";"_TNAME
 ;
 ;==============================
GENTNAME(FILENUM,IEN) ;Generate a new term name to use. Create it based on
 ;the original definition finding.
 N ABBR,FNAME,NLEN,TEMP,TNAME,TSTAMP
 S FNAME=$$GET1^DIQ(FILENUM,IEN,.01)
 ;DBIA #2991, #5149 for access to ^DD.
 S TEMP=$O(^DD(811.902,.01,"V","B",FILENUM,""))
 S ABBR=$P(^DD(811.902,.01,"V",TEMP,0),U,4)
 S TSTAMP=$$FMTE^XLFDT($$NOW^XLFDT,"5Z")
 ;Calculate the number of characters from the .01 we can use.
 ;AUTOGENERATED ABBR-NAME TIMESTAMP
 S NLEN=48-$L(ABBR)-$L(TSTAMP)
 S TNAME="AUTOGENERATED "_ABBR_"-"_$E(FNAME,1,NLEN)_" "_TSTAMP
 Q TNAME
 ;
 ;==============================
NEW(EVENT,FILENUM,FIEN,STATUS,NL) ;New entry in file.
 N FNAME,NAME
 S FNAME=$$GET1^DID(FILENUM,"","","NAME")
 S NAME=$P(^XTMP(EVENT,FILENUM,"NEW",FIEN,0),U,1)
 S NL=NL+1,^TMP("PXRMXMZ",$J,NL,0)=""
 S NL=NL+1,^TMP("PXRMXMZ",$J,NL,0)="======================================================"
 S NL=NL+1,^TMP("PXRMXMZ",$J,NL,0)="Added new "_FNAME_" named "_NAME_" status is "_$P(STATUS,U,3)
 Q
 ;
 ;==============================
RFWT(IEN,FI,TERM,NL) ;Definition finding has a replacement; change the
 ;finding to a term that is mapped to the original replacement and
 ;its replacement.
 N EMSG,FDA,TEXT
 S FDA(811.902,FI_","_IEN_",",.01)=$P(TERM,";",1)_";PXRMD(811.5,"
 D FILE^DIE("","FDA","EMSG")
 I $D(MSG) D
 . N ERRMSG,IND
 . S NL=NL+1,^TMP("PXRMXMZ",$J,NL,0)="  Error changing finding to term."
 . D AERRMSG(.EMSG,.NL)
 E  S NL=NL+1,^TMP("PXRMXMZ",$J,NL,0)="   Finding number "_FI_" changed to RT."_$P(TERM,";",2)
 S TEXT(1)="STS protocol automated update."
 S TEXT(2)="Finding number "_FI_" changed to RT."_$P(TERM,";",2)_"."
 D UPEHIST^PXRMUTIL(811.9,IEN,.TEXT,.EMSG)
 I $D(EMSG) D
 . S NL=NL+1,^TMP("PXRMXMZ",$J,NL,0)="  Edit history update failed."
 . D AERRMSG(.EMSG,.NL)
 Q
 ;
 ;==============================
STATUSTX(MAPACT,FILENUM,FIEN,REPA,REPB,STATUS,NL) ;Generate the status text.
 N ABBR,FNAME,NAME,RFNAME,RFNUM,RIEN,RNAME,TEMP
 S FNAME=$$GET1^DID(FILENUM,"","","NAME")
 S NAME=$$GET1^DIQ(FILENUM,FIEN,.01)
 S NL=NL+1,^TMP("PXRMXMZ",$J,NL,0)=""
 S NL=NL+1,^TMP("PXRMXMZ",$J,NL,0)="======================================================"
 S NL=NL+1,^TMP("PXRMXMZ",$J,NL,0)=FNAME_" entry "_NAME_" status is "_$P(STATUS,U,3)
 I MAPACT="M" D
 . S RIEN=$P(REPA,";",1)
 . S RFNUM=$P(REPA,";",2)
 . S RFNAME=$$GET1^DID(RFNUM,"","","NAME")
 . S RNAME=$$GET1^DIQ(RFNUM,RIEN,.01)
 . S NL=NL+1,^TMP("PXRMXMZ",$J,NL,0)=" Its replacement is "_RFNAME_"; "_RNAME_"."
 I MAPACT="U" D
 . S RIEN=$P(REPB,";",1)
 . S RFNUM=$P(REPB,";",2)
 . S RFNAME=$$GET1^DID(RFNUM,"","","NAME")
 . S RNAME=$$GET1^DIQ(RFNUM,RIEN,.01)
 . S NL=NL+1,^TMP("PXRMXMZ",$J,NL,0)=" It is being unmapped; originally mapped to "_RFNAME_"; "_RNAME_"."
 . S NL=NL+1,^TMP("PXRMXMZ",$J,NL,0)=" This finding may need to be manually removed."
 Q
 ;
 ;==============================
TERM(FILENUM,GBL,FIEN,REP,MAPACT,NL) ;Search all reminder terms for any
 ;that are using this finding, defined by the global (GBL) and the
 ;IEN (FIEN).
 N FI,IEN,TERM
 S NL=NL+1,^TMP("PXRMXMZ",$J,NL,0)=""
 S NL=NL+1,^TMP("PXRMXMZ",$J,NL,0)=" It is used in the following terms:"
 I '$D(^TMP($J,"FDATA",FILENUM,FIEN,"TERM")) S NL=NL+1,^TMP("PXRMXMZ",$J,NL,0)="  None" Q
 S IEN=0
 F  S IEN=$O(^TMP($J,"FDATA",FILENUM,FIEN,"TERM",IEN)) Q:IEN=""  D
 . S TERM=$P(^PXRMD(811.5,IEN,0),U,1)
 . S NL=NL+1,^TMP("PXRMXMZ",$J,NL,0)=""
 . S NL=NL+1,^TMP("PXRMXMZ",$J,NL,0)="  "_TERM_" IEN="_IEN
 . S FI=""
 . F  S FI=$O(^TMP($J,"FDATA",FILENUM,FIEN,"TERM",IEN,FI)) Q:FI=""  D
 .. S NL=NL+1,^TMP("PXRMXMZ",$J,NL,0)="   Finding number "_FI
 .. I MAPACT="M" D ATFND(IEN,FI,REP,.NL)
 Q
 ;
 ;==============================
UNKNOWN(TYPE,NL) ;Unknown event type.
 S NL=NL+1,^TMP("PXRMXMZ",$J,NL,0)=TYPE_" is an unknown event type."
 Q
 ;
