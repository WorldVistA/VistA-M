PSO7E529 ;ALB/BI - ENVIRONMENTAL CHECK/PRE-INSTALL FOR PSO*7.0*529 ;05/15/2018
 ;;7.0;OUTPATIENT PHARMACY;**529**;DEC 1997;Build 94
 ;External reference to ^XOB(18.12 supported by DBIA 5813
 ;External reference to ^XOB(18.02 supported by DBIA 5814
 ;External reference to ^XUSRB1 is supported by ICR 2240
 ;
 ; 1st: Makes an entry/update to the WEB SERVICE FILE #18.02 in global ^XOB(18.02,
 ; 2nd: Makes an entry/update to the WEB SERVICE FILE #18.02 in global ^XOB(18.02,
 ; 3nd: Makes an entry/update to the WEB SERVER FILE #18.12 in global ^XOB(18.12,
 ; 4th: Performs a web service call to validate the server connection.
 ;
 N FDA     ; -- FileMan Data Array
 N WEBVICE ; -- Web Service Internal Entry Number
 N WEBVER  ; -- Web Server Internal Entry Number
 N MULTIEN ; -- Web Service Multiple Internal Entry Number
 N WSTAT   ; -- Web Service Status
 N IENROOT,MSGROOT,IENROOT1,VICEIEN
 N PSODEAC,PSODEAMSG
 ;
 N DIR,DTOUT,DUOUT,DIRUT,DIROUT,SERVADD,X,Y,ENVRMT
 S ENVRMT="" I $$PROD^XUPROD S ENVRMT="P"
 I ENVRMT="" D  Q:$D(DIRUT)
 . S DIR(0)="S^N:PRE-PROD;S:SQA/DEV"
 . S DIR("A")="ENVIRONMENT TYPE" D ^DIR
 . I $D(DIRUT) D  Q
 . . D BMES^XPDUTL("******************************************************************")
 . . D BMES^XPDUTL("WARNING:  The WEB SERVER/SERVICE ENVIRONMENT TYPE MUST BE SELECTED")
 . . D BMES^XPDUTL("                 >>>> Installation aborted <<<<")
 . . D BMES^XPDUTL("******************************************************************")
 . . S XPDQUIT=1  ; Do not install this transport global and KILL it from ^XTMP.
 . S ENVRMT=$G(Y)
 ;
 S:ENVRMT="P" SERVADD="prod.deals.vaec.domain.ext"
 S:ENVRMT="N" SERVADD="dev.deals.vaec.domain.ext"
 S:ENVRMT="S" SERVADD="dev.deals.vaec.domain.ext"
 ;
 I $G(SERVADD)="" D  Q
 . D BMES^XPDUTL("     *******************************************************")
 . D BMES^XPDUTL("          No Environment Selected - Patch Not Installed     ")
 . D BMES^XPDUTL("     *******************************************************")
 . S XPDQUIT=1  ; Do not install this transport global and KILL it from ^XTMP.
 ;
 K FDA
 S FDA(18.02,"?+1,",.01)="PSO DOJ/DEA WEB SERVICE"                  ; NAME
 S FDA(18.02,"?+1,",.02)="REST"                                     ; TYPE
 S FDA(18.02,"?+1,",200)="/deaInfo/"                                ; CONTEXT ROOT
 S FDA(18.02,"?+1,",201)=""                                         ; AVAILABILITY RESOURCE
 D UPDATE^DIE("E","FDA","IENROOT","MSGROOT")
 K IENROOT,MSGROOT,FDA
 ;
 S FDA(18.12,"?+1,",.01)="PSO DOJ/DEA WEB SERVER"                    ; NAME
 S FDA(18.12,"?+1,",.03)=443                                         ; PORT
 S FDA(18.12,"?+1,",.04)=SERVADD                                     ; SERVER
 S FDA(18.12,"?+1,",.06)="ENABLED"                                   ; STATUS 1-ENABLED / 0-DISABLED
 S FDA(18.12,"?+1,",.07)=10                                          ; DEFAULT HTTP TIMEOUT
 S FDA(18.12,"?+1,",1.01)="YES"                                      ; LOGIN REQUIRED
 S FDA(18.12,"?+1,",3.01)="TRUE"                                     ; SSL ENABLED
 S FDA(18.12,"?+1,",3.02)="encrypt_only_tlsv12"                      ; SSL CONFIGURATION
 S FDA(18.12,"?+1,",3.03)=443                                        ; SSL PORT
 I ENVRMT="P" D
 . S FDA(18.12,"?+1,",200)="user"
 . S FDA(18.12,"?+1,",300)=$$ENCRYP^XUSRB1("hkttHhdfn6XK")
 I ENVRMT'="P" D
 . S FDA(18.12,"?+1,",200)="user"
 . S FDA(18.12,"?+1,",300)=$$ENCRYP^XUSRB1("pass")
 D UPDATE^DIE("E","FDA","IENROOT","MSGROOT")
 ;
 S IENROOT1=$G(IENROOT(1)),MULTIEN=0
 ;
 S WEBVER=$S(IENROOT1:IENROOT1,1:WEBVER)
 K IENROOT,MSGROOT,FDA
 S VICEIEN=0 F  S VICEIEN=$O(^XOB(18.12,WEBVER,100,"B",VICEIEN)) Q:'VICEIEN  I $$GET1^DIQ(18.02,VICEIEN,.01)="PSO DOJ/DEA WEB SERVICE" S MULTIEN=VICEIEN Q
 S MULTIEN=$S(MULTIEN:MULTIEN,1:"+1")
 S FDA(18.121,MULTIEN_","_WEBVER_",",.01)="PSO DOJ/DEA WEB SERVICE"      ; WEB SERVICE
 S FDA(18.121,MULTIEN_","_WEBVER_",",.06)="ENABLED"                      ; STATUS 1-ENABLED / 0-DISABLED
 D UPDATE^DIE("E","FDA","IENROOT","MSGROOT")
 ;
 D BMES^XPDUTL("Connecting to PSO DOJ/DEA WEB SERVICE..")
 S WSTAT=$$GET
 I '$G(WSTAT) D  Q
 . D BMES^XPDUTL("     *********************************************************")
 . D BMES^XPDUTL("          WARNING:  The WEB SERVER/SERVICE SETUP FAILED")
 . D BMES^XPDUTL("      Please try again after a few minutes. Failed to install,")
 . D BMES^XPDUTL("              please submit a Service Now ticket.")
 . D BMES^XPDUTL("                 >>>> Installation aborted <<<<")
 . D BMES^XPDUTL("     *********************************************************")
 . S XPDQUIT=1  ; Do not install this transport global and KILL it from ^XTMP.
 ;
 D FILE^DID(8991.8,,"ENTRIES","PSODEAC","PSODEAMSG")
 I '$G(PSODEAC("ENTRIES")) D  Q
 . D BMES^XPDUTL("     *********************************************************")
 . D BMES^XPDUTL(" WARNING:  XU*8.0*688 required for installation of this patch ")
 . D BMES^XPDUTL("                 >>>> Installation aborted <<<<")
 . D BMES^XPDUTL("     *********************************************************")
 . S XPDQUIT=1  ; Do not install this transport global and KILL it from ^XTMP.
 ;
 D BMES^XPDUTL("     *******************************************************")
 D BMES^XPDUTL("      The Environmental Check Routine finished Successfully.")
 D BMES^XPDUTL("     *******************************************************")
 Q
 ;
GET()  ; -- Send a test to the Web Service and compare the Result
 N SERVER,SERVICE,RESOURCE,REQUEST,SC,RESPONSE,RESPJSON,DATA,PSOERR
 S SERVER="PSO DOJ/DEA WEB SERVER"
 S SERVICE="PSO DOJ/DEA WEB SERVICE"
 S RESOURCE=""
 ;
 ; Get an instance of the REST request object.
 S REQUEST=$$GETREST^XOBWLIB(SERVICE,SERVER)
 ;
 ; Execute the HTTP Get method.
 S SC=$$GET^XOBWLIB(REQUEST,RESOURCE,.PSOERR,0)
 I 'SC I PSOERR.code=404 Q 1
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
PRE ; Pre-Install
 I '$D(ZTQUEUED) D  Q
 .N PSOASTER S $P(PSOASTER,"*",74)="*"
 .S XPDABORT=1
 .D BMES^XPDUTL(PSOASTER)
 .D MES^XPDUTL("  Patch Install must be Queued. Please unload this distribution")
 .D MES^XPDUTL("   and run install again with Queueing.")
 .D MES^XPDUTL(PSOASTER)
 Q
