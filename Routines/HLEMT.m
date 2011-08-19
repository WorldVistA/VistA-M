HLEMT ;ALB/CJM-HL7 - APIs for Monitor Event Types ;02/04/2004
 ;;1.6;HEALTH LEVEL SEVEN;**109**;Oct 13, 1995
 ;
FIND(CODE,PACKAGE) ;
 ;Description: Finds an event type.
 ;Input:
 ;  CODE - the string value of the code
 ;  PACKAGE - the name (.01 field) of a package in the Package file representing the application that dessigned/created the code.
 ;Output:
 ;   Function returns 0 on failue, ien of event type if successful
 ;
 Q:('$L($G(CODE))) 0
 Q:'$L($G(PACKAGE)) 0
 Q $O(^HLEV(776.3,"C",CODE,PACKAGE,0))
 ;
GET(IEN,ETYPE) ;
 ;Description - given the ien, it returns an array containing the event type
 ;Input:
 ;  IEN - ien of event type
 ;  ETYPE - pass by reference, the return array
 ;Output:
 ;  function returns 0 on failure, 1 on success
 ;  ETYPE(
 ;   "ACTION" - <tag>^<routine> - the routine that should be executed when events of this type occur
 ;   "BRIEF" - brief description
 ;   "CODE" - the event type code
 ;   "CATEGORY" - category of event type, set of codes
 ;   "CONGLOMERATE" - 1=events of this type are conglomerated, 0 is no
 ;   "CONGLOMERATE","HOURS" - #of hours to conglomerate
 ;   "DAYS" - # of days to keep events of this type before purge
 ;   "IEN" -the ien
 ;   "PACKAGE" - ien of the package that assigned the code
 ;   "REVIEW" - 0=not required, 1=required, 2=only if action fails
 ;   "SITES",<IEN of DOMAIN>=<screen if defined> - list of domains to send server messages
 ;   "URGENT" - 0=NO,1=YES,2=IF ACTIONFAILS
 ;
 Q:'$G(IEN) 0
 N NODE,I,DOMAIN
 K ETYPE
 S ETYPE("IEN")=IEN
 S NODE=$G(^HLEV(776.3,IEN,0))
 Q:'$L(NODE) 0
 S ETYPE("CODE")=$P(NODE,"^")
 S ETYPE("PACKAGE")=$P(NODE,"^",2)
 S ETYPE("CATEGORY")=$P(NODE,"^",3)
 S ETYPE("URGENT")=$P(NODE,"^",4)
 S ETYPE("CONGLOMERATE")=$P(NODE,"^",5)
 S ETYPE("CONGLOMERATE","HOURS")=$P(NODE,"^",6)
 S ETYPE("REVIEW")=$P(NODE,"^",7)
 S ETYPE("DAYS")=$P(NODE,"^",9)
 S ETYPE("ACTIVE")=$P(NODE,"^",10)
 S ETYPE("ACTION")=$E($G(^HLEV(776.3,IEN,1)),1,20)
 S I=0 F  S I=$O(^HLEV(776.3,IEN,2,I)) Q:'I  S DOMAIN=+$G(^HLEV(776.3,IEN,2,I,0)) S:DOMAIN ETYPE("DOMAIN",DOMAIN)=$G(^HLEV(776.3,IEN,2,I,1))
 S ETYPE("BRIEF")=$P($G(^HLEV(776.3,IEN,4)),"^")
 Q 1
 ;
CODE(EVENT) ;
 ;Given the event type ien, returns the code
 Q:'$G(EVENT) ""
 Q $P($G(^HLEV(776.3,EVENT,0)),"^")
BRIEF(EVENT) ;
 ;Given the event type ien, returns the brief desciption
 Q:'$G(EVENT) ""
 Q $P($G(^HLEV(776.3,EVENT,4)),"^")
 ;
CONG(TYPE) ;
 ;Input:
 ;  TYPE - ien of event type
 ;Output:
 ;  function returns 0 if this is NOT a conglomerated event, 1 if it is
 ;
 Q $P($G(^HLEV(776.3,TYPE,0)),"^",5)
HOURS(TYPE) ;
 ;Description - returns #of hours overwhich to congregate events of this type
 ;Input:
 ;  TYPE - ien of event type
 ;Output:
 ;  function returns # of hours, 0 if not to be conglomerated
 ;
 Q:'$$CONG(TYPE) 0
 Q $P($G(^HLEV(776.3,TYPE,0)),"^",6)
