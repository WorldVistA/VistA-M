ESPUTIL ;DALISC/CKA- CONVERTS UOR # TO DESIRED FORMAT & ZIP CODE TRANSFORMS;3/93
 ;;1.0;POLICE & SECURITY;**14,17,22**;Mar 31, 1994
EN ;Miscellaneous
UORN ;This is to get a UOR# fm 18 doesn't allow 1990 standard
 S X=$$CONV^ESPUOR($P(^ESP(912,D0,0),U,2))
 Q
XR ;This is to get a UOR# for UOR xref on DATE/TIME RECEIVED field
 S ESPUOR=$$CONV^ESPUOR(X)
 Q
 ;This routine contains generic input and output transforms for the
 ;ZIP + extension fields which reside in DHCP
 ;
ZIPIN ; input transform for ZIP - massages user input and returns data
 ; in Fileman internal format (no '-'s)
 ;
 ;  Input: X as user entered value
 ; Output: X as internal value of user input OR
 ;          undefines if input from user was invalid
 ;
 N %
 I X'?.N F %=1:1:$L(X) I $E(X,%)?1P S X=$E(X,0,%-1)_$E(X,%+1,20),%=%-1
 I X'?5N,(X'?9N) K X
 Q
 ;
 ;
ZIPOUT ; output transform for ZIP - prints either ZIP or ZIP+4 (in 12345-1234)
 ; format.
 ;
 ;  Input: Y as Fileman internal value
 ; Output: Y as external format (12345 or 12345-1234)
 ;
 S Y=$E(Y,1,5)_$S($E(Y,6,9)]"":"-"_$E(Y,6,9),1:"")
 Q
 ;
 ;
EOP() ; end of page check - return 1 to quit, 0 to continue
 ; 
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 I $E(IOST,1,2)'="C-" Q 0  ; not to terminal
 F  Q:($Y>(IOSL-2))  W !
 S DIR(0)="E"
 D ^DIR
 Q 'Y
 ;
 ;
NOW() ; return NOW in external format for print on reports
 N X
 S X=$$FMTE^XLFDT($$NOW^XLFDT())
 Q $P($$UP^XLFSTR(X),":",1,2)
 ;
ID(NODE0) ;writes identifiers for file 910.2
 Q:NODE0=""
 N COLOR,TYPE,OWNER
 S COLOR=$P(NODE0,"^",2)
 I COLOR D
 .S COLOR=$P($G(^ESP(910.7,COLOR,0)),"^")
 E  S COLOR=""
 S TYPE=$P(NODE0,"^",4)
 S TYPE=$S(TYPE=1:"VEHICLE",TYPE=2:"BICYCLE",TYPE=3:"WEAPON",TYPE=4:"PET",TYPE=5:"GOLF",1:"")
 S OWNER=$P(NODE0,"^",3)
 I OWNER D
 .S OWNER=$P($G(^ESP(910,OWNER,0)),"^")
 E  S OWNER=""
 W ?20,"  ",$J($E(COLOR,1,10),10),"  ",$J($E(OWNER,1,30),30),"  ",$J($E(TYPE,1,10),10)
 Q
 ;
SUBTYPE(ESPS,ESPDTR) ;screen for field #.03/subfile #912.01/file #912
 ;   input
 ;     ESPS   = what 2nd & 3rd piece of file #912.9 record
 ;     ESPDTR = date/time (internal FM format) when offense report
 ;              received
 I $P(^(0),U,2,3)'=ESPS Q 0
 I '$D(^(1)) Q 1
 I ESPDTR>$P($G(^(1)),U,1) Q 0
 Q 1
