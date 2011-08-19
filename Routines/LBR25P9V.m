LBR25P9V ;ALB/MRY - Patch #9 Old 440 vendor conversion ;[08/30/02 14:38 pm ]
 ;;2.5;Library;**9**.Mar 11,  1996
 ;
 ; This routine will assist sites in converting their pre CoreFLS
 ; vendor names over to the new CoreFLS vendor fields.  Its purpose
 ; is to pull a list of old vendor names from the free text vendor 
 ; (440) file, allow the user to assign a CoreFLS equivalient from
 ; local (CoreFLS) vendor (392.31) file.  Once the temporary file 
 ; is built, populating the entries will place the values in the CoreFLS
 ; fields.  Review the documentation found in patch LBR*2.5*9.  The
 ; temporary file is only retained for 90 days.  All tasks are intended
 ; to be completed within the 90 day timeframe.
 ;
 N LBRSTOP D INTRO I $G(LBRSTOP) Q
 ;
TOP S OPT=$$ASK
 I OPT="P" S %=$$PULL
 I OPT="A" S %=$$ASSOC
 I OPT="C" S %=$$POP
 I OPT="L" S %=$$LIST
 I OPT="Q" G TOP
 G END
ASK() ;
 N DIR,Y,DIRUT
 S DIR(0)="SOM^P:PULL LIST OF OLD LIBRARY (440) VENDORS;L:DISPLAY PULL LIST;A:ASSOCIATE OLD LIBRARY (440) VENDORS TO COREFLS VENDORS;C:POPULATE COREFLS VENDOR FIELDS;Q:QUIT"
 S DIR("?",1)="  Enter 'P' to generate a list of 440 vendors entered in the Library files."
 S DIR("?",2)="  Enter 'L' to Display Pull List."
 S DIR("?",3)="  Enter 'A' to associate a 440 Vendor name to a CoreFLS Vendor name."
 S DIR("?",4)="  Enter 'C' to populate to CoreFLS Vendor fields."
 S DIR("?",5)="  Enter 'Q' to quit."
 D ^DIR K DIR I $D(DIRUT)!'$D(Y) Q -1
 Q Y
 ;
INTRO ;
 N X
 S X="CSLVQ" X ^%ZOSF("TEST") I '$T D  S LBRSTOP=1 Q
 . W !,"** COMMUNICATIONS SERVICE LIBRARY (CSL) PACKAGE NOT INSTALLED **"
 Q
 ;
PULL() ;
 N LBRIEN,X
 I $D(^XTMP("LBR25P9")) W !!,"^XTMP('LBR25P9') already pulled!" Q 1
 S ^XTMP("LBR25P9",0)=$$FMADD^XLFDT(DT,90)_"^"_DT
 W !!,"Looking through ^LBRY(680)..."
 S LBRIEN=0 F  S LBRIEN=$O(^LBRY(680,LBRIEN)) Q:'LBRIEN  D
 . S X=$P($G(^LBRY(680,LBRIEN,2)),"^",5)
 . I X'="" S ^XTMP("LBR25P9",1,X)="",^(X,680,LBRIEN)=""
 W !,"Looking through ^LBRY(681)..."
 S LBRIEN=0 F  S LBRIEN=$O(^LBRY(681,LBRIEN)) Q:'LBRIEN  D
 . S X=$P($G(^LBRY(681,LBRIEN,1)),"^",5)
 . I X'="" S ^XTMP("LBR25P9",1,X)="",^(X,681,LBRIEN)=""
 Q 1
 ;
ASSOC() ;
 N LBR440,DTOUT,DUOUT,ANS,LBRNEW,DIC,X
 I '$D(^XTMP("LBR25P9")) W !!,"Pull List not created!" Q 1
 S LBR440=0 F  S LBR440=$O(^XTMP("LBR25P9",1,LBR440)) Q:LBR440=""  D AS1 Q:$D(DTOUT)!$D(DUOUT)!(ANS=-1)
 Q 1
AS1 W !!,"OLD VENDOR (440) NAME: ",LBR440
 S (LBRNEW,ANS)=0 I ^XTMP("LBR25P9",1,LBR440)="" D  Q:$D(DTOUT)!($D(DUOUT))
 . S DIC="^DGBT(392.31,",DIC(0)="QEAMZ"
 . D ^DIC Q:$D(DTOUT)!$D(DUOUT)!(Y=-1)
 . S ^XTMP("LBR25P9",1,LBR440)=Y(0,0)_"^"_+Y,LBRNEW=1
 S X=^XTMP("LBR25P9",1,LBR440)
 W:LBRNEW !,"OLD VENDOR (440) NAME: ",LBR440
 W !,"NEW COREFLS VENDOR NAME: ",$P(X,"^")
 I X'="" S ANS=$$ACCEPT Q:ANS=-1  I 'ANS S ^XTMP("LBR25P9",1,LBR440)="" G AS1
 Q
ACCEPT() ;
 N DIR,ACCEPT,Y,DTOUT,DUOUT
 S DIR(0)="SB^A:ACCEPT;R:REMOVE",DIR("A")="ACCEPT, OR REMOVE?",DIR("B")="A"
 D ^DIR S ACCEPT=$S(Y="A":1,$D(DUOUT)!($D(DTOUT)):-1,1:0)
 Q ACCEPT
 ;
POP() ;
 I '$D(^XTMP("LBR25P9")) W !!,"Pull List not created!" Q
 W !!,"Adding CoreFLS Vendor names to ^LBRY(680), and ^LBRY(681)..."
 S LBR440=0
 F  S LBR440=$O(^XTMP("LBR25P9",1,LBR440)) Q:LBR440=""  S X=^XTMP("LBR25P9",1,LBR440) I X'="" D
 . S FLSNAM=$P(X,"^"),FLSIEN=$P(X,"^",2)
 . I $P($G(^DGBT(392.31,FLSIEN,0)),"^")'=FLSNAM Q
 . S LBRFILE="" F  S LBRFILE=$O(^XTMP("LBR25P9",1,LBR440,LBRFILE)) Q:'LBRFILE  D
 . . S LBRIEN="" F  S LBRIEN=$O(^XTMP("LBR25P9",1,LBR440,LBRFILE,LBRIEN)) Q:'LBRIEN  D
 . . . S LBRIENS=LBRIEN_"," K FDATA
 . . . I LBRFILE=680 S FDATA(680,LBRIENS,2.6)=FLSIEN
 . . . I LBRFILE=681 S FDATA(681,LBRIENS,3.01)=FLSIEN
 . . . I $D(FDATA) D FILE^DIE("","FDATA","ERROR")
 Q 1
 ;
LIST() ;
 I '$D(^XTMP("LBR25P9")) W !!,"Pull List not created!" Q 1
 N %ZIS,ZTRN,ZTDESC
 S %ZIS="QM" D ^%ZIS G:POP END
 I $D(IO("Q")) S ZTRTN="PRINT^LBR25P9V",ZTDESC="LBR25P9V VENDOR LIST" D ^%ZTLOAD
 K ZTSK,IO("Q") D HOME^%ZIS
 U IO
 ;
PRINT ;
 N PAG,HDR,HDR1,HDR2,LBR440,FLSDATA,FLSNAM,DIRUT
 S PAG=0,HDR="OLD VENDORS (440) AND CORRESPONDING CoreFLS VENDORS LIST"
 S HDR1="OLD VENDOR NAME",HDR2="NEW CoreFLS VENDOR NAME"
 S LBR440="" F  S LBR440=$O(^XTMP("LBR25P9",1,LBR440)) Q:LBR440=""  D  Q:$D(DIRUT)
 . S FLSNAM=$P(^XTMP("LBR25P9",1,LBR440),"^")
 . D PLINE
 Q 1
 ;
PLINE ;
 I PAG=0 D HDR
 W !,$E(LBR440,1,35),?40,$E(FLSNAM,1,35)
 D CHKL Q
 ;
HDR ;
 W:$E(IOST,1,2)["C-"!(PAG>0) @IOF S PAG=PAG+1
 W !,?(IOM-$L(HDR)/2),HDR,?(IOM-10),"PAGE ",PAG
 W !!,HDR1,?40,HDR2
 W !,$TR($J("",IOM)," ","-")
 Q
 ;
CHKL ;
 I IOSL<($Y+5),$E(IOST,1,2)="C-" D PAUSE^VALM1 Q:$D(DIRUT)  W @IOF D HDR Q
 I $E(IOST,1,2)'="C",IOSL<($Y+5) D HDR
 Q
 ;
END ;
 I $D(ZTQUEUED) S ZTREQ="@" Q
 D ^%ZISC Q
 Q
