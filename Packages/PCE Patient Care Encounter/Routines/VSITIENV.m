VSITIENV ;ISL/dee - Environment Check rtn ;8/9/96
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**76**;Aug 12, 1996
 ; Patch PX*1*76 changes the 2nd line of all VSIT* routines to reflect
 ; the incorporation of the module into PCE.  For historical reference,
 ; the old (VISIT TRACKING) 2nd line is included below to reference VSIT
 ; patches.
 ;
 ;;2.0;VISIT TRACKING;;Aug 12, 1996
EN ; entry point
 N PXINSTAL,AICSINST,PXPTINST
 S AICSINST=$$VERSION^XPDUTL("IBD")
 S GMTSINST=$$VERSION^XPDUTL("GMTS")
 S VSITINST=$$VERSION^XPDUTL("VSIT")
 S PXPTINST=$$VERSION^XPDUTL("PXPT")
 S PXINSTAL=$$VERSION^XPDUTL("PX")
 I +AICSINST<2.1 D
 . W !!,"You can only install this version in an account that has"
 . W !,"AUTOMATED INFO COLLECTION SYS (IBD) version 2.1 installed."
 . W !,"You must install this before installing PCE."
 . S XPDQUIT=1
 I PXINSTAL]"",PXINSTAL'="1.0",$P(PXINSTAL,"T",2)<31 D
 . W !!,"You can only install this version in an account that has the"
 . W !,"  released version 1.0 or test version 1.0T31 or greater of "
 . W !,"  PCE.  Or an account that does not have PCE installed yet."
 . W !,"You must install T32 of PCE and Visit Tracking before installing"
 . W !,"  this version."
 . W !,"T32 has database clean up that is not included in this version."
 . S XPDQUIT=1
 E  I VSITINST]"",VSITINST'="2.0",$P(VSITINST,"T",2)<31 D
 . W !!,"You can only install this version in an account that has the"
 . W !,"  released version 2.0 or test version 2.0T31 or greater of"
 . W !,"  Visit Tracking.  Or an account that does not have"
 . W !,"Visit Tracking installed yet."
 . W !,"You must install T32 of Visit Tracking before installing"
 . W !,"this version."
 . W !,"T32 has database clean up that is not included in this version."
 . S XPDQUIT=1
 I $G(XPDQUIT)=1 Q
 I '$G(XPDENV) Q
 I $S('($D(DUZ)#2):1,'($D(DUZ(0))#2):1,'DUZ:1,'(+$G(DUZ(2))):1,1:0) D  Q
 . W !!,$C(7),"DUZ, DUZ(0), and DUZ(2) must be defined as an active user."
 . W !,"Please sign-on before installing."
 . K DIFQ
 . S XPDQUIT=2
 I DUZ(0)'="@" D  Q
 . W !!,$C(7),"You must have programmer access <DUZ(0)=""@""> "
 . W !,"to do this install."
 . K DIFQ
 . S XPDQUIT=2
 Q
