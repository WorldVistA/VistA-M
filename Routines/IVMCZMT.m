IVMCZMT ;ALB/MLI/LD/CKN,TDM,EG,TDM - Creation of  HL7 ZMT (means test) segment ; 7/19/06 4:41pm
 ;;2.0;INCOME VERIFICATION MATCH;**17,53,49,58,81,89,104,105**;21-OCT-94;Build 2
 ;
 ; This routine returns the ZMT segment which contains means test
 ; data for a selected patient. It differs from the standard segment
 ; builder in that it will add default values where needed for
 ; fields added by means test sharing - these fields may not have
 ; values for old tests, though for new tests the values should be there.
 ;
 ;
 ;
EN(DFN,VAFSTR,VAFMTDT,VAFTYPE,SETID,DELETE,LIMIT)       ; Entry point to get ZMT segment
 ;
 ;  Input:
 ;      DFN - as the IEN or corresponding patient in the PATIENT file
 ;   VAFSTR - as string of segment fields needed separated by commas
 ;  VAFMTDT - (optional) as date of desired means test (defaults to latest MT)
 ;  VAFTYPE - (optional) as type of test:  1 - Means Test (default=1)
 ;      2 - Copay Test
 ;      4 - LTC Copay Exemption Test
 ;  SETID -  (optional) value to use for SEQ 1, the set id field (1 used
 ;     as default if not passed.)
 ;  DELETE - (optional, pass by reference) This array is used to
 ;    indicate whether the segment is being used to notify of the
 ;    the deletion of a means test, pharmacy copay test, or a
 ;    hardship determinatin.  If a means test or hardship is being
 ;    deleted, then VAFTYPE must equal 1.  If an Rx copay test is
 ;    being deleted, then VAFTYPE must equal 2.  The subscripts
 ;    are as follows:
 ;    DELETE("DATE OF TEST")=<date of test> - indicates
 ;    the income year of the test that the deletion flags
 ;    refer to
 ;    DELETE("HARDSHIP") -  if $G(DELETE("HARDSHIP"))=1 then the
 ;    segment will be created to delete the hardship.
 ;    DELETE("MT") - if $G(DELETE("MT"))=1 then
 ;    the segment will be created to delete a means test.
 ;    DELETE("RX")= if $G(DELETE("RX"))=1 then
 ;    the segment will be created to delete a pharmacy
 ;    copay test.
 ;    DELETE("LTC")= if $G(DELETE("LTC"))=1 then
 ;    the segment will be created to delete a Long term
 ;    care copay exemption test.
 ;  LIMIT - (optional) if $G(LIMIT)=1 then this indicates that a test in
 ;    an income year other than indicated in the IVM Patient File
 ;    should NOT be returned in the ZMT segment
 ;
 ;      ****Also assumes all HL7 variables are defined as returned ****
 ;   by the INIT^HLTRANS call
 ;
 ; Output - string in the form of the DHCP HL7 ZMT segment
 ;
 ;
 N NODE,PRIM,X,Y,VAFY,NODE2,MTIEN
 ;
 I '$G(DFN)!($G(VAFSTR)']"") G QUIT
 S $P(VAFY,HLFS,22)="",VAFSTR=","_VAFSTR_","
 S VAFTYPE=$S($G(VAFTYPE):VAFTYPE,1:1)
 S VAFMTDT=$S($G(VAFMTDT):VAFMTDT,1:DT)
 S $P(VAFY,HLFS,1)=$S($G(SETID):SETID,1:1)
 S (NODE,NODE2,PRIM)=""
 ;
 ;handle deletions of a test
 I ($G(DELETE("MT"))=1),VAFTYPE=1 D  G QUIT
 .S $P(VAFY,HLFS,2)=$$HLDATE^HLFNC(DELETE("DATE OF TEST")) ; MT Date
 .S $P(VAFY,HLFS,3)=HLQ
 .I ($G(DELETE("HARDSHIP"))=1) S $P(VAFY,HLFS,24)=HLQ
 .S $P(VAFY,HLFS,17)=VAFTYPE ; Type Of Test
 ;
 I ($G(DELETE("RX"))=1),VAFTYPE=2 D  G QUIT
 .S $P(VAFY,HLFS,2)=$$HLDATE^HLFNC(DELETE("DATE OF TEST")) ; MT Date
 .S $P(VAFY,HLFS,3)=HLQ
 .S $P(VAFY,HLFS,17)=VAFTYPE ; Type Of Test
 ;
 I ($G(DELETE("LTC"))=1),VAFTYPE=4 D  G QUIT
 .S $P(VAFY,HLFS,2)=$$HLDATE^HLFNC(DELETE("DATE OF TEST")) ; MT Date
 .S $P(VAFY,HLFS,3)=HLQ
 .S $P(VAFY,HLFS,17)=VAFTYPE ; Type Of Test
 ;
 ; Income Year requiring transmission from IVM Patient File (301.5)
 S IVMIY=$S($D(IVMIY):IVMIY,1:(VAFMTDT-10000))
 ;
 ; Check for a future dated Income Test
 S MTIEN=""
 N EC S EC=0
 I VAFTYPE'=4 D
 . S MTIEN=+$$FUT^DGMTU(DFN,"",$S($G(VAFTYPE):VAFTYPE,1:1))
 . I MTIEN D
 . . S NODE=$G(^DGMT(408.31,MTIEN,0)),PRIM=$G(^("PRIM")),NODE2=$G(^DGMT(408.31,MTIEN,2))
 . . ;the FUT API works off the a XREF that is not deleted if the test
 . . ;is no longer future.  As a result, you may pick up the wrong income
 . . ;year as a return.  The check $E(IVMIY,1,3)+1'=$E(+NODE,1,3) must be
 . . ;performed here and after the current Primary icnome test section below
 . . I ($G(LIMIT)=1),($E(IVMIY,1,3)+1)'=$E(+NODE,1,3) S EC=1
 . . Q
 . Q
 I VAFTYPE'=4,EC S (NODE,NODE2,MTIEN,PRIM)=""   ;Q "ZMT"_HLFS_$G(VAFY)
 ;
 ; Check for a current Primary Income Test
 I 'MTIEN S MTIEN=+$$LST^DGMTU(DFN,VAFMTDT,$S($G(VAFTYPE):VAFTYPE,1:1))
 S:(NODE="") NODE=$G(^DGMT(408.31,MTIEN,0)),PRIM=$G(^("PRIM")),NODE2=$G(^DGMT(408.31,MTIEN,2))
 ;
 ;if the wrong income yr, and told to ignore it ($G(LIMIT)=1,
 ;send blank means test
 I ($G(LIMIT)=1),($E(IVMIY,1,3)+1)'=$E(+NODE,1,3) S (NODE,NODE2,MTIEN,PRIM)="" Q "ZMT"_HLFS_$G(VAFY)
 ;
 ;
 I NODE'="" D
 .;add default values to new means test sharing fields
 .N STATUS,CODE,TDSTATUS,TDCODE,HARDSHIP,DATA,SOURCE,TIME
 .S TDSTATUS=$P(NODE2,"^",3)
 .S HARDSHIP=$P(NODE,"^",20)
 .I TDSTATUS="" D
 ..S STATUS=$P(NODE,"^",3)
 ..Q:'STATUS
 ..S CODE=$$GETCODE^DGMTH(STATUS)
 ..I CODE'="","ABCEGMP"[CODE D
 ...I VAFTYPE=1,HARDSHIP D
 ....I "AG"[CODE D  Q
 .....I CODE="A",($P(NODE,"^",4)'>$P(NODE,"^",27)) S TDSTATUS=$$GETSTAT^DGMTH("G",1) Q  ;Income <= GMT Threshold
 .....S TDSTATUS=$$GETSTAT^DGMTH("C",1)
 ....S TDSTATUS=STATUS
 ...S DATA(2.03)=TDSTATUS,$P(NODE2,"^",3)=TDSTATUS
 .S SOURCE=$P(NODE,"^",23)
 .I SOURCE=1 D
 ..S TIME=$P(NODE2,"^",2)
 ..I TIME="" S TIME=$$NOW^XLFDT,$P(NODE2,"^",2)=TIME,DATA(2.02)=TIME
 ..I $P(NODE2,"^",5)="",$P(NODE,"^",6) S $P(NODE2,"^",5)=$$GETSITE^DGMTU4($P(NODE,"^",6)),DATA(2.05)=$P(NODE2,"^",5)
 .I HARDSHIP,$P(NODE2,"^",4)="",$P(NODE,"^",22) S $P(NODE2,"^",4)=$$GETSITE^DGMTU4($P(NODE,"^",22)),DATA(2.04)=$P(NODE2,"^",4)
 .I $D(DATA),$$UPD^DGENDBS(408.31,MTIEN,.DATA)
 .;
 I VAFSTR[",2," S $P(VAFY,HLFS,2)=$S(+NODE:$$HLDATE^HLFNC(+NODE),1:HLQ) ; MT Date
 I VAFSTR[",3," S X=$P($G(^DG(408.32,+$P(NODE,"^",3),0)),"^",2),$P(VAFY,HLFS,3)=$S(X]"":X,1:"") ; MT Status
 I VAFSTR[",4," S $P(VAFY,HLFS,4)=$S($P(NODE,"^",4)]"":$P(NODE,"^",4),1:HLQ) ; Income
 I VAFSTR[",5," S $P(VAFY,HLFS,5)=$S($P(NODE,"^",5)]"":$P(NODE,"^",5),1:HLQ) ; Net Worth
 I VAFSTR[",6," S $P(VAFY,HLFS,6)=$S($P(NODE,"^",10):$$HLDATE^HLFNC($P(NODE,"^",10)),1:HLQ) ; Adjudication Date/Time
 I VAFSTR[",7," S $P(VAFY,HLFS,7)=$$YN^VAFHLFNC($P(NODE,"^",11)) ;Agreed To Pay
 I VAFSTR[",8," S $P(VAFY,HLFS,8)=$S($P(NODE,"^",12):$P(NODE,"^",12),1:HLQ) ; Threshold A
 I VAFSTR[",9," S $P(VAFY,HLFS,9)=$S($P(NODE,"^",15)]"":$P(NODE,"^",15),1:HLQ) ; Deductible Expenses
 I VAFSTR[",10," S $P(VAFY,HLFS,10)=$S($P(NODE,"^",7):$$HLDATE^HLFNC($P(NODE,"^",7)),1:HLQ) ; Date/Time Completed
 I VAFSTR[",11," S $P(VAFY,HLFS,11)=$$YN^VAFHLFNC($P(NODE,"^",16)) ;Previous Year Means Test Threshold Flag
 I VAFSTR[",12," S $P(VAFY,HLFS,12)=$S($P(NODE,"^",18)]"":$P(NODE,"^",18),1:HLQ) ; Total Dependents
 I VAFSTR[",13," S $P(VAFY,HLFS,13)=$$YN^VAFHLFNC($P(NODE,"^",20)) ;Hardship
 I VAFSTR[",14," S $P(VAFY,HLFS,14)=$S($P(NODE,"^",21):$$HLDATE^HLFNC($P(NODE,"^",21)),1:HLQ) ; Hardship Review Date
 I VAFSTR[",15," S $P(VAFY,HLFS,15)=$S($P(NODE,"^",24):$$HLDATE^HLFNC($P(NODE,"^",24)),1:HLQ) ; Date Vet Signed Test
 I VAFSTR[",16," S $P(VAFY,HLFS,16)=$$YN^VAFHLFNC($P(NODE,"^",14)) ;Declines To Give Income Info
 I VAFSTR[",17," S $P(VAFY,HLFS,17)=$S($P(NODE,"^",19):$P(NODE,"^",19),1:VAFTYPE) ; Type Of Test
 I VAFSTR[",18," S $P(VAFY,HLFS,18)=$S($P(NODE,"^",23)]"":$P(NODE,"^",23),1:HLQ) ; Source Of Test
 I VAFSTR[",19," S $P(VAFY,HLFS,19)=$$YN^VAFHLFNC(PRIM) ; Primary Test?
 I VAFSTR[",20," S $P(VAFY,HLFS,20)=$S($P(NODE,"^",25):$$HLDATE^HLFNC($P(NODE,"^",25)),1:HLQ) ; Date IVM Verified MT Completed
 I VAFSTR[",21," S $P(VAFY,HLFS,21)=$$YN^VAFHLFNC($P(NODE,"^",26)) ;Refused To Sign
 ;
 ;
 I VAFSTR[",22," S $P(VAFY,HLFS,22)=$P(NODE2,"^",5) ;Site Conducting Test
 I VAFSTR[",23," S $P(VAFY,HLFS,23)=$P(NODE2,"^",4) ;Site Granting Hardship
 I VAFSTR[",24," S $P(VAFY,HLFS,24)=$S($P(NODE2,"^"):$$HLDATE^HLFNC($P(NODE2,"^")),1:"") ;Hardship Effective Date
 I VAFSTR[",25," S $P(VAFY,HLFS,25)=$S($P(NODE2,"^",2):$$HLDATE^HLFNC($P(NODE2,"^",2)),1:"") ;Dt/Tm Test Last Edited
 I VAFSTR[",26," S $P(VAFY,HLFS,26)=$S($P(NODE2,"^",3):$$GETCODE^DGMTH($P(NODE2,"^",3)),1:"") ; Test Determined Status
 I VAFSTR[",28," S $P(VAFY,HLFS,28)=$P(NODE,"^",27)  ;GMT Threshold
 I VAFSTR[",29," S $P(VAFY,HLFS,29)=$P(NODE2,"^",9)  ;Hardship Reason
 I VAFSTR[",30," S $P(VAFY,HLFS,30)=+$P(NODE2,"^",11) ; Test Version
 ;
 ;can only transmit the deletion of a hardship if the segment is for a means test - and the income years must match if there is a means test
 ;
 I VAFTYPE=1,($G(DELETE("HARDSHIP"))=1),('(+NODE)!($E(DELETE("DATE OF TEST"),1,3)=$E((+NODE),1,3))) S $P(VAFY,HLFS,24)=HLQ
 ;
QUIT    Q "ZMT"_HLFS_$G(VAFY)
