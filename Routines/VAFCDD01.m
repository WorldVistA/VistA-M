VAFCDD01 ;ALB/JRP,LTL-DATA DICTIONARY UTILITIES ;05-SEP-1996
 ;;5.3;Registration;**91,149**;Jun 06, 1996
AVAFC(DFN) ;AVAFC* cross reference for PATIENT file (#2)
 ;
 ;Input  : IFN - Pointer to entry in PATIENT file (#2)
 ;Output : None
 ;         VAFCFLG will be set to 1 if the cross reference is
 ;         not executed because the change is being made from
 ;         within the Registration process.  This notifies
 ;         Registration that a change was made and that this
 ;         cross reference should be executed if the Registration
 ;         process is aborted.
 ;
 ;Notes  : The AVAFC* cross references are used to remember that
 ;         changes were made to the PATIENT file (#2) outside of
 ;         the Registration process.  Execution of this cross
 ;         reference will create an entry in the ADT/HL7 PIVOT
 ;         file (#391.71) and mark it as requiring transmission
 ;         of an HL7 ADT-A08 message.
 ;
 ;       : Execution of this cross reference can be prevented by
 ;         setting the local variables: VAFCA08 equal to 1
 ;                                      VAFHCA08 equal to 1
 ;
 ;       : If only one of the CA08 variables is set to 1 an entry
 ;         will be made in the pivot file (#391.71) but the
 ;         corresponding transmission flag will not be set.  In this
 ;         case setting VAFCA08=1 will prevent the REQUIRES TRANSMISSION
 ;         flag from being set and setting VAFHCA08=1 will prevent the
 ;         TRANSMITTED-REQUIRES TRANSMISSION flag from being set.
 ;         This allows control for sending HL7 and/or HL7v2.3
 ;
 ;Check input
 I +$G(DFN),$D(^DPT(DFN,0))
 E  Q
 ;quit if re-indexing
 Q:$D(DIU(0))
 ;
 N VARPTR,PIVOTNUM ;Declare variables
 ;
 DO  K VAFCF ; do HL7 V2.3 MESSAGING
 .;CHECK TURNOFF FLAG
 .Q:$D(VAFCA08)
 .;IF SEND HL7 V2.3 MESSAGES IN MAS PARAMETER FILE IS SET
 .;TO SEND/SUSPEND THEN DO IT, ELSE QUIT 
 .I '$P($$SEND^VAFHUTL(),"^",2) Q
 .;IF in Registration option, save fields edited
 .I $$REG() D  Q
 . . Q:$G(VAFCF)=""
 . . S VAFCFLDS(VAFCF)=""
 .;IF NOT IN REGISTRATION DO THIS
 .D PVT4A08(DFN)
 .I PIVOTNUM<0 Q
 .; set need to transmit flag
 .D XMITFLAG(0,PIVOTNUM)
 ;
 DO  ;    do HL7 V2.2 MESSAGING
 .Q:$G(VAFHCA08)
 .Q:$G(VAFCFLG)
 .I $$EN^VAFHREG() S VAFCFLG=1 Q
 .I '$$SEND^VAFHUTL() Q
 .I +$G(PIVOTNUM)<0 Q  ;         its already been called and failed quit
 .I '$G(PIVOTNUM) D PVT4A08(DFN) ;                 set ac xref and pivot
 .I PIVOTNUM<0 Q
 .; set requires transmission-Yes flag
 .D SETTFLAG(0,PIVOTNUM)
 .;done
 QUIT
 ;
PVT4A08(DFN) ;Create entry in ADT/HL7 PIVOT file for an ADT-A08 event
 ; and mark it for transmission
 ;
 ;Input  : IFN - Pointer to entry in PATIENT file (#2)
 ;Output : None
 ;Notes  : There are no checks to determine if the entry should be
 ;         created (other than input of a valid DFN)
 ;
 ;Check input
 I +$G(DFN),$D(^DPT(DFN,0))
 E  QUIT
 ;Declare variables  don't new for call from top
 ;N VARPTR,PIVOTNUM
 ;Set variable pointer used by ADT/HL7 PIVOT file
 S VARPTR=DFN_";DPT("
 ;Create entry
 S PIVOTNUM=+$$PIVNW^VAFHPIVT(DFN,$P(DT,"."),4,VARPTR)
 Q:(PIVOTNUM<0)
 ;Mark entry as requires transmission
 I $P($$SEND^VAFHUTL(),"^",2) D XMITFLAG(0,PIVOTNUM)
 ;Mark entry as transmitted field YES
 I $G(VAFCFLG),$$SEND^VAFHUTL() D SETTFLAG(0,PIVOTNUM)
 ;Done
 Q
 ;
PROCESS() ;
 ;This call simply processes the array elements in the VAFCFLDS
 ;variable into a string
 Q:'$D(VAFCFLDS) -1
 N INDEX,RETURN S INDEX="",RETURN=""
 F  S INDEX=$O(VAFCFLDS(INDEX)) Q:INDEX=""  D
 . S RETURN=RETURN_INDEX
 Q:$G(RETURN)="" -1
 Q RETURN
 ;
REGEDIT(PIVOTNUM,FIELDS) ;
 ;This call is used to generate an HL7 VERSION 2.3 A04 or A08 message
 ;from the pivot file the A04 is generated from DGREG00 when a 
 ;Registration is known to have been completed. The A08 message
 ;is generated from DGREG0 when the Registration option was used
 ;to edit some fields, but the Registration was never completed.
 ;FIELDS variable contains the fields edited during the session.
 S DIE="391.71",DA=PIVOTNUM
 S DR="2.1///^S X=FIELDS"
 D ^DIE
 K DIE,DA,DR
 Q
TRANSMIT(PIVOTNUM) ;
 ;This call is used to simply set the 'Requires Transmission'
 ;flag in the pivot file
 S DIE="391.71",DA=PIVOTNUM
 S DR=".08///^S X=1"
 D ^DIE
 K DIE,DA,DR
 Q
 ;
MESSAGE(PIVOTPTR,NUMBER) ;
 ;This tag stuffs the message id from hl7 into pivot file
 S DIE="391.71",DA=PIVOTPTR
 S DR="1.1///^S X=NUMBER"
 D ^DIE
 K DIE,DA,DR
 Q
 ;
REG() ;
 ;this tag looks at what option the user is in at the time
 ;
 I $P($G(XQY0),"^")="DG REGISTER PATIENT" Q 1
 I $P($G(XQY0),"^")="DGRPT 10-10T REGISTRATION" Q 1
 Q 0
 ;
HL7A08 ;
 I $D(VAFHMRG) D KILL^VAFHUTL2(DFN,VAFHBEF)
 ;Registration process was aborted and changes were made
 ;to key demographic data.  Create an HL7 V2.3 entry in
 ;the ADT/HL PIVOT file so that demographic changes will be 
 ;broadcast. VAFCFLDS is set in routine VAFCDD01. It contains the
 ;fields that were edited.
 I $D(VAFCFLDS) D
 . N PIVOTNUM,IEN,PTR
 . S PTR=DFN_";DPT("
 . S PIVOTNUM=+$$PIVNW^VAFHPIVT(DFN,DT,4,PTR)
 . Q:PIVOTNUM'>0
 . S IEN=$O(^VAT(391.71,"D",PIVOTNUM,""))
 . Q:IEN'>0
 . S VAFCFLDS=$$PROCESS^VAFCDD01()
 . I VAFCFLDS'=-1 D
 . . D REGEDIT^VAFCDD01(IEN,VAFCFLDS)
 . . D TRANSMIT^VAFCDD01(IEN)
 K VAFCFLDS
 Q
 ;
SECA08(DFN) ;PUT ENTRY IN PIVOT FILE WHEN USER FLAGS A PT AS SENSITIVE IN 
 ;FILE 38.1 THIS IS TRIGGERED OUT OF ROUTINE DGSEC1
 N PIVOTNUM,IEN,PTR
 S PTR=DFN_";DPT("
 S PIVOTNUM=+$$PIVNW^VAFHPIVT(DFN,DT,4,PTR)
 Q:PIVOTNUM'>0
 S IEN=$O(^VAT(391.71,"D",PIVOTNUM,""))
 Q:IEN'>0
 ;SET EVENT CODE FIELD TO 97 INDICATING A SENSITIVITY UPDATE
 S DIE="391.71",DA=IEN
 S DR=".1///^S X=97"
 D ^DIE
 K DIE,DA,DR
 D TRANSMIT^VAFCDD01(IEN)
 Q
 ;
XMITFLAG(PIVOTPTR,PIVOTNUM,TURNOFF) ;Turn transmission flag for entry
 ; in ADT/HL7 PIVOT file on/off
 ;
 ;Input  : PIVOTPTR - Pointer to entry in ADT/HL7 PIVOT file (#391.71)
 ;                  - Use this parameter if the entry number is known
 ;                  - Not required if using PIVOTNUM parameter
 ;                  - Use of this parameter takes precedence over use
 ;                    the PIVOTNUM parameter
 ;         PIVOTNUM - PIVOT NUMBER value (field #.02) for entry
 ;                    in ADT/HL7 PIVOT file (#391.71)
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
 N VALUE,NODE,XREFNUM,DA,X
 ;Passed pointer - validate
 I (PIVOTPTR) Q:('$D(^VAT(391.71,PIVOTPTR,0)))
 ;Passed pivot number - convert to pointer
 I ('PIVOTPTR) S PIVOTPTR=+$O(^VAT(391.71,"D",PIVOTNUM,0)) Q:('PIVOTPTR)
 ;Set FileMan variables
 S DA=PIVOTPTR
 S X='TURNOFF
 ;If already transmitted, empty field(s) edited, can't do 8th piece ""
 ;I $G(VAFCF),'$P($G(^VAT(391.71,DA,0)),U,8),$G(^VAT(391.71,DA,2)) S $P(^VAT(391.71,DA,2),U)=""
 ;Hard set field
 S $P(^VAT(391.71,DA,0),"^",8)=X
 ;Hard set fields edited
 S:$G(VAFCF)&($P($G(^VAT(391.71,DA,2)),U)'[$G(VAFCF)) $P(^VAT(391.71,DA,2),U)=$P($G(^VAT(391.71,DA,2)),U)_$G(VAFCF)
 ;Execute cross references
 S XREFNUM=0
 F  S XREFNUM=+$O(^DD(391.71,.08,1,XREFNUM)) Q:('XREFNUM)  D
 .;Execute kill logic
 .S NODE=$G(^DD(391.71,.08,1,XREFNUM,2))
 .I (NODE'="") X NODE
 .;Execute set logic
 .S NODE=$G(^DD(391.71,.08,1,XREFNUM,1))
 .I (NODE'="") X NODE
 Q
 ;
SETTFLAG(PIVOTPTR,PIVOTNUM,TURNOFF) ;Turn transmission flag for entry
 ;                                in ADT/HL7 PIVOT file on/off
 ;
 ;Input  : PIVOTPTR - Pointer to entry in ADT/HL7 PIVOT file (#391.71)
 ;                  - Use this parameter if the entry number is known
 ;                  - Not required if using PIVOTNUM parameter
 ;                  - Use of this parameter takes precedence over use
 ;                    the PIVOTNUM parameter
 ;         PIVOTNUM - PIVOT NUMBER value (field #.02) for entry
 ;                    in ADT/HL7 PIVOT file (#391.71)
 ;                  - Use this parameter if the pivot number is known
 ;                  - Not required if using PIVOTPTR parameter
 ;         TURNOFF - Denotes if TRANSMITTED field (#.06) should
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
 N VALUE,NODE,XREFNUM,DA,X
 ;Passed pointer - validate
 I (PIVOTPTR) Q:('$D(^VAT(391.71,PIVOTPTR,0)))
 ;Passed pivot number - convert to pointer
 I ('PIVOTPTR) S PIVOTPTR=+$O(^VAT(391.71,"D",PIVOTNUM,0)) Q:('PIVOTPTR)
 ;Set FileMan variables
 S DA=PIVOTPTR
 S X='TURNOFF
 ;Hard set field
 S $P(^VAT(391.71,DA,0),"^",6)=X
 ;Execute cross references
 S XREFNUM=0
 F  S XREFNUM=+$O(^DD(391.71,.06,1,XREFNUM)) Q:('XREFNUM)  D
 .;Execute kill logic
 .S NODE=$G(^DD(391.71,.06,1,XREFNUM,2))
 .I (NODE'="") X NODE
 .;Execute set logic
 .S NODE=$G(^DD(391.71,.06,1,XREFNUM,1))
 .I (NODE'="") X NODE
 Q
