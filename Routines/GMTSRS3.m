GMTSRS3 ; SLC/KER - Health Summary Resequence - Misc     ; 02/11/2003
 ;;2.7;Health Summary;**62**;Oct 20, 1995
 ;
 Q
SI ; Structure for Items
 W !!,"    Example Health Summary Type with Components containing Selection"
 W !,"    Items which may be resequenced",!
 W !,"        Health Summary Type                  Rehab Summary"
 W !,"            Health Summary Component           Brief Demographics"
 W !,"            Health Summary Component           Lab Cum Selected"
 W !,"               1  Selection Item                   Glucose"
 W !,"               2  Selection Item                   B 12"
 W !,"               3  Selection Item                   Liver Function"
 W !,"            Health Summary Component           Health Factor Select"
 W !,"               1  Selection Item                   Alcohol Screen"
 W !,"               2  Selection Item                   Depression Screening"
 W !,"            Health Summary Component           Progress Notes"
 Q
SC ; Structure for Components
 I '$D(GMTST) D  Q
 . W !,?3,"Example of a Health Summary Type with multiple components which ",!,?3,"may be resequenced.",!
 . W !,?5,"Health Summary Type",?32,"REHAB SUMMARY"
 . W !,?7,"Component #1",?34,"BRIEF DEMOGRAPHICS"
 . W !,?7,"Component #2",?34,"LAB CUM SELECTED"
 . W !,?7,"Component #3",?34,"HEALTH FACTOR SELECT"
 . W !,?7,"Component #4",?34,"PROGRESS NOTES"
 N GMTSI,GMTSC,GMTSN
 W !,?3,"This Health Summary Type has multiple Components which may be resequenced.",!
 W !,?5,"Health Summary Type",?32,$$UP^XLFSTR($P($G(^GMT(142,+GMTST,0)),"^",1))
 S (GMTSC,GMTSI)=0 F  S GMTSI=$O(^GMT(142,+($G(GMTST)),1,GMTSI)) Q:+GMTSI=0  D
 . S GMTSN=$P($G(^GMT(142,+($G(GMTST)),1,+GMTSI,0)),"^",2)
 . S GMTSN=$P($G(^GMT(142.1,+GMTSN,0)),"^",1) Q:'$L(GMTSN)
 . S GMTSC=GMTSC+1
 . W !,?7,"Component #",GMTSC,?34,$$UP^XLFSTR(GMTSN)
 Q
YN ; Yes/No
 W !,?3,"Enter either 'Y' or 'N'."
 Q
TRIM(X) ; Remove Spaces
 S X=$G(X) F  Q:$E(X,1)'=" "  S X=$E(X,2,$L(X))
 F  Q:$E(X,$L(X))'=" "  S X=$E(X,1,($L(X)-1))
 Q X
