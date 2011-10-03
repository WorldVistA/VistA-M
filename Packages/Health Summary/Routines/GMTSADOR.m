GMTSADOR ;SLC/KER - Ad Hoc Summary Driver ; 09/21/2001
 ;;2.7;Health Summary;**30,35,47**;Oct 20, 1995
 ;                     
 ; External References
 ;   DBIA 10026  ^DIR
 ;   DBIA 10140  EN^XQORM
 ;   DBIA 10102  DISP^XQORM1
 ;                     
MAIN ; External call to allow user to define components and
 ; defaults through the AD Hoc menu interface and print
 ; health summaries for a programmer-specified patient 
 ; and device. Called with:
 ;                     
 ;    DFN = Patient internal file record number (optional)
 ;          For OE/RR interface sets DFN to Patient DFN in
 ;          the ORVP variable.  If not defined a patient 
 ;          will be prompted for.
 ;                     
 N C,GMTSEG,GMTSEGI,GMTSEGC,GMTSQIT,GMTSTYP,GMTSTITL,GMW,X,Y,DIC,DIPGM,I,POP,%,GMTSMULT,DIROUT,DUOUT,DTOUT,ZTRTN
 S DIC=142,DIC(0)="MZF",X="GMTS HS ADHOC OPTION" S Y=$$TYPE^GMTSULT K DIC Q:+Y'>0  S GMTSTYP=+Y,GMTSTITL="AD HOC"
 I $G(DFN)'>0 S DFN=$S($D(ORVP):$P(ORVP,";"),1:"") D:+DFN'>0 SELPT^GMTS
 Q:+($G(DFN))'>0  F  K GMTSEG,GMTSEGI,GMTSEGC D BUILD Q:$D(GMTSQIT)!($D(DIROUT))  D HSOUT^GMTS,END^GMTS S:$D(DTOUT) GMTSQIT="" Q:$D(GMTSQIT)!($D(DIROUT))
 D END
 Q
BUILD ; Conducts Dialogue to build Ad Hoc Summary
 N GMI,GMJ,GMW,X,XQORM,Y Q:$D(GMTSQIT)!($D(DIROUT))  W @IOF
 S XQORM("S")="I $D(^GMT(142,DA(1),1,DA,0)),($P(^GMT(142.1,$P(^GMT(142,DA(1),1,DA,0),U,2),0),U,6)'=""Y"")"
 S XQORM=GMTSTYP_";GMT(142,",XQORM(0)="DA",XQORM("A")="Select COMPONENT(S): ",XQORM("??")="D HELP^GMTSADH" D EN^XQORM I Y'>0 S GMTSQIT="" Q
 G:+Y&(X?1"^^".E) BUILD S GMTSEGC=Y,(X,GMI,GMJ)=0 F  S GMI=$O(Y(GMI)) Q:'GMI  D LOAD
 D GETLIM^GMTSADH1
 Q
LOAD ; Load enabled components
 N SREC,STRN S STRN=+Y(GMI),SREC=^GMT(142,GMTSTYP,1,STRN,0)
LOAD1 ; Load array GMTSEG
 S GMJ=GMJ+1,GMTSEG(GMJ)=SREC,GMTSEGI($P(SREC,U,2))=GMJ D LOADSEL
 Q
LOADSEL ; Loads GMTSEG(J,FN,IFN)  (Selection Items)
 N S2,SEL,SR,SF S S2=0 F  S S2=$O(^GMT(142,GMTSTYP,1,STRN,1,S2)) Q:'S2  D
 . S SEL=^(S2,0),SR=U_$P(SEL,";",2) Q:SR="^"
 . S SF=+$P(@(SR_"0)"),U,2) Q:+SF=0
 . S GMTSEG(GMJ,SF,S2)=$P(SEL,";"),GMTSEG(GMJ,SF,0)=SR
 Q
END ; Cleans up any residual locals
 K GMTSQIT,FROM,GMI,I1,ISVALID,LRDFN,PTR,SEX,TO,VAOA,VASD,VASV,X Q
HELP ; Display Help Text
 N GMJ,GMTSTXT,HLP S HLP=$S(X="??":"HTX2",X="?":"HTX1",1:"") I $L(HLP) W ! F GMJ=1:1 S GMTSTXT=$T(@HLP+GMJ) Q:GMTSTXT["ZZZZ"  W !,$P(GMTSTXT,";",3,99)
 I X="???" W !! D HELP2^GMTSUP1
 D REDISP
 Q
REDISP ; Ask Whether or not to redisplay menu
 N I,DIR,X,Y S DIR(0)="Y",DIR("A")="Redisplay items",DIR("B")="YES" D ^DIR Q:'Y  W @IOF
 D DISP^XQORM1 W !
 Q
HTX1 ; Help Text for "?"
 ;; Select ONE or MORE items from the menu, separated by commas.
 ;;
 ;; Enter: ??  to see HELP for MULTIPLE SELECTION
 ;;        ??? to see HELP for "^^"-jump
 ;;
 ;;ZZZZ
HTX2 ; Help Text for ??
 ;;
 ;; The Health Summary components you select at this prompt create
 ;; an ADHOC Health Summary.
 ;;
 ;; Select ONE or MORE items from the menu, separated by commas.
 ;;
 ;; ALL items may be selected by typing "ALL".
 ;;
 ;; EXCEPTIONS may be entered by preceding them with a minus.
 ;;  For example, "ALL,-THIS,-THAT" selects all but "THIS" and "THAT".
 ;;
 ;;ZZZZ
