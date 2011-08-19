HLCS2 ;SF/JC - More Communication Server utilities ; 10/04/2007  14:31
 ;;1.6;HEALTH LEVEL SEVEN;**14,40,43,49,57,58,82,84,109,122**;Oct 13, 1995;Build 14
 ;Per VHA Directive 2004-038, this routine should not be modified.
FWD ; Add supplemental clients from HLL("LINKS") to HLSUP array
 ;This enhancement also supports distribution of a message to
 ;the same client over multiple logical links.
 Q:'$D(HLL("LINKS"))
 N CNT,LNK,CLIAP
 S CNT=0,ROUTINE=1 F  S CNT=$O(HLL("LINKS",CNT)) Q:CNT<1  D
 . S PTR=$P(HLL("LINKS",CNT),"^"),LNK=$P(HLL("LINKS",CNT),"^",2)
 . Q:PTR=""  I +PTR<1 S PTR=$O(^ORD(101,"B",PTR,0)) Q:PTR<1
 . ;
 . ; patch HL*1.6*122: excluding subscribers defined in
 . ; HLP("EXCLUDE SUBSCRIBER",I) = ien of subscriber
 . N I,EXCLUDE
 . S (EXCLUDE,I)=0
 . F  S I=$O(HLP("EXCLUDE SUBSCRIBER",I)) Q:'I  D  Q:EXCLUDE
 .. N TEMP
 .. S TEMP=HLP("EXCLUDE SUBSCRIBER",I)
 .. I 'TEMP,TEMP]"" S TEMP=$O(^ORD(101,"B",TEMP,0))
 .. I TEMP=PTR S EXCLUDE=1
 . Q:EXCLUDE
 . ; 
 . Q:LNK=""  I +LNK<1 S LNK=$O(^HLCS(870,"B",LNK,0)) Q:LNK<1
 . Q:'$D(^HLCS(870,LNK))
 . S CLIAP=$$PTR^HLUTIL2(PTR)
 . ; patch HL*1.6*122: add the 3rd component as receiving facility
 . ; S HLSUP("S",PTR,+LNK)=CLIAP_$S(CLIAP<1:U_HLL("LINKS",CNT),1:"")
 . S HLSUP("S",PTR,+LNK)=CLIAP_U_$S(CLIAP<1:HLL("LINKS",CNT),1:$P(HLL("LINKS",CNT),"^",3))
 Q
ADD ;Deliver message to supplemental client list.
 ;Invoked by HLTP before and after processing normal clients
 ;Only processes remote links. Local clients must be subscribing
 ;protocols.
 Q:'$D(HLSUP("S"))
 N HLTCP,HLTCPI,HLTCPO,ZHLEIDS,ZLCLIENT,ZLOGLINK,ZMTIENS
 S ZHLEIDS=0 F  S ZHLEIDS=$O(HLSUP("S",ZHLEIDS)) Q:ZHLEIDS<1  D
 .S ZLOGLINK=0 F  S ZLOGLINK=$O(HLSUP("S",ZHLEIDS,ZLOGLINK)) Q:ZLOGLINK<1  D
 ..S ZLCLIENT=+HLSUP("S",ZHLEIDS,ZLOGLINK)
 ..I ZLCLIENT<1 S:$G(HLERROR)="" HLERROR="15^Invalid Subscriber Protocol in HLL('LINKS'): "_$P(HLSUP("S",ZHLEIDS,ZLOGLINK),U,2,9) Q
 .. ; patch HL*1.6*122 start
 .. ; S HLOGLINK=ZLOGLINK D SEND^HLMA2(ZHLEIDS,HLMTIEN,ZLCLIENT,"D",.ZMTIENS,ZLOGLINK),STATUS^HLTF0(+ZMTIENS,1)
 .. S HLOGLINK=ZLOGLINK
 .. ; 3rd component for receiving facility
 .. S ZMTIENS("REC-FACILITY")=$P(HLSUP("S",ZHLEIDS,ZLOGLINK),U,3)
 .. D SEND^HLMA2(ZHLEIDS,HLMTIEN,ZLCLIENT,"D",.ZMTIENS,ZLOGLINK)
 .. D STATUS^HLTF0(+ZMTIENS,1)
 .. ; patch HL*1.6*122 end
 .. ;
 K HLL("LINKS"),HLSUP
 Q
STALL ;STOP ALL LINKS AND FILERS
 N DIR,Y
 W ! S DIR(0)="Y",DIR("A")="Okay to shut down all Links and Filers"
 D ^DIR
 I 'Y!($D(DIRUT))!($D(DUOUT)) W !!,"Shutdown Aborted!" Q
 W !,"Shutting down all Links and Filers..."
 D CLEAR
 D LLP(1)
 Q
QUE ;Restart Filers and AUTOSTART Logical Links after system re-boot
 N DIR,Y
 I '$D(ZTQUEUED) D  Q:'Y!($D(DIRUT))!($D(DUOUT))
 .W ! S DIR(0)="Y",DIR("A")="Shutdown and restart ALL AUTOSTART links and filers. Okay"
 .D ^DIR
 .I 'Y!($D(DIRUT))!($D(DUOUT)) W !!,"RESTART Aborted!" Q
 .W !,"Restarting all Autostart-Enabled Links and Filers..."
 D CLEAR
 D STARTF
 D LLP(0)
 D STRT
 Q
CLEAR ;Reset state of 869.3
 S DA(1)=1,DA=0,DIK="^HLCS(869.3,1,2,"
 F  S DA=$O(^HLCS(869.3,DA(1),2,DA)) Q:DA<1  D ^DIK
 S DA=0,DIK="^HLCS(869.3,1,3,"
 F  S DA=$O(^HLCS(869.3,DA(1),3,DA)) Q:DA<1  D ^DIK
 Q
STARTF ;Start filers
 ;Get Defaults
 N TMP,PTR,DEFCNT,DA,HLCNT,HLNODE1
 S PTR=+$O(^HLCS(869.3,0)) Q:'PTR
 ;default # of incoming filers
 S HLNODE1=$G(^HLCS(869.3,PTR,1)),DEFCNT=+$P(HLNODE1,U) S:'DEFCNT DEFCNT=1
 F HLCNT=1:1:DEFCNT S TMP=$$TASKFLR^HLCS1("IN")
 ;default # of outgoing filers
 S DEFCNT=+$P(HLNODE1,U,2) S:'DEFCNT DEFCNT=1
 F HLCNT=1:1:DEFCNT S TMP=$$TASKFLR^HLCS1("OUT")
 Q
LLP(ALL) ;Stop Logical Links
 ;ALL=1 OR 0 IF zero, only AUTOSTART LINKS get stopped
 N HLDP,HLDP0,HLPARM0,HLPARM4,HLJ,X,Y S HLDP=0
 F  S HLDP=$O(^HLCS(870,HLDP)) Q:'HLDP  S HLDP0=$G(^(HLDP,0)),X=+$P(HLDP0,U,3) D:X
 .;skip this link if not stopping all and Autostart not enabled
 . I 'ALL&('$P(HLDP0,U,6)) Q
 . S HLPARM4=$G(^HLCS(870,HLDP,400))
 . ; patch HL*1.6*122
 . ; TCP Multi listener: quit if TCP service as GT.M, DSM,
 . ; or Cache/VMS
 . I $P(HLPARM4,U,3)="M" Q:^%ZOSF("OS")'["OpenM"  Q:$$OS^%ZOSV["VMS"
 . ;
 . ;4=status,10=Time Stopped,9=Time Started,11=Task Number,3=Device Type,14=shutdown?
 . S X="HLJ(870,"""_HLDP_","")",@X@(10)=$$NOW^XLFDT,(@X@(11),@X@(9))="@",@X@(14)=1
 . I "Shutdown,SHUTDOWN"'[$P(HLDP0,U,5) S @X@(4)="Halting"
 . I $P(HLPARM4,U,3)="C"&("N"[$P(HLPARM4,U,4)),'$P(HLDP0,U,12) S @X@(4)="Shutdown"
 . D FILE^HLDIE("","HLJ","","LLP","HLCS2") ;HL*1.6*109
 . I ^%ZOSF("OS")["OpenM",($P(HLPARM4,U,3)="M"!($P(HLPARM4,U,3)="S")) D
 .. ; pass task number to stop listener
 .. S:$P(HLDP0,U,12) X=$$ASKSTOP^%ZTLOAD(+$P(HLDP0,U,12))
 ; patch HL*1.6*122 start
 ; .. D CALL^%ZISTCP($P(HLPARM4,U),$P(HLPARM4,U,2),10)
 ; .. I POP D HOME^%ZIS Q
 ; .. D CLOSE^%ZISTCP
 ; patch HL*1.6*122 end
 Q
STRT ;Start Links
 N HLDP,HLDP0,HLDAPP,HLTYPTR,HLBGR,HLENV,HLPARAM0,HLPARM4,HLQUIT,ZTRTN,ZTDESC,ZTSK,ZTCPU
 S HLDP=0
 F  S HLDP=$O(^HLCS(870,HLDP)) Q:HLDP<1  S HLDP0=$G(^(HLDP,0)) D
 . S HLPARM4=$G(^HLCS(870,HLDP,400))
 . ;quit if no parameters or AUTOSTART is disabled
 . Q:'$P(HLDP0,U,6)
 . ;HLDAPP=LL name, HLTYPTR=LL type, HLBGR=routine, HLENV=environment check
 . S HLDAPP=$P(HLDP0,U),HLTYPTR=+$P(HLDP0,U,3),HLBGR=$G(^HLCS(869.1,HLTYPTR,100)),HLENV=$G(^(200))
 . ;quit if no LL type or no routine
 . Q:'HLTYPTR!(HLBGR="")
 . I HLENV'="" K HLQUIT X HLENV Q:$D(HLQUIT)
 . ; patch HL*1.6*122
 . ; TCP Multi listener: quit if TCP service as GT.M, DSM,
 . ; or Cache/VMS
 . I $P(HLPARM4,U,3)="M" Q:^%ZOSF("OS")'["OpenM"  Q:$$OS^%ZOSV["VMS"
 . ;
 . I $P(HLPARM4,U,3)="C"&("N"[$P(HLPARM4,U,4)) D  Q
 .. ;4=status 9=Time Started, 10=Time Stopped, 11=Task Number 
 .. ;14=Shutdown LLP, 3=Device Type, 18=Gross Errors
 .. N HLJ,X
 .. I $P(HLDP0,U,15)=0 Q
 .. L +^HLCS(870,HLDP,0):2
 .. E  Q
 .. S X="HLJ(870,"""_HLDP_","")"
 .. S @X@(4)="Enabled",@X@(9)=$$NOW^XLFDT,@X@(14)=0
 .. D FILE^HLDIE("","HLJ","","STRT","HLCS2") ; HL*1.6*109
 .. L -^HLCS(870,HLDP,0)
 .. Q
 . S ZTRTN=$P(HLBGR," ",2),ZTIO="",ZTDTH=$H,HLTRACE=""
 . S ZTDESC=HLDAPP_" Low Level Protocol",ZTSAVE("HLDP")=""
 . ;get startup node
 . I $P(HLPARM4,U,6),$D(^%ZIS(14.7,+$P(HLPARM4,U,6),0)) S ZTCPU=$P(^(0),U)
 . D ^%ZTLOAD
 Q
SITEP ;Edit Site Parameters
 S DDSFILE=869.3,DA=1,DR="[HL SITE PARAMETERS]" D ^DDS
 Q
PARAM() ;Return HL7 site parameters
 ;HLPARAM=domain ien^domain name^production or test^institution ien^
 ;institution name^institution number^mail group ien^mail group name^
 ;purge completed messages^purge awaiting ack messages^purge all msgs^
 ;default retention
 N HLX,HLX4,HLX5,HLDOMP,HLDOMN,HLPROD,HLINSP,HLINSN,HLINSNM,HLMAILP,HLMAILN,HLPARAM,HLPRGAA,HLPRGALL,HLPRGCMP,HLDEFRET
 S HLX=$G(^HLCS(869.3,1,0))
 S HLX4=$G(^HLCS(869.3,1,4))
 S HLX5=$G(^HLCS(869.3,1,5))
 S HLDOMP=$P(HLX,U,2) I HLDOMP S HLDOMN=$P(^DIC(4.2,HLDOMP,0),U)
 S HLPROD=$P(HLX,U,3)
 S HLINSP=$P(HLX,U,4) I HLINSP S HLINSN=$P(^DIC(4,HLINSP,0),U),HLINSNM=$P($G(^DIC(4,HLINSP,99)),U)
 S HLMAILP=$P(HLX,U,5) I HLMAILP S HLMAILN=$P(^XMB(3.8,HLMAILP,0),U)
 S HLPRGCMP=$P(HLX4,U),HLPRGAA=$P(HLX4,U,2),HLPRGALL=$P(HLX4,U,3)
 S HLDEFRET=$P(HLX5,U)
 S HLPARAM=HLDOMP_U_$G(HLDOMN)_U_$G(HLPROD)_U_HLINSP_U_$G(HLINSN)_U_$G(HLINSNM)_U_HLMAILP_U_$G(HLMAILN)_U_HLPRGCMP_U_HLPRGAA_U_HLPRGALL_U_HLDEFRET
 Q HLPARAM
 ;
GETAPP(HLAPP) ;Function to Retrieve parameters pertaining to a specific sending or receiving application
 ;HLAPP=APPLICATION NAME OR IEN OF FILE 771
 ;Returns MAIL GROUP NAME^'a' or 'i' (active or inactive) 
 S HLAPP=$G(HLAPP)
 I HLAPP]"",'HLAPP S HLAPP=$O(^HL(771,"B",$E(HLAPP,1,30),0))
 I 'HLAPP Q ""
 I HLAPP S HLM=$P(^HL(771,HLAPP,0),U,4)
 I HLM S HLM=$P($G(^XMB(3.8,HLM,0)),U)
 Q $G(HLM)_U_$P(^HL(771,HLAPP,0),U,2)
