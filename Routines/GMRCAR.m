GMRCAR ;SLC/DLT,JFR - Associate Results ;7/21/00  12:20
 ;;3.0;CONSULT/REQUEST TRACKING;**1,15**;DEC 27, 1997
AR ;Associate results with request
 I $D(IOTM),$D(IOBM),$D(IOSTBM) D FULL^VALM1
 I '$D(GMRCSEL) D SEL^GMRCA2 I $D(DTOUT)!$D(DIROUT) S GMRCQIT="" Q
 I 'GMRCSEL G END
 S GMRCO=$O(^TMP("GMRCR",$J,"CS","AD",GMRCSEL,GMRCSEL,0)),GMRC(0)=^GMR(123,GMRCO,0)
 I $P(GMRC(0),"^",12)=1 W !!,"THIS ORDER HAS BEEN DISCONTINUED, PLEASE SELECT OR ADD ANOTHER ORDER!",!! G END
 S GMRCQIT="" Q
ARMED ;Entry to associate results with a consult/request
 N GMRCQIT,GMRCQUT,GMRCPROC,GMRCSR,MCROOT,MCFILE,Y
 I '$$VERSION^XPDUTL("MC") D  Q
 . N GMRCMSG
 . S GMRCMSG="Medicine Package Not Installed. Can't Associate Results."
 . D EXAC^GMRCADC(GMRCMSG)
 I $$VERSION^XPDUTL("MC")'>2.0 D  Q
 . N GMRCMSG
 . S GMRCMSG="**Version 2.2 of Medicine required to associate results with Consults**"
 . D EXAC^GMRCADC(GMRCMSG)
 . S GMRCQUT=1
 I $D(XQY0),$E(XQY0,1,2)="MC" G AR
 I '$D(GMRCO) D SEL^GMRCA2 I 'GMRCSEL G END
 I $D(VALM) D FULL^VALM1
 I '$D(GMRCO) S GMRCO=$O(^TMP("GMRCR",$J,"CS","AD",GMRCSEL,GMRCSEL,0))
 S GMRC(0)=^GMR(123,GMRCO,0)
 S GMRCPROC=$P(GMRC(0),"^",8)
 I GMRCPROC="" D  G END
 . S GMRCMSG="No Procedure was ordered - Cannot Associate Results."
 . D EXAC^GMRCADC(GMRCMSG) S GMRCQIT=1
 I '$P(^GMR(123.3,+GMRCPROC,0),U,5) D  I $G(GMRCQIT)=1  G END
 . D EXAC^GMRCADC("This procedure not configured for Medicine Resulting")
 . S GMRCQIT=1
 I $P(GMRC(0),"^",12)=1 D  G END
 . S GMRCMSG="THIS ORDER HAS BEEN DISCONTINUED!"
 . D EXAC^GMRCADC(GMRCMSG) S GMRCQUT=1
 I +$P(GMRC(0),"^",15),$P(GMRC(0),U,15)["MCAR" D
 . S GMRCSR=$P(GMRC(0),"^",15)
 . S GMRCSR=U_$P(GMRCSR,";",2)_$P(GMRCSR,";")_",0)"
 . I '$D(@GMRCSR) D  I $G(GMRCQIT)=1 Q
 .. S GMRCMSG="This request is currently associated with results "
 .. S GMRCMSG=GMRCMSG_"no longer available" D EXAC^GMRCADC(GMRCMSG),END
 .. S GMRCQIT=1
 .S X=$P(@GMRCSR,"^",1) D REGDTM^GMRCU S X1=X
 .S X=$P(^GMR(123,GMRCO,0),"^",7) D REGDTM^GMRCU
 .W !,"  Results entered on "_X1_" are associated "
 .W !,"  with this request ordered on "_X
 . S DIR(0)="YA",DIR("A")="Would you like to continue? "
 . S DIR("B")="No" D ^DIR I Y<1 S GMRCQIT=1 Q
 . Q
 I $G(GMRCQIT)=1 Q
 S MCROOT=$$GET1^DIQ(697.2,+$P(^GMR(123.3,+GMRCPROC,0),U,5),1)
 D RESULTS^GMRCMED(MCROOT,$P(^GMR(123,+GMRCO,0),U,2))
 I $D(^TMP("GMRCR",$J,"DT")) D EN^GMRCMER S VALMBCK="R",GMRCQIT=1
 I '$D(^TMP("GMRCR",$J,"DT"))&'($G(GMRCQIT)) D
 . N MSG
 . S MSG="No results are available to associate with this request."
 . D EXAC^GMRCADC(MSG)
 Q
LKUP ;look up on procedure file using "C" cross-reference
 N Y,DIC
 S GMRCDIC="^"_GMRCGL_",""C"","_DFN_")" I '$D(@GMRCDIC) S GMRCMSG="No "_GMRCPRNM_" results available for "_$P(^DPT(DFN,0),"^") D EXAC^GMRCADC(GMRCMSG) G END
 S DIC="^"_GMRCGL_",",DIC(0)="XEZ",D="C",X=$P(^DPT(DFN,0),"^"),DIC("S")="I $P(^(0),U,2)=DFN" W !,"Results for "_$P(^DPT(DFN,0),"^")
 D MIX^DIC1 G:+Y<0 END
 S GMRCSR=+Y_";"_GMRCGL_",",GMRCSRDT=Y(0,0)
 N GMRCEND S GMRCEND=0 W ! S DIR(0)="Y",DIR("A")="Do you want to review these results first",DIR("B")="Y" D ^DIR K DIR I Y D  G:GMRCEND END
 .W @IOF S GMRCSRS=GMRCSR D AREN^GMRCSLM3(GMRCO,GMRCSR),EN^GMRCMER S GMRCSR=GMRCSRS
 .I GMRCCT=1 S GMRCEND=1 Q
 .N DIR,DIROUT,DTOUT,DUOUT
 .W !! S DIR(0)="Y",DIR("A")="Are these the right results to be associated with the selected request",DIR("B")="N" D ^DIR K DIR S:$D(DIROUT)!$D(DTOUT)!(X="^") GMRCEND=1
 .I Y=0 K GMRCSR S GMRCEND=1
 I GMRCEND K GMRCEND G END
 I '$D(GMRCSR) K GMRCEND W ! G LKUP
 I '+GMRCSR G END
ORSTS ;Check if status needs update to complete
 N ORSTS
 I $P(GMRC(0),"^",12)=2 W !,"This request is already completed, no updating performed for this request",!,"Press the <ENTER> key to EXIT " R X:DTIME G END
 W ! S DIR(0)="Y",DIR("A")="Shall I update the order status to complete",DIR("B")="N",DIR("?")="Type 'Y' for 'YES' or 'N' for 'NO' and press <ENTER> key." D ^DIR K DIR I $D(DTOUT)!$D(DIROUT)!$D(DUOUT) G END
 S ORSTS=$S(Y:2,1:9)
 I $P(^GMR(123,GMRCO,0),"^",12)=ORSTS&(+$P(^GMR(123,GMRCO,0),"^",15)) G END
 S GETPROV="Clinician responsible for results" D GETPROV^GMRCAU I '$D(GMRCORNP) S GMRCQIT="" G END
 S GMRCSVSS=GMRCSVCN D RESULT^GMRCR S GMRCSS=GMRCSVSS K GMRCSVSS,ORIFN
 S GMRCVP=$O(^ORD(101,"B","GMRCR "_GMRCPROC,0)) I GMRCVP]"" S GMRCVP=GMRCVP_";ORD(101," D AD^GMRCSLM1,INIT^GMRCSLM
END ;
 K ORIFN,GMRCO,GMRCEND,GMRCGL,GMRCDIC,GMRCMSG,GMRCVP,DIC,D,GMRCSR,GMRCSRDT,GMRCSRS,GMRCTM,GMRCBM,X,X1,GETPROV
 K GMRCO,GMRC(0),GMRCSR,MCFILE,MCPROC,GMRCPROC,GMRCPRNM
 I $D(DTOUT)!$D(DIROUT) S GMRCQIT=""
 Q
