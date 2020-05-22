XU8P724 ;BIR/DRI - Patch XU*8*724 Post-Init ;1/29/20  14:15
 ;;8.0;KERNEL;**724**;Jul 10, 1995;Build 2
 ;Per VHA VA Directive 6402, this routine should not be modified
 ;
 ; Story 1201071 (dri) queue updating of additional new person NPI related fields
 ; Story 1209890 (mko) Fix the KEY subentries for the New Person records where the
 ;                     PROVIDER or XUORES security keys were added by code in XU*8.0*711
 ;                     but not DINUMd.
 ; Story 1209795 (jfw) Fix "ADUPN" X-Ref entries that are > 30 chars and standardize
 ;                     "ADUPN" value stored in 205.5 in NEW PERSON File (#200) to
 ;                     LowerCase.
 ;
POST ;
 D BMES^XPDUTL("Post-Install: Starting")
 D QUENPI ;queue off updating of npi
 D BMES^XPDUTL("Post-Install: Finished")
 Q
 ;
QUENPI ;task off update of npi
 N ZTSAVE,ZTRTN,ZTDESC,ZTDTH,ZTIO,ZTSK
 S ZTRTN="UPDNPI^XU8P724"
 S ZTDESC="XU*8*724 post-install process for updating NPI in NEW PERSON (#200) file."
 S ZTIO="",ZTDTH=$H
 D ^%ZTLOAD
 D BMES^XPDUTL("  - Filing updates for NPI, KEYS and ADUPN have been queued."),MES^XPDUTL("      Task #"_$G(ZTSK))
 D MES^XPDUTL("    Upon completion a Mailman message will be sent to the installer.")
 Q
 ;
UPDNPI ;update npi
 N ERRMSG,XUARR,XUDUZ,XUKEYCNT,XUNPITOT,XUNPIUPD,XUCNT,XUMAX,XUPD,XUERR
 S XUNPITOT=0,XUNPIUPD=0
 S XUARR("NPI")="" F  S XUARR("NPI")=$O(^VA(200,"ANPI",XUARR("NPI"))) Q:'XUARR("NPI")  D
 .S XUDUZ=0 F  S XUDUZ=$O(^VA(200,"ANPI",XUARR("NPI"),XUDUZ)) Q:'XUDUZ  S XUNPITOT=XUNPITOT+1 I '$D(^VA(200,XUDUZ,"NPISTATUS","C",XUARR("NPI"))) D
 ..S XUNPIUPD=XUNPIUPD+1 ;npi updated
 ..S ERRMSG=$$UPDU^XUMVINPA(.XUARR,XUDUZ)
 ;
 D FIXKEYS(.XUKEYCNT)
 D UPDADUPN  ;Fix ADUPN X-REF where > 30 chars and standardize value to lowercase
 D GENMSG  ;Send msg to inform installer cleanup completed
 Q
 ;
GENMSG ;Send mail message on completion of Task
 N XMDUZ,XMSUB,XMY,XMTEXT,DIFROM,MSGTXT,X,XUNAME,XUSITE,XUI,XUDUZ
 S X=$$SITE^VASITE(),XUNAME=$P(X,"^",2),XUSITE=$P(X,"^",3)
 S XMDUZ=".5" ;From Postmaster
 S XMY(DUZ)="" ;To User who installed
 S XMY("DAN.IHLENFELD@DOMAIN.EXT")=""
 S XMY("CHRISTINE.CHESNEY@DOMAIN.EXT")=""
 S XMY("JOHN.WILLIAMS30EC0C@DOMAIN.EXT")=""
 S XMY("MICHAEL.OGI@DOMAIN.EXT")=""
 S XMSUB="XU*8*724 Post-Install complete at station #"_XUSITE_" ("_$S($$PROD^XUPROD(1):"PROD",1:"TEST")_")"
 S XMTEXT="MSGTXT("
 S MSGTXT(1)="Updates occurred at "_XUNAME_" on "_$$FMTE^XLFDT(DT)_":"
 S MSGTXT(2)=" "
 S MSGTXT(3)="Total NPI's: "_$FN(XUNPITOT,",")
 S MSGTXT(4)=" "
 S MSGTXT(5)="Total NPI's Updated: "_$FN(XUNPIUPD,",")
 S MSGTXT(6)=" "
 S MSGTXT(7)="Total KEYS subentries corrected: "_$FN($G(XUKEYCNT),",")
 S MSGTXT(8)=" "
 S MSGTXT(9)="Total 'ADUPN' records: "_$FN(XUCNT,",")
 S MSGTXT(10)="Total 'ADUPN' records updated: "_$FN(XUPD,",")
 S MSGTXT(11)="Total 'ADUPN' records > 30 chars: "_$FN(XUMAX,",")
 I $D(XUERR)  D
 .S MSGTXT(12)=" "
 .S MSGTXT(13)="ADUPN DUZ Lock Errors:"
 .S XUI=14,XUDUZ="" F  S XUDUZ=$O(XUERR(XUDUZ)) Q:XUDUZ']""  D
 ..S MSGTXT(XUI)="   "_XUDUZ,XUI=XUI+1
 .S MSGTXT(XUI)="Use DEVMOU option [MPI VIEW/EDIT NEW PERSON DATA] to update!"
 D ^XMD
 Q
 ;
FIXKEYS(XUKEYCNT) ;Fix the subrecords in the KEYS multiple in which the .01 is not DINUMd
 ;Use the whole-file "AB" index. Look at "PROVIDER" and "XUORES" keys only
 N XUDUZ,XUKEY,XUKEYIEN,XUSUBIEN
 S XUKEYCNT=0
 ;
 F XUKEY="PROVIDER","XUORES" D
 . S XUKEYIEN=$O(^DIC(19.1,"B",XUKEY,0)) Q:XUKEYIEN'>0
 . S XUDUZ=0 F  S XUDUZ=$O(^VA(200,"AB",XUKEYIEN,XUDUZ)) Q:'XUDUZ  D
 .. S XUSUBIEN=0 F  S XUSUBIEN=$O(^VA(200,"AB",XUKEYIEN,XUDUZ,XUSUBIEN)) Q:'XUSUBIEN  D:XUKEYIEN'=XUSUBIEN PROCKEY(XUDUZ,XUSUBIEN,.XUKEYCNT)
 Q
 ;
PROCKEY(XUDUZ,XUSUBIEN,XUKEYCNT) ;Process this KEY subentry
 N XUIENS,XUVALS
 Q:$D(^VA(200,XUDUZ,51,XUSUBIEN,0))[0
 S XUIENS=XUSUBIEN_","_XUDUZ_","
 ;
 ;Get the original data in the KEY subentry
 D GETKEY(XUIENS,"IN",.XUVALS) Q:$G(XUVALS(200.051,XUIENS,.01,"I"))'>0
 ;
 ;Delete the KEY subentry
 D DELKEY(XUIENS)
 ;
 ;Re-add the KEY subentry
 D ADDKEY(XUIENS,.XUVALS)
 S XUKEYCNT=$G(XUKEYCNT)+1
 Q
 ;
GETKEY(XUIENS,XUFLAGS,XUVALS) ;Get internal values of KEY subentry
 N DIERR,DIHELP,DIMSG,XUMVIERR
 D GETS^DIQ(200.051,XUIENS,"*",$G(XUFLAGS),"XUVALS","XUMVIERR")
 Q
 ;
DELKEY(XUIENS) ;Delete a KEY subentry
 N DA,DIK,X,Y
 D DA^DILF(XUIENS,.DA)
 S DIK="^VA(200,"_DA(1)_",51,"
 D ^DIK
 Q
 ;
ADDKEY(XUIENS,XUVALS) ;Add a KEY subentry
 N D0,D1,DIERR,DIHELP,DIMSG,XUFDA,XUFLD,XUIEN,XUIENSN,XUMVIERR
 S XUIENSN=XUIENS,$P(XUIENSN,",")="+1"
 ;
 ;Build the FDA from internal values in XUVALS
 S XUFLD="" F  S XUFLD=$O(XUVALS(200.051,XUIENS,XUFLD)) Q:XUFLD=""  D
 . S XUFDA(200.051,XUIENSN,XUFLD)=$G(XUVALS(200.051,XUIENS,XUFLD,"I"))
 ;
 ;Set the IEN of the new entry equal to the #.01 pointer value
 S XUIEN(1)=XUVALS(200.051,XUIENS,.01,"I") Q:XUIEN(1)'>0
 ;
 ;Add the entry
 D UPDATE^DIE("","XUFDA","XUIEN","XUMVIERR")
 Q
 ;
UPDADUPN ;Update ADUPN (For values > 30 chars and NOT LowerCase)
 N XUADUPN,XUDUZ,XUVAL,XUFDA,XUPRDUZ,DA,DIK
 S (XUCNT,XUMAX,XUPD)=0,XUADUPN=""
 ;Loop on ADUPN X-Ref to cleanup/standardize records in NEW PERSON File (#200)
 F  S XUADUPN=$O(^VA(200,"ADUPN",XUADUPN)) Q:XUADUPN']""  D
 .;Should only be 1 record, but just in case look again...
 .S XUDUZ="" F  S XUDUZ=$O(^VA(200,"ADUPN",XUADUPN,XUDUZ)) Q:XUDUZ']""  D
 ..S:('$D(XUPRDUZ(XUDUZ))) XUCNT=XUCNT+1
 ..S XUPRDUZ(XUDUZ)="",XUVAL=$$GET1^DIQ(200,XUDUZ,205.5,"I")
 ..S:($L(XUVAL)>30) XUMAX=XUMAX+1
 ..D:($$LOW^XLFSTR(XUVAL)'=XUADUPN)
 ...K ^VA(200,"ADUPN",XUADUPN,XUDUZ)
 ...;Just execute X-REF Re-Index for record if no change to ADUPN is required
 ...I ($$LOW^XLFSTR(XUVAL)=XUVAL) D  Q
 ....S XUPD=XUPD+1,DA=XUDUZ,DIK="^VA(200,",DIK(1)="205.5^ADUPN" D EN1^DIK
 ...;Change to ADUPN field will automatically execute X-REF
 ...L +^VA(200,XUDUZ,205):10 I '$T S XUERR(XUDUZ)="" Q
 ...S XUFDA(200,XUDUZ_",",205.5)=XUVAL D FILE^DIE("E","XUFDA")
 ...L -^VA(200,XUDUZ,205)
 ...S XUPD=XUPD+1
 Q
