ORLPL ; slc/CLA - Display/Edit Patient Lists; 8/8/91
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;;Dec 17, 1997
GETDEF ;called by SETUP, ASKLIST^ORLP, INQ^ORLP1 - get a default list from ^TMP or user's primary list
 N LST
 I $D(^TMP("ORLP",$J,"TLIST")) S DIC("B")=^TMP("ORLP",$J,"TLIST") Q
 ;if user has a primary list defined, its type is team, users are defined and the current user is on the list, use the primary list as the default
 S LST=$$GET^XPAR("USR.`"_DUZ,"ORLP DEFAULT TEAM",1,"I") I +$G(LST)>0,$D(^OR(100.21,LST,0)) S DIC("B")=$P(^(0),U)
 Q
SETUP ;called by DELUSER, DELPT - setup list for display and editing
 S LIST=Y,^TMP("ORLP",$J,"TLIST")=+Y
 K DIC,^XUTL("OR",$J),Y
 Q
DELUSER ;called by option ORLP DELETE TEAM USERS - removes provider/users from a list
 S ET="U",DIC="^OR(100.21,",DIC(0)="AEMQ",DIC("S")="I $P(^(0),U,2)'=""P""",DIC("A")="Select TEAM PATIENT list: "
 D ^DIC I Y<1 D END Q
 D SETUP
 ;if no users on list goto NOENTRY
 I '$D(^OR(100.21,+LIST,1,0)) G NOENTRY
 I $P(^OR(100.21,+LIST,1,0),"^",4)=""!($P(^(0),"^",4)=0) G NOENTRY
 S ORUS="^OR(100.21,+LIST,1,",ORUS(0)="40MN",ORUS("T")="W @IOF,?34,""OWNER LIST"",!",ORUS("A")="Enter Provider/user(s) to REMOVE from list: "
 D ^ORUS
 I ($D(Y)<10) G END
 S I=0 W ! F  S I=$O(Y(I)) Q:I<1  S DA(1)=+LIST,DA=+Y(I),DIK="^OR(100.21,"_DA(1)_",1," D
 . N Y D ^DIK
 W !,"Provider/user(s) removed from list."
 D END
 Q
DELPT ;called by option ORLP DELETE TEAM PATIENTS - removes patients from a list
 S ET="P",DIC="^OR(100.21,",DIC(0)="AEMQ",DIC("S")="I $P(^(0),U,2)[""M""",DIC("A")="Select TEAM PATIENT list: "
 D ^DIC I Y<1 D END Q
 D SETUP
 ;if no patients on list goto NOENTRY
 I '$O(^OR(100.21,+LIST,10,0)) G NOENTRY
 I $P(^OR(100.21,+LIST,0),U,2)="TA" D  D END Q
 . S A(1)="",A(2)="This 'TEAM PATIENT' list is an AUTOLINK list."
 . S A(3)="In order to remove patients from this TEAM PATIENT list you must remove the"
 . S A(4)="AUTOLINK(s).",A(5)="" D EN^DDIOL(.A) K A
 . S DIR(0)="YO",DIR("A")="Do you want to remove Autolinks",DIR("B")="Y" D ^DIR K DIR Q:$D(DIROUT)  I Y=1 D ASKLINK^ORLP2(+LIST)
 S ORUS="^OR(100.21,+LIST,10,",ORUS(0)="40MN",ORUS("T")="W @IOF,?32,""PATIENT LIST"",!",ORUS("A")="Enter patient(s) to REMOVE from list: "
 D ^ORUS
 I ($D(Y)<10) G END
 S I=0 W ! F  S I=$O(Y(I)) Q:I<1  S DA(1)=+LIST,DA=+Y(I),DIK="^OR(100.21,"_DA(1)_",10," D
 . N Y D ^DIK
 W !,"Patient(s) removed from list."
 D END
 Q
NOENTRY ;called by DELUSER, DELPT - indicate no entries in file/record/field
 W !!,"There are no ",$S(ET="U":"provider/user ",ET="P":"patient ",1:""),"entries in this list to edit!"
END K DA,DIC,DIK,ET,I,J,LIST,ORUS,RESP,Y
 Q
