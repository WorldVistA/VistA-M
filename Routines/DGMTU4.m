DGMTU4 ;ALB/CJM,SCG,LBD,EG,PHH MEANS TEST UTILITES ; 06/07/2005
 ;;5.3;Registration;**182,267,285,347,454,456,476,610,658**;Aug 13, 1993
 ;
GETSITE(DUZ) ;
 ;Descripition:  Gets the users station number.  If not found, it will
 ;return the station number of the primary facility.
 ;
 ;Input:
 ;      DUZ array, pass by reference
 ;Output:
 ;      Function Value - station number with suffix
 N FACILITY,STATION,CURSTN,CHILD,CIEN
 S FACILITY=""
 S:($G(DUZ)'=.5) FACILITY=$G(DUZ(2))
 I 'FACILITY S FACILITY=+$$SITE^VASITE()
 S:FACILITY STATION=$$STA^XUAF4(FACILITY)
 S CURSTN=$P($$SITE^VASITE,"^",3)
 I $D(STATION) D
 .I STATION']"" D
 ..D CHILDREN^XUAF4("CHILD","`"_FACILITY,"PARENT FACILITY")
 ..S CIEN=0 F  S CIEN=$O(CHILD("C",CIEN)) Q:'CIEN  I CIEN=CURSTN S STATION=$$STA^XUAF4(CIEN) Q
 ..I STATION']"" D
 ...D CHILDREN^XUAF4("CHILD","`"_FACILITY,"VISN")
 ...S CIEN=0 F  S CIEN=$O(CHILD("C",CIEN)) Q:'CIEN  I CIEN=CURSTN S STATION=$$STA^XUAF4(CIEN) Q
 Q $G(STATION)
 ;
DATETIME(MTIEN) ;
 ;Writes date/time stamp to means test record
 N DATA
 Q:$G(IVMZ10)="UPLOAD IN PROGRESS"
 S DATA(2.02)=$$NOW^XLFDT
 I $G(MTIEN),$D(^DGMT(408.31,MTIEN,0)) I $$UPD^DGENDBS(408.31,MTIEN,.DATA)
 Q
SAVESTAT(MTIEN,DGERR) ;
 ;Save the Test Determined Status (#2.03) in the ANNUAL MEANS TEST file
 ;(#408.31)
 ;
 ;Input:
 ;      MTIEN - IEN of 408.31
 ;      DGERR  - (optional) 1 - Means or Copay Test is incomplete
 ;                          0 - Means or Copay Test is complete       
 ;
 ;only current statuses of P, A, or C for Means Tests and
 ;current status of M, or E for Copay Tests will be stored.
 ;
 ;if test is incomplete the Test Determined Status will be deleted.
 ;
 Q:('$G(MTIEN))
 ;
 N CODE,DATA,NODE0,TYPE
 I $G(DGERR) S DATA(2.03)="" G SET
 S NODE0=$G(^DGMT(408.31,MTIEN,0))
 S TYPE=$P(NODE0,"^",19)
 S CODE=$$GETCODE^DGMTH($P(NODE0,"^",3))
 S:CODE="A" (DATA(.11),DATA(.14))=""
 S DATA(2.03)=""
 I TYPE=1,(CODE="N") Q
 I TYPE=2,(CODE="L") Q
 I TYPE=1,(CODE'=""),"CPAG"[CODE D
 .S DATA(2.03)=$P(NODE0,"^",3)
 .I $P(NODE0,"^",20) D
 ..S DATA(2.03)=$$GETSTAT^DGMTH($S(CODE="P":"P",CODE="A"&(($P(NODE0,U,4)-$P(NODE0,U,15))'>$P(NODE0,U,27)):"G",1:"C"),1)
 I TYPE=2,(CODE'=""),"ME"[CODE S DATA(2.03)=$P(NODE0,"^",3)
SET I $$UPD^DGENDBS(408.31,MTIEN,.DATA)
 Q
MTPRIME(MTIEN) ;
 ;Makes the means test MTIEN primary
 ;
 N DGREQF,DGDOM1,DGADDF,DGMSGF,DGMTACT,DGMTI,DGMTINF,DGMTP,DGMTA,TRIES,DATA,NODE,DFN,MTDATE,YREND,DGMTDC,IBPRIOR,MTPRIME,LSTNODE
 Q:('$G(MTIEN))
 S MTPRIME="DGMTU4"
 S NODE=$G(^DGMT(408.31,MTIEN,0))
 Q:(NODE="")
 S DFN=$P($G(^DGMT(408.31,MTIEN,0)),"^",2)
 Q:'DFN
 Q:+$G(^DGMT(408.31,MTIEN,"PRIM"))  ;already marked as primary!
 S MTDATE=+NODE
 Q:'MTDATE
 Q:($P(NODE,"^",19)'=1)
 ;
 S DGMTACT="ADD"
 D PRIOR^DGMTEVT
 ;
 ;marks any existing tests as non-primary - shouldn't be more than
 ;one such test, but give it two tries
 I '$$OLD(MTDATE) D
 .S YREND=DT_.2359
 E  D
 .S YREND=$E(MTDATE,1,3)_1231.9999
 F TRIES=1,2 S NODE=$$LST^DGMTU(DFN,YREND,1) Q:'(+NODE)  Q:($E($P(NODE,"^",2),1,3)'=$E(MTDATE,1,3))  D
 .N DATA
 .;set up for the event driver - should be treated as an edit
 .S:(TRIES=1) DGMTACT="EDT",DGMTI=+NODE D PRIOR^DGMTEVT
 .;set the old test to non-primary
 .S DATA(2)=0 I $$UPD^DGENDBS(408.31,+NODE,.DATA)
 ;
 ;don't want any old RX copay tests as primary either - if needed, they can be auto-created based on the means test
 F TRIES=1,2 S NODE=$$LST^DGMTU(DFN,YREND,2) Q:'(+NODE)  Q:($E($P(NODE,"^",2),1,3)'=$E(MTDATE,1,3))  D
 .N DATA
 .;set the old test to non-primary
 .S DATA(2)=0 I $$UPD^DGENDBS(408.31,+NODE,.DATA)
 ;
 ;mark this test as primary
 K DATA S DATA(2)=1 I $$UPD^DGENDBS(408.31,MTIEN,.DATA)
 ;
 ; Get Last Primary Means Test irrespective of income year
 S LSTNODE=$$LST^DGMTU(DFN)
 ;if STATUS is REQUIRED & test is PRIMARY, then set it to NOT PRIMARY
 ;if the uploaded test is MT COPAY REQUIRED
 ; MT COPAY (CAT C) doesn't expire, which is why you have to 
 ; flip the test to Not Primary eg 02/01/2005
 I $P(LSTNODE,U,4)="R",+$G(^DGMT(408.31,+LSTNODE,"PRIM")),$P(^DGMT(408.31,MTIEN,0),U,3)=6 D
 . N DATA S DATA(2)=0 I $$UPD^DGENDBS(408.31,+LSTNODE,.DATA)
 ;if means test is required and test is primary and not a CAT C, 
 ;and it hasn't expired, flip the test to Not Primary eg 02/23/2005
 I $P(LSTNODE,U,4)="R",+$G(^DGMT(408.31,+LSTNODE,"PRIM")),$P(^DGMT(408.31,MTIEN,0),U,3)'=6,'$$OLD(MTDATE) D
 . N DATA S DATA(2)=0 I $$UPD^DGENDBS(408.31,+LSTNODE,.DATA)
 ;
 ;If this is a Z10 upload, call the means test event driver and quit.
 ;
 I $G(IVMZ10)="UPLOAD IN PROGRESS" D  Q
 .S DGMTI=MTIEN
 .S DGMTINF=1
 .D QUE^DGMTR
 ;
 ;If the test is still in effect, need to do additional checks
 ;and call event driver
 ;
 I '$$OLD(MTDATE) D
 .;Mark this test as NO LONGER REQUIRED -  calling EN^DGMTR will
 .;change it back to its old status if required and will que the event
 .;driver
 .K DATA
 .S DATA(.03)=$$GETSTAT^DGMTH("N",1)
 .I $$UPD^DGENDBS(408.31,MTIEN,.DATA)
 .S (DGADDF,DGMSGF)=1 ;don't want new test added or messages
 .S DGMTI=MTIEN
 .S DGMTINF=1
 .;
 .D EN^DGMTR
 .;if the test wasn't required, maybe a Rx copay test is needed
 .I '$G(DGREQF),'$G(DGDOM1) D COPYRX^DGMTR1(DFN,MTIEN)
 Q
 ;
RXPRIME(RXIEN) ;
 ;Makes phramacy copay test =RXIEN the primary test
 ;
 N DGREQF,DGDOM1,DGADDF,DGMSGF,DGMTACT,DGMTI,DGMTINF,DGMTP,DGMTA,TRIES,DATA,NODE,DFN,MTIEN,DGRAUTO,DGADDF,DGMTE,DGMTCOR,DGMT,YREND,RXPRIME,QUIT
 ;
 Q:('$G(RXIEN))
 S RXPRIME="DGMTU4"
 S QUIT=0
 S NODE=$G(^DGMT(408.31,RXIEN,0))
 Q:(NODE="")
 S DFN=$P($G(^DGMT(408.31,RXIEN,0)),"^",2)
 Q:'DFN
 Q:+$G(^DGMT(408.31,RXIEN,"PRIM"))  ;already marked as primary!
 S MTDATE=+NODE
 Q:'MTDATE
 Q:($P(NODE,"^",19)'=2)
 ;
 S DGMTINF=1
 ;
 ;marks any existing tests as non-primary - shouldn't be more than
 ;one such test, but give it two tries
 ;
 I '$$OLD(MTDATE) D
 .S YREND=DT_.2359
 E  D
 .S YREND=$E(MTDATE,1,3)_1231.9999
 F TRIES=1,2 S NODE=$$LST^DGMTU(DFN,YREND,2) Q:'(+NODE)  Q:($E($P(NODE,"^",2),1,3)'=$E(MTDATE,1,3))  D
 .N DATA
 .;set up for the event driver - should be treated as an edit
 .S:(TRIES=1) DGMTACT="EDT",DGMTI=+NODE D PRIOR^DGMTEVT
 .;set the old test to non-primary
 .S DATA(2)=0 I $$UPD^DGENDBS(408.31,+NODE,.DATA)
 ;
 ;don't want any old means tests marked as primary - unless they are actually needed!  In which case, do not make this Rx test primary.
 F TRIES=1,2 S NODE=$$LST^DGMTU(DFN,YREND,1) Q:'(+NODE)  Q:($E($P(NODE,"^",2),1,3)'=$E(MTDATE,1,3))  D
 .N DATA
 .I '$$OLD($P(NODE,"^",2)),$P(NODE,"^",4)'="","ACGP"[$P(NODE,"^",4) S QUIT=1 Q
 .;set the old test to non-primary
 .S DATA(2)=0 I $$UPD^DGENDBS(408.31,+NODE,.DATA)
 ;
 I QUIT G QRXPRIME
 ;mark this test as primary -  calling
 ;EN^DGMTCOR will change it to NO LONGER APPLICABLE if appropriate
 ;
 K DATA
 S DATA(2)=1 I $$UPD^DGENDBS(408.31,RXIEN,.DATA)
 ;
 ;If the test is still in effect, need to do additional checks
 ;and call event driver
 ;
 I '$$OLD(MTDATE) D
 .S DGMSGF=1,DGADDF=0 ;don't want new test added or messages
 .;
 .;EN^DGMTR will first create a stub for a required MT if needed, then
 .;call ^DGMTCOR to set the status of the copay test
 .D EN^DGMTR
 .;
 .;if the pharmacy copay test was determined to be required, than
 .;que the event driver
 .I DGMTCOR D
 ..S DGMTACT="ADD"
 ..D PRIOR^DGMTEVT
 ..S DGMTI=RXIEN
 ..D QUE^DGMTR
QRXPRIME ;
 Q
 ;
OLD(TESTDATE) ;
 ;Checks if the date is older than 365 days.  Returns 0 for no, 1 for yes
 ;if the test is exactly 365 days, 
 ;it is considered expired eg 03/09/2005
 I ($$FMDIFF^XLFDT(DT,TESTDATE)'<365) Q 1
 Q 0
 ;
TRANSFER(DFN,FROM,TO) ;
 ;transfers the Income Relations from the test=FROM to test=TO
 ;
 N DGINI,DGINR,DATA,ERROR
 Q:'$G(DFN)
 Q:'$G(FROM)
 Q:'$G(TO)
 Q:(FROM=TO)
 S DGINI=0 F  S DGINI=$O(^DGMT(408.22,"AMT",FROM,DFN,DGINI)) Q:'DGINI  S DGINR=$O(^DGMT(408.22,"AMT",FROM,DFN,DGINI,"")) I $P($G(^DGMT(408.22,+DGINR,"MT")),"^")]"" D
 .K DATA
 .S DATA(31)=TO
 .I $$UPD^DGENDBS(408.22,+DGINR,.DATA,.ERROR)
 Q
 ;
GETINCOM(DFN,TDATE) ;
 ;Makes sure Income Relations point to the right test
 ;
 ;Input:
 ;  DFN
 ;  TDATE -income year of test (uses $E(IVMMTDT,1,3))
 ;Output: none.  Repoints Income Relations if necessary
 ;
 N MTNODE,RXNODE,IVMMTDT,CODE,ACTVIEN
 Q:'$G(TDATE)
 Q:'$G(DFN)
 ;
 S IVMMTDT=$E(TDATE,1,3)_"1231.9"
 S (CODE,ACTVIEN)=""
 S MTNODE=$$LST^DGMTU(DFN,IVMMTDT,1) I $E($P(MTNODE,"^",2),1,3)'=$E(IVMMTDT,1,3) S MTNODE=""
 S RXNODE=$$LST^DGMTU(DFN,IVMMTDT,2) I $E($P(RXNODE,"^",2),1,3)'=$E(IVMMTDT,1,3) S RXNODE=""
 ;
 D
 .;determine which test has the associated income relations
 .;
 .I +MTNODE S CODE=$P(MTNODE,"^",4) I CODE'="",("ACGPR"[CODE) S ACTVIEN=+MTNODE Q
 .I +RXNODE S CODE=$P(RXNODE,"^",4) I CODE'="",("EMI"[CODE) S ACTVIEN=+RXNODE Q
 .I +MTNODE S ACTVIEN=+MTNODE Q
 .I +RXNODE S ACTVIEN=+RXNODE Q
 I ACTVIEN,+MTNODE,+RXNODE D TRANSFER^DGMTU4(DFN,$S((ACTVIEN=+MTNODE):+RXNODE,1:+MTNODE),ACTVIEN)
 Q
 ;
CHKPT(DFN) ;
 ; Cross check the CURRENT MEANS TEST STATUS in the PATIENT File (#2) with the
 ; primary means test in the ANNUAL MEANS TEST File (#408.31).  Update the 
 ; CURRENT MEANS TEST STATUS if the fields are out of synch.
 ;
 N PATMT,DGMTI,DATA
 ;
 Q:$G(DFN)'>0
 Q:'$D(^DPT(DFN))
 S PATMT=$$GET1^DIQ(2,DFN,.14,"I")
 S DGMTI=+$$LST^DGMTU(DFN)
 S DATA(.14)=$P($G(^DGMT(408.31,DGMTI,0)),U,3)
 Q:DATA(.14)=PATMT
 ;
 I $$UPD^DGENDBS(2,DFN,.DATA)
 Q
