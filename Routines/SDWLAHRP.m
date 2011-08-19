SDWLAHRP ;;IOFO BAY PINES/TEH - EWL REPORT - PRINT;06/12/2002 ; 20 Aug 2002 2:10 PM
 ;;5.3;scheduling;**419**;AUG 13 1993;Build 16
 ;
 ;
 ;
 ;
 ;
 ;
 ;==================================================================================
 ;                                      NOTES
 ;==================================================================================
 ;
 ;
EN ;
 S PG=0 D HD
 S SDWLA=0
 F  S SDWLA=$O(^XTMP("SDWLAHR",SDWLJ,"LIST",SDWLA)) Q:SDWLA<1  D
 .S DIC="^SDWL(409.3,",DA=SDWLA,DR=":" D EN^DIQ
 .I $Y>(IOSL-5) D HD
 G END
HD W:$D(IOF) @IOF
 W !!,?80-$L("EWL CUSTOM AD HOC REPORT")\2,"EWL CUSTOM AD HOC REPORT",?65 S PG=PG+1 W "PAGE: ",PG,!
 X ^DD("DD") W ?80-$L(Y)\2,Y,!!
 Q
END ;
 K DIR,DIC,DR,DIE,SDWLERR,SDWLF,SDWLX,SDLFD,SDWLCTX,SDWLDAT,SDWLPROM,SDWLINST,SDWLI,SDWLTAG,SDWLY
 K PG,DA,SDWLA,SDWLJ,Y
 Q
