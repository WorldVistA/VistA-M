EASECMT ;ALB/LBD - Means Test for LTC Co-Pay exemption ; 27 DEC 2001
 ;;1.0;ENROLLMENT APPLICATION SYSTEM;**7,16,18,70,88**;Mar 15, 2001;Build 3
 ;
EN ; This is the entry point for the routine that will find the 
 ; financial test for a veteran that can be used to check if
 ; veteran's income is below the threshold and exempt from LTC
 ; co-payments.  If a financial test is not on file for the veteran
 ; it can be added through this process.
 ;  Input --      DFN = Patient IEN
 ;  Output --     DGEXMPT = 1 (exempt from LTC co-payments)
 ;                        = 0 or "" (not exempt from LTC co-payments)
 ;                DGOUT = 1 (user wants to exit from the process) 
 N DGCMPLT,DGMTI,DGMTDT,DGMTYPT,DGMTACT,DGL,DGCS,DGMSGF,DGREQF,DGDOM,DGDOM1,Y
 ; Does veteran have current LTC co-pay exemption test (type 4)?
 S Y=$$GETLTC4(DFN) I Y S DGEXMPT=$S($P(Y,U,3)="EXEMPT":1,1:0) Q
 ; Does veteran have current means test?
 S DGL=$$LST^DGMTU(DFN),DGMTI=+DGL,DGMTDT=$P(DGL,U,2),DGCS=$P(DGL,U,4)
 ; If last means test has status of Cat C or Pend. Adj. and vet agreed
 ; to pay MT copay, new means test is not required
 I ((DGCS="C")!(DGCS="P")),$P($G(^DGMT(408.31,DGMTI,0)),U,11)=1,DGMTDT>2991005 S DGEXMPT=0 D LTC4(DGMTI,DGEXMPT) Q
 ; If means test is required or more than a year old, do new means test
 I (DGCS="R")!($$OLD^DGMTU4(DGMTDT)) D  Q:$G(DGOUT)!(DGMTYPT=4)
 .S (DGADDF,DGMSGF)=1 D ^DGMTR S DGMTYPT=$S(DGREQF:1,1:4)
 .I '$$ASK(DGMTYPT) S DGOUT=1 Q
 .S DGMTACT="ADD" I DGMTYPT=1,$E(DGMTDT,1,3)=$E(DT,1,3) S DGMTACT="EDT"
 .D MT(DFN,DGMTYPT,DGMTACT,.DGMTI,.DGCMPLT)
 .I '$G(DGCMPLT) S DGOUT=1 Q
 .I DGMTYPT=4 D
 ..D DOM^DGMTR I '$G(DGDOM1) D COPYRX^DGMTR1(DFN,DGMTI)
 ..S Y=$$GETCODE^DGMTH($P($G(^DGMT(408.31,DGMTI,0)),U,3)),DGEXMPT=$S(Y=0:1,1:0)
 ; If no means test or means test is no longer required, check if
 ; there is an RX co-pay test, otherwise do new LTC co-pay exemption test
 I DGCS=""!(DGCS="N") D  Q:$G(DGOUT)!($G(DGMTYPT)=4)
 .S DGL=$$LST^DGMTU(DFN,DT,2),DGMTI=+DGL,DGMTDT=$P(DGL,U,2),DGCS=$P(DGL,U,4)
 .I DGMTI,'$$OLD^DGMTU4(DGMTDT),("^I^L^")'[("^"_DGCS_"^") Q
 .S DGMTYPT=4
 .I '$$ASK(DGMTYPT) S DGOUT=1 Q
 .D MT(DFN,DGMTYPT,"ADD",.DGMTI,.DGCMPLT)
 .I '$G(DGCMPLT) S DGOUT=1 Q
 .D DOM^DGMTR I '$G(DGDOM1) D COPYRX^DGMTR1(DFN,DGMTI)
 .S Y=$$GETCODE^DGMTH($P($G(^DGMT(408.31,DGMTI,0)),U,3))
 .S DGEXMPT=$S(Y=0:1,1:0)
 ; Check if veteran's income is below the pension threshold
 S DGEXMPT=$$THRES(DFN,DGMTDT)
 I DGEXMPT<0 W !!,"The income threshold check could not be completed due to an error." S DGOUT=1 Q
 ; Create LTC co-pay exemption test (type 4) by copying MT
 D LTC4(DGMTI,DGEXMPT)
 Q
 ;
THRES(DFN,DGMTDT) ; Is veteran's income below the pension threshold
 ; Input   -  DFN = Patient IEN
 ;            DGMTDT = Test date
 ; Output  -   = 1 (Below the threshold)
 ;             = 0 (Above the threshold)
 ;             = -1(Error)
 N DGDC,DGDEP,DGDET,DGERR,DGIN0,DGIN1,DGIN2,DGINI,DGINT,DGINTF,DGIRI
 N DGNC,DGND,DGNWT,DGNWTF,DGPRI,DGSP,DGVINI,DGVIR0,DGVIRI,DGTHRES
 N DGLY,DGMTPAR
 ; Get current single veteran pension threshold amount
 S DGTHRES=$$THRES^IBARXEU1(DGMTDT,1,0) I '+DGTHRES Q -1
 ; Calculate veteran's income level and check against the threshold
 S DGPRI=$O(^DGPR(408.12,"C",DFN_";DPT(",0)) I 'DGPRI Q -1
 D GETIENS^DGMTU2(DFN,DGPRI,DGMTDT) I '$G(DGIRI),'$G(DGINI) Q -1
 S DGVIRI=DGIRI,DGVINI=DGINI
 S DGLY=$$LYR^DGMTSCU1(DGMTDT) D PAR^DGMTSCU
 D DEP^DGMTSCU2,INC^DGMTSCU3 I '$D(DGINT) Q -1
 ; If vet declined to provide financial info, return 0 (above threshold)
 I $P($G(^DGMT(408.31,+$G(DGMTI),0)),U,14) Q 0
 I (DGINT-DGDET)'>+DGTHRES Q 1
 Q 0
 ;
MT(DFN,TYPE,ACT,DGMTI,DGCMPLT) ; Complete a means test or LTC co-pay exemption test
 ; Input    -  DFN = Patient IEN
 ;             TYPE = Type of test (1=MT; 4=LTC4)
 ;             ACT = Type of action (ADD or EDT)
 ;             DGMTI = If EDT action, IEN of test to be edited
 ; Output   -  DGCMPLT = 1 (MT completed)
 ;                     = 0 (MT not completed)
 ;             DGMTI = IEN of new test
 N DGMTYPT,DGMTACT,DGMTROU,DGMT0,DGSTA,TYPESAVE,DGCMPLT
 S DGCMPLT=0
 I $$LOCK^DGMTUTL(DFN) E  Q DGCMPLT
 S DGMTYPT=TYPE,DGMTACT=ACT
 S TYPESAVE=TYPE ;*GTS - EAS*1*70
 S DGMTDT=$S(DGMTACT="EDT":+$G(^DGMT(408.31,DGMTI,0)),1:DT) I 'DGMTDT D MT1 Q
 ;*GTS - EAS*1*70
 ; If adding a LTC CP Exemption test, TYPE indicates test copied from for ADD^DGMTA
 I DGMTACT="ADD" S:TYPE=4 TYPE=1 D ADD^DGMTA S TYPE=TYPESAVE I '$G(DGMTI) D MT1 Q
 S DGMTROU="MT1^EASECMT"
 G EN^DGMTSC
MT1 I $G(DGMTI) D
 .S DGMT0=$G(^DGMT(408.31,DGMTI,0)),DGSTA=$$GETCODE^DGMTH($P(DGMT0,U,3))
 .I DGSTA'="","ACP01"[DGSTA,$P(DGMT0,U,7)]"" S DGCMPLT=1
 .I 'DGCMPLT,TYPE=4 D DEL  ;Delete incomplete LTC copay exemption test
 D UNLOCK^DGMTUTL(DFN)
 Q
 ;
LTC4(DGMT,DGEXMPT) ; Create or update LTC copay exemption test (type 4) by copying
 ; means test
 ; Input   -   DGMT = Annual Means Test IEN of test to be copied
 ;         -   DGEXMPT = LTC copayments exemption status (optional)
 Q:'DGMT
 N DGMT0,DGMT2,DA,DIC,DIK,DLAYGO,X,DFN,DGMTI,DGCONVRT
 N DGMTA,DGMTP,DGMTACT,DGMTINF,DGMTYPT
 ; Quit if this is a LTC copay exemption test (type 4)
 S DGMT0=$G(^DGMT(408.31,DGMT,0)) I $P(DGMT0,U,19)=4 Q
 S DGMT2=$G(^DGMT(408.31,DGMT,2))
 ; Add a new LTC 4 test or edit an existing LTC 4 test?
 S DGMTI=$O(^DGMT(408.31,"AT",DGMT,0))
 S DGMTACT=$S(DGMTI:"EDT",1:"ADD")
 S DGMTP="" I DGMTACT="EDT" S DGMTP=$G(^DGMT(408.31,DGMTI,0))
 S DFN=$P(DGMT0,U,2)
 ; Add new entry to Annual Means Test file (#408.31) for LTC 4 test
 I DGMTACT="ADD" D  Q:DGMTI'>0
 .S X=+DGMT0,(DIC,DIK)="^DGMT(408.31,",DIC(0)="L",DLAYGO=408.31
 .D FILE^DICN S DGMTI=+Y
 .;*GTS - EAS*1*70
 .S DGCONVRT=$$VRCHKUP^DGMTU2(4,$P(DGMT0,"^",19),+DGMT0,+DGMT0)
 .S DATA(2.11)=1
 F I=.01,.02,.04,.05,.06,.11,.14,.15,.18,.23 S DATA(I)=$P(DGMT0,U,(I/.01))
 I '$D(DGEXMPT) S DGEXMPT=$$THRES(DFN,$P(DGMT0,U,1))
 S DATA(.03)=$S(DGEXMPT:15,1:14),DATA(.07)=DT
 S DATA(.019)=4,DATA(2.02)=$P(DGMT2,U,2),DATA(2.08)=DGMT
 S DATA(2.05)=$P(DGMT2,U,5)
 I $$UPD^DGENDBS(408.31,DGMTI,.DATA,.ERROR)
 K DATA,ERROR
 ; Update the LTC copay test (type 3), if status changed
 I DGMTACT="EDT" D UPLTC3(DGMTI)
 ; Update Audit file and IVM Patient file
 S DGMTYPT=4,DGMTINF=1 D AFTER^DGMTEVT
 D EN^DGMTAUD
 D EN^IVMPMTE
 Q
 ;
ASK(TYPE) ; Does user want to perform MT/LTC4 test now?
 ; Input   -   TYPE = Type of test, 1: MT; 4: LTC Copay Exemption
 ; Output  -   Y = 1 (YES)
 ;               = 0 (NO)
 N DIR,TST
 S TST=$S(TYPE=1:"Means Test",1:"LTC Copay Exemption Test")
 W !!,"The previous year's financial information is not on file for this veteran.",!,"A ",TST," is required."
 S DIR("A")="Do you wish to complete the "_TST_" at this time"
 S DIR("B")="NO",DIR(0)="Y"
 W ! D ^DIR
 Q +(Y)
 ;
GETLTC4(DFN,DGMTDT) ; Return last LTC co-pay exemption test (type 4),
 ; if less than a year old
 ; Input   -   DFN = Patient IEN
 ;             DGMTDT (optional) = Date of test
 ; Output  -   Y = Annual Means Test IEN^Date of Test^Status Name^
 ;                    Status Code^Source of Test
 ;               = "" (no current LTC co-pay exemption test)
 N Y
 S Y="" Q:'$G(DFN) Y I '$G(DGMTDT) S DGMTDT=DT
 S Y=$$LST^DGMTU(DFN,DGMTDT,4) I '(+Y) Q Y
 I $$OLD^DGMTU4($P(Y,U,2)) S Y=""
 Q Y
 ;
DEL ;Delete incomplete LTC Copay Exemption test (type 4)
 ; Input   -- DGMTI  LTC Copay Exemption test IEN
 N DA,DIK,DIE,DR,V
 Q:'$G(DGMTI)  Q:$P($G(^DGMT(408.31,DGMTI,0)),U,19)'=4
 ; Delete pointer in Income Relation file (#408.22)
 I $D(^DGMT(408.22,"AMT",DGMTI)) D
 .S DIE="^DGMT(408.22,",DR="31///@"
 .S V=$O(^DGMT(408.22,"AMT",DGMTI,0)) Q:'V
 .S IR=0 F  S IR=$O(^DGMT(408.22,"AMT",DGMTI,V,IR)) Q:'IR  S DA=$O(^(IR,0)) I DA D ^DIE
 ; Delete LTC Copay Exemption test from Annual Means Test file (#408.31)
 S DA=DGMTI,DIK="^DGMT(408.31,"
 D ^DIK
 Q
 ;
UPLTC3(DGMT4) ;If the status of a LTC Copay Exemption test (type 4) changes,
 ;update the status of the LTC Copay test (type 3), if necessary
 ;  Input   -- DGMT4  LTC Copay Exemption test IEN
 N DGMT3,DGMTS4,DGMTS3,DGS,DATA,ERROR
 Q:'DGMT4
 S DGMT3=$O(^DGMT(408.31,"AT",DGMT4,0)) Q:$G(^DGMT(408.31,+DGMT3,0))=""
 ; Get test status
 S DGMTS4=$$GETNAME^DGMTH($P(^DGMT(408.31,DGMT4,0),U,3))
 S DGMTS3=$$GETNAME^DGMTH($P(^DGMT(408.31,DGMT3,0),U,3))
 ; If test status is the same quit
 I DGMTS4=DGMTS3 Q
 ; If LTC copay test (type 3) is Exempt and the Reason for Exemption is
 ; anything other than 2 (Income Last Year Below Threshold), quit
 I DGMTS3="EXEMPT",$P($G(^DGMT(408.31,DGMT3,2)),U,7)'=2 Q
 ; Get IEN of Means Test Status and update LTC copay test
 S DGS="" F  S DGS=$O(^DG(408.32,"B",DGMTS4,DGS)) Q:'DGS  I $P(^DG(408.32,DGS,0),U,19)=3 Q
 S DATA(.03)=DGS,DATA(2.07)=$S(DGMTS4="EXEMPT":2,1:"@")
 I $$UPD^DGENDBS(408.31,DGMT3,.DATA,.ERROR)
 Q
