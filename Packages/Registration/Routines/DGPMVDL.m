DGPMVDL ;ALB/MIR - DELETE PATIENT MOVEMENTS ; 2/13/04 1:01pm
 ;;5.3;Registration;**161,517**;Aug 13, 1993
 ;
 ;D_DGPMT - these lines are used as DEL nodes.  If DGPMER=1, movement can
 ;          not be deleted.
 ;DGPMT   - once the movement is to be deleted, these are the other
 ;          updates that must also occur.
 ;
D1 S DGPMER=0 F I=0:0 S I=$O(^DGPM("APMV",DFN,DGPMCA,I)) Q:I'>0  S J=$O(^(I,0)) I $D(^DGPM(J,0)),($P(^(0),"^",15)]"") S DGPMER=1 Q
 I DGPMER W !,"Cannot delete before ASIH transfers are removed" Q
 I $P(DGPMAN,"^",21),$P(DGPMAN,"^",17) S DGPMER=1 W !,"Must delete discharge first"
 I $O(^DGPT("ACENSUS",+$P(DGPMAN,U,16),0)) S DGPMER=1 W !,"Cannot delete while PTF Census record #",$O(^(0))," is closed."
 Q
1 S DA=$P(DGPMAN,U,16),DIK="^DGPT(",FLAG=1,I=0 F  S I=$O(^DGCPT(46,"C",DA,I)) Q:'I  I '$G(^DGCPT(I,9)) S FLAG=0 Q
 I FLAG S I=0 F  S I=$O(^DGICD9(46.1,"C",DA,I)) Q:'I  I '$G(^DGICD9(I,9)) S FLAG=0 Q
 I 'FLAG W !,"CANNOT DELETE THE PTF RECORD WHEN THERE ARE ACTIVE ORDERS OR CPT ENTRIES." K FLAG H 2 Q
 S DGMSG="Patient admission has been deleted for admit date: "_$$FMTE^XLFDT(+DGPMAN,"5DZ"),DGMSG1="Deleted Admission"
 D MSG^DGPTMSG1 S DA=$P(DGPMAN,U,16),DIK="^DGPT(" D ^DIK:DA>0 K FLAG,I,DA,DIK ; delete PTF record
 S DA=$O(^DGS(41.1,"AMVT",DGPMDA,0)) I DA S DIE="^DGS(41.1,",DR="17///@" D ^DIE ;remove scheduled admission reference in 41.1
 F DGI=DGPMDA:0 S DGI=$O(^DGPM("CA",DGPMDA,DGI)) Q:'DGI  I $D(^DGPM(DGI,0)) S DGPMTYP=$P(^(0),"^",2),DA=DGI,DIK="^DGPM(",^UTILITY("DGPM",$J,DGPMTYP,DA,"P")=^(0),^("A")="" D ^DIK
 S DGX=$P(DGPMAN,"^",21) G Q1:'DGX S DIK="^DGPM(",DA=DGX I $D(^DGPM(+DA,0)) S DGX1=^(0),^UTILITY("DGPM",$J,2,DA,"P")=^(0),^("A")="" D ^DIK W !,"ASIH transfer deleted",!
 G Q1:($P(DGX1,"^",18)'=13) S DGPMADM=$P(DGX1,"^",14) D DD^DGPMVDL1
Q1 K ORQUIT Q
Q Q
D2 ;Can this transfer be deleted?
 I $P(DGPMP,"^",18)=43,($P(DGPM2,"^",18)=42) S DGPMER=0 Q
 I DGPM2,'$D(^DG(405.1,+$P(DGPM2,"^",4),"F",+$P(DGPM0,"^",4),0)) S DGPMER=1 W !,"Cannot delete transfer - would create an invalid transfer pair" Q
 I "^13^44^"[("^"_$P(DGPMP,"^",18)_"^") S DGPMER=1 W !,"Must delete through corresponding hospital admission" Q
 I $P(DGPMP,"^",18)=14,$P(DGPMAN,"^",17) S DGPMER=1 W !,"Cannot delete while discharge exists" Q
 I $D(^DGPM(+$P(DGPMP,"^",15),0)),$D(^DGP(45.84,+$P(^(0),"^",16))) S DGPMER=1 W !,"Cannot delete when corresponding admission PTF closed out" Q
 I "^14^43^45^"[("^"_$P(DGPMP,"^",18)_"^"),("^13^14^43^44^45^"[("^"_$P(DGPM2,"^",18)_"^")) S DGX=$S($D(^DG(405.1,+$P(DGPM2,"^",4),0)):$P(^(0),"^",1),1:"") W !,DGX," movement must be removed first" S DGPMER=1 Q
 Q
2 I DGPMABL,DGPM0 S DGPMND=DGPM0 D AB^DGPMV32
 S DGPMTYP=$P(DGPMP,"^",18) I DGPMTYP=43 S DGPMADM=DGPMCA D DD^DGPMVDL1 Q
 I DGPMTYP=45 Q:'$P(DGPMP,"^",22)  S DGX=$O(^DGPM("APTT3",DFN,DGPMP+.0000001,0)) I $D(^DGPM(+DGX,0)) S DGPMADM=$P(^(0),"^",14) D DD^DGPMVDL1 Q
 Q:DGPMTYP'=14  S DGX=0 F I=(9999999.9999999-DGPMP):0 S I=$O(^DGPM("ATID2",DFN,I)) Q:'I  S DGJ=$O(^(I,0)) I $D(^DGPM(+DGJ,0)),("^13^43^44^"[("^"_$P(^(0),"^",18)_"^")) S DGX=1 Q
 Q:'DGX  I "^13^44^"[("^"_$P(^DGPM(DGJ,0),"^",18)_"^") S DGPMADM=$P(^(0),"^",15) I $P(DGPMP,"^",22) D DD^DGPMVDL1
 Q:$P(^DGPM(DGJ,0),"^",18)=44  S DGPMAB=+^DGPM(DGJ,0) D ASIHOF^DGPMV321 ;recreate 30 days
 Q
