%ZTBKC1 ;SF/GJL,SFCIOFO/AC - OPEN M BLOCK COUNT ;06/05/2007  1720232.438851
 ;;7.3;TOOLKIT;**80**;Apr 25, 1995;Build 6
 ;
 I $$ONAPPSVR G EXIT
 O 63::0 E  S %T="The VIEW device is busy." G EXIT
 S %G=$G(^XUTL($J,"ZTBKCDIR"))
 I %G="" D
 .S %G=$ZU(12,"")
 .S ^XUTL($J,"ZTBKCDIR")=%G
 S %B=$ZU(49,%G),%ZTBKBDB=$P(%B,",",21),%B=$P(%B,",",7) G EXIT:'%B
 ;%B=directory block--Not used here.
 O 63:"^^"_%G
ONTGD ;FIND AND PARSE GLOBAL DIRECTORY BLOCK
 ;The global directory block is not parsed here.
 ;We use Cache's APIs/Extrinsic functions to obtain the
 ;first data block of the selected global root.
 ;===============================
 N %ZTBKNSP S %ZTBKNSP="^^"_%G
 I $G(%ZTBKVER)']"" S %ZTBKVER=$P($$VERSION^%ZOSV,".",1,2)
 I $G(%BS)]"" S X=%BS
 S %ZTBKGLO="^"_X,%A="^["""_%ZTBKNSP_"""]"_X
 I '$D(@%A) G EXIT
 I %ZTBKVER="5.0" D  I 1
 . S %=$$GetGlobalPointers^%DM(%G,%ZTBKGLO,.%ZTBKTOP,.%B)
 E  S %=$$GetGlobalPointers^%SYS.DATABASE(%G,%ZTBKGLO,.%ZTBKTOP,.%B)
 V %B
 I % S %O=1,%E=$V(%O*2-1,-6),%H=0,%J=0,%T=0 G ONTDATA
 G EXIT
ONTPTBK ;POINTER BLOCK
 ;Not used here
ONTPTLP ;POINTER BLOCK LOOP
 ;Not used here
 G EXIT
ONTPTNT ;PROCESS NODES IN POINTER BLOCK
 ;Not used here
ONTPTDW ;SAVE OFF LAST DOWN LINK BLOCK FOR LATER USE
 ;Not used here
 ;
ONTDTBK ;DATA BLOCK
 V %B
 S %O=1,%E=$V(%O*2-1,-6),%T=%T+1,%J=0
ONTDATA ;DATA BLOCK LOOP TO PROCESS NODES
 I %E'="" G ONTDTNT
 S %B=$CASE(%ZTBKBDB,0:$V(2040,0,"3O"),:$V($ZUTIL(40,32,4),0,4)) I %B G ONTDTBK
 G EXIT
ONTDTNT ;PROCESS DATA NODES
 S %J=%J+1 D ONTNODE I %I=1 S:%H=0 %T=%T+1 D ONTSTBIG S %H=1,%E="" G ONTDATA ;Next BLK
 I %I=2 S %O=%O+1 G ONTDATA
 S:%J=1 %T=%T-1 G EXIT
 G EXIT
ONTNODE ;BUILD STRINGS TO COMPARE SUBSCRIPTS
 S %F=$V(%O*2-1,-5),%M=$P(%F,"(",2),%M=$P(%M,")",1),%M=","_%M
 G ONTTSTN
ONTPROC ;PROCESS ENCODED DATA
 ;Not used here
ONTASCI ;PROCESS ASCII CHAR
 ;Not used here
ONTPOS ;PROCESS POSITIVE DATA
 ;Not used here
ONTNEG ;PROCESS NEGATIVE DATA
 ;Not used here
ONTTSTN S %M=$E(%M,2,256),%S=$P(X,"(",2),%S=$P(%S,")",1) I (%S="")!(%S=%M) S %I=1 Q
ONTTSTL S %X=$P(%S,",",1),%Y=$P(%M,",",1) I +%X'=%X G ONTSTR
 I %Y="" S %I=2 Q
 I +%Y'=%Y S %I=3 Q
 I %X>%Y S %I=2 Q
 I %X<%Y S %I=3 Q
ONTTSTC S %S=$P(%S,",",2,256) I %S="" S %I=1 Q
 S %M=$P(%M,",",2,256) I %M="" S %I=2 Q
 G ONTTSTL
ONTSTR I +%Y=%Y S %I=2 Q
 I %X]%Y S %I=2 Q
 I %X'=%Y S %I=3 Q
 G ONTTSTC
ONTSTBIG ;Check for big strings
 S %ZTBKEND=0
 F %A=%O:1 S %E=$V(%A*2-1,-6) Q:%E=""  D  Q:%ZTBKEND
 . S %ZTBKCY=$V(%A*2-1,-5)
 . S %ZTBKCY1=$QL($NA(@%ZTBKCY))
 . S %ZTBKCX=$NA(@("^"_X))
 . S %ZTBKCX1=$QL($NA(@%ZTBKCX))
 . I %ZTBKCX1>%ZTBKCY1 S %ZTBKEND=1 Q
 . I $NA(@%ZTBKCX)'=$NA(@%ZTBKCY,%ZTBKCX1) S %ZTBKEND=1 Q
 . S %ZTBKCY=$V(%A*2,-6)
 . I $A(%ZTBKCY)'=5,($A(%ZTBKCY)'=$CASE(%ZTBKBDB,0:9,:7)),($A(%ZTBKCY)'=3) Q
 . S %ZTBKCX=$P(%ZTBKCY,",",2),%ZTBKCX1=$P(%ZTBKCY,",",3)
 . S %T=%T+(%ZTBKCX-1)+''%ZTBKCX1
 . Q
 Q
ASKDIR ;Ask directory/data set name
 N %A,%I,DEND,DIRNAM,GD
 I $G(%ZTBKVER)']"" S %ZTBKVER=$P($$VERSION^%ZOSV,".",1,2)
 I %ZTBKVER="5.0"!(%ZTBKVER'<5.2) D ASK I 1
 E  W !,"An error has just occurred!" Q
 I $G(DUOUT)=1 Q
 I $G(DIRNAM)']"" S DUOUT=1 Q
 S ^XUTL($J,"ZTBKCDIR")=DIRNAM
 Q
ASK ; Enter here to select default directory
 N %ZTBKERR,%ZTBKEC S %ZTBKERR=0
 I $$ONAPPSVR D  Q
 . S DUOUT=1
 . W !,"Note:  You are attempting to run this utility"
 . W !,?7,"on a Cache' ECP Application Server."
 . W !,?7,"This utility will not run on an ECP Application Server."
 . W !,?7,"Please try running this utility again on an ECP Data Server."
 D
 . N $ETRAP,$ESTACK S $ETRAP="D ERROR^%ZTBKC1"
 . D RDCHK
 I %ZTBKERR=1 D ASKBYAPI Q
 I %ZTBKERR=2 D  Q
 . S DUOUT=1
 . W !,"The following error just occurred:"
 . W !,%ZTBKEC
 S DIRNAM=$ZU(12,"")
 K DIR S DIR(0)="Y",DIR("B")="YES"
 S DIR("A")="Use default directory"
 S DIR("A",1)="Default directory is "_DIRNAM
 S DIR("?")="^D HELP^%ZTBKC1"
 D ^DIR
 Q:$D(DTOUT)!$D(DIRUT)
 I 'Y D ASK2
 Q
ASK2 ; Enter here to select directory from a list
 N MGDIR,ZTBKCDIR
 K DIR S DIR("A",1)="Select a number from the following:"
 S %U="",MGDIR="%SYS" F %I=1:1 S %U=$O(^|MGDIR|SYS("UCI",%U)) Q:%U=""  D
 .  S DIR("A",%I+1)="   "_$J(%I,3)_"      "_%U
 .  S ZTBKCDIR(%I)=%U
 .  I %U=DIRNAM S DIR("B")=%I
 S DIR("A")="Enter a number "
 S DIR(0)="N^"_"1:"_(%I-1)
 W ! D ^DIR
 Q:$D(DTOUT)!$D(DIRUT)
 S DIRNAM=ZTBKCDIR(Y)
 Q
RDCHK ; Check to see if ^SYS global is readable with current privs.
 N %U,MGDIR
 S %U="",MGDIR="%SYS"
 S %U=$O(^|MGDIR|SYS("UCI",%U))
 Q
ONAPPSVR() ;Check to see if this utility is run from an ECP Application Server
 Q ($ZU(12,"")="")
 ;
ASKBYAPI ;
 W !,"Note:  You do not have adequate privileges to view the ^SYS global."
 W !,?7,"Therefore, a directory listing will not be available"
 W !,?7,"at the directory prompt."
 W !!,?7,"Also, Cache's API will be used to prompt for directory.",!!
 I $G(%ZTBKVER)']"" S %ZTBKVER=$P($$VERSION^%ZOSV,".",1,2)
 I %ZTBKVER="5.0" D ASK^%FILE I 1
 E  I %ZTBKVER'<5.2 D ASK^%SYS.FILE I 1
 E  W !,"An error has just occurred!" Q
 Q
HELP ;Single question mark help for 'Use default directory' prompt
 W !,"Enter either 'Y' or 'N'."
 W !!,"If you enter 'N' for 'NO', you may then select a directory from a list."
 W !,"Block count on globals will only be returned for globals that reside"
 W !,"in the selected directory."
 Q
ERROR ; Error trap for disconnect error and return back to the read loop.
 S $ETRAP="D UNWIND^%ZTER"
 S %ZTBKEC=$$EC^%ZOSV
 I %ZTBKEC["PROTECT" S %ZTBKERR=1 D UNWIND^%ZTER Q
 S %ZTBKERR=2 D ^%ZTER
 D UNWIND^%ZTER
 Q
%Z3 N X S PG=PG+1,ST=0 D:(PG>1)&%ZTBIOC2&%ZTBIOC %Z5 Q:ST
 U IO W:((9+$Y'<IOSL)&($Y>3))!(PG>1) @IOF
 S %SK=$X W ?(%SK+25),"Global Block Count  ",$S(PG>1:"(cont.)",1:""),?(%SK+60),"Page ",PG
 W !,$G(^XUTL($J,"ZTBKCDIR")),"  " S %SK=$X+1 W "Globals",?(%SK+12),"Data Blocks"
 W ?(%SK+34),%ZTBKCDT W !
 Q
%Z5 U IO(0) R !,"Press RETURN to continue or '^' to exit: ",ST:600 S ST=$S(ST["^":1,1:0) S:ST %GLO="zzzz" ;SET SOME VARIABLE TO STOP LOOP
 Q
DD S:Y Y=$S($E(Y,4,5):$P("JAN^FEB^MAR^APR^MAY^JUN^JUL^AUG^SEP^OCT^NOV^DEC","^",+$E(Y,4,5))_" ",1:"")_$S($E(Y,6,7):+$E(Y,6,7)_",",1:"")_($E(Y,1,3)+1700)_$P("@"_$E(Y_0,9,10)_":"_$E(Y_"000",11,12),"^",Y[".")
 Q
ALL ;Entry point for block count of all globals.
ALLONT ;Directory at ^UTILITY("GLO")
 K ^UTILITY("%ZTBKC",$J)
 O 63::0 E  S %T="The VIEW device is busy." G EXIT
 S %G=$G(^XUTL($J,"ZTBKCDIR"))
 I %G="" D
 .S %G=$ZU(12,"")
 .S ^XUTL($J,"ZTBKCDIR")=%G
 S %B=$ZU(49,%G),%B=$P(%B,",",7) G EXIT:'%B
 O 63:"^^"_%G
 N ST,PG
 S %ZTBIOC=(IO=IO(0)),%ZTBIOC2=$E(IOST,1,2)["C-"
 U IO W:%ZTBIOC2 @IOF I '%ZTBIOC,'$D(ZTQUEUED) U IO(0) W !!,"Printing report..."
 S %ZTBKCZY=IOSL-(255\IOM+1) K %D,%T,%TIM
AONTVUE V %B S %ZTBKCG=""
 S %ZTBKSIZ=$P($ZU(49,%G),",",2)
 S %ZTBKBIG=$CASE(%ZTBKSIZ,2048:0,:1)
 S %ZTBKCL=$CASE(%ZTBKBIG,0:$V(2040,0,"3O"),:$V($ZUTIL(40,32,4),0,4))
 S %E=$CASE(%ZTBKBIG,0:$V(2046,0,2),:$V($ZU(40,32,0),0,4)+$ZU(40,32,10))
 I %E>%ZTBKSIZ G EXIT
 S %O=$CASE(%ZTBKBIG,0:0,:$ZU(40,32,10))
AONTNXT G AONTPTR:%E'>%O
 S %ZTBKA=%O,%ZTBKRAW=$V(%ZTBKA,0,4),%ZTBKINF=$ZU(167,0,0,%ZTBKRAW)
 S %ZTBKA=%ZTBKA+4
 S %ZTBKCCC=$P(%ZTBKINF,"^",3),%ZTBKLEN=$P(%ZTBKINF,"^",4)
 S %ZTBKPAD=$P(%ZTBKINF,"^",5),%ZTBKSUB=$P(%ZTBKINF,"^",2)
 S %ZTBKCG="" I %ZTBKCCC S %ZTBKCG=$E(%ZTBKPRV,1,%ZTBKCCC)
 S %ZTBKCE=%ZTBKA+%ZTBKSUB-1,%O=%ZTBKA
AONTLOP S %Z=$V(%O,0),%O=%O+1 S:%Z %ZTBKCG=%ZTBKCG_$C(%Z) G AONTLOP:(%O'>%ZTBKCE)
 S ^UTILITY("%ZTBKC",$J,%ZTBKCG)=""
 S %ZTBKPRV=%ZTBKCG,%O=%ZTBKCE+%ZTBKLEN-%ZTBKSUB-3,%ZTBKCG="" G AONTNXT
AONTPTR S %B=%ZTBKCL I %B G AONTVUE
 D NOW^%DTC S Y=% D DD S %ZTBKCDT=Y
 S PG=0 D %Z3
 S (%TOT,%GLO)=0 F %II=1:1 S X=$O(^UTILITY("%ZTBKC",$J,%GLO)),%GLO=X Q:X=""  D:%ZTBKCZY'>$Y %Z3 Q:$G(ST)  S:X?1"^".E X=$E(X,2,255) W !,?%SK,X,?(%SK+15) S %T=-1 D %ZTBKC1 S X=%T S:X>0 %TOT=%TOT+X W:X<0 "-- no such global --" W:X'<0 X
 W !!?%SK,"Total",?(%SK+15),%TOT K %GLO,%II,%SK,%T,%TOT,%ZTBIOC,%ZTBIOC2,%ZTBKCDT,%ZTBKCZY,X,Y U IO(0) D ^%ZISC
EXIT C 63 K %,%A,%B,%C,%D,%E,%F,%G,%H,%I,%J,%K,%L,%M,%N,%O,%S,%V,%W,%X,%Y,%Z,%ST
 K %ZTBKA,%ZTBKBDB,%ZTBKBIG,%ZTBKCCC,%ZTBKCE,%ZTBKCG,%ZTBKCL,%ZTBKCX,%ZTBKCX1,%ZTBKCY,%ZTBKCY1,%ZTBKEND,%ZTBKGLO,%ZTBKINF,%ZTBKLEN,%ZTBKPAD,%ZTBKPRV,%ZTBKRAW,%ZTBKSIZ,%ZTBKSUB,%ZTBKTOP,%ZTBKVER
