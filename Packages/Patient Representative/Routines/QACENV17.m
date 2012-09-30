QACENV17 ;ALB/ERC - PRE-INSTALL ROUTINE FOR QAC*2*17 ;3/5/02
 ;;2.0;Patient Representative;**17**;07/25/1995
 ;
 ;This pre-install routine will do several things.  It will check
 ;existing entries in the Customer Service Standard file (745.6) to 
 ;ensure that entries have not been added locally. If they have, the 
 ;site will get a message displayed indicating  that installing will 
 ;overwrite the data.  It will also check entries in the Issue Code 
 ;file (#745.2) looking for existing local Issue Codes that duplicate 
 ;the code of any entries that will be added with the pot-install.  If
 ;any duplications exist the site will have a message display. 
START ;
 N X,XPDQUIT
 S XPDQUIT=""
 D CSS
 D ISS
 Q
CSS ;check entries in 745.6
 N QACQ
 D INSTALL
 Q:$G(QACQ)=1
 N QAC,QACNAME,QACZERO
 S QACNAME="Staff Courtesy^Timeliness^One Provider^Decisions^Emotional Needs^Coordination of Care^Patient Education^Family Involvement^Physical Comfort^Transitions"
 S QAC=0
 F  S QAC=$O(^QA(745.6,QAC)) Q:QAC'>0!(QAC>10)  D
 . S QACZERO=^QA(745.6,QAC,0)
 . I QAC'=$P(QACZERO,U) S QAC(QAC)=".01^"
 . I $P(QACZERO,U,2)'=$P(QACNAME,U,QAC) S QAC(QAC)=$G(QAC(QAC))_"1"
 ;if a different number of entries than the 10 exported previously
 I $P(^QA(745.6,0),U,3,4)'="10^10" S QAC(0)=""
 I $D(QAC(0))!($O(QAC(0))]"") D
 . W !!!,"                  ****NOTE****"
 . W !,"The Customer Service Standard file (#745.6) has been altered locally."
 . W !,"This file is pointed to by the Issue Code file (#745.2)."
 . W !,"Before installation these pointers should be updated."
 . W !!,"Current Customer Service Standards MUST be:"
 . W !,"    ^QA(745.6,1,0) = 1^Staff Courtesy"
 . W !,"    ^QA(745.6,2,0) = 2^Timeliness"
 . W !,"    ^QA(745.6,3,0) = 3^One Provider"
 . W !,"    ^QA(745.6,4,0) = 4^Decisions"
 . W !,"    ^QA(745.6,5,0) = 5^Emotional Needs"
 . W !,"    ^QA(745.6,6,0) = 6^Coordination of Care"
 . W !,"    ^QA(745.6,7,0) = 7^Patient Education"
 . W !,"    ^QA(745.6,8,0) = 8^Family Involvement"
 . W !,"    ^QA(745.6,9,0) = 9^Physical Comfort"
 . W !,"    ^QA(745.6,10,0) = 10^Transitions",!!
 . W !,"Patch 17 will overwrite your data - editing of this file is not permitted."
 . W !,"Installation of the patch will create changes in this file."
 . N DIR,DIRUT,DIROUT
 . S DIR(0)="YO"
 . S DIR("A")="Do you want to continue with this installation"
 . S DIR("B")="YES"
 . ;S DIR("?")="Installing this patch will overwrite the data in your file 745.6. Proceed? "
 . D ^DIR I $D(DIRUT)!($D(DIROUT)) Q
 . I $E(X)="N"!($E(X)="n") S XPDQUIT=1 W !,"Installation stopped, global destroyed."
 Q
ISS ;check Issue Code entries for duplicate
 N QACQ
 D INSTALL
 Q:$G(QACQ)=1
 N QAC,QACCODE,QACE,QACIEN,QACPRE
 S QACCODE="^SC^AC^OP^PR^EM^PC^CO^TR^FI^RI^LL^EV^RG^IF^CP^"
 S QACIEN=0
 S QAC=""
 F  S QAC=$O(^QA(745.2,"B",QAC)) Q:QAC']""  D
 . S QACIEN=$O(^QA(745.2,"B",QAC,QACIEN)) Q:QACIEN'>0  D
 . . S QACE="^"_$E(QAC,1,2)_"^"
 . . I QACCODE[QACE D
 . . . S QACPRE=$E(QAC,1,2)
 . . . D CODE(QAC,QACPRE,.QACIEN)
 I $O(QACIEN(0))>0 D MSG
 Q
CODE(QAC,QACPRE,QACIEN) ;
 ;check for specific code, if a duplicate display message
 N QACQUIT,QACR,QACTXT,QAX
 Q:$G(QAC)']""
 F QAX=1:1 S QACTXT=$P($T(@QACPRE+QAX),";;",2) Q:$G(QACTXT)']""!($G(QACQUIT)=1)  D
 . I $G(QAC)=$G(QACTXT) D
 . . S QACIEN(QACIEN)=""
 . . S QACQUIT=1
 Q
MSG ;
 N QACND,QACR
 S QACR=0
 W !!!,"                     ****NOTE****"
 W !,"Your database has Issue Codes that duplicate those exported with this patch."
 W !,"After installing this patch the following Issue Codes will refer to"
 W !,"the new codes."
 ;a message will display saying which codes will be affected
 F  S QACR=$O(QACIEN(QACR)) Q:QACR'>0  D
 . S QACND=^QA(745.2,QACR,0)
 . W !,"    "_$P(QACND,U)_"   "_$P(QACND,U,3)
 N DIRUT,DIROUT
 S DIR(0)="YO"
 S DIR("A")="Do you want to continue with this installation"
 S DIR("B")="YES"
 ;S DIR("?")="Installing this patch will change the entry in your file 745.2.  Proceed? "
 D ^DIR
 I $E(X)="N"!($E(X)="n") S XPDQUIT=1 W !,"Installation stopped, global destroyed."
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
INSTALL ;check to see if the patch has been installed - if so quit
 S QACQ=$$PATCH^XPDUTL("QAC*2.0*17")
 Q
