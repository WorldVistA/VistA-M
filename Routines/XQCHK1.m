XQCHK1 ;BP-OAK/BDT - Check security on option; 5/12/03 12:32pm
 ;;8.0;KERNEL;**303**; Jul 10,1995
 Q
CHCK1 ;check if there is another path to access a specific option
 N XQK,XQK1,XQK2,XQK3,XQK4,I,J,KFG1,KFG2 S KFG=0,XQK=0
 Q:'$D(^XUTL("XQO",XQDIC,"^",%XQOP,0))
 F  S XQK=$O(^XUTL("XQO",XQDIC,"^",%XQOP,0,XQK)) Q:XQK=""  D
 .S XQK1=$P($G(^XUTL("XQO",XQDIC,"^",%XQOP,0,XQK)),"^",2)
 .S XQK3=$P($G(^XUTL("XQO",XQDIC,"^",%XQOP,0,XQK)),"^",5)
 .I XQK1="",XQK3="" S KFG=1 Q
 .S KFG1=1,KFG2=1
 .F I=1:1 S XQK2=$P(XQK1,",",I) Q:XQK2=""  D
 ..I $D(^XUSEC(XQK2,%XQUSR)) S KFG1=KFG1+1
 .F J=1:1 S XQK4=$P(XQK3,",",J) Q:XQK4=""  D
 ..I '$D(^XUSEC(XQK4,%XQUSR)) S KFG2=KFG2+1
 .I KFG1=I,KFG2=J S KFG=1
 Q
