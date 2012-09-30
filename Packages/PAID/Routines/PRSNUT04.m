PRSNUT04 ;;WOIFO/JAH - Nurse Activity for VANOD Utilities;8/25/2009
 ;;4.0;PAID;**126**;Sep 21, 1995;Build 59
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 Q
 ;
HASACCES(IEN200,PRSIEN,ACCTYP) ;FUNCTION RETURNS TRUE if the user defined in 
 ; parameter IEN200 has access to the Nurse defined in parameter PRSIEN
 ;
 ;INPUT:  
 ;   IEN200: accessors' internal entry number in file 200 (DUZ)
 ;   PRSIEN: nurses' internal entry number in file 450.
 ;   ACCTYP: 'E' OR 'A' for data Entry or Approver
 ;
 ;OUTPUT:
 ;   HASACCES: function returns true if user has access to this nurse
 ;
 N HASACCES
 S HASACCES=0
 ;
 ; Get T&L unit and default location of Nurse plus division 
 ; associated with each
 ;
 ;  T&L + division
 N TLE,TLI,TLDIVI,TINDEX,LINDEX
 D GETS^DIQ(450,PRSIEN_",",7,"I","FIELDS(",,)
 S TLE=$G(FIELDS(450,PRSIEN_",",7,"I"))
 S TLI=$O(^PRST(455.5,"B",TLE,0))
 ;
 I TLI>0 D
 .  D GETS^DIQ(455.5,TLI_",","20.5","I","FIELDS(",,)
 .  S TLDIVI=$G(FIELDS(455.5,TLI_",",20.5,"I"))
 ;
 ;  Nurses (PRSIEN) Primary Location + division
 N NLI,NURIE200,LINDEX,NLDIVI
 ;
 S NURIE200=+$G(^PRSPC(PRSIEN,200))
 S NLI=+$$PRIMLOC^PRSNUT03(NURIE200)
 S NLDIVI=$P($$DIV^PRSNUT03("N",+NLI),U,3)
 ;
 ;  Build list of all T&Ls and Locations that (APPROVER/ENTRY PERS)
 ;  in IEN200 has access to subscripted by group ien and division ien
 ;
 S TINDEX=$S(ACCTYP="E":"AE",ACCTYP="A":"AR",1:"")
 S LINDEX=$S(ACCTYP="E":"AE",ACCTYP="A":"AA",1:"")
 ;
 N TMPGRPS,DIVMAP,DIVGRP,TN,DN
 D TLACC^PRSNUT02(.TMPGRPS,.DIVMAP,.DIVGRP,.TN,.DN,TINDEX,IEN200,DT)
 D NLACC^PRSNUT02(.TMPGRPS,.DIVMAP,.DIVGRP,.TN,.DN,LINDEX,IEN200,DT)
 ; 
 ; Array (returned from above calls) and shown below indicates that
 ; the user (IEN200) has access to both 'N' nurse locations
 ; and 'T' t&l units for division 16433 and division 500
 ; the last subscipt is the IEN of the t&l or nurse location
 ;
 ;   TMPGRPS("N",16433,4)="3B-WEST 500GA"
 ;   TMPGRPS("N",16433,5)="5-NORTH"
 ;   TMPGRPS("T",500,222)=110
 ;   TMPGRPS("T",500,230)=117
 ;
 ; Check to see if IEN200 (ENTRY/APPROVAL) matches access to the
 ; Nurses (PRSIEN) location or T&L (including correct division
 ; parameter for that access)
 ;
 I TLDIVI>0,$D(TMPGRPS("T",TLDIVI,TLI)) S HASACCES=1
 I NLDIVI>0,$D(TMPGRPS("N",NLDIVI,NLI)) S HASACCES=1
 ;
 Q HASACCES
 ;
 ;=================================================================
 ;
PIKGROUP(GRPS,GCHOICE,MANY) ;return the groups selected by a user regardless of access
 K GRPS
 ;
 ;INPUT:
 ;  GCHOICE:  (optional) Flag set to T, N or null
 ;            T: user will be prompted for T&L units
 ;            N: user will be prompted for Nurse Locations
 ;         null: user will be asked T&L units or locations
 ;  MANY-  (optional) set this flag to true (1) if more than one
 ;         group can be selected
 ;
 ;OUTPUT:
 ;PROCEDURE INTERACTS WITH USER AND RETURNS THE FOLLWOING:
 ;
 ;  GRPS - An array with the users selected groups subscripted
 ;         by .01 field value (t&l external code or location pointer)
 ;  GRPS(0) - will contain the number selected followed by either
 ;            N,T, or E for Nurse Location, T&L unit or Error
 ;            If piece 2 is an E then piece 3 will contain error
 ;            description
 ;         
 ;  Node Definition: an Upparrow delimited string with the following:
 ;     PEICE  DEFINITION
 ;     =====  ==============================
 ;       1    internal entry number of field value of group 
 ;       2     IEN of Division associated with this Group
 ;       3     External value of division
 ;
 ;  Sample Call:
 ;
 ;      D PIKGROUP^PRSNUT04(.G,"T",1)    
 ;
 ;  Sample Return:
 ;
 ;      G(0)="3^N"
 ;      G("1E-EAST")="1^16433^500GA"
 ;      G("3B-EAST")="6^16433^500GA"
 ;      G("3B-WEST")="4^16433^500GA"
 ;
 ; Build temporary list of all possible groups 
 ;  If user has access to groups in more than one division then
 ;  prompt to select a division
 ;
 ; Example of TMPGRPS array
 ;
 ;     TMPGRPS("N",500,5)="5-NORTH"
 ;     TMPGRPS("N",16433,6)="3B-EAST"
 ;     TMPGRPS("N",16436,1)="1E-EAST"
 ;     TMPGRPS("T",500,261)=112
 ;     TMPGRPS("T",16433,1)=221
 ;
 ;  Example of DIVMAP array:
 ;    0 node - total divisions ^ access param set ^ access param not set
 ;    other nodes - (IEN file 4)="Station number" (field #99)
 ; 
 ;    DIVMAP(0)=2
 ;    DIVMAP(16433)="500GA^T&L"
 ;    DIVMAP(16436)="500GD^NL"
 ;
 N TLI,FIELDS,TLE,TMPGRPS,DIVMAP,LOCI,LOCE,I,DIVNOPAR,EFFECTPP,DIVPARAM
 N NURSLOC,SELDIV,TINDEX,TLDIVI,DIVGRP,DIVI
 ;
 S DIVMAP(0)="0^0^0"
 S TLI=0
 F  S TLI=$O(^PRST(455.5,TLI)) Q:TLI'>0  D
 .   D GETS^DIQ(455.5,TLI_",",".01;20.5","IE","FIELDS(",,)
 .   S TLE=$G(FIELDS(455.5,TLI_",",.01,"E"))
 .   S DIVI=$G(FIELDS(455.5,TLI_",",20.5,"I"))
 .;
 .  Q:DIVI=""
 .;
 .   D GETS^DIQ(4,DIVI_",",".01;99","EI","FIELDS(",,)
 .;
 .  S TMPGRPS("T",DIVI,TLI)=TLE
 .  S DIVMAP(DIVI)=FIELDS(4,DIVI_",",99,"E")
 .  S DIVGRP("T",TLI)=DIVI_U_FIELDS(4,DIVI_",",99,"E")
 K FIELDS
 ;
 S LOCI=0
 F  S LOCI=$O(^NURSF(211.4,LOCI)) Q:LOCI'>0  D
 .;
 .  D GETS^DIQ(211.4,LOCI_",",".01;.02","IE","FIELDS(",,)
 .;
 .  S LOCE=$G(FIELDS(211.4,LOCI_",",.01,"E"))
 .  S DIVI=$G(FIELDS(211.4,LOCI_",",.02,"I"))
 .;
 .   S NURSLOC=+$$GET1^DIQ(44,+$G(^NURSF(211.4,LOCI,0)),3,"I")
 .   D GETS^DIQ(4,NURSLOC_",",".01;99","EI","FIELDS(",,)
 .;
 .  Q:DIVI=""
 .;
 .  S DIVMAP(NURSLOC)=FIELDS(4,NURSLOC_",",99,"E")
 .  S TMPGRPS("N",NURSLOC,LOCI)=LOCE
 .  S DIVGRP("N",LOCI)=NURSLOC_U_FIELDS(4,NURSLOC_",",99,"E")
 K FIELDS
 ;
 ;
 I '$D(DIVMAP) S GRPS(0)="0^E^No T&Ls or Locations found with correct division setup." Q
 ;
 ; count number of divisions with t&ls and locations
 ;
 N CNT,DIVI
 S (DIVI,CNT)=0 F  S DIVI=$O(DIVMAP(DIVI)) Q:DIVI'>0  S CNT=CNT+1
 ;
 N OUT
 S OUT=0
 I CNT>1 D
 .  W !?5,"Location(s) and T&L units are in more than one division"
 .  N DIC,X,Y,DUOUT,DTOUT
 .  S DIC(0)="AEQMZ"
 .  S DIC="^DIC(4,"
 .  S DIC("S")="I $D(DIVMAP(Y))"
 .  D ^DIC
 .  I $D(DUOUT)!$D(DTOUT)!(Y'>0) S OUT=1
 .  S SELDIV=$G(Y)
 E  D
 .  S SELDIV=$O(DIVMAP(0))
 I OUT S GRPS(0)="0^E^user abort" Q
 ;
 ; prompt user for location or T&L within selected division
 ;
 N DIR,DIRUT,X,Y
 I "^N^T^"'[(U_$G(GCHOICE)_U) D
 .  S DIR(0)="S^T:T&L Units;N:Nurse Locations"
 .  S DIR("A")="Enter Selection"
 .  S DIR("?")="Enter whether you want to select T&L units or Locations."
 .  D ^DIR
 .  S DIVPARAM=Y
 E  D
 .  S DIVPARAM=GCHOICE
 I $D(DIRUT) S GRPS(0)="0^E^user abort" Q
 ;
 N DIC,X,Y,DUOUT,DTOUT,VAUTSTR,VAUTNI,VAUTVB,OUT,PRSNGR
 S OUT=0
 ;      select t&l unit OR nurse location
 I DIVPARAM="T" D
 .  S VAUTSTR="T&L Units"
 .  S DIC="^PRST(455.5,"
 E  D
 .  S VAUTSTR="Nurse Location"
 .  S DIC="^NURSF(211.4,"
 S DIC(0)="AEQMZ"
 S DIC("S")="I $D(TMPGRPS(DIVPARAM,+SELDIV,+Y))"
 I $G(MANY) D
 .  S VAUTNI=2,VAUTVB="PRSNGR"
 .  D FIRST^VAUTOMA
 .  S (CNT,Y)=0
 .  I 'PRSNGR D
 ..    F  S Y=$O(PRSNGR(Y)) Q:Y=""  D
 ...     I $D(TMPGRPS(DIVPARAM,+SELDIV,Y)) D
 ....      S CNT=CNT+1
 ....      S GRPS($G(TMPGRPS(DIVPARAM,+SELDIV,Y)))=+Y_U_$G(DIVGRP(DIVPARAM,+Y))_U_$S(DIVPARAM="N":+$G(^NURSF(211.4,+Y,0)),1:"")
 .  E  D
 ..    ; all groups selected, so update output array with them
 ..    F  S Y=$O(DIVGRP(DIVPARAM,Y)) Q:Y=""  D
 ...     I $D(TMPGRPS(DIVPARAM,+SELDIV,Y)) D
 ....      S CNT=CNT+1
 ....      S GRPS($G(TMPGRPS(DIVPARAM,+SELDIV,Y)))=+Y_U_$G(DIVGRP(DIVPARAM,+Y))_U_$S(DIVPARAM="N":+$G(^NURSF(211.4,+Y,0)),1:"")
 .;
 .  S GRPS(0)=CNT_U_$E(DIVPARAM,1,1)
 .  I CNT=0 S GRPS(0)="0^E^Nothing Selected" Q
 E  D
 .  D ^DIC
 .  I $D(DUOUT)!$D(DTOUT)!(Y'>0) S OUT=1 Q
 .  S GRPS(0)="1"_U_$E(DIVPARAM,1,1)
 .  S GRPS($G(TMPGRPS(DIVPARAM,+SELDIV,+Y)))=+Y_U_$G(DIVGRP(DIVPARAM,+Y))_U_$S(DIVPARAM="N":+$G(^NURSF(211.4,+Y,0)),1:"")
 I OUT S GRPS(0)="0^E^user abort" Q
 ;
 Q
 ;
