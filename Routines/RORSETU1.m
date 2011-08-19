RORSETU1 ;HCIOFO/SG - SETUP UTILITIES (USER INTERFACE) ; 6/10/03 8:28am
 ;;1.5;CLINICAL CASE REGISTRIES;;Feb 17, 2006
 ;
 Q
 ;
 ;***** REQUESTS SETUP PARAMETERS FROM THE USER
 ;
 ; .MAXNTSK      Maximum number of registry update subtasks is
 ;               returned via this parameter
 ;
 ; .SUSPEND      Start and end times of registry setup suspension
 ;               are returned via this parameter
 ;
 ; Return Values:
 ;       <0  Error code
 ;        0  Ok
 ;
ASKPARMS(MAXNTSK,SUSPEND) ;
 N DA,DIR,DIROUT,DIRUT,DTOUT,DUOUT,RC,X,Y
 S MAXNTSK=0,SUSPEND=""
 ;---
 K DIR  S DIR(0)="N^0:10:0",DIR("B")=5
 S DIR("A")="Maximum number of registry update subtasks"
 D BLD^DIALOG(7980000.009,,,"DIR(""?"")","S")
 D ^DIR
 Q:$D(DUOUT) -71  Q:$D(DTOUT) -72
 S MAXNTSK=Y
 ;---
 K DIR  S DIR(0)="Y",DIR("B")="NO"
 S DIR("A")="Suspend the post-install during the peak hours"
 D BLD^DIALOG(7980000.01,,,"DIR(""?"")","S")
 D ^DIR
 Q:$D(DUOUT) -71  Q:$D(DTOUT) -72
 ;---
 S RC=0
 F  Q:'$G(Y)  D  Q:RC<0
 . K DIR  S DIR(0)="D^::R",DIR("B")="7:00AM"
 . S DIR("A")="Suspension start time"
 . D BLD^DIALOG(7980000.011,,,"DIR(""?"")","S")
 . D ^DIR
 . I $D(DUOUT)  S RC=-71  Q
 . I $D(DTOUT)  S RC=-72  Q
 . S $P(SUSPEND,U,1)=Y#1
 . ;---
 . K DIR  S DIR(0)="D^::R",DIR("B")="6:00PM"
 . S DIR("A")="Suspension end time"
 . D BLD^DIALOG(7980000.012,,,"DIR(""?"")","S")
 . D ^DIR
 . I $D(DUOUT)  S RC=-71  Q
 . I $D(DTOUT)  S RC=-72  Q
 . S $P(SUSPEND,U,2)=Y#1
 . ;---
 . I $P(SUSPEND,U,2)>$P(SUSPEND,U,1)  S Y=0  Q
 . W " ??",!!,"The end time must be later than the start time.",!
 ;---
 D:'RC CONFTXT(MAXNTSK,SUSPEND)
 ;---
 Q RC
 ;
 ;***** GENERATES THE TEXT OF CONFIRMATION REQUEST
 ;
 ; MAXNTSK       Maximum number of registry update subtasks
 ; SUSPEND       Task suspension parameters
 ;
CONFTXT(MAXNTSK,SUSPEND) ;
 N TMP
 W !
 W !,"  ============================================="
 S TMP=$S(MAXNTSK>0:MAXNTSK,1:1)
 W !,"  Number of registry update (sub)tasks... "_TMP
 S TMP=$S(SUSPEND:"Yes",1:"No")
 W !,"  Suspend the tasks during peak hours.... "_TMP
 D:SUSPEND
 . S TMP=$P($$FMTE^XLFDT(DT+$P(SUSPEND,U,1),"F"),"@",2)
 . W !,"  Suspend the tasks at................... "_TMP
 . S TMP=$P($$FMTE^XLFDT(DT+$P(SUSPEND,U,2),"F"),"@",2)
 . W !,"  Resume the tasks at.................... "_TMP
 W !,"  ============================================="
 W !
 Q
 ;
 ;***** ASKS FOR CONFIRMATION IF THERE ARE NO SEARCH INDICATORS
 ;
 ; LSNAME        Name of the Lab Search
 ;
 ; Return Values:
 ;       <0  Error code
 ;        0  Exit the registry setup
 ;       >1  Continue the setup
 ;
LSCONF(LSNAME) ;
 N DA,DIR,DIROUT,DIRUT,DTOUT,DUOUT,RC,X,Y
 S DIR(0)="Y",DIR("B")="NO"
 S DIR("A")="Continue the registry setup"
 S DIR("A",1)=""
 S DIR("A",2)="The '"_LSNAME_"' Lab Search contains no active search indicators."
 D ^DIR
 Q $S($D(DUOUT):-71,$D(DTOUT):-72,1:+Y)
