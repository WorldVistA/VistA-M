GMTSUP ; SLC/KER - Utilities for Paging HS           ; 01/06/2003
 ;;2.7;Health Summary;**2,7,21,27,28,30,35,47,56,58,85**;Oct 20, 1995;Build 24
 ;
 ; External References
 ;   DBIA 10026  ^DIR
 ;   DBIA    82  EN^XQORM
 ;                       
CKP ; Check page position, pause and prompt
 Q:$D(GMTSQIT)  S GMTSNPG=0
 K:$L($G(GMTSOBJ("LABEL"))) GMTSOBJ("REPORT HEADER")
 I $G(GMTSWRIT)=1 D BREAK S GMTSWRIT=0
 I +($$HF^GMTSU) D BREAK:(GMTSEGN'=$G(GMTSLCMP)) Q
 Q:+$G(GMTSLPG)'>0&($Y'>(IOSL-GMTSLO))
 I $E(IOST,1)="C" S:'$D(GMTSTOF) GMTSTOF=1 D CKP1
 I '$D(GMTSQIT) W @IOF D HEADER,BREAK S GMTSNPG=1,GMTSTOF=GMTSEGN
 I $D(GMTSQIT),(GMTSQIT]""),($D(GMTSTYP)) W @IOF D HEADER S GMTSTOF=GMTSEGN
 Q
CKP1 ; Help Display of Optional Components for Navigation
 N DA,I,J,K,L,X,XQORM,Y,GMTSY,TYP,DIC
 I $S('$D(GMTSTYP):1,$D(GMTOPT):1,1:0) N DIR S DIR(0)="E" D ^DIR K DIR S:$D(DUOUT)!(GMTSLPG) GMTSQIT="" Q
 S TYP=GMTSTYP
 S DIC=142,DIC(0)="MZF",X="GMTS HS ADHOC OPTION" S Y=$$TYPE^GMTSULT
 S GMTSTYP=+Y K DIC,X,Y
 S XQORM=GMTSTYP_";GMT(142,",XQORM(0)="1AF\+",XQORM("A")="Press <RET> to continue, ^ to exit, or select component: "
 S XQORM("??")="D HELP^GMTSUP1" I GMTSLPG,'$D(GMTSOBJ) W:'$D(GMTSOBJE) "* END * "
 S XQORM("S")="I $D(^GMT(142,DA(1),1,DA,0)),($P(^GMT(142.1,$P(^GMT(142,DA(1),1,DA,0),U,2),0),U,6)'=""T"")"
 D EN^XQORM W ! D @$S(Y=1:"BRNCH",1:"EVAL")
 I $D(GMTSY),(GMTSY=0) K GMTSY G CKP1
 S GMTSTYP=TYP
 Q
BREAK ; Writes the Component Header
 ;           
 ;   If the variable GMTSOBJ exist, then the 
 ;   Component Headers are suppressed with the
 ;   following exceptions:
 ;           
 ;       If GMTSOBJ("COMPONENT HEADER") exist,
 ;       then the Component Header will NOT be
 ;       suppressed
 ;           
 ;       If GMTSOBJ("BLANK LINE") exist, a blank
 ;       line will be written after the Component
 ;       Header
 ;              
 N GMTSM,GMTSF S GMTSM=$$MUL,GMTSF=$$FST
 I +GMTSM=0,$D(GMTSOBJ),'$D(GMTSOBJ("COMPONENT HEADER")),'$D(GMTSOBJ("BLANK LINE")) Q
 N GMTS,GMTSUL,GMTSL S:'$D(GMTSLCMP) GMTSLCMP=0
 S GMTSUL="",GMTSNPG=1,GMTS=$$CHDR,GMTSL=+($L($G(GMTS))),$P(GMTSUL,"-",+GMTSL)="-"
 I $Y'>(IOSL-GMTSLO)!(+($$HF^GMTSU)) D
 . I $D(GMTSOBJ) D  Q
 . . S GMTSLCMP=GMTSEGN
 . . I +($G(GMTSM))>0!($D(GMTSOBJ("COMPONENT HEADER"))) D
 . . . W:+GMTSF=0 ! W !,GMTS W:$D(GMTSOBJ("UNDERLINE")) !,GMTSUL
 . . . W ! W:$D(GMTSOBJ("BLANK LINE")) !
 . W !,GMTS,!
 . W:$Y'>(IOSL-GMTSLO) ?34,$S(GMTSEGN=GMTSLCMP:"(continued)",1:""),!
 . S GMTSLCMP=GMTSEGN
 Q
OLDB ;
 S:'$D(GMTSLCMP) GMTSLCMP=0
 S GMTS="",GMTSNPG=1
 S $P(GMTS,"-",79-$L(GMTSEGH_GMTSEGL)/2)=""
 S GMTS=GMTS_" "_GMTSEGH_GMTSEGL_" "_GMTS
 I $Y'>(IOSL-GMTSLO)!(+($$HF^GMTSU)) D
 . W !,GMTS,!
 . W:$Y'>(IOSL-GMTSLO) ?34,$S(GMTSEGN=GMTSLCMP:"(continued)",1:""),!
 . S GMTSLCMP=GMTSEGN
        Q
HEADER ; Print Running Header
 ;           
 ;   If the variable GMTSOBJ exist, then the 
 ;   Report Headers are suppressed with the 
 ;   following exceptions:
 ;           
 ;       If GMTSOBJ("DATE LINE") exist, then the
 ;       Location/Report Date line will NOT be
 ;       suppressed.
 ;           
 ;       If GMTSOBJ("CONFIDENTIAL") exist, then
 ;       the Confidential Header Name line will
 ;       NOT be suppressed.
 ;           
 ;       If GMTSOBJ("REPORT HEADER") exist, then
 ;       the Report Header containing the patient's
 ;       name, SSAN, ward and DOB will NOT be
 ;       suppressed.
 ;              
 ;       If the variable GMTSOBJ("LABEL") contains
 ;       text, and the variable GMTSOBJ("USE LABEL")
 ;       exist, then this text will be printed before
 ;       the object text.
 ;                 
 ;       If GMTSOBJ("REPORT DECEASED") exist, then
 ;       the optional line that displays for Deceased
 ;       patients will NOT be suppressed.
 ;                 
 ;   Header Lines:
 N GMTSVDT,DATA S DATA="" I +$G(GMTSPXD1)&+$G(GMTSPXD2) D
 . Q:$G(GMTSOBJ)  S:'$D(GMTSOBJE) DATA="Printed for data "  S:$D(GMTSOBJE) DATA="Include data "
 . I GMTSPXD1=GMTSPXD2 S DATA=DATA_"on "_GMTSPXD1 Q
 . S DATA=DATA_"from "_GMTSPXD2_" to "_GMTSPXD1
 I $D(GMTSCDT(0)),'$D(GMTSOBJ) S GMTSVDT=GMTSCDT(0) S:GMTSDTM'["Printed:" GMTSDTM="Printed: "_GMTSDTM
 ;     Location and Date of Report
 I '$D(GMTSOBJ)!($D(GMTSOBJ("DATE LINE"))) D
 . N GMTSLOC S GMTSLOC=$S('$D(GMTSOBJ("DATE LINE")):$P($G(GMTSSC),U,2),1:"")
 . W !,$S($L(GMTSLOC):"Location: "_GMTSLOC_" ",1:"")
 . W $S($D(GMTSVDT):GMTSVDT,1:"")
 . W:'$D(GMTSOBJ("DATE LINE")) DATA,?(79-$L(GMTSDTM)),GMTSDTM
 . W:$D(GMTSOBJ("DATE LINE")) DATA,?(74-$L(GMTSDTM)),GMTSDTM
 ;     Confidential Header Name
 S:'$D(GMTSPG) GMTSPG=0
 S GMTSPG=GMTSPG+1,GMTSHDR=" CONFIDENTIAL "_GMTSTITL_" SUMMARY "
 S GMTSHDR=GMTSHDR_$S($E(IOST,1)="C":"",1:"  pg. "_GMTSPG)
 S GMTS="" S:'$D(GMTSOBJ) $P(GMTS,"*",(77-$L(GMTSHDR))\2)="*"
 S:$D(GMTSOBJ) $P(GMTS,"*",(72-$L(GMTSHDR))\2)="*"
 S GMTSHDR=GMTS_" "_GMTSHDR_" "_GMTS
 I '$D(GMTSOBJ)!($D(GMTSOBJ("CONFIDENTIAL"))) W !,GMTSHDR,"*"
 ;     Name, SSAN, Ward, DOB
 I '$D(GMTSLFG) D
 .I $G(GMTSTITL)'["AD HOC",($G(GMTSTITL)'["PDX"),($G(HSTAG)="") D EN^GMTSHCPR  ;GMTS,85 restrict ssn/dob on HS Type hard copies 
 . I $G(GMTSPHDR("TWO")) D
 . . I $D(GMTSOBJ),'$D(GMTSOBJ("REPORT HEADER")),$L($G(GMTSOBJ("LABEL"))) D LABEL
 . . I $D(GMTSOBJ),'$D(GMTSOBJ("REPORT HEADER")) Q
 . . W !,GMTSPHDR("NMSSN"),?GMTSPHDR("DOBS"),GMTSPHDR("DOB")
 . . W !,?GMTSPHDR("WARDRBS"),GMTSPHDR("WARDRB")
 . E  D
 . . I $D(GMTSOBJ),'$D(GMTSOBJ("REPORT HEADER")),$L($G(GMTSOBJ("LABEL"))) D LABEL
 . . I $D(GMTSOBJ),'$D(GMTSOBJ("REPORT HEADER")) Q
 . . W !,GMTSPHDR("NMSSN"),?GMTSPHDR("WARDRBS")
 . . W GMTSPHDR("WARDRB"),?GMTSPHDR("DOBS"),GMTSPHDR("DOB")
 ;     Deceased
 ;                    
 I '$D(GMTSOBJ)!($D(GMTSOBJ("DECEASED"))) D
 . W:+$G(VADM(6)) !,?26,"** DECEASED   "_$P(VADM(6),U,2)_" **"
 W:'$D(GMTSOBJ) !
 Q
BRNCH ; Checks abbreviation to branch to a different component
 N GMTINX,LIM,CREC,SBS
 I Y,("+-"[X) S:X="-" GMTSEGN=GMTSTOF-1 S (GMTSY,GMTSQIT)=1,GMTSLPG=0 Q
 I X="^^" S DIROUT=1,GMTSQIT="" Q
 I Y,(X?1"^^".E) Q
 S GMTINX=$S($D(^GMT(142,GMTSTYP,1,+Y(1),0)):$P(^(0),U,2),1:"")
 I 'GMTINX S GMTSY=0 Q
 I '$D(GMTSEGI(GMTINX)) N GMI,GMJ,GMTSDFLT S GMI=1,GMJ=GMTSEGC,GMTSDFLT=1 D LOAD^GMTSADH S GMTSEGC=GMTSEGC+1
 I '$D(GMTSEGI(GMTINX)) S GMTINX="",GMTSY=0 Q
 S LIM=$P(Y(1),U,4) I LIM'["=" G NOLIM
 S CREC=^GMT(142.1,GMTINX,0),SBS=GMTSEGI(GMTINX) D CMPLIM^GMTSADH2
 I $D(DIROUT) S GMTSQIT="" Q
NOLIM ; No limits
 S GMTSEGN=GMTSEGI(GMTINX)-1,(GMTSY,GMTSQIT)=1,GMTSLPG=0
 Q
 ;
EVAL ; Evaluate input to determine quit or continue
 Q:'$D(X)
 S:$D(GMTSEXIT) GMTSEXIT=$G(X)
 S:$D(DTOUT) DIROUT=1 I $S(X="^^":1,GMTSLPG:1,$D(DIROUT):1,X="^":1,1:0) S GMTSQIT=""
 I +$G(GMPSAP),(X="^") S GMDUOUT=1
 Q
MUL(X) ; Multiple Components in Type
 N GMTSF,GMTSL S GMTSF=$O(GMTSEG(0)),GMTSL=$O(GMTSEG(" "),-1)
 Q:+GMTSF=+GMTSL 0  Q 1
FST(X) ; First Component in Type
 N GMTSF,GMTSL S GMTSF=$O(GMTSEG(0)),GMTSL=+($G(GMTSEGN))
 Q:+GMTSF=+GMTSL 1  Q 0
CHDR(X) ; Component Header
 N GMTSN,GMTSH,GMTSL,GMTS S GMTSN=$$CNAM,GMTSH=$G(GMTSEGH)
 S GMTSL=$G(GMTSEGL),GMTS="",$P(GMTS,"-",79-$L(GMTSH_GMTSL)/2)=""
 S X=GMTS_" "_GMTSH_GMTSL_" "_GMTS Q:'$D(GMTSOBJ) X
 S:$L(GMTSH)&($D(GMTSOBJ("COMPONENT HEADER"))) GMTSN=GMTSH
 S:$L(GMTSL)&($L(GMTSN))&($D(GMTSOBJ("LIMITS"))) GMTSN=GMTSN_" "_GMTSL
 S X=GMTSN Q X
CNAM(X) ; Component Name
 N GMTSH S GMTSH=+($P($G(GMTSEG(+($G(GMTSEGN)))),"^",2))
 S X=$P($G(^GMT(142.1,+GMTSH,0)),"^",1) Q X
LABEL ; Label
 Q:'$D(GMTSOBJ("USE LABEL"))  N LABEL S LABEL=$G(GMTSOBJ("LABEL"))
 W !,LABEL W:$L(LABEL) ! W:$D(GMTSOBJ("LABEL BLANK LINE")) !
 Q
LABDAT ; Label/Date
 Q:'$D(GMTSOBJ("USE LABEL"))  N LABEL S LABEL=$G(GMTSOBJ("LABEL"))
 I '$D(GMTSOBJ("DATE LINE")),$D(GMTSOBJ("LABEL")),$L(LABEL),$L($G(GMTSDTM)) S LABEL=LABEL_$J("",((79-$L(GMTSDTM))-$L(LABEL)))_GMTSDTM
 I '$D(GMTSOBJ("DATE LINE")),$D(GMTSOBJ("LABEL")),'$L(LABEL),$L($G(GMTSDTM)) S LABEL="Information as of "_$G(GMTSDTM)
 W !,LABEL W:$L(LABEL) ! W:$D(GMTSOBJ("LABEL BLANK LINE")) !
 Q
