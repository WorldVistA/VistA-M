QACMAIL1 ;ERC/WASHCIOFO-Send data to reposititory ;11/29/99
 ;;2.0;Patient Representative;**4,14,15,17**;07/25/1995
 ;continuation routine - contains looping code, assigns variables
 ;and stuffs values into temporary global ^TMP("QAC MAIL",$J,linecount)
 ;
ENV ;environment check - to ensure that the Mailman patch creating
 ;domain has beem installed.
 N QACQ,QACE,ZPDQUIT
 S QACQ="Q-PSS.MED.VA.GOV"
 Q:$$FIND1^DIC(4.2,,"QX",QACQ,"B",,"QACE")
 W !!?5,$C(7),"**** Installation of this patch requires that domain "
 W !?10,QACQ," be defined."
 S XPDQUIT=1
 W !!!?5,"Refer to patch XM*999*133 for domain definition information."
 W !?15,"<Patch QAC*2.0*4 installation aborted!>",!!
 Q
LOOP ;
 ;loop through file 745.1 looking for entries edited 
 ;since the previous rollup that have at least one issue code.
 N QACD,QACDD,QACJ,QACLAST,QACOUNT
 S QACJ=0
 S QACLAST=$P($G(^QA(740,1,"QAC")),U,4)
 ;(DBIA #3061 for lookup of value of QAC LAST RECORD in file #740)
 S QACOUNT=0
 F  S QACJ=$O(^QA(745.1,"F",3,QACJ)) Q:QACJ'>0!($G(QACOUNT)>700)  D WORK
 I $G(QACLAST)'>0 D
 . ;if QACLAST'>0, need to run rollup for the first time from 10/01/99
 . S QACD=$O(^QA(745.1,"D",2991000)) Q:QACD'>0  D
 . . S QACJ=$O(^QA(745.1,"D",QACD,QACJ)) Q:QACJ'>0  S QACJ=QACJ-1 D
 . . . F  S QACJ=$O(^QA(745.1,QACJ)) Q:QACJ'>0!($G(QACOUNT)>700)  D WORK
 S DIE="^QA(740,",DA=1,DR="753////^S X=QACLAST"
 D ^DIE K DA,DIE,DR
 Q
WORK ;
 D NODE0
 S QACLAST=QACJ
 S QACOUNT=QACOUNT+1
 S DIE="^QA(745.1,",DA=QACJ,DR="41///@" D ^DIE K DA,DIE,DR
 Q
DATA ; Set data into local variables and then into ^TMP global for
 ; inclusion in mail message.
 N QACNODE2,QACNODE7
 N QACK,QACL,QACM,QACN
 N QACCOM,QACDAT,QACDATE,QACDAYS,QACDISC,QACDIV,QACDOB,QACELIG,QACISSC
 N QACLSAT,QACMADE,QACNO,QACPGV,QACPSRV,QACRDAT,QACRDATE,QACROC
 N QACSEAT,QACSEX,QACSSN,QACSTAT,QACTST
 ;if record was previously rejected and is now closed set Roll-up status
 ;to "0" (call ROLL(0)) - if still open but has IC call ROLL(2)
 ;if record previously sent but "open", but is now closed, call ROLL(0)
 N QACNOT
 S QACROC=$P($G(QACNODE0),U)
 I $G(QACNODE0)]"" D
 . I $P($G(QACNODE0),U,3)]"" D
 . . S QACSSN=$P(VADM(2),U) ;SSN
 . . S QACDOB=$P(VADM(3),U) ;DOB
 . . I $G(QACDOB) D  ;Austin wanted dates in MMDDYYYY
 . . . S QACDOB=$P($$FMTHL7^XLFDT(QACDOB),"-")
 . . . S QACDOB=$E(QACDOB,5,8)_$E(QACDOB,1,4)
 . . S QACSEX=$P(VADM(5),U)
 . S QACDATE=$P(QACNODE0,U,2) ;date of contact
 . I $G(QACDATE) D
 . . S QACDATE=$P($$FMTHL7^XLFDT(QACDATE),"-")
 . . S QACDATE=$E(QACDATE,5,8)_$E(QACDATE,1,4)
 . S QACPSRV=$P($G(QACNODE0),U,14) ;period of service
 . S QACPGV=$P($G(QACNODE0),U,15) ;Persian Gulf vet?
 . S QACDIV=""
 . I $P($G(QACNODE0),U,16)]"" D DIV16
 . ;S QACDIV=$E(QACDIV,1,30)
 . I $G(QACDIV)["Unknown" S QACDIV=""
 . S QACELIG=$S($P($G(QACNODE0),U,4)]"":$O(^DIC(8,"B",$P($G(QACNODE0),U,4),0)),1:"UNK") ;eligibility
 . S QACMADE=$P(QACNODE0,U,10)
NODE2 ; set variables for node 2
 S QACNODE2=$G(^QA(745.1,QACJ,2))
 I QACNODE2]"" S QACTST=$P($G(QACNODE2),U,2) ;treatment status
 S QACINTAP=$P($G(QACNODE2),U,7) ;Internal Appeal
NODE3 ;issue code info
 S QACK=0
 F  S QACK=$O(^QA(745.1,QACJ,3,QACK)) Q:QACK'>0  D
 . S QACISSC(QACK)=$P(^QA(745.2,^QA(745.1,QACJ,3,QACK,0),0),U)
 . I $P($G(^QA(745.1,QACJ,3,QACK,3,0)),U,3)'>0 S QACDISC(QACK,1)=QACISSC(QACK)_"^"
 . S QACL=0
 . F  S QACL=$O(^QA(745.1,QACJ,3,QACK,3,QACL)) Q:QACL'>0  D
 . . ;get code for discipline
 . . N QACTEMP,QACTMP
 . . S QACTMP=$P($G(^QA(745.1,QACJ,3,QACK,3,QACL,0)),U,2)
 . . S QACTEMP=$S($G(QACTMP)]"":$P($G(^QA(745.5,QACTMP,0)),U),1:"")
 . . S QACDISC(QACK,QACL)=QACISSC(QACK)_"^"_$G(QACTEMP)
NODE7 ;set variables for node 7
 S QACNODE7=$G(^QA(745.1,QACJ,7)) I $G(QACNODE7)]"" D
 . S QACSTAT=$P($G(QACNODE7),U,2) ;status
 . S QACRDATE=$P(QACNODE7,U) ;resolution date
 . I $G(QACRDATE) D
 . . S QACRDATE=$P($$FMTHL7^XLFDT(QACRDATE),"-")
 . . S QACRDATE=$E(QACRDATE,5,8)_$E(QACRDATE,1,4)
 . S QACDAYS=$P($G(QACNODE7),U,4) ;days to resolution
NODE8 ; set variables for employee multiple
 N QACC
 S QACC=0
 K QACEM,QACEMP
 F  S QACC=$O(^QA(745.1,QACJ,8,QACC)) Q:QACC'>0  D
 . S QACEM=^QA(745.1,QACJ,8,QACC,0) Q:QACEM'>0
 . S QACEM=$P($G(^VA(200,QACEM,0)),U)
 . I $G(QACEM)]"" S QACEMP(QACJ,QACC)=QACEM
NODE12 ; set variables for source(s) of contact multiple
 N QACD,QACSOR,QACSR
 S QACD=0
 F  S QACD=$O(^QA(745.1,QACJ,12,QACD)) Q:QACD'>0  D
 . S QACSR=^QA(745.1,QACJ,12,QACD,0) Q:QACSR']""
 . I $G(QACSR)]"" S QACSOR(QACJ,QACD)=QACSR
STUFF ; Stuff variables into ^TMP global for use in ^XMD
 ;      field delimiter = "^"
 ;       line delimiter = "&"
 ;     record delimiter = "$"
 ;    message delimiter = "#"
 N QACJJ,QACKK,QACLL
 S QACRCNT=QACRCNT+1
 ;check message size - need to ensure message < 32000
 I $G(QACTCNT)>29000 D NEWMSG^QACMAIL0
 X QACINC
 S ^TMP("QAC MAIL",$J,QACLCNT)=$G(QACROC)_"^ROC^"_$G(QACDATE)_"^"_$G(QACSSN)_"^"_$G(QACSEX)_"^"_$G(QACDOB)_"^"_$G(QACSTAT)_"^"_$G(QACRDATE)_"^"_$G(QACTST)_"^"_$G(QACPSRV)
 S ^TMP("QAC MAIL",$J,QACLCNT)=^TMP("QAC MAIL",$J,QACLCNT)_"^"_$G(QACPGV)_"^"_$G(QACDIV)_"^"_$G(QACDAYS)_"^"_$G(QACELIG)_"^"_$G(QACMADE)_"^"_$G(QACVISN)_"^"_$G(QACINTAP)_"&"
STFFISSC ;stuff issue code values into ^TMP
 ;using "~" as an Issue Code delimiter
 N QACCHCNT
 S (QACJJ,QACKK)=0
 I $O(QACISSC(0))'>0 Q
 X QACINC S ^TMP("QAC MAIL",$J,QACLCNT)=$G(QACROC)_"^ISSC^"
 F  S QACJJ=$O(QACDISC(QACJJ)) Q:QACJJ'>0  D
 . S QACKK=0
 . F  S QACKK=$O(QACDISC(QACJJ,QACKK)) Q:QACKK'>0  D
 . . N QACLIN,QACLINE
 . . S QACLINE=QACDISC(QACJJ,QACKK)
 . . ; adding employee(s) to each issue code.  In future employee (and
 . . ; location) will be associated with Issue Code - code will change
 . . ; here.  For now, location will be represented by "" in last piece
 . . ; There will be one IC, one Disc., one location and one employee
 . . ; separated by "^", and each 4 field set separated by "~"
 . . S (QACE,QACCHCNT)=0
 . . I $O(QACEMP(0))'>0 S ^TMP("QAC MAIL",$J,QACLCNT)=^TMP("QAC MAIL",$J,QACLCNT)_QACLINE_"^^~"
 . . F  S QACE=$O(QACEMP(QACJ,QACE)) Q:QACE'>0  D
 . . . S QACLIN=QACLINE_"^"_$G(QACEMP(QACJ,QACE))_"^~" ;space for loc
 . . . I $L(QACLIN)+$L(^TMP("QAC MAIL",$J,QACLCNT))>200 D
 . . . . X QACINC
 . . . . S ^TMP("QAC MAIL",$J,QACLCNT)=""
 . . . S ^TMP("QAC MAIL",$J,QACLCNT)=^TMP("QAC MAIL",$J,QACLCNT)_QACLIN
 . . . S QACLIN=""
 S ^TMP("QAC MAIL",$J,QACLCNT)=^TMP("QAC MAIL",$J,QACLCNT)_"&"
STFFSOUR ;stuff values for source(s) of contact into ^TMP
 X QACINC
 S ^TMP("QAC MAIL",$J,QACLCNT)=$G(QACROC)_"^SOUR"
 N QACF
 S QACF=0
 F  S QACF=$O(QACSOR(QACJ,QACF)) Q:QACF'>0  D
 . S ^TMP("QAC MAIL",$J,QACLCNT)=^TMP("QAC MAIL",$J,QACLCNT)_"^"_$G(QACSOR(QACJ,QACF))
 S ^TMP("QAC MAIL",$J,QACLCNT)=^TMP("QAC MAIL",$J,QACLCNT)_"$"
 Q
NODE0 ;set values from zero node
 N DFN,QACNAME,QACNODE0,QACNOFLG,VADM
 S QACNODE0=^QA(745.1,QACJ,0)
 I $P($G(QACNODE0),U,3)]"" D
 . S DFN=$P(QACNODE0,U,3)
 . D ^VADPT
 S QACNAME=$S($G(VADM(1))]"":VADM(1),1:"No Patient Involved")
 ;If no issue code count record and go to next entry.
 I $P($G(^QA(745.1,QACJ,3,0)),U,3)<1 D
 . S QACNOCNT=$G(QACNOCNT)+1,QACNOT=1
 . ;D ROLL^QACMAIL0(1) ;sets Roll-Up Status to rejected
 . Q
 I $G(QACNOT)=1 S QACNOT=0 Q
 D DATA
 Q
LOOP1 ;post-install to check previously rejected records (see if they now
 ;have Issue Codes) and to get any records since last run of the
 ;rollup.  for QAC*2*17.  will set these records to a Rollup Status
 ;of 3, which means they will be transmitted with the next run.
 N QACF,QACJ
 F QACF=1,2 S QACJ=0 D
 . F  S QACJ=$O(^QA(745.1,"F",QACF,QACJ)) Q:QACJ'>0  D
 . . I $P($G(^QA(745.1,QACJ,3,0)),U,3)'>0 D DIE("@") Q
 . . D DIE(3)
 S QACJ=$P(^QA(740,1,"QAC"),U,4)
 I $G(QACJ)']"" Q
 F  S QACJ=$O(^QA(745.1,QACJ)) Q:QACJ'>0  D
 . D DIE(3)
 Q
DIE(QACE) ;
 S DIE="^QA(745.1,",DA=QACJ,DR="41///^S X=QACE"
 D ^DIE
 K DA,DIE,DR,QACE
 Q
DIV16 ;division field, #37
 S QACNO=$P($G(QACNODE0),U,16)
 ;D INST^QACUTL0(QACNO,.QACDIV)
 S QACDIV=$P($G(^DIC(4,QACNO,99)),U)
 Q
