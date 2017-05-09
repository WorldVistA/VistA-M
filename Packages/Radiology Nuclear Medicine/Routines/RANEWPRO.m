RANEWPRO ;BPFO/CLT - NTRT RESPONSE ; 27 Jul 2016  11:51 AM
 ;;5.0;Radiology/Nuclear Medicine;**127**;Mar 16, 1998;Build 119
 ;
EN ;PRIMARY ENTRY POINT
 N RAFIRST,RALINE,X,Y,RARESP,RAMSG,RATXT,XMY,XMTEXT,XMSUB,RAIEN,RAPRO,XMDUN,XMDUZ
 S RAMSG=XMZ
 S RAFIRST=$S($E(^XMB(3.9,RAMSG,2,1,0),1,2)="--":5,1:1)
 S RALINE=RAFIRST
 ;
RESPONSE ;DETERMINE THE RESPONSE
 S RARESP=$P(^XMB(3.9,RAMSG,2,RALINE,0)," ",1)
 S X=RARESP X ^%ZOSF("UPPERCASE") S RARESP=Y
 S RAIEN=$P(^XMB(3.9,RAMSG,2,(RALINE+3),0),":",2)
 S RAPRO=$P(^XMB(3.9,RAMSG,2,(RALINE+2),0),":",2)
 I RARESP="NEW" D
 . S RATXT(1)="A new procedure has been added by NTRT to the MRPF."
 . S RATXT(2)="This procedure will be included in the next MRPF release."
 . S RATXT(3)="Contunue to use your created procedure, as is, until the new MRPF"
 . S RATXT(4)="is received.  Then this procedure can be matched.",RALINE=5
 . I $G(RAIEN)'="" S $P(^RAMIS(71,RAIEN,"NTRT"),U,2)=""
 . Q
 I RARESP="MATCH" D
 . S RATXT(1)="A match in MRPF has been found by NTRT.  Please use"
 . S RATXT(2)="the MRPF procedure "_$P(^XMB(3.9,RAMSG,2,(RALINE+1),0),"procedure ",2)_"."
 . S RATXT(3)="Please map you new procedure to this MRPF entry.",RALINE=4
 . I $G(RAIEN)'="" S $P(^RAMIS(71,RAIEN,"NTRT"),U,2)=""
 . Q
 I RARESP="NO" D
 . S RATXT(1)="No LOINC can be found for the requested new procedure."
 . S RATXT(2)="A request for a new LOINC has been submitted."
 . S RATXT(3)="Continue to use your new procedure without matching until a new LOINC"
 . S RATXT(4)="is received and distributed via a new MRPF release.  Then this procedure"
 . S RATXT(5)="can be matched.",RALINE=5
 . Q
MSG ;CREATE A MESSAGE
 S RATXT(RALINE+2)=" "
 S RATXT(RALINE+3)="Local procedure: "_RAPRO
 S RATXT(RALINE+4)="Local IEN: "_RAIEN
 S XMSUB="NTRT RESPONSE"
 S XMY("G.RADNTRT")="",XMTEXT="RATXT("
 D ^XMD
END ;END ROUTINE
 K XMZ
 Q
