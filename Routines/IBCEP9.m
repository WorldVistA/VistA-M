IBCEP9 ;ALB/TMP - MASS UPDATE OF PROVIDER ID FROM FILE OR MANUAL ;08-NOV-00
 ;;2.0;INTEGRATED BILLING;**137,200,320,348,349**;21-MAR-94;Build 46
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
EN ; Get parameters and mass input provider id by ins co
 N A,DA,DIC,DIE,DIK,DIR,DR,POP,Q,Q0,X,Y,Y3,Z,Z0
 N IBCND,IBCU,IBCT,IBDELIM,IBFILE,IBFILEN,IBFILEP,IBFORMAT
 N IBFT,IBINFILE,IBINS,IBL,IBN,IBOK,IBOPEN,IBPOS,IBPT,IBQUIT
 N IBQUIT1,IBQUOTES,IBRA,IBS,IBSA,IBSTART,IBSRC,IBVERIFY,IBVNAME
 K ^TMP("IBPID_IN",$J),^TMP("IBPID-ERR",$J),^TMP("IBPID",$J)
 S IBQUIT=0
1 ; Select INSURANCE COMPANY NAME:
 G:IBQUIT ENQ
 S IBQUIT1=0
 S DIC("S")="I $P($G(^DIC(36,+Y,3)),U,13)'=""C"""
 S DIC(0)="AEMQ",DIC="^DIC(36," D ^DIC
 I Y'>0 G ENQ
 S IBINS=+Y
 S IBQUIT=$$LOCK^IBCEP9B(IBINS)
 I IBQUIT,$G(IBINS) D  G 1
 . D UNLOCK^IBCEP9B(IBINS)
 . S IBINS="",IBQUIT=0
 . W !!,"Unable to lock all associated insurance companies.",!,"Please try again later.",!!
 ;
2 ; get data source
 S IBQUIT1=0
 S DIR(0)="SA^M:Manual Entry;F:Entry from file"
 S DIR("A")="PROVIDER ID DATA SOURCE: ",DIR("B")="Manual Entry"
 S Y=$$DIR(.DIR,.IBQUIT,.IBQUIT1)
 I Y=""!("FM"'[Y)!IBQUIT1 D UNLOCK^IBCEP9B(IBINS) G 1
 S IBSRC=Y,IBVERIFY=0
 S IBVERIFY=(Y="M")
 I 'IBVERIFY D  G:IBQUIT ENQ G:IBQUIT 2
 . S DIR(0)="YA",DIR("A")="DO YOU WANT TO VIEW/VERIFY EACH ENTRY BEFORE IT GETS UPDATED?: "
 . S Y=$$DIR(.DIR,.IBQUIT,.IBQUIT1)
 . I Y=1 S IBVERIFY=1
 ;
 G:IBSRC="M" 4
21 ; get parameters for file type
 G:IBQUIT ENQ
 S IBQUIT1=0
 S DIR(0)="SA^D:DELIMITED;F:FIXED LENGTH",DIR("B")="D",DIR("A")="SELECT FILE FORMAT: "
 S Y=$$DIR(.DIR,.IBQUIT,.IBQUIT1)
 I IBQUIT1 G 2
 S IBPOS=Y
 I IBPOS="D" D  G:IBQUIT1 21
 . S DIR(0)="FA^1:1",DIR("B")=",",DIR("A")="DELIMITER CHARACTER: "
 . S Y=$$DIR(.DIR,.IBQUIT,.IBQUIT1)
 . Q:IBQUIT1
 . S $P(IBPOS,U,2)=Y
 . S DIR(0)="YA",DIR("B")="NO",DIR("A")="ARE QUOTES WITHIN A FIELD DOUBLE QUOTED?: "
 . S Y=$$DIR(.DIR,.IBQUIT,.IBQUIT1,,,1)
 . Q:IBQUIT1
 . S $P(IBPOS,U,3)=Y
3 ; select external file name
 G:IBQUIT ENQ
 S IBQUIT1=0
 G:IBSRC="M" 2
 S DIR(0)="FA^1:60"
 S DIR("A")="FILE NAME PATH: ",DIR("B")=$$PWD^%ZISH
 S Y=$$DIR(.DIR,.IBQUIT,.IBQUIT1)
 G:IBQUIT1 2
 S IBFILEP=$P(Y,U)
 S DIR(0)="FA^1:60"
 S DIR("A")="FILE NAME: "
 S IBSA("*")=""
 S DIR("?")="^S Y3=$$LIST^%ZISH(IBFILEP,""IBSA"",""IBRA"") I Y3=1 S Y3="""" F  S Y3=$O(IBRA(Y3)) Q:Y3=""""  W !,Y3"
 S Y=$$DIR(.DIR,.IBQUIT,.IBQUIT1,,,1)
 G:IBQUIT1 2
 S IBFILEN=$P(Y,U)
 K ^TMP($J),IBRA,Y3
 N Y S Y=$$FTG^%ZISH(IBFILEP,IBFILEN,$NA(^TMP($J,1)),2)
 I Y=0 W !,"FILE ",IBFILEP,IBFILEN," COULD NOT BE FOUND OR COULD NOT BE OPENED",! G 3
 S IBFILE=IO
4 ; select Provider ID Type
 G:IBQUIT ENQ
 S IBQUIT1=0
 S DIR(0)="355.9,.06"
 I IBSRC="M" S Z=$P($G(^IBE(355.97,+$$PPTYP^IBCEP0(IBINS),0)),U) S:Z'="" DIR("B")=Z
 S Y=$$DIR(.DIR,.IBQUIT,.IBQUIT1)
 G:Y=""!IBQUIT1 3
 S IBPTYP=$P(Y,U)
5 ; select Forms Type
 G:IBQUIT ENQ
 S IBQUIT1=0
 S DIR(0)="355.9,.04r",DIR("B")="BOTH UB-04 AND CMS-1500 FORMS"
 S Y=$$DIR(.DIR,.IBQUIT,.IBQUIT1)
 G:IBQUIT1 4
 I Y=""!("012"'[Y) G 5
 S IBFT=$P(Y,U)
6 ; select Bill Care Type
 G:IBQUIT ENQ
 S IBQUIT1=0
 S DIR(0)="355.9,.05r",DIR("B")="BOTH INPATIENT AND OUTPATIENT"
 S Y=$$DIR(.DIR,.IBQUIT,.IBQUIT1)
 G:IBQUIT1 5
 I Y=""!("0123"'[$P(Y,U)) G 6
 S IBCT=$P(Y,U)
 ;
 S IBCND=$$CAREUN^IBCEP3(IBINS,IBPTYP,IBFT,IBCT,IBCT=3)
7 ; get Care Unit
 G:IBQUIT ENQ
 S IBQUIT1=0
 I IBCND D  G:IBQUIT1 6
 . S DIR(0)="355.9,.03O"
 . S Y=$$DIR(.DIR,.IBQUIT,.IBQUIT1)
 . Q:IBQUIT1
 . S IBCU=$P(Y,U)
 . I IBCU="" W !!,$J("",22),"***** WARNING *****",!," YOU WILL NEED TO MANUALLY ENTER THE CARE UNIT FOR EACH PROVIDER",!!
 ;
 ; Manual entry to get providers from VistA
 I IBSRC="M" D MANUAL^IBCEP9B G:IBQUIT1 6
 ; For 'OTHER' files ask position/length or delimiter/piece for data
 I IBSRC="F" D  I IBQUIT1 G:'IBCND 6 G 7
 . F Z="PROV. SSN^SSN^15^1","PROV. NAME^NAM^30","PROV. 1500 ID^PROF_ID^15","PROV. UB-04 ID^INST_ID^15" D  Q:IBQUIT1
 .. I $P(IBPOS,U)'="D" D
 ... N X
 ... I IBFT=0!(IBFT=1) Q:Z["PROF_ID"  I Z["INST_ID" S $P(Z,U)="PROV. ID"
 ... I IBFT=2 Q:Z["INST_ID"
 ... S DIR("A")="START POSITION OF "_$P(Z,U)_" FIELD: "
 ... S DIR(0)="NA"_$S($P(Z,U,4)!($P(Z,U)["PROV. ID")!($P(Z,U)["_ID"):"",1:"O")_"^1:250"
 ... W ! S X=$$DIR1^IBCEP9B(.DIR,Z,.IBQUIT,.IBQUIT1)
 ... Q:IBQUIT1
 ... I X>0 D
 .... S IBPOS($P(Z,U,2))=X
 .... S DIR("A")="LENGTH OF "_$P(Z,U)_" FIELD: "
 .... S DIR(0)="NA"_$S($P(Z,U,3):"^1:"_$P(Z,U,3),1:"")
 .... S X=$$DIR1^IBCEP9B(.DIR,Z,.IBQUIT,.IBQUIT1)
 .... Q:IBQUIT1
 .... S $P(IBPOS($P(Z,U,2)),U,2)=IBPOS($P(Z,U,2))+X-1
 .. ;
 .. I $P(IBPOS,U)="D" D
 ... I IBFT=0!(IBFT=1) Q:Z["PROF_ID"  I Z["INST_ID" S $P(Z,U)="PROV. ID"
 ... I IBFT=2 Q:Z["INST_ID"
 ... W ! S DIR("A")="STARTING '"_$P(IBPOS,U,2)_"' PIECE # OF "_$P(Z,U)_" FIELD: "
 ... S DIR(0)="NA"_$S($P(Z,U,4)!($P(Z,U)["PROV. ID")!($P(Z,U)["_ID"):"",1:"O")
 ... S X=$$DIR1^IBCEP9B(.DIR,Z,.IBQUIT,.IBQUIT1)
 ... Q:IBQUIT1
 ... I X>0 D
 .... S (DIR("B"),IBPOS($P(Z,U,2)))=X
 .... S DIR("A")="ENDING '"_$P(IBPOS,U,2)_"' PIECE # OF "_$P(Z,U)_" FIELD: "
 .... S DIR(0)="NA"_$S($P(Z,U,4):"",1:"O")_U_(IBPOS($P(Z,U,2)))_":99"
 .... S DIR("?")="JUST PRESS THE ENTER KEY IF THIS FIELD IS CONTAINED IN ONLY 1 PIECE"
 .... S Y=$$DIR1^IBCEP9B(.DIR,Z,.IBQUIT,.IBQUIT1)
 .... Q:IBQUIT1
 .... W ! I Y>0,Y'=IBPOS($P(Z,U,2)) S $P(IBPOS($P(Z,U,2)),U,2)=Y
 .. ;
 . Q:IBQUIT1
 . D READFILE^IBCEP9B
 . ;
P1 ;
 S Z="" F  S Z=$O(^TMP("IBPID_IN",$J,Z)) Q:Z=""  S Z0=0 F  S Z0=$O(^TMP("IBPID_IN",$J,Z,Z0)) Q:'Z0  S Q=$G(^(Z0)) D  G:IBQUIT ENQ
 . ;
 . I IBSRC="M" D  Q
 .. D DISP^IBCEP9B(Q,0,IBINS,IBPTYP,IBFT,IBCT,$G(IBCU),,IBSRC)
 .. ; Manually add IDs
 .. S IBN=$$DUP(+Z0_";VA(200,",IBINS,$S($G(IBCU)'="":IBCU,1:"*N/A*"),IBFT,IBCT,IBPTYP)
 .. I 'IBN D  Q:IBQUIT!(IBN'>0)
 ... S IBN=$$ADDID^IBCEP9B(Z0,IBINS,$G(IBCU),IBFT,IBCT,IBPTYP,,.IBQUIT)
 .. S DIE="^IBA(355.9,",DR=".07",DA=+IBN D ^DIE
 .. I $D(Y)!($P($G(^IBA(355.9,+IBN,0)),U,7)="") D
 ... I $P(IBN,U,3) S DA=+IBN,DIK="^IBA(355.9," D ^DIK
 ... S DIR(0)="YA",DIR("B")="NO",DIR("A")="DO YOU WANT TO STOP ENTERING PROVIDER IDs?: "
 ... S Y=$$DIR(.DIR,.IBQUIT,.IBQUIT1,,1,1)
 ... I Y=1 S IBQUIT=1
 .. S IBID=$P($G(^IBA(355.9,+IBN,0)),U,7)
 .. S:$L(IBID) ^TMP("IBPID_IN",$J,U,Z0,"INST_ID")=IBID
 .. I IBID="" K ^TMP("IBPID_IN",$J,U,Z0)
 .. I IBQUIT=1 F  S Z0=$O(^TMP("IBPID_IN",$J,U,Z0)) Q:Z0=""  K ^TMP("IBPID_IN",$J,U,Z0) ; user wants to stop, remove all remaining names from list
 . ;
 . S IBOK=1
 . N IBX,IBID
 . M IBX=^TMP("IBPID_IN",$J,Z,Z0)
 . I IBSRC="F" S IBID=$S(IBFT=0!(IBFT=1):$G(IBX("INST_ID")),1:$G(IBX("PROF_ID")))
 . I $G(IBVERIFY) D  ; Display record, ask OK to file id's
 .. D DISP^IBCEP9B(Q,0,IBINS,IBPTYP,IBFT,IBCT,$G(IBCU),,IBSRC)
 .. W !,"PROVIDER ID: ",IBID
 .. S DIR("A")="OK TO FILE THIS ID FOR THIS PROVIDER?: ",DIR(0)="YA",DIR("B")="NO"
 .. S Y=$$DIR(.DIR,,,,1,1)
 .. I Y'=1 D  Q  ; Send to error array
 ... S IBOK=0
 ... S ^TMP("IBPID-ERR",$J,2,$P(IBX,U),$P(IBX,U,2)_" ","PROV ID")=IBID
 ... S ^TMP("IBPID_IN",$J,U,Z0,0)="NO PRINT"
 ... N Z1
 ... S Z1="" F  S Z1=$O(IBX(Z1)) Q:Z1=""  I $G(IBX(Z1))'="",Z1'["_ID" S ^TMP("IBPID-ERR",$J,2,$P(IBX,U),$P(IBX,U,2)_" ",Z1)=IBX(Z1)
 . I IBOK D  ; Add/update the record
 .. I IBSRC="F" D
 ... I IBID'="" D
 .... S IBN=$$ADDID^IBCEP9B(+Z0,IBINS,$G(IBCU),IBFT,IBCT,IBPTYP,,.IBQUIT)
 .... I IBQUIT D:IBN>0  Q
 ..... S DA=+IBN,DIK="^IBA(355.9," D ^DIK
 .... I IBN>0 S DIE="^IBA(355.9,",DA=+IBN,DR=".07////"_IBID D ^DIE
 .. ;
 ;
ENQ ; Print report, exit
 I $G(IBINS) D
 . D COPY^IBCEPCID(IBINS)
 . D UNLOCK^IBCEP9B(IBINS)
 ;
 I ($D(^TMP("IBPID-ERR",$J)))!($D(^TMP("IBPID_IN",$J))) D
 . N %ZIS,ZTSAVE,ZTRTN,ZTDESC,IBDUZ
 . S IBDUZ=$G(DUZ)
 . S %ZIS="QM" D ^%ZIS Q:POP
 . I $D(IO("Q")) K IO("Q") D  D ^%ZTLOAD K ZTSK D HOME^%ZIS Q
 .. S ZTRTN="PRTERR^IBCEP9B",ZTSAVE("^TMP(""IBPID-ERR"",$J,")=""
 .. S ZTSAVE("^TMP(""IBPID_IN"",$J,")="",ZTSAVE("IB*")=""
 .. S ZTDESC="IB - PROVIDER ID BATCH UPDATE ERROR LOG"
 . U IO
 . D PRTERR^IBCEP9B
 K ^TMP("IBPID_IN",$J),^TMP("IBPID-ERR",$J),^TMP("IBPID",$J)
 U IO(0)
 Q
 ;
DUP(IBPRV,IBINS,IBCU,IBFT,IBCT,IBPTYP) ; Check if provider id record already exists in file 355.9
 Q +$O(^IBA(355.9,"AUNIQ",IBPRV,IBINS,IBCU,IBFT,IBCT,IBPTYP,0))
 ;
ERREOF ; Traps EOF error on file read for non-DSM systems
 N IBERROR S IBERROR=$$EC^%ZOSV
 I IBERROR["ENDOFFILE" D CLOSE(.IBOPEN) G ENQ
 D ^%ZTER
 Q
 ;
CLOSE(IBOPEN) ; Close file
 D CLOSE^%ZISH("IBINFILE") S IBOPEN=0
 Q
 ;
DIR(DIR,IBQUIT,IBQUIT1,X,IBW1,IBW2) ; Standard call to ^DIR
 ;  Inputs DIR array
 ;  Returns IBQUIT,IBQUIT1,X if passed by reference
 ;    AND
 ;      FUNCTION returns the value of Y
 ;  IBW1 = 1 if initial write ! should be done
 ;  IBW2 = 1 if last write ! should be done
 N DIROUT,DTOUT,DUOUT,DA
 W:$G(IBW1) ! D ^DIR K DIR W:$G(IBW2) !
 S (IBQUIT,IBQUIT1)=0
 S DIR("?")="Enter '^' to back up one prompt or '^^' to exit the option"
 I $D(DIROUT) S (IBQUIT,IBQUIT1)=1
 I $D(DTOUT)!$D(DUOUT) S IBQUIT1=1
 Q Y
 ;
ERR ; Error list
 ;; INVALID OR MISSING SSN - NO PROVIDER MATCH FOUND
 ;; NO UPDATE PER USER REQUEST
 ;;
