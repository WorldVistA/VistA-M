PSXSND ;BIR/BAB,WPB-Transmit a Message ;[ 05/13/97  8:39 AM ]
 ;;2.0;CMOP;**1**;11 Apr 97
GETMSG ;Get first message in queue
 S PSXQN=$O(^PSX(552.2,"AQ",PSXB,"")) K PSXPOP
 S PSXMSGID=$P(^PSX(552.2,PSXQN,0),"^")
 G:'PSXQN ^PSXJOB
 G:$G(PSXBHS)'=1 HDR
 S BHST=0
 D GETTXT Q:$G(QRYPOP)=1
 G:PSXPOP ^PSXJOB
 I PSXPOP D SND8 D LOG^PSXUTL,FLUSH1^PSXUTL
 I PSXPOP G DONE ;dont store last if mess never sent
 S ^PSX(553,1,99)=$P(^PSX(552.2,PSXQN,0),"^") ;last message sent, wait for ACK message
DONE W *EOT,*TERM ;send termination sequence to slave
 D EN^PSXACK ;get ACK message
 G ^PSXJOB
FILE Q:$G(PSXDA)=""  D NOW^%DTC S REC=PSXDA L +^PSX(552.1,REC):30 G:'$T FILE S $P(^PSX(552.1,REC,0),U,2)=3,DIE="^PSX(552.1,",DA=REC,DR="16////"_%_";18////"_$G(PSXMSH)_$G(PSXMSA)_";20////@"
 D ^DIE L -^PSX(552.1,REC) K DIE,REC S DIK="^PSX(552.1," D IX^DIK K DA,DIK
 S LOG(1)="Transmission # "_PSXB_" finished downloading." D LOG^PSXUTL
 S $P(^PSX(554,1,0),"^",2)=PSXB
 D ACK^PSXNOTE
 Q
HDR D TSOUT^PSXUTL
 S PSXBLK=1,PSXBHS=0,LOG(1)="Downloading Transmission # "_PSXB D LOG^PSXUTL
 ;S $P(^PSX(552.1,PSXDA,0),"^",2)=7
 S PSXTXT="BHS|^~\&|DHCP||"_$S($G(PSXVNDR)>0:"SI BAKER",1:"ELECTROCOM")_"||"_PSXTS_"||ORM|"_PSXB_"|P|2.1|",PSXLAST=0 D XMIT G:$G(PSXPOP) ^PSXJOB
 S PSXBLK=PSXBLK+1
 S REC=PSXDA,PSXMSGID=PSXB
 F CNT=0:0 S CNT=$O(^PSX(552.1,REC,"S",CNT)) Q:CNT'>0  S PSXBLK=(CNT#8)+1,PSXTXT=$G(^PSX(552.1,REC,"S",CNT,0)),PSXLAST=$S($O(^PSX(552.1,REC,"S",CNT)):0,1:1) S:PSXBLK>7 PSXBLK=0 D XMIT G:$G(PSXPOP) ^PSXJOB
 W *EOT,*TERM
 D EN^PSXACK K:$G(PSXBHS)>0 XTRY G:PSXBHS=1 BID1^PSXMST
 S XTRY=$G(XTRY)+1 S LOG(1)="Batch Header Rejected by Vendor for Transmission "_$G(PSXB) D LOG^PSXUTL G:$G(XTRY)'>5 ^PSXJOB
 I $G(XTRY)>5 S LOG(1)="Batch Header for transmission "_$G(PSXB)_" rejected max times.",LOG(2)="DHCP Stopping interface." D LOG^PSXUTL G STOP^PSXJOB
 Q
GETTXT F I=0:0 S I=$O(^PSX(552.2,PSXQN,"T",I)) Q:'I  K PSXTXT S PSXBLK=I#8,PSXTXTN=I,PSXTXT=$G(^(PSXTXTN,0)),PSXLAST=$S($O(^PSX(552.2,PSXQN,"T",I)):0,1:1) Q:PSXTXT=""  D XMIT Q:PSXPOP
 Q
XMIT S (PSXPOP,PSXTRYN)=0
 S PSXLEN=$L(PSXTXT)
 S PSXLEN=$E("00000",1,5-$L(PSXLEN))_PSXLEN
 S PSXTXT=PSXBLK_PSXLEN_PSXTXT_$S(PSXLAST:$C(ETX),1:$C(ETB))
 ;Get 2 byte hex Csum
 S X=PSXTXT X ^%ZOSF("LPC") S PSXHEX=Y D HEX^PSXUTL
 S PSXTXT=$C(STX)_PSXTXT_PSXHEX_$C(TERM)
RETRY W PSXTXT
 S PSXBLK=$A(PSXBLK)
TRY R *X:PSXDLTA E  D SND1 G ERROR ;look for ACK or NAK
 I X=ACK R *X:PSXDLTA D:('$T)!(X'=PSXBLK) SND2 G:('$T)!(X'=PSXBLK) ERROR R *X:PSXDLTA D:('$T)!(X'=TERM) SND9 G:('$T)!(X'=TERM) ERROR Q
 I X=NAK R *X:PSXDLTA D:('$T)!(X'=TERM) SND3 D SND4 G ERROR
 I X=EOT R *X:PSXDLTA D:('$T)!(X'=TERM) SND5 D SND7 G:('$T)!(X'=TERM) ERROR S PSXTRYN=9999 G ERROR
 D SND6
ERROR D FLUSH1^PSXUTL,LOG^PSXUTL
 S PSXTRYN=PSXTRYN+1
 S PSXBLK=$C(PSXBLK)
 G:PSXTRYN'>PSXTRYL RETRY
 S PSXPOP=1
 Q
SND1 K LOG S LOG(1)="SND1 Timer A timeout after sending a line of text."_$G(PSXBLK) Q
SND2 K LOG S LOG(1)="SND2 ACK Received with bad block number after sending line of text, ASCII ("_$G(X)_")  "_X
 S LOG(2)="Expected ASCII ("_$G(PSXBLK)_")." Q
SND3 K LOG S LOG(1)="SND3 NAK Received with no terminator after sending a line of text." Q
SND4 K LOG S LOG(1)="SND4 NAK Received after sending a line of text." Q
SND5 K LOG S LOG(1)="SND5 EOT Received with no terminator after sending a line of text." Q
SND6 K LOG S LOG(1)="SND6 Garbage received after sending a line of text. ("_X_")" Q
SND7 K LOG S LOG(1)="SND7 EOT Received, aborting send." Q
SND8 K LOG S LOG(1)="SND8 Aborting Send.  Error processing order # "_$P($G(^PSX(552.2,PSXQN,0)),"^",1)_".  Text: "_PSXTXT Q
SND9 K LOG S LOG(1)="SND9 ACK,"_$G(PSXBLK)_" received with no terminator after sending",LOG(2)="a line of text." Q
