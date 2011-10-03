PRSASR1 ;WCIOFO/JAH - Display VCS, Fee, ED ;02/20/08
 ;;4.0;PAID;**6,21,82,93,116**;Sep 21, 1995;Build 23
 ;;Per VHA Directive 2004-038, this routine should not be modified.
VCS ; Display VCS Sales/Fee Basis
 ;
 N OLDPP
 S PAYP=$P($G(^PRSPC(DFN,0)),"^",21)
 ; Check the pay plan for the pay period we are dealing with
 ; in case it's a previous pay period where an employee
 ; had a different pay plan.
 ;  1st put pay period in YY-PP format 4 call 2 lookup old pay plan.
 ;Only check if called from option Display employee pay period PPERIOD
 ;will be defined.
 I $G(PPERIOD) D
 .;S PPERIOD=$S(Y["-":$P(Y,"^",2),1:$P(^PRST(458,$P(Y,"^"),0),"^"))
 .S OLDPP=$$OLDPP^PRS8UT(PPERIOD,DFN)
 .I OLDPP'=0,(OLDPP'=PAYP) D
 .. S PAYP=OLDPP
 .. W !,"Employee is NOT currently under this pay plan."
 ;
 W !!?30,$S(PAYP="F":"Fee Basis Appointee",1:"VCS Commission Sales")
 W !!?13,"Sun       Mon       Tue       Wed       Thu       Fri       Sat",!
 W !,"Week 1" S L1=1 F K=1:1:7 S L1=L1+10,Z1=$P(Z,"^",K) I Z1'="" W ?L1,$J(Z1,7,2)
 W !,"Week 2" S L1=1 F K=8:1:14 S L1=L1+10,Z1=$P(Z,"^",K) I Z1'="" W ?L1,$J(Z1,7,2)
 I PAYP="F" W !! F K=19:1:21 S Z1=$P(Z,"^",K) W "Total ",$P("Hours Days Procedures"," ",K-18),": ",Z1,"    "
 Q
ED ; Display Envir. Diff.
 W !!?26,"Environmental Differentials",!
 S Y="" F K=1:2:5 S Z1=$P(Z,"^",K) Q:'Z1  S:Y'="" Y=Y_"; " S Y=Y_$P($G(^PRST(457.6,+Z1,0)),"^",1)_" "_$P(Z,"^",K+1)_" Hrs."
 I Y'="" W !,"Week 1: ",Y
 S Y="" F K=7:2:11 S Z1=$P(Z,"^",K) Q:'Z1  S:Y'="" Y=Y_"; " S Y=Y_$P($G(^PRST(457.6,+Z1,0)),"^",1)_" "_$P(Z,"^",K+1)_" Hrs."
 I Y'="" W !,"Week 2: ",Y
 Q
 ;
LD ; Display changes to the Labor Distribution Codes within the Pay
 ; Period.
 ;
 N DASH,DESC,IENS,LDCC,LDCCB,LDCCEX,LDCODE,LDCNT,LDDOA,LDFCP
 N LDHOLD,LDPCT,LDTOI,PRSLD,Y
 S $P(DASH,"-",80)=""
 W !
 D LDHOLD
 W !,"Current Labor Distribution Values:"
 S LDDOA=$$GET1^DIQ(450,DFN,756,"E")
 S LDCCB=$$GET1^DIQ(450,DFN,755,"E")
 S LDTOI=$$GET1^DIQ(450,DFN,755.1,"E")
 W !,LDDOA,?24,LDCCB,?61,LDTOI
 F PRSLD=1:1:4 D
 . S LDCODE=$$GET1^DIQ(450.0757,PRSLD_","_DFN,1)
 . S LDPCT=$$GET1^DIQ(450.0757,PRSLD_","_DFN,2)
 . S LDCC=$$GET1^DIQ(450.0757,PRSLD_","_DFN,3)
 . S Y=LDCC,SUB454="CC"
 . D OT^PRSDUTIL K SUB454
 . S LDCCEX=$E(Y,1,30)
 . S LDFCP=$$GET1^DIQ(450.0757,PRSLD_","_DFN,4)
 . W !,"Code",PRSLD,": ",LDCODE,?12,LDPCT,?24,LDCC," - ",LDCCEX,?70,LDFCP
 ;
 W !!,"The previous Labor Distribution Values:"
 S LDCNT="A"
 S LDCNT=$O(^PRST(458,PPI,"E",DFN,"LDAUD",LDCNT),-1)
 Q:'LDCNT
 S IENS=LDCNT_","_DFN_","_PPI_","
 S LDDOA=$$GET1^DIQ(458.1105,IENS,1,"E")
 S LDCCB=$$GET1^DIQ(458.1105,IENS,2,"E")
 S LDTOI=$$GET1^DIQ(458.1105,IENS,3,"E")
 W !,LDDOA,?24,LDCCB,?61,LDTOI
 F PRSLD=1:1:4 D
 . S IENS=PRSLD_","_LDCNT_","_DFN_","_PPI_","
 . S LDCODE=$$GET1^DIQ(458.11054,IENS,1)
 . S LDPCT=$$GET1^DIQ(458.11054,IENS,2)
 . S LDCC=$$GET1^DIQ(458.11054,IENS,3)
 . S Y=LDCC,SUB454="CC"
 . D OT^PRSDUTIL K SUB454
 . S LDCCEX=$E(Y,1,30)
 . S LDFCP=$$GET1^DIQ(458.11054,IENS,4)
 . W !,"Code",PRSLD,": ",LDCODE,?12,LDPCT,?24,LDCC," - ",LDCCEX,?70,LDFCP
 Q
 ;
LDHDR ; Labor Distribution Header information
 ;
 W !?15,"Labor Distribution Changes within the Pay Period:"
 W !,"Date/Time",?24,"Changed by",?61,"Type of Interface"
 W !,"Code",?12,"Percent",?24,"Cost Center - Description"
 W ?65,"Fund Ctrl Pt"
 W !,DASH
 Q
 ;
LDHOLD ; Pause of more LD changes that will fit on 1 screen.
 ;
 N X
 S LDHOLD=$$ASK^PRSLIB00(1)
 S X=$G(^PRSPC(DFN,0))
 W !,@IOF,?3,$P(X,"^",1)
 S X=$P(X,"^",9)
 I X W ?68,$E(X),"XX-XX-",$E(X,6,9)
 W !,DASH
 D LDHDR
 Q
 ;
PTP(PRSIEN,PPI) ; Updates hours credited for PT Phys w/ Memorandums
 ; This API can be used for initial and subsequent calculation
 ; of the PTP's ESR.
 ;    algorithm for this API follows:
 ; 1. Grab copy of currently stored pay period hours
 ; 2. Look at ESR/timecard data to recalculate pay period hours
 ; 3. Calculate net difference between 1 and 2
 ; 4. update current pay period with new pp totals from (2) above
 ; 5. add net diff (3) to memo totals
 ;
 N AHRS,AHTCM,AMT,COHRS,DIFFNP,DIFFRG,DIFFWP,INPH,ITHP,ITHW,IWPH
 N MDAT,MDATA,MEAL,MIEN,MPPIEN,POHC,POT,PPC,PPE
 N PPHRS,PPNP,PPWP,PRSX,START,STOP,THP,TOT,TOTAL,TOTNP,TOTWP
 S MDAT=$P($G(^PRST(458,PPI,1)),U,1)
 S MIEN=+$$MIEN^PRSPUT1(PRSIEN,MDAT)
 Q:'MIEN  ; Not a PTP w/ memo
 S PPE=$P($G(^PRST(458,PPI,0)),U,1)
 ;
 ; Locate this PP in the PTP's memorandum
 S MPPIEN=$O(^PRST(458.7,MIEN,9,"B",PPE,0))
 Q:'MPPIEN  ; PP not found within memo (###exception message)
 ;
 ;get the current values for this pay period under the memo.
 S PRSX=$G(^PRST(458.7,MIEN,9,MPPIEN,0))
 S PPHRS=+$P(PRSX,U,2) ; Actual hours of work credited
 S PPNP=+$P(PRSX,U,3)  ; Actual hours of Non Pay
 S PPWP=+$P(PRSX,U,4)  ; Actual hours of LWOP
 K PRSX
 ;
 ; Load the memo totals
 S MDATA=$G(^PRST(458.7,MIEN,0))
 S AHRS=+$P(MDATA,U,4)  ; Agreed Hours
 S COHRS=+$P(MDATA,U,9) ; Carryover Hours
 S ITHW=+$P(MDATA,U,10) ; Initial Total Hours Worked
 S ITHP=+$P(MDATA,U,11) ; Initial Total Hours Paid
 S INPH=+$P(MDATA,U,12) ; Initial Non-Pay Hours
 S IWPH=+$P(MDATA,U,13) ; Initial Without Pay Hours
 S (AHTCM,DIFFRG,DIFFNP,DIFFWP)=0
 ;
 ; Get Non pay and Leave without pay times from 8b string or recalc.
 N TAMTS
 S TAMTS("WP","Leave Without Pay")=""
 S TAMTS("NP","Non-Pay Time")=""
 D PP8BAMT^PRSPUT3(.TAMTS,PPI,PRSIEN)
 S TOTAL("WP")=$G(TAMTS("WP","Leave Without Pay"))
 S TOTAL("NP")=$G(TAMTS("NP","Non-Pay Time"))
 S DIFFNP=TOTAL("NP")-PPNP
 S DIFFWP=TOTAL("WP")-PPWP
 ;
 ; Loop thru day and ESR segments looking for leave and RG time
 N DAY,ESR,RGCODES,SEG,TOT
 S RGCODES="AA,AD,AL,CB,CP,DL,HX,ML,RG,RL,SL,TR,TV"
 S TOTAL("RG")=0
 F DAY=1:1:14 D
 . ; only add totals for supervisor approved days
 . Q:$$GETSTAT^PRSPESR1(PRSIEN,PPI,DAY)'=5
 . S ESR=$G(^PRST(458,PPI,"E",PRSIEN,"D",DAY,5))
 . Q:ESR=""
 . F SEG=0:1:6 Q:$P(ESR,U,(5*SEG)+3)=""  D
 . . S TOT=$P(ESR,U,(5*SEG)+3)
 . . ; Types Of Time that might have been worked in week 1
 . . I RGCODES[TOT D  Q
 . . . S TOTAL("RG")=TOTAL("RG")+$$AMT(ESR)
 ;
 ; Checks for Regular Time
 S DIFFRG=TOTAL("RG")-PPHRS
 ; determine number of memo pay periods that have been certified
 S PRSX=$$MEMCPP^PRSPUT3(MIEN)
 S PPC=$P(PRSX,U,2)+$S(PPE]$P(PRSX,U):1,1:0)
 ;
 ; Update pp totals with current calculated values
 K IEN4587,PRSFDA
 S IEN4587=MIEN_","
 S PRSFDA(458.701,MPPIEN_","_IEN4587,1)=TOTAL("RG")  ; PP new REG hrs
 S PRSFDA(458.701,MPPIEN_","_IEN4587,2)=TOTAL("NP")  ; PP new NP hrs
 S PRSFDA(458.701,MPPIEN_","_IEN4587,3)=TOTAL("WP")  ; PP new WP hrs
 ;
 ; update memo grand totals with differences found 
 S TOTNP=INPH+DIFFNP
 S TOTWP=IWPH+DIFFWP
 S PRSFDA(458.7,IEN4587,11)=TOTNP ; NP hrs
 S PRSFDA(458.7,IEN4587,12)=TOTWP ; WP hrs
 S PRSFDA(458.7,IEN4587,9)=ITHW+DIFFRG ; tot hrs worked (all creditable)
 ;
 ; If this is the first time the PP has been processed PPHRS will be null
 ; so add the average hrs/pp, otherwise this count has already been added
 S THP=ITHP+$S(PPHRS="":AHRS/26,1:0)
 S PRSFDA(458.7,IEN4587,10)=$FN(THP-DIFFNP-DIFFWP,"",2) ; tot hrs paid
 S PRSFDA(458.7,IEN4587,13)=$FN(PPC/26,"",2) ; % of memo completed
 ; % OF HOURS COMPLETED
 S POHC=$FN((ITHW+COHRS+DIFFRG)/(AHRS-TOTNP-TOTWP),"",2)
 S PRSFDA(458.7,IEN4587,14)=POHC
 ;
 ; ave hrs/pp to complete mem (if certifying last pay period then then
 ; you're out of pay periods so use 0.00 to report how many more hours)
 S AHTCM=$S(PPC>25:"0.00",1:$FN((AHRS-(ITHW+COHRS+DIFFRG)/(26-PPC)),"",2))
 S PRSFDA(458.7,IEN4587,15)=AHTCM
 ; % off target
 S POT=((AHRS/26)*PPC)-TOTNP-TOTWP
 S POT=(ITHW+COHRS+DIFFRG)-POT/POT,POT=POT*100,POT=$FN(POT,"",2)
 S PRSFDA(458.7,IEN4587,16)=POT
 D FILE^DIE("","PRSFDA")
 Q
 ;
AMT(ESR) ; Return hours elapsed for time segment in decimal format
 ;          deduct meal
 ;            e.g. AMT=2.5 (2 hours 30 min)
 N START,STOP,MEAL,AMT,X
 S START=$P(ESR,U,(5*SEG)+1),STOP=$P(ESR,U,(5*SEG)+2)
 S MEAL=$P(ESR,U,(5*SEG)+5)
 S AMT=$$ELAPSE^PRSPESR2(MEAL,START,STOP)
 S X=$P(AMT,":",2) S X=$S(X=30:5,X=15:25,X=45:75,1:0)
 S AMT=+$P(AMT,":",1)_"."_X
 Q AMT
