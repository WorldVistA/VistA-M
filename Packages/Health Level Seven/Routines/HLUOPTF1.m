HLUOPTF1 ;ALB/CJM-HL7 -Set Logic for the AI x-ref on file 773 ;02/04/2004
 ;;1.6;HEALTH LEVEL SEVEN;**109**;Oct 13, 1995
 ;
PXREF(IEN,STATUS) ;sets the AI x-ref on file 773 and the FAST PURGE DT/TM fields in file 772 and 773
 ;Input:  IEN is the ien of record in file 773
 ;        STATUS is the new value of the STATUS field
 ;Output: none
 ;
 Q:'$G(IEN)
 ;
 ;don't set the x-ref if status is  not Successfully Completed 
 Q:($G(STATUS)'=3)
 ;
 N NODE,WHEN,CHILD
 ;
 ;also not if DON'T PURGE field is set
 Q:$P($G(^HLMA(IEN,2)),"^")=1
 ;
 ;also not if this isn't the initial message
 S NODE=$G(^HLMA(IEN,0))
 I $P(NODE,"^",6),$P(NODE,"^",6)'=IEN Q
 ;
 ;This record can be purged via FAST PURGE
 ;determine the dt/tm the record can be purged
 S WHEN=$$NOW^XLFDT
 S WHEN=$$FMADD^XLFDT(WHEN,$$WAIT)
 ;
 ;set the FAST PURGE DT/TM and x-ref, and do the same for file 772 record
 D SET(IEN,WHEN,+NODE)
 ;
 ;All the records in file 773 that point to this record (children) should be purged at the same time
 S CHILD=0
 F  S CHILD=$O(^HLMA("AF",IEN,CHILD)) Q:'CHILD  D:(CHILD'=IEN) SET(CHILD,WHEN,+$G(^HLMA(CHILD,0)))
 Q
 ;
SET(IEN773,WHEN,IEN772) ;sets FAST PURGE DT/TM for and the AI x~ref for both file 772 & 773
 ;Input:
 ;   IEN773 - ien of record to be purged in file 773
 ;   WHEN - date/time to purge
 ;   IEN772 - ien of corresponding record in file 772
 ;
 N OLDWHEN
 ;if the fast purge dt/tm changed, kill the old xref
 S OLDWHEN=$P($G(^HLMA(IEN773,2)),"^",2)
 I $L(OLDWHEN) K ^HLMA("AI",OLDWHEN,773,IEN773)
 ;
 ;set the FAST PURGE DATE
 S $P(^HLMA(IEN773,2),"^",2)=WHEN
 ;
 ;set the AI x-ref
 S ^HLMA("AI",WHEN,773,IEN773)=""
 ;
 ;do the same for the corresponding entry in file 772
 I IEN772,$D(^HL(772,IEN772,0)) D
 .;if the fast purge dt/tm changed, kill the old xref
 .S OLDWHEN=$P($G(^HL(772,IEN772,2)),"^",2)
 .I $L(OLDWHEN) K ^HLMA("AI",OLDWHEN,772,IEN772)
 .;set the FAST PURGE DATE
 .S $P(^HL(772,IEN772,2),"^",2)=WHEN
 .;
 .;set the AI x-ref
 .S ^HLMA("AI",WHEN,772,IEN772)=""
 Q
 ;
WAIT() ;
 ;returns the wait time to purge completed messages from file 869.3
 N IEN
 S IEN=$O(^HLCS(869.3,0))
 Q:'IEN 0
 Q +$G(^HLCS(869.3,IEN,4))
