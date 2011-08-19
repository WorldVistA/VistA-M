DGMTA ;ALB/RMO/CAW/LD/SCG/AEG/PHH - Add a New Means Test ; 2/24/10 2:58pm
 ;;5.3;Registration;**33,45,137,166,177,182,290,344,332,433,458,535,612,564,688,661**;Aug 13, 1993;Build 5
 ;
EN ;Entry point to add a new means test
 N DGMDOD S DGMDOD=""
 S DGADDF=1
 I $D(DGMTDFN)#2 D UNLOCK^DGMTUTL(DGMTDFN) K DGMTDFN
 S DIC="^DPT(",DIC(0)="AEMQ" W ! D ^DIC K DIC G Q:Y<0 S (DFN,DGMTDFN)=+Y
 I $P($G(^DPT(DFN,.35)),U)'="" S DGMDOD=$P(^DPT(DFN,.35),U)
 I $G(DGMDOD) W !,"Patient died on: ",$$FMTE^XLFDT(DGMDOD,"1D") Q
 ;
 ; check if income test in progress
 D CKUPLOAD^IVMCUPL(DFN)
 ;
 ; obtain lock used to synchronize local MT/CT options with income test upload
 I $$LOCK^DGMTUTL(DFN)
 ;
 I DGMTYPT=1 N DGDOM1 D EN^DGMTR I 'DGREQF,'$G(DGDOM1) W !,*7,"A means test can only be added for patients who require one.",! K DGDOM1 G EN
 ;
 N FUTMT S FUTMT=$$FUT^DGMTU(DFN,"",DGMTYPT) I FUTMT D FTST G EN
 ;
 ;if a test was auto-completed, DGADDF gets set to 0
 I 'DGADDF W !!,*7,"A means test already exists and is in effect" G EN
 ;
 K:DGMTYPT=1 DGDOM1
 I DGMTYPT=2 D EN^DGMTCOR I 'DGMTCOR S I=$P($T(WHY+DGWRT),";",3,99) W !!,*7,"A copay exemption test can only be added for applicable veterans.",!,I G EN
 S DGLDT=$$LST^DGMTU(DFN,"",DGMTYPT),DGLD=$P(DGLDT,U,2),DGLDYR=$E(DGLD,1,3)_"1231"
 ;
DT S %DT("A")="DATE OF TEST: ",%DT="AEX",%DT(0)="-NOW",%DT("B")="NOW" W ! D ^%DT K %DT G Q:Y<0 S DGMTDT=Y
 I DGMTDT<$S(DGMTYPT=1:2860701,1:2921029) W !?3,*7,"The date of test cannot be before "_$S(DGMTYPT=1:"7/1/1986.",1:"10/29/1992.") G DT
 I DGLD,DGMTDT<DGLD W !?3,*7,"The date of test cannot be before the last date of test on " S Y=DGLD X ^DD("DD") W Y,"." G DT
 I DGLD S X1=DGMTDT,X2=DGLD D ^%DTC I X<365,DGMTDT'>DGLDYR D  G EN
 .W !?3,*7,"An annual date of test already exists on " S Y=DGLD X ^DD("DD") W Y,"."
 .S DGTTYP=$S(DGMTYPT=1:"Means ",1:"Copay Exemption ")
 .W !,$S($P($G(^DG(408.34,+$P($G(^DGMT(408.31,+DGLDT,0)),U,23),0)),U)="VAMC":"   Use the 'Edit an Existing "_DGTTYP_"Test' Option.",1:"   Use the 'View a Past Means Test' Option.")
 ;
 ;Means Test cannot be added for patient on a DOM ward on date of test
 I DGMTYPT=2 G PRINT
 N VAINDT,VADMVT,DGDOM,DGDOM1
 S VAINDT=DGMTDT
 D DOM1^DGMTR I $G(DGDOM1) D  K VAINDT,VADMVT,DGDOM,DGDOM1 G EN
 .W !,*7,"A Means Test cannot be added for patients on a DOM ward on date of test.",!
 K VAINDT,VADMVT,DGDOM,DGDOM1
 ;
 ;A warning message is displayed if last means test for patient is
 ;from a prior year and has a status of required.  The user is given
 ;the option to continue or stop adding a new means test.
 N %
 I DGLD,DGMTDT>DGLDYR,$P(DGLDT,"^",4)="R" D  Q:%=-1  I %=2 K % G EN
 .W !?3,*7,"WARNING - last means test on " S Y=DGLD X ^DD("DD") W Y," has a status of required."
DT2 .W !?3,"Do you still want to continue adding new test"
 .S %=2 D YN^DICN
 .I %=0 W !?3,"Answer 'Y'es to continue adding new test." G DT2
 .Q 
 K %
 ;
PRINT I "^P^A^C^G^"[(U_$P(DGLDT,U,4)_U) S %=1 W !,"Do you wish to print the prior means test" D YN^DICN G:%=-1 Q I %Y["?" W !!,"This will print the prior means test information.",! G PRINT
 I $G(%)=1 S DGX=DGMTDT,DGMTDT=DGLD,DGMTI=+DGLDT,DGOPT="" D DEV^DGMTP,CLOSE^DGUTQ S DGMTDT=DGX K DGX
 D ADD G EN:DGMTI<0
 S DGMTACT="ADD",DGMTROU="EN^DGMTA" G EN^DGMTSC
 ;
Q K DA,DFN,DGADDF,DGBL,DGFL,DGFLD,DGIRO,DGLD,DGLDT,DGLDYR,DGMTACT,DGMTCOR,DGMTDT,DGMTI,DGMTROU,DGREQF,DGTTYP,DGMTYPT,DGVI,DGVO,X,X1,X2,Y
 ;
 ; release lock used to synchronize local MT/CT options with income test upload
 I $D(DGMTDFN)#2 D UNLOCK^DGMTUTL(DGMTDFN) K DGMTDFN
 Q
 ;
ADD ;Add means test
 ; Input  -- DFN     Patient IEN
 ;           DGMTDT  Date
 ;           DGMTYPT Type of Test 1=MT 2=COPAY 4=LTC
 ; Output -- DGMTI   Annual Means/Copay/LTC Test IEN
 N DA,DD,DIC,DIK,DINUM,DLAYGO,DO,DS,X,D0,DGSITE,CONVRT,CURIEN,LINK,DGLNKMT
 ;
 ; obtain lock used to synchronize local MT/CT options with income test upload
 I $$LOCK^DGMTUTL(DFN) E  Q
 ;
 ; Check for Linked test and don't lose the link.
 S LINK="",DGLNKMT=$$LST^DGMTU(DFN,DGMTDT,DGMTYPT),CURIEN=+DGLNKMT
 I CURIEN D
 . ;Don't link test if it's in a different year (DG*5.3*661)
 . I $E($P(DGLNKMT,U,2),1,3)'=$E(DGMTDT,1,3) Q
 . S LINK=$P($G(^DGMT(408.31,CURIEN,2)),U,6)
 ;
 S DGSITE=$$GETSITE^DGMTU4(.DUZ)
 S X=DGMTDT,(DIC,DIK)="^DGMT(408.31,",DIC(0)="L",DLAYGO=408.31
 ;
 ;Look for existing IAI records and convert (if necessary)
 D ALL^DGMTU21(DFN,"VSD",DT,"IPR") ;ALL only returns IAI from last IY
 I $D(DGINC) DO
 . D ISCNVRT^DGMTUTL(.DGINC)
 ;
 ; The DIC("DR") string is built in this specific order so that
 ; all triggers and "M" x-refs fire correctly.  Should not be
 ; modified without an in-depth review of DD of file #408.31.
 ;
 I DGMTYPT=2 D
 .S DIC("DR")="2////"_(DGMTYPT'=4)_";2.05////"_DGSITE_";2.06////"_LINK
 .S DIC("DR")=DIC("DR")_";.02////"_DFN_";.019////"_DGMTYPT_";.23////1"
 E  D
 .S DIC("DR")="2////"_(DGMTYPT'=4)_";2.05////"_DGSITE_";2.06////"_LINK
 .S DIC("DR")=DIC("DR")_";.019////"_DGMTYPT_";.02////"_DFN_";.23////1"
 K DD,DO
 D FILE^DICN S DGMTI=+Y
 ;
 ; Check for another test in the current year and convert IAI records if needed
 ; Send new test date (as test that have) into VRCHKUP
 I $D(TYPE),((+TYPE=1)!(TYPE=4)) S CONVRT=$$VRCHKUP^DGMTU2(DGMTYPT,TYPE,DGMTDT)
 I $D(TYPE),((+TYPE'=1)&(TYPE'=4)) S CONVRT=$$VRCHKUP^DGMTU2(DGMTYPT,,DGMTDT)
 I '$D(TYPE) S CONVRT=$$VRCHKUP^DGMTU2(DGMTYPT,,DGMTDT)
 N DGERR,DGMTRT
 S DGMTRT(408.31,DGMTI_",",2.11)=1
 S DGERR=""
 D FILE^DIE("","DGMTRT",DGERR)
 ; release lock used to synchronize local MT/CT options with income test upload
 D UNLOCK^DGMTUTL(DFN)
 ;
ADDQ Q
 ;
FTST ; Build message for future tests that are added to the system, but
 ; were not performed by the VAMC trying to add a new MT.
 N SITE,DGMTYPT,DGTTYP,SRC,SCT
 S SCT=$P(^DGMT(408.31,+FUTMT,2),U,5),SITE=$$INST^DGENU()
 S DGMTYPT=$P(^DGMT(408.31,+FUTMT,0),U,19)
 S DGTTYP=$S(DGMTYPT=1:"Means ",1:"Copay Exemption ")
 W !?3,*7,"A future test already exists on "
 S Y=$P(FUTMT,U,2) X ^DD("DD") W Y,"."
 ; This site performed the MT
 I SITE=SCT D
 .W !?3,"Use the 'Edit an Existing "_DGTTYP_"Test' Option."
 ;
 ; The MT was added by another VAMC
 I SITE'=SCT D
 .S SRC=$P(FUTMT,U,5)
 .I SCT W !?3,"The "_DGTTYP_"Test was conducted at Site: ",SCT
 .W !?3,"Please contact "
 .W $S($D(^DIC(4,+SCT,0)):$P(^DIC(4,+SCT,0),U),SRC=2:"IVM",SRC=3:"the HEC",1:"the site")
 .W ",",!?3,"if it is necessary to edit the test."
 Q
WHY ;Why Copay Test cannot be added
 ;;Patient is not a veteran.
 ;;Patient does not have a Primary Eligibility Code.
 ;;Patient is Service Connected 50-100%.
 ;;Means Test options must be used instead of Copay options.
 ;;Patient is receiving Aid and Attendance, automatically exempted.
 ;;Patient is receiving Housebound Benefits, automatically exempted.
 ;;Patient is receiving a VA Pension, automatically exempted.
 ;;Patient is in a DOM ward, automatically exempted.
 ;;Patient is an inpatient, automatically exempted.
 ;;Patient was a POW, automatically exempted.
 ;;Patient is Unemployable, automatically exempted.
