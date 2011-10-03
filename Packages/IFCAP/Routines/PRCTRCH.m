PRCTRCH ;WISC@ALTOONA/RGY-HANDLE INTEGRITY CHECK OF REPORT ;01 Jun 90/3:57 PM
 ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 S ERR=0 I '$D(^PRCT(446.5,DA,0)) S ERR=1 G Q
 S N0=^PRCT(446.5,DA,0) I $P(N0,"^")="" S ERR=1 W *7,!,"Error, name of report is null"
 I $P(N0,"^",2),'$D(^DIC($P(N0,"^",2),0)) S ERR=1 W *7,!,"Error, FILE defined for this entry does not exist"
 I '$O(^PRCT(446.5,DA,1,0)) W *7,!,"Error, no report text exists!" S ERR=1
 F X=0:0 S X=$O(^PRCT(446.5,DA,1,X)) Q:'X  D LNCH
 F X=0:0 S X=$O(^PRCT(446.5,DA,2,X)) Q:'X  D PCH
Q K PRCTE,FL,PRCT,N0 Q
LNCH S Y=^PRCT(446.5,DA,1,X,0) I $L(Y,"|")-1#2 W *7,!,"Report TEXT line #",X," parameter is invalid!" S ERR=1
 F PRCT=2:2:$L(Y,"|") I $P(Y,"|",PRCT)'?.N W *7,!,"Parameter in line #",X," is not numeric" S ERR=1
 F PRCT=2:2:$L(Y,"|") I '$D(^PRCT(446.5,DA,2,+$P(Y,"|",PRCT),0)) W *7,!,"Parameter #",$P(Y,"|",PRCT)," in line #",X," is not defined" S ERR=1
 Q
PCH S Y=^PRCT(446.5,DA,2,X,0) I $P(Y,"^",2)=1,$P(Y,"^",4)="" W *7,!,"Error, parameter #",X," is defined as FIELD, but has no field defined." S ERR=1
 I $P(Y,"^",2)=1,$P(N0,"^",2)="" W *7,!,"Error, parameter #",X," is defined as FIELD, but no FILE has been defined." S ERR=1
 I $P(Y,"^",2)=1,$P(N0,"^",2) S PRCTE=$P(Y,"^",4),FL=$P(N0,"^",2) F PRCT=0:0 S PRCT=+PRCTE,PRCTE=$P(PRCTE,+PRCTE,2,999) Q:PRCT=0  D FLD Q:'FL  S PRCTE=$E(PRCTE,2,999)
 I $P(Y,"^",2)=0&($P(Y,"^",7)=""!($P(Y,"^",8)="")) W *7,!,"Error, parameter #",X," is defined as COUNTER, but START and/or INCREMENT",!,"  ... are not defined" S ERR=1
 I $P(Y,"^",2)=2,$S('$D(^PRCT(446.5,DA,2,X,1)):1,^(1)="":1,1:0) W *7,!,"Error, parameter #",X," is defined as XECUTABLE CODE, but no CODE has",!,"  ... been defined!" S ERR=1
 Q
FLD ;
 I $S($D(^DD(FL,PRCT,0)):0,1:1) S ERR=1 W *7,!,"Field in parameter ",X," does not exist in file specified" S FL=0 Q
 I $E(PRCTE)]"" S FL=$S($E(PRCTE)=":":+$P($P(^DD(FL,PRCT,0),"^",2),"P",2),1:+$P(^(0),"^",2)) I 'FL S ERR=1 W *7,!,"An invalid field exists for parameter #",X
 Q
