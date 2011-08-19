XDREMSG ;SF-IRMFO/IHS/OHPRD/JCM - ERROR MESSAGE PROCESSOR ;12/2/96  12:58
 ;;7.3;TOOLKIT;**23**;Apr 25, 1995
 ;;
START ;
 S XDRQFLG=1
 S XDREMSG=$P($T(ERRTXT+XDRERR),";; ",2)
 S ^XTMP("XDRERR",XDRFL)=XDREMSG
 I '$D(ZTQUEUED) W !,XDREMSG,!
 E  D BULL
END D EOJ
 Q
 ;
BULL ;
 G:'$D(XDRD("DMAILGRP")) BULLX
 F XDRI=0:0 S XDRI=$O(XDRD("DMAILGRP",XDRI)) Q:'XDRI  S XMY(XDRI)=""
 K XDRI
 S XMB="XDR ERROR"
 S:$D(XDRFL) XMB(1)=$P(^DIC(XDRFL,0),U)
 S:$D(XDRMRG("FR")) XMB(2)=XDRMRG("FR")
 S:$D(XDRMRG("TO")) XMB(3)=XDRMRG("TO")
 I $D(XDRGL),$D(XDRMRG("FR")),$D(@(XDRGL_XDRMRG("FR")_",0)")) S XMB(4)=$P(@(XDRGL_XDRMRG("FR")_",0)"),U)
 I $D(XDRGL),$D(XDRMRG("TO")),$D(@(XDRGL_XDRMRG("TO")_",0)")) S XMB(5)=$P(@(XDRGL_XDRMRG("TO")_",0)"),U)
 S XMB(6)=XDREMSG,XMDUZ=.5
 D ^XMB K XMB,XMDUZ
BULLX Q
 ;
EOJ ;
 K XMB,XDREMSG,XDRERR
 Q
ERRTXT ;;
 ;; The Candidate Collection Routine is Undefined
 ;; The Candidate Collection Routine is not present
 ;; The Potential Duplicate Threshold is Undefined
 ;; There are no Duplicate Tests entered for this Duplicate Resolution entry
 ;; The Global root node in DIC is undefined
 ;; No entry in Duplicate Resolution file for this file
 ;; The From and To Record are undefined
 ;; The test routine is not present
 ;; The routine defined as the Pre-Merge routine is not present
 ;; The routine defined as the Post-Merge routine is not present
 ;; The routine defined as the Verified Msg routine is not present
 ;; The routine defined as the Merged Msg routine is not present
 ;; You can not have a 'Non-Interactive' merge style with entries in the Dinum Files multiple
 ;; The file for checking duplicates is not defined (XDRFL)
 ;; The entry for checking duplicates is not defined (XDRCD)
 ;; The routine defined as the Merge Direction input transform routine is not present
 ;; The NEW x-ref has not been entered for this Duplicate Resolution entry
