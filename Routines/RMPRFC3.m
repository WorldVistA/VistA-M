RMPRFC3 ;HINES CIOFO/HNC - Process IFC HL7 ; 2/6/09
 ;;3.0;PROSTHETICS;**83**;Feb 09,1996;Build 20
 ;
 ;
 ;Helen Corkwell-new flow 3/9/05
 ;
 ; Patch 83 - 
 ;          - Prohibit filing data in 668 if code runs at sending site
 ;          - Exit if NW record in consults and 668; and if DC and is dup
 ; 
 Q
EN ;process IFC responses
 ;load message in ^TMP
 K ^TMP("RMPRIF",$J)
 N HLNODE,SEG,I  ;production code
 F I=1:1 X HLNEXT Q:HLQUIT'>0  D
 .I $P(HLNODE,"|")="OBX" D
 ..S ^TMP("RMPRIF",$J,"OBX",$P(HLNODE,"|",2),$P(HLNODE,"|",5))=$E(HLNODE,5,999)
 .I $P(HLNODE,"|")="NTE" D
 ..S ^TMP("RMPRIF",$J,"NTE",$P(HLNODE,"|",2))=$E(HLNODE,5,999)
 .I "OBXNTE"'[$P(HLNODE,"|") D
 ..S ^TMP("RMPRIF",$J,$P(HLNODE,"|"))=$E(HLNODE,5,999)
 ;
CHK ;
 ;DC does not have a OBR segment, must check status first
 ;
 ;
 ;is it a NW or DC order?
 I '$D(^TMP("RMPRIF",$J,"ORC")) G EXIT
 S RMPRST=$P(^TMP("RMPRIF",$J,"ORC"),"|",1)
 I RMPRST="OD" S RMPRST=$P(^TMP("RMPRIF",$J,"ORC"),"|",5)
 I (RMPRST'="NW")&(RMPRST'="DC") G EXIT
 ;
 I '$D(^TMP("RMPRIF",$J,"OBR"))&(RMPRST'="DC") G EXIT
 I RMPRST="NW"&($P($G(^TMP("RMPRIF",$J,"OBR")),"|",4)'["PROSTHETICS IFC") G EXIT
 ;
 ;is it a discontinued order? does it have a consult ien?
 ;is there a local consult ien? has it already been filed in 668?
 I RMPRST="NW" D
 .S RMPR123=$P(^TMP("RMPRIF",$J,"OBR"),"|",2)
 .S RMPR123I=$P(RMPR123,U,1),RMPRISIT=$P(RMPR123,U,2)
 ;
 I RMPRST="DC" D
 .S RMPR123=$P(^TMP("RMPRIF",$J,"ORC"),"|",3)
 .S RMPR123I=$P(RMPR123,U,1),RMPRISIT=$P(RMPR123,U,2)
 .S RMPR123A=RMPR123I
TST ;
 ;Consult IEN
 I RMPRST="NW" D
 .S RMPR123A=$O(^GMR(123,"AIFC",RMPRISIT,RMPR123I,0))
 ;
 I RMPR123A="" G EXIT
 ;added check, when HL7 link is down possible to get mult NW msg
 ;8/23/05 hnc
 ; modified check, EXIT imm. on NW message, loop On 668 "D" xref to determine if dup DC
 ; 13 MAR 09  DDA
 I RMPRST="NW" G:$D(^RMPR(668,"D",RMPR123A)) EXIT
 I RMPRST="DC" S RMPRDPDC=0 D
 .S RMPRDCIN="" F  S RMPRDCIN=$O(^RMPR(668,"D",RMPR123A,RMPRDCIN)) Q:RMPRDCIN=""  D
 ..S:^RMPR(668,RMPRDCIN,2,1,0)["****DISCONTINUED****" RMPRDPDC=1
 ..Q
 .Q
 I $G(RMPRDPDC)=1 G EXIT
 S ^TMP("RMPRIF",$J,"GOODTOGO")="OKAY"
 G EN^RMPRFC4
 Q
 ;
EXIT ;common exit point
 K ^TMP("RMPRIF",$J)
 G EXIT^RMPRFC4
 ;END
