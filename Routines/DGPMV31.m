DGPMV31 ;ALB/MIR - CONTINUE ADMIT PROCESS ; 12 SEP 89 @12
 ;;5.3;Registration;**43,114,418**;Aug 13, 1993
 I '$P(DGPMA,"^",6)!(DGPMN&DGPMOUT) D KILL G DQ
 S Y=DGPMDA_"^1" I 'DGPMOUT S:DGPMN DIE("NO^")="" D SPEC^DGPMV36 I '$D(^DGPM("APHY",DGPMDA)) D KILL G DQ
 I $D(DGPMSVC) S DGPMDER=0 ;FOR DISPO^DGPMV - from disposition
 I DGPMN,$D(^DGS(41.1,+DGPMSA,0)) S DA=DGPMSA,DR="17////"_DGPMDA,DIE="^DGS(41.1," D ^DIE
 I DGPMN D ^DGPMVBUL,CK^DGBLRV
 I 'DGPMN,($P(DGPMP,"^",6,7)'=$P(DGPMA,"^",6,7)),DGPMABL S DGPMND=DGPMA D AB^DGPMV32
 D SA
UP I $P(DGPMA,"^",21)&$S(+DGPMA'=+DGPMP:1,$P(DGPMA,"^",6,7)'=$P(DGPMP,"^",6,7):1,1:0) D ASIH
 G:'$P(DGPMA,"^",6) PTF S X=$O(^DGWAIT("C",DFN,0)),Y=$O(^(+X,0)) G PTF:('X!'Y)
 W !!,"This patient has the following waiting list entries on file:"
 F I=0:0 S I=$O(^DGWAIT("C",DFN,I)) Q:'I  D
 . F J=0:0 S J=$O(^DGWAIT("C",DFN,I,J)) Q:'J  D
 . . S X=$G(^DGWAIT(I,"P",J,0)) I X']"" Q
 . . W !?5,"TO: ",$S($D(^DG(40.8,+^DGWAIT(I,0),0)):$E($P(^(0),"^",1),1,20),1:"")
 . . W ?32,"APPLIED: ",$$FMTE^XLFDT($P(X,"^",2)),?63,"BEDSECTION: ",$P(X,"^",5)
 W !!,"Please delete from the waiting list if necessary.",!
PTF S PTF=$P(DGPMA,"^",16)
 N DGELA
 S DGELA=+$P($G(^DGPT(+PTF,101)),U,8)
 S DR="",DIE="^DGPT(" S:$S('$D(^DGPT(+PTF,0)):0,$P(^(0),"^",2)'=+DGPMA:1,1:0) DR=DR_"2////"_+DGPMA_";" S DR=DR_"20;20.1////^S X=$$ELIG^DGUTL3(DFN,2,DGELA)",DA=PTF I $D(^DGPT(+DA,0)) K DQ,DG D ^DIE G DQ
 ;
 G DQ:'DGPMN S Y=+DGPMA D CREATE^DGPTFCR
 S PTF=Y
 S DIE="^DGPM(",DA=DGPMDA,DR=".16////"_+Y K DQ,DG D ^DIE
 ;
 ;-- update admitting elig
 S DR="",DIE="^DGPT("
 S DR=DR_"20.1////^S X=$$ELIG^DGUTL3(DFN,2,DGELA)",DA=PTF
 D ^DIE
 ;
 D ADM^DGPMVODS
DQ I DGPMA'=DGPMP W !,"Patient Admi",$S($P(DGPMP,"^",4)']"":"tted",1:"ssion Updated"),!
 Q
DICS S DGER=0 I DGPMTYP=40 S DGER=1 Q  ;no TO ASIH!
 I $P(^DGPM(DA,0),"^",18)=40 S DGER=1 Q  ;don't let them change from TO ASIH!
 Q:DGPMTYP'=18
 S DGX1=9999999.9999999-+^DGPM(DA,0)
 F DGX=1:1:2 S DGX1=$O(^DGPM("ATID1",DFN,DGX1)) Q:'DGX1  S DGY=$O(^(DGX1,0)) I $D(^DGPM(+DGY,0)) G:($P(^(0),"^",18)=40) DICSQ S DGY=$P(^(0),"^",6) I $D(^DIC(42,+DGY,0)),("^NH^D^"[("^"_$P(^(0),"^",3)_"^"))!($P(^(0),"^",17)=1) G DICSQ ;p-418
 S DGER=1 Q
DICSQ S DGER=0 Q
ASIH ;update corresponding transfer and NHCU/DOM discharge episodes
 W !,"Updating corresponding NHCU/DOM movements"
 S DIE="^DGPM(",DA=$P(DGPMA,"^",21),DR=".01///"_+DGPMA_";.06////"_$P(DGPMA,"^",6)_";.07////"_$P(DGPMA,"^",7)
 I $D(^DGPM(+DA,0)) S ^UTILITY("DGPM",$J,2,DA,"P")=$S($D(^UTILITY("DGPM",$J,2,DA,"P")):^("P"),1:^DGPM(DA,0)) K DQ,DG D ^DIE S ^UTILITY("DGPM",$J,2,DA,"A")=^DGPM(DA,0)
 Q:+DGPMP=+DGPMA  S DGX=$S($D(^DGPM(+$P(DGPMA,"^",21),0)):^(0),1:0),DGX2=$S('$D(^DGPM(+$P(DGX,"^",14),0)):0,$D(^DGPM(+$P(^(0),"^",17),0)):+^(0),1:0),X1=+DGPMP,X2=30 Q:'X1!'DGX2  D C^%DTC Q:X'=+DGX2
 K DGX2 S X1=+DGPMA,X2=30 D C^%DTC S DA=$S($D(^DGPM(+$P(DGX,"^",14),0)):$P(^(0),"^",17),1:"")
 S DIE="^DGPM(",DR=".01///"_X I $D(^DGPM(+DA,0)) S ^UTILITY("DGPM",$J,3,DA,"P")=$S($D(^UTILITY("DGPM",$J,3,DA,"P")):^("P"),1:^DGPM(DA,0)) K DQ,DG D ^DIE S ^UTILITY("DGPM",$J,3,DA,"A")=^DGPM(DA,0)
 Q
KILL S DIK="^DGPM(",DA=DGPMDA W !,"Incomplete admission...Deleted" D ^DIK K DIK S DGPMA="" Q
 ;
SA Q:'$D(^DGS(41.1,"B",DFN))  S DGCT=0
 F DGI=0:0 S DGI=$O(^DGS(41.1,"B",DFN,DGI)) Q:'DGI  S J=$S($D(^DGS(41.1,DGI,0)):^(0),1:0),Y=$P(J,"^",2) I Y X ^DD("DD") I '$P(J,"^",13),'$P(J,"^",17) S DGCT=DGCT+1 D WR
 K DGCT,DGI,J,Y Q
 ;
WR I DGCT=1 W !,"This patient has the following scheduled admissions on file:"
 W !?5,Y,?25,$S($P(J,"^",10)="W":"WARD: "_$S($D(^DIC(42,+$P(J,"^",8),0)):$P(^(0),"^",1),1:""),$P(J,"^",10)="T":"FACILITY TREATING SPECIALTY: "_$S($D(^DIC(45.7,+$P(J,"^",9),0)):$P(^(0),"^",1),1:""),1:"")
 Q
