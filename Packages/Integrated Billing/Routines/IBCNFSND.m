IBCNFSND ;WOIFO/PO - Electronic Insurance Identification ;12/23/2011
 ;;2.0;INTEGRATED BILLING;**457**;21-MAR-94;Build 30
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;;
 ;
 ; Sending Extract files and checking status of file transfers.
 ;
 Q
 ;
SENDEII ; send HMS extract files and check status of files transfers. 
 ; this subroutine is called from IBAMTC routine which is an scheduled job running once a day. 
 ;
 N IBNOTREC,IBNOEXT,IBCNFPAR,IBCRDT,IBD0,IBD1,IBEXTNOD,IBFARR,IBFILE,IBFLIST,IBFROM,IBFSPEC,IBMSGNUM,IBNOEXT
 N IBNUMMSG,IBNUMREC,IBPSTDUE,IBSUB1,IBTEXT,IBTO,IBXMSUB,IBXMY,IBNORES,IBMAXREC,IBAKEEP,IBXMZ
 N X,Y,DA,DIC,DIK,D0,D1,D2,DG,DI,DIW,DICR,DIE,DLAYGO,DQ,DR,XMDUN,XMZ,IBFILEX,FNDFILE,FNDFILES
 ; get the IB configuration parameters and list of active extract files.
 D GETPARAM^IBCNFRD(.IBCNFPAR)
 ;
 I 'IBCNFPAR(13.02) QUIT                 ; if eII active field is not 1 quit. 
 ;
 S IBMAXREC=255                          ; message's maximum record line legth
 S IBAKEEP=6*30                          ; number of days to keep the activity logs before get purged.
 S IBTEXT="^TMP(""IBCNFCND_IBTEXT"",$J)" ; @IBTEXT@(1:nnn) array to store the extract file content.
 K @IBTEXT
 ;
 ; for each active extracted HMS file name.
 S IBSUB1=0
 F  S IBSUB1=$O(IBCNFPAR(13.08,IBSUB1)) Q:'IBSUB1  D
 . S IBEXTNOD=IBCNFPAR(13.08,IBSUB1)
 . S IBFILE=$P(IBEXTNOD,U,3)    ; extract file name
 . ;
 . K DIC S DIC="^IBA(355.35,",DIC(0)="QZL",X=$P(IBEXTNOD,U,1) D ^DIC
 . S IBD0=+Y
 . S IBCRDT=$P(Y(0),U,2)   ;creation date time.
 . I 'IBCRDT S IBCRDT=$$NOW^XLFDT()   ; first time this type is created.
 . ;
 . ; Check message sub-file for all acknowledgements
 . ; want to do this first, so we can get the old ones cleared out
 . ; and put in activity log
 . ; 
 . I $O(^IBA(355.35,IBD0,1,0))  D 
 . . ; if confirmation messages are received for the extract file
 . . I $$CHKEXT(IBD0,IBFILE,$P(IBEXTNOD,U,4),.IBNOTREC) D 
 . . . D CACTLOG(IBD0)        ; save the top-level fields of HMS extract file status in the activity log sub-file.
 . . . ; kill the messages sub-file. 
 . . . S DA(1)=IBD0,DA=0
 . . . S DIK="^IBA(355.35,"_DA(1)_",1,"
 . . . F  S DA=$O(^IBA(355.35,IBD0,1,DA)) Q:'DA  D ^DIK
 . ;
 . ; check, if the extract file exits.
 . K IBFSPEC,IBFLIST,FNDFILES
 . S IBFSPEC(IBFILE)=""
 . ;process all the versions of files
 . F  K IBFLIST S FNDFILE=$$LIST^%ZISH(IBCNFPAR(13.01),"IBFSPEC","IBFLIST") Q:'FNDFILE  D
 . . S FNDFILES(IBFILE)=""
 . . ;Get the full name of the first file found (includes version number for VMS based systems)
 . . S IBFILEX=$O(IBFLIST(""))
 . . ;
 . . ; set the file creation date/time.
 . . S DIE="^IBA(355.35,",DA=IBD0,DR=".02///^S X=$$NOW^XLFDT()" D ^DIE
 . . ;
 . . ; open the eII file and read the content into @IBTEXT@ global and cut the 
 . . ; records to 255 (IBMAXREC) character chunks if more than 255 (IBMAXREC) characters.
 . . D FILERD(IBCNFPAR(13.01),IBFILEX,IBTEXT)
 . . ;
 . . ; build the file message(s)with the maximum number of lines per message.
 . . ; and send the file message(s) to related AITC queue.
 . . S IBNUMREC=$O(@IBTEXT@(""),-1)                  ; number of records
 . . S IBNUMMSG=IBNUMREC\IBCNFPAR(13.07)             ; number of message to be sent 
 . . S:IBNUMREC#IBCNFPAR(13.07) IBNUMMSG=IBNUMMSG+1  ; add one message if number records is not multiple of max number of records
 . . S:IBNUMMSG<1 IBNUMMSG=1                         ; make sure at least one message is sent if the extract file is empty
 . . F IBMSGNUM=1:1:IBNUMMSG D
 . . . S IBFROM=((IBMSGNUM-1)*IBCNFPAR(13.07)+1)
 . . . S IBTO=IBMSGNUM*IBCNFPAR(13.07)
 . . . S:IBTO>IBNUMREC IBTO=IBNUMREC
 . . . S IBXMSUB="HMS eII Extracted file "_IBFILE_" MSG("_IBMSGNUM_"/"_IBNUMMSG_")"
 . . . S IBXMY($P(IBEXTNOD,U,4))=""                 ; send it to associated ATIC queue address e.g. XXX@Q-IBN.domain.ext
 . . . S IBXMZ=$$MSGSEND(.IBXMY,IBXMSUB,IBTEXT,IBFROM,IBTO,IBMAXREC)
 . . . ;
 . . . ; set the purge date for the message in message(#3.9) file
 . . . D VAPOR^XMXEDIT(IBXMZ,$$HTFM^XLFDT(+$H+IBAKEEP_","_$P($H,",",2)))
 . . . ;
 . . . ; record the creation date/time and the time the message(s) were sent in HMS Extract File Status                                                      
 . . . K DIC S DA(1)=IBD0,DIC(0)="MLF",DLAYGO=355.35
 . . . S DIC="^IBA(355.35,"_DA(1)_",1,"
 . . . S DIC("DR")=".02///^S X=$$NOW^XLFDT()"
 . . . S X=IBXMZ
 . . . D FILE^DICN
 . . ; delete the file using its full name
 . . S IBFARR(IBFILEX)=""
 . . S Y=$$DEL^%ZISH(IBCNFPAR(13.01),$NA(IBFARR))
 . ;   
 . I '$D(FNDFILES(IBFILE)) D   ;else if extracted file does not exist, save the file name to be reported.
 . . S IBPSTDUE=$$FILEDUE^IBCNFSND($P(IBEXTNOD,U,5),$P(IBEXTNOD,U,6),IBCRDT)
 . . S:IBPSTDUE IBNOEXT(IBFILE)=""
 ;
 ; send an email to IBCNF EII IRM mail group with list of files and messages that their 
 ; confirmation messages are not received within the given time. then re-send the message to ATIC.
 I $D(IBNOTREC)>0 D
 . D MSGNOTRC^IBCNFSND(.IBNOTREC)
 . D RESNDMSG(.IBNOTREC,IBAKEEP)
 ;
 ; if extract files are not created withing the give time send an email to IBCNF EII IRM mail group.
 I $D(IBNOEXT)>0 D MSGNOEXT^IBCNFSND(.IBNOEXT)
 ;
 ; if a Result File is not received within the due time  
 ;               Send an email to IBCNF EII IRM mail group
 S IBCRDT=+$P($G(^IBA(355.351,1,0)),U,2)
 S IBPSTDUE=$$FILEDUE^IBCNFSND(IBCNFPAR(13.04),IBCNFPAR(13.05),IBCRDT)
 I IBPSTDUE>0 D MSGNORES^IBCNFSND(IBCNFPAR(13.03))
 ;
 ; purge the entries older than  6 months in Activity Log sub-file of  
 ; HMS Extract File Status and HMS Result File Status 
 D PURGELOG(IBAKEEP) ; purge the activity logs of HMS extract file status and HMS result file status 
 ;
 K @IBTEXT
 ;
 Q
 ;
FILEDUE(IBDUEDAY,IBLTDAY,IBCRDT,IBNOW) ;  check if  file is due
 ;  input: IBDEUDAY - day of the month the file is due
 ;         IBLTDAY  - number of days after day of month to declare file is late
 ;         IBCRDT   - date/time last file was processed
 ; output: 1 - if file is due
 ;         0 - if file is not due 
 ;
 N IBLDM,IBDUEDT,IBLATEDT,LATE,PREVDUE,IBFDOM,IBPFDOM,PLATEDT
 S IBNOW=$G(IBNOW,$$NOW^XLFDT())
 S LATE=0
 ; if day of month file due day is 0 retrun 0, since this is as needed file.
 I 'IBDUEDAY Q LATE                             ; do not check assume not past  due. 
 S IBNOW=IBNOW\1                       ; current date
 S IBCRDT=IBCRDT\1
 ;
 ; calculate the due date and passed due late date.
 S IBLDM=$E($$SCH^XLFDT("1M(L@1A)",IBNOW)\1,6,7)  ; last day of month
 I IBDUEDAY>IBLDM S IBDUEDAY=IBLDM           ; if due day greater than last day of currnt month set it to last date of current month.
 S IBDUEDT=$E(IBNOW,1,5)_$S($L(IBDUEDAY)>1:IBDUEDAY,1:"0"_IBDUEDAY)
 S IBLATEDT=$$FMADD^XLFDT(IBDUEDT,IBLTDAY)   ; calculate late date
 ;FIRST OF THIS MONTH
 S IBFDOM=$E(IBNOW,1,5)_"01"
 ;MINUS ONE GETS LAST DAY OF PREVIOUS MONTH
 S IBLDMP=$$HTFM^XLFDT($$FMTH^XLFDT(IBFDOM,1)-1,1)
 ; SETUP FIRST DAY OF PREV MONTH TO CALCULATE DUE DATE OF PREV MONTH
 S IBPFDOM=$E(IBLDMP,1,5)_"01"
 ;NOW CALCULATE DUE DATE OF PREV MONTH
 S PREVDUE=$E(IBPFDOM,1,5)_$S($L(IBDUEDAY)>1:IBDUEDAY,1:"0"_IBDUEDAY)
 I PREVDUE>IBLDMP S PREVDUE=IBLDMP
 S PLATEDT=$$FMADD^XLFDT(PREVDUE,IBLTDAY)   ; calculate late date
 ;
 ; if current time greater than late date/time and creation time is less than due date/time,  the file due
 I IBNOW>IBLATEDT,IBCRDT<IBDUEDT S LATE=1
 I IBCRDT<PREVDUE,IBNOW>PLATEDT S LATE=1
 Q LATE                                                     ; file is not due.
 ;
MSGNORES(IBFILE) ; Notify G.IBCNF EII IRM mail group that the result file is not received
 ;  input: IBNORES - result file name 
 ; output: none
 ;
 N XMSUB,IBMSG,XMY,XMTEXT,IBNOW,IBX
 S XMSUB="Expected Result file has not been received."
 S IBNOW=$$NOW^XLFDT()
 S IBMSG(1)="Expected Result file "_IBFILE_" has not been received yet"
 S XMTEXT="IBMSG("
 S XMY("G.IBCNF EII IRM")=""
 D ^XMD
 Q
 ;
MSGNOEXT(IBNOEXT) ; Notify G.IBCNF EII IRM mail group that the extract file is not created
 ;  input: IBNOEXT(<file name>)="" list of the extract file names. 
 ; output: none
 ;
 N XMSUB,IBMSG,XMY,XMTEXT,IBNOW,IBX,IBFILE
 S XMSUB="Expected Extract files have not been created."
 S IBNOW=$$NOW^XLFDT()
 S IBMSG(1)="The following Extract file(s) have not been created yet:"
 S IBFILE=""
 S IBX=1
 F  S IBFILE=$O(IBNOEXT(IBFILE)) Q:IBFILE=""  D
 . S IBX=IBX+1
 . S IBMSG(IBX)="    "_IBFILE
 S XMTEXT="IBMSG("
 S XMY("G.IBCNF EII IRM")=""
 D ^XMD
 Q
 ;
MSGNOTRC(IBNOTREC) ; Notify G.IBCNF EII IRM mail group the confirmation messages are not received for extract files
 ;  input: IBNOTREC - array where
 ;             IBNOTREC((<file index>)= <file name> ^
 ;             IBNOTREC(<file index>, <message index>) = <message #> ^ 
 ; output: none
 ;
 N XMSUB,IBRESMSG,XMY,XMTEXT,IBNOW,I,IBX,J
 S XMSUB="Confirmation messages have not been received!!!"
 S IBNOW=$$NOW^XLFDT()
 S IBRESMSG(1)="Confirmation message(s) have not been received for the following file(s):"
 S IBX=1
 S I=0
 F  S I=$O(IBNOTREC(I)) Q:'I  D
 . S IBX=IBX+1
 . S IBRESMSG(IBX)="File Name: "_$P(IBNOTREC(I),U)
 . S J=0
 . F  S J=$O(IBNOTREC(I,J)) Q:'J  D
 . . S IBX=IBX+1
 . . S IBRESMSG(IBX)="    Msg #: "_$P(IBNOTREC(I,J),U)
 S XMTEXT="IBRESMSG("
 S XMY("G.IBCNF EII IRM")=""
 D ^XMD
 Q
 ;
CHKEXT(IBD0,IBFILE,IBAITC,IBNOTREC) ; For given extract file type check if all messages are confirmed.
 ;  input: IBD0   - ien of HMS extract file status (#355.35) 
 ;         IBFILE - file name
 ;         IBAITC = AITC DMI queue email address.
 ;
 ; output: IBNOTREC array where
 ;             IBNOTREC((<file index>)= file name^AITC DMI queue email address
 ;             IBNOTREC(<file index>, <message index>) = message # ^ send date time
 ;
 N IBD1,IBCONFRM,IBNOW,IBDIFF
 S IBNOW=$$NOW^XLFDT()
 S IBCONFRM=1
 S IBD1=0
 F  S IBD1=$O(^IBA(355.35,IBD0,1,IBD1)) Q:'IBD1  D
 . I $P($G(^IBA(355.35,IBD0,1,IBD1,0)),U,4)="" D     ;if AITC confirmation number is empty
 . . S IBCONFRM=0
 . . S IBDIFF=$$HDIFF^XLFDT($$FMTH^XLFDT(IBNOW),$$FMTH^XLFDT($P($G(^IBA(355.35,IBD0,1,IBD1,0)),U,2)),2)
 . . I IBDIFF>(IBCNFPAR(13.06)*3600) D     ; if no confirmation received within due time 
 . . . S IBNOTREC(IBD0,IBD1)=$P($G(^IBA(355.35,IBD0,1,IBD1,0)),U)_U_$P($G(^IBA(355.35,IBD0,1,IBD1,0)),U,2)
 . . . S IBNOTREC(IBD0)=IBFILE_U_IBAITC  ; keep track of file name to be sent to IRM mail group
 Q IBCONFRM
 ;
FILERD(DIR,FILE,IBTEXT) ; Read the extract file into @IBTEXT@ array
 ;  input: DIR      - HMS directory name 
 ;         FILE     - extract file name
 ; output: IBTEXT   - array name where file is read into as @IBTEXT@(<1...n>)
 ;
 ;
 N IBI,IBREC,I
 K @IBTEXT
 ; read the  file
 D OPEN^%ZISH("IBFILEX",DIR,FILE,"R")
 Q:POP
 U IO
 S IBI=0
 F  Q:$$STATUS^%ZISH  D
 . R IBREC:5
 . Q:$$STATUS^%ZISH
 . S IBI=IBI+1
 . S @IBTEXT@(IBI)=IBREC
 D CLOSE^%ZISH("IBFILEX")
 Q
 ;
MSGSEND(XMY,XMSUB,IBTEXT,IBFROM,IBTO,IBMAXREC) ; send the extract file text to AITC DMI Queue
 ;  input: XMY     - array of recipients names
 ;         XMSUB   - message subject  
 ;         IBTEXT  - array name where content of message is read from @IBTEXT@(IBFROM:IBTO)
 ;         IBFROM  - start of the message text in @IBTEXT@() array
 ;         IBTO    - end of the message text in @IBTEXT@() array 
 ;         IBMAXREC - maximum line length that can be put into each messge line.  
 ; output: returns the created message id
 ;
 N XMDUZ,XMTEXT,TEMPTEXT,I,IBI,J,IBREC
 S TEMPTEXT="TMP(""IBCNFSND_TEMP"",$J)"
 K @TEMPTEXT
 S IBI=0
 F J=IBFROM:1:IBTO D
 . S IBREC=@IBTEXT@(J)
 . F I=1:IBMAXREC:$L(IBREC) D
 . . S IBI=IBI+1
 . . S @TEMPTEXT@(IBI)=$E(IBREC,I,IBMAXREC+I-1)
 ;
 S @TEMPTEXT@(IBI+1)="NNNN"    ; insert the end of message marker as required by AITC.
 S XMTEXT=$E(TEMPTEXT,1,$L(TEMPTEXT)-1)_","    ;set XMTEXT in form of say "TMP(""IBCNFSND_TEMP"",$J,"
 S XMDUZ=.5    ;post master (.5 user id)
 ; send the message
 D ^XMD
 K @TEMPTEXT
 Q $G(XMZ)
 ;
CACTLOG(IBD0) ; create the activity log of HMS extract file status
 ;  input: IBD0 - ien of HMS extract file status (#355.35)
 ; output: none
 ; 
 N IBCDT,IBD1,IBNODE,DA,DIC,X,Y
 ; create the the activity log subfile.
 S IBCDT=$P(^IBA(355.35,IBD0,0),U,2)
 S DA(1)=IBD0,DIC(0)="MLF",DLAYGO=355.35
 S DIC="^IBA(355.35,"_DA(1)_",2,"
 S X=IBCDT D FILE^DICN
 ; create messages subfile of activity log subfile
 K DA,DIC,X
 S DA(2)=IBD0
 S DA(1)=+Y
 S IBD1=0
 F  S IBD1=$O(^IBA(355.35,IBD0,1,IBD1)) Q:'IBD1  D
 . S IBNODE=^IBA(355.35,IBD0,1,IBD1,0)
 . S DIC(0)="MLF"
 . S DIC="^IBA(355.35,"_DA(2)_",2,"_DA(1)_",1,"
 . S DIC("DR")=".02///^S X=$P(IBNODE,U,2);.03///^S X=$P(IBNODE,U,3);.04///^S X=$P(IBNODE,U,4)"
 . S X=$P(IBNODE,U)
 . D FILE^DICN
 Q
 ;
PURGELOG(IBAKEEP) ; purge the activity logs of HMS extract file status and HMS result file status 
 ;  input: IBAKEEP - number of days to keep the activity logs
 ; output: none
 ;
 N IBCRDT,IBNOW,IBSTART,IBD0,DA,DIK
 S IBNOW=$$NOW^XLFDT()
 S IBSTART=$$HTFM^XLFDT($$HADD^XLFDT($$FMTH^XLFDT(IBNOW),-IBAKEEP))
 ;
 ;  purge the HMS extract file status activity log.
 S IBD0=0
 F  S IBD0=$O(^IBA(355.35,IBD0)) Q:'IBD0  D 
 . S IBCRDT=""
 . F  S IBCRDT=$O(^IBA(355.35,IBD0,2,"B",IBCRDT)) Q:'IBCRDT  Q:IBCRDT>IBSTART  D
 . . ;W !, IBCRDT
 . . S DA(1)=IBD0
 . . S DA=$O(^IBA(355.35,IBD0,2,"B",IBCRDT,""))
 . . S DIK="^IBA(355.35,"_DA(1)_",2,"
 . . D ^DIK
 ;
 ;  purge the HMS result file status activity log.
 S IBD0=0
 F  S IBD0=$O(^IBA(355.351,IBD0)) Q:'IBD0  D 
 . S IBCRDT=""
 . F  S IBCRDT=$O(^IBA(355.351,IBD0,2,"B",IBCRDT)) Q:'IBCRDT  Q:IBCRDT>IBSTART  D
 . . S DA(1)=IBD0
 . . S DA=$O(^IBA(355.351,IBD0,2,"B",IBCRDT,""))
 . . S DIK="^IBA(355.351,"_DA(1)_",2,"
 . . D ^DIK
 Q
 ;
RESNDMSG(IBNOTREC,IBAKEEP) ; Resend the messages for which the confirmation messages are not received for extract files
 ;  input: IBNOTREC - array where
 ;             IBNOTREC((<file index>)= file name^AITC DMI queue email address
 ;             IBNOTREC(<file index>, <message index>) = message # ^ send date time
 ;         IBAKEEP = number of days before purge the new message 
 ; output: none
 ;
 N XMSUB,IBRESMSG,XMY,XMTEXT,IBNOW,IBD0,IBD1,XMZ,IBRESEND,IBAITC,XMDUZ,XMPOS
 S IBNOW=$$NOW^XLFDT()
 S IBD0=0
 ; for each extract file type get the list of unconfirmed messages.
 F  S IBD0=$O(IBNOTREC(IBD0)) Q:'IBD0  D
 . S IBAITC=$P(IBNOTREC(IBD0),U,2)    ; AITC DMI Queue email address.
 . S IBD1=0
 . F  S IBD1=$O(IBNOTREC(IBD0,IBD1)) Q:'IBD1  D
 . . S IBXMZ=$P(IBNOTREC(IBD0,IBD1),U)
 . . ; for this unconfirmed message, set AUSTIN ID and AITC Confirmation number to 0. 
 . . S DA=IBD1,DA(1)=IBD0
 . . S DIE="^IBA(355.35,"_DA(1)_",1,"
 . . S DR=".03///^S X=0;.04///^S X=0" D ^DIE
 . . ;
 . . ; get and resend the message, with the " - Re-Send:<old message id>"
 . . ; appended to the subject of the new message.
 . . D GMSGTXT(IBXMZ,.IBRESMSG)
 . . S IBRESEND=" - Re-Send:"
 . . S XMSUB=$$SUBGET^XMGAPI0(IBXMZ)
 . . S XMSUB=$S(XMSUB[IBRESEND:$P(XMSUB,IBRESEND,1),1:XMSUB)_IBRESEND_IBXMZ
 . . S XMY(IBAITC)=""                    ; AITC DMI queue address
 . . S XMTEXT="IBRESMSG("
 . . D ^XMD
 . . ;
 . . ; set the purge date for the message in message(#3.9) file
 . . D VAPOR^XMXEDIT(XMZ,$$HTFM^XLFDT(+$H+IBAKEEP_","_$P($H,",",2)))
 . . ;
 . . ; record the time, the message is re-sent in HMS Extract File Status                                                      
 . . K DIC S DA(1)=IBD0,DIC(0)="MLF",DLAYGO=355.35
 . . S DIC="^IBA(355.35,"_DA(1)_",1,"
 . . S DIC("DR")=".02///^S X=$$NOW^XLFDT()"
 . . S X=XMZ
 . . D FILE^DICN
 Q
 ;
GMSGTXT(XMZ,IBRESMSG) ; get message's txt 
 ;  input: XMZ - message id.
 ; output: IBRESMSG - array containing the message's txt
 ;
 N IBXMZ,XMER,XMA,XMRG
 K IBRESMSG
 S IBXMZ=$G(XMZ)
 S XMA=0
 F  D  Q:XMER<0
 . D REC^XMS3 ; receive a line
 . Q:XMER<0  ;  check for end of message
 . S XMA=XMA+1
 . S IBRESMSG(XMA)=XMRG
 Q
 ;
