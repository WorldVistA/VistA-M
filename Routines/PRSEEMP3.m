PRSEEMP3 ;WIRMFO/JAH-STUDENT TRAINING REPORT BY SERVICE ;7/2/97
 ;;4.0;PAID;**25**;Sep 21, 1995
 ;%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
EN1 ;
 N PRSE132,CCORG,PRSERV,ZZ,SERVIEN,CLOCK,HWIDE,X,DATSEL,POUT
 N CEU,PRESEL,SERCNT,EMPCNT,CCOCNT,YRST,YREND,REPDT
 ;set spin clock counter
 S CLOCK=1
 ;
 ;If user has PRSE CORD key/programmer continue
 I '(+$$EN4^PRSEUTL3($G(DUZ))!(DUZ(0)["@")) D MSG22^PRSEMSG S ZZ=$$ASK^PRSLIB00(1) Q
 ;
 ;Check 2 make sure Educ. Track. is Online
 S X=$G(^PRSE(452.7,1,"OFF"))
 I X=""!(X=1) D MSG6^PRSEMSG S ZZ=$$ASK^PRSLIB00(1) Q
 ;
 S (POUT,NPC,NSW1)=0,HOLD=1
 ;
 ;Ask date range/fiscal/calender year.  YRST, YREND returned as range.
 W ! S DATSEL="N+"
 D DATSEL^PRSEUTL G:$G(POUT) EXIT^PRSEEMP4
 ;
 ;Ask type of training 2 search. Code 4 search returned in PRSESEL.
 ;M:Mandatory  C:Continuing Educ  O:Other  W:Ward/Unit-Locat
 ;A:All      ;L:All without Mandatory
 D INS2^PRSEUTL G EXIT^PRSEEMP4:$G(POUT)
 ;
 ;set flag when selection contains CEU type classes.
 S CEU=0
 I PRSESEL="C"!(PRSESEL="A")!(PRSESEL="L")!(PRSESEL="H") S CEU=1
 ;
 ; find hospital wide classes 2 screen out of report
 I PRSESEL="H" D HWLIST^PRSEEMP4,HASHLIST^PRSEEMP4
 ;
 ;call 2 select 1,many,all services.
 N DIC,Y
 S DIC="^PRSP(454.1,"
 S VAUTSTR="Service"
 S VAUTNI=2,VAUTVB="PRSERV"
 D FIRST^VAUTOMA
 ;
 ;quit if user ^ at service prompt
 Q:Y<0
 ;
 W ! S ZTRTN="START^PRSEEMP3",ZTDESC="TRAINING REPORT BY SERVICE" D L,DEV^PRSEUTL G:POP!($D(ZTSK)) EXIT^PRSEEMP4
START ;
 U IO
 ;initialize temp global and set unknown entry in job table.
 K ^TMP($J),^TMP("JOBS",$J)
 S ^TMP("JOBS",$J,0)="unknown"
 ;
 I $E(IOST,1,2)="C-" D
 . D MSSG^PRSLIB00(.MSG)
 . D MONOGRPH^PRSLIB00(MSG)
 S (PHRS,PHRS("CEU"),PHRS("CON"),PCOUNT)=0,PRSE132=$S(IOM'<132:132,1:0)
 ;
 ;If user selects all services then fill up PRSERV array
 I PRSERV=1 D ALLSERV(.PRSERV)
 ;
 ;Drive thru services user has selected. They may select 1,many,all
 ;or abort. If user selects 1 or 1+, PRSERV(ien)=selection(s), 
 ;PRSERV=0.  If user selects ALL, PRSERV=1
 N SERVICE,SERVIEN,EMPIEN,EMPNAME,CCIEN,CCORG
 S (SERVIEN,POUT,SRVCNT)=0
 F  S SERVIEN=$O(PRSERV(SERVIEN))  Q:SERVIEN=""!(POUT)  D
 . S SRVCNT=SRVCNT+1
 . S SERVICE=PRSERV(SERVIEN)
 .;
 .;There r many Cost Ctrs 4 each service.  Use cost ctrs
 .;2 find all employees in service.
 . S CCIEN=0
 . F  S CCIEN=$O(^PRSP(454,1,"ORG","C",SERVIEN,CCIEN))  Q:CCIEN=""!(POUT)  D
 ..  S CCORG=$P(^PRSP(454,1,"ORG",CCIEN,0),"^",1)
 ..  S CCORG=$P(CCORG,":",1)_$P(CCORG,":",2)
 ..;
 ..; Get employees w/in cost ctr
 ..  S EMPIEN=0
 ..  F  S EMPIEN=$O(^PRSPC("ACC",CCORG,EMPIEN))  Q:EMPIEN=""!(POUT)  D
 ...   S EMPNAME=$P($G(^PRSPC(EMPIEN,0)),"^",1)
 ...   S EMPOINT=$G(^PRSPC(EMPIEN,200))
 ...   I EMPOINT'="" D SORT^PRSEEMP4(EMPOINT)
 ;
 S (SERCNT,EMPCNT,CCOCNT)=0
 ;get date for report
 S X="T" D ^%DT S REPDT=+Y
 ;Drive thru services & cost ctr/orgs 2 print output 4 employees
 S SERVIEN=0
 F  S SERVIEN=$O(^TMP($J,SERVIEN))  Q:SERVIEN'>0!(POUT)  D
 . S SERVICE=PRSERV(SERVIEN)
 . S SERCNT=SERCNT+1
 .;Initialize cost ctr global & counters
 . D INITCC(.CCORG)
 . F  S CCORG=$O(^TMP($J,SERVIEN,CCORG))  Q:CCORG=""!(POUT)  D
 ..  S CCOCNT=CCOCNT+1
 ..  S EMPIEN=""
 ..  F  S EMPIEN=$O(^TMP($J,SERVIEN,CCORG,EMPIEN))  Q:EMPIEN=""!(POUT)  D
 ...   D INITEMP^PRSEEMP3 ;initialize course counters 4 employee
 ...   S EMPCNT=EMPCNT+1
 ...   S EMPNODE=^TMP($J,SERVIEN,CCORG,EMPIEN,0)
 ...   S DATA=$P(EMPNODE,"^",1)
 ...   S JOBCODE=$P(EMPNODE,"^",2)
 ...   S EMPNAME=$P(EMPNODE,"^",3)
 ...   D OUTPUT^PRSEEMP4(EMPIEN,.POUT,JOBCODE,EMPNAME)
 I POUT S ^TMP("EORM",$J,2)="- Incomplete report.  User aborted."
 D STATS,MSSGS
 D EXIT^PRSEEMP4
 Q
 ;%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
STATS ;
 N HDR,UND,TAB1,PTAB
 S HDR="END OF TRAINING REPORT BY SERVICE"
 S UND="================================="
 S PTAB=(IOM-9)
 S TAB1=($G(IOM)/2-($L(HDR)/2)) ;center hdr on page
 W @IOF,?PTAB,"PAGE ",NPC+1
 W !,?TAB1,HDR,!,?TAB1,UND
 W !,"Employees counted:     ",EMPCNT
 W !,"Services counted:      ",SERCNT
 W !,"Cost Centers counted:  ",CCOCNT
 Q
 ;%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
MSSGS ;Write any messages that we've created during processing.
 N EOR
 W !,"----------------",!
 ;
 S EOR="" F  S EOR=$O(^TMP("EORM",$J,EOR))  Q:EOR=""  D
 .W !,^TMP("EORM",$J,EOR)
 W !
 Q
 ;%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
ALLSERV(PRSERV) ; Put all services in PAID COST CTR/ORGANIZATION file
 ;in2 PRSERV() array, subscripted by IEN = "service name".
 S SERVICE=""
 F  S SERVICE=$O(^PRSP(454.1,"B",SERVICE))  Q:SERVICE=""  D
 .S SERVIEN=0,SERVIEN=$O(^PRSP(454.1,"B",SERVICE,SERVIEN))
 .I SERVIEN'="",$G(^PRSP(454.1,SERVIEN,0))'="" S PRSERV(SERVIEN)=SERVICE
 Q
 ;%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
INITCC(CCORG) ;INITIALIZE COST CTR STUFF
 K ^TMP($J,"CC")
 S CCORG=""
 Q
 ;%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
INITEMP ;initialize all counters 4 an employee
 S (PCOUNT,PHRS,PHRS("CEU"),PHRS("CON"))=0
 Q
 ;%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
L F X="PHRS*","PCOUNT","PYR","PRDA","YRST","YREND","HOLD","PRSECLS","PRSESEL","POUT","NPC","NSW1","TYP","PRSERV*","PRSERV(","CEU" S ZTSAVE(X)=""
 Q
 ;%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
