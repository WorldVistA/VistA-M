RMPRHL7U ;HINES CIOFO/HNC - Utilities for HL7 messages ;3/14/00
 ;;3.0;PROSTHETICS;**45,78**;Feb 09, 1996
 ;
 ;Patch #78 09/26/03 TH - Add field desc for PV1 & ZCL segments.
 ;                      - Clean up DG1 related variables.
 Q
 ;
PID(RMPRPID) ;Get fields from PID segment and set into RMPR variables.
 S DFN=$P(RMPRPID,"|",4),RMPRPNM=$P(RMPRPID,"|",6)
 Q
 ;
PV1(RMPRPV1) ;
 ;Get fields from PV1 segment of HL-7 message and set into RMPR variables
 N X
 ; RMPRSBR = service basis to be rendered (Inpatient or Outpatient)
 S X=$P(RMPRPV1,"|",3),RMPRSBR=$S(X]"":X,1:"")
 ;
 ; Patient Location
 ; Inpatient: Hospital Location IEN^Room-Bed
 ; Outpatinet: Hospital Location IEN
 ; RMPRWARD=patients ward
 S X=$P(RMPRPV1,"|",4),RMPRWARD=$S($P(X,"^",1)]"":$P(X,"^",1),1:"")
 ; RMPRRB  = patients room/bed
 S RMPRRB=$S($P(X,"^",2)]"":$P(X,"^",2),1:"")
 ;
 ; Outpatient: VISIT=Pointer for the Visit file (#9000010)
 S VISIT=$S($P(RMPRPV1,"|",20)]"":$P(RMPRPV1,"|",20),1:"")
 N RMPRVSIT S:VISIT]"" RMPRVSIT=$$FMDATE^RMPRHL7(VISIT)
 Q
 ;
REJECT(RMPRMSG) ;can't be filed send reject message
 ;
 ;send message to mail group RMPR SUSP
 N XMDUZ
 S XMDUZ=.5
 S XMTEXT="RMPRMSG("
 S XMSUB="Request Failed to Suspense"
 S XMY("RMPR SUSP")=""
 D ^XMD
 Q
 ;
FILE(RMPRO,DR) ;File data "^"RMPR(668,IEN,4 using "^"DIE
 N DIE,DA
 ;RMPRO = IEN
 L +^RMPR(668,+RMPRO,4) S:'$D(^RMPR(668,+RMPRO,4,0)) ^(0)="^668.02DA^^"
 S DA=$S($P(^RMPR(668,+RMPRO,4,0),"^",3):$P(^(0),"^",3)+1,1:1),DA(1)=+RMPRO
 S DIE="^RMPR(668,"_RMPRO_",4,"
 S $P(^RMPR(668,+RMPRO,4,0),"^",3,4)=DA_"^"_DA
 D ^DIE
 L -^RMPR(668,+RMPRO,4)
 Q
 ;
EXIT ;Kill variables and exit
 K HLQ,J,LN,ND,ND1,ND2
 K RMPRA,RMPRACT,RMPRAD,RMPRAP,RMPRAPP,RMPRATN,RMPRDA,RMPRDEV,RMPRFAC
 K RMPRFF,RMPRINTR,RMPRMTP,RMPRMSG,RMPRMSH,RMPRNOD,RMPRNTC,RMPRODT
 K RMPROID,RMPRORFN,RMPRPA,RMPRPLCR,RMPRPLI,RMPRPNM,RMPRPR,RMPRPRI,RMPRFQ
 K RMPRPRDG,RMPRSEND,RMPRSTDT,RMPRSTS,RMPRURGI,RMPRVAL,RMPRVTYP,RMPRWARD
 K RMPRPRV,RMPRTYPE,RMPRND,RMPRND1,VISIT
 K RMPRRB,RMPRPRA,RMPRRFQ,MSH,OBXND,PID,RMPRORPV,RMPROTXT
 K RMPRTRLC,RMPRSS,RMPRO,RMPRORNP
 K RMPRGMRC,RMPRCD,RMPRNATO,RMPRQT,RMPRS38,RMPRS668
 K DA,DIC
 K RMPRMSG,RMPRCI,RMPRSID,RMPRDIAG,RMPRDG1
 Q
 ;END
