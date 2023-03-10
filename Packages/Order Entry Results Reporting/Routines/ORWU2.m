ORWU2 ; SLC/JEH,AJB - General Utilities for Windows Calls ;May 05, 2021@13:34:59
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**243,533,539**;Dec 17, 1997;Build 41
 ;
 Q
 ;
 ; $$REQCOSIG^TIULP  DBIA #2322
 ; $$ISA^USRLM       DBIA #1544
 ;
 ; Return a set of names from the NEW PERSON file.
COSIGNER(ORY,ORFROM,ORDIR,ORDATE,ORTIUTYP,ORTIUDA,ORSIM) ;
 ; (Set up for the DC Summary)
 ;  (to use TIU doc requirments and USR PROVIDER)
 ;
 ; PARAMS from ORWU2 COSIGNER RPC call:
 ;  .ORY=returned list.
 ;  ORFROM=Starting name for this set.
 ;  ORDIR=Direction to move through the x-ref with $O.
 ;  ORDATE=Checks for an USR PROVIDER on this date (optional).
 ;  ORTIUTYP is + of the 0 node of the 8925 docmt.
 ;  ORTIUDA is the docmt IEN.
 ;  ORSIM = If true, this indicates that this is a Similar Provider RPC call NSR#20110606 (539)
 ;
 ;
 ;
 N ORDD,ORDIV,ORDUP,ORGOOD,ORI,ORIEN1,ORIEN2,ORLAST,ORMAX,ORMRK,ORMULTI,ORNPI,ORPREV,ORSRV,ORTTL,ORERR
 N ORFNM,ORFNMLEN,ORLNM,OPTIEN,ORDUPNM ; Add first and last names, the provider IEN and first name length
 S ORI=0,ORMAX=44,(ORLAST,ORPREV,ORDUPNM)="",ORDATE=$G(ORDATE),ORSIM=$G(ORSIM)
 S OPTIEN=$$LKOPT^XPDMENU("OR CPRS GUI CHART") ;Set IEN to option file for GUI Chart for Similar Provider calls
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
 .;Using COS2 instead of COS4(0) in case duplicate (same but different) entry found later
 .D COS2
 E  D
 .S (ORFNM,ORFNMLEN,ORLNM)=""
 ;
ND I +$G(ORTIUDA) S ORTIUTYP=+$G(^TIU(8925,+$G(ORTIUDA),0))
 ;
 F  Q:ORI'<ORMAX  S ORFROM=$O(^VA(200,"AUSER",ORFROM),ORDIR) Q:ORFROM=""!'$$CHKORSIM(ORSIM,ORFNM,ORFNMLEN,ORFROM,ORLNM)  D  ;Check for quitting with ORSIM and names comparison (539)
 .S ORIEN1=""
 .F  S ORIEN1=$O(^VA(200,"AUSER",ORFROM,ORIEN1),ORDIR) Q:'ORIEN1  D
 ..I $D(ORDUPNM(ORIEN1)) Q
 ..I '$$PROVIDER^XUSER(ORIEN1,1) Q   ; Terminated?
 ..I '$$ISA^USRLM(+ORIEN1,"PROVIDER",.ORERR,ORDATE) Q  ;(USR PROVIDER CLASS CHECK?)
TIU .. I $$REQCOSIG^TIULP(ORTIUTYP,ORTIUDA,ORIEN1,ORDATE) Q  ; User requiers cosigner
 ..I ORSIM,('+$$ACCESS^XQCHK(ORIEN1,OPTIEN)!'$$FIND1^DIC(200.010113,","_ORIEN1_",","","COR")) Q    ;Check if Similar Provider call
 ..;I ($L(ORKEY)),(ORKEY'="COSIGNER"),('$D(^XUSEC(ORKEY,+ORIEN1))) Q       ; Check for key?
 ..;I ORDATE>0,$$GET^XUA4A72(ORIEN1,ORDATE)<1 Q    ; Check date?
 ..S ORI=ORI+1,ORY(ORI)=ORIEN1_"^"_$$NAMEFMT^XLFNAME(ORFROM,"F","DcMPC")
 ..S ORDUP=0                            ; Init flag, check dupe.
 ..I ($P(ORPREV_" "," ")=$P(ORFROM_" "," ")) S ORDUP=1
 ..;
 ..; Append Title if not duplicated:
 ..I 'ORDUP D
 ...S ORIEN2=ORIEN1
 ...D COS4(0)                            ; Get Title. *533 & NPI
 ...; add NPI data *533 ; ajb
 ...I ORTTL="" S ORY(ORI)=ORY(ORI)_U_ORNPI Q
 ...S ORY(ORI)=ORY(ORI)_U_"- "_ORTTL_ORNPI
 ...I ORTTL="" Q
 ...S ORY(ORI)=ORY(ORI)_U_"- "_ORTTL
 ..;
 ..; Get data in case of dupes:
 ..I ORDUP D
 ...S ORIEN2=ORLAST                     ; Prev IEN for NP2 call.
 ...;
 ...; Reset, use previous array element, call for extended data:
 ...S ORI=ORI-1,ORY(ORI)=$P(ORY(ORI),U)_U_$P(ORY(ORI),U,2)  D COS2
 ...;
 ...; Then return to current user for second extended data call:
 ...S ORIEN2=ORIEN1,ORI=ORI+1  D COS2
 ..S ORLAST=ORIEN1,ORPREV=ORFROM        ; Reassign vars for next pass.
 ;
END Q
 ;
COS2 ; Retrieve subset of data for dupes in COSIGNER.
 ; (Assumes certain vars already set/new'd in calling code.)
 ;
 ; Variables used:
 ;   ORZ    = Memory array storage variable.
 ;   ORZERR = Error storage for LIST^DIC call.
 ;
 N ORZ,ORZERR                           ; Initialize variables.
 S ORDIV=""                             ; Reset each time.
 D COS4(1)                               ; Get Title, Service/Section.
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
 I (ORTTL="")&(ORSRV="")&(ORDIV="")&(ORNPI="")  Q  ; Nothing to append.
 S ORY(ORI)=ORY(ORI)_U_"- "             ; At least something exists.
 I (ORTTL'="") S ORY(ORI)=ORY(ORI)_ORTTL,ORMRK=", "       ; Title.
 I (ORSRV'="") S ORY(ORI)=ORY(ORI)_ORMRK_ORSRV,ORMRK=", " ; Service.
 I (ORDIV'="") S ORY(ORI)=ORY(ORI)_ORMRK_ORDIV            ; Division.
 I (ORNPI'="") S ORY(ORI)=ORY(ORI)_ORNPI                  ; NPI *533
 ;
 Q
 ;
 ;
COS4(ORSS) ; Retrieve Title or Title and Service/Section.
 ; (Assumes certain vars already set/new'd in calling code.)
 ;
 ; Passed variable ORSS: If true, get Service/Section also.
 ;
 S (ORNPI,ORTTL,ORSRV)=""                            ; Init each time.
 ; DBIA# 4329:
 S ORTTL=$P($G(^VA(200,ORIEN2,0)),U,9)         ; Get Title pointer.
 S ORNPI=+$$NPI^XUSNPI("Individual_ID",ORIEN2) ; Get NPI. *533 ICR#4532
 S ORNPI=$S(ORNPI>0:" [NPI:"_ORNPI_"]",1:"")
 I ORTTL<1 S ORTTL=""                          ; Reset var if none.
 ; DBIA# 1234:
 I ORTTL>0 S ORTTL=$$TITLE^XLFSTR($G(^DIC(3.1,ORTTL,0)))       ; Actual Title value.
 S ORSS=$G(ORSS)
 I ORSS D                                      ; Get Service/Section?
 .; DBIA# 4329:
 .S ORSRV=$P($G(^VA(200,ORIEN2,5)),U,1)        ; Get S/S pointer.
 .I ORSRV<1 S ORSRV=""                         ; Reset var if none.
 .; DBIA# 4330:
 .I ORSRV>0 S ORSRV=$$TITLE^XLFSTR($P($G(^DIC(49,ORSRV,0)),U)) ; Actual S/S value.
 ;
 Q
 ;
CHKORSIM(ORSIM,ORFNM,ORFNMLEN,ORFROM,ORLNM) ; If this is a Similiar Provider call check for matching names - 539
 I 'ORSIM Q 1 ; If 'ORSIM, no additional restrictions
 I $E(ORFROM,1,$L(ORLNM))'=ORLNM Q 0 ; If last names don't match, quit now
 I $E($P(ORFROM,",",2),1,ORFNMLEN)'=ORFNM Q 0 ; If first name portions don't match, quit now
 Q 1 ; All checks passed
