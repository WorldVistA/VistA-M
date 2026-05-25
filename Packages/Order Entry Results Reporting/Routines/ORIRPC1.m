ORIRPC1 ; SLC/AGP,AJB - Information panel RPC ;Sep 17, 2025@14:28:58
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**508**;Dec 17, 1997;Build 39
 ;
 Q
 ;
SETSECTIONS(CL,DA,DATA,NODE) ;
 N NUM S NUM=$O(DATA("sections",""),-1)+1
 S:$P(NODE(0),U,3)'="" DATA("sections",NUM,"displayText")=$P(NODE(0),U,3)
 S:$P(NODE(0),U,4)'="" DATA("sections",NUM,"abbreviatedDisplayText")=$P(NODE(0),U,4)
 S:$P(NODE(0),U,5)'="" DATA("sections",NUM,"color")=$$GUICOMPONENT($P(NODE(0),U,5))
 S DATA("sections",NUM,"collapsible")=$S($P(NODE(0),U,7)="":"false",1:$P(NODE(0),U,7))
 I $P(NODE(0),U,8) D
 . N X S X=0 F  S X=$O(^ORI(101.73,$P(NODE(0),U,8),50,X)) Q:'X  S DATA("sections",NUM,"imageIcon")=$G(DATA("sections",NUM,"imageIcon"))_^ORI(101.73,$P(NODE(0),U,8),50,X,0)
 S DATA("sections",NUM,"disabled")="false"
 S DATA("sections",NUM,"isNational")=$S(CL="NATIONAL":"true",1:"false")
 S DATA("sections",NUM,"sectionId")=DA(0)_";"_DA(1)_";"_DA(2)
 S:$P(NODE(101.73,0),U,1)'="" DATA("sections",NUM,"name")=$P(NODE(101.73,0),U,1)
 S:$P(NODE(101.73,0),U,3)'="" DATA("sections",NUM,"tab")=$P(NODE(101.73,0),U,3),DATA("sections",NUM,"pageID")=$P(NODE(101.73,"CPRS"),U)
 Q
SETUPDATE(ORY) ;
 N ALLTAB,DATA,ERROR,NUM
 S ALLTAB=$O(^ORI(101.73,"B","ALL TAB ADMIN",""))
 S NUM=$O(DATA("sections",""),-1)+1
 S DATA("sections",1,"displayText")="Panels updating, please try again."
 S DATA("sections",1,"abbreviatedDisplayText")="UPDT"
 S DATA("sections",1,"collapsible")="false"
 S DATA("sections",1,"disabled")="false"
 S DATA("sections",1,"isNational")="true"
 S DATA("sections",1,"sectionid")="1;1;1"
 S DATA("sections",1,"name")=$P(^ORI(101.73,ALLTAB,0),U)
 S DATA("sections",1,"tab")=$P(^ORI(101.73,ALLTAB,0),U,3),DATA("sections",NUM,"pageID")=$P(^ORI(101.73,ALLTAB,"CPRS"),U)
 S DATA("presentation",1,"name")="updating"
 S DATA("presentation",1,"abbreviatedDisplayText")="  "
 S DATA("presentation",1,"displayText")="    "
 S DATA("presentation",1,"action")="actNone"
 S DATA("presentation",1,"id")="1;1;1;1"
 S DATA("presentation",1,"sectionId")=DATA("sections",1,"id")
 K @ORY D ENCODE^XLFJSON("DATA",ORY,"ERROR")
 Q
 ;
GUICOMPONENT(DA) ; return component name
 Q $S($G(DA)="":0,1:$P($G(^ORI(101.73,DA,0)),U,3))
 ;
