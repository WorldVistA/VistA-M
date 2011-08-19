GMTSADH1 ;SLC/JER,MAM - Ad Hoc Summary Driver ; 09/21/2001
 ;;2.7;Health Summary;**1,37,47**;Oct 20, 1995
 ;
 ; External References
 ;   DBIA 10026  ^DIR
 ;   DBIA 10140  EN^XQORM
 ;                  
GETLIM ; Get Limits/Flags (external entry)
 ;              
 ;   Time 
 ;   Occurrence
 ;   Selection Items
 ;   Hospital Location Display
 ;   ICD Text Display
 ;   Provider Narrative Display
 ;   CPT Modifier Display
 ;                  
 N LISTFLG,GMCHANGE,GMW,QUIT S GMCHANGE=0 D LIST
 F  S LISTFLG=0 D ASKCMPS Q:$D(QUIT)!$D(DIROUT)
 Q
LIST ; Lists defaults for Ad Hoc Summary
 S LISTFLG=1,GMCHANGE=0
 W @IOF,!,"                      Default Limits and Selection Items",!!
 W "     Component              Occ    Time   Hosp  ICD  Prov  CPT  Selection",!
 W "                            Limit  Limit  Loc   Txt  Narr  Mod  Item(s)",!
 N FLG,DTOUT S FLG=0
LIST1 ; Called by GMTSUP to list components
 ;   FLG=1 for Ad Hoc Health Summary Type
 ;   FLG=2 for other Health Summary Types
 N GMI,DIR,DUOUT,GMW S DIR(0)="E"
 S GMI=0 F  S GMI=$O(GMTSEG(GMI)) Q:GMI'>0  D SCRNLNTH Q:$D(DUOUT)!($D(DTOUT))  D LISTLIM D:($D(GMTSEG(GMI))=11)&('FLG) LISTSEL Q:$D(DUOUT)!($D(DTOUT))
 Q
SCRNLNTH ; Checks screen length
 I $Y>(IOSL-4) W ! D ^DIR S:$D(DTOUT) DIROUT="" Q:$D(DUOUT)!($D(DTOUT))  W @IOF
 Q
 ;                     
LISTLIM ; List Components and Limits for GMTSET() array
 ;   Component Abbreviation
 ;   Component Name
 ;   If not called by GMTSUP:
 ;      Time Limits
 ;      Occurrence Limits
 ;      Hospital Location
 ;      ICD Text
 ;      Provider Narrative
 ;      CPT Modifier
 ;                  
 N CREC S CREC=^GMT(142.1,$P(GMTSEG(GMI),U,2),0) W ! I FLG=2 D STAR
 W $P(CREC,U,4),?5,$S($L($P(GMTSEG(GMI),U,5)):$P(GMTSEG(GMI),U,5),$L($P(CREC,U,9)):$P(CREC,U,9),1:$E($P(CREC,U),1,24))
 W:'FLG ?28,$P(GMTSEG(GMI),U,3),?35,$P(GMTSEG(GMI),U,4)
 W:'FLG ?42,$P(GMTSEG(GMI),U,6),?48,$E($P(GMTSEG(GMI),U,7),1,5)
 W:'FLG ?53,$P(GMTSEG(GMI),U,8),?59,$P(GMTSEG(GMI),U,9)
 Q
STAR ; Writes * to indicate added component when called by
 ; GMTSUP for Health Summary Type other than AD HOC
 I $D(^GMT(142,+($G(GMTSTYP)),1,"C",$P(GMTSEG(GMI),U,2))) W " "
 E  W "*"
 Q
LISTSEL ; Lists default selection items
 N GMW,GMJ,GML S GMJ=$O(GMTSEG(GMI,0)),GML=0
 F GMW=1:1 S GML=$O(GMTSEG(GMI,GMJ,GML)) Q:GML=""  D SCRNLNTH Q:$D(DUOUT)!($D(DTOUT))  W:GMW'=1 ! W ?64,$E($P(@(GMTSEG(GMI,GMJ,0)_GMTSEG(GMI,GMJ,GML)_",0)"),U),1,15)
 Q
ASKCMPS ; Asks for components for new limits/sel items
 N GMI,GMW,GMX,ASKCPQIT,DIC,X,XQORM,Y I LISTFLG D
 . W !!,"To change limits, selection items, hospital location display, ICD"
 . W !,"text display, provider narrative display, or CPT Modifiers, enter "
 . W !,"components, one at a time or more than one, separated by commas."
 . W !,"You may select new components if you wish."
 S XQORM=GMTSTYP_";GMT(142,",XQORM("??")="D HELP^GMTSADH3"
 S XQORM(0)="A",XQORM("A")="Select COMPONENT(S) to EDIT or other COMPONENT(S) to ADD: "
 D EN^XQORM S:$D(DTOUT)!(X="^^") (DIROUT,QUIT)=1 I $D(DIROUT) Q
 I +Y,(X?1"^^".E) G ASKCMPS
 I $S(X="^":1,X=""&(GMCHANGE=0):1,1:0) S QUIT="" Q
 I X="",GMCHANGE D ASKLIST Q
 I X["^" W "  ??" Q
 S GMCHANGE=1,GMI=0 F  S GMI=$O(Y(GMI)) Q:GMI=""  S GMX=^GMT(142,+GMTSTYP,1,+Y(GMI),0) W !!,$P(Y(GMI),U,3) D CMPCOND Q:$D(DUOUT)!($D(DIROUT))
 S:'$D(DIROUT) LISTFLG=1
 Q
CMPCOND ; Checks component for new limits/sel items
 N OLD,SBS,CREC,SREC,STRN,CPCDQIT S OLD=0 I $D(GMTSEGI($P(GMX,U,2))) S SBS=GMTSEGI($P(GMX,U,2)),OLD=1
 S CREC=^GMT(142.1,$P(GMX,U,2),0)
 I OLD=0 S GMTSEGC=GMTSEGC+1,SREC=GMX,STRN=+GMX D LOAD1^GMTSADH S SBS=GMJ
 D CMPLIM^GMTSADH2
 Q
ASKLIST ; Asks whether to relist Component
 N DIR,X,Y S DIR(0)="YA",DIR("A")="Would you like to see Component Limits and Selection Items again?  (Y/N): ",DIR("B")="NO" W !
 D ^DIR I Y'>0,(GMCHANGE=1) S QUIT=1 Q
 S:$D(DTOUT) DIROUT=1 I $D(DIROUT) Q
 I $D(DIRUT),'$D(DUOUT) W "  ??"
 I $D(DIRUT)!(Y=0) Q
 D LIST
 Q
