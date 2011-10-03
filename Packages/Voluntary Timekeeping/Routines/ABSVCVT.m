ABSVCVT ;VAMC ALTOONA/CTB - CONVERT VOL 3.0 TO 4.0 ;1/26/94  9:31 AM
V ;;4.0;VOLUNTARY TIMEKEEPING;;JULY 6, 1994
 ;re-index sex field
 D FIX
 W !,"This program converts Voluntary Service data from Version 3 to Version 4."
 S ABSVXA="OK to Continue",ABSVXB="",%=1 D ^ABSVYN
 I %'=1 S X="   <No action taken>" D MSG^ABSVQ QUIT
 W !! S X="Although this program will not take very long to run, you may QUEUE it to run.  If you run without Queueing, PLEASE save the output to paper." D MSG^ABSVQ
 S ZTRTN="BEGIN^ABSVCVT",ZTDESC="Conversion of voluntary service data"
 D ^ABSVQ
 QUIT
FIX S X="Please hold on while I cross reference the SEX field of the Volunteer Master File." D MSG^ABSVQ
 S DIK="^ABS(503330,",DIK(1)="6^AD" D ENALL^DIK
 W ! S X="Cross reference completed." D MSG^ABSVQ W !!
 ;check version
 I $D(ABSVX("VERSION")),ABSVX("VERSION")>3 QUIT
 ;validate voluntary station numbers
FI1 W !! S X="We will now loop through and validate the VOL STATION NUMBER field in the Site Parameter File.  This field must NOT be blank." D MSG^ABSVQ
 S DA=0 F  S DA=$O(^ABS(503338,DA)) Q:'DA  S DIE="^ABS(503338,",DR=".01;9" D ^DIE W !!
 S OK=1 F  S DA=$O(^ABS(503338,DA)) Q:'DA  I $P($G(^(DA,0)),"^",9)="" S OK=0 QUIT
 I 'OK S X="At least one VOL STATION NUMBER is blank.*" D MSG^ABSVQ W !! G FI1
 S X="All records in the Site Parameter File are OK.*" D MSG^ABSVQ W !!
 QUIT
BEGIN S NAME="" F I=1:1 S NAME=$O(^ABS(503330,"B",NAME)) Q:NAME=""  S DA=0 F  S DA=$O(^ABS(503330,"B",NAME,DA)) Q:'DA  I $D(^ABS(503330,DA,0)) W !,$P(^(0),"^",1),?40 D CONVERT
 Q
CONVERT ;converts one record
 I $D(^ABS(503330,DA,4,0)),$P(^(0),"^",2)="503330.01P" Q  ;IF RECORD ALREADY CONVERTED
 I $D(^ABS(503330,DA,4)) K ^(4)
 S X0=$S($D(^ABS(503330,DA,0)):^(0),1:"")
 I X0="" S X="Zeroth node for record "_DA_" is missing.*" D MSG^ABSVQ Q  ;BLANK ZEROTH NODE
 S INST=$P(X0,"^",17) I INST="" S X=2 G ERR
 S SITE=$P(^ABS(503338,INST,0),"^",9) I SITE="" S X=1 G ERR
 S XX="^503330.01P^"_INST_"^1" S ^ABS(503330,DA,4,0)=XX
 S X=$P(X0,"^",17)_"^"_$P(X0,"^",9,15)_"^"_$P(X0,"^",20)_"^"_$P(X0,"^",19)_"^"_$P(X0,"^",21) ;NEW STATION NODE
 S ^ABS(503330,DA,4,INST,0)=X,^ABS(503330,"AB",+X,DA,INST)="",^ABS(503330,DA,4,"B",INST,+X)=""
 S $P(X0,"^",9,15)="^^^^^^",$P(X0,"^",17)="",$P(X0,"^",19,21)="^^",^ABS(503330,DA,0)=X0 K X0
C ;reset combinations
 S D1=0 F K=1:1 S D1=$O(^ABS(503330,DA,1,D1)) Q:'D1  I $D(^(D1,0)) S X=^(0) S X=SITE_"-"_+X,$P(^(0),"^")=X,^ABS(503330,DA,1,"B",X,D1)="",^ABS(503330,DA,1,"AD",$P(X,"-"),$P(X,"-",2),D1)="" D COMB
 S DIK="^ABS(503330," D IX^DIK K DIK
 S X="    Converted Successfully." D MSG^ABSVQ Q
ERR S X=$P($T(ERR+X),";",3,99)_"   Fix and rerun this program" D MSG^ABSVQ Q
 ;;    No FACILITY field in volunteer record
 ;;    Problem with VOL STATION NUMBER field in VOLUNTEER SITE PARAMETER File
COMB ;edit one combination
 ;  DA=VOLUNTEER DA NUMBER
 ;  D1=SPECIFIC COMBINATION NUMBER
 N X,COMB,SER,SCH,ORG
 S X=$G(^ABS(503330,DA,1,D1,0)) I X="" Q
 I $L($P(X,"^",5))<4 Q
 I $P(X,"^",2)="",$P(X,"^",3)="",$P(X,"^",4)="" Q
 S ORG=$P(X,"^",2),SCH=$P(X,"^",3),SER=$P(X,"^",4),COMB=$P(X,"^",5)
 I ORG]"" S ORG=$E(COMB,1,3),ORG=$O(^ABS(503334,"B",ORG,0)) S $P(X,"^",2)=ORG,OK=1
 I SCH]"" S SCH=$E(COMB,4),SCH=$O(^ABS(503333,"B",SCH,0)) S $P(X,"^",3)=SCH,OK=1
 I SER]"" S SER=$E(COMB,5,8),SER=$O(^ABS(503332,"B",SER,0)) S $P(X,"^",4)=SER,OK=1
 S ^ABS(503330,DA,1,D1,0)=X
