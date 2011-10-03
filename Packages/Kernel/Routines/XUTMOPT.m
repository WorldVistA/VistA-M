XUTMOPT ;SFISC/RWF - One time queue and Schedule option code. ;12/04/2000  11:02
 ;;8.0;KERNEL;**2,111,112,118,127,175**;Jul 10, 1995
ONE ;One time queue setup
 N XUXQM,DIC,DIR,Y,ZTSK,ZTSAVE,ZTCPU
 W !!,"You can only select OPTION's that have the SCHEDULING RECOMMENDED",!,"field set to YES or STARTUP."
 S DIC=19,DIC(0)="AEMQZ",DIC("S")="I $TR($P($G(^DIC(19,Y,200.9)),U,1),""nsy"",""011"")" D ^DIC G:Y'>0 EXIT
 S XUXQM=+Y,XUXQM(0)=Y(0)
 S DIR(0)="Y",DIR("A")="Does this option need a DEVICE",DIR("B")="NO" D ^DIR G:$D(DIRUT) EXIT
OZ S ZTIO=""
 I Y=1 D  G EXIT:POP,OZ:'$D(IO("Q"))
 . W ! S IOP="Q",%ZIS="NQM",%ZIS("B")="" D ^%ZIS Q:POP  K ZTIO
 . I '$D(IO("Q")) U IO(0) W !,"Not a valid device for Queueing." D ^%ZISC
 . Q
 K DIR S DIR(0)="FO^2:15",DIR("A")="Enter Particular Volume set if needed" D ^DIR G EXIT:$D(DTOUT)!$D(DUOUT)
 I X]"" S ZTCPU=X
 S ZTSAVE("XQY")=$O(^DIC(19,"B","XU OPTION START",0)),ZTSAVE("XUXQM*")="",ZTRTN="ZTSK^XQ1"
 S ZTDESC="One time Queue: "_$P(XUXQM(0),U,2)
 D ^%ZTLOAD K IO("Q")
EXIT D HOME^%ZIS
 Q
 ;
EDIT(OPTION) ;User edit of option schedule file.
 N DR,DIE,DA,DIC,DDSFILE
 I OPTION?1A.ANP S OPTION=$$FIND(OPTION) Q:OPTION'>0
 I '$D(^DIC(19.2,OPTION,0)) Q
 S DA=OPTION,DR="[XU OPTION SCHEDULE]",DIE="^DIC(19.2," D XUDIE^XUS5
 Q
 ;
DISP(OPTION) ;Display an option schedule (public entry-point)
 N DR,DIC,DA
 I OPTION?1A.ANP S OPTION=$$FIND(OPTION) Q:OPTION'>0
 S L=0,DIC="^DIC(19.2,",FLDS="[XQ-BACKGROUND SCHEDULE]",BY="NUMBER",(FR,TO)=OPTION,IOP=$G(IOP,0),DHD="Scheduled Option Display"
 D EN1^DIP
 Q
 ;
RESCH(OPTION,WHEN,DEVICE,BY,FLAG,ERR) ;EF. App reschedule entry point
 N DIE,DR,DIC,DA,X
 I OPTION?1A.ANP S OPTION=$$FIND(OPTION,$S($G(FLAG)["L":"L",1:""))
 I OPTION'>0 S ERR=-1
 S DIE="^DIC(19.2,",DA=OPTION,DR="" S:$D(WHEN) DR="2///"_WHEN_";" S:$D(DEVICE) DR=DR_"3///"_DEVICE_";" S:$D(BY) DR=DR_"6///"_BY
 D ^DIE
 ;S X=$NA(XFDA(19.2,OPTION_","))
 ;S:$D(WHEN) @X@(2)=WHEN S:$D(DEVICE) @X@(3)=DEVICE S:$D(BY) @X@(6)=BY
 ;D FILE^DIE("","XFDA")
 Q
 ;
FIND(X,F) ;Find and option
 N DIC,Y,DLAYGO S DLAYGO=19
 ;S X=$O(^DIC(19,"B",X,0)) I X'>0 Q -1
 ;S X=$O(^DIC(19.2,"B",X,0)) I X'>0 Q -1
 S DIC="^DIC(19.2,",DIC(0)="M"_$G(F) D ^DIC S X=+Y
 Q X
 ;
OPTSTAT(OPTION,ROOT) ;Get the status of an option
 ;Return an array because an option can be scheduled more than once
 N XUTMDA,XUTMMSG
 D FIND^DIC(19.2,,,"X",OPTION,5,,,,"XUTMDA","XUTMMSG")
 S XU1=0,ROOT=+$G(XUTMDA("DILIST",0))
 F  S XU1=$O(XUTMDA("DILIST",2,XU1)) Q:XU1'>0  D
 . S XU2=XUTMDA("DILIST",2,XU1),%=^DIC(19.2,XU2,0)
 . S ROOT(XU1)=$G(^DIC(19.2,XU2,1))_U_$P(%,U,2)_U_$P(%,U,6)_U_$P(%,U,9)
 . Q
 Q
