IVMCM6 ;ALB/SEK,JAN,RTK,CKN,TDM,GN - COMPLETE DCD INCOME TEST ; 7/21/03 1:13pm
 ;;2.0;INCOME VERIFICATION MATCH;**17,25,39,44,50,53,49,58,62,67,84,115,136**;21-OCT-94;Build 1
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ;IVM*2*84 - insure DGMTP is defined by LTC test prior to calling
 ;           audit
 ;
EN ; This routine will update annual means test file (#408.31):
 ;      
 ; Note: There is no entry in 408.31 for income screening.
 ;
 ;
 ;Input:
 ;  DGMTI - ien of new Annual Means Test which requires completion
 ;  IVMMTIEN - ien of replaced test (may not exist)
 ;
 ; - open case record in (#301.5) file
 N DGREF,DATA,CODE,FIELD,RET,NODE0,NODE2,OK2SND
 D CHKTST,OPEN
 ;
 ; - if income screening goto MTBULL
 I IVMTYPE=3 G MTBULL
 ;
 ; - setup variables for (#408.31) file
 ;get the ZMT segment, translate HLQ's to NULLS
 S IVMSEG=$G(^TMP($J,"IVMCM","ZMT"_IVMTYPE)) ; get mt/copay ZMT segment
 F FIELD=4:1:30 I FIELD'=24,$P(IVMSEG,HLFS,FIELD)=HLQ S $P(IVMSEG,HLFS,FIELD)=""
 ;
 S IVM1=$$FMDATE^HLFNC($P(IVMSEG,"^",10)) ; dt/time completed
 S IVM2=$P(IVMSEG,"^",7) ; agree to pay deductible
 S IVM3=$$FMDATE^HLFNC($P(IVMSEG,"^",15)) ; dt vet signed test
 S IVM4=$P(IVMSEG,"^",16) ; declines to give income info field
 S:IVM4 DGREF=""
 S IVM5=$$FMDATE^HLFNC($P(IVMSEG,"^",6)) ; dt/time of adjudication
 S IVM6=$P(IVMSEG,"^",3) ;status
 S IVM7=$P(IVMSEG,"^",13) ; hardship
 S:$G(IVMHADJ) IVMCAT=$P(IVMSEG,"^",3) ; test status 
 S IVM8=$P(IVMSEG,"^",22) ; site conducting test
 S IVM9=$P(IVMSEG,"^",23) ; site granting hardship
 S IVM10=$P(IVMSEG,"^",11) ; prev years threshold
 S IVM11=$P(IVMSEG,"^",18) ; source of test
 S IVM12=$$FMDATE^HLFNC($P(IVMSEG,"^",24)) ; hardship effective date
 S IVM13=$$FMDATE^HLFNC($P(IVMSEG,"^",25)) ; date/time last edited
 S IVM14=$P(IVMSEG,"^",26) ; test determined status
 S IVM15=$P(IVMSEG,"^",4) ; income 
 S IVM16=$P(IVMSEG,"^",5) ; net worth
 S IVM17=$P(IVMSEG,"^",8) ; threshold A
 S IVM18=$P(IVMSEG,"^",9) ; deductible expenses
 S IVM19=$P(IVMSEG,"^",12) ; total dependents
 S IVM20=$P(IVMSEG,"^",27) ; signature valid?
 S IVM21=$$FMDATE^HLFNC($P(IVMSEG,"^",14)) ; hardship review date
 S IVM22=$P(IVMSEG,"^",28) ; GMT threshold
 S IVM23=$P(IVMSEG,"^",29) ; hardship reason
 S IVM24=+$P(IVMSEG,"^",30) ; Means Test Version
 ;
 ;old tests may not have the field Test-Determined Status
 I IVM14="" D
 . I IVMTYPE=1,IVM7,"AG"[IVM6 D  Q
 . . I IVM6="A",(IVM15'>IVM22) S IVM14="G" Q   ;Income <= GMT Threshold
 . . S IVM14="C"
 . S IVM14=IVM6
 ;
 ; - fields for means test, copay test and Long Term Care Test
 S DATA(.14)=IVM4,DATA(.18)=IVM19,DATA(.23)=IVM11,DATA(2.05)=IVM8,DATA(.06)=DUZ,DATA(.07)=IVM1,DATA(2.02)=IVM13,DATA(2.03)=$$GETSTAT^DGMTH(IVM14,IVMTYPE),DATA(2.11)=IVM24
 ;
 I IVM7 S DATA(.08)=.5,DATA(.09)=$$NOW^XLFDT
 ;
 I 'IVM4 S DATA(.04)=IVM15,DATA(.15)=IVM18
 ;
 ; - means test fields
 I IVMTYPE=1 D
 . S DATA(.11)=IVM2,DATA(.12)=IVM17,DATA(.2)=IVM7,DATA(.24)=IVM3,DATA(.29)=IVM20,DATA(2.04)=IVM9,DATA(.1)=IVM5,DATA(2.01)=IVM12
 . I 'IVM4 S DATA(.05)=IVM16
 . S DATA(.16)=IVM10,DATA(.21)=IVM21,DATA(.27)=IVM22,DATA(2.09)=IVM23
 ;
 ; - Long Term Care fields
 I IVMTYPE=4 D
 . N DATE,TYPE
 . ;set pointer to associated means test or RX copay test if there is one
 . I $P($G(^TMP($J,"IVMCM","ZMT1")),HLFS,2) S DATE=$P(^TMP($J,"IVMCM","ZMT1"),HLFS,2),TYPE=1
 . E  I $P($G(^TMP($J,"IVMCM","ZMT2")),HLFS,2) S DATE=$P(^TMP($J,"IVMCM","ZMT2"),HLFS,2),TYPE=2
 . I $G(DATE) S DATA(2.08)=$P($$LST^DGMTU(DFN,DATE,TYPE),"^")
 . S DATA(.11)=IVM2
 . I 'IVM4 S DATA(.05)=IVM16
 . K DATA(2.03)  ;test determined status is not used in LTC test
 ;
 I $G(IVMMTIEN) D
 . ; Get record data to compare with HL7 Message data
 . S NODE0=$G(^DGMT(408.31,IVMMTIEN,0))
 . S NODE2=$G(^DGMT(408.31,IVMMTIEN,2))
 . ;
 . ; If Site Conducting Test is the same, get Completed By from record.
 . I $P(NODE2,"^",5)=IVM8 S DATA(.06)=$P(NODE0,"^",6)
 . ;
 . ; If there are Comments, copy them into new record
 . I $O(^DGMT(408.31,IVMMTIEN,"C",0)) S DATA(50)="^DGMT(408.31,"_IVMMTIEN_",""C"")"
 . ;
 . I IVMTYPE=1 D
 . . ; Hardship is YES in msg and record, and the Site Granting Hardship
 . . ; is the same as the site receiving the msg, keep the record data
 . . I IVM7,$P(NODE0,"^",20),IVM9=$P($$SITE^VASITE,"^",3) S DATA(.21)=$P(NODE0,"^",21),DATA(.22)=$P(NODE0,"^",22),DATA(2.01)=$P(NODE2,"^",1),DATA(.08)=$P(NODE0,"^",8),DATA(.09)=$P(NODE0,"^",9)
 . . ;
 . . ; Hardship is YES in msg and record, and the Site Granting Hardship
 . . ; is NOT the same in both the msg and record, keep the message data
 . . I IVM7,$P(NODE0,"^",20),$P(NODE2,"^",4)'=IVM9 S DATA(.22)=DATA(.06)
 . . ;
 . . ; Hardship is YES in msg and NO in record, keep the message data
 . . I IVM7,'$P(NODE0,"^",20) S DATA(.22)=DATA(.06)
 . . ;
 . . ; Hardship is set to delete in msg, delete the Hardship
 . . I IVM12=HLQ!('IVM7&($P(NODE0,"^",20))) D
 . . . S (DATA(.08),DATA(.09),DATA(.2),DATA(.21),DATA(.22),DATA(2.01),DATA(2.04),DATA(2.09))=""
 . . . I $P(NODE0,"^",20) D BULL2^IVMCMB(DFN,$P(NODE2,"^"),$P(NODE2,"^",4))
 . . ;
 . . ; Hardship is NO in msg and in record, keep the message data
 . . I 'IVM7,'$P(NODE0,"^",20) S DATA(.22)=""
 . . ;
 . . ; Notify site of hardship?
 . . I IVM12'=HLQ,IVM7,((IVM12'=$P(NODE2,"^"))!('$P(NODE0,"^",20))) D BULL1^IVMCMB(DFN,IVM12,IVM9)
 . . ;
 . . ; Notify site to discontinue net-worth development?
 . . I IVM11=3,$P(NODE0,"^",23)=1,$$GETCODE^DGMTH($P(NODE0,"^",3))="P" D BULL3^IVMCMB(DFN)
 ;
 ;determine status based on test-determined status and hardship
 S CODE=IVM14
 I IVMTYPE=1,DATA(.2) S CODE=IVM6
 S DATA(.03)=$$GETSTAT^DGMTH(CODE,IVMTYPE)
 ;
 I $$UPD^DGENDBS(408.31,DGMTI,.DATA) D
 . ; can't call MT Events protocol for Long Term Care Copay Exemption
 . ; Tests as it triggers an IB and Enrollment update
 . ; so manually call needed protocols to trigger audit, date stamp
 . ; and transmission (if necessary)
 . I IVMTYPE=4 D  Q
 . . S:$G(DGMTACT)="" DGMTACT="ADD"
 . . S DGMTP=$G(DGMTP)                                       ;IVM*2*84
 . . S DGMTINF=1  ;Means Test Interactive/Non-interactive flag
 . . D AFTER^DGMTEVT
 . . D EN^DGMTAUD                   ;means test audit event
 . . D ^IVMPMTE                     ;IVM means test event
 . . D DATETIME^DGMTU4($G(DGMTI))   ;date stamp
 . ;
 . ; - call means test event driver if not future test
 . I 'IVMFUTR D
 . . D:(IVMTYPE=1) MTPRIME^DGMTU4(DGMTI)
 . . D:(IVMTYPE=2) RXPRIME^DGMTU4(DGMTI)
 . . S CODE=$$GETCODE^DGMTH($P($G(^DGMT(408.31,DGMTI,0)),"^",3))
 . E  D
 . . ;enter to list of future tests kept in the IVM Patient file
 . . D ADDFUTR^IVMPLOG2(DGMTI)
 . . ;also, if HEC changed the test to a future date, there could be
 . . ;a test on file for the same income year marked as primary
 . . I $G(IVMMTIEN),$P(NODE2,"^",5)=IVM8 D
 . . . N DATA,ERROR,DGMTI,DGMTACT,DGMTYPT,DGMTA
 . . . S DATA(2)=0
 . . . I $$UPD^DGENDBS(408.31,IVMMTIEN,.DATA,.ERROR)
 . . . ; if the test being replaced by the uploaded future test
 . . . ; becomes non-primary and the site conducted both tests
 . . . ; then call Means Test event driver (non interactively)
 . . . S DGMTACT="EDT",DGMTI=IVMMTIEN,DGMTYPT=IVMTYPE,DGMTINF=1
 . . . D AFTER^DGMTEVT
 . . . D EN^DGMTEVT
 . . . D
 . . . . N DGMSGF,DGADDF
 . . . . S DGMSGF=1,DGADDF=0
 . . . . D EN^DGMTR
 . D:OK2SND TRNSMT
 ;
 ;
MTBULL ; Build results array
 D ADD^IVMCMB(DFN,IVMTYPE,$S(IVMFUTR:"Future Test",1:"New Test"),$G(IVMMTDT),$S($G(IVMMTIEN):$$GETCODE^DGMTH($P($G(^DGMT(408.31,IVMMTIEN,0)),"^",3)),1:""),CODE)
 ;
CLEANUP ; cleanup
 K DGCAT,DGCOMF,DGMTACT,DGMTI,DGMTINF,DGMTPAR,DGTHB,IVMBU45,IVMOP,IVMOP1
 K IVM1,IVM2,IVM3,IVM4,IVM5,IVM6,IVM7,IVM8,IVM9,IVM10,IVM11,IVM12,IVM13,IVM14,IVMCAT,IVMCEA,IVMCEB,IVMMTA,IVM15,IVM16,IVM17,IVM18,IVM19,IVM20,IVM21
 K IVM22,IVM23,IVM24
 Q
 ;
OPEN ; open case record for uploaded test
 S IVMOP="",IVMOP=$O(^IVM(301.5,"AYR",DGLY,DFN,IVMOP)) I 'IVMOP D OPEN1 Q
 S IVMOP1=$G(^IVM(301.5,IVMOP,0)) I 'IVMOP1 D OPEN1 Q
 I $P(IVMOP1,"^",4)=1 S DA=+IVMOP D  Q
 . S DIE="^IVM(301.5,",DR=".03////1;.04////0"
 . D OPEN2
 Q
OPEN1 K DD,DO
 S DIC="^IVM(301.5,",DIC(0)="LMNZ",X=DFN,DLAYGO=301.5
 D FILE^DICN Q:Y'>0  S DA=+Y
 S DIE="^IVM(301.5,",DR=".02////^S X=DGLY;.03////1;.04////0"
OPEN2 D ^DIE K DD,DO,DIC,DLAYGO,X,Y,DIE,DR
 Q
 ;
MTDRIVER ; call means test event driver
 ; dgmtact
 ; adj  adjudicated mt
 ; cat  hardship mt
 ; add  new mt or copay
 ; edit corrected mt or copay
 ;         
 N IVMDA,IVMDT,IVMFLG,IVMMTDT,IVMNEW
 S DGMTACT=$S($G(IVMHADJ)=1:"ADJ",$G(IVMHADJ)=2:"CAT",'$G(DGMTP):"ADD",1:"EDT")
 D AFTER^DGMTEVT
 S DGMTINF=1 ; non-interactive flag
 D EN^DGMTEVT
 Q
 ;
CHKTST ; Verify if the incoming Income Test requires a Z07 transmission.
 ;
 N MTREC,REC01,ZMTSEG
 S OK2SND=0
 S MTREC=$G(^DGMT(408.31,DGMTI,0))
 Q:'$D(^DGMT(408.31,DGMTI,0))
 ; Check if the Source of the Test is DCD
 S ZMTSEG=$G(^TMP($J,"IVMCM","ZMT"_IVMTYPE))
 Q:$P($G(^DG(408.34,+$P(ZMTSEG,U,18),0)),U)'="DCD"
 ;Check if the DCD software has been installed
 Q:'$$VERSION^XPDUTL("IVMC")
 ;
 ; If the source of the test is DCD, and the site receiving the test
 ; is a DCD site, set the record to transmit.
 S OK2SND=1
 Q
 ;
TRNSMT ; Set the record to transmit due to DCD Criteria
 N REC01,DCDDATA,DCDIEN,EVENTS,ERROR
 S REC01=$O(^IVM(301.5,"AYR",DGLY,DFN,""))
 S DCDDATA(.04)=0,DCDIEN=REC01
 I $$UPD^DGENDBS(301.5,DCDIEN,.DCDDATA,.ERROR)
 S EVENTS("DCD")=1
 I $$SETSTAT^IVMPLOG(REC01,.EVENTS)
 ;
 Q
