DGMTR ;ALB/RMO,CAW,SCG,AEG,SCG,AEG,LBD - Check Means Test Requirements ; 7/8/05 2:30pm
 ;;5.3;Registration;**45,93,114,137,141,147,177,182,146,305,326,314,344,402,426,456,495,672,688,773**;Aug 13, 1993;Build 7
 ;A patient requires a means test under the following conditions:
 ;  - Primary Eligibility is NSC OR patient is SC 0% non-compensable
 ;  - who is NOT receiving disability retirement from the military
 ;  - who is NOT eligible for medicaid
 ;  - who is NOT on a DOM ward
 ;  - who has NOT been means tested in the past year
 ;  - who is NOT a Purple Heart recipient
 ; Input  -- DFN     Patient IEN
 ;           DGADDF  Means Test Add Flag  (Optional- default none)
 ;                   (1 if using the 'Add a New Means Test' option)
 ;           DGMSGF  Means Test Msg Flag  (Optional- default none)
 ;                   (1 to suppress messages)
 ;           DGNOIVMUPD No IVM Update Flag (Optional - default allow)
 ;                   (1 if updating of an IVM test is not allowed)
 ; Output -- DGREQF  Means Test Require Flag
 ;                   (1 if required and 0 if not required)
 ;           DGDOM1  DOM Patient Flag (defined and set to 1 if
 ;                               patient currently on a DOM ward)
 ;           DGNOCOPF = 1 to suppress copay test prompt 0 otherwise
 ;                      used in CP^DG10.  Killed there as well.
 ;           If NOT using the 'Add a New Means Test' option,
 ;           a REQUIRED date of test will be added for the
 ;           patient if it is required.
 ;           If a means test is required and the current
 ;           status is NO LONGER REQUIRED, the last date of
 ;           test and current means test status will be
 ;           updated to REQUIRED unless the DGNOIVMUPD flag is set to 1
 ;           and the current primary means test is an IVM test. 
 ;           If a means test is no longer required the
 ;           last date of test and the current means test
 ;           status will also be updated to NO LONGER REQUIRED unless
 ;           the DGNOIVMUPD flag is set to 1 and the current primary
 ;           means test is an IVM test.
EN N DGCS,DGDOM,DGMT0,DGMTI,DGMTYPT,OLD,DGRGAUTO,DGQSENT,DGMTLTD,DGMDOD,DGMTDT
 ;DG*5.3*146 change to exit if during patient merge process
 Q:$G(VAFCA08)=1
 ;DGMTCOR is needed if uploading copay test
 I $G(RXPRIME)'="DGMTU4" N DGMTCOR
 S (DGQSENT,DGREQF)=0,(OLD,DGMTYPT)=1
 I $D(^DPT(DFN,.36)) S X=^(.36) D
 . I $P($G(^DIC(8,+X,0)),"^",9)=5!($$SC(DFN)) S DGREQF=1
 . I $P(X,"^",12)=1 S DGREQF=0 ;new field, DG 672
 . I $P(X,"^",13)=1 S DGREQF=0 ;new field, DG 672 
 S (DGMTI,DGMT0)="",DGMTI=+$$LST^DGMTU(DFN)
 S:DGMTI DGMT0=$G(^DGMT(408.31,DGMTI,0))
 ;Added with DG*5.3*344
 S:DGMTI DGMTDT=$P(DGMT0,U)
 S DGMDOD=$P($G(^DPT(DFN,.35)),U)
 I 'DGMTI,$G(DGMDOD) D EN^DGMTCOR S DGREQF=0 Q
 I DGREQF S:$G(^DPT(DFN,.38)) DGREQF=0
 I DGREQF D DOM S:$G(DGDOM) DGREQF=0
 S DGCS=$P(DGMT0,"^",3)
 S DGMTLTD=+DGMT0,DGNOCOPF=0
 I +$G(DGMDOD) S DGNOCOPF=1
 I DGCS S OLD=$$OLD^DGMTU4(+DGMT0)
 ;Purple Heart Recipient ;brm 10/02/00 added 1 line below
 I $P($G(^DPT(DFN,.53)),U)="Y" S DGREQF=0
 D
 .I DGREQF,DGCS=3,'OLD D REQ Q
 .I DGREQF,'$G(DGADDF),((DGCS=6)!(DGCS=2)),$P(DGMT0,U,11)=1,DGMTLTD>2991005 S DGREQF=0,DGNOCOPF=1 Q
 .; next line added 2/19/02 - DG*5.3*426
 .I DGREQF,'$G(DGADDF),$G(DGCS)=6,+$P(DGMT0,U,14),+$P(DGMT0,U,11) S DGREQF=0,DGNOCOPF=1 Q
 .I DGREQF,'$G(DGADDF),(('DGCS)!(OLD)),'$G(DGMDOD) D ADD Q
 .I 'DGREQF,DGCS,DGCS'=3,'$G(DGDOM),'$G(DGMDOD),'+$G(IVMZ10F) D NOL Q
 ;be sure to check whether or not patient is subject to RX copay!
 D EN^DGMTCOR
 Q
 ;Check if patient is in a DOM
 ;  call to DOM checks if patient currently on a DOM ward
 ;                                     (called from EN)
 ;  call to DOM1 checks if patient on a DOM ward for a specific date
 ;    before call to DOM1 - N VAINDT,VADMVT,DGDOM,DGDOM1
 ;                          S VAINDT=specific date
 ;                          S DFN=Patient IEN
 ;                 output - DGDOM & DGDOM1 (defined and set to 1 if
 ;                          patient on a DOM ward for specific date)
DOM N VAINDT,VADMVT
DOM1 D ADM^VADPT2
 I VADMVT,$P($G(^DG(43,1,0)),"^",21),$D(^DIC(42,+$P($G(^DGPM(VADMVT,0)),"^",6),0)),$P(^(0),"^",3)="D" S (DGDOM,DGDOM1)=1
 Q
SC(DFN) ;Check if patient is SC 0% non-compensable
 ; Input  -- DFN     Patient IEN
 ; Output -- 1=Yes and 0=No
 ;     No if:
 ;        No total annual VA check amount
 ;        POW STATUS INDICATOR is yes
 ;        Secondary Eligibility is one of the following:
 ;           A&A, NSC, VA PENSION
 ;           HOUSEBOUND, MEXICAN BORDER WAR, WWI, POW
 N DG,DGE,DGF,Y
 S Y=0
 ;Primary eligibility is SC LESS THAN 50%
 I $D(^DPT(DFN,.36)),$P($G(^DIC(8,+^(.36),0)),"^",9)=3 S Y=1
 G:'Y SCQ
 ;Service connected percentage is 0
 I $P($G(^DPT(DFN,.3)),"^",2)'=0 S Y=0 G SCQ
 ;No Total annual VA check amount
 I $P($G(^DPT(DFN,.362)),"^",20) S Y=0 G SCQ
 ;POW STATUS INDICATOR
 I $P($G(^DPT(DFN,.52)),"^",5)="Y" S Y=0 G SCQ
 ;Purple Heart Indicator
 I $P($G(^DPT(DFN,.53)),"^")="Y" S Y=0 G SCQ
 ;Secondary Eligibility
 F DG=2,4,15:1:18 S DGE(DG)=""
 S DG=0 F  S DG=$O(^DPT(DFN,"E","B",DG)) Q:'DG  D SELIG I DGF,$D(DGE(+DGF)) S Y=0 Q
SCQ Q +$G(Y)
ADD ;Add a required means test
 N DGMTA,DGMTACT,DGMTDT,DGMTI,DGMTP,ERROR
 W:'$G(DGMSGF) !,"MEANS TEST REQUIRED"
 S DGMTACT="ADD" D PRIOR^DGMTEVT
 S DGMTDT=DT D ADD^DGMTA
 I DGMTI>0 S DGMTYPT=1 D
 .N DATA S DATA(.03)=$$GETSTAT^DGMTH("R",1) I $$UPD^DGENDBS(408.31,DGMTI,.DATA)
 .D GETINCOM^DGMTU4(DFN,DT)
 .D QUE
 I $G(IVMZ10)'="UPLOAD IN PROGRESS",'$$OPEN^IVMCQ2(DFN),'$$SENT^IVMCQ2(DFN) D QRYQUE2^IVMCQ2(DFN,$G(DUZ),0,$G(XQY)) S DGQSENT=1 I '$D(ZTQUEUED),'$G(DGMSGF) W !!,"Financial query queued to be sent to HEC..."
 Q
REQ ;Update means test status to REQUIRED
 N DGMTA,AUTOCOMP,DGMTE,ERROR
 ;may have set prior MT for means test upload
 I $G(MTPRIME)'="DGMTU4" N DGMTP,DGMTACT S DGMTACT="STA" D PRIOR^DGMTEVT
 S AUTOCOMP=$$AUTOCOMP(DGMTI)
 ;if a test were auto-completed, don't want another being added inadvertently
 I AUTOCOMP,$G(DGADDF) S DGADDF=0
 I AUTOCOMP S DGCS=$P($G(^DGMT(408.31,DGMTI,0)),"^",3)
 I $G(IVMZ10)'="UPLOAD IN PROGRESS",'AUTOCOMP,'$$OPEN^IVMCQ2(DFN),'$$SENT^IVMCQ2(DFN) D QRYQUE2^IVMCQ2(DFN,$G(DUZ),0,$G(XQY)) S DGQSENT=1 I '$D(ZTQUEUED),'$G(DGMSGF) W !!,"Financial query queued to be sent to HEC..."
 I ('AUTOCOMP),('$G(DGMSGF)) W !,"MEANS TEST REQUIRED"
 I (AUTOCOMP),('$G(DGMSGF)) W !,"CURRENT MEANS TEST STATUS IS ",$$GETNAME^DGMTH(DGCS)
 S DGMTYPT=1
 D QUE
 Q
AUTOCOMP(DGMTI) ;
 ;Will either automatically complete the test (RX copay or means test) 
 ;based on the Test Determined Status, or will change the status to
 ;Required for means tests or Incomplete for Rx copay tests
 ;Input:
 ;  DGMTI - the ien of the test
 ;Output:
 ;  Function value - 1 if the test was completed, 0 otherwise
 N NODE0,NODE2,DATA,RET,LINKIEN,DGINR,DGINI,ERROR,CODE,TYPE,DFN,TDATE
 S RET=0
 Q:'$G(DGMTI) RET
 S NODE0=$G(^DGMT(408.31,DGMTI,0))
 Q:(NODE0="") RET
 S TYPE=$P(NODE0,"^",19)
 S DFN=$P(NODE0,"^",2)
 S TDATE=+NODE0
 S NODE2=$G(^DGMT(408.31,DGMTI,2))
 ;get test-determined status code
 S CODE=$$GETCODE^DGMTH($P(NODE2,"^",3))
 ;if means test
 I TYPE=1 D
 .S DATA(.03)=$$GETSTAT^DGMTH("R",1),DATA(.17)=""
 .I (CODE'=""),"ACGP"[CODE D
 ..S RET=1
 ..S DATA(.03)=$P(NODE2,"^",3)
 ..;determine status if there is a hardship
 ..I $P(NODE0,"^",20) D
 ...S DATA(.03)=$$GETSTAT^DGMTH($S(CODE="P":"P",CODE="C"&($P(NODE0,U,27)>$P(NODE0,U,12)):"G",1:"A"),1)
 .I (CODE="")!(CODE'=""&"ACGP"'[CODE) D
 ..; Check for another test in the current year and convert IAI records, if needed
 ..S CONVRT=$$VRCHKUP^DGMTU2(1,,TDATE)
 ..S DATA(2.11)=1
 ;RX copay test
 I TYPE=2 D
 .S DATA(.03)=$$GETSTAT^DGMTH("I",2),DATA(.17)=""
 .I (CODE'=""),"EM"[CODE D
 ..S RET=1
 ..S DATA(.03)=$P(NODE2,"^",3)
 .I (CODE="")!(CODE'=""&"EM"'[CODE) D
 ..; Check for another test in the current year and convert IAI records, if needed
 ..S CONVRT=$$VRCHKUP^DGMTU2(2,,TDATE)
 ..S DATA(2.11)=1
 I '$$UPD^DGENDBS(408.31,DGMTI,.DATA,.ERROR) W:'$G(DGMSGF) ERROR
 ;restore the pointers from the Income Relation file (408.22) to this
 ;test, using the linked test
 S LINKIEN=$P(NODE2,"^",6)
 I LINKIEN D
 .S DGINI=0 F  S DGINI=$O(^DGMT(408.22,"AMT",LINKIEN,DFN,DGINI)) Q:'DGINI  S DGINR=$O(^DGMT(408.22,"AMT",LINKIEN,DFN,DGINI,"")) I $P($G(^DGMT(408.22,+DGINR,"MT")),"^")]"" D
 ..K DATA
 ..S DATA(31)=DGMTI
 ..I $$UPD^DGENDBS(408.22,+DGINR,.DATA)
 D GETINCOM^DGMTU4(DFN,TDATE)
 Q RET
NOL ;Update means test status to NO LONGER REQUIRED
 N DGMTA,DGINI,DGINR,DGMTDT,DATA
 I $G(DGNOIVMUPD),$$IVMCVT^DGMTCOR(DGMTI) D  G NOLQ ; Check for converted IVM MT
 . ;I '$G(DGMSGF),$G(DGNOIVMUPD)<2 W !,"IVM MEANS TEST EXISTS, BUT VISTA CALCULATES 'NO LONGER REQUIRED'",!,"CONTACT IVM TO CLEAR UP THE DISCREPANCY - YOU CANNOT UPDATE AN IVM TEST"
 . S DGNOIVMUPD=2 ; Prevent double printing of the message
 W:'$G(DGMSGF) !,"MEANS TEST NO LONGER REQUIRED"
 ;may have set prior MT for means test upload
 I $G(MTPRIME)'="DGMTU4" N DGMTP,DGMTACT S DGMTACT="STA" D PRIOR^DGMTEVT
 ;save the Test Determined Status
 D SAVESTAT^DGMTU4(DGMTI)
 S DATA(.03)=3,DATA(.17)=DT I $$UPD^DGENDBS(408.31,DGMTI,.DATA)
 D QUE
 ;create a Rx copay test based on MT if needed
 D COPYRX^DGMTR1(DFN,DGMTI)
NOLQ Q
SET ;Set Cross-reference
 N D0,DA,DIV,DGIX,X
 S DA=DGIEN,X=DGVAL,DGIX=0
 F  S DGIX=$O(^DD(DGFL,DGFLD,1,DGIX)) Q:'DGIX  X ^(DGIX,1) S X=DGVAL
 Q
KILL ;Kill Cross-reference
 N D0,DA,DIV,DGIX,X
 S DA=DGIEN,X=DGVAL,DGIX=0
 F  S DGIX=$O(^DD(DGFL,DGFLD,1,DGIX)) Q:'DGIX  X ^(DGIX,2) S X=DGVAL
 Q
QUE ;Queue means test event driver
 D AFTER^DGMTEVT
 S ZTDESC="MEANS TEST EVENT DRIVER",ZTDTH=$H,ZTRTN="EN^DGMTEVT"
 F I="DFN","DGMTACT","DGMTI","DGMTP","DGMTA","DGMTYPT" S ZTSAVE(I)=""
 S ZTSAVE("DGMTINF")=1
 I $D(IVMZ10) S ZTSAVE("IVMZ10")=""
 I $D(DGENUPLD) S ZTSAVE("DGENUPLD")=""
 S ZTIO="" D ^%ZTLOAD
 K ZTDESC,ZTDTH,ZTIO,ZTRTN,ZTSAVE,ZTSK
 Q
SELIG ;Check if secondary eligibility code missing from ELIGIBILITY CODE
 ;file (#8) or entry in file #8 not pointing to MAS ELIGIBILITY
 ;CODE file (#8.1)
 N DGTXT
 S DGF=$G(^DIC(8,+DG,0)) I DGF="" D  Q
 .S DGTXT(4)="Entry with an IEN OF "_DG_" missing from"
 .S DGTXT(5)="the ELIGIBILITY CODE file (#8)"
 .D MAIL^DGMTR1
 .Q
 S DGF=$P(DGF,"^",9) I DGF=""!('$D(^DIC(8.1,+DGF,0))) D
 .S DGTXT(4)="ELIGIBILITY CODE file (#8) entry with an IEN OF "_DG_" doesn't"
 .S DGTXT(5)="have a valid pointer to the MAS ELIGIBILITY CODE file (#8.1)"
 .D MAIL^DGMTR1
 .S DGF=""
 .Q
 Q
