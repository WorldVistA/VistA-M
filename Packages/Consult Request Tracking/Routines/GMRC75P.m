GMRC75P ;DAL/PHH - POST INSTALL ;8/6/14
 ;;3.0;CONSULT/REQUEST TRACKING;**75**;DEC 27, 1997;Build 22
 ;
 Q
 ; Documented API's and Integration Agreements
 ; ----------------------------------------------
 ; 6081   $$CREATE^XUSAP
 ;
POST ; Create Proxy User
 N GMRCPRXY,GMRCDUZ
 S GMRCPRXY="HCPS,APPLICATION PROXY"
 Q:$O(^VA(200,"B",GMRCPRXY,0))
 S GMRCDUZ=$$CREATE^XUSAP(GMRCPRXY,"")
 ;
 I GMRCDUZ>0 D  Q
 .D BMES^XPDUTL("*****")
 .D MES^XPDUTL("'"_GMRCPRXY_"' user successfully created.")
 E  D
 .D BMES^XPDUTL("*****")
 .D MES^XPDUTL("Error - '"_GMRCPRXY_"' user not added.")
 Q
