HLEMDD ;ALB/CJM-HL7 - M CODE FOUND IN THE DD'S ;02/04/2004
 ;;1.6;HEALTH LEVEL SEVEN;**109**;Oct 13, 1995
 ;
 ;
KILLAH(IEN) ;kills the AH x~ref on file 776.4 or a particular event=ien
 Q:'$G(IEN)
 N NEXT,LOCATION
 S NEXT=""
 F  S NEXT=$O(^HLEV(776.4,"AH KILL",IEN,NEXT)) Q:'$L(NEXT)  D
 .S LOCATION="^HLEV(776.4,""AH"","_NEXT
 .K @LOCATION
 K ^HLEV(776.4,"AH KILL",IEN)
 Q
 ;
SETID(IEN) ;sets the value of the ID field in the EVENT
 ;Input:  IEN is the ien of the Monitor Event
 ;Output: none
 ;
 Q:'$G(IEN)
 Q:'$D(^HLEV(776.4,IEN,0))
 S $P(^HLEV(776.4,IEN,0),"^",4)=$$STATNUM^HLEMU_"-"_IEN
 Q
 ;
STATUS(IEN,STATUS) ;
 ;if the REVIEW STATUS is REQUIRED ONLY IF ACTION FAILS then  when the ACTION STATUS field changes the REVIEW STATUS is updated appropriately
 ;
 ;
 Q:'$G(IEN)
 Q:($G(STATUS)<3)
 N NODE,REVIEW
 S NODE=$G(^HLEV(776.4,IEN,0))
 S REVIEW=$P(NODE,"^",6)
 I REVIEW=2 D
 .I STATUS=3 S $P(^HLEV(776.4,IEN,0),"^",6)=0
 .I STATUS=4 S $P(^HLEV(776.4,IEN,0),"^",6)=1
 Q
 ;
ADDSTAT(NEWTIME,OLDSITE,SITE,TYPE,STATUS,COUNT) ;
 ;Description - add logic for the AF x~ref on the Monitor Event file.
 ;Maintains statistics for events.
 ;Input:
 ;  NEWTIME - new value of the .01 field (DT/TM)
 ;  OLDSITE - old value of the SITE field
 ;  SITE - new value of the SITE field
 ;  TYPE - new value of the TYPE field
 ;  STATUS - new value of the REVIEW STATUS field
 ;  COUNT - the new value of the COUNT field
 ;Output:  see DD for description of the AF x~ref
 ;
 Q:'($G(NEWTIME)&$G(SITE)&$G(TYPE)&$L($G(STATUS)))
 ;
 N INDEX
 S INDEX="^HLEV(776.4,""AF"",SITE,TYPE)"
 ;
 ;COUNT must be ast least 1
 S COUNT=$G(COUNT,1)
 ;
 I '$G(OLDSITE) D
 .N YEAR,MONTH,DAY,HOUR
 .S YEAR=$$YEAR(NEWTIME),MONTH=$$MONTH(NEWTIME),DAY=$$DAY(NEWTIME),HOUR=$$HOUR(NEWTIME)
 .I YEAR,$$I^HLEMU($NA(@INDEX@("RECEIVED","YEAR",YEAR)),COUNT) D
 ..I MONTH,$$I^HLEMU($NA(@INDEX@("RECEIVED","YEAR",YEAR,"MONTH",MONTH)),COUNT) D
 ...I DAY,$$I^HLEMU($NA(@INDEX@("RECEIVED","YEAR",YEAR,"MONTH",MONTH,"DAY",DAY)),COUNT) D
 ....I HOUR,$$I^HLEMU($NA(@INDEX@("RECEIVED","YEAR",YEAR,"MONTH",MONTH,"DAY",DAY,"HOUR",HOUR)),COUNT)
 I $$I^HLEMU($NA(@INDEX@(STATUS)),COUNT)
 Q
 ;
DELSTAT(SITE,TYPE,STATUS,COUNT) ;
 ;Description - delete logic for the AF x~ref on the Monitor Event file.
 ;Maintains statistics for events.
 ;Input:
 ;  SITE - old value of the SITE field
 ;  TYPE - old value of the TYPE field
 ;  STATUS - old value of the REVIEW STATUS field
 ;  COUNT - old value fo the COUNT field
 ;Output:  see DD for description of the AF x~ref
 ;
 Q:'($G(SITE)&$G(TYPE)&$L($G(STATUS)))
 ;
 ;COUNT must be at least 1
 S COUNT=$G(COUNT,1)
 ;
 N INDEX
 S INDEX="^HLEV(776.4,""AF"",SITE,TYPE,STATUS)"
 I $$I^HLEMU($NA(@INDEX),-COUNT)
 Q
 ;
YEAR(FMDATE) ;returns the year (i.e., "2003", not in FM format)
 Q $S($G(FMDATE):1700+$E(FMDATE,1,3),1:"")
MONTH(FMDATE) ;returns the month (1-12)
 Q $S($G(FMDATE):+$E(FMDATE,4,5),1:"")
DAY(FMDATE) ;returns the day (1 - 31)
 Q $S($G(FMDATE):+$E(FMDATE,6,7),1:"")
HOUR(FMDATE) ;returns the hour (1-24
 Q $S($G(FMDATE):+$E($P(FMDATE,".",2),1,2),1:"")
 ;
URGENCY(EVENT,URGENT,ACTION,REVIEW) ;
 ;Description- changes the urgency as the action status and review status change.
 ;
 Q:'$G(EVENT)
 I $G(URGENT)=2,$G(ACTION)=4 S $P(^HLEV(776.4,EVENT,0),"^",12)=1
 I $G(URGENT)=2,$G(ACTION)=3 S $P(^HLEV(776.4,EVENT,0),"^",12)=0
 I $G(REVIEW)=4 S $P(^HLEV(776.4,EVENT,0),"^",12)=0
 Q
 ;
DEFAULT(PROFILE,DUZ,DEFAULT) ;
 ;Description - maintains the "AC" x~ref on file 776.5, Event Log Prfofiles, insuring that each use has only one profile marked his default
 ;
 Q:'$G(PROFILE)
 Q:'$G(DUZ)
 Q:'$D(DEFAULT)
 I $G(DEFAULT) D
 .N PROF
 .S PROF=""
 .F  S PROF=$O(^HLEV(776.5,"AC",DUZ,PROF)) Q:'PROF  D
 ..S $P(^HLEV(776.5,PROF,0),"^",3)=0
 ..K ^HLEV(776.5,"AC",DUZ,PROF)
 .S ^HLEV(776.5,"AC",DUZ,PROFILE)=""
 E  D
 .K ^HLEV(776.5,"AC",DUZ,PROFILE)
 Q
 ;
CSTATUS(EVENT,STATUS) ;
 ;This is the trigger logic of the AI index for file 776.4. If the event
 ;status changes to COMPLETED, the DT/TM REVIEWED field is set to NOW
 ;and the REVIEWER field is set to DUZ, if defined.
 ;
 Q:'$G(EVENT)
 Q:$G(STATUS)'=4
 S $P(^HLEV(776.4,EVENT,0),"^",7)=$$NOW^XLFDT
 S $P(^HLEV(776.4,EVENT,0),"^",8)=$G(DUZ)
 Q 
 ;
SETPURGE(EVENT,WHEN,TYPE) ;
 ;Sets the earliest purge date into the AJ index on file 776.4
 ;Input:
 ;  EVENT - IEN of the event
 ;  WHEN - .01 FIELD (DT/TM)
 ;  TYPE - .02 field - event type
 ;
 Q:'$G(EVENT)
 Q:'$G(WHEN)
 Q:'$G(TYPE)
 ;
 N WAIT,PWHEN
 S WAIT=$P($G(^HLEV(776.3,TYPE,0)),"^",9)
 Q:'WAIT
 S PDATE=$$FMADD^XLFDT(WHEN,WAIT\1)
 S ^HLEV(776.4,"AJ",PDATE,EVENT)=""
 Q
 ;
DELPURGE(EVENT,WHEN,TYPE) ;
 ;kill logic fo the AJ index of file 776.4
 ;Input:
 ;  EVENT - IEN of the event
 ;  WHEN - .01 FIELD (DT/TM)
 ;  TYPE - .02 field - event type
 ;
 Q:'$G(EVENT)
 Q:'$G(WHEN)
 Q:'$G(TYPE)
 ;
 N WAIT,PWHEN
 S WAIT=$P($G(^HLEV(776.3,TYPE,0)),"^",9)
 Q:'WAIT
 S PDATE=$$FMADD^XLFDT(WHEN,WAIT\1)
 K ^HLEV(776.4,"AJ",PDATE,EVENT)
 Q
 ;
SETPKG(ETYPE,PACKAGE,OLDNAME) ;
 ;Given a ptr to the event type and package, it sets the PACKAGE NAME
 ;field to the name of the package.  Also maintains the index that 
 ;PACKAGE NAME is part of
 ;
 Q:'$G(ETYPE)
 Q:'$G(PACKAGE)
 N NAME,NODE
 S NAME=$P($G(^DIC(9.4,PACKAGE,0)),"^")
 S $P(^HLEV(776.3,ETYPE,0),"^",8)=NAME
 S NODE=$G(^HLEV(776.3,ETYPE,0))
 I $L($G(OLDNAME)),$L($P(NODE,"^")) K ^HLEV("AC",$P(NODE,"^"),OLDNAME)
 I $L(NAME),$L($P(NODE,"^")) S ^HLEV("AC",$P(NODE,"^"),NAME)=ETYPE
 Q
