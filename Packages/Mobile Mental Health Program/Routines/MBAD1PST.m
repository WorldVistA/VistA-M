MBAD1PST ;HPE/ART MHPRO Patch 1 Post Install ;09/12/2016
 ;;1.0;MHPRO;**1**;;Build 1
 ;
 QUIT
 ;
 ;Public, Supported ICRs
 ; #10141 - XPDUTL - Public APIs for KIDS
 ;
 ;Subscription ICR
 ;>>>>>>>>>>>>>>>>>>>>>>>>>>> SUBSCRIPTION NEEDS TO BE APPROVED <<<<<<<<<<<<<<<<<<<<<<<<<
 ; ICR 4677 - Application Proxy (XUSAP) - subscription, also use of app proxy requires VA DBA approval, ICR team approval
 ;
EN ;Main Entry Point
 ;
 ;Create MHPRO Application Proxy User
 DO ADDPROXY
 ;
 QUIT
 ;
ADDPROXY ;Create MHPRO Application Proxy User
 ;User needs XUMGR security key for this to work
 ;
 NEW MHOPT,MHRTN
 SET MHOPT("MBAD APP PROXY BROKER MENU")=1
 SET MHRTN=$$CREATE^XUSAP("MBAD,APPLICATION PROXY","",.MHOPT)
 IF MHRTN DO  QUIT
 . DO BMES^XPDUTL(" o MBAD,APPLICATION PROXY user was created.")
 IF +MHRTN=0 DO
 . DO BMES^XPDUTL(" o MBAD,APPLICATION PROXY user already exists.")
 ELSE   DO
 . DO BMES^XPDUTL(" o Error creating MBAD,APPLICATION PROXY user ")
 QUIT
 ;
