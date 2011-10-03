ENPLSV1 ;WISC/SAB-PROJECT COMMUNICATION SERVER (CONTINUED) ;6/15/94
 ;;7.0;ENGINEERING;**11**;Aug 17, 1993
CM ; Create Mail Message
 S ENL=0
 D @("CM"_ENCTYPE)
 Q
CMATH ;
 S XMSUB=ENSTEXT_" "_ENPNBR_" Authorized"
 D XMZ^XMA2 I XMZ<1 S ENABORT=1 Q
 S ENL=ENL+1,^XMB(3.9,XMZ,2,ENL,0)="To: G.EN PROJECTS"
 S ENL=ENL+1,^XMB(3.9,XMZ,2,ENL,0)=" "
 S ENJ="" F  S ENJ=$O(^TMP($J,"ENCC",ENJ)) Q:'ENJ  S ENL=ENL+1,^XMB(3.9,XMZ,2,ENL,0)=^TMP($J,"ENCC",ENJ)
 S ENL=ENL+1,^XMB(3.9,XMZ,2,ENL,0)=" "
 Q
CMCON ;
 S XMSUB=ENSTEXT_" Confirmation "_$E(ENCDATE,5,6)_"/"_$E(ENCDATE,7,8)
 D XMZ^XMA2 I XMZ<1 S ENABORT=1 Q
 S ENL=ENL+1,^XMB(3.9,XMZ,2,ENL,0)="To: G.EN PROJECTS"
 S ENL=ENL+1,^XMB(3.9,XMZ,2,ENL,0)=" "
 S X="The following "_ENSTEXT_"(s) transmitted from the site"
 S ENL=ENL+1,^XMB(3.9,XMZ,2,ENL,0)=X
 F  S X=$P($T(CMCONT+ENL),";;",2) Q:X="$EX"  S ENL=ENL+1,^XMB(3.9,XMZ,2,ENL,0)=X
 Q
CMCONT ;; 
 ;; 
 ;; 
 ;;have been received by the Regional Construction Database.
 ;; 
 ;;The Action Taken column indicates what action was taken with the
 ;;transmitted project. ADDED means that the transmitted project was
 ;;added to the database. UPDATED means that existing project data was
 ;;replaced by the transmitted project. IGNORED means that the
 ;;transmitted project was ignored because it would be inappropriate
 ;;to modify the Regional Construction Database with this data for the
 ;;reason listed. For example; an existing project which is currently
 ;;'region approved' can not be modified so a new transmission of this
 ;;project must be ignored.
 ;; 
 ;;Note: '?' after a project # indicates it was not found on your system.
 ;; 
 ;; 
 ;;Region       Site         Project      Action
 ;;Processed    Transmitted  #            Taken    Title / (Comments)
 ;;-----------  -----------  -----------  -------  ------------------------------
 ;;$EX
CMDIS ;
 S XMSUB=ENSTEXT_" Disapproved "_$E(ENCDATE,5,6)_"/"_$E(ENCDATE,7,8)
 D XMZ^XMA2 I XMZ<1 S ENABORT=1 Q
 S ENL=ENL+1,^XMB(3.9,XMZ,2,ENL,0)="To: G.EN PROJECTS"
 S ENL=ENL+1,^XMB(3.9,XMZ,2,ENL,0)=" "
 S X="The following "_ENSTEXT_"(s) have been disapproved"
 S ENL=ENL+1,^XMB(3.9,XMZ,2,ENL,0)=X
 F  S X=$P($T(CMDIST+ENL),";;",2) Q:X="$EX"  S ENL=ENL+1,^XMB(3.9,XMZ,2,ENL,0)=X
 Q
CMDIST ;; 
 ;; 
 ;; 
 ;; 
 ;; 
 ;;Project #    Date Disapproved  Reviewer
 ;;-----------  ----------------  ------------------------------
 ;;$EX
CMNVI ;
 S XMSUB=ENSTEXT_" "_ENPNBR_" Non-Viable"
 D XMZ^XMA2 I XMZ<1 S ENABORT=1 Q
 S ENL=ENL+1,^XMB(3.9,XMZ,2,ENL,0)="To: G.EN PROJECTS"
 S ENL=ENL+1,^XMB(3.9,XMZ,2,ENL,0)=" "
 Q
CMRET ;
 S XMSUB=ENSTEXT_" "_ENPNBR_" Returned"
 D XMZ^XMA2 I XMZ<1 S ENABORT=1 Q
 S ENL=ENL+1,^XMB(3.9,XMZ,2,ENL,0)="To: G.EN PROJECTS"
 S ENL=ENL+1,^XMB(3.9,XMZ,2,ENL,0)=" "
 Q
CMSUM ;
 S XMSUB=ENSTEXT_" Summary "_($E(ENCDATE,1,4)+1)
 D XMZ^XMA2 I XMZ<1 S ENABORT=1 Q
 S ENL=ENL+1,^XMB(3.9,XMZ,2,ENL,0)="To: G.EN PROJECTS"
 S ENL=ENL+1,^XMB(3.9,XMZ,2,ENL,0)=" "
 S ENJ="" F  S ENJ=$O(^TMP($J,"ENCC",ENJ)) Q:'ENJ  S ENL=ENL+1,^XMB(3.9,XMZ,2,ENL,0)=^TMP($J,"ENCC",ENJ)
 S ENL=ENL+1,^XMB(3.9,XMZ,2,ENL,0)=" "
 Q
 ;ENPLSV1
