IBTUTL1 ;ALB/AAS - CLAIMS TRACKING UTILITY ROUTINE ;21-JUN-93
 ;;2.0;INTEGRATED BILLING;**13,223,249,292,384,517**;21-MAR-94;Build 240
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
OPT(DFN,IBETYP,IBTDT,ENCTR,IBRMARK,IBVSIT) ; -- add outpatient care entries
 ; -- input   dfn  := patient pointer to 2
 ;          ibetyp := pointer to type entry in 356.6
 ;          ibtdt  := episode date
 ;          enctr  := pointer to opt. encounter file (optional)
 ;        ibrmark  := text of reason not billable (optional)
 ;         ibvsit  := pointer to visit file (optional)
 ;
 N X,Y,DA,DR,DIE,DIC,IBSCRN
 S IBSCRN=0
 ;Allow user inter-actions if not queued and IBTALK=1 or not exist. 
 I '$D(ZTQUEUED) D  I IBSCRN G OPTSCRN
 . I $D(IBTALK),'$G(IBTALK) Q
 . I IBTDT<3060101 Q  ;Don't use new code for claims prior to 1/1/2006
 . S IBSCRN=1
 I $G(IBETYP) S IBETYP=$O(^IBE(356.6,"AC",2,0))
 I IBTDT<3060101 S X=$O(^IBT(356,"APTY",DFN,IBETYP,IBTDT,0)) I X S IBTRN=X G OPTQ ;Prevent duplicate date/time claims prior to 1/1/2006
 ;Check for encounter already in claims tracking.
 I $D(ENCTR),$D(^IBT(356,"AENC",+DFN,+ENCTR)) S IBTRN=$O(^IBT(356,"AENC",+DFN,+ENCTR,0)) G OPTQ
 D ADDT^IBTUTL
 S DA=IBTRN,DIE="^IBT(356,"
 I IBTRN<1 G OPTQ
 L +^IBT(356,+IBTRN):10 I '$T G OPTQ
 S DR=".02////"_$G(DFN)_";.03////"_$G(IBVSIT)_";.04////"_$G(ENCTR)_";.06////"_+IBTDT_";.18////"_IBETYP_";.2////1;.24////"_$$INSURED^IBCNS1(DFN)_";1.01///NOW;1.02////"_DUZ_";.17////"_$$EABD^IBTUTL(IBETYP)
 I $G(IBRMARK)'="" S DR=DR_";.19///"_IBRMARK
 D ^DIE K DA,DR,DIE
 L -^IBT(356,+IBTRN)
 I IBETYP=2 S HCSRIEN=+$$FNDHCSR^IBTUTL(DFN,IBTDT) D:HCSRIEN HCSRCPY^IBTUTL(HCSRIEN,IBTRN,DFN,IBTDT)
OPTQ Q
 ;
REFILL(DFN,IBETYP,IBTDT,IBRXN,IBRXN1,IBRMARK,IBEABD,IBSCROI) ; -- add refill
 ; -- input   dfn   := patient pointer to 2
 ;          ibetyp  := pointer to type entry in 356.6
 ;          ibtdt   := episode date (refill date)
 ;          ibrxn   := pointer to 52
 ;          ibrxn1  := refill multiple entry
 ;          ibrmark := non billable reason if unsure
 ;          ibeabd  := optional, can specify an earliest auto bill date
 ;          ibscroi := special consent roi
 ;
 N X,Y,DA,DR,DIE,DIC
 ;S X=$O(^IBT(356,"APTY",DFN,IBETYP,IBTDT,0)) I X S IBTRN=X G REFILLQ
 S X=$O(^IBT(356,"ARXFL",IBRXN,IBRXN1,0)) I X S IBTRN=X G REFILLQ
 D ADDT^IBTUTL
 I IBTRN<1 G REFILLQ
 S DA=IBTRN,DIE="^IBT(356,"
 L +^IBT(356,+IBTRN):10 I '$T G REFILLQ
 S DR=".02////"_$G(DFN)_";.06////"_+IBTDT_";.08////"_IBRXN_";.1////"_IBRXN1_";.18////"_IBETYP_";.2////1;.24////"_$$INSURED^IBCNS1(DFN)_";1.01///NOW;1.02////"_$S($G(IBDUZ):IBDUZ,1:DUZ)_";.17////"_$S($G(IBEABD):IBEABD,1:$$EABD^IBTUTL(IBETYP))
 I $G(IBRMARK)'="" S DR=DR_";.19///"_IBRMARK
 I $G(IBSCROI)'="" S DR=DR_";.31////"_IBSCROI ;IB*2*384
 D ^DIE K DA,DR,DIE
 L -^IBT(356,+IBTRN)
REFILLQ Q
 ;
PRO(DFN,IBTDT,IBPRO,IBRMARK) ; -- add prosthetic entries
 ; -- input   dfn  := patient pointer to 2
 ;          ibetyp := pointer to type entry in 356.6
 ;          ibtdt  := episode date
 ;
 N X,Y,DA,DR,DIE,DIC,IBETYP
 ;S IBETYP=$O(^IBE(356.6,"ACODE",4,0))
 S IBETYP=$O(^IBE(356.6,"AC",3,0)) ;prosthetics type
 S X=$O(^IBT(356,"APRO",IBPRO,0)) I X S IBTRN=X G PROQ
 D ADDT^IBTUTL
 I IBTRN<1 G PROQ
 S DA=IBTRN,DIE="^IBT(356,"
 L +^IBT(356,+IBTRN):10 I '$T G PROQ
 S DR=".02////"_$G(DFN)_";.06////"_+IBTDT_";.09////"_IBPRO_";.18////"_IBETYP_";.2////1;.24////"_$$INSURED^IBCNS1(DFN)_";1.01///NOW;1.02////"_DUZ_";.17////"_$$EABD^IBTUTL(IBETYP)
 I $G(IBRMARK)'="" S DR=DR_";.19///"_IBRMARK
 D ^DIE K DA,DR,DIE
 L -^IBT(356,+IBTRN)
PROQ Q
 ;
PT(DFN) ; -- format patient name - last 4 for output
 S Y="" I '$G(DFN) G PTQ
 I '$D(VA("PID")) D PID^VADPT
 S Y=$E($P($G(^DPT(DFN,0)),"^"),1,20)_" "_$E($G(^(0)),1)_VA("BID")
PTQ Q Y
 ;
PRODATA(IBDA) ; -- return data from prosthetics file
 N IBDA0,DA,DIC,DIE,DR
 K IBRMPR ; only one array at a time
 I '$G(IBDA) G PRODAQ
 S IBDA0=$G(^RMPR(660,+IBDA,0))
 G:IBDA0="" PRODAQ
DIQ S DIC="^RMPR(660,",DR=".01;1:5;7;10;12:17;24"
 S DIQ="IBRMPR",DIQ(0)="E",DA=IBDA
 D EN^DIQ1
PRODAQ Q
 ;
OPTSCRN ; -- add outpatient care entries with user feedback
 ; called from OPT^IBTUTL1 which has following inputs
 ; -- input   dfn  := patient pointer to 2
 ;          ibetyp := pointer to type entry in 356.6
 ;          ibtdt  := episode date
 ;          enctr  := pointer to opt. encounter file (optional)
 ;        ibrmark  := text of reason not billable (optional)
 ;         ibvsit  := pointer to visit file (optional)
 ;
 N CNT,DIR,DIROUT,DIRUT,DTOUT,DUOUT,IB3560,IBACT,IBDATE,IBENC,IBETYPNM
 N IBID,IBPATNM,IBQUIT,LINE,TEMP,TMP
 ;If encounter passed in already exists in claims Tracking, remove it.
 I $D(ENCTR),$D(^IBT(356,"AENC",+DFN,+ENCTR)) S ENCTR=""
 I $G(IBETYP) S IBETYP=$O(^IBE(356.6,"AC",2,0))
 S IBQUIT=0
 I $O(^IBT(356,"APTY",DFN,IBETYP,IBTDT,0)) D  I X S IBTRN=X G OPTSCRNQ
 . S (CNT,LINE)=1,(TEMP,TMP,X)=""
 . S Y=IBTDT D DD^%DT S IBDATE=$E(Y_"                  ",1,18) S Y=""
 . S TMP("DIMSG",LINE)=" ",LINE=LINE+1
 . S TMP("DIMSG",LINE)=" ",LINE=LINE+1
 . S TMP("DIMSG",LINE)="There are match(es) for the episode date you have entered:",LINE=LINE+1
 . S TMP("DIMSG",LINE)=" ",LINE=LINE+1
 . S TMP("DIMSG",LINE)="   EPISODE DATE       PATIENT NAME    CT ID      TYPE     ENCOUNTER  ACTIVE",LINE=LINE+1
 . S TMP("DIMSG",LINE)="   ------------       ------------    -----      ----     ---------  ------",LINE=LINE+1
 . S TMP("DIMSG",LINE)=" ",LINE=LINE+1
 . F  S X=$O(^IBT(356,"APTY",DFN,IBETYP,IBTDT,X)) Q:X=""  D
 .. S IB3560=$G(^IBT(356,X,0)) I IB3560="" Q
 .. S IBID=$P($G(IB3560),U,1) S IBID=$S(IBID="":"ID_UNKNOWN",1:$E(IBID_"          ",1,10))
 .. S IBPATNM=$P($G(^DPT(DFN,0)),U,1) S IBPATNM=$S(IBPATNM="":"PATIENT_UNKNOWN",1:$E(IBPATNM_"               ",1,15))
 .. S IBENC=$P($G(IB3560),U,4) S IBENC=$S(IBENC="":"NONE      ",1:$E(IBENC_"          ",1,10))
 .. S IBACT=$S($P($G(IB3560),U,20)=1:"YES",1:"NO ")
 .. S IBETYPNM=$P($G(^IBE(356.6,IBETYP,0)),U,2) S IBETYPNM=$S(IBETYPNM="":"NONE    ",1:$E(IBETYPNM_"        ",1,8))
 .. S TMP("DIMSG",LINE)=$E(CNT_"  ",1,3)_IBDATE_" "_IBPATNM_" "_IBID_" "_IBETYPNM_" "_IBENC_" "_IBACT
 .. S TEMP(CNT)=X_"^"_$TR(IBENC," ",""),CNT=CNT+1
 .. S LINE=LINE+1
 . I CNT>0 D
 .. S TMP("DIMSG",LINE+1)=$E(CNT_"  ",1,3)_"*** CREATE A NEW CLAIMS TRACKING ENTRY ***"
 .. D MSG^DIALOG("WM",,,,"TMP")
 .. S DIR(0)="NA^1:"_CNT_":0"
 .. S DIR("A")="Select a Claims Tracking entry: "
 .. S DIR("?",1)="Choose a Claims Tracking entry from the previous list to continue processing."
 .. S DIR("?")="Valid responses are 1 thru "_CNT_" or ^ to exit."
 .. D ^DIR
 .. I ($G(DTOUT))!($G(DUOUT))!($G(DIRUT))!($G(DIROUT)) S IBQUIT=1
 .. I Y>0 S X=+$G(TEMP(Y)) I +$P($G(TEMP(Y)),U,2)>0 S ENCTR=$P($G(TEMP(Y)),U,2)
 I IBQUIT Q
 I '$G(ENCTR) D
 . N CNT,DIR,IBDATA,IBDATA1,IBDATA2,IBERR,IBMSG,IBSCRN,IBTMP,LINE,TMP,X
 . N DIOUT,DIROUT,DTOUT,DUOUT
 . S X(1)=IBTDT
 . S IBSCRN="I $P($G(^(0)),U,2)="_DFN
 . S IBMSG="IBTMP(""ENC"")"
 . S IBERR="IBTMP(""ERR"")"
 . D FIND^DIC(409.68,,,"PQX",.X,,"B",IBSCRN,,IBMSG,IBERR)
 . I +IBTMP("ENC","DILIST",0)=0 S ENCTR="" Q
 . S CNT=+IBTMP("ENC","DILIST",0)+1
 . S (LINE,X)=0
 . S TMP("DIMSG",LINE)=" ",LINE=LINE+1
 . S TMP("DIMSG",LINE)=" ",LINE=LINE+1
 . S TMP("DIMSG",LINE)=" ",LINE=LINE+1
 . S TMP("DIMSG",LINE)="There are encounters for the episode date you have selected:",LINE=LINE+1
 . S TMP("DIMSG",LINE)=" ",LINE=LINE+1
 . F  S X=$O(IBTMP("ENC","DILIST",X)) Q:X=""  D
 .. S LINE=LINE+1
 .. S IBDATA1=$P($G(IBTMP("ENC","DILIST",X,0)),"^"_IBTDT,1)
 .. S IBDATA2=$P($G(IBTMP("ENC","DILIST",X,0)),"^"_IBTDT,2)
 .. S IBDATA=$TR(IBDATA1_IBDATA2,"^"," ")
 .. S TMP("DIMSG",LINE)=$E(X_"    ",1,4)_IBDATA
 . S TMP("DIMSG",LINE+1)=$E(+IBTMP("ENC","DILIST",0)+1_"    ",1,4)_"*** CREATE A NEW CLAIMS TRACKING ENTRY WITHOUT AN ENCOUNTER ***"
 . D MSG^DIALOG("WM",,,,"TMP")
 . S DIR(0)="NA^1:"_CNT_":0"
 . S DIR("A")="Select an Encounter for the Claims Tracking entry: "
 . S DIR("?",1)="Choose an Encounter from the previous list to continue processing."
 . S DIR("?")="Valid responses are 1 thru "_CNT_" or ^ to exit."
 . D ^DIR
 . I ($G(DTOUT))!($G(DUOUT))!($G(DIRUT))!($G(DIROUT)) S IBQUIT=1
 . I +$G(Y)<1 Q
 . S ENCTR=+$G(IBTMP("ENC","DILIST",+Y,0)) I 'ENCTR Q
 . I $D(^IBT(356,"AENC",+DFN,ENCTR)) S IBTRN=$O(^IBT(356,"AENC",+DFN,ENCTR,0)) Q
 I IBQUIT Q
 G:$G(IBTRN)'="" OPTSCRNQ
 D ADDT^IBTUTL
 S DA=IBTRN,DIE="^IBT(356,"
 I IBTRN<1 G OPTSCRNQ
 L +^IBT(356,+IBTRN):10 I '$T G OPTSCRNQ
 S DR=".02////"_$G(DFN)_";.03////"_$G(IBVSIT)_";.04////"_$G(ENCTR)_";.06////"_+IBTDT_";.18////"_IBETYP_";.2////1;.24////"_$$INSURED^IBCNS1(DFN)_";1.01///NOW;1.02////"_DUZ_";.17////"_$$EABD^IBTUTL(IBETYP)
 I $G(IBRMARK)'="" S DR=DR_";.19///"_IBRMARK
 D ^DIE K DA,DR,DIE
 L -^IBT(356,+IBTRN)
OPTSCRNQ Q
