SDECSTP ;ALB/BNT - SCHEDULING ENHANCEMENTS STOP CODES ;11/04/2012
 ;;5.3;Scheduling;**628**;Aug 13, 1993;Build 371
 ;
 ; Reference to file 40.7 supported through IA 557
 ; Reference to ^XPAR supported through IA 2263
 ; Reference to ^SC global supported through IA 10040
 ; Reference to ^%ZTLOAD supported by IA #10063
 ;
 Q
 ;
LST ; Display the SCHEDULING STOP CODES Parameters
 N LIST,NP,SCIEN,SDECTYPE,CLSTIEN,ARR,SDECQ,SDECPAGE,NP
 N SDECDATA,SDECLNS,SDECSCR,SDECNOW,SDECARR,SDECPARM,ZTQUEUED,ZTREQ
 S (SDECQ,SDECPAGE,NP,SDECDATA,SDECLNS,SDECSCR,SDECDESC)=0
 S SDECNOW=$$FMTE^XLFDT(DT)
 D DEVICE I SDECQ Q
 ;
 D HDR(.SDECPAGE,1,SDECNOW)
 F SDECPARM="SDEC PRIMARY CARE STOP CODES","SDEC SPECIALTY CARE STOP CODES","SDEC MENTAL HEALTH STOP CODES" D  Q:SDECQ
 . N LIST,X,CLSTIEN,SDECSTP,SDECARR D GETLST^XPAR(.LIST,"PKG.SCHEDULING",SDECPARM,"B")
 . I $G(LIST)=0 D ADD(SDECPARM) Q
 . ; Sort the list by Stop Code number first
 . S X="" F  S X=$O(LIST(X)) Q:X=""  D
 . . S CLSTIEN=$P(LIST(X,"N"),U)
 . . S SDECSTP=$P(^DIC(40.7,CLSTIEN,0),U,2)
 . . S SDECARR(SDECSTP)=$P(LIST(X,"N"),U,2)
 . ; Print the sorted list
 . S X="" F  S X=$O(SDECARR(X)) Q:X=""  D  Q:SDECQ
 . . S NP=$$CHKP(1,1,SDECNOW) Q:SDECQ
 . . D WRLN1(X_" - "_SDECARR(X),$S(SDECPARM["PRIMARY":"Primary Care",SDECPARM["SPECIALTY":"Specialty Care",1:"Mental Health"))
 . ;Q:SDECQ  D PAUSE Q:SDECQ
 Q
 ;
LSTCLN ; Display all Hospital Locations with SCHEDULING Stop Codes
 N CLST,HLOC,HLOCIEN,SDECSTP,SDECQ,SDECPAGE,NP,SDECDATA,SDECLNS,SDECSCR,SDECDESC,SDECNOW,SDECARR,SDECCNT,SDECTOT,SDRT,SDECLN
 S (SDECQ,SDECPAGE,NP,SDECDATA,SDECLNS,SDECSCR,SDECDESC,SDECCNT,SDECTOT)=0
 S SDECNOW=$$FMTE^XLFDT(DT)
 ;
 ; Write Wait Message
 W ! D WAIT^DICD
 ; Get Hospital Location
 D GETCLNS(.SDECARR)
 ;
 D DEVICE I SDECQ Q
 D HDR(.SDECPAGE,2,SDECNOW) Q:SDECQ
 ; Write the Locations
 S SDECLN="" F SDRT="P","S","M"  F  S SDECLN=$O(SDECARR(SDRT,SDECLN)) Q:SDECLN=""  D  Q:SDECQ
 . S NP=$$CHKP(1,2,SDECNOW) Q:SDECQ
 . D WRLN2(SDECLN,SDRT,$P(SDECARR(SDRT,SDECLN),U,2)_"-"_$P(SDECARR(SDRT,SDECLN),U,3))
 I 'SDECQ W !!,?5,"Total Clinics:  ",SDECTOT
 Q
 ;
GETCLNS(SDECARR) ; Get all Scheduling Hospital Location Clinics
 ; Input:  SDECARR = Array passed by ref to return clinics
 ; Output: SDECARR(Report Type,Clinic Name)=Hospital Location IEN^Stop Code^Stop Code Name
 ;
 ;         Report Type are (P=Primary Care, S=Specialty Care, M=Mental Health)
 ;
 N HLOC,HLOCIEN,SDECQ,SDECSTP,SDECCNT
 S SDECCNT=0 K SDECARR
 ; Build Location Array
 S HLOC="" F  S HLOC=$O(^SC("B",HLOC)) Q:HLOC=""  D
 . S HLOCIEN=$O(^SC("B",HLOC,0))
 . I '$D(^SC(HLOCIEN,0)) Q
 . S SDECSTP=$$FLTCL(HLOCIEN) Q:'+SDECSTP
 . S SDECCNT=SDECCNT+1,SDECTOT=SDECCNT
 . S SDECARR($P(SDECSTP,U,2),HLOC)=HLOCIEN_U_$P(SDECSTP,U,3)_U_$P(SDECSTP,U,4)
 . Q
 Q
 ;
ADD(SDECPARM) ;
 N DIR,DIRUT,DTOUT,DUOUT,DIROUT,X,LIST,ERR,DIRUT,Y,SDECSTP,SDECNAME,SDECAT,SDQ
 S (SDQ,ERR)=0
 I $G(SDECPARM)="" D  Q:SDQ
 . N Y,X S DIR(0)="S^P:Primary Care;S:Specialty Care;M:Mental Health"
 . S DIR("A")="CS Management Resource Report Type"
 . D ^DIR I ($D(DIRUT))!($D(DTOUT))!($D(DUOUT))!($D(DIROUT)) S SDQ=1 Q
 . S SDECPARM=$S(Y="P":"SDEC PRIMARY CARE STOP CODES",Y="S":"SDEC SPECIALTY CARE STOP CODES",1:"SDEC MENTAL HEALTH STOP CODES")
 S SDECAT=$S(SDECPARM["PRIMARY":"Primary Care",SDECPARM["SPECIALTY":"Specialty Care",1:"Mental Health")
 D GETLST^XPAR(.LIST,"PKG.SCHEDULING",SDECPARM,"B")
 ;
 W !
 N Y,X S DIR(0)="P^40.7:EMZ",DIR("A")="Select "_SDECAT_" Clinic Stop Code",DIR("S")="I '$P(^(0),U,3)" D ^DIR
 Q:($D(DIRUT))!($D(DTOUT))!($D(DUOUT))!($D(DIROUT))
 Q:'+Y
 S SDECSTP=+Y,SDECNAME=$P(Y,U,2)
 S X="" F  S X=$O(LIST(X)) Q:X=""  I $P(LIST(X,"N"),U)=SDECSTP D  G EXIT
 . W !!,SDECNAME_" is an existing "_SDECAT_" Clinic Stop Code."
 . N DIR S DIR(0)="Y",DIR("B")="NO"
 . S DIR("A")="Remove "_SDECAT_" Clinic Stop Code "_SDECNAME
 . D ^DIR I $D(DIRUT)!($D(DTOUT))!($D(DUOUT))!($D(DIROUT)) G EXIT
 . I +Y D
 . . N ERR D EN^XPAR("PKG.SCHEDULING",SDECPARM,"`"_SDECSTP,"@",.ERR)
 . . I 'ERR W !!,SDECNAME_" removed from "_SDECAT_" Clinic Stop Code parameter list."
 N DIR S DIR(0)="Y",DIR("B")="NO",DIR("A")="Add "_SDECNAME_" as a new "_SDECAT_" Clinic Stop Code"
 D ^DIR I $D(DIRUT)!($D(DTOUT))!($D(DUOUT))!($D(DIROUT)) G EXIT
 I +Y D EN^XPAR("PKG.SCHEDULING",SDECPARM,"`"_SDECSTP,1,.ERR)
 I 'ERR,Y W !!,SDECNAME_" added to "_SDECAT_" Clinic Stop Code parameter list." Q
 W !!,"There was an error editing this Stop Code"
 W !,"Error Code-Description: "_ERR
 ;
 Q
 ;
HDR(SDECPAGE,LST,SDECNOW) ; Write the header
 ; Define SDECDATA - Tells whether data has been displayed for a screen
 S SDECDATA=0
 S SDECPAGE=$G(SDECPAGE)+1
 W @IOF
 ;
 W !,"Print Date: "_$G(SDECNOW),$$RJ("Page: "_SDECPAGE,40)
 ;
 D ULINE("-") Q:$G(SDECQ)
 I SDECDESC Q
 I LST=1 D HDLN1
 I LST=2 D HDLN2
 D ULINE("-")
 Q
 ;
HDLN1 ;
 W !,?1,"Category",?20,"Clinic Stop Code"
 Q
 ;
HDLN2 ;
 W !,"Clinic Service/Location",?33,"Category",?43,"Clinic Stop Code"
 Q
 ;
CHKP(SDECLNS,LST,SDECNOW) ; Check for End of Page
 ; Input variables -> SDECLNS -> Number of lines from bottom
 ;                    
 ; Output variable -> SDECDATA  -> 0 -> New screen, no data displayed yet
 ;                                 1 -> Data displayed on current screen
 S SDECLNS=SDECLNS+1
 I $G(SDECSCR) S SDECLNS=SDECLNS+2
 I $G(SDECSCR),'$G(SDECDATA) S SDECDATA=1 Q 0
 S SDECDATA=1
 I $Y>(IOSL-SDECLNS) D:$G(SDECSCR) PAUSE Q:$G(SDECQ) 0 D HDR(.SDECPAGE,LST,SDECNOW) Q 1
 Q 0
 ;
WRDESC(LINE) ; Write the description line
 W !,LINE
 Q
 ;
WRLN1(CLSTP,CLSCAT) ; Write the SDEC Stop Codes
 W !,?1,CLSCAT,?20,CLSTP
 Q
 ;
WRLN2(HLOC,CAT,CLSTP) ; Write the Clinic Location, Category and Stop Code
 W !,HLOC,?33,CAT,?43,CLSTP
 Q
 ;
ULINE(X) ;Print one line of characters
 N I
 W ! F I=1:1:80 W $G(X,"-")
 Q
 ;
 ;right justified, blank padded
 ;adds spaces on left or truncates to make return string SDECLEN characters long
 ;SDECST- original string
 ;SDECLEN - desired length
RJ(SDECST,SDECLEN)  ;
 N SDECL
 S SDECL=SDECLEN-$L(SDECST)
 I SDECL>0 Q $J("",$S(SDECL<0:0,1:SDECL))_SDECST
 Q $E(SDECST,1,SDECLEN)
 ;
  ;Screen Pause 1
 ;
 ; Return variable - SDECQ = 0 Continue
 ;                          2 Quit
PAUSE N X
 U IO(0) W !!,"Press RETURN to continue, '^' to exit:"
 R X:$G(DTIME) S:'$T X="^" S:X["^" SDECQ=2
 U IO
 Q
 ;
 ;Screen Pause 2
 ;
 ; Return variable - SDECQ = 0 Continue
 ;                         2 Quit
PAUSE2 N X
 U IO(0) W !!,"Press RETURN to continue:"
 R X:$G(DTIME) S:'$T X="^" S:X["^" SDECQ=2
 U IO
 Q
 ;
 ;Prompt For the Device
 ;
 ; Returns Device variables and FBSCR
 ;
DEVICE ;
 N %ZIS,ZTSK,ZTRTN,ZTIO,ZTDESC,ZTSAVE,POP
 S %ZIS="QM"
 D ^%ZIS
 I POP S SDECQ=1
 ;
 ;Check for exit
 I $G(SDECQ) G EXIT
 ;
 S SDECSCR=$S($E($G(IOST),1,2)="C-":1,1:0)
 I $D(IO("Q")) D  S SDECQ=1
 . S ZTRTN="LST^SDECSTP"
 . S ZTIO=ION
 . S ZTSAVE("*")=""
 . S ZTDESC="SDEC Hospital Locations"
 . D ^%ZTLOAD
 . W !,$S($D(ZTSK):"REQUEST QUEUED TASK="_ZTSK,1:"REQUEST CANCELLED")
 . D HOME^%ZIS
 U IO
 ;
EXIT ;
 I $D(ZTQUEUED) S ZTREQ="@"
 Q
 ;
FLTCL(LOC) ; Filter the Clinic Hospital Locations
 ; Input     = Hospital Location file #44 IEN
 ; Returns 0 = Invalid SQWM Clinic Stop
 ;         1^STOP CODE NAME^Clinic Name
 I LOC="" Q 0
 N OK,IDATE,RDATE S OK=1
 ; If LOC does not exist, check location name
 I '$D(^SC(LOC,0)) S LOC=$O(^SC("B",LOC,0)) I '$D(^SC(LOC,0)) Q 0
 ; Has clinic been Inactivated?
 S IDATE=$P($G(^SC(LOC,"I")),U),RDATE=$P($G(^SC(LOC,"I")),U,2)
 ; Is clinic Inactive?
 I IDATE S OK=0 D
 . ; Has clinic been Reactivated?
 . I RDATE>IDATE S OK=1
 . ; Is Reactivate date in the future?
 . I RDATE>DT S OK=0
 Q:'OK 0
 Q $$FLTCLSTP($P($G(^SC(LOC,0)),U,7))_U_$P(^SC(LOC,0),U)
 ;
FLTCLSTP(CLST) ; Filter the CLINIC STOP codes
 ; Filter SCHEDULING STOP CODES Parameters
 ; 
 ; Returns 0 = Invalid Clinic Stop
 ;         1^Parameter Category^STOP CODE^STOP CODE NAME = Valid Clinic Stop
 ;         Parameter Categories are (P=Primary Care, S=Specialty Care, M=Mental Health)
 N OK,X,LIST
 S OK=0
 Q:CLST="" OK
 D GETLST^XPAR(.LIST,"PKG.SCHEDULING","SDEC PRIMARY CARE STOP CODES","B")
 I +$G(LIST) S X="" F  S X=$O(LIST(X)) Q:('X)!(+OK)  I +LIST(X,"N")=CLST S OK=1_"^P^"_$P(^DIC(40.7,CLST,0),U,2)_U_$P(LIST(X,"N"),U,2)
 Q:OK OK
 N LIST,X
  D GETLST^XPAR(.LIST,"PKG.SCHEDULING","SDEC SPECIALTY CARE STOP CODES","B")
 I +$G(LIST) S X="" F  S X=$O(LIST(X)) Q:('X)!(+OK)  I +LIST(X,"N")=CLST S OK=1_"^S^"_$P(^DIC(40.7,CLST,0),U,2)_U_$P(LIST(X,"N"),U,2)
 Q:OK OK
 N LIST,X
 D GETLST^XPAR(.LIST,"PKG.SCHEDULING","SDEC MENTAL HEALTH STOP CODES","B")
 I +$G(LIST) S X="" F  S X=$O(LIST(X)) Q:('X)!(+OK)  I +LIST(X,"N")=CLST S OK=1_"^M^"_$P(^DIC(40.7,CLST,0),U,2)_U_$P(LIST(X,"N"),U,2)
 Q OK
 ;
