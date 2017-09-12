DGPREPST ;ALB/SCK - Pre-Registration Post Init ; 1/9/97
 ;;5.3;Regisitration;**109**;Aug 13, 1993
 ;
START ;
 D BMES^XPDUTL("Beginning Post-Install of Pre-Registration")
 ;
 I '$$NEWCP^XPDUTL("POST_1","OPT1^DGPREPST",0) D
 . D BMES^XPDUTL("Error creating Scheduling Option checkpoint")
 ;
 I '$$NEWCP^XPDUTL("POST_2","OPT2^DGPREPST",0) D
 . D BMES^XPDUTL("Error adding to Mailgroup checkpoint")
 ;
 D BMES^XPDUTL("Post-Install Complete")
 Q
 ;
OPT1 ;
 N DGPIEN,DGPIEN1,MSG,DIFROM,DGPERR
 ;
 S DGPIEN="",DGPIEN=$O(^DIC(19,"B","DGPRE PRE-REGISTER NIGHT JOB",DGPIEN))
 I DGPIEN']"" D  Q
 . S MSG(1)="The DGPRE PRE-REGISTER NIGHT JOB option was not created in the OPTION File"
 . S MSG(2)="during the KIDS build.  Please re-verify your KIDS build and  reinstall"
 . D MES^XPDUTL(.MSG) K MSG
 ;
 S (DGPF,DGPIEN1)="",DGPIEN1=$O(^DIC(19.2,"B",DGPIEN,DGPIEN1))
 S:DGPIEN1']"" DGPF="L"
 ;
 I DGPIEN1]"",+$P($G(^DIC(19.2,DGPIEN1,0)),U,2)>0 S Y=$P(^(0),U,2) D  Q
 . D BMES^XPDUTL("The DGPRE PRE-REGISTER NIGHT JOB is already scheduled for"_$$FMTE^XLFDT(Y))
 ;
 I XPDQUES("POS001")']"" D
 . S MSG(1)="You have not specified the QUEUED TO RUN AT WHAT TIME"
 . S MSG(2)="The option will not run until IRM sets the Queued to run time."
 . D MES^XPDUTL(.MSG) K MSG
 ;
 I XPDQUES("POS002")']"" D
 . S MSG(1)="You have not specified a DEVICE FOR QUEUED JOB OUTPUT"
 . S MSG(2)="This may cause a problem for MSM sites, and a NULL device may have"
 . S MSG(3)="to set by IRM"
 . D MES^XPDUTL(.MSG) K MSG
 ;
 D RESCH^XUTMOPT("DGPRE PRE-REGISTER NIGHT JOB",XPDQUES("POS001"),$P(XPDQUES("POS002"),U,2),"1D",DGPF)
 S DGPIEN="",DGPIEN=$O(^DIC(19,"B","DGPRE PRE-REGISTER NIGHT JOB",DGPIEN))
 S DGPIEN1="",DGPIEN1=$O(^DIC(19.2,"B",DGPIEN,DGPIEN1))
 I +$G(DGPIEN1)'>0 D  Q
 . S MSG(1)="There was an error scheduling the  DGPRE PRE-REGISTER NIGHT JOB"
 . S MSG(2)="Please have IRM schedule this job in the OPTION SCHEDULING File"
 . D MES^XPDUTL(.MSG) K MSG
 Q
 ;
OPT2 ;
 N MSG,DGPIEN,DGPMBR
 ;
 S DIC="^XMB(3.8,",DIC(0)="MZ",X="DGPRE PRE-REG STAFF" D ^DIC
 S DGPIEN=+Y
 I DGPIEN'>0 D  Q
 . S MSG(1)="The DGPRE PRE-REG STAFF mailgroup was not created during the build"
 . S MSG(2)="Please check and try re-installing the build.  If this still does"
 . S MSG(3)="not install correctly, your IRM will have to complete this manually"
 . D MES^XPDUTL(.MSG) K MSG
 ;
 I $G(XPDQUES("POS003"))']"" D  Q
 . D BMES^XPDUTL("No members selected to add to mailgroup")
 ;
 S DIC="^XMB(3.8,",DIC(0)="MZ",X="DGPRE PRE-REG STAFF" D ^DIC
 ;
 S X=$P(XPDQUES("POS003"),U,2)
 S DA(1)=DGPIEN,DIC=DIC_DA(1)_",1,",DIC(0)="LQ"
 S DIC("P")=$P(^DD(3.8,2,0),"^",2)
 ;
 D ^DIC K DIC
 I +$P(Y,U,3)>0 D  G OPT2Q
 . D BMES^XPDUTL("Selected member was added to the mailgroup")
 ;
 I +$P(Y,U,3)=0 D  G OPT2Q
 . D BMES^XPDUTL("Selected member is already assigned to the mailgroup")
 ;
 I +$Y<0 D  G OPT2Q
 . D BMES^XPDUTL("Selected member was not added, contact your IRM")
 ;
OPT2Q Q
 ;
CNVRT ; Conversion procedure for converting pre-reg fields in the PATIENT File, #2 to
 ; the PRE-REGISTRATION AUDIT File, #41.41.  This procedure uses the 'AZZ'
 ; cross reference in the PATIENT File, #2.
 ;
 N DGPDT,DGPDFN,DGPD,DGPCNT,DGPCNT1,DGPD1
 ;
 S (DGPCNT,DGPCNT1)=0
 W !!,"Starting conversion of Preregistration entries..."
 D WAIT^DICD
 S DGPDFN=0 F  S DGPDFN=$O(^DPT(DGPDFN)) Q:'DGPDFN  D
 . S DGPCNT=DGPCNT+1
 . I DGPCNT#500=0 W "."
 . Q:'$D(^DPT(DGPDFN,663201))
 . K DGPD,DGPD1
 . S DGPD=$G(^DPT(DGPDFN,663201)),DGPD1=$P(DGPD,U) Q:+DGPD1'>0
 . Q:$D(^DGS(41.41,"ADC",DGPDFN,DGPD1))
 . K DD,DO
 . S DIC="^DGS(41.41,",DIC(0)="NL"
 . S X=DGPDFN
 . S DIC("DR")="1////^S X=DGPD1;2///^S X=$S($P(DGPD,U,2)]"""":$P(DGPD,U,2),1:.5)"
 . D FILE^DICN
 . I Y<0 W !,"PROBLEM ADDING DFN: "_DGPDFN_" TO FILE 41.41" Q
 . S DGPCNT1=DGPCNT1+1
 ;
 W !!,"Conversion complete"
 W !,DGPCNT_" Patient records scanned"
 W !,DGPCNT1_" Records added to File #41.41"
 Q
