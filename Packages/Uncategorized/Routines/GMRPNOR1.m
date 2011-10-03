GMRPNOR1 ;SLC/MKB/DJP Progress Note- OE/RR interface;; 2-14-97 ; 7-DEC-1999 12:10:24
 ;;2.5;Progress Notes;**25,45,50**;Jan 08, 1993
 ;
 ; this rtn is needed by TIU to support the one letter CWAD indicators
 ; in OE/RR 2.5 screens- subroutine CWAD
 ; DO NOT delete this rtn when the GMRP* rtns are deleted in the
 ; TIU clean-up
 ;
SELPT ;select new patient using IN^OR to update ORVP, etc. GMRP*2.5*50
 ; IN^OR doesn't exist, code no longer used
 ;K DIC,Y,DIROUT S GMRPOLD=$G(ORVP)
 ;D IN^OR I $D(DIROUT) S GMRPEND=1 Q
 ;I (ORVP=GMRPOLD) S XQORM("B")="Redisplay Screen" K GMRPOLD Q
 ;K GMRPOLD D PAT Q:$D(GMRPQT)  S:'$D(GMRPCTXT) GMRPCTXT=1
 ;D @("BUILD"_GMRPCTXT_"^GMRPNOR"),SCREEN^GMRPNOR
 ;Q
PAT ;set up patient info for use - expects ORVP or DFN
 S GMRPDFN=$S($D(ORVP):$P(ORVP,";"),$D(DFN):DFN,1:0)
 I +GMRPDFN'>0 D  Q:$D(GMRPQT)
 .S DIC="^DPT(",DIC(0)="AEQM" D ^DIC K DIC
 .I +Y<1 S GMRPQT=1 Q
 .S GMRPDFN=+Y
 N DFN S DFN=+GMRPDFN D OERR^VADPT
 S $P(GMRPDFN,U,2)=VADM(1),GMRPSSN=VA("PID")
 S GMRPDOB=VADM(3),GMRPAGE=VADM(4),GMRPRB=VAIN(5),GMRPLOC=$P(VAIN(4),U)
 S GMRPLOC=$P($G(^DIC(42,+GMRPLOC,44)),U)
 S:GMRPLOC>0 $P(GMRPLOC,U,2)=$P(^SC(+GMRPLOC,0),U)
 K VAIN,VADM,GMRPCWAD S GMRPCWAD=$$CWAD(GMRPDFN)
 Q
CWAD(GMRPDFN) ;;check if any clinical warnings exist for patient
 ;Returns GMRPCWAD="CWAD" (for ones found), or "" if none
 ;S DFN (below) needed for hidden action CWAD^TIULX 
 ; N GMRPCWAD,GMRPCWA1,TIUST,GMRPALG,GMRPI
 N GMRPCWA1,GMRPI
 I '+GMRPDFN Q ""
 S GMRPCWAD=""
 S GMRPCWA1=""
 F GMRPI=7,8 D
 . I $D(^TIU(8925,"ADCPT",+GMRPDFN,30,GMRPI)) S GMRPCWA1=GMRPCWA1_"C"
 . I $D(^TIU(8925,"ADCPT",+GMRPDFN,31,GMRPI)) S GMRPCWA1=GMRPCWA1_"W"
 . I $D(^TIU(8925,"ADCPT",+GMRPDFN,27,GMRPI)) S GMRPCWA1=GMRPCWA1_"D"
 . Q
 S DFN=GMRPDFN D ALLERGY^GMRPNCW I $D(GMRPALG) S GMRPCWA1=GMRPCWA1_"A"
 F GMRPI="C","W","D","A" D
 . I GMRPCWA1[GMRPI S GMRPCWAD=GMRPCWAD_GMRPI
 K CWA,TIUST,GMRPALG
 Q GMRPCWAD
 ;
QUIT ;quits out of review screen
 S GMRPEND=1
 Q
SEL ;selects single note from screen -- assumes GMRPN(GMRPNN) array
 S DIR(0)="NAO^1:"_GMRPNN,DIR("A")="Select a note: "
 S DIR("?")="Enter the display number of the note you wish to amend."
 S DIR("??")="^D HELPASK1^GMRPND" D ^DIR K DIR
 I $D(DTOUT)!($D(DIRUT))!($D(DIROUT)) S GMRPQT=1 Q
 S GMRPIFN=GMRPN(+Y)
 I $D(GMRPADDM),$P($G(^GMR(121,GMRPIFN,5)),U)=1 D  Q
 .W !!,"This note requires a cosignature before it may be amended!"
 .W $C(7) S GMRPQT=1 K GMRPIFN
 D DISPL^GMRPN2 K:'$D(DIROUT)&('$D(DTOUT)) GMRPQT,DUOUT
 Q
CURR ;Redisplay current screen -- needs GMRPPG & calls SCREEN
 I $S('$D(GMRPPG):1,GMRPPG'>0:1,1:0) S GMRPPG=1
 D SCREEN^GMRPNOR
 Q
NEXT ;Display next screen -- needs GMRPPG & calls SCREEN
 I $S('$D(GMRPPG):1,GMRPPG'>0:1,1:0) S GMRPPG=1
 I GMRPPG<GMRPN("PG") S GMRPPG=GMRPPG+1
 D SCREEN^GMRPNOR
 Q
PREV ;Display previous screen -- needs GMRPPG & calls SCREEN
 I $S('$D(GMRPPG):1,GMRPPG'>0:1,1:0) S GMRPPG=1
 I GMRPPG>1 S GMRPPG=GMRPPG-1
 D SCREEN^GMRPNOR
 Q
CTXT ;Select new context for viewing/acting on notes
 ;Requires/Returns GMRPCTXT
 S DIR(0)="SAO^1:SIGNED;2:UNSIGNED;3:UNCOSIGNED;4:AUTHOR;5:DATES"
 S DIR("A")="Select context: ",DIR("A",1)="Valid selections are:"
 S DIR("A",2)="  1 - signed notes (all)   2 - unsigned notes       3 - uncosigned notes"
 S DIR("A",3)="  4 - signed notes/author  5 - signed notes/dates",DIR("A",4)="   "
 S DIR("?",1)="To change which notes are displayed, select the number"
 S DIR("?")="of the context you wish to work within.",DIR("B")="1"
 W ! D ^DIR K DIR S:$D(DIROUT) GMRPEND=1
 Q:$D(DUOUT)!($D(DTOUT))!($D(DIROUT))
 S GMRPSAV=Y D AUTHOR:Y=4,DATES^GMRPNP:Y=5 Q:$D(GMRPQT)
 S GMRPCTXT=GMRPSAV K GMRPBLD,GMRPSAV
 Q
AUTHOR ;selects author - Returns GMRPDUZ=#^NAME or GMRPQT
 S DIC="^VA(200,",DIC(0)="AEQM",DIC("A")="Select AUTHOR: "
 S DIC("B")=$P(^VA(200,DUZ,0),U) D ^DIC K DIC
 I '$T!(+Y<1) S GMRPQT=1 S:$D(DIROUT) GMRPEND=1 Q
 S GMRPDUZ=Y K GMRPQT
 Q
SETERM ;sets up GMRPTRML variable to hi-lite <CWAD> flag on review screen
 ;node 5 = inverse display, node 7 = highlighted display
 S GMRPTRML="" Q:'$D(IOST)  Q:'$L(IOST)
 S X=$O(^%ZIS(2,"B",IOST,0))
 ;I X,$D(^%ZIS(2,X)) S GMRPTRML=$S($D(^(X,5)):$P(^(5),U,4,5),1:"")
 I X,$D(^%ZIS(2,X)) S GMRPTRML=$S($D(^(X,7)):$P(^(7),U,1,3),1:"")
 I  S:'$L($P(GMRPTRML,U,3)) $P(GMRPTRML,U,3)=$P(GMRPTRML,U,2)
 F GMRPI=1,3 I '$L($P(GMRPTRML,U,GMRPI)) S GMRPTRML="" Q
 K GMRPI Q
INV() I '$L(X) Q ""
 N DX,DY S DX=$X,DY=$Y W @X X ^%ZOSF("XY")
 Q ""
UNSIGN ;entry point for follow-up action on unsigned pn's
 N ORVP S XQAKILL=0
 S GMRPCTXT=2,ORVP=$P($G(XQAID),",",2)_";DPT("
 S X=$O(^ORD(101,"B","GMRP REVIEW SCREEN",0))_";ORD(101," D EN^XQOR  ;WPB/CAM REMOVE B START OF LINE
 Q
COSIGN ;entry point for follow-up action on uncosigned pn's
 N ORVP S XQAKILL=0
 S GMRPCTXT=3,ORVP=$P($G(XQAID),",",2)_";DPT("
 S X=$O(^ORD(101,"B","GMRP REVIEW SCREEN",0))_";ORD(101," D EN^XQOR
 Q
