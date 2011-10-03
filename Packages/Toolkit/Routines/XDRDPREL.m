XDRDPREL ;SF-IRMFO.SEA/JLI - PRELIMINARY IDENTIFICATION OF ENTRIES WITH BAD DATA ;9/19/96  09:19
 ;;7.3;TOOLKIT;**23**;Apr 25, 1995
 ;;
 ;;
EN ;
 S XDRFL=+$$FILE^XDRDPICK() G:XDRFL'>0 EXIT S XDRFNAM=$P(^DIC(XDRFL,0),U)
 I $D(^XTMP("XDRDPREL",XDRFL," DONE")) D  Q:XDRFL=0  I 1
 . W !!,"A run was completed on "_$$HTE^XLFDT(^XTMP("XDRDPREL",XDRFL," DONE")),!!
 . S DIR(0)="Y",DIR("A")="Do you want to view those results",DIR("B")="YES" D ^DIR K DIR
 . I Y>0 D
 . . D VIEW(XDRFL)
 . . S XDRFL=0
 E  I $D(^XTMP("XDRDPREL",XDRFL," TIME")) D  Q:XDRFL=0
 . I $$HDIFF^XLFDT($H,^XTMP("XDRDPREL",XDRFL," TIME"),2)>300 Q
 . W !!,"There appears to be a job already running.  You may either"
 . W !,"view those data or check back in about 5 minutes.",!!
 . S DIR(0)="Y",DIR("A")="Do you want to view the running job",DIR("B")="YES" D ^DIR K DIR
 . I Y>0 D VIEW(XDRFL)
 . S XDRFL=0
 S ZTRTN="DQ^XDRDPREL",ZTIO="",ZTSAVE("XDRFL")="",ZTDESC="XDRDPREL - PRELIM SCAN" D ^%ZTLOAD
 I $D(ZTSK) W !!,"Queued as task ",ZTSK,!
 Q
DQ ;
 S XDRGLB=^DIC(XDRFL,0,"GL")_"XDRDA)"
 S XDRDR=""
 F XDRI=0:0 S XDRI=$O(^DD(XDRFL,0,"ID",XDRI)) Q:XDRI'>0  S XDRDR=XDRDR_XDRI_";"
 S XDRTMP="^XTMP(""XDRDPREL"",XDRFL)"
 K @XDRTMP,XDRNV,XDRN S NTOT=0,@XDRTMP@(" TIME")=$H,@XDRTMP@(" START")=$H
 F XDRDA=0:0 S XDRDA=$O(@XDRGLB) Q:XDRDA'>0  D
 . I $D(@XDRGLB@(-9)) Q
 . S @XDRTMP@(" CURR")=XDRDA,^(" TIME")=$H
 . S NTOT=NTOT+1
 . S @XDRTMP@(" TOTAL")=NTOT
 . I '$D(@XDRGLB@(0)) D  Q
 . . S XXX="NO ZERO NODE"
 . . S ^(XXX)=$G(@XDRTMP@(XXX))+1
 . . S @XDRTMP@(XXX,XDRDA)=""
 . I XDRDR'="" D
 . . S DR=XDRDR
 . . S DA=XDRDA,DIC=XDRFL,DIQ(0)="I",DIQ="XDRX" K XDRX
 . . D EN^DIQ1
 . . S N=0
 . . F I=0:0 S I=$O(XDRX(XDRFL,XDRDA,I)) Q:I'>0  D
 . . . I XDRX(XDRFL,XDRDA,I,"I")="" D
 . . . . S N=N+1
 . . . . S XXX="MISSING #"_I
 . . . . S @XDRTMP@(XXX)=$G(@XDRTMP@(XXX))+1
 . . . . S @XDRTMP@(XXX,XDRDA)=""
 . . S XXX=$G(XDRX(XDRFL,XDRDA,$S(XDRFL=2:.09,XDRFL=200:9,1:0),"I"))
 . . I XXX'="" D
 . . . I XXX'?9N.E D
 . . . . S XXX="BAD SSN"
 . . . . S @XDRTMP@(XXX)=$G(@XDRTMP@(XXX))+1
 . . . . S @XDRTMP@(XXX,XDRDA)=""
 . . . . S N=N+1
 . . I N>0 D
 . . . S XXX="MISSING "_N_" VAL"_$S(N>1:"S",1:"")
 . . . S @XDRTMP@(XXX)=$G(@XDRTMP@(XXX))+1
 . . . S @XDRTMP@(XXX,XDRDA)=""
 S @XDRTMP@(" DONE")=$H
 K @XDRTMP@(" TIME")
 Q
VIEW(XDRFL) ;
 N XDRTMP,X,Y,XTIME
 S XDRTMP="^XTMP(""XDRDPREL"",XDRFL)"
 I '$D(@XDRTMP) Q
 L +@XDRTMP
 S X=""
 F  S X=$O(@XDRTMP@(X)) Q:X=""  S X(X)=@XDRTMP@(X)
 L -@XDRTMP
 S XRUN=$$HDIFF^XLFDT($S($D(X(" DONE")):X(" DONE"),1:X(" TIME")),X(" START"),2)
 S XTIME=(XRUN\3600)_":"_$S((XRUN#3600\60)<10:"0",1:"")_(XRUN#3600\60)_":"_$S((XRUN#60)<10:"0",1:"")_(XRUN#60)
 W @IOF
 W !!!,"RUN TIME: ",XTIME,"     CURRENT IEN: ",X(" CURR"),"     FILE ENTRIES: ",X(" TOTAL")
 W !
 S X="" F  S X=$O(X(X)) Q:X=""  I X["#" D
 . S Y=+$P(X,"#",2)
 . W !,$J(X(X),10)," ",XDRFNAM," entries are missing field # ",Y,"  ",$P(^DD(XDRFL,Y,0),U)
 I $D(X("NO ZERO NODE")) W !,$J(X("NO ZERO NODE"),10)," ",XDRFNAM," entries have NO zero node!"
 I $D(X("BAD SSN")) W !,$J(X("BAD SSN"),10)," ",XDRFNAM," entries have bad SSN values (non-numeric, etc.)"
 S X="" W !
 F  S X=$O(X(X)) Q:X=""  I X["VAL" D
 . S Y=+$P(X," ",2)
 . W !,$J(X(X),10)," ",XDRFNAM," entries are missing ",Y," of the fields above"
 W ! K DIR S DIR(0)="E" D ^DIR K DIR
 Q
 ;
EXIT Q
