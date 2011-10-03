RAO7PC4 ;HISC/SWM-utilities ;11/19/01  10:23
 ;;5.0;Radiology/Nuclear Medicine;**28,32,31,45,77**;Mar 16, 1998;Build 7
 ;08/10/2006 BAY/KAM Remedy Call 134839 Subscript Error
 Q
EN1 ; api for CPRS notification alert #67
 Q:'$D(XQADATA)
 D SET1 ;  set up ^TMP nodes
 D DISP1 ; convert and display ^TMP nodes
 D KIL1 ;  kill ^TMP nodes
 Q
SET1 N RADFN,RADTI,RACNI,RAPROC1,RAPROC2,RAPHY1,RAPHY2,RAPMOD1,RAPMOD2,RAACNT
 N RAPATNAM,RASSN,RASTR,I,J,RACMU
 ; 08/10/2006 BAY/KAM Remedy Call 134839/RA*5*77 - Added next line
 Q:$G(XQADATA)=""
 S RADFN=$P(XQADATA,"/") ; ien patient
 S RAACNT=0 ; counter
 S RADTI=$P(XQADATA,"/",2) ; inverse date of exam
 S RACNI=$P(XQADATA,"/",3) ; ien case
 S RAPROC1=$P(XQADATA,"/",4) ; ien 71, before
 S RAPROC2=$P(XQADATA,"/",5) ; ien 71, after
 S RAPHY1=$P(XQADATA,"/",6) ; ien 200 requesting physician, before
 S RAPHY2=$P(XQADATA,"/",7) ; ien 200 requesting physician, after
 S RAPMOD1=$P(XQADATA,"/",8) ;string of proc mod iens, before
 S RAPMOD2=$P(XQADATA,"/",9) ;string of proc mod iens, after
 K ^TMP($J,"RAE4")
 Q:'$D(^DPT(RADFN,0))
 S RAPATNAM=$P(^DPT(RADFN,0),"^") S RASSN=$$SSN^RAUTL() S:RASSN="" RASSN="Unkn"
 S RACMU=$S(+$O(^RADPT(RADFN,"DT",RADTI,"P",RACNI,"CM",0))>0:" (CM w/exam)",1:"")
 S ^TMP($J,"RAE4",1)="Imaging Exam for "_RAPATNAM_" ("_RASSN_") changed:"
 I 'RAPROC2,RAPROC1 D
 .S ^TMP($J,"RAE4",$$INCR^RAUTL4(RAACNT))=" "
 .S ^TMP($J,"RAE4",$$INCR^RAUTL4(RAACNT))="For procedure "_$E($P(^RAMIS(71,RAPROC1,0),"^"),1,53)_RACMU
 .S ^TMP($J,"RAE4",$$INCR^RAUTL4(RAACNT))=" "
 I RAPROC2 D
 .S ^TMP($J,"RAE4",$$INCR^RAUTL4(RAACNT))=" Procedure changed"
 .S ^TMP($J,"RAE4",$$INCR^RAUTL4(RAACNT))="  From: "_$E($P(^RAMIS(71,RAPROC1,0),"^"),1,53)
 .S ^TMP($J,"RAE4",$$INCR^RAUTL4(RAACNT))="  To:   "_$E($P(^RAMIS(71,RAPROC2,0),"^"),1,53)_RACMU
 .S ^TMP($J,"RAE4",$$INCR^RAUTL4(RAACNT))=""
 I RAPHY2 D
 .S ^TMP($J,"RAE4",$$INCR^RAUTL4(RAACNT))=" Requesting Physician changed"
 .S ^TMP($J,"RAE4",$$INCR^RAUTL4(RAACNT))="  From: "_$$GET1^DIQ(200,RAPHY1,.01)
 .S ^TMP($J,"RAE4",$$INCR^RAUTL4(RAACNT))="  To:   "_$$GET1^DIQ(200,RAPHY2,.01)
 I RAPMOD2!(('RAPMOD2)&(RAPMOD1)) D
 .S ^TMP($J,"RAE4",$$INCR^RAUTL4(RAACNT))=" Procedure Modifier changed"
 .S RASTR=""
 .F I=1:1:($L(RAPMOD1)/2) S J=$P(RAPMOD1,",",I) Q:J=""  S RASTR=RASTR_$$GET1^DIQ(71.2,J,.01)_", " Q:$L(RASTR)>240
 .S RASTR=$E(RASTR,1,$L(RASTR)-2) ;rid trailing comma and blank
 .S ^TMP($J,"RAE4",$$INCR^RAUTL4(RAACNT))="  From: "_RASTR
 .S RASTR=""
 .F I=1:1:($L(RAPMOD2)/2) S J=$P(RAPMOD2,",",I) Q:J=""  S RASTR=RASTR_$$GET1^DIQ(71.2,J,.01)_", " Q:$L(RASTR)>240
 .S RASTR=$E(RASTR,1,$L(RASTR)-2) ;rid trailing comma
 .S ^TMP($J,"RAE4",$$INCR^RAUTL4(RAACNT))="  To:   "_RASTR
 Q
DISP1 N RARRAY
 MERGE RARRAY=^TMP($J,"RAE4")
 D EN^DDIOL(.RARRAY)
 Q
KIL1 K ^TMP($J,"RAE4")
 Q
 ;
SETALERT ;
 Q:'$D(RASTRING)
 N RAPHY1,RAPHY2,RAPNAM,RAPSSN
 S RADFN=$P(RASTRING,"/") ; ien patient
 S RAPNAM=$$GET1^DIQ(70,+RADFN,.01) S:RAPNAM="" RAPNAM="UNKNOWN"
 S RAPSSN=$$GET1^DIQ(70,+RADFN,.09) S:RAPSSN="" RAPSSN="UNKNOWN"
 S RAPHY1=$P(RASTRING,"/",6) ; ien 200 requesting physician, before
 S RAPHY2=$P(RASTRING,"/",7) ; ien 200 requesting physician, after
 ;
 S XQA(RAPHY1)="",XQAID=$J_","_$H S:$G(RAPHY2)]"" XQA(RAPHY2)=""
 S XQAMSG=$E(RAPNAM,1,9)_" ("_$E(RAPNAM,1)_$E(RAPSSN,6,9)_"): Imaging Exam Changed: "_$S($P(RASTRING,"/",5):"Proc., ",1:"")_$S($P(RASTRING,"/",7):"Rqstr, ",1:"")_$S($P(RASTRING,"/",9):"Proc Mod",1:"")
 S:$E(XQAMSG,($L(XQAMSG)-1))="," XQAMSG=$E(XQAMSG,1,($L(XQAMSG)-2))
 S XQADATA=RASTRING
 S XQAROU="ZZ^RAO7PC4(XQADATA)"
 D SETUP^XQALERT
 Q
 ;
ZZ(RASTRING) ; Additional text for display when processing alert.
 ;
 N RADFN,RADTI,RACMU,RACNI,RAPROC1,RAPROC2,RAPHY1,RAPHY2,RAPMOD1,RAPMOD2
 N RAPNAM,RAPSSN,I,RAPRFR,RAPRTO,RAPHYFR,RAPHYTO,RASTR
 S RADFN=$P(RASTRING,"/") ; ien patient
 S RADTI=$P(RASTRING,"/",2) ; inverse date of exam
 S RACNI=$P(RASTRING,"/",3) ; ien case
 S RAPROC1=$P(RASTRING,"/",4) ; ien 71, before
 S RAPROC2=$P(RASTRING,"/",5) ; ien 71, after
 S RAPHY1=$P(RASTRING,"/",6) ; ien 200 requesting physician, before
 S RAPHY2=$P(RASTRING,"/",7) ; ien 200 requesting physician, after
 S RAPMOD1=$P(RASTRING,"/",8) ;string of proc mod iens, before
 S RAPMOD2=$P(RASTRING,"/",9) ;string of proc mod iens, after
 ;
 S RAPNAM=$$GET1^DIQ(70,+RADFN,.01) S:RAPNAM="" RAPNAM="UNKNOWN"
 S RAPSSN=$$GET1^DIQ(70,+RADFN,.09) S:RAPSSN="" RAPSSN="UNKNOWN"
 D EN^DDIOL("Imaging Exam For "_$E(RAPNAM,1,30)_" ("_RAPSSN_") Changed:",,"!!?4")
 ;
 S RACMU=$S(+$O(^RADPT(RADFN,"DT",RADTI,"P",RACNI,"CM",0))>0:" (CM w/exam)",1:"")
 I 'RAPROC2,RAPROC1 D
 .S RAPRFR=$E($$GET1^DIQ(71,+RAPROC1,.01),1,50) S:RAPRFR="" RAPRFR="UNKNOWN"
 .S RAPRFR=RAPRFR_RACMU D EN^DDIOL("For procedure "_RAPRFR_RACMU,,"!?4")
 .D EN^DDIOL(" ",,"!")
 .Q
 I RAPROC2 D
 .S RAPRFR=$E($$GET1^DIQ(71,+RAPROC1,.01),1,53) S:RAPRFR="" RAPRFR="UNKNOWN"
 .S RAPRTO=$E($$GET1^DIQ(71,+RAPROC2,.01),1,53) S:RAPRTO="" RAPRTO="UNKNOWN"
 .D EN^DDIOL("Procedure changed",,"!?4")
 .D EN^DDIOL("From: "_RAPRFR,,"!?8")
 .D EN^DDIOL("To:   "_RAPRTO_RACMU,,"!?8")
 .Q
 I RAPHY2 D
 .S RAPHYFR=$$GET1^DIQ(200,RAPHY1,.01) S:RAPHYFR="" RAPHYFR="UNKNOWN"
 .S RAPHYTO=$$GET1^DIQ(200,RAPHY2,.01) S:RAPHYTO="" RAPHYTO="UNKNOWN"
 .D EN^DDIOL("Requesting Physician changed",,"!?4")
 .D EN^DDIOL("From: "_RAPHYFR,,"!?8")
 .D EN^DDIOL("To:   "_RAPHYTO,,"!?8")
 .Q
 I RAPMOD2!('(RAPMOD2)&(RAPMOD1)) D
 .D EN^DDIOL("Procedure Modifier changed",,"!?4")
 .S RASTR=""
 .F I=1:1:($L(RAPMOD1)/2) S J=$P(RAPMOD1,",",I) Q:J=""  S RASTR=RASTR_$$GET1^DIQ(71.2,J,.01)_", " Q:$L(RASTR)>240
 .S RASTR=$E(RASTR,1,$L(RASTR)-2) ;rid trailing comma
 .D EN^DDIOL("From: "_RASTR,,"!?8")
 .S RASTR=""
 .F I=1:1:($L(RAPMOD2)/2) S J=$P(RAPMOD2,",",I) Q:J=""  S RASTR=RASTR_$$GET1^DIQ(71.2,J,.01)_", " Q:$L(RASTR)>240
 .S RASTR=$E(RASTR,1,$L(RASTR)-2) ;rid trailing comma
 .D EN^DDIOL("To:   "_RASTR,,"!?8")
 .Q
 Q
 ;
SETNOTIF(RAIEN751) ; called by RAO7XX if patch OR*3.0*112 is installed
 ;so that the CPRS notification system can be used to set the alert
 Q:'$D(RASTRING)
 ;RASTRING is : dfn^invdt^caseien^befproc^aftproc^befphy^aftphy
 ;              ^befpmodA,pmodF,etc^aftpmodF,pmodH,etc
 N RAREQPHY
 S:+$P(RASTRING,"/",6) RAREQPHY(+$P(RASTRING,"/",6))=""
 S:+$P(RASTRING,"/",7) RAREQPHY(+$P(RASTRING,"/",7))=""
 S RAMSG="Imaging Exam Changed: "_$S($P(RASTRING,"/",5):"Proc., ",1:"")_$S($P(RASTRING,"/",7):"Rqstr, ",1:"")_$S($L($P(RASTRING,"/",8,9))>1:"Proc Mod",1:"")
 S:$E(RAMSG,$L(RAMSG)-1)="," RAMSG=$E(RAMSG,1,($L(RAMSG)-2))
 D EN^ORB3(67,+RASTRING,RAIEN751,.RAREQPHY,RAMSG,RASTRING)
 ;ORN mustbe 67,dfn,ienfile75.1,reqphys,messagetitle,string for api
 Q
