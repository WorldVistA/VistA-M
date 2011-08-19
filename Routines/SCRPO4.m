SCRPO4 ;BP-CIOFO/KEITH - Historical Provider Position Assignment Listing (cont.) ; 9/3/99 12:52pm
 ;;5.3;Scheduling;**177**;AUG 13, 1993
 ;
BPRPA(SCPASS,SCDIV,SCTEAM,SCPOS,SCLINIC,SCFMT) ;Evaluate provider position assignment information
 ;Input: SCPASS=provider position assignment information
 ;              string from $$PRTP^SCAPMC
 ;Input: SCDIV=division^ifn 
 ;Input: SCTEAM=team^ifn 
 ;Input: SCPOS=team position^ifn 
 ;Input: SCLINIC=associated clinic^ifn (if one exists)
 ;Input: SCFMT=report format (detail or summary)
 ;
 ;evaluate assignment/gather data
 N SCI,SCTP0,SCPC,SCMAX,SCACT,SCINAC,SCARR,ERR,SCPTD,SCPTPA0,SCX
 N DFN,SCPCA,SCNPCA,SCOSL,SCPPC,SCPNPC,SCPPOSD,SCPACT,SCPINAC,SCDT2
 N SCPPTD,SCPPTPA0,SCPROV,SCPTP0,SCY
 Q:+SCPASS'>0  ;invalid provider ifn
 ;not a selected provider
 I $O(^TMP("SC",$J,"ASPR",0)),'$D(^TMP("SC",$J,"ASPR",+SCPASS)) Q
 S SCPROV=$P(SCPASS,U,2)_U_$P(SCPASS,U)  ;provider name^ifn
 S SCTP0=$G(^SCTM(404.57,+$P(SCPASS,U,3),0)) Q:'$L(SCTP0)
 S SCPC=$S($P(SCTP0,U,4)=1:"YES",1:"NO") Q:'$$SPCAT(SCPC)  ;pc? y/n
 S SCMAX=+$P(SCTP0,U,8)  ;maximum patients
 ;adjust dates if necessary
 S SCACT=$P(SCPASS,U,9),SCINAC=$P(SCPASS,U,10)
 M SCDT=^TMP("SC",$J,"DTR") S SCDT="SCDT"
 I SCACT>SCDT("BEGIN") S SCDT("BEGIN")=SCACT
 I SCINAC,SCINAC<SCDT("END") S SCDT("END")=SCINAC
 S SCARR="^TMP(""SCARR"",$J,2)" K @SCARR,^TMP("SCARR",$J,3)
 S SCI=$$PTTP^SCAPMC($P(SCPOS,U,2),.SCDT,SCARR,"ERR")
 ;count patients assigned to the provider
 S SCI=0 F  S SCI=$O(^TMP("SCARR",$J,2,SCI)) Q:'SCI  D
 .S SCPTD=^TMP("SCARR",$J,2,SCI),DFN=+SCPTD Q:DFN'>0
 .S SCPTPA0=$G(^SCPT(404.43,+$P(SCPTD,U,3),0)) Q:'$L(SCPTPA0)
 .S SCX=$S($P(SCPTPA0,U,5)>0:"PC",1:"NPC")
 .S ^TMP("SCARR",$J,3,SCX,DFN)=""
 .Q
 S (SCPCA,DFN)=0 F  S DFN=$O(^TMP("SCARR",$J,3,"PC",DFN)) Q:'DFN  D
 .S SCPCA=SCPCA+1
 .Q
 S (SCNPCA,DFN)=0 F  S DFN=$O(^TMP("SCARR",$J,3,"NPC",DFN)) Q:'DFN  D
 .S SCNPCA=SCNPCA+1
 .Q
 ;jlu added 4 to clean up array 9/8/99
 F SCI=2,3,4 K ^TMP("SCARR",$J,SCI)
 S SCOSL=SCMAX-SCPCA-SCNPCA S:SCOSL<0 SCOSL=0  ;open slots
 ;count precepted patients
 S (SCPPC,SCPNPC)=0,SCI=$$PRECHIS^SCMCLK($P(SCPOS,U,2),.SCDT,SCARR)
 N SCPPOS S SCI=0 F  S SCI=$O(^TMP("SCARR",$J,2,SCI)) Q:'SCI  D
 .S SCPPOSD=^TMP("SCARR",$J,2,SCI),SCPPOS=$P(SCPPOSD,U,3) Q:'SCPPOS
 .S SCPACT=$P(SCPPOSD,U,14),SCPINAC=$P(SCPPOSD,U,15)
 .Q:'SCPACT  S:SCPINAC<1 SCPINAC=9999999
 .S SCPPOS(SCPPOS,SCPACT,SCPINAC)=""
 .Q
 S SCPPOS=0 F  S SCPPOS=$O(SCPPOS(SCPPOS)) Q:'SCPPOS  D
 .S SCPACT=0 F  S SCPACT=$O(SCPPOS(SCPPOS,SCPACT)) Q:'SCPACT  D
 ..S SCPINAC=0 F  S SCPINAC=$O(SCPPOS(SCPPOS,SCPACT,SCPINAC)) Q:'SCPINAC  D
 ..;adjust dates again
 ..M SCDT2=SCDT S SCDT2="SCDT2"
 ..I SCPACT>SCDT2("BEGIN") S SCDT2("BEGIN")=SCPACT
 ..I SCPINAC<SCDT2("END") S SCDT2("END")=SCINAC
 ..N SCARR S SCARR="^TMP(""SCARR"",$J,3)" K @SCARR,^TMP("SCARR",$J,4)
 ..;get patients assigned to precepted position
 ..S SCI=$$PTTP^SCAPMC(SCPPOS,.SCDT2,SCARR,"ERR")
 ..S SCI=0 F  S SCI=$O(^TMP("SCARR",$J,3,SCI)) Q:'SCI  D
 ...S SCPPTD=^TMP("SCARR",$J,3,SCI) Q:'+SCPPTD
 ...S SCPPTPA0=$G(^SCPT(404.43,+$P(SCPPTD,U,3),0)) Q:'$L(SCPPTPA0)
 ...S SCX=$S($P(SCPPTPA0,U,5)>0:"PC",1:"NPC")
 ...S ^TMP("SCARR",$J,4,SCX,+SCPPTD)=""
 ...Q
 ..Q
 .Q
 ;bp/djb Positions that have been precepted should show zero in
 ;       the Precepted Patients column.
 ;Old code begin
 ;S (SCPPC,DFN)=0 F  S DFN=$O(^TMP("SCARR",$J,4,"PC",DFN)) Q:'DFN  D
 ;.S SCPPC=SCPPC+1
 ;.Q
 ;S (SCPNPC,DFN)=0 F  S DFN=$O(^TMP("SCARR",$J,4,"NPC",DFN)) Q:'DFN  D
 ;.S SCPNPC=SCPNPC+1
 ;.Q
 ;Old code end
 ;New code begin
 S (SCPPC,SCPNPC)=0 ;Initialize to zero.
 ;Only count DFNs if position hasn't been precepted.
 I '$D(^SCTM(404.53,"B",$P(SCPOS,"^",2))) D  ;
 . S DFN=0
 . F  S DFN=$O(^TMP("SCARR",$J,4,"PC",DFN)) Q:'DFN  S SCPPC=SCPPC+1
 . S DFN=0
 . F  S DFN=$O(^TMP("SCARR",$J,4,"NPC",DFN)) Q:'DFN  S SCPNPC=SCPNPC+1
 ;New code end
 ;
 ;set data string
 S SCX=$E($P(SCPROV,U),1,19)_U_$E($P(SCPOS,U),1,18)_U_SCPC
 S SCX=SCX_U_$E($P(SCTEAM,U),1,19)_U_$E($P(SCLINIC,U),1,17)
 S SCX=SCX_U_SCMAX_U_SCPCA_U_SCNPCA_U_SCOSL_U_SCPPC_U_SCPNPC
 ;Set sort values
 I SCFMT="D" F SCI=1:1:5 S SCS=$P($G(^TMP("SC",$J,"SORT",SCI)),U,3) D
 .I $L(SCS) S SCY=@SCS S:'$L(SCY) SCY="~~~"
 .S:'$L(SCS) SCY="~~~" S SCS(SCI)=SCY
 .Q
 ;Set report detail global
 I SCFMT="D" D LSET(.SCS,SCX)
 ;
 ;Set report summary global
 I SCPC="YES" S ^TMP("SCRPT",$J,0,0,"PC")="",^TMP("SCRPT",$J,0,SCDIV,"PC")="",^TMP("SCRPT",$J,0,SCDIV,1,SCTEAM,"PC")=""
 S SCX=$P(SCX,U,6,11) F SCI=1:1:6 D
 .S $P(^TMP("SCRPT",$J,0,0),U,SCI)=$P($G(^TMP("SCRPT",$J,0,0)),U,SCI)+$P(SCX,U,SCI)
 .S $P(^TMP("SCRPT",$J,0,SCDIV),U,SCI)=$P($G(^TMP("SCRPT",$J,0,SCDIV)),U,SCI)+$P(SCX,U,SCI)
 .S $P(^TMP("SCRPT",$J,0,SCDIV,1,SCTEAM),U,SCI)=$P($G(^TMP("SCRPT",$J,0,SCDIV,1,SCTEAM)),U,SCI)+$P(SCX,U,SCI)
 Q
 ;
LSET(SCS,SCX) ;Set report line
 ;Input: SCS=array of sort values
 ;Input: SCX=data strin
 N SCI,SCN,SCL
 S SCN=$G(^TMP("SCRPT",$J,1,SCS(1),SCS(2),SCS(3))) I 'SCN D
 .S ^TMP("SCRPT",$J,1)=$G(^TMP("SCRPT",$J,1))+1
 .S SCN=^TMP("SCRPT",$J,1)
 .S ^TMP("SCRPT",$J,1,SCS(1),SCS(2),SCS(3))=SCN
 .Q
 S ^TMP("SCRPT",$J,2)=$G(^TMP("SCRPT",$J,2))+1
 S SCL=^TMP("SCRPT",$J,2)
 S ^TMP("SCRPT",$J,2,SCN,SCS(4),SCS(5),SCL)=SCX
 Q
 ;
SPCAT(SCPC) ;selected pc assignment type?
 ;Input: SCPC= possible primary care? YES/NO
 Q:$E(^TMP("SC",$J,"ATYPE"))="B" 1
 I $E(SCPC)="N" Q $E(^TMP("SC",$J,"ATYPE"))="N"
 I $E(SCPC)="Y" Q $E(^TMP("SC",$J,"ATYPE"))="P"
 Q 0
