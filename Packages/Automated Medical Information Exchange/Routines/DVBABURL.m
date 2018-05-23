DVBABURL ;ALB/SPH - CAPRI URL ;14/MAY/2012
 ;;2.7;AMIE;**104,136,143,149,168,181,186,192,205**;Apr 10, 1995;Build 1
 ;ALB/RTW - added 7=VICAP website
 ;
URL(Y,WHICH) ;
 ;This procedure supports the DVBAB GET URL remote procedure 
 S Y=""
 ; 1=VBA's AMIE Worksheet Website
 ; 2=CAPRI training website
 ; 3=VistAWeb website
 ; 5=HIA download website
 ; 6=VIRTUAL VA web service server
 ; 7=VICAP website
 ; 8=VLER DAS web service server
 ; 9=JLV website
 ; 999=Debug/Test Code
 I WHICH=1 S Y="http://152.124.238.193/bl/21/rating/Medical/exams/index.htm"
 I WHICH=2 S Y="http://vaww.demo.domain.ext/"
 I WHICH=3 D
 . I '$$PROD^XUPROD S Y="-1^VistAWeb disabled for non-production systems." Q
 . S Y="https://vistaweb.domain.ext/CapriPage.aspx"
 I WHICH=4 S Y="M21-1, Part VI, Rating Board Procedures^http://152.124.238.193/bl/21/Publicat/Manuals/Part6/601.htm#Exam"
 I WHICH=5 S Y=$$GET^XPAR("PKG","DVBAB CAPRI HIA UPDATE URL",1,"Q")
 I WHICH=6 D  ;Virtual VA web service server
 . I $$PROD^XUPROD D
 . . S Y=$$GET^XPAR("PKG","DVBAB CAPRI VIRTUALVA PROD URL",1,"Q")
 . E  D
 . . S Y=$$GET^XPAR("PKG","DVBAB CAPRI VIRTUALVA TEST URL",1,"Q")
 I WHICH=7 S Y=$$GET^XPAR("PKG","DVBAB CAPRI VICAP URL",1,"Q")
 I WHICH=8 D  ;VLER DAS web service server
 . I $$PROD^XUPROD D
 . . S Y=$$GET^XPAR("PKG","DVBAB CAPRI VLER DAS PROD URL",1,"Q")
 . E  D
 . . S Y=$$GET^XPAR("PKG","DVBAB CAPRI VLER DAS CH3 URL",1,"Q")
  I WHICH=9 D  ;VD 10/4/17 DVBA*2.7*205
 . I '$$PROD^XUPROD S Y="-1^JLV disabled for non-production systems." Q
 . S Y=$$GET^XPAR("PKG","DVBAB CAPRI JLV URL",1,"Q")
 I WHICH=999 S Y="http://vhaannweb2.v11.domain.ext/VwDesktop/CapriPage.aspx"
 Q
 ;
VVATOKEN(DVBAUTH) ;retrieve and return the Virtual VA authorization credentials
 ;This procedure supports the DVBA GET VVA TOKEN remote procedure and
 ;retrieves the user, password, and token value required to login to the Virtual
 ;VA web service.  The procedure supports returning differerent values based on
 ;whether the system is a production system or a test/development system.
 ;  
 ; Returns user^password^token on success; otherwise returns ""
 ; Example: "capri^XXXXX^Username-1"
 ;
 N DVBUSER
 N DVBPWD
 N DVBTOKEN
 ;
 I $$PROD^XUPROD D  ;return values for production system
 . S DVBUSER=$$GET^XPAR("PKG","DVBAB CAPRI VVA USER",1,"Q")
 . S DVBPWD=$$GET^XPAR("PKG","DVBAB CAPRI VVA PROD PASSWD",1,"Q")
 . S DVBTOKEN=$$GET^XPAR("PKG","DVBAB CAPRI VVA PROD TOKEN",1,"Q")
 E  D  ;return values for test/development system
 . S DVBUSER=$$GET^XPAR("PKG","DVBAB CAPRI VVA USER",1,"Q")
 . S DVBPWD=$$GET^XPAR("PKG","DVBAB CAPRI VVA TEST PASSWD",1,"Q")
 . S DVBTOKEN=$$GET^XPAR("PKG","DVBAB CAPRI VVA TEST TOKEN",1,"Q")
 I DVBUSER'="",DVBPWD'="",DVBTOKEN'="" D  ;success
 . S DVBAUTH=DVBUSER_U_DVBPWD_U_DVBTOKEN
 E  D  ;failure
 . S DVBAUTH=""
 Q
