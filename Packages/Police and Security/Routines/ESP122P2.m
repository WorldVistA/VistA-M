ESP122P2 ;ALB/JAP; POST-INSTALL FOR ES*1*22 cont.;3/98
 ;;1.0;POLICE & SECURITY;**22**;Mar 31, 1994
 ;
MANUAL ;user update of file #912 entries (manual)
 N X,Y,DIC,DTOUT,DUOUT,ESPOUT,LN,ESIEN,ESN
 S $P(LN,"=",80)=""
 ;subtype conversion array - these are the only changes allowed
 S ESPCNV("ABOVE $100 (GOV'T)",1)="39^ABOVE $1000 (GOV'T)"
 S ESPCNV("ABOVE $100 (GOV'T)",2)="40^BELOW $1000 (GOV'T)"
 S ESPCNV("ABOVE $100 (PERSONAL)",1)="41^ABOVE $1000 (PERSONAL)"
 S ESPCNV("ABOVE $100 (PERSONAL)",2)="42^BELOW $1000 (PERSONAL)"
 S ESPCNV("ABOVE $1000 (GOV'T)",1)="40^BELOW $1000 (GOV'T)"
 S ESPCNV("BELOW $1000 (GOV'T)",1)="39^ABOVE $1000 (GOV'T)"
 S ESPCNV("ABOVE $1000 (PERSONAL)",1)="42^BELOW $1000 (PERSONAL)"
 S ESPCNV("BELOW $1000 (PERSONAL)",1)="41^ABOVE $1000 (PERSONAL)"
 ;subtype iens
 S ESPOLD("ABOVE $100 (GOV'T)")=23
 S ESPOLD("ABOVE $100 (PERSONAL)")=25
 S ESPOLD("ABOVE $1000 (GOV'T)")=39
 S ESPOLD("BELOW $1000 (GOV'T)")=40
 S ESPOLD("ABOVE $1000 (PERSONAL)")=41
 S ESPOLD("BELOW $1000 (PERSONAL)")=42
 ;select a file #912 record eligible for conversion/change
 F  S ESPOUT=0 D  Q:$D(DTOUT)!($D(DUOUT))!(ESPOUT)
 .S DIC="^ESP(912,",DIC(0)="AEMNQ"
 .S DIC("S")="I $P(^ESP(912,Y,0),U,3)>2970930.235959"
 .D ^DIC
 .I X="" S ESPOUT=1 Q
 .Q:Y=-1
 .S ESIEN=+Y
 .I ('$D(^XTMP("ESP","CONV",ESIEN)))&('$D(^XTMP("ESP","USER",ESIEN))) D  Q
 ..W !,"That record doesn't need to be converted.  Try again...",!! K ESIEN
 .D DISPLAY Q:ESPOUT
 .D UPDATE
 K ESPCNV,ESPOLD
 Q
 ;
DISPLAY ;display file #912 record data
 D HOME^%ZIS
 W @IOF
 S ESPDTR=$P($G(^ESP(912,ESIEN,0)),U,2) Q:ESPDTR=""
 W !?20,"Patch ES*1*22 Conversion Utility"
 W !,"File #912 ien: ",ESIEN
 W ?45,"UOR# ",$E(ESPDTR,2,3),"-",$E(ESPDTR,4,5),"-",$E(ESPDTR,6,7),"-",$TR($E($P(ESPDTR,".",2)_"ZZZZ",1,4),"Z",0)
 K ^UTILITY("DIQ1",$J)
 S DIC="^ESP(912,",DA=ESIEN,DR=".02;.03;.04;.06;.08;5.02;5.05;5.06;6.01;6.02",DIQ(0)="E" D EN^DIQ1 Q:'$D(^UTILITY("DIQ1",$J,912,DA))
 W !,"DATE/TIME RECEIVED: ",$G(^UTILITY("DIQ1",$J,912,DA,.02,"E"))
 W !,"DATE/TIME OF OFFENSE: ",$G(^UTILITY("DIQ1",$J,912,DA,.03,"E"))
 W !,"LOCATION: ",$G(^UTILITY("DIQ1",$J,912,DA,.04,"E"))
 W !,"INVESTIGATING OFFICER: ",$G(^UTILITY("DIQ1",$J,912,DA,.06,"E"))
 W !,"CASE STATUS: ",$G(^UTILITY("DIQ1",$J,912,DA,.08,"E"))
 W ?45,"COMPLETED FLAG: ",$G(^UTILITY("DIQ1",$J,912,DA,5.02,"E"))
 S FLAG=$G(^UTILITY("DIQ1",$J,912,DA,5.05,"E")) D
 .Q:FLAG=""  Q:FLAG["NONE"
 .W !,"DELETED/REOPENED FLAG: ",FLAG
 .I $E(FLAG,1)="D" W ?45,"DATE/TIME: ",$G(^UTILITY("DIQ1",$J,912,DA,5.06,"E"))
 .I ($E(FLAG,1)="R")&($D(^UTILITY("DIQ1",$J,912,DA,6.02,"E"))) W ?45,"DATE/TIME: ",^UTILITY("DIQ1",$J,912,DA,6.02,"E"),!?45,"PREVIOUS ID#: ",$G(^UTILITY("DIQ1",$J,912,DA,6.01,"E"))
 W !,"LOST/STOLEN  PROPERTY:"
 I $D(^ESP(912,ESIEN,90)) D
 .S ESL=0 F  S ESL=$O(^ESP(912,ESIEN,90,ESL)) Q:ESL=""  D
 ..S DIC="^ESP(912,"_ESIEN_",90,",DA=ESL,DR=".01;.03",DIQ(0)="E" D EN^DIQ1 Q:'$D(^UTILITY("DIQ1",$J,912.1,DA))
 ..W !?5,$G(^UTILITY("DIQ1",$J,912.1,DA,.01,"E"))
 ..W ?45,"LOSS: $",$G(^UTILITY("DIQ1",$J,912.1,DA,.03,"E"))
 I '$D(^ESP(912,ESIEN,90)) D
 .W !?5,"(No information available.)"
 K ESN S ESN=0 F  S ESN=$O(^ESP(912,ESIEN,10,ESN)) Q:ESN=""  D
 .S (ESOLD,ESUSER,ESCNVDT)=0,ESOLDNM=""
 .S ESOLD=$P($G(^XTMP("ESP","CONV",ESIEN,ESN)),U,1)
 .I ESOLD S ESUSER=$P($G(^XTMP("ESP","CONV",ESIEN,ESN)),U,3),ESCNVDT=$P($G(^XTMP("ESP","CONV",ESIEN,ESN)),U,4)
 .S DIC="^ESP(912,"_ESIEN_",10,",DA=ESN,DR=".01;.02;.03",DIQ(0)="E" D EN^DIQ1 Q:'$D(^UTILITY("DIQ1",$J,912.01,DA,.01,"E"))
 .I $D(^XTMP("ESP","CONV",ESIEN,ESN)) S ESN(ESN)=$G(^UTILITY("DIQ1",$J,912.01,DA,.03,"E"))
 .I $D(^XTMP("ESP","USER",ESIEN,ESN)) S ESN(ESN)=$G(^UTILITY("DIQ1",$J,912.01,DA,.03,"E"))
 .I ESOLD D
 ..S NUM="("_ESN_") ",NUML=$L(NUM)
 ..W !,NUM_"Classification: ",!?5,$G(^UTILITY("DIQ1",$J,912.01,DA,.01,"E"))
 ..I $G(^UTILITY("DIQ1",$J,912.01,DA,.02,"E"))]"" W "/",^("E")
 ..I $G(^UTILITY("DIQ1",$J,912.01,DA,.03,"E"))]"" W "/",^("E")
 ..I ESUSER W !,?NUML,"Converted by: ",$E($P($G(^VA(200,ESUSER,0)),U,1),1,20),?45,"Date/time: ",ESCNVDT
 .I 'ESOLD D
 ..S NUM="("_ESN_") ",NUML=$L(NUM)
 ..W !,NUM_"Classification: ",!?5,$G(^UTILITY("DIQ1",$J,912.01,DA,.01,"E"))
 ..I $G(^UTILITY("DIQ1",$J,912.01,DA,.02,"E"))]"" W "/",^("E")
 ..I $G(^UTILITY("DIQ1",$J,912.01,DA,.03,"E"))]"" W "/",^("E")
 W !,LN,!
 Q
 ;
UPDATE ;allow user to update subtype of subrecord
 ;variable esien=record, array esn=subrecords which may be converted
 N DIR,DTOUT,DUOUT,DIRUT,X,Y,SUBTYPE,NUM,NEWSUB,OLDSUB,ESPOUT,ESPPREV
 D NOW^%DTC S Y=$E(%,1,12),ESCNVDT=$$FMTE^XLFDT(Y,"5")
 W !!,"You may modify the following sub-record(s) -- ",!
 W !?5,"Sub-record #",?25,"Current Subtype"
 S JJ=0,DIR(0)="LA^",DIR("A")="Select sub-record #: "
 F  S JJ=$O(ESN(JJ)) Q:JJ=""  D
 .S DIR(0)=DIR(0)_","_JJ_","
 .W !,?8,JJ,?25,ESN(JJ)
 W ! D ^DIR W ! K DIR
 Q:$D(DTOUT)!($D(DUOUT))!($D(DIRUT))
 Q:(X["^")!(Y["^")
 I '$D(ESN(+Y)) G UPDATE
 S ESN=+Y,SUBTYPE=ESN(+Y),OLDSUB=ESPOLD(SUBTYPE)
 ;if more than 1 possible subtype to change to
 S (ESPOUT,NUM,NEWSUB)=0
 I $D(ESPCNV(SUBTYPE,2)) F  D  Q:(NUM)!(ESPOUT)
 .W !!?5,"The subrecord selected may be converted"
 .W !?5,"     to one of the following:",!
 .W !!?10,"(a) "_$P(ESPCNV(SUBTYPE,1),U,2)
 .W !?10,"(b) "_$P(ESPCNV(SUBTYPE,2),U,2)
 .S DIR(0)="SA^A:"_$P(ESPCNV(SUBTYPE,1),U,2)_";B:"_$P(ESPCNV(SUBTYPE,2),U,2)
 .S DIR("A")="Select (a) or (b): "
 .W !?5 D ^DIR W ! K DIR
 .I $D(DTOUT)!($D(DUOUT))!($D(DIRUT)) S ESPOUT=1
 .I (X["^")!(Y["^") S ESPOUT=1
 .I Y="A" S NUM=1
 .I Y="B" S NUM=2
 Q:ESPOUT
 ;if only 1 possible subtype to change to
 I '$D(ESPCNV(SUBTYPE,2)) S NUM=1
 S NEWSUB=$P(ESPCNV(SUBTYPE,NUM),U,1)
 ;update the subrecord
 S $P(^ESP(912,ESIEN,10,ESN,0),U,3)=NEWSUB
 ;keep previous conversion data, if any
 S ESPPREV=1+$O(^XTMP("ESP","PREV",ESIEN,ESN,""),-1)
 I $D(^XTMP("ESP","CONV",ESIEN,ESN)) S ^XTMP("ESP","PREV",ESIEN,ESN,ESPPREV)=^XTMP("ESP","CONV",ESIEN,ESN)
 ;store the conversion data
 S ^XTMP("ESP","CONV",ESIEN,ESN)=OLDSUB_"^"_NEWSUB_"^"_DUZ_"^"_ESCNVDT
 ;delete from unreviewed, if necessary
 K ^XTMP("ESP","USER",ESIEN,ESN)
 W !!,"...done.",!
 K X,Y,DIR S DIR(0)="E" D ^DIR K DIR W !!
 Q
