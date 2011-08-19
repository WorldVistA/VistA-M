RAPSAPI ;HOIFO/SWM-calling Pharmacy APIs ;8/29/05  08:12
 ;;5.0;Radiology/Nuclear Medicine;**65**;Mar 16, 1998;Build 8
 ;
 ;DBIA: 4533  DATA^PSS50 returns external value of field from file #50
 ;DBIA: 4533  ZERO^PSS50 returns B crossreference of file #50
 ;DBIA: 4551  DO^PSSDI puts header info from file #50 into local vars
 ;DBIA: 4551 ($$FNAME^PSSDI) returns field value from file #50
 ;DBIA: 4551  DIC^PSSDI  looks up & screens records from file #50
 ;DBIA: 2055  reference to ROOT^DILFD
 Q
EN1(RAX,RAN) ; call data^pss50 to get external values to some fields
 ; input RAX is ien to file 50
 ; input RAN is field number of file 50 to display
 N RAY,X,SCR
 S:RAX="" RAX=+RAX
 K ^TMP($J,"RAPSS50")
 D DATA^PSS50(RAX,"","","","","RAPSS50")
 S RAY=$G(^TMP($J,"RAPSS50",RAX,RAN))
 K ^TMP($J,"RAPSS50")
 Q RAY
EN2(RADIC,RAUTIL) ; adapted from EN1^RASELCT
 ; called from selradio+11^RANMUTL1
 ;REQUIRES:
 ;  RADIC      = FILE NUMBER OR GLOBAL ROOT
 ;  RADIC(0)   = DIC(0) STRING
 ;  RAUTIL     = NODE TO STORE DATA UNDER IN ^TMP($J,RAUTIL,
 ;  RAVACL()   = ARRAY OF VA CLASS DRUGS TO INCLUDE
 ;  RAVACL("R") = INDICATE RADIOPHARMS ONLY
 ;OPTIONAL:
 ;  RADIC("A") = DIC("A") STRING
 ;  RADIC("S") is not accepted by DIC^PSSDI
 ;
 ;RETURNS:
 ;  1) RAQUIT     = $S(UP_ARROW_OUT:1 , NOTHING_SELECTED:1 , 1:0)
 ;  2) ^TMP($J,RAUTIL,EXTERNAL_.01_FIELD_DATA,IEN) = ""
 ;
 S RAQUIT=0
 I ($G(RADIC)="")!($G(RADIC(0))="")!($G(RAUTIL)="") S RAQUIT=1 G EXIT
 N DIC,PSSDIY,X,Y
 D K S DIC=RADIC I DIC S (RADIC,DIC)=$$ROOT^DILFD(DIC) I DIC="" S RAQUIT=1 G EXIT
 S DIC(0)=RADIC(0),DIC(0)=$TR(DIC(0),"AL") S:DIC(0)'["Z" DIC(0)=DIC(0)_"Z" S RADIC(0)=DIC(0)
 D DO^PSSDI(50,"RA",.RADIC)
 I PSSDIY=-1 S RAQUIT=1 G EXIT  ; -1 if file access invalid
 S RAFNAME=$P(DO,"^"),RAFLD01=$$FNAME^PSSDI(.01,50) K DO
 S RANUM=1 K ^TMP($J,RAUTIL) D HOME^%ZIS
1 ;
 W !!,$S(RANUM>1:"Another one (Select/De-Select): ",1:RADIC("A"))
 R X:DTIME S:('$T)!($E(X)="^") RAQUIT=1 G:RAQUIT EXIT G:X="" EXIT S RADSEL=$S(X?1"-"1.E:1,1:0) S:RADSEL X=$E(X,2,$L(X))
 I $L(X),(X["*") D SOME G 1
 ;removed checking for ALL because user answered "N" to all in selradio^ranmutl1
 D HELP:$E(X)="?"
 ; cannot call old SEL() to prevent reselection since can't use DIC("S")
 ; but no problem as same drug is stored only once in ^TMP
 ;
 ; null 6th piece skip check drug inactive dt -- want select old drugs
 D SETVACL^RAPSAPI2("R")
 D DIC^PSSDI(50,"RA",.RADIC,.X,"","","",.RAVACL)
 G:+Y'>0 1
 ; no rafld
 I 'RADSEL,'$D(^TMP($J,RAUTIL,$E($P(Y,U,2),1,63),+Y)) S ^(+Y)="",RANUM=RANUM+1
 I RADSEL,$D(^TMP($J,RAUTIL,$E($P(Y,U,2),1,63),+Y)) K ^(+Y) S RANUM=RANUM-$S(RANUM>0:1,1:0)
 G 1
EXIT ;
  S RAQUIT=$S(RAQUIT:1,$O(^TMP($J,RAUTIL,""))="":1,1:0) K RADIC,RAUTIL
K K %,%X,%Y,%Z,C,D0,DA,DIC,DIK,DIR,DO,RA,RAALL,RACASE,RAD0,RADSEL,RAFLD01
 K RAFNAME,RAFNUM,RAFSCR,RALINE,RANUM,RAVALUE,X,Y,RAVACL
 Q
SOME ; SG 4/12/07
 N RA50I,RADIC0,RAENTRY,RAXN,NAME
 I $E(X,$L(X))'="*" W " ??",$C(7) Q
 I $L(X)=1 W "  ?? Enter at least 1 character before the ""*"".",$C(7) Q
 S RADIC0=RADIC(0),RADIC(0)="" ; no terminal output
 S RAENTRY=$E(X,1,$L(X)-1)
 D ZERO^PSS50(,RAENTRY,,,,"RAPSS50")
 S RAXN=""
 F  S RAXN=$O(^TMP($J,"RAPSS50","B",RAXN)) Q:RAXN=""  D
 . S RA50I=0
 . F  S RA50I=$O(^TMP($J,"RAPSS50","B",RAXN,RA50I))  Q:RA50I'>0  D
 . . ; screen data
 . . D SETVACL^RAPSAPI2("R")
 . . D DIC^PSSDI(50,"RA",.RADIC,"`"_RA50I,,,,.RAVACL)
 . . Q:+Y'>0
 . . S NAME=$E($P(Y,U,2),1,63)
 . . ; add
 . . I 'RADSEL D:'$D(^TMP($J,RAUTIL,NAME,+Y))  Q
 . . . S ^TMP($J,RAUTIL,NAME,+Y)="",RANUM=RANUM+1
 . . ; remove
 . . I $D(^TMP($J,RAUTIL,NAME,+Y)) K ^(+Y) S:RANUM>0 RANUM=RANUM-1
 S RADIC(0)=RADIC0
 K ^TMP($J,"RAPSS50")
 Q
HELP ;
 N X S RA="Select a "_RAFNAME_" "_RAFLD01_" from the displayed list." D WRAP
 W !?5,"To deselect a ",RAFLD01," type a minus sign (-)",!?5,"in front of it, e.g.,  -",RAFLD01,"."
 W !?5,"Use an asterisk (*) to do a wildcard selection, e.g.,"
 W !?5,"enter ",RAFLD01,"* to select all entries that begin"
 W !?5,"with the text '",RAFLD01,"'.  Wildcard selection is"
 W !?5,"case sensitive."
 G:$O(^TMP($J,RAUTIL,""))="" HLP
SHOW S RALINE=$Y,RA="" W !!,"You have already selected:"
 F  S RA=$O(^TMP($J,RAUTIL,RA)) Q:RA=""!RAQUIT  F RAD0=0:0 S RAD0=$O(^TMP($J,RAUTIL,RA,RAD0)) Q:RAD0'>0!RAQUIT  D SHO
HLP W ! S RAQUIT=0
 Q
SHO W !?3,RA
 I $Y>(IOSL+RALINE-3) D PAUSE S RALINE=$Y
 Q
WRAP ;
 W ! F  S Y=$L($E(RA,1,IOM-20)," ") W !?5,$P(RA," ",1,Y) S RA=$P(RA," ",Y+1,999) Q:RA=""
 Q
PAUSE ;
 K DIR S DIR(0)="E" D ^DIR K DIR S RAQUIT=$S(Y:0,1:1)
 Q
 ; exclude SETDIC and SEL(Y) sections from routine RASELCT
 ;
EN5() ;display identifier from file 71.9, field 5 radiopharm
 ; ^(0) is ^RAMIS(71.9,-,0)
 Q $$EN1(+$P(^(0),U,5),.01)
