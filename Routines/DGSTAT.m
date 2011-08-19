DGSTAT ;ALB/MRL - ADT SYSTEM STATUS DISPLAY ; 03/12/2004
 ;;5.3;Registration;**75,151,568**;Aug 13, 1993
 ;
 ; modified for K8, 12/7/95; mli
 ;
EN ; main entry point
 I $$VERSION^XPDUTL("XU")<8 W !,"You must have KERNEL version 8.0 or higher to run this option!" G Q
 S ^UTILITY("DG",$J,"ST")=""
 S DGUSER=$P($G(^VA(200,+DUZ,.1)),"^",4),DGNOW=$$NOW^XLFDT()
 W @IOF,!,$$GREETING(),$S(DGUSER]"":" "_DGUSER,1:""),".  Welcome to MAS, VERSION ",$$VERSION^XPDUTL("REGISTRATION"),!
 F I=1:1:40 W "= "
 F I=334,345 S X=$O(^DGAM(I,"ALST",0)) I X W !,"AMIS ",I S DGX=$X D L W "Last run for month of ",$$DATE(X,1) ; amis 334,345
 S X=$P($P($G(^DG(43,1,"AMIS")),"^",6),"'",2)
 W !,"AMIS 401-420 Reports" S DGX=$X D L W "Last run for month of ",$$DATE(X,1) ;                              amis 400s
 S X=$G(^DG(43,1,"GLS"))
 W !,"Auto Recalculation" S DGX=$X D L W "Last run ",$$DATE(X,7)," on CPU ",$P(X,"^",8) ;                      auto recalc
 S X=$$SCHED("DG G&L RECALCULATION AUTO")
 W ! D L W "Scheduled for ",$S(X:$$DATE(X,1),1:"(not currently scheduled)")
 I X<DGNOW D
 . N DIQUIET ; uced to silence echo of date in %dt
 . S DIQUIET=1
 . W ! D L W "Rescheduled to run at 9 p.m."
 . D RESCH^XUTMOPT("DG G&L RECALCULATION AUTO",DT_.2100,,,"L")
 W !,"Embosser Option from Registration" S DGX=$X D L W "Is turned ",$$ONOFF(28) ;                             emboss on/off
 W !,"Gains & Losses (G&L)" S DGX=$X D L W "Last run ",$$DATE($G(^DG(43,1,"GLS")),11) ;                        g&l
 W !,"HINQ Option from Registration" S DGX=$X D L W "Is turned ",$$ONOFF(27) ;                                 hinq at reg
 W !,"RUG-II Background Job" S DGX=$X D L W "Last run ",$$DATE($G(^DG(43,1,"RUG")),1) ;                        rug bgj
 S X=$$LAST^DGSDUTL,X=$G(^SDD(409.65,+X,0)) ;                                                                   appt stat upd
 W !,"Appointment Status Update" S DGX=$X D L W "Last run ",$$DATE(X,5)
 W ! D L W "Updated appointments for ",$$DATE(X,1)
 W ! D L W "Scheduled for " S X=$$SCHED("SDAM BACKGROUND JOB") W $S(X:$$UP^XLFSTR($$FMTE^XLFDT(X)),1:"(not currently scheduled)")
 W !,"IRT Background Job" S DGX=$X D L W "Last run ",$$DATE($G(^DG(43,1,"IRT")),1) ;                           irt bgj
 W ! D L W "Scheduled for " S X=$$SCHED("DGJ IRT UPDATE (Background)") W $S(X:$$UP^XLFSTR($$FMTE^XLFDT(X)),1:"(not currently scheduled)")
 I $D(^%ZOSF("UCI")) X ^("UCI") W !!,"YOU ARE PRESENTLY ON CPU ",Y,!
Q W ! I $D(DUZ("AUTO")),DUZ("AUTO") R "Press RETURN to continue:  ",X:DTIME
 K %DT,%H,DA,DGRE,DGUSER,DGVERS,DGX,DIE,DR,I,DGNOW,X,Y Q
 ;
ONOFF(PIECE) ; return ON or OFF
 ;  input - piece of 0 node of file 43 wanted
 ; output - ON or OFF
 ;
 Q $S($P($G(^DG(43,1,0)),"^",PIECE):"ON",1:"OFF")
 ;
DATE(NODE,PIECE) ; return appropriate date
 ;  input - NODE as node of data
 ;          PIECE as piece of node to convert
 ; output - date in external format
 ;
 Q $$UP^XLFSTR($$FMTE^XLFDT($P(NODE,"^",PIECE)))
 ;
SHOW I $S('$D(^DG(43,1,0)):1,'$P(^(0),"^",34):1,$D(^UTILITY("DG",$J,"ST")):1,1:0) Q
 G EN
 ;
L ; write line of dots
 ;
 W ?DGX+1 F I=1:1:(36-(DGX+1)) W "."
 W " "
 Q
 ;
GREETING() ; randomize greeting
 N X,%H
 S X=$P("Hello^Hi There^Good ^Hello There^Hi","^",$R(5)+1)
 I X["Good" S %H=$P($H,",",2),X=X_$S(%H<43200:"Morning",%H<61200:"Afternoon",1:"Evening")
 Q X
 ;
SCHED(OPTION) ; sent back time time for queued process
 ;  input - OPTION as name of option
 ; output - date currently queued (external format)
 N I,IEN,X
 S (I,X)=0,IEN=$$LKOPT^XPDMENU(OPTION)
 F  S I=$O(^DIC(19.2,"B",IEN,I)) Q:'I  S X=$P($G(^DIC(19.2,+I,0)),"^",2) Q:X>$$NOW^XLFDT()
 Q X
