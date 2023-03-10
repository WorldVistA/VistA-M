VPRHSX1 ;SLC/MKB -- HS Mgt Options cont ;09/18/18 4:36pm
 ;;1.0;VIRTUAL PATIENT RECORD;**25,27**;Sep 01, 2011;Build 10
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ; External References          DBIA#
 ; -------------------          -----
 ; ^DDE                          7014
 ; ^DPT                         10035
 ; ^GMR(120.86                   3449
 ; DIQ                           2056
 ; DIR                          10026
 ; MPIF001                       2701
 ; ORQ12                         5704
 ; VADPT                         3744
 ; XLFDT                        10103
 ; XUPROD                        4440
 ;
GET ; -- Add patient/container/record to GET list [VPR HS PUSH]
 N DFN,ICN,X
 I '$P($G(^VPR(1,0)),U,2) W !,"WARNING: Data Monitoring is currently disabled!",!
 ;
 W ! S DFN=+$$PATIENT^VPRHST Q:DFN<1
 I '$$SUBS^VPRHS(DFN) D  Q
 . W !,$C(7),"WARNING: This patient is not currently in the Edge Cache Repository (ECR)!",!
 . S ICN=$$ICN(DFN) I ICN<0 W !,$P(ICN,U,2),!,"Cannot add to ECR",! Q
 . I $G(^VPR(1,2,DFN,"ANEW")) W !,"This patient already has a request for subscription.",! Q
 . Q:'$$CONT  D NEW^VPRHS(DFN,ICN)
 . S X=$G(^VPR(1,2,DFN,"ANEW"))
 . W !," ... request "_$S(X:"",1:"NOT ")_"added to update queue."
 ;
 I $$MERGED^VPRHS(DFN) D  Q
 . S X=$G(^DPT(DFN,-9))
 . W !,"Patient is being merged"_$S(X:" into DFN "_X,1:""),!
 S ICN=$$GETICN^MPIF001(DFN) I ICN<0 W !,"ICN is required!",! Q
 N TYPE,ENT,FN,ACT,VST,DLIST,VPRX,VPRI,VPRN,ID
G1 ;loop for prompting
 S TYPE=$$CONTNR^VPRHST,ID="" Q:"^"[TYPE
 I $G(^VPR(1,2,DFN,"AVPR",TYPE,"*")) W !,"This patient already has a container update request in the queue!",! G G1
 I TYPE="Patient"!(TYPE="AdvanceDirective")!(TYPE="MemberEnrollment") D  G G1
 . W !,"Entire container must be updated."
 . S:TYPE="Patient" ID=DFN_";2"
 . D P1^VPRHS,OUT W !
 I $$ALL D P1^VPRHS,OUT W ! G G1
 ;
 ; select source file, record(s)
 S ENT=$$ENTITY(TYPE) G:"^"[ENT G1
 S FN=$P(ENT,U,3),ACT="U"
 D QUERY I '$D(DLIST) W !,"No records available to update.",! G G1
 S VPRX=$$SELECT(FN) I "^"[VPRX W ! G G1
 F VPRI=1:1 S VPRN=$P(VPRX,",",VPRI) Q:VPRN<1  D
 . S ID=$G(DLIST(VPRN))_";"_FN
 . D P1^VPRHS,OUT(VPRN)
 ;
 W ! G G1
 Q
 ;
ICN(DFN) ; -- return ICN or -1^Message
 N ICN,X I $G(DFN)<1 S ICN="-1^INVALID PATIENT" G ICQ
 S X=$G(^DPT(DFN,.35)) I X D  G ICQ
 . S ICN="-1^Patient DIED on "_$$FMTE^XLFDT(X)
 I $$TESTPAT^VADPT(DFN),$$PROD^XUPROD S ICN="-1^TEST PATIENT" G ICQ
 I $$MERGED^VPRHS(DFN) D  G ICQ
 . S ICN="-1^Patient is being MERGED",X=$G(^DPT(DFN,-9))
 . I X S ICN=ICN_" into DFN "_X
 S ICN=$$GETICN^MPIF001(DFN) ;-1^error or ICN
ICQ ;exit
 Q ICN
 ;
OUT(N) ; -- write message
 S:$G(ID)="" ID="*"
 N SEQ S SEQ=+$G(^VPR(1,2,DFN,"AVPR",TYPE,ID))
 I ID="*" W !,TYPE," container "_$S(SEQ:"",1:" NOT")_" added to update queue." Q
 W !,TYPE_" "_$S($G(N):"#"_N,1:"")_$S(SEQ:"",1:" NOT")_" added to update queue."
 Q
 ;
CONT() ; -- continue?
 N X,Y,DIR,DUOUT,DTOUT
 S DIR(0)="YA",DIR("B")="NO"
 S DIR("A")="Are you sure you want to continue with this patient? "
 S DIR("?")="Enter YES to add this patient to the ECR and subscribe to VistA updates, or NO to exit."
 D ^DIR S:$D(DUOUT)!$D(DTOUT) Y="^"
 Q Y
 ;
ENTITY(TYPE) ; -- return array of selected Entity info
 N C,X,Y,I,FN S TYPE=$G(TYPE,"ZZZ")
 S C=+$O(^VPRC(560.1,"C",TYPE,0))
 S X=+$P($G(^VPRC(560.1,C,1,0)),U,4),Y=0
 I X<1 W !!,"This container has no source files." G ENTQ
 I X=1 S I=+$O(^VPRC(560.1,C,1,0)),Y=+$P($G(^(I,0)),U,2) G ENTQ
 ;
 W !!,"This container has multiple sources; please select one."
 S FN=$$FILE^VPRHST(C) I FN>0 D
 . S I=+$O(^VPRC(560.1,C,1,"B",FN,0))
 . S Y=+$P($G(^VPRC(560.1,C,1,I,0)),U,2)
ENTQ ;exit
 S:Y Y=Y_U_$G(^DDE(Y,0))
 Q Y
 ;
ALL() ; -- return 1 or 0, for full container (all records) update
 N X,Y,DIR,DUOUT,DTOUT
 S DIR(0)="YA",DIR("B")="NO"
 S DIR("A")="Update the full container? "
 S DIR("?")="Enter YES to send all available records in this container to the ECR, or NO to exit."
 D ^DIR S:$D(DUOUT)!$D(DTOUT) Y="^"
 Q Y
 ;
QUERY ; -- execute Query, return DLIST(#)=ID
 ; Expects DFN, ENT=ien^name^file#
 N DSTRT,DSTOP,DMAX,QRTN
 Q:'$G(DFN)  S QRTN=$G(^DDE(+ENT,5)) Q:QRTN=""  Q:'$L($T(@($P(QRTN,"("))))
 S DSTRT=2222222,DSTOP=4444444,DMAX=99999 K DLIST
 D @QRTN
 Q
 ;
SELECT(FNUM) ; -- select ID(s) for update list
 N X,Y,DIR
 W !!,"Available "_TYPE_"s for "_$P($G(^DPT(DFN,0)),U)_": " D LIST
 S DIR(0)="LAO^1:"_$O(DLIST("A"),-1),DIR("A")="Select ITEM(S): "
 S DIR("?")="Select the number(s) of the records for updating."
 S DIR("??")="^D LIST^VPRHSX"
 D ^DIR
 Q Y
 ;
LIST ; -- ??help for SELECT
 N FLDS,LCNT,ID,X,DONE
 S (LCNT,DONE)=0,FLDS=$$FIELDS(FNUM)
 F  S LCNT=$O(DLIST(LCNT)) Q:LCNT<1  D  Q:DONE
 . S ID=DLIST(LCNT) S:ID["^" ID=$P(ID,U) S:ID["~" ID=$P(ID,"~") ;IEN
 . W !,LCNT,?5,$$DATE(FNUM,$P(FLDS,";"),ID)
 . W @$S(TYPE="Problem":"?19",TYPE="MemberEnrollment":"?19",1:"?25")
 . W $$NAME(FNUM,$P(FLDS,";",2,99),ID)
 . Q:LCNT#22  W !,"Press <return> to continue..."
 . R X:DTIME I '$T!(X["^") S DONE=1
 Q
 ;
DATE(FN,FD,DA) ; -- return external date
 N RES S RES=$$GET1^DIQ(FN,DA_",",FD)
 I $P(RES,":",3) S RES=$P(RES,":",1,2) ;strip seconds
 I RES="" S RES="<NO DATE>"
 Q RES
 ;
NAME(FN,FD,DA) ; -- return name or description
 N RES S RES=""
 I FN=120.86 S RES=$S('$P($G(^GMR(120.86,DA,0)),U,2):"No ",1:"")_"Known Allergies" Q RES
 I FN=100,TYPE="OtherOrder" D  Q RES
 . N VPRX,ORIGVIEW
 . S ORIGVIEW=2 D TEXT^ORQ12(.VPRX,DA)
 . S RES=$G(VPRX(1))
 . I $L(RES)>50 S RES=$E(RES,1,50)_"..."
 N IDX,VPRX,SP S IDX="VPRX",SP=""
 D:FD GETS^DIQ(FN,DA_",",FD,"EN",IDX)
 F  S IDX=$Q(@IDX) Q:IDX'?1"VPRX(".E  S RES=RES_SP_@IDX,SP=", "
 Q RES
 ;
FIELDS(FN,IEN) ; -- DATE;NAME fields to display record
 N Y,FLDS S Y=""
 I FN=120.5 S Y=".01;.03"
 I FN=120.8 S Y="4;.02"
 I FN=120.86 S Y="3;1"
 I FN=100 S Y="21;.1*"
 I FN=9000010 S Y=".01;.07;.22"
 I FN[".",$P(FN,".")=9000010 S Y=".03;.01"
 ; FN=790.05 S Y=".01;21"
 I FN=9000011 S Y=".08;.05"
 I FN=783 S Y=".1"
 I FN=230 S Y=".01;.03"
 I FN=405 S Y=".01;.02"
 I FN=2.98 S Y=".001;.01"
 I FN=41.1 S Y="2;9;10"
 I FN=45 S Y="2;79"
 I FN=8925 S Y="1301;.01"
 I FN=74 S Y="3;102"
 I $P(FN,".")=63 S Y=".01;.06"
 I FN=702 S Y=".02;.04"
 I FN=130 S Y=".09;26"
 I FN=123 S Y="3;1;4"
 I FN=26.13 S Y=".06;.02"
 I FN=2.312 S Y="8;.18"
 Q Y
