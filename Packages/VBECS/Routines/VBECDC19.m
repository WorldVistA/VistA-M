VBECDC19 ;hoifo/gjc-utilities for VistA Blood Bank options (#19);Nov 21, 2002
 ;;5.2;LAB SERVICE;**335**;Sep 27, 1994;Build 5
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
EN(VBECFLG) ;
 ;input: VBECFLG=1 set options 'out-of-order', else place options
 ;       in order.
 ;
 ; call to OUT^XPDMENU(OPT,TXT) supported by IA: 1157
 ;
 ; Need to check if this option is independently invoked, or executed
 ; during the data conversion process.  If independent, ask the user for
 ; his/her real intentions.  VBECECHO is set in the Entry/Exit Action
 ; fields in the option file for options: VBEC BB COMPONENTS ENABLE &
 ; VBEC BB COMPONENTS DISABLE
 ;
 I $D(VBECECHO)#2 D
 .S X=$S(VBECFLG=1:"dis",1:"en")_"able"
 .S DIR(0)="Y",DIR("A",1)=" ",DIR("A",2)="Are you sure you want to "_X_" specific VistA Blood Bank option, files,",DIR("A")="and fields"
 .S DIR("B")="No",DIR("?")="Enter 'Yes' to "_X_" selected components, or 'No' to exit without taking action." D ^DIR
 .S:$D(DIRUT) VBECYN=0
 .S:'$D(DIRUT) VBECYN=+Y ;1 for yes, 0 for no
 .K DIR,DIROUT,DIRUT,DTOUT,DUOUT,VBECACTN,X,Y
 .Q
 I $G(VBECYN)=0 K VBECYN Q
 I VBECFLG,$P($G(^VBEC(6009,65.5,0)),"^",3)="Y" W:$D(VBECECHO)#2 !,"Options, files, and fields have already been disabled." Q  ;RLM 10/31/05
 ;
 S VBECMSG="finished setting specific VistA Blood Bank options "_$S(VBECFLG=1:"'Out-of-Order'",1:"'In Order'")_"."
 S I=0 F  S I=$O(^VBEC(6003,I)) Q:'I  D
 .S OPT=$P($G(^VBEC(6003,I,0)),U)
 .Q:OPT="LRBLAD"!(OPT="LRBLPC")!(OPT="LRBLSI")
 .S TXT=$S(VBECFLG=1:"out-of-order",1:"@")
 .D OUT^XPDMENU(OPT,TXT)
 .Q
 D BMES^XPDUTL(VBECMSG)
 K I,OPT,TXT,VBECMSG
 D EN1(VBECFLG) ; set file level and field level access
 Q
 ;
EN1(VBECFLG) ;
 ;input: VBECFLG=1 disable sub-file data dictionary (write access)
 ;       or set the file restriction node ^DD(file#,0,"DI")
 ;
 ;       VBECFLG=0 enable sub-file data dictionary nodes (write access)
 ;                 or kill the file restriction node ^DD(file#,0,"DI")
 ;
 ; Note: this routine called from VBECDC19
 ;
 ; Note: Using Integration Agreement# 3805 to set and kill the
 ; ^DD(file#,0,"DI") node.
 ;
 ;
 I VBECFLG,$P($G(^VBEC(6009,65.5,0)),"^",3)="Y" W:$D(VBECECHO)#2 !,"Options, files, and fields have already been disabled." Q  ;RLM 10/31/05
 N VBECIEN S GG=0,U="^",VBECMSG="Finished "_$S(VBECFLG=1:"dis",1:"en")_"abling specific VistA Blood Bank components."
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
 ...S VBECIEN(1)=GG,VBECIEN=HH,VBECIENS=$$IENS^DILF(.VBECIEN)
 ...I VBECFLG=1 D
 ....;
 ....; 1) obtain sub-file and field information
 ....; 2) set pre-conv. field write access to pre-conv. value
 ....; 3) set pst-conv. field write access to pst-conv. value
 ....; 4) hardset write node access
 ....; 5) file data tracking pre/post conversion field level values
 ....;
 ....S VBECNODE=$G(^VBEC(6009,GG,"DD",HH,0))
 ....S VBECFLD=$P(VBECNODE,U,2),VBECFLE=$P(VBECNODE,U) ;(1)
 ....S VBECB4=$G(^DD(VBECFLE,VBECFLD,9))
 ....S:VBECB4]"" VBECFDA(6009.01,VBECIENS,1)=VBECB4 ;(2)
 ....S VBECFDA(6009.01,VBECIENS,2)="^" ;(3)
 ....S ^DD(VBECFLE,VBECFLD,9)="^" ;(4)
 ....D FILE^DIE("","VBECFDA") ;(5)
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
 ....S VBECNODE=$G(^VBEC(6009,GG,"DD",HH,0))
 ....S VBECFLD=$P(VBECNODE,U,2),VBECFLE=$P(VBECNODE,U) ;(1)
 ....S VBECB4=$G(^VBEC(6009,GG,"DD",HH,"PREW"))
 ....S:VBECB4="" VBECFDA(6009.01,VBECIENS,1)="@" ;(2A)
 ....S:VBECB4]"" VBECFDA(6009.01,VBECIENS,1)=VBECB4 ;(2B)
 ....S:VBECB4]"" ^DD(VBECFLE,VBECFLD,9)=VBECB4 ;(3)
 ....K:VBECB4="" ^DD(VBECFLE,VBECFLD,9) ;(4)
 ....S VBECFDA(6009.01,VBECIENS,2)="@" ;(5)
 ....D FILE^DIE("","VBECFDA") ;(6)
 ....Q
 ...K VBECB4,VBECFDA,VBECFLD,VBECFLE,VBECIENS,VBECNODE
 ...Q
 ..K HH
 ..Q
 .;
 .; whole file restriction check
 .;
 .I VBECFLG=1 D
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
 ..Q:$D(^VBEC(6009,GG,"DD"))  ;RLM 10/31/05
 ..S VBECB4=$P($G(^DD(GG,0,"DI")),U,2) ;(1)
 ..S:VBECB4]"" VBECFDA(6009,GG_",",.02)=VBECB4 ;(1A)
 ..S $P(^DD(GG,0,"DI"),U,2)="Y" ;(2)
 ..S VBECFDA(6009,GG_",",.03)="Y" ;(3)
 ..D FILE^DIE("","VBECFDA") ;(4)
 ..Q
 .E  D
 ..;
 ..; Enabling file access, or lifting the file restriction
 ..; 1) find the file restriction value before the data conversion
 ..;    (no file level restrictions are expected on these files prior
 ..;    to the data conversion).
 ..; 2) restore the data dictionary to its pre-conversion state (if
 ..;    ^DD(GG,0,"DI") didn't exist prior to the conversion, it will
 ..;    after the restore. The key fact is that the first & second
 ..;    pieces of the "DI" node will be null)
 ..; 3) if file restriction exists, track in the pre-conv. value field
 ..; 4) update the pre-conversion restriction tracking field to null
 ..; 5) update the post-conversion restriction tracking field to null
 ..; 6) file the data into the file
 ..;
 ..S VBECB4=$P(^VBEC(6009,GG,0),U,2) ;(1)
 ..S $P(^DD(GG,0,"DI"),U,2)=VBECB4 ;(2)
 ..S:VBECB4="" VBECFDA(6009,GG_",",.02)="@" ;(3)
 ..S:VBECB4]"" VBECFDA(6009,GG_",",.02)=VBECB4 ;(4)
 ..S VBECFDA(6009,GG_",",.03)="@" ;(5)
 ..D FILE^DIE("","VBECFDA") ;(6)
 ..Q
 .K VBECB4,VBECFDA
 .Q
 D BMES^XPDUTL(VBECMSG)
 K GG,VBECMSG
 Q
 ;
