SPNAHOCW ;HISC/DAD-AD HOC REPORTS: MACRO EXPORT COMPILER ; [ 06/15/95  8:24 PM ]
 ;;2.0;Spinal Cord Dysfunction;;01/02/1997
 ;
 W !,"=== Ad Hoc Report Macro Export Compiler ==="
 I $$VFILE^DILFD(154.8)=0 D  G EXIT
 . W $C(7),!!?3,"The Ad Hoc Macro file does not exist !!"
 . Q
 D DT^DICRW,HOME^%ZIS,NOW^%DTC
 S X=$J(%,0,6),SPNTODAY=$E(X,4,5)_"/"_$E(X,6,7)_"/"_$E(X,2,3)
 S SPNTODAY=SPNTODAY_"  "_$E(X,9,10)_":"_$E(X,11,12)
 S SPNYESNO="Please answer Y(es) or N(o)."
ROUTINE ; *** Macro routine
 K DIR S DIR(0)="FAO^2:8^K:X'?1U1.7UN X",DIR("?")="^D EN^SPNAHOCH(""H6"")"
 S DIR("A")="Ad Hoc Report Macro Routine: "
 D ^DIR G:$D(DIRUT) EXIT S (SPNPROG,X)=Y
 X ^%ZOSF("TEST") I  D  G EXIT:SPNREPLC=-1 I SPNREPLC=2 W ! G ROUTINE
 . W !!?5,"*** ",SPNPROG," already exists !! ***",$C(7)
 . F  D  Q:%
 .. W !!?5,"Do you want to replace it"
 .. S %=2 D YN^DICN S SPNREPLC=% I '% W !!?10,SPNYESNO
 .. Q
 . I SPNREPLC=1 F  D  Q:%
 .. W !!?5,"Replace ",SPNPROG,", are you sure"
 .. S %=2 D YN^DICN S SPNREPLC=% I '% W !!?10,SPNYESNO
 .. Q
 . Q
MACRO ; *** Select macros
 S SPNNUM=1,SPNQUIT=0 K ^TMP($J,"SPNMACRO")
 F  D  Q:X=""!SPNQUIT
 . W !!,$S(SPNNUM>1:"Another macro",1:"Select MACRO TO EXPORT")_": "
 . R X:DTIME S:('$T)!($E(X)=U) SPNQUIT=1 Q:X=""!SPNQUIT
 . I X?1"?".E D
 .. W !
 .. W !?5,"Select a macro name or number, to deselect a macro"
 .. W !?5,"type a minus sign (-) in front of it, e.g., -MACRO."
 .. W !?5,"Enter ALL to select all macros.  ALL may be followed by"
 .. W !?5,"SORT or PRINT to select only sort/print macros.  ALL"
 .. W !?5,"may also be followed by FILE to select macros for a"
 .. W !?5,"particular file.  Or, use any combination of the above."
 .. W !?5,"Use an asterisk (*) to do a wildcard selection, e.g., MACRO*"
 .. W !
 .. I $O(^TMP($J,"SPNMACRO",""))]"" D
 ... W !,"You have already selected:"
 ... N SPNQUIT,X S SPNLN=$Y,SPNQUIT=0,SPNMACRO=""
 ... F  S SPNMACRO=$O(^TMP($J,"SPNMACRO",SPNMACRO)) Q:SPNMACRO=""!SPNQUIT  S SPND0=0 F  S SPND0=$O(^TMP($J,"SPNMACRO",SPNMACRO,SPND0)) Q:SPND0'>0!SPNQUIT  W !?3,SPND0,"    ",SPNMACRO D ID^SPNAHOCV(SPND0) I $Y>(IOSL+SPNLN-3) D
 .... K DIR S DIR(0)="E" D ^DIR S SPNQUIT=$S(Y'>0:1,1:0),SPNLN=$Y
 .... Q
 ... Q
 .. Q
 . S SPNDSEL=$S(X?1"-".E:1,1:0) S:SPNDSEL X=$E(X,2,$L(X))
 . I $E($$U^SPNAHOCY(X),1,3)="ALL"!(X["*") S SPNALL=0 D ASKALL I SPNALL Q
 . K DIC S DIC="^SPNL(154.8,",DIC(0)="EMNQZ",DIC("W")="D ID^SPNAHOCV(+Y)"
 . D ^DIC K DIC Q:+Y'>0
 . I 'SPNDSEL,'$D(^TMP($J,"SPNMACRO",Y(0,0),+Y)) D TMP(Y(0,0),+Y,1)
 . I SPNDSEL,$D(^TMP($J,"SPNMACRO",Y(0,0),+Y)) D TMP(Y(0,0),+Y,0)
 . Q
 I $O(^TMP($J,"SPNMACRO",""))=""!SPNQUIT G EXIT
 W !
BUILD ; *** Build the macro export routine(s)
 D BUILD^SPNAHOCV
EXIT ; *** Exit
 K %,DIC,DIE,DIR,DIROUT,DIRUT,DTOUT,SP,SPN,SPNAFLAG,SPNALL,SPND0,SPND1
 K SPNDIC,SPNDONE,SPNDSEL,SPNFFLAG,SPNLEN,SPNLN,SPNMACRO,SPNNAME,SPNNUM
 K SPNPATRN,SPNPFILE,SPNPFLAG,SPNPROG,SPNQUIT,SPNREPLC,SPNRTN,SPNRTNNO
 K SPNRTNXT,SPNSFLAG,SPNTAB,SPNTODAY,SPNTYPE,SPNUTIL,SPNWFLAG,SPNYESNO
 K X,XCN,Y,^TMP($J,"SPNROU")
 Q
ASKALL ; *** All macros?
 S SP=X N X S X=$$U^SPNAHOCY(SP),SPNWFLAG=(X["*")
 S SPNAFLAG=(X="ALL"),SPNFFLAG=(X["FILE")
 S SPNSFLAG=(X["SORT"),SPNPFLAG=(X["PRINT")
 I 'SPNWFLAG D  W:%=2 !!,SP Q:%'=1
 . F  D  Q:%
 .. W !!?5,"By '",X,"' do you mean all "
 .. W:SPNSFLAG "sort" W:SPNSFLAG&SPNPFLAG " & " W:SPNPFLAG "print"
 .. W !?5,"macros" W:SPNFFLAG " for a particular file"
 .. S %=2 D YN^DICN I '% W !!?10,SPNYESNO
 .. Q
 . Q
 E  D
 . S SPNPATRN="SPNNAME?",SPN=""
 . F Y=1:1:$L(SP,"*") D
 .. S SPN=$P(SP,"*",Y) I SPN]"" S SPNPATRN=SPNPATRN_"1"""_SPN_""""
 .. S X=$E(SP,$L($P(SP,"*",1,Y))+1),SPN=$L(SPNPATRN)
 .. I X="*",$E(SPNPATRN,SPN-1,SPN)'=".E" S SPNPATRN=SPNPATRN_".E"
 .. Q
 . Q
 S SPNPFILE=""
 I SPNFFLAG,'SPNWFLAG D  I SPNPFILE'>0 W !!,SP Q
 . K DIC S DIC="^DIC(",DIC(0)="AEMNQZ",DIC("A")="Select FILE: "
 . W ! D ^DIC S SPNPFILE=+Y
 . Q
 S SPND0=0,SPNALL=1
 F  S SPND0=$O(^SPNL(154.8,SPND0)) Q:SPND0'>0  D
 . S SPN=$G(^SPNL(154.8,SPND0,0)) Q:SPN=""
 . S SPNNAME=$P(SPN,U),SPNTYPE=$P(SPN,U,2),SPNPFILE(0)=$P(SPN,U,3)
 . I SPNWFLAG,@SPNPATRN D TMP(SPNNAME,SPND0,'SPNDSEL)
 . I SPNWFLAG Q
 . I SPNAFLAG D TMP(SPNNAME,SPND0,'SPNDSEL) Q
 . I SPNFFLAG,SPNPFILE=SPNPFILE(0) D  Q
 .. I SPNSFLAG,SPNTYPE="s" D TMP(SPNNAME,SPND0,'SPNDSEL)
 .. I SPNPFLAG,SPNTYPE="p" D TMP(SPNNAME,SPND0,'SPNDSEL)
 .. I 'SPNSFLAG,'SPNPFLAG D TMP(SPNNAME,SPND0,'SPNDSEL)
 .. Q
 . I 'SPNFFLAG,SPNSFLAG,SPNTYPE="s" D TMP(SPNNAME,SPND0,'SPNDSEL)
 . I 'SPNFFLAG,SPNPFLAG,SPNTYPE="p" D TMP(SPNNAME,SPND0,'SPNDSEL)
 . Q
 Q
TMP(X,Y,Z) ; *** Set/Kill ^TMP
 I Z,'$D(^TMP($J,"SPNMACRO",X,Y)) D
 . S ^TMP($J,"SPNMACRO",X,Y)="",SPNNUM=SPNNUM+1
 . Q
 I 'Z,$D(^TMP($J,"SPNMACRO",X,Y)) D
 . K ^TMP($J,"SPNMACRO",X,Y) S SPNNUM=SPNNUM-$S(SPNNUM>0:1,1:0)
 . Q
 Q
