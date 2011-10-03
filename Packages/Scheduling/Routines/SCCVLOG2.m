SCCVLOG2 ;ALB/RMO,TMP - Scheduling Conversion Log Utilities - Bulletin; [ 05/12/95  13:59 PM ]
 ;;5.3;Scheduling;**211**;Aug 13, 1993
 ;
SEND(SCLOG,SCACT) ;Send conversion bulletin
 ; Input  -- SCLOG    CST ien
 ;           SCACT    Action
 ; Output -- None
 N C,SCACTD,SCLNE,SCLOG0,SCLOG1,SCLOG2,SCTXT,X,Y
 S SCLOG0=$G(^SD(404.98,SCLOG,0)),SCLOG1=$G(^(1)),SCLOG2=$G(^(2))
 S Y=$$EXPAND^SCCVDSP2(404.9875,.02,SCACT)
 S SCACTD=$E(Y,1)_$$LOW^XLFSTR($E(Y,2,$L(Y)))
 S XMSUB="Scheduling Conversion Template #"_SCLOG_" - Event "_SCACTD
 S XMDUZ=.5,XMY(DUZ)=""
 S XMTEXT="SCTXT(",SCLNE=0
 S X="The conversion event has been '"_SCACTD_"'." D SET
 S X=" " D SET
 S Y=$$EXPAND^SCCVDSP2(404.98,.05,$P(SCLOG0,U,5))
 S X="                Conversion Event: "_$E(Y,1)_$$LOW^XLFSTR($E(Y,2,$L(Y))) D SET
 S X=" " D SET
 S Y=$P(SCLOG0,U,3) D D^DIQ
 S X="                      Start Date: "_Y D SET
 S Y=$P(SCLOG0,U,4) D D^DIQ
 S X="                      End   Date: "_Y D SET
 S X=" " D SET
 S X="    # encounters -     converted: "_+$P(SCLOG1,U,2) D SET
 S X="                 - not converted: "_+$P(SCLOG2,U,6) D SET
 S X="    Total # of errors logged    : "_+$P(SCLOG1,U,5) D SET
 ;
 I $O(^SD(404.98,SCLOG,"ERROR",0)) D
 . S Y=+$P($G(^SD(404.98,SCLOG,"R",+$$LSTREQ^SCCVLOG(SCLOG),0)),U,7)
 . Q:'Y
 . S X=" " D SET
 . S X=Y_" error"_$S(Y>1:"s were",1:" was")_" encountered during this conversion run." D SET
 . S X="For details, review the 'Error Log' in the 'View Template' action." D SET
 ;
 D ^XMD
 K XMSUB,XMDUZ,XMTEXT,XMY
 Q
 ;
SET ;Set message text
 S SCLNE=SCLNE+1,SCTXT(SCLNE,0)=X
 Q
