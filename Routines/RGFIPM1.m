RGFIPM1 ;ALB/CJM-PROCESS FACILITY INTEGRATION MESSAGE ;08/27/99
 ;;1.0;CLINICAL INFO RESOURCE NETWORK;**5,9**;30 Apr 99
 ;
RECEIVE ;
 ;Description: Process the Facility Integration Message
 ;
 ;Input:
 ;  HL7 variables must be defined
 ;Output: none
 ;Variables:
 ;  LEGACY - station # of legacy site
 ;  PRIMARY - station # of primary site
 ;  ICN - patient ICN from message
 ;  CHECKSUM - ICN checksum from message
 ;  CMOR - station # of CMOR
 ;  CMORIEN - ien of CMOR in Institution file
 ;  HERE - ien in Institution file of site this routine is executing on
 ;  HERE("STATION#") - station number of this site
 ;  FROM - station # of sending site
 ;  DFN - ien from the patient file
 ;  HLERR - error encountered
 ;  LCHKSUM - local checksum
 ;
 N CMOR,CMORIEN,LEGACY,PRIMARY,ICN,FROM,HERE,DFN,CHECKSUM,LCHKSUM
 K HLERR
 D
 .I '$$PARSE(0,.LEGACY,.PRIMARY,.ICN,.CHECKSUM,.FROM,.HLERR) Q
 .S HERE=$$SITE^VASITE(),HERE("STATION#")=$P(HERE,"^",3),HERE=+HERE
 .S DFN=$$DFN^RGFIU(ICN)
 .I ('DFN)!('$D(^DPT(+DFN))) D  Q
 ..S HLERR=$$ERROR("PATIENT LOOKUP BASED ON ICN FAILED",228,ICN)
 .;
 .S LCHKSUM=$P($$GETICN^MPIF001(DFN),"V",2)
 .I (+CHECKSUM)'=(+LCHKSUM) D  Q
 ..;If this is a local problem notify the local site
 ..I (+LCHKSUM)'=(+$$CHECKDG^MPIFSPC(ICN)) D
 ...S HLERR=$$ERROR("LOCAL DATABASE HAS INCORRECT ICN CHECKSUM",1,ICN)
 ...D EXC^RGFIU(1,$P(HLERR,"^",2),DFN)
 ..E  D
 ...S HLERR=$$ERROR("SENT INCORRECT ICN CHECKSUM",1,ICN)
 .;
 .S CMORIEN=$P($$MPINODE^RGFIU(DFN),"^",3)
 .S CMOR=$$STATNUM^RGFIU(CMORIEN)
 .;
 .;Notify site if there is no station number for CMOR
 .I 'CMOR D EXC^RGFIU(221,"ERROR ENCOUNTERED WHILE PROCESSING FACILITY INTEGRATION MESSAGE",DFN)
 .;
 .;If this is the legacy site it does not need to process this message
 .Q:(HERE("STATION#")=LEGACY)
 .;
 .;If this site is the CMOR, it should only be receiving this message
 .;from the legacy site
 .I (CMORIEN=HERE),(FROM'=LEGACY) D  Q
 ..S HLERR=$$ERROR("SITE INTEGRATION MSG TO CMOR NOT FROM LEGACY SITE",230,ICN)
 .;
 .;If this site is not the CMOR, the message must be from the CMOR
 .I CMORIEN,HERE'=CMORIEN,FROM'=CMOR D  Q
 ..S HLERR=$$ERROR("SITE INTEGRATION MSG NOT FROM CMOR, CMOR IS "_CMOR,226,ICN)
 .;
 .;update database
 .I '$$XCHANGE^RGFIPM(DFN,LEGACY,PRIMARY) ;local exceptins are logged by $$XCHANGE if errors are encountered
 .;
 .;at this point the receiving application has decided that it can accept the message.  An AA will be returned to the sender.
 .;
 .I '$D(HLERR),$G(HL("APAT"))="AL" D ACK(FROM,.HLERR)
 .;
 .;if this is the CMOR, notify subscribers & MPI of the site integration
 .I CMORIEN=HERE,'$$SEND^RGFIBM(DFN,LEGACY,PRIMARY) ;local exceptions are logged by $$SEND if errors are encountered
 ;
 I $D(HLERR),$G(HL("APAT"))="AL" D ACK(FROM,.HLERR)
 D:$G(RGLOG) STOP^RGHLLOG(1)
 Q
 ;
ACK(FROM,HLERR) ;
 ;Description:  Send an acknowledment
 ;
 ;Input:
 ;  FROM - station number of site that sent the original message
 ;  HLERR - error to be returned in format <exception code>^<error text>
 ;  HL7 variables - assumed defined
 ;
 N RESULT,HLA,FS,CS,HLL,TOLINK
 S TOLINK=$$GETLINK^RGFIU($$LKUP^XUAF4(FROM))
 S HLL("LINKS",1)="RG FACILITY INTEGRATION CLIENT^"_TOLINK
 S FS=HL("FS"),CS=$E(HL("ECH"),1)
 I $D(HLERR) D
 .;return NAK
 .S HLA("HLA",1)="MSA"_FS_"ER"_FS_HL("MID")_FS_$P($G(HLERR),";;",2)_FS_FS_FS_CS_CS_CS_$P($G(HLERR),";;")
 E  D
 .;return ACK
 .S HLA("HLA",1)="MSA"_FS_"AA"_FS_HL("MID")
 D GENACK^HLMA1(HL("EID"),HLMTIENS,HL("EIDS"),"LM",1,.RESULT)
 Q
 ;
PARSE(SKIPMSH,LEGACY,PRIMARY,ICN,CHECKSUM,FROM,HLERR) ;
 ;Description:  Parses the message and returns parameters.
 ;Input:
 ;   SKIPMSH - (optional) if set to 1, means that the MSH segment is
 ;              not expected to exist. This is the case when the
 ;              routing logic is called.
 ;   HL7 variables must be defined (assumed)
 ;Output:
 ;  Function Value:  1 on success, 0 on failure
 ;  LEGACY - station # of legacy site (pass by reference)
 ;  PRIMARY - station # of primary site (pass by reference)
 ;  ICN - ICN of patient (pass by reference)
 ;  CHECKSUM - ICN checksum (pass by reference)
 ;  FROM - station # of sendign site (pass by reference)
 ;  HLERR - returns a message if an error is encountered (pass by reference) 
 ;
 ;Variables:
 ;  FS - field seperator
 ;  CS - component seperator
 ;  ERRFLAG - initially set to 1, set to 0 if message passes all checks
 ;
 N FS,CS,ERRFLAG
 S FS=HL("FS")
 S CS=$E(HL("ECH"),1)
 S ERRFLAG=1
 S (LEGACY,PRIMARY,ICN,CHECKSUM,FROM)=""
 K HLERR
 ;
 D
 .D:'$G(SKIPMSH)  Q:$D(HLERR)
 ..X HLNEXT I (HLQUIT'>0) S HLERR=$$SEGERROR("MSH") Q
 ..I $P(HLNODE,FS)'["MSH" S HLERR=$$SEGERROR("MSH") Q
 ..S FROM=$P($P(HLNODE,FS,4),CS)
 ..I 'FROM S HLERR=$$ERROR("MISSING STATION NUMBER IN MSH SEGMENT FOR SENDING SITE",11) Q
 .;
 .X HLNEXT I (HLQUIT'>0) S HLERR=$$SEGERROR("EVN") Q
 .I $P(HLNODE,FS)'["EVN" D  Q:$D(HLERR)
 ..I $G(SKIPMSH) X HLNEXT
 ..I $P(HLNODE,FS)'["EVN" S HLERR=$$SEGERROR("EVN") Q
 .I $P(HLNODE,FS,5)'=51 S HLERR=$$ERROR("EVENT REASON CODE NOT 51",9) Q
 .;
 .X HLNEXT I (HLQUIT'>0) S HLERR=$$SEGERROR("PID") Q
 .I $P(HLNODE,FS)'["PID" S HLERR=$$SEGERROR("PID") Q
 .S ICN=$P($P(HLNODE,FS,3),"V")
 .I 'ICN D  Q
 ..S HLERR=$$ERROR("MISSING ICN IN PID SEGMENT",10)
 .S CHECKSUM=$P($P(HLNODE,FS,3),"V",2)
 .;
 .X HLNEXT I (HLQUIT'>0) S HLERR=$$SEGERROR("PV1",ICN) Q
 .I $P(HLNODE,FS)'["PV1" S HLERR=$$SEGERROR("PV1",ICN) Q
 .;
 .X HLNEXT I (HLQUIT'>0) S HLERR=$$SEGERROR("NTE",ICN) Q
 .I $P(HLNODE,FS)'["NTE" S HLERR=$$SEGERROR("NTE",ICN) Q
 .S LEGACY=$P($P(HLNODE,FS,4),CS)
 .I 'LEGACY S HLERR=$$ERROR("MISSING LEGACY STATION # IN NTE SEGMENT",8,ICN) Q
 .S PRIMARY=$P($P(HLNODE,FS,4),CS,2)
 .I 'PRIMARY S HLERR=$$ERROR("MISSING PRIMARY STATION # IN NTE SEGMENT",8,ICN) Q
 .S ERRFLAG=0
 Q 'ERRFLAG
 ;
ERROR(ERRMSG,CODE,ICN) ;
 ;Description:  formats ERRMSG in format <exception type>;;<error text>
 ;Input:
 ;  ERRMSG - text to incorporate into message
 ;  CODE - Exception Type
 ;  ICN - patient ICN
 ;  
 ;
 Q $G(CODE)_";;"_" From Station:"_$P($$SITE^VASITE(),"^",3)_" ICN:"_$G(ICN)_" Code:"_$G(CODE)_" Msg:"_$G(ERRMSG)
 ;
 ;
SEGERROR(SEGMENT,ICN) ;
 ;Description:  formats error if expected segment not there
 S ERRMSG="MISSING SEGMENT: "_SEGMENT
 Q $$ERROR(ERRMSG,7,$G(ICN))
