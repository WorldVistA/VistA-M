RAO7XX ;HISC/SS-Sending XX HL7 message to CPRS ;11/19/01  09:07
 ;;5.0;Radiology/Nuclear Medicine;**18,26,28,32,82**;Mar 16, 1998;Build 8
 ;Check if requested and registered procedures differ in:
 ;  proc, requesting physician, proc mod(s)
 ;if there are changes - send XX message and return 1, otherwise 0
 ; called from RAREG2 
EN1(RAOIFN1) ;P18  entry point for "Register exams" and "Add to last visit" options
 K RAREGMOD
 Q:'$D(^RAO(75.1,RAOIFN1,0)) 0
 Q:'$D(^RAMIS(71,$P(^RAO(75.1,RAOIFN1,0),"^",2),0)) 0
 N RAPRTYPE S RAPRTYPE=$P(^RAMIS(71,$P(^RAO(75.1,RAOIFN1,0),"^",2),0),"^",6)
 Q:RAPRTYPE="P" 0 ;quit processing if parent proc, since RAREG2 treats an order, not each descendent of an order, thus no "XX" and no Alert
 I $$ISCHNGD(RAOIFN1,1)=0 Q 0  ;no changes or no OR*3*92
CHCK N RAREGMOD S RAREGMOD="R" ;as a flag for registering mode
 I $$ORVR^RAORDU()'<3 D EN1^RAO7NEW(RAOIFN1) ;sends HL7 message
 Q 1  ;proc/reqphys/pmod was changed
 ;
 ;Can be used only for EXAMS that DO NOT contain Parent procedures
 ;ISSCHNGD Checks: Was original procedure changed? 
 ;if proc/prc mod/rqstr changed, return 1 to syncrhonize with CPRS
 ;Usage:  RAIEN751 recNo in 75.1 (like RAOIFN)
 ;if SNDALERT=1 sends alert to provider requested the order 
 ;----------------
ISCHNGD(RAIEN751,SNDALERT) ;P18
 N RACHANGE,RAX751,RAX70,RASTRING
 N RAD751 S RAD751=$G(^RAO(75.1,RAIEN751,0),-1),RASTRING=""
 Q:RAD751=-1 0
 N RAPAT S RAPAT=$P(RAD751,"^",1)
 N RAD70 S RAD70=$$FNDIN70(RAPAT,RAIEN751,"V")
 N RAD70SB S RAD70SB=$$FNDIN70(RAPAT,RAIEN751,"T")
 Q:RAD70=0 0
 N RAPR751 S RAPR751=$P(RAD751,"^",2) ;ien proc from order
 N RAPHYSID S RAPHYSID=$P(RAD751,"^",14) ;ien req phys
 S RAPR70=$P(RAD70,"^",2) ;ien proc from exam
 S RACHANGE=0
 I RAPR751'=RAPR70,(RAPRTYPE'="P") S RACHANGE=1,$P(RASTRING,"/",4,5)=RAPR751_"/"_RAPR70 ; nonparent,proc changed
 I RAPR751=RAPR70,(RAPRTYPE'="P") S $P(RASTRING,"/",4)=RAPR751 ;save unchanged proc name
 I RAPHYSID'=$P(RAD70,"^",14) S RACHANGE=1,$P(RASTRING,"/",6,7)=RAPHYSID_"/"_$P(RAD70,"^",14) ;req phy changed
 D STR751^RAUTL10(.RAX751,RAIEN751)
 D STR70^RAUTL10(.RAX70,RAPAT,$P(RAD70SB,"^"),$P(RAD70SB,"^",2))
 I RAX751'=RAX70 S RACHANGE=1,$P(RASTRING,"/",8,9)=RAX751_"/"_RAX70 ;proc mods changed
 Q:'RACHANGE 0
 S $P(RASTRING,"/",1,3)=RAPAT_"/"_$P(RAD70SB,"^")_"/"_$P(RAD70SB,"^",2) ;dfn,invdt,case ien
 S:$P(RASTRING,"/",6)="" $P(RASTRING,"/",6)=RAPHYSID ;recipient of msg
 I $G(SNDALERT,0)=1 D
 . I $$PATCH^XPDUTL("OR*3.0*112") D SETNOTIF^RAO7PC4(RAIEN751) Q
 . D SETALERT^RAO7PC4
B1P18 Q:'$$PATCH^XPDUTL("OR*3.0*92") 0  ;CPRS patch not installed yet-return zero (do not send XX message).Alert has been sent above,because it should be sent anyway
 Q 1  ;one or more changes from orig order AND OR*3*92
 ;
 ;RAPT like RADFN
 ;RADT like RADTI
 ;RACSN like RACN
 ;If RARET="V" returns string value, otherwise - $Q of the node 
 ;if failure returns "0"
FNDIN70M(RAPT,RADT,RACSN,RARET)      ;P18
 N RALV,RALFL
 S (RALV,RALFL)=0
 N RALVAR2,RAVAL2
 S RALV=$O(^RADPT(RAPT,"DT",RADT,"P","B",RACSN,0))
 Q:+RALV=0 0
 Q:RARET="V" $G(^RADPT(RAPT,"DT",RADT,"P",RALV,0),0)
 Q:RARET="T" RADT_"^"_RALV
 Q $Q(^RADPT(RAPT,"DT",RADT,"P",RALV))
 ;
 ;search for #70 entry using PATIEN and Order No from 75.1
 ;works correctly ONLY FOR ORDERS that do NOT contain PARENT PROCEDURE
 ;RETRN="V" returns value
 ;RETRN="T" returns D1^D2 of #70
 ;otherwise - $Q
FNDIN70(RAPATN,RAORDN,RETRN) ;
 N RA18A,RA18B
 S RA18A=$O(^RADPT("AO",RAORDN,RAPATN,0))
 Q:RA18A="" 0
 S RA18B=$O(^RADPT("AO",RAORDN,RAPATN,RA18A,0))
 Q:RA18B="" 0
 Q:RETRN="V" $G(^RADPT(RAPATN,"DT",RA18A,"P",RA18B,0),0)
 Q:RETRN="T" RA18A_"^"_RA18B
 Q $Q(^RADPT(RAPATN,"DT",RA18A,"P",RA18B))
 Q
 ;
 ;
UPDTRA0 ;P18 updates var RAO with data from file #70 and sets RAD70SB variable (D2^D3 of #70), called from RAO7NEW
 N RAD70
 S RAD70=0
 ;if registering mode (should not be parent procedure, so we can locate the exam in #70 by OrderN) - data and D2^D3 in #70 for the Order No 
 S:RAREGMOD="R" RAD70=$$FNDIN70(+RA0,RAOIFN,"V"),RAD70SB=$$FNDIN70(+RA0,RAOIFN,"T")
 ;editing exam had called SVBEFOR, and thus RAPRIEN()s are defined
 S:RAREGMOD="E" RAD70=$G(^RADPT(RAPRIEN(1),"DT",RAPRIEN(2),"P",RAPRIEN(3),0)),RAD70SB=RAPRIEN(2)_"^"_RAPRIEN(3) S:+RAD70SB=0 RAD70SB=0 S:+RAD70=0 RAD70=0 ;041801 convert null to 0
 ; updating info
 I RAD70=0 S $P(RA0,"^",26)="" G ORCSET ; nature of new order activity
 S:$P(^RAMIS(71,+$P(RA0,"^",2),0),"^",6)'="P" $P(RA0,"^",2)=$P(RAD70,"^",2) ;OBR(4) reset prc only if not parent typ
 S $P(RA0,"^",9)=$P(RAD70,"^",9) ;Contract/Sharing Source
 S $P(RA0,"^",14)=$P(RAD70,"^",14) ; req phys ORC(12)
ORCSET S $P(RA0,"^",15)=DUZ ;ORC(10)
 Q
 ;
MODIF70(RA18D1,RA18D2) ;P18 uses data of Modifiers from #70 for OBR(18)
 I $O(^RADPT(+RA0,"DT",RA18D1,"P",RA18D2,"M",0)) D
 . S (A,RAXIT)=0
 . F  S A=$O(^RADPT(+RA0,"DT",RA18D1,"P",RA18D2,"M",A)) Q:A'>0  D  Q:RAXIT
 .. S B(0)=$G(^RADPT(+RA0,"DT",RA18D1,"P",RA18D2,"M",A,0))
 .. S B(1)=$P($G(^RAMIS(71.2,+B(0),0)),U)
 .. I $L(RA("OBR",18))+$L(B(1))>60 S RAXIT=1 Q
 .. S RA("OBR",18)=$G(RA("OBR",18))_B(1)_RAECH(2)
 .. Q
 . S RA("OBR",18)=$P(RA("OBR",18),RAECH(2),1,$L(RA("OBR",18),RAECH(2))-1)
 . Q
 Q
SVBEFOR(RAPATN,RAINVDT,RACIEN) ;P18;send radfn,radti,racni (instead of racn and new sequencing of params
 D SVBEFOR^RAO7UTL(RAPATN,RAINVDT,RACIEN) Q
 ;Compare proc ien after editing
CMPAFTR(SNDALERT) ;P18
 K RAREGMOD
 I $D(I) N I
 I $D(J) N J
 I $D(Y) N Y
 Q:'$D(RAPRIEN) 0 ;RAPRIEN must be defined by calling SVBEFOR
 N RADATA,RACHANGE,RAX,RA0,RA1,RA2,RA3,RASTRING,RAPRTYPE
 S RASTRING=""
 S RACHANGE=0 ;=1 if changed any of : proc, proc mod, req phys
 S RADATA=$G(^RADPT(RAPRIEN(1),"DT",RAPRIEN(2),"P",RAPRIEN(3),0))
 I RADATA="" G CMPEXIT
 I $P(RADATA,"^",11)="" G CMPEXIT ;can't process unknown proc type
 S RAPRTYPE=$P($G(^RAMIS(71,+$P($G(^RAO(75.1,+$P(RADATA,"^",11),0)),"^",2),0)),"^",6)
 I RAPRTYPE="P" G CMPEXIT ; if parent-type, skip both "XX" and Alert
 ; compare procedure if it's nonparent
 I $P(RADATA,"^",11),RAPRTYPE'="P",$P(RADATA,"^",2)'=RAPRIEN S RACHANGE=1,$P(RASTRING,"/",4,5)=RAPRIEN_"/"_$P(RADATA,"^",2) ;nonparent proc--changed
 I $P(RADATA,"^",11),RAPRTYPE'="P",$P(RADATA,"^",2)=RAPRIEN S $P(RASTRING,"/",4)=RAPRIEN ;save unchanged proc name
 ; compare req phys
 I $P(RADATA,"^",14)'=RAPRIEN(4) S RACHANGE=1,$P(RASTRING,"/",6,7)=RAPRIEN(4)_"/"_$P(RADATA,"^",14) ;req phy--changed
 ; compare proc mods
 D STR70^RAUTL10(.RAX,RAPRIEN(1),RAPRIEN(2),RAPRIEN(3))
 I RAPRIEN(5)'=RAX S RACHANGE=1,$P(RASTRING,"/",8,9)=RAPRIEN(5)_"/"_RAX ;proc mods-- changed
 I 'RACHANGE G CMPEXIT
 S $P(RASTRING,"/",1,3)=RAPRIEN(1)_"/"_RAPRIEN(2)_"/"_RAPRIEN(3)
 S:$P(RASTRING,"/",6)="" $P(RASTRING,"/",6)=RAPRIEN(4)
 ; set up of vars for call to XQALERT or to ORB3
 I $G(SNDALERT,0)=1 D
 . I $$PATCH^XPDUTL("OR*3.0*112") D SETNOTIF^RAO7PC4($P(RADATA,"^",11)) Q
 . D SETALERT^RAO7PC4
B2P18 G:'$$PATCH^XPDUTL("OR*3.0*92") CMPEXIT
 ;if CPRS patch not installed-don't send any XX message.Checkpoint for all modes except registration,for registration mode see ISCHNGD.Alert has been sent above,because it should be sent anyway
 N RAREGMOD S RAREGMOD="E" ;edit mode
 I $$ORVR^RAORDU()'<3 D EN1^RAO7NEW($P(RADATA,"^",11))
CMPEXIT ;
 ;Next lines are for RA*5*82
 G:$G(RACHANGE) QQQ ;If proc, proc mod, req phys changed quit 1
 S RAX=0 ;Quit 1 if CPT modifier changed or Tech comments changed
 F  S RAX=$O(^RADPT(RAPRIEN(1),"DT",RAPRIEN(2),"P",RAPRIEN(3),"CMOD",RAX)) Q:'RAX  I $G(RAPRIEN("CMOD",RAX))'=+$G(^(RAX,0)) S RACHANGE=1 Q
 G:$G(RACHANGE) QQQ ;
 S RAX=0
 F  S RAX=$O(^RADPT(RAPRIEN(1),"DT",RAPRIEN(2),"P",RAPRIEN(3),"L",RAX)) Q:'RAX  I $G(RAPRIEN("TCOM",RAX))'=$G(^(RAX,"TCOM")) S RACHANGE=1 Q
QQQ K RAPRIEN Q RACHANGE
 ;End of RA*5*82 change
 Q  ;OK
 ;In input templates the TECH COMMENT prompt should follow 
 ;TECHNOILOGIST prompt but on the other hand it must be saved 
 ;ONLY with other Activity log fields. That is why we call TCPROMPT 
 ;from template after TECHNOLOGIST prompt and put the content of 
 ;RA18TCOM in the file 70 only in the very end of editing
TCPROMPT() ;called from input templates to immitate prompt
 N RA18A,RA18B,RA18C,DIR,Y,X,DA,DTOUT,DUOUT,DIRUT,DIROUT
 S RA18A="DESCRIPTION;HELP-PROMPT;INPUT TRANSFORM"
 D FIELD^DID(70.07,4,"",RA18A,"RA18B") ;field's parameters
 S DIR(0)="FO^3:255^"_RA18B("INPUT TRANSFORM")
 S DIR("?")=RA18B("HELP-PROMPT")
 S DIR("??")="^D DSCRP^RAO7XX"
 S DIR("A")="    TECHNOLOGIST COMMENT"
 S RA18C=$$GETTCOM^RAUTL11(RADFN,RADTI,RACNI)
 S:RA18C'="" DIR("B")=RA18C
 D ^DIR
 Q:Y=""!(Y=RA18C) ""
 Q Y
 ;
DSCRP ;get field description
 N RA18D S RA18D=0
 F  S RA18D=$O(RA18B("DESCRIPTION",RA18D)) Q:RA18D=""  W !,RA18B("DESCRIPTION",RA18D)
 Q
ZZ(RAPTID,RAPFIEN,RAPTIEN) ; Additional text for display when processing alert.
 ;
 S RAPTID=$G(RAPTID)   ; IEN of Patient
 S RAPFIEN=$G(RAPFIEN) ; IEN of Procedure changed FROM
 S RAPTIEN=$G(RAPTIEN) ; IEN of Procedure changed TO
 ;
 N RAPNAM,RAPSSN,RAPRFR,RAPRTO
 ;
 S RAPNAM=$$GET1^DIQ(70,+RAPTID,.01) S:RAPNAM="" RAPNAM="UNKNOWN"
 S RAPSSN=$$GET1^DIQ(70,+RAPTID,.09) S:RAPSSN="" RAPSSN="UNKNOWN"
 S RAPRFR=$$GET1^DIQ(71,+RAPFIEN,.01) S:RAPRFR="" RAPRFR="UNKNOWN"
 S RAPRTO=$$GET1^DIQ(71,+RAPTIEN,.01) S:RAPRTO="" RAPRTO="UNKNOWN"
 ;
 D EN^DDIOL("Imaging Exam For "_$E(RAPNAM,1,30)_" ("_RAPSSN_") Changed:",,"!!?4")
 D EN^DDIOL("From: "_RAPRFR,,"!?8")
 D EN^DDIOL("To:   "_RAPRTO,,"!?8")
 Q
 ;
