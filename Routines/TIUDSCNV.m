TIUDSCNV ; SLC/JER - Discharge Summary Conversion routine
 ;;1.0;TEXT INTEGRATION UTILITIES;**9**;Jun 20, 1997
MAIN ; Control branching
 N GMRDA,TIUOK,TIUQUEUE,TIURUN,GMRDSTOP
 I +$P($G(^AUPNPAT(0)),U,3)'=+$P($G(^DPT(0)),U,3),'$D(^GMR(128,"CNV","PXPTPOST")) D  Q:+TIUOK'>0
 . N TIUPRMT
 . W !!,"The IHS Patient file appears to be out of synchrony with File #2."
 . W !,"Before continuing, you must run a program to synchronize these files."
 . W !,"It may take a few minutes.",!
 . S TIUPRMT="Would you like me to run that program now"
 . S TIUOK=$$READ^TIUU("Y",TIUPRMT,"NO")
 . I +TIUOK'>0 W !,"Okay, hurry back!" Q
 . I +TIUOK>0 D QUE^PXPTPOST S ^GMR(128,"CNV","PXPTPOST")=1
 W !!?9,"***************************************************************"
 W !?9,"* This option will convert your Discharge Summary version 1.0 *"
 W !?9,"*   Database in preparation for implementation of Discharge   *"
 W !?9,"*           Summary under Text Integration Utilities...       *"
 W !?9,"* Although the process is NOT irreversible, we recommend you  *"
 W !?9,"*  be certain you are prepared to implement before invoking   *"
 W !?9,"*                         this process!                       *"
 W !?9,"***************************************************************",!
 S TIUOK=$$READ^TIUU("Y","         ... Are you sure","NO")
 I +TIUOK'>0 W !!?9,$C(7),"Very well, no damage done!" Q
 I +$G(^GMR(128,"CNV","T0")),'+$G(^GMR(128,"CNV","T1")) D  Q:+$G(TIURUN)
 . W !!,"The DISCHARGE SUMMARY CONVERSION is either still running in another partition,"
 . W !,"or it has been interrupted...",!
 . S TIURUN=+$$RUNNING
 . I +TIURUN W !!,$C(7),"CONVERSION STILL RUNNING IN ANOTHER PARTITION."
 . E  W !!,"No other instance of the conversion could be detected...You're free to RESTART."
 I +$P($G(^TIU(8925.97,1,0)),U,2),'+$P($G(^TIU(8925.97,1,0)),U,3) D  Q:+$G(TIURUN)
 . W !!,"The PROGRESS NOTES CONVERSION is either still running in another partition,"
 . W !,"or it has been interrupted...",!
 . S TIURUN=+$$PNRUN
 . I +TIURUN W !!,$C(7),"PROGRESS NOTES CONVERSION STILL RUNNING IN ANOTHER PARTITION."
 . E  W !!,"PN CONVERSION is NOT currently running...You're free to begin."
 S GMRDA=+$G(^GMR(128,"CNV","CHKPNT"))
 S GMRDSTOP=+$G(^GMR(128,"CNV","STOP #"))
 I GMRDSTOP'>0 D
 . S GMRDSTOP=+$P($G(^GMR(128,0)),U,3),^GMR(128,"CNV","STOP #")=GMRDSTOP
 I +GMRDSTOP'>0 W !!,$C(7),"NO DISCHARGE SUMMARIES TO CONVERT...Bye!",! Q
 I +GMRDA>0 D
 . W !!,"CONVERSION HAS ALREADY BEEN RUN..."
 . W !,"Checkpoint is Record #",GMRDA
 . I +GMRDSTOP'=+$P($G(^GMR(128,0)),U,3) D
 . . S GMRDSTOP=+$P(^GMR(128,0),U,3)
 . . S ^GMR(128,"CNV","STOP #")=GMRDSTOP
 . W !,"Conversion will stop after record #",GMRDSTOP
 . S TIUOK=$$READ^TIUU("Y","  Do You Wish to Continue","NO")
 I +TIUOK'>0 W !!?5,"Very well, no damage done!" Q
 S TIUQUEUE=$$READ^TIUU("Y","Would you like to QUEUE this Process","NO")
 I +TIUQUEUE'>0 D  Q
 . W !!?9,$C(7),"Discharge Summary Conversion Running in Foreground"
 . D ENQ
 D QUEUE
 Q
QUEUE ; Call Task Manager to process conversion
 N %,ZTDTH,ZTDESC,ZTIO,ZTSAVE,ZTSK,ZTRTN
 S ZTRTN="ENQ^TIUDSCNV"
 S ZTSAVE("GMRDA")="",ZTSAVE("DUZ(")="",ZTSAVE("GMRDSTOP")=""
 S:'$D(ZTDESC) ZTDESC="TIU DISCHARGE SUMMARY CONVERSION" S ZTIO=""
 D ^%ZTLOAD W !,$S($D(ZTSK):"Request Queued!",1:"Request Cancelled!")
 D ^%ZISC
 Q
ENQ ; Where the work happens
 N GMRDCNT,GMRDTOTL
 S:+$G(GMRDA)'>0 GMRDA=+$G(^GMR(128,"CNV","CHKPNT"))
 S GMRDCNT=+$G(^GMR(128,"CNV","CNT"))
 S GMRDTOTL=+$P($G(^GMR(128,0)),U,3)
 ; --- Get records from file #128 ---
 S:'$D(^GMR(128,"CNV","T0")) ^GMR(128,"CNV","T0")=$$NOW^TIULC
 I '$D(ZTQUEUED) D PROGBAR
 F  S GMRDA=$O(^GMR(128,GMRDA)) Q:(+GMRDA'>0)!(+GMRDA>+GMRDSTOP)!+$G(ZTSTOP)  D
 . D CONVERT(GMRDA) S GMRDCNT=+$G(GMRDCNT)+1
 . I '$D(ZTQUEUED) D PROGRESS(GMRDCNT,GMRDTOTL)
 . S ^GMR(128,"CNV","CNT")=GMRDCNT
 . I $$S^%ZTLOAD S ZTSTOP=1
 Q:+$G(ZTSTOP)
 S ^GMR(128,"CNV","CNT")=GMRDCNT
 S ^GMR(128,"CNV","T1")=$$NOW^TIULC
 D BULLETIN ; Send Conversion Bulletin
 Q
BULLETIN ; Send Bulletins on completion
 N TIUCNVCT,TIUMISCT,TIUADMCT,TIUFAIL,TIUBDT,TIUEDT,XMY,XMB,XMDUZ
 S TIUCNVCT=+$G(^GMR(128,"CNV","SUCCEED"))
 S TIUMISCT=+$G(^GMR(128,"CNV","FAIL",0))
 S TIUADMCT=+$P($G(^GMR(128,"CNV","FAIL",0)),U,2)
 S TIUFAIL=+$G(TIUMISCT)+$G(TIUADMCT)
 S TIUBDT=$$DATE^TIULS(+$G(^GMR(128,"CNV","T0")),"MM/DD/YY HR:MIN")
 S TIUEDT=$$DATE^TIULS(+$G(^GMR(128,"CNV","T1")),"MM/DD/YY HR:MIN")
 S XMY(+$G(DUZ))=""
 S XMB="TIU DS CONVERSION "_$S(+TIUFAIL>0:"ERRORS",1:"CLEAN")
 S XMDUZ="TIU DISCHARGE SUMMARY CONVERSION"
 S XMB(1)=TIUBDT,XMB(2)=TIUEDT,XMB(3)=TIUCNVCT
 I +TIUFAIL>0 S XMB(4)=TIUFAIL,XMB(5)=TIUMISCT,XMB(6)=TIUADMCT
 D ^XMB,KILL^XM
 Q
PROGBAR ; Write a Progress Bar
 K LAST
 ; I '$D(IOINORM) S X="IOINORM;IORVON;IORVOFF" D ENDR^%ZISS
 W !!,$$CENTER^TIULS("Discharge Summary Conversion in Progress...")
 W !,$$CENTER^TIULS("Percent Complete")
 W !,$$CENTER^TIULS("0    10   20   30   40   50   60   70   80   90   100")
 W !?12,"|"
 Q
PROGRESS(COUNT,TOTAL) ; Indicate Progress
 N PCT,INCR,BAR S PCT=(COUNT/TOTAL)*100
 S INCR=PCT\2
 I +$G(LAST)'=$J(INCR,0,0) D
 . S $P(BAR,"|",(INCR-+$G(LAST))+1)=""
 . W BAR S LAST=$J(INCR,0,0)
 I COUNT=TOTAL W "|",!!?20,"DISCHARGE SUMMARY CONVERSION COMPLETE!"
 Q
CONVERT(GMRDA,TIUSNGL) ; "Turn or burn!"
 N GMRD0,GMRDACT,DOCTYP,DFN,GMRDADT,GMRDLDT,TNEW,TIU,TIUTYP,TIUDA,TIUDAD
 S GMRD0=$G(^GMR(128,+GMRDA,0)),GMRDACT=$G(^GMR(128,+GMRDA,"ACT"))
 I GMRD0']"" D  Q
 . N TIUCRCT
 . S ^GMR(128,"CNV","FAIL",GMRDA)="MISSING INFORMATION"
 . S TIUCRCT=+$G(^GMR(128,"CNV","FAIL",0))+1
 . S $P(^GMR(128,"CNV","FAIL",0),U)=TIUCRCT
 D ALERTDEL^GMRDALRT(GMRDA)
 S DOCTYP=$S(+$P(GMRD0,U,6):"ADDENDUM",1:"DISCHARGE SUMMARY")
 S TIUTYP(1)=1_U_+$$WHATITLE^TIUPUTU(DOCTYP)_U_DOCTYP
 S DFN=+$P(GMRD0,U,2),GMRDADT=$P(GMRD0,U,7)
 S GMRDLDT=$S($L(GMRDADT,".")=2:$$FMADD^XLFDT(GMRDADT,"","","",1),1:$$FMADD^XLFDT(GMRDADT,1))
 D MAIN^TIUMOVE(.TIU,.DFN,"",GMRDADT,GMRDLDT,1,"LAST",0)
 I +$G(TIU("AD#"))'>0 D  Q
 . N TIUNOVCT
 . S ^GMR(128,"CNV","FAIL",GMRDA)="NO ADMISSION FOUND"
 . S TIUNOVCT=+$P($G(^GMR(128,"CNV","FAIL",0)),U,2)+1
 . S $P(^GMR(128,"CNV","FAIL",0),U,2)=TIUNOVCT
 I DOCTYP="DISCHARGE SUMMARY" D
 . S TIUDA=$$GETREC^TIUEDI1(DFN,.TIU,1,.TNEW)
 . I +$G(TIU("VSTR")) D POST^TIUPXAP1(.TIU,DFN,TIUDA)
 . D STUFREC^TIUDSCN1(TIUDA,"",GMRD0,GMRDACT)
 I DOCTYP="ADDENDUM" D
 . S TIUDA=$$MAKEADD^TIUPUTU
 . I +$G(TIU("VSTR")) D POST^TIUPXAP1(.TIU,DFN,TIUDA)
 . S TIUDAD=$$FINDAD(DFN,.TIU,+$P(TIUTYP(1),U,2))
 . I +TIUDAD'>0 D DELETE^TIUDSCN1(TIUDA),ADDFAIL^TIUDSCN1(GMRDA) Q
 . D STUFREC^TIUDSCN1(TIUDA,TIUDAD,GMRD0,GMRDACT)
 D SEND^TIUALRT(TIUDA)
 D AUDIT^TIUEDI1(TIUDA,0,$$CHKSUM^TIULC("^TIU(8925,"_+TIUDA_",""TEXT"")"))
 S:'+$G(TIUSNGL) ^GMR(128,"CNV","CHKPNT")=GMRDA_U_TIUDA
 S ^GMR(128,"CNV","SUCCEED")=+$G(^GMR(128,"CNV","SUCCEED"))+1
 S ^GMR(128,"CNV","SUCCEED",GMRDA)=TIUDA
 Q
RUNNING() ; Evaluate whether conversion is running in another partition
 N TIUCKP0,TIUCKP1,TIUI,TIUY
 W !,"Attempting to determine whether conversion has crashed,"
 W !,"or is still running in another partition..."
 S TIUCKP0=+$G(^GMR(128,"CNV","CHKPNT")),TIUY=0
 F TIUI=1:1:1000 D  Q:+TIUY
 . W:'(TIUI#10) "."
 . S TIUCKP1=+$G(^GMR(128,"CNV","CHKPNT"))
 . I TIUCKP1'=TIUCKP0 S TIUY=1
 Q +$G(TIUY)
PNRUN() ; Evaluate whether PN conversion is running in another partition
 N TIUCKP0,TIUCKP1,TIUI,TIUY
 W !,"Attempting to determine whether PN conversion has crashed,"
 W !,"or is still running in another partition..."
 S TIUCKP0=+$P($G(^TIU(8925.97,1,0)),U,5),TIUY=0
 F TIUI=1:1:1000 D  Q:+TIUY
 . W:'(TIUI#10) "."
 . S TIUCKP1=+$P($G(^TIU(8925.97,1,0)),U,5)
 . I TIUCKP1'=TIUCKP0 S TIUY=1
 Q +$G(TIUY)
FINDAD(DFN,TIU,TIUTYPE) ; Find original record for an addendum
 N TIUY
 S TIUY=+$O(^TIU(8925,"AV",DFN,1,+$G(TIU("VISIT")),0))
 I +TIUY'>0 S TIUY=+$O(^TIU(8925,"APTLD",DFN,1,$G(TIU("VSTR")),0))
 Q TIUY
