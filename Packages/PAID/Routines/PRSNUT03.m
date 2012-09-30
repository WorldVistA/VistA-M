PRSNUT03 ;;WOIFO/JAH - Nurse Activity for VANOD Utilities;6/5/2009
 ;;4.0;PAID;**126**;Sep 21, 1995;Build 59
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 Q
 ;
PRIMLOC(IEN200) ; RETURN NURSES PRIMARY ASSIGMENT LOCATION
 ;
 ;FUNCTION RETURNS Nurses primary assigment from Nursing Service package
 ;  piece     value
 ;   1        ien of location from 211.4
 ;   2        .01 value which is pointer to 44
 ;   3        external value of .01 field (e.g., 4 WEST)
 ;
 ; INPUT:
 ;    PRSIEN:  IEN from New Person file (200)
 ;
 Q:IEN200'>0 "0^Nurse not found"
 ;
 N D0
 S D0=$O(^NURSF(210,"B",IEN200,0))
 Q:D0'>0 "0^Nurse not found"
 ;
 ; call returns external name of nurse location in X
 ; 
 N X,LOCI,LOCE
 D EN2^NURSUT2
 Q $$NLIEN^PRSNUT03(X)
 ;
NLIEN(NLE) ;
 ;  INPUT:
 ;    NLE - nurse location external name (without NUR prefix)
 ;  OUTPUT:
 ;    function returns 211.4 IEN ^ .01 pointer ^ external
 ;
 N LOCP,LOCI,LOCE,PL
 I NLE="" Q ""
 D FIND^DIC(211.4,,".01","M","NUR "_NLE,,,,,"PL",)
 S LOCP=$G(PL("DILIST",1,1))
 S LOCI=$G(PL("DILIST",2,1))
 S LOCE=$G(PL("DILIST","ID",1,.01))
 Q LOCI_U_LOCP_U_LOCE
 ;
LOCNOD(LOC) ; given a location in 211.4 return the node necessary to find
 ; all the nurses in 211.8 with that primary location out of the 
 ;  "D" index on the primary assignment field.
 N POINT44
 S POINT44=+$G(^NURSF(211.4,LOC,0))
 Q:POINT44'>0 -1
 Q +$O(^NURSF(211.8,"B",POINT44,0))
 ;
PICKNURS(GROUP,VALUE) ; pick a nurse from a t&l or location
 ; INPUT:
 ;     GROUP = T for T&L or N for Nurse Location
 ;     VALUE = IEN (T&L 455.5 or Nurse Location 211.4)
 ; OUTPUT:
 ;     function returns a Nurse file 450 (IEN^external Name)
 ;
 Q:"T^N^"'[(GROUP_U) 0
 Q:VALUE'>0 0
 ;
 N DIC,X,Y,TLE,D,S1,S2,REFD,S3
 S DIC("A")="Select Nurse: "
 S DIC="^PRSPC("
 S DIC(0)="AEQZ"
 I GROUP="T" D
 . S DIC("S")="I $$ISNURSE^PRSNUT01(Y)"
 . S TLE=$P($G(^PRST(455.5,VALUE,0)),U)
 . S D="ATL"_TLE
 . D MIX^DIC1
 E  D
 .  S REFD=+$G(^NURSF(211.4,VALUE,0))
 .  S S3=""
 .  ;S DIC("S")="N VA200IEN,NAME I $$ISNURSE^PRSNUT01(Y) S VA200IEN=+$G(^PRSPC(+Y,200)) I VA200IEN S NAME=$P($G(^VA(200,VA200IEN,0)),U) I NAME'="""",$D(^NURSF(211.8,""D"",REFD,NAME,VA200IEN))"
 .  S DIC("S")="N VA200IEN I $$ISNURSE^PRSNUT01(Y) S VA200IEN=+$G(^PRSPC(+Y,200)) I VA200IEN,REFD=+$$PRIMLOC^PRSNUT03(VA200IEN)"
 .  D ^DIC
 Q Y
 ;
DIV(GROUP,VALUE) ; Return the division of a location or a T&L unit
 ;
 ; INPUT:
 ;     GROUP = T for T&L or N for Nurse Location
 ;     VALUE = IEN (T&L 455.5 or Nurse Location 211.4)
 ; OUTPUT:
 ;     Function returns division of input group
 ;
 Q:"T^N^"'[(GROUP_U) 0
 N DIV,STANUM,NLP,P4
 I GROUP="N" D
 .  S NLP=+$G(^NURSF(211.4,VALUE,0))
 .  S P4=+$$GET1^DIQ(44,NLP,3,"I")
 E  D
 .  S P4=+$$GET1^DIQ(455.5,VALUE,20.5,"I")
 S DIV=$$GET1^DIQ(4,P4,.01,"I")
 S STANUM=$$GET1^DIQ(4,P4,99,"I")
 Q DIV_U_STANUM_U_P4
 ;
ENTRYPNT ;
 N DIVMAP,DIVS
 D BLDMAP(.DIVMAP)
 S DIVS=$$SELECT(.DIVMAP)
 Q:DIVS=0
 N DIR,DIRUT,SRT,Y,X,SHOW
 S DIR(0)="SB^T:T&L UNIT;N:NURSE LOCATION"
 S DIR("B")="T"
 S DIR("A")="Select Sort: "
 D ^DIR
 Q:$D(DIRUT)
 S SRT=Y
 N DIR,Y,X
 S DIR(0)="Y"
 S DIR("B")="N"
 S DIR("A")="Show Full Nurse Data"
 D ^DIR
 Q:$D(DIRUT)
 S SHOWNURS=Y
 N %ZIS,POP,IOP
 S %ZIS="MQ"
 D ^%ZIS
 Q:POP
 I $D(IO("Q")) D
 . K IO("Q")
 . N ZTSK,ZTDESC,ZTDTH,ZTIO,ZTRTN,ZTSAVE,ZTUCI,ZTCPU,ZTPRI,ZTKIL,ZTSYNC
 . S ZTDESC="PRSN SHOW ALL NURSES"
 . S ZTRTN="ALNURLST^PRSNUT03(0,SRT,SHOWNURS)"
 . S ZTSAVE("SHOWNURS")=""
 . S ZTSAVE("SRT")=""
 . S ZTSAVE("FLAG")=""
 . S ZTSAVE("DIVMAP(")=""
 . S ZTSAVE("DIVS")=""
 . D ^%ZTLOAD
 . I $D(ZTSK) S ZTREQ="@" W !,"Request "_ZTSK_" Queued."
 E  D
 . D ALNURLST(0,SRT,SHOWNURS)
 Q
ALNURLST(FLAG,SORT,SHOWNURS) ;List all Nurses in file 450
 ; INPUT:
 ;    FLAG - set to true if you want to attempt to add the Nurse
 ;           to file 200.  this will also convert any numbers in
 ;           the name from file 450 to letters
 ;    SORT - (required) If "N" will sort by Nurse location, "T"
 ;           report sorts by T&L unit.
 ;    SHOWNURS - Set to true if you want to see the full info
 ;               about a nurses role
 ;
 Q:"T^N^"'[(SORT_U) 0
 U IO
 K ^TMP($J,"PRSN")
 N N2CNT,NCNT
 S (NCNT,N2CNT)=0
 D GATHER
 N STOP
 D REPORT(.STOP)
 D TOTAL(.STOP)
 D ^%ZISC
 Q
GATHER ;
 N PRSIEN,X,IEN200,SSN,OUT,SSN200,NAME,ZNODE,TLE,NURTYP
 N SRT1,SRT2,NL,SEPFLAG,NLE,NLDIV
 S (PRSIEN)=0
 F  S PRSIEN=$O(^PRSPC(PRSIEN)) Q:PRSIEN'>0  D
 . S X=$$ISNURSE^PRSNUT01(PRSIEN)
 . Q:'X
 . S SEPFLAG=$P($G(^PRSPC(PRSIEN,1)),U,33)
 . Q:SEPFLAG="Y"
 . S NCNT=NCNT+1
 . S NURTYP=$P(X,U,2,4)
 . I $G(FLAG) W @IOF,!!!
 . S IEN200=$P($G(^PRSPC(PRSIEN,200)),U)
 . S ZNODE=$G(^PRSPC(PRSIEN,0))
 . S SSN=$P(ZNODE,U,9)
 . S NAME=$P(ZNODE,U)
 . S TLE=$P(ZNODE,U,8)
 . I TLE="" S TLE="NONE"
 . S (NL,NLE,NLDIV)="NONE"
 . I IEN200>0 D
 .. S N2CNT=N2CNT+1
 .. S SSN200=$P($G(^VA(200,IEN200,1)),U,9)
 .. S NL=$$PRIMLOC^PRSNUT03(IEN200)
 .. S NLE=$P(NL,U,3)
 .. I NLE="" S NLE="NONE"
 .. I NL>0 D
 ... S NLDIV=$P(DIVMAP("NL",+NL),U,3)
 .. E  D
 ... S (NLDIV,NLE)="NONE"
 . E  D
 .. I $G(FLAG) D ADDNRS
 . I NLDIV'="NONE",DIVS'<0,DIVS'=NLDIV Q  ;NOT ALL DIVS OR NOT THE DIV WE'RE LOOKING FOR
 . S SRT1=$S($G(SORT)="N":NLE,1:TLE)
 . S SRT2=$S($G(SORT)="N":TLE,1:NLE)
 . S ^TMP($J,"PRSN",SRT1,SRT2,PRSIEN)=SSN_U_NAME_U_IEN200_U_$G(SSN200)_U_NLE_U_TLE
 . S ^TMP($J,"PRSN",SRT1,SRT2,PRSIEN,1)=NURTYP
 Q
REPORT(STOP) ;
 ;
 ;Print the data in the tmp array by the sort parameter
 ;
 N PAGE,GIEN,PRSIEN,DAT,SD,NL,NTL,TL
 S (PAGE,STOP)=0
 S GROUP=""
 D HDR
 F  S GROUP=$O(^TMP($J,"PRSN",GROUP)) Q:GROUP=""!STOP  D
 .  W !?17,$S($G(SORT)="N":"NURSING LOCATION: ",1:"T&L UNIT: ")
 .  I SORT="N" D
 ..    S GIEN=$$NLIEN^PRSNUT03(GROUP)
 .  E  D
 ..    S GIEN=$O(^PRST(455.5,"B",GROUP,0))
 .  S SD=$$DIV^PRSNUT03(SORT,+GIEN)
 .  W GROUP,!,?17,"STATION: ",$P(SD,U)," (",$P(SD,U,2),")"
 .  W !?12,"--------------------------------------------"
 .  S SRT2=""
 .  F  S SRT2=$O(^TMP($J,"PRSN",GROUP,SRT2)) Q:SRT2=""!STOP  D
 ..   S PRSIEN=0
 ..   F  S PRSIEN=$O(^TMP($J,"PRSN",GROUP,SRT2,PRSIEN)) Q:PRSIEN'>0!STOP  D
 ...    S DAT=$G(^TMP($J,"PRSN",GROUP,SRT2,PRSIEN))
 ...    S NURTYP=$G(^TMP($J,"PRSN",GROUP,SRT2,PRSIEN,1))
 ...    S NAME=$P(DAT,U,2)
 ...    S IEN200=$P(DAT,U,3)
 ...    S NL=$P(DAT,U,5)
 ...    S TL=$P(DAT,U,6)
 ...    S SSN=$E($P(DAT,U,1),6,9)
 ...    W !,NAME,?23,SSN,?28,PRSIEN,?35,IEN200
 ...    W ?46,$S($G(SORT)="N":TL,1:NL)
 ...    I $G(SHOWNURS) D
 ....      W !,?5,$P(NURTYP,U,1),?25,$P(NURTYP,U,2),?50,$P(NURTYP,U,3),!
 ...    E  D
 ....      S X=$P(NURTYP,U)
 ....      S NTL=$L(X)
 ....      I NTL>15 D
 .....        S DIWL=64
 .....        S DIWF="WC15"
 .....        K ^UTILITY($J,"W")
 .....        D ^DIWP,^DIWW K DIWL,DIWF
 ....      E  D
 .....       I $X>62 W !
 .....       W ?63,X
 ...   I (IOSL-5)<$Y S STOP=$$ASK^PRSLIB00() D HDR
 ...   I $G(FLAG) S STOP=$$ASK^PRSLIB00()
 Q
TOTAL(STOP) ;
 W !,"ALL DONE" I STOP W ":  User Aborted"
 W !,"VA Nurse Count: ",NCNT,!,"Nurses with DUZ: ",N2CNT
 Q
ADDNRS ;
 ; edit PAID 450 Employee name replaceing digits 0..9 with A..J
 ;
 N NEWNAME
 S NEWNAME=$TR(NAME,"0123456789","ABCDEFGHIJ")
 W !,"NAME: ",NAME,!,"NEW:  ",NEWNAME,!,"Y: ",Y,!,"Y(0): ",$G(Y(0))
 N DIE,DR,DA
 S DIE="^PRSPC(",DA=PRSIEN,DR=".01///^S X=NEWNAME" D ^DIE
 ;
 ;
 ; add PAID Nurse employees to file 200
 ;
 N DIC,X,Y
 K DD,DO
 S DIC(0)="LZ",X=NEWNAME,DIC="^VA(200," D FILE^DICN
 ;
 ; edit ssn in 200
 ;
 I +Y D
 . S DIE="^VA(200,",DA=+Y,DR="9///^S X=SSN" D ^DIE
 Q
HDR ;
 W @IOF
 S PAGE=PAGE+1
 W ?68,"PAGE ",PAGE
 W !," NAME",?21,"SSN",?26,"IEN 450",?35,"IEN 200"
 W ?46,$S($G(SORT)="N":"T&L",1:"PRIM LOC")
 I $G(SHOWNURS) D
 .  W !,"     NURSE ROLE"
 E  D
 .  W ?64,"NURSE TYPE"
 W !,"======================================================================="
 Q
 ;
BLDMAP(DIVMAP) ; BUILD A DIVISION MAP OF LOCATIONS
 N DIVINFO,LIEN
 S LIEN=0
 F  S LIEN=$O(^NURSF(211.4,LIEN)) Q:LIEN'>0  D
 .  S DIVINFO=$$DIV^PRSNUT03("N",LIEN)
 .  S DIVMAP("NL",LIEN)=DIVINFO
 .  S DIVMAP("IN",$P(DIVINFO,U,3))=$P(DIVINFO,U,1,2)
 Q
 ;
SELECT(DM) ; Allow selection of one or all from division
 N DIC,DUOUT,DTOUT,X,Y
 S DIC="^DIC(4,",DIC(0)="AEQMZ"
 S DIC("S")="I $D(DM(""IN"",+Y))"
 S DIC("A")="Select Division or Return for All: "
 D ^DIC
 I $D(DUOUT)!$D(DTOUT) Q 0
 Q +Y
 ;
