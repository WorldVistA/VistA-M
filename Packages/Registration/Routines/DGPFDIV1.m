DGPFDIV1 ;ALB/KCL - PRF ENABLE MEDICAL CENTER DIVISIONS CONT.; 5/07/05 ; 8/25/05 4:12pm
 ;;5.3;Registration;**650**;Aug 13, 1993;Build 3
 ;
 ;No direct entry
 QUIT
 ;
LOCK(DGIEN) ;lock MEDICAL CENTER DIVISION record
 ;This lock function is used to prevent another process from editing
 ;a record in the MEDICAL CENTER DIVISION (#40.8) file.
 ;
 ;  Input:
 ;   DGIEN - (required) IEN for MEDICAL CENTER DIVISION (#40.8) file
 ;
 ; Output:
 ;   Function value - returns 1 on success, 0 on failure
 ;
 I $G(DGIEN) L +^DG(40.8,DGIEN):10
 ;
 Q $T
 ;
UNLOCK(DGIEN) ;unlock MEDICAL CENTER DIVISION record
 ;This procedure is used to release a lock created by $$LOCK.
 ;
 ;  Input:
 ;   DGIEN - (required) IEN for MEDICAL CENTER DIVISION (#40.8) file
 ;
 ; Output: none
 ;
 I $G(DGIEN) L -^DG(40.8,DGIEN)
 ;
 Q
 ;
GETDIV(DGIEN,DGDIV) ;retrieve PRF MEDICAL CENTER DIVISION object
 ;This function is used to retrieve the data fields related to the
 ;PRF Ownership Indicator from the MEDICAL CENTER DIVISION (#40.8) file
 ;and place them in a local array.
 ;
 ;  Input:
 ;   DGIEN - (required) ien for MEDICAL CENTER DIVISION (#40.8) file
 ;
 ; Output:
 ;   Function value - returns 1 on success, 0 on failure
 ;   DGDIV - local array of MEDICAL CENTER DIVISION data fields (passed
 ;           by reference)
 ;            Subscript   Field#
 ;            ----------  ------
 ;            "NAME"      .01
 ;            "INST"      .07
 ;            "IND"       26.01
 ;            "EDITDT"    26.02
 ;            "EDITBY"    26.03
 ;
 N DGIENS ;ien string
 N DGFLDS ;target root
 N DGERR  ;error root
 N DGRSLT ;function result
 ;
 K DGDIV S DGDIV=""
 S DGRSLT=0
 ;
 I $G(DGIEN)>0,$D(^DG(40.8,DGIEN)) D
 . S DGIENS=DGIEN_","
 . D GETS^DIQ(40.8,DGIENS,".01;.07;26.01;26.02;26.03","IE","DGFLDS","DGERR")
 . Q:$D(DGERR)
 . ;
 . S DGDIV("NAME")=$G(DGFLDS(40.8,DGIENS,.01,"I"))_U_$G(DGFLDS(40.8,DGIENS,.01,"E"))
 . S DGDIV("INST")=$G(DGFLDS(40.8,DGIENS,.07,"I"))_U_$G(DGFLDS(40.8,DGIENS,.07,"E"))
 . S DGDIV("IND")=$G(DGFLDS(40.8,DGIENS,26.01,"I"))_U_$G(DGFLDS(40.8,DGIENS,26.01,"E"))
 . S DGDIV("EDITDT")=$G(DGFLDS(40.8,DGIENS,26.02,"I"))_U_$G(DGFLDS(40.8,DGIENS,26.02,"E"))
 . S DGDIV("EDITBY")=$G(DGFLDS(40.8,DGIENS,26.03,"I"))_U_$G(DGFLDS(40.8,DGIENS,26.03,"E"))
 . ;
 . ;success
 . S DGRSLT=1
 ;
 Q DGRSLT
 ;
STODIV(DGIEN,DGIND) ;store PRF MEDICAL CENTER DIVISION object
 ;This function is used to store the data fields related to the
 ;PRF Ownership Indicator into the MEDICAL CENTER DIVISION (#40.8) file.
 ;
 ;  Input:
 ;   DGIEN - (required) ien for MEDICAL CENTER DIVISION (#40.8) file
 ;   DGIND - (required) PRF Ownership Indicator [1=enable, 0=disable] 
 ;
 ; Output:
 ;   Function value - returns 1 on success, 0 on failure
 ;
 ;
 N DGERR  ;error root
 N DGFDA  ;fda array
 N DGRSLT ;function result
 ;
 S DGRSLT=0
 ;
 I $G(DGIEN)>0,$D(^DG(40.8,DGIEN)) D
 . ;
 . ;quit if can't convert internal value to external
 . Q:$$EXTERNAL^DILFD(40.8,26.01,"",DGIND)']""
 . ;
 . ;file data
 . S DGFDA(40.8,DGIEN_",",26.01)=DGIND         ;indicator
 . S DGFDA(40.8,DGIEN_",",26.02)=$$NOW^XLFDT() ;current date/time
 . S DGFDA(40.8,DGIEN_",",26.03)=DUZ           ;user
 . D FILE^DIE("","DGFDA","DGERR")
 . Q:$D(DGERR)
 . ;
 . ;success
 . S DGRSLT=1
 ;
 Q DGRSLT
 ;
VIEW ;view medical center divisions
 ;This procedure is used to view all medical center divisions within the
 ;Medical Center Division (#40.8) file and whether or not they have been
 ;enabled for PRF assignment ownership.
 ;
 ;  Input: none
 ; Output: none
 ;
 N DGEXIT ;exit var
 N DGIEN  ;file (#40.8) ien
 N DGINST ;ptr to INSTITUTION file
 N DGLINE ;display line
 N DGOBJ  ;med center division object array
 N DGSUB  ;loop subscript
 ;
 S $P(DGLINE,"_",66)=""
 W @IOF
 ;
 F DGIEN=0:0 S DGIEN=$O(^DG(40.8,DGIEN)) D  Q:'DGIEN!($G(DGEXIT))
 . K DGOBJ
 . I $$GETDIV(DGIEN,.DGOBJ) D
 . . F DGSUB="NAME","IND","EDITBY","EDITDT" D
 . . . I $P(DGOBJ(DGSUB),U,2)']"" S $P(DGOBJ(DGSUB),U,2)="n/a"
 . . ;
 . . S:$P(DGOBJ("IND"),U,2)="n/a" $P(DGOBJ("IND"),U,2)="DISABLED (default)"
 . . S DGINST=+$P($G(^DG(40.8,DGIEN,0)),U,7)
 . . S DGOBJ("ACTIVE")=$S($D(^DGPF(26.13,"AOWN",DGINST,1)):"YES",1:"NO")
 . . ;
 . . W !,"  Medical Center Division: ",$P(DGOBJ("NAME"),U,2)
 . . W !," PRF Assignment Ownership: ",$P(DGOBJ("IND"),U,2)
 . . W !,"                Edited By: ",$P(DGOBJ("EDITBY"),U,2)
 . . W !,"           Edit Date/Time: ",$P(DGOBJ("EDITDT"),U,2)
 . . W !,"   Active PRF Assignments: ",DGOBJ("ACTIVE")
 . . W !,DGLINE,!
 . . I $Y>(IOSL-5) S DGEXIT='$$CONTINUE^DGPFUT() W @IOF
 ;
 Q
