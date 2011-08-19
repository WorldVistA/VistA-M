LBRVCON1 ;SSI/ALA/JSR-Consolidate library files continued ;[ 04/20/2000  8:35 AM ]
 ;;2.5;Library;**3,8**;APR 19, 2000
INF ;  Inform FORUM when integration is completed for VA library sites
 S CODE="" F I=1:1 S CODE=$O(^LBRY(680.6,"C",CODE)) Q:CODE=""  D
 . S MES(I)="Library Station "_$G(CODE)_" has been integrated." Q
 S MES(I+1)="Please update associated DOMAINs."
 S TRNSM=$S($G(^XMB("NETNAME"))["SENTIENT":"BBB.SENTIENT.ISC-WASH.VA.GOV",1:"FORUM.VA.GOV")
 S XMDUZ=DUZ,XMSUB="LIBRARY PATCH 8 LOADED",XMY("G.LBRYRECV@"_TRNSM)=""
 S XMTEXT="MES("
 D ^XMD K XMSUB,XMY,XMTEXT,MSG,XMZ,XMDUZ,MES,TRNSM
EXIT D MES^LBRPUTL("I am now re-indexing all cross-references/Patch 8")
 D REINDX
 Q
REINDX ; reindex crossreferences
 W !
 F J=680,681,682,680.4,680.7,680.3,680.5 S LX="A" F  S LX=$O(^LBRY(J,LX)) Q:LX=""  K ^LBRY(J,LX)
 F DIK="^LBRY(680,","^LBRY(681,","^LBRY(682,","^LBRY(680.4,","^LBRY(680.7,","^LBRY(680.3,","^LBRY(680.5," D
 . W DIK,! D IXALL^DIK
 D MES^LBRPUTL("Patch 8 The integration has completed successfully.")
 Q
