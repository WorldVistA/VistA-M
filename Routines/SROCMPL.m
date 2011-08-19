SROCMPL ;B'HAM ISC/MAM - ENTER NON-OPERATIVE OCCURRENCES; [ 01/08/98   9:54 AM ]
 ;;3.0; Surgery ;**38,77**;24 Jun 93
 W @IOF,!,"NOTE:  You are about to enter an occurrence for a patient that has not had an",!,"operation during this admission.  If this patient has a surgical procedure"
 W !,"during the current admission, use the option to enter or edit intraoperative",!,"and postoperative occurrences.",!!
 W !! K Y,DIC S DIC=2,DIC(0)="QEAM" D ^DIC G:Y<0 END S DFN=+Y,SRNM=$P(Y,"^",2)
 W @IOF,!,?3,SRNM,!
 S (SROP,CNT)=0 F I=0:0 S SROP=$O(^SRF("ANON",DFN,SROP)) Q:'SROP  S CNT=CNT+1,SRSDATE=$P(^SRF(SROP,0),"^",9) D LIST
 S CNT=CNT+1,SRCASE(CNT)="" W !!,CNT_".",?14,"ENTER A NEW NON-OPERATIVE OCCURRENCE"
OPT R !!!!,"Select Number:  ",OPT:DTIME I '$T!("^"[OPT) K SRTN G END
 I OPT["?"!('$D(SRCASE(OPT))) W !!,"Enter the number of the desired occurrence, or '"_CNT_"' to enter a new occurrence." G OPT
 G:OPT=CNT NEW
ENTER S SRTN=SRCASE(OPT) R !!!,"Enter or Delete Data ?  E// ",Z:DTIME G:'$T!(Z="^") END S Z=$E(Z) S:Z="" Z="E"
 I "ED"'[Z D HELP G ENTER
 I "Dd"[Z D ^SROCMPD G END
 S SRSDATE=$P(^SRF(SRTN,0),"^",9) W @IOF D COMP
 G END
LIST ; list case
 W !,CNT_". "_$E(SRSDATE,4,5)_"-"_$E(SRSDATE,6,7)_"-"_$E(SRSDATE,2,3),?14,"OCCURRENCE IN WHICH THERE WAS NO SURGICAL PROCEDURE",!,?14,"DURING THE CURRENT ADMISSION" S SRCASE(CNT)=SROP
 Q
HELP ; help text
 W !!,"Enter RETURN to select an option used to enter or edit information for this",!,"case.  If you would like a two screen overview of this operation, enter"
 W !,"'Review'.  To delete this surgical case from your records, Enter 'Delete'.",!,"Please note that choosing to delete a case will remove EVERYTHING pertaining",!,"to this operative procedure.",!
 Q
KEY S NOKEY=0 I '$D(^XUSEC("SROEDIT",DUZ)) S NOKEY=1 W !!,"You do not have the access necessary to delete a case from the file.",!!,"Press RETURN to continue  " R X:DTIME Q
 Q
END W @IOF D ^SRSKILL K SRTN
 Q
PROMPT ;
 D KEY Q:NOKEY  W !!,"By deleting this case, all information stored for this operative procedure",!,"will be removed from the computer."
 Q
NEW ; enter new occurrence
 W @IOF,! S %DT("A")="Select the Date of Occurrence: ",%DT="AEXP" D ^%DT I Y<0 W !!,"When entering a new non-operative occurrence, a date MUST be entered.",!! G SROCMPL
 G:Y'>0 END S SRSDATE=Y
 S SRPRIN="OCCURRENCE IN WHICH THERE WAS NO SURGICAL PROCEDURE DURING THE CURRENT ADMISSION"
 K DA,DIC,DO,DD,DINUM,SRTN S X=DFN,DIC="^SRF(",DIC(0)="L",DLAYGO=130 D FILE^DICN K DIC,DLAYGO S SRTN=+Y
 K DIE,DR S DA=SRTN,DIE=130,DR=".09///"_SRSDATE_";26///"_SRPRIN D ^DIE K DR S ^SRF(SRTN,37)=1
COMP ; enter occurrence information
 K DIE,DR S DR="[SROCOMP]",DIE=130,DA=SRTN D ^DIE K DR W !!,"Press RETURN to continue  " R X:DTIME
 D END
 Q
