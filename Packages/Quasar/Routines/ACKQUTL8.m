ACKQUTL8 ;HCIOFO/AG -QUASAR Utility Routine ; [ 04/25/96 10:03 ]
 ;;3.0;QUASAR;**1,2,8**;Feb 11, 2000
 ;Per VHA Directive 10-93-142, this routine SHOULD NOT be modified.
 ;
 ;
CHKVST(ACKVIEN,ACKARR,ACKFULL) ; check a visit for missing fields
 ; this function will validate a visit to determine if there are any
 ;  missing required fields.
 ; required inputs:  ACKVIEN  - visit ien number
 ;    ACKARR - array to hold errors (must be passed by ref ie ".ACKARR")
 ;    ACKFULL - if true, the visit will be checked in full and may
 ;      return type 0 errors, and type 1 and type 2. if false, the
 ;      function will only look for type 1s if there are no type 0s etc.
 ; output:
 ;    ACKARR=typ - type of error found
 ;                 -1 = Error - unable to process visit
 ;                  0 = visit does not have minimum data required
 ;                      for Quasar
 ;                  1 = visit has minimum for Quasar but some additional
 ;                      required fields are missing
 ;                  2 = all Quasar required fields are present but one
 ;                      or more PCE fields are missing (ie will not be
 ;                      accepted by PCE if the interface is on).
 ;                  3 = everything ok
 ;   ACKARR(typ)=num - number of fields in error
 ;   ACKARR(typ,1-num)=field - free text name of field
 ; example:
 ;   ACKARR=0 - visit does not have minimum reqd by Quasar
 ;   and ACKARR(0)=2,ACKARR(0,1)="Clinic",ACKARR(0,2)="Patient"
 ;       this visit does not have a clinic or a patient
 ;
 N ACKDATA
 S ACKFULL=+$G(ACKFULL)
 K ACKARR S ACKARR=3
 ;
 ; if visit number not passed in then exit
 I +$G(ACKVIEN)=0 S ACKARR=-1 G CHKVSTX
 ;
 ; get quasar minimum fields for the visit (level 0)
GET0 D GETS^DIQ(509850.6,ACKVIEN_",",".01;1;2.6;5;60","I","ACKDATA")
 ;
 ; if nothing returned by fileman then exit
 I '$D(ACKDATA(509850.6,ACKVIEN_",")) S ACKARR=-1 G CHKVSTX
 ;
 ; check visit date
CHK0 I $G(ACKDATA(509850.6,ACKVIEN_",",.01,"I"))'?7N D
 . S ACKARR=0,ACKARR(0)=+$G(ACKARR(0))+1
 . S ACKARR(0,ACKARR(0))="Visit Date"
 ; check Patient
 ; I $G(ACKDATA(509850.6,ACKVIEN_",",1,"I"))'?1.N D
 ; . ; S ACKARR=0,ACKARR(0)=+$G(ACKARR(0))+1
 ; . ; S ACKARR(0,ACKARR(0))="Patient"
 ; check Clinic
 I $G(ACKDATA(509850.6,ACKVIEN_",",2.6,"I"))'?1.N D
 . S ACKARR=0,ACKARR(0)=+$G(ACKARR(0))+1
 . S ACKARR(0,ACKARR(0))="Clinic"
 ; check CDR Account
 I $G(ACKDATA(509850.6,ACKVIEN_",",5,"I"))'?1.N D
 . S ACKARR=0,ACKARR(0)=+$G(ACKARR(0))+1
 . S ACKARR(0,ACKARR(0))="CDR Account"
 ; check Division
 I $G(ACKDATA(509850.6,ACKVIEN_",",60,"I"))'?1.N D
 . S ACKARR=0,ACKARR(0)=+$G(ACKARR(0))+1
 . S ACKARR(0,ACKARR(0))="Division"
 ;
END0 ; if errors found and we're not doing a full check then exit
 I ACKARR<3,'ACKFULL G CHKVSTX
 ;
GET1 ; get data for level 1 check 
 K ACKDATA
 D GETS^DIQ(509850.6,ACKVIEN_",","55;6;7;.09;4.01;.07","I","ACKDATA")
 ;
 ; check Appointment Time
CHK1 I $G(ACKDATA(509850.6,ACKVIEN_",",55,"I"))'?1"."1.N D
 . S:ACKARR>1 ACKARR=1
 . S ACKARR(1)=$G(ACKARR(1))+1,ACKARR(1,ACKARR(1))="Appointment Time"
 ;
 ; check Primary Provider
 N ACKPRV
 S ACKPRV=$G(ACKDATA(509850.6,ACKVIEN_",",6,"I"))   ; prim
 I ACKPRV'?1.N D
 . S:ACKARR>1 ACKARR=1
 . S ACKARR(1)=+$G(ACKARR(1))+1,ACKARR(1,ACKARR(1))="Primary Provider"
 ;
 ; check procedure
 I 'ACKEVENT D
 . N ACKCPT
 . N ACKP S ACKP=$O(^ACK(509850.6,ACKVIEN,3,0)),ACKCPT=""
 . I ACKP S ACKCPT=$P($G(^ACK(509850.6,ACKVIEN,3,ACKP,0)),U,1)
 . I ACKCPT'?1N.N D
 . . S:ACKARR>1 ACKARR=1
 . . S ACKARR(1)=$G(ACKARR(1))+1,ACKARR(1,ACKARR(1))="CPT Procedure"
 . K ACKCPT
 ;
 I ACKEVENT D
 . N ACKEV S ACKEV=""
 . N ACKP S ACKP=$O(^ACK(509850.6,ACKVIEN,7,0)),ACKEV=""
 . I ACKP S ACKEV=$P($G(^ACK(509850.6,ACKVIEN,7,ACKP,0)),U,1)
 . I ACKEV="" D
 . . S:ACKARR>1 ACKARR=1
 . . S ACKARR(1)=$G(ACKARR(1))+1,ACKARR(1,ACKARR(1))="Event Capture Procedure"
 . K ACKEV
 ;
 ; check Diagnosis
 N ACKICD,ACKFROM
 ; D LIST^DIC(509850.63,","_ACKVIEN_",","","",1,.ACKFROM,"","","","","ACKICD")
 ; I $P($G(ACKICD("DILIST",0)),U,1)'=1 D  ; LIST call removed - too slow!
 N ACKD S ACKD=$O(^ACK(509850.6,ACKVIEN,1,0)),ACKICD=""
 I ACKD S ACKICD=$P($G(^ACK(509850.6,ACKVIEN,1,ACKD,0)),U,1)
 I ACKICD'?1N.N D
 . S:ACKARR>1 ACKARR=1
 . S ACKARR(1)=$G(ACKARR(1))+1,ACKARR(1,ACKARR(1))="Diagnosis"
 ;  check to see that a diagnosis has been allocated as the Primary
 I '$$PRIMARY^ACKQASU5(ACKVIEN,"") D
 . S:ACKARR>1 ACKARR=1
 . S ACKARR(1)=$G(ACKARR(1))+1,ACKARR(1,ACKARR(1))="Primary Diagnosis"
 K ACKICD
 ;
 ; check C and P status (CHECK FOR OPEN REQUEST?)
 N ACKCP
 S ACKCP=$G(ACKDATA(509850.6,ACKVIEN_",",.09,"I"))
 I ACKCP'="",ACKCP'?1N D
 . S:ACKARR>1 ACKARR=1
 . S ACKARR(1)=$G(ACKARR(1))+1,ACKARR(1,ACKARR(1))="C and P Status"
 ;
 ; check first audiometric field
 I ACKCP,$G(ACKDATA(509850.6,ACKVIEN_",",4.01,"I"))'?1.N D
 . S:ACKARR>1 ACKARR=1
 . S ACKARR(1)=$G(ACKARR(1))+1,ACKARR(1,ACKARR(1))="Audiometric Data"
 ;
 ; check Time Spent
 I $G(ACKDATA(509850.6,ACKVIEN_",",.07,"I"))'?1N.N D
 . S:ACKARR>1 ACKARR=1
 . S ACKARR(1)=$G(ACKARR(1))+1,ACKARR(1,ACKARR(1))="Time Spent"
 ;
END1 ; if errors found and we're not doing a full check then exit
 I ACKARR<3,'ACKFULL G CHKVSTX
 ;
 ; get data for level 2
GET2 K ACKDATA
 D GETS^DIQ(509850.6,ACKVIEN_",","1;80;20;25;30;35","I","ACKDATA")
 ;
 ; check visit eligibility
CHK2 I $G(ACKDATA(509850.6,ACKVIEN_",",80,"I"))'?1.N D
 . S:ACKARR>2 ACKARR=2
 . S ACKARR(2)=$G(ACKARR(2))+1,ACKARR(2,ACKARR(2))="Visit Eligibility"
 ;
 ; get service connected data
 N DFN,VAEL,VASV,ACKSC,ACKSCV,ACKAO,ACKIR,ACKENV
 S DFN=$G(ACKDATA(509850.6,ACKVIEN_",",1,"I"))
 S (ACKSC,ACKAO,ACKIR,ACKEC)=0
 I DFN?1.N D ELIG^VADPT,SVC^VADPT D
 . S ACKSC=$S(+VAEL(3)=1:1,1:0)  ; patient service connected
 . S ACKAO=$S(+VASV(2)=1:1,1:0)  ; patient agent orange
 . S ACKIR=$S(+VASV(3)=1:1,1:0)  ; patient radiation
 . S ACKEC=$S($$GET1^DIQ(2,DFN_",",.322013,"I")="Y":1,1:0)  ; pat env cont
 S ACKSCV=$G(ACKDATA(509850.6,ACKVIEN_",",20,"I"))  ; serv conn visit
 ;
 ; check service connected status
 I ACKSC=1,ACKSCV'?1N D
 . S:ACKARR>2 ACKARR=2
 . S ACKARR(2)=$G(ACKARR(2))+1,ACKARR(2,ACKARR(2))="Service Connected"
 ;
 ; check Agent Orange
 I ACKSCV'=1,ACKAO,$G(ACKDATA(509850.6,ACKVIEN_",",25,"I"))'?1N D
 . S:ACKARR>2 ACKARR=2
 . S ACKARR(2)=$G(ACKARR(2))+1,ACKARR(2,ACKARR(2))="Agent Orange"
 ;
 ; check Radiation
 I ACKSCV'=1,ACKIR,$G(ACKDATA(509850.6,ACKVIEN_",",30,"I"))'?1N D
 . S:ACKARR>2 ACKARR=2
 . S ACKARR(2)=$G(ACKARR(2))+1,ACKARR(2,ACKARR(2))="Ionizing Radiation"
 ;
 ; check Environmental contaminants
 I ACKSCV'=1,ACKEC,$G(ACKDATA(509850.6,ACKVIEN_",",35,"I"))'?1N D
 . S:ACKARR>2 ACKARR=2
 . S ACKARR(2)=$G(ACKARR(2))+1,ACKARR(2,ACKARR(2))="Environmental Contaminants"
 ;
 ;
CHKVSTX ; that'll do
 Q
 ;
 ;
DIAGTXT(ACKQDCDS,ACKCVD) ;  Get Short ICD9 Description
 N DIAGTXT
 I $G(ACKCVD)="" S ACKCVD=$$DATE
 ; S DIAGTXT=$$GET1^DIQ(80,ACKQDCDS,3)
 S DIAGTXT=$$ICDDX^ICDCODE(ACKQDCDS,ACKCVD)
 S DIAGTXT=$P(DIAGTXT,"^",4)
 Q DIAGTXT
 ;
LDIAGTXT(ACKQDCDS,ACKCVD) ;  Get Long ICD9 Description
 N LDIAGTXT,LST,RET
 S ACKQDCDS=$$CONV(ACKQDCDS)
 S LST="LST"
 I $G(ACKCVD)="" S ACKCVD=$$DATE
 ; S LDIAGTXT=$$GET1^DIQ(80,ACKQDCDS,10)
 S RET=$$ICDD^ICDCODE(ACKQDCDS,LST,ACKCVD)
 I $P(RET,"^",1)="-1" S LDIAGTXT=$P(RET,"^",2)
 I $P(RET,"^",1)'="-1" S LDIAGTXT=LST(1)
 Q LDIAGTXT
 ;
PROCTXT(ACKQDCDS,ACKCVD) ;  Get Short CPT Description
 N PROCTXT
 I $G(ACKCVD)="" S ACKCVD=$$DATE
 ; S PROCTXT=$$GET1^DIQ(81,ACKQDCDS,2)
 S PROCTXT=$$CPT^ICPTCOD(ACKQDCDS,ACKCVD)
 S PROCTXT=$P(PROCTXT,"^",3)
 Q PROCTXT
 ;
MODTXT(ACKQMCDS,ACKCVD) ;  Get Short CPT Modifier Description
 N MODTXT
 I $G(ACKCVD)="" S ACKCVD=$$DATE
 ; S MODTXT=$$GET1^DIQ(81.3,ACKQMCDS,.02)
 S MODTXT=$$MOD^ICPTMOD(ACKQMCDS,"I",ACKCVD)
 S MODTXT=$P(MODTXT,"^",3)
 Q MODTXT
 ;
CONV(ACKQDCDS) ;
 N CODE
 S CODE=$P($G(^ICD9(ACKQDCDS,0)),"^",1)
 Q CODE
 ;
DATE() ;
 D NOW^%DTC
 Q $P(%,".",1)
 ;
 ;
