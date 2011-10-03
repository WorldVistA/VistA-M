PXRMP6IM ; SLC/PKR - Inits for PXRM*2.0*6 ;11/08/2007
 ;;2.0;CLINICAL REMINDERS;**6**;Feb 04, 2005;Build 123
 ;========================
ENVCHK ;Environment check.
 I '$$PATCH^XPDUTL("YS*5.01*85") D  Q
 . W !,"The required patch YS*5.01*85 is not installed, therefore PXRM*2.0*6 cannot"
 . W !,"be installed."
 . S XPDABORT=1
 N NLINES
 D HMHPTRS^PXRMP6IM(.NLINES,0)
 I NLINES>0 D
 . W !,"There are MH findings that cannot be converted; reminders, terms, and"
 . W !,"dialogs using these findings will not work properly."
 . W !!,"A message giving the details has been sent to the reminders mail group."
 . N ANS
 . S ANS=$$ASKYN^PXRMEUT("Y","Continue the installation")
 . I ANS=0 S XPDABORT=1
 ;Don't ask about disabling options and protocols since we are taking
 ;care of them automatically.
 S XPDDIQ("XPZ1")=0
 ;Make the default for inhibiting logins NO.
 S XPDDIQ("XPI1","B")="NO"
 Q
 ;
 ;========================
HMHPTRS(NLINES,REPOINT) ;Handle MH pointers. Check for 601 tests that are
 ;obsolete and change existing MH pointers in definitions, terms,
 ;and dialogs to point the new global 601.71.
 N DNAME,DTYPE,EM,FI,IEN,IENS,MHNAME,MSG,NEWPTR,NEWSC,NNCONV
 N OLDPTR,OLDSC,RNAME
 N STATUS,TEMP,TERMNAME,TEXT,TNAME,YS,YSCODE,YSDATA
 K ^TMP($J,"MH"),^TMP("PXRMXMZ",$J)
 ;Check definitions.
 S (IEN,NLINES,NNCONV)=0
 F  S IEN=+$O(^PXD(811.9,IEN)) Q:IEN=0  D
 . I '$D(^PXD(811.9,IEN,20,"E","YTT(601,")) Q
 . S TEMP=^PXD(811.9,IEN,0)
 . S RNAME=$P(TEMP,U,1)
 . I REPOINT D
 .. S TEXT="Changing MH pointers in reminder definition "_RNAME_" IEN="_IEN
 .. D BMES^XPDUTL(.TEXT)
 . S STATUS=$S($P(TEMP,U,6)=1:"INACTIVE",1:"ACTIVE")
 . S ^TMP($J,"MH",RNAME)=STATUS
 . S OLDPTR=""
 . F  S OLDPTR=$O(^PXD(811.9,IEN,20,"E","YTT(601,",OLDPTR)) Q:OLDPTR=""  D
 .. S FI=0
 .. F  S FI=$O(^PXD(811.9,IEN,20,"E","YTT(601,",OLDPTR,FI)) Q:FI=""  D
 ... K YS,YSDATA
 ... S YS("YS601")=OLDPTR
 ...;DBIA #5043
 ... D CONVERT^YTQPXRM6(.YSDATA,.YS)
 ... S NEWPTR=$P(YSDATA(2),U,1)
 ... I YSDATA(1)="[ERROR]" D
 .... S NEWPTR=109
 .... S MHNAME=$$GET1^DIQ(601,OLDPTR,.01,"","","")
 .... S NNCONV=NNCONV+1
 .... S ^TMP($J,"MH",RNAME,"FINDING",FI)=MHNAME
 ... I REPOINT D
 .... S TEXT="Converting finding number "_FI
 .... D MES^XPDUTL(.TEXT)
 .... S IENS=FI_","_IEN_","
 .... D UPDATE(811.902,IENS,.01,NEWPTR)
 ....;Convert the scale.
 .... S OLDSC=$P(^PXD(811.9,IEN,20,FI,0),U,12)
 ....;DBIA #5042
 .... S NEWSC=$S(OLDSC'="":$$OLDNEW^YTQPXRM3(NEWPTR,OLDSC),1:"")
 .... S $P(^PXD(811.9,IEN,20,FI,0),U,12)=NEWSC
 ;Format the message.
 I NNCONV>0 D
 . S NLINES=0,RNAME=""
 . F  S RNAME=$O(^TMP($J,"MH",RNAME)) Q:RNAME=""  D
 .. I '$D(^TMP($J,"MH",RNAME,"FINDING")) Q
 .. S TEXT="Reminder "_RNAME_", status "_^TMP($J,"MH",RNAME)_", has the following MH findings which cannot be converted:"
 .. S NLINES=NLINES+1,^TMP("PXRMXMZ",$J,NLINES,0)=TEXT
 .. S FI=""
 .. F  S FI=$O(^TMP($J,"MH",RNAME,"FINDING",FI)) Q:FI=""  D
 ... S TEXT="  Finding number "_FI_", MH instrument "_^TMP($J,"MH",RNAME,"FINDING",FI)
 ... S NLINES=NLINES+1,^TMP("PXRMXMZ",$J,NLINES,0)=TEXT
 .. S TEXT="This reminder will not function properly until it is repaired."
 .. S NLINES=NLINES+1,^TMP("PXRMXMZ",$J,NLINES,0)=TEXT
 .. S NLINES=NLINES+1,^TMP("PXRMXMZ",$J,NLINES,0)=" "
 ;
 ;Check terms.
 K ^TMP($J,"MH")
 S (IEN,NNCONV)=0
 F  S IEN=+$O(^PXRMD(811.5,IEN)) Q:IEN=0  D
 . I '$D(^PXRMD(811.5,IEN,20,"E","YTT(601,")) Q
 . S TEMP=^PXRMD(811.5,IEN,0)
 . S TERMNAME=$P(TEMP,U,1)
 . I REPOINT D
 .. S TEXT="Changing MH pointers in reminder term "_TERMNAME_" IEN="_IEN
 .. D BMES^XPDUTL(.TEXT)
 . S STATUS=$S($P(TEMP,U,6)=1:"INACTIVE",1:"ACTIVE")
 . S ^TMP($J,"MH",TERMNAME)=STATUS
 . S OLDPTR=""
 . F  S OLDPTR=$O(^PXRMD(811.5,IEN,20,"E","YTT(601,",OLDPTR)) Q:OLDPTR=""  D
 .. S FI=0
 .. F  S FI=$O(^PXRMD(811.5,IEN,20,"E","YTT(601,",OLDPTR,FI)) Q:FI=""  D
 ... K YS,YSDATA
 ... S YS("YS601")=OLDPTR
 ... D CONVERT^YTQPXRM6(.YSDATA,.YS)
 ... S NEWPTR=$P(YSDATA(2),U,1)
 ... I YSDATA(1)="[ERROR]" D
 .... S NEWPTR=109
 .... S MHNAME=$$GET1^DIQ(601,OLDPTR,.01,"","","")
 .... S NNCONV=NNCONV+1
 .... S ^TMP($J,"MH",TERMNAME,"FINDING",FI)=MHNAME
 ... I REPOINT D
 .... S TEXT="Converting finding number "_FI
 .... D MES^XPDUTL(.TEXT)
 .... S IENS=FI_","_IEN_","
 .... D UPDATE(811.52,IENS,.01,NEWPTR)
 ....;Convert the scale.
 .... S OLDSC=$P(^PXRMD(811.5,IEN,20,FI,0),U,12)
 ....;DBIA #5042
 .... S NEWSC=$S(OLDSC'="":$$OLDNEW^YTQPXRM3(NEWPTR,OLDSC),1:"")
 .... S $P(^PXRMD(811.5,IEN,20,FI,0),U,12)=NEWSC
 ;Format the message.
 I NNCONV>0 D
 . S TERMNAME=""
 . F  S TERMNAME=$O(^TMP($J,"MH",TERMNAME)) Q:TERMNAME=""  D
 .. I '$D(^TMP($J,"MH",TERMNAME,"FINDING")) Q
 .. S TEXT="Term "_TERMNAME_", status "_^TMP($J,"MH",TERMNAME)_", has the following MH findings which cannot be converted:"
 .. S NLINES=NLINES+1,^TMP("PXRMXMZ",$J,NLINES,0)=TEXT
 .. S FI=""
 .. F  S FI=$O(^TMP($J,"MH",TERMNAME,"FINDING",FI)) Q:FI=""  D
 ... S TEXT="  Finding number "_FI_", MH instrument "_^TMP($J,"MH",TERMNAME,"FINDING",FI)
 ... S NLINES=NLINES+1,^TMP("PXRMXMZ",$J,NLINES,0)=TEXT
 .. S TEXT="This term will not function properly until it is repaired."
 .. S NLINES=NLINES+1,^TMP("PXRMXMZ",$J,NLINES,0)=TEXT
 .. S NLINES=NLINES+1,^TMP("PXRMXMZ",$J,NLINES,0)=" "
 ;
 ;Check dialogs.
 N PXRMINST
 S PXRMINST=1
 K ^TMP($J,"MH")
 S (IEN,NNCONV)=0
 F  S IEN=+$O(^PXRMD(801.41,IEN)) Q:IEN=0  D
 . I $P($G(^PXRMD(801.41,IEN,1)),U,5)'["YTT(601," Q
 . S TEMP=^PXRMD(801.41,IEN,0)
 . S DNAME=$P(TEMP,U,1)
 . S DTYPE=$P(TEMP,U,4)
 . S STATUS=$S($P(TEMP,U,3)=1:"DISABLE",1:"ACTIVE")
 . S ^TMP($J,"MH",DNAME)=STATUS_U_DTYPE
 . I REPOINT D
 .. S TEXT="Changing MH pointers in reminder dialog "_DNAME_" IEN="_IEN
 .. D BMES^XPDUTL(.TEXT)
 . S OLDPTR=$P($P(^PXRMD(801.41,IEN,1),U,5),";")
 . K YS,YSDATA
 . S YS("YS601")=OLDPTR
 . D CONVERT^YTQPXRM6(.YSDATA,.YS)
 . S NEWPTR=$P(YSDATA(2),U,1)
 . I (YSDATA(1)="[ERROR]")!(NEWPTR="dropped") D
 .. S NEWPTR=109
 .. S MHNAME=$$GET1^DIQ(601,OLDPTR,.01,"","","")
 .. S NNCONV=NNCONV+1
 .. S ^TMP($J,"MH",DNAME,"FINDING",1)=MHNAME
 . I REPOINT D
 .. S IENS=IEN_","
 .. D UPDATE(801.41,IENS,15,NEWPTR)
 ;Format the message.
 I NNCONV>0 D
 . S DNAME=""
 . F  S DNAME=$O(^TMP($J,"MH",DNAME)) Q:DNAME=""  D
 .. I '$D(^TMP($J,"MH",DNAME,"FINDING")) Q
 .. S STATUS=$P(^TMP($J,"MH",DNAME),U,1)
 .. S DTYPE=$P(^TMP($J,"MH",DNAME),U,2)
 .. S DTYPE=$$EXTERNAL^DILFD(801.41,4,"",DTYPE,.EM)
 .. S TEXT="Dialog entry "_DNAME_", type "_DTYPE_", status "_STATUS_", has the following MH findings which cannot be converted:"
 .. S NLINES=NLINES+1,^TMP("PXRMXMZ",$J,NLINES,0)=TEXT
 .. S FI=""
 .. F  S FI=$O(^TMP($J,"MH",DNAME,"FINDING",FI)) Q:FI=""  D
 ... S TEXT="  Finding number "_FI_", MH instrument "_^TMP($J,"MH",DNAME,"FINDING",FI)
 ... S NLINES=NLINES+1,^TMP("PXRMXMZ",$J,NLINES,0)=TEXT
 .. S TEXT="This dialog will not function properly until it is repaired."
 .. S NLINES=NLINES+1,^TMP("PXRMXMZ",$J,NLINES,0)=TEXT
 .. S NLINES=NLINES+1,^TMP("PXRMXMZ",$J,NLINES,0)=" "
 . S TEXT="For instructions on what to do with these entries see the PXRM*2*6"
 . S NLINES=NLINES+1,^TMP("PXRMXMZ",$J,NLINES,0)=TEXT
 . S TEXT="Installation Guide."
 . S NLINES=NLINES+1,^TMP("PXRMXMZ",$J,NLINES,0)=TEXT
 . S NLINES=NLINES+1,^TMP("PXRMXMZ",$J,NLINES,0)=" "
 I NLINES=0 Q
 K ^TMP($J,"MH")
 D SEND^PXRMMSG("MH findings that cannot be converted")
 K ^TMP("PXRMXMZ",$J)
 Q
 ;
 ;========================
UPDATE(FILENUM,IENS,FIELD,IEN)   ;Update an MH finding.
 N FDA,MSG
 S FDA(FILENUM,IENS,FIELD)="MH.`"_IEN
 D UPDATE^DIE("E","FDA","","MSG")
 I $D(MSG) D
 . N TEXT
 . D ACOPY^PXRMUTIL("MSG","TEXT()")
 . D BMES^XPDUTL("The MH update failed, UPDATE^DIE returned the following error message:")
 . D MES^XPDUTL(.TEXT)
 . D MES^XPDUTL("Examine the above error message for the reason.")
 Q
 ;
