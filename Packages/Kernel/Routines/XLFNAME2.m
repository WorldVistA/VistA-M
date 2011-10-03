XLFNAME2 ;CIOFO-SF/MKO-UPDATE ENTRY POINTS;1:07 PM  24 Apr 2003
 ;;8.0;KERNEL;**134,211,301,343**;Jul 10, 1995
 ;
UPDNAME(XUFIL,XUREC,XUFLD,XUCOMP,XUFLAG) ;Update source name field
 ;Called from "ANAME" MUMPS xref on file #20.
 ;
 N XUIENS,XUFDA,XUMAX,XUMSG,XUNAME,DIERR
 I '$G(XUNOTRIG) N XUNOTRIG S XUNOTRIG=1
 S:$G(XUFLAG)="" XUFLAG="CLS"
 ;
 ;Get IENS from XUREC
 I $G(XUREC)'["," S XUIENS=$$IENS^DILF(.XUREC)
 E  S XUIENS=XUREC S:XUIENS'?.E1"," XUIENS=XUIENS_","
 ;
 ;Get maximum length of source field
 I XUFLAG["L",'$P(XUFLAG,"L",2) D
 . S XUFLAG=$TR(XUFLAG,"L")_"L"_+$$GET1^DID(XUFIL,XUFLD,"","FIELD LENGTH","","XUMSG")
 . K DIERR,XUMSG
 ;
 ;Get name from components; quit if source name = new name
 S XUNAME=$$BLDNAME^XLFNAME8(.XUCOMP,35)
 ;S XUNAME=$$NAMEFMT^XLFNAME(.XUCOMP,"F",XUFLAG)
 ;
 Q:XUNAME=$$GET1^DIQ(XUFIL,XUIENS,XUFLD,"I","","XUMSG")  K DIERR,XUMSG
 ;
 ;Call Filer to edit entry in source file
 S XUFDA(XUFIL,XUIENS,XUFLD)=XUNAME
 D FILE^DIE("","XUFDA","XUMSG") K DIERR,XUMSG
 Q
 ;
UPDCOMP(XUFIL,XUREC,XUFLD,XUNAME,XUPTR,XUPVAL,XUFLAG) ;Update Name Components entry
 ;Called from set logic of "ANAME" MUMPS xref of file #200,
 ;Called from UPDATE^XLFNAME3 to update components during conversion.
 N XUDEG,XUIEN,XUIENS,XUFDA,XUMSG,DIERR
 I '$G(XUNOTRIG) N XUNOTRIG S XUNOTRIG=1
 ;
 ;Get IENS from XUREC
 I $G(XUREC)'["," S XUIENS=$$IENS^DILF(.XUREC)
 E  S XUIENS=XUREC S:XUIENS'?.E1"," XUIENS=XUIENS_","
 ;
 ;Get name components from XUNAME
 I $D(XUNAME)=1,XUNAME]"" D NAMECOMP^XLFNAME(.XUNAME)
 ;
 ;Call updater to add or edit entry in Name Component file
 S XUFDA(20,"?+1,",.01)=XUFIL
 S XUFDA(20,"?+1,",.02)=XUFLD
 S XUFDA(20,"?+1,",.03)=XUIENS
 S:$D(XUNAME("FAMILY"))#2 XUFDA(20,"?+1,",1)=XUNAME("FAMILY")
 S:$D(XUNAME("GIVEN"))#2 XUFDA(20,"?+1,",2)=XUNAME("GIVEN")
 S:$D(XUNAME("MIDDLE"))#2 XUFDA(20,"?+1,",3)=XUNAME("MIDDLE")
 S:$D(XUNAME("PREFIX"))#2 XUFDA(20,"?+1,",4)=XUNAME("PREFIX")
 S:$D(XUNAME("SUFFIX"))#2 XUFDA(20,"?+1,",5)=XUNAME("SUFFIX")
 S:$D(XUNAME("DEGREE"))#2 XUFDA(20,"?+1,",6)=XUNAME("DEGREE")
 S:$D(XUNAME("NOTES"))#2 XUFDA(20,"?+1,",11)=XUNAME("NOTES")
 S:$D(XUFLAG)#2 XUFDA(20,"?+1,",7)=XUFLAG
 D UPDATE^DIE("K","XUFDA","XUIEN","XUMSG") K DIERR,XUMSG
 ;
 ;Update pointer
 I $G(XUPTR),$G(XUIEN(1)),$G(XUIEN(1))'=$G(XUPVAL) D
 . S XUPVAL=XUIEN(1)
 . S XUFDA(XUFIL,XUIENS,XUPTR)=XUPVAL
 . D FILE^DIE("","XUFDA","XUMSG") K DIERR,XUMSG
 Q
 ;
DELCOMP(XUFIL,XUREC,XUFLD,XUPTR) ;Delete Name Components entry
 ;Called from kill logic "ANAME" MUMPS xref of file #200
 N DA,DIK,XUFDA,XUIENS,XUMSG,XUVAL,DIERR
 ;
 ;Get IENS from XUREC
 I $G(XUREC)'["," S XUIENS=$$IENS^DILF(.XUREC)
 E  S XUIENS=XUREC S:XUIENS'?.E1"," XUIENS=XUIENS_","
 ;
 ;Lookup entry in Name Components file
 S XUVAL(1)=XUFIL,XUVAL(2)=XUFLD,XUVAL(3)=XUIENS
 S DA=$$FIND1^DIC(20,"","X",.XUVAL,"BB","","XUMSG") ;8*301
 Q:$G(DIERR)
 ;
 ;Delete entry from Name Components file
 S DIK="^VA(20,"
 D ^DIK
 ;
 ;Delete pointer value
 I $G(XUPTR) D
 . K XUFDA S XUFDA(XUFIL,XUIENS,XUPTR)=""
 . D FILE^DIE("","XUFDA","XUMSG") K XUMSG,DIERR
 Q
 ;
CHKPTR ;Make sure entry contains a valid pointer to Name Components file.
 ;Called from the pre-action on the XUEXISTING USER form.
 N AIEN,DEG,FDA,NAM,PTR,DIERR
 ;
 ;Get current pointer value
 S PTR=+$P($G(^VA(200,DA,3.1)),U)
 ;
 ;If not valid, get standard name, and update the Name Components file
 I 'PTR!($D(^VA(20,PTR,0))[0) D
 . K PTR
 . S NAM=$P($G(^VA(200,DA,0)),U)
 . S DEG=$P($G(^VA(200,DA,3.1)),U,6)
 . D STDNAME^XLFNAME(.NAM,"C")
 . D UPDCOMP(200,DA_",",.01,.NAM,10.1)
 Q
