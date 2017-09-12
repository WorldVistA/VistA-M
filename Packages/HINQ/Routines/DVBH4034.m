DVBH4034        ;ISC-ALBANY/PKE-HINQ-TCP,; 8/17/99  08:50 ;
 ;;4.0;HINQ;**34**;03/25/92
 ;
 N DVBLOG,DVBIP,DVBIP0
 S DVBLOG=$P($P($G(^DVB(395,1,"HQVD")),"^",1),".",2)
 ;philly East
 I DVBLOG["BDNE" S DVBIP="152.124.127.227"
 ;       South
 I DVBLOG["BDNS" S DVBIP="152.124.127.228"
 ;hines  Central
 I DVBLOG["BDNC" S DVBIP="152.124.127.243"
 ;       Midsouth/west
 I DVBLOG["BDNM" S DVBIP="152.124.127.244"
 ;       West
 I DVBLOG["BDNW" S DVBIP="152.124.127.245"
 ;
 I '$G(DVBIP),'$G(^DVB(395,1,"HQIP")) DO  QUIT
 . D BMES^XPDUTL("...The post-init routine could not determine the RDPC for this site")
 . D BMES^XPDUTL("...Please enter the RDPC IP Address in the DVB PARAMETERS file #395, field #22")
 . D BMES^XPDUTL("...to complete the installation")
 .;
 E  DO
 . I $G(^DVB(395,1,"HQIP")) S DVBIP0=^("HQIP") DO  QUIT
 . . D BMES^XPDUTL("...The RDPC IP Address was already set to "_DVBIP0)
 . . D BMES^XPDUTL("...The post-init DVBH4034 is complete")
 . . D BMES^XPDUTL("")
 . .; 
 . S ^DVB(395,1,"HQIP")=DVBIP
 . D BMES^XPDUTL("...The RDPC IP Address for "_DVBLOG_" has been set to "_DVBIP)
 . D BMES^XPDUTL("...The post-init DVBH4034 is complete")
 . D BMES^XPDUTL("")
 Q
