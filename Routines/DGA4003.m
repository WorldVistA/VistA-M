DGA4003 ;ALB/MRL - AMIS 420 MESSAGES FROM MAILMAN ;01 JAN 1988@2300
 ;;5.3;Registration;;Aug 13, 1993
 S XMSUB=DGH,XMDUZ=.5,XMY(DUZ)="" F I=1:1 S J=$P($T(OPEN+I),";;",2) Q:J="QUIT"  S DGL=I,DGTEXT(I,0)=J
 D MORE Q
PMES ;Pending Message
 S XMSUB=DGH,XMDUZ=.5,XMY(DUZ)="" F I=1:1 S J=$P($T(PEND+I),";;",2) Q:J="QUIT"  S DGL=I,DGTEXT(I,0)=J
MORE S XMTEXT="DGTEXT(",DGL=DGL+1,DGTEXT(DGL,0)="",DGL=DGL+1,DGTEXT(DGL,0)="Number of PENDING Dispositions found:  "_+DGP,DGL=DGL+1,DGTEXT(DGL,0)="Number of OPEN Dispositions found   :  "_+DGO D ^XMD K XMSUB,XMY,DGTEXT,XMDUZ,I,J,DGL Q
OPEN ;
 ;;I've accomplished a preliminary search of your database in preparation for
 ;;generation of the AMIS 401-420 series reports for the range shown above.  In
 ;;this search there were "open" dispositions found which caused the actual gen-
 ;;eration of the report to cease.  There were, possibly, some "pending" dispos-
 ;;itions found also.  Although these do not stop the report from generating every
 ;;effort should be made to properly disposition these registrations also.  A
 ;;listing of these open/pending dispositions should have printed for your use in
 ;;properly dispositioning them.  If you can't locate this list there is an option
 ;;available to regenerate this listing without generating the report.
 ;;QUIT
PEND ;
 ;;I didn't find any "open" dispositions in preparation for generation of the AMIS
 ;;401-420 series reports but I did find some "pending" dispositions.  Although
 ;;these do not stop the report from clearing you should make every effort to
 ;;properly disposition these registrations and then regenerate the report.  A
 ;;listing of these "pending" dispositions should have printed for your use in
 ;;properly dispositioning them.  If you can't locate this listing there is an
 ;;option available to regenerate it without regenerating the report itself.
 ;;QUIT
DEL ;Delete Existing 401-420 Data from ^DG(391.1
 F DGSEG=401:1:420 F DGDIV=0:0 S DGDIV=$O(^DG(391.1,DGSEG,"D",DGDIV)) Q:'DGDIV  K ^DG(391.1,DGSEG,"D",DGDIV,"MY",DGA,"A1")
 K DGSEG,DGDIV Q
