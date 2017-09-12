LR408 ;hoifo/rlm-Disable VistA Blood Bank options ;Nov 21, 2002
 ;;5.2;LAB SERVICE;**408**;Sep 27, 1994;Build 8
 ;
 ;Medical Device #:
 ;Note: The food and Drug Administration classifies this software as a
 ;medical device.  As such, it may not be changed in any way.
 ;Modifications to this software may result in an adulterated medical
 ;device under 21CFR820, the use of which is considered to be a
 ;violation of US Federal Statutes.  Acquiring and implementing this
 ;software through the Freedom of Information Act requires the
 ;implementer to assume total responsibility for the software, and
 ;become a registered manufacturer of a medical device, subject to FDA
 ;regulations.
 ;
 ;Call to FILE^DIE is supported by IA: 2053
 ;Call to $$IENS^DILF is supported by IA: 2054
 ;Call to ^DIR is supported by IA: 10026
 ;Call to OUT^XPDMENU is supported by IA: 1157
 ;Call to BMES^XPDUTL is supported by IA: 10141
 ;Setting the "DI" node in the data dictionary supported by IA: 3805
 ;Setting the 'write access' (9) node in the Agglutination Strength File
 ; (62.55) data dictionary is supported by IA: 4468
 ;Setting the 'write access' (9) node in the Lab Data (63) file data
 ; dictionary is supported by IA: 4469
 ;
EN ;
 I $P($G(^VBEC(6009,65.5,0)),"^",3)="Y" S LRVBTXT="Options, files, and fields have already been disabled at "_$P($$SITE^VASITE,"^",2) G MSG
 S LRVBFLG=1,LRVBTXT="Options, files, and fields have been disabled at "_$P($$SITE^VASITE,"^",2)
 S I=0 F  S I=$O(^VBEC(6003,I)) Q:'I  D
 .S OPT=$P($G(^VBEC(6003,I,0)),U)
 .Q:OPT="LRBLAD"!(OPT="LRBLPC")!(OPT="LRBLSI")
 .S TXT=$S(LRVBFLG=1:"out-of-order",1:"@")
 .D OUT^XPDMENU(OPT,TXT)
 .Q
 K I,OPT,TXT
 ; Note: Using Integration Agreement# 3805 to set and kill the
 ; ^DD(file#,0,"DI") node.
 ;
 ;
 S GG=0,U="^"  W !,"Finished disabling specific VistA Blood Bank components."
 F  S GG=$O(^VBEC(6009,GG)) Q:'GG  D
 .;
 .; need to check if only whole file restrictions apply, or if a
 .; sub-file/field levels are involved
 .;
 .I +$O(^VBEC(6009,GG,"DD",0)) D
 ..;
 ..; sub-file/field levels exist
 ..;
 ..S HH=0 F  S HH=$O(^VBEC(6009,GG,"DD",HH)) Q:'HH  D
 ...S LRVBIEN(1)=GG,LRVBIEN=HH,LRVBIENS=$$IENS^DILF(.LRVBIEN)
 ...I LRVBFLG=1 D
 ....;
 ....; 1) obtain sub-file and field information
 ....; 2) set pre-conv. field write access to pre-conv. value
 ....; 3) set pst-conv. field write access to pst-conv. value
 ....; 4) hardset write node access
 ....; 5) file data tracking pre/post conversion field level values
 ....;
 ....S LRVBNODE=$G(^VBEC(6009,GG,"DD",HH,0))
 ....S LRVBFLD=$P(LRVBNODE,U,2),LRVBFLE=$P(LRVBNODE,U) ;(1)
 ....S LRVBB4=$G(^DD(LRVBFLE,LRVBFLD,9))
 ....S:LRVBB4]"" LRVBFDA(6009.01,LRVBIENS,1)=LRVBB4 ;(2)
 ....S VBECFDA(6009.01,LRVBIENS,2)="^" ;(3)
 ....S ^DD(LRVBFLE,LRVBFLD,9)="^" ;(4)
 ....D FILE^DIE("","LRVBFDA") ;(5)
 ....Q
 ...E  D
 ....;
 ....; 1) obtain sub-file and field information
 ....; 2) set pre-conv. field to pre-conv. write access value
 ....;    2A) if pre-conv value was null delete data in the field
 ....;    2B) if pre-conv value was not null restore the field to
 ....;        the pre-conv value of the field
 ....; 3) set write access node to pre-conv. value (if any)
 ....; 4) kill write access data dictionary node if no pre-conv. value
 ....; 5) set pst-conv write access field to null
 ....; 6) file data tracking pre-conversion field level values
 ....;
 ....S LRVBNODE=$G(^VBEC(6009,GG,"DD",HH,0))
 ....S LRVBFLD=$P(LRVBNODE,U,2),LRVBFLE=$P(LRVBNODE,U) ;(1)
 ....S LRVBB4=$G(^VBEC(6009,GG,"DD",HH,"PREW"))
 ....S:LRVBB4="" LRVBFDA(6009.01,LRVBIENS,1)="@" ;(2A)
 ....S:LRVBB4]"" LRVBFDA(6009.01,LRVBIENS,1)=LRVBB4 ;(2B)
 ....S:LRVBB4]"" ^DD(LRVBFLE,LRVBFLD,9)=LRVBB4 ;(3)
 ....K:LRVBB4="" ^DD(LRVBFLE,LRVBFLD,9) ;(4)
 ....S LRVBFDA(6009.01,LRVBIENS,2)="@" ;(5)
 ....D FILE^DIE("","LRVBFDA") ;(6)
 ....Q
 ...K LRVBB4,LRVBFDA,LRVBFLD,LRVBFLE,LRVBIENS,LRVBNODE
 ...Q
 ..K HH
 ..Q
 .;
 .; whole file restriction check
 .;
 .D
 ..;
 ..; Disabling file access, or imposing file restrictions
 ..; 1) find the file restriction value before the data conversion
 ..;    (no pre-data conversion file level restrictions anticipated)
 ..;       1A) if pre-conv value was not null set the field to the
 ..;           pre-conv value of the field
 ..; 2) hard set the 2nd piece of ^DD(File#,0,"DI") to "Y"
 ..; 3) Set pst-conversion file restriction value,'Y' into the correct
 ..;    field (#.03)
 ..; 4) file the data.
 ..;
 ..Q:$D(^VBEC(6009,GG,"DD"))
 ..S LRVBB4=$P($G(^DD(GG,0,"DI")),U,2) ;(1)
 ..S:LRVBB4]"" LRVBFDA(6009,GG_",",.02)=LRVBB4 ;(1A)
 ..S $P(^DD(GG,0,"DI"),U,2)="Y" ;(2)
 ..S LRVBFDA(6009,GG_",",.03)="Y" ;(3)
 ..D FILE^DIE("","LRVBFDA") ;(4)
 ..Q
 .K LRVBB4,LRVBFDA
 .Q
 K GG,LRVBMSG
MSG ;Send a message showing success.
 K ^TMP("VBEC",$J)
 s ^TMP("VBEC",$J,1,0)=LRVBTXT
 s XMSUB="LR*5.2*408 Patch Installation verification",XMTEXT="^TMP(""VBEC"",$J)",XMDUN="Vista BB Patch Monitor"
 s XMY("G.VBEC@DOMAIN.EXT")=""
 d SENDMSG^XMXAPI(DUZ,XMSUB,XMTEXT,.XMY)
 k ^TMP("VBEC",$J),XMY
 q  ;
ZEOR ;LR408
