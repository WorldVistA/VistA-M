LRLLS ;SLC/RWF-LOAD LIST FIX UP ;8/17/87  11:16
 ;;5.2;LAB SERVICE;**116,221**;Sep 27, 1994
LRINST ;from LRLLS2
 S U="^" D DT^LRX S LRAD=DT K ^TMP("LR",$J,"T"),DIC,LRHOLD,LRTSTS
 S DIC="^LRO(68.2,",DIC(0)="AEMZ",DIC("S")="S %=$P(^(0),U,12) X ""I '$L(%)"" Q:$T  S %=$P(^DIC(19.1,%,0),U,1) I $D(^XUSEC(%,DUZ))" D ^DIC K DIC S LRINST=+Y Q:Y<1
 S LRTRANS=+$P(Y(0),U,2),LRTYPE=+$P(Y(0),U,3),LRFULL=$P(Y(0),U,5),LRINSTIT=+$P(Y(0),U,7),LRMAXCUP=+$P(Y(0),U,4)
 S LRTRANS=$S($D(^LAB(62.07,LRTRANS,.1)):^(.1),1:"S LRCUP=LRCUP+1"),LRINSTIT=$S($D(^LAB(62.07,LRINSTIT,.1)):^(.1),1:"Q")
 Q
EN ;
INSERT ;INSERT A SAMPLE ON TO A TRAY
 D END D LRINST G END:LRINST<1 D PROFILE G END:+$G(LRWPROF)<1
IN2 S LRACC=1 S:+$G(LRWPROF)<1 LRWPROF=0 D ^LRWU4 K LRACC G END:LRAN<1
 D SHOW W !?15 S %=1 D YN^DICN G NOP:%<1,IN2:%=2
 K ^TMP("LR",$J,"T"),LRTSTS D WHATEST G NOP:'$D(X),NOP:X=U
IN5 D PCUP G NOP:LRCUP[U D LIFT,SETONE W !!," >> INSERTED <<" I LRHOLD'="" W !,"NOW WHAT TO DO WITH" D NOW,SHOW G IN5
 Q
LIFT K LRHOLD S LRHOLD=$S($D(^LRO(68.2,LRINST,1,LRTRAY,1,LRCUP,0)):^(0),1:"") Q:LRHOLD=""
 F I=0:0 S I=$O(^LRO(68.2,LRINST,1,LRTRAY,1,LRCUP,1,I)) Q:I<1  S LRHOLD(I)=^(I,0)
 IF $D(^LRO(68,+$P(LRHOLD,U,1),1,+$P(LRHOLD,U,2),1,+$P(LRHOLD,U,3),0))[0 S LRHOLD=""
 D DROP Q
NOW Q:LRHOLD=""  K ^TMP("LR",$J,"T"),LRTSTS S LRAA=+LRHOLD,LRAD=$P(LRHOLD,U,2),LRAN=$P(LRHOLD,U,3),LRWPROF=$P(LRHOLD,U,4)
 W:$D(^LRO(68,LRAA,1,+LRAD,1,+LRAN,.2)) " ACCESSION:  ",^(.2)
 F I=0:0 S I=$O(LRHOLD(I)) Q:I<1  S ^TMP("LR",$J,"T",I)=LRHOLD(I)
 Q
PCUP S W="PUT THE SAMPLE IN " G CP1
GCUP S W="REMOVE THE SAMPLE FROM "
CP1 I 'LRTYPE S LRTRAY=1 W !,W,"SEQUENCE #: " R LRCUP:DTIME G CP4:LRCUP[U!(LRCUP=""),CPSH:+LRCUP'=LRCUP Q
CP2 W !,W,"TRAY: " R LRTRAY:DTIME G CP4:LRTRAY[U!(LRTRAY="") R "    CUP: ",LRCUP:DTIME G CP4:LRCUP[U!(LRCUP=""),CPTH:+LRTRAY'=LRTRAY,CPTH:+LRCUP'=LRCUP Q
CP4 S LRCUP=U K W Q
CPSH W !,"Enter the SEQUENCE # to use." G CP1
CPTH W !,"Enter the TRAY or CUP that you want to use." G CP1
EN01 ;
CLEAR ; Clear data from LAH
 N DIR,DIRUT,DTOUT,DUOUT,LRCNT,LRCUTDT,LREND,LRINST,LRISQN,LRCTYPE,X,Y
 S DT=$$DT^XLFDT
 S (LRCUTDT,LREND)=0
 D LRINST
 I LRINST<1 D END Q
 I '$D(^LAH(LRINST)) D  Q
 . W !!,$C(7),"<<< No data in LAH global for this load/work list >>>",!
 . D NOP
 W !
 L +^LAH(LRINST):1
 I '$T D  Q
 . W !!,$C(7),"<<< Unable to lock global, try again later >>>",!
 . D NOP
 S DIR(0)="SO^0:All Results for this Load/Worklist;1:By Date Results First Received;2:By Date Results Last Updated",DIR("A")="Clear Results"
 S DIR("?",1)="All results can be cleared or results can"
 S DIR("?")="be cleared by date received or last updated."
 D ^DIR
 I $D(DIRUT) D UNLAH(LRINST),END Q
 S LRCTYPE=+Y
 I LRCTYPE D
 . W !
 . S DIR(0)="DO^:NOW:AEPTX",DIR("A")="Select Cutoff Date/Time",DIR("B")="T-1"
 . S DIR("?",1)="Enter a date or a date/time."
 . S DIR("?",2)="Date selected must be on or before "_$$HTE^XLFDT($H,"1")
 . S DIR("?")="Results before this date/time will be removed from Load/Worklist "_$P($G(^LRO(68.2,+LRINST,0)),"^")_"."
 . D ^DIR
 . I $D(DIRUT) S LREND=1 Q
 . S LRCUTDT=Y
 I LREND D UNLAH(LRINST),NOP Q
 W !
 S DIR(0)="YO",DIR("B")="NO"
 S DIR("A",1)="For Load/Worklist "_$P($G(^LRO(68.2,LRINST,0)),"^")_" clear "_$S(LRCUTDT:"results before "_$$FMTE^XLFDT(LRCUTDT),1:"ALL RESULTS")
 S DIR("A")="Is this correct"
 D ^DIR
 I $D(DIRUT)!(Y'=1) D UNLAH(LRINST),NOP Q
 W !!,"<< Clearing Instrument Data >>",!
 I 'LRCUTDT K ^LAH(LRINST) ; Kill all results for this loadlist.
 I LRCUTDT D
 . W !,"Clearing sequence number: "
 . S (LRCNT,LRISQN)=0
 . F  S LRISQN=$O(^LAH(LRINST,1,LRISQN)) Q:'LRISQN  D
 . . S $P(LRCNT,"^")=$P(LRCNT,"^")+1
 . . I '$P($G(^LAH(LRINST,1,LRISQN,0)),"^",11) D UPDT^LAGEN(LRINST,LRISQN) Q  ; No date, put current d/t, skip
 . . I $P($G(^LAH(LRINST,1,LRISQN,0)),"^",9+LRCTYPE)'<LRCUTDT Q  ; Skip - Keep
 . . S LRLL=LRINST,I=LRISQN,$P(LRCNT,"^",2)=$P(LRCNT,"^",2)+1
 . . I $X>(IOM-10) W !
 . . W "[",LRISQN,"]"
 . . N LRINST,LRISQN,LRCUTDT
 . . D ZAP^LRVR3
 . S X=$O(^LAH(LRINST,1,"A"),-1) ; Get last entry, reset zeroth node.
 . I X S ^LAH(LRINST)=X
 . I '$O(^LAH(LRINST,"")) K ^LAH(LRINST)
 . W !,"Checked ",+$P(LRCNT,"^")," entries, removed ",+$P(LRCNT,"^",2),"."
 D UNLAH(LRINST),END
 Q
 ;
UNLAH(LRLL) ; Unlock node in LAH global
 L -^LAH(+$G(LRLL))
 Q
 ;
NOP W !,"Operation not complete"
END K ^TMP("LR",$J,"T"),A,DIC,I,LRFULL,LRDFN,LRDPF,LRFULL,LRIX,LRTSTS,LRTX,LRWPROF,LRWRD,LRINSTIT,LRMAXCUP,LRTRANS,LRTYPE,X,Y,Z,LRINST,%,LRPROF,LRTRAY,LRCUP,LRAA,LRAD
 K AGE,DFN,DOB,K,PNM,SEX,T,D,G,LRAN,LREXEC,LRLLOC,SSN,X9
 Q
PROFILE S DIC(0)="AEQ",DIC="^LRO(68.2,"_LRINST_",10," D ^DIC K DIC Q:Y<1 
 S LRWPROF=+Y
 Q
EN02 ;
REMOVE D LRINST G NOP:LRINST<1
RM D GCUP G END:LRCUP[U D CURRENT,DROP:%=1 W:%=1 !,">> REMOVED <<" G RM
EN03 ;
MOVE D LRINST G NOP:LRINST<1
MOV D GCUP G END:LRCUP[U D LIFT I LRHOLD="" W !,"LOCATION EMPTY" G MOV
 D NOW G IN5
SETONE G SETONE^LRLLS2
WHATEST G WHATEST^LRLLS2
SHOW G SHOW^LRLLS2
WHO G WHO^LRLLS2
CURRENT G CURRENT^LRLLS2
DROP G DROP^LRLLS2
CLRALL D LRINST G CLRALL^LRLLS2
EN04 ;
CLRBYTRY ;CLEAR LOAD LIST BY LRTRAY
 G CLRBYTRY^LRLLS2
