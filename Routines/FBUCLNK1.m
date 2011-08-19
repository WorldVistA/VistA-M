FBUCLNK1 ;ALBISC/TET - LINK CLAIM DISPLAY
 ;;3.5;FEE BASIS;;JAN 30, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
LINK(FBDA,FBIX,FBSET) ;determine if link claims exist
 ;INPUT:  FBDA = ien of unauthoriezed claim
 ;        FBIX = xref indicating how user is looking up (APMS,AVMS,AOMS)
 ;        FBSET = (optional) 1 to set global array, 0 to not set
 ;OUTPUT: 1 if claim is linked to others, 0 if not
 ;        TMP("FBAR" global array (if 1 and flagged to set)
 I '+$G(FBDA) Q 0 S:$G(FBSET)']"" FBSET=0
 N FBCT,FBDCT,FBI,FBMC,FBZ S FBMC=+$P($$FBZ^FBUCUTL(FBDA),U,20) I 'FBMC Q 0
 S (FBDCT,FBCT,FBI)=0 F  S FBI=$O(^FB583("AMC",FBMC,FBI)) Q:'FBI!(FBCT&('FBSET))  I FBI'=FBDA S FBCT=FBCT+1 I FBSET S FBZ=$G(^FB583(FBI,0)) I FBZ]"" D
 .;set array
 .D DA^FBUCUTL5(FBI,"APMS",.FBDCT,+$P(FBZ,U,20),FBZ)
 I FBCT,FBSET D FBAR^FBUCUTL5(FBCT)
 Q $S(FBCT:1,1:0)
 ;
ENTER(FBDA,FBUCA,DISP,FBIX) ;link claim on entry
 ;called from fbucen - enter new unauth claim
 ;INPUT:  FBDA = ien of unauthorized claim
 ;        FBUCA = after node of unauthorized claim
 ;        DISP = 0 to display only, 1 to update
 ;        FBIX = cross-ref (optional)
 ;VAR:     FBTFROM-treatment from date/FBTTO-treatment to date/FBVET-veteran
 ;OUTPUT: link new claim to existing claim, if user so designates
 ;        data stored in tmp(fbar/tmp(fbary global arrays
 N FBAR,FBARY,FBCNT,FBDCT,FBI,FBLINK,FBMC,FBOUT,FBTFROM,FBTTO,FBVET,FBX,FBZ S FBDCT=0
 S:$G(FBIX)']"" FBIX="APMS" S FBTFROM=$P(FBUCA,U,5),FBTTO=$P(FBUCA,U,6),FBVET=$P(FBUCA,U,4),FBMC=+$P(FBUCA,U,20),FBX=+$O(^FB583("APF",FBVET,FBTFROM,0))
 I FBX'=FBDA S FBLINK=1,FBI=0 F  S FBI=$O(^FB583("APF",FBVET,FBTFROM,FBI)) Q:'FBI  S FBZ=$$FBZ^FBUCUTL(FBI) I $P(FBZ,U,6)=FBTTO,$$LINKTO^FBUCUTL4(FBI,FBZ,FBDA),FBI'=FBDA D DA^FBUCUTL5(FBI,FBIX,.FBDCT,FBMC,FBZ)
 D FBAR^FBUCUTL5(FBDCT)
 I DISP,+$G(FBLINK),+$G(FBAR) D ASK^FBUCLINK Q:+$G(FBOUT)  I FBLINK D SELECT^FBUCLINK(+FBAR) Q:+$G(FBOUT)  D:FBLINK UPD^FBUCLINK(FBDA,FBLINK)
 I 'DISP,+$G(FBLINK),+$G(FBAR) S FBX="< ASSOCIATED CLAIMS >" W !!?(IOM-$L(FBX)/2),FBX,! D DISPX^FBUCUTL1(0)
 K ^TMP("FBAR",$J),^TMP("FBARY",$J) Q
 ;
UNLINK(FBGROUP,FBDA,FBZ,FBRELINK) ;unlink claim from group/determine new primary claim
 ;INPUT:  FBGROUP = # in group^# of programs^1 if auth^# of u/c w/same status^# of diff dispositions
 ;        FBGROUP(ien of 162.7) = prog^auth ien^status ien^dispositon ien
 ;        FBDA = ien of unauth claim working with
 ;        FBZ = zero node of unauth claim (fbda)
 ;        FBRELINK = <optional> flag to auto relink: 1 for auto-relink
 ;OUTPUT: fbda claim is unlinked; if group and fbda primary, new primary
 ;         if another claim exists with same vet and episode of care,
 ;           the unlinked claim may be relinked to it.
 I $S('+$G(FBGROUP):1,'+$G(FBDA):1,$G(FBZ)']"":1,1:0) Q
 S FBRELINK=+$G(FBRELINK) N FBALL,FBD,FBDIRA,FBI,FBMATCH,FBO,FBOUT,FBPRIME,FBTFR,FBTTO,FBVET ;other variables
 S (FBALL,FBMATCH,FBOUT)=0
 S FBPRIME=$$PRIME^FBUCUTL4(FBDA,FBZ) D:FBPRIME PRIME(.FBGROUP,FBDA,FBZ) I 'FBPRIME D DIE^FBUCUTL2("^FB583(",FBDA,"20////^S X="_FBDA)
 S FBVET=$P(FBZ,U,4),FBTFR=$P(FBZ,U,5),FBTTO=$P(FBZ,U,6),FBD=FBTFR-.1
 F  S FBD=$O(^FB583("APF",FBVET,FBD)) Q:'FBD!(FBD>FBTFR)  S FBI=0 F  S FBI=$O(^FB583("APF",FBVET,FBD,FBI)) Q:'FBI!(FBMATCH)  I FBI'=FBDA S FBO=$G(^FB583(FBI,0)) I $P(FBO,U,6)=FBTTO,'$D(FBGROUP(FBI)) S FBMATCH=+$P(FBO,U,20)
 Q:'FBMATCH  ;nothing else to which this claim can be grouped
 I 'FBRELINK S FBDIRA="Do you want to automatically link this claim with another group" D READ^FBUCUTL7(FBDIRA,.FBOUT) Q:FBOUT!('FBALL)
 I FBALL D DIE^FBUCUTL2("^FB583(",FBDA,"20////^S X="_FBMATCH)
 Q
PRIME(FBGROUP,FBDA,FBZ) ;determine primary claim
 ;INPUT:  FBGROUP = # in group^# of programs^1 if auth^# of u/c w/same status^# of diff dispositions
 ;        FBGROUP(ien of 162.7) = prog^auth ien^status ien^dispositon ien
 ;        FBDA = ien of unauth claim
 ;        FBZ = zero node of unauth claim (fbda)
 ;OUTPUT: if primary, find new primary for other claims in group and update
 N FBPRIME,FBI,FBO
 ;determine new primary claim; reset rest in group to new primary
 S (FBI,FBPRIME)=0 F  S FBI=$O(FBGROUP(FBI)) Q:'FBI  I FBI'=FBDA S FBPRIME=FBI Q:FBPRIME
 I FBPRIME S FBI=0 F  S FBI=$O(FBGROUP(FBI)) Q:'FBI  I FBI'=FBDA S FBO=$G(^FB583(FBI,0)) D DIE^FBUCUTL2("^FB583(",FBI,"20////^S X="_FBPRIME)
 Q
