FBAAUTL ;AISC/GRR,SBW-Fee Basis Utility Routine ; 4/23/10 3:06pm
 ;;3.5;FEE BASIS;**101,114,108,124**;JAN 30, 1995;Build 20
 ;;Per VHA Directive 2004-038, this routine should not be modified.
DATE N FBDT S FBPOP=0 K BEGDATE,ENDDATE K:$G(%DT)'["A" %DT W !!,"**** Date Range Selection ****"
 S FBDT=$S($D(%DT):1,1:0) W ! S %DT=$S(FBDT:%DT,1:"APEX"),%DT("A")="   Beginning DATE : " D ^%DT S:Y<0 FBPOP=1 Q:Y<0  S (%DT(0),BEGDATE)=Y
 W ! S %DT=$S(FBDT:%DT,1:"AEX"),%DT("A")="   Ending    DATE : " D ^%DT K %DT S:Y<0 FBPOP=1 Q:Y<0  W ! S ENDDATE=Y
 Q
 ;
ZIS S ZTRTN=PGM,ZTSAVE="",FBPOP=0 F I=1:1 Q:$P(VAR,"^",I)']""  S ZTSAVE($P(VAR,"^",I))=""
 I '$D(ZTDESC) S ZTDESC=$S($D(PGM):PGM,1:"UNKNOWN OPTION")
 W ! S %ZIS="QMP" D ^%ZIS S:POP FBPOP=1 Q:POP  I $D(IO("Q")) K IO("Q"),ZTIO D ^%ZTLOAD W:$D(ZTSK) !,*7,"REQUEST QUEUED",!,"Task #: ",$G(ZTSK) K I,ZTSK,ZTIO,ZTSAVE,ZTRTN D HOME^%ZIS S FBPOP=1 Q
 Q
 ;
CLOSE I '$D(ZTQUEUED) D ^%ZISC
 K IOP,ZTDESC,ZTRTN,ZTSAVE,ZTDTH,VAR,VAL,PGM,FBPOP,POP Q
 ;
D S Y=$P("JAN^FEB^MAR^APR^MAY^JUN^JUL^AUG^SEP^OCT^NOV^DEC","^",$E(Y,4,5))_" "_$S(Y#100:$J(Y#100\1,2)_",",1:"")_(Y\10000+1700)_$S(Y#1:"  "_$E(Y_0,9,10)_":"_$E(Y_"000",11,12),1:"") Q
SITEP ;SET FBSITE(0),FBSITE(1) VARIABLE TO FEE SITE PARAMETERS
 S FBPOP=0,FBSITE(0)=$G(^FBAA(161.4,1,0)) S:FBSITE(0)']"" FBPOP=1
 S FBSITE(1)=$G(^FBAA(161.4,1,1)) S:FBSITE(1)']"" FBPOP=1
 S FBSITE("FBNUM")=$G(^FBAA(161.4,1,"FBNUM")) S:FBSITE("FBNUM")']"" FBPOP=1
 W:FBPOP !,*7,"Fee Basis Site Parameters must be entered to proceed",!
 Q
TM S X=$E($P(X,".",2)_"0000",1,4),%=X>1159 S:X>1259 X=X-1200 S X=X\100_":"_$E(X#100+100,2,3)_" "_$E("AP",%+1)_"M" Q
PDF S:Y Y=$E(Y,4,5)_"/"_$E(Y,6,7)_"/"_$E(Y,2,3) Q
GETNXB ;GET NEXT AVAILABLE BATCH NUMBER
 L +^FBAA(161.4):$G(DILOCKTM,3) I '$T D  G GETNXB
 .W !,"Another user is opening a batch.  Trying again.",!
 I '$D(^FBAA(161.4,1,"FBNUM")) S ^FBAA(161.4,1,"FBNUM")="1^1"
 I '$P($G(^FBAA(161.4,1,"FBNUM")),"^") S $P(^("FBNUM"),"^")=1
 S FBBN=$P(^FBAA(161.4,1,"FBNUM"),"^")
 ;I FBBN>99899,$S('$D(^FBAA(161.4,1,"PURGE")):1,$P(^FBAA(161.4,1,"PURGE"),"^",1)'>0:1,1:"") D WARNBT
 I $P(^FBAA(161.7,0),U,4)>99899 D WARNBT ;*114
 S $P(^FBAA(161.4,1,"FBNUM"),"^",1)=$S(FBBN+1>99999:1,1:FBBN+1) I '$$CHKBI^FBAAUTL4(FBBN,1) L -^FBAA(161.4) G GETNXB
 L -^FBAA(161.4) Q
WARNBT W !,*7,"There are ",99999-FBBN," batches left before the BATCH PURGE routine",!,"needs to be run. Contact your IRM Service!",!!
 Q
GETNXI ;GET NEXT AVAILABLE INVOICE NUMBER 
 L +^FBAA(161.4):$G(DILOCKTM,3) I '$T D  G GETNXI
 .W !,"Another user is obtaining an invoice number.  Trying again.",!
 I '$D(^FBAA(161.4,1,"FBNUM")) S ^FBAA(161.4,1,"FBNUM")="1^1"
 I '$P($G(^FBAA(161.4,1,"FBNUM")),U,2) S $P(^("FBNUM"),U,2)=1
 S FBAAIN=$P(^FBAA(161.4,1,"FBNUM"),"^",2),$P(^("FBNUM"),"^",2)=$S(FBAAIN+1>9999999:1,1:FBAAIN+1) I '$$CHKBI^FBAAUTL4(FBAAIN) L -^FBAA(161.4) G GETNXI
 L -^FBAA(161.4) Q
PDATE S FBPDT=$P("January^February^March^April^May^June^July^August^September^October^November^December","^",$E(Y,4,5))_" "_$S(Y#100:$J(Y#100\1,2)_", ",1:"")_(Y\10000+1700)_$S(Y#1:"  "_$E(Y_0,9,10)_":"_$E(Y_"000",11,12),1:"") Q
DATCK S HOLDY=Y,HOLDY=$S($P(HOLDY,"^",2):$P(HOLDY,"^",2),1:HOLDY)
 I $D(FBAAID),Y>FBAAID D  K X Q
 .N SHODAT S SHODAT=$E(FBAAID,4,5)_"/"_$E(FBAAID,6,7)_"/"_$E(FBAAID,2,3)
 .W !!,*7,?5,"*** Date of Service cannot be later than",!?8," Invoice Received Date ("_SHODAT_") !!!",!
 I $D(FBAABDT),$D(FBAAEDT),(Y<FBAABDT!(Y>FBAAEDT)) D  K X
 .N PRIORLAT,AUTHDAT,SHODAT
 .S PRIORLAT=$S($P(Y,"^",2)<FBAABDT:"prior to ",1:"later than ")
 .S AUTHDAT=$S($P(Y,"^",2)<FBAABDT:FBAABDT,1:FBAAEDT)
 .S SHODAT=$E(AUTHDAT,4,5)_"/"_$E(AUTHDAT,6,7)_"/"_$E(AUTHDAT,2,3)
 .W !!,*7,?5,"*** Date of Service cannot be ",PRIORLAT
 .W !?8," Authorization period ("_SHODAT_") !!!",!
 S Y=HOLDY Q
 ;
DATX(X) ;external output function for date format
 ;INPUT = FM internal date format (time optional)
 ;OUTPUT = date/time with slashes
 Q $$FMTE^XLFDT(X,2)
 ;
STATION ;GET STATION NUMBER FROM INSTITUTION FILE
 I '$D(FBSITE(1)) D SITEP
 I $S('$D(FBSITE(1)):1,$P(FBSITE(1),"^",3)="":1,'$D(^DIC(4,$P(FBSITE(1),"^",3),0)):1,'$D(^DIC(4,$P(FBSITE(1),"^",3),99)):1,'+$P(^DIC(4,$P(FBSITE(1),"^",3),99),"^"):1,1:0) G NOSTA
 S (FBSN,FBAASN)=$S($D(^DIC(4,$P(FBSITE(1),"^",3),99)):$E(^(99),1,3),1:999)
 Q
NOSTA S FB("ERROR")=1 I '$D(ZTQUEUED) W !!,*7,"Unable to determine Station Number. Check Fee Site Parameters or Station Number in the Institution File.",!!
 Q
 ;
HD ;set transmission header
 I '$D(FBSITE(1)) S FBSITE(1)=$G(^FBAA(161.4,1,1))
 S FBHD=$$HDR^FBAAUTL3() I FBHD']"" S FB("ERROR")=1 W !,"Transmission header must exist in FEE BASIS SITE PARAMETER file",!,"before you can proceed.",*7,!
 Q
 ;
SSN(PID,BID,DOD) ;
 ;PID = DFN of Patient. If this is all that is past,
 ;full Pt.ID (000-00-0000) will be returned.
 ;If BID = 1 the call will return last 4 of Pt.ID only.
 ;If DOD is defined to internal entry # of eligibility the appropriate
 ;Pt.ID will be returned.
 N DFN,FBSSN
 S DFN=PID
 I 'DFN Q "Unknown"
 S:'$D(BID) BID="" S:$D(DOD) VAPTYP=DOD
 D PID^VADPT6 I VAERR K VAERR Q "Unknown"
 S FBSSN=$S(BID:VA("BID"),1:VA("PID"))
 K VA("BID"),VA("PID"),VAERR,VAPTYP
 Q FBSSN
 ;
SSNL4(SSN) ;Convert 1st 5 digits of SSN to X (Only print last 4 digits of SSN)
 ;Input:
 ;   SSN - SSN in 9 digit or ###-##-#### format
 ;     Pseudo SSN is also allowed as input
 ;Output
 ;   SSN - SSN in XXXXX#### or XXX-XX-#### format
 ;     Pseudo SSN will be changed as above with passed "P" at end
 ; X represent actual X and # represent digit
 ;
 S SSN=$G(SSN)
 ;Change SSN ######### to XXXXX####
 S:SSN?9N0.1"P" $E(SSN,1,5)="XXXXX"
 ;Change SSN ###-##-#### to XXX-XX-####
 S:SSN?3N1"-"2N1"-"4N0.1"P" $E(SSN,1,7)="XXX-XX-"
 Q SSN
