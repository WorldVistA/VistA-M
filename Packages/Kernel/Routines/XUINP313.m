XUINP313 ;ISF/RWF - Post-init for patch XU*8*313 ;07/14/2003  14:41
 ;;8.0;KERNEL;**313**;Jul 10, 1995
 ;
POST ;Run Terminate event for users after 6/10/2003
 N Y,DATE,DT
 S Y=$G(XPDQUES("POS001")) Q:Y'=1
 S DT=$$DT^XLFDT
 S DATE=$G(XPDQUES("POS002")) Q:DATE'>3030101
 D PROC
 Q
 ;
TEST ;Test Terminate event
 N Y,DIR,DUOUT,DTOUT,DATE
 S DIR(0)="Y",DIR("A")="Run Terminate events",DIR("B")="NO"
 S DIR("A",1)="If you installed patch XU*8*290 you should answer Yes"
 S DIR("A",2)="(If you installed XU*8*313 V3, this has already been done)"
 S DIR("A",3)=""
 S DIR("A",4)="A Yes answer will cause all users Terminated after a date you"
 S DIR("A",5)="choose to have the XU USER TERMINATE protocol run on them."
 D ^DIR
 Q:Y'=1
 K DIR
 S DIR(0)="D^3030101:3030701"
 S DIR("A")="Date of patch XU*8*290 install",DIR("B")="06/10/2003"
 D ^DIR
 S DATE=Y Q:DATE'>3030101
 S DT=$$DT^XLFDT
 D PROC
 Q
 ;
PROC ;Process
 N XUDA,XUIEN,XUIFN,D
 S XUDA=.5
 F  S XUDA=$O(^VA(200,XUDA)) Q:XUDA'>0  S X=$G(^VA(200,XUDA,0)),D=$P(X,"^",11) I D>DATE,D<DT D
 . D DEQUE^XUSERP(XUDA,3)
 . Q
 Q
 ;
LK(X) ;Lookup Option Name
 Q $O(^DIC(19,"B",X,0))
 ;
PRETEST ;Test the pre-init
 N DIR
 S DIR(0)="Y",DIR("A")="Add national items to the XU USER TERMINATE option",DIR("B")="Yes"
 D ^DIR Q:Y'=1
 S XPDQUES("PRE001")=Y
 D PRE
 Q
PRE ;Check if OK for pre-init to add national items back
 N OPT,I,X,LIST,MENU,MSG
 Q:'$G(XPDQUES("PRE001"))  ;Check Pre-init answer
 S LIST="USR USER TERMINATE^GMRC TERMINATE CLEANUP^OR TERMINATE CLEANUP^PRCS TERMINATE^TIU TEMPLATE USER DELETE"
 S MENU=$$LK("XU USER TERMINATE")
 F I=1:1:5 S OPT=$P(LIST,"^",I) S MSG=OPT D  D MES^XPDUTL(MSG)
 . S X=$$LK(OPT) I X'>0 S MSG=MSG_" not on system" Q
 . I $D(^DIC(19,MENU,10,"B",X)) S MSG=MSG_" already on menu." Q
 . S X=$$ADD("XU USER TERMINATE",OPT) S MSG=MSG_"  "_$S(X>0:"",1:"NOT ")_"Added"
 Q
 ;
ADD(MENU,OPT,SYN,ORD) ;EF. Add options to a menu
 Q:$G(MENU)']"" 0 Q:$G(OPT)']"" 0
 N X,XPD1,XPD2,XPD3,DIC,DA,D0,DR,DLAYGO
 S XPD1=$$LK(MENU) Q:XPD1'>0 -1
 ;quit if type is not extended action
 I $$TYPE(XPD1)'["X" Q -2
 S XPD2=$$LK(OPT) Q:XPD2'>0 -3
 ;if OPTion is not in menu, add it
 I '$D(^DIC(19,XPD1,10,"B",XPD2)) D
 .S X=XPD2,(D0,DA(1))=XPD1,DIC(0)="MLF",DIC("P")=$P(^DD(19,10,0),"^",2),DLAYGO=19,DIC="^DIC(19,"_XPD1_",10,"
 .D FILE^DICN
 S XPD3=$O(^DIC(19,XPD1,10,"B",XPD2,0))
 Q XPD3>0
 ;
TYPE(X) ;EF. Return option type, Pass IFN.
 Q:X'>0 "" Q $P($G(^DIC(19,X,0)),"^",4)
