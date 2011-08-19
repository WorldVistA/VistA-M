DGMTUTL ;ALB/CAW/BRM/LBD - Means Test generic utilities ; 8/12/02 4:33pm
 ;;5.3;Registration;**3,31,166,182,454,688**;Aug 13, 1993;Build 29
 ;
FDATE(Y) ; -- return formatted date
 ;   input:          Y := field name
 ;  output: [returned] := formatted date only
 N DGY
 S DGY=$$FMTE^XLFDT(Y,"5F"),DGY=$TR(DGY," ","0")
 Q DGY
 ;
FTIME(Y) ; -- return formatted date/time
 ;   input:          Y := internal date/time
 ;  output: [returned] := formatted date and time
 D DD^%DT
 Q Y
 ;
RANGE(WHEN) ; select date range
 ;  input:  WHEN := past or future dates (optional)
 ; output: DGBEG := begin date
 ;         DGEND := end date
 ; return: was selection made [ 1|yes   0|no]
 W !!,$$LINE("Date Range Selection")
DATE S DIR(0)="D^::EX",DIR("A")="Enter Beginning Date",DIR("?")="^D HELP^%DTC" D ^DIR K DIR G:$D(DIRUT) RANGEQ S DGBEG=Y
 I $G(WHEN)="P",DGBEG>(DT_.9999) W !,"   Future dates are not allowed.",*7 K DGBEG G DATE
 I $G(WHEN)="F",(DGBEG_.9999)<DT W !,"   Past dates are not allowed.",*7 K DGBEG G DATE
 ;select ending date
 S DIR(0)="D^::EX",DIR("A")="Enter Ending Date",DIR("?")="^D HELP^%DTC" D ^DIR K DIR G:$D(DIRUT) RANGEQ
 S DGEND=Y
 I $G(WHEN)="P",DGEND>(DT_.9999) W !,"   Future dates are not allowed.",*7 K DGEND G DATE
 I $G(WHEN)="F",(DGEND_.9999)<DT W !,"   Past dates are not allowed.",*7 K DGEND G DATE
 I DGEND<DGBEG W !!,"Beginning Date must be prior to Ending Date" K DGEND G DATE
RANGEQ Q $D(DGEND)
 ;
DIV() ; -- get division data
 ;  input: none
 ; output: VAUTD := divs selected (VAUTD=1 for all)
 ; return: was selection made [ 1|yes   0|no]
 ;
 W:$P($G(^DG(43,1,"GL")),U,2) !!,$$LINE("Division Selection")
 D ASK2 I Y<0 K VAUTD
 Q $D(VAUTD)>0
 ;
CLINIC() ; -- get clinic data
 ;  input: VAUTD  := divisions selected
 ; output: VAUTC := clinic selected (VAUTC=1 for all)
 ; return: was selection made [ 1|yes   0|no]
 ;
 W !!,$$LINE("Clinic Selection")
 S DIC("S")="I $S(VAUTD:1,$D(VAUTD(+$P(^SC(Y,0),U,15))):1,'+$P(^(0),U,15)&$D(VAUTD(+$O(^DG(40.8,0)))):1,1:0)"
 S DIC="^SC(",VAUTSTR="clinic",VAUTVB="VAUTC",VAUTNI=2
 D FIRST^VAUTOMA
 I Y<0 K VAUTC
CLINICQ Q $D(VAUTC)>0
 ;
 ;
LINE(STR) ; -- print line
 ;  input: STR := text to insert
 ; output: none
 ; return: text to use
 ;
 N X
 S:STR]"" STR=" "_STR_" "
 S $P(X,"_",(IOM/2)-($L(STR)/2))=""
 Q X_STR_X
 ;
ASK2 S (VAUTD,Y)=0 I '$D(^DG(40.8,+$O(^DG(40.8,0)),0)) W !,*7,"***WARNING...MEDICAL CENTER DIVISION FILE IS NOT SET UP" G ASK2Q
 I '$P($G(^DG(43,1,"GL")),U,2) S VAUTD=1 G ASK2Q
 I $D(^DG(43,1,"GL")),$P(^("GL"),U,2) G DIVISION^VAUTOMA
 S I=$O(^DG(40.8,0)) G:'$D(^DG(40.8,+I,0)) ASK2Q S VAUTD(I)=$P(^(0),U) K DIC Q
ASK2Q ;
 Q
 ;
CLOSE ; Utility to clean up tasked outputs
 Q:'$D(ZTQUEUED)
 D KILL^%ZTLOAD K ZTSK,ZTDESC,ZTRTN,ZTREQ,ZTSAVE,ZTIO,ZTDTH,ZTUCI,IO("Q"),IO("C")
 Q
 ;
XMY(GROUP,DGDUZ,DGPOST) ; -- set up XMY for mail group members
 ; input: GROUP := mail group efn [required]
 ;        DGDUZ := send to current user [ 0|no ; 1|yes] [optional]
 ;       DGPOST := send to postmaster if XMY is undefined
 ;                 [ 0|no ; 1|yes] [optional]
 ; output:  XMY := array of users
 ;        XMDUZ := message sender set postmaster
 ;
 N I K XMY
 I '$D(DGDUZ) N DGDUZ S DGDUZ=1
 I '$D(DGPOST) N DGPOST S SDPOST=1
 S XMY("G."_$P($G(^XMB(3.8,GROUP,0)),U))=""
 I DGDUZ,DUZ S XMY(DUZ)=""
 ; makes sure it gets sent to someone
 I '$D(XMY),DGPOST S XMY(.5)=""
 ; make postmaster the sender so it will show up as new to DUZ
 S XMDUZ=.5
 Q
 ;
 ;
LOCK(DFN) ;
 ; Description: Sets a lock used to synchronize local income test
 ; options with the income test upload. 
 ;
 ;  Input:
 ;    DFN - ien of record in PATIENT file
 ;
 ; Output:
 ;   Function value - returns 1 if the lock was obtained, 0 otherwise.
 ;
 Q:'$G(DFN) 1
 L +^DGMT("LOCAL INCOME TEST",DFN):5
 Q $T
 ;
 ;
UNLOCK(DFN) ;
 ; Description: Release the lock obtained by calling $$LOCK(DFN).
 ;
 ;  Input:
 ;    DFN - ien of record in PATIENT file
 ;
 ; Output: none
 ;
 Q:'$G(DFN)
 L -^DGMT("LOCAL INCOME TEST",DFN)
 Q
 ;
PA(DGMTI) ;Determine if the Pending Adjudication is for MT or GMT
 ; Input:
 ;   DGMTI - IEN of Annual Means Test file #408.31
 ; Output:
 ;   Returns "MT","GMT", or "" if it can't be determined
 ;
 N PA,DGMT0,MTTHR,GMTTHR
 S PA=""
 I '$G(DGMTI) Q PA
 S DGMT0=$G(^DGMT(408.31,DGMTI,0))
 ; If means test status is not Pending Adjudication, quit
 I $P(DGMT0,U,3)'=2 Q PA
 ; Get MT Threshold and GMT Threshold
 S MTTHR=+$P(DGMT0,U,12) I 'MTTHR Q PA
 S GMTTHR=+$P(DGMT0,U,27)
 ; If GMT Threshold is greater than MT Threshold then return GMT,
 ; otherwise return MT
 S PA=$S(GMTTHR>MTTHR:"GMT",1:"MT")
 Q PA
 ;
ISCNVRT(DGINC) ;* Convert Node 0 for records in 408.21 (IAI)
 ; Input:  DGINC - Individual Annual Income IEN Array
 ;
 N RESULT,IAIREC,NULLVAL,PCE,IAIIEN,TOT08,TOT201,TOT204,NWNODE
 S NULLVAL=""
 ;
 ; Convert 408.21 nodes to version 1 form
 F RECTYP="V","S","D"  DO
 . I RECTYP'="D" DO
 . . I $D(DGINC(RECTYP)) DO
 . . . S IAIIEN=DGINC(RECTYP)
 . . . S IAIREC=$G(^DGMT(408.21,IAIIEN,0))
 . . . S NWNODE=$G(^DGMT(408.21,IAIIEN,2))
 . . . S (TOT08,TOT201,TOT204)=0
 . . . S TOT201=$P(NWNODE,"^",1)+$P(NWNODE,"^",2)
 . . . S TOT204=$P(NWNODE,"^",4)-$P(NWNODE,"^",5)
 . . . S PCE=""
 . . . F PCE=8:1:13,15,16 I $P(IAIREC,"^",PCE)'=NULLVAL S TOT08=TOT08+$P(IAIREC,"^",PCE)
 . . . N DGERR,DGMTRT,FLDNM
 . . . S FLDNM=""
 . . . S DGERR=""
 . . . F FLDNM=.09:.01:.13,.15,.16,2.02,2.05 S DGMTRT(408.21,IAIIEN_",",FLDNM)="@"
 . . . S DGMTRT(408.21,IAIIEN_",",".08")=$S(TOT08>0:TOT08,1:"")
 . . . S DGMTRT(408.21,IAIIEN_",","2.01")=$S(TOT201>0:TOT201,1:"")
 . . . S DGMTRT(408.21,IAIIEN_",","2.04")=$S(TOT204>0:TOT204,1:"")
 . . . D FILE^DIE("E","DGMTRT",DGERR)
 . ;
 . I RECTYP="D" DO
 . . N DEPNUM,DGMTVR
 . . S DGMTVR=1
 . . S DEPNUM=""
 . . F  S DEPNUM=$O(DGINC("D",DEPNUM))  Q:DEPNUM=""  DO
 . . . S IAIIEN=DGINC("D",DEPNUM)
 . . . S IAIREC=$G(^DGMT(408.21,IAIIEN,0))
 . . . S NWNODE=$G(^DGMT(408.21,IAIIEN,2))
 . . . S (TOT08,TOT201,TOT204)=0
 . . . S TOT201=$P(NWNODE,"^",1)+$P(NWNODE,"^",2)
 . . . S TOT204=$P(NWNODE,"^",4)-$P(NWNODE,"^",5)
 . . . S PCE=""
 . . . F PCE=8:1:13,15,16 I $P(IAIREC,"^",PCE)'=NULLVAL S TOT08=TOT08+$P(IAIREC,"^",PCE)
 . . . N DGERR,DGMTRT,FLDNM
 . . . S FLDNM=""
 . . . S DGERR=""
 . . . F FLDNM=.09:.01:.13,.15,.16,2.02,2.05 S DGMTRT(408.21,IAIIEN_",",FLDNM)="@"
 . . . S DGMTRT(408.21,IAIIEN_",",".08")=$S(TOT08>0:TOT08,1:"")
 . . . S DGMTRT(408.21,IAIIEN_",","2.01")=$S(TOT201>0:TOT201,1:"")
 . . . S DGMTRT(408.21,IAIIEN_",","2.04")=$S(TOT204>0:TOT204,1:"")
 . . . D FILE^DIE("E","DGMTRT",DGERR)
 Q
