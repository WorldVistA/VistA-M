MDCPHL7A ;HINES OIFO/BJ - CliO HL7 Handler/validator;09 Aug 2006
 ;;1.0;CLINICAL PROCEDURES;**16**;Apr 01, 2004;Build 280
 ;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ; This routine uses the following IAs:
 ;  #10106       - $$FMDATE^HLFNC               HL7                            (supported)
 ;  # 2165       - GENACK^HLMA1                 HL7                            (supported)
 ;  # 2434       - $$DONTPURG^HLUTIL            HL7                            (supported)
 ;
 ;;only call via line tags.
 Q
 ;
EN ;
 ; Main processing routine used by VistA HL7 subsystem
 ; Parameters -
 ;   Covert (preset local variables) -
 ;     See HL*1.6*56 guide, pg 9-4.
 ;       HLMTIENS - The message ID
 ;       HLNODE - Current message segment: set by HLNEXT;
 ;       HLNODE(N) - Continuation nodes for current segment.
 ;       HLQUIT - will be less than 1 if there are no more nodes.
 ;
 ; Returns -
 ;   None
 ;
 ; We get the message instrument, date/time, and IEN.
 ;
 N MDCPMSH,MDCPID,MDCPFS,MDCPV1,MDCPLOC,MDCPINST,MDCPDTTM,MDCPIEN
 S MDCPFS=$G(HLREC("FS"))
 I MDCPFS="" S MDCPFS=$G(HL("FS"))
 F  X HLNEXT Q:HLQUIT'>0  D
 .S:$P($G(HLNODE),MDCPFS)="MSH" MDCPMSH=HLNODE
 .S:$P($G(HLNODE),MDCPFS)="PID" MDCPID=HLNODE
 .S:$P($G(HLNODE),MDCPFS)="PV1" MDCPV1=HLNODE
 ;
 S MDCPINST=$P($G(MDCPMSH),MDCPFS,4)
 S MDCPDTTM=$$HL72FMDT($P($G(MDCPMSH),MDCPFS,7))
 S MDCPLOC=$P($G(MDCPV1),MDCPFS,4)
 S MDCPLOC=$P(MDCPLOC,$E(HL("ECH"),1),1)
 ;
 ; Check for XPAR setting to ignore this location (Entity = IGNORE_mdcploc)
 I MDCPLOC]"",$$GET^XPAR("SYS","MD PARAMETERS","IGNORE_"_MDCPLOC)=1 Q
 ;
 ; First, we log the message:
 S MDCPIEN=$$LOG(MDCPINST,$G(MDCPORD),MDCPDTTM,HLMTIEN,HLMTIENS,MDCPLOC)
 ;
 ; Next, we tell HL7 not to deep-six the message.  We'll release the message
 ; later once we're sure that everything was okay both here and GUI-side.
 I $$DONTPURG^HLUTIL<0 D UPDRSN^MDCPHL7B(.MDCPTMP,MDCPIEN,"Unable to set the DONT PURGE flag for this message.")
 ;
 S MDCPSTAT=2 ; Assume everything will be ready to process
 ;
 ; Validate the PID segment and Device.
 I '$$VALPID(MDCPIEN,MDCPID) D
 .D UPDRSN^MDCPHL7B(.MDCPTMP,MDCPIEN,"Invalid patient identifying information for patient")
 .S MDCPSTAT=3
 ;
 ; Now to see if a mapping table exists
 I '$$VALMAP(MDCPIEN,MDCPINST) D
 .D UPDRSN^MDCPHL7B(.MDCPTMP,MDCPIEN,"Invalid device information.")
 .S MDCPSTAT=3
 ;
 ; Try and get the location - won't error out if it's not there
 D VALLOC(MDCPIEN,MDCPLOC)
 ;
 ; Status 2 = "Awaiting Processing", 3 = "Error"
 D UPDATERP^MDCPHL7B(.MDCPERR,MDCPIEN,MDCPSTAT)
 ;
 ; Finally, we tell HL7 to ack the message, as not to leave the device hanging.
 ;
 I $G(HL("APAT"))["AL" D
 .N MDCPRSLT,MDCPMSG
 .S HLA("HLA",1)="MSA"_MDCPFS_"AA"_MDCPFS_HL("MID")
 .D GENACK^HLMA1(HL("EID"),HLMTIENS,HL("EIDS"),"LM",1,.MDCPRSLT)
 .I +$P($G(MDCPRSLT),U,2) D
 ..S MDCPSTAT="E"
 ..S MDCPMSG=$P(MDCPRSLT,U,3)
 .E  D
 ..S MDCPSTAT="M"
 ..S MDCPMSG="Message acked successfully."
 ;
 Q
 ;
LOG(MDCPINST,MDCPORD,MDCPDTTM,MDCPHL7,MDCPHDR,MDCPLOC) ; We need to make an entry in 704.002 for this message.
 ; Parameters -
 ;   Overt:
 ;     MDCPINST - The name of the instrument sending the message.
 ;     MDCPORD - The order identifier returned from the instrument.
 ;     MDCPDTTM - The date/time of the observation.
 ;     MDCPHL7- The HL7 message id in file 773.
 ;     MDCPHDR- The ID of the HL7 message in file 772 (for the MSH segment)
 ;     MDCPLOC- The reported location of the patient in this HL7 message
 ;
 ; Returns -
 ;   IEN of entry in 704.002.
 ;
 N MDCPFDA,MDCPID,MDCPRSLT,MDCPER,MDCPINS1,MDCPINS2,MDCPSTIN
 ;
 D GETGUID^MDCLIO1(.MDCPID)
 F  Q:'$D(^MDC(704.002,"PK",MDCPID))  D GETGUID^MDCLIO1(.MDCPID)
 S MDCPFDA(704.002,"+1,",.01)=MDCPID
 S MDCPFDA(704.002,"+1,",.02)=1
 S MDCPFDA(704.002,"+1,",.04)=MDCPHDR
 S MDCPFDA(704.002,"+1,",.05)=MDCPHL7
 S MDCPFDA(704.002,"+1,",.08)=MDCPDTTM
 S MDCPFDA(704.002,"+1,",.11)=$G(MDCPLOC)
 D UPDATE^DIE("","MDCPFDA","MDCPRSLT","MDCPER")
 I '$D(MDCPER) Q MDCPRSLT(1)
 Q -1
 ;
VALPID(MDCPIEN,MDCPID) ; Validate an HL7 PID segment.
 ;
 ; Note: This line tag assumes that all of the required segments are on the first
 ;   PID segment part to come through.  According to the HL7 v 2.4 spec, fields
 ;   3, 5, 6, 9, 10, 11, 13, 14, 15, 16, 17, and 18 (we're only interested in
 ;   fields up to 19) can each hold up to 250 characters.  However, this is not
 ;   something we'd expect to see in real life.
 ;
 ;   The Value in field 3,1 is expected to be canonic.  If it is not present, we'll look at field 19.
 ;   If field 19 is not present, then we drop back and punt.
 ; Parameters -
 ;   Overt:
 ;     MDCPIEN: The IEN of the message in the CP RESULT REPORT file
 ;     MDCPID: The PID segment of the message to validate.
 ;   Covert:
 ;     None.
 ;
 ;   The things that we're going to look at:
 ;   =======================================
 ;        Sequence  Description
 ;       - 3,1      Patient DFN or SSN(if given)
 ;       - 5,1      Patient Last Name
 ;       - 5,2      Patient First Name
 ;       - 5,3      Patient Middle Name
 ;       - 7        Patient DOB
 ;       - 8        Patient Sex
 ;       - *        Patient SSN:
 ;           If the SSN is given in the Patient ID array in segment 3, it needs to match what is in the DB
 ;           If the SSN is given in sequence 19, it needs to match what is in the DB
 ;           If the SSN is given in both places, both SSNs need to be identical.
 ;
 ;  Result:
 ;    Returns 0 if PID is invalid, 1 if PID is valid
 ;
 ;  Note: $$FMNAME^XLFNAME appears courtesy of IA #3065 (public).
 ;
 N MDCPFDA,MDCPDFN,MDCPNAME,MDCPDOB,MDCPSEX,MDCPSSN,MDCPIX,MDCPSCRN,MDCPTMP,MDCPSTAT
 ;
 S MDCPSSN=$P(MDCPID,HL("FS"),4)
 S MDCPSSN=$P(MDCPSSN,$E(HL("ECH"),1))
 ;
 ;Right now, as part of the HL7 Spec, we're allowing them to send either SSN or last initial/last 4.  It is my
 ;current understanding that the Patient Safety committee is going to require a full SSN for a match.  So, we may
 ;end out modifying this item.
 S MDCPIX=$S(MDCPSSN?9N:"SSN",1:"")
 I MDCPIX="" D UPDRSN^MDCPHL7B(.MDCPTMP,MDCPIEN,"The SSN in PID-3 is not in a recognized format")
 ;
 S MDCPDOB=$P(MDCPID,HL("FS"),8),MDCPDOB=$$FMDATE^HLFNC(MDCPDOB)
 S:MDCPDOB?7N1".24" MDCPDOB=$$FMADD^XLFDT(MDCPDOB\1,1,0,0,0)
 S MDCPDOB=MDCPDOB\1
 S MDCPSEX=$E($P(MDCPID,HL("FS"),9),1,1)
 ;S MDCPNAME=$$FMNAME^HLFNC($P(MDCPID,HL("FS"),6),HL("ECH"))
 S MDCPNAME=$$FMNAME^XLFNAME($P(MDCPID,HL("FS"),6),"S",$E(HL("ECH")))
 S MDCPSCRN="I $P(^DPT(Y,0),U,1)="""_MDCPNAME_""",$P(^DPT(Y,0),U,2)="""_MDCPSEX_""",$P(^DPT(Y,0),U,3)="""_MDCPDOB_""""
 S MDCPDFN=$$FIND1^DIC(2,"","X",MDCPSSN,"SSN",MDCPSCRN)
 S MDCPSTAT=$S(+$G(MDCPDFN)>0:+MDCPDFN,1:"0")
 ; Now to save the info into the log.
 S:MDCPDFN>0 MDCPFDA(704.002,MDCPIEN_",",.06)=MDCPDFN ; Only file if valid pt found
 S MDCPFDA(704.002,MDCPIEN_",",.21)=MDCPNAME_"|"_MDCPSSN_"|"_MDCPDOB_"|"_MDCPSEX_"|"
 D FILE^DIE("K","MDCPFDA")
 Q MDCPSTAT
 ;
VALMAP(MDCPIEN,MDCPINST) ; Validate an incoming device to a mapping table
 ; Purpose -
 ;   This line tag will take an incoming HL7 Sending Application and ensure
 ;   that it has a mapping table in the TERM_MAPPING_TABLE file (704.108)
 ;   Compare is done on field SOURCE_ID (#.21) via the 'SOURCE' x-ref
 ;
 N MDCPFDA,MDVALID
 S MDVALID=$$FIND1^DIC(704.108,"","X",MDCPINST,"HL7")
 S MDCPFDA(704.002,MDCPIEN_",",.31)=MDCPINST
 S MDCPFDA(704.002,MDCPIEN_",",.03)=$S(MDVALID>0:$$GET1^DIQ(704.108,MDVALID_",",.01),1:"")
 D FILE^DIE("K","MDCPFDA")
 Q (MDVALID>0)
 ;
VALLOC(MDCPIEN,MDCPLOC) ; Validate an incoming location to File 44
 N MDCPFDA,MDVALID
 S MDVALID=$$FIND1^DIC(44,"","X",MDCPLOC,"B")
 S MDCPFDA(704.002,MDCPIEN_",",.11)=MDCPLOC
 ;S MDCPFDA(704.002,MDCPIEN_",",**NEED A FIELD FOR THIS ITEM**)=$S(MDVALID>0:MDVALID,1:"")
 D FILE^DIE("K","MDCPFDA")
 Q
 ;
BLDARRY(MDCPVAL,MDCPSEP) ; Build an array
 ;
 ; Purpose-
 ;   This line tag will take the incoming string in MDCPVAL and will parse it based on the separator MDCPSEP.
 ;   It will then build a local array with each node containing a piece delimited by MDCPSEP.  As an example,
 ;   given that MDCPVAL="This^is^a^test~string" and MDCPSEP="^", then when this line tag is done processing,
 ;
 ;     MDCPVAL="This^is^a^test~string"
 ;     MDCPVAL(1)="This"
 ;     MDCPVAL(2)="is"
 ;     MDCPVAL(3)="a"
 ;     MDCPVAL(4)="test~string"
 ;
 ; Parameters
 ;   MDCPVAL - The string to parse.  Passed _by_reference_
 ;   MDCPSEP - The separator
 ;
 ; Note: For now, this call is NOT meant to be invoked outside of MDCPHVLD
 ;
 N I,J,MDCPTEMP S I=1,J=0
 S MDCPTEMP=MDCPVAL
 F  S MDCPVAL(I)=$P(MDCPTEMP,MDCPSEP,I) S I=I+1 Q:MDCPVAL(I-1)=""
 K MDCPVAL(I-1)
 Q
 ;
HL72FMDT(MDHL7) ; Convert an HL7 Date/Time to Fileman
 ; Check for YYYYMMDDhhmmss pattern first
 Q:MDHL7'?14N.E -1
 S MDRET=($E(MDHL7,1,4)-1700)_$E(MDHL7,5,6)_$E(MDHL7,7,8)
 S MDRET=MDRET+("."_$E(MDHL7,9,14))
 ; Check for .24 - Even the ancient Mayan calendar understands what zero means :(
 I MDRET?7N1".24" S MDRET=$$FMADD^XLFDT(MDRET\1,1,0,0,0)
 ; Check for YYYYMMDDhhmmss-nn offset because not everyone is on central time :)
 I MDHL7?14N1"-"1.2N S MDRET=$$FMADD^XLFDT(MDRET,0,+$P(MDHL7,"-",2)*-1,0,0)
 Q MDRET
 ;
