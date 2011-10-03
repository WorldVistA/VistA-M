SDPCE2 ;MJK/ALB - Process PCE - Bulletin ;01 APR 1993
 ;;5.3;Scheduling;**27**;08/13/93
 ;
 ; **** See SDPCE0 for variable definitions ****
 ;
BULL(DFN,SDT,SDCL,SDEVENT,SDERR,SDVSIT,SDACT) ;
 ; input:
 ;    o Required Variables:
 ;           DFN := ifn of patient
 ;           SDT := visit date [internal date format]
 ;          SDCL := ifn of clinic
 ;     SDEVENT() := event info array
 ;       SDERR() := error info array
 ;         SDACT := activity [free text]
 ;      SDVSIT() := visit info array
 ;
 ;
 N SDBUL,XMDUZ,XMSUB,XMTEXT,SDLN,VA,SDTYPE,SDMSG,SDATA,STATUS
 ;
 ; -- check status... if cancelled or no-show quit
 S SDATA=$G(^DPT(DFN,"S",SDT,0))
 S STATUS=+$$STATUS^SDAM1(DFN,SDT,SDCL,SDATA,$G(SDDA))
 IF "^4^5^6^7^9^10^"[U_STATUS_U G BULLQ
 ;
 ; -- should message be sent
 S SDMSG=$$MSG() IF SDMSG="" G BULLQ
 ;
 ; -- if no notifications to process then quit
 IF '$D(SDERR("ERROR")),'$D(SDERR("WARNING")) G BULLQ
 ;
 ; -- if (no 'errors' to process) and ('warnings' are NOT to be processed) then quit
 IF '$D(SDERR("ERROR")),SDMSG'["WARNING" G BULLQ
 ;
 ; use site specified mg and bull is only sent if mg defined
 D XMY^SDUTL2(+$P($G(^DG(43,1,"SCLR")),U,26),0,0) G BULLQ:'$D(XMY)
 S XMSUB="Scheduling API Error/Warning",XMTEXT="SDBUL("
 D SET("The following background error has occurred:")
 D SET("")
 D SET("                 Activity: "_SDACT)
 D SET("       Visit File Entry #: "_SDVSIT)
 D SET("               Visit Date: "_$$FTIME^VALM1(SDT))
 D SET("                   Clinic: "_$P($G(^SC(+SDCL,0)),U))
 D PID^VADPT6
 D SET("                  Patient: "_$P($G(^DPT(+DFN,0)),U)_"  ("_VA("BID")_")")
 D SET("")
 F SDTYPE="ERROR","WARNING" IF SDMSG[SDTYPE D TYPE(SDTYPE)
 D ^XMD
BULLQ K XMY Q
 ;
SET(X) ; -- set text into array
 S SDLN=$G(SDLN)+1,SDBUL(SDLN,0)=X Q
 ;
TYPE(SDTYPE) ; -- insert errors/warnings into msg
 N SDI,X,Y,SDCNT
 S SDCNT=0
 D SET(SDTYPE_" #:")
 D SET($E("-------------",1,$L(SDTYPE)+3))
 S SDI=0 F  S SDI=$O(SDERR(SDTYPE,SDI)) Q:'SDI  D
 . S X=SDERR(SDTYPE,SDI),Y=$P(X,U,2),SDCNT=SDCNT+1
 . D SET("  "_$P(X,U)_$E("        ",1,8-$L($P(X,U)))_"-> "_$E(Y,1,60)) S Y=$E(Y,61,999)
 . F  Q:Y=""  D SET("             "_$E(Y,1,60)) S Y=$E(Y,61,999)
 IF 'SDCNT D SET("  <none reported>")
 D SET(""),SET("")
 Q
 ;
MSG() ; -- msg flag 'ERROR' or 'WARNING' or 'ERROR+WARNING'
 N Y,X
 S Y=$P($G(^DG(43,1,"SCLR")),U,27),X=""
 I Y["E" S X=X_"ERROR/"
 I Y["W" S X=X_"WARNING"
 Q X
 ;
