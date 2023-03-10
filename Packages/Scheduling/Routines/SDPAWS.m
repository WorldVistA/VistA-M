SDPAWS ;MS/SJA - UPDATE LLP, 'TMP_SEND' TO USE AWS SERVERS;July 05, 2018
 ;;5.3;Scheduling;**765**;May 29, 2018;Build 13
 ;
 ; Reference to ^HLCS(870, supported by IA#6409
 ;
 Q
POST ; Entry point
 ;Output:
 ; ^XTMP("SDPAWS",0) = purge date ^ today's date ^ patch 
 ; ^XTMP("SDPAWS",1) = Link name ^ DNS ^ Port Number ^ DNS DOMAIN ^ TCP/IP PORT (OPTIMIZED)
 ; ^XTMP global will be deleted after 30 days from installation
 ;
 N SDENV,X,Y
 D MES^XPDUTL("  Start Logical Link updates...")
 I $G(SDRLBK) G STBK
 ;
ENV ; install environment
 ; Output: P = Production, T = Test (Pre-Prod), Q = SQA Test, D = Development
 S SDENV=$$PROD^XUPROD()
 N DIR,DIRUT,DTOUT,DUOUT,DIROUT
 S DIR("B")=$S($G(SDENV)=1:"P",$G(SDENV)=0:"Q",1:"T")
 S DIR(0)="S^P:Production;T:Pre-Prod(Test);Q:SQA Test;D:Development"
 S DIR("A")="Select Environment"
 S DIR("?")="Select the Environment associated with this install"
 D ^DIR K DIR I $D(DTOUT)!$D(DUOUT) D BMES^XPDUTL("Aborted. No Updates made.") Q
 S SDENV=Y
 ;
 ; AWS HealthShare servers  (DNS name, IP address, and port number)
 N DNS,SDDNS,SDIP,SDPORT,OPTI
 S DNS("P")="vac10cluhl7r201-hl7.domain.ext^127.0.0.1^7950"
 S DNS("T")="vac10cluhshhl7rtr401.domain.ext^127.0.0.1^6950"
 S DNS("Q")="vac10apphsh924.domain.ext^127.0.0.1^54619"
 S DNS("D")="vac10apphsh804.domain.ext^127.0.0.1^54619"
 S SDDNS=$P(DNS(SDENV),U),SDIP=$P(DNS(SDENV),U,2),SDPORT=$P(DNS(SDENV),U,3),OPTI=SDPORT
 ;
STBK ;
 N FDA,SDA,SDACTV,SDDP,SDLNK,SDP0,SDDAPP,SDP4,SDER,SDLLN
 S SDLLN="TMP_SEND",(SDDP,SDLNK)=+$$FIND1^DIC(870,"","MX",SDLLN)
 I SDLNK=0 D BMES^XPDUTL("Link '"_SDLLN_"' does not exist. Update aborted.") Q
 L +^HLCS(870,SDLNK):10 I '$T D BMES^XPDUTL("Logical Link '"_SDLLN_"' was locked and unable to access. Update aborted.") Q
 S SDP0=$G(^HLCS(870,SDDP,0)),SDDAPP=$P(SDP0,"^"),SDP4=$G(^HLCS(870,SDDP,400))
 ;
 ; Save current LLP, Link Name ^ IP ^ Port# ^ DNS, to XTMP
 I '$G(SDRLBK) D
 . S ^XTMP("SDPAWS",0)=$$FMADD^XLFDT(DT,30)_U_DT_U_"SD*5.3*765"
 . S ^XTMP("SDPAWS",1)=$P(SDP0,U)_U_$P(SDP4,U)_U_$P(SDP4,U,2)_U_$P(SDP0,"^",8)_U_$P(SDP4,U,8)
 ;
 ; Shutdown LLP
 ; 4=status,10=Time Stopped,9=Time Started,11=Task Number, 14=Shutdown LLP
 ; DD14(P15)=0 means LLP was ON, OK to shutdown, piece 12=DD11 above
 ;
 S SDACTV=1
 I $P(SDP0,U,15) D BMES^XPDUTL("Logical Link '"_SDLLN_"' status was already shutdown.") S SDACTV=0
 N SDER
 I '$P(SDP0,U,15) D  Q:$D(SDER)
 . S X="FDA(870,"""_SDDP_","")",@X@(4)="Halting",@X@(10)=$$NOW^XLFDT,(@X@(11),@X@(9))="@",@X@(14)=1
 . ; SDP4-P3="C"LIENT, P4="N"ON-PERSISTANT, No task number
 . I $P(SDP4,U,3)="C"&("N"[$P(SDP4,U,4)),'$P(SDP0,U,12) S @X@(4)="Shutdown"
 . D FILE^DIE("","FDA","SDER")
 . I $D(SDER) D  Q
 .. D BMES^XPDUTL("Logical Link '"_SDLLN_"' was NOT able to Shutdown!")
 .. D BMES^XPDUTL("Error: "_$G(SDER("DIERR",1,"TEXT",1)))
 .. D BMES^XPDUTL("Please log a ticket to report this error")
 . ;
 . D BMES^XPDUTL("Logical Link '"_SDLLN_"' has been shutdown!")
 ;
 ; If Roll Back, retrieve previous saved Link data
 S SDA=0 I $G(SDRLBK) D  Q:SDA
 . S X=$G(^XTMP("SDPAWS",1))
 . I X="" S SDA=1 D BMES^XPDUTL("No rollback data stored in ^XTMP('SDPAWS') global") Q
 . S SDIP=$P(X,U,2),SDDNS=$P(X,U,4),SDPORT=$P(X,U,3),OPTI=$P(X,U,5)
 . S:SDIP="" SDIP="@" S:SDDNS="" SDDNS="@" S:SDPORT="" SDPORT="@" S:OPTI="" OPTI="@"
 . D NOW^%DTC
 . S ^XTMP("SDPAWS",2)="Roll back performed: "_+$E(%,1,12)
 ;
 ; Update LINK
 S DIE="^HLCS(870,",DA=SDLNK,DR="400.01///"_SDIP_";400.02///"_SDPORT_";.08///"_SDDNS_";400.08///"_OPTI
 D ^DIE K DIE,DA,DR
 D BMES^XPDUTL("SD link 'TMP_SEND' "_$S($G(SDRLBK):"rolled back",1:"updated with new data"))
 D BMES^XPDUTL("  - Logical Link "_SDLLN_", DNS: "_SDDNS)
 D BMES^XPDUTL("  - TCP/IP Address: "_SDIP_", PORT: "_SDPORT)
 I SDACTV=0 D END Q
 ;
 ; Activate LLP
 K SDER
 I $P(SDP4,U,3)="C"&("N"[$P(SDP4,U,4)) D  Q:$D(SDER)
 . ;4=state 9=Time Started, 14=Shutdown LLP
 . K FDA S X="FDA(870,"""_SDDP_","")",@X@(4)="Enabled",@X@(9)=$$NOW^XLFDT,@X@(14)=0
 . D FILE^DIE("","FDA","SDER")
 . ;
 . ; if DIE unable to enable LINK, EXIT
 . I $D(SDER) D  Q
 .. D BMES^XPDUTL("Logical Link '"_SDLLN_"' was NOT enabled!")
 .. D BMES^XPDUTL("Error: "_$G(SDER("DIERR",1,"TEXT",1)))
 .. D BMES^XPDUTL("Please log a ticket to report this error")
 .. Q
 .. ;
 . D BMES^XPDUTL("Logical Link: '"_SDLLN_"' has been enabled!")
 . Q
 ;
END L -^HLCS(870,SDLNK)
 I '$G(SDRLBK) D BMES^XPDUTL("Logical Link '"_SDLLN_"' now pointing to the new AWS server.")
 Q
 ;
ROLLBAK ; rolled back
 N SDRLBK S SDRLBK=1 D POST
 Q
