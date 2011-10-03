DGPTAEE ;ALB/MTC - Austin Edit Checks Error Driver ; 23 NOV 92
 ;;5.3;Registration;**64,338,678**;Aug 13, 1993
 ;
EN ;-- entry point for list manager
 D BUILD
 Q
 ;
HDR ;-- header function for Editing List.
 S VALMHDR(1)="Patient : "_$P($G(^DPT(DFN,0)),U)
 S VALMHDR(2)="Admission Date : "_$$FTIME^VALM1($P(^DGPT(PTF,0),U,2))
 S VALMHDR(3)="Discharge Date : "_$$FTIME^VALM1($P(^DGPT(PTF,70),U))
 Q
 ;
BUILD ;-- this fuction will build the display array - similar to Austin's EAL
 ;
 Q:'$D(^TMP("AERROR",$J))!'($D(^TMP("AEDIT",$J)))
 K ^TMP("AD",$J)
 N NODE,SEQ,DGER,ERSTR,SP,ROU,REC
 S (VALMCNT,SEQ)=0,NODE="",SP=" "
 F  S SEQ=$O(^TMP("AERROR",$J,SEQ)) Q:SEQ=""  S NODE=$O(^(SEQ,0)) I NODE="N101"!(NODE="N401")!(NODE="N501")!(NODE="N601")!(NODE="N701")!(NODE="N702") D
 . S ERSTR=$P($T(@("ER"_$E(NODE,2,4))+1),";;",2) D LOADER
 . S REC=^TMP("AEDIT",$J,NODE,SEQ)
 . S ROU="H"_$E(NODE,2,4)_"^"_$S(NODE="N101"!(NODE="N401")!(NODE="N501"):"DGPTAEE1",1:"DGPTAEE2")_"(REC)" D @ROU
 Q
 ;
EXIT ;-- exit point for list manager
 K ^TMP("AD",$J)
 D CLEAR^VALM1
 Q
 ;
LOADER ;-- This function will load the array DGER
 ;
 N Y,J,X1,X2
 K DGER
 S DGER=""
 S Y="",J=0 F  S J=$O(^TMP("AERROR",$J,SEQ,NODE,J)) Q:'J  S X2=$G(^(J)) D
 . S X1=$O(^DGP(45.64,"B",X2,0)),Y=$G(^DGP(45.64,X1,0))
 . S DGER(J)=Y,DGER=DGER_$P(ERSTR,U,$P(Y,U,3))_","
 S DGER=$E(DGER,1,$L(DGER)-1)
 Q
 ;
WRER ;-- This function will write errors in DGER into ^TMP
 ;
 N I
 S VALMCNT=VALMCNT+1,^TMP("AD",$J,VALMCNT,0)="Error Code(s) : "
 S I="" F  S I=$O(DGER(I)) Q:'I  D
 . S VALMCNT=VALMCNT+1,^TMP("AD",$J,VALMCNT,0)=$P(DGER(I),U)_" - "_$P(DGER(I),U,2)
 D TRTCHK
 I '$G(DGPTERR) S VALMCNT=VALMCNT+1,$P(^TMP("AD",$J,VALMCNT,0),"=",80)=""
 K DGPTERR
 Q
 ;
 ;-- This data is used to determine where in the output string a '#'
 ;   should be printed. The format of the each datum is:
 ;      <position in transmission string>:<position in display string>
 ;
ER101 ;-- 101 error position string
 ;;1:1^2:8^3:18^4:32^5:47^6:52^7:55^8:62^9:66^10:70^11:73^12:1^13:15^14:20^15:24^16:27^17:34^18:41^19:44^20:52^^^^24:71
 ;
ER501 ;-- 501 error position string
 ;;1:1^2:8^3:18^4:32^5:47^6:56^7:60^8:64^9:69^10:1^11:9^12:17^13:25^14:33^15:1^16:14^17:23^18:27^19:31^20:34^21:37^22:42^23:45:^24:50^
 ;
ER401 ;-- 401 error position string
 ;;1:1^2:8^3:18^4:32^5:48^6:53^7:59^8:64^9:1^10:9^11:17^12:25^13:33^14:42^15:52^
 ;
ER601 ;-- 601 error position string
 ;;1:1^2:10^3:18^4:32^5:47^6:52^7:57^8:1^9:9^10:17^11:25^12:33^
 ;
ER701 ;-- 701 error position string
 ;;1:1^2:8^3:18^4:32^5:46^6:51^7:56^8:62^9:69^10:75^11:1^12:8^13:12^14:16^15:23^16:28^17:39^18:48^19:52^20:55^21:58^22:63^23:66^
 ;
ER702 ;-- 702 error position string
 ;;1:1^2:8^3:18^4:32^5:1^6:9^7:17^8:25^9:33^10:41^11:49^12:57^13:65^
 ;
TRTCHK ;-- Check for treating spec error flag and print error message if flag
 ;-- exists.
 N I,X
 S I=0,I=$O(DGPTSER(I)) G:'I TRTCHKQ
 I $G(DGPTSER(+I))=1 D
 . S X="*** Bed section code is not active for the date/time period listed. ***"
 . S VALMCNT=VALMCNT+1,^TMP("AD",$J,VALMCNT,0)=X,DGPTERR=1
TRTCHKQ K DGPTSER(+I)
 Q
