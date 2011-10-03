DGPTFUP ;ALB/ABS,BOK - Updates Means Test, LOS, TRANSFER DRGs in PTF records ; 3/28/02 11:54am
 ;;5.3;Registration;**441,478**;Aug 13, 1993
ACTIVE ;this call should be queued to run nightly to update the LOS in active admission PTF records and the Means Test Indicator in Open PTF records
 D NOW^%DTC S DT=X,U="^",(DGBGJ,DGLN)=1
 F PTF=0:0 S PTF=$O(^DGPT("AS",0,PTF)) Q:PTF'>0  I $D(^DGPT(PTF,0)),$P(^(0),U,11)=1 S DFN=+^(0),DGADM=$P(^(0),U,2),DGPMCA=$O(^DGPM("APTT1",DFN,DGADM,0)),DGPMAN=$S($D(^DGPM(+DGPMCA,0)):^(0),1:"") I DGPMAN D:DGADM>2860700 MT^DGPTUTL D LOS
 K DGADM,DGADIFN,PTF,DFN,DGLEAVE,DGMV,DGMVDT,DGPASS,DGTOT,DGTYPE,X,X1,X2,DGCUM,DGMT,DGBGJ,DGLN,DGPMAN,DGPMCA Q
LOS Q:'$D(^DGPT("AADA",DGADM,PTF))!('$D(^DGPT(PTF,"M",1,0)))  I '$D(^DGPT(PTF,"M",1,"P")) S ^DGPT(PTF,"M",1,"P")=""
 S DGMVDT=1,DGCUM=0 F X=1:0 S X=$O(^DGPT(PTF,"M",X)) Q:X'>0  I $D(^(X,"P")),$P(^("P"),"^",3)>DGMVDT S DGMVDT=$P(^("P"),"^",3),DGCUM=$P(^("P"),"^",6)
 I DGMVDT'>1 S DGMVDT=DGADM
 S (DGLEAVE,DGPASS)=0,X1=DT,X2=DGMVDT D ^%DTC S DGTOT=$S(X>0:X,1:1)
 F DGMV=(DGMVDT-.1):0 S DGMV=$O(^DGPM("APTT2",DFN,DGMV)) Q:DGMV'>0  S X=$O(^DGPM("APTT2",DFN,DGMV,0)) I $S('$D(^DGPM(+X,0)):0,$P(^(0),"^",14)=DGPMCA:1,1:0) S DGTYPE=+$P(^(0),"^",18) I DGTYPE=1!(DGTYPE=2)!(DGTYPE=3) D ABSENT
 S DGTOT=DGTOT-DGPASS-DGLEAVE
 N DGFDA,DGMSG
 S DGFDA(45.02,1_","_PTF_",",23)=DGTOT
 S DGFDA(45.02,1_","_PTF_",",25)=DGTOT+DGCUM
 D FILE^DIE("","DGFDA","DGMSG")
 Q
ABSENT S X2=DGMV,X=$O(^DGPM("APTT2",DFN,DGMV)),X1=$S(X>0:X,1:DT) D ^%DTC I DGTYPE=1 S DGPASS=DGPASS+X Q
 S DGLEAVE=DGLEAVE+X Q
 ;
 ;ADDING TRANSFER DRGs
ALL D DT^DICRW S U="^" W !?5,"===> PTF TRANSFER DRG update beginning..."
 F PTF=0:0 S PTF=$O(^DGPT(PTF)) Q:PTF'>0  D UPDATE
 G Q
 ;
SOME ;
 W !!?2,"This option will recalculate the TRANSFER DRG's for all",!?2,"current fiscal year PTF records."
 W !!?2,"Do you want to continue" S %=2 D YN^DICN Q:%=-1!(%=2)
 I '% W !?2,"Answer 'YES' to begin recalculation or 'NO' to stop." G SOME
 W !?5,"===> PTF partial TRANSFER DRG update beginning with "
 W !?5,"     discharge dates for the current fiscal year..."
 ;
 D DT^DICRW S U="^",DGFYDT=$S($E(DT,4,5)<10:($E(DT,1,3)-1),1:$E(DT,1,3))_1000
 N DGD1SAV
 F DGXREF="ADS","AADA" S DGD1SAV=0  F DGD1=$S(DGXREF="ADS":DGFYDT,1:0):0 S DGD1=$O(^DGPT(DGXREF,DGD1)) Q:'DGD1  Q:DGD1<DGD1SAV  F PTF=0:0 S PTF=$O(^DGPT(DGXREF,DGD1,PTF)) Q:'PTF  D UPDATE
Q W !!?5,"===> PTF TRANSFER DRG update complete"
 K PTF,DGD1,DGFYDT,DGXREF Q
 ;
UPDATE ; -- update xfr drg's for PTF ifn
 S DGD1SAV=DGD1
 G UPDATEQ:'$D(^DGPT(PTF,0)) S DGNODE=^(0)
 G UPDATEQ:$S($P(DGNODE,"^",11)>1:1,1:$P(DGNODE,"^",4))
 D PM^DGPTUTL G UPDATEQ:'DGPMCA
 K DGTDD,DGPRD,DGNXD F I=0:0 S I=$O(^DGPT(PTF,"M",I)) Q:I'>0  D
 .N FLD,DGFDA,DGMSG
 .F FLD=20:1:25 S DGFDA(45.02,I_","_PTF_",",FLD)="@"
 .D FILE^DIE("","DGFDA","DGMSG")
 S DFN=+DGNODE,DGADM=+$P(DGNODE,U,2)
 D SUDO1^DGPTSUDO
 W:'(PTF#300) !,"   TRANSFER DRG update in progress...on IFN ",PTF
UPDATEQ K DGPMCA,DGPMAN,DGNODE,DGADM,DFN Q
 ;
ZERO ;LOOK FOR MISSING 0 NODE IN 501 MULTIPLE
 D LO^DGUTL F I=0:0 S I=$O(^DGPT(I)) Q:I'>0  S:'$D(^DGPT(I,0)) ^DGPT(I,0)="" I $D(^DGPT(I,"M")),'$D(^("M",0)) S ^(0)="^45.02AI"
 K I Q
