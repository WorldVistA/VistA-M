QACEMPE ;WCIOFO/VAD-Report By Employee ;02/10/1999
 ;;2.0;Patient Representative;**9**;07/25/1995
 ;
MAIN ;
 D INIT
 D DATDIV^QACUTL0 G:QAQPOP EXIT
 I +$G(QAC1DIV) D INST^QACUTL0(QAC1DIV,.QACDVNAM)  ; If reporting for one division get the division name to be reported.
 ;
 D GTEMP G:QAQPOP EXIT
 ;
 K %ZIS,IOP S %ZIS="MQ" W ! D ^%ZIS I POP D EXIT Q
 ;
 I $D(IO("Q")) D  Q 
 . S ZTDESC=QACDESC
 . S ZTRTN="PROCESS^QACEMPE"
 . S ZTSAVE("QACALL")="",ZTSAVE("QACDESC")=""
 . S ZTSAVE("QAC1DIV")="",ZTSAVE("QACDVNAM")=""
 . S ZTSAVE("QACESEL")="",ZTSAVE("QACINFO")="",ZTSAVE("QACRTN")=""
 . S ZTSAVE("QAQRANG")=""
 . D TASK^QACUTL0
 ;
 D PROCESS
 Q
 ;
INIT ;
 S (QACINFO,QAQPOP)=0,QACDVNAM=""
 S QACRTN="QACEMPE"
 S QACDESC="Report by Employee"
 Q
 ;
GTEMP ; Get the Employee Selection.
 S QACESEL="",QACALL=0
 W !!,"Enter an Employee Name or <CR> for ALL: " R QACESEL:DTIME
 I QACESEL="^" S QAQPOP=1 Q
 I QACESEL="" S QACALL=1 Q
 I QACESEL'?.AP W !,$C(7),"INVALID NAME...RE-ENTER NAME!" G GTEMP
 S QACESEL=$$TRANS(QACESEL)
 ;
 ; Select one Employee.
 S QACFIL=200,QACFLDS=.01,QACFLGS="O",QACDATA="^TMP(QACRTN,$J,""DATA"")",QACERR="^TMP(QACRTN,$J,""ERR"")"
 D FIND^DIC(QACFIL,,.QACFLDS,QACFLGS,QACESEL,,,,,QACDATA,QACERR)
 S QACFOUND=+$G(^TMP(QACRTN,$J,"DATA","DILIST",0))
 I 'QACFOUND D  G GTEMP
 . W !!,$C(7),"EMPLOYEE SELECTION NOT FOUND...<CR> to Continue" R R:DTIME
 ;
 S QACOK=0
 I QACFOUND=1 D GTEMP1 Q:QACOK  G GTEMP
 D GTEMP2 Q:QACOK  G GTEMP
 Q
 ;
GTEMP1 ;
 S QACREC=^TMP(QACRTN,$J,"DATA","DILIST",1,1)
 W !!?5,QACREC
 W !!?5,"Is the above Employee the correct one? <Y> " R R:DTIME
 S R=$$TRANS(R)
 I R="" S R="Y"
 I R="Y" S QACESEL=QACREC,QACOK=1 Q
 I R'="N" D  G GTEMP1
 . W !!,"PLEASE ENTER 'Y' or 'N'...<CR> to Continue" R R:DTIME
 Q
 ;
GTEMP2 ;
 F I=1:1:QACFOUND D
 . S QACREC=^TMP(QACRTN,$J,"DATA","DILIST",1,I)
 . W !?5,I,".)  ",QACREC
 ;
 W !!?5,"Select one of the above: " R QACNUM:DTIME
 I '$L(QACNUM) Q
 I QACNUM>QACFOUND D  G GTEMP2
 . W !!,"MUST SELECT A NUMBER FROM 1-",QACFOUND,"...<CR> to Continue" R R:DTIME
 S QACESEL=^TMP(QACRTN,$J,"DATA","DILIST",1,QACNUM)
 S QACOK=1
 Q
 ;
PROCESS ;
 D SETUP,SORT,RPT
 I 'QACINFO D HEADER W !!?26,"* * * NO DATA TO PRINT * * *",!!
 D EXIT
 Q
 ;
SETUP ;
 K ^TMP(QACRTN,$J)
 K QACEMPNM
 S (QACQUIT,QACPAGE)=0
 S QACHDR2="Date "_QAQRANG
 S $P(QACUNDL,"-",78)="-"
 S QACDTIM=$$HTE^XLFDT($H,1)
 S QACTIME=$P(QACDTIM,"@",2)
 S QACTODAY=$P(QACDTIM,"@")_"  "_$E(QACTIME,1,5)
 Q
 ;
SORT ; Sort thru the data to accumulate results based upon selection criteria
 S QACDATE1=QAQNBEG-1  ; Initialize the starting point for the Date of Contacts.
 I '$D(QAC1DIV) S QACDVNAM="NON-DIVISIONAL"
 ;
 ; Loop thru ROCs by "Date of Contact"
 F  S QACDATE1=$O(^QA(745.1,"D",QACDATE1)) Q:(QACDATE1>QAQNEND)!('$L(QACDATE1))  D
 . S QACD0=""
 . F  S QACD0=$O(^QA(745.1,"D",QACDATE1,QACD0)) Q:'$L(QACD0)  D
 . . K QACOUT
 . . D GETS^DIQ(745.1,QACD0,".01;1;2;37","NIE","QACOUT")
 . . S QACD0X=QACD0_","
 . . S QACROCNO=$G(QACOUT(745.1,QACD0X,.01,"E"))  ; Contact Number
 . . S QACROCDT=$G(QACOUT(745.1,QACD0X,1,"E"))  ; Date of Contact - External
 . . S QACPTNO=$G(QACOUT(745.1,QACD0X,2,"I"))  ; Patient #
 . . S QACPTNAM=$G(QACOUT(745.1,QACD0X,2,"E"))  ; Patient Name
 . . S QACDOK=1
 . . ;
 . . ; If site is Multi-divisional set up for the division name.
 . . I $D(QAC1DIV) D  Q:'QACDOK
 . . . S QACDVNO=$G(QACOUT(745.1,QACD0X,37,"I"))  ; Division #
 . . . I +QAC1DIV,+QAC1DIV'=+QACDVNO S QACDOK=0 Q  ; Not the selected Division
 . . . S QACDVNAM=$G(QACOUT(745.1,QACD0X,37,"E"))  ; Division Name
 . . . I '$L(QACDVNAM) S QACDVNAM="  EMPTY"
 . . ;
 . . ; Get array of Service/Disciplines for an ROC.
 . . K QAC3ARAY
 . . S QACD1=0
 . . F  S QACD1=$O(^QA(745.1,QACD0,3,QACD1)) Q:'$L(QACD1)  D
 . . . I '$D(^QA(745.1,QACD0,3,QACD1,3,"B")) Q
 . . . S QACD2=""
 . . . F  S QACD2=$O(^QA(745.1,QACD0,3,QACD1,3,"B",QACD2)) Q:'$L(QACD2)  D
 . . . . S QACSVDP=$P($G(^QA(745.55,QACD2,0)),U,1)  ; Serv/Disp Name
 . . . . S QACD3=""
 . . . . F  S QACD3=$O(^QA(745.1,QACD0,3,QACD1,3,"B",QACD2,QACD3)) Q:'$L(QACD3)  D
 . . . . . S QACSEQ=0 F QACSEQ=QACSEQ:1 I '$D(QAC3ARAY(QACSVDP,QACSEQ)) Q
 . . . . . S QAC3ARAY(QACSVDP,QACSEQ)=""
 . . ;
 . . ; Get each Employee for an ROC.
 . . S QACD1=0
 . . F  S QACD1=$O(^QA(745.1,QACD0,8,QACD1)) Q:'$L(QACD1)!(QACD1'?.N)  D
 . . . S QACENO=$G(^QA(745.1,QACD0,8,QACD1,0))  ; Employee Internal #
 . . . S QACENOX=QACENO_","
 . . . I '$D(QACEMPNM(200,QACENOX)) D  ; If Employee Name not previously accessed get the name.
 . . . . D GETS^DIQ(200,QACENO,".01","NE","QACEMPNM")
 . . . . I $G(QACEMPNM(200,QACENOX,.01,"E"))="" S ^("E")="Unknown Employee"
 . . . S QACENAM=QACEMPNM(200,QACENOX,.01,"E")  ; Employee Name
 . . . D STORIT
 Q
 ;
STORIT ; Store sorted ROC data in the ^TMP global for reporting purposes.
 I 'QACALL,(QACENAM'=QACESEL) Q  ; Not selected Employee.
 I '$D(^TMP(QACRTN,$J,"ROC",QACROCNO)) D
 . S ^TMP(QACRTN,$J,"ROC",QACROCNO)=QACD0_U_QACROCDT_U_QACPTNAM
 ; Store record for reporting purposes
 S (QACSVDP,QACSEQ)=""
 F  S QACSVDP=$O(QAC3ARAY(QACSVDP)) Q:'$L(QACSVDP)  D
 . F  S QACSEQ=$O(QAC3ARAY(QACSVDP,QACSEQ)) Q:'$L(QACSEQ)  D
 . . S ^TMP(QACRTN,$J,"RPT",QACDVNAM,QACENAM,QACSVDP,QACROCNO,QACSEQ)=""
 Q
 ;
RPT ; Print the report
 U IO
 ;
 ; Loop through the Sorted data.
 S (QACDVNAM,QACEMPNM,QACSVDP,QACROCNO,QACSEQ)=""
 F  S QACDVNAM=$O(^TMP(QACRTN,$J,"RPT",QACDVNAM)) Q:QACDVNAM=""  D  Q:QACQUIT
 . F  S QACEMPNM=$O(^TMP(QACRTN,$J,"RPT",QACDVNAM,QACEMPNM)) Q:QACEMPNM=""  D  Q:QACQUIT
 . . ;
 . . ; New Employee
 . . D HEADER Q:QACQUIT
 . . F  S QACSVDP=$O(^TMP(QACRTN,$J,"RPT",QACDVNAM,QACEMPNM,QACSVDP)) Q:QACSVDP=""  D  Q:QACQUIT
 . . . F  S QACROCNO=$O(^TMP(QACRTN,$J,"RPT",QACDVNAM,QACEMPNM,QACSVDP,QACROCNO)) Q:QACROCNO=""  D  Q:QACQUIT
 . . . . ;
 . . . . ; Get an array of Issue Text for an ROC.
 . . . . K QACITXT
 . . . . S QACREC=^TMP(QACRTN,$J,"ROC",QACROCNO)
 . . . . S QACD0=$P(QACREC,U),QACROCDT=$P(QACREC,U,2),QACPTNAM=$P(QACREC,U,3)
 . . . . I $D(^QA(745.1,QACD0,4,0)) D
 . . . . . S DIC=745.1,DA=QACD0,DR=22,DIQ="QACITXT"
 . . . . . D EN^DIQ1
 . . . . ;
 . . . . ; Print the Contact #, Date of Contact and Patient Name
 . . . . I $Y>(IOSL-6) D HEADER Q:QACQUIT
 . . . . W !!,QACROCNO,?25,QACROCDT,?45,QACPTNAM
 . . . . ;
 . . . . ; Print the Issue Text if there is any.
 . . . . I $D(QACITXT) D  Q:QACQUIT
 . . . . . S QACD1=""
 . . . . . F  S QACD1=$O(QACITXT(745.1,QACD0,DR,QACD1)) Q:'$L(QACD1)  D  Q:QACQUIT
 . . . . . . I $Y>(IOSL-6) D HEADER Q:QACQUIT
 . . . . . . W !?3,QACITXT(745.1,QACD0,DR,QACD1)
 . . . . ;
 . . . . F  S QACSEQ=$O(^TMP(QACRTN,$J,"RPT",QACDVNAM,QACEMPNM,QACSVDP,QACROCNO,QACSEQ)) Q:QACSEQ=""  D  Q:QACQUIT
 . . . . . ;
 . . . . . ; Print a Serv/Sect or Discipline line.
 . . . . . I $Y>(IOSL-6) D HEADER Q:QACQUIT
 . . . . . W !?6,QACSVDP
 Q
 ;
HEADER ;
 S QACPAGE=QACPAGE+1
 I QACPAGE>1 D  Q:QACQUIT
 . W $C(7)
 . I $E(IOST)="C" K DIR S DIR(0)="E" D ^DIR S QACQUIT=$S(Y'>0:1,1:0)
 ;
 W:$E(IOST)="C"!(QACPAGE>1) @IOF
 W !,QACDESC,?48,QACTODAY,?70,"PAGE ",QACPAGE
 W !?(80-$L(QACHDR2))/2,QACHDR2
 W !,"Contact #",?25,"Date of Contact",?45,"Patient Name"
 W !?3,"Issue Text",!?6,"Serv/Sect or Discipline"
 W !,QACUNDL
 ;
 I $D(QAC1DIV) D    ; Print the division if site is Multi-divisional.
 . S QACDVTXT="Division: "_$S(QACDVNAM="  EMPTY":"EMPTY",1:QACDVNAM)
 . I $L(QACDVNAM) W !?(80-$L(QACDVTXT))/2,QACDVTXT S QACINFO=1
 ;
 S QACEMTXT="Employee: "_QACEMPNM
 I $L(QACEMPNM) W !?(80-$L(QACEMTXT))/2,QACEMTXT,! S QACINFO=1
 Q
 ;
TRANS(X) ; Module to transform lower-case into uppercase.
 S X=$TR(X,"abcdefghijklmnopqrstuvwxyz","ABCDEFGHIJKLMNOPQRSTUVWXYZ")
 Q X
 ;
EXIT ;
 W ! D ^%ZISC S:$D(ZTQUEUED) ZTREQ="@"
 D K^QAQDATE
 K ^TMP(QACRTN,$J)
 K DA,DIC,DIQ,DIR,DR
 K QAC1DIV,QAC3ARAY,QAC4ARAY,QACALL,QACCONT,QACCREC0,QACD0,QACD0X
 K QACD1,QACD2,QACD3,QACDATA,QACDATE1,QACDESC,QACDOK,QACDTIM,QACDV
 K QACDVNAM,QACDVNO,QACDVTXT,QACEMPNM,QACEMTXT,QACENAM,QACENO,QACENOX
 K QACERR,QACESEL,QACFIL,QACFLDS,QACFLGS,QACFOUND,QACHDR2,QACINFO,QACITXT
 K QACNUM,QACOK,QACOUT,QACPAGE,QACPTNAM,QACPTNO,QACQUIT,QACREC
 K QACROCNO,QACROCDT,QACRTN,QACSEQ,QACSNO,QACSVDP,QACTIME,QACTODAY
 K QACUNDL,QAQDTOUT,QAQNBEG,QAQNEND,QAQPOP,QAQRANG
 K I,POP,R,X,Y,ZTDESC,ZTRTN,ZTSAVE
 Q
