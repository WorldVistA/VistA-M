DGPMV36 ;ALB/MIR - TREATING SPECIALTY TRANSFER, CONTINUED ; SEP 15 1989@12
 ;;5.3;Registration;;Aug 13, 1993
 ;
 I '$P(DGPMA,"^",9) S DGPMA="",DIK="^DGPM(",DA=DGPMDA D ^DIK K DIK W !,"Incomplete Treating Specialty Transfer...Deleted"
 Q
 ;
DICS ; -- check that it is a PROVIDER/SPECIALTY change
 S DGER=DGPMTYP'=20
 Q
 ;
ONLY ; -- determine if there is only one 'specialty xfr' type mvt
 N C,I S C=0
 F I=0:0 S I=$O(^DG(405.1,"AT",6,I)) Q:'I  I $D(^DG(405.1,I,0)),$P(^(0),"^",4) S C=C+1,DGPMSPI=I I C>1 K DGPMSPI Q
 Q
 ;
SPEC ; -- entry point to add/edit specialty mvt when adding/editing
 ;    a physical mvt
 ;
 ;       Input:     Y = ifn of mvt file ^ auto add specialty entry(1)
 ;      Output:     Y = ifn of spec mvt
 ;      
 ;    Variable: DGPMPHY = physical mvt IFN ; DGPMPHY0 = 0th node
 ;              DGPMSP  = specialty mvt IFN
 ;
 Q:'$D(^DGPM(+Y,0))
 N DGPMT,DGPMN S DGPMPHY=+Y,DGPMPHY0=^DGPM(+Y,0),DGPMT=6,DGPMN=0
 S DGPMSP=$S($D(^DGPM("APHY",DGPMPHY)):$O(^(DGPMPHY,0)),1:"")
 I 'DGPMSP S Y=+$P(Y,"^",2) D ASK:'Y G SPECQ:'Y D NEW
 D EDIT:DGPMSP
SPECQ S Y=DGPMSP K DGPMPHY,DGPMPHY0,DGPMSP Q
 ;
ASK ; -- ask user if they want to make a special mvt also
 W ! S DIR(0)="YA",DIR("A")="Do you wish to associate a 'facility treating specialty' transfer? "
 S DIR("?",1)="If you would like to associate a facility specialty"
 S DIR("?",2)="transfer with this physical movement than answer 'Yes'."
 S DIR("?")="Otherwise, answer with a 'No'."
 D ^DIR K DIR
 Q
 ;
NEW ; -- add a specialty mvt
 S X=DGPMPHY0,Y=+X_U_DGPMT_U_$P(X,U,3),$P(Y,U,14)=$P(X,U,14),$P(Y,U,24)=DGPMPHY
 S X=+X,DGPM0ND=Y D NEW^DGPMV3
 S DGPMSP=$S(+Y>0:+Y,1:"") S DGPMN=(+Y>0)
 I DGPMSP,$P(DGPMPHY0,"^",2)=1,$P(DGPMPHY0,"^",10)]"" S DR="99///"_$P(DGPMPHY0,"^",10),DA=DGPMSP,DIE="^DGPM(" D ^DIE
 K DIE,DIC,DA,DR,DGPM0ND
 Q
EDIT ; -- edit specialty mvt
 N DGPMX,DGPMP
 I DGPMN S (DGPMP,^UTILITY("DGPM",$J,6,DGPMSP,"P"))="",DIE("NO^")=""
 I 'DGPMN S (DGPMP,^UTILITY("DGPM",$J,6,DGPMSP,"P"))=^DGPM(DGPMSP,0)
 S Y=DGPMSP D PRIOR
 S DGPMN=(+DGPMP=+DGPMPHY0) ;set to 1 no dt/time change to bypass x-refs
 S DGPMX=+DGPMPHY0,DA=DGPMSP,DIE="^DGPM(",DR="[DGPM SPECIALTY TRANSFER]"
 K DQ,DG D ^DIE
 S ^UTILITY("DGPM",$J,6,DGPMSP,"A")=$S($D(^DGPM(DGPMSP,0)):^(0),1:"")
 S Y=DGPMSP D AFTER
 Q
 ;
PRIOR ; -- set special 'prior' nodes for event driver
 I DGPMN S (^UTILITY("DGPM",$J,6,Y,"DXP"),^("PTFP"))=""
 I 'DGPMN S X=$P($S($D(^DGPM(Y,"DX",0)):^(0),1:""),"^",3,4),X=X_$S($D(^(1,0)):$E(^(0),1,245-$L(X)),1:""),^UTILITY("DGPM",$J,6,Y,"DXP")=X,^UTILITY("DGPM",$J,6,Y,"PTFP")=$S($D(^DGPM(Y,"PTF")):^("PTF"),1:"")
 Q
 ;
AFTER ; -- set special 'after' nodes for event driver
 S X=$P($S($D(^DGPM(Y,"DX",0)):^(0),1:""),"^",3,4),X=X_$S($D(^(1,0)):$E(^(0),1,245-$L(X)),1:""),^UTILITY("DGPM",$J,6,Y,"DXA")=X,^UTILITY("DGPM",$J,6,Y,"PTFA")=$S($D(^DGPM(Y,"PTF")):^("PTF"),1:"")
 Q
