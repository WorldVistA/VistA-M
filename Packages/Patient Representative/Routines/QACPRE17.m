QACPRE17 ;ALB/ERC - PRE-INSTALL FOR PATCH QAC*2*17 ;3/6/02
 ;;2.0;Patient Representative:**17**;07/25/1995
 ;
 ;This routine will perform the de-activation of the existing Issue 
 ;Codes from file 745.2.  Allowable Issue Codes will now be restricted 
 ;to those being imported with this patch.  Two existing codes, ED01 and
 ;ED02 will be retained.
EN ;
 D INACT
 D ED
 D CSS
 D RENAME
 Q
INACT ;inactivate current codes
 N QACQ
 D INSTALL^QACENV17
 Q:$G(QACQ)=1
 N QAC,QACC,QACFDA,QACNODE
 S QAC=0
 F  S QAC=$O(^QA(745.2,QAC)) Q:QAC'>0  D
 . Q:'$D(^QA(745.2,QAC,0))
 . S QACNODE=^QA(745.2,QAC,0)
 . ;ED01 and ED02 will still be in use
 . Q:$P(QACNODE,U)="ED01"!($P(QACNODE,U)="ED02")
 . I $P(QACNODE,U,6)']"" D
 . . S QACFDA(745.2,QAC_",",4)=1
 . . S QACFDA(745.2,QAC_",",6)=DT
 . . D FILE^DIE(,"QACFDA","QACERR")
 Q
ED ;check to see if the ED01 and ED02 entries are current.  These two
 ;codes are already in existence, and are being retained
 ;if these codes are not in the file, add them
 N QACC,QACD,QACN,QACNM,QACNN,QACNNN
 S QACD=0
 F QACC="ED01","ED02" D
 . S QACD=$O(^QA(745.2,"B",QACC,QACD)) Q:QACC']""  D
 . . I '$D(^QA(745.2,QACD,0)) D DIC  Q
 . . S QACN=$P(^QA(745.2,QACD,0),U,3)
 . . S QACNN=$TR(QACN," ")
 . . S QACNNN=$E($$UP^XLFSTR(QACN),1,60)
 . . S QACNM=$S(QACC="ED01":"DIAGNOSIS / CARE / PREVENTION",1:"PURPOSE/SIDE EFFECTS OF MEDICATION")
 . . I $G(QACNM)'=QACN,($G(QACNM)'=QACNNN),($G(QACNM)'=(QACNNN)) D ADD
 Q
RENAME ;check for duplicates. If there are any, rename them
 N QACQ
 D INSTALL^QACENV17
 Q:$G(QACQ)=1
 N QACE,QACIEN,QACODE,QACPRE,QAX
 S QACIEN=0
 S QAX=""
 S QACODE="^SC^AC^OP^PR^EM^PC^CO^TR^FI^RI^LL^EV^RG^IF^CP^"
 F  S QAX=$O(^QA(745.2,"B",QAX)) Q:QAX']""  D
 . S QACIEN=$O(^QA(745.2,"B",QAX,QACIEN)) Q:QACIEN'>0  D
 . . S QACE="^"_$E(QAX,1,2)_"^"
 . . I QACODE[QACE D
 . . . S QACPRE=$E(QAX,1,2)
 . . . D CODE(QAX,QACPRE,QACIEN)
 Q
CODE(QAC,QACPRE,QACIEN) ;check for specific code, if a duplicate, call DIE
 N QACQUIT,QACR,QACTXT,QAXX
 Q:$G(QAC)']""
 F QAXX=1:1 S QACTXT=$P($T(@QACPRE+QAXX),";;",2) Q:$G(QACTXT)']""!($G(QACQUIT)=1)  D
 . I $G(QAC)=$G(QACTXT) D
 . . S QACIEN(QACIEN)=""
 . . S QACQUIT=1
 I $O(QACIEN(0))'>0 D ZZ
 Q
ZZ ;rename duplicate code entries (add "Z" to beginning of code)
 N DA,DIK,QACDR,QACN,QACNN
 S QACN=0
 S DIK="^QA(745.2,"
 F  S QACN=$O(QACIEN(QACN)) Q:QACN'>0  D
 . S QACNN=$P(^QA(745.2,QACN,0),U)
 . Q:$G(QACNN)']""
 . S QACDR="Z"_QACNN
 . S $P(^QA(745.2,QACN,0),U)=$G(QACDR)
 . Q:$G(QACDR)']""!('$D(^QA(745.2,QACN,0)))
 . S DA=QACN
 . S DIK(1)=".01^B^BU"
 . D EN^DIK
 . K ^QA(745.2,"B",QACNN,QACN)
 . K ^QA(745.2,"BU",QACNN,QACN)
 Q
ADD ;update entries ED01 and ED02
 N DA,DIE,DR
 S DIE="^QA(745.2,",DA=QACD
 S DR="2///^S X=$S(QACC=""ED01"":""Diagnosis / care / prevention"",1:""Purpose/side effects of medication"");4///^S X=""N"";6///@;7///^S X=7"
 D ^DIE
 Q
DIC ;if ED01 or ED02 not in file, add it
 N DA,DIC,Y
 S DIC="^QA(745.2,",DA=QACD
 D ^DIC
 I +Y>0 S DA=+Y
 D ADD
 Q
SC ;
 ;;SC01
 ;;SC02
 Q
AC ;
 ;;AC01
 ;;AC02
 ;;AC03
 ;;AC04
 ;;AC05
 ;;AC06
 ;;AC07
 ;;AC08
 ;;AC09
 ;;AC10
 ;;AC11
 ;;AC12
 Q
OP ;
 ;;OP01
 ;;OP02
 Q
PR ;
 ;;PR01
 ;;PR02
 ;;PR03
 ;;PR04
 Q
EM ;
 ;;EM01
 ;;EM02
 ;;EM03
 Q
PC ;
 ;;PC01
 ;;PC02
 Q
CO ;
 ;;CO01
 ;;CO02
 ;;CO03
 ;;CO04
 Q
TR ;
 ;;TR01
 Q
FI ;
 ;;FI01
 Q
RI ;
 ;;RI01
 ;;RI02
 ;;RI03
 ;;RI04
 ;;RI05
 Q
RE ;
 ;;RE01
 Q
LL ;
 ;;LL01
 ;;LL02
 ;;LL03
 ;;LL04
 Q
EV ;
 ;;EV01
 ;;EV02
 ;;EV03
 Q
RG ;
 ;;RG01
 ;;RG02
 ;;RG03
 Q
IF ;
 ;;IF01
 ;;IF02
 ;;IF04
 ;;IF05
 ;;IF06
 ;;IF07
 ;;IF08
 ;;IF09
 ;;IF10
 Q
CP ;
 ;;CP01
 Q
CSS ;edit any Name fields that differ from the exported version, as FM will
 ;create new entries is they are not the same
 N DA,DIE,DR,QAC,QACNAME,QACZERO,X
 S QACNAME="Staff Courtesy^Access/Timeliness^One Provider^Decisions/Preferences^Emotional Needs^Coordination of Care^Patient Education^Family Involvement^Physical Comfort^Transitions"
 S QAC=0
 F  S QAC=$O(^QA(745.6,QAC)) Q:QAC'>0!(QAC>10)  D
 . S QACZERO=^QA(745.6,QAC,0)
 . I QAC'=$P(QACZERO,U) S QAC(QAC)=""
 . I $P(QACZERO,U,2)'=$P(QACNAME,U,QAC) S QAC(QAC)=""
 Q:$O(QAC(0))'>0
 S QAC=0
 S DIE="^QA(745.6,"
 F  S QAC=$O(QAC(QAC)) Q:QAC'>0  D
 . S DA=QAC,DR=".01///^S X=QAC;1///^S X=$P(QACNAME,U,QAC)"
 . D ^DIE
 Q
