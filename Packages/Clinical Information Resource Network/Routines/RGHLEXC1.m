RGHLEXC1 ;CAIRO/DKM-Generate exception statistics report ;02-Jul-97 11:27
 ;;1.0; CLINICAL INFO RESOURCE NETWORK ;;30 Apr 99
 ;=================================================================
 D TITLE^RGRSUTL2("HL7 Message Exception Report")
 D ^%ZIS
 G:POP DONE
 U IO
 N RGZ,RGZ1,RGZ2,RGP,RGL
 S RGZ="",RGL=IOSL-5,RGP=0,$Y=999999
 K ^TMP($J)
 F  S RGZ=$O(^RGHL7(991.1,"AC",RGZ)) Q:RGZ=""  S ^TMP($J,+$G(^(RGZ)),RGZ)=""
 F  S RGZ=$O(^TMP($J,RGZ),-1),RGZ1="" Q:'RGZ  D
 .F  S RGZ1=$O(^TMP($J,RGZ,RGZ1)) Q:RGZ1=""  D
 ..D:$Y'<RGL PAUSE,TITLE^RGRSUTL2("HL7 Message Exception Report","Page "_RGP)
 ..W $J(RGZ,8),?10,RGZ1,!
 D PAUSE:$Y,^%ZISC
DONE K ^TMP($J)
 W:IO'=IO(0) @IOF
 Q
PAUSE I IO=IO(0),$Y=RGL,$$PAUSE^RGRSUTL2
 S $Y=0,RGP=RGP+1
 Q
