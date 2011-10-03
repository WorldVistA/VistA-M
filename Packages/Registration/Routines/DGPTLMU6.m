DGPTLMU6 ;ALB/MTC - PTF A/P LIST MANAGER UTILITY CONT. ; 9-24-92
 ;;5.3;Registration;**606**;Aug 13, 1993
 ;
DI501 ;-- this function will load the 501 information into the display array
 N X,Y,I,J
 S I=0 F  S I=$O(^DGPT(DGPTF,"M",I)) Q:'I  D
 . S X1="",X=$G(^DGPT(DGPTF,"M",I,0)) Q:X']""
 . S ^TMP("ARCPTFDI",$J,$$NUM^DGPTLMU4(.NUMREC),0)=""
 . S Y="Movement Dt :"_$S($P(X,U,10):$$FTIME^VALM1($P(X,U,10)),1:"")
 . S X1=$$SETSTR^VALM1(Y,X1,1,40)
 . S ^TMP("ARCPTFDI",$J,$$NUM^DGPTLMU4(.NUMREC),0)=X1,X1=""
 . S Y="Treated for SC condit :"_$S($P(X,U,18)=1:"YES",1:"NO")
 . S X1=$$SETSTR^VALM1(Y,X1,1,40)
 . S Y="Treated for AO condit :"_$S($P(X,U,26)=1:"YES",1:"NO")
 . S X1=$$SETSTR^VALM1(Y,X1,45,30)
 . S ^TMP("ARCPTFDI",$J,$$NUM^DGPTLMU4(.NUMREC),0)=X1,X1=""
 . S Y="Treated for IR condit :"_$S($P(X,U,27)=1:"YES",1:"NO")
 . S X1=$$SETSTR^VALM1(Y,X1,1,40)
 . S Y="Treated for EC condit :"_$S($P(X,U,28)=1:"YES",1:"NO")
 . S X1=$$SETSTR^VALM1(Y,X1,45,30)
 . S ^TMP("ARCPTFDI",$J,$$NUM^DGPTLMU4(.NUMREC),0)=X1,X1=""
 . S Y="Leave Days :"_$S($P(X,U,3):$P(X,U,3),1:"")
 . S X1=$$SETSTR^VALM1(Y,X1,1,40)
 . S Y="Pass Days :"_$S($P(X,U,4):$P(X,U,4),1:"")
 . S X1=$$SETSTR^VALM1(Y,X1,45,30)
 . S ^TMP("ARCPTFDI",$J,$$NUM^DGPTLMU4(.NUMREC),0)=X1,X1=""
 . S Y="Losing Specialty :"_$S($P(X,U,2):$P(^DIC(42.4,$P(X,U,2),0),U),1:"")
 . S X1=$$SETSTR^VALM1(Y,X1,1,75)
 . S ^TMP("ARCPTFDI",$J,$$NUM^DGPTLMU4(.NUMREC),0)=X1,X1=""
 .;
 .;-- check for ICD codes
 . S ^TMP("ARCPTFDI",$J,$$NUM^DGPTLMU4(.NUMREC),0)="ICD CODES :"
 . F J=5:1:9,11:1:15 I $P(X,U,J) D
 .. S Y=$$ICDDX^ICDCODE($P(X,U,J),$P(X,U,10)),Y=$P(Y,U,2)_" - "_$P(Y,U,4)
 .. S ^TMP("ARCPTFDI",$J,$$NUM^DGPTLMU4(.NUMREC),0)=" "_Y
 .;
 .;-- check for 300 node information
 .;
 . S X2=$G(^DGPT(DGPTF,"M",I,300)) I X2]"" D DI300^DGPTLMU4(X2)
 Q
 ;
DI535 ;-- this function will load the 535 information
 N Y,X,X1,DG535
 S DG535=0 F  S DG535=$O(^DGPT(DGPTF,535,DG535)) Q:'DG535  D
 . S ^TMP("ARCPTFDI",$J,$$NUM^DGPTLMU4(.NUMREC),0)=""
 . S X=$G(^DGPT(DGPTF,535,DG535,0)),X1=""
 . S Y="Ward Movement Date :"_$S($P(X,U,10):$$FTIME^VALM1($P(X,U,10)),1:"")
 . S X1=$$SETSTR^VALM1(Y,X1,1,40)
 . S Y="Losing Ward Specialty :"_$P(^DIC(42.4,$P(X,U,2),0),U,1)
 . S X1=$$SETSTR^VALM1(Y,X1,45,30)
 . S ^TMP("ARCPTFDI",$J,$$NUM^DGPTLMU4(.NUMREC),0)=X1,X1=""
 . S Y="Leave Days : "_$P(X,U,3)
 . S X1=$$SETSTR^VALM1(Y,X1,1,40)
 . S Y="Pass Days :"_$P(X,U,4)
 . S X1=$$SETSTR^VALM1(Y,X1,45,30)
 . S ^TMP("ARCPTFDI",$J,$$NUM^DGPTLMU4(.NUMREC),0)=X1,X1=""
 . S Y="Losing Ward : "_$P(^DIC(42,$P(X,U,6),0),U)
 . S X1=$$SETSTR^VALM1(Y,X1,1,40)
 . S ^TMP("ARCPTFDI",$J,$$NUM^DGPTLMU4(.NUMREC),0)=X1,X1=""
 Q
 ;
