PXRMPTL ; SLC/DLT,PKR,PJH - Print Clinical Reminders logic; 01/07/2008
 ;;2.0;CLINICAL REMINDERS;**4,12**;Feb 04, 2005;Build 73
 ;
 ;====================================================
BLDFLST(RITEM,FL) ;Build the list of findings defined for this reminder.
 N IC,TEMP,GLOB,SUB,NAME
 ;Build a list of findings.
 S IC=0
 F  S IC=$O(^PXD(811.9,RITEM,20,IC)) Q:+IC=0  D
 . S TEMP=$P(^PXD(811.9,RITEM,20,IC,0),U)
 . S GLOB=$P(TEMP,";",2),SUB=$P(TEMP,";")
 . S NAME=$S(GLOB="":"???",1:$P($G(@(U_GLOB_SUB_",0)")),U))
 . S FL(IC)=NAME
 Q
 ;
 ;====================================================
CDUE(CDUE,FL,NL,ARRAY) ;Expand the custom date due string into ARRAY.
 N ARGL,FI,FREQ,IND,OPER,NARGS,PFSTACK,TEMP
 K ARRAY
 S OPER=","
 D POSTFIX^PXRMSTAC(CDUE,OPER,.PFSTACK)
 S ARRAY(1)=PFSTACK(1)_"(",NL=1
 S NARGS=0
 F IND=2:1:PFSTACK(0) D
 . I PFSTACK(IND)=OPER Q
 . S NARGS=NARGS+1,ARGL(NARGS)=PFSTACK(IND)
 F IND=1:1:NARGS D
 . S TEMP=ARGL(IND)
 . S FI=$P(TEMP,"+",1)
 . S FREQ=$P(TEMP,"+",2)
 . S TEMP=FL(FI)_" + "_FREQ
 . S NL=NL+1
 . S ARRAY(NL)=$S(IND<NARGS:TEMP_", ",1:TEMP)
 S NL=NL+1,ARRAY(NL)=")"
 Q
 ;
 ;====================================================
COHORT(DA) ;
 N ARRAY,CNT,LINE,NODE,NLINES,OUTPUT
 F NODE=60,61,65,66,70,71,75,76  I $D(^PXD(811.9,DA,NODE))>0 D
 . I NODE=60 W !,"General Patient Cohort Found Text:"
 . I NODE=61 W !,"General Patient Cohort Not Found Text:"
 . I NODE=65 W !,"General Resolution Found Text:"
 . I NODE=66 W !,"General Resolution Not Found Text:"
 . I NODE=70 W !,"Summary Patient Cohort Found Text:"
 . I NODE=71 W !,"Summary Patient Cohort Not Found Text:"
 . I NODE=75 W !,"Summary Resolution Found Text:"
 . I NODE=76 W !,"Summary Resolution Not Found Text:"
 . S (CNT,LINE)=0 F  S LINE=$O(^PXD(811.9,DA,NODE,LINE)) Q:LINE=""  D
 .. S CNT=CNT+1 S ARRAY(CNT)=$G(^PXD(811.9,DA,NODE,LINE,0))
 . I $D(ARRAY)>0 D FORMAT^PXRMTEXT(5,78,CNT,.ARRAY,.NLINES,.OUTPUT)
 . I NLINES>0 F CNT=1:1:NLINES  W !,OUTPUT(CNT)
 . W !
 Q
 ;
 ;====================================================
DISLOG ;Display the patient cohort, resolution logic, and custom date due.
 ;Determine if this is a default adhoc logic or user modified logic
 N CDUE,CUSTOM,FL,IND,LARRAY,LOGSTR,MAXLEN,NLOGLIN,NPL
 N PARRAY,RITEM,SEP
 S MAXLEN=72
 ;Build the list of findings for this reminder.
 S RITEM=D0
 D BLDFLST(RITEM,.FL)
 ;
 ;Get the cohort logic string.
 S LOGSTR=$G(^PXD(811.9,RITEM,30))
 ;Otherwise use internal cohort logic
 I LOGSTR="" S LOGSTR=$G(^PXD(811.9,RITEM,31)),CUSTOM=0
 E  S CUSTOM=1
 ;
 ;Remove any (0)! and (1)& entries
 S LOGSTR=$$REMOVE(LOGSTR)
 ;
 ;Break the logic string into an array using the Boolean operators
 ;and the comma as separators.
 S SEP="'!&<>=,"
 S NLOGLIN=$$STRARR(LOGSTR,SEP,.LARRAY)
 ;
 ;Print the cohort logic.
 I CUSTOM  W "Customized PATIENT COHORT LOGIC to see if the Reminder applies to a patient:"
 E  W "Default PATIENT COHORT LOGIC to see if the Reminder applies to a patient:"
 S NPL=$$FMTARR(MAXLEN,NLOGLIN,.LARRAY,.PARRAY)
 F IND=1:1:NPL W !,?1,PARRAY(IND)
 ;
 ;Expand the logic and print it.
 D EXPAND(NLOGLIN,.LARRAY,.FL,"FI(",")")
 S NPL=$$FMTARR(MAXLEN,NLOGLIN,.LARRAY,.PARRAY)
 W !!,"Expanded Patient Cohort Logic:"
 F IND=1:1:NPL W !,?1,PARRAY(IND)
 ;
 ;Get the resolution logic string.
 S LOGSTR=$G(^PXD(811.9,RITEM,34))
 ;Otherwise use internal cohort logic
 I LOGSTR="" S LOGSTR=$G(^PXD(811.9,RITEM,35)),CUSTOM=0
 E  S CUSTOM=1
 ;
 ;Remove any (0)! and (1)& entries
 S LOGSTR=$$REMOVE(LOGSTR)
 ;
 ;Break the logic string into an array using the Boolean operators
 ;and the comma as separators.
 S NLOGLIN=$$STRARR(LOGSTR,SEP,.LARRAY)
 ;
 ;Print the resolution logic.
 W !!
 I CUSTOM  W "Customized RESOLUTION LOGIC defines findings that resolve the Reminder:"
 E  W "Default RESOLUTION LOGIC defines findings that resolve the Reminder:"
 S NPL=$$FMTARR(MAXLEN,NLOGLIN,.LARRAY,.PARRAY)
 F IND=1:1:NPL W !,?1,PARRAY(IND)
 ;
 ;Expand the logic and print it.
 D EXPAND(NLOGLIN,.LARRAY,.FL,"FI(",")")
 S NPL=$$FMTARR(MAXLEN,NLOGLIN,.LARRAY,.PARRAY)
 W !!,"Expanded Resolution Logic:"
 F IND=1:1:NPL W !,?1,PARRAY(IND)
 ;
 ;Display the custom date due string.
 S CDUE=$G(^PXD(811.9,D0,45))
 I CDUE="" Q
 W !!,"Custom Date Due:"
 W !," ",CDUE
 D CDUE(CDUE,.FL,.NLOGLIN,.LARRAY)
 S NPL=$$FMTARR(MAXLEN,NLOGLIN,.LARRAY,.PARRAY)
 W !!,"Expanded Custom Date Due:"
 F IND=1:1:NPL W !,?1,PARRAY(IND)
 Q
 ;
 ;====================================================
DISLOGF(RITEM,FINDING,FL,PARRAY) ;Expand FUNCTION FINDING logic and
 ;return the result in PARRAY.
 N ARGNUM,AT,FARG,FUN,FUNCTION,FUNSTR,IND,ISFUN,MAXLEN,LARRAY
 N NAME,NLOGLIN,NPL,NUM,SEP,TEMP
 S MAXLEN=72
 K PARRAY
 ;Get the function string.
 S FUNSTR=$G(^PXD(811.9,RITEM,25,FINDING,3))
 I FUNSTR="" Q
 ;
 ;Establish the list of separators that can be used in the logic
 ;string and take it apart.
 S SEP="'!&=><,()+-"
 S NLOGLIN=$$STRARR(FUNSTR,SEP,.LARRAY)
 ;Replace argument numbers with the finding.
 S FARG=0
 F IND=1:1:NLOGLIN D
 . S TEMP=LARRAY(IND)
 . I TEMP="" Q
 . S FUN=$P(TEMP,"(",1)
 . S ISFUN=$S(FUN="":0,$D(^PXRMD(802.4,"B",FUN)):1,1:0)
 . I ISFUN S FARG=1,FUNCTION=$TR(FUN,"_",""),ARGNUM=0 Q
 . I FARG D
 .. S NUM=+TEMP
 .. S ARGNUM=ARGNUM+1
 .. S AT=$$ARGTYPE^PXRMFFAT(FUNCTION,ARGNUM)
 .. I AT="F" D
 ... S NAME=$S($D(FL(NUM)):FL(NUM),1:"???")
 ... S LARRAY(IND)=$$STRREP^PXRMUTIL(LARRAY(IND),NUM,NAME)
 ..E  S LARRAY(IND)=TEMP
 . I TEMP[")" S FARG=0
 ;Format the array for printing.
 S NPL=$$FMTARR(MAXLEN,NLOGLIN,.LARRAY,.PARRAY)
 Q
 ;
 ;====================================================
EXPAND(NL,ARRAY,FL,LT,RT) ;Insert findings in FI(n) format. Each element
 ;of ARRAY will contain no more than one FI.
 N FIE,FIS,FNUM,LEN,NAME,STRING
 F IND=1:1:NL D
 . S STRING=ARRAY(IND)
 . S FIS=$F(STRING,LT)
 . I FIS=0 Q
 . S LEN=$L(STRING)
 . S FIE=$F(STRING,RT,FIS)-2
 . S FNUM=$E(STRING,FIS,FIE)
 . S NAME=$S($D(FL(FNUM)):FL(FNUM),1:"???")
 . S ARRAY(IND)=$E(STRING,1,FIS-1)_NAME_$E(STRING,FIE+1,LEN)
 Q
 ;
 ;====================================================
FMTARR(MAXLEN,NE,INARRAY,OUTARRAY) ;Load the output array.
 N IC,LINNUM,SLEN
 K OUTARRY
 S OUTARRAY(1)=""
 S LINNUM=1
 F IC=1:1:NE D
 . S SLEN=$L(OUTARRAY(LINNUM))+$L(INARRAY(IC))
 . I SLEN>MAXLEN D
 .. S LINNUM=LINNUM+1
 .. S OUTARRAY(LINNUM)=INARRAY(IC)
 . E  S OUTARRAY(LINNUM)=OUTARRAY(LINNUM)_INARRAY(IC)
 Q LINNUM
 ;
 ;====================================================
STRARR(STRING,SEP,ARRAY) ;Break STRING into an array using SEP.
 N CHAR,IC,LINNUM,NE,SLEN,TEMP
 K OUTARRAY
 ;Break string into pieces using SEP.
 S SLEN=$L(STRING)
 S LINNUM=0,TEMP=""
 F IC=1:1:SLEN D
 . S CHAR=$E(STRING,IC,IC)
 . S TEMP=TEMP_CHAR
 . I SEP[CHAR D
 .. S LINNUM=LINNUM+1
 .. S ARRAY(LINNUM)=TEMP
 .. S TEMP=""
 S LINNUM=LINNUM+1
 S ARRAY(LINNUM)=TEMP
 Q LINNUM
 ;
 ;====================================================
REMOVE(STRING) ;Remove leading (n) entries
 I ($E(STRING,1,4)="(0)!")!($E(STRING,1,4)="(1)&") S $E(STRING,1,4)=""
 Q STRING
 ;
