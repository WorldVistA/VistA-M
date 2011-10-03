DGPAR2 ;ALB/LDB - MAS PARAMETERS ENTRY/EDIT CONT. ; 15 MAY 90
 ;;5.3;Registration;;Aug 13, 1993
 ;
EN ;called from DGPAR1 to continue display of parameters
 S X=$P(DGZE,"^",5) W !?4,"'",$P(DGDV1,"^",2),"' on G&L",?25,": ",$S($P(DGZE,"^",5):"YES",1:"NO")
 S X=+$P(DGZE,"^",6) W !?4,"Combined/Separate G&L: ",$S(X:"SEPARATE",1:"COMBINED")
 S DGDV1="10/10^DRUG PROFILE^ROUTING SLIP" F I=1:1:3 S X=$P(DGDV,"^",I) W:$X>4 !?4 W $P(DGDV1,"^",I)," printer",?25,": ",$S(X]"":X,1:"NOT SPECIFIED")
 Q
