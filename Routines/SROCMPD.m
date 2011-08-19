SROCMPD ;B'HAM ISC/MAM - DELETE OCCURRENCE ; 24 SEPT 1990  2:55 PM
 ;;3.0; Surgery ;**38**;24 Jun 93
KEY I '$D(^XUSEC("SROEDIT",DUZ)) W !!,"You do not have the access necessary to delete a case from the file.",!!,"Press RETURN to continue  " R X:DTIME Q
 W !!,"By deleting this case, all information stored for this occurrence will be",!,"removed from the computer."
DEL W !!,"Are you sure that you want to delete this occurrence ?  NO//  " R SRYN:DTIME I '$T!(SRYN["^") Q
 S SRYN=$E(SRYN) I SRYN="" S SRYN="N"
 I "YyNn"'[SRYN W !!,"Enter 'YES' to delete this occurrence, or RETURN if you have made a mistake." G DEL
 I "Nn"[SRYN Q
 S SRCC="",SROPCOM="Occurrence ..." D KILL^SROPDEL
 Q
