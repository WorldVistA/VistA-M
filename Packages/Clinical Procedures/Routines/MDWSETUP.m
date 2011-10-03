MDWSETUP ; HOIFO/NCA - Auto Study Check-In Setup ;3/18/08  14:14
 ;;1.0;CLINICAL PROCEDURES;**14,11**;Apr 01, 2004;Build 67
EN1 ; [Procedure]
 ; This post conversion routine will place the Medicine Enter/Edit 
 ; options out of order
 ; Reference IA # 2263 [Supported] XPAR parameter calls
 ;               10040 [Supported] Accessing Hospital Location file (#44)
 ;               10103 [Supported] XLFDT call
 ;
 N MDANS,MDAPT,MDAR,MDCL,MDCNOD,MDCP,MDCT,MDCTR,MDDEF,MDDFLT,MDERR,MDFLAG,MDFRST,MDLP,MDLAST,MDLST,MDLST1,MDLST2,MDNODE,MDNXT
 N MDPREC,MDS,MDSAP,MDSED,MDSEL,MDX,MDX1,MDX2,MDX3,MDY,MDY1 K ^TMP("MDOLD",$J)
 D GETLST^XPAR(.MDLST1,"SYS","MD CLINIC ASSOCIATION") I '+$G(MDLST1) D GET
 S MDDEF=$$GET^XPAR("SYS","MD USE APPT WITH PROCEDURE",1),MDDEF=$S(+MDDEF:"YES",1:"NO")
 K DIR S DIR(0)="YA",DIR("A")="Use Appointment with procedure? ",DIR("B")=MDDEF,DIR("?")="Enter either 'Y' or 'N'."
 S DIR("?",1)="Default should be 'N' as most sites do not schedule procedures"
 S DIR("?",2)="before the order is entered.  Select 'Y' if the procedure appointment"
 S DIR("?",3)="is scheduled before the order is entered and the ordering provider"
 S DIR("?",4)="selects the appointment for the procedure."
 D ^DIR K DIR Q:$D(DIRUT)!$D(DIROUT)!(Y<0)
 ;D DEL^XPAR("SYS","MD USE APPT WITH PROCEDURE",1)
 D EN^XPAR("SYS","MD USE APPT WITH PROCEDURE",1,0)
 D GETLST^XPAR(.MDLST,"SYS","MD CHECK-IN PROCEDURE LIST")
 D GETLST^XPAR(.MDLST1,"SYS","MD CLINIC ASSOCIATION")
 K ^TMP("MDPROC",$J),^TMP("MDPARAM",$J) S (MDCT,MDCTR,MDLAST)=0
 ; Get procedure parameter list
 F MDLP=0:0 S MDLP=$O(MDLST(MDLP)) Q:MDLP<1  I +$G(MDLST(MDLP)) S MDX=$P($G(^MDS(702.01,+$G(MDLST(MDLP)),0)),"^",1) D
 . Q:MDX=""  S MDY=+$P($G(MDLST(MDLP)),"^",2)
 . S ^TMP("MDPROC",$J,MDX,+$G(MDLST(MDLP)))=MDY_"^"_$S(MDY=1:"Outpatient",MDY=2:"Inpatient",MDY=3:"Both",1:"None")
 ; Get Clinic Quick List
 F MDLP=0:0 S MDLP=$O(MDLST1(MDLP)) Q:MDLP<1  S MDX3=+$G(MDLST1(MDLP)),MDX2=$P($G(MDLST1(MDLP)),"^",2),MDX1=+$P(MDX2,";",2) I +MDX1 D
 . S MDX=$P($G(^MDS(702.01,MDX1,0)),"^",1) Q:MDX=""
 . S MDY=+$P(MDX2,";",1) Q:'MDY
 . S MDCNOD=$G(^TMP("MDPROC",$J,MDX,MDX1)) Q:MDCNOD=""
 . S MDY1=$$GET1^DIQ(44,MDY_",",.01),MDCTR=MDCTR+1
 . S:$G(MDCTR(MDY))="" MDCTR(MDY)=0 S MDCTR(MDY)=MDCTR(MDY)+1
 . S ^TMP("MDPARAM",$J,MDX,MDY1)=MDX1_"^"_MDY_"^"_MDCNOD_"^"_MDX3,MDLAST=MDX3
 S MDPREC=$NA(^TMP("MDPROC",$J)) K MDLST,MDLST1
 F  S MDPREC=$Q(@MDPREC) Q:MDPREC=""  Q:$QS(MDPREC,1)'="MDPROC"  D
 . I '$D(^TMP("MDPARAM",$J,$QS(MDPREC,3))) S MDCTR=MDCTR+1,^TMP("MDPARAM",$J,$QS(MDPREC,3),"None")=$QS(MDPREC,4)_"^^"_@MDPREC
QURY ; Query the procedure parameter list
 I MDCTR<1 G A1
 N MDN S MDPREC=$NA(^TMP("MDPARAM",$J)),(MDANS,MDN)="" D HDR
 F  S MDPREC=$Q(@MDPREC) Q:MDPREC=""  Q:$QS(MDPREC,1)'="MDPARAM"  D
 . Q:MDANS="^"
 . S MDAPT=@MDPREC,MDAPT=$P(MDAPT,"^",4)
 . I $Y>(IOSL-2) K DIR S DIR(0)="E" D ^DIR K DIR D:Y HDR I $D(DIRUT)!$D(DIROUT)!(Y<0) S MDANS="^" Q
 . I MDN'=$QS(MDPREC,3) W !,$E($QS(MDPREC,3),1,25),?27,MDAPT,?55,$E($QS(MDPREC,4),1,25) S MDN=$QS(MDPREC,3) Q
 . W !?55,$E($QS(MDPREC,4),1,25)
A1 ; Ask for procedure parameter
 W !!,"Procedure: " R X:DTIME G:'$T!("^"[X) KIL
 I X["?" D PHELP^MDWCHK
 K DIC S DIC="^MDS(702.01,",DIC(0)="EQMZ",DIC("S")="I +$P(^(0),U,9)>0"
 D ^DIC K DIC G A1:"^"[X!$D(DTOUT),A1:Y<1
 S MDSEL=Y,MDCP=+MDSEL
 G:'$D(^TMP("MDPARAM",$J,Y(0,0))) A2
 S MDFRST=$O(^TMP("MDPARAM",$J,Y(0,0),"")) G:MDFRST="" A2
 S MDX1=$P($G(^TMP("MDPARAM",$J,Y(0,0),MDFRST)),"^",3)
 S MDNXT=$O(^TMP("MDPARAM",$J,Y(0,0),MDFRST)),MDDFLT="",MDFLAG=0
 I MDNXT="" S MDDFLT=$G(^TMP("MDPARAM",$J,Y(0,0),MDFRST)),MDNODE=MDFRST G E1
 I MDNXT'="" D  Q:+MDFLAG
 . W ! S MDLP="",MDCT=0 F  S MDLP=$O(^TMP("MDPARAM",$J,Y(0,0),MDLP)) Q:MDLP=""  D
 . . S MDCT=MDCT+1 W !,MDCT_") ",Y(0,0),"  ",MDLP S MDAR(MDCT)=MDLP
 . W ! K DIR S DIR(0)="NAO^1:"_MDCT,DIR("A")="Select 1-"_MDCT_": ",DIR("?")="Select from 1-"_MDCT D ^DIR
 . I X="" S MDSED=MDSEL,MDSAP=MDX1,MDFLAG=1 Q
 . K DIR G:$D(DIRUT)!$D(DIROUT)!(Y<1) KIL S MDS=Y
 . S MDNODE=$G(MDAR(MDS))
 . S MDDFLT=$G(^TMP("MDPARAM",$J,$P(MDSEL,"^",2),MDNODE))
E1 ; Edit the procedure
 W !!,"Procedure: ",$P(MDSEL,"^",2)_"// " R X:DTIME G:'$T!(X=U) KIL
 I X["?"!(X'="")&(X'="@") W !,"Hit Return to accept the procedure",!,"Enter ""@"" to delete the procedure.",!,"Enter a ""^"" will exit completely." G E1
 I X="@" D  G A1
 . I MDNXT="" D EN^XPAR("SYS","MD CHECK-IN PROCEDURE LIST",$P(MDSEL,"^",2),"@")
 . D EN^XPAR("SYS","MD CLINIC ASSOCIATION",+$P(MDDFLT,"^",5),"@")
 . K ^TMP("MDPARAM",$J,$P(MDSEL,"^",2),MDNODE)
 . S:+$P(MDDFLT,"^",2) MDCTR(+$P(MDDFLT,"^",2))=MDCTR(+$P(MDDFLT,"^",2))-1
 . W " ..Procedure deleted"
 S MDSED=MDSEL
E2 ; Ask whether appointment scheduled
 K DIR S DIR(0)="SA^0:None;1:Outpatient;2:Inpatient;3:Both",DIR("A")="Schedule Appointment?: ",DIR("B")=+$P(MDDFLT,"^",3)
 S DIR("?")="^D CHELP^MDWCHK"
 D ^DIR K DIR
 G:$D(DIRUT)!$D(DIROUT)!(Y<0) KIL S MDSAP=Y
 I $G(MDDFLT)'="" D EN^XPAR("SYS","MD CHECK-IN PROCEDURE LIST",$P(MDSEL,"^",2),"@")
 D EN^XPAR("SYS","MD CHECK-IN PROCEDURE LIST","`"_+MDSED,+MDSAP)
 I MDSAP'=+$P(MDDFLT,"^",3) S MDLP="" F  S MDLP=$O(^TMP("MDPARAM",$J,$P(MDSED,"^",2),MDLP)) Q:MDLP=""  S MDX=$G(^(MDLP)) I $P(MDX,"^",3)'=+MDSAP D
 . S $P(MDX,"^",3,4)=+MDSAP_"^"_$S(MDSAP=1:"Outpatient",MDSAP=2:"Inpatient",MDSAP=3:"Both",1:"None")
 . S ^TMP("MDPARAM",$J,$P(MDSED,"^",2),MDLP)=MDX
 I MDNODE["None" G A3
E3 ; Edit the location
 W !,"Clinic: ",MDNODE_"// " R X:DTIME G:'$T!(X=U) KIL
 I X["?"!(X'="")&(X'="@") W !,"Hit Return to accept the clinic",!,"Enter ""@"" to delete the clinic from the procedure.",!,"Enter a ""^"" will exit completely." G E3
 I X="" G A4
 I X="@" D  G A4
 . D:+$P(MDDFLT,"^",5) EN^XPAR("SYS","MD CLINIC ASSOCIATION",+$P(MDDFLT,"^",5),"@")
 . S:+$P(MDDFLT,"^",2) MDCTR(+$P(MDDFLT,"^",2))=MDCTR(+$P(MDDFLT,"^",2))-1
 . K ^TMP("MDPARAM",$J,$P(MDSEL,"^",2),MDNODE)
 . I $G(MDNXT)="" S $P(MDDFLT,"^",2)="",^TMP("MDPARAM",$J,$P(MDSEL,"^",2),"None")=MDDFLT
 . W " ..Value deleted"
 S MDCL=+$P(MDDFLT,"^",2)_"^"_MDNODE
 K MDCL,MDSEL
 G A4
A2 ; Ask if site schedule appointments
 K DIR S DIR(0)="SA^0:None;1:Outpatient;2:Inpatient;3:Both",DIR("A")="Schedule Appointment?: ",DIR("?")="^D CHELP^MDWCHK"
 D ^DIR K DIR
 I $D(DIRUT)!$D(DIROUT)!(Y<0) W "...Procedure removed" G KIL
 S MDSAP=Y
 D EN^XPAR("SYS","MD CHECK-IN PROCEDURE LIST","`"_+MDSEL,+MDSAP)
 S ^TMP("MDPARAM",$J,$P(MDSEL,"^",2),"None")=+MDSEL_"^^"_MDSAP_"^"_$S(MDSAP=1:"Outpatient",MDSAP=2:"Inpatient",MDSAP=3:"Both",1:"None")
 I 'MDSAP S MDCL="" D TASK G A1
A3 ; Ask for clinic value
 W !,"Clinic: " R X:DTIME G:'$T!(X=U) KIL
 I X["?" D CLHELP
 I X="" S MDCL="" D:'+MDSAP TASK G A1
 K DIC S DIC="^SC(",DIC(0)="EQMZ"
 D ^DIC K DIC G A3:"^"[X!$D(DTOUT),A3:Y<1
 S MDCL=Y D TASK
 K ^TMP("MDPARAM",$J,$P(MDSEL,"^",2),"None")
 S ^TMP("MDPARAM",$J,$P(MDSEL,"^",2),$P(MDCL,"^",2))=+MDSEL_"^"_+MDCL_"^"_MDSAP_"^"_$S(MDSAP=1:"Outpatient",MDSAP=2:"Inpatient",MDSAP=3:"Both",1:"None")
 S:$G(MDCTR(+MDCL))="" MDCTR(+MDCL)=0 S MDCTR(+MDCL)=MDCTR(+MDCL)+1,MDLAST=MDLAST+1
 D EN^XPAR("SYS","MD CLINIC ASSOCIATION",MDLAST,+MDCL_";"_+MDSEL)
A4 ; Ask for another Clinic
 K DIR W ! S DIR(0)="YA",DIR("A")="Enter another clinic for the same procedure? ",DIR("B")="NO",DIR("?")="Enter either 'Y' or 'N', if you want to assign more than one clinic."
 D ^DIR K DIR G:$D(DIRUT)!$D(DIROUT)!(Y<0) A4
 I +Y G A3
 G A1
KIL ; Clean Up TMP global arrays and exit
 K DIROUT,DIRUT,MDCL,MDSEL,X,Y
 K ^TMP("MDPROC",$J),^TMP("MDPARAM",$J)
 Q
TASK ; Queue a task to process previous requests
 K IO("Q"),ZTUCI,ZTDTH,ZTIO,ZTSAVE S ZTRTN="START^MDWCHK",ZTREQ="@",ZTSAVE("ZTREQ")="",ZTIO="",ZTDTH=$$NOW^XLFDT()
 S ZTDESC="Check-In Studies for "_$P($G(^MDS(702.01,+MDCP,0)),"^",1)
 S ZTSAVE("MDCP")="",ZTSAVE("MDCL")="",MDUSR=DUZ,ZTSAVE("MDUSR")="",ZTSAVE("MDSAP")=""
 D ^%ZTLOAD K ZTSK
 Q
GET ; Get existing parameter
 N MDPAR,MDVAL
 D GETLST^XPAR(.MDLST1,"SYS","MD CLINIC QUICK LIST")
 D GETLST^XPAR(.MDLST2,"SYS","MD CLINICS WITH MULT PROC")
 ; Get Clinic Quick List
 F MDLP=0:0 S MDLP=$O(MDLST1(MDLP)) Q:MDLP<1  S MDX1=+$P($G(MDLST1(MDLP)),"^",2) I +MDX1 D
 . S MDX=$P($G(^MDS(702.01,MDX1,0)),"^",1) Q:MDX=""
 . S MDY=+$G(MDLST1(MDLP)) Q:'MDY
 . S MDY1=$$GET1^DIQ(44,MDY_",",.01)
 . S ^TMP("MDOLD",$J,MDX,MDY1)=MDY_"^"_MDX1
 ; Get clinic with multiple procedures
 F MDLP=0:0 S MDLP=$O(MDLST2(MDLP)) Q:MDLP<1  I +$G(MDLST2(MDLP)) S MDX=$P($G(^MDS(702.01,+$G(MDLST2(MDLP)),0)),"^",1) D
 . S MDY=+$P($G(MDLST2(MDLP)),"^",2),MDY1=$$GET1^DIQ(44,MDY_",",.01)
 . Q:$G(^TMP("MDOLD",$J,MDX,MDY1))'=""
 . S ^TMP("MDOLD",$J,MDX,MDY1)=MDY_"^"_+$G(MDLST2(MDLP))
 S MDPAR=$NA(^TMP("MDOLD",$J)),MDCTR=0 F  S MDPAR=$Q(@MDPAR) Q:MDPAR=""  Q:$QS(MDPAR,1)'="MDOLD"  D
 . S MDCTR=MDCTR+1,MDVAL=@MDPAR,MDVAL=$TR(MDVAL,"^",";")
 . D EN^XPAR("SYS","MD CLINIC ASSOCIATION",MDCTR,MDVAL)
 K ^TMP("MDOLD",$J)
 Q
CLHELP ; Help Message for Clinic prompt
 W !,"Only required, if appointments are scheduled for the procedure."
 W !,"Enter the clinic used for scheduling the procedure."
 I +MDCP,$D(^TMP("MDPARAM",$J)) D
 .W ! S MDLP="" F  S MDLP=$O(^TMP("MDPARAM",$J,$P($G(^MDS(702.01,+MDCP,0)),"^",1),MDLP)) Q:MDLP=""  I MDLP'["None" W !,MDLP
 W !
 Q
HDR ; Parameter List Header
 W @IOF,!!,"Procedure",?27,"Schedule Appt.",?55,"Clinic"
 W !,"---------",?27,"--------------",?55,"------"
 Q
