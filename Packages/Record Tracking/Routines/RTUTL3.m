RTUTL3 ;TROY ISC/MJK-Utility Routine ; 3/16/87  2:05 PM ; 1/30/03 3:52pm
 ;;2.0;Record Tracking;**33**;10/22/91
EQUALS S L1="="
LINE S L1=$S('$D(L1):"-",L1="=":L1,1:"-") K L2 S $P(L2,L1,$S($D(IOM):IOM+1,1:81))="" W !,L2 K L2,L1 Q
 ;
PT W ! S DIC("A")="Select PATIENT: ",DIC="^DPT(",DIC(0)="IAEMQ" D ^DIC K:Y<0 DIC Q:Y<0  D:'$G(DICR) ^DGSEC K DIC Q:Y<0  S DFN=+Y,RTE=+Y_";DPT(",^DISV($S($D(DUZ)'[0:DUZ,1:0),"RT",+RTAPL)=RTE Q
 ;
H ;
 S RTIME=$P(X,".",2)_"00000",X=$P(X,".") D H^%DTC I %Y<0 S X=-1 G HQ
 S Y=RTIME,Y=($E(Y,1,2)*3600)+($E(Y,3,4)*60),X=%H_","_Y
HQ K RTIME Q
 ;
CHK ;INQUIRY DISPLAY ORDER input transform check for record types
 Q:'X!('$P(^DIC(195.2,DA,0),"^",3))  S RTZ1="T^A" D SAVE^RTUTL1 S A=+$P(^(0),"^",3)
 F T=0:0 S T=$O(^DIC(195.2,"C",A,T)) Q:'T  I T'=DA,$D(^DIC(195.2,T,0)),$P(^(0),"^",4)=X W !?3,"...the '",$P(^(0),"^"),"' already uses order number '",X,"'  " K X Q
 K A,T D RESTORE^RTUTL1 Q
 ;
LATEST ;Entry to find latest volume/borrower/phone/room# for a record type
 ;Inputs variables: RTE,RTYPE
 ;Outputs variable: RTDATA=<VOL>^<BORROWER>^<PHONE/ROOM#>^<DATE/TIME CHARGED>
 ;            RT    =<INTERNAL ENTRY NUMBER>
 ;
 S (RT0,RTCL)="" F RT=0:0 S RT=$O(^RT("AT",RTYPE,RTE,RT)) Q:'RT  I $D(^RT(RT,0)),$P(^(0),"^",7)>$P(RT0,"^",7) S RT0=RT_";"_^(0),RTCL=$S($D(^("CL")):^("CL"),1:"")
 S RT=+RT0,RTDATA=$P(RT0,"^",7)_"^Unknown^Unknown^"_+$P(RTCL,"^",6) I $D(^RTV(195.9,+$P(RTCL,"^",5),0)) S Y=^(0),$P(RTDATA,"^",3)=$P(Y,"^",7),Y=$P(Y,"^") D NAME^RTB S $P(RTDATA,"^",2)=Y
 K RT0,RTCL Q
 ;
XRAY Q:'$D(^DIC(195.4,1,"RAD"))  S RTYPE=+$P(^("RAD"),"^",2) D LATEST K RTYPE Q
 ;
MED Q:'$D(^DIC(195.4,1,"MAS"))  S RTYPE=+$P(^("MAS"),"^",2) D LATEST K RTYPE Q
