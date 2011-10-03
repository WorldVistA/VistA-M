MHVU1 ;WAS/GPM - UTILITIES  ; 7/25/05 3:48pm [12/13/07 12:06am]
 ;;1.0;My HealtheVet;**2**;Aug 23, 2005;Build 22
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 Q
 ;
NOTIFY(ADM) ; Notify MHV server of patch installation, and configuration data
 ;  Sends the current version and last patch installed for the 
 ; My HealtheVet package.  This is called by post install routines to
 ; notify the MHV server of patch installation.
 ;  Configuration data passed in ADM will also be sent.
 ;
 ;  Input:
 ;     ADM - Array of administrative data
 ;                SITE NUMBER - From Institution file
 ;                  SITE NAME - Descriptive Site Name
 ;                     DOMAIN - System Domain Name
 ;               SYSTEM TYPE  - Production or Test
 ;                    VERSION - MHV version
 ;               PATCH NUMBER - Last MHV patch loaded
 ;            RPC BROKER PORT - Broker port MHV Server should use
 ;                 IP ADDRESS - System IP address
 ;          HL7 LISTENER PORT - For HL7 listener
 ;
 ;  Output:
 ;     MFN^Z01 Message is sent to the MHV server
 ;
 ;
 N XMT
 D LOG^MHVUL2("MFN-Z01 UPDATE","BEGIN","S","TRACE")
 D LOG^MHVUL2("ADM",.ADM,"M","TRACE")
 S XMT("BUILDER")="MFNZ01^MHV7B0"
 S XMT("PROTOCOL")="MHV MFN-Z01 Event Driver"
 S XMT("MODE")="A"
 D XMIT^MHV7T(.ADM,.XMT,"","","")
 ;
 ; code to use Email transmitter
 ;S XMT("SAF")=ADM("SITE NUMBER")
 ;S XMT("EMAIL")="VHAMHVSITECOMMCONFIG@MED.VA.GOV"
 ;D EMAIL^MHV7T(.ADM,.XMT,"","","")
 ;
 D LOG^MHVUL2("MFN-Z01 UPDATE","END","S","TRACE")
 ;
 Q
 ;
SETADM(ADM) ; Set up ADM array of site information
 ;
 ;  Integration Agreements:
 ;        10141 : $$LAST^XPDUTL,$$VERSION^XPDUTL
 ;         3552 : $$PARAM^HLCS2
 ;         4440 : $$PROD^XUPROD
 ;
 ;  Input: None
 ;
 ;  Output:
 ;     ADM - Array of administrative data
 ;                SITE NUMBER - From Institution file
 ;                  SITE NAME - Descriptive Site Name
 ;                     DOMAIN - System Domain Name
 ;               SYSTEM TYPE  - Production or Test
 ;                    VERSION - MHV version
 ;               PATCH NUMBER - Last MHV patch loaded
 ;            RPC BROKER PORT - Broker port MHV Server should use
 ;                 IP ADDRESS - System IP address
 ;          HL7 LISTENER PORT - For HL7 listener
 ;
 N PARAM,VERSION,PATCH
 S PARAM=$$PARAM^HLCS2
 S VERSION=$$VERSION^XPDUTL("My HealtheVet")
 S PATCH=$P($$LAST^XPDUTL("My HealtheVet",.VERSION),"^")
 I PATCH<1 S PATCH=""
 ;
 S ADM("SITE NUMBER")=$P(PARAM,"^",6)
 S ADM("SITE NAME")=$P(PARAM,"^",5)
 S ADM("DOMAIN")=$P(PARAM,"^",2)
 S ADM("SYSTEM TYPE")=$S($$PROD^XUPROD(1):"P",1:"T")
 S ADM("VERSION")=VERSION
 S ADM("PATCH NUMBER")=PATCH
 S ADM("RPC BROKER PORT")=""
 S ADM("IP ADDRESS")=""
 S ADM("HL7 LISTENER PORT")=5000
 Q
 ;
