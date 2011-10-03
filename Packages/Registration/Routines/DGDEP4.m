DGDEP4 ;ALB/CAW - Dependents Utilities (con't) ;12/1/94
 ;;5.3;Registration;**45,688**;Aug 13, 1993;Build 29
 ;
EN ; Spouse Demographics
 N BEG,CNT,END,FLAG,QUIT,DGERR S CNT=0
 I $G(DGMTI),$G(DGMTACT)="VEW" W !,"Cannot edit when viewing a means test." H 2 G ENQ
 I '$D(DGMTI),$G(DGRPV)=1 W !,"Not while viewing" H 2 G ENQ
 F  S CNT=$O(DGDEP(CNT)) Q:'CNT  D
 .I $P(DGDEP(CNT),U,2)="SPOUSE" S FLAG=$G(FLAG)+1
 I '$G(FLAG) W !,"There is no spouse to choose from." H 2 G ENQ
 I $G(FLAG)>1 D  G:'$G(DGERR) EN1
 .S BEG=2,END=FLAG+1 D SEL^DGDEPU Q:$G(DGERR)
 .S DGREL("S")=$P(DGDEP(DGW),U,20)_U_$P(^DGPR(408.12,+$P(DGDEP(DGW),U,20),0),U,3)
 I $G(DGERR) G ENQ
 I '$G(DGREL("S")) S DGREL("S")=$P(DGDEP(2),U,20)_U_$P(^DGPR(408.12,+$P(DGDEP(2),U,20),0),U,3)
EN1 S DGPRI=$P(DGDEP(1),U,20),DGIRI=$P(DGDEP(1),U,22) D SPOUSE1^DGMTSC1
ENQ D INIT^DGDEP
 Q
 ;
ADDEP ; Add a new dependent
 ;
 N DGANS
 S VALMBCK=""
 I $G(DGMTI),$G(DGMTACT)="VEW" W !,"Cannot edit when viewing a means test." H 2 G ADDEPQ
 I '$D(DGMTI),$G(DGRPV)=1 W !,"Not while viewing" H 2 G ADDEPQ
 S DIR(0)="S^S:Spouse;D:Dependent",DIR("A")="Do you want to add (S)pouse or (D)ependent"
 D ^DIR S DGANS=Y K DIR,Y I DGANS="D",$G(DGMTI) S DGANS="C"
 I $D(DIRUT) G ADDEPQ
 D GETREL^DGMTU11(DFN,"S",$S($G(DGMTD):DGMTD,1:DT))
 I DGANS="S",$G(DGREL("S")) W !,"An active spouse is currently on file.  Use the 'ES - Edit Spouse'",!,"action to edit." H 3 G ADDEPQ
 I DGANS="S",$G(DGMTI) S CNT=0 F  S CNT=$O(DGDEP(CNT)) Q:'CNT  I $P(DGDEP(CNT),U,2)="SPOUSE" D REMOVE^DGDEP2(DFN,DGDEP(CNT),DGMTI)
 D GETREL^DGMTU11(DFN,"C",$S($G(DGMTD):DGMTD,1:DT))
 I ((DGANS="C")!(DGANS="D")),(+$$CNTDEPS^DGMTU11(DFN)>18) DO
 . W !,"The addition of another dependent child can not be completed."
 . W !,"Nineteen (19) dependent children are already associated to the veteran."
 I ((DGANS="C")!(DGANS="D")),(+$$CNTDEPS^DGMTU11(DFN)>18) H 3 G:(DGANS="C") ADDEPQ
 D CLEAR^VALM1
 D ADD^DGRPEIS(DFN,DGANS,$S($G(DGMTI):$P(^DGMT(408.31,DGMTI,0),U),1:DT),DGDEP)
 S PERSON=DGPRI
 I DGFL=-1!(DGFL=-2) G ADDEPQ
 D INIT^DGDEP
 I $G(DGMTI) D
 .N CNT
 .S CNT=0
 .F  S CNT=$O(DGDEP(CNT)) Q:'CNT  I $P(DGDEP(CNT),U,20)=PERSON D
 ..D ADD^DGDEP2(DFN,DGDEP(CNT),DGMTI)
 ..D EDITD^DGDEP2(DFN,DGDEP(CNT),CNT,DGMTI)
ADDEPQ S VALMBCK="R"
 D INIT^DGDEP
 K DGFL Q
 ;
EDITDEP ; Edit dependent demo
 ;
 S VALMBCK=""
 N DGSAVE1,DGSAVE2,DGMTD,DGBEG,I
 I $G(DGMTI),$G(DGMTACT)="VEW" W !,"Cannot edit when viewing a means test." H 2 G EDITDEPQ
 I '$D(DGMTI),$G(DGRPV)=1 W !,"Not while viewing" H 2 G EDITDEPQ
 S I=0 F  S I=$O(DGDEP(I)) Q:'I!($G(DGBEG))  I $P(DGDEP(I),U,2)'="SELF",$P(DGDEP(I),U,2)'="SPOUSE" S DGBEG=I
 S VALMBCK="",DGSAVE1=VALMBG,DGSAVE2=VALMLST,VALMBG=$S($G(DGBEG):DGBEG,1:0)
 S VALMLST=DGCNT D SEL^VALM2 S VALMBG=DGSAVE1,VALMLST=DGSAVE2 G EDITDEPQ:'$O(VALMY(0))
 N CTR S CTR=0 F  S CTR=$O(VALMY(CTR)) Q:'CTR  D
 .D EDITC(DFN,DGDEP(CTR),CTR,$G(DGMTI))
EDITDEPQ S VALMBCK="R"
 K DGDEP D INIT^DGDEP
 Q
 ;
EDITC(DFN,DGDEP,DGW,DGMTI) ; Edit
 N DA,DR,DIE,DGMTDT,DEP,DGSAVE
 S DGMTDT=$S($G(DGMTI):$P(^DGMT(408.31,+DGMTI,0),U),1:DT)
 I $G(DGMTI),$G(DGMTACT)="VEW" W !,"Cannot edit when viewing a means test." H 2 G EDITCQ
 S DEP=$S($G(DGMTI):"C",1:"D"),DGSAVE=DGDEP
 D GETREL^DGMTU11(DFN,DEP,$$LYR^DGMTSCU1($S($G(DGMTDT):DGMTDT,1:DT)),$G(DGMTI))
 S DGDEP=DGSAVE
 N CNTR
 S CNTR=0
 F  S CNTR=$O(DGREL(DEP,CNTR)) Q:'CNTR  I $P(DGDEP,U,20)=+DGREL(DEP,CNTR) D
 .D EDIT^DGRPEIS(DGREL(DEP,CNTR),DEP)
EDITCQ ;
 K ^TMP("DGMTEP",$J)
 Q
