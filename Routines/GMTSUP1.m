GMTSUP1 ; SLC/JER,KER - Utilities for Paging HS ; 09/21/2001
 ;;2.7;Health Summary;**28,29,47**;Oct 20, 1995
 ;
 ; External References
 ;   DBIA 10102  DISP^XQORM1
 ;   DBIA 10026  ^DIR
 ;                 
RJUMP ; XQOR for "^^"-jump is no longer supported
 N GMDFN,GMTSAV W !,"Jumping not allowed.",! H 1 G RETURN
RETURN ; Return to Health Summary without Jump
 W:$G(GMTSAV)'["?" !,">>>  Returning to Health Summary",! H 1
 Q
HELP ; Offers help to confused individuals
 N GMQUIT
 W @IOF
 I X="?",GMTSTYP=TYP W "These components have been selected for Ad Hoc.",! S FLG=1 D LIST K FLG Q:$D(DTOUT)  D HELP1 W ! Q
 I X="?",GMTSTYP'=TYP W "These components are part of ",GMTSTITL," Health Summary Type",!,"or have been temporarily added.  Added components are indicated by *.",! S FLG=2 D LIST K FLG Q:$D(DTOUT)  D HELP1 W ! Q
 I X="??" W "These components may be temporarily added (use ""=C"" to change limits)." D DISP^XQORM1 W !!
 I X="???" D HELP2
 Q
HELP1 ; Writes part of help prompt
 D SCRNLNTH Q:$D(GMQUIT)  W !!
 D SCRNLNTH Q:$D(GMQUIT)  W "To leave display order and jump to a different component, select any component",!
 D SCRNLNTH Q:$D(GMQUIT)  W "from the  above list,  or select  any additional  component to  be temporarily",!
 D SCRNLNTH Q:$D(GMQUIT)  W "added  to the display.   Add ""=C"" to  component to change  limits or selection",!
 D SCRNLNTH Q:$D(GMQUIT)  W "items.  EXAMPLE: LO=C",!!
 D SCRNLNTH Q:$D(GMQUIT)  W "Enter: ??    to see additional components.",!
 D SCRNLNTH Q:$D(GMQUIT)  W ?7,"???   to see HELP for ""^^""-jump.",!
 D SCRNLNTH Q:$D(GMQUIT)  W ?7,"<RET> to continue display.",!
 D SCRNLNTH Q:$D(GMQUIT)  W ?7,"+     to proceed to next component.",!
 D SCRNLNTH Q:$D(GMQUIT)  W ?7,"-     to return to preceeding component.",!
 D SCRNLNTH Q:$D(GMQUIT)  W ?7,"^     to quit present patient's summary.",!
 D SCRNLNTH Q:$D(GMQUIT)  W ?7,"^^    to quit and return to menu.",!!
 Q
HELP2 ; Help for "^^"-jump
 D SCRNLNTH Q:$D(GMQUIT)  W ?22,"Navigation OUTSIDE of Health Summary",!!
 D SCRNLNTH Q:$D(GMQUIT)  W "You may also enter ""^^"" followed by the name, partial name or synonym for",!
 D SCRNLNTH Q:$D(GMQUIT)  W "any of a  variety of options  OUTSIDE of Health Summary  to which you can",!
 D SCRNLNTH Q:$D(GMQUIT)  W "jump.  Partial matches will allow you to select from a subset of options.",!!
 D SCRNLNTH Q:$D(GMQUIT)  W "For example:  ^^?    will list ALL available options.",!
 D SCRNLNTH Q:$D(GMQUIT)  W ?14,"^^PN   will show you all of the PROGRESS NOTES options, or",!
 D SCRNLNTH Q:$D(GMQUIT)  W ?14,"^^OR   will show you all of the ORDER ENTRY options.",!!
 D SCRNLNTH Q:$D(GMQUIT)  W "You may also  order a wide variety of LABORATORY tests using this syntax.",!
 D SCRNLNTH Q:$D(GMQUIT)  W "e.g., ^^CHEM 7 will allow you to ADD an order for that test.",!!
 Q
LIST ; List components
 N GMI,DUOUT
 S GMI=0 F  S GMI=$O(GMTSEG(GMI)) Q:GMI'>0  D SCRNLNTH Q:$D(DUOUT)!($D(DTOUT))  D LIST1 Q:$D(DUOUT)!($D(DTOUT))
 Q
SCRNLNTH ; Checks screen length
 N DIR
 Q:$Y'>(IOSL-4)
 S DIR(0)="E"
 D ^DIR I $S($D(DUOUT):1,$D(DTOUT):1,1:0) S GMQUIT=""
 W:'$D(GMQUIT) @IOF
 Q
LIST1 ; Lists component information
 N CREC S CREC=^GMT(142.1,$P(GMTSEG(GMI),U,2),0)
 W:GMI#2 ! W ?$S(GMI#2:0,1:40) D:FLG=2 STAR W $P(CREC,U,4),?$S(GMI#2:8,1:48),$E($S($L($P(GMTSEG(GMI),U,5)):$P(GMTSEG(GMI),U,5),$L($P(CREC,U,9)):$P(CREC,U,9),1:$P(CREC,U)),1,24)
 Q
STAR ; Writes * to indicate added component when called by GMTSUP
 ; for HST other than AD HOC
 W $S($D(^GMT(142,TYP,1,"C",$P(GMTSEG(GMI),U,2))):" ",1:"*")
 Q
