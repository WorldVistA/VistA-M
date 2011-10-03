AWCMCPUR        ;VISN 7/THM-Purge CPRS Monitor data file and ^XTMP("AWC" global ; 09 Jan 2004  3:43 PM
 ;;7.3;TOOLKIT;**84**;Jan 9, 2004
 ;
EN D DT^DICRW
 ; number of days to keep data in param file
 S AWCPDAYS=$P(^AWC(177100.12,1,0),U,14)
 I +AWCPDAYS=0 S AWCPDAYS=30 ;if no limit set, keep minimum of 30 days
 S X1=DT,X2=-AWCPDAYS D C^%DTC S AWCEND=X+.2359,AWCDTX=""
 F  S AWCDTX=$O(^AWC(177100.13,"C",AWCDTX)) Q:(AWCDTX>AWCEND)!(AWCDTX="")  DO
 .F DA=0:0 S DA=$O(^AWC(177100.13,"C",AWCDTX,DA)) Q:DA=""  DO
 ..S DIK="^AWC(177100.13," D ^DIK
 ;
 ; now purge the XTMP global
PGXTMP S AWCDTX="" F  S AWCDTX=$O(^XTMP("AWCCPRS",AWCDTX)) Q:(AWCDTX>AWCEND)!(AWCDTX="")  DO
 .F DA=0:0 S DA=$O(^XTMP("AWCCPRS",AWCDTX,DA)) Q:DA=""  K ^XTMP("AWCCPRS",AWCDTX,DA,0)
 ; reset zero node purge date
 S X="T+10",%DT="" D ^%DT Q:Y<0  S AWCPGDT=Y
 S $P(^XTMP("AWCCPRS",0),U)=AWCPGDT
 K DIK,DA,AWCEND,AWCPGDT,AWCDTX,AWCPDAYS,X1,X2,X,%,%H,%T,%DT,Y
 Q
