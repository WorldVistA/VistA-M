PRSARC02 ;WOIFO/JAH - Recess Tracking Library Functions ;10/16/06
 ;;4.0;PAID;**112**;Sep 21, 1995;Build 54
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 Q
GETNURSE(NURSE,PRSTLV) ; procedure prompts and screens only 9-month AWS nurses
 ;   
 ;
 ; INPUT: PRSTLV - flag to indicate T&L access, 2 for timekeeper
 ;                 3 for 
 ; OUTPUT: NURSE (3 ^ pieces)
 ;           1) - Nurse IEN from 450 lookup which is screened for
 ;            (DB part-time + NH 80 + pp M) or (recess rec exists)
 ;           2) Nurse name
 ;           3) 0 edit only, 1 add and edit
 ;
 ; use full screen for initial prompts
 D FULL^VALM1
 W @IOF,!!!
 ;
 ;Ask T&L unit
 ;
 N TLI,TLE,SSN,DUMMY
 I $G(PRSTLV)'>0 Q -1
 D ^PRSAUTL
 I $G(TLE)="" Q -1
 ;
 ;Lookup employees screening on t&l, normal hours, duty basis, pay plan
 ;
 N DIC,D
 S DIC("A")="Select AWS NURSE: "
 S DIC(0)="AEQM"
 S DIC="^PRSPC("
 S D="ATL"_TLE
 S DIC("S")="I $P(^(0),U,8)=TLE,(($P(^(0),U,16)=80)&($P(^(0),U,10)=2)&($P(^(0),U,21)=""M""))!($O(^PRST(458.8,""B"",+Y,0)))"
 D IX^DIC
 S NURSE=Y
 I +NURSE'>0 Q -1
 ;
 ; ensure entitlement string returns recess periods set to 1
 ;
 N DFN,ENT,ZENT
 S DFN=+NURSE
 D ^PRSAENT S ZENT=$S($E(ENT,5):"Recess Periods",1:"")
 I ZENT="" D
 .  W !!?5,"This nurse is not currently entitled to Recess Periods."
 .  W !?5,"A new FY Recess Record cannot be added, but existing FY"
 .  W !?5,"Recess records may be edited."
 .  W ! S DUMMY=$$ASK^PRSLIB00(1)
 .  S NURSE=NURSE_U_0
 E  D
 .  S NURSE=NURSE_U_1
 S SSN=$P(^PRSPC(+NURSE,0),U,9),SSN="XXX-XX-"_$E(SSN,6,9)
 S NURSE=NURSE_U_TLE_U_SSN
 Q
 ;
CHOOSEFY(SELFY,NURSE) ; Build List of FY choices--Last, Current, Next--include
 ; whether a record exists for that fiscal year already or not
 ;
 ;  INPUT: NURSE- IEN^NAME^(0 edit only, 1 add and edit)
 ;         if nurse entitled to recess, new rec can be added, else
 ;         only edit existing records allowed.
 ;  OUTPUT: SELFY-selected fiscal year data (11 ^ piece string)
 ;    1) 4 digit yr           2) ex.FY06-07      3) external 1st day
 ;    4) external last day    5) FM 1st day      6) FM last day
 ;    7) first pp             8) last pp         9) 458.8 IEN if exists 
 ;    10) ext AWS start date 11) FM date AWS start
 ;    12) AWS start pay period
 ;
 ;    example:
 ; 2007^FY06-07^10/01/06^10/13/07^3061001^3071013^06-20^07-20^1
 ; ^11/12/06^3061112^06-23
 ;
 ; entitled to Recess
 N RENT,FYA,FYSA
 S RENT=$P(NURSE,U,3)
 ;
 ; check to see if any Schedules are on file for this Nurse
 ;
 D FIND^DIC(458.8,,".01;1;1.1","Q",+NURSE,"AC",,,,"FYA")
 ;
 ; get current next and last
 ;
 D PRMPTARY
 ;
 ; if there are no editable records in the range and the Nurse
 ; isn't entitled then the gig is up.
 ;
 I 'RENT&($P(FYSA(1),U,9)=""&($P(FYSA(2),U,9)="")&($P(FYSA(3),U,9)="")) D  Q
 .  W !,$P(NURSE,U,2)," has no AWS schedules in the current, next or last fiscal years."
 ;
 N DIR,X,Y,DTOUT,DUOUT,DIRUT,DIROUT,CHOICE,CH,DIRUT
 S DIR(0)=$$BLDDIR(.FYSA,.CHOICE,RENT)
 S CH=CHOICE
 I $L(CHOICE)=3 S CH=$E(CHOICE,1)_", "_$E(CHOICE,2)_" or "_$E(CHOICE,3)
 E  I $L(CHOICE)=2 S CH=$E(CHOICE,1)_" or "_$E(CHOICE,2)
 S DIR("?")="  Enter "_CH_" to "_$S(RENT:"add or edit",1:"edit")_" the recess schedule for that fiscal year."
 S DIR("?",1)="  Edit a fiscal year by entering the code on the left."
 S DIR("?",2)="  The available choices for editing a 9 month AWS"
 S DIR("?",3)="  recess record are limited to the current, next and last"
 S DIR("?",4)="  fiscal years.  If the nurse has an AWS record on file"
 S DIR("?",5)="  for the current, next or last fiscal year then the"
 S DIR("?",6)="  record may be edited.  To add a new schedule the nurse"
 S DIR("?",7)="  must have a pay plan of M, a duty basis of part-time"
 S DIR("?",8)="  and normal Hours equal to 80."
 S DIR("A")="Select fiscal year"
 S DIR("B")=$E(CHOICE,1)
 D ^DIR
 I $D(DIRUT) S SELFY=0
 E  S SELFY=FYSA($S(Y="C":1,Y="N":2,1:3))
 Q
 ;
PRMPTARY ; Build array w/fiscal year selections to edit
 N FY,CNT,REC,FOUND,ST,EN,RANGE,RWIEN,CUR,CUR4Y,EXTRANGE,PPE,STDT
 N X,TMPDT,EXTSTDT,LAS,LAS4Y,NEX,NEX4Y
 S CUR=$$GETFSCYR^PRSARC04(DT)
 S CUR4Y=+$E(CUR,1,3)
 S TMPDT=CUR4Y+1_"0101"
 S NEX=$$GETFSCYR^PRSARC04(TMPDT)
 S NEX4Y=+$E(NEX,1,3)
 S TMPDT=NEX4Y-2_"0101"
 S LAS=$$GETFSCYR^PRSARC04(TMPDT)
 S LAS4Y=+$E(LAS,1,3)
 S CUR4Y=CUR4Y+1700
 S NEX4Y=NEX4Y+1700
 S LAS4Y=LAS4Y+1700
 ;
 S CNT=0
 F FY=CUR4Y,NEX4Y,LAS4Y D
 .  S CNT=CNT+1
 .  S (REC,FOUND)=0
 .  F  S REC=$O(FYA("DILIST","ID",REC)) Q:REC'>0!(FOUND)  D
 ..   I FYA("DILIST","ID",REC,1)=FY S FOUND=REC,RWIEN=FYA("DILIST",2,REC)
 .  S RANGE=$$FYDAYS^PRSARC04(FY)
 .  S ST=$P(RANGE,U)
 .  S EN=$P(RANGE,U,2)
 .  S ST=$E(ST,4,5)_"/"_$E(ST,6,7)_"/"_$E(ST,2,3)
 .  S EN=$E(EN,4,5)_"/"_$E(EN,6,7)_"/"_$E(EN,2,3)
 .  S EXTRANGE=ST_U_EN
 .  S FYSA(CNT)=$S(CNT=2:NEX4Y,CNT=1:CUR4Y,1:LAS4Y)
 .  S FYSA(CNT)=FYSA(CNT)_U_$P($S(CNT=2:NEX,CNT=1:CUR,1:LAS),U,3)_U_EXTRANGE_U_RANGE
 .  I FOUND D
 ..    ;convert start date to mm/dd/yy
 ..    S X=$G(FYA("DILIST","ID",FOUND,1.1))
 ..    D ^%DT
 ..    S STDT=Y
 ..    N D1 S D1=STDT D PP^PRSAPPU
 ..    S EXTSTDT=$E(Y,4,5)_"/"_$E(Y,6,7)_"/"_$E(Y,2,3)
 ..    S FYSA(CNT)=FYSA(CNT)_U_RWIEN_U_EXTSTDT_U_STDT_U_PPE
 .  E  D
 ..    S FYSA(CNT)=FYSA(CNT)_U_U_U
 ;
 Q
BLDDIR(FYSA,CHOICES,RENT) ; Put Set of Codes for DIR into DIR(0) format
 I '$D(FYSA) W !,"Error: no fiscal year data!",!! Q
 ;
 N CNT,CI,SOC,AW,SELI,NR
 S CNT=0
 S NR="-has no existing record."
 S AW="-has AWS start date "
 ;
 ; SOC -set of codes
 ;
 N SOC S SOC="",CHOICES=""
 F SELI="Current","Next","Last" D
 . S CNT=CNT+1
 . S CI=$G(FYSA(CNT))
 . Q:RENT=0&($P(CI,U,9)="")
 . S CHOICES=CHOICES_$S(CNT=1:"C",CNT=2:"N",1:"L")
 . I SOC="" D
 ..  S SOC="S^"_$S(CNT=1:"C:",CNT=2:"N:",1:"L:")
 . E  D
 ..  S SOC=SOC_$S(CNT=2:";N:",1:";L:")
 . S SOC=SOC_SELI_" FY"_$P(CI,U,1)_" begins "_$P(CI,U,3)_$S($P(CI,U,9)'="":AW_$P(CI,U,10),1:NR)
 Q SOC
