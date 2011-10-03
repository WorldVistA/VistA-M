DGPTLMU5 ;ALB/MTC - PTF A/P LIST MANAGER UTILITY CONT. ; 10-9-92
 ;;5.3;Registration;**606**;Aug 13, 1993
 ;
DI401 ;-- this function will load the 401 information
 N X,X1,Y,I,J,DGDAT,DXD
 S I=0 F  S I=$O(^DGPT(DGPTF,"S",I)) Q:'I  D
 . S ^TMP("ARCPTFDI",$J,$$NUM^DGPTLMU4(.NUMREC),0)="",DGDAT=$P(X,U)
 . S X1="",X=$G(^DGPT(DGPTF,"S",I,0)) Q:X']""
 . S Y="Surgery/Procedure Date :"_$S($P(X,U):$$FTIME^VALM1($P(X,U)),1:"")
 . S X1=$$SETSTR^VALM1(Y,X1,1,40)
 . S Y="Surg Specialty :"_$S($P(X,U,3):$P($G(^DIC(45.3,$P(X,U,3),0)),U,2),1:"")
 . S X1=$$SETSTR^VALM1(Y,X1,45,30)
 . S ^TMP("ARCPTFDI",$J,$$NUM^DGPTLMU4(.NUMREC),0)=X1
 . S Y="Cat of Chief Surg :"_$S($P(X,U,4):$P($P($P(^DD(45.01,4,0),U,3),";",$P(X,U,4)),":",2),$P(X,U,4)="V":"VA TEAM",$P(X,U,4)="M":"MIXED VA&NON VA",$P(X,U,4)="N":"NON VA",1:"")
 . S X1=$$SETSTR^VALM1(Y,X1,1,40)
 . S Y="Cat of Frst Assist :"_$S($P(X,U,5):$P($P($P(^DD(45.01,5,0),U,3),";",$P(X,U,5)),":",2),1:"")
 . S X1=$$SETSTR^VALM1(Y,X1,45,30)
 . S ^TMP("ARCPTFDI",$J,$$NUM^DGPTLMU4(.NUMREC),0)=X1
 . S Y="Prin Anest Tech :"_$S($P(X,U,6):$P($P($P(^DD(45.01,6,0),U,3),";",$P(X,U,6)),":",2),1:"NONE")
 . S X1=$$SETSTR^VALM1(Y,X1,1,40)
 . S Y="Source of Pay :"_$S($P(X,U,7):$P($P($P(^DD(45.01,7,0),U,3),";",$P(X,U,7)),":",2),1:"")
 . S X1=$$SETSTR^VALM1(Y,X1,45,30)
 . S ^TMP("ARCPTFDI",$J,$$NUM^DGPTLMU4(.NUMREC),0)=X1
 .;
 .;-- check for ICD codes
 . S ^TMP("ARCPTFDI",$J,$$NUM^DGPTLMU4(.NUMREC),0)="OPERATION CODES :"
 . F J=8:1:12 I $P(X,U,J) D
 .. S DXD=$$ICDOP^ICDCODE($P(X,U,J),DGDAT),Y=$P(DXD,U,2)_" - "_$P(DXD,U,5)
 .. S ^TMP("ARCPTFDI",$J,$$NUM^DGPTLMU4(.NUMREC),0)=" "_Y
 . S ^TMP("ARCPTFDI",$J,$$NUM^DGPTLMU4(.NUMREC),0)="PROCEDURE CODES :",X3=$G(^DGPT(DGPTF,"401P"))
 . I X3]"" F J=1:1:5 I $P(X3,U,J) D
 .. S DXD=$$ICDOP^ICDCODE($P(X3,U,J),DGDAT),Y=$P(DXD,U,2)_" - "_$P(DXD,U,5)
 .. S ^TMP("ARCPTFDI",$J,$$NUM^DGPTLMU4(.NUMREC),0)=" "_Y
 .;
 .;-- check for 300 node information
 . S X2=$G(^DGPT(DGPTF,"S",I,300)) I X2]"" D
 .. I +$P(X2,U) S ^TMP("ARCPTFDI",$J,$$NUM^DGPTLMU4(.NUMREC),0)="Kidney Source :"_$S($P(X2,U,2)=1:"Live Donor",1:"Cadaver")
 Q
 ;
DI601 ;-- this function will load the 601 information
 N X,X1,Y,I,J,DGDAT,DXD
 S I=0 F  S I=$O(^DGPT(DGPTF,"P",I)) Q:'I  D
 . S ^TMP("ARCPTFDI",$J,$$NUM^DGPTLMU4(.NUMREC),0)="",DGDAT=$P(X,U)
 . S X1="",X=$G(^DGPT(DGPTF,"P",I,0)) Q:X']""
 . S Y="Procedure Date :"_$S($P(X,U):$$FTIME^VALM1($P(X,U)),1:"")
 . S X1=$$SETSTR^VALM1(Y,X1,1,40)
 . S Y="Specialty :"_$P($G(^DIC(42.4,+$P(X,U,2),0)),U,1)
 . S X1=$$SETSTR^VALM1(Y,X1,45,30)
 . S ^TMP("ARCPTFDI",$J,$$NUM^DGPTLMU4(.NUMREC),0)=X1
 . S Y="Dialysis Type :"_$P($G(^DG(45.4,+$P(X,U,3),0)),U,1)
 . S X1=$$SETSTR^VALM1(Y,X1,1,40)
 . S Y="Num of Dialysis Treat :"_$P(X,U,4)
 . S X1=$$SETSTR^VALM1(Y,X1,45,30)
 . S ^TMP("ARCPTFDI",$J,$$NUM^DGPTLMU4(.NUMREC),0)=X1
 . S ^TMP("ARCPTFDI",$J,$$NUM^DGPTLMU4(.NUMREC),0)="PROCEDURE CODES :"
 . F J=5:1:9 I $P(X,U,J) D
 .. S DXD=$$ICDOP^ICDCODE($P(X,U,J),DGDAT),Y=$P(DXD,U,2)_" - "_$P(DXD,U,5)
 .. S ^TMP("ARCPTFDI",$J,$$NUM^DGPTLMU4(.NUMREC),0)=" "_Y
 Q
 ;
