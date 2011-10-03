ECMLMP ;ALB/ESD - Multiple procedure dates and procedures ;22 AUG 1997 11:11
 ;;2.0; EVENT CAPTURE ;**5,18,47**;8 May 96
 ;
EN ;- ListMan entry point
 ;
 D EN^VALM("EC MUL PROCEDURES")
 Q
 ;
HDR ;- Display location, provider #1, DSS Unit, and Category as header
 ;
 S VALMHDR(1)=" Location: "_$G(ECLN)_"  ("_$G(ECL)_")"
 S VALMHDR(1)=$$SETSTR^VALM1("Provider #1: "_$P(ECU(1),"^",2),VALMHDR(1),40,30)
 S VALMHDR(2)=" DSS Unit: "_$P(ECDSSU,"^",2)
 S VALMHDR(2)=$$SETSTR^VALM1("   Category: "_$P(ECCAT,"^",2),VALMHDR(2),40,30)
 ;
 Q
 ;
INIT ;- Initialize variables and call BLD which does processing
 ;
 N BL,ECPCNT,IC,IW,DC,DW,NC,NW,PC,PW,RC,RW,VC,VW,X,MC,MW
 D CLEAN^VALM10
 K ^TMP("ECM",$J),^TMP("ECMP",$J),^TMP("ECMPIDX",$J)
 ;K XQORNOD,%B
 ;
 S (VALMCNT,ECPCNT)=0
 S BL="",$P(BL," ",30)=""
 S X=VALMDDF("INDEX"),IC=$P(X,"^",2),IW=$P(X,"^",3)
 S X=VALMDDF("PROC DT"),DC=$P(X,"^",2),DW=$P(X,"^",3)
 S X=VALMDDF("PROC NUM"),NC=$P(X,"^",2),NW=$P(X,"^",3)
 S X=VALMDDF("PROCEDURE"),PC=$P(X,"^",2),PW=$P(X,"^",3)
 S X=VALMDDF("VOL"),VC=$P(X,"^",2),VW=$P(X,"^",3)
 S X=VALMDDF("REASON"),RC=$P(X,"^",2),RW=$P(X,"^",3)
 S X=VALMDDF("MODIFIER"),MC=$P(X,"^",2),MW=$P(X,"^",3)
 ;
 D BLD
 S $P(^TMP("ECMP",$J,0),"^",4)=VALMCNT
 Q
 ;
BLD ;- Combine arrays and build lines with data for display
 ;
 D COMBINE
 ;
 N ECPD,ECNT,ECX
 S ECPD=0 F  S ECPD=$O(^TMP("ECM",$J,ECPD)) Q:'ECPD  D
 . S ECNT=0 F  S ECNT=$O(^TMP("ECM",$J,ECPD,ECNT)) Q:'ECNT  D BLDLM
 ;
 Q
 ;
BLDLM ;- Build each line for display and create ^TMP("ECMPIDX",$J) array
 ;
 N ECPR,ECCPT K ECX
 S ECPCNT=ECPCNT+1,ECX="",$P(ECX," ",VALMWD+1)=""
 S ECX=$E(ECX,1,IC-1)_$E(ECPCNT_BL,1,IW)_$E(ECX,IC+IW+1,VALMWD)
 S ECX=$E(ECX,1,DC-1)_$E($$FTIME^VALM1(ECPD)_BL,1,DW)_$E(ECX,DC+DW+1,VALMWD)
 S ECX=$E(ECX,1,NC-1)_$E($P($P(^TMP("ECM",$J,ECPD,ECNT),"^"),";")_BL,1,NW)_$E(ECX,NC+NW+1,VALMWD)
 S ECCPT=$P(^TMP("ECM",$J,ECPD,ECNT),"^")
 S ECCPT=$S(ECCPT["ICPT":+ECCPT,1:$P($G(^EC(725,+ECCPT,0)),"^",5))
 I ECCPT'="" S ECCPT=$P($$CPT^ICPTCOD(ECCPT,ECPD),U,2)
 S ECPR=$S(ECCPT'="":ECCPT_" ",1:ECCPT)_$P(^TMP("ECM",$J,ECPD,ECNT),"^",2)
 S ECX=$E(ECX,1,PC-1)_$E($E(ECPR,1,30)_BL,1,PW)_$E(ECX,PC+PW+1,VALMWD)
 S ECX=$E(ECX,1,VC-1)_$E($P(^TMP("ECM",$J,ECPD,ECNT),"^",5)_BL,1,VW)_$E(ECX,VC+VW+1,VALMWD)
 ;
 D SET(ECX)
 ;
 S ^TMP("ECMPIDX",$J,ECPCNT)=VALMCNT_"^"_ECPD_"^"_$P(^TMP("ECM",$J,ECPD,ECNT),"^")_"^"_$P(^TMP("ECM",$J,ECPD,ECNT),"^",2)_"^"_$P(^TMP("ECM",$J,ECPD,ECNT),"^",3)_"^"_$P(^TMP("ECM",$J,ECPD,ECNT),"^",4)_"^"_$P(^TMP("ECM",$J,ECPD,ECNT),"^",5)
 ;
 I $D(^TMP("ECM",$J,ECPD,ECNT,"MOD")) D  K MOD
 . S MOD="",ECX=$E(BL,1,26)_"Modifier:"
 . F  S MOD=$O(^TMP("ECM",$J,ECPD,ECNT,"MOD",MOD)) Q:MOD=""  D
 . . S ECX=$E(ECX,1,MC-1)_"  - "_MOD_" "_$E($P(^TMP("ECM",$J,ECPD,ECNT,"MOD",MOD),"^")_BL,1,MW)_$E(ECX,MC+MW+1,VALMWD)
 . . D SET(ECX) K ECX S ECX=BL_"      "
 . M ^TMP("ECMPIDX",$J,ECPCNT,"MOD")=^TMP("ECM",$J,ECPD,ECNT,"MOD")
 ;
 K ECX
 S ECX="                  "
 S ECX=$E(ECX,1,RC-1)_"Procedure Reason: "_$E($P(^TMP("ECM",$J,ECPD,ECNT),"^",4)_BL,1,RW)_$E(ECX,RC+RW+1,VALMWD)
 D SET(ECX)
 K ECX S ECX=BL D SET(ECX)
 Q
 ;
 ;
SET(X) ;- Create display array ^TMP("ECMP",$J)
 ;
 S VALMCNT=VALMCNT+1,^TMP("ECMP",$J,VALMCNT,0)=X
 S ^TMP("ECMP",$J,"IDX",VALMCNT,ECPCNT)=""
 Q
 ;
HLPS ;- Brief help
 ;
 S X="?" D DISP^XQORM1 W !!
 Q
HELP ;- Help for list
 S ECZ=""
 I $D(X),X'["??" D HLPS,PAUSE^VALM1 G HLPQ
 D CLEAR^VALM1
 F I=1:1 S ECZ=$P($T(HELPTXT+I),";",3,99) Q:ECZ="$END"  D PAUSE^VALM1:ECZ="$PAUSE" Q:'Y  W !,$S(ECZ["$PAUSE":"",1:ECZ)
 W !,"Possible actions are the following:"
 D HLPS,PAUSE^VALM1 S VALMBCK="R"
HLPQ K ECZ,Y,I Q
 ;
EXIT ;- Clean up and exit
 ;
 K ^TMP("ECPRDT",$J),^TMP("ECPROC",$J)
 K ^TMP("ECM",$J),^TMP("ECMP",$J)
 K VALMDDF
 D CLEAN^VALM10,CLEAR^VALM1
 Q
 ;
COMBINE ;- Combine proc date array and procedure array
 ;
 N ECNT,ECPDT,ECPR,ECX,ECY
 S (ECNT,ECPDT,ECX,ECY)=0,ECPR=""
 F  S ECX=$O(^TMP("ECPRDT",$J,ECX)) Q:'ECX  D
 . S ECY=0 F  S ECY=$O(^TMP("ECPROC",$J,(ECY))) Q:'ECY  D
 .. S ECPR=$G(^TMP("ECPROC",$J,(ECY)))
 .. S ECNT=ECNT+1,^TMP("ECM",$J,ECX,ECNT)=$P(ECPR,"^")_"^"_$P(ECPR,"^",2)_"^"_$P(ECPR,"^",3)_"^"_$P(ECPR,"^",4)_"^"_$P(ECPR,"^",5)
 .. M ^TMP("ECM",$J,ECX,ECNT,"MOD")=^TMP("ECPROC",$J,ECY,"MOD")
 Q
 ;
 ;
PRDTDEL ;- Entry point for EC MUL DEL PROCDT protocol
 ;
 N ECDATE,ECFND,ECSEL,ECDP,VALMY
 S VALMBCK=""
 D FULL^VALM1
 D EN^VALM2(XQORNOD(0))
 S (ECFND,ECSEL)=0
 F  S ECSEL=$O(VALMY(ECSEL)) Q:'ECSEL  D
 . I $D(^TMP("ECMPIDX",$J,ECSEL)) K ECDAT S ECDAT=^(ECSEL) D
 .. S ECDATE=$P(ECDAT,"^",2)
 .. S ECDP=0 F  S ECDP=$O(^TMP("ECPRDT",$J,ECDP)) Q:'ECDP!(ECFND)  D
 ... I ECDATE=ECDP S ECFND=1 K ^TMP("ECPRDT",$J,ECDP)
 .. I ECFND=0 W !!,*7,">>> This procedure date could not be found. <<<" D PAUSE^VALM1 Q
 I '$D(^TMP("ECPRDT",$J)) K ^TMP("ECPROC",$J)
 I ECFND=1 D INIT^ECMLMP
 S VALMBCK="R"
 K ECDAT
PRDTDLQ Q
 ;
 ;
PRDEL ;- Entry point for EC MUL PROC DEL protocol
 ;
 N ECDP,ECFND,ECSEL,VALMY
 S VALMBCK=""
 D FULL^VALM1
 D EN^VALM2(XQORNOD(0))
 S (ECFND,ECSEL)=0
 F  S ECSEL=$O(VALMY(ECSEL)) Q:'ECSEL  D
 . I $D(^TMP("ECMPIDX",$J,ECSEL)) K ECI S ECI=^(ECSEL) D
 .. S ECDP=0 F  S ECDP=$O(^TMP("ECPROC",$J,ECDP)) Q:'ECDP!(ECFND)  K ECN S ECN=^(ECDP) D
 ... I ($P(ECI,"^",3)=$P(ECN,"^")),($P(ECI,"^",4)=$P(ECN,"^",2)),($P(ECI,"^",5)=$P(ECN,"^",3)),($P(ECI,"^",6)=$P(ECN,"^",4)),($P(ECI,"^",7)=$P(ECN,"^",5)) D
 .... S ECFND=1 K ^TMP("ECPROC",$J,ECDP)
 .. I ECFND=0 W !!,*7,">>> This procedure could not be found. <<<" D PAUSE^VALM1 Q
 I '$D(^TMP("ECPROC",$J)) K ^TMP("ECPRDT",$J)
 I ECFND=1 D INIT^ECMLMP
 S VALMBCK="R"
 K ECI,ECN
PRDELQ Q
 ;
 ;
PRDTADD ;- Entry point for EC MUL ADD PROCDT protocol
 ;
 N ECADD
 S ECADD=0,VALMBCK=""
 D FULL^VALM1
 S ECADD=$$ASKPRDT^ECMUTL(+$P(ECDSSU,"^"),1)
 I 'ECADD W !!,*7,">>> No Procedure Date entered. <<<" D PAUSE^VALM1 G PRDTADQ
 I ECADD=1,'$D(^TMP("ECPROC",$J)) D ASKPRO^ECMUTL(ECL,+$P(ECDSSU,"^"),+$P(ECCAT,"^"),-99)
 I ECADD=1,$D(^TMP("ECPROC",$J)) D INIT^ECMLMP
 ;
PRDTADQ S VALMBCK="R"
 Q
 ;
 ;
PRADD ;- Entry point for EC MUL ADD PROC protocol
 ;
 N ECAP
 S VALMBCK=""
 D FULL^VALM1
 S ECAP="",ECAP=$O(^TMP("ECPROC",$J,ECAP),-1)
 I ECAP>0 D
 . D ASKPRO^ECMUTL(ECL,+$P(ECDSSU,"^"),+$P(ECCAT,"^"),(ECAP+1))
 . D INIT^ECMLMP
 I 'ECAP,('$D(^TMP("ECPRDT",$J))) W !!,*7,">>> At least one procedure date must exist before adding a procedure.",!,"    Please add a procedure date first. <<<" D PAUSE^VALM1
 S VALMBCK="R"
PRADDQ Q
 ;
 ;
HELPTXT ; -- help text
 ;;Enter actions(s) by typing the name(s), or abbreviation(s).
 ;;
 ;;ACTION DEFINITIONS:
 ;;  AD - Add a Procedure Date allows the user to add a procedure date
 ;;        to procedures previously entered
 ;;  DD - Delete a Procedure Date allows the user to delete a procedure
 ;;        date from procedures previously entered
 ;;  PA - Add a Procedure allows the user to add a procedure to all
 ;;        procedure dates previously entered
 ;;  PD - Delete a Procedure allows the user to delete a procedure
 ;;        from all procedure dates previously entered
 ;;  MP - Multiple Patients allows the user to enter the patients
 ;;        for the indicated procedure dates and procedures
 ;;
 ;;  NOTE: After the user has entered procedures and date/times, he or
 ;;        she will need to use the 'MP' Action to add patients for the
 ;;        entered procedures and date/times.
 ;;------------------------------------------------------------------------------
 ;;$PAUSE
 ;;$END
