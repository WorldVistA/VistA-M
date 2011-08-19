RADD1 ;HISC/FPT-Radiology Utility Routine ;6/2/98  16:17
 ;;5.0;Radiology/Nuclear Medicine;**1,5,10,65,94**;Mar 16, 1998;Build 9
 ;
 ;Supported IA #10142 reference to EN^DDIOL
 ;Supported IA #10103 reference to FMADD^XLFDT
 ;
SECXREF ; sets/kills 'ARES' & 'ASTF' x-refs for secondary resident/staff rads
 ; called from ^DD(74,5
 ;
 Q:'$D(^RARPT(DA,0))  S RADFNZ=^(0)
 S RADTIZ=9999999.9999-$P(RADFNZ,"^",3),RACNIZ=$O(^RADPT(+$P(RADFNZ,"^",2),"DT",RADTIZ,"P","B",+$P(RADFNZ,"^",4),0)),RADFNZ=+$P(RADFNZ,"^",2)
 I 'RACNIZ D KILL Q
 I '$D(^RADPT(RADFNZ,"DT",RADTIZ,"P",RACNIZ,0)) D KILL Q
 I '$D(^RADPT(RADFNZ,"DT",RADTIZ,"P",RACNIZ,RASECOND,0)) D KILL Q
 S RASECIEN=0
 F  S RASECIEN=$O(^RADPT(RADFNZ,"DT",RADTIZ,"P",RACNIZ,RASECOND,RASECIEN)) Q:RASECIEN<1  S RARAD=+$P($G(^(RASECIEN,0)),"^",1) I RARAD>0 D
 .S:$D(RASET) ^RARPT(RAXREF,RARAD,DA)="" K:$D(RAKILL) ^RARPT(RAXREF,RARAD,DA)
 D XSEC^RAUTL20
KILL K RACNIZ,RADFNZ,RADTIZ,RASECOND,RASECIEN
 Q
SCDTC ; status change date/time check
 ; called from ^DD(70.05,.01
 ; if X is a date/time prior to the exam date/time, then set Y=0.
 ; if X is a over a minute in the future, then set Y=0.
 ; if X is missing the time portion, then set Y=0.
 I '($D(X)#2) Q
 I '$F(X,".") D EN^DDIOL("** Time is Required **","","!!?20") S Y=0 Q
 N RASTATUS,RAORDNUM,RAPLUS1
 ; eg. da(3)=1128, da(2)=7028970.8743,da(1)=1,da=1
 S RASTATUS=$P($G(^RADPT(+$G(DA(3)),"DT",+$G(DA(2)),"P",+$G(DA(1)),0)),U,3)
 S RAORDNUM=$P($G(^RA(72,+RASTATUS,0)),U,3)
 I X<(9999999.9999-$G(DA(2))),RAORDNUM>1 S Y=0 Q
 S RADTHOLD=X
 D NOW^%DTC
 ; 2/25/98 allow entry to be at most 1 minute after current time
 S RAPLUS1=%,RAPLUS1=$$FMADD^XLFDT(RAPLUS1,0,0,1,0)
 I RADTHOLD>RAPLUS1 S Y=0
 S X=RADTHOLD
 K RADTHOLD
 Q
 ;
PDC() ; do not enter secondary into primary diagnostic code field
 ; called from ^DD(70.03,13,0)
 ; do not select inactive diagnostic code 12/23/96
 ;P94 - IF changed to a post-conditional
 Q:$P(^RA(78.3,+Y,0),U,5)="Y" 0
 Q:$D(^RADPT(DA(2),"DT",DA(1),"P",DA,"DX","B",+Y)) 0
 Q 1
 ;
SDC() ; do not enter primary into secondary diagnostic code field
 ; called from ^DD(70.14,.01,0)
 ; do not select inactive diagnostic code 12/23/96
 I $P(^RA(78.3,+Y,0),U,5)="Y" Q 0
 I '$D(X)!('$D(DA(3))) G SDC2
 I '$D(^RADPT(DA(3),"DT",DA(2),"P",DA(1),0)) G SDC2
 I $P(^RADPT(DA(3),"DT",DA(2),"P",DA(1),0),"^",13)=+Y Q 0
 Q 1
SDC2 ;
 I '$D(X)!('$D(DA(2))) G SDC3
 I '$D(^RADPT(DA(2),"DT",DA(1),"P",DA,0)) Q 0
 I $P(^RADPT(DA(2),"DT",DA(1),"P",DA,0),"^",13)=+Y Q 0
 Q 1
SDC3 ;
 I '$D(RADFN) Q 0
 S DA(2)=RADFN
 I '$D(^RADPT(DA(2),"DT",DA(1),"P",DA,0)) Q 0
 I $P(^RADPT(DA(2),"DT",DA(1),"P",DA,0),"^",13)=+Y Q 0
 Q 1
 ;
NODEL ; Do not permit deletion of the PRIMARY DIAGNOSTIC CODE (70.03,
 ; 13), PRIMARY INTERPRETING RESIDENT (70.03,12) or PRIMARY
 ; INTERPRETING STAFF (70.03,15) if a SECONDARY DIAGNOSTIC CODE
 ; multiple (70.03,13.1) is associated with the exam record.
 ; 
 ; P94: WRITE removed; EN^DDIOL added
 ;
 ;Note: the IF statement has to remain because $T needs to be
 ;set in order to properly influence the "DEL" node.
 ;
 S RASECCHK=0,RASECCHK=$O(^RADPT(DA(2),"DT",DA(1),"P",DA,RAMULT,RASECCHK))
 I RASECCHK D EN^DDIOL("   Required","","?0")
 K RAMULT,RASECCHK
 Q
 ;
PRCCPT() ; Displays the procedure type and CPT code if applicable.
 ; This code is called from ^DD(71,0,"ID","WRITE") and rtn RAPROD
 N RA,RATXT S RA(0)=$G(^(0)),RA("I")=+$G(^("I")),RATXT=""
 S RA=$S('RA("I"):0,DT'>RA("I"):0,1:1)
 S RA(6)=$P(RA(0),U,6),RA(9)=$P(RA(0),U,9)
 S RA(12)=$P(RA(0),U,12) I 'RA(12) S RA(10)="UNKN "
 I '$D(RA(10)) S RA(10)=$P(^RA(79.2,+RA(12),0),U,3)_" "
 I $L(RA(10))<5 F  S RA(10)=RA(10)_" " Q:$L(RA(10))>4
 S RATXT="("_RA(10)_$S(RA:"Inactive",RA(6)="B":"Broad   ",RA(6)="D":"Detailed",RA(6)="P":"Parent  ",RA(6)="S":"Series  ",1:"Unknown ")_")"
 S:RA(9)]"" RATXT=RATXT_" CPT:"_$P($$NAMCODE^RACPTMSC(RA(9),DT),"^")
 Q RATXT
INDTCHK(RADA) ; Cannot inactivate a procedure if it is a common procedure
 ; with a valid sequence number.  Code resides in ^DD(71,100,0)!
 ; 'RADA' is the ien of the procedure in file 71.  if this procedure is
 ; a common procedure i.e, $D(^RAMIS(71.3,"B",RADA)) inform the user that
 ; the sequence number must be deleted.  This relies on the "AA" xref in
 ; the Common Proc. file for the Sequence # fld (#3) 0 node, 4th pce.
 N RA,RAIEN S RAIEN=+$O(^RAMIS(71.3,"B",RADA,0))
 S RA(0)=$G(^RAMIS(71.3,RAIEN,0)) Q:RA(0)']""
 S RA(4)=+$P(RA(0),"^",4) ; obtain the sequence number
 I $D(^RAMIS(71.3,"AA",$$EN3^RAUTL17(RADA),RA(4),RAIEN)) D  ; sequence #?
 . N RATXT S RATXT(1)=" "
 . S RATXT(2)="   Cannot inactivate - this procedure is currently in the"
 . S RATXT(3)="   Rad/Nuc Med Common Procedure file with a sequence"
 . S RATXT(4)="   number.  Please remove the sequence number thru the"
 . S RATXT(5)="   'Common Procedure Enter/Edit' option before assigning"
 . S RATXT(6)="   an inactivation date to this procedure."
 . S RATXT(7)="   "
 . D EN^DDIOL(.RATXT) K X ; display message, can't input ANY date!
 . Q
 Q
CPTCHK(RADA) ; Check if the CPT code is inactive nationally.
 ; 'RADA' assume the value of +Y passed from the input xform, ^DD(71,9,0)
 ; quit if CPT code is active
 ;
 Q:$$ACTCODE^RACPTMSC(RADA,DT)
 N RATXT S RATXT(1)=" "
 S RATXT(2)="   Warning - Nationally inactive CPT code."
 S RATXT(3)=" " D EN^DDIOL(.RATXT)
 K X
 Q
 ;
VALADM(RAD0,Y,RADT,RAUTH) ;edit validation
 ;Used to validate/screen radiopharm dosage administrator,
 ;   radiopharm prescribing phys, person who measured radiopharm dose,
 ;----------------------------------------------------------------------
 ; RAD0  : IEN of entry in question for NUC MED EXAM DATA (70.2) file
 ; Y     : Pointer to the New Person file
 ; RADT  : Xam Date; if not passed, calculate exam date from file 70.2
 ; RAUTH : 1 - only staff/resid, must be auth'zd to write med orders
 ;       : 0 - staff/resid & tech's
 ;----------------------------------------------------------------------
 ; Output: '1' authorized to write med orders, else '0'
 ;----------------------------------------------------------------------
 Q $$VALADM^RADD4()
 ;
VOL(RAX) ; Validate the format of the value input for volume.
 ; RAX must be a number followed by a space then text -or-
 ; a number followed by text
 ; Input Variable : 'RAX'- user's input
 ; Output Variable: null if 'RAX' erroneous, formatted version of 'RAX'
 Q $$VOL^RADD4()
