PXEDIP ;ISL/PKR - Routines to print PCE device interface errors. ;6/7/96
 ;;1.0;PCE PATIENT CARE ENCOUNTER;;Aug 12, 1996
 ;
 ;=======================================================================
PR ;Print the report.
 N DONE,INDENT,PAGE,PATDFN,POP,PXRROPT,TYPE
 ;
 ;Allow the task to be cleaned up upon successful completion.
 I $D(ZTSK) S ZTREQ="@"
 ;
 U IO
 D GENHEAD
 ;Write out the specific information.
 S DONE=0
 S INDENT=5
 I OPT="EDT" D EDT
 I OPT="ERN" D ERN
 I OPT="PAT" D PAT
 I OPT="PDT" D PDT
 Q
 ;
 ;=======================================================================
EDT ;Print the errors based on encounter date and time.
 S PATDFN=0
 S TYPE="EDT"
 W !!,"Report based on Encounter Date and Time:"
 W !,?INDENT,$$FMTE^XLFDT(BENDT,1)," through ",$$FMTE^XLFDT(EENDT,1),"."
 D ERRLST^PXEDIEL
 Q
 ;
 ;=======================================================================
ERN ;Print the errors based on error number.
 S PATDFN=0
 S TYPE="ERN"
 W !!,"Report based on Error Numbers ",BERN," through ",EERN,"."
 D ERRLST^PXEDIEL
 Q
 ;
 ;=======================================================================
PAT ;Print the errors based on patients.
 N IC
 S TYPE="PAT"
 W !!,"Report based on errors by patient."
 F IC=1:1:NPATIENT D
 . S (DFN,PATDFN)=PATIENT(IC)
 . D DEM^VADPT
 . W !,"Errors for patient ",VADM(1),"  ",$P(VADM(2),U,2)
 . D ERRLST^PXEDIEL
 . D KVA^VADPT
 Q
 ;
 ;=======================================================================
PDT ;Print the errors based on error date and time.
 S PATDFN=0
 S TYPE="PDT"
 D GENHEAD
 W !!,"Report based on Processing Date and Time:"
 W !,?INDENT,$$FMTE^XLFDT(BERDT,1)," through ",$$FMTE^XLFDT(EERDT,1),"."
 D ERRLST^PXEDIEL
 Q
 ;
 ;=======================================================================
GENHEAD ;Print the general report heading.
 S PAGE=0
 D PAGE
 Q
 ;
 ;=======================================================================
PAGE ;form feed to new page
 I (PAGE>0)&(($E(IOST)="C")&(IO=IO(0))) D
 . S DIR(0)="E"
 . W !
 . D ^DIR K DIR
 I $D(DUOUT)!($D(DTOUT)) D  Q
 . S DONE=1
 I PAGE>0 W:$D(IOF) @IOF
 S PAGE=PAGE+1
 D HDR^PXRRGPRT(PAGE)
 Q
 ;
