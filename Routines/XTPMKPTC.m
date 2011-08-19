XTPMKPTC ;OAK/BP - PATCH MONITOR FUNCTIONS ;09/10/2008
 ;;7.3;TOOLKIT;**98,100,114**; Apr 25, 1995;Build 1
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
SRVR N XMB X XMREC
 S XTBMLN1=$G(^XMB(3.9,XMZ,0))
 I XTBMLN1["COMPLIANCE DATE CHANGE" G CKCMPDT
 ;
CHECK I XTBMLN1["TEST" G EXIT
 I XTBMLN1["COMPLIANCE DATE CHANGE" G CKCMPDT
 I XTBMLN1["Entered in error patch" DO  I $D(OUT) K OUT G EXIT
 .F XTBX=1:1:8 S XTBY=$G(^XMB(3.9,XMZ,2,+XTBX,0)) I XTBY["The patch is" DO  Q:$D(OUT)
 ..K OUT S X=$P(XTBY,"'",2),DIC(0)="QLM",DIC="^XPD(9.9," D ^DIC I Y<0 S OUT=1 Q
 ..S DIK=DIC,DA=+Y D ^DIK K DIC,DIK,DA,XTBX,XTBY,Y,X S OUT=1 Q
 I XTBMLN1'["SEQ #"!(XTBMLN1'["National Patch Module") G EXIT
 ;
CKCMPDT D CMPDTCG^XTPMKPCF I $D(XTBCMDCG) K XTBCMDCG G EXIT ;compliance date chg check
 S XTBPTYPE=1 ;assume NON-KIDS until verified
 F XTBX=0:0 S XTBX=$O(^XMB(3.9,XMZ,2,XTBX)) Q:XTBX=""!(+XTBX=0)  S XTBY=$G(^XMB(3.9,XMZ,2,XTBX,0)) I XTBY["$KID" DO
 .S XTBZ=$O(^XMB(3.9,XMZ,2,XTBX)) I $G(^XMB(3.9,XMZ,2,XTBZ,0))["**INSTALL NAME**" S XTBPTYPE="",XTBX=9999999 Q
 ;
EXTINFO S (XTBDESG,XTBPKG,XTBPRIO,XTBVER,XTBSEQ,XTBSUB)=""
 F  X XMREC Q:XMER<0!(XMRG["Description")  DO  Q:$D(NOFILE)
 .K NOFILE
 .Q:XMRG["====="
 .I XMRG["Designation" S (XTBDESG,XTBINST)=$P(XMRG,"Designation: ",2) Q:$D(NOFILE)  DO
 ..Q:XTBINST'["*"  ;*p114*-REM
 ..S XTBY=$P(XTBDESG,"*",2) I XTBY'?1.2N1".".N S XTBY=XTBY_".0",$P(XTBINST,"*",2)=XTBY
 .I XTBDESG="" S NOFILE=1 Q
 .I $D(^XPD(9.9,"B",XTBDESG)) S NOFILE=1 Q  ; already done
 .I XMRG["Package" DO
 ..S XTBPKG=$P(XMRG,"Package : ",2),XTBPKG=$P(XTBPKG,"Priority: ",1),XTBPKG=$E(XTBPKG,1,35)
 ..S XTBX=$L(XTBPKG)
 ..F XX=XTBX:-1 S XTBY=$E(XTBPKG,XX,XX) Q:($A(XTBY)>64)!(XTBY="")  I $A(XTBY)=32 S $E(XTBPKG,XX,XX)="z"
 ..I XTBPKG["z" S XTBPKG=$P(XTBPKG,"z",1)
 .I XMRG["Priority" S XTBPRIO=$P(XMRG,"Priority: ",2) DO
 ..S XTBPRIO=$P(XTBPRIO," ",1) S X=XTBPRIO X ^%ZOSF("UPPERCASE") S XTBPRIO=X
 .I XMRG["Version" S XTBVER=$P(XMRG,"Version: ",1) DO
 ..S XTBSEQ=$P(XTBVER,"#",2),XTBSEQ=$P(XTBSEQ," ",1)
 ..S XTBVER=$P(XTBVER,"Version : ",2),XTBVER=+XTBVER
 .I XMRG["Compliance Date:" S XTBCMPDT=$P(XMRG,"Compliance Date: ",2)
 .I XMRG["Subject" S XTBSUB=$P(XMRG,"Subject: ",2),XTBSUB=$E(XTBSUB,1,50),XTBSUB=$TR(XTBSUB,":;","--")
 G:$D(NOFILE) EXIT
 ;
FILE K DO,DD S (DIC,DIE)="^XPD(9.9,",DIC(0)="M",X=XTBDESG
 S XTBRCPDT=$G(^XMB(3.9,XMZ,.6)) I XTBRCPDT="" S XTBRCPDT=DT
 S DIC("DR")="1////"_XTBRCPDT_";2///"_XTBPRIO_";3///"_XTBPKG_";4////"_XTBSEQ_";5////"_XTBVER_";6///"_XTBSUB_";7///"_XTBINST_";8///"_XTBCMPDT_";11////"_XTBPTYPE
 D FILE^DICN
 ;
EXIT G EXITA^XTPMKPCF
 ;
NIGHT S XTBPURGI=$P($G(^XPD(9.95,1,0)),U,3) ;purge y/n
 K ^TMP($J) S XTBX="",XTBLN=8,XTBCNT=0
 S NIGHT=1 D TEXT S Y=DT X ^DD("DD") S XTBRUNDT=Y
 F  S XTBX=$O(^XPD(9.9,"B",XTBX)) Q:XTBX=""  F XTBDA=0:0 S XTBDA=$O(^XPD(9.9,"B",XTBX,XTBDA)) Q:XTBDA=""  DO
 .K XTBKILLD
 .S XTBDTA=$G(^XPD(9.9,XTBDA,0)) Q:XTBDTA=""
 .S XTBINST=$P(XTBDTA,U,8) Q:XTBINST=""
 .S XTBPTYPE=$P(XTBDTA,U,10)
 .S XTBXX=$O(^XPD(9.7,"B",XTBINST,9999999999),-1) I $G(^XPD(9.7,+XTBXX,2))[" TEST v" S XTBXX=""
 .I $P($G(^XPD(9.7,+XTBXX,0)),U,9)=3!(XTBPTYPE=1&($P(XTBDTA,U,11)]"")),XTBPURGI=1 DO  Q:$D(XTBKILLD)  ; installed, check purge flag
 ..S DA=XTBDA,DIK="^XPD(9.9," D ^DIK S XTBKILLD=1 K DA,DIK Q
 .I XTBXX]"",XTBPTYPE=1 S XTBPTYPE="",$P(^XPD(9.9,XTBDA,0),U,10)="" ;found In INSTALL
 .Q:XTBPTYPE=1&($P(XTBDTA,U,11)]"")  ;non-kids, has install date  
 .Q:$P($G(^XPD(9.7,+XTBXX,0)),U,9)=3
 .I (DT>$P(XTBDTA,U,9)) D SET
 I '$D(^TMP($J,9,0)) K ^TMP($J) S ^TMP($J,3,0)="",^TMP($J,4,0)="    No Delinquent Patches were found."
 S ^TMP($J,XTBLN,0)="",XTBLN=XTBLN+1
 I XTBCNT>0 S ^TMP($J,XTBLN,0)="Total: "_XTBCNT,XTBLN=XTBLN+1
 S ^TMP($J,XTBLN,0)="",XTBLN=XTBLN+1
 S XMSUB="Patch Monitor Report for "_^DD("SITE")_" for "_XTBRUNDT
 N DUZ S XMDUZ=.5,XMTEXT="^TMP($J,",XMY("G.XTPM PATCH MONITOR")="",XMY(.5)="" D ^XMD
 ; purge old data
 I +XTBPURGI=0 D ^XTPMKPP
 G EXIT
 ;
SET S XTBPTNM=$P(XTBDTA,U,1),XTBSUBJ=$E($P(XTBDTA,U,7),1,20)
 S X=$P(XTBDTA,U,3),XTBPRIO=$S(X="m":"Mandatory",X="e":"Emergency",1:"Unknown")
 S (X1,Y)=$P(XTBDTA,U,2) X ^DD("DD") S XTBRECPT=Y
 S (Y,YY1)=$P(XTBDTA,U,9) X ^DD("DD") S XTBINSTX=Y ; compliance date
 I YY1<DT,'$D(NIGHT) S XTBINSTX=Y_" *"
 S XTBPKG=$P(XTBPTNM,"*",1),XTBPKGPT=$O(^DIC(9.4,"C",XTBPKG,0))
 S XTBPCTVR=+$P(XTBPTNM,"*",2),XTBPLVER=+$G(^DIC(9.4,+XTBPKGPT,"VERSION"))
 I XTBPCTVR>XTBPLVER,XTBPLVER>0 S XTBINSTX="Future Version"
 I XTBPCTVR>XTBPLVER,XTBPLVER=0 S $P(^XPD(9.9,XTBDA,0),U,10)=1,XTBINSTX="CompleteByHand"
 I XTBPCTVR=999 S XTBINSTX="CompleteByHand" ;mainly new Mailman domains
 I XTBINSTX="Future Version"&($D(NIGHT)) Q
 I XTBINSTX="Future Version"&($D(XTBPSTD)) Q
 S XTBLN=XTBLN+1 ; first line=9
 S XTBCNT=XTBCNT+1
 S XTBDTA=""
 S $E(XTBDTA,1)=XTBPTNM,$E(XTBDTA,15)=XTBSUBJ,$E(XTBDTA,38)=XTBPRIO,$E(XTBDTA,51)=XTBRECPT,$E(XTBDTA,64)=XTBINSTX
 S ^TMP($J,XTBLN,0)=XTBDTA,XTBLN=XTBLN+1
 S ^TMP($J,XTBLN,0)="",XTBLN=XTBLN+1
 Q
 ;
TEXT S ^TMP($J,1,0)=""
 S ^TMP($J,2,0)="The following patches are not installed at this site and are past the"
 S ^TMP($J,3,0)="designated installation time:"
 S ^TMP($J,4,0)=""
 S ^TMP($J,5,0)="                                                               Compliance"
 S ^TMP($J,6,0)="Patch #       Subject                Priority     Recpt Date   Date"
 S ^TMP($J,7,0)="-------       -------                --------     ----- ----   ----------"
 S ^TMP($J,8,0)=""
 Q
 ;
REG ; regular notification
 K ^TMP($J) S XTBX="",XTBLN=8,XTBCNT=0
 D TEXT S Y=DT X ^DD("DD") S XTBRUNDT=Y
 S ^TMP($J,2,0)="The following patches are uninstalled at this site:" K ^TMP($J,3,0)
 F  S XTBX=$O(^XPD(9.9,"B",XTBX)) Q:XTBX=""  F XTBDA=0:0 S XTBDA=$O(^XPD(9.9,"B",XTBX,XTBDA)) Q:XTBDA=""  DO
 .S XTBDTA=$G(^XPD(9.9,XTBDA,0)),XTBINST=$P(XTBDTA,U,8)
 .Q:XTBDTA=""!(XTBINST="")  ;no data or no install name
 .S XTBXX=$O(^XPD(9.7,"B",XTBINST,9999999999),-1) I $G(^XPD(9.7,+XTBXX,2))[" TEST v" S XTBXX=""
 .Q:$P(XTBDTA,U,10)=1&($P(XTBDTA,U,11)]"")  ;non-kids
 .Q:$P($G(^XPD(9.7,+XTBXX,0)),U,9)=3
 .D SET
 I '$D(^TMP($J,9,0)) G EXIT
 S ^TMP($J,XTBLN,0)="",XTBLN=XTBLN+1
 S ^TMP($J,XTBLN,0)="Total: "_XTBCNT,XTBLN=XTBLN+1
 S ^TMP($J,XTBLN,0)="",XTBLN=XTBLN+1
 S XMSUB="Uninstalled Patch Report for "_^DD("SITE")_" for "_XTBRUNDT
 N DUZ K XMY
 S XMDUZ=.5,XMTEXT="^TMP($J," D MG,^XMD
 G EXIT
 ;
RPT W @IOF,!,"Complete Uninstalled Patch Report for "_^DD("SITE"),!!!
 S %ZIS="AEQ" D ^%ZIS G:POP EXIT
 I $D(IO("Q")) S ZTIO=ION,ZTSAVE="",ZTRTN="RPT1^XTPMKPTC",ZTDESC="Uninstalled Patch Report" D ^%ZTLOAD D HOME^%ZIS
 I $D(ZTSK) W !,"Queued as task# ",ZTSK,!! H 2 G EXIT
 ;
RPT1 U IO K ^TMP($J) S XTBX="",XTBLN=8,XTBCNT=0
 D TEXT S Y=DT X ^DD("DD") S XTBRUNDT=Y
 K ^TMP($J,2,0),^TMP($J,3,0)
 F  S XTBX=$O(^XPD(9.9,"B",XTBX)) Q:XTBX=""  F XTBDA=0:0 S XTBDA=$O(^XPD(9.9,"B",XTBX,XTBDA)) Q:XTBDA=""  DO
 .S XTBDTA=$G(^XPD(9.9,XTBDA,0)),XTBINST=$P(XTBDTA,U,8) Q:XTBDTA=""!(XTBINST="")  ; no data or no install name
 .S XTBXX=$O(^XPD(9.7,"B",XTBINST,9999999999),-1) I $G(^XPD(9.7,+XTBXX,2))[" TEST v" S XTBXX=""
 .Q:$P(XTBDTA,U,10)=1&($P(XTBDTA,U,11)]"")  ;non-kids
 .Q:$P($G(^XPD(9.7,+XTBXX,0)),U,9)=3
 .D SET
 I '$D(^TMP($J,9,0)) S ^TMP($J,XTBLN,0)="",XTBLN=XTBLN+1,^TMP($J,XTBLN,0)="     Nothing to report",XTBLN=XTBLN+1
 S ^TMP($J,XTBLN,0)="",XTBLN=XTBLN+1
 I XTBCNT>0 S ^TMP($J,XTBLN,0)="Total: "_XTBCNT,XTBLN=XTBLN+1
 S ^TMP($J,XTBLN,0)="",XTBLN=XTBLN+1
 S PG=1,XTBHDR="Uninstalled Patch Report for "_^DD("SITE")_" for "_XTBRUNDT
 W:IOST?1"C-".E @IOF W !,XTBHDR,?(IOM-12),"Page: ",PG,!
 F XTBLN=0:0 S XTBLN=$O(^TMP($J,XTBLN)) Q:XTBLN=""  W ^TMP($J,XTBLN,0),! I $Y>(IOSL-5) S PG=PG+1 D PAUSE W @IOF,!,XTBHDR,?(IOM-12),"Page: ",PG,!!
 G EXIT
 ;
PASTDUE W @IOF,!,"Past Due Patch Report for "_^DD("SITE"),!!!
 S %ZIS="AEQ" D ^%ZIS G:POP EXIT
 I $D(IO("Q")) S ZTIO=ION,ZTSAVE="",ZTRTN="PASTD1^XTPMKPTC",ZTDESC="Past Due Patch Report" D ^%ZTLOAD D HOME^%ZIS
 I $D(ZTSK) W !,"Queued as task# ",ZTSK,!! H 2 G EXIT
 ;
PASTD1 U IO K ^TMP($J) S XTBX="",XTBLN=8,XTBCNT=0
 S XTBPSTD=1
 D TEXT S Y=DT X ^DD("DD") S XTBRUNDT=Y
 K ^TMP($J,2,0),^TMP($J,3,0)
 F  S XTBX=$O(^XPD(9.9,"B",XTBX)) Q:XTBX=""  F XTBDA=0:0 S XTBDA=$O(^XPD(9.9,"B",XTBX,XTBDA)) Q:XTBDA=""  DO
 .S XTBDTA=$G(^XPD(9.9,XTBDA,0)),XTBINST=$P(XTBDTA,U,8) Q:XTBDTA=""!(XTBINST="")
 .S XTBXX=$O(^XPD(9.7,"B",XTBINST,9999999999),-1) I $G(^XPD(9.7,+XTBXX,2))[" TEST v" S XTBXX=""
 .Q:$P(XTBDTA,U,10)=1&($P(XTBDTA,U,11)]"")  ;non-kids
 .Q:$P($G(^XPD(9.7,+XTBXX,0)),U,9)=3
 .S XTBCOMPD=$P(XTBDTA,U,9) Q:XTBCOMPD'<DT
 .D SET
 I '$D(^TMP($J,9,0)) S ^TMP($J,XTBLN,0)="",XTBLN=XTBLN+1,^TMP($J,XTBLN,0)="     Nothing to report",XTBLN=XTBLN+1
 S ^TMP($J,XTBLN,0)="",XTBLN=XTBLN+1
 I XTBCNT>0 S ^TMP($J,XTBLN,0)="Total: "_XTBCNT,XTBLN=XTBLN+1
 S ^TMP($J,XTBLN,0)="",XTBLN=XTBLN+1
 S ^TMP($J,XTBLN,0)="",XTBLN=XTBLN+1
 S PG=1,XTBHDR="Past Due Patch Report for "_^DD("SITE")_" for "_XTBRUNDT
 W:IOST?1"C-".E @IOF W !,XTBHDR,?(IOM-12),"Page: ",PG,!
 F XTBLN=0:0 S XTBLN=$O(^TMP($J,XTBLN)) Q:XTBLN=""  W ^TMP($J,XTBLN,0),! I $Y>(IOSL-5) S PG=PG+1 D PAUSE W @IOF,!,XTBHDR,?(IOM-12),"Page: ",PG,!!
 K XTBPSTD G EXIT
 ;
PAUSE W !,"Press RETURN to continue or '^' to exit: " R XTBANS:DTIME
 I XTBANS["^" S XTBLN=9999
 Q
 ;
MG F XTBMG=0:0 S XTBMG=$O(^XPD(9.95,1,1,"B",XTBMG)) Q:XTBMG=""  DO
 .S XTBMGN=$P(^XMB(3.8,XTBMG,0),U)
 .S XMY("G."_XTBMGN)=""
 S XMY("G.XTPM PATCH MONITOR USER")="",XMY(.5)=""
 Q
