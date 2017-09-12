SD53P209 ;ALB/JLU;Patch 209 version control ; 1/12/00
 ;;5.3;Scheduling;**209**;JAN 12, 2000
 ;
POST ;this is the entry point for the post init.  It will add the necessary
 ;version info to files 404.45 and 404.46.
 ;
 ;I $D(^SCTM(404.45,"B",
 N SC1,SC1IEN,SC1ERR
 S SC1(1,404.46,"?+1,",.01)="1.2.1.0" ;client version
 S SC1(1,404.46,"?+1,",.02)=1 ;active?
 S SC1(1,404.46,"?+1,",.03)=DT ;today
 D UPDATE^DIE("","SC1(1)","SC1IEN","SC1ERR")
 I $D(SC1ERR)!(+$G(SC1IEN(1))<0) DO  G ENQ
 .D BMES^XPDUTL("******")
 .D MES^XPDUTL("Unable to log 1.2.1.0 as a new client.")
 .D MES^XPDUTL("******")
 .Q
 D BMES^XPDUTL("Client log updated!")
 ;
 ;update server file
 N SC2,SC2IEN,SC2ERR
 S SC2(1,404.45,"?+1,",.01)="SD*5.3*209" ;server version
 S SC2(1,404.45,"?+1,",.02)=SC1IEN(1) ;ptr - client version
 S SC2(1,404.45,"?+1,",.03)=DT ;today
 S SC2(1,404.45,"?+1,",.04)=1 ;active?
 D UPDATE^DIE("","SC2(1)","SC2IEN","SC2ERR")
 I $D(SC2ERR)!(+$G(SC2IEN(1))<0) DO  G ENQ
 .D BMES^XPDUTL("******")
 .D MES^XPDUTL("Unable to log SD*5.3*209 as a new PCMM server.")
 .D MES^XPDUTL("******")
 .Q
 D BMES^XPDUTL("Server log updated!")
 ;
ENQ Q
 ;
