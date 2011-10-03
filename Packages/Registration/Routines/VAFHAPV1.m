VAFHAPV1 ;ALB/RJS - INPATIENT PV1 SEGMENT ; 1/11/10 1:43pm
 ;;5.3;Registration;**91,209,190,298,494,621,823**;Aug 13, 1993;Build 6
 ;
 ;The DGBUILD entry point is call used internally by MAS software
 ;to build a PV1 Segment for deleted Admissions. The DGPMP
 ;variable, available from the DGPM Event Driver at the time of
 ;the deletion, makes it possible to construct a partial PV1 segment
 ;for the deleted record.
 ;
 ;06/29/00 ACS - Added sequence 21 (physical treating specialty - ward
 ;location) and sequence 39 (facility + suffix).
 ;
EN(DFN,VAFHDT,VAFSTR,IEN,ALTVISID,SETID,VAFDIAG) ;
 ;
 ;This Entry Point builds the HL7 PV1 segment for inpatients.
 ;
 ;DFN, VAFHDT, & VAFSTR are the required variables.
 ;
 ;            DFN = IEN of Patient File
 ;         VAFHDT = Date/Time of Patient Movement
 ;         VAFSTR = HL7 Fields Requested e.g. ",3,7,10"
 ;
 ;IEN, ALTVISID, SETID are the optional variables
 ;
 ;The optional variable IEN is used for Discharge movements
 ;because if only Date/Time is passed for a Discharge movement
 ;no useful information is returned by VADPT.
 ;
 ;The optional ALTVISID variable is used to pass in a "Alternate.
 ;Visit ID" this is a unique number that 
 ;identifies this Admission or episode of care
 ;
 ;The optional variable SETID can be used to differentiate 
 ;different sets of data, in messages that may contain multiple
 ;events or messages.
 ;
 ;VAFDIAG, is a passed as a dotted variable. The inpatient diagnosis
 ;is then returned in this variable.
 ;
 N VAFCOMP,RESULT,VAROOT,VA200
 N CURRENT
 ;Make sure the VAFSTR string is correctly formatted (",#,#,...,#,") DG*823
 I $E(VAFSTR,1)'="," S VAFSTR=","_VAFSTR
 I $E(VAFSTR,$L(VAFSTR))'="," S VAFSTR=VAFSTR_","
 ;
 D KVAR^VADPT
 S VAFCOMP=$E(HLECH,1)
 S VAROOT="CURRENT",VAIP("D")=VAFHDT,VA200=1
 I ($G(IEN)'="") S VAIP("E")=IEN
 D IN5^VADPT
 S RESULT=$$BUILD()
 I $G(ALTVISID)'="" S $P(RESULT,HLFS,51)=ALTVISID
 I $G(SETID)'="" S $P(RESULT,HLFS,2)=SETID
 I $G(SETID)="" S $P(RESULT,HLFS,2)=1
 ;
EXIT ;
 Q $G(RESULT)
 ;
BUILD() ;Build the PV1 Segment
 ;
 ;Required Variables: Array "CURRENT" containing the results
 ;                    of a call to VADPT
 ;
 ;This entry point is called to build the HL7 PV1 segment from
 ;data returned by VADPT
 ;
 ;It returns a fully encoded HL7 segment, or a partially encoded HL7 segment containing patient class only
 ;
 N RESULT,SUBS
 S RESULT="PV1"_HLFS_HLFS_"I"
 I $G(CURRENT(1))="" Q RESULT
 I $G(CURRENT(1))'="" D
 . S VAFDIAG=CURRENT(9)
 . ;
 . ;--Ward, Room, Bed
 . ;
 . ;Format all If statements to be the same (I VAFSTR[",#,") DG*823
 . I VAFSTR[",3," D
 . . N WARD,ROOM,BED
 . . S WARD=$$HLQ^VAFHUTL($P(CURRENT(5),"^",2))
 . . S ROOM=$$HLQ^VAFHUTL($P($P(CURRENT(6),"^",2),"-",1))
 . . S BED=$$HLQ^VAFHUTL($P($P(CURRENT(6),"^",2),"-",2))
 . . S $P(RESULT,HLFS,4)=$G(WARD)_VAFCOMP_$G(ROOM)_VAFCOMP_$G(BED)
 . ;
 . ;--Attending Physician
 . ;
 . I VAFSTR[",7," D
 . . N ATTNDPTR,ATTNDING
 . . S ATTNDPTR=$P(CURRENT(18),"^",1)
 . . ;S:ATTNDPTR'="" ATTNDING=$$HLNAME^HLFNC($P(CURRENT(18),"^",2))
 . . I $G(ATTNDPTR)'="" D
 . . . N DGNAME S DGNAME("FILE")=200,DGNAME("IENS")=ATTNDPTR,DGNAME("FIELD")=.01
 . . . S ATTNDING=$$HLNAME^XLFNAME(.DGNAME,"S",$E($G(HLECH)))
 . . S $P(RESULT,HLFS,8)=$$HLQ^VAFHUTL($G(ATTNDPTR))_VAFCOMP_$$HLQ^VAFHUTL($G(ATTNDING))
 . ;
 . ;--Treating Specialty
 . ;
 . I VAFSTR[",10," D
 . . N SPECPTR,SPECALTY
 . . S SPECPTR=$P(CURRENT(8),"^",1)
 . . S:$G(SPECPTR)'="" SPECALTY=$P($G(^DIC(45.7,SPECPTR,0)),"^",2)
 . . S $P(RESULT,HLFS,11)=$$HLQ^VAFHUTL($G(SPECALTY))
 . ;
 . ;--Previous Patient Location
 . I VAFSTR[",6," D
 . . N WARD,ROOM,BED,ROOMPTR,ROOMBED,MOVEMENT
 . . S WARD=$$HLQ^VAFHUTL($P(CURRENT(15,4),"^",2))
 . . S MOVEMENT=$G(CURRENT(15))
 . . I MOVEMENT D
 . . . S ROOMPTR=$P(^DGPM(MOVEMENT,0),"^",7)
 . . . I ROOMPTR D
 . . . . S ROOMBED=$P(^DG(405.4,ROOMPTR,0),"^",1)
 . . . . I (ROOMBED'="") D
 . . . . . S ROOM=$P(ROOMBED,"-",1)
 . . . . . S BED=$P(ROOMBED,"-",2)
 . . S $P(RESULT,HLFS,7)=$$HLQ^VAFHUTL($G(WARD))_VAFCOMP_$$HLQ^VAFHUTL($G(ROOM))_VAFCOMP_$$HLQ^VAFHUTL($G(BED))
 . ;
 . ;-- Patient Type
 . I VAFSTR[",18," D
 . .I +$G(^DPT(DFN,"TYPE")) DO
 . . .S $P(RESULT,HLFS,19)=$P($G(^DG(391,+^("TYPE"),0)),"^",1)
 . .E  S $P(RESULT,HLFS,19)=HLQ
 . ;
 . ;--Physical Treating Specialty - Ward Location
 . ;
 . I VAFSTR[",21," D
 . . N VAWARD,VAPHYTS
 . . ; get ward location pointer
 . . S VAWARD=$P($G(CURRENT(5)),"^",1) Q:VAWARD=""
 . . ; get ward treating specialty pointer
 . . S VAPHYTS=$P($G(^DIC(42,VAWARD,0)),"^",12)
 . . S $P(RESULT,HLFS,22)=$S(VAPHYTS]"":VAPHYTS,1:HLQ)
 . . Q
 . ;
 . ;--Facility and Suffix
 . I VAFSTR[",39," D
 . . N VAFIEN,VAWARD,VAMEDCTR,VAFACSUF
 . . ; get patient movement IEN, ward loc ptr, med center div ptr
 . . S VAFIEN=$G(CURRENT(1))
 . . S VAWARD=$P($G(^DGPM(VAFIEN,0)),"^",6) Q:VAWARD=""
 . . S VAMEDCTR=$P($G(^DIC(42,VAWARD,0)),"^",11) Q:VAMEDCTR=""
 . . ; call below returns: inst pointer^inst name^station number w/suffix
 . . S VAFACSUF=$$SITE^VASITE($G(CURRENT(3)),VAMEDCTR)
 . . S VAFACSUF=$P(VAFACSUF,"^",3)
 . . ; move data into the PV1 segment
 . . S $P(RESULT,HLFS,40)=$S(VAFACSUF]"":VAFACSUF,1:HLQ)
 . ;
 . ;Discharge Disposition
 . I VAFSTR[",36," D  ;If Discharge Disposition requested
 . .N DGDTYP
 . .S DGDTYP=$P(CURRENT(17,3),"^") S $P(RESULT,HLFS,37)=DGDTYP
 . ;
 . ;--Admission Date
 . ;
 . I (VAFSTR[",44,") D
 . . I ($P(CURRENT(13,1),"^",1)'="") S $P(RESULT,HLFS,45)=$$HLDATE^HLFNC($P(CURRENT(13,1),"^",1),"TS")
 . . E  S $P(RESULT,HLFS,45)=HLQ
 . ;
 . ;
 . ;--Discharge Date
 . ;
 . I (VAFSTR[",45,") D
 . . I ($P(CURRENT(17,1),"^",1)'="") S $P(RESULT,HLFS,46)=$$HLDATE^HLFNC($P(CURRENT(17,1),"^",1),"TS")
 . . E  S $P(RESULT,HLFS,46)=HLQ
 ;
 Q:$$TEST(7,RESULT,HLFS,VAFCOMP) RESULT
 Q RESULT
DGBUILD(DGPMP,VAFSTR) ;
 ;
 ;Required Variables:    DGPMP = 0 node of patient movement
 ;                      VAFSTR = HL7 fields requested e.g.
 ;                               ",3,7,10"
 ;
 ;This entry point builds an HL7 segment from data supplied
 ;from the 0 node of the Patient movement file in the required
 ;variable DGPMP. It is an internal PIMS call used to build
 ;a PV1 segment when the record has already been deleted.
 ;
 ;The call returns a fully encoded PV1 segment or a partially encoded
 ;PV1 segment containing only set id and patient class
 ;
 N WARD,BED,ROOM,ATTNDPTR,ATTNDING,SPECPTR,SPECALTY,TRANSACT
 N ADMPTR,ADMSSN,VAFCOMP,RESULT
 ;Check to have string follow correct format (",#,#,...,#,") DG*823
 I $E(VAFSTR,1)'="," S VAFSTR=","_VAFSTR
 I $E(VAFSTR,$L(VAFSTR))'="," S VAFSTR=VAFSTR_","
 S RESULT="PV1"_HLFS_1_HLFS_"I" ;Inpatient
 I $G(DGPMP)="" Q RESULT
 S TRANSACT=$P(DGPMP,"^",2),VAFCOMP=$E(HLECH,1)
 I TRANSACT=1 S VAFDIAG=$P(DGPMP,"^",10)
 E  S ADMPTR=$P(DGPMP,"^",14),ADMSSN=$G(^DGPM(ADMPTR,0)),VAFDIAG=$P(ADMSSN,"^",10)
 ;
 ;--Ward, Room, Bed
 ;
 ;Make sure all IF statements carry same logic (I VAFSTR[",#,") DG*823
 I VAFSTR[",3," D
 . N WARD,ROOM,BED
 . ;
 . ;--Check node 2 to see if it's a discharge movement
 . ;
 . ;
 . I TRANSACT=3 D
 . . S $P(RESULT,HLFS,4)=HLQ_VAFCOMP_HLQ_VAFCOMP_HLQ
 . . ;
 . . ;--All non discharge events are handled the same
 . . ;
 . I TRANSACT'=3 D
 . . N WARDPTR,ROOMPTR,ROOM,WARD,BED
 . . S WARDPTR=$P(DGPMP,"^",6)
 . . S ROOMPTR=$P(DGPMP,"^",7)
 . . I $G(WARDPTR)'="" S WARD=$P(^DIC(42,WARDPTR,0),"^",1)
 . . I $G(ROOMPTR)'="" D
 . . . S ROOM=$P(^DG(405.4,ROOMPTR,0),"^",1)
 . . . S BED=$P(ROOM,"-",2)
 . . . S ROOM=$P(ROOM,"-",1)
 . . S $P(RESULT,HLFS,4)=$$HLQ^VAFHUTL($G(WARD))_VAFCOMP_$$HLQ^VAFHUTL($G(ROOM))_VAFCOMP_$$HLQ^VAFHUTL($G(BED))
 . ;
 . ;--Attending Physician
 . ;
 I VAFSTR[",7," D
 . N ATTNDPTR,ATTNDING
 . S ATTNDPTR=$P(DGPMP,"^",19)
 . I $G(ATTNDPTR)'="" D
 . . N DGNAME S DGNAME("FILE")=200,DGNAME("IENS")=ATTNDPTR,DGNAME("FIELD")=.01
 . . S ATTNDING=$$HLNAME^XLFNAME(.DGNAME,"S",$E($G(HLECH)))
 . S $P(RESULT,HLFS,8)=$$HLQ^VAFHUTL($G(ATTNDPTR))_VAFCOMP_$$HLQ^VAFHUTL($G(ATTNDING))
 . ;
 . ;--Treating Specialty
 . ;
 I VAFSTR[",10," D
 . N SPECPTR,SPECALTY
 . S SPECPTR=$P(DGPMP,"^",9)
 . I $G(SPECPTR)'="" S SPECALTY=$P($G(^DIC(45.7,SPECPTR,0)),"^",2)
 . S $P(RESULT,HLFS,11)=$$HLQ^VAFHUTL($G(SPECALTY))
 ;
 ;-- Patient Type
 I VAFSTR[",18," D
 . I +$G(^DPT(DFN,"TYPE")) DO
 . .  S $P(RESULT,HLFS,19)=$P($G(^DG(391,+^("TYPE"),0)),"^",1)
 . E  S $P(RESULT,HLFS,19)=HLQ
 ;
 ;--Physical Treating Specialty - Ward Location
 ;
 I VAFSTR[",21," D
 . N VAWARD,VAPHYTS
 . ; get ward location pointer
 . S VAWARD=$P($G(DGPMP),"^",6) Q:VAWARD=""
 . ; get ward treating specialty
 . S VAPHYTS=$P($G(^DIC(42,VAWARD,0)),"^",12)
 . S $P(RESULT,HLFS,22)=$S(VAPHYTS]"":VAPHYTS,1:HLQ)
 . Q
 ;
 ;--Facility and Suffix
 ;
 N VAWARD,VAMEDCTR,VAFACSUF
 I VAFSTR[",39," D
 . ; get ward location pointer, med center div pointer
 . S $P(RESULT,HLFS,40)=HLQ
 . S VAWARD=$P($G(DGPMP),"^",6) Q:VAWARD=""
 . S VAMEDCTR=$P($G(^DIC(42,VAWARD,0)),"^",11) Q:VAMEDCTR=""
 . ; call below returns: inst pointer^inst name^station number w/suffix
 . S VAFACSUF=$$SITE^VASITE($P(DGPMP,"^",1),VAMEDCTR)
 . S VAFACSUF=$P(VAFACSUF,"^",3)
 . ; move data into the PV1 segment
 . S $P(RESULT,HLFS,40)=$S(VAFACSUF]"":VAFACSUF,1:HLQ)
 ;
 ;Discharge Disposition
 ;
 I VAFSTR[",36," D  ;If Discharge Disposition requested
 . N DGDTYP
 . S DGDTYP=$P($G(DGPMP),"^",18) ;Discharge type pointer in movement file
 . S $P(RESULT,HLFS,37)=DGDTYP ;store in variable
 ;
 ;--Admission Date
 ;
 I (VAFSTR[",44,") D
 . I $P(DGPMP,"^",1)="" S $P(RESULT,HLFS,45)=HLQ
 . E  S $P(RESULT,HLFS,45)=$$HLDATE^HLFNC($P(DGPMP,"^",1),"TS")
 ;
 Q:$$TEST(8,RESULT,HLFS,VAFCOMP) RESULT
 Q RESULT
TEST(COUNTER,STRING,FIELDSEP,COMPNENT) ;
 N CHAR,LENGTH
 S LENGTH=$L(STRING)
NEXT ;
 I COUNTER>LENGTH Q 0
 S CHAR=$E(STRING,COUNTER,COUNTER)
 I $G(CHAR)=FIELDSEP!($G(CHAR)=COMPNENT) S COUNTER=COUNTER+1 G NEXT
 Q 1
