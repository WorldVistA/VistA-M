FBUCEN ;ALBISC/TET - ENTER UNAUTHORIZED CLAIM ; 4/9/10 11:25am
 ;;3.5;FEE BASIS;**32,61,114**;JAN 30, 1995;Build 7
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;FBUC - unauthorized claims site parameter node
 ;FBTRACK - 1 to track incomplete claims, 0 to track complete claims only
 ;FBUCP - 0 to not automatically print letters, otherwise default device
 ;FBOK - 0 if claim is incomplete, 1 if claim is complete.
 ;FBACT - ENT for enter (fbact represents action type)
 ;FBINENT = initial entry parameter: 1 if using, 0 if not
 S FBOUT=0,FBUC=$$FBUC^FBUCUTL2(1),FBTRACK=+$P(FBUC,U),FBOK=$S('FBTRACK:1,1:0),FBACT="ENT",FBINENT=+$P(FBUC,U,7)
GET ;get info on new claim entry
 K FBVEN,FBVET
VET ;get vet info
 N DIR,DA W !! S DIR(0)="162.7,2O",DIR("A")="Select VETERAN" D ^DIR K DIR,DA G END:$D(DIRUT),VET:+Y'>0 S FBVET=+Y
VEN ;get vendor info
 N DIR,DA S DIR(0)="162.7,1O",DIR("A")="Select FEE VENDOR" D ^DIR K DIR,DA G VET:$D(DUOUT)!($D(DTOUT)),VEN:+Y<0,VEN:+Y=0&('FBINENT) S FBVEN=+Y
PROG N DIC,DA S DIC="^FBAA(161.8,",DIC(0)="AEQMZ",DIC("S")="I +$P(^(0),U,3)" D ^DIC K DIC,DA S:$D(DTOUT)!($D(DUOUT)) FBOUT=1 G END:FBOUT,GET:Y<0 S FBPR=+Y D  S:FBOUT FBOUT=0 G VET
 .N FBDA,FBMASTER,FBORDER,FBTFROM,FBTTO,FB1725,FBFPPSC
 .; ask if claim is an EDI claim (patch *61)
 .S FBFPPSC=$$FPPSC^FBUTL5() I FBFPPSC=-1 S FBFPPSC="",FBOUT=1 Q
 .; ask if claim is a mill bill emergency care claim (patch *32)
 .S DIR(0)="Y"
 .S DIR("A")="Is this claim being considered under Millennium Act 38 U.S.C. 1725 (Y/N)"
 .D ^DIR K DIR I $D(DIRUT) S FBOUT=1 Q
 .S FB1725=$S(Y:1,1:"")
 .D ASKDT Q:FBOUT  I FBTRACK,'FBINENT D  Q:FBOUT
 ..S DIR(0)="Y",DIR("A")="Is the unauthorized claim complete for the FEE PROGRAM" D DIRQ,^DIR K DIR S:$D(DIRUT) FBOUT=1 S:'FBOUT FBOK=Y Q:FBOUT!(FBOK)
 ..D REQ^FBUCPEND Q:FBOUT  S FBORDER=10 ;display/select pending information,set status order to incomplete if selected pending items
 .;check for duplicates
 .I 'FBINENT W !,"Checking for potential duplicates...",! H 1 D ^FBUCDUP
 .W !!,"Checking eligibility...",! H 1 S DFN=FBVET D ELIG^VADPT W:VAEL(4)'=1 !,"Patient is not a veteran.",*7 D ELIG^FBAADEM K VAEL,VAERR
 .W ! S DIR("A")="Are you sure you wish to enter a new unauthorized claim",DIR(0)="Y" D ^DIR K DIR S:'Y!($D(DIRUT)) FBOUT=1 Q:FBOUT
 .;file new claim
 .S DIC="^FB583(",DIC(0)="Z",X=DT K DD,DO D FILE^DICN S FBOUT=$S($P(Y,U,3):0,1:1) Q:FBOUT  S FBDA=+Y D PRIOR^FBUCEVT(FBDA,FBACT) D
 ..S FBMASTER=FBDA,FBORDER=$S(+$G(FBORDER)=10:10,'FBINENT:30,1:5)
 ..S DIE=DIC,DIE("NO^")="BACKOUTOK",DR="[FB UNAUTHORIZED ENTER]",DA=FBDA
 ..D LOCK^FBUCUTL(DIE,DA,1) S:'FBLOCK FBOUT=1 Q:FBOUT  D ^DIE L -^FB583(FBDA) K DA,DIE,DQ,DR,FBLOCK I $D(Y)!($D(DTOUT)) S DIK=DIC,DA=FBDA D ^DIK K DIK W !,"... Deleting incomplete record.",*7 S FBOUT=1 Q
 ..I FBORDER=10 D FREQ^FBUCPEND ;file requested info
 ..K ^TMP("FBARY",$J),^TMP("FBAR",$J)
 .D AFTER^FBUCEVT(FBDA,FBACT)
 .K FBARY,FBLOCK Q:FBOUT  D ENTER^FBUCLNK1(FBDA,FBUCA,1) K FBARY,^TMP("FBARY",$J),^TMP("FBAR",$J)
 .I FBORDER'=10,+$G(FBVEN)>0,+$G(FBTTO)>0 D AFTER^FBUCEVT(FBDA,FBACT),EN^FBUCEN1(FBUCA,FBDA) ;if claim complete, check if group, any in group dispositioned
 .;do update
 .D AFTER^FBUCEVT(FBDA,FBACT),^FBUCUPD(FBUCP,FBUCPA,FBUCA,FBUCAA,FBDA,FBACT)
 ;
END ;kill and quit
 K DA,DFN,DIC,DIE,DIR,DIRUT,DQ,DR,DTOUT,DUOUT,FBACT,FBARY,FBDA,FBDISP,FBINENT,FBLOCK,FBMASTER,FBOK,FBORDER,FBOUT,FBPEND,FBPI,FBPR,FBPROG
 K FBSTATUS,FBTFROM,FBTRACK,FBTTO,FBUC,FBUCA,FBUCP,FBUCAA,FBUCP,FBUCPA,FBVEN,FBVET,X,Y,^TMP("FBAR",$J),^TMP("FBARY",$J)
 Q
ASKDT ;ask treatment from/to dates
 S DIR(0)="162.7,3" S:FBPR=6 DIR("A")="ADMISSION DATE" D ^DIR K DIR S:'+Y DIRUT="^" S:$D(DIRUT) FBOUT=1 S:'FBOUT FBTFROM=Y
 I 'FBOUT S DIR(0)="162.7,4O" S:FBPR=6 DIR("A")="DISCHARGE DATE" S:FBPR'=6&(FBPR'=7) DIR("B")=$$DATX^FBAAUTL(FBTFROM) D ^DIR K DIR S:$D(DUOUT)!($D(DTOUT)) FBOUT=1 I 'FBOUT,'FBINENT G:+Y'>0!(FBTFROM>Y) ASKDT S FBTTO=Y
 I 'FBOUT S FBTTO=+Y
 Q
HELP ;help text for complete claim question - ??
 W !?10,"An unauthorized claim is considered complete (or valid)"
 W !?10,"if all the necessary information has been received."
 W !?10,"A claim can never be considered complete if it is missing"
 W !?10,"form 10-583 or form 10-583 is incomplete."
 W !?10,"Some examples of other items which are needed are:"
 W !?20,"Copies of actual bills",!?20,"Original paid receipt"
 W !?20,"Itemized invoice/UB82",!?20,"Medical records or signature for release"
 W !?20,"Diagnostic/Procedure code(s)",!
 Q
DIRQ ;set dir(?,#)
 S DIR("?")="Enter Y(es) if complete, N(o) if incomplete."
 S DIR("??")="^D HELP^FBUCEN"
 S DIR("?",1)="Enter Y(es) if all required information has been submitted,"
 S DIR("?",2)="      N(o)  if the claim is incomplete."
 S DIR("?",3)=""
 Q
