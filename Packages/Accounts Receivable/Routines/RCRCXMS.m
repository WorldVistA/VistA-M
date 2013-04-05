RCRCXMS ;ALB/CMS - RC TRANSMISSION MESSAGE HANDLER ; 16-JUN-00
V ;;4.5;Accounts Receivable;**63,159**;Mar 20, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 Q
 ;
ENT(RCDA,RCSUB,RCWHO,RCCOM) ;RC Transmission information
 ;add RC TRANSMISSION TO FILE 349.3
 N DA,DIC,DIE,DLAYGO,DR,RCPDT,RCSND,X,Y
 K DD,DO
 I 'RCDA G ENTQ
 S RCD=$O(^RCT(349.3,"B",RCDA,0)) I RCD G ENTE
 S X=RCDA,DIC="^RCT(349.3,",DIC(0)="L",DLAYGO=349.3
 D FILE^DICN S RCD=+Y K DD,DO I RCD<1 G ENTQ
ENTE S DA=RCD S DIE="^RCT(349.3,"
 S RCSND=$E($P($G(^VA(200,+DUZ,0)),U,1),1,45)
 S RCSND=$S(RCSND]"":RCSND,1:"POSTMASTER")
 D PURG
 ;if entry is from RC via the RC Server
 I $G(RCSCE)="O" S RCSND=$G(XMFROM)
 S DR="1////"_$E(RCSUB,1,45)_";2////"_RCSND_";4////"_DT
 S DR=DR_";8////"_+$G(RCPDT)_";3////"_$E(RCWHO,1,45)_";7///"_$G(RCCOM)
 D ^DIE
 S RCCOM="Transmitted to RC in MM #["_RCDA_"] containing "_+$G(RCCNT)_" bill(s)."
ENTQ Q
 ;
PURG ;Get Purge Date
 N X1
 S X1=$O(^RCT(349.1,"B","RC",0))
 I 'X1 G PURGQ
 S X1=+$P(^RCT(349.1,X1,0),U,4)
 S RCPDT=$$FMADD^XLFDT(DT,$S($G(X1):X1,1:30))
PURGQ Q
 ;
SITE ;RC Site Parameter Edit
 N D1,DA,DIC,DIE,DIK,DTOUT,DR,RCDA,RCSITE,X,Y
 S (RCDA,DA)=$O(^RCT(349.1,"B","RC",0)),DIE="^RCT(349.1,"
 S RCSITE=$P($$SITE^RCMSITE,U,2)
 I 'DA G SITEQ
 ;S DR=".04;W !!,""Primary Division: "",$P($G(^DIC(4,$$SITE^RCMSITE,0)),U,1);32R~PRIMARY RC REMOTE DOMAIN"_";I $E($G(^DIC(4.2,X,0)),1,3)'=""RC-"" W !,""   <<RC DOMAIN MUST START WITH 'RC-'>>"" S Y=32" D ^DIE
 S DR=".04;W !!,""Primary Division: "",$P($G(^DIC(4,$$SITE^RCMSITE,0)),U,1);34R~RC MAIL ADDRESS"_";I $E($G(X),1,3)'=""OGC""!($E($G(X),7,20)'=""RI@MAIL.domain.ext"") D MAILADD^RCRCXMS S Y=34"
 S DR=DR_";35R~RC DEATH NOTIFICATION ADDRESS"_";I $E($G(X),1,9)'=""OGCRegion"" D DEATHADD^RCRCXMS S Y=35" D ^DIE
 I ($D(DTOUT))!($D(Y)) G SITEQ
 ;
DR61 W !!,"Enter Division(s) of care if domain is different then primary RC Mail Address.",!
 S DR=61
 ;S DR(2,349.161)=".01;.02R~RC MAIL ADDRESS"_";I $E($G(^DIC(4.2,X,0)),1,3)'=""RC-"" W !,"" <<RC DOMAIN MUST START WITH 'RC-'>>"" S Y=.02" D ^DIE
 S DR(2,349.161)=".01;.03R~RC MAIL ADDRESS"_";I $E($G(X),1,3)'=""OGC""!($E($G(X),7,20)'=""RI@MAIL.domain.ext"") D MAILADD^RCRCXMS S Y=.03"_";N RCFLAG D DIK^RCRCXMS I $G(RCFLAG) S Y=.01"
 S DR(2,349.161)=DR(2,349.161)_";.04R~RC DEATH NOTIFICATION ADDRESS"_";I $E($G(X),1,9)'=""OGCRegion"" D DEATHADD^RCRCXMS S Y=.04" D ^DIE
 ;S DR(2,349.161)=".04R~RC DEATH NOTIFICATION ADDRESS"_";I $E($G(X),1,3)'=""OGC""!($E($G(X),7,20)'=""RI@MAIL.domain.ext"") D DEATHADD^RCRCXMS S Y=.04" D ^DIE
 ;
SITEQ Q
 ;
DIK ;If the RC address is the same as the primary,the entry will be deleted.
 I X=$P($G(^RCT(349.1,RCDA,3)),U,4) W !!,"<< DELETING ENTRY.  Domain same as Primary RC Remote Domain.>>",!! D
 .S DA(1)=RCDA,DIK="^RCT(349.1,"_RCDA_",6,",DA=D1 D ^DIK
 .S RCFLAG=1
 .Q
 Q
MAILADD ;MAIL ADDRESS FOR REGIONAL COUNSEL
 W !!,"Please enter an Regional Counsel mail address that adheres to the"
 W !,"following format:"
 W !!," The first three characters must be 'OGC'"
 W !," Characters 7 through 20 should be 'RI@MAIL.domain.ext'"
 W !!,"Choose one of the following RC addresses:",!
 N RCCT,RCMAIL,RCUP
 F RCCT=1:1 S RCMAIL=$P($T(ADDR+RCCT),";;",2) Q:RCMAIL="END"!(+$G(RCUP))  D
 .I RCCT=15 R !,"""^"" TO QUIT: ",X:DTIME S:X="^" RCUP=1 Q:X="^"  W $C(13),$J("",15),$C(13)
 .W !,$P(RCMAIL,"^",1)
 .Q
 Q
DEATHADD ;DEATH ADDRESSES FOR REGIONAL COUNSEL
 W !!,"Please enter the Death Notification mail address adhering to"
 W !,"the following format:"
 W !!," The first nine characters must be 'OGCRegion'"
 W !," followed by a number from 1-23"
 W !," followed by 'DeathNotification@mail.domain.ext'"
 W !!," Choose from one of the following:",!
 N RCCT,RCMAIL,RCUP
 F RCCT=1:1 S RCMAIL=$P($T(ADDR+RCCT),";;",2) Q:RCMAIL="END"!(+$G(RCUP))  D
 .I RCCT=15 R !,"""^"" TO QUIT: ",X:DTIME S:X="^" RCUP=1 Q:X="^"  W $C(13),$J("",15),$C(13)
 .W !,$P(RCMAIL,"^",2)
 .Q
 Q
ADDR ;
 ;;OGCBOSRI@MAIL.domain.ext^OGCRegion1DeathNotification@mail.domain.ext
 ;;OGCNYNRI@MAIL.domain.ext^OGCRegion2DeathNotification@mail.domain.ext
 ;;OGCBALRI@MAIL.domain.ext^OGCRegion3DeathNotification@mail.domain.ext
 ;;OGCPHIRI@MAIL.domain.ext^OGCRegion4DeathNotification@mail.domain.ext
 ;;OGCATLRI@MAIL.domain.ext^OGCRegion5DeathNotification@mail.domain.ext
 ;;OGCBAYRI@MAIL.domain.ext^OGCRegion6DeathNotification@mail.domain.ext
 ;;OGCCLERI@MAIL.domain.ext^OGCRegion7DeathNotification@mail.domain.ext
 ;;OGCNASRI@MAIL.domain.ext^OGCRegion8DeathNotification@mail.domain.ext
 ;;OGCJACRI@MAIL.domain.ext^OGCRegion9DeathNotification@mail.domain.ext
 ;;OGCCHIRI@MAIL.domain.ext^OGCRegion10DeathNotification@mail.domain.ext
 ;;OGCDETRI@MAIL.domain.ext^OGCRegion11DeathNotification@mail.domain.ext
 ;;OGCSTLRI@MAIL.domain.ext^OGCRegion12DeathNotification@mail.domain.ext
 ;;OGCWACRI@MAIL.domain.ext^OGCRegion13DeathNotification@mail.domain.ext
 ;;OGCHOURI@MAIL.domain.ext^OGCRegion14DeathNotification@mail.domain.ext
 ;;OGCMINRI@MAIL.domain.ext^OGCRegion15DeathNotification@mail.domain.ext
 ;;OGCDENRI@MAIL.domain.ext^OGCRegion16DeathNotification@mail.domain.ext
 ;;OGCLOSRI@MAIL.domain.ext^OGCRegion17DeathNotification@mail.domain.ext
 ;;OGCSFCRI@MAIL.domain.ext^OGCRegion18DeathNotification@mail.domain.ext
 ;;OGCPHORI@MAIL.domain.ext^OGCRegion19DeathNotification@mail.domain.ext
 ;;OGCPORRI@MAIL.domain.ext^OGCRegion20DeathNotification@mail.domain.ext
 ;;OGCBUFRI@MAIL.domain.ext^OGCRegion21DeathNotification@mail.domain.ext
 ;;OGCINDRI@MAIL.domain.ext^OGCRegion22DeathNotification@mail.domain.ext
 ;;OGCWINRI@MAIL.domain.ext^OGCRegion23DeathNotification@mail.domain.ext
 ;;END
EN(RCTAG) ;
 ;ENTRY POINT FROM RC TRANSMISSIONS LIST TEMPLATE
 N DA,DIC,DIQ,DIR,DR,RC,RCCNT,RCY,RCDA,RCOUT,RCT,RCTE,X,Y
 D FULL^VALM1
 I '$O(^RCT(349.3,0)) W !!,"  **  TRANSMISSION LOG EMPTY  **" G ENQ
 I '$O(^TMP("RCRCE",$J,"SEL",0)) W !!,"  **  NO ITEMS SELECTED FROM LIST  **" G ENQ
 D @$S(RCTAG="COM":"COM",RCTAG="DEL":"DEL",RCTAG="VEW":"VEW",RCTAG="FRW":"VEW",1:"ENQ")
ENQ K DIR D:$G(RCOUT)'["^" PAUSE^VALM1 Q
 ;
COM ;Append Comments to File 349.3
 N DA,DR,DIC,DIE,DIR,DIROUT,DUOUT,RCX,RCY,X,Y S RCOUT=""
 ;S DIC="^RCT(349.3,",DWLW=75,DIWEPSE="" D EN^DIWE
 ;Enter Comments for each or all?
 S RCX=0 F  S RCX=$O(^TMP("RCRCE",$J,"SEL",RCX)) Q:('RCX)!(RCOUT["^")  D
 .S DA=$G(^TMP("RCRCEX",$J,RCX)),RCLN=+DA,DA=$P(DA,U,2)
 .I '$D(^RCT(349.3,DA,0)) W !,"Item ",RCX,". Transmission Entry no longer exists.",!!
 .I $D(^RCT(349.3,DA,0)) D
 ..W @IOF,!!,"Item ",RCX,"." S (DIC,DIE)="^RCT(349.3," D EN^DIQ W ! S DR="7" D ^DIE K DR
 .W ! S DIR(0)="E" D ^DIR K DIR I $D(DIROUT)!$D(DUOUT) S RCOUT="^" Q
 .W @IOF
 S RCOUT="" W !!,"REMEMBER: Resequence List to see Appended Comments.",!
COMQ Q
 ;
DEL ;Delete entries in File 349.3
 N DA,DIK,DIR,RCLN,RCX,RCY,X,Y
 S RCY="...deleted...       "
 W @IOF W !,"Selected Items ..."
 S RCX=0 F  S RCX=$O(^TMP("RCRCE",$J,"SEL",RCX)) Q:'RCX  D
 .S RCLN=+$G(^TMP("RCRCEX",$J,RCX))
 .W !,$G(^TMP("RCRCE",$J,RCLN,0))
 W !!!,?8,"ALL ITEMS SELECTED WILL BE DELETED FROM"
 W !,?5,"TRANSMISSION LOG FILE WITHOUT FURTHER WARNING!",!!
 S DIR("A")="Okay to Continue Deletion(s) ",DIR("?")="Enter Yes to Continue with deletions"
 D ASK^RCRCACP K DIR I $G(Y)'=1 W !,"Okay nothing deleted." G DELQ
 W !!,"Deleting ..."
 S RCX=0 F  S RCX=$O(^TMP("RCRCE",$J,"SEL",RCX)) Q:'RCX  D
 .S DA=$G(^TMP("RCRCEX",$J,RCX)),RCLN=+DA,DA=$P(DA,U,2)
 .I $D(^RCT(349.3,DA,0)) D
 ..S DIK="^RCT(349.3," D ^DIK
 ..W !,$G(^TMP("RCRCE",$J,RCLN,0))
 ..D FLDTEXT^VALM10(RCLN,"SUBJECT",RCY)
 S RCOUT="" W !!,"REMEMBER: Resequence List to remove Deleted Items from list.",!
DELQ Q
 ;
VEW ;View/Forward  XM Message
 N DA,DIR,DIROUT,DUOUT,RCLN,RCX,X,Y
 S RCOUT="",RCX=0 F  S RCX=$O(^TMP("RCRCE",$J,"SEL",RCX)) Q:('RCX)!(RCOUT["^")  D
 .S DA=$G(^TMP("RCRCEX",$J,RCX)),RCLN=+DA,DA=$P(DA,U,2)
 .I '$D(^RCT(349.3,+DA,0)) W !!,"Item ",RCX,".",?5," Transmission Entry no longer exists.",!!
 .I $D(^RCT(349.3,+DA,0)) D VEWD I RCOUT="^" Q
 .W ! S DIR(0)="E" D ^DIR I $D(DIROUT)!$D(DUOUT) S RCOUT="^" Q
 .W @IOF
VEWQ Q
VEWD ;Display message
 N DIR,DIROUT,DUOUT,RCI,RCY,X,XMER,XMPOS,XMRG,XMZ,X,Y W @IOF
 S RCI=$G(^RCT(349.3,+DA,0)),XMZ=+RCI
 S RCY=$$NET^XMRENT(XMZ)
 I RCY="" W !!,RCX,".",?5," Mail Message #["_XMZ_"] no longer exists on this system.",! S XMZ=0 G VEWDQ
 W !,RCX,"."
 W !,"Subj: "_$P(RCY,U,6)_"  [#"_XMZ_"]  "_$P(RCY,U,1)
 W !,"From: "_$P(RCY,U,3)
 W !,"Message ID: "_$P(RCY,U,4)
 W !,"Recipient: "_$P(RCI,U,4)
 W !! F X=1:1:(IOM-1) W "="
 W !
 F  W !,$$READ^XMGAPI1() Q:(XMER=-1)!(RCOUT="^")  I ($Y+3)>IOSL D
 .W ! S DIR(0)="E" D ^DIR I $D(DIROUT)!$D(DUOUT) S RCOUT="^" Q
 .W @IOF
 I RCTAG="FRW" W !! I XMZ D ENT2^XMD
VEWDQ Q
 ;
 ;RCRCXMS
