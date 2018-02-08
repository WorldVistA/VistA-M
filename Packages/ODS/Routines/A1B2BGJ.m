A1B2BGJ ;ALB/MIR - BACKGROUND JOB TO UPDATE A1B2 ENTRIES ; 14 JAN 91
 ;;Version 1.55 (local for MAS v5 sites);;
 ;
 F I=1:1:4 S A1B2FN=11500+(I/10) F J=0:0 S J=$O(^A1B2(A1B2FN,"AX",0,J)) Q:'J  I $D(^A1B2(A1B2FN,J,0)) S DIE="^A1B2("_A1B2FN_",",DA=J,DR="" D @I:I'=3,2:I=3 D DIE:DR]""
 D ST^A1B2T1
 K XFR,I,J,A1B2FN D KILL^%ZTLOAD
 Q
 ;
 ;
DIE ; new variables, call ^DIE
 N I,J,K D ^DIE
 Q
 ;
 ;
1 ;Update patients
 S DFN=$S($D(^A1B2(11500.1,+J,0)):$P(^(0),"^",12),1:"") Q:'DFN
 F K=0,.32,"ODS" S X(K)=$S($D(^DPT(DFN,K)):^(K),1:"")
 S DR=".01///"_$P(X(0),"^",9)_";.02////"_$P(X(0),"^",1)_";.03////"_$P(X(0),"^",3)_";.04///"_$S($P(X(.32),"^",5):"/"_$P(X(.32),"^",5),1:"@")_";.05///"_$S($P(X("ODS"),"^",3):"/"_$P(X("ODS"),"^",3),1:"@")
 S DR=DR_";.06///"_$S($P(X("ODS"),"^",2)]"":"/"_$P(X("ODS"),"^",2),1:"@")_";.07///"_$S('$D(^DPT(DFN,"DAC")):"",$P(^("DAC"),"^",1)]"":"/"_$P(^("DAC"),"^",1),1:"@")_";1.01////3"
 S ^A1B2(11500.1,J,.11)=$S($D(^DPT(DFN,.11)):^(.11),1:"") S X=^(.11),$P(^A1B2(11500.1,J,.11),"^",7)=$S($D(^DIC(5,+$P(X,"^",5),1,+$P(X,"^",7),0)):$P(^(0),"^",1),1:"")
 Q
 ;
 ;
2 ;Update admissions/discharges
 S XFR="AODS"_$S(I=2:"A",1:"D"),IFN=+$O(^DGPM(XFR,J,0)) I '$D(^DGPM(IFN,0)) Q
 F X=0,"ODS" S X(X)=$S($D(^DGPM(IFN,X)):^(X),1:"")
 I $P(X("ODS"),"^",7) D 3 Q
 S (X(1),X("ODS1"))=""
 I $P(X(0),U,17) S:$D(^DGPM($P(X(0),U,17),0)) X(1)=^(0) S:$D(^("ODS")) X("ODS1")=^("ODS")
 S DGSPEC=$O(^DGPM("APHY",IFN,0)),DGSPEC=$S($D(^DGPM(+DGSPEC,0)):$P(^(0),"^",9),1:""),DGSPEC=$S($D(^DIC(45.7,+DGSPEC,0)):$P(^(0),"^",2),1:"")
 S DR=".01///"_+X(0)_";.03////"_DGSPEC_";.05////"_$S($D(^DG(405.1,+$P(X(1),"^",4),0)):$P(^(0),"^",3),1:"")
 S DR=DR_";.06////"_$S(+X(1):+X(1),1:"")_";.1////"_$S($D(^DIC(4,+$P(X(1),"^",5),0)):$P(^(0),"^",1),1:"")_";.11////"_$P(X("ODS1"),"^",2)_";1.01////3"
 K DGSPEC Q
 ;
 ;
3 ;Update displace patients
 S DR=".01///"_+X(0)_";.03////"_$P(X("ODS"),"^",6)_";.1////"_$S($D(^DIC(4,+$P(X(0),"^",5),0)):$P(^(0),"^"),1:"")_";.11////"_$P(X("ODS"),"^",2)_";1.01////3"
 Q
 ;
 ;
4 ;get the DFN and multiple IFNs for registration option
 N DFN
 S DFN=$O(^DPT("AODSR",J,0)),IFN=$O(^(+DFN,0)) I IFN S DIE="^A1B2(11500.4," D REG
 K K Q
 ;
 ;
REG ;Update registrations
 S X=$S($D(^DPT(DFN,"DIS",IFN,0)):^(0),1:"")
 S DR=".01///"_+X_";.05////"_$P(X,"^",7)_";1.01////3" N I,J,K D ^DIE
 Q
 ;
 ;
QUEUE ; manually queue the ods background job
 S ZTRTN="A1B2BGJ",ZTDESC="ODS BACKGROUND JOB",ZTIO=""
 D ^%ZTLOAD
 Q
