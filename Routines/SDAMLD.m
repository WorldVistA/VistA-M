SDAMLD ;ALB/CAW - Ambulartory Status Update Log Utilities ; 3/6/92
 ;;5.3;Scheduling;;Aug 13, 1993
 ;
EN D DT^DICRW S X=$T(+1),DIK="^DOPT("""_$P(X," ;",1)_""","
 G:$D(^DOPT($P(X," ;"),4)) A S ^DOPT($P(X," ;"),0)=$P(X,";",3)_"^1N^" F I=1:1 S Y=$T(@I) Q:Y=""  S ^DOPT($P(X," ;"),I,0)=$P(Y,";",3,99)
 D IXALL^DIK
A ;
 W !! S DIC="^DOPT("""_$P($T(+1)," ;")_""",",DIC(0)="IQEAM" D ^DIC Q:Y<0  D @+Y G A
 ;
1 ;;Update Appointment Status
 ;
 G EN^SDAMQ
 ;
2 ;;View Log Date (single entry)
 ;
 S SDEF="LAST"
SELECT W !!,"Select APPOINTMENT DATE: "_$S(SDEF]"":SDEF_"// ",1:"") R SDWHEN:DTIME
 I '$T!(SDWHEN["^") G Q2
 I SDEF="",SDWHEN="" G Q2
 I SDEF]"",SDWHEN="" S SDWHEN=SDEF
 I $$UPPER^VALM1(SDWHEN)=$E("LAST",1,$L(SDWHEN)) W $E("LAST",$L(SDWHEN)+1,4) S D0=$$LAST() G SHOW:D0 W !,*7,"o  update has not completed in the last 100 days" G SELECT
 ;
 S X=SDWHEN,DIC="^SDD(409.65,",DIC(0)="EMQ" D ^DIC K DIC G SELECT:Y<0 S D0=+Y
 ;
SHOW S SDEF="",X="SDAMXLD" X ^%ZOSF("TEST") I $T W:$D(IOF) @IOF W "Appointment Status Log" K DXS D HEAD^SDAMXLD,^SDAMXLD K DXS G SELECT
 S D0=DA,DIC="^SDD(409.65," D EN^DIQ G SELECT
Q2 K SDWHEN,SDEF,D0,Y,X,DA,DIC Q
 ;
3 ;;View Log Date (date range)
 ;
 N SDT00,SDBD,SDED,BEGDATE,ENDDATE,X
 S SDT00="AEX" D DATE^SDUTL G:'$D(SDED) Q3
 S L=0,FLDS="[SDAMVLD]",BY="@.01",FR=SDBD,TO=SDED
 S DHD="Appointment Status Update Log from "_$$FTIME^VALM1(BEGDATE)_" to "_$$FTIME^VALM1(ENDDATE)
 S DIC="^SDD(409.65," D EN1^DIP
Q3 Q
 ;
4 ;;Purge log entries (data will be kept for current+1 FYs)
 ;
 N SDLFY,SDMAX,SDBD,SDED,BEGDATE,ENDDATE,SDLIM,SDT00,X,Y
 S SDLIM=($E(DT,1,3)-$S($E(DT,4,5)>9:1,1:2))_"1001"
 W !,"This option will not purge dates beyond " S X1=SDLIM,X2=-1 D C^%DTC S (Y,SDLFY,SDMAX)=X D DT^DIQ W "."
 S %DT(0)=-X,SDT00="AEX" D DATE^SDUTL G:'$D(SDED) Q4 S SDCNT=0
 I SDED<SDMAX S SDMAX=SDED
 S Y=$$QUE
 Q
 ;
EN4 ;
 N DIK,SDI,DA,SDCNT
 S DIK="^SDD(409.65,",SDCNT=0
 F SDI=SDBD:0 S SDI=$O(^SDD(409.65,"B",SDI)) Q:'SDI!(SDI>SDMAX)  S DA=$O(^(SDI,0)) D ^DIK S SDCNT=SDCNT+1
 D BULL
Q4 Q
 ;
LAST() ;
 ; input - no input (user selection of last)
 ; output - the latest date, beginning day or -100 days
 ;
 N SDI,LAST
 F SDI=0:1:100 S X1=DT,X2=-SDI D C^%DTC S LAST=$O(^SDD(409.65,"B",X,0)) S LAST1=$P($G(^SDD(409.65,+LAST,0)),U,5) Q:LAST1
 Q LAST
BULL ; Bulletin for purge
 N SDLN,SDMSG
 K ^TMP("SDAMLBL",$J)
 S SDLN=0,XMSUB="APPOINTMENT STATUS UPDATE LOG PURGE" K XMY
 S XMTEXT="^TMP(""SDAMLBL"",$J,"
 S XMY($S(DUZ:DUZ,1:.5))=""
 S XMDUZ=.5 D NOW^%DTC
 S SDMSG=" " D SETLN
 S SDMSG="The Appointment Status Update Log Purge was completed "_$$FTIME^VALM1(%)_"." D SETLN
 S SDMSG=" " D SETLN
 S SDMSG=SDCNT_" records were purged from "_$$FDATE^VALM1(SDBD)_" to "_$$FDATE^VALM1(SDED)_"." D SETLN
 D ^XMD
 K ^TMP("SDAMLBL",$J),XMY,XMTEXT,XMSUB
 Q
 ;
SETLN ; Setting TMP global for bulletin
 S SDLN=SDLN+1
 S ^TMP("SDAMLBL",$J,SDLN)=SDMSG
 Q
QUE() ; -- que job
 ; return: did job que [ 1|yes   0|no ]
 ;
 K ZTSK,IO("Q")
 S ZTIO="",ZTDESC="Appointment Update Log Status Purge",ZTRTN="EN4^SDAMLD"
 F X="SDBD","SDED","SDMAX","DUZ" S ZTSAVE(X)=""
 D ^%ZTLOAD W:$D(ZTSK) "   (Task: ",ZTSK,")"
 Q $D(ZTSK)
