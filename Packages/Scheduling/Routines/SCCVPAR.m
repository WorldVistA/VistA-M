SCCVPAR ;ALB/TMP - SCHED VISITS CONVERSION PARAMETERS; [ 03/02/98  10:47 AM ]
 ;;5.3;Scheduling;**211**;Aug 13, 1993
 ;
PARAM ; Main entry point - display scheduling conversion parameters
 D EN^VALM("SCCV CONV PARAM MENU")
 D REFRESH^SCCVCDSP
 Q
 ;
INIT ; -- set up initial variables
 D FNL
 S U="^",VALMCNT=0,VALMBG=1
 D BLD
 Q
 ;
HDR ;
 S VALMHDR(1)=""
 Q
 ;
FNL ; Clean up
 K ^TMP("SCCV.PARAM",$J),^TMP("SCCV.PARAM.DX",$J)
 Q
 ;
BLD ;Build parameter display
 N SCCVCNV
 S VALMBG=1
 K ^TMP("SCCV.PARAM",$J)
 S VALMCNT=0
 S SCCVCNV=$G(^SD(404.91,1,"CNV"))
 S VALMCNT=VALMCNT+1
 D SET^VALM10(VALMCNT," ")
 S VALMCNT=VALMCNT+1
 D SET^VALM10(VALMCNT,"Earliest encounter date to be converted: "_$S(+SCCVCNV:$$FMTE^XLFDT(+SCCVCNV,"1D"),1:"<Not Specified>"))
 S VALMCNT=VALMCNT+1
 D SET^VALM10(VALMCNT,"Limit CST date range to 1 year or less?: "_$$EXPAND^SCCVDSP2(404.91,905,+$P(SCCVCNV,U,5)))
 S VALMCNT=VALMCNT+1
 D SET^VALM10(VALMCNT,"             Default Disposition Clinic: "_$$NONE^SCCVDSP2(404.91,902,$P(SCCVCNV,U,2),"<Not Specified>"))
 S VALMCNT=VALMCNT+1
 D SET^VALM10(VALMCNT,"                 Maximum Errors Allowed: "_$$EXPAND^SCCVDSP2(404.91,907,$S($P(SCCVCNV,U,7):$P(SCCVCNV,U,7),1:1000)))
 S VALMCNT=VALMCNT+1
 D SET^VALM10(VALMCNT,"            Display Cancelled Templates: "_$$EXPAND^SCCVDSP2(404.91,909,+$P(SCCVCNV,U,9)))
 S VALMCNT=VALMCNT+1
 D SET^VALM10(VALMCNT," ")
 S VALMCNT=VALMCNT+1
 D SET^VALM10(VALMCNT,"Date Conversion Completed: "_$S('$$COMPL():"* UNEDITABLE - CST entry(s) missing or incomplete *",1:$$FMTE^XLFDT($P(SCCVCNV,U,4),"1D")))
 S VALMCNT=VALMCNT+1
 D SET^VALM10(VALMCNT,"Date Deletion   Completed: "_$S('$$COMPL():"* UNEDITABLE - CST entry(s) missing or incomplete *",1:$$FMTE^XLFDT($P(SCCVCNV,U,3),"1D")))
 Q
 ;
EDIT ; Edit scheduling conversion parameters
 N SCDT1
 S SCDT1=$P($G(^SD(404.91,1,"CNV")),U,4)
 D FULL^VALM1
 S DIE="^SD(404.91,",DA=1,DR="[SCCV CONV EDIT SITE PARAMS]"
 D ^DIE
 I 'SCDT1,$P($G(^SD(404.91,1,"CNV")),U,4) D
 . S DIR(0)="YA",DIR("A")="Do you want to delete the old scheduling files now? ",DIR("B")="NO" D ^DIR K DIR
 . I Y=1 D
 .. D EN^SCCVDEL
 D BLD
 S VALMBCK="R"
 Q
 ;
903(SKIPTO) ;
 N DIR,Y
 ;
 Q:'$P($G(^SD(404.91,1,"CNV")),U,3)!($G(SCCVX(903)))
 ;
 I '$P($G(^SD(404.91,1,"CNV")),U,4) D  G Q903
 .S DIR(0)="EA"
 .S DIR("A",1)="DATE CONVERSION COMPLETED must be entered before you can enter this date",DIR("A")="Press RETURN to continue"
 .D ^DIR K DIR
 .S SKIPTO="@30"
 ;
 S DIR(0)="YA",DIR("B")="NO"
 S DIR("A",1)="Entering this date indicates that your site is finished",DIR("A",2)="deleting any old encounter files that can be deleted.",DIR("A",3)=" ",DIR("A")="Are you sure you want to do this?: "
 D ^DIR K DIR
 I Y'=1 S SKIPTO="@30"
 ;
Q903 Q
 ;
904(SKIPTO) ;
 N DIR,SC0,SCLACT,SCLEVT,SCOK,Y,Z
 ;
 G:'$P($G(^SD(404.91,1,"CNV")),U,4)!($G(SCCVX(904))) Q904
 ;
 ; All CST's must be canceled or completed before date can be entered
 I '$$COMPL() D  S SKIPTO="@20" G Q904
 . W !
 . S DIR(0)="EA"
 .S DIR("A",1)="You must complete or cancel each CST before you may enter this date",DIR("A",2)="At least one CST was found to be missing or incomplete",DIR("A")="Press RETURN to continue "
 . D ^DIR K DIR
 . W !
 ;
 I $$SEQGAP() D  S SKIPTO="@20" G Q904 ; Check for gaps in the dt range
 . N DIR,Y,SCDT1
 . S SCDT1=$P($G(^SD(404.91,1,"CNV")),U)
 . S:SCDT1 SCDT1=$$FMTE^XLFDT(SCDT1,2)
 . W !
 . S DIR(0)="EA"
 . S DIR("A",1)="You have one or more gaps in conversion dates from your earliest date to",DIR("A",2)=" convert ("_$S(SCDT1'="":SCDT1,1:"NOT ENTERED")_") to 9-30-96"
 . S DIR("A",3)="You must finish converting before you can enter the conversion completed date",DIR("A")="Press RETURN to continue "
 . D ^DIR K DIR
 . W !
 ;
 S DIR(0)="YA",DIR("B")="NO"
 S DIR("A",1)="Entering this date prevents you from converting any more data from the old",DIR("A",2)=" Scheduling files to the PCE V-files",DIR("A",3)=" ",DIR("A")="Are you sure you want to do this?: "
 D ^DIR K DIR
 I Y'=1 S SKIPTO="@20"
 ;
Q904 Q
 ;
COMPL(ANY) ; Check if all/any CST's are complete or canceled
 ; Returns 0 if function fails, 1 if function succeeds
 ; ANY = 1: just check for ANY completed
 ;
 N Z,SC0,SCOK,SCLACT,SCLEVT,SCANY
 ;
 I '$G(ANY) S SCOK='$$SEQGAP() G COMPLQ  ;Check all for full range
 ;
 S Z=0,SCANY=0
 F  S Z=$O(^SD(404.98,Z)) Q:'Z  S SC0=$G(^(Z,0)) D  Q:SCANY
 . Q:$P(SC0,U,9)  ; CST canceled
 . S SCLACT=+$$LSTACT^SCCVLOG(Z),SCLEVT=+$$LSTEVT^SCCVLOG(Z)
 . I $S(SCLACT'=5:0,1:"12"[SCLEVT) S SCANY=1 Q  ; Last actn (cnvrt/recnvrt) completed
 ;
COMPLQ Q $S($G(ANY):SCANY,1:SCOK)
 ;
SEQGAP() ; Checks entire date range from start to 9-30-96 has been converted 
 ; Returns 0 if no gap found from earliest date to convert to 09/30/96
 ;         1 if gap found
 N Z,Z0,SC0,SCLACT,SCLEVT,SCGAP,SCDT1,SCDT2
 ;
 S Z=0,SCGAP=0
 F  S Z=$O(^SD(404.98,Z)) Q:'Z  S SC0=$G(^(Z,0)) D
 . Q:$P(SC0,U,9)  ; CST canceled
 . S SCLACT=+$$LSTACT^SCCVLOG(Z),SCLEVT=+$$LSTEVT^SCCVLOG(Z)
 . I $S(SCLACT'=5:0,1:"12"[SCLEVT) D  ; Last actn (cnvrt/recnvrt) completed
 .. S SCGAP(+$$FMTH^XLFDT($P(SC0,U,3),1))=+$$FMTH^XLFDT($P(SC0,U,4),1)
 ;
 S SCDT1=+$$FMTH^XLFDT(+$G(^SD(404.91,1,"CNV"),2801001),1) ; start date
 S SCDT2=+$$FMTH^XLFDT($$ENDDATE^SCCVU(),1)                          ; end date
 S SCGAP=0,Z=SCDT1
 F  S Z0=$G(SCGAP(Z)) D  Q:SCGAP!(Z0=SCDT2)  ;Check ranges for gaps
 . I Z0=SCDT2 Q                              ; No gaps found
 . I Z0="" S SCGAP=1 Q                       ; Gap found...S/B an entry at Z
 . I Z=SCDT1 S Z=Z0+1 Q                      ; First date range
 . S Z=Z0+1
 ;
 Q SCGAP
 ;
