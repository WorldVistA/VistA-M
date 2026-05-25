SDCCRP912 ;CCRA/LB,PB - Pre Install Routine for Patch SD*5.3*912;
 ;;5.3;Scheduling;**912**;;Build 61
 ;SAC EXEMPTION 202505291453-05 : CCRA use of vendor specific code
 ;ICR 7205
 ;External reference to ^XOB(18.12 supported by DBIA 7204
 ;External reference to ^XOB(18.02 supported by DBIA 7205
 ;External reference to ^XUSRB1 is supported by ICR 2240
 ;External reference to ^XOBWLIB is supported by ICR 5421
 ;
 ;Patch 912 change to set up the new web service to make a REST call to PPMS to get provider information
 Q
EN ;
 N FDA     ; -- FileMan Data Array
 N WEBVICE ; -- Web Service Internal Entry Number
 N WEBVER  ; -- Web Server Internal Entry Number
 N MULTIEN ; -- Web Service Multiple Internal Entry Number
 N WSTAT   ; -- Web Service Status
 N IENROOT,MSGROOT,IENROOT1,VICEIEN
 ;
 N DIR,DTOUT,DUOUT,DIRUT,DIROUT,SERVADD,X,Y,ENVRMT,SERVPORT,IEN1802
 ; Check to see if the web service has already been installed and configured
 S IEN1802=$O(^XOB(18.02,"B","CCRA NPI SERVICE",""))
 I IEN1802>0 D
 . D BMES^XPDUTL("*************************************************************")
 . D BMES^XPDUTL(" The CCRA WEB SERVICE has already been setup and configured. ")
 . D BMES^XPDUTL("*************************************************************")
 ;
 I $G(IEN1802)'>0 D
 .S SERVADD="127.0.0.1"
 .S SERVPORT=80
 .K FDA
 .S FDA(18.02,"?+1,",.01)="CCRA NPI SERVICE"  ; WEB SERVICE NAME
 .S FDA(18.02,"?+1,",.02)="REST"  ; TYPE
 .S FDA(18.02,"?+1,",200)="csp/healthshare/ppms/rest/PPMS/Locations"  ; CONTEXT ROOT
 .S FDA(18.02,"?+1,",201)=""  ; AVAILABILITY RESOURCE
 .D UPDATE^DIE("E","FDA","IENROOT","MSGROOT")
 .K IENROOT,MSGROOT,FDA
 .;
 .S FDA(18.12,"?+1,",.01)="CCRA NPI SERVER"  ; NAME
 .S FDA(18.12,"?+1,",.03)=SERVPORT  ; PORT
 .S FDA(18.12,"?+1,",.04)=SERVADD  ; SERVER
 .S FDA(18.12,"?+1,",.06)="ENABLED"  ; STATUS 1-ENABLED / 0-DISABLED
 .S FDA(18.12,"?+1,",.07)=10  ; DEFAULT HTTP TIMEOUT
 .D UPDATE^DIE("E","FDA","IENROOT","MSGROOT")
 .;
 .S IENROOT1=$G(IENROOT(1)),MULTIEN=0
 .;
 .S WEBVER=$S(IENROOT1:IENROOT1,1:WEBVER)
 .K IENROOT,MSGROOT,FDA
 .S VICEIEN=0 F  S VICEIEN=$O(^XOB(18.12,WEBVER,100,"B",VICEIEN)) Q:'VICEIEN  I $$GET1^DIQ(18.02,VICEIEN,.01)="CCRA WEB SERVICE" S MULTIEN=VICEIEN Q
 .S MULTIEN=$S(MULTIEN:MULTIEN,1:"+1")
 .S FDA(18.121,MULTIEN_","_WEBVER_",",.01)="CCRA NPI SERVICE"  ; WEB SERVICE
 .S FDA(18.121,MULTIEN_","_WEBVER_",",.06)="ENABLED"  ; STATUS 1-ENABLED / 0-DISABLED
 .D UPDATE^DIE("E","FDA","IENROOT","MSGROOT")
 ;
 D BMES^XPDUTL("Connecting to CCRA WEB SERVICE..")
 S WSTAT=$$GET
 I '$G(WSTAT) D  Q
 . D BMES^XPDUTL("     *********************************************************")
 . D BMES^XPDUTL("          WARNING:  The WEB SERVER/SERVICE SETUP SUCCEEDED")
 . D BMES^XPDUTL("                 >>>> Installation Successful <<<<")
 . D BMES^XPDUTL("     *********************************************************")
 . ;S XPDQUIT=1  ; Do not install this transport global and KILL it from ^XTMP.
 ;
 D BMES^XPDUTL("     *******************************************************")
 D BMES^XPDUTL("      The Environmental Check Routine finished Successfully.")
 D BMES^XPDUTL("     *******************************************************")
 Q
 ;
GET()  ; -- Send a test to the Web Service and compare the Result
 N SERVER,SERVICE,RESOURCE,REQUEST,SC,RESPONSE,RESPJSON,DATA,CCRAERR
 S SERVER="CCRA NPI SERVER"
 S SERVICE="CCRA NPI SERVICE"
 S RESOURCE=""
 ;
 ; Get an instance of the REST request object.
 S REQUEST=$$GETREST^XOBWLIB(SERVICE,SERVER)
 ;
 ; Execute the HTTP Get method.
 S SC=$$GET^XOBWLIB(REQUEST,RESOURCE,.CCRAERR,0)
 I 'SC I CCRAERR.code=404 Q 1
 I 'SC Q "0^General Service Error"
 ;
 ; Process the response.
 S RESPONSE=REQUEST.HttpResponse
 S DATA=RESPONSE.Data
 S RESPJSON=""
 F  Q:DATA.AtEnd  Set RESPJSON=RESPJSON_DATA.ReadLine()
 I $L($G(RESPJSON)) Q 1
 Q 0
 ;
