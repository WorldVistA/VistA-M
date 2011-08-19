VBECSRV ;DALLAS CIOFO/RLM - INTEGRITY CHECKER FOR BLOOD BANK ROUTINES ;08/20/2001 4:35 PM
 ;;1.0;VBEC;**10**;Sep 27, 1994;Build 15
 ;
START ;
 K ^TMP($J,"VBECDATA")
 S VBECSITE=$P($$SITE^VASITE,U,2),VBECSIT1=$P($$SITE^VASITE,U,1)
 ;Determine station number
 S VBECSUB=$TR(XQSUB,"abcdefghijklmnopqrstuvwxyz","ABCDEFGHIJKLMNOPQRSTUVWXYZ")
 ;Translate the subject into upper case and place it into a locally
 ;namespaced variable.
 S ^TMP("VBECINTEG",$J,1,0)=VBECSUB_" triggered at "_VBECSITE_" by "_XMFROM_" on "_XQDATE
 ;The first line of the message tells who requested the action and when.
 S %DT="T",X="NOW" D ^%DT,DD^%DT S VBECNOW=Y
 I VBECSUB["REPORT" D REPORT G EXIT
 I VBECSUB["UPDATE" D UPDATE G EXIT
 I VBECSUB["LIST" D LIST G EXIT
 I VBECSUB["PATCH" D PATCH G EXIT
 K XMTEXT,XMSUB,VBECSITE,VBECNOW,XMY
 ;Call a routine based on the "Subject" line of the message.
 ;Skip the rest of the routine (down to exit) if the subject
 ;is a valid call.
 S VBECSITE=$P($$SITE^VASITE,U,2),VBECSIT1=$P($$SITE^VASITE,U,1)
 S ^TMP($J,"VBECDATA",1)=""
 S ^TMP($J,"VBECDATA",2)="Sorry, but I don't know how to "_XQSUB
 S ^TMP($J,"VBECDATA",3)="No action taken"
 S ^TMP($J,"VBECDATA",3)="Invalid VBEC Server Request From "_XMFROM_" at "_VBECSITE_" run on "_VBECNOW
 S XMY("G.bloodbank@FO-HINES.MED.VA.GOV")=""
 S %DT="T",X="NOW" D ^%DT,DD^%DT S VBECNOW=Y
 S XMSUB="Invalid BB Server Request From "_XMFROM_" at "_VBECSITE_" run on "_VBECNOW
 S XMTEXT="^TMP($J,""VBECDATA"",",XMDUZ="Blood Bank Monitor"
 D ^XMD
 ;Send a message to the designated mail group if the server is triggered with
 ;an invalid command.  This lets the users know that they either made
 ;a typo, or that someone is attempting to improperly invoke the server.
EXIT K %DT,XMTEXT,XMSUB,VBECSITE,VBECNOW,XMY,^TMP($J,"VBECDATA")
 Q
REPORT ;report on invalid checksums at a site.
 S VBECSITE=$P($$SITE^VASITE,U,2),VBECSIT1=$P($$SITE^VASITE,U,1)
 S X=$T(+0) X ^%ZOSF("RSUM1") S ^TMP("VBECINTEG",$J,2,0)="VBECSRV at "_VBECSITE_" = "_Y,^TMP("VBECINTEG1",$J,3,0)="**VBECSRV^"_Y_"^^"_VBECSIT1_"^"_DT
 S VBA=0,VBI=4 F  S VBA=$O(^VBEC(6002.04,VBA)) Q:'VBA  S VBDATA=$G(^VBEC(6002.04,VBA,0)) D
  . S X=$P(VBDATA,"^") X ^%ZOSF("TEST") I '$T S ^TMP("VBECINTEG",$J,VBI,0)=X_" is missing.",VBI=VBI+1,^TMP("VBECINTEG1",$J,VBI,0)="**"_X_"^"_$P(VBDATA,"^",2)_"^0^"_DT,VBI=VBI+1 Q
  . X ^%ZOSF("RSUM1") I $P(VBDATA,"^",2)'=Y S ^TMP("VBECINTEG",$J,VBI,0)=X_" should be "_$P(VBDATA,"^",2)_" is "_Y,VBI=VBI+1
  . S ^TMP("VBECINTEG1",$J,VBI,0)="**"_X_"^"_$P(VBDATA,"^",2)_"^"_Y_"^"_VBECSIT1_"^"_DT_"^"_(Y'=$P(VBDATA,"^",2)),VBI=VBI+1
 K XMY S XMY("G.bloodbank@FO-HINES.MED.VA.GOV")="" ;,XMY("S.VBECINTEG@FO-HINES.MED.VA.GOV")=""
 S %DT="T",X="NOW" D ^%DT,DD^%DT S VBECNOW=Y
 S XMSUB="BB CHECKSUM "_XQSUB_" at "_VBECSITE_" run on "_VBECNOW
 F I="",1 S XMTEXT="^TMP(""VBECINTEG"_I_""",$J,",XMDUZ="Blood Bank Monitor" D ^XMD
 K %DT,VBA,VBECNOW,VBECSITE,VBI,X,XMDUZ,XMSUB,XMTEXT,Y
 K ^TMP("VBECINTEG",$J),^TMP("VBECINTEG1",$J)
 Q
UPDATE ;Update checksums at a site.
 S VBI=2
 F  X XMREC Q:XMER<0  S VBDEL=$S($P(XMRG,"^")?1"-".E:1,1:0),VBROU=$TR($P(XMRG,"^"),"-",""),VBCHK=$P(XMRG,"^",2) D
  . S VBECON=$$FIND1^DIC(6002.04,,"X",VBROU,,.ERROR)
  . I VBDEL S DA=VBECON,DIK="^VBEC(6002.04," D ^DIK S ^TMP("VBECINTEG",$J,VBI,0)="Routine "_VBROU_" deleted at "_VBECSITE,VBI=VBI+1 Q
  . S VBECIEN=$S(VBECON:VBECON_",",1:"+1,")
  . S FDA(1,6002.04,VBECIEN,.01)=VBROU
  . S FDA(1,6002.04,VBECIEN,1)=VBCHK
  . I 'VBECON D UPDATE^DIE("","FDA(1)",,"VBERR")
  . I VBECON D FILE^DIE("E","FDA(1)","VBERR")
  . S ^TMP("VBECINTEG",$J,VBI,0)="Routine "_VBROU_$S(VBECON:" updated to ",1:" added with ")_"checksum "_VBCHK,VBI=VBI+1
 K XMY S XMY("G.bloodbank@FO-HINES.MED.VA.GOV")=""
 S %DT="T",X="NOW" D ^%DT,DD^%DT S VBECNOW=Y
 S XMSUB="BB Checksum update at "_VBECSITE_" run on "_VBECNOW
 S XMTEXT="^TMP(""VBECINTEG"",$J,",XMDUZ="Blood Bank Monitor" D ^XMD
 K %DT,VBA,VBECNOW,VBECSITE,VBI,X,XMDUZ,XMSUB,XMTEXT,Y
 K ^TMP("VBECINTEG",$J),^TMP("VBECINTEG1",$J)
 Q
LIST ;
 S VBA=0,VBI=2  F  S VBA=$O(^VBEC(6002.04,VBA)) Q:'VBA  D
  . S VBDATA=$G(^VBEC(6002.04,VBA,0)),VBROU=$P(VBDATA,"^"),VBCHK=$P(VBDATA,"^",2)
  . I VBDATA="" S ^TMP("VBECINTEG",$J,VBI,0)="Record "_VBA_" damaged." Q
  . S ^TMP("VBECINTEG",$J,VBI,0)=VBECSIT1_$E("          ",1,(10-$L(VBECSIT1)))_VBROU_$E("          ",1,(10-$L(VBROU)))_VBCHK,VBI=VBI+1
 K XMY S XMY("G.bloodbank@FO-HINES.MED.VA.GOV")=""
 S %DT="T",X="NOW" D ^%DT,DD^%DT S VBECNOW=Y
 S XMSUB="BB CHECKSUM "_XQSUB_" at "_VBECSITE_" run on "_VBECNOW
 S XMTEXT="^TMP(""VBECINTEG"",$J,",XMDUZ="Blood Bank Monitor" D ^XMD
 K %DT,VBA,VBECNOW,VBECSITE,VBI,X,XMDUZ,XMSUB,XMTEXT,Y
 K ^TMP("VBECINTEG",$J),^TMP("VBECINTEG1",$J)
 Q
PATCH ;Determine Vista patch level. Expand later to include VBECS
 f VBECI=1:1:9999 s VBECA=$$PATCH^XPDUTL("VBEC*1.0*"_VBECI) i VBECA s ^TMP("VBEC",$J,(VBECI+5),0)="Patch VBEC*1.0*"_VBECI_" has been installed."
 K XMY S XMY("G.bloodbank@FO-HINES.MED.VA.GOV")=""
 S %DT="T",X="NOW" D ^%DT,DD^%DT S VBECNOW=Y
 S XMSUB="VBEC Patch List at "_VBECSITE_" run on "_VBECNOW
 S XMTEXT="^TMP(""VBEC"",$J,",XMDUZ="Blood Bank Monitor" D ^XMD
 K %DT,VBA,VBECNOW,VBECSITE,VBI,X,XMDUZ,XMSUB,XMTEXT,Y
 K ^TMP("VBECINTEG",$J),^TMP("VBECINTEG1",$J)
ZEOR ;VBECSRV
