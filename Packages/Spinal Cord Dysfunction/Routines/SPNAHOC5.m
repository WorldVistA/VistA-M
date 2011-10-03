SPNAHOC5 ;HISC/DAD-AD HOC REPORTS: MISCELLANEOUS ; [ 02/21/95  4:05 PM ]
 ;;2.0;Spinal Cord Dysfunction;;01/02/1997
 ;
MACCHK ; *** Check/update macro checksums
 G:$$GET1^DID(+$G(SPNDIC),"","","NAME")=""!($G(SPNMRTN)="") EXIT
 D SETUP G:(SPNMMAX'>0)!(SPNSORT'>0) EXIT
 W !!,"Check/update macro checksums."
 S (SPND0,SPNQUIT,SPNYESNO)=0
 F  S SPND0=$O(^SPNL(154.8,SPND0)) Q:SPND0'>0!SPNQUIT  D
 . S SP=$G(^SPNL(154.8,SPND0,0))
 . S SPNMACRO=$P(SP,U),SPNTYPE=$P(SP,U,2)
 . S SPNDIC(0)=$P(SP,U,3),SPNCHKSM(0)=$P(SP,U,4)
 . I SPNDIC'=SPNDIC(0) Q
 . W !!,"Macro: ",SPNMACRO
 . W ?40,"Type: ",$S(SPNTYPE="s":"Sort",SPNTYPE="p":"Print",1:"???")
 . W ?55,"Checksum: ",SPNCHKSM(0)
 . I SPNCHKSM=SPNCHKSM(0) W !,"Checksum is OK." Q
 . I SPNYESNO'=2 D
 .. K DIR
 .. S DIR(0)="SOAB^y:YES;n:NO;a:ALL;",DIR("?")="^D EN^SPNAHOCH(""H10"")"
 .. S DIR("A")="Change checksum to "_SPNCHKSM_": ",DIR("B")="NO"
 .. D ^DIR K DIR I $D(DIRUT) S SPNQUIT=1 Q
 .. S SPNYESNO=$S(Y="a":2,Y="y":1,1:0)
 .. Q
 . K DA,DIE,DR S DIE="^SPNL(154.8,",DA=SPND0,DR=".04////"_SPNCHKSM
 . I SPNYESNO D ^DIE
 . Q
 W:'SPNQUIT !!,"Done."
EXIT G EXIT^SPNAHOC0
 ;
SETUP ; *** Set up needed variables
 D XIT^SPNAHOC0,DT^DICRW,HOME^%ZIS,@SPNMRTN K SPNMENU(0)
 S (SPNMMAX,SPNCHKSM,SPNSORT,SP)=0 F  S SP=$O(SPNMENU(SP)) Q:SP'>0  D
 . S SPNMMAX=SPNMMAX+1,SPNCHKSM(0)=0,X=SPNMENU(SP) S:X SPNSORT=SPNSORT+1
 . F SPI=1:1:$L(X) S SPNCHKSM(0)=$A(X,SPI)*SPI+SPNCHKSM(0)
 . S SPNCHKSM=SPNCHKSM(0)*SP+SPNCHKSM
 . Q
 S SPNBLURB="Enter numeric 1 to "_SPNMMAX_", <RETURN> to end, ^ to exit"
 S SPNYESNO="Please answer Y(es) or N(o)." K BY,FLDS,FR,TO
 S (SPNNUMOP("S"),SPNNUMOP("P"),SPNQUIT,SPNNEXT)=0,(BY,FLDS)=""
 S SPNMAXOP("S")=4,SPNMAXOP("P")=7,SPNDTIME=10,$P(SPNUNDL,"_",81)=""
 Q
 ;
SETSAVE ; *** Set save flag
 S SPNMSAVE=1 W !!?3,"The macro will be saved when you exit the "
 W SPNTYPE(0)," menu. ",$C(7) I SPNSEQ=1 R SP:SPNDTIME Q
 F  W !!?3,"OK to exit now" S %=1 D YN^DICN Q:%  I '% W !!?5,SPNYESNO
 S (SPNNEXT,SPNQUIT)=(%=-1) Q:SPNQUIT  S SPNNEXT=(%=1)
 Q
SAVDHD(Y,X) ; *** Save DHD into the Ad Hoc Macro file
 I $G(^SPNL(154.8,+Y,0))]"",$P(Y,U,4)="SAVE" S $P(^SPNL(154.8,+Y,0),U,6)=X
 Q
SAVDIPCR(Y,X) ; *** Save DIPCRIT into the Ad Hoc Macro file
 I $G(^SPNL(154.8,+Y,0))]"",$P(Y,U,4)="SAVE" D
 . N DA,DIE,DR S DIE="^SPNL(154.8,",DA=+Y,DR=".05///^S X="_X D ^DIE
 . Q
 Q
