XLFNP152 ;SFISC/MKO-POST INSTALL ROUTINE FOR PATCH XU*8*152 ;9:11 AM  26 Apr 2000
 ;;8.0;KERNEL;**152**;Jul 10, 1995
 ;This post-install routine for patch XU*8*152 loops through the
 ;entries in the New Person file, and if the SIGNATURE BLOCK
 ;PRINTED NAME field (#20.2) is null, updates it from the
 ;data in the corresponding entry in the Name Components file.
 N XUDA
 S XUDA=0
 F  S XUDA=$O(^VA(200,XUDA)) Q:'XUDA  D:$P($G(^(XUDA,20)),U,2)=""
 . N XUCOMP,XUFDA,XUMSG,XUNC,XUNC1,DIERR
 . S XUNC=$O(^VA(20,"BB",200,.01,XUDA_",",0)) Q:'XUNC
 . S XUNC1=$G(^VA(20,XUNC,1)) Q:XUNC1?."^"
 . S XUCOMP("FAMILY")=$P(XUNC1,U)
 . S XUCOMP("GIVEN")=$P(XUNC1,U,2)
 . S XUCOMP("MIDDLE")=$P(XUNC1,U,3)
 . S XUCOMP("SUFFIX")=$P(XUNC1,U,5)
 . S XUFDA(200,XUDA_",",20.2)=$$NAMEFMT^XLFNAME(.XUCOMP,"G")
 . D FILE^DIE("","XUFDA","XUMSG")
 Q
