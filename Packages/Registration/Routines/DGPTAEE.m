DGPTAEE ;ALB/MTC,HIOFO/FT - Austin Edit Checks Error Driver ;7/6/15 10:06am
 ;;5.3;Registration;**64,338,678,850,884**;Aug 13, 1993;Build 31
 ;
 ;no external references
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
BUILD ;-- this function will build the display array - similar to Austin's EAL
 ;
 Q:'$D(^TMP("AERROR",$J))!'($D(^TMP("AEDIT",$J)))
 K ^TMP("AD",$J)
 N NODE,SEQ,DGER,ERSTR,SP,ROU,REC,DGPTLINE,DGPTLGTH,DGFLAG
 S (DGFLAG,VALMCNT,SEQ)=0,NODE="",SP=" "
 F  S SEQ=$O(^TMP("AERROR",$J,SEQ)) Q:SEQ=""  D
 . S NODE=$O(^TMP("AERROR",$J,SEQ,0))
 . S DGFLAG=$S(NODE="N101":1,NODE="N401":1,NODE="N501":1,NODE="N601":1,NODE="N701":1,NODE="N702":1,1:0)
 . Q:DGFLAG=0
 . Q:'$D(^TMP("AERROR",$J,SEQ,NODE))
 . S REC=$G(^TMP("AEDIT",$J,NODE,SEQ))
 . Q:REC=""
 . S DGPTLGTH=$L(REC),DGPTLINE=1
 . S:NODE="N101" DGPTLINE=$S(DGPTLGTH=125:1,1:2)  ;1 is for ICD9 layout, 2 is for ICD10 layout
 . S:NODE="N401" DGPTLINE=$S(DGPTLGTH=125:1,1:2)
 . S:NODE="N501" DGPTLINE=$S(DGPTLGTH=125:1,1:2)
 . S:NODE="N601" DGPTLINE=$S(DGPTLGTH=125:1,1:2)
 . S:NODE="N701" DGPTLINE=$S(DGPTLGTH=125:1,1:2)
 . S:NODE="N702" DGPTLINE=$S(DGPTLGTH=125:1,1:2)
 . S ERSTR=$P($T(@("ER"_$E(NODE,2,4))+DGPTLINE),";;",2) D LOADER
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
 . S X1=$O(^DGP(45.64,"B",$G(X2),0)),Y=$G(^DGP(45.64,+$G(X1),0))
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
 ;  first ";;" line represents ICD9 layout
 ; second" ;;" line represents ICD10 layout
ER101 ;-- 101 error position string
 ;;1:1^2:8^3:18^4:32^5:47^6:52^7:55^8:62^9:66^10:70^11:73^12:1^13:15^14:20^15:24^16:27^17:34^18:41^19:44^20:52^^^^24:71
 ;;1:1^2:8^3:18^4:32^5:47^6:52^7:55^8:62^9:66^10:70^11:73^12:1^13:15^14:20^15:24^16:27^17:34^18:41^19:44^20:52^^^^24:71
 ;
ER501 ;-- 501 error position string
 ;;1:1^2:8^3:18^4:32^5:47^6:56^7:60^8:64^9:69^10:1^11:9^12:17^13:25^14:33^15:1^16:14^17:23^18:27^19:31^20:34^21:37^22:42^23:45:^24:50^
 ;;1:1^2:8^3:18^4:32^5:47^6:56^7:60^8:64^9:69^10:1^11:10^12:20^13:30^14:40^15:1^16:10^17:20^18:30^19:40^20:1^21:20^22:30^23:30^24:40^25:1^26:20^27:30^28:30^29:40^30:1^31:20^32:30^33:30^34:40
 ;
ER401 ;-- 401 error position string
 ;;1:1^2:8^3:18^4:32^5:48^6:53^7:59^8:64^9:1^10:9^11:17^12:25^13:33^14:42^15:52^
 ;;1:1^2:8^3:18^4:32^5:48^6:53^7:59^8:64^9:1^10:9^11:17^12:25^13:33^14:1^15:9^16:17^17:25^18:33^19:1^20:9^21:17^22:25^23:33^24:1^25:9^26:17^27:25^28:33^29:1^30:9^31:17^32:25^33:33
 ;
ER601 ;-- 601 error position string
 ;;1:1^2:10^3:18^4:32^5:47^6:52^7:57^8:1^9:9^10:17^11:25^12:33^
 ;;1:1^2:10^3:18^4:32^5:47^6:52^7:57^8:1^9:9^10:17^11:25^12:33^13:1^14:9^15:17^16:25^17:33^18:1^19:9^20:17^21:25^22:33^23:1^24:9^25:17^26:25^27:33^28:1^29:9^30:17^31:25^32:33
 ;
ER701 ;-- 701 error position string
 ;;1:1^2:8^3:18^4:32^5:46^6:51^7:56^8:62^9:69^10:75^11:1^12:8^13:12^14:16^15:23^16:28^17:39^18:48^19:52^20:55^21:58^22:63^23:66^
 ;;1:1^2:8^3:18^4:32^5:46^6:51^7:56^8:62^9:69^10:75^11:1^12:8^13:12^14:16^15:23^16:28^17:39^18:48^19:52^20:55^21:58^22:63^23:66^24:1^25:4^26:8^27:12^28:16^29:20^30:25^31:30^32:50^33:55
 ;
ER702 ;-- 702 error position string
 ;;1:1^2:8^3:18^4:32^5:1^6:9^7:17^8:25^9:33^10:41^11:49^12:57^13:65^
 ;;1:1^2:8^3:18^4:32^5:1^6:9^7:17^8:25^9:33^10:1^11:9^12:17^13:25^14:33^15:1^16:9^17:17^18:25^19:33^20:1^21:9^22:17^23:25^24:33^25:1^26:9^27:17^28:25^29:33
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
