RTNQ41 ;MJK,PKE/TROY ISC;Expanded Record Inquiry cont; ; 9/4/90  9:57 AM ;
 ;;v 2.0;Record Tracking;**19,20,21**;10/22/91 
 S DFN=+RTE,(R3,R2)=""
 ;appointment
 S (I,S)=0
 F  S S=$O(^DPT(DFN,"S",S)) Q:'S  DO
 .I $P(^DPT(DFN,"S",S,0),U,2)'["C" DO
 ..S I=I+1,Z(I)=S
 ..K Z(I-3)
 N RTLPCT
 S CT=0,RTLPCT=$O(Z(0))
 I RTLPCT DO
 .F S=RTLPCT:1:RTLPCT+2 DO
 ..I $D(Z(S)),($D(^DPT(DFN,"S",Z(S),0))) DO
 ...S Y=Z(S) D D^DIQ
 ...S Y=$E($S($D(^SC(+^(0),0)):$P(^(0),"^"),1:"UNKNOWN"),1,19)_"^"_Y
 ...S CT=CT+1
 ...S R3(4-CT)=Y
 K RTLPCT
 ;admissions
 D ADM^VADPT2 S Y=VADMVT
 I +Y S CT=4,Y=^DGPM(VADMVT,0),M="adm" D ADM S M="dis",CT=5 D DIS Q
 I Y="" S M="dis",CT=5 K RTAD D DIS Q:'$D(RTAD)  S M="adm",Y=^DGPM(RTAD,0),CT=4 D ADM Q
 Q
Q K RTFUT,RTESC,RTE,RTFL,RTDTI,A1,A,S,RTVAR,RTPGM,RTDT,R,RT,M,P,DFN,RTG,RTH,RTI,T,V,^TMP($J,"RTCOMBO") D CLOSE^RTUTL
 K RTG1,%,%H,%I,N,POP,RTI1 Q
 ;
REC S V=$S('$D(^DIC(195.2,+$P(Y,"^",3),0)):"UNKNOWN",1:$P(^(0),"^",2))_+$P(Y,"^",7) Q
 ;
ADM ;
 S D1=+Y,D=9999999.9999-Y,Y=$S($D(^DIC(42,+$P(Y,"^",6),0)):$P(^(0),"^"),1:"UNKNOWN")_"                ",R2(CT)=$E(Y,1,20)_";"_M,Y=$E(D1,1,12) D D^DIQ S R2(CT)=R2(CT)_"^"_Y
 Q
DIS ;
 Q:'$D(^DGPM("ATID3",DFN))  D NOW^%DTC S Y=$O(^DGPM("ATID3",DFN,9999999.9999999-%)) Q:Y=""  S Y=$O(^(Y,0)),DA=Y,Y=^DGPM(Y,0),RTY=Y,RTAD=$S($P(Y,U,14):$P(Y,U,14),1:0)
 S DIC="^DGPM(",DR=200,DIQ(0)="E",DIQ="HLD($J," D EN^DIQ1 K DIC,DR S X=$S($D(HLD($J,405,DA,200,"E")):HLD($J,405,DA,200,"E"),1:0),X=X_"                ",Y=RTY,R2(CT)=$E(X,1,20)_";"_M,Y=+Y D D^DIQ S R2(CT)=R2(CT)_"^"_Y
 K RTY,HLD($J,405,DA),DA
 Q
 ;
DPL ;Displays the admissions and discharges.
 D LINE^RTUTL3
 F CT=1:1:3 I $D(R3(CT)) W !,$P($T(LABELS+CT),";;",2),"   ",$E($P(R3(CT),"^")_"                     ",1,20),$P(R3(CT),"^",2)
XXX F CT=4:1:5 I $D(R2(CT)) W !,$P($T(LABELS+CT),";;",2),"   ",$E($P(R2(CT),"^")_"                   ",1,20),$P(R2(CT),"^",2)
 Q
LABELS ;;
 ;;Clinic appoint  :
 ;;Clinic appoint  :
 ;;Clinic appoint  :
 ;;Last Admission  :
 ;;Last Discharge  :
