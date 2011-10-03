SDAMN ;ALB/MJK - No-Show Appt Action ; 2/4/92
 ;;5.3;Scheduling;**478**;Aug 13, 1993
 ;
EN ; -- protocol SDAM APPT NO-SHOW entry pt
 ; input:  VALMY := array entries
 ;
 N VALMY,SDI,SDAT,SDTIME,SDNSACT,DFN,SDCL,SDT,SDSTB,SDSTA,SDSTOP
 S VALMBCK="",(SDNSACT,SDSTOP)=0
 D SEL^VALM2 G ENQ:'$O(VALMY(0))
 D FULL^VALM1 S VALMBCK="R",SDI=0
 F  S SDI=$O(VALMY(SDI)) Q:'SDI  I $D(^TMP("SDAMIDX",$J,SDI)) K SDAT S SDAT=^(SDI) D  Q:SDSTOP
 .D NOW^%DTC S SDTIME=%
 .W !,^TMP("SDAM",$J,+SDAT,0),!
 .S DFN=+$P(SDAT,U,2),SDT=+$P(SDAT,U,3),SDCL=+$P(SDAT,U,4)
 .S SDSTB=$$STATUS^SDAM1(DFN,SDT,SDCL,$G(^DPT(DFN,"S",SDT,0))) ; before status
 .Q:'$$CHK
 .S SDSTOP=$$NS(DFN,SDT,SDCL,SDTIME,.SDNSACT)
 .S SDSTA=$$STATUS^SDAM1(DFN,SDT,SDCL,$G(^DPT(DFN,"S",SDT,0))) ; after status
 .I 'SDNSACT,'$$UPD(SDSTB,SDSTA,SDAT,$G(CNSTLNK)) S SDNSACT=2
 ; values for SDNSACT :   0 = no re-build
 ;                        1 = re-build because of re-book
 ;                        2 = re-build because after not for list
 I SDNSACT,SDAMTYP="P" D BLD^SDAM1
 I SDNSACT,SDAMTYP="C" D BLD^SDAM3
ENQ Q
 ;
NS(DFN,SDT,SC,SDTIME,SDNSACT) ; execute no-show code
 ; input:   DFN := pt file ifn
 ;          SDT := d/t of appt
 ;           SC := clinic ifn
 ;       SDTIME := now
 ;      SDNSACT := ns processing flag
 ;     [return] := did user uparrow [ 0|no , 1|yes]
 ;
 N SDI,SDCP,SDYES,SDINP,SDLT1,SDLT,SDDT,SDMSG,A,L,I,SDV1,SDCL
 K ^UTILITY($J)
 D LO^DGUTL S SDLT1="",SDYES="",SDDT=DT,I=SDT,SDT=$P(I,".")
 S SDMSG=" DOES NOT HAVE A NO-SHOW LETTER ASSIGNED TO IT!"
 S SDV1=$O(^DG(40.8,0)) D DIV^SDUTL I $T S SDV1=$P($G(^SC(SC,0)),U,15)
 D EN1^SDN,73^SDN,PAUSE^VALM1
NSQ Q 'Y
 ;
CHK() ; -- check if status of appt permits no-show
 N SDOK S SDOK=1
 I '$D(^SD(409.63,"ANS",1,+SDSTB)) S SDOK=0,X="You cannot execute no-show processing for this appointment."
 I SDOK,SDT>SDTIME S SDOK=1,X="It is too soon to no-show this appointment."
 I 'SDOK W !!,*7,X K VALMY(SDI) D PAUSE^VALM1
 Q SDOK
 ;
UPD(BEFORE,AFTER,SDAT,CNST) ; can just the 1 display line be changed w/o re-build
 ; input:   BEFORE := before status info in $$STATUS format
 ;           AFTER := after     "     "   "     "      "
 ;            SDAT := selected VALMY entry's data
 ;            CNST := consult status (null, consult link ien)
 N Y S Y=0
 I +BEFORE=+AFTER S Y=1 G UPDQ
 I $D(SDAMLIST(+AFTER)) S Y=1 I $D(SDAMLIST("SCR")) X SDAMLIST("SCR") S Y=$T
 I 'Y,$P(SDAMLIST,U)="ALL" S Y=1
 I Y D
 . S ^TMP("SDAM",$J,+SDAT,0)=$$SETFLD^VALM1($P(AFTER,";",3),^TMP("SDAM",$J,+SDAT,0),"STAT")
 . I '$G(CNST) S ^TMP("SDAM",$J,+SDAT,0)=$$SETFLD^VALM1("    ",^TMP("SDAM",$J,+SDAT,0),"CONSULT")
UPDQ Q Y
