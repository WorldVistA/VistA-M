PSORRVIE ;WISC/AS UPDATE LLP, PSORRXSEND ; 7/05/2018 4:57pm
 ;;7.0;OUTPATIENT PHARMACY;**534**;JULY 2018;Build 352
 ;
 Q
 ;
PST ;POST INSTALL
 ;Reference to ^HLCS(870, supported by IA#6409
 ;
 ;Output:
 ; - ^XTMP("PSORRVIE",0)=purge date_U_today's date_U_patch 
 ; - ^XTMP("PSORRVIE",1) = Link name ^ DNS ^ Port Number
 ; Do not delete XTMP file until 30 days from now
 ;
 ; By region number, Get LINK name, DNS name, and port number.
 N PSOA,PSOLNK,PSOPORT,PSODNS,PSOIP
 S U="^",PSOLNK="PSORRXSEND",PSOPORT=2200
 S PSODNS="vaausvrsprdlb1.aac.domain.ext",PSOIP="127.0.0.1"
 ;
 ;
 ; 1. If link is up, stop the link.
 ; 2. Save existing DNS, IP address, and Port
 ; 3. Update logical link.
 ; 4. If the link was shutdown by this patch, bring it up
 ;
 N X,PSOLLK,PSODP,PSOP4,PSOP0,PSOACTV,PSODAPP,X1,X2,HLJ
 S (PSODP,PSOLLK)=+$$FIND1^DIC(870,"","MX",PSOLNK)
 ;
 ; If link is not defined in the HL LOGICAL LINK (#870) file
 ;  *** Exit ***
 I PSOLLK=0 D  Q
 . D BMES^XPDUTL("Link '"_PSOLNK_"' does not exist. Update aborted.")
 . Q
 ;
 ; If link is locked by other process,
 ;  *** Exit ***
 L +^HLCS(870,PSOLLK):10 I '$T D  Q
 . D BMES^XPDUTL("Link '"_PSOLNK_"' was locked and unable to access. Update aborted.")
 . Q
 ; 
 S PSOP4=$G(^HLCS(870,PSODP,400)),PSOP0=$G(^HLCS(870,PSODP,0))
 S PSODAPP=$P(PSOP0,"^",1)
 ; 
 ;
 ; Save current LLP, Link Name^IP^Port#^DNS, to XTMP
 ;
 I '$G(PSORLBK) D
 . S DT=$$DT^XLFDT,X1=DT,X2=30 D C^%DTC
 . S ^XTMP("PSORRVIE",0)=X_U_DT_U_"PSO*7.0*534"
 . S ^XTMP("PSORRVIE",1)=$P(PSOP0,"^")_U_$P(PSOP4,U)_U_$P(PSOP4,U,2)
 . S ^XTMP("PSORRVIE",1)=^XTMP("PSORRVIE",1)_U_$P(PSOP0,"^",8)
 ;
 ; Shut Down LLP
 ;
 ;4=status,10=Time Stopped,9=Time Started,11=Task Number,3=Device Type
 ;DD14(P15)=0 means LLP was ON, OK to shutdown, piece 12=DD11 above
 ;
 ; If LLP status is SHUTDOWN, do nothing
 S PSOACTV=1
 I $P(PSOP0,U,15) D
 . D BMES^XPDUTL("LINK '"_PSOLNK_"' status was already shutdown.")
 . S PSOACTV=0
 ;
 ; If LLP status is ENABLED, shutdown the LLP
 N PSOER
 I '$P(PSOP0,U,15) D  Q:$D(PSOER)
 . S X="HLJ(870,"""_PSODP_","")",@X@(4)="Halting",@X@(10)=$$NOW^XLFDT
 . S (@X@(11),@X@(9))="@",@X@(14)=1
 . ; PSOP4 P3="C"LIENT, P4="N"ON-PERSISTANT, No task number
 . I $P(PSOP4,U,3)="C"&("N"[$P(PSOP4,U,4)),'$P(PSOP0,U,12) S @X@(4)="Shutdown"
 . D FILE^DIE("","HLJ","PSOER")
 . ;
 . ; if DIE unable to Shutdown LINK, EXIT
 . I $D(PSOER) D  Q
 .. D BMES^XPDUTL("LINK '"_PSOLNK_"' was NOT able to Shutdown!")
 .. D BMES^XPDUTL("Error: "_$G(PSOER("DIERR",1,"TEXT",1)))
 .. D BMES^XPDUTL("Please log a ticket to report this error")
 .. Q
 .. ;
 . D BMES^XPDUTL("LINK '"_PSOLNK_"' has been shutdown!")
 ;
 ; If Roll Back, retrieve previous saved Link data
 ;
 S PSOA=0 I $G(PSORLBK) D  Q:PSOA
 . S X=$G(^XTMP("PSORRVIE",1)) I X="" D  Q
 .. S PSOA=1
 .. D BMES^XPDUTL("PSO, no rollback data stored in ^XTMP('PSORRVIE') global")
 . S PSOIP=$P(X,U,2),PSODNS=$P(X,U,4),PSOPORT=$P(X,U,3)
 . I PSODNS="" S PSODNS="@"
 . I PSOPORT="" S PSOPORT="@"
 . I PSOIP="" S PSOIP="@"
 . S ^XTMP("PSORRVIE",2)="Roll back performed "_$$DT^XLFDT
 ;
 ; Update LINK
 ;
 S DIE="^HLCS(870,",DA=PSOLLK
 S DR="400.01///"_PSOIP
 S DR=DR_";400.02///"_PSOPORT_";.08///"_PSODNS
 D ^DIE
 K DIE,DA,DR
 S X="PSO, LINK PSORRXSEND "_$S($G(PSORLBK):"rolled back",1:"updated with VIERS data")
 D BMES^XPDUTL(X)
 S X="  - LOGICAL LINK "_PSOLNK_", DNS: "_PSODNS
 D BMES^XPDUTL(X)
 S X="  - TCP/IP ADDRESS: "_PSOIP_", PORT: "_PSOPORT
 D BMES^XPDUTL(X)
 ;
 I PSOACTV=0 D PSTEND Q
 ;
 ; Activate LLP
 ;
 K PSOER
 I $P(PSOP4,U,3)="C"&("N"[$P(PSOP4,U,4)) D  Q:$D(PSOER)
 . ;4=status 9=Time Started, 10=Time Stopped, 11=Task Number
 . ;14=Shutdown LLP, 3=Device Type, 18=Gross Errors
 . K HLJ
 . S X="HLJ(870,"""_PSODP_","")"
 . S @X@(4)="Enabled",@X@(9)=$$NOW^XLFDT,@X@(14)=0
 . D FILE^DIE("","HLJ","PSOER")
 . ;
 . ; if DIE unable to enable LINK, EXIT
 . I $D(PSOER) D  Q
 .. D BMES^XPDUTL("LINK '"_PSOLNK_"' was NOT enabled!")
 .. D BMES^XPDUTL("Error: "_$G(PSOER("DIERR",1,"TEXT",1)))
 .. D BMES^XPDUTL("Please log a ticket to report this error")
 .. Q
 .. ;
 . D BMES^XPDUTL("LINK '"_PSOLNK_"' has been enabled!")
 . Q
 ;
PSTEND L -^HLCS(870,PSOLLK)
 I '$G(PSORLBK) D BMES^XPDUTL("PSO, LOGICAL LINK '"_PSOLNK_"' NOW POINT TO VIERS SERVER.")
 ;
 Q
 ;
ROLLBAK ;
 N PSORLBK S PSORLBK=1
 D PST
 Q
