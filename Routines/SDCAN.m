SDCAN ;ALB/LDB - CREATE INDIVIDUALLY CANCELLED APPT. NODES ;25-NOV-88@14:00
 ;;5.3;Scheduling;**487**;Aug 13, 1993
 K Q8 F Q7=0:0 S Q7=$O(^SC($P(^DPT(DA(1),"S",DA,0),"^"),"S",DA,1,Q7)) Q:Q7'>0  I $P(^(Q7,0),"^")=DA(1),$P(^(0),"^",9)["C" S Q8="" Q
 I '$D(Q8) S ^DPT("ASDCN",$P(^DPT(DA(1),"S",DA,0),"^"),DA,DA(1))=$S($P(^DPT(DA(1),"S",DA,0),"^",2)["P":1,1:"")
 K Q7,Q8 Q
