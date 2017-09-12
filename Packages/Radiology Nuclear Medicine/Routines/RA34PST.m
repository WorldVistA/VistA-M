RA34PST ;HOIFO/SWM-Post install to correct entries in file 71 ;1/28/03  07:54
 ;;5.0;Radiology/Nuclear Medicine;**34**;Mar 16, 1998
QOFF ;Post-Install queues off File 71 Name correction job
 I '$D(XPDNM)#2 D EN^DDIOL("This entry point must be called from the KIDS installation -- Nothing Done.",,"!!,$C(7)") Q
 I +$G(DUZ)=0 D EN^DDIOL("DUZ isn't defined -- Nothing Done.",,"!!,$C(7)")
 N RATXT,ZTDESC,ZTDTH,ZTIO,ZTRTN S ZTIO=""
 S ZTRTN="EN^RA34PST"
 S ZTDESC="RA*5.0*34 File 71 Name correction job"
 S ZTDTH=$$FMADD^XLFDT($$NOW^XLFDT(),0,0,2,0) ;add 2 minutes to 'now'
 D ^%ZTLOAD S RATXT(1)=" "
 S RATXT(2)="RA*5.0*34 File 71 Name correction is running in background."
 S:$G(ZTSK)>0 RATXT(3)="Task: "_ZTSK_"."
 S RATXT(4)=" "
 S RATXT(5)="The results will be sent to your mailbox."
 S RATXT(6)=" "
 D MES^XPDUTL(.RATXT)
 Q
MANUAL ;manually queue off Name correction job, only use if post-install abends
 I +$G(DUZ)=0 D EN^DDIOL("DUZ isn't defined -- Nothing Done.",,"!!,$C(7)") Q
ASKQ K DIR,DIROUT,DIRUT,DTOUT,DUOUT
 N RAX
 S DIR(0)="Y",DIR("B")="No"
 S DIR("?")="Enter 'Y' if you want to queue the File 71 Name correction job."
 S DIR("A")="Do you want to start routine RA34PST to correct File 71 procedure names"
 D ^DIR
 K DIR,DIROUT,DIRUT,DTOUT,DUOUT
 Q:'Y  ;don't queue if answer is NO
 D EN^DDIOL("The results will be sent to your mailmox.",,"!!,$C(7)")
 N ZTDESC,ZTDTH,ZTIO,ZTRTN S ZTIO=""
 S ZTRTN="EN^RA34PST"
 S ZTDESC="MANUAL File 71 Name correction -- routine RA34PST"
 S ZTDTH=$$FMADD^XLFDT($$NOW^XLFDT(),0,0,2,0) ;add 2 minutes to 'now'
 D ^%ZTLOAD
 D EN^DDIOL("RA*5.0*34 File 71 Name correction will start in 2 minutes in the background.",,"!,$C(7)")
 I $G(ZTSK)>0 S RAX="Task: "_ZTSK D EN^DDIOL(RAX,,"!,$C(7)")
 Q
EN ; LOOP THRU FILE 71, FIELD .01
 ; remove SEMICOLON from it
 ; if proc is active, then call PROC^RAO7MFN to update OI file
 N RAI,RAX,RA1,RA2,RA3,RAFDA,RASTAT,RAY,RACTOT,RAC1,RAC2,RABADTOT,RAC
 S (RAI,RACTOT,RAC1,RAC2,RABADTOT,RAC)=0
SLOOP S RAI=$O(^RAMIS(71,RAI)) G:'RAI EXLOOP
 S RAX=$G(^RAMIS(71,RAI,0)) G:RAX="" SLOOP
 S RACTOT=RACTOT+1
 S RA1=$P(RAX,"^")
 I (RA1[";") D 
 . L +^RAMIS(71,RAI,0):0 I '$T D  Q
 .. S RA3="Can't lock ^RAMIS(71,"_RAI_",0), so "_RA1_" isn't changed."
 .. D STOR
 .. S RABADTOT=RABADTOT+1
 .. Q
 . S RA2=$TR(RA1,";",",") ; new string
 . Q:$O(^RAMIS(71,"B",RA2,0))  ; skip if new string already exists
 . S RA3="^RAMIS(71,"_RAI_",0)'s "_RA1_" will be "_RA2 D STOR
 . D REMOV,CPRS
 . L -^RAMIS(71,RAI,0)
 . Q
 G SLOOP
EXLOOP S RA3=" " D STOR
 S RA3="File 71, RAD/NUC MED PROCEDURES, has been checked." D STOR
 S RA3=" " D STOR
 S RA3="No. records checked:                 "_$J(RACTOT,7) D STOR
 S RA3="No. records had semicolon corrected: "_$J(RAC1,7) D STOR
 S RA3="No. records updated in file 101.43:  "_$J(RAC2,7) D STOR
 S RA3="No. records locked and not updated:  "_$J(RABADTOT,7) D STOR
 D MAIL
 S:$D(ZTQUEUED) ZTREQ="@"
 Q
STOR ; store messages and totals
 Q:$G(RA3)=""
 S RAC=RAC+1,^TMP($J,"RA34PST",RAC)=RA3
 Q
REMOV ; remove ";"
 S RAC1=RAC1+1
 S RAFDA(71,RAI_",",.01)=RA2
 D FILE^DIE("E","RAFDA")
 K RAFDA
 Q
CPRS ; update record in Orderable Items file 101.43
 Q:$$ORQUIK^RAORDU()'=1  ;skip update if no Order Dialog file 101.41
 ; skip if inactive
 I $S('$D(^RAMIS(71,RAI,"I")):0,^("I")="":0,+^("I")>DT:0,1:1) Q
 S RAC2=RAC2+1
 S RASTAT="1^1"
 S RAY=RAI_"^"_RA2
 D PROC^RAO7MFN(0,71,RASTAT,RAY)
 Q
MAIL ; Send mail message to the installer
 N XMDUZ,XMSUB,XMTEXT,XMY S XMDUZ=.5
 S XMTEXT="^TMP($J,""RA34PST""," ;only numeric nodes are mailed
 S XMSUB="Results from routine RA34PST"
 S XMY(DUZ)="" D ^XMD
 Q
