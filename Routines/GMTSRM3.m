GMTSRM3 ; SLC/DLT - Create/Modify - Selection Items ; 08/27/2002
 ;;2.7;Health Summary;**56,62,63**;Oct 20, 1995
 ;
 ; External References
 ;   DBIA  2160  ^XUTL("OR")
 ;   DBIA    67  ^LAB(60,
 ;   DBIA  3137  EN^ORUS
 ;                    
EN ; Entry Logic for Selection Items
 N GMTSN W !!,$S($O(^GMT(142,DA(1),1,DA,1,0)):"Current selection items are:  ",1:"No selection items chosen.")
 S GMTSN=0 F  S GMTSN=$O(^GMT(142,DA(1),1,DA,1,GMTSN)) Q:+GMTSN'>0  S GMTSN(0)=^(GMTSN,0) D SHOWSEL
 W !!,"Select new items one at a time in the sequence you want them displayed."
 W !,"You may select " I SELCNT="" W "any number of items.",!
 E  W "up to ",SELCNT," items.",!
 Q
SHOWSEL ; Writes Current Selection Items
 W ?30,$P(@("^"_$P(GMTSN(0),";",2)_+GMTSN(0)_",0)"),U),!
 Q
EXIT ; Exit Logic for Selection Items
 N GMTSN,SELREF,GMREF I +X,(X["LAB(60,") D
 . S SELREF=U_$P(X,";",2)_+X_",",GMREF=X
 . I '$L($P($G(@(SELREF_"0)")),U,5)) D RESOLVE(GMREF)
 I $S('$D(DA(1)):1,'$D(DA(2)):1,1:0) Q
 S (GMTSNCNT,GMTSN)=0 F  S GMTSN=$O(^GMT(142,DA(2),1,DA(1),1,GMTSN)) Q:'GMTSN  S GMTSNCNT=GMTSNCNT+1
 S $P(^GMT(142,DA(2),1,DA(1),1,0),U,4)=GMTSNCNT
 I SELCNT,(GMTSNCNT'<SELCNT) W !?2,$C(7),"MAXIMUM # OF ITEMS SELECTED.",!
 Q
RESOLVE(GMREF) ; Resolve Compound Items
 N C,IEN,GMI,GMHEAD,P,X,Y K ^XUTL("OR",$J,"ORU"),^("ORV"),^("ORW")
 S GMHEAD="-- "_$P($G(^LAB(60,+GMREF,.1)),U)_" --"
 S ^XUTL("OR",$J,"GMTS",0)="LAB TEST^1^^0" D COMPILE(+GMREF)
 S ORUS="^XUTL(""OR"","_$J_",""GMTS"",",ORUS("T")="D HEADER^GMTSRM3"
 I +$G(SELCNT) D
 . S ORUS(0)="40MN^"_SELCNT
 . S ORUS("A")="Select 1 - "_SELCNT_" LAB TEST(s): ",ORUS("B")="1-"_SELCNT
 E  S ORUS(0)="40MN",ORUS("A")="Select LAB TEST(s): ",ORUS("B")="ALL"
 D EN^ORUS K ^XUTL("OR",$J,"GMTS"),^("ORU"),^("ORV"),^("ORW")
 I $S('$D(CMP(142.14,DA)):1,$G(CMP(142.14,DA))=GMREF:1,1:0) D
 . I $D(CMP(142.14,+$O(CMP(142.14,DA)))) D
 . . S GMI=DA F  S GMI=$O(CMP(142.14,GMI)) Q:+GMI'>0!(GMI'<(DA+Y))  S CMP(142.14,GMI+Y)=CMP(142.14,GMI)
 . S GMI=0 F  S GMI=$O(Y(GMI)) Q:GMI'>0  D
 . . I '$D(^GMT(142,+$G(DA(2)),1,+$G(DA(1)),1,"B",+$G(Y(GMI))_";LAB(60,")) D
 . . . S CMP(142.14,((GMI-1)+DA))=+$G(Y(GMI))_";LAB(60,"
 S IEN=0 F  S IEN=$O(CMP(142.14,IEN)) Q:IEN'>0  D
 . I $D(^GMT(142,+$G(DA(2)),1,+$G(DA(1)),1,"B",CMP(142.14,IEN))) W $C(7),!,"  Duplicate test omitted." K CMP(142.14,IEN) Q
 . D LOADSEL^GMTSRM1A
 I $P($G(^LAB(60,+$G(^GMT(142,+DA(2),1,+DA(1),1,+DA,0)),0)),U,5)']"" D
 . N REC,SUBREC,SUBSUB S REC=DA(2),SUBREC=DA(1),SUBSUB=DA
 . D DELCOSMO(REC,SUBREC,SUBSUB)
 Q
REITEM(GMTST,GMTSS) ; Resequence Items
 Q:+($G(GMTST))'>0  Q:'$D(^GMT(142,+($G(GMTST))))
 Q:+($G(GMTSS))'>0  Q:'$D(^GMT(142,+GMTST,1,+($G(GMTSS))))
 N DIR,DTOUT,DUOUT,DIRUT,DIROUT,GMTSA,GMTSCN,GMTSCA,GMTSMAX,GMTSN,GMTSI,Y,X
 D ARY(GMTST,GMTSS,.GMTSA) Q:+($G(GMTSA(0)))'>1
 S GMTSCN=$P($G(^GMT(142,GMTST,1,GMTSS,0)),"^",2),GMTSCA=$P($G(^GMT(142.1,+GMTSCN,0)),"^",4),GMTSCN=$P($G(^GMT(142.1,+GMTSCN,0)),"^",1)
 W !,?1,GMTSCN,"    ",$S($L(GMTSCA):"(",1:""),GMTSCA,$S($L(GMTSCA):")",1:"")
 S GMTSN=0 F  S GMTSN=$O(GMTSA(GMTSN)) Q:+GMTSN=0  W !,$J(GMTSN,6),"  ",GMTSA(GMTSN)
 S DIR(0)="YAO",DIR("?")="^D RIH^GMTSRM3",DIR("A")=" Do you want to resequence the selection items?  "
 W ! D ^DIR I $D(DTOUT)!($D(DUOUT))!($D(DIRUT))!($D(DIROUT)) Q
 Q:+Y'>0
 N DA S DA(2)=+($G(GMTST)),DA(1)=+($G(GMTSS)) D RSI^GMTSRS2
 Q
RIH ; Resequence Items Help
 W !,?4,"Enter either 'Y' or 'N'." Q
ARY(GMTST,GMTSS,ARY) ; Array of Items
 N GMTSC,GMTSI,GMTSVAL,GMTSPTR,GMTSFRT,GMTSCRT,GMTSFFRT,GMTSFCRT,GMTSTYPE
 N GMTSRT,GMTSUB S ARY(0)=0 Q:+($G(GMTST))'>0  Q:'$D(^GMT(142,+($G(GMTST))))  Q:+($G(GMTSS))'>0  Q:'$D(^GMT(142,+GMTST,1,+($G(GMTSS))))
 S (GMTSC,GMTSI)=0 F  S GMTSI=$O(^GMT(142,GMTST,1,GMTSS,1,GMTSI)) Q:+GMTSI=0  D
 . S GMTSVAL=$G(^GMT(142,GMTST,1,GMTSS,1,GMTSI,0)),GMTSPTR=+GMTSVAL,GMTSFRT=$P(GMTSVAL,";",2) Q:GMTSFRT'["("  S:GMTSFRT'["^" GMTSFRT="^"_GMTSFRT
 . S GMTSCRT=$$CREF^DILF(GMTSFRT),GMTSFFRT=GMTSFRT_GMTSPTR_","
 . S GMTSFCRT=$$CREF^DILF(GMTSFFRT) Q:'$D(@GMTSFCRT)  Q:'$L($G(@($P(GMTSFCRT,")",1)_",0)")))
 . I GMTSFCRT["^AUTTHF(" D  Q
 ..S GMTSTYPE=$S($P($G(@($P(GMTSFCRT,")",1)_",0)")),"^",10)="C":"CATEGORY",$P($G(@($P(GMTSFCRT,")",1)_",0)")),"^",10)="F":"FACTOR",1:" ")
 ..S GMTSUB=$$LJ^XLFSTR($P($G(@($P(GMTSFCRT,")",1)_",0)")),"^",1),42)_GMTSTYPE,GMTSC=GMTSC+1,ARY(GMTSC)=GMTSUB,ARY(0)=+GMTSC
 . S GMTSUB=$P($G(@($P(GMTSFCRT,")",1)_",0)")),"^",1),GMTSC=GMTSC+1,ARY(GMTSC)=GMTSUB,ARY(0)=+GMTSC
 Q
COMPILE(GMTEST) ; Compile Menu
 N GMC,GMI,GMJ,GMROOT
 S GMI=0 F  S GMI=$O(^LAB(60,GMTEST,2,GMI)) Q:GMI'>0  D
 . S GMJ=+$G(^LAB(60,GMTEST,2,+GMI,0))
 . S GMROOT=$G(^LAB(60,+GMJ,0))
 . I $L($P(GMROOT,U,5)) D
 . . S GMC=+$P($G(^XUTL("OR",$J,"GMTS",0)),U,4)+1
 . . S ^XUTL("OR",$J,"GMTS",GMJ,0)=$P(GMROOT,U),$P(^XUTL("OR",$J,"GMTS",0),U,4)=GMC
 . E  D COMPILE(+$G(^LAB(60,GMTEST,2,GMI,0)))
 Q
HEADER ; Write Header
 W !!?15,"Select the tests which you wish to include, in the",!?19,"sequence in which you wish them to appear."
 W !!?((80-$L(GMHEAD))\2),GMHEAD,!
 Q
DELCOSMO(X1,X2,X3) ; Delete Cosmic Lab Tests from Selection Items
 N TEST S TEST=$G(^GMT(142,X1,1,X2,1,X3,0))
 K ^GMT(142,X1,1,X2,1,"B",TEST),^GMT(142,X1,1,X2,1,X3,0)
 Q
