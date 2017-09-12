PSB0000 ;BIR/JLC - BUILD APATCH CROSS-REFERENCE ;04/01/02
 ;;2.0;BAR CODE MED ADMIN;;May 2002
 Q
EN I $G(DUZ)="" W !,"Your DUZ is not defined.  It must be defined to run this routine." Q
 K ZTSAVE,ZTSK S ZTRTN="ENQN^PSB0000",ZTDESC="Build PATCH cross-reference",ZTIO="" D ^%ZTLOAD
 W !!,"The build of the PATCH xref is",$S($D(ZTSK):"",1:" NOT")," queued",!
 I $D(ZTSK) D
 . W " (to start NOW).",!!,"YOU WILL RECEIVE A MAILMAN MESSAGE WHEN TASK #"_ZTSK_" HAS COMPLETED."
 Q
ENQN ;first - delete the old style cross reference
 D DELIX^DDMOD(53.795,.04,2,"K")
 S IEN=0
 F  S IEN=$O(^PSB(53.79,IEN)) Q:'IEN  D
 . S DA(1)=IEN,DA=1,DIK="^PSB(53.79,DA(1),.5,",DIK(1)=".04^APATCH" D EN^DIK
SENDMSG ;Send mail message when check is complete.
 K PSG,XMY S XMDUZ="MEDICATIONS,INPATIENT",XMSUB="BUILD OF PATCH CROSSREFERENCE COMPLETE",XMTEXT="PSB(",XMY(DUZ)="" D NOW^%DTC S Y=% X ^DD("DD")
 S PSB(1,0)="  The build of the PATCH crossreference completed as of "_Y_"."
 D ^XMD Q
