GMTSADH3 ; SLC/JER,KER - Ad Hoc Summary Driver - Help ; 02/27/2002
 ;;2.7;Health Summary;**49**;Oct 20, 1995
 ;                
 ; External References
 ;   DBIA 10026  ^DIR
 ;   DBIA 10102  DISP^XQORM1
 ;                    
HELP ; Help at Select Additional or Existing COMPONENT(S): prompt
 N GMJ,GMTSTXT,HLP
 S HLP=$S(X="??":"HTX2",X="?":"HTX1",1:"") I $L(HLP) W ! F GMJ=1:1 S GMTSTXT=$T(@HLP+GMJ) Q:GMTSTXT["ZZZZ"  W !,$P(GMTSTXT,";",3,99)
 I X="???" W !! D HELP2^GMTSUP1
 D REDISP
 Q
REDISP ; Ask Whether or not to redisplay menu
 N I,DIR,X,Y S DIR(0)="Y",DIR("A")="Redisplay items",DIR("B")="YES" D ^DIR Q:'Y
 W @IOF D DISP^XQORM1 W !
 Q
HTX1 ;;Help Text for "?"
 ;;NOTE: At this point, any selections made are added to the list of
 ;;      previous selections.  Any exceptions (-THIS, -THAT) DO NOT REMOVE
 ;;      components from previous selections.  Exceptions only apply to the
 ;;      selections you are about to make.
 ;;
 ;;Select ONE or MORE items from the menu, separated by commas.
 ;;
 ;;Enter: ??  to see HELP for MULTIPLE SELECTION
 ;;       ??? to see HELP for "^^"-jump
 ;;
 ;;ZZZZ
HTX2 ;;Help Text for "??"
 ;;NOTE: At this point, any selections made are added to the list of
 ;;      previous selections.  Any exceptions (-THIS, -THAT) DO NOT REMOVE
 ;;      components from previous selections.  Exceptions only apply to the
 ;;      selections you are about to make.
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
