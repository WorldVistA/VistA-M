SD53103B ;ALB/MJK - Unique Visit ID Clean Up ; March 10,1997
 ;;5.3;Scheduling;**103**;AUG 13, 1993
 ;
 Q
 ;
OE(SDOE) ; -- display oe data
 N DIQ,DIC,DR,DA,SDLINE
 S $P(SDLINE,"=",80)=""
 W !,SDLINE,!
 S DIC="^SCE(",DA=SDOE,DIQ(0)="CAR" D EN^DIQ
 W !,SDLINE,!
 Q
 ;
HDR(TEXT) ; -- intro header
 N X
 S X=">>>> Encounter Clean Up Tool for -1 Visit ID's ["_TEXT_"] <<<<"
 S T=(80-$L(X))/2
 W @IOF,!?T,X
 Q
 ;
INIT() ; -- init global locals
 N SDOK
 D HOME^%ZIS
 S SDOK=1,U="^",SDTALK=0
 IF '$G(DT) S DT=$$DT^XLFDT()
 ;
 IF '$G(DUZ) D  G INITQ
 . W !,"DUZ is not defined."
 . S SDOK=0
 ;
 IF '$O(^DIC(9.4,"C","SD",0)) D  G INITQ
 . W !,"No package with 'SD' namespace exists on the system."
 . S SDOK=0
 ELSE  D
 . S SDPKG=$O(^DIC(9.4,"C","SD",0))
 ;
INITQ Q SDOK
 ;
RESULTS(SDMODE,SDBEG,SDEND,SDRT,SDCNT) ; generate an e-mail bulletin when done
 N DIFROM,I,LINE,X
 S SDCOUNT=0
 D LINE("The Unique Visit ID cleanup has run to completion."),LINE("")
 D LINE("    Start Time:         "_$$FMTE^XLFDT(SDBEG))
 D LINE("      End Time:         "_$$FMTE^XLFDT(SDEND))
 D LINE("      Run Mode:         "_$S(SDMODE=1:"Count Only",1:"Fix Entries")),LINE("")
 IF $$S^%ZTLOAD D
 . D LINE(" >>> Task Stopped by user. <<<")
 . D LINE("")
 . S ZTSTOP=1
 ;
 D LINE("Total number of Outpatient Encounter entries "_$S(SDMODE=1:"that will be ",1:"")_"processed: "_SDCNT),LINE(""),LINE("")
 ;
 IF SDMODE=2 D
 . D LINE("Note: Child encounters re-linked as part of parent")
 . D LINE("      re-linking process are not listed below nor")
 . D LINE("      counted in the total above.")
 . D LINE("")
 ;
 ; -- layout of line
 D LINE("Message Format:")
 D LINE(" Piece    Description")
 D LINE(" -----    -----------")
 D LINE("   1      Status of update")
 D LINE("   2      Internal Entry Number of Outpatient Encounter file")
 D LINE("   3      Internal Entry Number of Parent Outpatient Encounter file")
 D LINE("   4      Internal Entry Number of Visit file")
 D LINE("   5      Patient Name")
 D LINE("   6      Encounter Date/Time")
 D LINE("   7      Hospital Location")
 D LINE("")
 ;
 ; --scan tmp records
 F I=0:0 S I=$O(@SDRT@(I)) Q:'I  D
 . D LINE(@SDRT@(I))
 ;
 ; -- set up and fire bulletin
 S XMSUB="Unique Visit ID Cleanup is Complete",XMN=0
 S XMTEXT="^TMP(""SDVISIT MSG"",$J,"
 S XMDUZ=.5,XMY(DUZ)=""
 D ^XMD
 K ^TMP("SDVISIT MSG",$J)
 K SDCOUNT,SDTEXT,XMDUZ,XMN,XMSUB,XMTEXT,XMY,XMZ
 Q
 ;
 ;
LINE(TEXT) ; add text to mail message
 S SDCOUNT=SDCOUNT+1,^TMP("SDVISIT MSG",$J,SDCOUNT)=TEXT
 Q
 ;
RANGE(SDBEG,SDEND) ; -- select range
 N SDWITCH,SDT,X1,X2,X,DIR
 S (SDBEG,SDEND)=0,SDT=2961001
 S DIR("B")=$$FDATE^VALM1(SDT)
 S DIR(0)="DA"_U_SDT_":"_DT_":EXP",DIR("A")="Select Beginning Date: "
 S DIR("?",1)="Enter a date between "_$$FMTE^XLFDT(SDT)_" to "_$$FMTE^XLFDT(DT)_".",DIR("?")=" "
 W ! D ^DIR K DIR G RANGEQ:Y'>0 S SDBEG=Y
 S DIR("B")=$$FDATE^VALM1(DT)
 S DIR(0)="DA"_U_SDBEG_":"_DT_":EXP",DIR("A")="Select    Ending Date: "
 S DIR("?",1)="Enter a date between "_$$FMTE^XLFDT(SDBEG)_" to "_$$FMTE^XLFDT(DT)_".",DIR("?")=" "
 D ^DIR K DIR G RANGEQ:Y'>0 S SDEND=Y_".235959"
RANGEQ Q SDEND
 ;
OK() ; -- ok to continue
 N DIR,Y
 S DIR("A")="Ok to continue"
 S DIR("B")="NO"
 S DIR(0)="Y"
 D ^DIR
 IF Y'=1 S Y=0
 Q Y
 ;
MODE() ; -- select update mode
 N DIR,Y
 S DIR(0)="S"_U_"1:Count Only;2:Fix Entries"
 S DIR("A")="Select update mode"
 S DIR("B")="Count Only"
 D ^DIR
 IF Y'=1,Y'=2 S Y=0
 Q Y
 ;
