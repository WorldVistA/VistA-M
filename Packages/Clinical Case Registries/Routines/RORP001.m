RORP001 ;HCIOFO/SG - PATCH ROR*1.5*1 INSTALLATION ROUTINE ; 7/18/06 9:38am
 ;;1.5;CLINICAL CASE REGISTRIES;**1**;Feb 17, 2006;Build 24
 ;
 ;***** ENVIRONMENT CHECK
 N RC
 ;--- Check the User ID
 I $G(DUZ)'>0  D  S XPDABORT=2  Q
 . W !!,"The DUZ variable must be defined!",!
 ;--- Check the required security key
 I '$D(^XUSEC("ROR VA IRM",DUZ))  D  S XPDABORT=2  Q
 . W !!,"You must have the ROR VA IRM security key!",!
 ;
 ;=== Installation section
 Q:'$G(XPDENV)
 ;--- Check the scheduled option
 I $$CHKOPT^RORKIDS("ROR TASK")<0  S XPDABORT=2  Q
 ;--- Override the "Want to DISABLE Options, and Protocols?" question
 S XPDDIQ("XPZ1")=0
 Q
 ;
 ;***** ERROR PROCESSING
ERROR ;
 N TMP  S XPDABORT=1
 I $D(ZTQUEUED)  D  D ALERT^RORKIDS(DUZ,-43,REGNAME,,TMP)
 . S TMP=+$G(RORPARM("KIDS"))
 . S TMP=$S(TMP=1:"pre-",TMP=2:"post-",1:"")_"install"
 D DSPSTK^RORERR(),ABTMSG^RORKIDS()
 Q
 ;
 ;***** POST-INSTALL ENTRY POINT
POS ;
 N RORERROR      ; Error processing data
 N RORLOG        ; Log subsystem constants & variables
 N RORPARM       ; Application parameters
 ;
 N DA,RC,RORHIV,TMP
 S RORPARM("DEVELOPER")=1   ; Enable modifications
 S RORPARM("ERR")=1         ; Enable error processing
 S RORPARM("KIDS")=2        ; Post-install indicator
 S RORPARM("LOG")=1         ; Enable log recording
 ;
 ;--- Open a new log
 K TMP  S TMP("VA HIV")=""
 S TMP=$$OPEN^RORLOG(.TMP,0,XPDNM_" POST-INSTALL STARTED")
 K TMP
 ;
 ;--- Initialize variables
 S RORHIV=$$REGIEN^RORUTL02("VA HIV")  G:RORHIV<0 ERROR
 S RORHIV=RORHIV_U_"VA HIV"
 ;
 ;--- ROR GENERIC DRUG file (#799.51)
 G:$$CP^RORKIDS("POS05","$$RS79951^RORPUT02")<0 ERROR
 ;
 ;--- Restore the CDC definition
 G:$$CP^RORKIDS("POS10","$$CDCDEF^RORPUT01")<0 ERROR
 ;
 ;--- Restore predefined report templates
 G:$$CP^RORKIDS("POS15","$$RSPRT^RORPUT02")<0 ERROR
 ;
 ;--- Close the log
 D CLOSE^RORLOG(XPDNM_" POST-INSTALL COMPLETED")
 Q
 ;
 ;***** PRE-TRANSPORTATION ENTRY POINT
PTR ;
 N RORBUF,TMP
 ;--- Copy the CDC definition to the transport global
 D GETPARM^RORRP038(.RORBUF,"ICRCDCDEF","PKG")
 K RORBUF(0)  M @XPDGREF@("RORCDCDEF")=RORBUF
 ;--- Load the records of the ROR GENERIG DRUG file
 D LD79951^RORPUT02()
 ;--- Load predefined report templates
 D LDPRT^RORPUT02()
 Q
