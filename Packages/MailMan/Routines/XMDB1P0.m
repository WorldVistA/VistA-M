XMDB1P0 ;ALB/DE - MAILMAN DOMAIN POST INSTALL UPDATE;11/08/2016
 ;;1.0;MAILMAN DOMAIN UPDATES;**0**;Nov 8, 2016;Build 9
 ;
 Q
 ;
POST ;post install entry point
 ;
 D BMES^XPDUTL(">>>Adding new entries to the DOMAIN (#4.2) file...")
 ;
 N XMCNT,XMREC,XMNAME,XMFLAG,XMDISTRN,XMRELAY,XMNOTE,XMDHCP,X,Y,DIC
 F XMCNT=1:1 S XMREC=$P($T(UPDDOM+XMCNT),";;",2) Q:XMREC="QUIT"  D
 .S XMNAME=$P(XMREC,"^"),XMFLAG=$P(XMREC,"^",2),XMDISTRN=$P(XMREC,"^",3),XMRELAY=$P(XMREC,"^",4),XMNOTE=$P(XMREC,"^",5),XMDHCP=$P(XMREC,"^",6)
 .I $O(^DIC(4.2,"B",XMNAME,"")) D BMES^XPDUTL("*** Entry "_XMNAME_" already added to the file. ***") Q
 .S DIC=4.2,DIC(0)="EZL",X=XMNAME
 .S DIC("DR")="1///"_XMFLAG_";1.7///"_XMDISTRN_";2///"_XMRELAY_";4.2///"_XMNOTE_";6.2///"_XMDHCP
 .D FILE^DICN
 .I Y=-1 D  Q 
  ..D BMES^XPDUTL("*** Error adding entry "_XMNAME_". ***")
  ..D MES^XPDUTL("*** Please contact support for assistance. ***")
 .E  D  Q
  ..D BMES^XPDUTL("   Domain "_XMNAME_" successfully added to the file")
 ;
 D BMES^XPDUTL("...update complete<<<")
 Q
 ;
UPDDOM ;name^flags^disable turn command^relay domain^notes^dhcp routing indicator
 ;;Q-CCT.DOMAIN.EXT^S^YES^FOC-AUSTIN.DOMAIN.EXT^Test queue for transmission to send monthly mailman transmissions containing daily Payment records to the Consolidated Billing Statement System (CBSS) in Austin.^CCT
 ;;Q-CPT.DOMAIN.EXT^S^YES^FOC-AUSTIN.DOMAIN.EXT^Test queue for transmission to send monthly mailman transmissions containing daily Payment records to the Consolidated Billing Statement System (CBSS) in Austin.^CPT
 ;;Q-CAT.DOMAIN.EXT^S^YES^FOC-AUSTIN.DOMAIN.EXT^Test queue for transmission to send monthly mailman transmissions containing daily Payment records to the Consolidated Billing Statement System (CBSS) in Austin.^CAT
 ;;Q-CBS.DOMAIN.EXT^S^YES^FOC-AUSTIN.DOMAIN.EXT^Test queue for transmission to send monthly mailman transmissions containing daily Payment records to the Consolidated Billing Statement System (CBSS) in Austin.^CBS
 ;;Q-CPP.DOMAIN.EXT^S^YES^FOC-AUSTIN.DOMAIN.EXT^Test queue for transmission to send monthly mailman transmissions containing daily Payment records to the Consolidated Billing Statement System (CBSS) in Austin.^CPP
 ;;Q-CAP.DOMAIN.EXT^S^YES^FOC-AUSTIN.DOMAIN.EXT^Test queue for transmission to send monthly mailman transmissions containing daily Payment records to the Consolidated Billing Statement System (CBSS) in Austin.^CAP
 ;;QUIT
