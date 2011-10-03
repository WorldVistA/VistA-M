DGPMVBUL ;ALB/MIR/MAC - SEND MOVEMENT BULLITENS; 12 Sep 1989
 ;;5.3;Registration;;Aug 13, 1993
 ;
 ;send UR admission bulletin
 D ^DGPMVBUR
 ;
 ;Send Unverified Eligibility Bulletin
 Q:'$D(DFN)  D ^DGPATV S DGB=$S('DGVETS:7,'$D(^DPT(DFN,.361)):0,$P(^DPT(DFN,.361),"^",1)'="V":5,1:0) G EN:'DGB
 D INFO
 I '$D(DGPMDA) G EN
 S DGADMIT=$S($D(^DGPM(DGPMDA,0)):^(0),1:"") G EN:'DGADMIT S Y=+DGADMIT X ^DD("DD") S DGTEXT(DGC,0)="ADMITTED:  "_Y,DGC=DGC+1
 S DGTEXT(DGC,0)="    TYPE:  "_$S($D(^DG(405.1,+$P(DGADMIT,"^",4),0)):$P(^(0),"^",1),1:"UNKNOWN"),DGC=DGC+1,DGTEXT(DGC,0)="    WARD:  "_$S($D(^DIC(42,+$P(DGADMIT,"^",6),0)):$P(^(0),"^",1),1:"UNKNOWN")
 I DGB=5 S DGC=DGC+1,DGTEXT(DGC,0)="",DGC=DGC+1,DGTEXT(DGC,0)="Veterans eligibility has not been verified yet." S DGC=DGC+1,DGTEXT(DGC,0)=""
EN S DGFL=0 F DGI=0:0 S DGI=$O(^DGS(41.1,"B",DFN,DGI)) Q:'DGI  S J=$S($D(^DGS(41.1,DGI,0)):^(0),1:0),Y=$P(J,"^",2) I Y X ^DD("DD") I '$P(J,"^",13),'$P(J,"^",17) D WR
 S DGFL=0 F X=0:0 S X=$O(^DGWAIT("C",DFN,X)) Q:'X  S Y=$O(^(+X,0)) G T:('X)!('Y) I $D(^DGWAIT(X,"P",Y,0)) S I=^(0) D:'DGFL TEXT S DGC=DGC+1,DGG=$S($D(^DG(40.8,+^DGWAIT(X,0),0)):$E($P(^(0),"^",1),1,20),1:"") D CO
T G Q:'$D(DGTEXT) S DGB=$S(DGB:DGB,1:5) D ^DGBUL
Q K DGADMIT,DGB,DGC,DGFL,DGG,DGI,I,J,X,Y D KILL^DGPATV Q
 Q
INFO I $D(DGC) S DGC=DGC+1 Q
 S XMSUB=$S('DGVETS:"NON-VETERAN ADMISSION",DGB=0:"FUTURE ACTIVITY SCHEDULED",1:"VETERAN ADMISSION WITHOUT VERIFIED ELIGIBILITY")
 S DGTEXT(1,0)="NAME:  "_DGNAME,DGTEXT(2,0)="SSN :  "_$P(SSN,"^",2),DGTEXT(3,0)="DOB :  "_$P(DOB,"^",2),DGTEXT(4,0)="ELIG:  "_$P(DGEC,"^",2)
 S DGC=5,DGTEXT(DGC,0)="",DGC=DGC+1
 Q
WR I 'DGFL D INFO S DGTEXT(DGC,0)="This patient has the following Scheduled Admissions on file:" S DGFL=1
 S DGC=DGC+1,DGTEXT(DGC,0)="      DATE: "_Y_"   "_$S($P(J,"^",10)="W":"WARD: "_$S($D(^DIC(42,+$P(J,"^",8),0)):$P(^(0),"^",1),1:""),$P(J,"^",10)="T":"FACILITY TREATING SPECIALTY: "_$S($D(^DIC(45.7,+$P(J,"^",9),0)):$P(^(0),"^",1),1:""),1:"") Q
 Q
TEXT D INFO S:'DGFL DGTEXT(DGC,0)="This patient has the following waiting list entries:" S DGFL=1 Q
CO S Y=$P(I,"^",2) X ^DD("DD") S DGTEXT(DGC,0)="        TO: "_DGG_"    APPLIED: "_Y_"      BEDSECTION: "_$P(I,"^",5) Q
