PSS224PI ;BIR/RTR - PATCH PSS*1*224 Post-Init Routine ;05/11/2018
 ;;1.0;PHARMACY DATA MANAGEMENT;**224**;9/30/97;Build 3
 ;
 Q
 ;
EN ;Check for PUMP(S) in DOSE UNITS File
 I '$D(^PS(51.24,54)),'$$ADD D MAIL(0) Q
 I '$$VAL D MAIL(0) Q
 D MAIL(1)
 Q
 ;
 ;
VAL() ;Validate data
 D BMES^XPDUTL("Validating PUMP(S) entry in DOSE UNITS (#51.24) File...")
 I $G(^PS(51.24,54,0))'="PUMP(S)^PUMPS^1" Q 0
 I $G(^PS(51.24,54,1,1,0))'="PUMP" Q 0
 I '$D(^PS(51.24,54,1,"B","PUMP",1)) Q 0
 I '$D(^PS(51.24,"B","PUMP(S)",54)) Q 0
 I '$D(^PS(51.24,"C","PUMPS",54)) Q 0
 I '$D(^PS(51.24,"D","PUMP",54,1)) Q 0
 I '$D(^PS(51.24,"UPCASE","PUMP(S)",54)) Q 0
 Q 1
 ;
 ;
MAIL(PSSPUMRS) ;send mail message
 ;PSSPUMRS=0 - Problem adding PUMP(S)
 ;PSSPUMRS=1 - PUMP(S) added successfully
 N XMTEXT,XMY,XMSUB,XMDUZ,XMMG,XMSTRIP,XMROU,XMYBLOB,XMZ
 K ^TMP($J,"PSS224TX")
 S ^TMP($J,"PSS224TX",1)="PSS*1.0*224 patch installation has completed.",^TMP($J,"PSS224TX",2)=""
 I 'PSSPUMRS D
 .D BMES^XPDUTL("***Invalid PUMP(S) entry in your DOSE UNITS (#51.24) File...")
 .S ^TMP($J,"PSS224TX",3)="A problem was encountered when adding/verifying the new PUMP(S) entry in"
 .S ^TMP($J,"PSS224TX",4)="your DOSE UNITS (#51.24) File. It is OK to install the remaining Mocha 2.1b"
 .S ^TMP($J,"PSS224TX",5)="warranty patches, but contact the national help desk for assistance with this"
 .S ^TMP($J,"PSS224TX",6)="Dose Unit problem. Refer to the PSS*1.0*224 patch installation in the ticket."
 I PSSPUMRS D
 .D BMES^XPDUTL("PUMP(S) successfully added to DOSE UNITS (#51.24) File...")
 .S ^TMP($J,"PSS224TX",3)="The new Dose Unit of PUMP(S) was successfully added to your DOSE"
 .S ^TMP($J,"PSS224TX",4)="UNITS (#51.24) File, no further action is necessary."
 S XMSUB="PSS*1.0*224 Installation Complete"
 S XMDUZ="PSS*1.0*224 Install"
 S XMTEXT="^TMP($J,""PSS224TX"","
 S XMY("G.PSS ORDER CHECKS")=""
 I $G(DUZ) S XMY(DUZ)=""
 N DIFROM D ^XMD
 I $D(XMMG) D
 .D BMES^XPDUTL("Problem sending mail message upon PSS*1*224 installation completion...")
 .I 'PSSPUMRS D  Q
 ..D BMES^XPDUTL("***Invalid PUMP(S) entry in your DOSE UNITS (#51.24) File...")
 .D BMES^XPDUTL("PUMP(S) successfully added to DOSE UNITS (#51.24) File...")
 K ^TMP($J,"PSS224TX")
 Q
 ;
 ;
ADD() ;Add PUMP(S) to Dose Units File
 ;Quit with 0 if unable to add
 D BMES^XPDUTL("Adding PUMP(S) to DOSE UNITS (#51.24) File...")
 N PSSADPMP,PSSADIEN,XUMF
 D KTMP S XUMF=""
 S PSSADPMP(1,51.24,"+1,",.01)="PUMP(S)"
 S PSSADPMP(1,51.24,"+1,",1)="PUMPS"
 S PSSADPMP(1,51.24,"+1,",3)=1
 S PSSADIEN(1)=54
 D UPDATE^DIE("","PSSADPMP(1)","PSSADIEN") I $D(^TMP("DIERR",$J)) D KTMP Q 0
 K PSSADPMP,PSSADIEN
 I $P($G(^PS(51.24,54,0)),"^")'="PUMP(S)" Q 0
 S PSSADIEN=54,XUMF=""
 S PSSADPMP(1,51.242,"+2,"_PSSADIEN_",",.01)="PUMP"
 D UPDATE^DIE("","PSSADPMP(1)")
 I $D(^TMP("DIERR",$J)) D KTMP Q 0
 D KTMP K XUMF
 Q 1
 ;
 ;
KTMP ;Kill TMP error global 
 K ^TMP("DIERR",$J)
 Q
