YSASCF ;ASF/ASL ASI CASE FINDER WITH DX API ;9/14/98  18:11
 ;;5.01;MENTAL HEALTH;**38,45,55**;Dec 30, 1994
MAIN ;
 K ^TMP("YSAS",$J),^TMP("YSASM",$J)
 N DFN,G,G1,P,X,Y,YSASBDT,YSASCNT,YSASCNT2,YSASEDT,YSASI,YSLOC,YSASITE
 N YSASIX,YSASMCNT,YSASMTC,YSASN,YSASNM,YSASS,YSICD,YSLS,YSM,YSODFN
 N YSOEDT,YSOEFN,YSPTFD,YSPTFN,YSSUB,YSTOT,YSASDNIT,YSMD
 W @IOF,!?10,"Addiction Severity Index Case finder",!
 D DTRANGE Q:YSASBDT=""!(YSASEDT="")
 W !!,"Results returned via Mailman. Please queue this report for "
 W "after hours."
QUEUE ;
 K IOP,ZTIO,ZTSAVE
 S ZTIO="",ZTSAVE("YSAS*")="",ZTRTN="ENQ^YSASCF"
 S ZTDESC="ASI Case Finder"
 D ^%ZTLOAD W:$D(ZTSK) !!,"Your Task Number is "_ZTSK D ^%ZISC
 K ^TMP("YSAS",$J),^TMP("YSASM",$J)
 Q
ENQ ;queue entry
 S:$D(ZTQUEUED) ZTREQ="@"
 S YSASN=0
 D PTFLP
 D OE
 D HEAD,PTLST,BOT
 D MAIL2 ; output
 Q
DTRANGE ;date range
 W ! S (YSASBDT,YSASEDT)="",%DT("A")="Beginning Date for ASI Case Finder Date Range: ",%DT="AEX" D ^%DT
 Q:Y'>0
 S YSASBDT=+Y_".000001"
 W ! S %DT("A")="Ending Date for ASI Case Finder Date Range: " D ^%DT
 Q:Y'>0
 S YSASEDT=+Y_".595959"
 I (YSASEDT>0)&(YSASEDT<YSASBDT) W !,?7,"Ending Date must be closer to today than Beginning Date",! H 2 W $C(7) G DTRANGE
 Q
PTFLP ;search PTF for subs abuse primary dx
 S YSPTFD=YSASBDT-.0001
 F  S YSPTFD=$O(^DGPT("ADS",YSPTFD)) Q:YSPTFD>(YSASEDT+.9999)!(YSPTFD'>0)  S YSPTFN=0 F  S YSPTFN=$O(^DGPT("ADS",YSPTFD,YSPTFN)) Q:YSPTFN'>0  D
 . S YSM=0,YSSUB=0
 . F  S YSM=$O(^DGPT(YSPTFN,"M",YSM)) Q:YSM'>0!(YSSUB=1)  D
 .. S DFN=+^DGPT(YSPTFN,0)
 .. Q:DFN'>0
 .. S G=$G(^DGPT(YSPTFN,"M",YSM,0))
 .. I G="" S ^TMP("YSAS",$J,$P(^DPT(DFN,0),U),DFN)="Missing PTF Data" Q
 .. ;dont add NHCU or DOM pts
 .. S YSLS=$P(G,U,2) S:YSLS YSLS=$P($G(^DIC(42.4,YSLS,0)),U)
 .. Q:YSLS?.E1"NHCU".E!(YSLS?.E1"DOMICILIARY".E)
 .. ;check idc9 #1= subs
 .. S YSICD=$P(G,U,5) S:YSICD YSICD=$P($G(^ICD9(YSICD,0)),U,1)
 .. D ICDCK(YSICD)
 .. I YSSUB=1 S ^TMP("YSAS",$J,$P(^DPT(DFN,0),U),DFN)=$P(G,U,10)_";"_YSICD_";"_$P(G,U,2)
 .. ;W:YSICD !,^DGPT(YSPTFN,0),!?5,YSICD,?15,YSLS
 Q
ICDCK(YSICD) ; CHECK IF ICD9 MEETS CRITERIA
 S YSSUB=0
 I ((YSICD?1"291.".E)!(YSICD?1"292.".E)!(YSICD?1"303.".E)!(YSICD?1"304.".E)!(YSICD?1"305.".E))&(YSICD'?1"305.1".E)&(YSICD'?3N1"."1N1"3") S YSSUB=1
 Q
OE ;loop thru OUTPATIENT ENCOUNTER file
 S YSOEDT=YSASBDT-.0001
 F  S YSOEDT=$O(^SCE("B",YSOEDT)) Q:(YSOEDT>(YSASEDT+.9))!(YSOEDT'>0)  S YSOEFN=0 F  S YSOEFN=$O(^SCE("B",YSOEDT,YSOEFN)) Q:YSOEFN'>0  D
 . S G=$G(^SCE(YSOEFN,0))
 . I G="" Q
 . S DFN=$P(G,U,2) Q:DFN'>0
 . K YSDXL S YSSUB=0
 . D GETDX^SDOE(YSOEFN,"YSDXL")
 . S I=0 F  S I=$O(YSDXL(I)) Q:I'>0!(YSSUB)  D
 .. S YSICD=$P(YSDXL(I),U) S:YSICD YSICD=$P($G(^ICD9(YSICD,0)),U,1)
 .. I ((YSICD?1"291.".E)!(YSICD?1"292.".E)!(YSICD?1"303.".E)!(YSICD?1"304.".E)!(YSICD?1"305.".E))&(YSICD'?1"305.1".E)&(YSICD'?3N1"."1N1"3") S YSSUB=1
 .. S:$P(YSDXL(I),U,12)="S" YSSUB=0
 . I YSSUB=1 S $P(^TMP("YSAS",$J,$P(^DPT(DFN,0),U),DFN),U,2)=$P(G,U)_";"_YSICD_";"_$P(G,U,4)
 Q
HEAD ;header
 K ^TMP("YSASM",$J) S YSASS="",$P(YSASS," ",75)=""
 ;S YSASN=0,YSASITE=$P($G(^YSTX(604.8,1,0)),U) S:YSASITE'="" YSASITE=$P($G(^DIC(4,YSASITE,0)),U)
 S YSASN=0
 S YSASITE=$$SITE
 S YSASN=YSASN+1,^TMP("YSASM",$J,YSASN)=$E(YSASS,1,15)_"Addiction Severity Index Case Finder"
 S Y=YSASBDT\1 X ^DD("DD") S YSASN=YSASN+1,^TMP("YSASM",$J,YSASN)="Beginning Date: "_Y
 S Y=YSASEDT\1 X ^DD("DD") S YSASN=YSASN+1,^TMP("YSASM",$J,YSASN)="  Ending Date: "_Y
 S YSASN=YSASN+1,^TMP("YSASM",$J,YSASN)="     Facility: "_YSASITE
 S YSASN=YSASN+1,^TMP("YSASM",$J,YSASN)=" "
 S YSASN=YSASN+1,^TMP("YSASM",$J,YSASN)="The following is a list of all patients who received a PSUD diagnosis"
 S YSASN=YSASN+1,^TMP("YSASM",$J,YSASN)="between the above dates but do not have a signed ASI."
 S YSASN=YSASN+1,^TMP("YSASM",$J,YSASN)=$E(YSASS,1,34)_"Last Primary Substance Abuse Dx"
 S YSASN=YSASN+1,^TMP("YSASM",$J,YSASN)="Name"_$E(YSASS,1,17)_"SSN         Type  Dx      Date        Location"
 Q
BOT ; bottom
 S YSASN=YSASN+1,^TMP("YSASM",$J,YSASN)=" "
 S YSASN=YSASN+1,^TMP("YSASM",$J,YSASN)=YSTOT_" patients without a signed ASI listed. ** indicates unsigned ASI"
 I YSMD>0 D
 .S XX=YSMD_" patient(s) with missing PTF data."
 .S YSASN=YSASN+1,^TMP("YSASM",$J,YSASN)=XX
 .K XX
 S YSASN=YSASN+1,^TMP("YSASM",$J,YSASN)=YSASDNIT_" PSUD patients had a signed ASI."
 S YSASN=YSASN+1,^TMP("YSASM",$J,YSASN)=" "
 S YSASN=YSASN+1,^TMP("YSASM",$J,YSASN)="PSUD= all 291, 292, 303, 304 and 305 ICD-9 codes except:"
 S YSASN=YSASN+1,^TMP("YSASM",$J,YSASN)="305.1 (tobacco dependency) and Remission codes (i.e. XXX.X3)"
 Q
PTLST ;check for previous ASI and print
 S YSASNM="",(YSTOT,YSASDNIT,YSMD)=0
 F  S YSASNM=$O(^TMP("YSAS",$J,YSASNM)) Q:YSASNM=""  S DFN=0 F  S DFN=$O(^TMP("YSAS",$J,YSASNM,DFN)) Q:DFN'>0  D
 . D ASICK(DFN) ;check previous ASI
 . I YSASI=1 S YSASDNIT=YSASDNIT+1 Q  ;out if done
 . D DEM^VADPT S YSASN=YSASN+1,^TMP("YSASM",$J,YSASN)=$E(YSASNM_YSASS,1,20)_" "_VA("PID")_" " ;$E(VA("BID")_"  ",1,6)_" "
 . S G=^TMP("YSAS",$J,YSASNM,DFN)
 . I G="Missing PTF Data" D  Q
 .. S YSMD=YSMD+1
 .. S ^TMP("YSASM",$J,YSASN)=^TMP("YSASM",$J,YSASN)_"Inpt  "_G
 . S YSTOT=YSTOT+1
 . S P=$S(+G>(+$P(G,U,2)):1,1:2) ; inpt vs outpt
 . S G1=$P(G,U,P),Y=$E(+G1,4,5)_"/"_$E(+G1,6,7)_$S(+G1>2999999:"/20",1:"/19")_$E(+G1,2,3) ;date
 . ; set location 
 . S X="" I P=1&($P(G1,";",3)'="") S X=$P(G1,";",3),X=$P($G(^DIC(42.4,X,0)),U)
 . I P=2&($P(G1,";",3)'="") S X=$P(G1,";",3),X=$P($G(^SC(X,0)),U)
 . S ^TMP("YSASM",$J,YSASN)=^TMP("YSASM",$J,YSASN)_$S(P=1:"Inpt  ",1:"Outpt ")_$E($P(G1,";",2)_YSASS,1,7)_" "_Y_"  "_$E(X_YSASS,1,20)_$S(YSASI=2:" **",1:"")
 Q
ASICK(DFN) ;check ASI already done 0=NONE 1=DONE 2=UNSIGNED
 I '$D(^YSTX(604,"C",DFN)) S YSASI=0 Q
 S YSASI=1,YSASIX=0 F  S YSASIX=$O(^YSTX(604,"C",DFN,YSASIX)) Q:YSASIX'>0  I $P($G(^YSTX(604,YSASIX,.5)),U,1)'=1 S YSASI=2
 Q
MAIL2 ; SEND MAILMAN
 K ^TMP("YSMM",$J)
 S YSASMCNT=0,YSASMTC=(YSASN\1000)+1
 S YSASCNT=0,YSASCNT2=0 F  S YSASCNT=$O(^TMP("YSASM",$J,YSASCNT)) Q:(YSASCNT'>0)  D
 .S YSASCNT2=YSASCNT2+1,^TMP("YSMM",$J,YSASCNT)=^TMP("YSASM",$J,YSASCNT)
 .I (YSASCNT2=1000)!(YSASCNT=YSASN) D
 ..S YSASMCNT=YSASMCNT+1
 ..S DTIME=600
 ..S XMSUB="ASI Case Finder      ("_YSASMCNT_" OF "_YSASMTC_")"
 ..S XMTEXT="^TMP(""YSMM"",$J,"
 ..S XMY("G.ASI PERFORMANCE MEASURES")=""
 ..S XMY(DUZ)=""
 ..S XMDUZ="AUTOMATED MESSAGE"
 ..D ^XMD
 ..S YSASCNT2=0
 ..S DTIME=$$DTIME^XUP(DUZ)
 ..K ^TMP("YSMM",$J)
 Q
 ;
SITE() ;SET YSASITE EQUAL TO SITE-NAME
 N DA,DIC,DIQ,DR
 S YSDA=+$P($$SITE^VASITE,U)
 QUIT $$GET1^DIQ(4,YSDA_",",.01)
