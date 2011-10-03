PXCEEXP ;ISL/dee - Main routine for the List Manager display for encounter profile of a visit and related v-files ;6/20/96
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**172**;Aug 12, 1996
 ;;
 Q
EN ; -- main entry point for PXCE ENCOUNTER PROFILE
 N PXCEVIEN,PXCEQUIT
 I PXCEVIEW["V" D
 . D GETVIEN^PXCEAE
 E  I PXCEVIEW["A" D
 . S PXCEVIEN=$$SELAPPM^PXCESDAM
 . S:'PXCEVIEN PXCEVIEN=0
 E  Q
EN1 ;
 I $G(PXCEVIEN)'>0 D  G QUIT
 . W !!,"There is no data stored in PCE to display."
 . D WAIT^PXCEHELP
 N PXCEAEVW
 I '$D(PXCEPAT) N PXCEKPAT D
 . S PXCEKPAT=1
 . S PXCEPAT=$P($G(^AUPNVSIT(PXCEVIEN,0)),"^",5)
 . D PATINFO^PXCEPAT(.PXCEPAT)
 S PXCEAEVW="D"
 ; next 3 lines added per PX*1.0*172
 N PXPTSSN,PXREC,PXDUZ S PXDUZ=DUZ,PXPTSSN=$TR($G(PXCEPAT("SSN")),"-")
 D SEC(.PXREC,PXDUZ,PXPTSSN)
 I PXREC W !!,"Security regulations prohibit computer access to your own medical record." H 3 G QUIT
 D EN^VALM("PXCE ENCOUNTER PROFILE")
QUIT ;
 D MAKELIST^PXCENEW,DONE^PXCE
 Q
 ;
SEC(PXREC,PXDUZ,PXPTSSN) ; added per PX*1.0*172
 N PXNPSSN S PXREC=0
 S PXNPSSN=$$GET1^DIQ(200,PXDUZ_",",9,"I","","PXNPERR")
 I PXNPSSN=PXPTSSN S PXREC=1
 Q
 ;
HDR ; -- header code
 K VALMHDR
 N VISIT0
 ;
 ;PATIENT
 S VISIT0=^AUPNVSIT(PXCEVIEN,0)
 S VALMHDR(1)=$E(PXCEPAT("NAME"),1,26)
 S VALMHDR(1)=$E(VALMHDR(1)_$E("    ",1,(27-$L(VALMHDR(1))))_PXCEPAT("SSN")_"                                           ",1,40)
 S VALMHDR(1)=VALMHDR(1)_"Clinic:  "_$S($P(VISIT0,"^",22)>0:$P(^SC($P(VISIT0,"^",22),0),"^"),1:"")
 ;
 ;DATE
 S VALMHDR(2)=$E("Encounter Date  "_$S($P(VISIT0,"^",1)>0:$$DATE^PXCEDATE($P(VISIT0,"^",1)),1:"")_"                                           ",1,40)
 S VALMHDR(2)=VALMHDR(2)_"Clinic Stop:  "_$S($P(VISIT0,"^",8)>0:$$DISPLY08^PXCECSTP($P(VISIT0,"^",8)),1:"")
 ;
 S VALMSG="+ Next Screen   - Prev Screen   ?? More Actions"
 Q
 ;
INIT ; -- init variables and list array
 D BUILD^PXCEAE1(PXCEVIEN,PXCEAEVW,"^TMP(""PXCEAE"",$J)","^TMP(""PXCEAEIX"",$J)")
 I '$D(VALMBCK) K VALMHDR S VALMBCK="R"
 Q
 ;
HELP ; -- help code
 S X="?" D DISP^XQORM1 W !!
 Q
 ;
EXIT ; -- exit code
 D CLEAN^VALM10
 K ^TMP("PXCEAE",$J),^TMP("PXCEAEIX",$J)
 D:$D(PXCEKPAT) PATKILL^PXCEPAT
 K PXCEVIEN
 Q
 ;
EXPND ; -- expand code
 S VALMBG=1
 S PXCEAEVW=$S(PXCEAEVW="D":"B",1:"D")
 D BUILD^PXCEAE1(PXCEVIEN,PXCEAEVW,"^TMP(""PXCEAE"",$J)","^TMP(""PXCEAEIX"",$J)")
 D DONE^PXCE
 Q
 ;
