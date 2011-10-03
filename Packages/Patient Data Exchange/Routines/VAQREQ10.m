VAQREQ10 ;ALB/JFP - REQUEST PDX RECORD, PROMPT PATIENT;01MAR93
 ;;1.5;PATIENT DATA EXCHANGE;**25**;NOV 17, 1993
 ; -- Entry Points
REQ D KILL^XUSCLEAN S VAQOPT="REQ" G INIT
UNS D KILL^XUSCLEAN S VAQOPT="UNS" G INIT
 QUIT
INIT ; -- Intialization
 D ^VAQUTL98
 N POP,TASK,DFN
 S:'$D(VAQOPT) VAQOPT="" ; -- should be set from entry point
 ;
MAIN ; -- Main entry point
 K VAQDFN,VAQIN,VAQNM,VAQISSN,VAQESSN,VAQIDOB,VAQEDOB,VAQIELG,VAQEELG
 K VAQAUSIT,VAQDOM,VAQDZ,VAQNOTI,VAQPID,VAQRQADD,VAQRQDT,VAQRQSIT
 K VAQTRN,VAQDZN,VAQPR,DFN
 S POP=0
 ;
 ; -- Call to Dir to request patient from patient file (2)
 S DIR("A")="Select Patient Name: "
 S DIR(0)="FAO^1:30^S X=$$UP^XLFSTR(X) K:(X'=$C(32)&($L(X)<1)) X"
 S DIR("?")="Enter Patient's Name (Last,First Middle) or SSN"
 W !! D ^DIR K DIR G:$D(DIRUT) EXIT
 S VAQIN=$$UP^XLFSTR(Y)
 ;
 ; -- Function call to get patient DFN (DIC)
 S TASK=$D(ZTSK) ; -- task = 1 (batch), task = 0 interactive
 D:$D(XRTL) T0^%ZOSV ; -- Capacity start
 S VAQDFN=$$GETDFN^VAQUTL97(VAQIN,TASK)
 S:$D(XRT0) XRTN=$T(+0) D:$D(XRT0) T1^%ZOSV ; -- Capacity stop
 D:VAQDFN=-1 MANUAL ; -- not in patient file (manual request)
 G:POP MLOOP
 D:VAQDFN>0 VADPT ; -- pulls off MAS data
 D EP^VAQREQ01 ; -- Call to list processor (status screen)
MLOOP G MAIN ; -- loop back until no more patient added
 ;
EXIT ; -- Cleanup and exit routine
 K POP,TASK,DFN
 K DIROUT,DIRUT,DTOUT,DUOUT,X,Y,BADSSN
 K VAQDFN,VAQIN,VAQNM,VAQISSN,VAQESSN,VAQIDOB,VAQEDOB,VAQIELG,VAQEELG
 K VAQAUSIT,VAQDOM,VAQDZ,VAQNOTI,VAQPID,VAQOPT,VAQRQADD,VAQRQDT,VAQRQSIT
 K VAQTRN,VAQDZN,VAQPR
 QUIT
 ;
MANUAL ; -- Gets Patient name SSN AND DOB if patient not found local PT file
 ; -- Don't allow manual entry of unsolicited request
 I VAQOPT="UNS" W !!,"An unsolicited PDX request requires an entry from the patient file...",!,"Press any key to continue: " S POP=1 R X:DTIME QUIT
 ;
 ; -- Request data
 S VAQEELG="Not Available"
 W !,$C(7)
 S DIR(0)="Y"
 S DIR("A")=VAQIN_" not found in local patient file...  Request PDX"
 S DIR("B")="YES"
 S DIR("?")="You will be required to enter the needed information."
 S DIR("?",1)="Enter 'YES' to request a PDX for a patient not in your Patient File."
 D ^DIR K DIR I $D(DIRUT)!('Y) S POP=1 QUIT
 ;
 ; -- Request patient name
 S DIR(0)="FAO^3:30^S X=$$UP^XLFSTR(X) K:(X?1P.E)!(X'?1U.ANP)!(X'["","") X"
 S DIR("A")="   Patient name : "
 S DIR("B")=VAQIN
 S DIR("?")="Enter patient's name in uppercase (LAST,FIRST MIDDLE)"
 S DIR("??")="^D PAT^VAQREQ09"
 D ^DIR K DIR I $D(DUOUT)!$D(DTOUT) S POP=1 QUIT
 S VAQNM=$$UP^XLFSTR(Y)
 ;
 ; -- Request pt SSN
 S DIR(0)="FAO^9:10^K:(X'?9N)&(X'?9N1""P"")!($D(BADSSN(X))) X"
 S DIR("A")="   SSN : "
 S DIR("?")="Enter patient's SSN (without dashes)"
 D ^DIR K DIR I $D(DUOUT)!$D(DTOUT) S POP=1 QUIT
 S VAQISSN=Y,VAQESSN=$$DASHSSN^VAQUTL99(Y)
 ;
 ; -- Checks for name or ssn required
 I (VAQNM="")&(VAQISSN="") W !!,"Patient name or SSN is required...Press any key to continue: " S POP=1 R X:DTIME QUIT
 ;
 ; -- Request pt DOB
 S DIR(0)="DAO^::EP"
 S DIR("A")="   DATE OF BIRTH : "
 S DIR("?")="Enter patient's date of birth"
 D ^DIR K DIR I $D(DUOUT)!$D(DTOUT) S POP=1 QUIT
 S VAQIDOB=Y,VAQEDOB=$$DOBFMT^VAQUTL99(Y)
 QUIT
 ;
VADPT ; -- Pulls off patient demographics, for DFN
 ; -- Gets name,ssn,dob
 S DFN=$P(VAQDFN,U,1)
 D DEM^VADPT,ELIG^VADPT
 S VAQNM=VADM(1)
 S VAQISSN=$P(VADM(2),U,1),VAQESSN=$P(VADM(2),U,2)
 S VAQIDOB=$P(VADM(3),U,1),VAQEDOB=$P(VADM(3),U,2)
 S VAQIELG=$P(VAEL(6),U,1),VAQEELG=$P(VAEL(6),U,2)
 K VADM,VAEL,VAERR,VA
 QUIT
 ;
END ; -- End of code
 QUIT
