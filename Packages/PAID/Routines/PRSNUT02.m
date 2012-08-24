PRSNUT02 ;WOIFO/JAH - Nurse Activity for VANOD Utilities;6/19/2009
 ;;4.0;PAID;**126**;Sep 21, 1995;Build 59
 ;;Per VHA Directive 2004-038,this routine should not be modified.
 Q
ACCESS(GRPS,ACCTYPE,PRSDT,MANY) ;return the user selected Group
 K GRPS
 ;
 ;INPUT:
 ;  ACCTYPE-The type of access flag, E for data entry personnel and
 ;          A for data approval personnel
 ;  PRSDT- date for determination of what the division access parameter
 ;         was on that date (either T&L or Location)
 ;  MANY-  (optional) set this flag to true (1) if more than one
 ;         group can be selected.  Set the flag to (2) if you want
 ;         all groups user has access to without any prompting.
 ;
 ;OUTPUT:
 ;PROCEDURE INTERACTS W/USER TO RETURN THE FOLLOWING:
 ;
 ;  GRPS - array w/users selected groups subscripted
 ;         by .01 field value (t&l external code or location pointer)
 ;  GRPS(0) - will contain the number selected followed by either
 ;            N,T, or E for Nurse Location, T&L unit or Error
 ;            If piece 2 is an E then piece 3 will contain error
 ;            description
 ;         
 ;  Node Definition: an Upparrow delimited string with the following:
 ;     PEICE  DEFINITION
 ;     =====  ==============================
 ;       1    IEN of field value of group 
 ;       2    IEN of Division associated with this Group
 ;       3    External value of division
 ;
 ;  Sample Call:
 ;
 ;      D ACCESS^PRSNUT02(.G,"E",DT,1)    
 ;
 ;  Sample Return:
 ;
 ;      G(0)="3^N"
 ;      G("1E-EAST")="1^16433^500GA"
 ;      G("3B-EAST")="6^16433^500GA"
 ;      G("3B-WEST")="4^16433^500GA"
 ;
 ; determine for which entities current user has access to in both T&L 
 ; Unit File & NURS LOCATION file.  Build temp list of all possible 
 ; groups. If user has access to groups in more than one division then
 ;  prompt for division
 ;
 N TINDEX,LINDEX
 ;
 ;    use access type parameter for appropriate indices for data entry
 ;    or data approval personnel--TINDEX is the T&L unit file and
 ;    LINDEX is the Nurse Location.
 ;
 S TINDEX=$S(ACCTYPE="E":"AE",ACCTYPE="A":"AR",1:"")
 S LINDEX=$S(ACCTYPE="E":"AE",ACCTYPE="A":"AA",1:"")
 ;
 ; Quit if no access specified in ACCTYP parameter
 I TINDEX="" S GRPS(0)="0^E^Access Type Not Specified" Q
 ;
 N TMPGRPS,DIVMAP,DIVGRP,TLNODIV,DIVNOPAR
 D TLACC(.TMPGRPS,.DIVMAP,.DIVGRP,.TLNODIV,.DIVNOPAR,TINDEX,DUZ,PRSDT)
 ;
 N OUT
 S OUT=0
 I $D(TLNODIV) D
 .  W !!?5,"WARNING:",!?5,"========="
 .  W !?5,"You have access to the following T&L unit(s), but no division"
 .  W !?5,"  has been entered for the T&L(s):"
 .  S TLE=""
 .  F  S TLE=$O(TLNODIV(TLE)) Q:TLE=""  D
 ..     W !?8,TLE
 .  S OUT=$$ASK^PRSLIB00(0)
 I OUT S GRPS(0)="0^E^user abort" Q
 ;
 ; get locations that meet the criteria:
 ;   1. user has access
 ;   2. division access parameter matches the users access type
 ;
 D NLACC(.TMPGRPS,.DIVMAP,.DIVGRP,.TLNODIV,.DIVNOPAR,LINDEX,DUZ,PRSDT)
 ;
 N NDIVI
 I $D(DIVNOPAR) D
 .  W !!,"WARNING: ",!,"========"
 .  W !?5,"You have access to location(s) or T&L units in the following"
 .  W !?5,"division(s), but the division parameter has not been set by"
 .  W !?5,"the package coordinator:",!
 .  S NDIVI=0
 .  F  S NDIVI=$O(DIVNOPAR(NDIVI)) Q:NDIVI=""  D
 ..    D GETS^DIQ(4,NDIVI_",",".01;99","EI","FIELDS(",,)
 ..    W !?7,NDIVI,?17,FIELDS(4,NDIVI_",",.01,"E"),?34,FIELDS(4,NDIVI_",",99,"E")
 . S OUT=$$ASK^PRSLIB00(0)
 I OUT S GRPS(0)="0^E^user abort" Q
 ;
 ;
 I '$D(DIVMAP) S GRPS(0)="0^E^You have no access to T&Ls or Locations" Q
 ;
 ; count divsions user can access
 ;
 N CNT,NDIVI
 S (NDIVI,CNT)=0 F  S NDIVI=$O(DIVMAP(NDIVI)) Q:NDIVI'>0  S CNT=CNT+1
 ;
 N OUT,SELDIV S OUT=0
 I CNT>1 D
 .  W !?5,"You have access to location(s) or T&L units in more than one division"
 .  N DIC,X,Y,DUOUT,DTOUT S DIC(0)="AEQMZ",DIC="^DIC(4,"
 .  S DIC("S")="I $P($G(DIVMAP(Y)),U,2)'="""""
 .  D ^DIC I $D(DUOUT)!$D(DTOUT)!(Y'>0) S OUT=1
 .  S SELDIV=$G(Y)
 E  D
 .  S SELDIV=$O(DIVMAP(0))
 I OUT S GRPS(0)="0^E^user abort" Q
 ;
 ; prompt for location or T&L within selected division
 ;
 N DIVPARAM
 S DIVPARAM=$P($G(DIVMAP(+SELDIV)),U,2)
 I "T^N"'[DIVPARAM S GRPS(0)="0^E^Division Parameter Unspecified" Q
 ;
 N DIC,X,Y,DUOUT,DTOUT,VAUTSTR,VAUTNI,VAUTVB,OUT
 S OUT=0
 ;      select t&l unit or nurse location
 I DIVPARAM="T" D
 .  S VAUTSTR="T&L Units",DIC="^PRST(455.5,"
 E  D
 .  S VAUTSTR="Nurse Location",DIC="^NURSF(211.4,"
 S DIC(0)="AEQMZ",DIC("S")="I $D(TMPGRPS(DIVPARAM,+SELDIV,+Y))"
 I $G(MANY)=1 D
 .  N PRSNGR
 .  S VAUTNI=2,VAUTVB="PRSNGR"
 .  D FIRST^VAUTOMA
 .  S (CNT,Y)=0
 .  I 'PRSNGR D
 ..    F  S Y=$O(PRSNGR(Y)) Q:Y=""  D
 ...     I $D(TMPGRPS(DIVPARAM,+SELDIV,Y)) D
 ....      S CNT=CNT+1
 ....      S GRPS($G(TMPGRPS(DIVPARAM,+SELDIV,+Y)))=+Y_U_$G(DIVGRP(DIVPARAM,+Y))_U_$S(DIVPARAM="N":+$G(^NURSF(211.4,+Y,0)),1:"")
 .  E  D
 .. ; all groups selected, so update output array with them
 ..    F  S Y=$O(DIVGRP(DIVPARAM,Y)) Q:Y=""  D
 ...     I $D(TMPGRPS(DIVPARAM,+SELDIV,+Y)) D
 ....       S CNT=CNT+1
 ....       S GRPS($G(TMPGRPS(DIVPARAM,+SELDIV,+Y)))=+Y_U_$G(DIVGRP(DIVPARAM,+Y))_U_$S(DIVPARAM="N":+$G(^NURSF(211.4,+Y,0)),1:"")
 .     S GRPS(0)=CNT_U_DIVPARAM
 .  I CNT=0 S GRPS(0)="0^E^Nothing Selected" Q
 E  D
 .; automatically return all groups (no prompt)
 .  I $G(MANY)=2 D
 ..    S (CNT,Y)=0
 ..    F  S Y=$O(DIVGRP(DIVPARAM,Y)) Q:Y=""  D
 ...     I $D(TMPGRPS(DIVPARAM,+SELDIV,+Y)) D
 ....       S CNT=CNT+1
 ....       S GRPS($G(TMPGRPS(DIVPARAM,+SELDIV,+Y)))=+Y_U_$G(DIVGRP(DIVPARAM,+Y))_U_$S(DIVPARAM="N":+$G(^NURSF(211.4,+Y,0)),1:"")
 ..    S GRPS(0)=CNT_U_DIVPARAM
 ..    I CNT=0 S GRPS(0)="0^E^Nothing Selected" Q
 .  E  D
 ..  D ^DIC
 ..  I $D(DUOUT)!$D(DTOUT)!(Y'>0) S OUT=1 Q
 ..  S GRPS(0)="1"_U_DIVPARAM
 ..  S GRPS($G(TMPGRPS(DIVPARAM,+SELDIV,+Y)))=+Y_U_$G(DIVGRP(DIVPARAM,+Y))_U_$S(DIVPARAM="N":+$G(^NURSF(211.4,+Y,0)),1:"")
 I OUT S GRPS(0)="0^E^user abort" Q
 ;
 Q
 ;
DIVACC(PRSDT,NDIVI) ; Return Nurse Access parameter for a division
 ;
 N PPI,PPE,PARAMIEN,EFFECTPP,IEN456
 S PPI=+$G(^PRST(458,"AD",PRSDT))
 ;
 ; Default to last pay period on file if none found for PRSDT
 I PPI'>0 S PPI=$O(^PRST(458,9999999),-1)
 ;
 S PPE=$P($G(^PRST(458,PPI,0)),U)
 S IEN456=$O(^PRST(456,"B",NDIVI,0))
 ;
 Q:IEN456="" ""
 ;
 S EFFECTPP=$O(^PRST(456,IEN456,1,"C",PPE_"A"),-1)
 ;
 Q:EFFECTPP="" ""
 ;
 Q $O(^PRST(456,IEN456,1,"C",EFFECTPP,0))_"^"_EFFECTPP
 ;
 Q
TLACC(TG,DM,DG,TND,DNP,INDEX,IEN200,PRSDT) ;get T&Ls user has access to.
 ; The T&L's division must also have access parameter set to T&L unit.
 ; Also return T&L's with no division or T&L's with a division (but the 
 ; division parameter isn't set) for warning messages but don't add 
 ; these to selection list.
 ; 
 ; OUTPUT:
 ;    TG: temporary array of groups user has access to
 ;    DM: Division Map-array of divisions 
 ;    DG: Division group array
 ;   TND: T&L with no divisions array
 ;   DNP: divisions with no parameter array
 ;
 ; Example of array
 ;
 ;     TG("N",500,5)="5-NORTH"
 ;     TG("N",16433,6)="3B-EAST"
 ;     TG("N",16436,1)="1E-EAST"
 ;     TG("T",500,261)=112
 ;     TG("T",16433,1)=221
 ;
 ;  Example of DM array:
 ;    0 node - total divisions ^ access param set ^ access param not set
 ;    other nodes - (IEN file 4)="Station number" (field #99)
 ; 
 ;     DM(0)=2
 ;     DM(16433)="500GA^T&L"
 ;     DM(16436)="500GD^NL"
 ;
 N TLI,FIELDS,TLE,NDIVACC,NDIVI
 ;
 S DM(0)="0^0^0"
 S TLI=""
 F  S TLI=$O(^PRST(455.5,INDEX,IEN200,TLI)) Q:TLI=""  D
 .   D GETS^DIQ(455.5,TLI_",",".01;20.5","IE","FIELDS(",,)
 .   S TLE=$G(FIELDS(455.5,TLI_",",.01,"E"))
 .   S NDIVI=$G(FIELDS(455.5,TLI_",",20.5,"I"))
 .   D GETS^DIQ(4,NDIVI_",",".01;99","EI","FIELDS(",,)
 .;
 .  I NDIVI="" S TND(TLE)="" Q
 .;
 .; Get date sensitive access parameter for POC entry/approval
 .; using pay period of PRSDT to find it in the Parameter file
 .;
 .  S NDIVACC=$P($$DIVACC(PRSDT,NDIVI),U)
 .;
 .;
 .; division access should be T&L Unit because we are looking
 .; at what T&L units this user is assigned to
 .;
 .  I NDIVACC'="T" Q
 .;
 .  S TG("T",NDIVI,TLI)=TLE
 .  S DM(NDIVI)=FIELDS(4,NDIVI_",",99,"E")_U_NDIVACC
 .  S DG("T",TLI)=NDIVI_U_FIELDS(4,NDIVI_",",99,"E")
 K FIELDS
 Q
 ;
 ;
NLACC(TG,DM,DG,NND,DNP,INDEX,IEN200,PRSDT) ;
 ;
 ; SEE DOCUMENTATION IN TLACC above for INPUT/OUPUT vars. The difference
 ; is this finds and returns access to locations instead of T&Ls.
 ;
 N LOCI,FIELDS,NDIVI,LOCE,NDIVACC,NURSLOC
 S LOCI=0
 F  S LOCI=$O(^NURSF(211.4,INDEX,IEN200,LOCI)) Q:LOCI'>0  D
 .;
 .  D GETS^DIQ(211.4,LOCI_",",".01;.02","IE","FIELDS(",,)
 .;
 .  S LOCE=$G(FIELDS(211.4,LOCI_",",.01,"E"))
 .  S NDIVI=$G(FIELDS(211.4,LOCI_",",.02,"I"))
 .;
 .   S NURSLOC=+$$GET1^DIQ(44,+$G(^NURSF(211.4,LOCI,0)),3,"I")
 .   D GETS^DIQ(4,NURSLOC_",",".01;99","EI","FIELDS(",,)
 .;
 .  I NDIVI="" S NND(LOCE)="" Q
 .  S NDIVACC=$P($$DIVACC(PRSDT,NURSLOC),U)
 .;
 .  I NDIVACC="" S DNP(NURSLOC)="" Q
 .;
 .; division access should be by Nursing Location-we are looking
 .; at what Nurse locations this user is assigned to
 .;
 .  I NDIVACC'="N" Q
 .;
 .  S DM(NURSLOC)=FIELDS(4,NURSLOC_",",99,"E")_U_NDIVACC
 .  S TG("N",NURSLOC,LOCI)=LOCE
 .  S DG("N",LOCI)=NURSLOC_U_FIELDS(4,NURSLOC_",",99,"E")
 K FIELDS
 Q
 ;
