NURCRL3 ;HIRMFO/RM-SELECT MULTIPLE NURSING LOCATION UTILITY ;9/11/91
 ;;4.0;NURSING SERVICE;;Apr 25, 1997
 ;;
MDIC() ; FUNTION RETURNS NURSNLOC(NLOC,NLOCIEN)=""
 ; FUNCTION VALUE IS -1 IF USER ABORT, 0 IF NO LOCS PICKED, ELSE 1
 N DIC,MDIC,NEG,X,Y K NURSNLOC
DIC W !,$S('$D(NURSNLOC):"Select",1:"Another")_" Nursing Unit: " R X:DTIME E  S X="^^"
RETURN I "^^"[X S MDIC=$S(X["^":-1,1:''$D(NURSNLOC)) Q MDIC
 I X?1"?".E D HLP S:Y<0 X="^^" G:Y<0 RETURN S X="?"
 S NEG=X?1"-".E,X=$E(X,NEG+1,$L(X)),DIC="^NURSF(211.4,",DIC(0)="EQMNZ" D ^DIC I +Y'>0 G DIC
 I 'NEG S NURSNLOC(Y(0,0),+Y)=""
 E  K NURSNLOC(Y(0,0),+Y)
 G DIC
HLP ; PRINT LOCATIONS SELECTED ALREADY
 W $C(7) I $D(NURSNLOC) W !?3,"YOU HAVE ALREADY SELECTED: "
 S Y="",X=0 F  S Y=$O(NURSNLOC(Y)) Q:Y=""  W !?5,Y S X=X+1 I X>5 W """^"" TO STOP: " R X:DTIME S:'$T X="^^" S:X="^^" Y=-1 Q:X="^"!(Y<0)  S X=0
 Q:Y<0
 W !!?3,"You may deselect from the list by typing the - followed by unit name.",!?4,"E.g.  -3E would delete 3E from the list of units already selected."
 Q
