XQLOCK1 ;MJM/SEA - Utilities for keys in the tree ;04/07/95  11:08
 ;;8.0;KERNEL;;Jul 10, 1995
 ;
EDIT ;Edit the set of keys we're working with
 W !!,"Enter one of the following codes followed by key name(s): ",!!?5,"'-' (minus) to remove a key from the set",!?8,"(For example ""-XQJUNK"" or ""-XQJUNK,XQMOREJUNK"")"
 ;W !?5,"'+' (plus) to add a key to this set of keys",!?8,"(For example ""+XQJUNK"" or ""+XQJUNK,XQKEY2"")"
 W !?5,"'S' to show the current key set"
 W !?5,"'RETURN' to end the editing session",!?5,"'^' to quit thiogram altogether",!
 R !!,"Enter -KEY, S, or ^ :",XQUR:DTIME Q:XQUR=""!(XQUR=U)!("-+^"'[$E(XQUR))
 I $E(XQUR,1)="-" S XQUR=$P(XQUR,"-",2) S %=1 F  S XQK=$P(XQUR,",",%) Q:XQK=""  S %=%+1 D KEY^XQLOCK I XQ>0 K XQKEY(XQK)
 I "Ss"[XQUR D SHOW^XQLOCK G EDIT
 Q
 ;
PAUSE ;Hold screen so it doesn't run off
 W !!,"Hit 'RETURN' to continue, '^' to stop." R XQDUMMY:DTIME
 I XQDUMMY=U S XQI=-1 K XQDUMMY Q
 W !!," Option Name",?23,"Option Text",?62,"Locked With",!
 K XQDUMMY
 Q
