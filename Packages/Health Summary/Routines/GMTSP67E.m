GMTSP67E ;ISP/WAT - HEALTH SUMMARY PATCH 67 ENVIRONMENT CHECK TASKS ;Jul 18, 2019@11:20
 ;;2.7;Health Summary;**67**;Oct 20, 1995;Build 538
 ;check for and warn installer about duplicate Names or Abbreviations between local system and incoming national components (142.1)
 D INFO,CONT
 N GMTSITEM,GMTSINC,GMTSFLG,GMTSCONT,GMTSIEN S (GMTSITEM,GMTSINC)="",(GMTSFLG,GMTSCONT,GMTSIEN)=0
 F GMTSINC=1:1  S GMTSITEM=$P($T(ABV+GMTSINC),";",3),GMTSIEN=$P(GMTSITEM,U,2),GMTSITEM=$P(GMTSITEM,U) Q:GMTSITEM="EOF"  D
 .Q:$D(^GMT(142.1,"C",GMTSITEM))&(GMTSIEN=+$O(^GMT(142.1,"C",GMTSITEM,"")))  ;for test sites & multiple installs
 .I $D(^GMT(142.1,"C",GMTSITEM)) D  ;report conflict if abbreviation found
 .. W !,"CONFLICT: "_GMTSITEM_" is an existing ABBREVIATION for IEN "_+$O(^GMT(142.1,"C",GMTSITEM,""))
 ..S GMTSFLG=1
 S (GMTSITEM,GMTSINC)="",GMTSCONT=0
 F GMTSINC=1:1  S GMTSITEM=$P($T(NAME+GMTSINC),";",3),GMTSIEN=$P(GMTSITEM,U,2),GMTSITEM=$P(GMTSITEM,U) Q:GMTSITEM="EOF"  D
 .Q:$D(^GMT(142.1,"B",GMTSITEM))&(GMTSIEN=+$O(^GMT(142.1,"B",GMTSITEM,"")))  ;for test sites & multiple installs
 .I $D(^GMT(142.1,"B",GMTSITEM)) D  ;report conflict if name found
 ..W !,"CONFLICT: "_GMTSITEM_" is an existing NAME for IEN "_+$O(^GMT(142.1,"B",GMTSITEM,""))
 ..S GMTSFLG=1
 S:GMTSFLG GMTSCONT=$$OW
 W:$G(GMTSCONT)=1 !,"OK - Install will continue"
 I GMTSFLG=0,GMTSCONT=0 D
 .W !,"Environment check complete. No conflicts found."
 Q
INFO ; info
 W !,"New Health Summary Component (#142.1) entries will be installed by this"
 W !,"patch. NAME (.01) and ABBREVIATION (4) values should be unique throughout"
 W !,"this file. Any conflicts found will be written to the screen and you will"
 W !,"have the choice to continue with installation or abort. Conflicts do not"
 W !,"prevent you from installing, but should be addressed soon after install.",!
 Q
CONT() ; -- read output before continuing
 N DIR,X,Y,DTOUT,DUOUT,DIRUT,DIROUT
 S DIR(0)="FO",DIR("A")="<Enter> to continue"
 D ^DIR
 Q
OW() ;ASK THE USER TO CONTINUE WITH INSTALLATION
 N DIR,X,Y,DTOUT,DUOUT,DIRUT,DIROUT
 W !!,"Installation *may* continue, but you must record these conflicts and"
 W !,"pass along to the appropriate site resource for review and edit of"
 W !,"local/existing items.",!
 S DIR(0)="Y^",DIR("A")="Do you wish to proceed with installation of this patch",DIR("B")="NO"
 D ^DIR
 W !
 S:+$G(Y)=0 XPDQUIT=2
 Q:$G(XPDQUIT)=2 +$G(Y)
 Q +$G(Y)
ABV ;abbreviations
 ;;WHL^260
 ;;WHP^259
 ;;WHPL^266
 ;;EOF
NAME ;names
 ;;WH LACTATION DOCUMENTATION^260
 ;;WH PREGNANCY DOCUMENTATION^259
 ;;WH PREGNANCY & LACTATION DOC^266
 ;;EOF
