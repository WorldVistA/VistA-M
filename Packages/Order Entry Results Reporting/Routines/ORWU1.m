ORWU1 ;SLC/GRE - General Utilities for Windows Calls [2/25/04 11:10am]
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**149,187,195,215**;Dec 17, 1997
 ;
 Q
 ;
NP1 ; Return a set of names from the NEW PERSON file.
 ; (PKS/8/5/2003: Now called by NEWPERS^ORWU; internal mods made.)
 ; (Keep GETCOS^ORWTPN up to date with matching logic/code, too.)
 ;
 ; PARAMS from NEWPERS^ORWU call:
 ;  .ORY=returned list.
 ;  ORDATE=Checks for an active person class on this date (optional).
 ;  ORDIR=Direction to move through the x-ref with $O.  
 ;  ORFROM=Starting name for this set.
 ;  ORKEY=Screen users by security key (optional).
 ;  ORVIZ=If true, includes RDV users; otherwise not (optional).
 ;  
 N ORDD,ORDIV,ORDUP,ORGOOD,ORI,ORIEN1,ORIEN2,ORLAST,ORMAX,ORMRK,ORMULTI,ORPREV,ORSRV,ORTTL
 ;
 S ORI=0,ORMAX=44,(ORLAST,ORPREV)="",ORKEY=$G(ORKEY),ORDATE=$G(ORDATE)
 S ORMULTI=$$ALL^VASITE ; IA# 10112.  Do once at beginning of call.
 ;
 ; NP3 tag includes visitors, uses full "B" x-ref.
 I +$G(ORVIZ)=1 D NP3(0) Q  ; Use alt. version, skip rest.
 ; User requested ALL users, both active and inactive.  Same call, but skip $$PROVIDER^XUSER screen
 I +$G(ORALL)=1 D NP3(0) Q
 ;
 F  Q:ORI'<ORMAX  S ORFROM=$O(^VA(200,"AUSER",ORFROM),ORDIR) Q:ORFROM=""  D
 .S ORIEN1=""
 .F  S ORIEN1=$O(^VA(200,"AUSER",ORFROM,ORIEN1),ORDIR) Q:'ORIEN1  D
 ..;
 ..I $L(ORKEY),'$D(^XUSEC(ORKEY,+ORIEN1)) Q       ; Check for key?
 ..I ORDATE>0,$$GET^XUA4A72(ORIEN1,ORDATE)<1 Q    ; Check date?
 ..S ORI=ORI+1,ORY(ORI)=ORIEN1_"^"_$$NAMEFMT^XLFNAME(ORFROM,"F","DcMPC")
 ..S ORDUP=0                            ; Init flag, check dupe.
 ..I ($P(ORPREV_" "," ")=$P(ORFROM_" "," ")) S ORDUP=1
 ..;
 ..; Append Title if not duplicated:
 ..I 'ORDUP D
 ...S ORIEN2=ORIEN1
 ...D NP4(0)                            ; Get Title. 
 ...I ORTTL="" Q
 ...S ORY(ORI)=ORY(ORI)_U_"- "_ORTTL
 ..;
 ..; Get data in case of dupes:
 ..I ORDUP D
 ...S ORIEN2=ORLAST                     ; Prev IEN for NP2 call.
 ...;
 ...; Reset, use previous array element, call for extended data:
 ...S ORI=ORI-1,ORY(ORI)=$P(ORY(ORI),U)_U_$P(ORY(ORI),U,2)  D NP2
 ...;
 ...; Then return to current user for second extended data call:
 ...S ORIEN2=ORIEN1,ORI=ORI+1  D NP2
 ..S ORLAST=ORIEN1,ORPREV=ORFROM        ; Reassign vars for next pass.
 ;
 Q
 ;
NP2 ; Retrieve subset of data for dupes in NP1.
 ; (Assumes certain vars already set/new'd in calling code.)
 ;
 ; Variables used:
 ;   ORZ    = Memory array storage variable.
 ;   ORZERR = Error storage for LIST^DIC call.
 ;
 N ORZ,ORZERR                           ; Initialize variables.
 S ORDIV=""                             ; Reset each time.
 D NP4(1)                               ; Get Title, Service/Section.
 ;
 ; For multi-divisional site, get Division if determinable:
 I ORMULTI D
 .D LIST^DIC(200.02,","_ORIEN2_",","@;.01;1","QP","","","","","","","ORZ","ORZERR")
 .S (ORDD,ORGOOD)=0                     ; Initialize variables.
 .I $P(ORZ("DILIST",0),U)=0 Q           ; Division not listed.
 .I $P(ORZ("DILIST",0),U)=1 D  Q        ; Only one, so use it.
 ..S ORDD=$O(ORZ("DILIST",ORDD))        ; Get the node's entry.
 ..S ORDIV=$P(ORDD,U,2)                 ; Get actual name value.
 .;
 .; More than one Division entry, so:
 .F  S ORDD=$O(ORZ("DILIST",ORDD)) Q:+ORDD=0!'($L(ORDD))  D  Q:ORGOOD
 ..;
 ..; See if current entry being processed is "Default" (done if so):
 ..I $P(ORZ("DILIST",ORDD,0),U,3)["Y" S ORDIV=$P(ORZ("DILIST",ORDD,0),U,2),ORGOOD=1  Q                       ; Division text.
 ;
 ; Append new pieces to array string:
 S ORMRK=""
 I (ORTTL="")&(ORSRV="")&(ORDIV="")  Q  ; Nothing to append.
 S ORY(ORI)=ORY(ORI)_U_"- "             ; At least something exists.
 I (ORTTL'="") S ORY(ORI)=ORY(ORI)_ORTTL,ORMRK=", "       ; Title.
 I (ORSRV'="") S ORY(ORI)=ORY(ORI)_ORMRK_ORSRV,ORMRK=", " ; Service.
 I (ORDIV'="") S ORY(ORI)=ORY(ORI)_ORMRK_ORDIV            ; Division.
 ;
 Q
 ;
NP3(COSFLAG) ; Retrieve diff. data when all users are involved, using "B" x-ref.
 ;
 ; COSFLAG=If TRUE, called by ORWTPN.
 ; (Assumes certain vars already set/new'd in calling code.)
 ;
 N ORNODE,COSQUIT
 S COSQUIT=0 ; Flag used in section for COSFLAG.
 ;
 F  Q:ORI'<ORMAX  S ORFROM=$O(^VA(200,"B",ORFROM),ORDIR) Q:ORFROM=""  D
 .S ORIEN1=""
 .F  S ORIEN1=$O(^VA(200,"B",ORFROM,ORIEN1),ORDIR) Q:'ORIEN1  D
 ..;
 ..; Screen default cosigner if appropriate (ORUSER set in ORWTPN):
 ..I COSFLAG D
 ...S COSQUIT=0
 ...I '$$SCRDFCS^TIULA3(ORUSER,ORIEN1) S COSFLAG=1 Q
 ...S ORNODE=$P($G(^VA(200,ORIEN1,0)),U)
 ...I '$L(ORNODE) S COSFLAG=1 Q
 ..I COSQUIT Q
 ..;
 ..I +$G(ORALL)=0,'$$PROVIDER^XUSER(ORIEN1,1) Q   ; Terminated?   Skip if ALL requested
 ..I ORDATE>0,$$GET^XUA4A72(ORIEN1,ORDATE)<1 Q    ; Check date?
 ..I $L(ORKEY),'$D(^XUSEC(ORKEY,+ORIEN1)) Q       ; Check for key?
 ..S ORI=ORI+1,ORY(ORI)=ORIEN1_"^"_$$NAMEFMT^XLFNAME(ORFROM,"F","DcMPC")
 ..S ORDUP=0                           ; Init flag, check duplication.
 ..I ($P(ORPREV_" "," ")=$P(ORFROM_" "," ")) S ORDUP=1
 ..;
 ..; Append Title if not duplicated:
 ..I 'ORDUP D
 ...S ORIEN2=ORIEN1
 ...D NP4(0)                           ; Get Title. 
 ...I ORTTL="" Q
 ...S ORY(ORI)=ORY(ORI)_U_"- "_ORTTL
 ..;
 ..; Get data in case of dupes:
 ..I ORDUP D
 ...S ORIEN2=ORLAST                   ; Set to prev. IEN for NP2.
 ...;
 ...; Reset, use previous array element, call for extended data:
 ...S ORI=ORI-1,ORY(ORI)=$P(ORY(ORI),U)_U_$P(ORY(ORI),U,2)  D NP2
 ...;
 ...; Now return to current user for second extended data call:
 ...S ORIEN2=ORIEN1,ORI=ORI+1  D NP2
 ..S ORLAST=ORIEN1,ORPREV=ORFROM       ; Reassign vars for next pass.
 ;
 Q
 ;
NP4(ORSS) ; Retrieve Title or Title and Service/Section.
 ; (Assumes certain vars already set/new'd in calling code.)
 ;
 ; Passed variable ORSS: If true, get Service/Section also.
 ;
 S (ORTTL,ORSRV)=""                            ; Init each time.
 ; DBIA# 4329:
 S ORTTL=$P($G(^VA(200,ORIEN2,0)),U,9)         ; Get Title pointer.
 I ORTTL<1 S ORTTL=""                          ; Reset var if none.
 ; DBIA# 1234:
 I ORTTL>0 S ORTTL=$G(^DIC(3.1,ORTTL,0))       ; Actual Title value.
 S ORSS=$G(ORSS)
 I ORSS D                                      ; Get Service/Section?
 .; DBIA# 4329:
 .S ORSRV=$P($G(^VA(200,ORIEN2,5)),U,1)        ; Get S/S pointer.
 .I ORSRV<1 S ORSRV=""                         ; Reset var if none.
 .; DBIA# 4330:
 .I ORSRV>0 S ORSRV=$P($G(^DIC(49,ORSRV,0)),U) ; Actual S/S value.
 ;
 Q
 ;
NAMECVT(Y,IEN) ; Returns text name(mixed-case) derived from IEN xref.
 ; GRE/2002
 ; PKS-12/20/2002 Tag not presently used.
 ; Y=Returned value, IEN=Internal number
 N ORNAME
 S IEN=IEN_","
 S ORNAME=$$GET1^DIQ(200,IEN,20.2)
 S Y=$$NAMEFMT^XLFNAME(.ORNAME,"F","DcMPC")
 Q
 ;
DEFDIV(Y) ; Return user's default division, if specified.
 ;
 ; Variables used:
 ;   ORDD   = Default division.
 ;   ORDIV  = Division holder variable.
 ;   ORGOOD = Flag for successful default division found.
 ;   ORIEN  = IEN of user.
 ;   ORZ    = Memory array storage variable.
 ;   ORZERR = Error storage for LIST^DIC call.
 ;   Y      = Returned value.
 ;
 N ORDD,ORDIV,ORGOOD,ORIEN,ORZ,ORZERR
 ;
 S ORIEN=DUZ,ORDIV=""
 S Y=0,(ORDD,ORGOOD)=0             ; Initialize variables.
 ;
 ; Get list of divisions from NEW PERSON file multiple:
 D LIST^DIC(200.02,","_ORIEN_",","@;.01;1","QP","","","","","","","ORZ","ORZERR")
 I $P(ORZ("DILIST",0),U)=0 Q       ; No Divisions listed.
 ;
 ; Iterate through list:
 F  S ORDD=$O(ORZ("DILIST",ORDD)) Q:+ORDD=0!'($L(ORDD))  D  Q:ORGOOD
 .;
 .; See if current entry being processed is "Default" (done if so):
 .I $P(ORZ("DILIST",ORDD,0),U,3)["Y" S ORDIV=$P(ORZ("DILIST",ORDD,0),U,2),ORGOOD=1                      ; Division text.
 .;
 I (ORDIV="") Q                    ; Punt if no default division.
 I $$UP^XLFSTR(ORDIV)="SALT LAKE CITY OIFO" S Y=1
 ;
 Q
 ;
NEWLOC(Y,ORFROM,DIR) ; Return "CZ" locations from HOSPITAL LOCATION file.
 ; C=Clinics, Z=Other, screened by $$ACTLOC^ORWU.
 ; .Y=returned list, ORFROM=text to $O from, DIR=$O direction.
 N I,IEN,CNT S I=0,CNT=44
 F  Q:I'<CNT  S ORFROM=$O(^SC("B",ORFROM),DIR) Q:ORFROM=""  D  ; IA# 10040.
 . S IEN="" F  S IEN=$O(^SC("B",ORFROM,IEN),DIR) Q:'IEN  D
 . . Q:("C"'[$P($G(^SC(IEN,0)),U,3)!('$$ACTLOC^ORWU(IEN)))
 . . S I=I+1,Y(I)=IEN_"^"_ORFROM
 Q
 ;        
