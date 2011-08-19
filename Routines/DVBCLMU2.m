DVBCLMU2 ;ALB/CMM TEXT FOR INITIAL/REEVALUATION ;12/30/93
 ;;2.7;AMIE;;Apr 10, 1995
 ;
 ;Display of initial and reevaluation exam descriptions
 ;
WINIT ;
 ;initial exam description displayed using ^DIWP
 ;
 K ^UTILITY($J,"W")
 N JJ,DIWF,DIWL,X
 W !!
 S JJ=0,DIWF="WN",DIWL=5
 F  Q:$O(^DVBP(396.91,3,"D",JJ))=""  D
 .S JJ=$O(^DVBP(396.91,3,"D",JJ))
 .S X=$P(^DVBP(396.91,3,"D",JJ,0),"^")
 .D ^DIWP
 D ^DIWW
 Q
WREE ;
 ;reevaluation exam description displayed using ^DIWP
 ;
 K ^UTILITY($J,"W")
 N JJ,DIWF,DIWL,X
 W !!
 S JJ=0,DIWF="WN",DIWL=5
 F  Q:$O(^DVBP(396.91,4,"D",JJ))=""  D
 .S JJ=$O(^DVBP(396.91,4,"D",JJ))
 .S X=$P(^DVBP(396.91,4,"D",JJ,0),"^")
 .D ^DIWP
 D ^DIWW
 Q
