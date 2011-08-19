SROLOCK ;B'HAM ISC/MAM - USED TO LOCK A CASE ;11/10/04
 ;;3.0; Surgery ;**7,50,134**;24 Jun 93
CHECK ; check to determine if a case is locked
 K SROLOCK I $D(^SRF(SRTN,"LOCK")),$P(^("LOCK"),"^")=1 S SROLOCK=1
 I $D(SROLOCK) W !!,"This case has been verified and locked.  It cannot be updated unless",!,"unlocked by your chief, or someone appointed by your chief.",!!,"Press RETURN to continue  " R X:DTIME
 Q:$D(SROLOCK)  S SROLOCK=0
 Q
UNLOCK ; unlock a case for editing
 S Z=0 D SEL I '$D(SRTN) G END
 I '$P($G(^SRF(SRTN,"LOCK")),"^") W !!,"This case is not locked." G END
 S ^SRF("AL",SRTN)="",^SRF(SRTN,"LOCK")="" W !!,"Case #"_SRTN_" is now unlocked."
END W !!,"Press RETURN to continue  " R X:DTIME W @IOF
 K SROPS,C,CASE,CNT,CPT,DATE,DFN,I,M,LOOP,SRTN,SROPER,X,Y,Z
 Q
LOCK ; queued to run nightly, locks cases that are passed the specified
 ; number of days for editing
 S SITE=0 F  S SITE=$O(^SRO(133,SITE)) Q:'SITE  S SR=^SRO(133,SITE,0),DAYS=$P(SR,"^",11) I DAYS S SRSITE("DIV")=$P(SR,"^") D
 .S X1=DT,MOE=25+DAYS,X2="-"_MOE D C^%DTC S START=X,X1=DT,X2="-"_DAYS D C^%DTC S END=X
 .S DATE=START-.0001 F  S DATE=$O(^SRF("AC",DATE)) Q:DATE>END!(DATE="")  D SRTN
 S L=0 F  S L=$O(^SRF("AL",L)) Q:L=""  S:$D(^SRF(L,0)) ^SRF(L,"LOCK")=1 K ^SRF("AL",L)
 ; clean up case edit/lock flags in ^XTMP
 S SRNOW=$$NOW^XLFDT,SRCASE="SRLOCK-0" F  S SRCASE=$O(^XTMP(SRCASE)) Q:SRCASE=""  S SRNOW1=$P($G(^XTMP(SRCASE,0)),"^") I SRNOW>SRNOW1 K ^XTMP(SRCASE)
 Q
SRTN S SRTN=0 F  S SRTN=$O(^SRF("AC",DATE,SRTN)) Q:SRTN=""  I $D(^SRF(SRTN,0)),$$DIV^SROUTL0(SRTN),$P($G(^SRF(SRTN,.2)),"^",12)!$P($G(^SRF(SRTN,"NON")),"^",5) S ^SRF(SRTN,"LOCK")=1
 Q
SEL ; select patient and case
 W @IOF S DIC(0)="QEAM",DIC=2 D ^DIC K DIC Q:Y'>0  S DFN=+Y,(CNT,SRCNT)=0
 I '$O(^SRF("ADT",DFN,0)) W !!,"No cases have been scheduled for the patient chosen.",!! Q
 W ! S SRI=0 F  S SRI=$O(^SRF("ADT",DFN,SRI)) Q:SRI=""  S SRTN=0 F  S SRTN=$O(^SRF("ADT",DFN,SRI,SRTN)) Q:SRTN=""   S L=$P($G(^SRF(SRTN,"LOCK")),"^") I L=1 S DATE=$P(^SRF(SRTN,0),"^",9),SRCNT=SRCNT+1 D LIST
 I 'SRCNT W !!,"There are no locked cases for this patient." K SRTN Q
 D ASK
 Q
LIST W !,?5,SRCNT_". "_$E(DATE,4,5)_"-"_$E(DATE,6,7)_"-"_$E(DATE,2,3)
 S CNT=CNT+1,(CPT,SROPER)=$P(^SRF(SRTN,"OP"),"^") I $P($G(^SRF(SRTN,"NON")),"^")="Y" S SROPER=SROPER_" (NON-OR PROCEDURE)"
 K SROPS,MM,MMM S:$L(SROPER)<55 SROPS(1)=SROPER I $L(SROPER)>54 S SROPER=SROPER_"  " F M=1:1 D LOOP Q:MMM=""
 W ?22,SROPS(1) W:$D(SROPS(2)) !,?22,SROPS(2) W:$D(SROPS(3)) !,?22,SROPS(3) S CPT(CNT)=SRTN
 Q
ASK R !!,"Select Number: ",Z:DTIME I '$T!("^"[Z) K SRTN Q
 I Z["?" W !!,"Enter the number of the desired procedure, or '^' to quit." G ASK
 S:$D(CPT(Z)) SRTN=CPT(Z) I '$D(CPT(Z)) K SRTN
 Q
LOOP ; break procedure if greater than 55 characters
 S SROPS(M)="" F LOOP=1:1 S MM=$P(SROPER," "),MMM=$P(SROPER," ",2,200) Q:MMM=""  Q:$L(SROPS(M))+$L(MM)'<55  S SROPS(M)=SROPS(M)_MM_" ",SROPER=MMM
 Q
ALL ; lock all eligible cases in entire file
 Q:'$O(^SRO(133,0))
 S SITE=0 F  S SITE=$O(^SRO(133,SITE)) Q:'SITE  S DAYS=$P(^SRO(133,SITE,0),"^",11),X1=DT,X2=$S(DAYS:"-"_DAYS,1:0) D C^%DTC S SRDIV(SITE)=X
 S SRTN=0 F  S SRTN=$O(^SRF(SRTN)) Q:'SRTN  S SR=$G(^SRF(SRTN,0)) I SR'="",$P($G(^SRF(SRTN,.2)),"^",12)!$P($G(^SRF(SRTN,"NON")),"^",5) D
 .S SITE=$$SITE^SROUTL0(SRTN) I SITE'="" S DATE=$P(SR,"^",9) I DATE<SRDIV(SITE) S ^SRF(SRTN,"LOCK")=1
 K DATE,DAYS,SITE,SR,SRDIV,SRTN,X,X1,X2
 Q
