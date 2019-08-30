VPRHSX ;SLC/MKB -- HS Options ;09/18/18 4:36pm
 ;;1.0;VIRTUAL PATIENT RECORD;**8,15**;Sep 01, 2011;Build 9
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ; External References          DBIA#
 ; -------------------          -----
 ; ^DDE                          7014
 ; ^DPT                         10035
 ; %ZTLOAD                      10063
 ; DIC                           2051
 ; DIE                          10018
 ; DIQ                           2056
 ; DIR                          10026
 ; MPIF001                       2701
 ; XLFDT                        10103
 ; XPDUTL                       10141
 ; XUPROD                        4440
 ;
ON ; -- Turn monitoring on/off
 N X0,DA,DR,DIE,X,Y
 S X0=$G(^VPR(1,0)) I $P(X0,U,2),$$PROD^XUPROD D  Q:'$$SURE
 . W !,$C(7) ;On in production
 . W !,"WARNING: Turning off data monitoring will cause the Regional Health Connect"
 . W !,"         server to become out of synch with VistA!!"
 W ! S DA=1,DR=.02,DIE="^VPR(" D ^DIE
 Q
 ;
LAST ; -- Reset Last# for AVPR update list
 ; ^VPR("AVPR",seq#,DFN) = ICN ^ TYPE ^ ID ^ U/D ^ VISIT#
 ; ^VPR("ANEW",seq#,dfn) = ICN
 N LAST,FIRST,TOTAL,X0,AV,AN
 S FIRST=0 I $D(^VPR("AVPR")) S FIRST=+$O(^VPR("AVPR",0))
 I $D(^VPR("ANEW")),+$O(^VPR("ANEW",0))<FIRST!'$D(^VPR("AVPR")) S FIRST=+$O(^VPR("ANEW",0))
 S LAST=+$G(^VPR(1,1)),TOTAL=LAST-FIRST+1
 ;
 I '$D(^VPR("AVPR")),'$D(^VPR("ANEW")) D  Q
 . W !!,"There are no records or patients in the update list."
 . I LAST,$$RESET S ^VPR(1,1)=0
 ;
 W !!,TOTAL_" records or patients awaiting update, last sequence number is "_LAST
 S X0=$G(^VPR(1,0)) I $P(X0,U,2),$$PROD^XUPROD D
 . W !,$C(7) ;On in production
 . W !,"WARNING: Resetting the update list will cause the Regional Health Connect"
 . W !,"         server to become out of synch with VistA!!"
 W ! I $$SURE(1) D
 . K ^VPR("AVPR"),^VPR("ANEW") S ^VPR(1,1)=0
 . N DFN S DFN=0 F  S DFN=$O(^VPR(1,2,DFN)) Q:DFN<1  K ^VPR(1,2,DFN,"AVPR"),^VPR(1,2,DFN,"ANEW")
 . W !," ... queue cleared, list counter reset to 0."
 Q
 ;
SURE(Q) ; -- are you sure?
 N X,Y,DIR,DUOUT,DTOUT
 S DIR(0)="YA",DIR("B")="NO",Q=+$G(Q)
 S:Q=0 DIR("A")="ARE YOU SURE? ",DIR("?")="Enter YES ONLY if directed to do so by Health Product Support or development staff!!"
 S:Q=1 DIR("A")="Are you sure you want to clear the update list? ",DIR("?")="Enter YES to empty the list of records to update and reset the counter, or NO to exit without making any changes."
 D ^DIR S:$D(DUOUT)!$D(DTOUT) Y="^"
 Q Y
 ;
RESET() ; -- Reset sequence#?
 N X,Y,DIR,DUOUT,DTOUT
 S DIR(0)="YA",DIR("A")="Reset the list counter? ",DIR("B")="NO"
 S DIR("?")="Last sequence number used is "_LAST_"; select YES to reset the list counter to start over from 0."
 D ^DIR S:$D(DUOUT)!$D(DTOUT) Y="^"
 Q Y
 ;
GET ; -- Add patient/container/record to GET list
 N DFN,ICN,X
 I '$P($G(^VPR(1,0)),U,2) W !,"WARNING: Data Monitoring is currently disabled!",!
 ;
 S DFN=+$$PATIENT^VPRHST Q:DFN<1
 S ICN=$$GETICN^MPIF001(DFN) I ICN<0 W !,"ICN is required!",! Q
 ;
 I '$$SUBS^VPRHS(DFN) D  Q
 . W !,$C(7),"WARNING: This patient is not currently in the Edge Cache Repository (ECR)!",!
 . S X=+$G(^DPT(DFN,.35)) I X D  Q
 .. W !,"This patient has a Date of Death: "_$$FMTE^XLFDT(X)
 .. W !,"Cannot add to ECR",!
 . I $G(^VPR(1,2,DFN,"ANEW")) W !,"This patient already has a request for subscription.",! Q
 . Q:'$$CONT  D NEW^VPRHS(DFN,ICN)
 . S X=$G(^VPR(1,2,DFN,"ANEW"))
 . W !," ... request "_$S(X:"",1:"NOT ")_"added to update queue."
G1 ;
 N ENT,FN,TYPE,ACT,VST,DLIST,VPRX,VPRI,VPRN,ID
 D ENTITY(.ENT) Q:"^"[ENT
 S FN=$P(ENT(0),U,2),TYPE=$G(ENT(.1)),ACT="U",ID=""
 I $G(^VPR(1,2,DFN,"AVPR",TYPE,"*")) W !,"This patient already has a container update request in the queue!",! Q
 I TYPE="Patient"!(TYPE="Alert")!(TYPE="AdvanceDirective") D  Q
 . W !,"Entire container must be updated"
 . D P1^VPRHS,OUT
 I $$ALL D P1^VPRHS,OUT Q
 D QUERY I '$D(DLIST) W !,"No records available to update.",! Q
 S VPRX=$$SELECT(FN) Q:"^"[VPRX
 F VPRI=1:1 S VPRN=$P(VPRX,",",VPRI) Q:VPRN<1  D
 . S ID=$G(DLIST(VPRN))_";"_FN
 . D P1^VPRHS,OUT
 ;
 Q
 ;
OUT ; -- write message
 S:$G(ID)="" ID="*"
 N SEQ S SEQ=+$G(^VPR(1,2,DFN,"AVPR",TYPE,ID))
 I ID="*" W !," ... request"_$S(SEQ:"",1:" NOT")_" added to update queue." Q
 W !,TYPE_" "_$P(ID,";")_$S(SEQ:"",1:" NOT")_" added to update queue."
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
ENTITY(Y) ; -- return array of selected Entity info
 N X,DIC
 S DIC=1.5,DIC(0)="AEQMZ",DIC("S")="I $L($G(^(5)))"
 D ^DIC I Y<1 S Y="^" Q
 S Y(.1)=$G(^DDE(+Y,.1)),Y(5)=$G(^(5))
 Q
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
 ; Expects DFN, ENT(5)=TAG^ROUTINE
 N DSTRT,DSTOP,DMAX,QRTN
 Q:'$G(DFN)  S QRTN=$G(ENT(5)) Q:QRTN=""  Q:'$L($T(@QRTN))
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
 N FLDS,LCNT,VPRX,IDX,SP,I,X,DONE
 S (LCNT,DONE)=0,FLDS=$$FIELDS(FNUM)
 F  S LCNT=$O(DLIST(LCNT)) Q:LCNT<1  D  Q:DONE
 . S I=DLIST(LCNT),IDX="VPRX",SP="  "
 . S:I["^" I=$P(I,U) S:I["~" I=$P(I,"~") ;IEN only
 . D GETS^DIQ(FNUM,I_",",FLDS,,IDX) Q:'$D(IDX)
 . S IDX=$Q(@IDX) W !,LCNT,?5,@IDX
 . F  S IDX=$Q(@IDX) Q:IDX'?1"VPRX(".E  W SP_@IDX S SP=", "
 . Q:LCNT#22  W !,"Press <return> to continue..."
 . R X:DTIME I '$T!(X["^") S DONE=1
 Q
 ;
FIELDS(FN,IEN) ; -- DATE;NAME fields to display record
 N Y,FLDS S Y=""
 I FN=120.5 S Y=".01;.03"
 I FN=120.8 S Y="4;.02"
 I FN=100 S Y="21;.1*"
 I FN=9000010 S Y=".01;.22"
 I FN[".",$P(FN,".")=9000010 S Y=".03;.01"
 I FN=9000011 S Y=".08;.05"
 I FN=783 S Y=".1"
 I FN=405 S Y=".01;.02"
 I FN=2.98 S Y=".001;.01"
 I FN=41.1 S Y="2;9"
 I FN=45 S Y="2;79"
 I FN=8925 S Y="1301;.01"
 I FN=74 S Y="3;.01"
 I $P(FN,".")=63 S Y=".01;.06"
 I FN=702 S Y=".02;.04"
 I FN=130 S Y=".09;26"
 I FN=123 S Y="3;1"
 Q Y
