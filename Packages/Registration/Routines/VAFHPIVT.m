VAFHPIVT ;ALB/CM PIVOT FILE UTILITY FUNCTIONS ;5/5/95
 ;;5.3;Registration;**91,179,575**;Jun 06, 1996
 ;
PIVNW(DFN,EVDT,EVTY,PTR) ;
 ;function will return 0 node of pivot file and pivot file entry number
 ;if no entry in pivot file, create one and return #:0 node
 ;
 Q:$G(DFN)=""!($G(EVDT)="")!($G(EVTY)="")!($G(PTR)="") "-1^Missing Parameters for PIVNW function"
 I $G(^DPT(DFN,0))="" Q "-1^PATIENT WITH PASSED DFN DOES NOT EXIST"
 N CROSS,DA,NODE,NEW,PIVOT,ERR,TNODE,NNODE,FCNT,FIELDS,FLD,X,STOP
 I '$D(^VAT(391.71,"AKY",EVTY,EVDT,PTR)) D
 .;not in pivot file
 .S PIVOT=$$GETPIV^VAFHPIV2() ;get next pivot file number
 .I +PIVOT=-1 S ERR="Y"
 .I '$D(ERR) S NEW="Y"
 ;
 I $D(^VAT(391.71,"AKY",EVTY,EVDT,PTR)) D
 .;check if it's been marked as deleted
 .S DA=$O(^VAT(391.71,"AKY",EVTY,EVDT,PTR,""))
 .I $P(^VAT(391.71,DA,0),"^",7)'="" D
 ..S STOP="N"
 ..F  S DA=$O(^VAT(391.71,"AKY",EVTY,EVDT,PTR,DA)) Q:DA=""  I $D(^VAT(391.71,DA)) S:$P(^VAT(391.71,DA,0),"^",7)="" STOP="Y" Q:STOP="Y"
 ..I DA="" S PIVOT=$$GETPIV^VAFHPIV2() I +PIVOT>0 S NEW="Y"
 .I '$D(PIVOT) S PIVOT=$P(^VAT(391.71,DA,0),"^",2)
 .I $D(PIVOT) S:+PIVOT=-1 ERR="Y"
 I $D(ERR) Q "-1^Can't get new pivot number"
 I $D(NEW) D
 .;Set up initial entry, get next internal entry number
 .L +^VAT(391.71,0):5 I '$T S ERR="-1^Unable to lock Pivot file" Q
 .S DA=$P(^VAT(391.71,0),"^",3)
 .F  S DA=DA+1 Q:'$D(^VAT(391.71,DA))
 .S ^VAT(391.71,DA,0)="" L +^VAT(391.71,DA,0):5 I '$T S ERR="-1^Unable to lock Pivot file entry" L -^VAT(391.71,0) Q
 .S $P(^VAT(391.71,0),"^",3)=DA,$P(^VAT(391.71,0),"^",4)=$P(^VAT(391.71,0),"^",4)+1 L -^VAT(391.71,0)
 .S ^VAT(391.71,DA,0)=EVDT,CROSS=0
 .;Set cross references for .01
 .F  S CROSS=$O(^DD(391.71,.01,1,CROSS)) Q:'CROSS  I $G(^(CROSS,0))'["TRIGGER"  D
 ..S X=EVDT X ^DD(391.71,.01,1,CROSS,2) ;kill cross reference
 ..S X=EVDT X ^DD(391.71,.01,1,CROSS,1) ;set cross reference
 .L -^VAT(391.71,DA,0)
 ;
 I '$D(ERR) D
 .L +^VAT(391.71,DA,0):5 I '$T S ERR="-1^Unable to lock Pivot file entry" Q
 .S TNODE=$G(^VAT(391.71,DA,0))
 .I '$D(DGUSER) S DGUSER=DUZ
 .S ^VAT(391.71,DA,0)=EVDT_"^"_PIVOT_"^"_DFN_"^"_EVTY_"^"_PTR_"^^^^"_$G(DGUSER)
 .S NNODE=$G(^VAT(391.71,DA,0))
 .;set cross references for all fields .01,.02,.03,.04,.05
 .S FIELDS=".01,.02,.03,.04,.05",FCNT=0
 .F  S FCNT=FCNT+1,FLD=$P(FIELDS,",",FCNT) Q:FLD=""  D
 ..S CROSS=0
 ..F  S CROSS=$O(^DD(391.71,FLD,1,CROSS)) Q:'CROSS  I $G(^(CROSS,0))'["TRIGGER" D
 ...I TNODE'="" S X=$P(TNODE,"^",FCNT) I X'="" X ^DD(391.71,FLD,1,CROSS,2) ;kill cross reference
 ...S X=$P(NNODE,"^",FCNT) X ^DD(391.71,FLD,1,CROSS,1) ;set cross reference
 .L -^VAT(391.71,DA,0)
 I $D(ERR) Q ERR
 I $D(^VAT(391.71,"AKY",EVTY,EVDT,PTR)) D
 .;have entry in pivot file
 .S DA=$O(^VAT(391.71,"AKY",EVTY,EVDT,PTR,"")) I DA="" S ERR="-1^Bad AKY Cross Reference"
 .I '$D(ERR) S STOP="N" F  Q:DA=""!(STOP="Y")  D
 ..I $D(^VAT(391.71,DA,0)) D
 ...I $P(^VAT(391.71,DA,0),"^",7)'=1 S NODE=$G(^VAT(391.71,DA,0)),PIVOT=$P(NODE,"^",2),STOP="Y"
 ...I $P(^VAT(391.71,DA,0),"^",7)=1 S DA=$O(^VAT(391.71,"AKY",EVTY,EVDT,PTR,DA))
 I '$D(^VAT(391.71,"AKY",EVTY,EVDT,PTR)) S ERR="-1^ERROR NO AKY CROSS REFERENCE"
 I $D(ERR) Q ERR
 Q PIVOT_":"_NODE
 ;
PIVX(PIVOT,DFN,EVDT) ;
 ;given pivot #, check for existence and compare the data in file to
 ;parameters, return pivot number:0 node
 I $G(PIVOT)="" Q "-1^Missing Parameters for PIVX function"
 I '$D(^VAT(391.71,"D",PIVOT)) Q "-1^No entry in Pivot file"
 N ENT,ERR S ENT=$O(^VAT(391.71,"D",PIVOT,""))
 I ENT="" Q "-1^BAD 'D' CROSS REFERENCE"
 S NODE=$G(^VAT(391.71,ENT,0))
 I $D(DFN) I $P(NODE,"^",3)'=DFN S ERR="-1^PATIENTS DON'T MATCH"
 I $D(EVDT) I $P(NODE,"^")'=EVDT S ERR="-1^DATE/TIME DOESN'T MATCH"
 I $P(NODE,"^",7)'="" S ERR="-1^No entry in Pivot file"
 I $D(ERR) Q ERR
 Q PIVOT_":"_NODE
 ;
PIVCHK(DFN,EVDT,EVTY,PTR) ;
 ;check for existence of pivot file entry.
 ;If exist, return pivot number:0 node.  If not exist, return 0
 I $G(DFN)=""!($G(EVDT)="")!($G(EVTY)="")!($G(PTR)="") Q "-1^Missing parameter for PIVCHK function"
 I $G(^DPT(DFN,0))="" Q "-1^PATIENT WITH PASSED DFN DOES NOT EXIST"
 ;
 I '$D(^VAT(391.71,"AKY",EVTY,EVDT,PTR)) Q "-1^No Entry in Pivot File"
 I $O(^VAT(391.71,"AKY",EVTY,EVDT,PTR,""))="" Q "-1^Bad AKY Cross Reference"
 N DA,EVENT,NODE
 S (DA,NODE,EVENT)=0
 F  S DA=$O(^VAT(391.71,"AKY",EVTY,EVDT,PTR,DA)) Q:'DA  DO  Q:EVENT
 . S NODE=$G(^VAT(391.71,DA,0))
 . I $P(NODE,"^",7)=1 Q
 . S EVENT=$P(NODE,"^",2)
 ;
 I 'EVENT Q "-1^NO Entry in Pivot File"
 I $P(NODE,"^",3)'=DFN Q "-1^DFN DOES NOT MATCH PIVOT DFN"
 Q EVENT_":"_NODE
 ;
 Q
