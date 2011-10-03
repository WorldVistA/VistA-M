AWCMCPST ;VISN 7/THM-POST-INIT FOR CPRS MONITOR ; Feb 27, 2004
 ;;7.3;TOOLKIT;**84,86**;Jan 09, 2004
 ;
EN ; set up ^XTMP nodes first
 N AWCPGDT,X,Y
 D DT^DICRW
 S X="T+10",%DT="" D ^%DT Q:Y<0  S AWCPGDT=Y
 ; locks applied even though nodes do not exist yet
 I '$D(^XTMP("AWCCPRS",0)) DO
 .L +^XTMP("AWCCPRS",0):1
 .S ^XTMP("AWCCPRS",0)=AWCPGDT_U_DT_U_"CPRS Monitor temporary global" ;zero node
 .L -^XTMP("AWCCPRS",0)
 I '$D(^XTMP("AWCCPRS",.5)) DO
 .L +^XTMP("AWCCPRS",.5):1
 .S ^XTMP("AWCCPRS",.5)=0 ;node that supplies IEN
 .L -^XTMP("AWCCPRS",.5)
 ;
PARAM ; set up parameter file; all settings off initially
 S AWCX=$$SITE^VASITE,AWCDIV=+AWCX,AWCDNAME=$P(AWCX,U,2),AWCMSTA=$P(AWCX,U,3)
 ; Output= Institution file pointer^Institution name^station number with suffix
 I AWCDIV="" W !!,$C(7),"Unable to resolve the site's station number",!! H 3
 G:AWCDIV="" EXIT
 ; Beta test sites have it already, so update it for consistency
 I $D(^AWC(177100.12,1,0)) DO  G EXIT
 .S (DIC,DIE)="^AWC(177100.12,",DIC(0)="QLM",DA=1
 .; set the first piece manually; can't edit a DINUMed field
 .; field 1.5 will be triggered on new entries at non-beta sites, but not for existing beta sites
 .S $P(^AWC(177100.12,DA,0),U)=AWCDIV
 .S DR="1///0;1.2///0;1.5////"_AWCMSTA_";2///0;3///0;5////cprsmonitor"_AWCMSTA
 .S DR=DR_";6///8;7///30;8///192,0,0;9///0,192,0;10///0,0,192;11///1;12///230,230,230"
 .S DR=DR_";13///7;20///vaftp.va.gov;21////itmuser;22////Padfoot1;23///0;24///1"
 .D ^DIE
 . ;now re-index .01 field because it changed (DIK executes KILL and then SET)
 .S DIK="^AWC(177100.12,",DA=1,DIK(1)=".01" D EN^DIK
 ; section for new sites - field 1.5 is triggered
 I '$D(^AWC(177100.12,1,0)) DO
 .S X=AWCDIV,DIC("DR")="1///0;1.2///0;2///0;3///0;5///cprsmonitor"_AWCMSTA
 .S DIC("DR")=DIC("DR")_";6///8;7///30;8///192,0,0;9///0,192,0;10///0,0,192;11///YES;12///230,230,230"
 .S DIC("DR")=DIC("DR")_";13///7;20///vaftp.va.gov;21///itmuser;22///Padfoot1;23///0;24///1"
 .S (DIC,DIE)="^AWC(177100.12,",DIC(0)="EQLM" K DO,DD D FILE^DICN
 ;
EXIT K AWCDIV,AWCDA,AWCDNAME,AWCMSTA,DO,DD,DIC,DIE,DR,%DT,AWCPGDT,X,Y
 K AWCX,DA
 Q
