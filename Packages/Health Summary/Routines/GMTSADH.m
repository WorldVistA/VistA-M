GMTSADH ;SLC/JER,MAM - Ad Hoc Summary Driver ; 09/21/2001
 ;;2.7;Health Summary;**30,35,47**;Oct 20, 1995
 ;
 ; External References
 ;   DBIA 10035  ^DPT(
 ;   DBIA   148  PATIENT^ORU1
 ;   DBIA 10141  $$VERSION^XPDUTL
 ;   DBIA    82  EN^XQORM
 ;   DBIA 10026  ^DIR
 ;   DBIA 10102  DISP^XQORM1
 ;                 
MAIN ; Ad Hoc Health Summary Driver
 N C,DFN,GMTSEG,GMTSEGI,GMTSEGC,GMTSQIT,GMTSTYP,GMTSTITL,GMW,X,Y,DIC,DIPGM,I,POP,%,DIROUT,DUOUT,DTOUT,ZTRTN,GMTSQIT,FROM,GMI,I1,ISVALID,LRDFN,PTR,SEX,TO,VAOA,VASD,VASV
 I $L($T(PATIENT^ORU1)),($$VERSION^XPDUTL("OR")>2.19) D MAIN^GMTSADHC Q
 S DIC=142,DIC(0)="MZF",X="GMTS HS ADHOC OPTION",Y=$$TYPE^GMTSULT K DIC S GMTSTYP=+Y,GMTSTITL="AD HOC"
 F  K GMTSEG,GMTSEGI,GMTSEGC D BUILD D  Q:$D(DIROUT)!$D(DUOUT)!$D(DTOUT) 
 . N GMPAT,DFN,GMTSMULT F  D  Q:$D(DIROUT)!$D(DUOUT)!$D(DTOUT)!(+$D(GMPAT)'>0)
 . . Q:$D(DIROUT)!$D(DUOUT)!$D(DTOUT)
 . . K GMPAT,GMTSMULT F  Q:$D(DIROUT)  K DFN W ! D SELPT^GMTS Q:+($G(DFN))'>0  D
 . . . N GMNAME S GMNAME=$P($G(^DPT(+DFN,0)),U) Q:GMNAME=""  S GMPAT(GMNAME,+($G(DFN)))=+($G(DFN))
 . . Q:$D(DIROUT)!$D(DUOUT)!$D(DTOUT)!(+$D(GMPAT)'>0)
 . . D RESUB^GMTSDVR(.GMPAT) S ZTRTN="PQ^GMTS" N DUOUT D HSOUT^GMTSDVR,END^GMTS W !
 Q
BUILD ; Conducts Dialogue to build Ad Hoc Summary
 N GMI,GMJ,GMW,X,XQORM,Y Q:$D(GMTSQIT)!($D(DIROUT))  W @IOF
 S XQORM("S")="I $D(^GMT(142,DA(1),1,DA,0)),($P(^GMT(142.1,$P(^GMT(142,DA(1),1,DA,0),U,2),0),U,6)'=""T"")",XQORM("M")=6
 S XQORM=GMTSTYP_";GMT(142,",XQORM(0)="AD",XQORM("A")="Select NEW set of COMPONENT(S): ",XQORM("??")="D HELP^GMTSADH" D EN^XQORM I Y'>0 S DIROUT=1 Q
 G:+Y&(X?1"^^".E) BUILD S GMTSEGC=Y,(X,GMI,GMJ)=0 F  S GMI=$O(Y(GMI)) Q:'GMI  D LOAD
 D GETLIM^GMTSADH1
 Q
LOAD ; Load enabled components 
 N SREC,STRN S STRN=+Y(GMI),SREC=^GMT(142,GMTSTYP,1,STRN,0)
LOAD1 ; Load array GMTSEG and GMTSEGI
 S GMJ=GMJ+1,GMTSEG(GMJ)=SREC,GMTSEGI($P(SREC,U,2))=GMJ D LOADSEL
 Q
LOADSEL ; Loads GMTSEG(J,FN,IFN)   (Selection Items)
 N S2,SJ,SEL,SR,SF S S2=0,SJ=GMJ
 F  S S2=$O(^GMT(142,GMTSTYP,1,STRN,1,S2)) Q:'S2  D
 . S SEL=^(S2,0),SR=U_$P(SEL,";",2) Q:SR="^"
 . S SF=+$P(@(SR_"0)"),U,2) Q:+SF=0
 . S GMTSEG(GMJ,SF,S2)=$P(SEL,";"),GMTSEG(GMJ,SF,0)=SR
 Q
HELP ; Display Help Text
 N GMJ,GMTSTXT,HLP S HLP=$S(X="??":"HTX2",X="?":"HTX1",1:"") I $L(HLP) W ! F GMJ=1:1 S GMTSTXT=$T(@HLP+GMJ) Q:GMTSTXT["ZZZZ"  W !,$P(GMTSTXT,";",3,99)
 I X="???" W !! D HELP2^GMTSUP1
 D REDISP
 Q
REDISP ; Ask Whether or not to redisplay menu
 N I,DIR,X,Y S DIR(0)="Y",DIR("A")="Redisplay items",DIR("B")="YES" D ^DIR Q:'Y
 W @IOF D DISP^XQORM1 W !
 Q
HTX1 ;; Help Text for "?" and "??"
 ;; Select ONE or MORE items from the menu, separated by commas.
 ;;
 ;; Enter: ??  to see HELP for MULTIPLE SELECTION
 ;;        ??? to see HELP for "^^"-jump
 ;;
 ;;ZZZZ
HTX2 ;; Help Text for ??
 ;;
 ;; The Health Summary components you select at this prompt create
 ;; an ADHOC Health Summary.
 ;;
 ;; Select ONE or MORE items from the menu, separated by commas.
 ;;
 ;; ALL items may be selected by typing "ALL".
 ;;
 ;; EXCEPTIONS may be entered by preceding them with a minus.
 ;;   For example, "ALL,-THIS,-THAT" selects all but "THIS" and "THAT".
 ;;
 ;; NOTE: Menu items are ordered alphabetically by the Component NAME.
 ;;       However, the displayed text is the Header Name which generally 
 ;;       is different from the Component Name. Component may be picked
 ;;       by their abbreviation, Header Name or Component Name.
 ;;
 ;;ZZZZ
