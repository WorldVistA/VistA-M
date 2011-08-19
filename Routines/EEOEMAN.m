EEOEMAN ;HISC/JWR - EEO Manager options routine ;Apr 20, 1995
 ;;2.0;EEO Complaint Tracking;;Apr 27, 1995
 ;;
SYSPAR ;Entry point for editing system parameters
 W !! S DIR(0)="SAO^1:Reassign Counselor Security;2:Edit Default EEO Officer"
 S DIR("A")="Selection: "
 S DIR("A",1)="Choose One of the Following:",DIR("A",1.5)=" "
 S DIR("A",2)="   1  Reassign Counselor Security",DIR("A",3)="   2  Edit Default EEO Officer",DIR("A",4)=" " D ^DIR Q:Y["^"
 Q:Y<1  I Y'>1 D SECOP^EEOUTIL G SYSPAR
 W !!,"       Enter/Edit EEO Officer Information",!!
 S DIE=789.5,DR="3",DA=1 D ^DIE
 I $G(X)>0 W !!,"The Default EEO Officer is Now:  ",$P($G(^VA(200,X,0)),U),!!
 Q:X=""  G SYSPAR
EDINF ;Managers entry point to edit counselor information (file 785.5)
 W !!,"       Enter/Edit Counselor Information for a Formal Complaint",!!
 K DO,DD,D0 S DIC="^EEO(785.5,",DIC(0)="AEMQZ"
 S DIC("A")="Select NAME: "
 D ^DIC Q:X="^"!(X="")  S EEOY=Y,DA=+Y,DIE=785
 S DIE=785.5,(DA,DINUM)=+EEOY
 D DRS1^EEOENF
 K EEOY,DIC,DR,DIE,DLAYGO,CN,EEO2,EEOF,EEOINF W ! G EDINF
 Q
ACKNO Q:'$D(EEOC)
 S Y=DT D DD^%DT S EEODT=Y
 S CN="" S CN=$O(EEOC(CN)),EEOOF=$P(^VA(200,$P(EEOC(CN),U,2),0),U)
 S $P(EEOMRK," ",18)="",$P(EEOMRK,"=",42)=""
 F CNU=1,5,6,11,13,14,15 S TMP("EEOACK",$J,CNU)=" "
 F CNY=2,4 S TMP("EEOACK",$J,CNY)=EEOMRK
 K EEOMRK S $P(EEOMRK," ",18)="***** EEO DATA BASE SECURITY UPDATE *****",TMP("EEOACK",$J,3)=EEOMRK
 S TMP("EEOACK",$J,8)="                 DATE/TIME OF UPDATE:      "_EEODT
 S TMP("EEOACK",$J,9)="                 USER MAKING CHANGE:       "_EEOOF
 S TMP("EEOACK",$J,10)="                 Reassignment of counselor security"
 S TMP("EEOACK",$J,12)="THIS UPDATE AFFECTED THE FOLLOWING CASE(S):  ",CNO=16
 S (CNO,CNQ)=0 F  S CNQ=$O(EEOC(CNQ)) Q:CNQ'>0  D
 .S CNO=CNO+1,TMP("EEOACK",$J,CNU)="  "_(CNO)_")  "_$P($G(^EEO(785,CNQ,5)),U,6),CNU=CNU+1 D TEST
 K EEOMRK
 S XMTEXT="TMP(""EEOACK"",$J,"
 S XMY("G.UPLINK_DATA_SERVER")=""
 S XMSUB="EEO COMPLAINT STATUS CHANGE NOTIFICATION"
 S XMDUZ=.5 D ^XMD Q
TEST S (EEOCUR,EEOPREV,EEOOF)=""
 S Y=$P(EEOC(CNQ),U,4) D DD^%DT S EEOFOR=Y
 S:$P(EEOC(CNQ),U,6)>0 EEOCUR=$P(^VA(200,$P(EEOC(CNQ),U,6),0),U)
 S:$P(EEOC(CNQ),U,7)>0 EEOPREV=$P(^VA(200,$P(EEOC(CNQ),U,7),0),U)
 I $P(EEOC(CNQ),U,5)'>0 D
 .S TMP("EEOACK",$J,CNU)="         Deleted Date of Formal Complaint: "_EEOFOR
 .S TMP("EEOACK",$J,CNU+1)="         Counselor Currently Assigned:      "_EEOCUR
 .S TMP("EEOACK",$J,CNU+2)="    * The couselor may now edit informal information for this case"
 .S TMP("EEOACK",$J,CNU+3)=" ",CNU=CNU+4,EEOPT=0
 I $P(EEOC(CNQ),U,5)=1 S EEOCUR=$P(EEOC(CNQ),U,6),EEOPREV=EEOFOR D
 .S TMP("EEOACK",$J,CNU)="         Previously Assigned Counselor: "_EEOFOR
 .S TMP("EEOACK",$J,CNU+1)="         Counselor Currently Assigned:  "_EEOCUR
 .S TMP("EEOACK",$J,CNU+2)=" ",CNU=CNU+3,EEOPT=0
 ;S:EEOCUR'="" XMY(EEOCUR)="" S:EEOPREV'="" XMY(EEOPREV)=""
 K EEOPREV,EEOCUR,EEOFOR Q
KILL K XMY,EEOC,XMTEXT,XMSUB
