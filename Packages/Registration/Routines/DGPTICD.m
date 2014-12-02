DGPTICD ;ALB/MTC - PTF DRG Grouper Utility ;2/19/02 3:08pm
 ;;5.3;Registration;**375,441,510,559,599,606,775,785,850**;Aug 13, 1993;Build 171
 ;variables to pass in:
 ;  DGDX <- format: DX CODE1^DX CODE2^DX CODE3^...                      (REQUIRED)
 ;  DGDXPOA <- format: poa1^poa2^poa3....                               (REQUIRED for ICD-10 diag)
 ;  DGSURG <- format: SURGERY CODE1^SURGERY CODE2^SURGERY CODE3^...       (OPTIONAL)
 ;  DGPROC <- format: PROCEDURE CODE1^PROCEDURE CODE2^PROCEDURE CODE3^... (OPTIONAL)
 ;  DGTRS  <- 1 if patient transferred to acute care facility             (REQUIRED)
 ;  DGEXP  <- 1 if patient died during this episode                       (REQUIRED)
 ;  DGDMS  <- 1 if patient was discharged with an Irregular discharge (discharged against medical advice) (REQUIRED)
 ;  AGE,SEX     (REQUIRED)
 ;values of variables listed above are left unchanged by this routine
 ;variable passed back: DRG(0) <- zero node of DRG in DRG file
 ;                    : DRG <- IFN of DRG in DRG file
 ;  DGDAT  <- Effective date to be used in calculating DRG
 ;
 ;-- check for required variables
 ;
 Q:'$D(DGDX)!'$D(DGTRS)!'$D(DGEXP)!'$D(DGDMS)
 N DGI
 ;-- build ICDDX array
 K ICDDX,ICDPOA
 ;
 I $G(EFFDATE)="" D EFFDATE^DGPTIC10($G(PTF))
 S ICDEDT=EFFDATE
 S DGI=0 F  S DGI=DGI+1 Q:$P(DGDX,U,DGI)=""  D
 . S DGPTTMP=$$ICDDATA^ICDXCODE("DIAG",+$P(DGDX,U,DGI),EFFDATE)
 . I +DGPTTMP>0,($P(DGPTTMP,U,10)) S ICDDX(DGI)=$P(DGDX,U,DGI) D
 .. I EFFDATE'<$$IMPDATE^LEXU("10D") S ICDPOA(DGI)=$S($G(DGDXPOA)'="":$P($G(DGDXPOA),U,DGI),1:"Y")
 I '$D(ICDDX) W ! G Q
 ;
 ;-- build ICDPRC array
 K ICDPRC
 ;-- build ICDPRC array eliminating dupes as we go
 K ICDPRC
 N I,J,X,Y,FLG,SUB S SUB=0
 I $D(DGPROC) F I=2:1 S X=$P(DGPROC,U,I) Q:X=""  D
 . S DGPTTMP=$$ICDDATA^ICDXCODE("PROC",X,+$G(EFFDATE))
 . I +DGPTTMP>0,($P(DGPTTMP,U,10)) S SUB=SUB+1,ICDPRC(SUB)=X
 I $D(DGSURG) F I=2:1 S X=$P(DGSURG,U,I) Q:X=""  D
 . S J=0 F  S J=$O(ICDPRC(J)) Q:'J
 . S DGPTTMP=$$ICDDATA^ICDXCODE("PROC",X,+$G(EFFDATE))
 . I +DGPTTMP>0,($P(DGPTTMP,U,10)) S SUB=SUB+1,ICDPRC(SUB)=X
 . S ICDSURG(SUB)=$P(DGPTTMP,U,2)
 ;
 ;-- set other required variables
 S ICDTRS=DGTRS,ICDEXP=DGEXP,ICDDMS=DGDMS
 ;DRP S ICDDATE=$S($D(DGDAT):DGDAT,1:DT),DGDAT=ICDDATE  ;Ensure that DGDAT is defined prior to executing PRT
 S ICDDATE=$S(+$G(DGDAT):DGDAT,1:DT),DGDAT=ICDDATE  ;Ensure that DGDAT is defined prior to executing PRT
 ;
 ;-- calculate DRG
 ;reset ICD partition variables to prevent date/coding system conflicts
 K ICDCSYS,ICD0,ICDCDSY,ICDEDT
 D ^ICDDRG S DRG=ICDDRG I '$D(DGDRGPRT) G Q
 ;
PRT ;print DRG and national HCFA values
 I (ICDDATE<3071001)&(DRG=468!(DRG=469)!(DRG=470)) W *7
 I DRG=998!(DRG=999) W *7
 S Y=ICDDATE D DD^%DT ; Y=external representation of effective date
 W !!?9,"Effective Date:","  ",Y
 S DRG(0)=$$DRG^ICDGTDRG(DRG,DGDAT) W !!,"Diagnosis Related Group: ",$J(DRG,6),?36,"Average Length of Stay(ALOS): ",$J($P(DRG(0),"^",8),6)
 W !?17,"Weight: ",$J($P(DRG(0),"^",2),6)  ;,?40,"Local Breakeven: ",$J($P(DRG(0),"^",12),6)
 W !?12," Low Day(s): ",$J($P(DRG(0),"^",3),6)  ;,?39,"Local Low Day(s): ",$J($P(DRG(0),"^",9),6)
 W !?13," High Days: ",$J($P(DRG(0),"^",4),6)  ;,?40,"Local High Days: ",$J($P(DRG(0),"^",10),6)
 N DXD,DGDX
 S DXD=$$DRGD^ICDGTDRG(DRG,"DGDX",,DGDAT),DGI=0
 W !!,"DRG: ",DRG,"-" F  S DGI=$O(DGDX(DGI)) Q:'+DGI  Q:DGDX(DGI)=" "  W ?10,DGDX(DGI),!
 K ICDDATE
Q K ICDDMS,ICDDRG,ICDDX,ICDEXP,ICDMDC,ICDPRC,ICDRTC,ICDTRS Q
 ;
80 ;
 N DIC S DIC=80,DIC(0)="AEQLIM" D ^DIC
 S OUT=Y
 Q
