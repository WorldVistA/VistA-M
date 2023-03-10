ORWU1 ;SLC/GRE - General Utilities for Windows Calls ;Aug 4, 2021@15:32:01
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**149,187,195,215,394,533,519,539,564**;Dec 17, 1997;Build 1
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
 ;  ORFROM=Starting name for this set or, if ORSIM=true, the starting IEN.  ** NSR 20110606/539 - Allow for name or IEN **.
 ;  ORKEY=Screen users by security key (optional).
 ;  ORVIZ=If true, includes RDV users; otherwise not (optional).
 ;  ORSIM=If true, this indicates that this is a Similar Provider RPC call NSR#20110606/539
 ;
 N ORDD,ORDIV,ORDUP,ORGOOD,ORI,ORIEN1,ORIEN2,ORLAST,ORMAX,ORMRK,ORMULTI,ORNPI,ORPREV,ORSRV,ORTTL,ORTERM,ORNOW
 N ORFNM,ORFNMLEN,ORLNM,OPTIEN,ORDUPNM,A,S1 ;** NSR 20110606/539 - Add first and last names, first name length and OPTIEN it is the IEN to the OPTION file
 S ORNOW=$P($$NOW^XLFDT(),".")
 K ORTAB S S1=0 F  S S1=$O(^ORD(101.13,S1)) Q:'S1  S A=$P($G(^ORD(101.13,S1,0)),"^") I A="COR"!(A="NVA") S ORTAB(A)=S1
 S ORI=0,ORMAX=44,(ORLAST,ORPREV,ORDUPNM)="",ORKEY=$G(ORKEY),ORDATE=$G(ORDATE),ORSIM=$G(ORSIM)    ; NSR 20110606/539 added ORSIM
 S OPTIEN=$$LKOPT^XPDMENU("OR CPRS GUI CHART") ;Set IEN to option file NSR 20110606/539
 S ORMULTI=$$ALL^VASITE ; IA# 10112.  Do once at beginning of call.
 I +ORSIM D  ; ** NSR 20110606/539 - If ORSIM, ORFROM is IEN and needs to be changed to name.  Also get first name, its length and last name **
 .N LASTCHAR,ORFIEN,ORFROM1,XFNM,XFNMLEN
 .S ORFIEN=ORFROM
 .S (ORFROM,ORFROM1)=$P(^VA(200,ORFROM,0),U),$P(ORFROM,",",2)=$E($P(ORFROM,",",2),1,2)
 .S ORFNM=$P(ORFROM,",",2),ORFNMLEN=$L(ORFNM),ORLNM=$P(ORFROM,",") ; ** NSR 20110606/539 - Add ORFNM, ORFNMLEN and ORLNM **
 .I ORFNM]"" D
 ..S XFNM=$P(ORFROM,",",2),XFNMLEN=$L(XFNM),LASTCHAR=$C($A(XFNM,XFNMLEN)-1),XFNM=$E(XFNM,1,XFNMLEN-1)_LASTCHAR_$C(126)
 ..S $P(ORFROM,",",2)=XFNM
 .S ORI=ORI+1,ORY(ORI)=ORFIEN_"^"_$$NAMEFMT^XLFNAME(ORFROM1,"F","DcMPC")
 .S ORDUPNM(ORFIEN)=""
 .S ORIEN2=ORFIEN
 .;Using NP2 instead of NP4(0) in case duplicate (same but different) entry found later
 .D NP2
 E  D
 .S (ORFNM,ORFNMLEN,ORLNM)=""
 ;
 ; NP3 tag includes visitors, uses full "B" x-ref.
 I +$G(ORVIZ)=1 D NP3(0) Q  ; Use alt. version, skip rest.
 ; User requested ALL users, both active and inactive.  Same call, but skip $$PROVIDER^XUSER screen
 I +$G(ORALL)=1 D NP3(0) Q
 ;
 F  Q:ORI'<ORMAX  S ORFROM=$O(^VA(200,"AUSER",ORFROM),ORDIR) Q:ORFROM=""!'$$CHKORSIM(ORSIM,ORFNM,ORFNMLEN,ORFROM,ORLNM)  D  ; NSR 20110606/539 - Check for quitting with ORSIM and names comparison
 .S ORIEN1=""
 .F  S ORIEN1=$O(^VA(200,"AUSER",ORFROM,ORIEN1),ORDIR) Q:'ORIEN1  D
 ..S ORTERM=$$GET1^DIQ(200,ORIEN1,9.2,"I") I ORTERM]"",ORTERM'>ORNOW Q
 ..I $D(ORDUPNM(ORIEN1)) Q
 ..; NSR 20120101 Limit Signers by Tabs & Excluded User Class
 ..I '+$$CPRSTAB(ORIEN1,ORTAB("COR")),'+$$CPRSTAB(ORIEN1,ORTAB("NVA")) Q  ; Check core tab & Non-VA tab access including effective date and expiration date
 .. I OREXCLDE,$$CPRSTAB(ORIEN1,ORTAB("NVA")) Q  ;If excluding users for additional signer, exclude NVA tab holders
 ..I +OREXCLDE,+$$USRCLASS(ORIEN1) Q  ; Check Excluded User Class
 ..;
 ..I $L(ORKEY),'$D(^XUSEC(ORKEY,+ORIEN1)) Q       ; Check for key?
 ..I ORDATE>0,$$GET^XUA4A72(ORIEN1,ORDATE)<1 Q    ; Check date?
 ..I +$G(ORPDMP)=1,'$$ISAUTH^ORPDMP(+ORIEN1) Q  ;For PDMP query form, filter out non-authorized users
 ..I '$$CPRSTAB(ORIEN1,ORTAB("NVA")),+$$ACCESS^XQCHK(ORIEN1,OPTIEN)=0 Q    ;NSR 20110606/539
 ..I +ORI,+ORY(ORI)=ORIEN1 Q  ; if the current IEN is already in list, quit
 ..S ORI=ORI+1,ORY(ORI)=ORIEN1_"^"_$$NAMEFMT^XLFNAME(ORFROM,"F","DcMPC")
 ..S ORDUP=0                            ; Init flag, check dupe.
 ..I ($P(ORPREV_" "," ")=$P(ORFROM_" "," ")) S ORDUP=1
 ..;
 ..; Append Title if not duplicated:
 ..I 'ORDUP D
 ...S ORIEN2=ORIEN1
 ...D NP4(0)                            ; Get Title. *533 & NPI
 ...; add NPI data *533 ; ajb
 ...I ORTTL="" S ORY(ORI)=ORY(ORI)_U_ORNPI Q
 ...S ORY(ORI)=ORY(ORI)_U_"- "_ORTTL_ORNPI
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
 ..S ORDIV=$P(ORZ("DILIST",ORDD,0),U,2) ; Get actual name value. p394
 .;
 .; More than one Division entry, so:
 .F  S ORDD=$O(ORZ("DILIST",ORDD)) Q:+ORDD=0!'($L(ORDD))  D  Q:ORGOOD
 ..;
 ..; See if current entry being processed is "Default" (done if so):
 ..I $P(ORZ("DILIST",ORDD,0),U,3)["Y" S ORDIV=$P(ORZ("DILIST",ORDD,0),U,2),ORGOOD=1  Q  ; Division text.
 ;
 ; add NPI information *533 ; ajb
 ; Append new pieces to array string:
 S ORMRK=""
 I (ORTTL="")&(ORSRV="")&(ORDIV="")&(ORNPI="") Q  ; Nothing to append. add check for NPI
 S ORY(ORI)=ORY(ORI)_U_"- "             ; At least something exists.
 I (ORTTL'="") S ORY(ORI)=ORY(ORI)_ORTTL,ORMRK=", "       ; Title.
 I (ORSRV'="") S ORY(ORI)=ORY(ORI)_ORMRK_ORSRV,ORMRK=", " ; Service.
 I (ORDIV'="") S ORY(ORI)=ORY(ORI)_ORMRK_ORDIV            ; Division.
 I (ORNPI'="") S ORY(ORI)=ORY(ORI)_ORNPI                  ; NPI *533
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
 ...; add NPI data *533 ; ajb
 ...I ORTTL="" S ORY(ORI)=ORY(ORI)_U_ORNPI Q
 ...S ORY(ORI)=ORY(ORI)_U_"- "_ORTTL_ORNPI
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
 S (ORNPI,ORTTL,ORSRV)=""                            ; Init each time. *533
 ; DBIA# 4329:
 S ORTTL=$P($G(^VA(200,ORIEN2,0)),U,9)         ; Get Title pointer.
 S ORNPI=+$$NPI^XUSNPI("Individual_ID",ORIEN2)  ; Get NPI. *533 ICR#4532
 S ORNPI=$S(ORNPI>0:" [NPI:"_ORNPI_"]",1:"")
 I ORTTL<1 S ORTTL=""                          ; Reset var if none.
 ; DBIA# 1234:
 I ORTTL>0 S ORTTL=$$TITLE^XLFSTR($G(^DIC(3.1,ORTTL,0)))       ; Actual Title value. *533 title case
 S ORSS=$G(ORSS)
 I ORSS D                                      ; Get Service/Section?
 .; DBIA# 4329:
 .S ORSRV=$P($G(^VA(200,ORIEN2,5)),U,1)        ; Get S/S pointer.
 .I ORSRV<1 S ORSRV=""                         ; Reset var if none.
 .; DBIA# 4330:
 .I ORSRV>0 S ORSRV=$$TITLE^XLFSTR($P($G(^DIC(49,ORSRV,0)),U)) ; Actual S/S value. *533 title case
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
 .I $P(ORZ("DILIST",ORDD,0),U,3)["Y" S ORDIV=$P(ORZ("DILIST",ORDD,0),U,2),ORGOOD=1  ; Division text.
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
CHKORSIM(ORSIM,ORFNM,ORFNMLEN,ORFROM,ORLNM) ; NSR 20110606/539 - Check if name complies with ORSIM flag and restrictions
 I 'ORSIM Q 1 ; If 'ORSIM, no additional restrictions
 I $E(ORFROM,1,$L(ORLNM))'=ORLNM Q 0 ; If last names don't match, quit now
 I $E($P(ORFROM,",",2),1,ORFNMLEN)'=ORFNM Q 0 ; If first name portions don't match, quit now
 Q 1 ; All checks passed
 ;
CPRSTAB(USER,TAB) ; NSR 20120101 - return 1 if users is ok to stay in list
 ; update 04/19/2021 to include NVA (Non-VA Providers) tab
 ; 1 - CPRS GUI "core" tabs.
 ; 2 - Reports tab.
 ; 3 - Non-VA Providers tab.
 N ORRES,ORTAB,ORX S ORRES=0 ; result, default to 0
 ;       TAB^EFFECTIVE DATE^EXPIRATION DATE
 I '$D(^VA(200,USER,"ORD","B",TAB)) Q ORRES
 S ORX=0 F  S ORX=$O(^VA(200,USER,"ORD","B",TAB,ORX)) Q:'ORX  D  Q:ORRES
 . S ORTAB=$G(^VA(200,USER,"ORD",ORX,0))
 . ; evaluate COR or NVA tab, check effective date, check expiration date
 . I DT'<$P(ORTAB,U,2),+$P(ORTAB,U,3)=0!(DT<$P(ORTAB,U,3)) S ORRES=1
 Q ORRES
 ;
USRCLASS(USER) ; NSR 20120101
 N ORLIST,ORQUIT,ORX
 S ORQUIT=0
 D GETLST^XPAR(.ORLIST,"SYS","OR CPRS USER CLASS EXCLUDE","I") ; IA# 2263
 S ORX="" F  S ORX=$O(ORLIST(ORX)) Q:'+ORX  D
 . I +$$ISA^USRLM(USER,ORLIST(ORX)) S ORQUIT=1 ; IA# 1544
 Q ORQUIT
