SDAMEVT2 ;ALB/CAW - Add/Edit Event Driver Utilities ; 10/15/92
 ;;5.3;Scheduling;**132**;Aug 13, 1993
 ;
BEFORE(SDOE,SDHDL) ;
 D CAPTURE("BEFORE",.SDOE,.SDHDL)
 Q
 ;
AFTER(SDOE,SDHDL) ;
 D CAPTURE("AFTER",.SDOE,SDHDL)
 Q
 ;
CAPTURE(SDCAP,SDOE,SDHDL) ;
 N OP
 ; -- set up 'OP'posite variable
 S OP=$S(SDCAP="BEFORE":"AFTER",1:"BEFORE")
 ;
 ; -- next lines are redunant data with OE^SDAMEVT but consistent
 ;    with appt and disp ^TMP strurcture
 S ^TMP("SDEVT",$J,SDHDL,2,"STANDALONE",0,SDCAP)=$G(^SCE(SDOE,0))
 S:'$D(^TMP("SDEVT",$J,SDHDL,2,"STANDALONE",0,OP)) ^(OP)=""
 ;
 D OE^SDAMEVT(.SDCAP,2,SDOE,SDHDL)
 Q
 ;
EVT(SDOE,SDEVT,SDHDL,SDOEP) ;
 D AFTER(SDOE,SDHDL)
 D EVTGO
 Q
 ;
EVTGO ; -- do it!
 N SDATA,SDHDLX
 S SDHDLX="SDHDL"_SDHDL_" SAVE"
 ; for compatibility in IB
 D SWAP("SDAMEVT",SDHDLX)
 S SDATA="0^0^0^0",(SDATA("BEFORE","STATUS"),SDATA("AFTER","STATUS"))=""
 S (^TMP("SDAMEVT",$J,"BEFORE","STATUS"),^TMP("SDAMEVT",$J,"AFTER","STATUS"))=""
 D EVT^SDAMEVT(.SDATA,SDEVT,0,SDHDL),SWAP(SDHDLX,"SDAMEVT")
 Q
 ;
SWAP(FR,TO) ; -- save/restore data for compatibility
 N NODE,SDCAP
 K ^TMP(TO,$J)
 I $D(^TMP(FR,$J)) D  K ^TMP(FR,$J)
 .F SDCAP="BEFORE","AFTER" S NODE="" F  S NODE=$O(^TMP(FR,$J,SDCAP,NODE)) Q:NODE=""  S ^TMP(TO,$J,SDCAP,NODE)=^TMP(FR,$J,SDCAP,NODE)
 Q
 ;
