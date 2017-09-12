GMTSP106 ; MWA/VMP - Post install GMTS*2.7*106 ; 12/4/12 9:25am
 ;;2.7;Health Summary;**106**;;Build 11
 ;
 ;
 Q
EN ; main entry point
 N GMTSIEN,GMTSMCNT,GMTSMSG
 S GMTSIEN=0,GMTSMCNT=4 F  S GMTSIEN=$O(^GMT(142.5,GMTSIEN)) Q:'GMTSIEN  D
 .Q:'$D(^GMT(142.5,GMTSIEN,2))!($G(^GMT(142.5,GMTSIEN,2))'["^")
 .N GMTSPC1 S GMTSPC1=$P($G(^GMT(142.5,GMTSIEN,2)),U)
 .S ^GMT(142.5,GMTSIEN,2)=GMTSPC1,GMTSMSG(GMTSMCNT)=$P($G(^GMT(142.5,GMTSIEN,0)),U),GMTSMCNT=GMTSMCNT+1
 D SENDMAIL
 Q
SENDMAIL ; sends mailman message to inform that routine has run
 N XMSUB,XMDUZ,XMTEXT,XMY,DIFROM
 S GMTSMSG(1)="GMTS*2.7*106 Post install routine has completed"
 S GMTSMSG(2)="Bad records corrected:"
 S GMTSMSG(3)=" "
 I '$D(GMTSMSG(4)) S GMTSMSG(4)="No bad records found"
 S XMSUB="GMTS*2.7*106 Post install routine has completed"
 S XMDUZ="HEALTH SUMMARY PACKAGE"
 S XMTEXT="GMTSMSG("
 S XMY(DUZ)=""
 D ^XMD
 Q
