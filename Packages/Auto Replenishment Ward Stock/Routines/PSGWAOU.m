PSGWAOU ;BHAM ISC/PTD,CML-Identify How Returns Are to be Credited & if Inventories for the AOU Are to be Counted in AMIS ; 14 Feb 1989  1:35 PM
 ;;2.3; Automatic Replenishment/Ward Stock ;;4 JAN 94
 W !!!,"For AMIS purposes, the system must know how to credit returns.",!,"Identify the ""usual"" method of drug distribution to be credited"
 W !,"for each AOU.  Answer ""A"" for Automatic Replenishment or",!,"""W"" for Ward Stock - On Demand.",!
 W !,"For AMIS purposes, the system must know if inventories for this AOU",!,"are to be counted in the AMIS Stats File.",!,"For each AOU, answer ""yes"" or ""no"".",!!
 F AOU=0:0 S AOU=$O(^PSI(58.1,AOU)) Q:'AOU  W !!?5,"Area of Use: ",$P(^PSI(58.1,AOU,0),"^") D RET Q:X="^"  D CNT Q:X="^"
DONE K AOU,X,DFLT Q
 ;
RET K DFLT I $P(^PSI(58.1,AOU,0),"^",2)'="" S DFLT=$P(^(0),"^",2)
 W !?5,"Returns credited to: " W:$D(DFLT) $S(DFLT="A":"Automatic Replenishment",1:"Ward Stock - On Demand")," // "
 R X:DTIME S:'$T X="^" Q:"^"[X  Q:'$D(DFLT)&(X="")
 I $D(DFLT) Q:((X="")!(DFLT=X))
 I "AW"[$E(X) S $P(^PSI(58.1,AOU,0),"^",2)=$E(X) Q
 W *7,*7,!?10,"For AMIS purposes, identify the ""usual"" method",!?10,"of drug distribution for this AOU.",!?10,"Answer ""A"" for Automatic Replenishment."
 W !?10,"Answer ""W"" for Ward Stock - On Demand.",!?10,"All returns from the AOU will be credited to this method.",!! G RET
 ;
CNT K DFLT I $P(^PSI(58.1,AOU,0),"^",3)'="" S DFLT=$P(^(0),"^",3)
 W !?5,"Count on AMIS? " W:$D(DFLT) $S(DFLT="1":"NO",1:"YES")," //"
 R X:DTIME S:'$T X="^" Q:"^"[X  Q:'$D(DFLT)&(X="")
 I $D(DFLT) Q:((X="")!(DFLT=X))
 I "YyNn"'[$E(X) W !?10,"Are inventories on this AOU to be counted for AMIS?",!?10,"Usually, the answer will be ""YES"".",!?10,"If the AOU is for INTERNAL Inpatient Pharmacy inventory ONLY,",!?10,"then answer ""NO"".",!! G CNT
 S $P(^PSI(58.1,AOU,0),"^",3)=$S("Nn"[$E(X):"1",1:"0")
 Q
 ;
