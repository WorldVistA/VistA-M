IBCNFRD ;WOIFO/PO/KJS - Electronic Insurance Identification ;25-MAY-2011
 ;;2.0;INTEGRATED BILLING;**457**;21-MAR-94;Build 30
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;;
 ;
 ; Electronic Insurance Indentification  Sending and Receiving AITC messages
 ;
 Q
 ;
GAITCMSG ; Get AITC Messages
 ;This routine is called when AITC sends the Result file message and/or Confirmation messages to
 ;IBCNF EII GET SERVER option a server type option that is the member of G.IBN mail group.
 N IBCNFPAR,I
 F I=1:1 L +^XTMP("IBCNFRD"):5 I $T Q  ;Only want one job at a time processing data
 ;
 ;Get the IB configuration Parameters.
 D GETPARAM(.IBCNFPAR)
 ;
 ;If eII Active field is not active quit 
 I 'IBCNFPAR(13.02) G EXIT
 ;
 ; Read the Message
 N IBXMZ,XMER,XMRG,XPOS,XMA,IBFIRST,IBMSG,IBAUSTIN,IBCONFIRM,IBREC,IBLAST,MSGID,IBCNT,REC,RECSAV,SEQ,LEN,RECP
 ;Set the zero node of ^XTMP as rquired by SAC standards.
 S:'$O(^XTMP("IBCNFRD",0)) ^XTMP("IBCNFRD",0)=$$FMADD^XLFDT(DT,30)_U_DT_U_" From IBCNF EII GET SERVER option, a member of G.IBN mail group."
 S IBXMZ=$G(XMZ)
 K ^XTMP("IBCNFRD",IBXMZ)
 ;
 S REC="",RECSAV="",XMA=0,IBLAST=0
 F  D  Q:XMER<0
 . D REC^XMS3 ; Receive a line
 . Q:XMER<0  ; Check for end of message
 .;keep accummulating record until a tilde is found
 . S LEN=$L(XMRG,"~")
 . F SEQ=1:1:LEN D
 .. S RECP=$P(XMRG,"~",SEQ)
 .. ;END OF MESSAGE INDICATOR
 .. Q:RECP="NNNN  "
 .. S REC=REC_RECP
 ..;last piece can't end with a tilde, so isn't ready for saving
 .. Q:SEQ=LEN
 .. S REC=REC_"~"
 ..;now save the reconstituted record
 .. S XMA=XMA+1
 ..;strip off the 13 char DMI header from the first record
 .. I XMA=1,REC'?1"Ref:".E S REC=$E(REC,14,$L(REC))
 .. I REC["### END OF FILE ### END OF FILE ###" S IBLAST=1 Q
 .. S ^XTMP("IBCNFRD",IBXMZ,XMA)=REC,REC=""
 ;
 ; update the LOG
 S IBNOW=$$NOW^XLFDT()
 S J=0
 K FDA,IENS
 S J=J+1
 S FDA(355.35103,"+"_J_",1,",.01)=IBXMZ
 S FDA(355.35103,"+"_J_",1,",.02)=IBNOW
 D UPDATE^DIE("","FDA"),MSG^DIALOG()
 ;
 ;SET VAPORIZE DATE TO TODAY+180
 S XMVAPOR=$$HTFM^XLFDT(+$H+180_","_$P($H,",",2))
 D VAPOR^XMXEDIT(IBXMZ,XMVAPOR,.XMINSTR,.XMMSG)
 ;
 I REC="NNNN  " G EXIT
 I REC'="" D
 . S XMA=XMA+1
 .;strip off the 13 char DMI header from the first record
 . I XMA=1,REC'?1"Ref:".E S REC=$E(REC,14,$L(REC))
 . I REC["### END OF FILE ### END OF FILE ###" S IBLAST=1 Q
 . S ^XTMP("IBCNFRD",IBXMZ,XMA)=REC
 ;
 S IBFIRST=$G(^XTMP("IBCNFRD",IBXMZ,1))
 ;
 ; If Confirmation message is received from AITC
 I IBFIRST?1"Ref:".E D CONFIRM(IBXMZ,IBFIRST) G EXIT
 ;
 ;Wait for last message indicator before processing messages into file
 ;
 I 'IBLAST G EXIT
 ; If message is a Result File 
 N TMPFILE
 S TMPFILE="TEMP.TXT"
 ; Unwrap the Result file
 D OPEN^%ZISH("RESFILE",IBCNFPAR(13.01),TMPFILE,"W")
 ;may need to notify IRM if can't create file
 I POP G EXIT
 S MSGID=0,IBCNT=0
 U IO
 F  S MSGID=$O(^XTMP("IBCNFRD",MSGID)) Q:'MSGID  D
 . S IBREC=0
 . F  S IBREC=$O(^XTMP("IBCNFRD",MSGID,IBREC)) Q:'IBREC  D
 .. S REC=^XTMP("IBCNFRD",MSGID,IBREC)
 .. ; Catch any leftover Confirmation messages in case anything went wrong on the initial processing
 .. I REC?1"Ref:".E D CONFIRM(MSGID,REC) Q
 .. S IBCNT=IBCNT+1
 .. W:IBCNT'=1 !
 .. W REC
 ;
 D CLOSE^%ZISH("RESFILE")
 ;Rename from temp file to actual file, must use the ;0 or the rename fails if a file exists with that name
 S SUCCESS=$$MV^%ZISH(IBCNFPAR(13.01),TMPFILE,IBCNFPAR(13.01),IBCNFPAR(13.03)_$S($$OS^%ZOSV="VMS":";0",1:""))
 ; Send Email to IBCNF EII IRM that Result file is ready
 N XMSUB,IBRESMSG,XMY,XMTEXT,IBNOW
 S XMSUB="HMS result file "_IBCNFPAR(13.01)_IBCNFPAR(13.03)_" is ready"
 S IBRESMSG(1)="HMS result file "_IBCNFPAR(13.01)_IBCNFPAR(13.03)_" has been created."
 S IBRESMSG(2)="It is ready to be uploaded to the insurance buffer file."
 S XMTEXT="IBRESMSG("
 S XMY("G.IBCNF EII IRM")=""
 D ^XMD
 ;
 D BLDXML^IBCNFRD2
 ; Update HMS Result File Status
 N DA,DIE
 S IBNOW=$$NOW^XLFDT()
 S DIE="^IBA(355.351,",DA=1,DR=".01///^S X=IBCNFPAR(13.03);.02///^S X=IBNOW" D ^DIE
 ;
 N IBD0
 S IBD0=$O(^IBA(355.351,0))
 I $O(^IBA(355.351,IBD0,1,0)) D
 . N DA,DIK
 . D CACTLOG(IBD0)        ; save the top-level fields of HMS result file status in the activity log sub-file.
 . ; kill the messages sub-file. 
 . S DA(1)=IBD0,DA=0
 . S DIK="^IBA(355.351,"_DA(1)_",1,"
 . F  S DA=$O(^IBA(355.351,IBD0,1,DA)) Q:'DA  D ^DIK
 ;
 ;Clean out held messages text now that it has been processed
 K ^XTMP("IBCNFRD")
 ;
EXIT ;COMMON EXIT POINT
 L -^XTMP("IBCNFRD")
 Q
 ;
CONFIRM(MSGID,REC) ;PROCESS CONFIRMATION MESSAGE
 ; Update the HMS Extract File Status
 N IBD0,IBD1,DA,DIE,DR,IBMSG,IBAUSTIN,IBCONFRM
 S IBMSG=+$P(REC,"message #",2)
 S IBAUSTIN=+$P(REC,"Austin ID #",2)
 S IBCONFRM=+$P(REC,"confirmation number ",2)
 S IBD0=$O(^IBA(355.35,"C",IBMSG,0))
 ;NO message found
 I 'IBD0 G CONFEND
 S IBD1=$O(^IBA(355.35,"C",IBMSG,IBD0,0))
 ;NO message found
 I 'IBD1 G CONFEND
 S DA=IBD1,DA(1)=IBD0
 S DIE="^IBA(355.35,"_DA(1)_",1,"
 S DR=".03///^S X=IBAUSTIN;.04///^S X=IBCONFRM" D ^DIE
 ;
CONFEND ;
 ;
 K ^XTMP("IBCNFRD",MSGID)
 Q
 ;
CACTLOG(IBD0) ; create the activity log of HMS extract file status 
 N IBCDT,IBD1,IBNODE,FDA,J,K,IENS,REALJ
 ;
 ; create the the activity log subfile.
 S IBCDT=$P(^IBA(355.351,IBD0,0),U,2)
 S J=0
 K FDA,IENS
 S J=J+1
 S FDA(355.3511,"+"_J_",1,",.01)=IBCDT
 D UPDATE^DIE("","FDA","IENS"),MSG^DIALOG()
 S REALJ=IENS(J)
 K FDA,IENS
 S IBD1=0,K=J
 F  S IBD1=$O(^IBA(355.351,IBD0,1,IBD1)) Q:'IBD1  D
 . S IBNODE=^IBA(355.351,IBD0,1,IBD1,0)
 . S K=K+1
 . S FDA(355.35111,"+"_K_","_REALJ_",1,",.01)=$P(IBNODE,U)
 . S FDA(355.35111,"+"_K_","_REALJ_",1,",.02)=$P(IBNODE,U,2)
 I $D(FDA) D UPDATE^DIE("","FDA","IENS"),MSG^DIALOG()
 Q
 ;
GETPARAM(IBCNFPAR) ;
 ; Get eII parameters from IB Site Parameters file  into IBCNFPAR array
 ;
 N IBACT,IBTYPE,IBFILE,IBQUEADD,IBDUEMSG,IBLTMSG,IBSUB2,IBSUB3,IBSUBIEN,IBARRAY
 ;
 D GETS^DIQ(350.9,"1,","13.01:13.07;13.08*","I","IBARRAY")
 S IBCNFPAR(13.01)=IBARRAY(350.9,"1,",13.01,"I")  ; (#13.01) HMS DIRECTORY [1F]
 S IBCNFPAR(13.02)=IBARRAY(350.9,"1,",13.02,"I")  ; (#13.02) EII ACTIVE [2S]
 S IBCNFPAR(13.03)=IBARRAY(350.9,"1,",13.03,"I")  ; (#13.03) RESULT FILE NAME [3F]
 S IBCNFPAR(13.04)=IBARRAY(350.9,"1,",13.04,"I")  ; (#13.04) DAY OF MONTH RESULT FILE DUE [4N]
 S IBCNFPAR(13.05)=IBARRAY(350.9,"1,",13.05,"I")  ; (#13.05) DAYS BEFORE LATE MESSAGE SENT [5N]
 S IBCNFPAR(13.06)=IBARRAY(350.9,"1,",13.06,"I")  ; (#13.06) MAX EXT FILE QUE CONFIRM TIME [6N
 S IBCNFPAR(13.07)=IBARRAY(350.9,"1,",13.07,"I")  ; (#13.07) MAX NUM OF RECORDS PER MESSAGE [7N] 
 ;
 ; get the EXTRACT FILES sub-file values for active extract files.
 S IBSUB2=""
 F  D  Q:IBSUB2=""
 . S IBSUB2=$O(IBARRAY(350.9006,IBSUB2)) Q:IBSUB2="" 
 . S IBSUBIEN=$P(IBSUB2,",",1)
 . S IBSUB3=""
 .F  D  Q:IBSUB3=""
 .. S IBSUB3=$O(IBARRAY(350.9006,IBSUB2,IBSUB3)) Q:IBSUB3=""
 .. S IBACT=$G(IBARRAY(350.9006,IBSUB2,.02,"I"))     ; (#.02) EXTRACT FILE ACTIVE [2S] 
 .. I IBACT=1 D
 ... S IBTYPE=$G(IBARRAY(350.9006,IBSUB2,.01,"I"))   ; (#.01) EXTRACT FILE TYPE [1F] 
 ... S IBFILE=$G(IBARRAY(350.9006,IBSUB2,.03,"I"))   ; (#.03) FILE NAME [3F]
 ... S IBQUEADD=$G(IBARRAY(350.9006,IBSUB2,.04,"I")) ; (#.04) AITC DMI QUEUE NAME [4F]
 ... S IBDUEMSG=$G(IBARRAY(350.9006,IBSUB2,.05,"I")) ; (#.05) DAY OF MONTH EXTRACT FILE DUE [5N]
 ... S IBLTMSG=$G(IBARRAY(350.9006,IBSUB2,.06,"I"))  ; (#.06) DAYS BEFORE LATE MESSAGE SENT [6N]
 ... S IBCNFPAR(13.08,IBSUBIEN)=IBTYPE_U_IBACT_U_IBFILE_U_IBQUEADD_U_IBDUEMSG_U_IBLTMSG
 Q
 ;
