SPNUTL1 ;HISC/DAD-REGISTRY/FIM DELETE ;11/7/95  12:10
 ;;2.0;Spinal Cord Dysfunction;**14,15,20**;01/02/1997
EN1 ; *** Delete SCD Registry records
 S SPNDIC="^SPNL(154,",SPNFILE=154
 S SPNDIC("W")="W ?36,$$SSN^SPNUTL1(+Y)"
 S SPNNAME="Registry"
 D DELETE
 K SPNEXIT,DA,DR,SPNNAM,DIC,DIR,^TMP($J)
 Q
 ;
EN2 ; *** Delete FIM records
 S SPNDIC="^SPNL(154.1,",SPNFILE=154.1
 S SPNDIC("W")="W:$X>36 ! W ?36,$$SSN^SPNUTL1(+Y),?48,$E($$FIMTYPE^SPNUTL1(+Y),1,18),?68,$$FIMDATE^SPNUTL1(+Y)"
 S SPNNAME="Outcomes"
 D DELETE
 K DIC
 Q
 ;
DELETE ; *** Delete a record
 S (SPNEXIT,SPNCOUNT)=0
 K ^TMP($J,"SPNUTL1")
 F  D  Q:SPNEXIT
 . K DIC S DIC=SPNDIC,DIC(0)="AEMQZ"
 . S DIC("A")="Select "_SPNNAME_" Record to Delete: "
 . S DIC("W")=SPNDIC("W")
 . W ! D ^DIC S SPND0=+Y,SPNDFN=+$P($G(Y(0)),U)
 . I SPND0'>0 S SPNEXIT=1 Q
 . I SPNFILE="154" I $D(^SPNL(154.1,"B",SPNDFN)) D REMOUT Q
 . K DIR S DIR(0)="YOA",DIR("B")="No"
 . S DIR("A")="OK to delete this record: "
 . S DIR("?",1)="Enter Y(es) to delete this record."
 . S DIR("?",2)="Enter N(o) to leave this record as is."
 . S DIR("?",3)="Enter ^ to exit this option."
 . S DIR("?")="Enter Y(es), N(o), or ^."
 . W ! D ^DIR S SPNLDEL=Y
 . I $D(DTOUT)!$D(DUOUT)!$D(DIROUT) S SPNEXIT=1 Q
 . I SPNLDEL'>0 Q
 . S SPNCOUNT=SPNCOUNT+1
 . S X=$E($P($G(^DPT(SPNDFN,0)),U,1),1)_$E($P($G(^DPT(SPNDFN,0)),U,9),6,9)
 . I SPNFILE=154.1 D
 .. S X=X_$J("",10-$L(X))_$E($$FIMTYPE(SPND0),1,18)
 .. S X=X_$J("",36-$L(X))_$$FIMDATE(SPND0)
 .. Q
 . S ^TMP($J,"SPNUTL1",SPNCOUNT)=X
 . S DIK=SPNDIC,DA=SPND0
 . D ^DIK D SEND S SPNEXIT=1
 . Q:SPNEXIT=1
 . I SPNFILE=154 D
 .. S DIK="^SPNL(154.9,",DA=SPND0
 .. D ^DIK
 .. D SEND S SPNEXIT=1
 .. Q
 . Q
 Q:SPNEXIT
SEND ;
 I SPNCOUNT D
 . S SPNMLGRP="SPNL SCD COORDINATOR"
 . W !!,"Sending deletion notification to the "
 . W SPNMLGRP," mail group...",!
 . D KILL^XM
 . S X="The following patient"_$S(SPNCOUNT>1:"s were",1:" was")
 . S X=X_" deleted from the"
 . S ^TMP($J,"SPNUTL1",.1)=X
 . S X=SPNNAME_" file on "_$$FMTE^XLFDT(DT)
 . S X=X_" by "_$$GET1^DIQ(200,DUZ,.01)
 . S ^TMP($J,"SPNUTL1",.2)=X
 . S ^TMP($J,"SPNUTL1",.3)=""
 . S XMSUB=SPNNAME_" File Deletion Notification"
 . S XMTEXT="^TMP($J,""SPNUTL1"","
 . S XMY("G."_SPNMLGRP_"@"_$G(^XMB("NETNAME")))=""
 . S (XMDUZ,XMDUN)="<SCD Registry Package>"
 . D ^XMD
 . Q
 ;
 D KILL^XM
 K D0,DA,DFN,DIC,DIK,DIR,DIROUT,DIRUT,DTOUT,DUOUT,SPNCOUNT
 K SPND0,SPNDFN,SPNDIC,SPNEXIT,SPNFILE,SPNMLGRP,SPNNAME,X,Y
 K ^TMP($J,"SPNUTL1")
 Q
 ;
SSN(D0) ; *** SSN Identifier
 N DFN S DFN=+$P($G(^SPNL(SPNFILE,D0,0)),U)
 Q $$GET1^DIQ(2,DFN,.09)
 ;
FIMDATE(D0) ; *** FIM Date Identifier
 Q $$GET1^DIQ(154.1,D0,.04)
 ;
FIMTYPE(D0) ; *** FIM Type Identifier
 Q $$GET1^DIQ(154.1,D0,.02)
 Q
REMOUT ;tag to delete all outcomes on file when the user is deleting the
 ;ien in 154.  Cleans up 154.1
 Q:'$D(^SPNL(154.1,"B",SPNDFN))
 W !!,"This patient has Outcome records on file and they must be removed before"
 W !,"we remove the patient from the REGISTRY file."
 W !?15,"The removal cannot be reversed!" W !?15,"Do you want to continue?"
 S %=1 D YN^DICN Q:%=2
 Q:%'=1
 S SPNCOUNT=1
 S SPNFILE=154.1
 S SPNNAME="Registry & Outcomes"
 S SPNOUT=0 F  S SPNOUT=$O(^SPNL(154.1,"B",SPNDFN,SPNOUT)) Q:(SPNOUT="")!('+SPNOUT)  D
 . I SPNCOUNT=1 S X=$E($P($G(^DPT(SPNDFN,0)),U,1),1)_$E($P($G(^DPT(SPNDFN,0)),U,9),6,9),X=X_$J("",10-$L(X))_"Registry entry",^TMP($J,"SPNUTL1",SPNCOUNT)=X
 . S X="",SPNCOUNT=SPNCOUNT+1
 . S SPNCOUNT=SPNCOUNT+1
 . S X=$E($P($G(^DPT(SPNDFN,0)),U,1),1)_$E($P($G(^DPT(SPNDFN,0)),U,9),6,9)
 . S X=X_$J("",10-$L(X))_$E($$FIMTYPE(SPNOUT),1,18)
 . S X=X_$J("",36-$L(X))_$$FIMDATE(SPNOUT)
 . S ^TMP($J,"SPNUTL1",SPNCOUNT)=X
 . S DIK="^SPNL(154.1,",DA=SPNOUT
 . D ^DIK
 S DIK="^SPNL(154,",DA=SPNDFN
 D ^DIK
 D SEND
 S SPNEXIT=1
 Q
