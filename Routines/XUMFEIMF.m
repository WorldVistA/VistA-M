XUMFEIMF ;OIFO-OAK/RAM - Edit IMF ;06/28/00
 ;;8.0;KERNEL;**217,335**;Jul 10, 1995
 ;
 ; $$PARAM^HLCS2 call supported by IA #3552
 ;
 Q
 ;
MAIN ; -- main
 ;
 D INIT,SEL1
 ;
 I $G(DIRUT) G EXIT
 I ERROR H 5 D EXIT G MAIN
 ;
EDT ;
 D PRE,EDIT,POST
 ;
 S DIR(0)="Y",DIR("B")="YES"
 S DIR("A")="Are you ready to update the Institution Master File"
 D ^DIR K DIR
 I $G(DIRUT) D  G EDT
 .W !!,"WARNING: You modified your entry without updating the IMF!"
 G:'Y EDT
 ;
SEND ;
 W !,"...send HL7 message to Master File Server..."
 S PARAM("LLNK")="XUMF IMF MFK^XUMF "_$S('TEST:"FORUM",1:"TEST")
 S PARAM("PROTOCOL")=$O(^ORD(101,"B","XUMF IMF MFN",0))
 D MAIN^XUMFP(4,IEN,0,.PARAM,.ERROR) Q:ERROR
 D MAIN^XUMFI(4,IEN,0,.PARAM,.ERROR)
 ;
 I $G(ERROR) W !,$G(ERROR),!
 I '$G(ERROR) W !,"Sent."
 ;
 H 1
 ;
 L -^DIC(4,IEN)
 ;
 D EXIT G MAIN
 ;
 Q
 ;
INIT ; -- initialize
 ;
 K ^TMP("XUMF MFS",$J),^TMP("HLS",$J),^TMP("HLA",$J),PARAM
 D CLEAN^DILF
 ;
 ;
 S (ERROR,TEST,FLAG)=0
 ;
 I $P($$PARAM^HLCS2,U,3)="T" S TEST=1
 ;
 ;
 S XUMF=1
 ;
 D LOAD^XUMF(4.1)
 ;
 Q
 ;
SEL1 ; -- select one institution
 ;
 D CHK^XUMF333
 ;
 W !
 ;
 K DIR
 S DIR(0)="F^3:7^K:'(X?3N.AN) X"
 S DIR("A")="Enter Station Number"
 D ^DIR Q:$G(DIRUT)
 ;
 S STA=Y
 ;
 S IEN=$O(^DIC(4,"D",STA,0))
 ;
 I 'IEN W "   Invalid selection!" H 2 G SEL1
 ;
 L +^DIC(4,IEN):0 I '$T D  Q
 .S ERROR="1^Another user is editing this entry."
 .W !,ERROR,!
 ;
 I 'IEN D  Q
 .S ERROR="1^Not an existing Station Number,"
 .W !,ERROR,!
 ;
 I $E($$STA^XUAF4(+$G(DUZ(2))),1,3)'=$E(STA,1,3) D  Q
 .S ERROR="1^Option may only be used to edit your facility!"
 .W !,ERROR
 .W !," to edit an inactive faciliy log on to that division"
 .W !," you must have DIVISION in your NEW PERSON multiple."
 .W !!," If Inactive facility not selectable - assign with"
 .W !," XUMGR security key."
 ;
 Q
 ;
PRE ; -- pre-udpate
 ;
 S N0=$G(^DIC(4,+IEN,0))
 S N1=$G(^DIC(4,+IEN,1))
 S N3=$G(^DIC(4,+IEN,3))
 S N4=$G(^DIC(4,+IEN,4))
 S NV=$G(^DIC(4,+IEN,7,1))
 S NP=$G(^DIC(4,+IEN,7,2))
 S N99=$G(^DIC(4,+IEN,99))
 ;
 Q
 ;
EDIT ; -- address edit
 ;
 S DIE("NO^")="BACK"
 ;
 ; edit template
 S DIE=4,DA=IEN
 S DR="[XUMF IMF EDIT]"
 D ^DIE
 ;
 ; if inactive remove parent and visn then quit
 I $P($G(^DIC(4,+IEN,99)),U,4) D  Q
 .K IENS,FDA
 .S IENS="1,"_IEN_","
 .S FDA(4.014,IENS,.01)="@"
 .D FILE^DIE("E","FDA")
 .K IENS,FDA
 .S IENS="2,"_IEN_","
 .S FDA(4.014,IENS,.01)="@"
 .D FILE^DIE("E","FDA")
 .W !
 ;
VN K DIR
 S DIR(0)="N^1:23^"
 S DIR("A")="Enter VISN Number"
 D ^DIR
 ;
 G:'Y VN
 ;
 K IENS,FDA
 S IENS="?+1,"_IEN_","
 S FDA(4.014,IENS,.01)="VISN"
 S FDA(4.014,IENS,1)="VISN "_Y
 D UPDATE^DIE("E","FDA")
 ;
PF ;
 ; parent facility
 W !,"Parent ASSOCIATION - Enter the admin PARENT for this facility"
 S DIE="^DIC(4,"_IEN_",7,"
 S DA(1)=IEN,DA=2
 S DR="1~PARENT"
 D ^DIE
 W !
 ;
 Q
 ;
POST ; -- post update
 ;
 I $P($G(^DIC(4,+IEN,0)),U,2)'=$P($G(N0),U,2) S FLAG=1 Q
 I $G(^DIC(4,+IEN,1))'=$G(N1) S FLAG=1 Q
 I $G(^DIC(4,+IEN,4))'=$G(N4) S FLAG=1 Q
 I $G(^DIC(4,+IEN,3))'=$G(N3) S FLAG=1 Q
 I $G(^DIC(4,+IEN,7,1))'=$G(NV) S FLAG=1 Q
 I $G(^DIC(4,+IEN,7,2))'=$G(NP) S FLAG=1 Q
 I $G(^DIC(4,+IEN,99))'=$G(N99) S FLAG=1 Q
 ;
 Q
 ;
EXIT ; -- clean up
 ;
 D CLEAN^DILF,KILL^XUSCLEAN
 K ^TMP("HLS",$J),^TMP("HLA",$J),^TMP("XUMF MFS",$J)
 ;
 K N0,N1,N3,N4,NV,NP,N99,XUMF,DIRUT,PARAM,DA,DR,DIE
 K DIC,DIR,X,Y,NAME,STA,FLAG,IEN,TEST,ERROR,IENS
 ;
 Q
 ;
