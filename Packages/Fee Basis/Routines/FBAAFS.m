FBAAFS ;WCIOFO/dmk,SAB-OUTPATIENT FEE SCHEDULE ; 8/16/10 6:01pm
 ;;3.5;FEE BASIS;**4,53,71,92,99,111,115**;JAN 30, 1995;Build 9
 ;;Per VHA Directive 2004-038, this routine should not be modified.
LOOKUP ; Entry point for option to get fee schedule amount
 ; without having to enter in a payment
 ;
 W !!
 ;
 ; ask date of service - required
 S DIR(0)="D^::EX",DIR("A")="Enter date of service"
 S DIR("B")=$$FMTE^XLFDT($S($G(FBDATE):FBDATE,1:DT))
 D ^DIR K DIR I $D(DIRUT) G LOOKUPX
 S FBDATE=+Y
 I FBDATE<2990901 W !,"Note: Date is prior to VA implementation of RBRVS fee schedule (9/1/99).",!
 ;
 D CPTM^FBAALU(FBDATE) I 'FBGOT G LOOKUPX
 S FBCPT=FBX
 S FBMODLE=$$MODL^FBAAUTL4("FBMODA","E")
 ;
 ; ask vendor - optional
 S DIR(0)="PO^161.2:EM",DIR("A")="Enter Fee Basis Vendor [optional]"
 D ^DIR K DIR I $D(DTOUT)!$D(DUOUT) G LOOKUPX
 S FBVEN=$P(Y,U)
 ;
 ; ask zip - required
 D ASKZIP(FBVEN,FBDATE) I FBZIP="" G LOOKUPX
 ;
 ; ask place of service OR facility
 ;S DIR(0)="SA^0:NON-FACILITY;1:FACILITY",DIR("A")="Place of Service: "
 ;S DIR("B")="NON-FACILITY"
 ;D ^DIR K DIR I $D(DIRUT) G LOOKUPX
 ;S FBFAC=Y
 D POS^FBAACO1 I '$G(FBHCFA(30)) G LOOKUPX
 S FBFAC=$$FAC(FBHCFA(30))
 I FBFAC="" W $C(7),!,"Error: Can't determine if facility or non-facility setting" G LOOKUPX
 ;
 ; report schedule amount
 S FBRSLT=$$GET^FBAAFS(FBCPT,FBMODLE,FBDATE,FBZIP,FBFAC)
 I $P($G(FBRSLT),U)]"" D
 . W !?5,"Amount to Pay: $ ",$P(FBRSLT,U),"   from the "
 . W:$P(FBRSLT,U,3)]"" $P(FBRSLT,U,3)," " ; year if returned
 . W:$P(FBRSLT,U,2)]"" $$EXTERNAL^DILFD(162.03,45,"",$P(FBRSLT,U,2))
 I $P($G(FBRSLT),U)']"" D
 . W !?5,"Unable to determine a FEE schedule amount.",!
 . I $D(FBERR) D DERR
 ;
 G LOOKUP
 ;
LOOKUPX ; exit for lookup
 K DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 K FBAACP,FBAAOUT,FBCPT,FBDATE,FBERR,FBFAC,FBGOT,FBMOD,FBMODLE,FBMODS
 K FBRSLT,FBVEN,FBX,FBZIP
 Q
 ;
GET(CPT,MODL,DOS,ZIP,FAC,TIME) ; call to calculate Fee Schedule amount
 ; Input
 ;   CPT    - CPT/HCPCS code, external value, required
 ;   MODL   - list of optional CPT/HCPCS modifiers, external values
 ;            delimited by commas
 ;   DOS    - date of service, fileman format, required
 ;   ZIP    - zip code, 5 digit, required
 ;   FAC    - facility flag, 0 or 1, required
 ;            indicates if procedure was performed in facility (1)
 ;            or non-facility (0)
 ;   TIME   - anesthesia time (minutes), reserved for future use
 ; Returns string
 ;   dollar amount^schedule used^schedule year (only when RBRVS)
 ;
 N FBAMT,FBERR,FBSCH,FBSCHYR
 ; initialization
 S (FBAMT,FBSCH,FBSCHYR)=""
 K FBERR
 S CPT=$G(CPT)
 S DOS=$G(DOS)
 S ZIP=$G(ZIP)
 S FAC=$G(FAC)
 S TIME=$G(TIME)
 ;
 ; validate input parameters
 I CPT="" D ERR("Missing CPT")
 I DOS'?7N D ERR("Invalid Date of Service")
 ;
 ; try RBRVS schedule
 I '$D(FBERR) D
 . S FBX=$$RBRVS^FBAAFSR(CPT,MODL,DOS,ZIP,FAC,TIME)
 . S:$P(FBX,U)]"" FBAMT=$P(FBX,U),FBSCH="R",FBSCHYR=$P(FBX,U,2)
 . K FBERR
 ;
 ; if not on RBRVS schedule try 75th percentile schedule
 I '$D(FBERR),FBAMT']"" D
 . S FBAMT=$$PRCTL^FBAAFSF(CPT,MODL,DOS)
 . S:FBAMT]"" FBSCH="F",FBSCHYR=""
 . K FBERR
 ;
 ; return result
 K FBERR
 Q $S(FBAMT]"":FBAMT_U_FBSCH_U_FBSCHYR,1:"")
 ;
ERR(MSG) ; add error message to array
 S FBERR=$G(FBERR)+1
 S FBERR(FBERR)=MSG
 Q
 ;
DERR ; display error messages
 N FBI
 F FBI=0 F  S FBI=$O(FBERR(FBI)) Q:'FBI  W !,FBERR(FBI)
 Q
 ;
ASKZIP(FBVEN,FBDOS) ;called from payment routines to ask user the
 ;site of service zip code.
 ; input
 ;   FBVEN - (optional) internal entry number of vendor (#161.2)
 ;           used to determine a default zip code
 ;   FBDOS - (optional) date of service
 ;           used to determine if GPCIs are available for the zip code
 ; output
 ;   FBZIP - zip code, 5 digit
 ;   FBAAOUT if user '^' out without answering
 N DIR,DUOUT,DIRUT,DTOUT,X,Y
 N FBCY,FBGPCIY0
ASKZIP1 ;
 S FBZIP=""
 S DIR(0)="162.03,42"
 ; set default zip code if vendor available
 I $G(FBVEN) D
 . S X=$P($P($G(^FBAAV(FBVEN,0)),U,6),"-")
 . I X]"" S DIR("B")=X
 D ^DIR K DIR I $D(DIRUT) S FBAAOUT=1 Q
 S FBZIP=Y
 ;
 ; if date after VA implementation then check for GPCIs
 I $G(FBDOS)]"",FBDOS>2990900 D  I Y D ASKZIP1
 . S FBCY=$E(FBDOS,1,3)+1700
 . ; if year after most recent RBRVS schedule then use prior year sched
 . I FBCY>$$LASTCY^FBAAFSR() S FBCY=FBCY-1
 . D ZIP^FBAAFSR(FBCY,FBZIP)
 . S Y=0 I FBGPCIY0="" D
 . . W $C(7),!,"Warning: ",FBCY," GPCIs are not on file for this zip code."
 . . S DIR(0)="Y",DIR("A")="Do you want to enter a different zip code"
 . . S DIR("B")="YES"
 . . S DIR("?",1)="Geographic Practice Cost Index (GPCI) values are"
 . . S DIR("?",2)="needed for calculation of the RBRVS physician fee"
 . . S DIR("?",3)="schedule amount. There are not any GPCI values on"
 . . S DIR("?",4)="file for the specified year and zip code."
 . . S DIR("?")="Answer YES to enter a different zip code."
 . . D ^DIR K DIR
 Q
 ;
ASKTIME ;called to ask time in minutes if the service provided
 ;is an anesthesia service (00100-01999)
 ;return FBTIME equal to # of minutes or zero if '^'/timeout
 ;return FBAAOUT if user does not answer
 S FBTIME=0
 S DIR(0)="162.03,43" D ^DIR K DIR I $D(DTOUT)!($D(DUOUT)) S FBAAOUT=1 Q
 S FBTIME=+Y
 I '$G(FBTIME) D  G ASKTIME
 . W !,$C(7),"Time entry is required!",!
 Q
 ;
ANES(CPT) ; call to determine if the CPT code has a major category
 ;of anesthesia.
 ; CPT = 5 digit CPT code (EXTERNAL)
 ; returns 1 if CPT is an anesthesia code else return 0.
 ;
 N FBCAT,FBMCAT
 S CPT=$G(CPT)
 S FBCAT=$P($$CPT^ICPTCOD(CPT),U,4)
 S FBMCAT=$P($$CAT^ICPTAPIU(FBCAT),U,4)
 Q $S(FBMCAT="ANESTHESIA":1,1:0)
 ;
FAC(POS) ; call to determine if the place of service is a facility
 ; Input
 ;   POS - place of service, internal, pointer to #353.1
 ; Returns 0 or 1 or null
 ;   = 0 if place of service is non-facility setting
 ;   = 1 if place of service is facility setting
 ;   = null value if type of setting could not be determined
 N CODE,RET
 S (CODE,RET)=""
 I $G(POS)]"" S CODE=$$GET1^DIQ(353.1,POS,.01)
 ; list of codes considered as facility settings
 S FCODE="^05^06^07^08^21^22^23^24^26^31^34^41^42^51^52^53^56^61^"
 ; list of codes considered as non-facility settings
 S NFCODE="^01^03^04^09^11^12^13^14^15^16^17^20^25^32^33^49^50^54^55^57^60^62^65^71^72^81^99^"
 I FCODE[(U_CODE_U) S RET=1
 I NFCODE[(U_CODE_U) S RET=0
 Q RET
 ;
 ;FBAAFS
