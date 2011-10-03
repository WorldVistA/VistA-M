LRCAPAMP ;DALISC/FHS - PURGE AND RE RUN LMIP PHASE 1
 ;;5.2;LAB SERVICE;**82,163,201**;Sep 27, 1994
EN ;
 L ^LRO(67.9):1 I '$T W !,$C(7),"Someone else is editing this file",! G END
 S LRPRI=+$P($G(^XMB(1,1,"XUS")),U,17) I LRPRI,$L($G(^DIC(4,LRPRI,0)),U) S LRPRIN=$P(^(0),U)
 I '$L($G(LRPRIN)) W !!?5,"Your Site is not defined in ^XMB(1,1,XUS) 17th Piece",!!,$C(7),!,"Process aborted ",! G END
 F I=1:1 S TXT=$P($T(MSG+I),";",3) Q:TXT="END"  W !?5,TXT
DIV K TXT,DIC S DIC("A")="Select Division to re-run: "
 S DIC="^LRO(67.9,"_LRPRI_",1,",DIC(0)="AEQZNM" D ^DIC
 G:Y<1 END S LRDIV=+Y
MONTH ;
 S DIC=DIC_LRDIV_",1,",DIC("A")="Select Month to re-run: "
 D ^DIC G:Y<1 END S LRMTH=Y
 K DIR W !!?10,"Are you Sure you wish to delete [ "_$$FMTE^XLFDT($P(LRMTH,U,2),"1D")_" ] Data ",!!
 S DIR(0)="Y" D ^DIR,STDRD G END:$G(LREND)!(Y'=1)
DEL ;
 K DA,DR,DIE S DIE=DIC,DA=+LRMTH,DR=".01///@",DA(1)=LRDIV,DA(2)=LRPRI,DA(3)=67.9
 W !!?10,"Purging ^LAH( Global ",! K ^LAH("LABWL")
 W !!?5,"Deleting Data from ^LRO(67.9 ",!
 D ^DIE W !!?10,"Data Purged",!!
LRO ;
 W !!?10,"Resetting counted node in ^LRO(64.1 file ",!
 S LRSPDT=$E($P(LRMTH,U,2),1,5),LRPDT=LRSPDT_"00"
 F  S LRPDT=$O(^LRO(64.1,LRDIV,1,LRPDT)) Q:LRPDT<1!($E(LRPDT,1,5)'=LRSPDT)  D
 . W "." S LRCC=0 F  S LRCC=$O(^LRO(64.1,LRDIV,1,LRPDT,1,LRCC)) Q:LRCC<1  D
 . . S LRCT=0 F  S LRCT=$O(^LRO(64.1,LRDIV,1,LRPDT,1,LRCC,1,LRCT)) Q:LRCT'>0  I $D(^(LRCT,0))#2 S $P(^(0),U,20)=0
 W !!?10,"FINISHED ",!!,$C(7)
END ;
 L -^LRO(67.9)
 W:$E(IOST)="P" @IOF D ^%ZISC
 K DA,DIC,DIE,DIR,DTOUT,DUOUT,LRCC,LRCT,LRDIV,LREND,LRMTH,LRPDT,LRPRI
 K LRPRIN,LRSPDT
 Q
STDRD ;
 S LREND=0 S:$D(DTOUT)!($D(DUOUT))!($D(DIRUT)) LREND=1
 Q
MSG ;;
 ;;Note:  If you Recompile any division's monthly LMIP data you must
 ;;recompile all divisions. Sites that are multi-divisional should ensure
 ;;that each division is recompiled and scanned again using Phase I
 ;;and Phase 2 options.
 ;;  The ^LAH("LABWL") global used to build the Austin NDB LMIP message
 ;;will be deleted, therefore all previously compiled LMIP data will
 ;;be lost.
 ;;                      ***** CAUTION *****
 ;; CONTACT IRM SERVICE TO ENSURE JOURNAL SPACE IS AVAILABLE BEFORE
 ;;USING THIS OPTION. IF JOURNAL SPACE IS EXHAUSTED DURING THE 
 ;;RECOMPILING PROCEDURE, YOUR COMPUTER SYSTEM MAY STOP
 ;;                  ALL DATA PROCESSING.
 ;;
 ;;
 ;;END
