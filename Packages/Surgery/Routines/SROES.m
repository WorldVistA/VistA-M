SROES ;BIR/ADM - SURGERY E-SIG UTILITY ;06/07/06
 ;;3.0; Surgery ;**100,153**;24 Jun 93;Build 11
 ;
 ;** NOTICE: This routine is part of an implementation of a nationally
 ;**         controlled procedure.  Local modifications to this routine
 ;**         are prohibited.
 ;
 ; Reference to EXTRACT^TIULQ supported by DBIA #2693
 ;
SRA N SRRISK S SRRISK=1
ENTER Q:'$G(SRTN)
 N SRSOUT D CHECK I $G(SRSOUT) K SRSOUT S XQUIT=""
 Q
CHECK ; pre-edit capture of nurse and anesthesia reports for addenda
 N I,SRA,SRAUDIT,SRCCASE,SRESAR,SRESNR,SRN,SROP,SRSIGN,SRTIU,SRX,SRY,X S (SRAUDIT,SRSOUT)=0
 S (SRA(SRTN),SRAUDIT(SRTN),SRN(SRTN))=0,SRTIU=$G(^SRF(SRTN,"TIU")),SRESNR=$P(SRTIU,"^",2),SRESAR=$P(SRTIU,"^",4),SROP=SRTN D DOCS
 S SRCCASE=$P($G(^SRF(SRTN,"CON")),"^") I SRCCASE S (SRA(SRCCASE),SRAUDIT(SRCCASE),SRN(SRCCASE))=0,SRTIU=$G(^SRF(SRCCASE,"TIU")),SRESNR=$P(SRTIU,"^",2),SRESAR=$P(SRTIU,"^",4),SROP=SRCCASE D DOCS
 S X=0 F  S X=$O(SRAUDIT(X)) Q:'X  I SRAUDIT(X) S SRAUDIT=1 Q
 Q:'SRAUDIT
 D:'$G(SRRISK) WARN I SRSOUT Q
 D KTMP
 N SRLCK S SRLCK=$$LOCK^SROUTL(SRTN) I 'SRLCK S XQUIT="",SRSOUT=1 Q
 S SROP=0 F  S SROP=$O(SRAUDIT(SROP)) Q:'SROP  D PRE
 Q
KTMP ; kill TMP globals
 F I="SRADDEND","SRAR","SRNR","SRASAVE","SRNSAVE" K ^TMP(I,$J)
 F I=1,2 F J="SRAD","SRADM","SRARAD","SRARMULT","SRNRAD","SRNRMULT" K ^TMP(J_I,$J)
 Q
DOCS ; determine if signed
 I SRESNR S SRX=SRESNR,SRSIGN=0 D SIGNED I SRSIGN S SRN(SROP)=1
 I SRESAR S SRX=SRESAR,SRSIGN=0 D SIGNED I SRSIGN S SRA(SROP)=1
 Q
SIGNED I SRX N SRERR D EXTRACT^TIULQ(SRX,"SRY",.SRERR,".05") I SRY(SRX,.05,"I")=7 S SRSIGN=1,SRAUDIT(SROP)=1
 K SRY
 Q
PRE ; save pr-edit copy of case data
 N SRTN S SRTN=SROP
 D:SRN(SRTN)=1 IN^SROESNR D:SRA(SRTN)=1 IN^SROESAR
 Q
WARN ; warning message that addendum may be required
 D HDR W !!!,?30,">>>  WARNING  <<<"
 W !!,"   Electronically signed reports are associated with this case.  Editing",!,"   of data that appear on electronically signed reports will require the",!,"   creation of addenda to the signed reports.",!!!
 K DIR S DIR(0)="E" D ^DIR K DIR I $D(DTOUT)!$D(DUOUT) S SRSOUT=1
 Q
HDR S DFN=$P(^SRF(SRTN,0),"^") D DEM^VADPT S Y=$E($P(^SRF(SRTN,0),"^",9),1,7) X ^DD("DD") S SRSDATE=Y
 W @IOF,!," "_VADM(1)_" ("_VA("PID")_")   Case #"_SRTN_" - "_SRSDATE
 Q
EXIT ; post-edit check to see if addenda to nurse/anes. reports are required
 Q:'$D(SRTN)  D WAIT^DICD
 D:$D(^TMP("SRNRAD1",$J,SRTN)) EX^SROESNR
 D:$D(^TMP("SRARAD1",$J,SRTN)) EX^SROESAR
 I $D(^TMP("SRNRAD1",$J,SRTN))!$D(^TMP("SRARAD1",$J,SRTN))!$D(^TMP("SRNRAD2",$J,SRTN))!$D(^TMP("SRARAD2",$J,SRTN)) D ^SROESAD1
 N SRCCASE,SRTN1 S SRCCASE=$P($G(^SRF(SRTN,"CON")),"^") I SRCCASE S SRTN1=SRTN S SRTN=SRCCASE D
 .D:$D(^TMP("SRNRAD1",$J,SRTN)) EX^SROESNR
 .D:$D(^TMP("SRARAD1",$J,SRTN)) EX^SROESAR
 .I $D(^TMP("SRNRAD1",$J,SRTN))!$D(^TMP("SRARAD1",$J,SRTN)) D ^SROESAD1
 .S SRTN=SRTN1
DOC N SRADOC,SRDOC,SRNDOC S (SRADOC,SRDOC,SRNDOC)=0
 I $O(^TMP("SRNR",$J,SRTN,0)) S SRNDOC=SRNDOC+1,SRDOC=SRDOC+1,SRNDOC(SRTN)="Nurse Intraoperative Report - Case #"_SRTN
 I SRCCASE,$O(^TMP("SRNR",$J,SRCCASE,0)) S SRNDOC=SRNDOC+1,SRDOC=SRDOC+1,SRNDOC(SRCCASE)="Nurse Intraoperative Report - Concurrent Case #"_SRCCASE
 I $O(^TMP("SRAR",$J,SRTN,0)) S SRADOC=SRADOC+1,SRDOC=SRDOC+1,SRADOC(SRTN)="Anesthesia Report - Case #"_SRTN
 I SRCCASE,$O(^TMP("SRAR",$J,SRCCASE,0)) S SRADOC=SRADOC+1,SRDOC=SRDOC+1,SRADOC(SRCCASE)="Anesthesia Report - Concurrent Case #"_SRCCASE
 I 'SRDOC Q
 D HDR W !!,"An addendum to each of the following electronically signed document(s) is",!,"required:",!
 S X=0 F  S X=$O(SRNDOC(X)) Q:'X  W !,?10,SRNDOC(X)
 S X=0 F  S X=$O(SRADOC(X)) Q:'X  W !,?10,SRADOC(X)
 W !!,"If you choose not to create an addendum, the original data will be restored",!,"to the modified fields appearing on the signed reports.",!!
 N SRESNOT S SRESNOT=0 K DIR S DIR(0)="Y",DIR("A")="Create addendum",DIR("B")="YES" D ^DIR K DIR I $D(DTOUT)!$D(DUOUT)!'Y S SRESNOT=1 D ALLREV Q
 D ^SROESAD I SRESNOT D REVRS,PRESS
 I SRCCASE S SRTN1=SRTN,SRTN=SRCCASE,SRESNOT=0 D ^SROESAD D:SRESNOT REVRS,PRESS S SRTN=SRTN1
UNLOCK D UNLOCK^SROUTL(SRTN),KTMP
 Q
PRESS W ! K DIR S DIR(0)="FOA",DIR("A")="Press RETURN to continue... " D ^DIR K DIR
 Q
ALLREV ; restore modified fields for both concurrent cases
 W !!,"No addendum created.  Original data will be restored.",!!
 D REVRS S SRCCASE=$P($G(^SRF(SRTN,"CON")),"^") I SRCCASE S SRTN1=SRTN,SRTN=SRCCASE D REVRS S SRTN=SRTN1
 D UNLOCK,PRESS
 Q
REVRS ; restore modified fields on signed reports
 D REVRS^SROESNR0,REVRS^SROESAR0
 S SROERR=SRTN D ^SROERR0
 Q
