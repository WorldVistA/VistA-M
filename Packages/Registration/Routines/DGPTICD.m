DGPTICD ;ALB/MTC - PTF DRG Grouper Utility ; 2/19/02 3:08pm
 ;;5.3;Registration;**375,441,510,559,599,606,775,785**;Aug 13, 1993;Build 7
 ;variables to pass in:
 ;  DGDX <- format: DX CODE1^DX CODE2^DX CODE3^...                      (REQUIRED)
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
 Q:'$D(DGDX)!'$D(DGTRS)!'$D(DGEXP)!'$D(DGDMS)
 N DGI
 ;-- build ICDDX array
 K ICDDX
 S DGI=0 F  S DGI=DGI+1 Q:$P(DGDX,U,DGI)=""  D
 . S DGPTTMP=$$ICDDX^ICDCODE(+$P(DGDX,U,DGI),+$G(DGDAT))
 . I +DGPTTMP>0,($P(DGPTTMP,U,10)) S ICDDX(DGI)=$P(DGDX,U,DGI)
 G Q:'$D(ICDDX)
 ;
 ;-- build ICDPRC array
 K ICDPRC
 ;I $D(DGPROC) S DGSURG=$S('$D(DGSURG):DGPROC,1:DGSURG_DGPROC)
 ;I $D(DGSURG) S DGI=0 F  S DGI=DGI+1 Q:$P(DGSURG,U,DGI)=""  D
 ;. I $D(^ICD0($P(DGSURG,U,DGI),0)) S ICDPRC(DGI)=$P(DGSURG,U,DGI)
 ;-- build ICDPRC array eliminating dupes as we go
 K ICDPRC
 N I,J,X,Y,FLG,SUB S SUB=0
 I $D(DGPROC) F I=2:1 S X=$P(DGPROC,U,I) Q:X=""  D
 . S DGPTTMP=$$ICDOP^ICDCODE(X,+$G(DGDAT))
 . I +DGPTTMP>0,($P(DGPTTMP,U,10)) S SUB=SUB+1,ICDPRC(SUB)=X
 I $D(DGSURG) F I=2:1 S X=$P(DGSURG,U,I) Q:X=""  D
 .S J=0 F  S J=$O(ICDPRC(J)) Q:'J
 .;I X=$G(ICDPRC(J)) S FLG=1 Q
 .;I FLG Q
 . S DGPTTMP=$$ICDOP^ICDCODE(X,+$G(DGDAT))
 . I +DGPTTMP>0,($P(DGPTTMP,U,10)) S SUB=SUB+1,ICDPRC(SUB)=X
 . S ICDSURG(SUB)=$P(DGPTTMP,U,2)
 ;
 ;-- set other required variables
 S ICDTRS=DGTRS,ICDEXP=DGEXP,ICDDMS=DGDMS
 S ICDDATE=$S($D(DGDAT):DGDAT,1:DT),DGDAT=ICDDATE  ;Ensure that DGDAT is defined prior to executing PRT
 ;
 ;-- calculate DRG
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
Q K ICDDMS,ICDDRG,ICDDX,ICDEXP,ICDMDC,ICDPRC,ICDRTC,ICDTRS,ICDDATE Q
