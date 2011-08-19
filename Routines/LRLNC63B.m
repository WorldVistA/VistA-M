LRLNC63B ;DALOI/FHS-HISTORICAL LOINC MAPPING MODIFIER ;01/30/2001 15:19
 ;;5.2;LAB SERVICE;**279**;Sep 27, 1994
EN ;
 K DIR W @IOF
 W !!,$$CJ^XLFSTR("This option will allow you to manage how specific DataNames",80)
 W !,$$CJ^XLFSTR("will be mapped to LOINC Codes for historical data.",80)
 W !!,$$LJ^XLFSTR("You are able to override file definitions to correct past LOINC mappings.",80)
 W !,$$LJ^XLFSTR("Select the CH subsripted test, indicate the suffix to be used.",80)
 W !,$$LJ^XLFSTR("You can indicate if this suffix should override previous LOINC Mapping.",80),!
 W !,$$LJ^XLFSTR("This option will REMAP your entire database.",80),!!
 W !,$$LJ^XLFSTR("This option should only be run on weekends after hours.",80),!
 S DIR(0)="Y",DIR("A")=" Do you wish to continue "
 D ^DIR Q:$G(Y)'=1
 K ^XTMP("LRLNC63",2),^XTMP("LRLNC63","LST"),^TMP("LR",$J),^TMP("LRLNC63",$J),LRCNT,LROX
SELECT ;Indicate which DATANAMES LOINC definition to be changed.
 K LRMOD,LRY,NODE
 S LRY=1
 F  W !! Q:$G(LRY)<1  D
 . K DIR,X
 . W !,$$CJ^XLFSTR("Selection can be a 'CH' Atomic or Panel test.",80),!
 . S DIR("?")="Selection can be an Atomic or Panel test."
 . S DIR("?",1)="Only those tests with a Result code will be stored."
 . S DIR(0)="PO^60:EMZ",DIR("S")="I $P(^(0),U,4)=""CH"""
 . S DIR("A")="Select test you want to modify mapping"
 . D ^DIR
 . S LRY=Y Q:Y<1
 . S LRYY=$P($P(Y(0),U,5),";",2)_U_LRY
 . D EXPAND
 ;
DISPLAY ;Show what has been recorded
 K DIRUT,LRY
 I '$O(^TMP("LRLNC63",$J,0)) W !?5,"Nothing was selected, Process Aborted",! Q
 W @IOF
 W !,$$CJ^XLFSTR("Here is a list of what you have selected.",80)
 W !,$$CJ^XLFSTR("[O] indicates override current mapping.",80),!
 D
 . D ^%ZIS Q:POP
 . U IO
 . N DIR
 . S DIR="E"
 . S NODE="^TMP(""LRLNC63"","_$J_",0)" F  S NODE=$Q(@NODE) Q:$S(NODE="":1,$QS(NODE,2)'=$J:1,1:0)  D  Q:$D(DIRUT)
 . . I $Y>(IOSL-3) D
 . . . I $E(IOST,1.2)="C-" D ^DIR Q:$D(DIRUT)
 . . . W @IOF
 . . . W !,"Here is a list of what you have selected."
 . . . W !,"[O] indicates override current mapping.",!
 . . D SHO
 . W:$E(IOST,1)="P" @IOF
 . D ^%ZISC
CHK ;
 ; K ^TMP("LR",$J)
 W !
 I $D(DIRUT) S DIR(0)="Y",DIR("A")="  Do you want to STOP" D ^DIR G:$G(Y)=1 END
 K DIR S DIR(0)="YO",DIR("A")="You wish to add more" D ^DIR I $G(Y)=1 G SELECT
 I $G(Y)=U G END
 ;
 W !
 S DIR("A")=" Do you want to delete an entry" D ^DIR G END:$G(Y)=U
 I $G(Y)=1 D EDIT G DISPLAY
 I $O(^TMP("LRLNC63",$J,0)) D
 . S LRMOD=1,ZTSAVE("LRMOD")=""
 . S NODE="^TMP(""LRLNC63"",0)"
 . F  S NODE=$Q(@NODE) Q:$S($QS(NODE,2)'=$J:1,1:0)  D
 . . S ^XTMP("LRLNC63",2,$QS(NODE,5))=@NODE
FIRE ;Run the mapping tasking function
 D QUE^LRLNC63
 Q
END ;
 K DIRUT
 K ^XTMP("LRLNC63",2)
 Q
SHO ;
 N LRX,LRXY
 S LRX=@NODE
 W !,$QS(NODE,3)_" "_$S($P(LRX,U,6):"[O]",1:"   "),?7,$E($P(LRX,U,3),1,30),?40,$E($P(LRX,U,4),1,25),?70,"/ ",$P(LRX,U,5)
 ;S LRXY=$QS(NODE,1)_"  "_$P(LRX,U,3)_" - "_$P(LRX,U,4)_" / "_$P(LRX,U,5)_"  "_$S($P(LRX,U,6):"Override Yes",1:"")
 ;W !,LRXY
 Q
EDIT ;
 K DIR,DIRUT
 S DIR("A")="Delete this entry"
 S DIR(0)="NO^1:"_LRCNT D ^DIR
 Q:$D(DIRUT)
 S LRY=Y I '$D(^TMP("LRLNC63",$J,Y)) W !?5,Y_" Entry not Valid",! G EDIT
 S NODE="^TMP(""LRLNC63"","_$J_","_Y_",0)"
 S NODE=$Q(@NODE) I $QS(NODE,2)'=$J W !?5,Y_" Entry not Valid",! G EDIT
 D SHO
 S DIR(0)="YO" D ^DIR Q:$D(DIRUT)
 I $G(Y)=1 K ^TMP("LRLNC63",$J,LRY)
 G EDIT
 Q
EXPAND ;If panel test expand to get parts
 K ^TMP("LR",$J) S LRCFL=""
 K DIR,LRTEST,LRX,T1
 S LRTEST(+LRY)=+LRY_U_^LAB(60,+LRY,0),T1=+LRY
 S LRNX=0
 D EX1^LREXPD
 S DIR(0)="PO^64.2:EMZ",DIR("A")=" Select Suffix Code"
 D ^DIR Q:Y<1
 S LRSUF=$P(Y(0),U)_U_$P($P(Y(0),U,2),".",2)
 K DIR S DIR(0)="YO",DIR("A")="Override previous LOINC mapping"
 D ^DIR I Y=1 S LRSUF=LRSUF_U_1
 I $O(^TMP("LR",$J,"TMP",0)) D
 . S LRN=0 F  S LRN=$O(^TMP("LR",$J,"TMP",LRN)) Q:LRN<1  S LRNX=^(LRN) D
 . . Q:'$P($G(^LAB(60,LRNX,64)),U,2)
 . . S LRCNT=$G(LRCNT)+1
 . . S ^TMP("LRLNC63",$J,LRCNT,$P(^LAB(60,LRNX,0),U),LRN)=LRN_U_+LRNX_U_$P(^(0),U)_U_LRSUF
 Q
