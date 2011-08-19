HLOASUB ;IRMFO-ALB/CJM - Subscription Registry ;08/17/2009
 ;;1.6;HEALTH LEVEL SEVEN;**126,146**;Oct 13, 1995;Build 16
 ;Per VHA Directive 2004-038, this routine should not be modified.
 ;
CREATE(OWNER,DESCRIP,ERROR) ;
 ;This API is used to create a new entry in the HLO Subscription Registry.
 ;Input:
 ;  OWNER - (required) The name of the owning application. The name of the owner. It should be prefixed with the package namespace to ensure uniqueness.
 ;  DESCRIPTION - (optional) a brief (1 line) description
 ;Output:
 ;  Function returns new file 779.4 ien, or 0 if error
 ;  ERROR (optional, pass by reference) an message on error
 ;
 N IEN,DATA
 K ERROR
 I '$L($G(OWNER)) S ERROR="OWNER NOT SPECIFIED" Q 0
 L +^HLD(779.4,0):60
 I '$T S ERROR="UNABLE TO LOCK THE HL7 SUBSCRIPTION REGISTRY" Q 0
 S IEN=$O(^HLD(779.4,":"),-1),IEN=IEN+1
 L -^HLD(779.4,0)
 S DATA(.01)=IEN
 S DATA(.02)=OWNER
 S DATA(.03)=$G(DESCRIP)
 Q $$ADD^HLOASUB1(779.4,,.DATA,.ERROR,IEN)
 ;
ONLIST(IEN,LINKIEN,APPNAME,FAC1,FAC2,FAC3) ;
 ;Determines whether the recipient is already on the subscription list.
 ;Input:
 ;  IEN - (required) ien of the subscription list
 ;  LINKIEN - ien of the logical link
 ;  APPNAME - receiving application
 ;  FAC1 -  component 1 of the receiving facility
 ;  FAC2 - component 2
 ;  FAC3 - component 3
 ;Output:
 ;  Function returns 0 if not found, otherwise the ien in the subfile
 ;
 Q +$O(^HLD(779.4,IEN,2,"AD",APPNAME,LINKIEN,FAC1_FAC2_FAC3,0))
 ;
ADD(IEN,WHO,ERROR) ;
 ;Adds a new recipient to the list of recipients for this Subscription Registry Entry.
 ;Input:
 ;  IEN- the ien of the entry in the HL7 SUBSCRIPTION REGISTRY file.
 ;  WHO (pass by reference) an array containing the information for a single new
 ;    recipient to be added to the list. These subscripts are allowed:
 ;
 ;    "RECEIVING APPLICATION" - (string, 60 char max, required)
 ;
 ;  EXACTLY ONE of these parameters must be provided to identify the Receiving Facility:
 ;
 ;   "FACILITY LINK IEN" - ien of the logical link 
 ;   "FACILITY LINK NAME" - name of the logical link 
 ;   "INSTITUTION IEN" - ptr to the INSTITUTION file
 ;   "STATION NUMBER" -  station # with suffix
 ;
 ;  EXACTLY ONE of these MAY be provided - optionally - to identify the interface engine to route the message through:
 ;
 ;   *"IE LINK IEN" (obsolete)  ptr to a logical link for the interface engine 
 ;   *"IE LINK NAME" (obsolete) - name of the logical link for the interface engine
 ;   "MIDDLEWARE LINK IEN" - a  ptr to a logical link for the middleware
 ;   "MIDDLEWARE LINK NAME" - name of the logical link for the middleware
 ;
 ;
 ;Output:
 ;   Function returns on success the ien of the recipient on the RECIPIENTS multiple , or 0 on failure
 ;   WHO - left undefined when this function returns
 ;   ERROR (optional, pass by reference) These error messages may be returned:
 ;SUBSCRIPTION REGISTRY ENTRY NOT FOUND
 ;RECEIVING FACILTY LOGICAL LINK NOT FOUND
 ;RECEIVING APPLICATION NOT FOUND
 ;MIDDLEWARE ENGINE LOGICAL LINK PROVIDED BUT NOT FOUND
 ;FAILED TO ACTIVATE SUBSCRIBER
 ;
 N PARMS,SUBIEN,DATA,DA,OK
 K ERROR
 S OK=0
 D
 .I '$G(IEN) S ERROR="SUBSCRIPITION REGISTRY ENTRY NOT FOUND" Q
 .Q:'$$CHECKWHO^HLOASUB1(.WHO,.PARMS,.ERROR)
 .S SUBIEN=$$ONLIST^HLOASUB1(IEN,.WHO)
 .I SUBIEN S OK=1 D  Q
 ..S DA=SUBIEN,DA(1)=IEN
 ..I $P(^HLD(779.4,IEN,2,SUBIEN,1),"^",2) S DATA(1.01)=$$NOW^XLFDT,DATA(1.02)="" S OK=$$UPD^HLOASUB1(779.41,.DA,.DATA) I 'OK S ERROR="FAILED TO ACTIVATE SUBSCRIBER"
 .;
 .S DA(1)=IEN
 .S DATA(.01)=PARMS("RECEIVING APPLICATION")
 .S DATA(.021)=PARMS("RECEIVING FACILITY","LINK IEN")
 .I PARMS("LINK IEN"),PARMS("LINK IEN")'=PARMS("RECEIVING FACILITY","LINK IEN") S DATA(.02)=PARMS("LINK IEN")
 .S DATA(.03)=PARMS("RECEIVING FACILITY",1)
 .S DATA(.04)=PARMS("RECEIVING FACILITY",2)
 .S DATA(.05)=PARMS("RECEIVING FACILITY",3)
 .S DATA(1.01)=$$NOW^XLFDT
 .S OK=$$ADD^HLOASUB1(779.41,.DA,.DATA,.ERROR)
 K WHO
 Q OK
 ;
NEXT(IEN,RECIP) ;
 ;gets the next recipient on the list. It ignores recipients
 ;that have a value for the DT/TM DELETED field.
 ;Input:
 ;  IEN (required) - the IEN assigned to this subscription
 ;  RECIP - if empty, it gets the first recipient on the list, else it uses the value of RECIP("SUBIEN") to find the next recipient
 ;Output:
 ;RECIP(pass by reference, required) - returns the next recipient on the list. These subscripts are returned:
 ;  "LINK IEN" - IEN of link overwhich to transmit the message (could be middleware)
 ;  "LINK NAME" - its name
 ;  "RECEIVING APPLICATION" 
 ; ("RECEIVING FACILITY",1)  - Component 1
 ; ("RECEIVING FACILITY",2)  - Component 2
 ; ("RECEIVING FACILITY",3)  - Component 2
 ;  "SUBIEN" - the ien in the multiple, used to find the next on the list.  
 ;Function Value - IEN in the subfile on success, 0 if there are no more recipients found on the list (in which case, set "SUBIEN"=-1, set all other subscripts to ""
 ;
 N LAST,NEXT,NODE,LINKIEN,OLD
 S LAST=+$G(RECIP("SUBIEN"))
 Q:(LAST=-1) 0
 Q:'$G(IEN) 0
 S NEXT=$O(^HLD(779.4,IEN,2,"AC",LAST))
 I 'NEXT D  Q 0
 .S RECIP("RECEIVING APPLICATION")=""
 .S RECIP("LINK IEN")=""
 .S RECIP("LINK NAME")=""
 .S RECIP("RECEIVING FACILITY",1)=""
 .S RECIP("RECEIVING FACILITY",2)=""
 .S RECIP("RECEIVING FACILITY",3)=""
 .S RECIP("SUBIEN")=-1
 ;
 S RECIP("SUBIEN")=NEXT
 S NODE=$G(^HLD(779.4,IEN,2,NEXT,0))
 S LINKIEN=+$P(NODE,"^",2)
 I 'LINKIEN S LINKIEN=+$P(NODE,"^",6)
 S RECIP("LINK IEN")=LINKIEN
 S RECIP("LINK NAME")=$P($G(^HLCS(870,LINKIEN,0)),"^")
 S RECIP("RECEIVING APPLICATION")=$P(NODE,"^")
 ;
 ;**P146 START CJM
 ;the station #, domain, or port may have changed
 S OLD("RECEIVING FACILITY",1)=$P(NODE,"^",3)
 S OLD("RECEIVING FACILITY",2)=$P(NODE,"^",4)
 S OLD("RECEIVING FACILITY",3)="DNS"
 S LINKIEN=$P(NODE,"^",6)
 I 'LINKIEN M RECIP=OLD Q NEXT
 S RECIP("RECEIVING FACILITY",1)=$$STATNUM^HLOTLNK(LINKIEN)
 S RECIP("RECEIVING FACILITY",2)=$$DOMAIN^HLOTLNK(LINKIEN)_":"_$$PORT^HLOTLNK(LINKIEN)
 S RECIP("RECEIVING FACILITY",3)="DNS"
 I (RECIP("RECEIVING FACILITY",1)'=OLD("RECEIVING FACILITY",1))!(RECIP("RECEIVING FACILITY",2)'=OLD("RECEIVING FACILITY",2)) D
 .N DA,DATA
 .S DATA(.03)=RECIP("RECEIVING FACILITY",1)
 .S DATA(.04)=RECIP("RECEIVING FACILITY",2)
 .S DATA(.05)="DNS"
 .S DA=NEXT,DA(1)=IEN
 .I $$UPD^HLOASUB1(779.41,.DA,.DATA)
 ;**P146 END CJM
 Q NEXT
 ;
END(IEN,WHO) ;will terminate a recipient from the list.The sub-record isn't
 ;deleted, but the DATE/TIME TERMINATED field is entered with the current
 ; date/time
 ;Input:
 ;  IEN - the ien of the HL7 Subscription Registry entry (required)
 ;  WHO - (required, pass by reference)  If WHO("SUBIEN") is defined, then it should be the ien of the sub-record to be terminated.  Otherwise, set the parameters as per $$ADD.
 ;Output: 
 ;  Function returns 1 on success, 0 on failure
 ;  WHO - left undefined when the function returns
 ;
 N SUBIEN,DATA,DA,OK
 S OK=0
 D
 .S SUBIEN=0
 .Q:'$G(IEN)
 .I $G(WHO("SUBIEN")) D
 ..S SUBIEN=WHO("SUBIEN")
 .E  D
 ..N PARMS
 ..S:$$CHECKWHO^HLOASUB1(.WHO,.PARMS) SUBIEN=$$ONLIST^HLOASUB1(IEN,.WHO)
 .I 'SUBIEN S OK=1 Q
 .S DA(1)=IEN,DA=SUBIEN
 .S DATA(1.02)=$$NOW^XLFDT
 .S OK=$$UPD^HLOASUB1(779.41,.DA,.DATA)
 K WHO
 Q OK
 ;
DELETE(IEN) ;Deletes the entry in the HL7 Subscription Registry.
 Q $$DELETE^HLOASUB1(779.4,$G(IEN))
 ;
 ;**P146 START CJM
ADDFAC(IEN,SUBIEN) ;
 ;Adds to the recipient sub-record components 1,2,3 of the Receiving
 ;Facility field of the message header.
 ;Input:
 ;  IEN- the ien of the entry in the HL7 SUBSCRIPTION REGISTRY file.
 ;  SUBIEN - ien in the multiple
 ;
 ;
 N PARMS,WHO,DATA,DA,NODE
 S NODE=$G(^HLD(779.4,+IEN,2,+SUBIEN,0))
 S WHO("RECEIVING APPLICATION")=$P(NODE,"^",1)
 S WHO("IE LINK IEN")=$P(NODE,"^",2)
 S WHO("FACILITY LINK IEN")=$P(NODE,"^",6)
 I '$$CHECKWHO^HLOASUB1(.WHO,.PARMS,.ERROR) W !,ERROR,! Q
 S DA=SUBIEN,DA(1)=IEN
 I '$P($G(^HLD(779.4,+IEN,2,+SUBIEN,1)),"^") S DATA(1.01)=$$NOW^XLFDT
 S DATA(.03)=PARMS("RECEIVING FACILITY",1)
 S DATA(.04)=PARMS("RECEIVING FACILITY",2)
 S DATA(.05)=PARMS("RECEIVING FACILITY",3)
 I '$$UPD^HLOASUB1(779.41,.DA,.DATA,.ERROR) W !,ERROR,!
 Q
 ;
TLINK(IEN,SUBIEN) ;
 ;returns the link overwhich to transmit for this subscriber
 ;
 N NODE,DLINK,MLINK
 S NODE=$G(^HLD(779.4,IEN,2,SUBIEN,0))
 S DLINK=$P(NODE,"^",6)
 S MLINK=$P(NODE,"^",2)
 I MLINK,MLINK'=DLINK Q +MLINK
 Q +DLINK
 ;**P146 END CJM
