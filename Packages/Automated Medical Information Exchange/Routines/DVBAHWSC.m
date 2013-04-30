DVBAHWSC ;ALB/RPM - CAPRI HEALTHEVET WEB SERVICES CLIENT TOOLS ;06/28/12
 ;;2.7;AMIE;**181**;Apr 10, 1995;Build 38
 ;
 Q  ;no direct entry
 ;
EN ; -- setup
 ;
 ; -- create DVBPSIM proxy
 D SETUP("PSIMWSEXECUTE.WSDL","DVB_PSIM_EXECUTE")
 Q
 ;
CKSETUP(DVBWSDL) ; - used to check the environment
 ; returns the path to be used that was verified or 0 if it fails
 ;
 ; $$DEFDIR^%ZISH,$$LIST^%ZISH - #2320
 ; BMES^XPDUTL - #10141
 ;
 N DVBSTAT,DVBPATH,DVBFILE
 S DVBPATH=$$DEFDIR^%ZISH()
 S DVBFILE(DVBWSDL)=""
 S DVBSTAT=$$LIST^%ZISH(DVBPATH,"DVBFILE","DVBSTAT")
 I 'DVBSTAT!($D(DVBSTAT)'=11) D  Q 0
 . D BMES^XPDUTL("**** Error cannot find file "_DVBPATH_DVBWSDL)
 I 'DVBSTAT!($D(DVBSTAT)'=11) D  Q 0
 . W !!,"**** WSDL file "_DVBWSDL_" not found in "_DVBPATH_"."
 . W !,"     You will need that prior to install."
 Q DVBPATH
 ;
SETUP(DVBWSDL,DVBSERV) ;  -- call to setup hwsc
 ;DVBWSDL - call with the wsdl file to setup, must be in the
 ;          kernel default directory
 ;
 ; $$GENPORT^XOBWLIB - #5421
 ;
 N DVBSTAT,DVBPATH,DVBARR
 S DVBPATH=$$CKSETUP(DVBWSDL) I DVBPATH=0 Q
 S DVBFILE(DVBWSDL)=""
 S DVBARR("WSDL FILE")=DVBPATH_DVBWSDL
 S DVBARR("CACHE PACKAGE NAME")="DVBPSIM"
 S DVBARR("WEB SERVICE NAME")=DVBSERV
 S DVBARR("AVAILABILITY RESOURCE")="?wsdl"
 S DVBSTAT=$$GENPORT^XOBWLIB(.DVBARR)
 ;
 I 'DVBSTAT D BMES^XPDUTL("**** Error creating Web Service (#18.02)"_DVBSERV),MES^XPDUTL(DVBSTAT) Q
 D BMES^XPDUTL(">>> "_DVBSERV_" entry added to WEB SERVICE file #18.02")
 D BMES^XPDUTL("  - Be sure and set up the Web Server as in the post-install instructions!!")
 ;
 Q
 ;
ERROR ; - catch errors
 ; Set ecode to empty to return to calling function
 ;
 ; $$EOFAC^XOBWLIB, ZTER^XOBWLIB - #5421
 ; UNWIND^%ZTER - #1621
 ;
 N DVBERR
 S DVBERR=$$EOFAC^XOBWLIB()
 D ZTER^XOBWLIB(DVBERR)
 S $ECODE=""
 D UNWIND^%ZTER
 Q
 ;
