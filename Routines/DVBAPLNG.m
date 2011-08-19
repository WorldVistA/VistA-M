DVBAPLNG ;ALB/JLU;updates the long description of file 31.;1/18/94
 ;;2.7;AMIE;;Apr 10, 1995
 ;
EN I +$$VERSION^DVBAPST1>2.59 DO  Q
 .S VAR=" - Version 2.6 of AMIE has already been loaded."
 .D BUMPBLK^DVBAPOST
 .D BUMPBLK^DVBAPOST
 .D BUMP^DVBAPOST(VAR)
 .W !!,VAR
 .S VAR="There is no need to add Long Descriptions to the Disability Condition file."
 .D BUMP^DVBAPOST(VAR)
 .W !,VAR,!
 .D BUMPBLK^DVBAPOST
 .Q
 D SET ;sets up variables.
 D LOOP ;loops through tmp global and adds long desc
 D SG1 ;write ending and updates tmp
 D EXIT
 Q
 ;
SET S CT=0
 S DIE="^DIC(31,"
 F LP1=1:1:3 D BUMPBLK^DVBAPOST
 S V1=" - Adding Long Description to the Disability Condition file."
 W !!!,V1,!
 D BUMP^DVBAPOST(V1)
 D BUMPBLK^DVBAPOST
SET1 S DIF="^TMP($J,""DVBA"",",XCNP=0
 K ^TMP($J,"DVBA")
 N R
 F R="DVBAPL1","DVBAPL2","DVBAPL3","DVBAPL4","DVBAPL5","DVBAPL6","DVBAPL7","DVBAPL8","DVBAPL9","DVBAPL10" S X=R X ^%ZOSF("LOAD") W "."
 K DIF,XCNP,R,X
 Q
 ;
EXIT ;cleans variables and exit.
 K CODE,CT,DIE,JA,JB,LP,LP1,V1,TEXT,DIR,^TMP($J,"DVBA")
 Q
 ;
SE ;writes and updates the tmp global with error message.
 ;
 S V1="- Problems exist with the disability condition "_CODE_"."
 W !,V1
 D BUMP^DVBAPOST(V1)
 S V1=" Long description NOT added!"
 W !,V1
 D BUMP^DVBAPOST(V1)
 Q
 ;
SG1 ;writes and updates the tmp global with the finish.
 ;
 F LP1=1:1:2 D BUMPBLK^DVBAPOST
 S V1="I have finished updating the long descriptions of the Disability Condition file!"
 W !!,V1
 D BUMP^DVBAPOST(V1)
 S V1="I updated "_CT_" disabilities."
 W !,V1
 D BUMP^DVBAPOST(V1)
 D BUMPBLK^DVBAPOST
 Q
 ;
LOOP ;loops through tmp and updates file 31 long description field.
 ;
 F LP=0:0 S LP=$O(^TMP($J,"DVBA",LP)) Q:LP=""  I $D(^(LP,0)) S CODE=$P(^(0),";;",2) I +CODE DO
 .S TEXT=$P(CODE,";",2)
 .S CODE=+CODE
 .K STOP
 .DO ADCHK
 .I $D(STOP) Q
 .Q
 Q
 ;
ADCHK ;checks to see if the disability code exists and if it already has a
 ;long description.
 ;
 I CODE<4900 S STOP=1 Q
 I '$D(^DIC(31,"C",CODE)) D SE S STOP=1 Q
 S JA=$O(^DIC(31,"C",CODE,""))
 I '$D(^DIC(31,JA,0)) D SE S STOP=1 Q
 S JB=$G(^DIC(31,JA,1))
 I JB=""!($P(JB,U,1)'=TEXT) DO ADD
 Q
 ;
ADD ;adds the long description to file 31 long description field.
 ;
 S DA=JA
 S DR="10////"_TEXT
 D ^DIE
 K DA,DR
 S CT=CT+1
 W:'(LP#10) "."
 Q
