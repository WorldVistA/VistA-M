MDCPHL7B ;HINES OIFO/BJ - CliO HL7 Handler/validator;09 Aug 2006
 ;;1.0;CLINICAL PROCEDURES;**16**;Apr 01, 2004;Build 280
 ;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ; This routine uses the following IAs:
 ;  # 2434       - $$TOPURG^HLUTIL              HL7                            (supported)
 ;  #10112       - $$SITE^VASITE() call         Registration                   (supported)
 ;  #10138       - access ^HL(772               HL7                            (supported)
 ;  # 3273       - access ^HLMA(                HL7              (controlled subscription)
 ;
 ;only call via line tags.
 Q
 ;
GTMSGIDS(MDCPRSLT,MDCPSTAT) ; Gets message ids
 ;
 ; Gets a list of message ids from the CLIO_HL7_LOG file (file 704.002)
 ;   based on status.
 ;
 ; Parameters -
 ;   Covert:
 ;     None
 ;   Overt:
 ;     MDCPRSLT - The name of an array that will contain the results.
 ;     MDCPSTAT - Internal code for status
 ;       1 = Entered
 ;       2 = Awaiting Processing
 ;       3 = Error
 ;       4 = Processed
 ;
 ; Returns -
 ;   An array of IDs of entries in file 704.002
 ;
 S MDCPRSLT=$NA(^TMP($J,"MDCPRSLT"))
 N I,J S I=1,J=0
 F  S J=$O(^MDC(704.002,"AS",MDCPSTAT,J)) Q:'J  D
 .S @MDCPRSLT@(1,I)=J
 .S I=I+1
 S @MDCPRSLT=I_U
 S @MDCPRSLT@(0)="0^"_I
 Q
 ;
GETMSG(MDCPRSLT,MDCPMSG) ; Gets a message based on ID
 ;
 ; Gets a message based on ID from the HL7 subsystem.
 ; IA
 ;   10138 (supported) - Used to reference the incoming message text in 772
 ;   ?? - SITE^VASITE extrinsic.
 ; Parameters -
 ;   Overt:
 ;     MDCPRSLT- The name of a global in which the message will be saved.
 ;     MDCPMSG- The IEN of the HL7 message in 703.1.
 ;
 ; Returns -
 ;   Root Node = Message ID (File 772 field 6)^Patient DFN^Facility
 ;   Node 0 = Message MSH segment
 ;   Node 1,n = The HL7 Message based on ID.
 ;
 S MDCPRSLT=$NA(^TMP("MDCPGTWY",$J))
 K @MDCPRSLT
 N MDCPHL7
 N MDCPDFN
 S MDCPDFN=$P($G(^MDC(704.002,MDCPMSG,0)),U,6)
 ; Need to set ^TMP($J,"MDCPRSLT,0) to the MSH segment for the message.
 ; Again, we're going to assume that everything we'll need from the MSH segment will be on the first line.
 N MDCPIEN S MDCPIEN=$P($G(^MDC(704.002,MDCPMSG,0)),U,4)
 N MDCPIENS S MDCPIENS=$P($G(^MDC(704.002,MDCPMSG,0)),U,5)
 S @MDCPRSLT@(-1,1)=$G(MDCPIENS)_U_$G(MDCPDFN)_U_$P($$SITE^VASITE(),U,3)
 I +MDCPIEN>0 S @MDCPRSLT@(0,1)=$G(^HLMA(MDCPIEN,"MSH",1,0))
 N I,MDCPHLSG S I=0
 F  S I=$O(^HL(772,MDCPIENS,"IN",I)) Q:'I  D
 .S MDCPHLSG=$G(^HL(772,MDCPIENS,"IN",I,0))
 .I ($G(MDCPHLSG)'=" ")&($L(MDCPHLSG)>1)  D
 ..S @MDCPRSLT@(1,I)=$G(^HL(772,MDCPIENS,"IN",I,0))
 Q
 ;
UPDATERP(MDCPRSLT,MDCPMSG,MDCPSTAT,MDCPDFN,MDCPMAP) ; Updates CP RESULT REPORT status
 ;
 ; Sets the status field of the message identified by
 ; MDCPMSG in 704.002 to the status listed in status.  Status
 ; must be in internal format.
 ;
 ; Parameters -
 ;   Covert: none
 ;   Overt:
 ;     MDCPMSG - IFN of message in CP RESULT REPORT file
 ;     MDCPSTAT - Status (in INTERNAL format).
 ;     MDCPDFN - (Optional) The IFN of the patient in the patient file.
 ;     MDCPMAP - (Optional) The identifier of the mapping table from CliO.
 ;
 ; Returns -
 ;   MDCPRSLT: A variable passed by reference containing the results of the status update.
 ;
 N MDCPFDA,MDCPPTID,MDCPIFN,MDCPERR,MDCPROC,MDCPEST,MDNOW,MDTMP
 S MDCPIENS=$G(MDCPMSG)_","
 D NOW^%DTC S MDNOW=%
 S MDCPEST=$$EXTERNAL^DILFD(704.002,.02,"",MDCPSTAT)
 S MDCPFDA(704.002,MDCPIENS,".02")=MDCPSTAT
 S:+$G(MDCPSTAT)="4" MDCPFDA(704.002,MDCPIENS,".09")=MDNOW
 ;S:$D(MDCPDFN)#10 MDCPFDA(704.002,MDCPIENS,".06")=MDCPDFN
 ;S:$D(MDCPMAP)#10 MDCPFDA(704.002,MDCPIENS,".03")=MDCPMAP
 D FILE^DIE("K","MDCPFDA","MDCPERR")
 I $D(MDCPERR) D  Q
 .D UPDRSN(.MDTMP,MDCPMSG,"Unable to change status of entry '"_MDCPMSG_"' to "_$G(MDCPEST))
 .S MDCPRSLT(0)="0^"_$G(MDCPERR(1,"TEXT",1),"Fileman didn't return a reason")
 ;
 ; Status change was successful - Now lets log it and keep going
 ;
 D UPDRSN(.MDTMP,MDCPMSG,"Status of entry '"_MDCPMSG_"' changed to "_$G(MDCPEST))
 S MDCPRSLT(0)="1^Status updated to "_MDCPEST
 ;
 ; We're going to get rid of the M trigger on the log file and directly notify the Windows service
 ; that we've got a message ready.  While it was cool, there was too much of a chance of bad things 
 ; happening if someone went in and edited this file and hit the trigger accidentally.
 ;
 I MDCPSTAT=2 D  Q
 .S MDCPVDFN=$P($G(^MDC(704.002,MDCPMSG,0)),U,6)
 .S MDCPVMAP=$P($G(^MDC(704.002,MDCPMSG,0)),U,3)
 .I (+MDCPVDFN)&(MDCPVMAP]"") D  Q
 ..D EN^MDCPSIGN(MDCPMSG)  ; Message sent to the gateway!
 .K MDCPVDFN,MDCPVMAP
 .; Set message back to error
 .S MDCPFDA(704.002,MDCPIENS,".02")=3
 .D FILE^DIE("K","MDCPFDA","MDCPERR")
 .D UPDRSN(.MDTMP,MDCPMSG,"Unable to change status of entry to "_$G(MDCPEST)_". Missing instrument or patient.")
 .S MDCPRSLT(0)="0^Unable to change status, missing patient or instrument"
 ;
 I $G(MDCPSTAT)="4" D  Q
 .S HLMTIENS=$P($G(^MDC(704.002,MDCPMSG,0)),U,4)
 .I $$TOPURG^HLUTIL<0 D UPDRSN(.MDTMP,MDCPMSG,"Unable to purge entry "_$G(MDCPMSG))
 ;
 Q
 ;
UPDRSN(MDCPRSLT,MDCPMSG,MDCPTEXT) ; Update CLIO_HL7_LOG file with a reason for a status.
 ; Published as MDCP UPDATE MESSAGE REASON
 ;
 ; Parameters -
 ;   Covert: none
 ;   Overt:
 ;     MDCPMSG - IFN of message in CP RESULT REPORT file
 ;     MDCPSTAT - The text to set place in .
 ;
 ; Returns -
 ;   MDCPRSLT: A global variable $NA() containing the results of the status update.
 ;
 S MDCPRSLT=$NA(^TMP($J)) K @MDCPRSLT
 N MDCPFDA
 D NOW^%DTC
 S MDCPFDA(704.004,"+1,",.01)=MDCPMSG
 S MDCPFDA(704.004,"+1,",.02)=%
 S MDCPFDA(704.004,"+1,",.1)=MDCPTEXT
 D UPDATE^DIE("","MDCPFDA")
 S @MDCPRSLT="1^Message Log Updated"
 S @MDCPRSLT@(0)="1^Message Log Updated"
 Q
 ;
CLRERR ; Quick clear of the HL7 error log
 N MDX,MDZ
 W !,"Set all HL7 errors to processed" S %=2 D YN^DICN Q:%'=1
 F MDX=0:0 S MDX=$O(^MDC(704.002,"AS",3,MDX)) Q:'MDX  D UPDATERP(.MDZ,MDX,4) W "."
 Q
 ;
