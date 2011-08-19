RAO7UTL ;HISC/GJC,SS-Utilities for HL7 messages. ;9/5/97  08:55
 ;;5.0;Radiology/Nuclear Medicine;**18,45,57,82**;Mar 16, 1998;Build 8
 ;modified by SS JUN 19,2000 for P18
EN1 ; Entry point to define some basic HL7 variables
 N I S RAHLFS="|",RAECH="^~\&"
 S $P(RAHLFS(0),RAHLFS,51)=""
 F I=1:1:$L(RAECH) S RAECH(I)=$E(RAECH,I)
 Q
 ;
CMEDIA(IEN,RAPTYPE) ;Called from RAO7MFN when a procedure is updated
 ;Input: IEN=ien of proc. in file 71
 ;   RAPTYPE=procedure type; broad, parent, series, or detailed.
 ;Return: J=a string with some combination of the following indicators:
 ;I for Iodinated ionic, N for Iodinated non-ionic, L for Gadolinium
 ;C for Oral Cholecystographic, G for Gastrografin, B for Barium or
 ;NULL if none of the indicators apply to this procedure.
 ;
 ;'Broad' procedures have no contrast media definition, return null
 Q:RAPTYPE="B" ""
 ;if 'detailed' or 'series' & no contrast media data return null
 I RAPTYPE'="P",'($O(^RAMIS(71,IEN,"CM",0))) Q ""
 NEW I,INA,J S J=""
 I RAPTYPE="P" D
 .S I=0 F  S I=$O(^RAMIS(71,IEN,4,I)) Q:'I  D
 ..S I(0)=+$G(^RAMIS(71,IEN,4,I,0)) Q:'I(0)
 ..S INA=$P($G(^RAMIS(71,I(0),"I")),"^")
 ..S INA=$S(INA="":1,INA>DT:1,1:0)
 ..D:INA NONPAR(I(0))
 ..Q
 .Q
 E  D NONPAR(IEN)
 Q J
 ;
NONPAR(IEN) ;obtain contrast media data for a 'detailed' or 'series' proc
 ; Input: IEN=ien of the non-parent, non-broad procedure
 ;Return: J=data string (return)
 ;variable definition: I=ien of sub-file rec
 NEW H,I S I=0
 F  S I=$O(^RAMIS(71,IEN,"CM",I)) Q:I'>0  D
 .S H=$P($G(^RAMIS(71,IEN,"CM",I,0)),U) Q:H=""
 .S:J'[H J=J_H
 .Q
 Q
 ;
MSH(X) ; Set up the 'MSH' segment.
 ; 'X' is passed in and identifies the message type.
 S:X']"" X="Message Type Error"
 Q "MSH"_RAHLFS_RAECH_RAHLFS_"RADIOLOGY"_RAHLFS_$P($G(^DIC(4,+$G(DUZ(2)),99)),"^")_$$STR(3)_$$HLDATE^HLFNC($$NOW^XLFDT(),"TS")_$$STR(2)_X
 ;
MSA(X,Y) ; Set up the 'MSA' segment. P18 
 ; 'X' is passed in and identifies the message ID.
 ; 'Y' is acknowledgement code
 S:X']"" X="Message ID Error"
 Q "MSA"_RAHLFS_Y_RAHLFS_$E(X,1,20)_$$STR(4)
MFI(X) ; Set up the 'MFI' segment
 S @(RAVAR_RACNT_")")="MFI"_RAHLFS_RAFNUM
 S @(RAVAR_RACNT_")")=@(RAVAR_RACNT_")")_RAECH(1)_RAFNAME_RAECH(1)
 S @(RAVAR_RACNT_")")=@(RAVAR_RACNT_")")_"99DD"_RAHLFS_RAHLFS_X ;P18
 S @(RAVAR_RACNT_")")=@(RAVAR_RACNT_")")_RAHLFS_RAHLFS_RAHLFS_"ER"
 X RAINCR ; increment counter
 Q
PID(Y) ; Create 'pid' segment
 Q "PID"_$$STR(3)_+$P(Y,"^")_$$STR(2)_$P($G(^DPT(+$P(Y,"^"),0)),"^")
 ;
PV1(Y) ; Create 'pv1' segment
 ;Input: Y=zero node of the RAD/NUC MED ORDERS (#75.1) file
 N DFN,RA,RARMBED,RAWARD,VAIP,RAPF
 S DFN=+$P(Y,"^"),VAIP("D")=$P(Y,"^",21)
 S RA("PV1",2)="O",RA("PV1",3)=+$P(Y,"^",22)
 D IN5^VADPT S RAWARD=$G(VAIP(5)),RARMBED=$G(VAIP(6))
 I RAWARD]"" D
 . S RA("PV1",2)="I",RAWARD(44)=$P($G(^DIC(42,+RAWARD,44)),"^")
 . S RA("PV1",3)=+RAWARD(44)_U_$P(RARMBED,"^",2)
 . Q
 S RAPF="PV1"_$$STR(2)_RA("PV1",2)_RAHLFS_RA("PV1",3)_$$STR(16) ;_"Visit #" was truncated for P18   ? Req 4
 D PV1^RABWIBB
 ; pv1^RABWIBB will redefine RAPF if the PFSS switch is on and there's a valid PFSS Account Reference
 ; Otherwise, RAPF won't be changed
 K RACCOUNT ; this variable was set earlier in FB^RABWIBB
 Q RAPF
 ;
PURGE K RAHLFS,RACNT,RAECH,RAFNAME,RAFNUM,RAINCR,RASUB,RATSTMP,RAVAR,RAXIT
PURGE1 ; kill only whole file update variables
 K RA71,RA713,RACMCODE,RACMNOR,RACOST,RACPT,RAIEN71,RAIMGAB,RAMFE,RAMULT
 K RAPHYAP,RAPRCTY,RAXT71
 Q
DIAG(X,Y,Z) ; Pass back an "A" if any Dx code has 'Yes' in the 'Generate
 ;         Abnormal Alert' field.
 N A,AAH,RA7003,RA783 S AAH=""
 S RA7003=$G(^RADPT(X,"DT",Y,"P",Z,0)),RA7003(13)=+$P(RA7003,"^",13)
 S RA783(0)=$G(^RA(78.3,RA7003(13),0))
 S RA783(4)=$$UP^XLFSTR($P(RA783(0),"^",4))
 S:RA783(4)="Y" AAH="A"
 Q:AAH]"" AAH
 S A=0 F  S A=$O(^RADPT(X,"DT",Y,"P",Z,"DX",A)) Q:A'>0  D  Q:AAH]""
 . S RA783=+$G(^RADPT(X,"DT",Y,"P",Z,"DX",A,0))
 . S RA783(0)=$G(^RA(78.3,RA783,0))
 . S RA783(4)=$$UP^XLFSTR($P(RA783(0),"^",4))
 . I RA783(4)="Y" S AAH="A"
 . Q
 Q AAH
PROCNDE(X) ; Check if the procedure has both an I-Type & Proc. Type
 ;         assigned. Pass back '1' if either the I-Type -or- Proc. Type
 ;         data is missing.  '0' if everything is ok.
 I $P(X(0),U,6)]"",($P(X(0),U,12)]"") Q 0
 Q 1
STR(X) ; Pass back a predetermined # of '|' or other field separator
 Q:$G(RAHLFS(0))']""!(+X=0) "" ; Quit if parent string i.e, 'RAHLFS(0)'
 ;                               does not exist or +X evaluates to null.
 ;
 S:X<0 X=$$ABS^XLFMTH(X) ;       If passed in negative, take absolute
 ;                               value.  Quit if 'X' is greater than the
 ;                               length of our parent string.
 ;
 S:X["." X=X\1 ;                 If a non-integer, remove mantissa.
 ;
 Q:X>($L(RAHLFS(0))) "" ;        If parameter greater than length of
 ;                               string, pass back null.
 Q $E(RAHLFS(0),1,X)
 ;
CHKUSR(RADUZ) ; Check user status to 'DC' an order.
 ; pass back '0' if non-active Rad/Nuc Med user
 ; pass back '1' if active Rad/Nuc Med user
 N RAINADT S RAINADT=+$P($G(^VA(200,RADUZ,"PS")),"^",4) ;inactivation DT
 Q $S('($D(RADUZ)#2):0,'$D(^VA(200,RADUZ,0)):0,'$D(^("RAC")):0,'RAINADT:1,'$D(DT):0,DT'>RAINADT:1,1:0)
 ;
ERR(RATXT,RAMSG,RAVAR) ; Call CPRS utility to log 'soft' errors.
 ; Input: RATXT-text description of the error
 ;        RAMSG-HL7 message array
 ;        RAVAR-variables to be saved off
 D EN^ORERR(RATXT,.RAMSG,.RAVAR)
 Q
 ;
MSG(RAPROTO,RAMSG) ; ship HL7 messages to CPRS from this entry point
 ; input: RAPROTO - protocol to execute
 ;          RAMSG - message (in HL7 format)
 D MSG^XQOR(RAPROTO,.RAMSG)
 Q
 ;
UPDATP(RAY) ;update the parent procedure when a descendent is
 ;updated. Called from RAMAIN2 (procedure entry/edit)
 ;input: RAY=ien of desc.^name of desc. (if existing record)
 ;       RAY=ien of desc.^name of desc.^1 (if new record)
 W !!,$P(RAY,U,2)_" is a descendent procedure, updating parent(s)..."
 N RAPIEN,RAQUIT S (RAPIEN,RAQUIT)=0
 F  S RAPIEN=$O(^RAMIS(71,"ADESC",+RAY,RAPIEN)) Q:'RAPIEN  D  Q:RAQUIT
 .S RAPIEN(0)=$G(^RAMIS(71,RAPIEN,0))
 .W !?2,"Updating parent: "_$E($P(RAPIEN(0),U),1,50)
 .S RAPIEN("I")=$P($G(^RAMIS(71,RAPIEN,"I")),"^")
 .S RAPIEN("S")=$S(RAPIEN("I")="":1,RAPIEN("I")>DT:1,1:0)
 .L +^RAMIS(71,RAPIEN):300
 .I '$T S RAQUIT=1 D  Q
 ..W !?2,"Parent Procedure: "_$E($P(RAPIEN(0),U),1,50)
 ..W !?2,"being edited by another user, try again later!",$C(7)
 ..Q
 .D PROC^RAO7MFN(0,71,RAPIEN("S")_"^"_RAPIEN("S"),RAPIEN)
 .L -^RAMIS(71,RAPIEN)
 .Q
 Q
 ;----------------------------
 ;called from 
 ;-Case # edit  START1+16^RAEDCN
 ;-Edit by patient
 ;-Tracking
 ;Saves proc ien before editing, locate the exam by patient, datetime and caseN 
SVBEFOR(RAPATN,RAINVDT,RACIEN) ;P18;send radfn,radti,racni (instead of racn and new sequencing of params
 ; RAPRIEN() holds "before" values
 N RADATA,RAX,RA0,RA1,RA2,RA3
 S RADATA=$G(^RADPT(RAPATN,"DT",RAINVDT,"P",RACIEN,0))
 Q:RADATA=""  ;failure
 ; don't check parent here, since still need compare Req Phys & Proc Mods
 S RAPRIEN=$P(RADATA,"^",2) ; procedure ien
 S RAPRIEN(1)=RAPATN ; dfn
 S RAPRIEN(2)=RAINVDT ; inverse date exm
 S RAPRIEN(3)=RACIEN ; case ien
 S RAPRIEN(4)=$P(RADATA,"^",14) ; req phy
 D STR70^RAUTL10(.RAX,RAPATN,RAINVDT,RACIEN)
 S RAPRIEN(5)=RAX ; string of proc mods
 ; send "XX" if diffcs in Req.Phy &/or Proc Mods
 ; Next lines are for RA*5*82
 ; Save CPT modifiers before editing
 S RAX=0 K RAPRIEN("CMOD")
 F  S RAX=$O(^RADPT(RAPATN,"DT",RAINVDT,"P",RACIEN,"CMOD",RAX)) Q:'RAX  S RAPRIEN("CMOD",RAX)=+$G(^(RAX,0))
 ; Save Tech comments before editing
 S RAX=0 K RAPRIEN("TCOM")
 F  S RAX=$O(^RADPT(RAPATN,"DT",RAINVDT,"P",RACIEN,"L",RAX)) Q:'RAX  S RAPRIEN("TCOM",RAX)=$G(^(RAX,"TCOM"))
 Q  ;OK
