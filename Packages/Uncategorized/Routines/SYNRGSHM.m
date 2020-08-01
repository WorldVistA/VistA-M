SYNRGSHM ;ven/gpl - RGNET SHIM ;2019-10-24  3:02 PM
 ;;0.1;VISTA FHIR SERVER;;Aug 17, 2018;Build 46
 ;
 ; (c) George P. Lilly 2019
 ;
 ; Licensed under the Apache License, Version 2.0 (the "License");
 ; you may not use this file except in compliance with the License.
 ; You may obtain a copy of the License at
 ; 
 ; http://www.apache.org/licenses/LICENSE-2.0
 ; 
 ; Unless required by applicable law or agreed to in writing, software
 ; distributed under the License is distributed on an "AS IS" BASIS,
 ; WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 ; See the License for the specific language governing permissions and
 ; limitations under the License.
 ;
 q
 ;
 ;DETECT(ROUTINE,ARGS,AUTHMODE) ; _rewrite_dhp exit for DHP RGNET SERVICES
DETECT ; _rewrite_dhp exit for DHP RGNET SERVICES
 ; called from VPRJRSP or from %webrsp to detect RGNET URLs for DHP
 ; If RGNET is on the system for mapping...
 IF ROUTINE="" IF $D(^RGNET(996.52)) DO MATCHRG(.ROUTINE,.ARGS,.AUTHNODE)
 ;
 Q
 ;
MATCHRG(ROUTINE,ARGS,AUTHNODE) ; match agains RGNET
 N PATH
 S PATH=$G(HTTPREQ("path"))
 S PATH=$E(PATH,2,$L(PATH))
 Q:PATH=""
 N SYNENTRY
 S SYNENTRY=$O(^RGNET(996.52,"B",PATH,""))
 ;D ^ZTER
 Q:SYNENTRY=""
 Q:$E(PATH,1,3)'="DHP"
 ; D ^ZTER
 S ARGS("command")=PATH
 S ROUTINE="WSRGNET^SYNRGSHM"
 Q
 ;
WSRGNET(RTN,FILTER) ; web service shim for RGNET web services
 N CMD
 S CMD=$G(FILTER("command"))
 Q:CMD=""
 N RGPROC ; RGNET processing routine
 S RGPROC=$$GETRGR(CMD)
 N RGPARM ; RGNET processor parms
 D DHPPARMS("RGPARM",RGPROC)
 ;
 ; initialize parms to null
 ;
 N ZI S ZI=""
 F  S ZI=$O(RGPARM(ZI)) Q:ZI=""  D  ;
 . S @ZI=""
 ;
 ; overwrite with provided parms
 ;
 F  S ZI=$O(FILTER(ZI)) Q:ZI=""  D  ;
 . N X,Y
 . S X=ZI
 . X ^%ZOSF("UPPERCASE")
 . Q:Y=""
 . S Y=$TR(Y,"-_")
 . S @Y=$G(FILTER(ZI))
 ;D ^ZTER
 ;
 ; run the processor
 ;
 ;W !,"running ",RGPROC
 Q:+RGPROC=-1
 X RGPROC
 ;ZWR RETSTA
 ;
 ;M RTN=RETSTA
 S RTN=$G(RETSTA)
 ;
 Q
 ;
GETRGR(SVC) ; extrinsic returns the routine associated with the
 ; the RGNET web service SVC
 ; returns -1 if not found
 N SYNRTN S SYNRTN=-1
 N SYNENTRY,SVCMINUS
 Q:$L(SVC)=0 "-1^COMMAND NOT SPECIFIED"
 S SYNENTRY=$E(SVC,1,$L(SVC)-1)
 F  S SYNENTRY=$O(^RGNET(996.52,"B",SYNENTRY)) Q:SYNENTRY=""  Q:$E(SYNENTRY,1,$L(SVC))=SVC
 Q:SYNENTRY="" "-1^ENTRY NOT FOUND"
 N SYNIEN
 S SYNIEN=$O(^RGNET(996.52,"B",SYNENTRY,""))
 ;
 N HANDLR
 S HANDLR=$$GET1^DIQ(996.52,SYNIEN_",",10)
 I HANDLR="" Q "-1^HANDLER NOT FOUND"
 ;
 ;W !,"DHPR ",$$DHPR(HANDLR),!
 S SYNRTN=$$DHPR(HANDLR)
 ;
 Q SYNRTN
 ;
DHPR(HAND) ; extrinsic returns
 ;the DHP processing routine for the handler HAND
 N ZI,DHPRTN
 S DHPRTN=""
 N HAND1,HAND2
 S HAND1=$P(HAND,"^",1)
 S HAND2=$P(HAND,"^",2)
 F ZI=0:1:10 D  ;
 . N ZL
 . S ZL=$T(@HAND1+ZI^@HAND2)
 . I ZL["SYNDHP" S DHPRTN=ZL
 Q:DHPRTN=""
 N ZE1,ZE2
 S ZE1=$P(DHPRTN,"(",1)
 S ZE2=$P(DHPRTN,"(",2)
 N ZP,ZE3
 S ZE3=".RETSTA"
 F ZP=2:1:$L(ZE2,",") D  ;
 . N ZP1
 . S ZP1=$P(ZE2,",",ZP)
 . S ZP1=$TR(ZP1,")")
 . I $E(ZP1,1,3)="DHP" S ZP1=$E(ZP1,4,$L(ZP1))
 . S ZE3=ZE3_","_ZP1
 ;S ZE2=$TR(ZE2,"DHP","")
 S DHPRTN=ZE1_"("_ZE3_")"
 S DHPRTN=$E(DHPRTN,2,$L(DHPRTN))
 ;
 Q DHPRTN
 ;
DHPPARMS(ARY,CMD) ; pulls the DHP and other parameters out of the line
 N ZP
 F ZP=2:1:$L(CMD,",") D  ;
 . N ZP1
 . S ZP1=$P(CMD,",",ZP)
 . S ZP1=$TR(ZP1,")")
 . I $E(ZP1,1,3)="DHP" S ZP1=$E(ZP1,4,$L(ZP1))
 . S @ARY@(ZP1)=""
 Q
 ;
