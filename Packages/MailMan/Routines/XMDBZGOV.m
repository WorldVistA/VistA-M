XMDBZGOV ;ALB/JTW - ZZ ALL GOV DOMAINS; Feb 07, 2020@7:35
 ;;1.0;MailMan;**2**;AUG 13, 1993;Build 7
 ;
 ; Post-init routine to update all GOV domains
 ; with RELAY DOMAIN of DOMAIN.EXT
 ;
 Q
 ;
POST ; Update GOV DOMAINS
 N XMDBIEN,XMDBERR,XMDBFDA,XMDBNIEN,XMDBCNT,XMDBGOV,XMDBFRM,XMDBFIEN
 S XMDBIEN="",XMDBCNT=0
 ;Update GOV domain to be ZZGOV, set Flags to C (closed), and remove Relay Domain
 F  S XMDBIEN=$O(^DIC(4.2,XMDBIEN)) Q:XMDBIEN=""  I ($P($G(^DIC(4.2,XMDBIEN,0)),U,1)="GOV")!($P($G(^DIC(4.2,XMDBIEN,0)),U,1)="gov") D
 .S XMDBNIEN=$P($G(^DIC(4.2,XMDBIEN,0)),U,3) Q:XMDBNIEN=""
 .I $P($G(^DIC(4.2,XMDBNIEN,0)),U,1)="DOMAIN.EXT" D
 ..K XMDBERR,XMDBFDA
 ..S XMDBFDA(4.2,XMDBIEN_",",.01)="ZZGOV"
 ..S XMDBFDA(4.2,XMDBIEN_",",1)="C"
 ..S XMDBFDA(4.2,XMDBIEN_",",2)="@"
 ..D FILE^DIE(,"XMDBFDA","XMDBERR")
 ..I '$D(XMDBERR) D BMES^XPDUTL(">>>....Domain with IEN:"_XMDBIEN_" was updated") S XMDBCNT=XMDBCNT+1
 ..I $D(XMDBERR) D BMES^XPDUTL(">>>....Unable to update IEN: "_XMDBIEN_".") D
 ...D BMES^XPDUTL("*** Please contact support for assistance. ***")
 ;Update the DOMAIN.EXT domain to remove the GOV synonym
 I $O(^DIC(4.2,"B","DOMAIN.EXT",""))'="" S XMDBFRM=$O(^DIC(4.2,"B","DOMAIN.EXT","")) D
 .I $O(^DIC(4.2,"C","GOV",XMDBFRM,""))'="" S XMDBFIEN=$O(^DIC(4.2,"C","GOV",XMDBFRM,"")) K XMDBFDA S XMDBFDA(4.23,XMDBFIEN_","_XMDBFRM_",",.01)="@" D
 ..K XMDBERR D FILE^DIE(,"XMDBFDA","XMDBERR")
 ..I '$D(XMDBERR) D BMES^XPDUTL(">>>....DOMAIN.EXT domain with IEN:"_XMDBFRM_" was updated") S XMDBCNT=XMDBCNT+1
 ..I $D(XMDBERR) D BMES^XPDUTL(">>>....Unable to update IEN: "_XMDBFRM_".") D
 ...D BMES^XPDUTL("*** Please contact support for assistance. ***")
 I XMDBCNT'=0 D BMES^XPDUTL(">>>...."_XMDBCNT_" record(s) updated.")
 I XMDBCNT=0 D BMES^XPDUTL(">>>...."_"No records updated.")
 Q
