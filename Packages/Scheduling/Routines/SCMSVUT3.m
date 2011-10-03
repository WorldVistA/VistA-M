SCMSVUT3   ;BP/JRP - HL7 segment & field validation utilities ;8/11/99 9:54am
 ;;5.3;Scheduling;**142,180,208,239,395,441,543**;AUG 13, 1993;Build 1
 ;
 ;Standard input parameters
 ;   DATA  - Value to validate
 ;   DFN   - Point to PATIENT file (#2)
 ;   ENCDT - Date/time of encounter (FileMan format)
 ;   HLFS  - HL7 field seperator
 ;   HLECH - HL7 encoding characters
 ;   HLQ   - HL7 null designation
 ;
 ;Standard output
 ;   1 - Valid
 ;   0 - Invalid
 ;
 ;
POWLOC(DATA,DFN) ;Prisoner of war location
 ;Note: Use of DFN is optional.  Use of the DFN will validate the POW
 ;      location and also verify that it is consistant with patient's
 ;      POW status (i.e. must also have been a POW).  Non-use of DFN
 ;      will only validate the POW location.
 ;
 Q:('$D(DATA)) 0
 N POW,NODE
 S DFN=+$G(DFN)
 ;Patient a POW ?
 S POW=1
 I (DFN) D
 .S NODE=$G(^DPT(DFN,.52))
 .S POW=$TR($P(NODE,"^",5),"YNU","100")
 ;Invalid location code
 I (DATA'="")&("456789AB"'[DATA) Q 0
 ;Location code not consistant with POW status
 I (DATA) Q:('POW) 0
 I (DATA="") Q:((DFN)&(POW)) 0
 ;Valid location code
 Q 1
RADMTHD(DATA,DFN) ;Radiation exposure method
 ;Note: Use of DFN is optional.  Use of the DFN will validate the
 ;      radiation method and also verify that it is consistant with
 ;      patient's radiation exposure (i.e. must also have claimed
 ;      exposure).  Non-use of DFN will only validate the radiation
 ;      method.
 ;
 Q:('$D(DATA)) 0
 N RAD,NODE
 S DFN=+$G(DFN)
 ;Patient claim exposure ?
 S RAD=1
 I (DFN) D
 .S NODE=$G(^DPT(DFN,.321))
 .S RAD=$TR($P(NODE,"^",3),"YNU","100")
 ;Invalid method code
 I (DATA'="") Q:((DATA'?1N)!(DATA<2)!(DATA>7)) 0  ;SD*543 changed >4 to >7
 ;Method code not consistant with exposure status
 I (DATA) Q:('RAD) 0
 I (DATA="") Q:((DFN)&(RAD)) 0
 ;Valid method code
 Q 1
NUMRANK(DATA,MINVAL,MAXVAL,DECCNT) ;Numeric ranking validation
 ;Input  : MINVAL - Minimum value (defaults to no lower limit)
 ;         MAXVAL - Maximum value (defaults to no upper limit)
 ;         DECCNT - Decimal places allowed (defaults to no limit)
 ;Note   : DATA considered invalid if NULL
 Q:('$D(DATA)) 0
 Q:(DATA="") 0
 Q:(DATA=".") 0
 N INVALID
 S INVALID=0
 ;General numeric check
 Q:(DATA'?.1"-".N.1".".N) 0
 ;Min value check
 I ($G(MINVAL)'="") D
 .S INVALID=(DATA<MINVAL)
 Q:(INVALID) 0
 ;Max value check
 I ($G(MAXVAL)'="") D
 .S INVALID=(DATA>MAXVAL)
 Q:(INVALID) 0
 ;Decimal check
 I ($G(DECCNT)'="") D
 .X "S INVALID=DATA'?.1""-"".N.1"".""."_DECCNT_"N"
 Q:(INVALID) 0
 ;Valid
 Q 1
VALFAC(DATA) ;Determine if given facility number is valid
 Q:('$D(DATA)) 0
 Q:(DATA="") 0
 ;Invalid
 Q:('$D(^DIC(4,"D",DATA))) 0
 ;Valid
 Q 1
ACTFAC(DATA) ;Determine if given facility number is active
 Q:('$D(DATA)) 0
 Q:(DATA="") 0
 N PTR4,ACTIVE,NODE
 ;Check all entries in INSTITUTION file (#4) with given facility number
 ; (quits when first active entry is found)
 S ACTIVE=0
 S PTR4=0
 F  S PTR4=+$O(^DIC(4,"D",DATA,PTR4)) Q:('PTR4)  D  Q:(ACTIVE)
 .;Get node with inactive flag
 .S NODE=$G(^DIC(4,PTR4,99))
 .;Inactive
 .Q:($P(NODE,"^",4)="y")
 .;Active
 .S ACTIVE=1
 ;Done
 Q ACTIVE
PROVID(DATA,HLECH) ;External Provider ID
 Q:('$D(DATA)) 0
 Q:(DATA="") 0
 N PRVDUZ,PRVFAC,SUBSEP,VALID
 S SUBSEP=$E(HLECH,4)
 S PRVDUZ=$P(DATA,SUBSEP,1)
 S PRVFAC=$P(DATA,SUBSEP,2)
 S VALID=0
 I $$NUMRANK(PRVDUZ,1,,0),$$VALFAC(PRVFAC),$$ACTFAC(PRVFAC) S VALID=1
 Q VALID
ROLEID(DATA) ;Role Instance ID
 Q:('$D(DATA)) 0
 Q:(DATA="") 0
 N ROLEID,SEQID,VALID
 S ROLEID=$P(DATA,"*",1)
 S SEQID=$P(DATA,"*",2)
 S VALID=0
 I ROLEID'="" I $$NUMRANK(SEQID,1,,0) S VALID=1
 Q VALID
VA01(DATA) ;VA Table 1 (Yes/No/Unknown)
 ;Notes: Table VA01 allows values of Y,N,U,1,0
 ;     : NULL is an accepted value
 Q:('$D(DATA)) 0
 Q:(DATA="") 1
 Q:($L(DATA)'=1) 0
 N TMP
 S TMP=$TR(DATA,"YNU0","1111")
 Q:(TMP'=1) 0
 Q 1
CLAMST(VALUE,DFN) ;
 ;Error code 9030
 ;Validating whether or not the visit is related to MST
 ;
 ;INPUT
 ;   ENCDT -  Date of encounter
 ;   DFN   -  IEN pointer from the Outpatient Encounter (#409.68) file
 ;   VALUE -  Is encounter related (1=Yes,0=No)
 ;
 ;OUTPUT
 ;   1 = Visit is related to MST
 ;   0 = Visit Not related to MST
 ;
 ;
 N MSTSTAT
 I '$D(VALUE) Q 0
 S MSTSTAT=$$GETSTAT^DGMSTAPI(DFN)
 S MSTSTAT=$P(MSTSTAT,"^",2)
 S MSTSTAT=$S(MSTSTAT="Y":1,1:0)
 Q $S(MSTSTAT=0&(VALUE=1):0,1:1)
MSTSTAT(DATA) ;
 ;Error code 7040
 ;Check for valid MST status codes Y,N,D,U
 ;
 ;INPUT
 ;   DATA - the MST Status passed in by routine SCMSVZEL 
 ;
 ;OUTPUT
 ;   1 - Valid MST Status
 ;   0 - Invalid MST Status
 ;
 I '$D(DATA) Q 0
 I ("Y,N,U,D"[DATA)!(DATA="") Q 1
 Q 0
MSTDATE(DATA) ;
 ;Error code 7060
 ;Check for valid date and that MST status is either Y,N,D or U
 ; Variable X must be passed to ^%DT for date verification
 ; Variable Y is returned from ^%DT
 ;
 ;INPUT
 ;  DATA - MST Date Status Changed^MST Status from SCMSVZEL
 ;
 ;OUTPUT
 ;   1 - Valid MST Status and date in a valid format
 ;   0 - Invalid MST Status or date in an invalid format
 ;
 N X,MSTSTAT
 S X=$P(DATA,"^",2)
 S MSTSTAT=$P(DATA,"^",1)
 I X=""&("Y,N,D"'[MSTSTAT!(MSTSTAT="")) Q 1
 S X=$$FMDATE^HLFNC(X),%DT="T"
 D ^%DT
 Q $S(Y>0&("U,Y,N,D"[MSTSTAT):1,1:0)
 ;
AO(DATA,DFN) ;Validate Agent Orange expos. (error 7120)
 ;INPUT  : DATA - Value to validate
 ;         DFN - Pointer to PATIENT file (#2)
 ;OUTPUT : 1 - Valid claim of exposure to Agent Orange
 ;         0 - Invalid claim of exposure to Agent Orange
 I '$D(DATA) Q 0
 I '$D(DFN) Q 0
 I DATA=1 Q 1 ;$$CANBEAO(DFN)  SD*5.3*395 rem check for period of service
 I (DATA=0)!(DATA="") Q 1
 Q 0
CANBEAO(DFN) ;Check to determine if patient can claim Agent Orange expos.
 ;INPUT  : DFN - Pointer to PATIENT file (#2)
 ;OUTPUT : 1 - Valid claim of exposure to Agent Orange
 ;         0 - Invalid claim of exposure to Agent Orange
 ;
 N VAEL
 I '$G(DFN) Q 0
 I '$D(^DPT(DFN,0)) Q 0
 ;Get data needed to perform check
 D ELIG^VADPT
 ;Must be a veteran
 I 'VAEL(4) Q 0
 ;Must have POS 7
 I $P($G(^DIC(21,+VAEL(2),0)),"^",3)=7 Q 1
 ;Can't claim AO
 Q 0
AOLOC(DATA,DFN) ;Validate Agent Orange exposure location (error 7130)
 ;INPUT  : DATA - Value to validate
 ;         DFN - Pointer to PATIENT file (#2)
 ;OUTPUT : 1 - Valid Agent Orange exposure location
 ;         0 - Invalid/missing Agent Orange exposure location
 ;NOTES  : Patient's claiming exposure must have an exposure location
 N VASV
 I '$G(DFN) Q 0
 I '$D(^DPT(DFN,0)) Q 0
 I '$D(DATA) Q 0
 ;Get data needed to perform check
 D SVC^VADPT
 ;No claim - shouldn't have a location
 I 'VASV(2) Q $S(DATA="":1,1:0)
 ;Claims exposure - must have a valid location
 Q $S(DATA="":0,"VKO"[DATA:1,1:0)
