SRSUTL ;B'HAM ISC/MAM - SCHEDULING UTILITY ROUTINE; 13 Feb 1989  12:09 PM
 ;;3.0; Surgery ;**37**;24 Jun 93
PATRN ; set pattern in OPERATING ROOM file
 S SRS1=+SRSST,SRS2=+SRSET
 ; algorithm for setting start and end of pattern
 S SRS1=11+((SRS1\1)*5)+(SRS1-(SRS1\1)*100\15),SRS2=11+((SRS2\1)*5)+(SRS2-(SRS2\1)*100\15)
 S S="" F I=SRS1:1:SRS2-1 S S=S_$S('(I#5):"|",$E(SRSSER,I#5)'="":$E(SRSSER,I#5),1:".")
 S X0=^SRS(SRSOR,"SS",SRSDATE,1),(X0,^(1))=$E(X0,1,SRS1)_S_$E(X0,SRS2+1,200),^SRS(SRSOR,"SS",SRSDATE,0)=SRSDATE
 S X1=^SRS(SRSOR,"S",SRSDATE,1) F I=SRS1:1:SRS2 I "X="'[$E(X1,I) S X1=$E(X1,1,I-1)_$E(X0,I)_$E(X1,I+1,200)
 S ^SRS(SRSOR,"S",SRSDATE,1)=X1,^SRS(SRSOR,"S",SRSDATE,0)=SRSDATE
 Q
CONCRNT ; concurrent case check
 W !!,"There is a concurrent case associated with this operation.  Do you want to",!,"schedule it for the same time ? (Y/N)  " R SRBOTH:DTIME I '$T S SRBOTH="^"
 S SRBOTH=$E(SRBOTH) I "^^"[SRBOTH W !!,"This prompt must be answered 'YES' or 'NO'." G CONCRNT
 I "YyNn"'[SRBOTH W !!,"If you want to schedule these operations concurrently, answer 'Y'.  If not,",!,"answer 'N' and these cases will no longer be associated with each other." G CONCRNT
 I "Yy"[SRBOTH S SRBOTH=1
 I SRBOTH'=1 D NOCC
 S SRSCC=1 Q:SRBOTH'=1  S SRTN=$P(^SRF(SRTN,"CON"),"^"),SRSOP=$P(^SRF(SRTN,"OP"),"^")
 Q:'$D(SRUPDT)  K ^SRF("AOR",SRSOR,OLDATE,SRTN) S SRATT=$P(^SRF(SRTN,.1),"^",13)
 S SRTREAT=$P(^SRF(SRTN,0),"^",4) I SRTREAT'="" K ^SRF("ASP",SRTREAT,OLDATE,SRTN) S ^SRF("ASP",SRTREAT,SRSDATE,SRTN)=SRTN
 Q
NOCC ; no longer concurrent cases
 S DIE=130,DR="35///@",DA=$P(^SRF(SRTN,"CON"),"^") D ^DIE S SROERR=$P(^SRF(SRTN,"CON"),"^") D ^SROERR0 S DA=SRTN,DR="35///@" D ^DIE S SROERR=SRTN D ^SROERR0
 I $D(SRTNEW) S DA=SRTNEW,DR="35///@",DIE=130 D ^DIE S SROERR=SRTNEW D ^SROERR0
 Q
OTHER ; other operations
 S SRLONG=1 I $L(SROPER)+$L($P(^SRF(SRTN,13,OPER,0),"^"))>250 S SRLONG=0,OPER=999,SROPERS=" ..."
 I SRLONG S SROPERS=$P(^SRF(SRTN,13,OPER,0),"^")
 S SROPER=SROPER_$S(SROPERS=" ...":SROPERS,1:", "_SROPERS)
 Q
