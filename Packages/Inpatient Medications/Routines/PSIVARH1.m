PSIVARH1 ;AAC/JLS - DISPLAY RECENTLY DC'D IV ORDERS ; 10/18/15 / 9:27 AM
 ;;5.0;INPATIENT MEDICATIONS;**325**;;Build 37
 ;
 ;called from DECODE^PSIVARH
 ;
DECODE ;decode backdoor hl7 PSIVMSG
       N PSIVA,PSIVB
       K PSIVFLD
       S PSIVA=0 F  S PSIVA=$O(PSIVMSG(PSIVA)) Q:'PSIVA  D
       .F PSIVB=0:1:$L(PSIVMSG(PSIVA),"|") S PSIVFLD(PSIVB)=$P(PSIVMSG(PSIVA),"|",PSIVB+1)
       .I PSIVFLD(0)="" Q
       .I $T(@PSIVFLD(0))]"" D @PSIVFLD(0)
       Q
MSH    ;
       S PSIVPKG=PSIVFLD(2) ;sending appl
       S PSIVPKG(2)=PSIVFLD(4)
       Q
PID    ;
       S DFN=PSIVFLD(3) ;dfn
       Q
PV1    ;
       S PSIVLOC=$G(PSIVFLD(3)) ;location
       Q
ORC    ;
       S PSIVSTS=$G(PSIVFLD(1)) ;order control/status
       S PSIVIFNF=$G(PSIVFLD(2)) ;placer order ien
       S PSIVIFNP=$G(PSIVFLD(3)) ;filler order ien
       S PSIVDUZ=$G(PSIVFLD(12)) ;requestor
       S PSIVRDUZ=$G(PSIVFLD(10)) ;releaser
       S PSIVEDT=$G(PSIVFLD(15)) ;effective dt
       S:+PSIVEDT PSIVEDT=$$FMDATE^HLFNC(PSIVEDT)
       S PSIVRDT=$G(PSIVFLD(9)) ;release dt
       S:+PSIVRDT PSIVRDT=$$FMDATE^HLFNC(PSIVRDT)
       Q
GETHRS(PSIVSN) ; function returns a date time in the past which is derived from
       ; the IV ROOM (59.5) file.  This file contains parameters for the
       ; IV room(s).  The parameter used is the DC'D IV ORDERS HOURS 
       ; FILTER (#21) field.  The function subtracts the value in the
       ; parameter file from NOW to get a date time in the past such that
       ; orders older than the returned date can be ignored.
       ;
       ; Return format:
       ; Internal date@time ^ External date@time ^ DC'D IV ORDERS HOURS FILTER
       ;
       N IDT,XDT,%  ;INTERNAL DATE/TIME, EXTERNAL DATE/TIME
       N IVRFILT    ;DC'D IV ORDERS HOURS FILTER
       ;
       ; PSIVSN = IV ROOM internal entry number returned by earlier call
       ; to MULT^PSIVSET
       ;
       I $G(PSIVSN) S IVRFILT=$P($G(^PS(59.5,PSIVSN,6)),U)
       S:$G(IVRFILT)="" IVRFILT=0
       D NOW^%DTC
       S IDT=$$FMADD^XLFDT(%,,-(IVRFILT),,-1)
       S XDT=$$FMTE^XLFDT(IDT,"1P")
       Q IDT_U_XDT_U_IVRFILT
       ;
       ;=====================================================================
ACTION() ;
       W !!
       N DIR,DUOUT,DTOUT,DIROUT,DIRUT,X,Y,ACTION
       S PSIVQT=0
       S DIR(0)="SB^P:Print;R:Refresh;D:Delete;I:Ignore",DIR("A")="(P)rint, (R)efresh, (D)elete, or (I)gnore?"
       S DIR("B")="I"
       S DIR("?",1)=" The records you are viewing are temporary and are stored"
       S DIR("?",2)=" in the IV MEDICATION ORDERS DC'D (#52.75) file.  These "
       S DIR("?",3)=" records are intended to help identify discontinued IV orders"
       S DIR("?",4)=" for a particular ward or a ward group."
       S DIR("?",5)=" (P)rint action allows the viewed orders to be printed to a device and"
       S DIR("?",6)="   optionally those records can be deleted, once printed."
       S DIR("?",7)=" (R)efresh action, simply re-displays the records."
       S DIR("?",8)=" (D)elete action removes the currently viewed records from the file so"
       S DIR("?",9)="   they will no longer be displayed."
       S DIR("?",10)=" (I)gnore action will continue with the usual next prompt and take no"
       S DIR("?",11)="   action on the records."
       S DIR("?")=" Enter an action (P),(R),(D) or (I) for the records you have just viewed."
       D ^DIR S ACTION=Y
       ;
       Q ACTION
       ;
ISDATAG(WG) ;
       ; FUNCTION (BOOLEAN) RETURNS TRUE IF THERE ARE RECORDS THAT FIT FILTER (GROUP)
       ; check for data in any of the wards that are part of the group
       ;
       N VDA,VWDI,FOUND,WRDIEN,WARD
       S FOUND=0
       ;
       S VWDI=0
       F  S VWDI=$O(^PS(57.5,WG,1,"B",VWDI)) Q:'VWDI!FOUND  D
       .  S WRDIEN=+$G(^DIC(42,VWDI,44))
       .  I $G(WRDIEN)>0 S FOUND=$$ISDATAW(WRDIEN)
       Q FOUND
       ;
ISDATAW(WRDIEN) ;
       ;FUNCTION (BOOLEAN) RETURNS TRUE IF THERE ARE RECORDS THAT FIT FILTER (WARD)
       ;
       N IEN,FOUND,THISHR
       S FOUND=0
       S THISHR=$P(HRSFILT,U,1)
       F  S THISHR=$O(^PS(52.75,"AW",WRDIEN,THISHR)) Q:'THISHR!FOUND  D
       .  S IEN=""
       .  S FOUND=+$O(^PS(52.75,"AW",WRDIEN,THISHR,IEN))
       Q FOUND
       ;
NODCD(PLACE,WHEN)  ;
       ;DISPLAY A MESSAGE IF THERE ARE NO D/C'D ORDERS OR NONE THAT ARE WITHIN THE FILTER PERIOD
       W !!?2,"No edited or discontinued IV orders are in the"
       W !?2,"temporary tracking file (#52.75) for ",PLACE
       W !?2,"from the past ",WHEN," hour(s).",!!
       Q
YOURSURE() ; ask user if they are sure about deleting
       N DIR,DUOUT,DTOUT,DIROUT,DIRUT,X,Y
       S DIR("B")="Y"
       S DIR(0)="Y",DIR("A")="Are you sure you want to remove the records you have just viewed"
       S DIR("?")="Answer yes to remove the discontinued orders tracking entries."
       S DIR("?",1)="The records you have viewed are from a temporary tracking file"
       S DIR("?",2)="and they can be deleted without any impact to the orders file."
       D ^DIR
       I $D(DIRUT) Q -1
       Q Y
TMPCLEAN(NODE) ;
       ;
       K ^TMP(NODE,$J)
       Q
SURE() ;
       ;
       N DIR,DUOUT,DTOUT,DIROUT,DIRUT,X,Y,DA
       W !!," Entering a zero or deleting this parameter will turn"
       W !," off the Discontinued IV Report when processing orders"
       W !," under this IV room. By entering a zero, any existing"
       W !," entries will be removed under this IV room.",!
       S DIR("B")="N"
       S DIR(0)="Y",DIR("A")="Turn off Discontinued IV Report"
       S DIR("?",1)="Answer Yes to Turn off the Discontinued IV report that is"
       S DIR("?")="run within the option Non-Verified/Pending Orders [PSJU VBW]."
       D ^DIR
       I $D(DIRUT) Q -1
       Q Y
       ;
CLEAN ;
    ;THIS CODE IS EXECUTED FROM AC CROSS REFERENCE ON FIELD 21 IN #52.75
    ;REMOVE ENTRIES FOR THIS IV ROOM IF OPTION BEING TURNED OFF
    ;DA IS CURRENT IV ROOM (*)
    ;X IS NEW VALUE FOR FIELD 21; Y IS PREVIOUS VALUE FOR 21
 N DIK,OIEN,PHPTI,ORDERN,PHPZN,IVR,IVRDA,DELCOUNT
    S DIK="^PS(52.75,"
    S DELCOUNT=0
    S IVRDA=+DA
    N DA
    S OIEN=0
    F  S OIEN=$O(^PS(52.75,OIEN)) Q:OIEN'>0  D
    . S PHPZN=$G(^PS(52.75,OIEN,0))
    . S PHPTI=$P(PHPZN,U,2)
    . S ORDERN=+$P(PHPZN,U,8)
    . S IVR=$$IVROOM^PSIVARH(PHPTI,ORDERN)
    . Q:'(+IVR=IVRDA)
    . S DA=OIEN D ^DIK
    . S DELCOUNT=DELCOUNT+1
    I DELCOUNT>0 W !,DELCOUNT," records deleted."
    E  W !,"There were no records to delete."
    Q
 ;
