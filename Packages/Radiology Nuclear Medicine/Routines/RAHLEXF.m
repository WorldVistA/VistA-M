RAHLEXF ;HIRMFO/BNT - RAD/NUC MED HL7 Exceptions filer;01/06/99
 ;;5.0;Radiology/Nuclear Medicine;**12,25**;Mar 16, 1998
 ;
 ;
 ; This routine is called from the bridge routine (^RAHLTCPB) when an 
 ; error occurs while processing an HL7 Message.
 ; The error is stored in the HL7 Message Exceptions File (#79.3)
 ; And, if requested, sent to the HL7 MAIL GROUP for this application
 ; 
 Q
EN1 ; Entry point called from Bridge routine.
 N RAEXFIL,RADT,RAPT,RAEX,RAERRX,SFAC,X,Y,RALNGCS,RAUSR,HLRADT,RAMSG
 ;
 ; File number of Exceptions File
 S RAEXFIL=79.3
 ;
 ; Date and Time of HL7 Transaction
 S HLRADT=$E($P($G(^TMP("RARPT-HL7",$J,1)),"|",7),1,14)
 S X=HLRADT,RADT=$$FMDATE^HLFNC(X)
 ;
 ; Radiology Patient Number
 S RAPT=$G(^TMP("RARPT-REC",$J,RASUB,"RADFN"))
 S RAPT="`"_RAPT
 ;
 ; Radiology Case Number
 S RALNGCS=$P($G(^TMP("RARPT-REC",$J,RASUB,"RALONGCN")),"-",2)
 ;
 ; Error (Exception) Text
 S RAERRX=RAERR
 ;
 ; Sending Application Name
 S SFAC=$G(HL("SAN"))
 ;
 ; Name of Verifying Physician or Interpreting staff (COTS unit user)
 S RAUSR=$G(^TMP("RARPT-REC",$J,RASUB,"RAVERF"))
 I RAUSR]"" D
 . D FIND^DIC(200,"",".01","AX",RAUSR,"","","","","RAOUT")
 . Q:'$D(RAOUT("DILIST","ID",1,.01))
 . S RAUSR=RAOUT("DILIST","ID",1,.01)
 ;
 ; IEN of entry in file 773 - Message Administration file.
 S RAMSG=$P(^TMP("RARPT-HL7",$J,1),"|",10)
 ;
 ; Go File the exception
 D RAERR
 ;
 ; Send mail message
 D MAIL(SFAC,$G(HL("SAF")),RAERR,RALNGCS,$P(RAPT,"`",2),RADT,RAUSR)
 ;
 D EXIT
 ;
 Q
RAERR ; Build array and update Exceptions File.
 S RAEX(0,RAEXFIL,"+1,",.01)=RADT
 S RAEX(0,RAEXFIL,"+1,",.02)=SFAC
 S RAEX(0,RAEXFIL,"+1,",1)=RAERRX
 S:$G(RAPT)]"" RAEX(0,RAEXFIL,"+1,",.03)=RAPT
 S:$G(RALNGCS)]"" RAEX(0,RAEXFIL,"+1,",.04)=RALNGCS
 S:$G(RAUSR)]"" RAEX(0,RAEXFIL,"+1,",.06)=RAUSR
 S:$G(RAMSG)]"" RAEX(0,RAEXFIL,"+1,",.05)=RAMSG
 D UPDATE^DIE("E","RAEX(0)","")
 Q
 ;
MAIL(SAN,SAF,RAERR,RACN,RADFN,RADT,RAUSR) ; Send mail message with error text.
 ;
 ; INPUT PARAMETERS:
 ; SAN = HL7 Sending Application (Required)
 ; SAF = Sending Facility Name
 ; RAERR = Error Message to display (Required)
 ; RACN = Radiology Case Number
 ; RADFN = Rad Patient File (#70) IEN
 ; RADT = Date & Time of HL7 message (FileMan format)
 ; RAUSR = Name of Verifying Physician
 ;
 N RAERTXT,RAMGP,XMY,XMDUZ,XMSUB,Y
 ;
 S RAMGP=$P($$GETAPP^HLCS2(SAN),"^",1) ; Get mail group
 Q:RAMGP=""
 ;
 S RAPT=$P($G(^DPT(+RADFN,0)),"^")
 S:RAPT="" RAPT="UNKNOWN"
 ;
 S RACN=$S($G(RACN)]"":$G(RACN),1:"???")
 S RAUSR=$S($G(RAUSR)]"":$G(RAUSR),1:"UNKOWN")
 S Y=RADT D DD^%DT S RADT=$S(Y]"":Y,1:"UNKOWN DATE/TIME")
 S SAF=$S($G(SAF)]"":$G(SAF),1:SAN)
 ;
 S XMDUZ="Rad HL7 Interface Processor"
 ;
 S XMSUB="HL7 message from "_SAF_" application rejected."
 ;
 S RAERTXT(1)="There was a problem processing an HL7 message sent by "
 S RAERTXT(2)=SAF_" on "_RADT_"."
 S RAERTXT(3)=""
 S RAERTXT(4)="The report entered on Case #"_RACN_" for "_RAPT
 S RAERTXT(5)="was rejected by Radiology/Nuclear Medicine."
 S RAERTXT(6)=""
 S RAERTXT(7)="The reason given was:"
 S RAERTXT(8)=RAERR
 S RAERTXT(9)=""
 S RAERTXT(10)="(  This message has been sent to G."_RAMGP
 S RAERTXT(11)="   and to the verifying physician, "_RAUSR_"  )"
 S XMTEXT="RAERTXT("
 ;
 S:$O(^XMB(3.8,"B",RAMGP,0)) XMY("G."_RAMGP)="" ; send to group
 S:$G(RAUSR)]"" XMY(RAUSR)="" ; send to dictating doctor
 ;
 D ^XMD
 ;
 Q
EXIT ; Kill variables and return to bridge routine..
 K RAEX,RADT,RAERRX,RAPT,SFAC,RAEXFIL,RALNGCS,RAUSR,RAMSG,X,Y
 Q
