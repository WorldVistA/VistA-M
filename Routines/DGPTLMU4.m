DGPTLMU4 ;ALB/MTC/ADL - PTF A/P LIST MANAGER UTILITY CONT. ; 9-24-92
 ;;5.3;Registration;**510**;Aug 13, 1993
 ;;ADL;;Update for CSV Project;;Mar 27, 2003
 ;
EN ;-- single PTF record entry point
 ; INPUT - DGPTF record to display
 K ^TMP("ARCPTFDI",$J)
 D EN^VALM("DGPT DETAILED INQUIRY")
 D CLEAR^VALM1
 Q
 ;
DIEX ;-- exit code 
 K ^TMP("ARCPTFDI",$J),DGPTF
 D CLEAR^VALM1
 Q
 ;
DIHEAD ;-- header code
 S VALMHDR(1)="Patient Name: "_$P(^DPT(+^DGPT(DGPTF,0),0),U)
 S VALMHDR(2)="PTF record # :"_DGPTF
 S VALMHDR(3)="Admission Date :"_$$FTIME^VALM1($P(^DGPT(DGPTF,0),U,2))
 Q
 ;
DIEN ;-- list manager entry point
 D SEL^DGPTLMU3
 S DGPTF=+$O(VALMY(0))
 I ('$D(^DGPT(DGPTF))!('$D(^TMP("ARCPTF",$J,"LIST","REC",DGPTF)))) S VALMBCK="" D  G DIENQ
 . W !,">>> Invalid selection"
 D EN^VALM("DGPT DETAILED INQUIRY")
 S VALMBCK="R"
DIENQ Q
 ;
DIINT ;-- This function will load the array containing the
 ; PTF detailed information.
 ;  INPUT : DGPTF - Valid PTF entry
 ;
 N I,J,X,Y,DGINC,X1,X2,NUMREC
 S NUMREC=0,X1=""
 S Y="Patient Name :"_$P(^DPT(+^DGPT(DGPTF,0),0),U)
 S X1=$$SETSTR^VALM1(Y,X1,1,40)
 S Y="PTF Record # :"_DGPTF
 S X1=$$SETSTR^VALM1(Y,X1,45,30)
 S ^TMP("ARCPTFDI",$J,$$NUM(.NUMREC),0)=X1,X1=""
 S Y="Admin Date :"_$$FTIME^VALM1($P(^DGPT(DGPTF,0),U,2))
 S X1=$$SETSTR^VALM1(Y,X1,1,40),DG70=$G(^DGPT(DGPTF,70))
 S Y="Disch Date :"_$S(+DG70:$$FTIME^VALM1(+DG70),1:"<UNKNOWN>")
 S X1=$$SETSTR^VALM1(Y,X1,45,30)
 S ^TMP("ARCPTFDI",$J,$$NUM(.NUMREC),0)=X1,X1=""
 S Y="Disch Specialty :"_$S($P(DG70,U,2):$P(^DIC(42.4,$P(DG70,U,2),0),U),1:"")
 S X1=$$SETSTR^VALM1(Y,X1,1,40),X=$P(DG70,U,3)
 S Y="Type of Dispos :"_$S(X:$P($P($P(^DD(45,72,0),U,3),";",X),":",2),1:"")
 S X1=$$SETSTR^VALM1(Y,X1,45,30)
 S ^TMP("ARCPTFDI",$J,$$NUM(.NUMREC),0)=X1,X1="",X=$P(DG70,U,14)
 S Y="Disch Status :"_$S(X:$P($P($P(^DD(45,72.1,0),U,3),";",X),":",2),1:"")
 S X1=$$SETSTR^VALM1(Y,X1,1,40),X=$P(DG70,U,4)
 S Y="Outpatient Treatment :"_$S(X=1:"YES",1:"NO")
 S X1=$$SETSTR^VALM1(Y,X1,45,30)
 S ^TMP("ARCPTFDI",$J,$$NUM(.NUMREC),0)=X1,X1=""
 S Y="ASIH Days :"_$S($P(DG70,U,8)]"":$P(DG70,U,8),1:"")
 S X1=$$SETSTR^VALM1(Y,X1,1,40),X=$P(DG70,U,9)
 S Y="C&P Status :"_$S(X:$P($P($P(^DD(45,78,0),U,3),";",X),":",2),1:"")
 S X1=$$SETSTR^VALM1(Y,X1,45,30)
 S ^TMP("ARCPTFDI",$J,$$NUM(.NUMREC),0)=X1,X1=""
 S Y="VA Auspices :"_$S($P(DG70,U,5)=1:"YES",1:"NO")
 S X1=$$SETSTR^VALM1(Y,X1,1,40)
 S DGINC=$P($G(^DGPT(DGPTF,101)),U,7) I DGINC>1000 S DGINC=$E(DGINC,1,$L(DGINC)-3)_","_$E(DGINC,$L(DGINC)-2,$L(DGINC))
 S Y="Income :"_$S(DGINC]"":"$"_DGINC,1:"")
 S X1=$$SETSTR^VALM1(Y,X1,45,30)
 S ^TMP("ARCPTFDI",$J,$$NUM(.NUMREC),0)=X1
 ;-- check for ICD codes
 S ^TMP("ARCPTFDI",$J,$$NUM(.NUMREC),0)="ICD CODES :"
 F J=10,15:1:24 I $P(DG70,U,J) D
 . S DGPTTMP=$$ICDDX^ICDCODE(+$P(DG70,U,J),$$GETDATE^ICDGTDRG(DGPTF))
 . S Y=$P(DGPTTMP,U,2)_" - "_$P(DGPTTMP,U,4)
 . S ^TMP("ARCPTFDI",$J,$$NUM(.NUMREC),0)=" "_Y
 ;
 ;-- check for 300 node information
 S X2=$G(^DGPT(DGPTF,300)) I X2]"" D DI300(X2)
 ;
 D DI501^DGPTLMU6,DI401^DGPTLMU5,DI601^DGPTLMU5,DI535^DGPTLMU6
 F X=1:1:NUMREC S ^TMP("ARCPTFDI",$J,"IDX",X,X)=""
 S VALMCNT=NUMREC
 Q
 ;
DI300(X2) ;-- load 300 node information
 ; INPUT X2 - Contains 300 node
 ; OUTPUT   - Load display array
 ;
 N X3,Y
 I +$P(X2,U,2) S ^TMP("ARCPTFDI",$J,$$NUM(.NUMREC),0)="Suicide Indicator :"_$S($P(X2,U,2)=1:"Attempted",1:"Accomplished")
 I +$P(X2,U,3) S ^TMP("ARCPTFDI",$J,$$NUM(.NUMREC),0)="Legionnaire's Disease :"_$S($P(X2,U,3)=1:"YES",1:"NO")
 I +$P(X2,U,4) S ^TMP("ARCPTFDI",$J,$$NUM(.NUMREC),0)="Abused Substance :"_$P($G(^DIC(45.61,$P(X2,U,4),0)),U)
 I $P(X2,U,5)]"" D
 . S Y="Psychiatry Classification Severity :",X3=$P(X2,U,5)
 . S Y=Y_$S(X3]"":$P($P($P(^DD(45.02,300.05,0),U,3),";",X3),":",2),1:"")
 . S ^TMP("ARCPTFDI",$J,$$NUM(.NUMREC),0)=Y
 I $P(X2,U,6)]"" S ^TMP("ARCPTFDI",$J,$$NUM(.NUMREC),0)="Current Psychiatry Classification Assesment :"_$P(X2,U,6)
 I $P(X2,U,7)]"" S ^TMP("ARCPTFDI",$J,$$NUM(.NUMREC),0)="Highest Level Psychiatry Classification :"_$P(X2,U,7)
 Q
 ;
NUM(X) ;-- increment function
 ; INPUT : X -number to increment
 ;OUTPUT : X+1
 S X=X+1
 Q X
