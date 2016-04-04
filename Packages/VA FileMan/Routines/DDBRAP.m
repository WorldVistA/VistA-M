DDBRAP ;SFISC/DCL-BROWSER WP ANCHOR PROCESSOR ;06:56 PM  31 Aug 2002
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;;GFT;**999**
 ;
 Q
WP(DDBROOT,DDBRFLG,DDBRTLE) ;
 ;Pass existing wp root, flag=c/clear all -indexes, title
 I $G(DDBROOT)="" Q
 I '$D(@DDBROOT) Q
 S DDBROOT=$NA(@DDBROOT),DDBRFLG=$G(DDBRFLG),DDBRTLE=$G(DDBRTLE)
 N DDBRINDX,DDBRSUB,DDBRSUBL,DDBNROOT,DDBSROOT,DDBAXRT,DDBRCHK,DDBRCHK1
 N DDBRSX,DDBRSXL,DDBRI,DDBRSXP,DDBRX,DDBRTLER
 S DDBRINDX=0,DDBNROOT=$$NROOT(DDBROOT),DDBAXRT=$NA(@DDBNROOT@("A")),DDBRCHK1=0
 Q:DDBNROOT=""!(DDBAXRT="")
 K @DDBAXRT
 F  S DDBRINDX=$O(@DDBROOT@(DDBRINDX)),DDBRCHK=1 Q:DDBRINDX'>0  D:$L($G(@DDBROOT@(DDBRINDX,0)),"$.$")>1  I DDBRCHK,$L($G(@DDBROOT@(DDBRINDX)),"$.$")>1 S DDBRCHK1=1 D
 .S DDBRCHK=0
 .I DDBRCHK1 S DDBRSX=@DDBROOT@(DDBRINDX),DDBRSXL=$L(DDBRSX,"$.$")
 .E  S DDBRSX=@DDBROOT@(DDBRINDX,0),DDBRSXL=$L(DDBRSX,"$.$")
 .F DDBRI=2:2:DDBRSXL S DDBRSXP=$P(DDBRSX,"$.$",DDBRI) S:'$D(@DDBAXRT@(DDBRSXP)) @DDBAXRT@(DDBRSXP)=DDBRINDX
 .Q
 S DDBRX=""
 I DDBRTLE]"" D
 .I '$D(@DDBNROOT@("TITLE")) S @DDBNROOT@("TITLE")=DDBRTLE
 .Q
 I $G(@DDBNROOT@("TITLE"))']"" D
 .Q:$$QL(DDBROOT)'>1
 .S DDBRTLER=$NA(@DDBROOT,$$QL(DDBROOT)-1)
 .S DDBRTLE=$P($G(@DDBRTLER@(0)),"^")
 .I DDBRTLE]"" S @DDBNROOT@("TITLE")=DDBRTLE Q
 .Q
 S @DDBNROOT@("DATE")=$H
 Q
 ;
NROOT(DDBROOT) ; *FUNCTION* return new (negative) root for wp field X-REF
 ;Q $NA(@DDBROOT@(.001))  ;tested ok
 Q $NA(@DDBROOT@(-1))  ;tested ok and in use
 ;Q $NA(@DDBROOT@(0,0))  ;tested ok
 ;
BINDEX(DDBROOT,DDBRNR,DDBRNRN) ; *FUNCTION* return "B" index root
 N DDBRSUBL,DDBSROOT
 S DDBRSUBL=$$QL(DDBROOT)
 Q:DDBRSUBL'>1 ""
 S DDBSROOT=$NA(@DDBROOT,(DDBRSUBL-2))
 S DDBRNR=DDBSROOT,DDBRNRN=$$QS(DDBROOT,DDBRSUBL)
 Q $NA(@DDBSROOT@("B"))
 ;
IENROOT(DDBROOT,DDBRLEV) ;pass root,.variable~by reference to return
 ;                                           $qs(ddbroot,$ql(ddbroot))~
 N DDBRSUBL,DDBSROOT
 S DDBRSUBL=$$QL(DDBROOT)
 Q:DDBRSUBL'>1 ""
 S DDBRLEV=$$QS(DDBROOT,DDBRSUBL)
 Q $NA(@DDBROOT,(DDBRSUBL-2))
 ;
EN ;create anchors and jumps on existing wp entry
 N DDBC,DDBFLG,DDBL,DDBPMSG,DDBSA,DDBX,IOTM,IOBM
 I '$$TEST^DDBRT W $C(7),!!,$$EZBLD^DIALOG(830),!! Q  ;**
 D LIST^DDBR3(.DDBX)
 I DDBX'>0 W:DDBX=0 $C(7),!!,$$EZBLD^DIALOG(1404),!! Q  ;**NO TEXT
 S DDBSA=DDBX(6)
 S DDBFLG=DDBX(4)
 S DDBPMSG=DDBX(5)
 W !,"...." ;**
 D WP(DDBSA,$G(DDBRFLG),DDBPMSG)
 W !,"done!",!
 Q
 ;
ENP ;create anchors & jumps and 'P'urge non-referenced jumps
 N DDBRFLG
 S DDBRFLG="P"
 G EN
 ;
ENC ;create anchors and jumps and "C"lear out all jumps prior to building
 N DDBRFLG
 S DDBRFLG="C"
 G EN
 ;
 ; THE FOLLOWING CODE WAS COPIED FROM KERNEL'S XLFUTL ROUTINE
QL(X) ;$QLENGTH OF GLOBAL STRING
 N %,%1
 S %1="" F %=0:1 Q:%1=$NA(@X,%)  S %1=$NA(@X,%)
 Q %-1
 ;
QS(X1,X2) ;$QSUBSCRIPT OF GLOBAL STRING
 N %,%1,Y
 I X2=-1,X1?1"^"1"[".E1"]".E Q $TR($P($P($NA(@X1,0),"]"),"[",2),"""")
 I X2=-1,X1?1"^"1"|".E1"|".E Q $TR($P($NA(@X1,0),"|",2,$L($NA(@X1,0),"|")-1),"""")
 I X2=0,(X1'?1"^"1"[".E)&(X1'?1"^"1"|".E) Q $NA(@X1,X2)
 I X2=0,X1?1"^"1"[".E1"]".E Q "^"_$P($NA(@X1,X2),"]",2,999)
 I X2=0,X1?1"^"1"|".E Q "^"_$P($NA(@X1,X2),"|",$L($NA(@X1,X2),"|"))
 S %1=$NA(@X1,X2-1)
 I $E(%1,$L(%1))=")" S %1=$E(%1,1,$L(%1)-1)
 S Y=$P($NA(@X1,X2),%1,2,999),Y=$E(Y,1,$L(Y)-1)
 I X2=1,$E(Y)="(" S Y=$E(Y,2,999)
 I X2>1,$E(Y)="," S Y=$E(Y,2,999)
 I $A(Y)=34,$A(Y,$L(Y))=34 S Y=$E(Y,2,$L(Y)-1)
 Q Y
 ;
GETR(DDBRWPDD,DDBRENS,DDBRFLG) ;return root
 ;pass Word-processing DD#, entries (external format)[separated by(:)]
 ;ie.999008.02,ENTRYONE:SUBENTRY)
 ;
 N DDBRA,DDBROOT,DDBREL,DDBRLVLS,DDBRI,DDBREN,DDBRIEN,DDBRDA,DDBRX,DDBRDD,DDBREEN,X,Y
 Q:'$$UP^DIQGU(DDBRWPDD,.DDBRA)
 S DDBREL=$L(DDBRENS,":"),DDBRLVLS=$O(DDBRA("")),DDBREN=1,DDBRIEN=","
 I $G(DDBRFLG)'["I",$G(DUZ(0))'="@" D  Q:$G(DIERR) ""
 .N DIFILE,DIAC,%
 .S DIFILE=+DDBRA(DDBRLVLS),DIAC="RD"
 .D ^DIAC
 .Q:%
 .D ERR("Read access denied, for file #"_DIFILE)
 .Q
 I ("-"_DDBREL)'=DDBRLVLS Q ""
 F DDBRI=DDBRLVLS:1:-1 D  Q:$G(DIERR)
 .S DDBRDD=+DDBRA(DDBRI),DDBREEN=$P(DDBRENS,":",DDBREN),DDBREN=DDBREN+1
 .D DA^DILF(DDBRIEN,.DDBRDA)
 .S DDBRIEN=","_+$$DIC($$ROOT^DILFD(DDBRDD,DDBRIEN),DDBREEN,.DDBRDA)_DDBRIEN
 .Q
 I $G(DIERR) K DIERR,^TMP("DIERR",$J) Q ""
 S DDBRX=$$GET^DIQG(+DDBRA(-1),$P(DDBRIEN,",",2,99),$O(^DD(+DDBRA(-1),"SB",+DDBRA(0),"")),"B")
 I $G(DIERR) K DIERR,^TMP("DIERR",$J) Q ""
 Q $P(DDBRX,"$CREF$",2)
 ;
DIC(DIC,X,DA) ;dic call for exaxt match
 Q:DIC=""!(X="") ""
 S DIC(0)="X" S:$E(X)="`" DIC(0)="N"
 D ^DIC
 Q $G(Y)
 ;
ERR(DDBERR) N P S P(1)=DDBERR
 I $G(U)="^" N U S U="^"
 D BLD^DIALOG(1700,.P)
 Q
