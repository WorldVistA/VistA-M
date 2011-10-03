TIUEN96 ; SLC/JER - Environment Check for TIU*1*96 ; 3-MAY-2000 16:34:23
 ;;1.0;TEXT INTEGRATION UTILITIES;**96**;Jun 20, 1997
MAIN ; -- Control Unit
 ; If ^TIU(8925 isn't populated, but PN or DS is populated, quit
 I (+$O(^TIU(8925,0))'>0),($S(+$O(^GMR(121,0)):1,+$O(^GMR(128,0)):1,1:0)) D  Q
 . D BMES^XPDUTL("** TIU IS NOT YET IN USE...ABORTING INSTALL **")
 . S XPDQUIT=2
 ; If ^GMR(121 has data, but no evidence of conversion, quit
 I +$O(^GMR(121,0)) D  Q:+$G(XPDQUIT)
 . N TIUMSG
 . I +$O(^GMR(121,"CNV",0))'>0 S XPDQUIT=2
 . I +$P($G(^TIU(8925.97,1,0)),U,2)'>0 S XPDQUIT=2
 . Q:'+$G(XPDQUIT)
 . S TIUMSG="** PROGRESS NOTE CONVERSION APPEARS NOT TO HAVE BEEN RUN: "
 . S TIUMSG=TIUMSG_"ABORTING **"
 . D BMES^XPDUTL(TIUMSG)
 ; If ^GMR(128 has data, but no evidence of conversion, quit
 I +$O(^GMR(128,0)) D
 . N TIUMSG
 . I $O(^GMR(128,"CNV",""))']"" S XPDQUIT=2
 . I +$G(^GMR(128,"CNV","T1"))'>0 S XPDQUIT=2
 . Q:'+$G(XPDQUIT)
 . S TIUMSG="** DISCHARGE SUMMARY CONVERSION APPEARS NOT TO HAVE RUN "
 . S TIUMSG=TIUMSG_"TO COMPLETION: ABORTING **"
 . D BMES^XPDUTL(TIUMSG)
 Q
