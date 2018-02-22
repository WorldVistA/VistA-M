XVEMSPS ;DJB/VSHL**Print Symbol Table (..ZW) ;2017-08-16  10:33 AM
 ;;14.1;VICTORY PROG ENVIRONMENT;;Aug 16, 2017
 ; Original Code authored by David J. Bolduc 1985-2005
 ; Mumps V1 support by Sam Habiel (c) 2017
 ;
WRITE(StarT) ;
 ; StartT is mixed case so it isn't already in symbol table
 ;
 I $G(XVV("OS"))'=20,'$$EXIST^XVEMKU("%ZOSV") D  Q
 . W !,"This QWIK requires routine ^%ZOSV.",!
 ;
 KILL ^TMP("XVV",$J)
 D INIT
 D SAVE
 I '$D(^TMP("XVV",$J,"SYM")) W !,"Symbol Table is empty.." G EX
 D START
 D LIST^XVEMKT("^TMP(""XVV"","_$J_",""LIST"")")
EX ;
 W !
 KILL ^TMP("XVV",$J)
 Q
 ;
SAVE ;Save symbol table to ^TMP("XVV",$J,"SYM",var)
 NEW %,%X,%Y,X,Y
 ; VEN/SMH - For MV1, get ST and then reformat it into the VISTA format
 I $G(XVV("OS"))=20 D
 . K ^TMP("XVV",$J,"MV1")
 . W $&%ZWRITE($NA(^TMP("XVV",$J,"MV1")))
 . N V S V=""
 . F  S V=$O(^TMP("XVV",$J,"MV1",V)) Q:V=""  D
 .. N VARNAME S VARNAME=$QS(V,0)
 .. M ^TMP("XVV",$J,"SYM",VARNAME)=@VARNAME
 . K ^TMP("XVV",$J,"MV1")
 E  S X="^TMP(""XVV"","_$J_",""SYM""," D DOLRO^%ZOSV
 ;
 NEW I,XxX
 F I="%","%X","%Y","X","Y","StarT","XVV","XVVSHC","XVVSHL" D  ;
 . KILL ^TMP("XVV",$J,"SYM",I)
 F I="%","%X","%Y","X","Y","StarT" I $D(^TMP("XVV",$J,"VAR",I))  D  ;
 . S ^TMP("XVV",$J,"SYM",I)=^(I)
 . S XxX=I
 . F  S XxX=$O(^TMP("XVV",$J,"VAR",XxX)) Q:XxX=""!($P(XxX,"(",1)'=I)  S ^TMP("XVV",$J,"SYM",XxX)=^(XxX)
 Q
 ;
START ;
 NEW %,%CNT,%DOT,%IEN,%L,%TXT,%TMP,%VAL,%VAR
 S ^TMP("XVV",$J,"LIST",1)=$J("",28)_"S Y M B O L   T A B L E"
 S %CNT=1,%IEN=2
 S %TMP="^TMP(""XVV"","_$J_",""SYM"")"
 S %="TMP(""XVV"","_$J_",""SYM"","
 F  S %TMP=$Q(@%TMP) Q:%TMP=""!(%TMP'[%)  D BUILD
 Q
 ;
BUILD ;Build array in ^XVEMS("ZZLIST","SYMTBL"_$J) to pass to scroller
 S %VAR=$P(%TMP,",",4),%VAR=$P(%VAR,"""",2) ;Strip quotes
 I $P(%TMP,",",5)]""  S %VAR=%VAR_"("_$P(%TMP,",",5,99)
 Q:StarT]%VAR
 S %VAL=@%TMP
 S %TXT=$J(%CNT,3)_". "_%VAR
 S %DOT=$S($L(%VAR)<11:$E(".............",1,12-$L(%VAR)),1:"..")_": "
 S %TXT=%TXT_%DOT,%L=$L(%TXT)
 S %TXT=%TXT_$E(%VAL,1,XVV("IOM")-1-%L)
 S %VAL=$E(%VAL,XVV("IOM")-%L,9999)
 S ^TMP("XVV",$J,"LIST",%IEN)=%TXT,%CNT=%CNT+1,%IEN=%IEN+1
BUILD1 Q:%VAL']""
 S %TXT=$E(%VAL,1,XVV("IOM")-1-%L)
 S ^TMP("XVV",$J,"LIST",%IEN)=$J("",%L)_%TXT,%IEN=%IEN+1
 S %VAL=$E(%VAL,XVV("IOM")-%L,9999)
 G BUILD1
INIT ;
 NEW %TMP
 S StarT=$G(StarT)
 F XxX="%","%X","%Y","X","Y" I $D(@XxX)#2 D  ;
 . S ^TMP("XVV",$J,"VAR",XxX)=@XxX
 . S %TMP=XxX
 . F  S %TMP=$Q(@%TMP) Q:%TMP=""!(%TMP'[XxX)  D  ;
 .. S ^TMP("XVV",$J,"VAR",%TMP)=@%TMP
 KILL XxX,%1,%2,%3,%4,%5,%6,%7,%8,%9
 Q
