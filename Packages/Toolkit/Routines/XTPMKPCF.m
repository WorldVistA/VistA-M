XTPMKPCF ;OAK/BP - COMPUTED FIELDS AND OTHER ODDITIES FOR PATCH MONITOR; ; 3/15/11 12:17pm
 ;;7.3;TOOLKIT;**98,106,130**; Apr 25, 1995;Build 2
 ;Per VHA Directive 2004-038, this routine should not be modified.
 ; computed fields
INSTALL ; returns the patch installation information from the INSTALL file.
 ; note: Fileman variables are NOT killed because they are used in output.
 ; read the index backwards and select the last patch reference because TEST
 ;   patches may be involved.  If a test patch, null the pointer, like nothing is there.
 S X=$P($G(^XPD(9.9,D0,0)),U,8) Q:X=""
 S X=$O(^XPD(9.7,"B",X,9999999999),-1) I $G(^XPD(9.7,+X,2))["TEST v" S X="" Q
 S X=$P($G(^XPD(9.7,+X,1)),U,3),XTINST=$P($G(X),".",1)
 I X="" Q
 S Y=X D DD^%DT S X=$P(Y,"@") K Y
 Q
 ;
WHO ; returns who installed the patch
 S X=$P($G(^XPD(9.9,D0,0)),U,8) Q:X=""
 S X=$O(^XPD(9.7,"B",X,9999999999),-1)  I $G(^XPD(9.7,+X,2))["TEST v" S X=""
 S X=$P($G(^XPD(9.7,+X,0)),U,11)
 S X=$P($G(^VA(200,+X,0)),U)
 Q
 ;
 ; other utility items
 ; patch inquiry
INQUIRE S IOP="HOME" D ^%ZIS K IOP S $P(DASH,"-",75)=""
 S HD="Patch Inquiry for "_^DD("SITE")
 W @IOF,!,HD,!!! K DIC,X,Y
 S DIC("A")="Enter PATCH NAME: ",DIC="^XPD(9.9,",DIC(0)="AEQM"
 D ^DIC G:Y<0 EXITI S DA=+Y
 ;
LOOKUP W @IOF,! S DR="0:9",DIQ(0)="C"
 S DA=+Y W @IOF,HD,!!!!!,DASH D EN1^DIQ W DASH
 ;
CONT W !!!,"Press RETURN to continue or '^' to exit  " R ANS:DTIME G:'$T EXITI
 G:ANS[U EXITI
 G INQUIRE
 ;
EXITI I IOST?1"C-".E W @IOF,!
 ; clean up FM vars left
 K %,%X,A,ANS,D0,D1,D2,DA,DIC,DIK,DL,DX,HD
 K I,POP,S,DASH,DR,X,Y,DK,DIQ,IOP
 Q
 ;
PKGLOOK ; used for free-text lookup in monitoring of namespaces
 N DIC,Y,D0,DO,DA,DICR
 S DIC(0)="EQM",DIC="^DIC(9.4," D ^DIC
 I Y<0 K X Q
 S X=$P($G(^DIC(9.4,+Y,0)),U,2) ; get package prefix
 Q
CMPDTCG ; Compliance Date change
 K XTBCMDCG
 S XTBMLN1=$G(^XMB(3.9,XMZ,0)) I XTBMLN1["COMPLIANCE DATE CHANGE" DO
 .F XTBX=0:0 S XTBX=$O(^XMB(3.9,XMZ,2,XTBX)) Q:XTBX=""!(+XTBX=0)  S XTBY=$G(^XMB(3.9,XMZ,2,XTBX,0)) DO
 ..I XTBY["PATCH " S XTBDESG=$P($P(XTBY,"PATCH ",2)," ",1) Q
 ..I $D(XTBDESG),XTBY["The Compliance Date for patch"&(XTBY["has been changed to") DO
 ...S XTBTCMPD=$P(XTBY,"has been changed to ",2)
 ...S DIC(0)="M",(DIC,DIE)="^XPD(9.9,",X=XTBDESG D ^DIC I Y<0 S XTBX=9999999 Q
 ...S DA=+Y,DR="8///"_XTBTCMPD D ^DIE
 ...S XTBCMDCG=1
 .K DR,DIC,DIE,DA,X,Y,XTBDESG,XTBTCMPD
 Q
 ;
EXITA D ^%ZISC
 K ^TMP($J)
 K XTBDESG,XTBI,XTBINST,XTBINSTX,XTBPKG,XTBPRIO,XTBSEQ,XTBSUB,%ZIS,XTBANS,XTBCOMPD,XTBPURGI
 K XTBVER,XTBX,XTBY,XTBZ,DIC,DIE,DO,DD,X,XMB,XMER,XMREC,XMRG,XX,XTBXX,XTBHDR,PG,POP,XTBMLN1
 K XTBDA,XTBLIMIT,XTBLN,XTBPTNM,XTBRECPT,XTBRUNDT,XTBSUBJ,ZTDESC,XTBCNT
 K XTBX,XTBDTA,XTBDTA,X1,X2,XMDUZ,XMSUB,XMTEXT,XMY,XMZ,Y,XTBRCPDT,XTBMG,XTBMGN
 K XTBINSDA,XTBISTAT,NOFILE,XTBPTYPE,XTBPLVER,XTBPKGPT,XTBPCTVR,YY1
 K XTBX1,XTBZ,NIGHT,XTBCMPDT,ZTSK,ZTIO,ZTRTN,ZTSAVE
 Q
 ;
INSDATE ;Print out Installed Date
 N X,X1
 S X=$P($G(^XPD(9.9,D0,0)),U,8) Q:X=""
 S X1=$P($G(^XPD(9.9,D0,0)),U,11) I X1>0 W $$FMTE^XLFDT(X1,"2Z") Q
 S X=$O(^XPD(9.7,"B",X,9999999999),-1) I $G(^XPD(9.7,+X,2))["TEST v" S X="" Q
 S X=$P($G(^XPD(9.7,+X,1)),U,3) W $$FMTE^XLFDT($P(X,"."),"2Z")
 Q
