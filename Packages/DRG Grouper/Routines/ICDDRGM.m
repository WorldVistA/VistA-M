ICDDRGM ;ALB/GRR/EG/ADL/KUM - GROUPER DRIVER ;28 Oct 2013  5:41 PM
 ;;18.0;DRG Grouper;**7,36,57,64**;Oct 20, 2000;Build 103
 ;
 ; ADL  Add Date prompt and passing of effective date for DRG CSV project
 ; ADL  Update DIC("S") code to screen using new function calls
 ; ADL  Update to access DRG file using new API for CSV Project
 ; KER  Remove direct global reads, update for ICD-10
 ; 
 ; Global Variables
 ;    ^DPT(               ICR  10035
 ;               
 ; External References
 ;    ^%DTC               ICR  10000
 ;    ^DIC                ICR  10006
 ;    ^DIR                ICR  10026
 ;    $$DT^XLFDT          ICR  10103
 ;    H^XUS               ICR  10044
 ;    ^ICDDRG             ICR  N/A
 ;    $$DRG^ICDEX         ICR  N/A
 ;    $$DRGD^ICDEX        ICR  N/A
 ;    $$ROOT^ICDEX        ICR  N/A
 ;               
 ; Local Variables NEWed or KILLed Elsewhere
 ;     DIRUT,ICDDATE,QUIT,Y
 ; 
 S U="^",DT=$$DT^XLFDT W !!?11,"DRG Grouper    Version ","18.0",!! ;$$VERSION^XPDUTL("ICD"),!!
PAT ; Patient
 D KILL
 S ICDQU=0 K ICDEXP,SEX,ICDDX,ICDSURG,ICDPOA,ICDCSYS
 D EFFDATE G KILL:$D(DUOUT),ICDOUT:$D(DTOUT)
 S DIR(0)="Y",DIR("A")="DRGs for Registered PATIENTS  (Y/N)",DIR("B")="YES"
 S DIR("?")="Enter 'Yes' if the patient has been previously registered, enter 'No' for other patient, or '^' to quit."
 D ^DIR K DIR S ICDPT=Y G KILL:$D(DUOUT),ICDOUT:$D(DTOUT)
PAT0 ; Patient - Ask again
 G:ICDPT=0 ASK
VA ; VA Patient File #2 
 S DIC="^DPT(",DIC(0)="AEQMZ" D ^DIC G Q:X=""!(X[U)!(Y'>0),ICDOUT:$D(DTOUT) S DFN=+Y,(DOB,AGE)=$P(Y(0),U,3),SEX=$P(Y(0),U,2)
 D TAC G:ICDQU PAT D DAM G:ICDQU PAT
EN1 ; Entry Point - Patient is known (DFN) 
 I $D(^DPT(DFN,.35)),$L(^DPT(DFN,.35)) D ALIVE G:ICDQU PAT
 S ICDEXP=$S($D(ICDEXP):ICDEXP,1:0)
 I AGE]"" N %,X,X1,X2 S X1=DT,X2=AGE D ^%DTC S AGE=X\365.25 W "  AGE: ",AGE
CD ;Prompt POA if ICD-10 DRG calculation 
 S ICDCSYS=$S(ICDDATE'<$$IMPDATE^LEXU("10D"):"ICD10",1:"ICD9")
 D ICDCD G PAT:$G(QUIT)
 G Q:X[U
OP ; PROCEDURE CODE SELECTION
 S ICDCDSY=$S(ICDCSYS="ICD9":2,1:31),ICDCV="(ICD "_$P(ICDCSYS,"ICD",2)_")"
 S DIC("A")="Enter Operation/Procedure "_ICDCV_": "
 W !
 F ICDNOR=1:1 D  Q:X=""!(X[U)  G:$D(DTOUT) ICDOUT I X'=0,Y>0 S ICDPRC(ICDNOR)=+Y,ICDSURG(ICDNOR)=X
 .;I ICDCSYS="ICD10" S ICDXX1=1 S ICDPRC="" D ASK^ICDCODLK K ICDXX1
 .I ICDCSYS="ICD10" D PROC
 .I ICDCSYS="ICD9" S ICDPRC="" D ICD9OP
 K DIC,ICDCDSY,ICDCV G Q:X["^"
 ;Rearrange ICDPRC array
 S X=0,ICDCNT=1
 F  S X=$O(ICDPRC(X)) Q:'X  D
 . S ICDPRCT(ICDCNT)=ICDPRC(X)
 . S ICDCNT=ICDCNT+1
 K ICDPRC
 M ICDPRC=ICDPRCT
 ;Rearrange ICDSURG array
 S X=0,ICDCNT=1
 F  S X=$O(ICDSURG(X)) Q:'X  D
 . S ICDSURGT(ICDCNT)=ICDSURG(X)
 . S ICDCNT=ICDCNT+1
 K ICDSURG
 M ICDSURG=ICDSURGT
 ;
 I ICDCSYS="ICD10" M ICDDXZ=ICDDX,ICDPRCZ=ICDPRC,ICDPOAZ=ICDPOA
 D ^ICDDRG
 D WRT
 I ICDCSYS="ICD10" K ICDEXP,SEX,ICDDX,ICDSURG,ICDPOA,ICDPRC,ICDDXZ,ICDPRCZ,ICDPOAZ,ICDPRCT,ICDCNT,ICDSURGT
 G PAT0
WRT S ICDDRG(0)=$$DRG^ICDEX(+ICDDRG,ICDDATE)  ;  new CSV code
 I ICDCSYS="ICD10" D
 . S ICDTMP=$$ICDDX^ICDEX(ICDDXZ(1),ICDDATE,"10D","I")
 . W !,"Principal Diagnosis: ",$P(ICDTMP,U,2),?30,$E($$VST^ICDEX(80,ICDDXZ(1),ICDDATE),1,44),?75,"POA=",$S($G(ICDPOAZ(1))'="":ICDPOAZ(1),1:"-")
 . F ICDI=2:1 Q:'$D(ICDDXZ(ICDI))  D
 . . S ICDTMP=$$ICDDX^ICDEX(ICDDXZ(ICDI),ICDDATE,"10D","I")
 . . W:ICDI=2 !,"Secondary Diagnosis: " W:ICDI>2 !?21 W $P(ICDTMP,U,2),?30,$E($$VST^ICDEX(80,ICDDXZ(ICDI),ICDDATE),1,44),?75,"POA=",$S($G(ICDPOAZ(ICDI))'="":ICDPOAZ(ICDI),1:"-")
 . F ICDI=1:1 Q:'$D(ICDPRCZ(ICDI))  D
 . . S ICDTMP=$$ICDOP^ICDEX(ICDPRCZ(ICDI),ICDDATE,"10P","I")
 . . W:ICDI=1 !!,"Procedure Code: " W:ICDI>1 ! W ?21,$P(ICDTMP,U,2),?30,$E($$VST^ICDEX(80.1,ICDPRCZ(ICDI),ICDDATE),1,50)
 W !!?9,"Effective Date: ","   ",ICDDSP
 W !,"Diagnosis Related Group: ",$J(ICDDRG,6),?40,"Avg len of stay: ",$J($P(ICDDRG(0),"^",8),6)
 W !?17,"Weight: ",$J($P(ICDDRG(0),"^",2),6),?40,"Local Breakeven: ",$J($P(ICDDRG(0),"^",12),6)
 W !?12," Low day(s): ",$J($P(ICDDRG(0),"^",3),6),?39,"Local low day(s): ",$J($P(ICDDRG(0),"^",9),6)
 W !?13," High days: ",$J($P(ICDDRG(0),"^",4),6),?40,"Local High days: ",$J($P(ICDDRG(0),"^",10),6)
 ;W !!,"DRG: ",ICDDRG,"-" F I=0:0 S I=$N(^ICD(ICDDRG,1,I)) Q:I'>0  W ?10,$P(^(I,0),U,1),!
 ;W !!,"DRG: ",ICDDRG,"-" F I=0:0 S I=$O(^ICD(ICDDRG,1,I)) Q:(I="")!(I'?.N)  W ?10,$P(^(I,0),U,1),!
 N ICDXD,ICDGDX,ICDGI
 S ICDXD=$$DRGD^ICDEX(ICDDRG,"ICDGDX",ICDDATE),ICDGI=0
 W !!,"DRG: ",ICDDRG,"-" F  S ICDGI=$O(ICDGDX(ICDGI)) Q:'+ICDGI  Q:ICDGDX(ICDGI)=" "  W ?10,ICDGDX(ICDGI),!
 Q
ERROR D WRT
 I ICDRTC<5 W !!,"Invalid ",$S(ICDRTC=1:"Principal Diagnosis",ICDRTC=2:"Operation/Procedure",ICDRTC=3:"Age",ICDRTC=4:"Sex",1:"") G PAT0
 I ICDRTC=5 W !!,"Grouper needs to know if patient died during this episode!" G PAT0
 I ICDRTC=6 W !!,"Grouper needs to know if patient was transferred to an acute care facility!" G PAT0
 I ICDRTC=7 W !!,"Grouper needs to know if patient was discharged against medical advice!" G PAT0
 I ICDRTC=8 W !!,"Patient assigned newborn diagnosis code.  Check diagnosis!" G PAT0
 G PAT0
KILL K DIC,DFN,DUOUT,DTOUT,ICDNOR,ICDDX,ICDPRC,ICDEXP,ICDTRS,ICDDMS,ICDDRG,ICDMDC,ICDO24,ICDP24,ICDP25,ICDRTC,ICDPT,ICDQU,ICDSD,ICDNMDC
 K ICDMAJ,ICDS25,ICDSEX,AGE,DOB,CC,HICDRG,ICD,ICDCC3,ICDJ,ICDJJ,ICDL39,ICDFZ,ICDDT,ICDDSP,IENT,QUIT
 Q
Q G PAT
AGE S DIR(0)="NOA^0:124:0",DIR("A")="Patient's age: ",DIR("?")="Enter how old the patient is (0-124)." D ^DIR K DIR S AGE=Y G QQ:$D(DUOUT),ICDOUT:$D(DTOUT)
 Q
ALIVE S DIR(0)="YO",DIR("A")="Did patient die during this episode" D ^DIR K DIR S ICDEXP=Y G QQ:$D(DUOUT),ICDOUT:$D(DTOUT)
 Q
TAC S DIR(0)="YO",DIR("A")="Was patient transferred to an acute care facility" D ^DIR K DIR S ICDTRS=Y G QQ:$D(DUOUT),ICDOUT:$D(DTOUT)
 Q
DAM S DIR(0)="YO",DIR("A")="Was patient discharged against medical advice" D ^DIR K DIR S ICDDMS=Y G QQ:$D(DUOUT),ICDOUT:$D(DTOUT)
 Q
SEX S DIR(0)="SBO^M:MALE;F:FEMALE",DIR("?")="Enter M for Male and F for Female",DIR("A")="Patient's Sex" D ^DIR K DIR S SEX=Y G QQ:$D(DUOUT),ICDOUT:$D(DTOUT)
 Q
QQ S ICDQU=1 Q
EFFDATE ;prompts for effective date for DRG grouper?
 K DIR S DIR(0)="D^::AEX",DIR("B")="TODAY",DIR("A")="Effective Date"
 S DIR("?")="The effective to be used when calculating the DRG code for the patient."
 D ^DIR K DIR I $D(DIRUT) S QUIT=1 Q
 S ICDDATE=Y,ICDDSP=Y(0)
 Q
ASK K DTOUT,DUOUT D AGE G:ICDQU PAT D ALIVE G:ICDQU PAT D TAC G:ICDQU PAT D DAM G:ICDQU PAT D SEX G:ICDQU PAT G CD
ICDOUT G H^XUS
 ;
ICDCD ;prompts for ICD diagnosis codes; ALB/JAM *64 ICD10 changes 
 N ICDPDXV,ICDSDXV,ICDDXPOA,ICDSD,ICDSC
 S ICDSC="(ICD "_$P(ICDCSYS,"ICD",2)_")"
 S ICDPDXV=$$ICDPDX Q:$G(QUIT)!(ICDPDXV<0)  S ICDDX(1)=ICDPDXV
 ;if ICD9 code skip POA question
 I ICDCSYS="ICD9" G ICDSDXV
 S ICDDXPOA=$$POA(ICDPDXV) Q:$G(QUIT)  S ICDPOA(1)=$TR(ICDDXPOA,"abcdefghijklmnopqrstuvwxyz","ABCDEFGHIJKLMNOPQRSTUVWXYZ")
ICDSDXV F ICDSD=2:1 S ICDSDXV=$$ICDSDX Q:$G(QUIT)!(ICDSDXV'>0)  S ICDDX(ICDSD)=ICDSDXV D  Q:$G(QUIT)
 .; if ICD9 code skip POA question
 .I ICDCSYS="ICD9" Q
 .S ICDDXPOA=$$POA(ICDSDXV) Q:$G(QUIT)  S ICDPOA(ICDSD)=$TR(ICDDXPOA,"abcdefghijklmnopqrstuvwxyz","ABCDEFGHIJKLMNOPQRSTUVWXYZ")
 Q
 ;
 ; Get ICD Principal Diagnosis Code
ICDPDX() ;
 N DIC,ICDCDSY,IENT,ICDSVAL,ICDPRI
 N ICDDSCR,ICDQUIT
 S ICDQUIT=0
 S ICDDSCR="Enter Principal diagnosis "_ICDSC_": "
 S ICDCDSY=$S(ICDCSYS="ICD9":1,1:30)
 ;if ICD-10
 I ICDCSYS="ICD10" D  Q ICDSVAL
 . ;if was aborted in the list then don't set QUIT=1, if aborted in the search string prompt then set QUIT=1 
 . F  S ICDSVAL=$$ICD10SRH(ICDDSCR,ICDDATE) Q:$G(ICDSVAL)>0  S:(ICDSVAL=-11)!(ICDSVAL=-2)!(ICDSVAL=0) (ICDQUIT,QUIT)=1  Q:ICDQUIT=1
 ;if ICD-9
 S IENT="I",ICDPRI="Y"
 S DIC=$$ROOT^ICDEX(80),DIC(0)="AEQMZI"
 S DIC("A")=ICDDSCR
 S DIC("S")="I $P($$ICDDX^ICDEX(+$G(Y),$G(ICDDATE),ICDCDSY,IENT),U,1)>0,$P($$ICDDX^ICDEX(+$G(Y),$G(ICDDATE),ICDCDSY,IENT),U,10),'$P($$ICDDX^ICDEX(+$G(Y),ICDDATE,ICDCDSY,IENT),U,5)"
 S Y=$$SEARCH^ICDSAPI(80,DIC("S"),DIC(0),$G(ICDDATE))
 I Y<=0 S QUIT=1 Q -1
 Q +Y
 ;
 ;Get ICD Secondary Diagnoses Codes 
ICDSDX() ;
 N DIC,ICDCDSY,IENT,ICDSVAL
 N ICDDSCR,ICDQUIT
 S ICDQUIT=0
 S ICDDSCR="Enter SECONDARY diagnosis "_ICDSC_": "
 S ICDCDSY=$S(ICDCSYS="ICD9":1,1:30)
 ;if ICD-10
 I ICDCSYS="ICD10" D  Q ICDSVAL
 . ;if was aborted in the list then don't set QUIT=1, if aborted in the search string prompt then set QUIT=1 
 . F  S ICDSVAL=$$ICD10SRH(ICDDSCR,ICDDATE) Q:$G(ICDSVAL)>0  S:ICDSVAL=0!(ICDSVAL=-2) ICDQUIT=1 S:ICDSVAL=-11 (ICDQUIT,QUIT)=1  Q:ICDQUIT=1
 ;if ICD-9
 S IENT="I"
 S DIC=$$ROOT^ICDEX(80),DIC(0)="AEQMZI"
 S DIC("A")=ICDDSCR
 S DIC("S")="I $P($$ICDDX^ICDEX(+$G(Y),$G(ICDDATE),ICDCDSY,IENT),U,1)>0,$P($$ICDDX^ICDEX(+$G(Y),$G(ICDDATE),ICDCDSY,IENT),U,10)"
 S Y=$$SEARCH^ICDSAPI(80,DIC("S"),DIC(0),$G(ICDDATE))
 I $D(DTOUT) S QUIT=1 Q -1
 I Y>0 Q +Y
 Q -1
 ;
 ;
 ;Ask for diagnosis
 ;ICDTINT - date of interest
 ;ICDPROM - prompt
 ;
 ;returns -11 if user has entered one of these - ^ ^^ or null
 ; -4 user doesn't want to continue
 ; -11 aborted by ^ or ^^ when the user enters the search sring (wants to quit from the prompt to the previous level)
 ; -3 aborted by ^ or ^^ during selection of the items on the list
 ; -2 Timed out 
 ; -9 User entered only one character
 ; -1 User entered Blank in the list of selection
 ; -10 User entered invalid data in the list of selection
ICD10SRH(ICDPROM,ICDTINT) ; Lexicon Partial Code Search
 N ICDUSTR,ICDPARAM
 ;set parameters for partial LEXICON search
 D SETPARAM^ICDDSLK(.ICDPARAM)
 ;if prompt provided the getusers input,
 ; return -11 to indicate that user wants to quit from the prompt to the previous level
 ; return 0 to indicate that user pressed Enter in the primary diag prompt it means he wants to quit from the prompt to the previous level, 
 ;   in secondary - wants to skip secodary diags
 ; otherwise call STS API for partial LEXICON search
 D  Q:ICDUSTR'>0 ICDUSTR  S ICDY=$$LEXICD10^ICDDSLK($P(ICDUSTR,U,2),ICDTINT,.ICDPARAM)
 . F  S ICDUSTR=$$GETUSINP(ICDPROM) Q:ICDUSTR'=-22  ;repeat if less than 2 chars and wasn't aborted by ^,^^ or null (Enter key pressed)
 ; User entered only one character
 I ICDY=-9 Q -9
 ; User entered Blank 
 I ICDY=-1 Q -1
 ; User entered invalid data
 I ICDY="" W !!,ICDPARAM("NO DATA FOUND") Q -12
 ; aborted by ^ or ^^
 I ICDY=-3 Q -3
 ; Timed out 
 I ICDY=-2 Q -2
 ; User doesn't want to continue
 I ICDY=-4 Q -4
 ; otherwise get the IEN of the selected code
 K DIC
 S ICDY=+$$CODEN^ICDEX($P($P(ICDY,";",2),U,1),80)
 Q +ICDY
 ;
 ;Get user input
 ;returns:
 ; "-2" timeout 
 ; "-11" user entered ^ or ^^
 ; "-22" user entered less than 2 chars
 ; 0 user entered null
 ; 1 user entered more than 2 chars
GETUSINP(ICDPRMPT) ;
 N DIR
 S DIR("A")=ICDPRMPT
 S DIR(0)="FAO^0:245"
 S DIR("?")="^D INPHLP^ICDDSLK"
 S DIR("??")="^D INPHLP^ICDDSLK"
 D ^DIR
 I $D(DTOUT) Q -2 ;timeout
 I Y="" Q 0 ; user entered null
 I Y["^" Q -11 ; user entered ^ or ^^
 I $L(Y)'>1 W !,"Please enter at least the first two characters of the ICD-10 code or code description to start the search." Q -22
 Q "1"_U_Y
 ;
GETIDX(ICDCSYS,ICDCODE,ICDT) ;
 N ICDICDX
 S ICDICDX=$$ICDDATA^ICDXCODE(ICDCSYS,ICDCODE,ICDT)
 I ICDICDX<1 Q $P(ICDICDX,U,2)
 Q $P(ICDICDX,U)_U_$P(ICDICDX,U,4)
 ;
POA(ICDDX123) ; Present On Admission
 N DIR,X,Y,ICDPR
 S QUIT=0,DIR("A")="Present on Admission: ",DIR(0)="SOA^Y:YES;N:NO;U:Unknown;W:Clinically undetermined"
 K DIR S QUIT=0,DIR("A")="Present on Admission: ",DIR(0)="SOA^Y:YES;N:NO;U:Unknown;W:Clinically undetermined"
 S (DIR("?"),DIR("??"))="^D HELPPOA^ICDDRGM"
 D ^DIR
 I ($D(DTOUT))!($D(DUOUT))!($D(DIROUT)) S QUIT=1 Q -1
 I X="" D
 . I $$GET1^DIQ(80,ICDDX123,1.9,"I")'=1 D  ;Not POA Exempt
 . . S ICDPR(1)="Diagnosis "_$$GET1^DIQ(80,ICDDX123,.01,"I")_" is not contained in the POA Exempt list so the POA field should"
 . . S ICDPR(2)="not be blank. If left blank, it will be treated as if it were a No (""N"")."
 . . D EN^DDIOL(.ICDPR)
 . . K DIR S DIR(0)="Y",DIR("A")="Do you wish to continue? (Y/N)",DIR("B")="YES" D ^DIR I ($D(DTOUT))!($D(DUOUT))!($D(DIROUT)) S QUIT=1
 . . I Y=0 S QUIT=1 Q
 . . S Y="N" ;This may subsequently be removed if the DX is on the HAC list - see $$HAC^ICDDRGM
 . E  S Y="Y"
 E  S Y=X
 I QUIT Q -1
 Q Y
 ;
DXSCRN ;Diagnoses review of POA and HAC indicators; ALB/JAM *64 ICD10 changes
 N I,X,ICDDX123,ICDTMPX,ICDTMPOA,C,ICDOUT
 ;if POA value does not exist for Primary DX set to "U"nknown
 I '$D(ICDPOA(1)) S ICDPOA(1)="U"
 S X=1
 F  S X=$O(ICDDX(X)) Q:'X  S ICDOUT=0 D
 .;if POA value does not exist for DX set to "U"nknown
 .I '$D(ICDPOA(X)) S ICDPOA(X)="U"
 .;if DX is POA exempt include in DRG calculation
 .S ICDDX123=ICDDX(X) I $$GET1^DIQ(80,ICDDX123,1.9,"I") Q
 .;if POA value for DX is Y or W include in DRG calculation
 .F I="Y","W" I ICDPOA(X)=I S ICDOUT=1 Q
 .I ICDOUT Q
 .;if DX not in HAC list include in DRG calculation
 .F I="N","U",1 I ICDPOA(X)=I,'$$HAC(ICDDX123) S ICDOUT=1 Q
 .I ICDOUT Q
 .I ICDPOA(X)="",'$$HAC(ICDDX123) S ICDOUT=1 Q
 .I ICDOUT Q
 .; remove entry from ICDDX and ICDPOA array 
 .K ICDDX(X),ICDPOA(X)
 ; resequence entries in ICDDX and ICDPOA array
 M ICDTMPX=ICDDX,ICDTMPOA=ICDPOA
 K ICDDX,ICDPOA
 S C=0
 S X=0 F  S X=$O(ICDTMPX(X)) Q:'X  S C=C+1,ICDDX(C)=ICDTMPX(X),ICDPOA(C)=ICDTMPOA(X)
 Q
 ;
HAC(ICDDX123) ; Check if diagnosis code is in Hospital Acquired Conditions (HACS) file #80.6
 ;Input DX - Diagnosis code IEN, pointer to file #80
 ;Output   - 1 if the DX code is found in file #80.6
 ;           0 if the DX code not found in the file
 ;
 I $D(^ICDHAC("C",ICDDX123)) Q 1
 Q 0
 ;
ICD9OP ; ICD-9 PROCEDURE CODE SEARCH
 S IENT="I"
 S DIC("S")="I $P($$ICDOP^ICDEX(+$G(Y),$G(ICDDATE),ICDCDSY,IENT),U,1)>0,+$P($$ICDOP^ICDEX(+$G(Y),$G(ICDDATE),ICDCDSY,IENT),U,10)'=0"
 S DIC("A")="Enter Operation/Procedure "_ICDCV_": "
 S DIC(0)="AEQMZI"   ;,DIC("S")="I $P($$ICDOP^ICDEX($G(Y),$G(ICDDATE),ICDCDSY,IENT),U,1)>0"
 S Y=$$SEARCH^ICDSAPI(80.1,DIC("S"),DIC(0),$G(ICDDATE))
 Q
 ;
HELPPOA ;
 W !?5,"Apply the Present on Admission (POA) indicator for each diagnosis"
 W !?5,"and external cause of injury code(s) reported as the final set of"
 W !?5,"diagnosis codes assigned.  One of the following values should be"
 W !?5,"assigned in accordance with the official coding guidelines:"
 W !?5,""
 W !?5,"Y = present at the time of inpatient admission;"
 W !?5,"N = not present at the time of inpatient admission;"
 W !?5,"U = documentation is insufficient to determine if"
 W !?5,"    condition is present on admission;"
 W !?5,"W = provider is unable to clinically determine"
 W !?5,"    whether condition was present on admission or not"
 W !?5,"<enter> = use only if diagnosis is exempt from POA reporting"
 Q
 ;
PROC ; Ask Procedure
 N DIR,ICDXX1
 S ICDXX1=1 S ICDPRC=""
 S DIR(0)="FAO^1:12"
 S DIR("A")="Enter Operation/Procedure (ICD 10):"
 S DIR("?")="^D P1^ICDDRGM",DIR("??")="^D P2^ICDDRGM"
 D ^DIR
 I $D(DTOUT)!($D(DUOUT))!($D(DIRUT))!($D(DIROUT))!(Y="") S Y=-1 Q
 ;I X["*" S X=$P(X,"*",1)
 S ICDPRC=X
 ;I X["*" S X=$P(X,"*",1)_$P(X,"*",2)
 D ASK^ICDCODLK
 Q Y
P1 ;
 I X["???" D P3 Q  ;For calls from ^DIR, doesn't support ??? help
 I X["??" D P2 Q
 D EN^DDIOL("Enter the initial character(s) of an ICD-10 partial code or an","","!?5")
 D EN^DDIOL("asterisk (*) for more information.","","!?5")
 D EN^DDIOL(" ")
 Q
 ;
P2 ;
 D EN^DDIOL("1. Enter an ICD-10 Procedure Code.","","!?8")
 D EN^DDIOL("      or  ","","!?8")
 D EN^DDIOL("2. Enter any alphanumeric char values of the procedure code to 'build'","","!?8")
 D EN^DDIOL("   an ICD-10 Procedure Code.","","!?8")
 D EN^DDIOL("      or  ","","!?8")
 D EN^DDIOL("3. Enter an asterisk (*) to initiate a procedure code build search. ","","!?8")
 D EN^DDIOL(" ")
 Q
 ;
P3 ;
 D EN^DDIOL("The procedure code search provides a 'decision tree' type structure","","!?8")
 D EN^DDIOL("that makes use of the specific ICD-10-PCS code format and structure,","","!?8")
 D EN^DDIOL("where all codes consist of 7 alphanumeric characters, with each","","!?8")
 D EN^DDIOL("position in the code having a specific meaning.","","!?8")
 D EN^DDIOL(" ")
 Q
 ;
