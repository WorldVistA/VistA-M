XQOROP ; slc/dcm - Environment check for patch 48
 ;;8.0;KERNEL;**48**;Oct 25, 1996
 I '$L($T(PATCH^XPDUTL)) D MES^XPDUTL("Unable to continue, Patch XU*8.0*39 must be installed first.") S XPDQUIT=2 Q
 I $T(OR4+1^OR4)'["46,47" D MES^XPDUTL("Unable to continue, Patch OR*2.5*47 must be installed") S XPDQUIT=2
 I '$$PATCH^XPDUTL("LR*5.2*100") D MES^XPDUTL("Unable to continue, Patch LR*5.2*100 must be installed") S XPDQUIT=2
 I '$$PATCH^XPDUTL("OR*2.5*46") D MES^XPDUTL("Unable to continue, Patch OR*2.5*46 must be installed") S XPDQUIT=2
 Q
