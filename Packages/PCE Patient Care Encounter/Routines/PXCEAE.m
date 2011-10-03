PXCEAE ;ISL/dee,ISA/KWP - Main routine for the List Manager display of a visit and related v-files ;04/26/99
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**37,67,99,147,156,172,195**;Aug 12, 1996;Build 1
 ;; ;
 Q
EN ;+ -- main entry point for PXCE DISPLAY VISIT
 Q:$G(PXCEVIEN)'>0
 ;The selection list for the AICS' package interface used in help messages
 N PXCEHLST
 ;
 N PXCEAEVW S PXCEAEVW="B"
 N PXCEVDEL S PXCEVDEL=0
 ;
 I '$D(PXCEPAT) N PXCEPAT D
 . S PXCEPAT=$P($G(^AUPNVSIT(PXCEVIEN,0)),"^",5)
 ; next 3 lines PX*1.0*172
 N PXREC,PXPTSSN,PXDUZ S PXDUZ=DUZ,PXPTSSN=$P($G(^DPT(PXCEPAT,0)),U,9)
 D SEC^PXCEEXP(.PXREC,PXDUZ,PXPTSSN)
 I PXREC W !!,"Security regulations prohibit computer access to your own medical record." H 3 Q
 S PXCECAT="AEP" D PATINFO^PXCEPAT(.PXCEPAT) K PXCECAT
 ;
 I '$D(PXCEHLOC) N PXCEHLOC S PXCEHLOC=$P($G(^AUPNVSIT(PXCEVIEN,0)),"^",22)
 ;Get Visit date/time if exists - PX*195
 I '$D(PXCEAPDT) N PXCEAPDT S PXCEAPDT=$P($G(^AUPNVSIT(PXCEVIEN,0)),"^")
 ;+If not called from encounter viewer lock ^PXLCKUSR
 ;+and create ^XTMP("PXLCKUSR",VISIEN)=DUZ
 I PXCEKEYS'["V" D
 .N PXRESVAL,PXVISIEN,PXMSG,PXUSR
 .S PXMSG="",PXVISIEN=PXCEVIEN
 .I $D(^XTMP("PXLCKUSR",PXVISIEN)) S PXUSR=$G(^VA(200,^XTMP("PXLCKUSR",PXVISIEN),0)),PXUSR=$S(PXUSR="":"Unknown",1:$P(PXUSR,"^")),PXMSG="Encounter Locked by "_PXUSR
 .S PXRESVAL=$$LOCK^PXUALOCK("^PXLCKUSR("_PXVISIEN_")",5,0,PXMSG,0)
 .I 'PXRESVAL Q
 .S PXRESVAL=$$CREATE^PXUAXTMP("PXLCKUSR",PXVISIEN,365,"PCE Encounter Lock",DUZ)
 .I 'PXRESVAL D UNLOCK^PXUALOCK("^PXLCKUSR("_PXVISIEN_")") Q
 .D EN^VALM("PXCE ADD/EDIT MENU")
 .D UNLOCK^PXUALOCK("^PXLCKUSR("_PXVISIEN_")"),DELETE^PXUAXTMP("PXLCKUSR",PXVISIEN)
 I PXCEKEYS["V",$D(^TMP("VALM DATA",$J,VALMEVL,"EXP")),^("EXP")]"" X ^("EXP")
 Q
 ;
GETVIEN ;Ask the user which visit.
 N PXCEVIDX
 S PXCEVIDX=+$P(XQORNOD(0),"^",3)
 S:PXCEVIDX'>0 PXCEVIDX=$$SEL1^PXCE("")
 Q:PXCEVIDX'>0
 S PXCEVIEN=$G(^TMP("PXCEIDX",$J,PXCEVIDX))
 ;Check that it is not related to a no show or canceled apppointment
 D APPCHECK^PXCESDAM(.PXCEVIEN)
 Q:'$D(PXCEVIEN)
 ;Cannot edit future visits
 I $P(+^AUPNVSIT(PXCEVIEN,0),".")>DT D  Q
 . W !!,$C(7),"Can not update future encounters."
 . D WAIT^PXCEHELP
 . K PXCEVIEN
 ;Check if the visit can be associated with an appointment.
 S PXCEAPPM=$G(^DPT($P(^AUPNVSIT(PXCEVIEN,0),"^",5),"S",+^AUPNVSIT(PXCEVIEN,0),0))
 I $P(PXCEVIEN,"^",7)="E" D  I 'Y K PXCEVIEN Q
 . W !!,"This is a historical encounter for documenting a clinical encounter only"
 . W !,"and will not be used by Scheduling, Billing or Workload credit."
 . D PAUSE^PXCEHELP
 Q
 ;
HDR ; -- header code
 I '$D(^AUPNVSIT(PXCEVIEN,0)) S VALMQUIT=1 Q
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
 ;
 Q
 ;
KEYS(PXCEPROT,PXCEEND) ;Set up ^XQORM("KEY") array so that can edit an item by having its 
 ;  number be and action to edit it.
 N PXCEPIEN,PXCEINDX
 S PXCEPIEN=$O(^ORD(101,"B",PXCEPROT,0))_"^1"
 F PXCEINDX=1:1:PXCEEND S XQORM("KEY",PXCEINDX)=PXCEPIEN
 ;
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
 ;
 ;Check for incomplete ENCOUNTER if not already removed.
 N PXQUIT
 S PXQUIT=1
 D:'$G(PXCEEXIT) CHECK^PXCEVFI5
 ;
 D CLEAN^VALM10
 K ^TMP("PXCEAE",$J),^TMP("PXCEAEIX",$J)
 D EVENT^PXKMAIN
 K PXCEVIEN,PXCEAPPM
 Q
 ;
EXPND ; -- expand code
 S PXCEAEVW=$S(PXCEAEVW="B":"D",1:"B")
 D BUILD^PXCEAE1(PXCEVIEN,PXCEAEVW,"^TMP(""PXCEAE"",$J)","^TMP(""PXCEAEIX"",$J)")
 D DONE^PXCE
 Q
 ;
EDIT ; -- edit a V-File entry
 N PXCEFIDX
 S PXCEFIDX=+$P(XQORNOD(0),"^",3)
 D DOMANY(PXCEFIDX,"E","EN^PXCEVFIL(PXCECAT)")
 Q
 ;
DEL ; -- delete a V-File entries
 I PXCEKEYS'["D",PXCEKEYS'["d" W !!!,$C(7),"Error: You do not have delete access." D WAIT^PXCEHELP Q
 D DOMANY(0,"D","DEL^PXCEVFI2(PXCECAT)")
 Q
 ;
DOMANY(PXCEFIDX,WHATDO,WHATTODO) ;Process one or more V-File entries
 ;WHATDO is E for edit and D for delete
 ;WHATTODO is the routine to call
 ;
 I WHATDO="D" N PXCEDELV S PXCEDELV=0
 D FULL^VALM1
 I WHATDO="E" D
 . S:PXCEFIDX'>0 PXCEFIDX=$$SEL^PXCEAE2("Edit",1)
 E  I WHATDO="D" D
 . S:PXCEFIDX'>0 PXCEFIDX=$$SEL^PXCEAE2("Delete",2)
 E  W "??",$C(7) Q
 Q:+PXCEFIDX'>0
 N PXCEINDX,PXCEFIX1,PXCEFIX2
 F PXCEINDX=1:1 S PXCEFIX1=$P(PXCEFIDX,",",PXCEINDX) Q:PXCEFIX1']""  D
 . I $L(PXCEFIX1,"-")=1 D
 .. I WHATDO="D",PXCEFIX1=1 S PXCEDELV=1
 .. E  D DO1(PXCEFIX1,WHATDO,WHATTODO)
 . E  F PXCEFIX2=$P(PXCEFIX1,"-",1):1:$P(PXCEFIX1,"-",2) D
 .. I WHATDO="D",PXCEFIX2=1 S PXCEDELV=1
 .. E  D DO1(PXCEFIX2,WHATDO,WHATTODO)
 I WHATDO="D",PXCEDELV D DO1(1,WHATDO,WHATTODO)
 D INIT
 Q
 ;
DO1(PXCEFIDX,WHATDO,WHATTODO) ;Process one V-File entry
 ;PXCEFIDX is and index into ^TMP("PXCEAEIX",$J, which tells the V-File
 ;  and the IEN to process
 ;WHATDO is E for edit and D for delete
 ;WHATTODO is the routine to call
 ;
 N PXCEONE,PXCECAT,PXCEFIEN
 S PXCEONE=$G(^TMP("PXCEAEIX",$J,PXCEFIDX))
 S PXCEFIEN=+PXCEONE
 S PXCECAT=$P(PXCEONE,"^",2)
 I PXCECAT="CSTP",WHATDO="E" W !!!,$C(7),"You cannot edit stop codes." S PXCENOER=1 D WAIT^PXCEHELP Q
 I PXCECAT="VST",$P(^AUPNVSIT(PXCEFIEN,0),"^",7)="E" S PXCECAT="HIST"
 D @$S("~VST~HIST~CSTP~CPT~IMM~PED~POV~PRV~SK~TRT~HF~XAM~"[("~"_PXCECAT_"~"):WHATTODO,1:"QUIT")
 Q
 ;
QUIT Q
 ;
