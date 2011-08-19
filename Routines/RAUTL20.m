RAUTL20 ;HISC/SWM-Utility Routine ;6/16/97  14:27
 ;;5.0;Radiology/Nuclear Medicine;**5,34**;Mar 16, 1998
 ;
EN1 ; for displaying  +  and  .   during case lookup
 S RAPRTSET=0
 Q:'$D(RADFN)!('$D(RADTI))!('$D(RACNI))
 Q:RADFN=""!(RADTI="")!(RACNI="")
 ; output : RAPRTSET=1 : case is part of a combined PRINTset, & flag it
 ;          RAMEMLOW=1 : case is lowest ien of print set AND flag it
 N RA1,RA2,RA3,RA4,RA5,RA6,RA7,RACN S RA1="",RA3="A",RA5=0
 S RACN=+$G(^RADPT(RADFN,"DT",RADTI,"P",RACNI,0))
 S RAMEMLOW=0
 S RAPRTSET=$P($G(^RADPT(RADFN,"DT",RADTI,"P",RACNI,0)),"^",25)=2
 Q:'RAPRTSET
 ; put  +  infront of lowest ien of case that has MEMBER OF SET = 2
 F  S RA1=$O(^RADPT(RADFN,"DT",RADTI,"P",RA1)) Q:RA1=""  Q:$P($G(^(RA1,0)),U,25)=2  ; RA1 is at lowest ien with MEMBER OF SET = 2
 S:RACNI=RA1 RAMEMLOW=1
 S RA1="" F  S RA1=$O(^RADPT(RADFN,"DT",RADTI,"P","B",RA1)) Q:RA1=""  D LOOP1
 I RA5 S RAPRTSET=0,RAMEMLOW=0 ;don't display if ptrs to #74 differ within set
 Q
LOOP1 ; RA1=  : for-loop var
 ; RA2=  : (1) ien for 70.03  (2) also, pointer value to file #74
 ; RA3=  : holds earliest case with pointer value to file #74
 ; RA4=  : (ienof #70.03)=case number^procedure pointers^ptr #74
 ; RA5=0 : all cases in set point to same non-null rarpt() or all null
 ;         regardless of cancelled status
 ; RA5<>0: one or more cases in set point to different rarpt()
 ; RA6=  : pointer to file #72 examination status
 ; RA7=1 : denote call of LOOP1 came from EN2 and not from EN1
 S RA2=$O(^RADPT(RADFN,"DT",RADTI,"P","B",RA1,0))
 ; skip rec if it's not part of combined report
 Q:$P(^RADPT(RADFN,"DT",RADTI,"P",RA2,0),"^",25)'=2
 S:$G(RA7) RA4=RA2,RA4(RA4)=RA1
 S RA2=$P(^RADPT(RADFN,"DT",RADTI,"P",RA2,0),"^",17),RA6=$P(^(0),"^",3) S:$G(RA7) RA4(RA4)=RA4(RA4)_"^"_$P(^(0),"^",2)_"^"_$P(^(0),"^",17)_"^"_$P(^(0),"^",3)
 ; skip if exm canc'd & exm's pc 17 is null
 I $P($G(^RA(72,+RA6,0)),"^",3)=0,RA2="" Q
 S:RA3="A" RA3=RA2
 I RA5=0,RA2]"" S RA5=RA2-RA3
 Q
EN2(RA4) ; display all print members' procs during report editing/printg
 S RAPRTSET=0
 Q:'$D(RADFN)!('$D(RADTI))!('$D(RACNI))
 Q:RADFN=""!(RADTI="")!(RACNI="")
 ; output : RA4(IEN OF #70.03)=CASE NUMBER^IEN OF #71 (procedure)^ptr #74
 ;                            ^exm stat
 ;          RAPRTSET = 1 : case is part of a combined PRINTset
 N RA1,RA2,RA3,RA5,RA6,RA7 S RA1="",RA3="A",RA5=0,RA7=1
 F  S RA1=$O(RA4(RA1)) Q:RA1=""  K RA4(RA1) ;clean up array
 S RAPRTSET=$P($G(^RADPT(RADFN,"DT",RADTI,"P",RACNI,0)),"^",25)=2
 Q:'RAPRTSET
 F  S RA1=$O(^RADPT(RADFN,"DT",RADTI,"P","B",RA1)) Q:RA1=""  D LOOP1
 I RA5 S RAPRTSET=0 ;don't display if ptrs to #74 differ within set
 Q
EN3(RA4) ; for print set, AFTER record is created in rarpt()
 Q:'$D(RADFN)!('$D(RADTI))
 Q:RADFN=""!(RADTI="")
 ; output :RA4(IEN OF #70.03)=CASE NUMBER  (ONLY THOSE CASES FROM #74.05)
 N RA1,RA2,RA3,RA5 S RA1="",RA3="A"
 F  S RA1=$O(RA4(RA1)) Q:RA1=""  K RA4(RA1) ;clean up array
 S RA5=$S($G(RARPT):RARPT,$G(RAIEN):RAIEN,1:0) Q:RA5=0
 F  S RA1=$O(^RARPT(RA5,1,"B",RA1)) Q:RA1=""  S RA2=$P(RA1,"-",2),RA3=$O(^RADPT(RADFN,"DT",RADTI,"P","B",RA2,0)),RA4(RA3)=RA2
 Q
XPRI ;loop thru sub-file #74.05 to set/kill prim. xref for other prt members
 Q:'$D(RADFNZ)!('$D(RADTIZ))!('$D(RARAD))!('$D(RAXREF))!('$D(DA))
 Q:$O(^RARPT(DA,1,"B",0))=""
 N RA1,RA200 S RA1=""
XPRI1 S RA1=$O(^RARPT(DA,1,"B",RA1)) Q:RA1=""
 S RACNIZ=$O(^RADPT(RADFNZ,"DT",RADTIZ,"P","B",$P(RA1,"-",2),0))
 G:'$D(^RADPT(RADFNZ,"DT",RADTIZ,"P",RACNIZ,0)) XPRI1 S RA200=+$P(^(0),"^",RARADOLD) ; use raradold to get piece number in "p" node
 G XPRI1:'RA200
 S:$D(RASET) ^RARPT(RAXREF,RA200,DA)=""
 K:$D(RAKILL) ^RARPT(RAXREF,RA200,DA)
 G XPRI1
XSEC ;loop thru sub-file #74.05 to set/kill sec. xref for other print members
 Q:'$D(RADFNZ)!('$D(RADTIZ))!('$D(RASECOND))!('$D(RAXREF))!('$D(DA))
 Q:$O(^RARPT(DA,1,"B",0))=""
 N RA1,RA2,RA200 S RA1=""
XSEC1 S RA1=$O(^RARPT(DA,1,"B",RA1)) Q:RA1=""
 S RACNIZ=$O(^RADPT(RADFNZ,"DT",RADTIZ,"P","B",$P(RA1,"-",2),0))
 G:'$D(^RADPT(RADFNZ,"DT",RADTIZ,"P",RACNIZ,0)) XSEC1 G:'$D(^(RASECOND,0)) XSEC1
 S RA2=0
XSEC2 S RA2=$O(^RADPT(RADFNZ,"DT",RADTIZ,"P",RACNIZ,RASECOND,RA2)) G:'+RA2 XSEC1 S RA200=+$G(^(RA2,0))
 G:'RA200 XSEC2
 S:$D(RASET) ^RARPT(RAXREF,RA200,DA)=""
 K:$D(RAKILL) ^RARPT(RAXREF,RA200,DA)
 G XSEC2
FLAGMEM() ;in distr list, print + if case is part of a print set
 ; called from File #74's print templates
 N RA1 S RA1=""
 I '$D(D0) Q RA1
 S RA1=$P($G(^RABTCH(74.4,D0,0)),U) I RA1="" Q RA1
 S RA1=$O(^RARPT(RA1,1,"B",0)) S:RA1]"" RA1="+"
 Q RA1
DELPNT(RADFN,RADTI,RACNI) ; When an exam is cancelled & it is associated
 ; with data in the Nuc Med Exam Data file (70.2) ask the user if this
 ; pointer to 70.2 is to be deleted.  Also delete the flag which
 ; indicates that the dosage ticket had printed for this exam.
 ; Called from CANCEL^RAEDCN
 ; Input: RADFN - Internal Entry Number (IEN) of the Patient.
 ;        RADTI - Date/Time of the examination (inverse format)
 ;        RACNI - IEN of the exam for this date/time
 ;
 ;- Delete entry in 'Dosage Ticket Printed?' field DD: 70.03, field: 29 -
 N RAFDA S RAFDA(70.03,RACNI_","_RADTI_","_RADFN_",",29)="@"
 D FILE^DIE("","RAFDA")
 ;----------------------------------------------------------------------
 Q:'+$P(^RADPT(RADFN,"DT",RADTI,"P",RACNI,0),"^",28)  ;no NucMed Xam data
 K RAFDA N RAYN
 F  D  Q:RAYN]""
 . R !!?3,"Do you wish to delete the radiopharmaceutical data associated",!?3,"with this exam? No//",RAYN:DTIME
 . I RAYN["^"!('$T) S RAYN="^" Q  ;don't delete pntr if '^' or timeout
 . S RAYN=$E(RAYN) S:RAYN="" RAYN="N"
 . S RAYN=$$UP^XLFSTR(RAYN) Q:RAYN="N"  ;exit, don't del 70.2 pnt
 . I RAYN="Y" D  Q  ; delete the pointer to 70.2, then quit
 .. N RAFDA S RAFDA(70.03,RACNI_","_RADTI_","_RADFN_",",500)="@"
 .. D FILE^DIE("","RAFDA")
 .. ; NOTE: This silent FileMan call not only deletes the pointer to
 .. ;       the entry in the Nuc Med Exam Data file (70.2), but the
 .. ;       entry in 70.2 itself. This is because a M X-Ref exists on
 .. ;       the field which points to file 70.2 that also deletes the
 .. ;       entry in the Nuc Med Exam Data file.  Please refer to
 .. ;       ^DD(70.03,500,.. for more information.
 .. Q
 . W !!?3,"Enter 'Yes' to delete the radiopharmaceutical data associated with this exam.",!?3,"Enter 'No' to preserve the radiopharmaceutical data associated with this",!?3,"exam.  "
 . W "Enter '^' to exit without deleting the radiopharmaceutical data",!?3,"associated with this exam.",$C(7)
 . S RAYN=""
 . Q
 Q
