SRHLMFN ;B'HAM ISC/DLR - Surgery Interface Master File Notification Message ; [ 05/19/98  9:31 AM ]
 ;;3.0; Surgery ;**41**;24 Jun 93
 ; Per VHA Directive 10-93-142, this routine SHOULD NOT be modified.
MSG(SRTBL,FEC,REC,SRENT) ;sends MFN message
 ;MFN - Master File Notification Message
 ; SRTBL - table entry consisting of <name><file><field>
 ; FEC   - file event code (MAD,MDC,MAC,MDL)
 ; REC   - record event code (REP,UPD)
 ; SRENT - (IEN) internal entry number of the record to be passed
 ;
 N HLCOMP,HLREP,HLSUB,ID,FIELD,FILE,SRI,XX
 S HLDAP=$O(^HL(771,"B","SR SURGERY",0)) Q:$G(HLDAP)=""
 Q:$P($G(^HL(771,HLDAP,0)),U,2)'="a"
 D INIT
 S SRI=1,HLCOMP=$E(HL("ECH"),1),HLREP=$E(HL("ECH"),2),HLSUB=$E(HL("ECH"),4)
 S ID=$P(SRTBL,U),FIELD=$P(SRTBL,U,3),FILE=$P(SRTBL,U,2)
 D MFI^SRHLUO3(.SRI,ID,FEC,FILE,SRENT)
 D MFE^SRHLUO3(.SRI,REC,FILE,FIELD,SRENT)
 D GEN
EXIT W !,REC," Sending HL7 Master File ",$S(REC="MAD":"addition",REC="MDC":"deactivate",REC="MAC":"Reactivation",REC="MDL":"Deletion",1:"")," message" F XX=1:1:5 W "."
 Q
INIT ;V. 1.6 interface
 ;EID - IEN of event protocol
 ;HL - array of output parameters
 ;INT - only for VISTA-to-VISTA message exchange
 ;SRET - Surgery Event Trigger
 I $P(SRTBL,U,2)=200 S SRET="SR Staff Master File Notification"
 E  S SRET="SR Other Master File Notification"
 S EID=$O(^ORD(101,"B",SRET,0)),HL="HL",INT=0
 D INIT^HLFNC2(EID,.HL,INT) S HLCOMP=$E(HL("ECH"),1),HLREP=$E(HL("ECH"),2),HLSUB=$E(HL("ECH"),4),HLFS=HL("FS"),HLQ=HL("Q"),HLECH=HL("ECH")
 Q
GEN ;generate the message
 ;HLEID - IEN of event protocol
 ;HLARYTYP - acknowledgement array (see V. 1.6 HL7 doc)
 ;HLFORMAT - is HLMA is pre-formatted HL7 form
 ;HLMTIEN - IEN in 772
 ;HLRESLT - message ID and/or the error message (for output)
 ;HLP("CONTPTR") - continuation pointer field value (not used)
 ;HLP("PRIORITY") - priority field value (not used)
 ;HLP("SECURITY") - security information (not used)
 S HLEID=EID,HLARYTYP="GM",HLFORMAT=1,HLMTIEN="",HLRESLT=""
 D GENERATE^HLMA(HLEID,HLARYTYP,HLFORMAT,.HLRESLT,HLMTIEN,.HLP)
 Q
