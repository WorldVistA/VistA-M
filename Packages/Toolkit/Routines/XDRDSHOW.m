XDRDSHOW ;SF-IRMFO.SEA/JLI - DISPLAY DATA IN FIELDS, GET OVERWRITES ;01/30/2008
 ;;7.3;TOOLKIT;**23,49,78,112**;Apr 25, 1995;Build 1
 ;;
SHOW(FILE,REC1,REC2,FLDS,REVIEW) ;
 N FILDIC,MULT,DDVAL,NAMIEN1,NAMIEN2,NAMREC1,NAMREC2,FIRSTIME,MPIMB
 S FILDIC=$G(^DIC(FILE,0,"GL")) Q:FILDIC=""
 S REVIEW=+$G(REVIEW)
 S FILREC1=FILDIC_"REC1)"
 S FILREC2=FILDIC_"REC2)"
 S NAMREC1=$P($G(@FILREC1@(0)),U) I NAMREC1="" Q
 S NAMREC2=$P($G(@FILREC2@(0)),U) I NAMREC2="" Q
 I FILE=63 D
 . S NAMIEN1=+$P(@FILREC1@(0),U,3),NAMIEN2=+$P(@FILREC2@(0),U,3)
 . S NAMREC1=$P(^DPT(NAMIEN1,0),U),NAMREC2=$P(^DPT(NAMIEN2,0),U)
 I $P(^DD(FILE,.01,0),U,2)["P" D
 . N XFIL
 . S XFIL=+$P($P($G(^DD(FILE,.01,0)),U,2),"P",2) Q:XFIL'>0
 . S XFIL=$G(^DIC(XFIL,0,"GL")) Q:XFIL=""
 . S NAMREC1=$P(@(XFIL_NAMREC1_",0)"),U)
 . S NAMREC2=$P(@(XFIL_NAMREC2_",0)"),U)
 ;
 ;   recalc CMOR scores
 I FILE=2,$D(^DD(FILE,991.06)) D
 . N RGDFN S RGDFN=REC1 D CALC^RGVCCMR2
 . N RGDFN S RGDFN=REC2 D CALC^RGVCCMR2
 . Q
 ; 
 ;   check for multiple birth indicator in MPI
 S FIRSTIME=1
 I FILE=2 D
 . I $G(^DPT(REC1,"MPIMB"))="Y"!($G(^DPT(REC2,"MPIMB"))="Y") S MPIMB=1
 . E  S MPIMB=0
 ;
 D HEADER
LOOP ;
 S FLD=0
 F FLD=0:0 S FLD=$O(^DD(FILE,FLD)) Q:FLD'>0  D  I NLIN<6 D PAGE Q:$D(DIRUT)  D HEADER
 . I FILE=63,$P($G(^DD(FILE,FLD,0)),U)="NAME" Q  ;scrn patient file data. From Lab
 . I FILE'=2,$P($G(^DD(FILE,FLD,0)),U,2)["P2" Q  ;From DINUM pointers.
 . S DDVAL=$G(^DD(FILE,FLD,0))
 . S NODE=$P($P(DDVAL,U,4),";")
 . S PIECE=$P($P(DDVAL,U,4),";",2)
 . I PIECE=0 S MULT(FLD)=""
 . I PIECE>0 D
 . . S X1=$P($G(@FILREC1@(NODE)),U,PIECE),X1=$$TYPE(X1,$P(DDVAL,U,2),DDVAL,REC1)
 . . S X2=$P($G(@FILREC2@(NODE)),U,PIECE),X2=$$TYPE(X2,$P(DDVAL,U,2),DDVAL,REC2)
 . . I X1'=""!(X2'="") D
 . . . S X0="    "
 . . . S XN=$P(DDVAL,U)
 . . . S XDRA=0
 . . . I X1'=""&(X2'=""),X1'=X2 D
 . . . . I FILE=2,((FLD=991.01)!(FLD=991.02)) Q  ;jds restrict ICN overwrites for MPI 
 . . . . S X0=$S($D(FLDS(FLD)):"||||",1:"****"),NDIFFS=NDIFFS+1,DIFFS(NDIFFS)=FLD,XDRA=1 I REVIEW S NLIN=NLIN-1
 . . . I 'REVIEW!XDRA D
 . . . . W ! S NLIN=NLIN-1
 . . . . F  Q:XN=""&(X1="")&(X2="")  D
 . . . . . W !,X0,"  ",$E(XN,1,20),?30,$E(X1,1,20),?55,$E(X2,1,20)
 . . . . . S NLIN=NLIN-1
 . . . . . S X0="    ",XN=$E(XN,21,$L(XN))
 . . . . . S X1=$E(X1,21,$L(X1))
 . . . . . S X2=$E(X2,21,$L(X2))
MULT I '$D(DIRUT) D
 . I $G(NDIFFS)>0 D PAGE Q:$D(DIRUT)  D HEADER
 . I $D(MULT) D
 . . F FLD=0:0 S FLD=$O(MULT(FLD)) Q:FLD'>0  D  I NLIN<6 D PAGE Q:$D(DIRUT)  D HEADER
 . . . S DDVAL=^DD(FILE,FLD,0)
 . . . S NAME=$P(DDVAL,U)
 . . . S NODE=$P($P(DDVAL,U,4),";")
 . . . S NOD1=$NA(@FILREC1@(NODE))
 . . . S NOD2=$NA(@FILREC2@(NODE))
 . . . S N1=0,N2=0
 . . . F I=0:0 S I=$O(@NOD1@(I)) Q:I'>0  S N1=N1+1
 . . . F I=0:0 S I=$O(@NOD2@(I)) Q:I'>0  S N2=N2+1
 . . . I N1'=0!(N2'=0) D
 . . . . S N1=$S(N1>1:N1_" entries",N1>0:N1_" entry",1:"---")
 . . . . S N2=$S(N2>1:N2_" entries",N2>0:N2_" entry",1:"---")
 . . . . W !!,$E(NAME,1,25),?30,N1,?55,N2
 . . . . S NLIN=NLIN-2
 Q
PAGE ;
 I IOST'["C-"!$D(ZTQUEUED) Q
 W !
 I '$D(DIFFS)!'REVIEW S DIR(0)="E" D ^DIR K DIR
 I $D(DIFFS)&REVIEW D
 . S DIR(0)="LO^1:"_NDIFFS,DIR("A")="OVERWRITE data for selected fields"
 . F I=1:1:NDIFFS W !,I,"  ",$P(^DD(FILE,DIFFS(I),0),U)
 . W ! D ^DIR K DIR
 . I X="",$D(DIRUT) K DIRUT
 . S I="" F  S I=$O(Y(I)) Q:I=""  S Y=Y(I) K Y(I) D
 . . F  Q:Y=","  Q:Y=""  S X=$D(FLDS(DIFFS(+Y))) K:X=1 FLDS(DIFFS(+Y)) S:X=0 FLDS(DIFFS(+Y))="" S Y=$P(Y,",",2,999)
 Q
 ;
HEADER ;
 N REC1MB,REC2MB
 I '$G(FIRSTIME),$D(IOF) W @IOF
 I $G(FIRSTIME),$G(MPIMB) D WARNING
 S FIRSTIME=0
 K DIFFS S NDIFFS=0
 S NLIN=IOSL-4
 I $D(MPIMB) S NLIN=NLIN-4,MPIMB=0
 I '$D(PACKAGE) S PACKAGE="PRIMARY"
 ;REM - modified next two lines to include IENs in review display
 W !,?30,$S(PACKAGE="PRIMARY":"RECORD1 [#"_REC1_"]",PACKAGE="LABORATORY":"MERGE FROM [#"_NAMIEN1_"]",1:"MERGE FROM [#"_REC1_"]")
 W ?55,$S(PACKAGE="PRIMARY":"RECORD2 [#"_REC2_"]",PACKAGE="LABORATORY":"MERGE TO [#"_NAMIEN2_"]",1:"MERGE TO [#"_REC2_"]")
 ;I FILE=63 W !?38,"[#"_NAMIEN1_"]",?55,"[#"_NAMIEN2_"]"
 W !,?30,$E(NAMREC1,1,20),?55,$E(NAMREC2,1,20)
 S NLIN=NLIN-2
 I $E(NAMREC1,21,40)'=""!($E(NAMREC2,21,40)'="") D
 . W !,?30,$E(NAMREC1,21,40),?55,$E(NAMREC2,21,40)
 . S NLIN=NLIN-1
 ;
 ;   add CMOR scores to header
 I $D(^DD(FILE,991.06)) D
 . W !,?30,"CMOR SCORE = "_$S($P($G(^DPT(REC1,"MPI")),U,6):$P(^DPT(REC1,"MPI"),U,6),1:"NULL"),?55,"CMOR SCORE = "_$S($P($G(^DPT(REC2,"MPI")),U,6):$P(^DPT(REC2,"MPI"),U,6),1:"NULL")
 . S NLIN=NLIN-1
 ;
 ;   add MULTIBLE BIRTH indicator to header
 S (REC1MB,REC2MB)=0
 I $G(^DPT(REC1,"MPIMB"))="Y" S REC1MB=1
 I $G(^DPT(REC2,"MPIMB"))="Y" S REC2MB=1
 I REC1MB!REC2MB D
 . W !,?30,$S(REC1MB:"**MULTIPLE BIRTH**",1:""),?55,$S(REC2MB:"**MULTIPLE BIRTH**",1:"")
 . S NLIN=NLIN-1
 ;
 W !,"----------------------------------------------------------------------------"
 S NLIN=NLIN-1
 Q
 ;
POINT(VAL,FILE) ;
 N X,Y
 I +VAL'=VAL Q "BAD POINTER VALUE IN FILE"
 S Y=$G(^DIC(FILE,0,"GL")) Q:Y="" ""
 S Y=Y_VAL_",0)"
 S Y=$P($G(@Y),U) I Y'=""&($P(^DD(FILE,.01,0),U,2)["P") S Y=$$POINT(Y,+$P($P(^DD(FILE,.01,0),U,2),"P",2))
 S:Y="" Y="** Missing Entry in File "_FILE_"." ;REM - 9/6/96 When a pointer node is missing. 
 Q Y
TYPE(VAL,TYPE,DDNODE0,REC) ;
 I TYPE["O",$D(^DD(FILE,FLD,2)) S Y=VAL,D0=REC X ^DD(FILE,FLD,2) S VAL=Y Q VAL
 I TYPE["F",VAL'="" S VAL=""""_VAL_"""" Q VAL
 I TYPE["P",VAL>0 S VAL=$$POINT(VAL,+$P(TYPE,"P",2)) Q VAL
 I TYPE["D",VAL>0 D  Q VAL
 . S VAL=$TR($$FMTE^XLFDT(VAL,2),"@"," ")
 I TYPE["S" D  Q VAL
 . N X S X=";"_$P(DDNODE0,U,3)
 . S X=$P($P(X,(";"_VAL_":"),2),";")
 . I X'="" S VAL=X
 Q VAL
 ;
WARNING ;
 W !,?2,"*** WARNING!!!  One or both of these records indicated MULTIPLE BIRTH. ***",!,?2,"Use caution to ensure that these records are truly duplicates and not",!,?2,"siblings before proceeding.",!
 Q
