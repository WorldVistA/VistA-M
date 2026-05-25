VDI1P1 ;BP/CMF/GJW - Patch 1 Post-Init ; 3/23/2023
 ;;1.0;VETERANS DATA INTEGRATION AND FEDERATION;**1**;Dec 30, 1994;Build 19
 ;
 ; External Reference   DBIA#
 ; ------------------   -----
 ; ^VA(200              10060
 ; XPDUTL               10141
 ; UPDATE^DIE            2053
 ; $$SHAHASH^XUSHSH()    6189
 ; Add new NPE user      7423
 ;
ENV ;do environment check
 S XPDABORT=""
 D PROGCHK(.XPDABORT) I XPDABORT=2 Q
 D RQIDCHK(.XPDABORT) I XPDABORT=2 Q
 I XPDABORT="" K XPDABORT
 Q
 ;
PROGCHK(XPDABORT) ; checks for necessary programmer variables
 I '$G(DUZ)!($G(DUZ(0))'="@")!('$G(DT))!($G(U)'="^") D
 .D MES^XPDUTL("Your programming variables are not set up properly.")
 .D MES^XPDUTL("Installation aborted.")
 .S XPDABORT=2
 Q
 ;
RQIDCHK(XPDABORT) ; checks for additional required identifiers beyond .01 field
 ; loop through required identifier fields, if a field outside of our filing list, abort, alert user with message
 Q:+$G(XPDENV)=0  ; do not execute if run by load a distribution.
 N RQIDOUT,RQIDMSG,RQIDENT,RQIDNUM,RQIDNAM,RQIDABRT,RQIDVAL
 ;S XPDGREF="^XTMP(""VDI1P1"")"
 D FILE^DID(200,,"REQUIRED IDENTIFIERS","RQIDOUT","RQIDMSG")
 S RQIDENT=0,RQIDABRT=0,XPDABORT=""
 F  S RQIDENT=$O(RQIDOUT("REQUIRED IDENTIFIERS",RQIDENT)) Q:+RQIDENT=0  D
 .S RQIDNUM=$G(RQIDOUT("REQUIRED IDENTIFIERS",RQIDENT,"FIELD"))
 .Q:RQIDNUM=""
 .Q:"^.01^2^11^7.2^205.1^205.2^205.3^205.4^205.5^"[(U_RQIDNUM_U)
 .S RQIDABRT=1
 .S RQIDABRT(RQIDNUM)=""
 .Q
 Q:RQIDABRT=0
 D BMES^XPDUTL("This site has required identifier fields for New Person file entries")
 D MES^XPDUTL("which are not contained in the new entries being made for this patch.")
 D MES^XPDUTL("Please supply the values for these fields at your facility.")
 D BMES^XPDUTL("The fields are:")
 S RQIDNUM=0
 F  S RQIDNUM=$O(RQIDABRT(RQIDNUM)) Q:+RQIDNUM=0!(XPDABORT=2)  D 
 .N DIR,X,Y
 .S DIR(0)="200,"_RQIDNUM
 .D ^DIR
 .I $D(DIRUT) S XPDABORT=2 Q
 .S RQIDNAM=$$GET1^DID(200,RQIDNUM,"","LABEL","","RQIDMSG")
 .S RQIDVAL=$P(Y,U,2)
 .I RQIDVAL="" S XPDABORT=2 Q
 .M @XPDGREF@("VDI1P1",RQIDNUM)=RQIDVAL
 .D MES^XPDUTL("  "_RQIDNUM_"  "_RQIDNAM_"  "_RQIDVAL_" added to filer array")
 .Q
 S:XPDABORT'="" XPDABORT=2
 Q
 ; 
HELP ; Help for ?? on Installation Question POS1 (use direct writes in env check routine)
 W !,"Enter 1 if patch is being installed in a Pre-Production system."
 W !,"Enter 2 if patch is being installed in a Software Quality Assurance system."
 W !,"Enter 3 if patch is being installed in a Test system."
 W !,"Enter 4 if patch is being installed in a Development system."
 Q
 ;
POST ; Post-init for VDI*1*1
 N VDIENV,VDITYPE
 S VDITYPE=$G(XPDQUES("POS1"))
 ;VDITYPE will be a value of 1-4 (pre-prod, sqa, test, development) if no value, this is a production system
 I 'VDITYPE S VDITYPE=5
 S VDIENV=$S(VDITYPE=1:"PPD",VDITYPE=2:"SQA",VDITYPE=3:"TST",VDITYPE=4:"DEV",1:"PRD")
 D IZG(VDIENV)  ; for IZG
 D MHV(VDIENV)  ; for MHV
 Q
 ;
IZG(VDIENV) ; Create Non Person Entity (NPE) user
 ; look for type of VistA instance
 ; create NPE for type of instance
 N VDINPE,VDISECID,VDIUPN,VDIRSLT,VDIRSLT2,VDIERR,VDIERTXT
 S VDINPE="OITAUSIZG"_VDIENV
 ; need SecID for dev
 S VDISECID=$S(VDIENV="PRD":1076035779,VDIENV="PPD":1017862488,VDIENV="SQA":1013776211,VDIENV="TST":1013776210,1:"")
 S VDIUPN="OITAUSIZG"_VDIENV_"@AAC.DVA.DOMAIN.EXT"  ;
 S VDIRSLT=$$ADD(VDINPE,VDINPE,VDISECID,VDIUPN,"VDIERR")
 I +VDIRSLT>0 D  QUIT
 . D BMES^XPDUTL(VDINPE_" NPE User created or updated")
 . Q
 D BMES^XPDUTL(VDINPE_" NPE User not created or updated")
 S VDIRSLT2=$P(VDIRSLT,U,2)
 D:VDIRSLT2'="" MES^XPDUTL(VDIRSLT2)
 S VDIERTXT=$G(VDIERR("DIERR",1,"TEXT",1))
 D:VDIERTXT'="" MES^XPDUTL(VDIERTXT)
 Q
 ;
MHV(VDIENV) ; Create NPE user
 ; create NPE for type of instance
 N VDINPE,VDISECID,VDIUPN,VDIRSLT,VDIRSLT2,VDIERR,VDIERTXT
 I VDIENV="PRD"!(VDIENV="PPD") D 
 . S VDINPE="OITSVCMHV"_VDIENV
 . S VDIUPN=VDINPE_"@DOMAIN.EXT"
 . Q
 E  D
 . S VDINPE="OITAUSMHV"_VDIENV
 . S VDIUPN=VDINPE_"@AAC.DVA.DOMAIN.EXT"
 . Q
 ; no names/secids for tst & dev defined
 S VDISECID=$S(VDIENV="PRD":1076218582,VDIENV="PPD":1017863107,VDIENV="SQA":1013775925,1:"")
 S VDIRSLT=$$ADD(VDINPE,VDINPE,VDISECID,VDIUPN,"VDIERR")
 I +VDIRSLT>0 D  QUIT
 . D BMES^XPDUTL(VDINPE_" NPE User created or updated")
 . Q
 D BMES^XPDUTL(VDINPE_" NPE User not created")
 S VDIRSLT2=$P(VDIRSLT,U,2)
 D:VDIRSLT2'="" MES^XPDUTL(VDIRSLT2)
 S VDIERTXT=$G(VDIERR("DIERR",1,"TEXT",1))
 D:VDIERTXT'="" MES^XPDUTL(VDIERTXT)
 Q
 ;
 ;
ADD(VDIFIRST,VDILAST,VDISECID,VDIEMAIL,VDIMSG) ;create new non-person user
 ;
 ;VDIFIRST - first name
 ;VDILAST - last name
 ;VDISECID (optional) - SECID
 ;VDIEMAIL (optional) - VA email address (UPN)
 ;VDIMSG (optional) - error message array from UPDATE^DIE
 ;
 ;return value: DUZ of user or a value < 0 on error:
 ;
 ; -1 - could not obtain lock
 ; -2 - FileMan signaled an error (see VDIMSG)
 ; -3 - User does not have DUZ(0)="@"
 ;
 N MYFDA,IROOT,MROOT,DIC,VDINAME,AC,VC,RQIDNUM,RQIDVAL
 Q:DUZ(0)'="@" "-3^User must have DUZ(0)=""@"""
 H 1 ;ensure that succeive calls do not occur with the same value of $H.
 S VDINAME=VDILAST_","_$G(VDIFIRST)
 S AC=$$SHAHASH^XUSHSH(256,$J_$H,"B")
 S VC=$$SHAHASH^XUSHSH(256,$J_$H_1,"B")
 L +^VA(200,0):5 I '$T Q "-1^Could not obtain lock on NEW PERSON file"
 S DIC(0)="" ;required to avoid hard error in FileMan
 S MYFDA(200,"?+1,",.01)=VDINAME
 S MYFDA(200,"?+1,",2)=AC ;ACCESS CODE
 S MYFDA(200,"?+1,",11)=VC ;VERIFY CODE
 S MYFDA(200,"?+1,",7.2)="Yes" ;VERIFY CODE never expires
 S MYFDA(200.07,"?+2,?+1,",.01)="NON-PERSON" ;USER CLASS
 S MYFDA(200,"?+1,",205.1)=$G(VDISECID) ;SECID
 S MYFDA(200,"?+1,",205.2)="Department of Veterans Affairs" ;SUBJECT ORGANIZATION
 S MYFDA(200,"?+1,",205.3)="urn:oid:2.16.840.1.113883.4.349" ;SUBJECT ORGANIZATION ID
 S MYFDA(200,"?+1,",205.4)=$G(VDISECID) ;UNIQUE USER ID
 S MYFDA(200,"?+1,",205.5)=$G(VDIEMAIL) ;ADUPN
 I $G(XPDGREF)'="" D:$D(@XPDGREF)
 .S RQIDNUM=0
 .F  S RQIDNUM=$O(@XPDGREF@("VDI1P1",RQIDNUM)) Q:+RQIDNUM=0  D
 ..S RQIDVAL=$G(@XPDGREF@("VDI1P1",RQIDNUM))
 ..Q:RQIDVAL=""
 ..S MYFDA(200,"?+1,",RQIDNUM)=RQIDVAL
 ..Q
 .Q
 D UPDATE^DIE("E","MYFDA","IROOT","MROOT")
 L -^VA(200,0)
 S VDIIEN=$G(IROOT(1))
 M:$D(VDIMSG) @VDIMSG=MROOT
 Q $S(VDIIEN="":"-2^FileMan signaled an error",1:VDIIEN)
 ;
