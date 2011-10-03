DIVR ;SFISC/GFT-VERIFY FLDS ;8:43 AM  1 Jul 1999
 ;;22.0;VA FileMan;**7**;Mar 30, 1999
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 I $D(DIVFIL)[0 N DIVDAT,DIVFIL,DIVMODE,DIVPG,POP D  G:$G(POP) Q^DIV
 . S DIVMODE="C"
 . D DEVSEL^DIV Q:$G(POP)
 . D INIT^DIV
 S W="W !,""ENTRY#"_$S(V:"'S",1:"")_""",?10,"""_$P(^DD(A,.01,0),U)_""",?40,""ERROR"""
 D LF Q:$D(DIRUT)  S T=$E(T) S:"PS"[T&($D(DIVZ)[0) DIVZ=Z
 K DIVREQK,DIVTYPE,DIVTMP
 S DIVREQK=$D(^DD("KEY","F",A,DA))>9
 I $D(^DD("IX","F",A,DA)) D
 . S DIVTYPE=T,T="INDEX",DIVROOT=$$FROOTDA^DIKCU(A)
 . D LOADVER^DIVC(A,DA,"DIVTMP")
 K DG
 F %=0:0 S %=$O(^DD(A,DA,1,%)) Q:%'>0  I $D(^(%,1)),$P(^(0),U,2,9)?1.A,^(2)?1"K ^".E1")",^(1)?1"S ^".E S DG(%)="I $D("_$E(^(2),3,99)_"),"_$E(^(1),3,99)
 I T'="INDEX",'$D(^(+$O(^DD(A,DA,1,0)),1)) G E
 I T'="INDEX",'$D(DG) W $C(7)_"(CANNOT CHECK"
 E  W "(CHECKING"
 W " CROSS-REFERENCE)" D LF I $D(DIRUT) Q:$D(DQI)  G Q
 I $D(DG) D
 . I T="INDEX" S E=DIVTYPE,DIVTYPE="IX"
 . E  S E=T,T="IX"
E S Y=$F(DDC,"%DT=""E") S:Y DDC=$E(DDC,1,Y-2)_$E(DDC,Y,999)
 I DR["*" S DDC="Q" I $D(^DD(A,DA,12.1)) X ^(12.1) I $D(DIC("S")) S DDC(1)=DIC("S"),DDC="X DDC(1) E  K X"
 D 0 S X=$P(Y(0),U,4),Y=$P(X,S,2),X=$P(X,S)
 I +X'=X S X=Q_X_Q I Y="" S DE=DE_"S X=DA D R" G XEC
 S M="S X=$S($D(^(DA,"_X_")):$"_$S(Y:"P(^("_X_"),U,"_Y,1:"E(^("_X_"),"_$E(Y,2,9))_"),1:"""") D R"
 I $L(M)+$L(DE)>250 S DE=DE_"X DE(1)",DE(1)=M
 E  S DE=DE_M
XEC K DIC,M,Y X DE Q:$D(DQI)
 W:'$D(M) $C(7),!,"NO PROBLEMS"
Q S M=$O(^UTILITY("DIVR",$J,0)),E=$O(^(M)),DK=J(0)
 I $D(ZTQUEUED) S ZTREQ="@"
 E  I $T(+0^%ZISC)]"" D
 . D ^%ZISC
 E  X $G(^%ZIS("C"))
 G:'E!$D(DIRUT)!$D(ZTQUEUED) QX K DIBT,DISV D
 . N C,D,I,J,L,O,Q,S,D0,DDA,DICL,DIFLD,DIU0
 . D S2^DIBT1 Q
 S DDC=0 I '$D(DIRUT) G Q:Y<0 F E=0:0 S E=$O(^UTILITY("DIVR",$J,E)) Q:E=""  S DDC=DDC+1,^DIBT(+Y,1,E)=""
 S:DDC>0 ^DIBT(+Y,"QR")=DT_U_DDC
QX K DIVINDEX,DIVKEY,DIVREQK,DIVROOT,DIVTMP,DIVTYPE
 K ^UTILITY("DIVR",$J),DIRUT,DIROUT,DTOUT,DUOUT,DQI,DK,DA,DG,DQ,DE,T,P,E,M,DR,W,DDC,DIVZ Q
 ;
R Q:$D(DIRUT)
 I X?." " Q:DR'["R"&'DIVREQK  D  G X
 . I X="" S M="Missing"_$S(DIVREQK:" key value",1:"")
 . E  S M="Equals only 1 or more spaces"
 G @T
 ;
P I @("$D(^"_DIVZ_"X,0))") S Y=X G F
 S M="No '"_X_"' in pointed-to File" G X
 ;
S S Y=X X DDC I '$D(X) S M=Q_Y_Q_" fails screen" G X
 Q:S_DIVZ[(S_X_":")  S M=Q_X_Q_" not in Set" G X
 ;
D S Y=X,X=$E(Y,1,3)+1700,%=$E(Y,6,7) S:% X=%_"-"_X S:$E(Y,4,5) X=+$E(Y,4,5)_"-"_X
 S:Y["." X=X_"@"_$E(Y_"00",9,10)_":"_$E(Y_"0000",11,12)_$S($E(Y,13,14):":"_$E(Y_"0",13,14),1:"")
N ;
K ;
F S DQ=X I X'?.ANP S M="Non-printing character" G X
 X DDC Q:$D(X)  S M=Q_DQ_Q_" fails Input Transform"
X I $O(^UTILITY("DIVR",$J,0))="" X W
 S X=$S(V:DA(V),1:DA),^UTILITY("DIVR",$J,X)=""
 S X=V I @(I(0)_"0)")
DA I 'X D  Q
 . D LF Q:$D(DIRUT)
 . W DA,?10,$S($D(^(DA,0)):$P(^(0),U),1:DA),?40,$E(M,1,40)
 . D:V LF
 D LF Q:$D(DIRUT)  W DA(X),?10,$P(^(DA(X),0),U) S X=X-1,@("Y=$D(^("_I(V-X)_",0))") G DA
 ;
0 ;
 S Y=I(0),DE="",X=V
L S DA="DA" S:X DA=DA_"("_X_")" S Y=Y_DA,DE=DE_"F "_DA_"=0:0 ",%="S "_DA_"=$O("_Y_"))" I V>2 S DE(X+X)=%,DE=DE_"X DE("_(X+X)_")"
 E  S DE=DE_%
 S DE=DE_" Q:"_DA_"'>0  S D"_(V-X)_"="_DA_" "
 ;I X=1,DIFLD=.01 S DE=DE_"X P:$D(^(DA(1),"_I(V)_",0)) ",P="S $P(^(0),U,2)="""_$P(^DD(J(V-1),P,0),U,2)_Q
 S X=X-1 Q:X<0  S Y=Y_","_I(V-X)_"," G L
 ;
IX F %=0:0 S %=$O(DG(%)) Q:+%'>0  X DG(%) I '$T S M=Q_X_Q_" not properly Cross-referenced" G X
 G @E
 ;
V I $P(X,S,2)'?1A.AN1"(".ANP,$P(X,S,2)'?1"%".AN1"(".ANP S M=Q_X_Q_" has the wrong format" G X
 S M=$S($D(@(U_$P(X,S,2)_"0)")):^(0),1:"")
 I '$D(^DD(A,DIFLD,"V","B",+$P(M,U,2))) S M=$P(M,U)_" FILE not in the DD" G X
 I '$D(@(U_$P(X,S,2)_+X_",0)")) S M=U_$P(X,S,2)_+X_",0) does not exist" G X
 G F
 ;
INDEX ;Check new indexes
 ;
 ;Set DIVINDEX(indexName,index#) = "" for indexes aren't set
 ;Set DIVKEY(file#,keyName,uiNumber) = "null" : if key field is null
 ;                                     "uniq" : if key is not unique
 K DIVKEY,DIINDEX
 D VER^DIVC(A,DIVROOT,.DA,"DIVTMP",.DIVINDEX,.DIVKEY)
 ;
 ;If some indexes aren't set properly, print index info
 I $D(DIVINDEX) D  K DIVINDEX Q:$D(DIRUT)
 . N DIVNAME,DIVNUM
 . S DIVNAME="" F  S DIVNAME=$O(DIVINDEX(DIVNAME)) Q:DIVNAME=""  D  Q:$D(DIRUT)
 .. S DIVNUM=0 F  S DIVNUM=$O(DIVINDEX(DIVNAME,DIVNUM)) Q:'DIVNUM  D  Q:$D(DIRUT)
 ... S M=Q_X_Q_": "_DIVNAME_" index (#"_DIVNUM_") not properly set"
 ... D IER
 ;
 ;If keys integrity is violated, print key info
 I $D(DIVKEY) D  K DIVKEY Q:$D(DIRUT)
 . N DIVFILE,DIVKNM,DIVPROB,DIVXRNM
 . S DIVFILE="" F  S DIVFILE=$O(DIVKEY(DIVFILE)) Q:DIVFILE=""  D  Q:$D(DIRUT)
 .. S DIVKNM="" F  S DIVKNM=$O(DIVKEY(DIVFILE,DIVKNM)) Q:DIVKNM=""  D  Q:$D(DIRUT)
 ... S DIVXRNM="" F  S DIVXRNM=$O(DIVKEY(DIVFILE,DIVKNM,DIVXRNM)) Q:DIVXRNM=""  D  Q:$D(DIRUT)
 .... S DIVPROB=DIVKEY(DIVFILE,DIVKNM,DIVXRNM)
 .... S M=Q_X_Q_": "_$S(DIVPROB="null":"Key values are missing.",1:"Key is not unique.")
 .... S M=M_" (File #"_DIVFILE_", Key "_DIVKNM_", Index "_DIVXRNM_")"
 .... D IER
 ;
 ;Continue with checking traditional xrefs (if any) and data type
 G @DIVTYPE
 ;
IER ;Print info about invalid indexes. (Modeled after DA subroutine above)
 N DIVTXT,DIVI,X
 ;
 ;Wrap message M to within 40 columns
 S DIVTXT(0)=M D WRAP^DIKCU2(.DIVTXT,40)
 ;
 ;If nothing was written yet, write column headers
 I $O(^UTILITY("DIVR",$J,0))="" X W
 ;
 ;Set ^UTILITY("DIVR",$J,topIen)="", X = level#, naked = top level root
 S X=$S(V:DA(V),1:DA),^UTILITY("DIVR",$J,X)=""
 S X=V I @(I(0)_"0)")
 ;
IER1 ;If top level, write record info and message
 I 'X D  Q
 . D LF Q:$D(DIRUT)  W DA,?10,$S($D(^(DA,0)):$P(^(0),U),1:DA)
 . F DIVI=0:1 Q:$D(DIVTXT(DIVI))[0  D  Q:$D(DIRUT)
 .. I DIVI D LF Q:$D(DIRUT)
 .. W ?40,DIVTXT(DIVI)
 . D:V LF
 ;
 ;Else write subrecord info, decrement level, set naked = ^naked(node,0)
 D LF Q:$D(DIRUT)
 W DA(X),?10,$P(^(DA(X),0),U) S X=X-1,@("Y=$D(^("_I(V-X)_",0))")
 G IER1
 ;
LF ;Issue a line feed or EOP read
 I $Y+3<IOSL W ! Q
 ;
 N DINAKED S DINAKED=$$LGR^%ZOSV
 I IOST?1"C-".E D
 . N DIR,X,Y
 . S DIR(0)="E" W ! D ^DIR
 ;
 I '$D(DIRUT) D
 . I $D(ZTQUEUED),$$S^%ZTLOAD S (ZTSTOP,DIRUT)=1
 . E  W @IOF D HDR
 S:DINAKED]"" DINAKED=$S(DINAKED["""""":$O(@DINAKED),1:$D(@DINAKED))
 Q
 ;
HDR ;Print header
 N DIVTAB
 S DIVPG=$G(DIVPG)+1
 W "VERIFY FIELDS REPORT"
 ;
 S DIVTAB=IOM-1-$L(DIVFIL)-$L(DIVDAT)-$L(DIVPG)
 I DIVTAB>1 W !,DIVFIL_$J("",DIVTAB)_DIVDAT_DIVPG
 E  W !,DIVFIL,!,$J("",IOM-1-$L(DIVDAT)-$L(DIVPG))_DIVDAT_DIVPG
 W !,$TR($J("",IOM-1)," ","-"),!
 Q
