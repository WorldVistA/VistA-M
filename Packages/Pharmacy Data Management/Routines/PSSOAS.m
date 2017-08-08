PSSOAS ;BP/AGV - Old Schedule Name processing ;2/9/17
 ;;1.0;PHARMACY DATA MANAGEMENT;**201**;9/30/97;Build 25
 ;
 ; @Author  - Alberto Vargas
 ; @Date    - February 9, 2017
 ; @Version - 1.0
 ;
OASDIC ; screening for the OLD SCHEDULE NAME(S) multiple
 N PSSDA,PSSX,PSSY,PSSFCHK,PSSFCHK2,PSSFCHK3,PSSFCHK4,PSSFL,PSSFL2,PSSFL3,PSSODA,PSSOX,PSSEX,PSSAIEN S PSSDA=$G(DA),PSSX=$G(X),PSSY=$G(Y),(PSSFL,PSSFL2,PSSFL3)=0,(PSSODA,PSSOX,PSSEX,PSSAIEN)=""
 N DA,D0,X,Y,DIC,DIE,DIEL,DI,DC,DR,DQ,DL,DM,DK,DP,PSSRN,MSG
 S DA=PSSDA,MSG=""
 ;
 F  S PSSRN=$$OASLE(DA),DA(1)=$G(DA) Q:'$G(DA(1))  S DIC="^PS(51.1,"_DA(1)_",5,",DIC(0)="AEMLTVZ",DIC("A")="Select OLD SCHEDULE NAME(S): "_$G(PSSRN) D ^DIC Q:+Y'>0  D
 .I $G(X)["""" S X=$P($G(Y),U,2)
 .S X=$$UP^XLFSTR(X)
 .S PSSFCHK="" F  S PSSFCHK=$O(^PS(51.1,"B",PSSFCHK)) Q:PSSFCHK']""!($G(PSSFL))  D
 ..I $G(PSSFCHK)=$G(X) S PSSFL=1
 .I $G(PSSFL)=1,$P(Y,U,3)=1 SET PSSFL=0 K X D  Q
 ..S DIE=DIC,DA=+Y,DR=".01////@" D ^DIE S DA=PSSDA
 ..S MSG(1)=""
 ..S MSG(2)="      An OLD SCHEDULE NAME(S) entry cannot be the same as an existing NAME"
 ..S MSG(3)="      field."
 ..S MSG(4)=""
 ..D EN^DDIOL(.MSG,"","!")
 .S PSSODA=+Y
 .S PSSOX=$P(Y,U,2)
 .S DIR(0)="FAO^2:20",DIR("A")="OLD SCHEDULE NAME(S): "_PSSOX_"// " D ^DIR
 .I $G(X)="^" S DA=PSSDA K X,DIR Q
 .S X=$$UP^XLFSTR($G(X))
 .I $G(X)=PSSOX S DA=PSSDA K X,DIR Q
 .S PSSFCHK2="" F  S PSSFCHK2=$O(^PS(51.1,"B",PSSFCHK2)) Q:PSSFCHK2']""!($G(PSSFL2))  D
 ..I $G(PSSFCHK2)=$G(X) S PSSFL2=1
 .I $G(PSSFL2)=1 S PSSFL2=0 K X,DIR  D  Q
 ..S DA=PSSDA
 ..S MSG(1)=""
 ..S MSG(2)="      An OLD SCHEDULE NAME(S) entry cannot be the same as an existing NAME"
 ..S MSG(3)="      field."
 ..S MSG(4)=""
 ..D EN^DDIOL(.MSG,"","!")
 .S PSSFCHK3="" F  S PSSFCHK3=$O(^PS(51.1,$G(DA),5,PSSFCHK3)) Q:PSSFCHK3']""!($G(PSSFL3))  D
 ..I $G(^PS(51.1,$G(DA),5,PSSFCHK3,0))=$G(X) S PSSFL3=1
 .I $G(PSSFL3)=1,$G(X)'="" S PSSFL3=0 K X,DIR  D  Q
 ..S DA=PSSDA
 ..S MSG(1)=""
 ..S MSG(2)="      Duplicate exists in Old Schedule Name multiple for this entry."
 ..S MSG(3)=""
 ..D EN^DDIOL(.MSG,"","!")
 .I $G(PSSFL3)=1 S PSSFL3=0
 .S PSSFCHK4="" F  S PSSFCHK4=$O(^PS(51.1,"D",PSSFCHK4)) Q:PSSFCHK4']""!($G(PSSFL4))  D
 ..I $G(PSSFCHK4)=$G(X) S PSSFL4=1 F  S PSSAIEN=$O(^PS(51.1,"D",PSSFCHK4,PSSAIEN)) Q:PSSAIEN'=""
 .I $G(PSSFL4)=1 S PSSFL4=0 K X,DIR D  Q
 ..S DA=PSSDA
 ..S MSG(1)=""
 ..S MSG(2)="      Duplicate exists in Old Schedule Name multiple for the entry"
 ..S MSG(3)="      "_$P(^PS(51.1,$G(PSSAIEN),0),U,1)_" ("_$G(PSSAIEN)_") in the file."
 ..S MSG(4)=""
 ..D EN^DDIOL(.MSG,"","!")
 .I $G(X)'="",$G(X)'="@" S PSSEX=X,DIE=DIC,DA=PSSODA,DR=".01///^S X=PSSEX" D ^DIE S DA=PSSDA K DIR
 .I $G(X)="@" S DIR(0)="YAO",DIR("A")="SURE YOU WANT TO DELETE? " D ^DIR
 .I $G(Y)=1 S DIE=DIC,DA=PSSODA,DR=".01///@" D ^DIE S DA=PSSDA K DIR
 .I $G(Y)=0 S DA=PSSDA K DIR
 I $G(X)="^" K DIC,DIE,DR,DA Q
 I $G(X)["^" D EN^DDIOL("   No Jumping allowed??","","!") K X,DIC,DIE,DR,DA Q
 S X=PSSX,Y=PSSY K DIC,DIE,DR,DA,PSSDA,PSSX,PSSY Q
 ;
OASLE(PSSDA) ; retrieve the last entry from the OLD SCHEDULE NAME (#13) field multiple
 N PSSLR,PSSLE S PSSLE=""
 I $G(^PS(51.1,$G(PSSDA),5,0))'="" S PSSLR=999999 F  S PSSLR=$O(^PS(51.1,$G(PSSDA),5,PSSLR),-1) S:$G(^PS(51.1,$G(PSSDA),5,PSSLR,0))'="" PSSLE=$G(^PS(51.1,$G(PSSDA),5,PSSLR,0))_"// " Q:PSSLR'=""
 Q $G(PSSLE)
