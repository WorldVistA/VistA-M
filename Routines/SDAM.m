SDAM ;MJK/ALB - Appt Mgt ; 8/30/99 9:09am
 ;;5.3;Scheduling;**149,177,76,242,380**;Aug 13, 1993
 ;
 D HDLKILL^SDAMEVT
EN ; -- main entry point
 N XQORS,VALMEVL D EN^VALM("SDAM APPT MGT")
 Q
 ;
INIT ; -- set up appt man vars
 K I,X,SDBEG,SDEND,SDB,XQORNOD,SDFN,SDCLN,DA,DR,DIE,DNM,DQ,%B,SDRES
 S DIR(0)="43,213",DIR("A")="Select Patient name or Clinic name"
 D ^DIR K DIR I $D(DIRUT) S VALMQUIT="" G INITQ
 S SDY=Y
 I SDY["DPT(" S DFN=+SDY D 2^VADPT I +VADM(6) D  G:SDUP="^" INIT
 . W !!,"WARNING ",VADM(7),!!
 . R "Press Return to Continue or ^ to Quit: ",SDUP:DTIME
 I SDY["DPT(" S SDAMTYP="P",SDFN=+SDY D INIT^SDAM1
 I SDY["SC(" S SDRES=$$CLNCK^SDUTL2(+SDY,1) I 'SDRES D  G INIT
 . W !,?5,"Clinic MUST be corrected before continuing."
 I SDY["SC(" S SDAMTYP="C",SDCLN=+SDY D INIT^SDAM3
INITQ Q
 ;
HDR ; -- screen head
 N X,SDX,SDLNX S SDLNX=2
 ;I SDAMTYP="P" D HDR^SDAM10 S VALM("TM")=5 D
 I SDAMTYP="P" D HDR^SDAM10 D
 .S SDX=$$PCLINE^SDPPTEM(SDFN,DT) Q:'$L(SDX)
 .S VALMHDR(SDLNX)=SDX,SDLNX=3
 .;S VALMHDR(SDLNX)=SDX,SDLNX=3,VALM("TM")=6
 .;Increment Top & Bottom margins to allow for additional line
 .;S VALM("TM")=VALM("TM")+1
 .;S VALM("BM")=VALM("BM")+1
 .Q
 I SDAMTYP="C" D HDR^SDAM3
 S X=$P(SDAMLIST,"^",2)
 S VALMHDR(SDLNX)=X
 S X="* - New GAF Required",VALMHDR(SDLNX)=$$SETSTR^VALM1(X,VALMHDR(SDLNX),34,30)
 S VALMHDR(SDLNX)=$$SETSTR^VALM1($$FDATE^VALM1(SDBEG)_" thru "_$$FDATE^VALM1(SDEND),VALMHDR(SDLNX),59,22)
 Q
 ;
FNL ; -- what to do after action
 K ^TMP("SDAM",$J),^TMP("SDAMIDX",$J),^TMP("VALMIDX",$J)
 K SDAMCNT,SDFLDD,SDACNT,VALMHCNT,SDPRD,SDFN,SDCLN,SDAMLIST,SDT,SDATA,SDBEG,SDEND,DFN,Y,SDAMTYP,SDY,X,SDCL,Y,SDDA,VALMY
 Q
 ;
BLD ; -- entry point to bld list
 ; input:  SDAMLIST := list to build
 D:'$D(SDAMLIST) GROUP("ALL",.SDAMLIST)
 I SDAMTYP="P" D BLD^SDAM1
 I SDAMTYP="C" D BLD^SDAM3
BLDQ Q
 ;
LIST ; -- find and build
 ;  input:        X := status group
 ; output: SDAMLIST := array of status'
 ;
 I X["CANCELLED",$G(SDAMTYP)="C" S VALMBCK="" W !!,*7,"You must be viewing a patient to list cancelled appointments." D PAUSE^VALM1 G LISTQ
 D GROUP(X,.SDAMLIST),BLD
 S VALMBCK="R"
LISTQ Q
 ;
GROUP(GROUP,SDAMLIST) ; -- find list
 S (I,SDAMLIST)="" F  S I=$O(SDAMLIST(I)) Q:I=""  K SDAMLIST(I)
 S GROUP=+$O(^SD(409.62,"B",GROUP,0))
 G GROUPQ:'$D(^SD(409.62,GROUP,0)) S SDAMLIST=^(0)
 S I=$G(^SD(409.62,GROUP,1)) S:I]"" SDAMLIST("SCR")=I
 S I=0 F  S I=$O(^SD(409.63,"C",GROUP,I)) Q:'I  S SDAMLIST(I)=""
GROUPQ Q
 ;
FUT ; -- change date range
 S X1=DT,X2=999 D C^%DTC
 S SDEBG=DT,SDEND=X,X="FUTURE" K VALMHDR
 D LIST
FUTQ Q
 ;
EXIT ; -- exit action for protocol
 I $D(VALMBCK),VALMBCK="R" D REFRESH^VALM S VALMBCK=$P(VALMBCK,"R")_$P(VALMBCK,"R",2)
 Q
 ;
