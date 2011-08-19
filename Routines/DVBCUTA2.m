DVBCUTA2 ;ALB/GTS-AMIE C&P UTILITY ROUTINE A-2 ; 2/8/95  11:15 AM
 ;;2.7;AMIE;;Apr 10, 1995
 ;
 ;** Version Changes
 ;   2.7 - New routine (Enhc 15)
 ;
INSUFXM ;** Insufficient exam information entry (Called from DVBCREDT)
 K DIR,Y
 N EXMNM,XMSTAT,XMDA,REQDA
 S REQDA=SAVEDA
 I $D(^DVB(396.3,REQDA,5)),NODE5=^DVB(396.3,REQDA,5) DO
 .W !
 .D XMQS
 .I +Y=1 DO
 ..K DIR,Y
 ..K DTOUT,DUOUT
 ..F XMDA=0:0 S XMDA=$O(^DVB(396.4,"C",REQDA,XMDA)) Q:(XMDA=""!($D(DTOUT)))  D XMUPDT
 .K DIR,Y
 I $D(^DVB(396.3,REQDA,5)),(NODE5'=^DVB(396.3,REQDA,5)) DO
 .D EXMEDIT
 .I $D(XMEDT) DO
 ..K DTOUT
 ..D SAVEXAM ;**Save exam info in case time out
 ..F XMDA=0:0 S XMDA=$O(^DVB(396.4,"C",REQDA,XMDA)) Q:(XMDA=""!($D(DTOUT)))  D XMUPDT
 ..I $D(DTOUT) D RESTLINK,RESTXAMS ;**Restore link and exam info
 .I '$D(XMEDT) DO  ;**Update original provider automatically
 ..F XMDA=0:0 S XMDA=$O(^DVB(396.4,"C",REQDA,XMDA)) Q:XMDA=""  D PROVUP
 K Y,^TMP($J,"NEW"),XMEDT,^TMP("DVBC",$J,396.4)
 Q
 ;
XMUPDT ;** Update exam insuf info
 W @IOF
 S EXMNM=$P(^DVB(396.6,$P(^DVB(396.4,XMDA,0),U,3),0),U,1)
 S ^TMP($J,"NEW",EXMNM)=$P(^DVB(396.4,XMDA,0),U,3)
 S XMSTAT=$P(^DVB(396.4,XMDA,0),U,4),Y=XMDA ;**Set var's for INSXM
 N DVBAINDA S DVBAINDA=$P(^DVB(396.3,REQDA,5),U,1)
 D:(XMSTAT'["X"&(XMSTAT'="T")) INSXM^DVBCUTA1 ;**Update exam info
 Q
 ;
PROVUP ;** Auto update original provider
 K DIE,Y,DR,DA
 N DVBAXMTP,DVBAPROV,DVBAORXM,DVBACMND,DVBAINDA
 S DVBAINDA=+$P(^DVB(396.3,REQDA,5),U,1)
 S DVBAXMTP=$P(^DVB(396.4,XMDA,0),U,3),DVBAORXM="",DVBAPROV=""
 S DVBACMND="S DVBAORXM=$O(^DVB(396.4,""ARQ"_DVBAINDA_""","_DVBAXMTP_",DVBAORXM))"
 N XREF S XREF="ARQ"_DVBAINDA
 I $D(^DVB(396.4,XREF,DVBAXMTP)) X DVBACMND ;**Return insuff exam IEN
 S:+DVBAORXM>0 DVBAPROV=$P(^DVB(396.4,DVBAORXM,0),U,7)
 I DVBAPROV="" DO
 .S DVBAPROV="Unknown" ;**Bad 'ARQ' X-Ref
 K DVBADMNM
 I +DVBAORXM>0,($D(^DVB(396.4,DVBAORXM,"TRAN"))) DO
 .S DVBADMNM=$P(^DIC(4.2,+$P(^DVB(396.4,DVBAORXM,"TRAN"),U,3),0),U,1)
 .S DVBADMNM=$P(DVBADMNM,".",1)
 S:$D(DVBADMNM) DVBAPROV=DVBAPROV_" at "_DVBADMNM
 S DIE="^DVB(396.4,",DR=".12////^S X=DVBAPROV",DA=XMDA
 D ^DIE K DIE,DR,DA
 Q
 ;
RESTLINK ;** Restore 2507 link info (Called from ^DVBCREDT & INSUFXM)
 N LINKDA,DAYS
 S LINKDA=$P(NODE5,U,1)
 S DAYS=$P(NODE5,U,2)
 S:LINKDA="" LINKDA="@"
 S:DAYS="" DAYS="@"
 K DA,DR,DIE
 S DIE="^DVB(396.3,"
 S DA=REQDA,DR="44////^S X=LINKDA;45////^S X=DAYS"
 D ^DIE
 K DA,DR,DIE
 S TVAR(1,0)="1,3,0,2:1,0^All exams must be reviewed....Insufficient link and info not updated!"
 D WR^DVBAUTL4("TVAR")
 K TVAR
 D CONTMES^DVBCUTL4
 Q
 ;
EXMEDIT ;** Ask user to edit exams
 I '$D(UPDT2507)!((+$P(^DVB(396.3,REQDA,5),U,1)>0)&($D(UPDT2507))) DO
 .D XMQS
 .S:+Y=1 XMEDT=""
 I (+$P(^DVB(396.3,REQDA,5),U,1)'>0)&($D(UPDT2507)) DO
 .S TVAR(1,0)="1,3,0,2:1,0^Review exam info for a new Original Provider."
 .D WR^DVBAUTL4("TVAR")
 .K TVAR
 .S XMEDT=""
 .D CONTMES^DVBCUTL4
 Q
 ;
XMQS ;** Edit exams?
 S DIR(0)="Y^AO",DIR("A")="Do you want to edit the insufficient information for the exams"
 S DIR("?",1)="Enter Yes to edit Remarks, Insufficient Reason and Original Providor (when"
 S DIR("?")=" appropriate).  Enter No to keep the current information."
 S DIR("B")="NO" D ^DIR
 Q
 ;
SAVEXAM ;** Save exam info prior to edit
 N REMDA,XMDA
 F XMDA=0:0 S XMDA=$O(^DVB(396.4,"C",REQDA,XMDA)) Q:XMDA=""  DO
 .S ^TMP("DVBC",$J,396.4,XMDA,0)=$P(^DVB(396.4,XMDA,0),U,11)_"^"_$P(^DVB(396.4,XMDA,0),U,12)
 .F REMDA=0:0 S REMDA=$O(^DVB(396.4,XMDA,"INREM",REMDA)) Q:REMDA=""  DO
 ..S ^TMP("DVBC",$J,396.4,XMDA,"INREM",REMDA,0)=^DVB(396.4,XMDA,"INREM",REMDA,0)
 Q
 ;
RESTXAMS ;** Restore exam information  (Called from INSUFXM)
 N REMDA,XMDA,REASDA,PROV,REMARK,LNCNT,XMSTAT
 F XMDA=0:0 S XMDA=$O(^DVB(396.4,"C",REQDA,XMDA)) Q:XMDA=""  DO
 .S XMSTAT=$P(^DVB(396.4,XMDA,0),U,4)
 .I (XMSTAT'["X")&(XMSTAT'["T") DO
 ..S REASDA=$P(^TMP("DVBC",$J,396.4,XMDA,0),U,1)
 ..S PROV=$P(^TMP("DVBC",$J,396.4,XMDA,0),U,2)
 ..K DIE,DR,DA
 ..S DIE="^DVB(396.4,",DR=".11////^S X=REASDA;.12////^S X=PROV;80////@",DA=XMDA
 ..D ^DIE
 ..S LNCNT=0
 ..S:'$D(^DVB(396.4,XMDA,"INREM",0)) ^DVB(396.4,XMDA,"INREM",0)="^^0^0^"_DT_"^"
 ..F REMDA=0:0 S REMDA=$O(^TMP("DVBC",$J,396.4,XMDA,"INREM",REMDA)) Q:REMDA=""  DO
 ...S REMARK=^TMP("DVBC",$J,396.4,XMDA,"INREM",REMDA,0)
 ...S LNCNT=LNCNT+1
 ...S ^DVB(396.4,XMDA,"INREM",REMDA,0)=REMARK
 ..S ^DVB(396.4,XMDA,"INREM",0)="^^"_LNCNT_"^"_LNCNT_"^"_DT_"^"
 Q
