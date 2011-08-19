RACPTCSV ;HISC/SWM - CPT Code Set Version ;2/23/04  09:03
 ;;5.0;Radiology/Nuclear Medicine;**38,46**;Mar 16, 1998
 Q
ACTC() ; find out if CPT CODE is active
 ; called from file 70.03 field 2's DIC("S")
 ; Y = ien file 71
 ; DA(2) = RADFN
 ; DA(1) = RADTI
 N RAACTIV,RA710,RACPT,RACPTNAM,RADT0,RAMSG,RADATE,RADATV
 N RATXT,RAI,RAX ; RATXT is local array of error text
 S RAACTIV=1 ; =1 no error, or CPT CODE is active
 S RAI=0 ; counter
 S RA710=^RAMIS(71,+Y,0)
 S RACPT=$P(RA710,U,9)
 I RACPT="",($P(RA710,U,6)="D")!($P(RA710,U,6)="S") D  S RAACTIV=0
 . S RAI=RAI+1
 . S RATXT(RAI)="** A Detailed or Series procedure is missing a CPT CODE.**"
 . Q
 S RADT0=^RADPT(DA(2),"DT",DA(1),0),RADATE=$P(RADT0,U)
 I $P(RA710,U,6)="P" D  S RAACTIV=0
 . S RAI=RAI+1
 . S RATXT(RAI)="** Procedure is a parent type. **"
 . Q
 I $D(^RAMIS(71,+Y,"I"))#2,^("I")'="",^("I")'>DT D  S RAACTIV=0
 . S RADATV=$$FMTE^XLFDT($P(^RAMIS(71,+Y,"I"),U),2) ; convert inact.dt
 . S RAI=RAI+1
 . S RATXT(RAI)="** Procedure is inactive since "_RADATV_". **"
 . Q
 I $P(RA710,U,12)'=$P(^RADPT(DA(2),"DT",DA(1),0),U,2) D  S RAACTIV=0
 . S RAI=RAI+1
 . S RATXT(RAI)="** Procedure's Imaging Type differs from Exam's Imaging Type. **"
 . Q
 S RADATV=$$FMTE^XLFDT(RADATE,2) ; convert Exam Date
 I RACPT,'$$ACTCODE^RACPTMSC(RACPT,RADATE) D  S RAACTIV=0
 . S RACPTNAM=$P($$NAMCODE^RACPTMSC(RACPT,RADATE),U)
 . S RAI=RAI+1
 . S RATXT(RAI)="** Procedure's CPT "_RACPTNAM_" is invalid for Exam Date "_RADATV_". **"
 .; if registering exam, and order is parent proc, display help message
 . I $D(RAOPT("REG")),$P($G(^RAMIS(71,+$P($G(^RAO(75.1,+$G(RAORDS(1)),0)),U,2),0)),U,6)="P" D
 .. S RAI=RAI+1
 .. S RATXT(RAI)="** Enter ""^"" to skip this descendent"
 .. S RAI=RAI+1
 .. S RATXT(RAI)="   or enter a procedure with an active CPT code. **"
 .. Q
 . Q
 I RAACTIV Q RAACTIV ; no errors flagged
 I '$D(RATXT) Q RAACTIV ; quit warning if no error text in local array
 ; X is what user typed, or is proc at // if user pressed return key
 I $E(RA710,1,$L(X))'=X Q RAACTIV ; quit warning if X'=prcnam begin chars
 I $P(^RAMIS(71,Y,0),U)'=X Q RAACTIV ; quit warning if lookup prcnam '= X
 ; if registering, quit warning if both met:
 ;  if user input matches order's procedure (frm descnd if parnt ordr)
 ;    if lookup IEN isn't same as order's proc's ien
 ; note:  RAPRC won't exist if procs added aftr descnts entered
 I $D(RAOPT("REG")),X=$G(RAPRC),Y'=$G(RAPROCI) Q RAACTIV
 S RAMSG=$P(RA710,U)
 D EN^DDIOL(RAMSG,,"!")
 S RAI=0
 F  S RAI=$O(RATXT(RAI)) Q:'RAI  S RAMSG=RATXT(RAI) D EN^DDIOL(RAMSG,,"!?4")
 S RAMSG=""
 D EN^DDIOL(RAMSG,,"!") ; put blank line after listing
 Q RAACTIV
FUTC() ; called from input templates [RA EXAM EDIT], [RA STATUS CHANGE]
 ; IF exam date is future to first Log Date:
 ;   check CPT CODE when/after that date arrives
 ;   and last Log Date isn't later than Exam Date
 ; assumes existing RADFN,RADTI,RACNI,RADTE
 ; RETURNS 0=inact.CPT Code, 1=active CPT Code
 N RADTEX,RARET,RALOG1,RALOGL,RA71,RACPTNAM,RAMSG,RAX
 S RARET=1 ; default return to 1 (active)
 S RAX=^RADPT(RADFN,"DT",RADTI,"P",RACNI,0) G:RAX="" FUTCQ
 S RADTEX=RADTE\1 ; date portion of RADTE
 S RALOG1=$O(^RADPT(RADFN,"DT",RADTI,"P",RACNI,"L",0)) G:'RALOG1 FUTCQ
 S RALOG1=+^RADPT(RADFN,"DT",RADTI,"P",RACNI,"L",RALOG1,0)\1 G:'RALOG1 FUTCQ ;dt portion 1st log date
 G:RALOG1'<RADTEX FUTCQ ;1st Log Date same/greater than Exam Date
 G:DT<RADTEX FUTCQ ; future Exam Date hasn't arrived yet
 S RALOGL=$O(^RADPT(RADFN,"DT",RADTI,"P",RACNI,"L",""),-1) G:'RALOGL FUTCQ
 S RALOGL=+^RADPT(RADFN,"DT",RADTI,"P",RACNI,"L",RALOGL,0)\1 ;dt portion last log date
 G:RALOGL'<RADTEX FUTCQ ;latest Log Date = OR > Exam Date
 ; now check CPT CODE from case record
 S RA71=$G(^RAMIS(71,+$P(RAX,U,2),0))
 S RARET=$$ACTCODE^RACPTMSC(+$P(RA71,"^",9),RADTE)
 I 'RARET D
 . S RACPTNAM=$P($$NAMCODE^RACPTMSC(+$P(RA71,"^",9),RADTE),U)
 . S RAMSG="*** Exam was registered with a future date, and since      ***"
 . D EN^DDIOL(RAMSG,,"!?4")
 . S RAMSG="*** registration, its CPT Code "_RACPTNAM_" has been inactivated. ***"
 . D EN^DDIOL(RAMSG,,"!?4")
 . S RAMSG="You must choose a procedure that has an active CPT Code."
 . D EN^DDIOL(RAMSG,,"!!?4")
 . D EN^DDIOL(" ",,"!?4")
 . Q
FUTCQ ;
 Q RARET
FUTCMOD() ; called from input templates [RA EXAM EDIT], [RA STATUS CHANGE]
 ; IF exam date is future to first Log Date:
 ;   check CPT Modifier when/after that date arrives
 ;   and last Log Date isn't later than Exam Date
 ; assumes existing RADFN,RADTI,RACNI,RADTE
 ; RETURNS 0=at least one CPT Mod is inactive, 1=all CPT Mods active
 N RADTEX,RARET,RALOG1,RALOGL,RA813,RAMSG,RA0,RA1,RAX,RAMODSTR
 S RARET=1 ;default return value to 1
 G:'$O(^RADPT(RADFN,"DT",RADTI,"P",RACNI,"CMOD",0)) FUTCMODQ ; no cpt mod entered
 S RADTEX=RADTE\1 ; date portion of RADTE
 S RALOG1=$O(^RADPT(RADFN,"DT",RADTI,"P",RACNI,"L",0)) G:'RALOG1 FUTCMODQ
 S RALOG1=+^RADPT(RADFN,"DT",RADTI,"P",RACNI,"L",RALOG1,0)\1 G:'RALOG1 FUTCMODQ ;dt portion 1st log date
 G:RALOG1'<RADTEX FUTCMODQ ; 1st Log date same/greater than Exam Date
 G:DT<RADTEX FUTCMODQ ; future Exam Date hasn't arrived yet
 S RALOGL=$O(^RADPT(RADFN,"DT",RADTI,"P",RACNI,"L",""),-1) G:'RALOGL FUTCMODQ
 S RALOGL=+^RADPT(RADFN,"DT",RADTI,"P",RACNI,"L",RALOGL,0)\1 G:'RALOGL FUTCMODQ ;dt portion last log date
 G:RALOGL'<RADTEX FUTCMODQ ;latest Log Date = OR > Exam Date
 ; now check all CPT Mods from case record
 S RA1=0 F  S RA1=$O(^RADPT(RADFN,"DT",RADTI,"P",RACNI,"CMOD",RA1)) Q:'RA1  D
 . S RAX=+^RADPT(RADFN,"DT",RADTI,"P",RACNI,"CMOD",RA1,0)
 . S RA0=$$ACTMOD^RACPTMSC(RAX,RADTE)
 . I 'RA0 S RARET=0 D
 .. S RAMSG="Exam was registered with a future date, and since registration,"
 .. D EN^DDIOL(RAMSG,,"!?4")
 .. S RAMSG=$P(RAMODSTR,"^",2)_" "_$P(RAMODSTR,"^",3)_" has been inactivated."
 .. D EN^DDIOL(RAMSG,,"!?4")
 .. Q
 . Q
 I 'RARET D EN^DDIOL("You must delete the inactive CPT Modifier(s) before you can continue.",,"!?4")
FUTCMODQ ;
 Q RARET
 ;
