ECUTL0 ;ALB/ESD - Event Capture Eligibility and In/Outpat Utilities ;4 May 98
 ;;2.0; EVENT CAPTURE ;**10**;8 May 96
 ;
 ;
CHKDSS(DSSU,INOUT) ;  Determine if DSS Unit is sending data to PCE
 ;
 ;   Input:
 ;      DSSU - DSS Unit IEN
 ;      INOUT - Inpatient or Outpatient
 ;
 ;  Output:
 ;      Function Value - 0 if DSS Unit not sending to PCE or input
 ;                           parameters not passed in
 ;                       1 if DSS Unit sending to PCE
 ;
 N ECDSS,ECSEND
 ;
 ;- Drops out if invalid condition
 D
 . I '$G(DSSU),($G(INOUT)="") S ECDSS=0 Q
 .;
 .;- Get 'Send to PCE' field
 . S ECSEND=$P($G(^ECD(+DSSU,0)),"^",14)
 . I ECSEND="A"!(ECSEND="O"&(INOUT="O")) S ECDSS=1
 . E  S ECDSS=0
 Q ECDSS
 ;
 ;
ELGLST() ;  Display list of patient eligibilities and allow user to
 ;          select eligibility, given ELIG^VADPT has been previously called.
 ;
 ;   Input:
 ;      None
 ;  Output:
 ;      Function value - IEN of eligibility from ELIGIBILITY CODE file
 ;                       (#8) or 0 if unsuccessful
 ;
 N ECALLEL,ECELIEN,ECELIG,ECPRIMEL
 S (ECELIEN,ECELIG)=0
 ;
 ;- If VAEL not previously called, exit with error condition
 I '$D(VAEL)!('$G(VAEL(1))) G ELGLSTQ
ELIG S ECALLEL=""
 S ECPRIMEL=$P(VAEL(1),"^",2)
 W !!,"THIS PATIENT HAS OTHER ENTITLED ELIGIBILITIES:"
 ;
 ;- Display all of patient's eligibilities
 F ECELIEN=0:0 S ECELIEN=$O(VAEL(1,ECELIEN)) Q:'ECELIEN  D
 . W !?5,$P(VAEL(1,ECELIEN),"^",2)
 . S ECALLEL=ECALLEL_"^"_$P(VAEL(1,ECELIEN),"^",2)
 ;
 ;- Use patient's primary elig as default
CHOOSE W !!,"ENTER THE ELIGIBILITY FOR THIS APPOINTMENT: "_ECPRIMEL_"// "
 ;
 ;- If return, uparrow, or time out get prim elig w/o searching for match
 R X:DTIME G PRIMELG:"^"[X!('$T)  S X=$$UPPER^VALM1(X) G ELIG:X["?",CHOOSE:ECALLEL'[("^"_X)
 S ECPRIMEL=X_$P($P(ECALLEL,"^"_X,2),"^")
 W $P($P(ECALLEL,"^"_X,2),"^")
 ;
 ;- If match found, exit with eligibility IEN from file #8
 F ECELIEN=0:0 S ECELIEN=$O(VAEL(1,ECELIEN)) Q:'ECELIEN  I $P(VAEL(1,ECELIEN),"^",2)=ECPRIMEL S ECELIG=+ECELIEN G ELGLSTQ
 ;
 ;- If default or error cond exit with IEN of primary elig from file #8
PRIMELG I ('$T)!(X["^") D ELIGERR^ECUTL0
 I ('$T)!(X["^")!($P(VAEL(1),"^",2)=ECPRIMEL) S ECELIG=+$P(VAEL(1),"^")
 ;
ELGLSTQ Q ECELIG
 ;
 ;
MULTELG(DFN) ;  Determine if patient has multiple eligibilites (calls
 ;          ELIG^VADPT).
 ;
 ;   Input:
 ;      DFN - IEN of Patient file (#2)
 ;  Output:
 ;      Function value - 0 if no additional eligibilities exist,
 ;      otherwise a number greater than 0 if addt'l eligibilities exist
 ;
 D ELIG^VADPT
 Q +$O(VAEL(1,0))
 ;
 ;
ASKIF(ELIGNM) ;  Ask user whether to edit the eligibility during the edit
 ;          of an existing EC Patient file (#721) record
 ;
 ;   Input:
 ;      ELIGNM - Eligibility Name
 ;
 ;  Output:
 ;      Function value - 1 if user wants to edit eligibility
 ;                       0 if user does not want to edit eligibility
 ;                      -1 if uparrow or time out
 ;
 N DIR
 Q:$G(ELIGNM)="" 0
 ;- Display patient's current eligibility
 W !!,"The eligibility previously filed for this patient's procedure is:",!?5,ELIGNM,!!
 ;- Ask user
 S DIR(0)="YA"
 S DIR("A")="Do you wish to edit the patient's eligibility? "
 S DIR("B")="NO"
 D ^DIR
 Q $S($D(DIRUT):-1,'Y:0,1:Y)
 ;
 ;
ELIGERR ;  If user uparrows or times out while choosing eligibility, display
 ;  primary eligibility msg to screen
 ;
 ;   Input:
 ;      None
 ;
 ;  Output:
 ;      Display primary eligibility message to screen
 ;
 W !!?5,"No eligibility entered.  The primary eligibility of the patient"
 W !?5,"will be sent to PCE for workload reporting (if the patient's"
 W !?5,"procedure data is complete).",!
 Q
 ;
 ;
INOUTPT(DFN,PROCDT) ;  Determine inpatient/outpatient status
 ;
 ;   Input:
 ;      DFN - IEN of Patient file (#2)
 ;      PROCDT - Procedure Date/Time
 ;
 ;  Output:
 ;      Function value - I if inpatient, O if outpatient, null if error
 ;
 N ECPTSTAT
 S ECPTSTAT=1
 I '$G(DFN)!('$G(PROCDT)) S ECPTSTAT=0
 ;
 ;- Call inpat/outpat function if both input variables are present
 I ECPTSTAT D
 . S ECPTSTAT=$$INP^SDAM2(DFN,PROCDT)
 . I $G(ECPTSTAT)="" S ECPTSTAT="O"
 ;
 ;- If either one of input variables are missing, return null (otherwise 
 ;  return "I" or "O")
 Q $S(ECPTSTAT=0:"",1:ECPTSTAT)
 ;
 ;
DSPSTAT(ECSTAT) ;  Display inpatient/outpatient status
 ;
 ;   Input:
 ;      ECSTAT - Inpatient/Outpatient status (I=inpatient, O=outpatient)
 ;
 ;  Output:
 ;      Display inpatient/outpatient status to screen
 ;
 N ECTXT
 S ECTXT="This patient is an "
 W !!,ECTXT_$S(ECSTAT="I":"Inpatient",1:"Outpatient"),!
 Q
 ;
 ;
INOUTERR ;  Display inpat/outpat status error msg to screen and set exit
 ;          variable
 ;
 ;   Input:
 ;      None
 ;
 ;  Output:
 ;      Display error message to screen
 ;
 W !,"Patient record data or procedure date/time data is missing.  No action taken."
 S ECOUT=1
 Q
