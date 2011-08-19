ECDSREF ;BIR/MAM/RHK,JPW-DSS MUMPS Cross References ;6 May 95
 ;;2.0; EVENT CAPTURE ;;8 May 96
INACT ; kill 'AP' x-ref for inactivated code
 S ECK=$P(^ECJ(DA,0),"^"),ECLOC=$P(ECK,"-"),ECUNIT=$P(ECK,"-",2),ECCAT=$P(ECK,"-",3),ECPRO=$P(ECK,"-",4)
 K ^ECJ("AP",ECLOC,ECUNIT,ECCAT,ECPRO,DA),^ECJ("APP",ECLOC,ECUNIT,ECPRO,DA)
 K ECK,ECCAT,ECLOC,ECPRO,ECUNIT
 Q
ACTIV ; set 'AP' x-ref when re-activated
 Q:$D(ECCH)  S ECK=$P(^ECJ(DA,0),"^"),ECLOC=$P(ECK,"-"),ECUNIT=$P(ECK,"-",2),ECCAT=$P(ECK,"-",3),ECPRO=$P(ECK,"-",4)
 S ^ECJ("AP",ECLOC,ECUNIT,ECCAT,ECPRO,DA)="",^ECJ("APP",ECLOC,ECUNIT,ECPRO,DA)=""
 K ECK,ECCAT,ECLOC,ECPRO,ECUNIT
 Q
AC ; set 'AC' x-ref on CATEGORY (Y/N) field in file 720
 I X=1 S ^ECP("AC",$P(^ECP(DA,0),"^"),DA)=""
 Q
KILLAC ; kill 'AC' x-ref on CATEGORY (Y/N) field in file 720
 K ^ECP("AC",$P(^ECP(DA,0),"^"),DA)
 Q
AP ; set 'AP' x-ref on EVENT CODE field in file 720.3
 Q:$D(ECCH)  S ECK=$P(^ECJ(DA,0),"^",1),ECLOC=$P(ECK,"-",1),ECUNIT=$P(ECK,"-",2),ECCAT=$P(ECK,"-",3),ECPRO=$P(ECK,"-",4)
 S ^ECJ("AP",ECLOC,ECUNIT,ECCAT,ECPRO,DA)="",^ECJ("APP",ECLOC,ECUNIT,ECPRO,DA)=""
 K ECLOC,ECUNIT,ECCAT,ECPRO,ECK
 Q
KILLAP ; kill 'AP' x-ref on EVENT CODE field in file 720.3
 S ECK=$P(^ECJ(DA,0),"^",1),ECLOC=$P(ECK,"-",1),ECUNIT=$P(ECK,"-",2),ECCAT=$P(ECK,"-",3),ECPRO=$P(ECK,"-",4)
 K ^ECJ("AP",ECLOC,ECUNIT,ECCAT,ECPRO,DA),^ECJ("APP",ECLOC,ECUNIT,ECPRO,DA),ECLOC,ECCAT,ECPRO,ECUNIT,ECK
 Q
ACC ; set 'ACC' x-ref on COST CENTER field in file 49
 S ^DIC(49,"ACC",+X,DA)=""
 Q
KILLACC ; kill 'ACC' x-ref on COST CENTER field in file 49
 K ^DIC(49,"ACC",+X,DA)
 Q
AST ; set AST cross reference on .01 field of 720.3
 S ECLOC=$P($P(^ECJ(DA,0),"^"),"-"),^ECJ("AST",ECLOC,DA)="" K ECLOC Q
 ;
KAST ; kill AST cross reference on.01 field of 702.3
 S ECLOC=$P($P(^ECJ(DA,0),"^"),"-") K ^ECJ("AST",ECLOC,DA),ECLOC Q
 ;
QUIT R !,"Enter ^ to quit or return to continue : ",ECZ:DTIME W ! I '$T!(ECZ["^") S ECQT=1
 Q
