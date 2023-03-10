XMDB1P3 ;ALB/FJF - MAILMAN DOMAIN POST INSTALL UPDATE; 30 Aug 2021
 ;;1.0;MAILMAN DOMAIN UPDATES;**3**;Nov 8, 2016;Build 5
 ;
 Q
 ;
POST ;post install entry point
 ;
 D BMES^XPDUTL(">>>Adding new entries to the DOMAIN (#4.2) file...")
 ;
 N XMDBCNT,XMDBREC,XMDBNAME,XMDBFLAG,XMDBRELAY,XMDBNOTE,X,Y,DIC
 F XMDBCNT=1:1 S XMDBREC=$P($T(UPDDOM+XMDBCNT),";;",2) Q:XMDBREC="QUIT"  D
 .S XMDBNAME=$P(XMDBREC,"^")
 .S XMDBFLAG=$P(XMDBREC,"^",2)
 .S XMDBRELAY=$P(XMDBREC,"^",3)
 .S XMDBNOTE=$P(XMDBREC,"^",4)
 .I $O(^DIC(4.2,"B",XMDBNAME,"")) D BMES^XPDUTL("*** Entry "_XMDBNAME_" already added to the file. ***") Q
 .S DIC=4.2,DIC(0)="EZL",X=XMDBNAME
 .S DIC("DR")="1///"_XMDBFLAG_";2///"_XMDBRELAY_";4.2///"_XMDBNOTE
 .D FILE^DICN
 .I Y=-1 D  Q
 ..D BMES^XPDUTL("*** Error adding entry "_XMDBNAME_". ***")
 ..D MES^XPDUTL("*** Please contact support for assistance. ***")
 .D BMES^XPDUTL("   Domain "_XMDBNAME_" successfully added to the file")
 ;
 D BMES^XPDUTL("...update complete<<<")
 Q
 ;
UPDDOM ;name^flags^disable turn command^relay domain^notes^dhcp routing indicator
 ;;Q-IFM.DOMAIN.EXT^NS^FOC-AUSTIN.DOMAIN.EXT^This is the Production queue for FMBT data transmissions.^IFM
 ;;Q-IFT.DOMAIN.EXT^NS^FOC-AUSTIN.DOMAIN.EXT^This queue is for testing FMBT data transmissions in a non-Production account.^IFT
 ;;QUIT
