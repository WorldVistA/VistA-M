XMP3 ;(WASH ISC)/AML/CAP-PackMan Build Backup Msg ;04/17/2002  11:07
 ;;8.0;MailMan;;Jun 28, 2002
ENTER ; This routine backs up what's on disk into a packman message.
 S X=""
 Q:$D(XMPKIDS)
 N XMABORT,XMANSER
 S XMABORT=0
 D QBACKUP(.XMANSER,.XMABORT) I XMABORT S X=U Q
 I 'XMANSER W !,"No backup message built.",! Q
 D BACKUP(XMDUZ,XMZ,.XMP2,.XMABORT) I XMABORT S X=U
 Q
QBACKUP(Y,XMABORT) ;
 N DIR,DIRUT,X
 W !!,"Routines are the only parts that are backed up.  NO other parts"
 W !,"are backed up, not even globals.  You may use the 'Summarize Message'"
 W !,"option of PackMan to see what parts the message contains."
 W !,"Those parts that are not routines should be backed up separately"
 W !,"if they need to be preserved.",!!
 S DIR(0)="Y"
 S DIR("A")="Shall I preserve the routines on disk in a separate back-up message"
 S DIR("B")="YES"
 S DIR("?",1)="If YES I will build a MailMan message containing the routines that will"
 S DIR("?",2)="be replaced by the Install."
 S DIR("?")="If NO then you will have no automatic backup of routines."
 D ^DIR I $D(DIRUT) S XMABORT=1
 Q
BACKUP(XMDUZ,XMZ,XMSELECT,XMABORT) ;
 ;Initialize message, reset & quit if abort
 N XMINSTR,XMPXMZ
 D BINIT(XMDUZ,.XMPXMZ,.XMINSTR,.XMABORT) Q:XMABORT
 D BTEXT(XMZ,.XMSELECT,XMPXMZ)
 D MOVEPART^XMXSEND(XMDUZ,XMPXMZ,.XMINSTR)
 D SEND^XMKP(XMDUZ,XMPXMZ,.XMINSTR)
 D CHECK^XMKPL
 D CLEANUP^XMXADDR
 W !,"PackMan backup message [",XMPXMZ,"] sent."
 Q
BTEXT(XMZ,XMSELECT,XMPXMZ) ;
 N XCNP,XMCN,XMREC,XMTYPE
 S XCNP=1,XMCN=0
 F  S XMCN=$O(^XMB(3.9,XMZ,2,XMCN)) Q:XMCN'>0  S XMREC=^(XMCN,0)  D
 . Q:$E(XMREC)'="$"
 . Q:"^$TXT^$END^"[(U_$E(XMREC,1,4)_U)
 . S XMTYPE=$E(XMREC,2,4)
 . D @($S(":ROU:GLB:GLO:DDD:DAT:OPT:HEL:BUL:KEY:FUN:PKG:RTN:DIE:DIB:DIP:"[(":"_XMTYPE_":"):XMTYPE,1:"NO"))
 Q
ROU ;save routine
 N X,XMROU
 S X=$P(XMREC," ",2) S:X[U X=$P(X,U,2)
 X ^%ZOSF("TEST") E  W !,"Routine ",X," is not on the disk." Q
 I $O(XMSELECT(""))="" D BROU Q
 S XMROU=""
 F  S XMROU=$O(XMSELECT(XMROU)) Q:XMROU=""!(X=XMROU)  I $E(XMROU,$L(XMROU))="*" Q:$E(X,1,$L(XMROU)-1)=$E(XMROU,1,$L(XMROU)-1)
 D:XMROU'="" BROU
 Q
BROU ;
 N DIF
 S DIF="^XMB(3.9,XMPXMZ,2,"
 S XCNP=XCNP+1
 S ^XMB(3.9,XMPXMZ,2,XCNP,0)="$ROU "_X_" (PACKMAN-BACKUP)"
 X ^%ZOSF("LOAD")
 S ^XMB(3.9,XMPXMZ,2,XCNP,0)="$END ROU "_X_" (PACKMAN-BACKUP)"
 S ^XMB(3.9,XMPXMZ,2,0)="^3.92A^"_XCNP_U_XCNP_U_DT
 Q
GLO ;New global section
GLB ;global...save the part to be updated
 W !,"GLOBAL..................NO BACKUP" Q
DDD ;data dictionary...
 W !,"DATA DICTIONARY.........NO BACKUP" Q
DAT ;fileman data...what to do
 W !,"FILEMAN DATA............NO BACKUP" Q
OPT ;Options
 W !,"OPTIONS.................NO BACKUP" Q
HEL ;Help Frames
 W !,"HELP FRAMES.............NO BACKUP" Q
BUL ;Bulletins
 W !,"BULLETINS...............NO BACKUP" Q
KEY ;Security Keys
 W !,"SECURITY KEYS...........NO BACKUP" Q
FUN ;Functions
 W !,"FUNCTIONS...............NO BACKUP" Q
PKG ;Package File
 W !,"PACKAGE FILE............NO BACKUP" Q
RTN ;Routine Documentation
 W !,"ROUTINE DOCUMENTATION...NO BACKUP" Q
DIE ;Input Templates
 W !,"INPUT TEMPLATES.........NO BACKUP" Q
DIP ;Print Templates
 W !,"PRINT TEMPLATES.........NO BACKUP" Q
DIB ;Sort Templates
 W !,"SORT TEMPLATES..........NO BACKUP" Q
NO ;no way
 W !,"UNDEFINED FUNCTION" Q
BINIT(XMDUZ,XMPXMZ,XMINSTR,XMABORT) ; setup for first routine
 N XMSUBJ,XMREC,XMDT
 D SUBJ^XMJMS(.XMSUBJ,.XMABORT) Q:XMABORT
 D CRE8XMZ^XMXSEND(XMSUBJ,.XMPXMZ,1) I XMPXMZ<1 S XMABORT=1 Q
 D INIT^XMXADDR
 D TOWHOM^XMJMT(XMDUZ,"Send",.XMINSTR,"",.XMABORT)
 I XMABORT D KILLMSG^XMXUTIL(XMPXMZ) Q
 W !,"Building PackMan backup message with subject ",XMSUBJ,!!
 S XMDT=$E($$NOW^XLFDT_"0000",1,12)
 S XMREC="PACKMAN BACKUP Created on "_$$DOW^XLFDT(XMDT)_", "_$$FMTE^XLFDT($P(XMDT,".",1),"2Z")_" at "_$E(XMDT,9,10)_":"_$E(XMDT,11,12)_" "
 I $D(DUZ),$D(^VA(200,DUZ,0)) S XMREC=XMREC_"by "_$$NAME^XMXUTIL(DUZ)_" "
 S:$D(^XMB("NETNAME")) XMREC=XMREC_"at "_$P(^("NETNAME"),U)_" "
 S ^XMB(3.9,XMPXMZ,2,0)=""
 S ^XMB(3.9,XMPXMZ,2,1,0)="$TXT "_XMREC
 Q
