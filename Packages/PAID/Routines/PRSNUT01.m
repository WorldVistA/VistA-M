PRSNUT01 ;WOIFO/JAH - Nurse Activity for VANOD Utilities;6/5/2009
 ;;4.0;PAID;**126**;Sep 21, 1995;Build 59
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 Q
 ;
GETCODES(PRSIEN) ;function returns the following codes from file 450
 ;       Cost Center (CST)
 ;       Budget Object Code (BOC)
 ;       Assignment Code (ASN)
 ;       Occupation Series Code (OCC)
 ;
 N IENS,BOC,BOCE,OCC,ASN,CST,FIELDS,ASNE,CSTE,OCCE
 S IENS=PRSIEN_","
 D GETS^DIQ(450,IENS,"3;15.5;17;18","IE","FIELDS(",,)
 S BOC=$G(FIELDS(450,IENS,18,"I"))
 S OCC=$G(FIELDS(450,IENS,15.5,"I"))
 S ASN=$G(FIELDS(450,IENS,3,"I"))
 S CST=$G(FIELDS(450,IENS,17,"I"))
 S BOCE=$G(FIELDS(450,IENS,18,"E"))
 S OCCE=$G(FIELDS(450,IENS,15.5,"E"))
 S ASNE=$G(FIELDS(450,IENS,3,"E"))
 S CSTE=$G(FIELDS(450,IENS,17,"E"))
 Q BOC_U_OCC_U_ASN_U_CST_U_BOCE_U_OCCE_U_ASNE_U_CSTE
 ;
GETDEG(PRSIEN) ;function returns degree and year of degree
 ;
 N IENS,DEGREE,YEAR,FIELDS
 S IENS=PRSIEN_","
 D GETS^DIQ(450,IENS,"10;47","IE","FIELDS(",,)
 S DEGREE=$G(FIELDS(450,IENS,10,"E"))
 S YEAR=$G(FIELDS(450,IENS,47,"I"))
 Q DEGREE_U_YEAR
 ;
ISNURSE(PRSIEN) ;Return True if employee is a nurse
 ;
 ;Lookup employees values in 450 for the following:
 ;       Cost Center (CST)
 ;       Budget Object Code (BOC)
 ;       Assignment Code (ASN)
 ;       Occupation Series Code (OCC)
 ;Determine whether they are a nurse by matching them to one of the
 ;entries in the Nurse Role file
 ;
 ;
 N BOC,CST,OCC,ASN,CODES,KEY
 N NODE0,ISNURSE,FIELDS,IENS
 S ISNURSE=0
 Q:PRSIEN'>0 ISNURSE
 S CODES=$$GETCODES(PRSIEN)
 S BOC=$P(CODES,U)
 S OCC=$P(CODES,U,2)
 S ASN=$P(CODES,U,3)
 S CST=$P(CODES,U,4)
 ;
 ; lookup on B index in 451.1 for exact or wildcard matches
 ;
 ; the wildcards (*) designate that an employee can have any value
 ; for that entity as long as the other entities match an entry in the
 ; table and they are considered a nurse.
 ;
 ; the .01 in that file is a key with cost center, budget object code,
 ; occupation series and assignment code.
 S KEY="* "_BOC_" "_OCC_" "_ASN
 I $D(^PRSN(451.1,"B",KEY)) D NURSTYP Q ISNURSE
 S KEY="* "_BOC_" "_OCC_" *"
 I $D(^PRSN(451.1,"B",KEY)) D NURSTYP Q ISNURSE
 S KEY=CST_" "_BOC_" "_OCC_" *"
 I $D(^PRSN(451.1,"B",KEY)) D NURSTYP Q ISNURSE
 S KEY=CST_" "_BOC_" "_OCC_" "_ASN
 I $D(^PRSN(451.1,"B",KEY)) D NURSTYP Q ISNURSE
 Q ISNURSE
NURSTYP ;
 N IEN
 S IEN=$O(^PRSN(451.1,"B",KEY,0))
 S ISNURSE="1^"_$P($G(^PRSN(451.1,IEN,0)),U,2,4)
 Q
ACTIVLOC(ACTLOC,PRSDT) ; return list of active locations for a given date
 ;INPUT:
 ;  PRSDT-optional fileman date.  If no date is passed then today
 ;        is assumed.
 ;OUTPUT:
 ;  ACTLOC-array of nursing locations that were active on the input
 ;         fileman date
 ; output array is subscripted by Nurse Location IEN and the zero
 ; node contains the count of active locations
 ; Each node contains the following pieces.
 ;
 ;  PIECE #   Definition
 ;  -------   -------------
 ;    1       external name of location
 ;    2       Institution Name
 ;    3       institution IEN
 ;    4       station number
 ;
 ;Loop through each entry in the nurse location file and check
 ;the index on the service date multiple to see if it was active
 ;
 I +$G(PRSDT)'>1700000!(+$G(PRSDT)'<4000000) S PRSDT=DT
 K ACTLOC
 N IEN,ACTIVE
 S ACTLOC(0)=0
 S IEN=0
 F  S IEN=$O(^NURSF(211.4,IEN)) Q:IEN'>0  D
 .  S ACTIVE=$$ISACTIVE(PRSDT,IEN)
 .  I ACTIVE D
 ..    S ACTLOC(IEN)="",ACTLOC(0)=ACTLOC(0)+1
 ..    S ACTLOC(IEN)=$P(ACTIVE,U,2,5)
 Q
ACTIVLST(ACTLOC,PRSDT) ; return list of active locations that are active
 ;for any day in a pay period in which date falls
 ;INPUT:
 ;  PRSDT-optional fileman date.  If no date is passed then today
 ;        is assumed.
 ;OUTPUT:
 ;  ACTLOC-array of nursing locations that were active on any day
 ;  during the pay period associated witht the input fileman date
 ;
 ;  Output array is subscripted by Nurse Location IEN and the zero
 ;  node contains the count of active locations
 ;  Each node contains the following pieces.
 ;
 ;  PIECE #   Definition
 ;  -------   -------------
 ;    1       external name of location
 ;    2       Institution Name
 ;    3       institution IEN
 ;    4       station number
 ;
 ;Loop through each entry in the nurse location file and check
 ;the index on the service date multiple to see if it was active
 ;
 I +$G(PRSDT)'>1700000!(+$G(PRSDT)'<4000000) S PRSDT=DT
 K ACTLOC
 N IEN,ACTIVE
 S ACTLOC(0)=0
 S IEN=0
 F  S IEN=$O(^NURSF(211.4,IEN)) Q:IEN'>0  D
 .  S ACTIVE=$$ISACTPP(PRSDT,IEN)
 .  I ACTIVE D
 ..    S ACTLOC(IEN)="",ACTLOC(0)=ACTLOC(0)+1
 ..    S ACTLOC(IEN)=$P(ACTIVE,U,2,6)
 Q
ISACTIVE(PRSDT,LIEN) ;Return TRUE if location is active on date
 ;INPUT:
 ;  PRSDT-FileMan date
 ;  LIEN- nurse location internal entry number
 ;OUTPUT:
 ;  function returns 5 piece string
 ;  PIECE #   Definition
 ;  -------   -------------
 ;    1       0 for inactive, 1 for active
 ;    2       external name of location
 ;    3       Institution Name
 ;    4       institution IEN
 ;    5       station number
 ;
 I '$D(^NURSF(211.4,LIEN,0)) Q "-1"_U_"Undefined Location"
 N IENS,STATUS,DIVI,STATUS,LOCE,INSIEN,STATNUM,FIELDS
 I +$G(PRSDT)'>1700000!(+$G(PRSDT)'<4000000) S PRSDT=DT
 S PRSDT=PRSDT_".1"
 S PRSDT=$O(^NURSF(211.4,LIEN,7,"C",PRSDT),-1)
 I PRSDT="" D
 .  S STATUS="I"
 E  D
 .  S STATUS=$O(^NURSF(211.4,LIEN,7,"C",PRSDT,""))
 S IENS=LIEN_","
 D GETS^DIQ(211.4,IENS_",",".01;.02","IE","FIELDS(",,)
 S LOCE=$G(FIELDS(211.4,IENS,.01,"E"))
 S DIVI=$G(FIELDS(211.4,IENS,.02,"I"))
 ;institution file pointer from Hospital Location
 ;
 S INSIEN=+$$GET1^DIQ(44,+$G(^NURSF(211.4,LIEN,0)),3,"I")
 D GETS^DIQ(4,INSIEN_",","99","E","FIELDS(",,)
 S STATNUM=FIELDS(4,INSIEN_",",99,"E")
 Q $S(STATUS="A":1,1:0)_U_LOCE_U_DIVI_U_INSIEN_U_STATNUM
 ;
ISACTPP(PRSDT,LIEN) ;Return True if location is active for any days
 ; during the pay period associated with date
 ;INPUT:
 ;  PRSDT-FileMan date
 ;  LIEN- nurse location internal entry number
 ;OUTPUT:
 ;  function returns 2 piece string
 ;  1st piece is 0 for inactive, 1 for active
 ;  2nd piece is external name of location
 ; 
 ; UNIT TEST: F PRSI=1:1:6 W !,$$ISACTPP^PRSNUT01(3090122,PRSI)
 ;
 N PPI,I,PRSDYS,ACTIVE
 S PPI=$P($G(^PRST(458,"AD",PRSDT)),U)
 ; if date isn't in an open pay period then assume last open pay period
 I PPI'>0 D
 .  S PRSDT=$O(^PRST(458,"AD",9999999),-1)
 .  S PPI=$P($G(^PRST(458,"AD",PRSDT)),U)
 S PRSDYS=$G(^PRST(458,PPI,1))
 F I=1:1:14 S PRSDT=$P(PRSDYS,U,I) D  Q:ACTIVE
 .  S ACTIVE=$$ISACTIVE(PRSDT,LIEN)
 ;
 Q ACTIVE
POCRANGE() ;Prompt user for POC date range and return start and stop dates
 ;
 ; GET START DATE
 N %DT,Y,X
 S %DT="AEP"
 S %DT("A")="Start Date: "
 ;
 ; Don't allow selection of dates prior to the first entry in
 ; the POC daily records file or a date after the last day
 ; of the last pay period with POC records on file
 ;
 N EPPI,LPPI,FD,LD,FIRSTDT,LASTDT
 S EPPI=$O(^PRSN(451,0))
 I EPPI'>0 Q 0_U_"No POC records on file!"
 S LPPI=$O(^PRSN(451,99999),-1)
 S LD=$P($G(^PRST(458,LPPI,1)),U,14)
 S Y=LD D DD^%DT S LASTDT=Y
 ;
 S FD=+$G(^PRST(458,EPPI,1))
 S Y=FD D DD^%DT S FIRSTDT=Y
 ;
 ;
 N SUCCESS,OUT,STARTDT,ENDDT,EDTE,SDTE
 S (SUCCESS,OUT)=0
 F  D  Q:SUCCESS!OUT
 .D ^%DT
 .I Y'>0 S OUT=1 Q
 .S STARTDT=Y
 .I STARTDT<FD D  Q
 ..W " cannot be earlier than ",FIRSTDT,$C(7)
 .I STARTDT>LD D  Q
 ..W " cannot be later than ",LASTDT,$C(7)
 .S SUCCESS=1
 Q:OUT 0
 ;Now reset the earliest date for end date since it cannot be before the start date
 S FD=STARTDT
 S Y=FD D DD^%DT S FIRSTDT=Y
 ;
 ;GET END DATE
 N %DT,Y,X
 S %DT="AEP"
 S %DT("A")="End Date: "
 ;
 ; Don't allow selection of prior to the start date
 ;
 S (SUCCESS,OUT)=0
 F  D  Q:SUCCESS!OUT
 .D ^%DT
 .I Y'>0 S OUT=1 Q
 .S ENDDT=Y
 .I ENDDT<FD D  Q
 ..W " cannot be earlier than ",FIRSTDT,$C(7)
 .I ENDDT>LD D  Q
 ..W " cannot be later than ",LASTDT,$C(7)
 .S SUCCESS=1
 Q:OUT 0
 S Y=STARTDT D DD^%DT S SDTE=Y
 S Y=ENDDT D DD^%DT S EDTE=Y
 Q STARTDT_U_ENDDT_U_SDTE_U_EDTE
