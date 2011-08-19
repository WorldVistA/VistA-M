YSASFUR ;ASF/ASL ASI FOLLOWUP REQUIRED ;3/13/98  10:39
 ;;5.01;MENTAL HEALTH;**38,55**;Dec 30, 1994
MAIN ;
 K ^TMP("YSAS",$J)
 N DIR,DIRUT,G,G2,VA,X,X1,X2,Y,YS2G12,YSASAD1,YSASBDT,YSASCL,YSASCNT,YSASCNT2,YSASCNT3,YSASDLY,YSASDT,YSASEDT,YSASG12,YSASIN,YSASIN2,YSASITE,YSASN,YSASS,YSASTC,YSASTYP2,YSCK,YSIN1,YSIN2,YSINTER,YSLOC,YSNM,YSTOT
 W @IOF,!?10,"Addiction Severity Index Followup Reminder",!
 D DTRANGE Q:YSASBDT=""!(YSASEDT="")  Q:(YSASDLY=0)
 W !!,"Results returned via Mailman. Please queue this report for after hours."
QUEUE ;
 K IOP,ZTIO,ZTSAVE
 S ZTIO="",ZTSAVE("YSAS*")="",ZTRTN="ENQ^YSASFUR",ZTDESC="ASI Followup Reminder" D ^%ZTLOAD W:$D(ZTSK) !!,"Your Task Number is "_ZTSK D ^%ZISC
 K ^TMP("YSAS",$J),^TMP("YSAS",$J,"G")
 Q
ENQ ;queue entry
 ;S:$D(ZTQUEUED) ZTREQ="@"
 S YSASN=0,YSTOT=0
 D DATELP
 D HEAD,PTLST,BOT
 D MAIL2 ; output
 Q
DTRANGE ;date range
 W ! S (YSASBDT,YSASEDT)="",%DT("A")="Beginning Date for ASI Followup Reminder Date Range: ",%DT="AEX" D ^%DT
 Q:Y'>0
 S YSASBDT=+Y
 W ! S %DT("A")="Ending Date for ASI Followup Reminder Date Range: " D ^%DT
 Q:Y'>0
 S YSASEDT=+Y
 I (YSASEDT>0)&(YSASEDT<YSASBDT) W !,?7,"Ending Date must be closer to today than Beginning Date",! H 2 W $C(7) G DTRANGE
 W ! K DIR S DIR(0)="N^31:999:0",DIR("B")=180,DIR("A")="Number of days after which a follow-up is required" D ^DIR S:$D(DIRUT) Y=0 S YSASDLY=Y K DIR
 Q
DATELP ;look for all ASIs in range
 S YSASDT=YSASBDT-.0001 F  S YSASDT=$O(^YSTX(604,"AD",YSASDT)) Q:YSASDT>YSASEDT!(YSASDT'>0)  S YSASIN=0 F  S YSASIN=$O(^YSTX(604,"AD",YSASDT,YSASIN)) Q:YSASIN'>0  D
 . S G=^YSTX(604,YSASIN,0),DFN=$P(G,U,2),YSASG12=$P(G,U,11),YSASCL=$P(G,U,4),YSASAD1=$P(G,U,5)
 . Q:YSASG12'="N"  ; only search on completes
 . Q:DFN=""
 . ;Q:YSASCL=3  ;it is a followup already
 . S YSIN2=""
 . D NEXTCK ;look for a fu
 . S ^TMP("YSAS",$J,"A",$P(^DPT(DFN,0),U),DFN)=YSCK_U_YSASIN_U_YSIN2
 Q
NEXTCK ;FU checker
 S YSCK=0 ; DEFAULT= NEEDS FU
 S X1=DT,X2=YSASAD1 D ^%DTC I X<YSASDLY S YSCK=-1 Q  ; if first admin closer than delay
 S YSASIN2=YSASIN F  S YSASIN2=$O(^YSTX(604,"C",DFN,YSASIN2)) Q:YSASIN2'>0  D
 . S G2=^YSTX(604,YSASIN2,0),YSASTYP2=$P(G2,U,4),YS2G12=$P(G,U,11),YSIN2=YSASIN2
 . S YSCK=YSASTYP2
 Q
PTLST ; list pts
 S YSNM="" F  S YSNM=$O(^TMP("YSAS",$J,"A",YSNM)) Q:YSNM=""  S DFN=0 F  S DFN=$O(^TMP("YSAS",$J,"A",YSNM,DFN)) Q:DFN'>0  D
 . S G=^TMP("YSAS",$J,"A",YSNM,DFN),YSCK=+G,YSIN1=$P(G,U,2),YSIN2=$P(G,U,3)
 . Q:YSCK=3  ; has a fU
 . Q:YSCK=-1  ;admin less than delay
 . D DEM^VADPT S YSASN=YSASN+1,^TMP("YSAS",$J,"G",YSASN)=$E(YSNM_YSASS,1,20)_" "_$E(VA("BID")_YSASS,1,6)_" "
 . S YSTOT=YSTOT+1
 . S G=^YSTX(604,YSIN1,0),YSASCL=$P(G,U,4),Y=$P(G,U,5) X ^DD("DD")
 . S YSINTER=$P(G,U,9) S:YSINTER?1N.N YSINTER=$P($G(^VA(200,YSINTER,0)),U)
 . S ^TMP("YSAS",$J,"G",YSASN)=^TMP("YSAS",$J,"G",YSASN)_$S(YSASCL=1:"Full",YSASCL=2:"Lite",YSASCL=3:"F-Up",1:"    ")_" "_$E(Y_"   ",1,13)_$E(YSINTER_YSASS,1,15)
 . S ^TMP("YSAS",$J,"G",YSASN)=^TMP("YSAS",$J,"G",YSASN)_" "_$S(YSCK=1:" subsequent Full",YSCK=2:" subsequent Lite",1:"")
 Q
HEAD ;header
 K ^TMP("YSAS",$J,"G") S YSASS="",$P(YSASS," ",75)=""
 ;S YSASN=0,YSASITE=$P($G(^YSTX(604.8,1,0)),U) S:YSASITE'="" YSASITE=$P($G(^DIC(4,YSASITE,0)),U)
 S YSASN=0
 S YSASITE=$$SITE^YSASCF
 S YSASN=YSASN+1,^TMP("YSAS",$J,"G",YSASN)=$E(YSASS,1,15)_"Addiction Severity Index Followup Reminder"
 S Y=YSASBDT\1 X ^DD("DD") S YSASN=YSASN+1,^TMP("YSAS",$J,"G",YSASN)="    Beginning Date: "_Y
 S Y=YSASEDT\1 X ^DD("DD") S YSASN=YSASN+1,^TMP("YSAS",$J,"G",YSASN)="      Ending Date: "_Y
 S YSASN=YSASN+1,^TMP("YSAS",$J,"G",YSASN)="Days to Follow-up: "_YSASDLY
 S YSASN=YSASN+1,^TMP("YSAS",$J,"G",YSASN)="         Facility: "_YSASITE
 S YSASN=YSASN+1,^TMP("YSAS",$J,"G",YSASN)=" "
 S YSASN=YSASN+1,^TMP("YSAS",$J,"G",YSASN)="The following is a list of all patients who have not received followup ASI's"
 S YSASN=YSASN+1,^TMP("YSAS",$J,"G",YSASN)="after completed interviews between the above dates."
 S YSASN=YSASN+1,^TMP("YSAS",$J,"G",YSASN)=$E(YSASS,1,34)_"Last ASI Administration in Range"
 S YSASN=YSASN+1,^TMP("YSAS",$J,"G",YSASN)="Name"_$E(YSASS,1,17)_"SSN    Type  Date        Interviewer"
 Q
BOT ; bottom
 S YSASN=YSASN+1,^TMP("YSAS",$J,"G",YSASN)=" "
 S YSASN=YSASN+1,^TMP("YSAS",$J,"G",YSASN)=YSTOT_" patients listed."
 Q
MAIL2 ; SEND MAILMAN
 K ^TMP("YSMM",$J)
 S YSASCNT3=0,YSASTC=(YSASN\1000)+1
 S YSASCNT=0,YSASCNT2=0 F  S YSASCNT=$O(^TMP("YSAS",$J,"G",YSASCNT)) Q:(YSASCNT'>0)  D
 .S YSASCNT2=YSASCNT2+1,^TMP("YSMM",$J,YSASCNT)=^TMP("YSAS",$J,"G",YSASCNT)
 .I (YSASCNT2=1000)!(YSASCNT=YSASN) D
 ..S YSASCNT3=YSASCNT3+1
 ..S DTIME=600
 ..S XMSUB="ASI Follow-up Reminder      ("_YSASCNT3_" OF "_YSASTC_")"
 ..S XMTEXT="^TMP(""YSMM"",$J,"
 ..S XMY("G.ASI PERFORMANCE MEASURES")=""
 ..S XMY(DUZ)=""
 ..S XMDUZ="AUTOMATED MESSAGE"
 ..D ^XMD
 ..S YSASCNT2=0
 ..K ^TMP("YSMM",$J)
 ..S DTIME=$$DTIME^XUP(DUZ)
 Q
