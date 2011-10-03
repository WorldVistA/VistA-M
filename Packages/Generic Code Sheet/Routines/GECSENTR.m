GECSENTR ;WISC/RFJ-stuff data into template map automatically       ;08 Nov 93
 ;;2.0;GCS;;MAR 14, 1995
 ;  the following needs to be defined for automatic stuffing of data:
 ;  GECS("STRING",0) or GECS("STRING",1), etc.=String to be stuffed delimited by ^
 ;  GECSSYS=Batch type name from file 2101.1
 ;  GECS("TTF")=Transaction/Segment name from file 2101.2
 ;  GECS("SITENOASK")=Station number_Suffix (from field 99 in the institution file)
 ;  GECS("AMIS")=month/year of amis in form 2890800
 ;  set the variable GECSAUTO="BATCH" to auto-mark for batch without asking
 ;  set the variable GECSAUTO="SAVE"  to save code sheet for edit
 ;
 ;  check for variables passed
 I '$D(GECS("STRING",0)) Q
 I '$G(GECS("SITENOASK")) Q
 I '$L($G(GECSSYS)) Q
 ;
 N %X,D,D0,DA,DI,DQ,GECSAMIS,GECSDATA,GECSEDIT,GECSI,GECSMAP,GECSNASK,GECSNEXT,GECSPCNT,GECSPIEC,GECSTT,N,P,X,Y
 ;
 ;  set passed data in temporary variable to prevent killing
 S %X="GECS(""STRING"",",%Y="GECSDATA(" D %XY^%RCR
 S GECSTT=$G(GECS("TTF"))
 S GECSAMIS=$G(GECS("AMIS"))
 S GECSNASK=$G(GECS("SITENOASK"))
 ;
 N GECS
 ;
 ;  get transaction type and input template
 S GECSEDIT=$P($G(^GECS(2101.2,+$O(^GECS(2101.2,"B",GECSTT,0)),0)),"^",3) I GECSEDIT="" Q
 S GECSEDIT=$E(GECSEDIT,2,$L(GECSEDIT)-1)
 S %=$O(^DIE("B",GECSEDIT,0)) I '% Q
 D GETMAP^GECSXMAP(%) I '$D(GECSMAP) Q
 ;
 I GECSNASK S GECS("SITENOASK")=GECSNASK
 D ^GECSSITE I '$G(GECS("SITE")) Q
 D BATTYPE^GECSUSEL(GECSSYS,1) I '$G(GECS("BATDA")) Q
 S GECS("TT")=GECSTT,GECS("EDIT")="["_GECSEDIT_"]"
 W !,"Transaction Type: ",GECSTT
 D NEWCS^GECSEDIT I '$D(GECS("CSDA")) Q
 ;
 W !,"Stuffing data into the following fields:"
 ;  stuff amis
 I $G(GECSAMIS) S Y=GECSAMIS D DD^%DT W !,"AMIS MONTH/YEAR: ",Y D
 .   N DA,DIC,DIE,DR
 .   S (DIC,DIE)="^GECS(2100,",DA=GECS("CSDA"),DR="9.1///"_GECSAMIS D ^DIE
 ;
 S GECSNEXT=0,GECSPIEC=1,DA=GECS("CSDA")
 S GECSI=0 F  S GECSI=$O(GECSMAP(GECSI)) Q:'GECSI  D
 .   F GECSPCNT=1:1 S Y=$P(GECSMAP(GECSI),"\",GECSPCNT) Q:Y=""  D
 .   .   I $P($G(GECSDATA(GECSNEXT)),"^",GECSPIEC,255)="" S GECSNEXT=GECSNEXT+1,GECSPIEC=1 Q:'$D(GECSDATA(GECSNEXT))
 .   .   S X=$P(GECSDATA(GECSNEXT),"^",GECSPIEC),P=$P(Y,";",3),N=$P(Y,";",2),$P(^GECS(2100,DA,N),"^",P)=X,GECSPIEC=GECSPIEC+1
 .   .   W !,$P(^DD(2100,+$P(Y,"^"),0),"^"),": ",X
 I $$MAPDATA^GECSXBLD(DA) D ASKTOBAT^GECSXBL1(DA)
 Q
