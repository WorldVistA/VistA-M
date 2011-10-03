YSASU ;ASF/ALB-ASI MANAGEMENT REPORTS ;2/4/98  10:27
 ;;5.01;MENTAL HEALTH;**38**;Dec 30, 1994
MAIN ;
 K ^TMP("YSASU",$J) N G,G0,G5,GP5,J,N,Y,YSASBDT,YSASCNT,YSASCNT2,YSASDT,YSASEDT,YSASITE,YSASMCNT,YSASMTC,YSASN,YSASS,YSAWAIT,YSCLASS,YSFL,YSIFN,YSLOC,YSNAME,YSSIGND,YSTOT,YSSPEC,YSTRANS
 W @IOF,!?10,"Addiction Severity Index",!?15,"Site Report by Date"
 D DTRANGE Q:YSASBDT=""!(YSASEDT="")
 W !!,"Results returned via Mailman. Please queue this report for after hours."
QUEUE ;
 ;S YSASITE=$P(^DIC(4,+^YSTX(604.8,1,0),0),U)
 S YSASITE=$$SITE^YSASCF
 K IOP,ZTIO,ZTSAVE
 S ZTIO="",ZTSAVE("YSAS*")="",ZTRTN="ENQ^YSASU",ZTDESC="YSAS ASI SITE REPORT" D ^%ZTLOAD
 I '$D(ZTSK) Q
 W !!,"Your Task Number is "_ZTSK D ^%ZISC
 Q
ENQ ;queue entry
 S:$D(ZTQUEUED) ZTREQ="@"
 D FINDIT
 D BUILDIT
 D PTLST^YSASU1
 D MAIL2^YSASU1
 Q
ZZ S N=0 F  S N=$O(^TMP("YSASU",$J,"M",N)) Q:N'>0  W !,^(N)
 Q
DTRANGE ;date range
 W ! S (YSASBDT,YSASEDT)="",%DT("A")="Beginning Date for ASI Range: ",%DT="AEX" D ^%DT
 Q:Y'>0
 S YSASBDT=+Y
 W ! S %DT("A")="Ending Date for ASI Range: " D ^%DT
 Q:Y'>0
 S YSASEDT=+Y
 I (YSASEDT>0)&(YSASEDT<YSASBDT) W !,?7,"Ending Date must be closer to today th an Beginning Date",! H 2 W $C(7) G DTRANGE
 Q
FINDIT ; loop thru 604 by date
 S (YSCLASS(-1),YSCLASS(1),YSCLASS(2),YSCLASS(3),YSTOT,YSSPEC(-1),YSSPEC(1),YSSPEC(2),YSSPEC(3),YSSPEC("N"),YSSIGND(0),YSSIGND(1),YSAWAIT(0),YSAWAIT(1),YSTRANS(0),YSTRANS(1))=0
 S YSASDT=YSASBDT-.001 F  S YSASDT=$O(^YSTX(604,"AD",YSASDT)) Q:YSASDT'>0!(YSASDT>YSASEDT)  S YSIFN=0 F  S YSIFN=$O(^YSTX(604,"AD",YSASDT,YSIFN)) Q:YSIFN'>0  D
 . S G0=$G(^YSTX(604,YSIFN,0)),GP5=$G(^YSTX(604,YSIFN,.5)),G5=$G(^YSTX(604,YSIFN,5))
 . ;1=date interview 2=dfn 3=class 4=special 5=interviewer 6=e signed 7=e sig 8= awaiting trans 9= trans date
 . IF $P(G0,U,2)>0 S YSNAME=$P(^DPT($P(G0,U,2),0),U)
 . IF $P(G0,U,2)="" S YSNAME="unknown "_YSIFN
 . S ^TMP("YSASU",$J,"A",YSNAME,YSIFN)=""
 . S ^TMP("YSASU",$J,YSIFN)=YSASDT_U_$P(G0,U,2)_U_$P(G0,U,4)_U_$P(G0,U,11)_U_$P(G0,U,9)_U_$P(GP5,U,1)_U_$P(GP5,U,2)_U_$P(G5,U,3)_U_$P(G5,U,4)
 . S YSTOT=$G(YSTOT)+1
 . S G=$P(G0,U,4) S:G="" G=-1 S YSCLASS(G)=$G(YSCLASS(G))+1
 . S G=$P(G0,U,11) S:G="" G=-1 S YSSPEC(G)=$G(YSSPEC(G))+1
 . S G=$P($G(GP5),U,1) S:G="" G=0 S YSSIGND(G)=$G(YSSIGND(G))+1
 . S G=$P($G(G5),U,3) S:G="" G=0 S YSAWAIT(G)=$G(YSAWAIT(G))+1
 . S G=$P($G(G5),U,4),G=$S(G="":0,1:1),YSTRANS(G)=$G(YSTRANS(G))+1
 Q
BUILDIT ;build output tmp
 K ^TMP("YSASU",$J,"M") S YSASN=0,YSASS="",$P(YSASS," ",79)=""
 S YSASN=YSASN+1,^TMP("YSASU",$J,"M",YSASN)=$E(YSASS,1,15)_"Addiction Severity Index Status Report"
 S YSASN=YSASN+1,^TMP("YSASU",$J,"M",YSASN)="     Facility: "_YSASITE
 S Y=YSASBDT X ^DD("DD") S YSASN=YSASN+1,^TMP("YSASU",$J,"M",YSASN)="Begining Date: "_Y
 S Y=YSASEDT X ^DD("DD") S YSASN=YSASN+1,^TMP("YSASU",$J,"M",YSASN)="  Ending Date: "_Y
 S YSASN=YSASN+1,^TMP("YSASU",$J,"M",YSASN)=" "
 S YSASN=YSASN+1,^TMP("YSASU",$J,"M",YSASN)="During this time period there were:"
 S YSASN=YSASN+1,^TMP("YSASU",$J,"M",YSASN)=YSTOT_" total entries"
 S YSASN=YSASN+1,^TMP("YSASU",$J,"M",YSASN)=YSCLASS(1)_" Full,  "_YSCLASS(2)_" Lite, "_YSCLASS(3)_" Follow-up and "_YSCLASS(-1)_" Unspecified"
 S YSASN=YSASN+1,^TMP("YSASU",$J,"M",YSASN)=YSSPEC("N")_" Completed, "_YSSPEC(1)_" Terminated,  "_YSSPEC(2)_" Refused, "_YSSPEC(3)_" Unable and "_YSSPEC(-1)_" Unspecified"
 S YSASN=YSASN+1,^TMP("YSASU",$J,"M",YSASN)=YSSIGND(1)_" were signed and "_YSSIGND(0)_" remain unsigned"
 S YSASN=YSASN+1,^TMP("YSASU",$J,"M",YSASN)=YSTRANS(1)_" were transmitted to the central database and "_YSTRANS(0)_" were not transmitted"
 S YSASN=YSASN+1,^TMP("YSASU",$J,"M",YSASN)=YSAWAIT(1)_" are in the queue for the next transmission"
 S YSASN=YSASN+1,^TMP("YSASU",$J,"M",YSASN)=" "
 Q
