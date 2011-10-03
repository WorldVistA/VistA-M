RACPTMSC ;HISC/SWM - CPT Mod screen, misc. ;5/30/00  11:02
 ;;5.0;Radiology/Nuclear Medicine;**10,19,38**;Mar 16, 1998
 Q
SCRN(Y) ;screen entry of cpt mod
 ; called from file 70.03's field 135's screen
 ; Y    = ien of file 81.3
 ; RACPT= CPT ien of this exam's procedure
 ; RADT = exam date
 ; RAX  = screen's outcome, 0=failed
 N RACPT,RADT,RAX,RA7002,RA7003,RA1,RA2,RA3
 S (RA7002,RA7003)=""
 D SET
 I RA7002="" Q 0
 I RA7003="" Q 0
 S RADT=$P(RA7002,U) I 'RADT Q 0
 S RACPT=+$P(^RAMIS(71,+$P(RA7003,U,2),0),U,9) I 'RACPT Q 0
 S RAX=$$MODP^ICPTMOD(RACPT,+Y,"I",RADT) S:RAX<0 RAX=0
 Q RAX
SET ; use Rad vars if available
 I $D(RADFN),$D(RADTI),$D(RACNI) S RA1=RADFN,RA2=RADTI,RA3=RACNI G SET23
 S RA1=$G(D0),RA2=$G(D1),RA3=$G(D2)
 Q:((RA1="")!(RA2="")!(RA3=""))
SET23 S RA7002=$G(^RADPT(RA1,"DT",RA2,0)),RA7003=$G(^RADPT(RA1,"DT",RA2,"P",RA3,0))
 Q
DW ; del exam's cpt mods and warn of proc mods
 ; called from file 70.03's field 2's Mumps xref for kill
 ; Y    = ien of file 81.3
 N RA7002,RA7003,RA1,RA2,RA3,RAX,RAROOT
 S (RA7002,RA7003)=""
 D SET
 Q:RA7002=""
 Q:RA7003=""
 G:'$O(^RADPT(RA1,"DT",RA2,"P",RA3,"CMOD",0)) WARN
 S RAX=0 ;del all cpt modifiers
 F  S RAX=$O(^RADPT(RA1,"DT",RA2,"P",RA3,"CMOD",RAX)) Q:'RAX  D
 . S RAROOT(70.3135,RAX_","_RA3_","_RA2_","_RA1_",",.01)="@"
 . D FILE^DIE("K","RAROOT")
 W !!?5,"All previous CPT Modifier(s) are deleted.",!
WARN Q:'$O(^RADPT(RA1,"DT",RA2,"P",RA3,"M","B",0)) 
 S RAX=0 ;warn of existing proc mods
 W !!?5,"Current Procedure Modifier(s) :"
 F  S RAX=$O(^RADPT(RA1,"DT",RA2,"P",RA3,"M",RAX)) Q:'RAX  W !?10,$P($G(^RAMIS(71.2,+^(RAX,0),0)),U)
 Q
ACTCODE(RA1,RA2) ;outputs CPT code active status
 ; output=1 active, =0 inactive
 ; RA1 = CPT CODE, internal or external
 ; RA2 = date to check CPT Code 
 N RA
 S RA=$$CPT^ICPTCOD(RA1,RA2)
 I $P(RA,"^",7)=1 Q 1
 Q 0
NAMCODE(RA1,RA2) ;outputs flds #.01 and #2  of CPT record
 ; RA1 = CPT CODE, internal or external
 ; RA2 = date to check CPT Code 
 N RA
 S RA=$$CPT^ICPTCOD(RA1,RA2)
 S:+RA=-1 RA=""
 S RA=$P(RA,"^",2,3)
 Q RA
BASICMOD(RA1,RA2) ; outputs basic modifier info
 ; RA1 = CPT MODIFIER, internal is used here
 ; RA2 = date to check CPT Modifier
 Q $$MOD^ICPTMOD(RA1,"I",RA2)
ACTMOD(RA1,RA2) ; outputs active status of CPT modifier
 ; RA1 = CPT MODIFIER, internal is used here
 ; RA2 = date to check CPT Modifier
 ; output: 
 ;        RA3 = 0 is inactive, >0 is active
 ;        RAMODSTR returned from call to MOD^ICPTMOD
 N RA3
 S RAMODSTR=$$MOD^ICPTMOD(RA1,"I",RA2)
 S RA3=+RAMODSTR
 S:RA3<0 RA3=0
 S:'$P(RAMODSTR,U,7) RA3=0
 Q RA3
SETDEFS ; set default CPT Modifiers, called by [RA REGISTER]
 ; 1st choice, defaults from file 71
 ; 2nd choice, defaults from file 79.1
 N RAROOT
 S RAROOT=$S($O(^RAMIS(71,+RAPRI,"DCM",0)):"^RAMIS(71,"_+RAPRI_",""DCM"",",$O(^RA(79.1,+RAMLC,"DCM",0)):"^RA(79.1,"_+RAMLC_",""DCM"",",1:"")
 Q:RAROOT=""
 N RA1,RA2,RA3,RAFDA,RAIEN,RAMSG
 Q:$O(^RADPT(RADFN,"DT",RADTI,"P",RACNI,"CMOD",0))  ;<--- ???
 S RA1=0,RA2=RACNI_","_RADTI_","_RADFN
LOOP1 K RAFDA,RAIEN,RAMSG ;clear arrays each time
 S RA1=$O(@(RAROOT_RA1_")")) Q:'RA1
 S RA3=+@(RAROOT_RA1_",0)")
 ; convert ien to external so Updater will validate data
 ; use DT because we're just getting the external value
 S RA3=$$BASICMOD(RA3,DT)
 G:+RA3<0 LOOP1 ; skip invalid CPT Modifier
 G:'$P(RA3,U,7) LOOP1 ; skip inactive CPT Modifier
 S RAFDA(70.3135,"+2,"_RA2_",",.01)=$P(RA3,U,2)
 D UPDATE^DIE("E","RAFDA","RAIEN","RAMSG")
 G:'$D(RAMSG) LOOP1
 W !!,$C(7),"** Unable to enter default CPT Modifier ",$P(RA3,U,2)," (",$P($P(RA3,U,3),"  "),") **",!
 G LOOP1
DISCMOD ; display existing CPT Modifiers
 Q:'$D(RADFN)  Q:'$D(RADTI)  Q:'$D(RACNI)
 N RA1,RA2,RA3 S RA1=0
 W:$O(^RADPT(RADFN,"DT",RADTI,"P",RACNI,"CMOD",RA1)) !
LOOP2 S RA1=$O(^RADPT(RADFN,"DT",RADTI,"P",RACNI,"CMOD",RA1)) Q:'RA1  S RA2=+^(RA1,0)
 S RA3=$$BASICMOD(RA2,DT)
 S:+RA3<0 RA3=""
 ; need parse with "  " to rid trailing blanks
 W !?6,$P(RA3,"^",2),?9,"(",$P($P(RA3,"^",3),"  "),") (",$S($P(RA3,"^",7)=1:"",1:"in"),"active)"
 G LOOP2
SDP(Y) ; SCREEN DEFAULT cpt mod for a PROCEDURE
 ; called from file 71's field 135's screen
 ; Y    = ien of file 81.3
 ; RACPT= CPT ien of this procedure
 ; RAX  = screen's outcome, 0=failed
 N RACPT,RAX,RA1,RA2,RA3
 S RACPT=+$P(^RAMIS(71,+$G(D0),0),U,9) I 'RACPT Q 0
 S RAX=$$MODP^ICPTMOD(RACPT,+Y,"I",DT) S:RAX<0 RAX=0
 Q RAX
SDL(Y) ; SCREEN DEFAULT cpt mod for a LOCATION
 ; called from file 79.1's field 135's screen
 ; Y    = ien of file 81.3
 ; RAX  = screen's outcome; 0=failed
 N RAX,RAMODSTR
 S RAX=$$ACTMOD(Y,DT) S:RAX<0 RAX=0
 Q RAX
DISDCM ;display existing Default CPT Modifers for procedure or location
 ; file 71 used if called from [RA PROCEDURE EDIT]
 ; file 79.1 used if called from [RA LOCATION PARAMETERS]
 Q:'($D(DA)#2)  Q:'$D(DIE)
 N RA1,RA2,RA3 S RA1=0
 D:DIE["79.1" WARNLOC
 I $O(@(DIE_DA_",""DCM"","_RA1_")")) W !
 F  S RA1=$O(@(DIE_DA_",""DCM"","_RA1_")")) Q:'RA1  S RA2=+^(RA1,0) S RA3=$$BASICMOD(RA2,DT) S:+RA3<0 RA3="" W !?6,$P(RA3,"^",2),?9,"(",$P($P(RA3,"^",3),"  "),")"
 Q
EHDP ; EXECUTABLE HELP for DEFAULT CPT MODIFIERS (PROC)
 N RATXT
 S RATXT(1)="     Choose a CPT Modifier that should be automatically stuffed"
 S RATXT(2)="     into the exam record with this procedure, during exam"
 S RATXT(3)="     registration."
 S RATXT(4)=" "
 D EN^DDIOL(.RATXT)
 Q
EHDL ; EXECUTABLE HELP for DEFAULT CPT MODIFIERS (LOC)
 D WARNLOC
 N RATXT
 S RATXT(1)="     Choose a CPT Modifier that should be automatically stuffed"
 S RATXT(2)="     into the exam record, when the following 2 conditions"
 S RATXT(3)="     are both met :"
 S RATXT(4)="       1-There is no default CPT Modifier for this exam's procedure."
 S RATXT(5)="       2-This location is the current sign-on (or switched-to) location"
 S RATXT(6)="         at the time of registration."
 S RATXT(7)="     If your entry is invalid, then during exam registration, this"
 S RATXT(8)="     Default CPT Modifier will NOT be stuffed, instead, an error message"
 S RATXT(9)="     with the name of the rejected CPT Modifier would be displayed."
 S RATXT(10)=" "
 D EN^DDIOL(.RATXT)
 Q
WARNLOC N RATXT
 S RATXT(1)="   +----------------------------------------------------------------+"
 S RATXT(2)="   | Your entry cannot be compared with a CPT CODE, so be very sure |"
 S RATXT(3)="   | that this is the Default CPT Modifier that you want to stuff   |"
 S RATXT(4)="   | into every registered exam from this imaging location.         |"
 S RATXT(5)="   +----------------------------------------------------------------+"
 D EN^DDIOL(.RATXT)
 Q
