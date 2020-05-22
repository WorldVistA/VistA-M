GMRCCCRA ;COG/PB/LB/MJ - Receive HL7 Message for HCP ;3/21/18 09:00
 ;;3.0;CONSULT/REQUEST TRACKING;**99,106,112,123,134,146**;JUN 1, 2018;Build 12
 ;
 ;DBIA# Supported Reference
 ;----- --------------------------------
 ;2161  INIT^HLFNC2
 ;2164  GENERATE^HLMA
 ;2944  TGET^TIUSRVR1
 ;3267  SSN^DPTLK1
 ;3630  BLDPID^VAFCQRY
 ;5807  GETLINK^TIUSRVT1
 ;10103 FMTE^XLFDT, FMTHL7^XLFDT
 ;10104 UP^XLFSTR
 ;10106 FMDATE^HLFNC
 ;1252  OUTPTPR^SDUTL3
 ;6917  EN^VAFHLIN1
 ;10106 HLADDR^HLFNC
 ;2467  OR^ORX8
 ;2171  NS^XUAF4
 ;2693  EXTRACT^TIULQ
 ;
 ;;Patch 85 fix for CA SDM ticket R6063960FY16
 ;;Patch 99 fix for screen to send community care consults HL7 messages -  Cognosante - PB Mar 5 2018
 ;;Patch 99 commented out PCP code- 2nd  PRD  segment -until Intersystems ready M14/M15- Cognosante-LB Apr 3 2018
 ;;Patch 106 added code to include IN1 segments with reimburse flag, and division value in PV1.
 ;;Patch 106 cleaned up per several ICRs.
 ;;Patch 112 critical fix to remove control characters before sending consult, as bad data was causing infinite loop of HL7 process.
 ;;Patch 123 consult status updates inbound to VistA, OHI additions outbound from VistA in IN1 segment
 ;;Patch 134 fix control character issue in TIU notes
 ;;Patch 146 fix if the consult was transferred from an imaging order, sets the DXCODE from the DX text
 ;;Patch 146 fix PRD address problem, set to null fields that contain only spaces
 ;;
 ;;proposed for CCRA release 8.0 - successfully send Administrative Complete consult notes
 ;
 ;
EN(MSG) ;Entry point to routine from GMRC CONSULTS TO CCRA protocol attached to GMRC EVSEND OR
 ;MSG = local array which contains the HL7 segments
 N I,QUIT,MSGTYP,DFN,ORC,GMRCDA,FS,MSGTYP2,MSGTYP3,ACTIEN,FROMSVC,OK,OKFROM,STATUS
 N UCID ;ABV/SCR 12/14/2017 *96*
 S (I,QUIT)=0,I=$O(MSG(I)) Q:'I  S MSG=MSG(I) Q:$E(MSG,1,3)'="MSH"  D  Q:QUIT
 .S FS=$E(MSG,4) I $P(MSG,FS,3)'="CONSULTS" S QUIT=1 Q
 .S MSGTYP=$P(MSG,FS,9) I ",ORR,ORM,"'[","_MSGTYP_"," S QUIT=1 Q  ;ORR is new consult, ORM are updates
 .Q
 F  S I=$O(MSG(I)) Q:'I!QUIT  S MSG=MSG(I) D
 .I $E(MSG,1,3)="PID" S DFN=+$P(MSG,FS,4) I 'DFN!('$D(^DPT(DFN))) S QUIT=1 Q
 .I $E(MSG,1,3)="ORC" S ORC=MSG S GMRCDA=+$P(ORC,FS,4),MSGTYP2=$P(ORC,FS,2),MSGTYP3=$P(ORC,FS,6) D
 ..D CCONTROL^GMRCCCR1(GMRCDA) ; strip out consult lines that contain only $C(13,10,10) to fix infinite msg loop - patch 112
 ..I MSGTYP3="IP" S ACTIEN=$O(^GMR(123,GMRCDA,40,99999),-1) D
 ...I ACTIEN S FROMSVC=$P($G(^GMR(123,GMRCDA,40,ACTIEN,0)),U,6) I FROMSVC S OKFROM=$$FEE(FROMSVC)
 ..S OK=$$FEE($$GET1^DIQ(123,GMRCDA,1,"I"))
 ..I '$G(OKFROM)&'$G(OK) S QUIT=1 ;not a Fee service or not forwarded from a fee service
 ..Q
 .Q
 Q:QUIT
 I MSGTYP="ORR" S MSGTYP3="NW"
 S STATUS=$$STATUS(MSGTYP2,MSGTYP3) I STATUS="UNKNOWN" Q  ;don't process anything we haven't coded for
 ;done verifying this consult needs to go to HCP, start building HL7 message
 N SNAME,GMRCHL,ZERR,ZCNT,ECH,DATA,GDATA,URG,TYP,RES,EFFDT,PDUZ,PN,ADDR,PH,GMRCP,SENS,DX,DXCODE
 N PCP,PCDUZ,PCPN,PCADDR,PCPH
 ;S SNAME="GMRC HCP REF-"_$S(MSGTYP2="DR":"I14",MSGTYP="ORR":"I12",MSGTYP2="OC":"I14",MSGTYP2="OD":"I14",1:"I13")_" SERVER"
 S SNAME="GMRC CCRA-HSRM REF-"_$S(MSGTYP2="DR":"I14",MSGTYP="ORR":"I12",MSGTYP2="OC":"I14",MSGTYP2="OD":"I14",1:"I13")_" SERVER"
 S GMRCHL("EID")=$$FIND1^DIC(101,,"X",SNAME)
 Q:'GMRCHL("EID")  D INIT^HLFNC2(GMRCHL("EID"),.GMRCHL)
 S ZERR="",ZCNT=0,ECH=$E(GMRCHL("ECH")) ;component separator
 ;start creating the segments.
 S DATA=$NA(^TMP("GMRCHL7CCRA",$J)) K @DATA D GETS^DIQ(123,GMRCDA,"*","IE",DATA)
 S GDATA=$NA(^TMP("GMRCHL7CCRA",$J,123,+GMRCDA_",")) ;File 123 data
 ;RF1 segment
 K GMRCM
 S URG=$G(@GDATA@(5,"E")) ;I URG]"" S URG=$S(URG["ROUTINE":"R",URG["STAT":"S",1:"A")
 S URG=$P(URG,"- ",2)
 S TYP=$G(@GDATA@(1,"I"))_ECH_$G(@GDATA@(1,"E")) D GETLINK^TIUSRVT1(.RES,+TYP_";GMR(123.5,")
 S TYP=TYP_ECH_ECH_$P($G(RES),U)_ECH_$P($G(RES),U,4)
 S EFFDT=$$FMTHL7^XLFDT($G(@GDATA@(.01,"I")))
 S ZCNT=ZCNT+1,GMRCM(ZCNT)="RF1|"_STATUS_"|"_URG_"|"_TYP_"||"_$G(@GDATA@(14,"I"))_"|"_GMRCDA_"|"_EFFDT_"||||"
 S UCID=$$GET1^DIQ(123,GMRCDA,80)
 S:$G(UCID)'="" GMRCM(ZCNT)="RF1|"_STATUS_"|"_URG_"|"_TYP_"||"_$G(@GDATA@(14,"I"))_"|"_UCID_"|"_EFFDT_"||||"
 S:$G(UCID)="" ^XTMP("GMRCHL7H","UCID IS EMPTY",GMRCDA)=GMRCDA ;TEMP ERROR HANDLER
 ;PRD segments 
 ;"RP"- Referring Provider segment 
 S PDUZ=+$G(@GDATA@(10,"I")),PN=$G(@GDATA@(10,"E")),PN=$$HLNAME^XLFNAME(PN,"S",ECH),$P(PN,ECH,9)=PDUZ
 N NPI S NPI=$P($G(^VA(200,PDUZ,"NPI")),"^")
 S ADDR=$$ADDR^GMRCHL7P(PDUZ,.GMRCHL),PH=$$PH^GMRCHL7P(PDUZ,.GMRCHL)
 S ADDR=$$CLRADD^GMRCCCR1(ADDR)  ; patch 146 - MJ
 S ZCNT=ZCNT+1,GMRCM(ZCNT)="PRD|RP|"_PN_"|"_$G(ADDR)_"||"_$G(PH)_"||"_+$G(NPI)
 ;;commented out PCP code- 2nd PRD segment -until Intersystems ready M14/M15- Cognosante-LB Apr 3 2018
 ;;PCP code-starts here-
 ;;"PP"- Primary Care Provider segment if the info exists 
 S PCP=$$OUTPTPR^SDUTL3(DFN)
 I +PCP  D
 . S PCDUZ=+PCP,PCPN=$P(PCP,"^",2),PCPN=$$HLNAME^XLFNAME(PCPN,"S",ECH),$P(PCPN,ECH,9)=PCDUZ
 . S PCADDR=$$ADDR^GMRCHL7P(PCDUZ,.GMRCHL),PCPH=$$PH^GMRCHL7P(PCDUZ,.GMRCHL)
 . S PCADDR=$$CLRADD^GMRCCCR1(PCADDR)  ; patch 146 - MJ
 . S NPI=$P($G(^VA(200,PCDUZ,"NPI")),"^")
 . S ZCNT=ZCNT+1,GMRCM(ZCNT)="PRD|PP|"_PCPN_"|"_$G(PCADDR)_"||"_$G(PCPH)_"||"_+$G(NPI)
 ;;PCP code-ends here-
 ;PID segment May be multiple nodes in the return array - make nodes 2-n sub nodes
 D BLDPID^VAFCQRY(DFN,1,"ALL",.GMRCP,.GMRCHL,ZERR)
 S I=0 F  S I=$O(GMRCP(I)) Q:'I  D
 .I I=1 S ZCNT=ZCNT+1,GMRCM(ZCNT)=$TR(GMRCP(I),"""") Q
 .S GMRCM(ZCNT,I)=$TR(GMRCP(I),"""")
 K GMRCP
 ; MJ - 5/24/2018 patch 106 changes to add - IN1 segments
 N GMRC0,I,INSP,INSPX,RETVAL,X,GMRCIN1,N,GMRCSTR,PLAN,PRECERT,TYPE ; PLAN, PRECERT, TYPE added for patch 123
 S GMRCSTR=",3,4,5,7,8,9,12,13,15,16,17,28,36"    ; IN1 fields to capture
 D EN^VAFHLIN1(DFN,GMRCSTR,,"|","GMRCIN1","^~\&") ; get IN1 segments
 ; loop through IN1 segments found
 F I=0:0 S I=$O(GMRCIN1(I)) Q:'I  I I>0 D
 . S GMRC0=$G(GMRCIN1(I,0)) I GMRC0']"" Q
 . S INSP=$P(GMRC0,"|",4)
 . S PRECERT=""  ; added for patch 123
 . S N=0 F  S N=$O(^DPT(DFN,.312,N)) Q:'N  I $D(^(N,0)) D
 .. S X=^DPT(DFN,.312,N,0)
 .. ; begin patch 123 mods
 .. N COORDBEN,LASTVER,Y
 .. S COORDBEN=$P(X,"^",20)
 .. S COORDBEN=$S(COORDBEN=1:"PRIMARY",COORDBEN=2:"SECONDARY",COORDBEN=3:"TERTIARY",1:"")
 .. S $P(GMRC0,"|",22)=COORDBEN
 .. S Y=$G(^DPT(DFN,.312,N,1)),LASTVER=$P(Y,"^",3)
 .. I +LASTVER>0 S LASTVER=LASTVER+17000000
 .. S $P(GMRC0,"|",30)=LASTVER
 .. S PLAN=+$P(X,"^",18)
 .. S PRECERT=$G(^IBA(355.3,PLAN,0)),TYPE=$P(PRECERT,"^",15),PRECERT=$P(PRECERT,"^",6)
 .. S PRECERT=$S(PRECERT=1:"YES",0:"NO",1:"")
 .. S $P(GMRC0,"|",16)=TYPE
 .. S PLANID=+$G(^IBA(355.3,PLAN,6)) S:PLANID=0 PLANID=""
 .. I $L(PLANID)>0 S PLANID=$P($G(^IBCNR(366.03,PLANID,0)),"^",1)
 .. S $P(GMRC0,"|",3)=PLANID ; 
 .. K COORDBEN,LASTVER,PLANID,Y
 .. ; end patch 123 mods
 .. N X1 S X1=$G(^DIC(36,+X,0)) I X1="" Q   ; no insurance company entry
 .. S INSPX=$P(X,U,1)
 .. I INSP=INSPX D                          ; insurance plan found matches that of the segment
 ... S RETVAL=$$GET1^DIQ(36,INSP_",",1,"I") ; get reimbursable flag
 ... S RETVAL=$S(RETVAL="Y":"YES",RETVAL="*":"*",RETVAL="**":"**",RETVAL="":"YES",RETVAL="N":"NO",1:"?")
 ... S $P(GMRC0,"|",33)=RETVAL              ; add flag back into segment
 ... ; get address
 ... S $P(GMRC0,"|",6)=$$GETADD^GMRCCCR1(INSP) ; get address info and put it into segment field 5
 ... S GMRCIN1(I,0)=GMRC0
 . S ZCNT=ZCNT+1,GMRCM(ZCNT)=GMRCIN1(I,0) ; add segment to message
 . ; patch 123 mods - if PRECERT value exists, create IN3 segment
 . I $L(PRECERT) S ZCNT=ZCNT+1,GMRCM(ZCNT)="IN3",$P(GMRCM(ZCNT),"|",21)="^"_PRECERT,PRECERT=""
 . ; end patch 123 mods
 K GMRC0,I,INSP,INSPX,RETVAL,X,GMRCIN1,N,GMRCSTR,PLAN,PRECERT,TYPE ; PLAN, PRECERT, TYPE added for patch 123
 ; end patch 106 changes
 ;DG1 segment ;Patch 85 modified
 ;if this is a radiology order converted to a consult the dxcode will not be in the consult in field 30.1
 ;the DX text has the dxcode in it, the code below parses it.
 ;radiology dx text:Encounter for other specified special examinations (ICD-10-CM Z01.89)
 S DX=$G(@GDATA@(30,"E"))
 S DXCODE=$G(@GDATA@(30.1,"E"))
 N TDXCODE
 I $G(DX)["(" S TDXCODE=$P($P(DX,"ICD-10-CM ",2),")",1),DX=$P(DX,"(")  ;PB - patch 146
 S:$G(DXCODE)="" DXCODE=$G(TDXCODE)
 S ZCNT=ZCNT+1,GMRCM(ZCNT)="DG1|1||"_$G(DXCODE)_ECH_$G(DX)_"|||W"
 ;OBR segment
 S ZCNT=ZCNT+1,GMRCM(ZCNT)="OBR|1|"_$P(ORC,FS,3)_"|"_$P(ORC,FS,4)_"|ZZ||"_$$FMTHL7^XLFDT($G(@GDATA@(17,"I")))
 ;PV1 segment
 D IN5^VADPT ;VAIP(18)=Attending Physician, VAIP(13,5)=Primary Physician for admission
 S ZCNT=ZCNT+1,GMRCM(ZCNT)="PV1|1|"_$S(VAIP(13):"I",1:"O")_"|||||"_VAIP(18)_"|"
 I VAIP(5) S $P(GMRCM(ZCNT),"|",4)=VAIP(5) ;location for last movement event
 ; patch 106 - add in division value
 N GMRCDIV
 S GMRCDIV=$$NS^XUAF4(DUZ(2)),GMRCDIV=$P(GMRCDIV,"^",2)
 N A,B S A="&"_GMRCDIV,B=$P(GMRCM(ZCNT),"|",4),$P(B,"^",4)=A,$P(GMRCM(ZCNT),"|",4)=B K A,B
 K GMRCDIV
 ; end patch 106 mod
 ;
 S SENS=$$SSN^DPTLK1(DFN) I SENS["*SENSITIVE*" S $P(GMRCM(ZCNT),"|",17)="R" ;sensitive patient
 S $P(GMRCM(ZCNT),"|",18)=VAIP(13,5)
 ; begin patch 106 mod
 K VAIP
 ; end patch 106 mod
 D KVA^VADPT
 ;NTE segment
 D NTE(.GMRCHL)
 K ^TMP("GMRCHL7CCRA",$J)
 ;
 ; When done, re-serve the (modified) referral message to CCRA
 N HL,HLA,GMRCRES,GMRCHLP
 M HL=GMRCHL,HLA("HLS")=GMRCM
 M GMRCHL=^XTMP("GMRCHL7H","MESSAGE")
 D GENERATE^HLMA(GMRCHL("EID"),"LM",1,.GMRCRES,"",.GMRCHLP)
 Q
NTE(HL) ;Find Reason for Request for New or Resubmit entries, Find TIU for complete, find Activity Comment for others
 N NTECNT,X S NTECNT=1
 I (MSGTYP="ORR"&(MSGTYP2'="DR"))!((MSGTYP3="IP")&'$G(OKFROM)) D  Q
 .D AUTHDTTM
 .S ZCNT=ZCNT+1,GMRCM(ZCNT)="NTE|"_NTECNT_"|P|Reason for Request"
 .S I=0 F  S I=$O(@GDATA@(20,I)) Q:'I  S X=@GDATA@(20,I) Q:X["^TMP"  D
 ..S X=$$TRIM^XLFSTR(X) I $L(X)=0 Q
 ..I X=$C(9,9) Q
 ..S X=$$TIUC^GMRCCCR1(X)
 ..D HL7TXT^GMRCHL7P(.X,.HL,"\")
 ..S ZCNT=ZCNT+1,NTECNT=NTECNT+1,GMRCM(ZCNT)="NTE|"_NTECNT_"||"_X
 ..Q
 .Q
 ; Build NTE for CM^ADDENDED
 I MSGTYP2="XX",MSGTYP3="CM" D  Q
 .N GMRCN,GMRCTXT,GMRCCMP,GMRCASTR
 .D AUTHDTTM
 .S ZCNT=ZCNT+1,GMRCM(ZCNT)="NTE|"_NTECNT_"|P|Progress Note"
 .S GMRCN=$P($G(^GMR(123,GMRCDA,50,1,0)),U) I GMRCN'["TIU(8925," Q
 .D TGET^TIUSRVR1(.GMRCTXT,$S(+$G(GMRCPARN):+GMRCPARN,+$G(TIUDA):+TIUDA,1:+GMRCN),"VIEW")
 .;
 .; line below modified in patch 106 to use GET1^DIQ call for date
 .S GMRCCMP=$$DATE^GMRCCCRA($$GET1^DIQ(8925,+TIUDA_",",1301,"I"),"MM/DD/CCYY")_" ADDENDUM"_" STATUS: "_$$GET1^DIQ(8925,+TIUDA_",",.05)
 .S (I,GMRCASTR)=0
 .F  S I=$O(@GMRCTXT@(I)) Q:I=""  S X=@GMRCTXT@(I) D
 ..I X=GMRCCMP S GMRCASTR=I
 .;
 .I GMRCASTR D
 ..S I=GMRCASTR-1
 ..F  S I=$O(@GMRCTXT@(I)) Q:I=""  S X=@GMRCTXT@(I) D
 ...S X=$$TRIM^XLFSTR(X) I $L(X)=0 Q
 ...D HL7TXT^GMRCHL7P(.X,.HL,"\")
 ...S X=$$TIUC^GMRCCCR1(X)
 ...S ZCNT=ZCNT+1,NTECNT=NTECNT+1,GMRCM(ZCNT)="NTE|"_NTECNT_"||"_X
 .K ^TMP("TIUVIEW",$J) ;clean up results of TIUSRVR1 call
 ;
 ; patch 146 - DONE flag used to determine if notes are found. If so, no need to drop to default
 ; some cases of DR/CM combo have notes stored in level 50, some in level 40
 ; both need to be accounted for
 ;
 ; I MSGTYP3="CM" D  Q  ; pre-146
 N DONE S DONE=0           ; patch 146
 I MSGTYP3="CM" D  Q:DONE  ; patch 146
 .N GMRCN,GMRCTXT
 .D AUTHDTTM
 .S ZCNT=ZCNT+1,GMRCM(ZCNT)="NTE|"_NTECNT_"|P|Progress Note"
 .S GMRCN=$P($G(^GMR(123,GMRCDA,50,1,0)),U) I GMRCN'["TIU(8925," Q
 .D TGET^TIUSRVR1(.GMRCTXT,$S(+$G(TIUDA):+TIUDA,1:+GMRCN),"VIEW") S I=0
 .F  S I=$O(@GMRCTXT@(I)) Q:I=""  S X=@GMRCTXT@(I) D
 ..S X=$$TRIM^XLFSTR(X) I $L(X)=0 Q
 ..D HL7TXT^GMRCHL7P(.X,.HL,"\")
 ..S X=$$TIUC^GMRCCCR1(X)
 ..S ZCNT=ZCNT+1,NTECNT=NTECNT+1,GMRCM(ZCNT)="NTE|"_NTECNT_"||"_X,DONE=1  ; patch 146 - DONE
 ..Q
 .K ^TMP("TIUVIEW",$J) ;clean up results of TIUSRVR1 call
 .Q
 I (MSGTYP2="DR") D  Q
 .N ORIEN,CMT
 .D AUTHDTTM
 .S ZCNT=ZCNT+1,GMRCM(ZCNT)="NTE|"_NTECNT_"|L|Activity Comment"
 .S ORIEN=$G(@GDATA@(.03,"I")) I 'ORIEN Q
 .S CMT=$$GET1^DIQ(100,ORIEN_",",64),CMT=$$TRIM^XLFSTR($G(CMT))
 .S CMT=$TR($G(CMT),$C(13,10,10),$C(10,10))
 .D HL7TXT^GMRCHL7P(.CMT,.HL,"\")
 .S CMT=$$TIUC^GMRCCCR1(CMT)
 .S ZCNT=ZCNT+1,GMRCM(ZCNT)="NTE|2||"_CMT
 .Q
 N ACT,ACTD,ACTIEN,Q
 S Q=0,ACTIEN=9999 F  S ACTIEN=$O(^GMR(123,GMRCDA,40,ACTIEN),-1) Q:'ACTIEN!Q  S X=$G(^GMR(123,GMRCDA,40,ACTIEN,0)) D
 .S ACT=$P(X,U,2),ACTD=$P($P($G(^GMR(123.1,+ACT,0)),U)," ")
 .I $P($P(STATUS,ECH,2)," ")'=ACTD Q
 .I +$O(^GMR(123,GMRCDA,40,ACTIEN,1,0)) D AUTHDTTM
 .S I=0 F  S I=$O(^GMR(123,GMRCDA,40,ACTIEN,1,I)) Q:'I  S X=$G(^GMR(123,GMRCDA,40,ACTIEN,1,I,0)) D
 ..I 'Q S ZCNT=ZCNT+1,GMRCM(ZCNT)="NTE|"_NTECNT_"|L|Activity Comment",Q=1
 ..S X=$$TRIM^XLFSTR(X) I $L(X)=0 Q
 ..D HL7TXT^GMRCHL7P(.X,.HL,"\")
 ..S X=$$TIUC^GMRCCCR1(X)
 ..S ZCNT=ZCNT+1,NTECNT=NTECNT+1,GMRCM(ZCNT)="NTE|"_NTECNT_"||"_X
 ..Q
 .Q
 Q
AUTHDTTM ; Add Author and Date/Time to NTE
 D AUTHDTTM^GMRCCCR1 ; patch 146, for size
 Q
STATUS(T1,T2) ;get status for event
 ;also add IP^COMMENT when those events are captured
 I T2="DC"!(T1="DR") Q "DC^DISCONTINUED"
 I T2="NW" Q "NW^CPRS RELEASED ORDER"
 I T1="SC"&(T2="SC") Q "SC^RECEIVED"
 I T1="SC"&(T2="ZC") Q "SC^SCHEDULED"
 I T1="XX"&(T2="XX") Q "IP^ADDED COMMENT"
 I T2="CA" Q "CA^CANCELLED"
 I T2="CM" D
 .I '+$G(GMRCPARN),'+$G(TIUDA) S GMRCPARN=$P($G(^GMR(123,GMRCDA,50,1,0)),U)
 .S $P(ORC,FS,4)=$S(+$G(GMRCPARN):+GMRCPARN_";TIU^TIU",+$G(TIUDA):+TIUDA_";TIU^TIU",1:$P(ORC,FS,4))
 I T1="XX"&(T2="CM") Q "CM^ADDENDED"
 I T2="CM" Q "CM^COMPLETE/UPDATE" ; patch 146, was "CM^COMPLETE", didn't match file 123.1 ; MJ
 I T1="XX"&(T2="IP")&$G(OKFROM) Q "XX^FORWARDED"
 I T1="XX"&(T2="IP") Q "IP^RESUBMITTED"
 Q "UNKNOWN"
FEE(FEESVC) ;send only if name contains HCPS
 I $G(FEESVC)="" Q 0
 N VAL
 S VAL=0
 I $$UP^XLFSTR($$GET1^DIQ(123.5,FEESVC,.01,"E"))["HCPS" S VAL=1
 I $$UP^XLFSTR($$GET1^DIQ(123.5,FEESVC,.01,"E"))["COMMUNITY CARE" S VAL=1 ;*99 - PB - Mar 5, 2018
 I $$UP^XLFSTR($$GET1^DIQ(123.5,FEESVC,.01,"E"))["DOD TREATMENT" S VAL=1 ;*99 - PB - Mar 5, 2018
 Q VAL
COMMENT(GMRCDA) ;send comments on Non VA Care consults to HCP
 ;create a fake event for HCP since there is no HL7 event passed to GMRC EVSEND OR
 I '$G(GMRCDA) Q
 ;N DFN S DFN=$$GET1^DIQ(123,GMRCDA,.02,"I") I 'DFN,'$D(^DPT(DFN)) Q ; modified "," to "!" within patch 106
 N DFN S DFN=+$$GET1^DIQ(123,GMRCDA,.02,"I") I 'DFN!('$D(^DPT(DFN))) Q
 N T S T(1)="MSH|^~\&|CONSULTS||||||ORM"
 S T(2)="PID|||"_DFN
 S T(4)="ORC|XX|"_$$GET1^DIQ(123,GMRCDA,.03,"I")_";"_$$OITEM($$GET1^DIQ(123,GMRCDA,.03,"I"))_"^OR|"_GMRCDA_";GMRC^GMRC||XX|"
 D EN(.T)
 Q
ADDEND(TIUDA) ;send addendums on Non VA Care consults to HCP
 ;create a fake event for HCP since there is no HL7 event passed to GMRC EVSEND OR
 ;
 I '$G(TIUDA) Q
 Q:'$D(^TIU(8925,+TIUDA,0))
 N TIUTYP,DFN,GMRCPARN,GMRCO,GMRCD,GMRCDA,GMRCD1,GMRC8925,T
 ;
 S GMRCO=$$ADDEND^GMRCCCR1 Q:'GMRCO   ; patch 146, needed for space ; MJ
 ;
 S T(1)="MSH|^~\&|CONSULTS||||||ORM"
 S T(2)="PID|||"_DFN
 S T(4)="ORC|XX|"_$$GET1^DIQ(123,GMRCO,.03,"I")_";"_$$OITEM($$GET1^DIQ(123,GMRCO,.03,"I"))_"^OR|"_GMRCO_";GMRC^GMRC||CM|"
 I $$FEE($$GET1^DIQ(123,GMRCO,1,"I")) D EN(.T)
 Q
TIME(X,FMT) ; Copied from $$TIME^TIULS
 ; Receives X as 2910419.01 and FMT=Return Format of time (HH:MM:SS).
 N HR,MIN,SEC,TIUI
 I $S('$D(FMT):1,'$L(FMT):1,1:0) S FMT="HR:MIN"
 S X=$P(X,".",2),HR=$E(X,1,2)_$E("00",0,2-$L($E(X,1,2))),MIN=$E(X,3,4)_$E("00",0,2-$L($E(X,3,4))),SEC=$E(X,5,6)_$E("00",0,2-$L($E(X,5,6)))
 F TIUI="HR","MIN","SEC" S:FMT[TIUI FMT=$P(FMT,TIUI)_@TIUI_$P(FMT,TIUI,2)
 Q FMT
DATE(X,FMT) ; Copied from $$DATE^TIULS
 ; Call with X=2910419.01 and FMT=Return Format of date ("MM/DD")
 N AMTH,MM,CC,DD,YY,TIUI,TIUTMP
 I +X'>0 S $P(TIUTMP," ",$L($G(FMT))+1)="",FMT=TIUTMP G QDATE
 I $S('$D(FMT):1,'$L(FMT):1,1:0) S FMT="MM/DD/YY"
 S MM=$E(X,4,5),DD=$E(X,6,7),YY=$E(X,2,3),CC=17+$E(X)
 S:FMT["AMTH" AMTH=$P("JAN^FEB^MAR^APR^MAY^JUN^JUL^AUG^SEP^OCT^NOV^DEC","^",+MM)
 F TIUI="AMTH","MM","DD","CC","YY" S:FMT[TIUI FMT=$P(FMT,TIUI)_@TIUI_$P(FMT,TIUI,2)
 I FMT["HR" S FMT=$$TIME(X,FMT)
QDATE Q FMT
OITEM(GMRCORDN) ; Orderable Item
 ; patch 106 - modified to use ICR 2467
 N RETVAL ;,GMRCOITM
 S RETVAL=1
 ;S GMRCOITM=+$O(^OR(100,GMRCORDN,.1,0))
 ;I GMRCOITM D
 ;.S RETVAL=+$G(^OR(100,GMRCORDN,.1,GMRCOITM,0))
 ;.I 'RETVAL S RETVAL=1
 S RETVAL=+$$OI^ORX8(GMRCORDN)
 I 'RETVAL S RETVAL=1
 ; end patch 106 mods
 Q RETVAL
ACK ; Process ACK HL7 messages
 D ACK^GMRCCCR1 ; patch 146, moved for space
 Q
MESSAGE(MSGID,ERRARY) ; Send a MailMan Message with the errors
 D MESSAGE^GMRCCCR1(MSGID,.ERRARY)
 Q
