IBAECM2 ;WOIFO/SS-LTC PHASE 2 MONTHLY JOB ; 20-FEB-02
 ;;2.0;INTEGRATED BILLING;**176,198,188**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ;
 ;Copay calculation for the patient
 ;Input:
 ;IBMDS - days array
 ; IBMDS(0)-first day of the month
 ; IBMDS(1)-last day of the month
 ; IBMDS(2)-yyymm (like 30201 - for Jan 2002)
 ;IBDFN - dfn
 ;IBSTART - date to start calclation from, 
 ; normally it is the first day of the month,
 ; but for very first time it will be the effective date
 ;IBCLKIEN - 351.81 ien
 ;returns 0 if no charges for any reason
 ;otherwise returns 1
PROCPAT(IBMDS,IBDFN,IBSTART,IBCLKIEN) ;
 ;IBCHRG - charge array, is used for SEND2AR, contains all charges for 
 ;the patient for this month
 ;one day may contain only one rate (charge), that prevents duplications
 ;   "A",IBDAY,"R"=rate^ien_of_#350.1(i.e.IB action type)
 ;   "A",IBDAY,"T"=type or care^source^date
 ;where
 ; outpatient:
 ;   type or care -  1 
 ;   source - ien of #409.68
 ;   date -  date of service
 ; inpatient:
 ;   type or care -  2
 ;   source -  ien of #405
 ;   date - date of admission
 N IBCHRG
 N IBDAY,IBDATE,IBINPAT,IBOUTPAT,IBRET,IBCMCA
 N IBINPINF,IBADM1,IBVISIT,IBCOMPEN,IBV1,IBV2
 N IBLDINP,IB40968,IBFDAY
 S IBCHRG=0,IBLDINP="^"
 D CLEAN^IBAECM1(IBDFN)
 ; determine first day (IBFDAY) of FOR cycle:
 S IBFDAY=1 ;default
 S IBSTART=+$G(IBSTART)
 ;if effective date is greater than the last day of this month, then do nothing
 Q:IBSTART>IBMDS(1) IBCHRG
 ;if effective date is in current month, then cycle starts from
 ;this day of the month
 S IBFDAY=+$E(IBSTART,6,7)
 ;if effective date is less than this month, then starts from
 ;the first day of the month
 S:IBSTART<IBMDS(0) IBFDAY=1
 ;----
 ; use LOS=1 to get patient status
 S IBRET=+$$LTCST^IBAECU(IBDFN,IBMDS(1),1)
 ;** EXEMPTION from co-pay **
 I IBRET=1 Q IBCHRG  ;>>QUIT
 ;
 ;get all data about all inpatient episodes
 ;IBINPAT'=0 - there are inpatient episodes
 S IBINPAT=$$INPINFO^IBAECU2(IBMDS(0),IBMDS(1),IBDFN,"IBMJINP",1)
 ;get all data about all outpatient episodes
 ;IBOUTPAT'=0 - there are outpatient episodes
 S IBOUTPAT=$$OUTPINFO^IBAECU3(IBMDS(0),IBMDS(1),IBDFN,"IBMJOUT")
 ;no 1010EC - send e-mail and quit
 I IBRET=0 D  Q IBCHRG  ;>>QUIT
 . S IBV1=$O(^TMP($J,"IBMJINP",IBDFN,0))
 . I +IBV1>0 S IBV1=+$G(^TMP($J,"IBMJINP",IBDFN,IBV1))
 . I +IBV1=0 S IBV1=$O(^TMP($J,"IBMJOUT",IBDFN,IBV1))
 . I +IBV1=0 S IBV1=IBMDS(0)
 . ; changed in 188 to eliminate some messages when nothing there
 . I IBINPAT'=0!(IBOUTPAT'=0) D MESS10EC^IBAECU5(IBDFN,IBV1)
 . D CLEAN^IBAECM1(IBDFN)
 . ; update or clean out current events date
 . S DR=".07///"_$S($D(^DPT(IBDFN,.1)):$E(DT,1,5)_"01",1:"@")
 . S DIE="^IBA(351.81,",DA=IBCLKIEN D ^DIE
 ;
 ; if no inpatient, no outpatient episodes and still 21 free days 
 ; remain - someone cancelled episodes and we cancel the clock
 I IBINPAT=0,IBOUTPAT=0,$P($G(^IBA(351.81,IBCLKIEN,0)),"^",6)=21  D  Q IBCHRG  ;>>QUIT
 . D CLCKADJ^IBAECU4("C",IBCLKIEN,IBDFN,"^",IBMDS(1))
 . S IBCHRG("A")=0 ; no charges
 . D CLEAN^IBAECM1(IBDFN)
 ;
 ; check correctness of 21 days clock if error then fix it and notify the users
 S IBV2=$$CHKDSERR^IBAECU4(IBCLKIEN,IBDFN)
 I IBV2<0 D FIX21CLK^IBAECU4(IBCLKIEN)
 ; ==============Go thru each day =============================
 F IBDAY=IBFDAY:1:IBMDS Q:IBCLKIEN=0  S IBDATE=$$MKDATE^IBAECU4(IBMDS(2),IBDAY) D
 . ;***** Gathering all necessary info ******
 . ; C&P status
 . S IBCOMPEN=$$ISCOMPEN^IBAECU5(IBDFN,IBDATE)
 . ; INPATIENT episodes
 . S IBADM1=0 ;adm ien
 . S IBINPINF="" K IBINPINF("M"),IBINPINF("L")
 . ; is any inpatient LTC this day?
 . S IBINPINF=$$ISINPAT^IBAECU2(IBDFN,IBDATE,"IBMJINP",.IBINPINF)
 . ;
 . ; if the patient has inpatient service in the last day of the 
 . ; processed month, then "CURRENT EVENTS DATE" in LTC clock (#351.81)
 . ; must be set to the 1st day of the following month to indicate that
 . ; the patient must be checked for LTC copay by MJ next month. 
 . ; Thus if so we set IBLDINP to IBINPINF (calcualted for the last day
 . ; of the processed month)(see CLCKADJ)
 . I IBMDS(1)=IBDATE S IBLDINP=IBINPINF
 . ; OUTPATIENT episodes
 . S IB40968=0
 . S IBVISIT="" K IBVISIT("M"),IBVISIT("L")
 . ;is there any outp episode with this day?
 . S IBVISIT=$$ISOUTP^IBAECU3(IBDFN,IBDATE,"IBMJOUT",.IBVISIT)
 . ; If there is LTC event this day (IBDATE) and if current
 . ; CLOCK BEGIN DATE > IBDATE then change it to IBDATE
 . ; (& reset its expiration date)
 . I +IBVISIT!(+IBINPINF) I $P($G(^IBA(351.81,IBCLKIEN,0)),"^",3)>IBDATE D RESET21^IBAECU4(IBCLKIEN,IBDATE,IBDFN)
 . ;*****************************************
 . ; check 21 days clock file
 . ; check expiration date,etc of 21 clock
 . S IBCLKIEN=$$CH21BFR^IBAECM1(IBCLKIEN,IBDATE,IBDFN) ;
 . I IBCLKIEN=0 Q  ;ERROR - new entry in #351.81 was not created - quit !
 . ;
 . ; 1. LTC inpatient in bed - ALWAYS charge him
 . S IBADM1=+$O(IBINPINF("L","SD",0))
 . I IBADM1>0 D  Q  ;>>>>QUIT - GO to NEXT DAY
 . . ;look for and cancel Means Test Outpatient charges for this date
 . . D CHKMTOUT^IBAECU3(IBDFN,IBDATE,"IBMJOUT")
 . . ; check expiration date,etc of 21 clock
 . . ; $$EXEMPT21 checks if vet is eligible for 21 clock exemption 
 . . ; 1 - if exempted, don't charge the patient
 . . I $$EXEMPT21^IBAECU4(IBCLKIEN)=1 D  Q
 . . . ;add new exempt day to LTC clock
 . . . D ADD21DAY^IBAECM1(IBCLKIEN,IBDATE,IBDFN)
 . . ; otherwise no 21 clock exemption - cretae a charge
 . . ;get rate for this treating specialty
 . . S IBCHRG("A",IBDAY,"R")=$$GETRATE^IBAECU3(2,+$G(IBINPINF("L","SD",IBADM1)),IBDATE)_"^"_$P($G(IBINPINF("L","SD",IBADM1)),"^",2)
 . . S IBCHRG("A",IBDAY,"T")="2^"_IBADM1_"^"_$P($G(IBINPINF("L","SD",IBADM1)),"^",3) ;inpatient
 . . S IBCHRG=IBCHRG+1
 . ;
 . ; 2. MeansTest inpatient in bed or in AA,UA or ASIH
 . ; do not charge vet for LTC outpatient visit
 . ; - MT inpatient care has precedence on LTC outpatient visit if vet is in bed.
 . ; - if MT inpatient in AA,UA,ASIH, the current MT rule don't allow to charge him
 . ; for MT outpatien visits in AA,UA&ASIH. It was decided to applied the same rules 
 . ; to LTC outpatient visits
 . S IBADM1=+$O(IBINPINF("M",0))
 . Q:IBADM1>0  ;............................>>>>QUIT - GO to NEXT DAY
 . ;
 . ; 3. LTC inpatient in AA,UA or ASIH
 . ; do not charge for any (MT or LTC) outpatient visits (see explanation for 2.)
 . S IBADM1=+$O(IBINPINF("L","LD",0))
 . I IBADM1>0 D  Q  ;>>>>QUIT - GO to NEXT DAY
 . . ;look for and cancel Means Test Outpatient charges for this date
 . . ;(at this point can be only outpatient MT charges, 
 . . ;because inpatient MT has gone earlier in 2.)
 . . D CHKMTOUT^IBAECU3(IBDFN,IBDATE,"IBMJOUT")
 . ;
 . ; 4. C&P exam
 . ; if C&P exam then any outpatient visits are exempted,no charge,goto NEXT DAY
 . Q:IBCOMPEN=1  ;............................>>>>QUIT - GO to NEXT DAY
 . ;
 . ; 5. LTC outpatient visit 
 . ;check if vet has a LTC outpatient visit
 . S IB40968=+$O(IBVISIT("L",0))
 . I IB40968>0 D
 . . ;look for and cancel Means Test Outpatient charges for this date
 . . D CHKMTOUT^IBAECU3(IBDFN,IBDATE,"IBMJOUT")
 . . ; $$EXEMPT21 checks if vet is eligible for 21 clock exemption 
 . . ; 1 - if exempted, don't charge the patient
 . . I $$EXEMPT21^IBAECU4(IBCLKIEN)=1 D  Q
 . . . ;add new exempt day to LTC clock
 . . . D ADD21DAY^IBAECM1(IBCLKIEN,IBDATE,IBDFN)
 . . ; otherwise no 21 clock exemption - cretae a charge
 . . ;get rate for LTC visit on this date
 . . S IBCHRG("A",IBDAY,"R")=$$GETRATE^IBAECU3(1,+$G(IBVISIT("L",IB40968)),IBDATE)_"^"_$P($G(IBVISIT("L",IB40968)),"^",2)
 . . S IBCHRG("A",IBDAY,"T")="1^"_IB40968_"^"_$$MKDATE^IBAECU4(IBMDS(2),IBDAY) ;outpatient
 . . S IBCHRG=IBCHRG+1
 . Q
 ;=============================================================
 I IBCLKIEN=0 Q -1  ;error
 ;return month copay
 S IBCMCA=$$CLCK180(IBDFN,$S(IBSTART>IBMDS(0):IBSTART,1:IBMDS(0)),IBMDS(1),"IBMJINP")
 ; create charges for
 ; check expiration date,etc of 21 clock
 I IBCHRG>0 D SEND2AR^IBAECU5(IBDFN,.IBCHRG,.IBMDS,+IBCMCA)
 ;clock adjustment
 D CLCKADJ^IBAECU4("P",IBCLKIEN,IBDFN,IBLDINP,IBMDS(1))
 D CLEAN^IBAECM1(IBDFN)
 Q IBCHRG
 ;
 ;returns "max_monthly_calculated_copay"^"is_181+_case"
 ;determine 181+ case (takes care about 30 days "gap" between
 ;prior 181+ and current admission)
CLCK180(IBDFN,IBBEGDT,IBENDDT,IBLBL) ;
 ;array for adm info
 N IBLNGADM,IBADMINF,IBRET1,IBCMC,IS180CLK,IBFL5,IB30BACK
 S IBADMINF="^"
 ; if we have active admission that started before IBMDS(0) then 
 ; What is the length of this admission?
 ; we need IBLNGADM to call $$COPAY^EASECCAL; If there is 
 ; no admission started before IBMDS(0) then sets IBLNGADM=1
 S IBLNGADM=$$DAYS180^IBAECM1(IBBEGDT,IBENDDT,IBDFN,IBLBL,.IBADMINF)
 ; if none then check if another admission 30 days before (see SDD)
 I IBLNGADM=1 D
 . S IBFL5=$$ISLTC^IBAECU5(IBDFN,IBLBL)
 . Q:IBFL5=0
 . K ^TMP($J,"180DAYS")
 . S IB30BACK=$$CHNGDATE^IBAECU4(IBFL5,-30)
 . I $$INPINFO^IBAECU2(IB30BACK,IBFL5,IBDFN,"180DAYS",1)=0 Q
 . K IBADMINF S IBADMINF="^"
 . S IBLNGADM=$$DAYS180^IBAECM1(IB30BACK,IBFL5,IBDFN,"180DAYS",.IBADMINF)
 ; get patient status
 S IBRET1=$$LTCST^IBAECU(IBDFN,IBENDDT,IBLNGADM)
 ;calculate a proper LTC Monthly Copay Amount and put it in IBCMC
 ;(max amount patient should pay monthly)
 ;IS180CLK =1 if patient has >180 days of continious LTC
 S IS180CLK=$$MONTHMAX^IBAECM1(IBDFN,.IBADMINF,IBRET1,IBLNGADM,.IBCMC)
 K ^TMP($J,"180DAYS")
 Q +IBCMC_"^"_IS180CLK
 ;
