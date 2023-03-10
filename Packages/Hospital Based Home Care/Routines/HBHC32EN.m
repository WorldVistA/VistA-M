HBHC32EN ;HPS/DSK - Pre-install environment check; May 02, 2021@14:20
 ;;1.0;HOSPITAL BASED HOME CARE;**32**;NOV 01, 1993;Build 58
 ;
 ;NEW PERSON (#200) file - IA #10060 (supported)
 ;BMES^XPDUTL            - IA #10141 (supported)
 ;^XUSEC                 - IA #10076 (supported)
 ;
EN ;
 ;Variable XPDQUIT is new'd by XPD routines.
 ;Setting XPDQUIT=2 leaves install in ^XTMP but
 ;aborts install until after issues are resolved.
 D BMES^XPDUTL("*** Environment check starting.... ***")
 N HBHCSEQ
 S HBHCSEQ=5,XPDQUIT=0
 K ^XTMP("HBHC32 ENV CHECK")
 S ^XTMP("HBHC32 ENV CHECK",0)=$$FMADD^XLFDT(DT,60)_"^"_DT_"^HBH*1.0*32 Environment Check"
 D ID,PROV
 S HBHCMZ=$$MESS()
 I $G(HBHCMZ) D
 . D BMES^XPDUTL("*** Environment Check Failed - Install Aborted. ***")
 . D BMES^XPDUTL("MailMan message #"_HBHCMZ_" has been sent to")
 . D BMES^XPDUTL("holders of the HBHC MANAGER security key and")
 . D BMES^XPDUTL("the patch installer "_$P($G(^VA(200,+DUZ,0)),"^")_".")
 ;
 D BMES^XPDUTL("*** Environment check finished. ***")
 Q
 ;
ID ;
 ;First check: are any HBHC ID's assigned to
 ;             more than one active provider.
 N HBHCA,HBHCB,HBHCHIT,HBHCCHK,HBHCNAME,HBHCZ
 S (HBHCA,HBHCB)="",HBHCCHK=0
 F  S HBHCA=$O(^HBHC(631.4,"B",HBHCA)) Q:HBHCA=""  D
 . S HBHCHIT=0
 . F  S HBHCB=$O(^HBHC(631.4,"B",HBHCA,HBHCB)) Q:HBHCB=""  D
 . . Q:$P(^HBHC(631.4,HBHCB,0),"^",7)=1
 . . ;found an active provider
 . . S HBHCHIT=HBHCHIT+1
 . . I HBHCHIT=1 S HBHCZ=HBHCB
 . . Q:HBHCHIT=1
 . . ;generate list for MailMan message
 . . I 'HBHCCHK D
 . . . S HBHCSEQ=HBHCSEQ+1
 . . . S ^XTMP("HBHC32 ENV CHECK",HBHCSEQ)=" "
 . . . S HBHCSEQ=HBHCSEQ+1
 . . . S ^XTMP("HBHC32 ENV CHECK",HBHCSEQ)="HBHC ID's assigned to more than one provider"
 . . . S HBHCSEQ=HBHCSEQ+1
 . . . S ^XTMP("HBHC32 ENV CHECK",HBHCSEQ)="------------------------------------------------------------------"
 . . . S HBHCCHK=1
 . . I HBHCHIT=2 D
 . . . ;If HBHCHIT=2, more than one active provider
 . . . ;is assigned to this ID, and install should be aborted.
 . . . S:'XPDQUIT XPDQUIT=2
 . . . ;retrieve name from first occurrence
 . . . S HBHCNAME=$P(^HBHC(631.4,HBHCZ,0),"^",2)
 . . . S HBHCNAME=$P($G(^VA(200,HBHCNAME,0)),"^")
 . . . S HBHCSEQ=HBHCSEQ+1
 . . . S ^XTMP("HBHC32 ENV CHECK",HBHCSEQ)=HBHCA_$E("      ",1,6-($L(HBHCA)))_HBHCNAME
 . . S HBHCNAME=$P(^HBHC(631.4,HBHCB,0),"^",2)
 . . S HBHCNAME=$P($G(^VA(200,HBHCNAME,0)),"^")
 . . S HBHCSEQ=HBHCSEQ+1
 . . S ^XTMP("HBHC32 ENV CHECK",HBHCSEQ)="      "_HBHCNAME
 Q
 ;
PROV ;
 ;Second check: are any providers assigned to
 ;              more than one active HBHC ID.
 N HBHCA,HBHCB,HBHCHIT,HBHCZ,HBHCCHK,HBHCSPACE,HBHCNAME
 S HBHCSPACE="                                     "
 S (HBHCA,HBHCB)="",HBHCCHK=0
 F  S HBHCA=$O(^HBHC(631.4,"C",HBHCA)) Q:HBHCA=""  D
 . S HBHCHIT=0
 . F  S HBHCB=$O(^HBHC(631.4,"C",HBHCA,HBHCB)) Q:HBHCB=""  D
 . . Q:$P(^HBHC(631.4,HBHCB,0),"^",7)=1
 . . ;found an active provider number
 . . S HBHCHIT=HBHCHIT+1
 . . I HBHCHIT=1 S HBHCZ=HBHCB
 . . Q:HBHCHIT=1
 . . ;generate list for MailMan message
 . . I 'HBHCCHK D
 . . . S HBHCSEQ=HBHCSEQ+1
 . . . S ^XTMP("HBHC32 ENV CHECK",HBHCSEQ)=" "
 . . . S HBHCSEQ=HBHCSEQ+1
 . . . S ^XTMP("HBHC32 ENV CHECK",HBHCSEQ)="Providers assigned to more than one active HBHC ID"
 . . . S HBHCSEQ=HBHCSEQ+1
 . . . S ^XTMP("HBHC32 ENV CHECK",HBHCSEQ)="------------------------------------------------------------------"
 . . . S HBHCCHK=1
 . . I HBHCHIT=2 D
 . . . S HBHCNAME=$P($G(^VA(200,HBHCA,0)),"^")
 . . . S HBHCNAME=HBHCNAME_$E(HBHCSPACE,1,37-$L(HBHCNAME))
 . . . ;If HBHCHIT=2, more than one active ID is assigned to this
 . . . ;provider, and install should be aborted.
 . . . S:'XPDQUIT XPDQUIT=2
 . . . ;pick up the first occurrence
 . . . S HBHCSEQ=HBHCSEQ+1
 . . . S ^XTMP("HBHC32 ENV CHECK",HBHCSEQ)=HBHCNAME_$E(HBHCSPACE,1,(37-$L(HBHCNAME)))_$P(^HBHC(631.4,HBHCZ,0),"^")
 . . S HBHCSEQ=HBHCSEQ+1
 . . S ^XTMP("HBHC32 ENV CHECK",HBHCSEQ)=HBHCSPACE_$P(^HBHC(631.4,HBHCB,0),"^")
 Q
 ;
MESS() ;
 ;Display results of environment check.
 ;Generate MailMan message if issues found.
 N HBHCSUB,HBHCMIN,HBHCTEXT,HBHCDUZ,HBHCMY,HBHCMZ
 S HBHCMZ=0
 I 'XPDQUIT D BMES^XPDUTL("No issues found during environment check.") Q HBHCMZ
 ;
 I XPDQUIT D
 . S HBHCSUB="HBH*1.0*32 Install Failed Environment Check"
 . S HBHCMIN=DUZ
 . S HBHCMY(DUZ)=""
 . S HBHCTEXT="^XTMP(""HBHC32 ENV CHECK"")"
 . S HBHCDUZ=""
 . F  S HBHCDUZ=$O(^XUSEC("HBHC MANAGER",HBHCDUZ)) Q:HBHCDUZ=""  D
 . . S HBHCMY(HBHCDUZ)=""
 . S ^XTMP("HBHC32 ENV CHECK",1)="If this message lists active ID's assigned to more than one provider,"
 . S ^XTMP("HBHC32 ENV CHECK",2)="assign each provider to a unique active ID."
 . S ^XTMP("HBHC32 ENV CHECK",3)=" "
 . S ^XTMP("HBHC32 ENV CHECK",4)="If the message lists providers assigned to more than one active ID,"
 . S ^XTMP("HBHC32 ENV CHECK",5)="inactivate all ID's except one."
 . D SENDMSG^XMXAPI(HBHCDUZ,HBHCSUB,HBHCTEXT,.HBHCMY,.HBHCMIN,.HBHCMZ,"")
 Q HBHCMZ
 ;
