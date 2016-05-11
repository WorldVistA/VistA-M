IBCNVPU0 ;ALB/BAA - SSVI PIN/HL7 PIVOT FILE UTILITY FUNCTIONS FOR SSVI ;25-FEB-15
 ;;2.0;INTEGRATED BILLING;**528**;21-MAR-94;Build 163
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
PIVNW(DFN,EVDT,EVTY,PTR) ;
 ;function will return 0 node of pivot file and pivot file entry number
 ;if no entry in pivot file, create one and return #:0 node
 ;
 Q:$G(DFN)=""!($G(EVDT)="")!($G(EVTY)="")!($G(PTR)="") "-1^Error - Missing Parameters for PIVNW function"
 Q:$G(^DPT(DFN,0))']"" "-1^Error - Patient DFN non-existent"
 ; 
 N I,X,DA,DIC,DIE,DR,DINUM,DLAYGO,IBPIVOT,IBPTNM,IENS,IBIEN,IBIENS
 ;
 ; - get next IB PIVOT Number
 S IBPIVOT=$$GETPIV() Q:+IBPIVOT=-1 "-1^Error - Cannot get the next PIVOT Number"
 ;
 ; - lock the PIVOT file for editing
 L +^IBCN(366,0):5 I '$T Q "-1^Error - Unable to lock Pivot file"
 ;
 ; - get the Patient Name
 S IBPTNM=$$GET1^DIQ(2,DFN,.01,"I") I IBPTNM']"" D UNLK Q "-1^Error - Cannot get Patient Name"
 ;
 ; - get next internal entry number of PIVOT file
 ;S IBIEN=$P(^IBCN(366,0),"^",3)+1 I $G(^IBCN(366,IBIEN,0))]"" D UNLK Q "-1^Error - Next IEN value exist already"
 S IBIEN=$$ADD(IBPIVOT),IBIENS=IBIEN_","
 ;
 ; - set up variables to create a new entry into the PIVOT file
 S IBARR(366,IBIENS,.03)=DFN,IBARR(366,IBIENS,.04)=EVTY
 S IBARR(366,IBIENS,.05)=PTR,IBARR(366,IBIENS,.09)=$G(DUZ)
 ;
 D FILE^DIE("I","IBARR")
 ;
 ; - unlock the PIVOT file
 D UNLK
 Q IBPIVOT
 ;
UNLK ; Unlock the PIVOT file
 L -^IBCN(366,0)
 Q
 ;
PIVX(PIVOT,DFN,EVDT) ;
 ;given pivot #, check for existence and compare the data in file to
 ;parameters, return pivot number
 I $G(PIVOT)="" Q "-1^Missing Parameters for PIVX function"
 I '$D(^IBCN(366,"D",PIVOT)) Q "-1^No entry in Pivot file"
 N ENT,ERR S ENT=$O(^IBCN(366,"D",PIVOT,""))
 I ENT="" Q "-1^BAD 'D' CROSS REFERENCE"
 S NODE=$G(^IBCN(366,ENT,0))
 I $D(DFN) I $P(NODE,"^",3)'=DFN S ERR="-1^PATIENTS DON'T MATCH"
 I $D(EVDT) I $P(NODE,"^")'=EVDT S ERR="-1^DATE/TIME DOESN'T MATCH"
 I $P(NODE,"^",7)'="" S ERR="-1^No entry in Pivot file"
 I $D(ERR) Q ERR
 Q PIVOT
 ;
PIVCHK(DFN,EVDT,EVTY,PTR) ;
 ;check for existence of pivot file entry.
 ;If exist, return pivot number:0 node.  If not exist, return 0
 I $G(DFN)=""!($G(EVDT)="")!($G(EVTY)="")!($G(PTR)="") Q "-1^Missing parameter for PIVCHK function"
 I $G(^DPT(DFN,0))="" Q "-1^PATIENT WITH PASSED DFN DOES NOT EXIST"
 ;
 I '$D(^IBCN(366,"E",EVTY,EVDT,PTR)) Q "-1^No Entry in Pivot File"
 I $O(^IBCN(366,"E",EVTY,EVDT,PTR,""))="" Q "-1^Bad E Cross Reference"
 N DA,EVENT,NODE
 S (DA,NODE,EVENT)=0
 F  S DA=$O(^IBCN(366,"E",EVTY,EVDT,PTR,DA)) Q:'DA  DO  Q:EVENT
 . S NODE=$G(^IBCN(366,DA,0))
 . I $P(NODE,"^",7)=1 Q
 . S EVENT=$P(NODE,"^",2)
 ;
 I 'EVENT Q "-1^NO Entry in Pivot File"
 I $P(NODE,"^",3)'=DFN Q "-1^DFN DOES NOT MATCH PIVOT DFN"
 Q EVENT
 ;
SETTRAN(PIVOT) ;
 ;sets TRANSMITTED field in pivot file
 I '$D(PIVOT) Q "-1^Missing Parameter for SETTRAN function"
 N ERR,ENT,DIE,DR,DA,X,Y,CROSS
 S ENT=$O(^IBCN(366,"D",PIVOT,""))
 I +ENT<1 S ERR="-1^NO D CROSS REFERENCE"
 I +ENT>0 D
 .;S $P(^IBCN(366,ENT,0),"^",6)=1,CROSS=0,DA=ENT
 .; - set up variables to stuff data into the new entry in the Inconsistant Data file
 .S DIE="^IBCN(366,",X=ENT,DR=".06///"_1
 .;
 .; - stuff the data into their specific fields
 .D ^DIE
 I $D(ERR) Q ERR
 Q 0
 ;
CLNTRAN(PIVOT) ;
 ;resets TRANSMITTED field in pivot file
 I '$D(PIVOT) Q "-1^Missing Parameter for CLNTRAN function"
 N ERR,ENTRY,DA,CROSS
 S ENTRY=$O(^IBCN(366,"D",PIVOT,"")),DA=ENTRY
 I +ENTRY<0 S ERR="-1^NO D CROSS REFERENCE"
 I +ENTRY>0 D
 .;S $P(^IBCN(366,ENTRY,0),"^",6)=""
 .; - set up variables to stuff data into the new entry in the Inconsistant Data file
 .S DIE="^IBCN(366,",X=ENT,DR=".06///@"
 .;
 .; - stuff the data into their specific fields
 .D ^DIE
 I $D(ERR) Q ERR
 Q 0
 ;
GETPIV() ;
 ;gets next available pivot number.  Get entry from IB SITE PARAMETER file
 ;quit returning new pivot number
 N ERR,VAR1,NEXT,FOUND,%
 S VAR1=$O(^IBE(350.9,0)) I 'VAR1 Q "-1^Unable to Find Parameter One"
 F  Q:$D(FOUND)!($D(ERR))  D
 .L +^IBE(350.9,VAR1,"HL7"):5 I '$T S ERR="-1^Unable to get next pivot number" Q
 .S NEXT=+$G(^IBE(350.9,VAR1,"HL7"))+1
 .I '$D(^IBCN(366,NEXT)) S FOUND=""
 I $D(ERR) Q ERR
 S $P(^IBE(350.9,VAR1,"HL7"),"^")=NEXT
 ;CHECK IF ENTRY WITH REQUESTED EVDT ALREADY EXIST. IF SO GET NEXT TIME
 I $D(^IBCN(366,"E",EVTY,EVDT,PTR)) D
 .H 1 ; GET UNIQUE NEW EVDT
 .D NOW^%DTC S EVDT=%
 L -^IBE(350.9,VAR1,"HL7")
 Q NEXT
 ;
XMITFLAG(PIVOTPTR,PIVOTNUM,TURNOFF) ;Turn transmission flag for entry
 ; in IB SSVI PIN/HL7 PIVOT file on/off
 ;
 ;Input  : PIVOTPTR - Pointer to entry in IB SSVI PIN/HL7 PIVOT file (#366)
 ;                  - Use this parameter if the entry number is known
 ;                  - Not required if using PIVOTNUM parameter
 ;                  - Use of this parameter takes precedence over use
 ;                    the PIVOTNUM parameter
 ;         PIVOTNUM - PIVOT NUMBER value (field #.02) for entry
 ;                    in IB SSVI PIN/HL7 PIVOT file (366)
 ;                  - Use this parameter if the pivot number is known
 ;                  - Not required if using PIVOTPTR parameter
 ;         TURNOFF - Denotes if REQUIRES TRANSMISSION field (#.08) should
 ;                   be turned on (set to 'YES') or off (set to 'NO')
 ;                 1 = Turns transmission off
 ;                 0 = Turns transmission on (default)
 ;Output : None
 ;
 ;Check input
 S PIVOTPTR=+$G(PIVOTPTR)
 S PIVOTNUM=+$G(PIVOTNUM)
 Q:(('PIVOTPTR)&('PIVOTNUM))
 S TURNOFF=+$G(TURNOFF)
 ;Declare variables
 N VALUE,NODE,XREFNUM,DA,STATUS
 ;Passed pointer - validate
 I (PIVOTPTR) Q:('$D(^IBCN(366,PIVOTPTR,0)))
 ;Passed pivot number - convert to pointer
 I ('PIVOTPTR) S PIVOTPTR=+$O(^IBCN(366,"D",PIVOTNUM,0)) Q:('PIVOTPTR)
 ;Set FileMan variables
 S DA=PIVOTPTR
 S STATUS='TURNOFF
 ;S $P(^IBCN(366,DA,0),"^",8)=STATUS
 S DIE="^IBCN(366,",X=DA,DR=".08///"_STATUS D ^DIE K DR,DIE
 Q
 ;
FNDPVT(DFN) ; find a pivot entry for current day and patient.
 N PIVOT,CURDAT,FND,PDAT,SNDFLG
 S FND=0,PIVOT=0
 F  S PIVOT=$O(^IBCN(366,"C",DFN,PIVOT)) Q:PIVOT=""  D  Q:FND
 .S CURDAT=DT
 .F  S CURDAT=$O(^IBCN(366,"B",CURDAT)) Q:CURDAT=""  D  Q:FND
 ..I CURDAT>DT,$D(^IBCN(366,"B",CURDAT,PIVOT)) D
 ...S SNDFLG=$$GET1^DIQ(366,PIVOT,.08,"I") I SNDFLG S FND=PIVOT
 Q FND
 ;
ADD(PIVOT) ; add a new PIVOT file entry (#366), sets only (0) node data
 N IBARR,IBERR,IBIFN,IBX
 Q:PIVOT=""
 ;
 S IBARR(366,"+1,",.01)="NOW",IBARR(366,"+1,",.02)=PIVOT
 D UPDATE^DIE("E","IBARR","IBIFN","IBERR")
 S IBX=+$G(IBIFN(1)) I $D(IBERR) S $P(IBX,U,2)=$G(IBERR("DIERR",1,"TEXT",1))
 Q IBX
