SROASWP3 ;B'HAM ISC/MAM - MANUAL MATCH RISK DATA ; 14 APR 1992  11:15 am
 ;;3.0; Surgery ;;24 Jun 93
 S SRA(0)=^SRA(SRAN,0),DFN=$P(SRA(0),"^"),(SDATE,X1)=$P(SRA(0),"^",5),X2=60 D C^%DTC S SRUPPER=X,X2=-60,X1=SDATE D C^%DTC S SRLOWER=X
 D DEM^VADPT S SRNAME=VADM(1) K VADM
 S SROPER=$P(^SRA(SRAN,"OP"),"^") K SROPS S:$L(SROPER)<65 SROPS(1)=SROPER I $L(SROPER)>64 S SROPER=SROPER_"  " K M,MM,MMM F M=1:1 D LOOP Q:MMM=""
 W @IOF,!,"PATIENT: "_SRNAME,?50,"DATE OF OPERATION: "_$E(SDATE,4,5)_"/"_$E(SDATE,6,7)_"/"_$E(SDATE,2,3),!,"ASSESSMENT NUMBER: "_SRAN,!,"PROCEDURE: "_SROPS(1) I $D(SROPS(2)) W !,?12,SROPS(2) I $D(SROPS(3)) W !,?12,SROPS(3)
 W ! F LINE=1:1:80 W "-"
 W ! K SRCASE S (SRTN,CNT)=0 F  S SRTN=$O(^SRF("B",DFN,SRTN)) Q:'SRTN  D CHECK I CASE S SROP=SRTN D LIST
 I '$D(SRCASE(1)) W !!,"There were no Surgery cases for "_SRNAME_" within the 60 days before",!,"or after the date of operation entered in this assessment." D DELETE Q
 I '$D(SRCASE(2)) D ONLYONE Q
 W !! F LINE=1:1:80 W "-"
SEL W !!,"Select the NUMBER corresponding to the ",!,"Surgery Case that this Assessment matches: " R X:DTIME I '$T!(X["^") S SRSOUT=1 Q
 I X="" D DELETE S:SRSOUT SRSOUT=0 Q
 I '$D(SRCASE(X)) W !!,"Enter the number that corresponds to the Surgery case that this assessment ",!,"matches.  If the assessment does not relate to any of the cases listed above,",!,"enter RETURN at the prompt." G SEL
MATCH W !!,"Are you sure that this is the correct Surgery Case ? YES//  " R SRYN:DTIME I '$T!(SRYN["^") S SRSOUT=1 Q
 S SRYN=$E(SRYN) I "YyNn"'[SRYN W !!,"Enter 'YES' to convert the assessemnt into the Surgery file, or 'NO' to make",!,"another selection." G MATCH
 I "Yy"[SRYN S OK=1,SRTN=SRCASE(X) W !!,"Converting Risk Assessment Information..."
 Q
CHECK ; check for dates within 60 days of procedure
 S CASE=0,SRSDATE=$P(^SRF(SRTN,0),"^",9)
 I SRSDATE<SRLOWER Q
 I SRSDATE>SRUPPER Q
 S CASE=1
 Q
LIST ; list cases
 I $P($G(^SRF(SROP,"NON")),"^")="Y" Q
 S SRSCAN=1 I $D(^SRF(SROP,.2)),$P(^(.2),"^",12)'="" K SRSCAN
 I $D(SRSCAN),$D(^SRF(SROP,30)),$P(^(30),"^") Q
 I $D(SRSCAN),$D(^SRF(SROP,31)),$P(^(31),"^",8) Q
 I $D(^SRF(SROP,37)),$P(^(37),"^") Q
 S CNT=CNT+1,SRSDATE=$P(^SRF(SROP,0),"^",9)
 W !,CNT_". "
CASE W $E(SRSDATE,4,5)_"-"_$E(SRSDATE,6,7)_"-"_$E(SRSDATE,2,3)
 S SROPER=$P(^SRF(SROP,"OP"),"^") I $O(^SRF(SROP,13,0)) S SROTHER=0 F I=0:0 S SROTHER=$O(^SRF(SROP,13,SROTHER)) Q:'SROTHER  D OTHER
 D ^SROP1 K SROPS,MM,MMM S:$L(SROPER)<65 SROPS(1)=SROPER I $L(SROPER)>64 S SROPER=SROPER_"  " F M=1:1 D LOOP Q:MMM=""
 W ?14,SROPS(1) I $D(SROPS(2)) W !,?14,SROPS(2) I $D(SROPS(3)) W !,?14,SROPS(3) W:$D(SROPS(4)) !,?14,SROPS(4)
 W ! S SRCASE(CNT)=SROP
 Q
OTHER ; other operations
 S SRLONG=1 I $L(SROPER)+$L($P(^SRF(SROP,13,SROTHER,0),"^"))>235 S SRLONG=0,SROTHER=999,SROPERS=" ..."
 I SRLONG S SROPERS=$P(^SRF(SROP,13,SROTHER,0),"^")
 S SROPER=SROPER_$S(SROPERS=" ...":SROPERS,1:", "_SROPERS)
 Q
LOOP ; break procedures
 S SROPS(M)="" F LOOP=1:1 S MM=$P(SROPER," "),MMM=$P(SROPER," ",2,200) Q:MMM=""  Q:$L(SROPS(M))+$L(MM)'<65  S SROPS(M)=SROPS(M)_MM_" ",SROPER=MMM
 Q
ONLYONE ; match if only one case
 W !!,"Do you want to match the Risk Assessment with this Surgical Case ? NO// " R SRYN:DTIME I '$T!(SRYN["^") S SRSOUT=1 Q
 S SRYN=$E(SRYN) I "YyNn"'[SRYN W !!,"Enter 'YES' to move the Risk Assessment information into this surgical case,",!,"or 'NO' if the information does not relate to this surgical case." G ONLYONE
 I "Nn"'[SRYN S SRTN=SRCASE(1),OK=1 W !!,"Converting Risk Assessment Information..." Q
DELETE ; delete assessment
 W !!,"Since this assessment cannot be matched to any Surgery case, it must be",!,"deleted.",!!,"Are you sure that you want to delete this assessment ? YES// " R SRYN:DTIME I '$T!(SRYN["^") S SRSOUT=1 Q
 S SRYN=$E(SRYN) I SRYN="" S SRYN="Y"
 I "YyNn"'[SRYN W !!,"Enter 'YES' to delete this assessment from the SURGERY RISK ASSESSMENT",!,"file (139), or 'NO' to continue matching other assessments." G DELETE
 I "Yy"'[SRYN Q
 K DA,DIK S DA=SRAN,DIK="^SRA(" W !!,"Deleting assessment from SURGERY RISK ASSESSMENT file (139)..." D ^DIK
 W !!,"Press RETURN to continue  " R X:DTIME
 Q
