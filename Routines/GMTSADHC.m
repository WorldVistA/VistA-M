GMTSADHC ; SLC/KER - Ad Hoc Summary Driver ; 09/21/2001
 ;;2.7;Health Summary;**6,27,28,30,31,35,47**;Oct 20, 1995
 ;
 ; External References
 ;   DBIA 10060  ^VA(200
 ;   DBIA  2160  ^XUTL("OR")
 ;   DBIA 10141  $$VERSION^XPDUTL
 ;   DBIA   148  PATIENT^ORU1
 ;   DBIA    82  EN^XQORM
 ;   DBIA 10026  ^DIR
 ;   DBIA 10102  DISP^XQORM1
 ;                          
MAIN ; Ad Hoc Summary Driver
 N I,XQORSPEW,%T S DIC=142,DIC(0)="MZF",X="GMTS HS ADHOC OPTION",Y=$$TYPE^GMTSULT K DIC Q:+Y'>0  S GMTSTYP=+Y,GMTSTITL="AD HOC"
 F  D  Q:$D(DUOUT)!$D(DIROUT)!'$D(GMTSEG)
 . K GMTSEG,GMTSEGI,GMTSEGC D BUILD Q:$D(DUOUT)!$D(DIROUT)!'$D(GMTSEG)
 . N GMPAT,GMP F  Q:$D(DIROUT)  D  Q:$D(DUOUT)!$D(DIROUT)!(+$D(GMPAT)'>0)!+$G(ORVP)
 . . K GMP,GMPAT
 . . I +$G(ORVP) S GMPAT(1)=+ORVP
 . . E  F  Q:$D(DIROUT)  K ^XUTL("OR",$J,"ORU"),^("ORV"),^("ORW"),^("ORLP"),GMP D PTPC Q:$S($D(DUOUT):1,$D(DIROUT):1,'+$G(GMP):1,$P($G(^VA(200,DUZ,100.1)),U,6)]"":1,1:0)  D
 . . . W !!,"Another patient(s) can be selected."
 . . Q:$D(DUOUT)!$D(DIROUT)!(+$D(GMPAT)'>0)
 . . D RESUB^GMTSDVR(.GMPAT) S ZTRTN="PQ^GMTSADHC" W !
 . . D HSOUT^GMTSDVR
 K ^XUTL("OR",$J,"ORU"),^("ORV"),^("ORW"),^("ORLP")
 Q
PTPC ; Combined Patient/Patient Copy
 N GMTSPRO,GMTSVER S GMTSVER=+($$VERSION^XPDUTL("OR")),GMTSPRO=+($$PROK^GMTSU("ORU1",11))
 D:GMTSVER>2.9&(GMTSPRO) PATIENT^ORU1(.GMP,,"I  $P($G(^(""OOS"")),""^"")")
 D:GMTSVER'>2.9!('GMTSPRO) PATIENT^ORU1(.GMP) D PATCOPY^GMTSDVR(.GMP,.GMPAT)
 Q
PQ ; Queued subroutine to print Ad Hoc HS for each patient
 N GMTS,GMTS1,GMTS2,GMTSAGE,GMTSDOB,GMTSDTM,GMTSLO,GMTSLPG,GMTSPHDR,GMTSPNM,GMTSRB,GMTSSN,GMTSTOF,GMTSWARD,VADM,VAERR,VAIN,VAROOT
 S GMPAT=0 F  S GMPAT=$O(GMPAT(GMPAT)) Q:GMPAT'>0  D  Q:$D(GMTSQIT)!$D(DIROUT)
 . S DFN=+$G(GMPAT(GMPAT)) D EN^GMTS1
 Q
BUILD ; Conducts Dialogue to build ad hoc summary
 N GMI,GMJ,X,XQORM,Y Q:$D(GMTSQIT)!($D(DIROUT))  W @IOF
 S XQORM("S")="I $D(^GMT(142,DA(1),1,DA,0)),($P(^GMT(142.1,$P(^GMT(142,DA(1),1,DA,0),U,2),0),U,6)'=""T"")",XQORM("M")=6
 S XQORM=GMTSTYP_";GMT(142,",XQORM(0)="AD",XQORM("A")="Select NEW set of COMPONENT(S): ",XQORM("??")="D HELP^GMTSADH" D EN^XQORM I Y'>0 S GMTSQIT="" Q
 I +Y,(X?1"^^".E) G BUILD
 S GMTSEGC=Y
 S (X,GMI,GMJ)=0 F  S GMI=$O(Y(GMI)) Q:'GMI  D LOAD
 D GETLIM^GMTSADH1
 Q
LOAD ; Load enabled components
 N SREC,STRN S STRN=+Y(GMI),SREC=^GMT(142,GMTSTYP,1,STRN,0)
LOAD1 ; Load GMTSEG and GMTSEGI arrays
 S GMJ=GMJ+1,GMTSEG(GMJ)=SREC,GMTSEGI($P(SREC,U,2))=GMJ D LOADSEL
 Q
LOADSEL ; Loads GMTSEG(J,FN,IFN)   (Selection Items)
 N SR,SF,S2,SEL S S2=0 F  S S2=$O(^GMT(142,GMTSTYP,1,STRN,1,S2)) Q:'S2  D
 . S SEL=^(S2,0),SR=U_$P(SEL,";",2) Q:SR="^"
 . S SF=+$P(@(SR_"0)"),U,2) Q:+SF=0
 . S GMTSEG(GMJ,SF,S2)=$P(SEL,";"),GMTSEG(GMI,SF,0)=SR
 Q
HELP ; Display Help Text 
 N GMJ,GMTSTXT,HLP S HLP=$S(X="??":"HTX2",X="?":"HTX1",1:"") I $L(HLP) W ! F GMJ=1:1 S GMTSTXT=$T(@HLP+GMJ) Q:GMTSTXT["ZZZZ"  W !,$P(GMTSTXT,";",3,99)
 I X="???" W !! D HELP2^GMTSUP1
 D REDISP
 Q
REDISP ; Ask Whether or not to redisplay menu
 N I,DIR,X,Y S DIR(0)="Y",DIR("A")="Redisplay items",DIR("B")="YES" D ^DIR Q:'Y  W @IOF
 D DISP^XQORM1 W !
 Q
HTX1 ; Help Text for "?" and "??"
 ;;Select ONE or MORE items from the menu, separated by commas.
 ;;
 ;;Enter: ??  to see HELP for MULTIPLE SELECTION
 ;;       ??? to see HELP for "^^"-jump
 ;;
 ;;ZZZZ
HTX2 ; Help Text for ??
 ;;
 ;;The Health Summary components you select at this prompt create
 ;;an ADHOC Health Summary.
 ;;
 ;;Select ONE or MORE items from the menu, separated by commas.
 ;;
 ;;ALL items may be selected by typing "ALL".
 ;;
 ;;EXCEPTIONS may be entered by preceding them with a minus.
 ;;  For example, "ALL,-THIS,-THAT" selects all but "THIS" and "THAT".
 ;;
 ;;NOTE: Menu items are ordered alphabetically by the Component NAME.
 ;;      However, the displayed text is the Header Name which generally 
 ;;      is different from the Component Name. Component may be picked
 ;;      by their abbreviation, Header Name or Component Name.
 ;;
 ;;ZZZZ
