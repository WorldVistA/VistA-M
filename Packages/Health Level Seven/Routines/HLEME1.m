HLEME1 ;ALB/CJM-HL7 - APIs for Monitor Events (continued) ;02/04/2004
 ;;1.6;HEALTH LEVEL SEVEN;**109**;Oct 13, 1995
 ;
NEWINDEX(EVENT,APPNAME,PARMARY) ;
 ;Description: This allows an application to build is own private index on its own events, which it can use to determine whether or not the event has been logged.
 ;
 ;Input:
 ;  EVENT - ien of an event
 ;  APPNAME - application name, including namespace. This is used as part of the lookup index.  The application is responsible for insuring there will be no coflict with other applications logging its own events.
 ;  PARMARY - **pass by reference** an array of parameters with which to build the index.  The format is: PARMARY(1)=<first parameter>, PARMARY(2)=<second parameter>  If PARRMARY(i)=null, the parameter will be translated to a single space.
 ;Output:
 ;  function returns 1 on success, 0 otherwise
 ;
 Q:'$G(EVENT) 0
 Q:'$D(^HLEV(776.4,EVENT,0)) 0
 Q:'$D(PARMARY) 0
 Q:'$L($G(APPNAME)) 0
 N INDEX,I
 S INDEX="^HLEV(776.4,""AH"",APPNAME,"
 S I=0
 F  S I=$O(PARMARY(I)) Q:'I  S INDEX=INDEX_""""_$S($L(PARMARY(I)):PARMARY(I),1:" ")_""","
 S INDEX=$E(INDEX,1,$L(INDEX)-1)_")"
 S @INDEX=EVENT
 S ^HLEV(776.4,"AH KILL",EVENT,""""_APPNAME_""","_$P(INDEX,"^HLEV(776.4,""AH"",APPNAME,",2))=""
 Q 1
 ;
LOGGED(APPNAME,PARMARY) ;
 ;Description: This allows an application to determine whether or not an
 ;event has already been logged, based on a private index the application
 ;built by calling $$NEWINDEX^HLEME1()
 ;
 ;Input:
 ;  APPNAME - application name, including namespace. This is used as part of the lookup index.  The application is responsible for insuring there will be no coflict with other applications logging its own events.
 ;  PARMARY  **pass by reference** an array of parameters with which the index was built.  The format is: PARMARY(1)=<first parameter>, PARMARY(2)=<second parameter>  If PARRMARY(i)=null, the parameter will be translated to a single space.
 ;Output:
 ;  function returns TWO values in the format <value 1>^<value 2>
 ;     <value 1> is 1 one if that subscript in the AH index exists, 0 otherwise
 ;     <value 2> is the event ien if found - which should be the case if all the subscripts are supplied that were passed to $$NEWINDEX
 ;
 Q:'$D(PARMARY) "0^"
 Q:'$L($G(APPNAME)) "0^"
 N INDEX,I,EVENT,VALUE1,VALUE2
 S VALUE1=0,VALUE2=""
 S INDEX="^HLEV(776.4,""AH"",APPNAME,"
 S I=0
 F  S I=$O(PARMARY(I)) Q:'I  S INDEX=INDEX_""""_$S($L(PARMARY(I)):PARMARY(I),1:" ")_""","
 S INDEX=$E(INDEX,1,$L(INDEX)-1)_")"
 S VALUE1=$S($D(@INDEX):1,1:0)
 S VALUE2=$G(@INDEX)
 Q VALUE1_"^"_VALUE2
 ;
 ;
ADD(SITE,TYPE,TIME) ;
 ;Description - Checks for an existing event and determines if it can be added to, based on whether or not its period is expired.  If it can be added, its count is incremented and its ien returned as the function value, otherwise, 0 is returned
 ;
 Q:'$G(SITE) 0
 Q:'$G(TYPE) 0
 Q:'$G(TIME) 0
 N EVENT,LAST,COUNT,HOURS
 S EVENT=0
 ;
 S HOURS=$$HOURS^HLEMT(TYPE)
 Q:'HOURS 0
 S LAST=$O(^HLEV(776.4,"AE",SITE,TYPE,TIME+.00000001),-1)
 I LAST,TIME<$$FMADD^XLFDT(LAST,,HOURS) D
 .S EVENT=$O(^HLEV(776.4,"AE",SITE,TYPE,LAST,0))
 .I EVENT,$$INC^HLEME(EVENT,1)
 Q EVENT
 ;
STORE(EVENT,ERROR) ;
 ;Desc: stores the event.Creates a new record if EVENT("IEN") isn't valued, otherwise overlays the existing record.
 ;Input:
 ;  EVENT - an array containing the EVENT **pass by reference**
 ;Output:
 ;  function value - 0 on failure, event ien on success
 ;  EVENT() - if successful, the EVENT array is refreshed
 ;  ERROR() - an array of error messages **pass by reference,optional**
 ; 
 Q:'$D(EVENT) 0
 ;
 N DATA,I,SUB,SUCCESS,NODE
 K ERROR
 S I=0
 F SUB="DT/TM","TYPE","SITE","ID","ACTION STATUS","REVIEW STATUS","DT/TM REVIEWED","REVIEWER","DT/TM ACTION","MSG ID","COUNT","URGENT","MSG TYPE","MSG EVENT","MSG LINK","APPLICATION","DT/TM CREATED" D
 .S I=I+.01 S:$D(EVENT(SUB)) DATA(I)=$G(EVENT(SUB))
 I $G(EVENT("IEN")) D
 .;record already exists, overlay it
 .S SUCCESS=$S($$UPD^HLEMU(776.4,EVENT("IEN"),.DATA,.ERROR):EVENT("IEN"),1:0)
 .D:SUCCESS
 ..;Kill the multiples to insure full overlay (re-write later)
 ..K ^HLEV(776.4,EVENT("IEN"),3)
 ..K ^HLEV(776.4,EVENT("IEN"),1)
 E  D
 .;record needs to be created
 .S SUCCESS=$$ADD^HLEMU(776.4,,.DATA,.ERROR)
 .S:SUCCESS EVENT("IEN")=SUCCESS
 Q:'SUCCESS 0
 ;
 ;store the list of mail messages
 K DATA,DA
 S DA(1)=EVENT("IEN")
 S I=0 F  S I=$O(EVENT("MAIL",I)) Q:'I  S DATA(.01)=I I '$$ADD^HLEMU(776.4,.DA,.DATA,.ERROR) Q
 I SUCCESS,$$GET^HLEME(SUCCESS,.EVENT)
 Q SUCCESS
 ;
LOCK(EVENT) ;
 ;Locks the event record (EVENT=Event ien), returns 1 on success, 0 on
 ;failure
 Q:'$G(EVENT) 0
 L +^HLEM(776.4,EVENT):3
 Q $T
 ;
UNLOCK(EVENT) ;
 ;Unlocks the event record (EVENT=Event ien)
 Q:'$G(EVENT)
 L -^HLEM(776.4,EVENT)
 Q
