IBYDPT ;ALB/TMP - PATCH IB*2*44 POST-INITIALIZATION ; 14-JUL-95
 ;;Version 2.0 ; INTEGRATED BILLING ;**44**; 21-MAR-94
 ;
EN D APD3
 Q
APD3 ; Sets up 'APD3' xref on field 10 of file 399 (AUTHORIZATION DATE)
 N CT,DA,X,H1,H2 S H1=$H
 I $D(^DGCR(399,"APD3")) W !!,"APD3 cross reference already exists - not rebuilt",!!,"Done.",! Q
 W !!,">>> Building the 'APD3' cross-reference for file #399 ..."
 W !,"    (I'll write a dot for every 500 entries processed)",!
 S (CT,DA)=0 F  S DA=$O(^DGCR(399,DA)) Q:'DA  S CT=CT+1,X=$E($P($G(^DGCR(399,DA,"S")),U,10),1,30) W:'(CT#500) "." I X'="" S ^DGCR(399,"APD3",X,DA)=""
 W !!,"Done."
 ;
 ;TEST SITES ONLY
D S H2=$H
 W !!,"Count: ",CT
 W !,"Begin: ",$$HTE^XLFDT(H1)
 W !,"End:   ",$$HTE^XLFDT(H2)
 W !!,CT," entries processed in ",$$HDIFF^XLFDT(H2,H1,3),"."
 Q
