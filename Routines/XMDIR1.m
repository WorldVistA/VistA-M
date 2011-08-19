XMDIR1 ;(WASH ISC)/CAP-Load VACO Directories ;04/17/2002  08:47
 ;;8.0;MailMan;;Jun 28, 2002
 ; Entry points used by MailMan options (not covered by DBIA):
 ; OPTION   XMMGR-DIRECTORY-VACO
 Q
ENT ;Batch Entry point (TaskMan)
 K ZTREQ,^TMP("XMDIR1",$J) S XMA=0
 ;
 ;LOCK to indicate to XMA5 that MailLink in being updated
 L +^XMD("XMDIR1"):1 E  G RES:$D(ZTQUEUED) W !!,$C(7),"<<< This task seems to be running already !",!,"(It cannot be run multiple times concurrently.) >>>" G Q
 ;
 U IO(0) S XMDIR1A("CODE")=$S($G(XMDIR1A)=1:"1A",1:"1B")
 I '$D(ZTQUEUED) W !!,"Killing off old AUTOMATIC entries for this code ("_XMDIR1A("CODE")_").",!!
 N DIK
 S DA=0,DIK="^XMD(4.2997,"
 F XMA0=1:1 S DA=$O(^XMD(4.2997,"E",XMDIR1A("CODE"),DA)) Q:+DA'=DA  D ^DIK I '$D(ZTQUEUED),XMA0#10=0 W "."
 ;
 ;Kill off very old manual entries that haven't been used
 S DA=0,XMDIR1=$E(DT,1,5)-200,XMDIR1("CNT")=0
 F XMA0=XMA0:1 S DA=$O(^XMD(4.2997,"AC",DA)) Q:$S(DA>XMDIR1:1,DA="":1,1:0)  D ^DIK I '$D(ZTQUEUED),XMA0#10=0 W "."
 ;
 I '$D(ZTQUEUED) W !!,"Starting load",!!
 U IO
 ;Load WANG directory
 I $G(XMDIR1A("CODE"))="1A" D ^XMDIR1A
 ;
 ;Load NOAVA directory
 I $G(XMDIR1A("CODE"))="1B" D ^XMDIR1B
 ;
 K XMDIR1A,XMDIR1B
 I '$D(ZTQUEUED) W !!!,"Task Completed"
 ;
 S ^TMP("XMDIR1",$J,.0001)="Remote Directories summary:"
 S ^TMP("XMDIR1",$J,.0002)=""
 I $D(XMDIR1("W")) S ^TMP("XMDIR1",$J,.0003)=XMDIR1("W")_" Wang system records processed."
 I $D(XMDIR1("N")) S ^TMP("XMDIR1",$J,.0003)=XMDIR1("N")_" NOAVA system records processed."
 S XMSUB="REMOTE DIRECTORY AUTOMATIC UPDATE",XMTEXT="^TMP(""XMDIR1"",$J,"
 N XMDUZ S XMDUZ="|XMDIR1_REMOTE_DIRECTORY_UPDATE|",XMY("G.POSTMASTER@"_^XMB("NETNAME"))=""
 I $D(DUZ) S XMY(DUZ)=""
 I $O(XMY(0))="" S XMY(.5)=""
 D ^XMD K A
Q L -^XMD("XMDIR1") K ^TMP("XMDIR1",$J)
 Q
 ;
 ;Menu option to schedule task
OPTION G ENT:$D(ZTQUEUED)
 N %,%0,%1,%6,D,DA,I,J,X,Y,XMA0,XMB0,XMC0,XMDUZ,XMDIR1,XMSUB,XMY,XMTEXT
 W !!,"You are about to load a file containing a list of names and"
 W !,"addresses into you Remote User Directory (file 4.2997).  This"
 W !,"file originated either from a NOAVA system or a WANG system."
 W !,"Choose the correct file.  We will check it some for format.",!!
 S %ZIS("S")="I $P($G(^(""TYPE"")),U)[""HFS"""
 S %ZIS("A")="Enter either HFS-WANG-DIR or HFS-NOAVA-DIR: "
 S %ZIS("B")="HFS-NOAVA-DIR"
 S %ZIS="Q" D ^%ZIS Q:POP
 S XMF=IO,XMDIR1A=$S(ION="HFS-NOAVA-DIR":2,1:1)
 R !!,"Do you want your job queued? (Answer YES or NO)  NO// ",X:DTIME
 K D S:X="" X="NO" S X=$TR(X,"noyes","NOYES") I $E("YES",1,$L(X))=X S D=1
 W !!,"Before the update occurs entries older than 90 days in the directory"
 W !,"are deleted if they were automatically filed by this procedure."
 W !,"Manually entered entries are deleted if they haven't been used"
 W !,"for at least 2 years."
 W !!,"Users are informed that an update is occuring if they are using"
 W !,"MailLink help options.  But are allowed to continue.",!!
 R !!,"Are you sure you want to do this (Answer 'YES/NO'): NO//",X:DTIME
 S:X="" X="NO" S X=$TR(X,"noyes","NOYES") I $E("YES",1,$L(X))'=X W !!,"Nothing done.",$C(7),!! Q
 I '$G(D) G INT
 D ZTSK W !!,$C(7),"Task #"_ZTSK_" scheduled.",!!
 D ^%ZISC K ZTSK,ZTRTN,ZTDTH,XMDUZ,ZTDESC,IO("Q"),XMDIR1A,XMDIR1B
 Q
ER ;Display error
 S XMDIR1("CNT")=XMDIR1("CNT")+1,^TMP("XMDIR1",$J,XMDIR1("CNT"))=XME_":"_XMY Q
ZTSK ;Schedule to run in the evening
 S XMDUZ="[XMDIR1_DIRECTORY_CONVERSION]",ZTRTN="ENT^XMDIR1",ZTDTH=+$H_",64800",ZTSAVE("*")="",ZTDESC="Convert MailLink list"
 S ZTDTH="" D ^%ZTLOAD Q
 ;Job out this process from here
JOB S ZTQUEUED=1,U="^",(IO,IO(0))="" D DT^DICRW G XMDIR1
 ;Reschedule job to run later
RES S ZTREQ=$$HADD^XLFDT($H,,,5)_"^^MailLink Conversion Restart @ "_$H_"^XMZWANG" Q
HFSFILE S DIC="^%ZIS(1,",DIC(0)="AZQME",DIC("S")="I $P($G(^%ZIS(1,Y,""TYPE"")),U)[""HFS"""
 D ^DIC Q:Y<0
 S IOP=X D ^%ZIS Q:POP
 S XMF=$P(^%ZIS(1,IOS,0),U,2) Q
INT ;Interactive processing begins here
 S XMF=$P(^%ZIS(1,IOS,0),U,2)
 W !!,"Answer 'YES' if you mean 'YES'.  All other response mean 'NO'."
 W !,"The first file to be processed is for the "_XMF_"."
 W !,"Enter '^' to skip this portion of the process.",!!
 I $$NEWERR^%ZTER N $ETRAP,$ESTACK S $ETRAP=""
 S X="NOWANG^XMDIR1B",@^%ZOSF("TRAP")
 U IO R Y:1 U IO(0)
 W !!,"The following string was read from the first line of "_XMF_"."
 W !!,Y,!!,"Is this correct ? NO// " R %:DTIME
 S:%="" %="NO" S %=$TR(%,"noyes","NOYES")
 I $E("YES",1,$L(%))'=% D ^%ZISC Q
 W ! G ENT
