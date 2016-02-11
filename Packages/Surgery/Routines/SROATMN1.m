SROATMN1 ;BIR/SJA - TRANSMIT NO ASSESSMENT ;06/02/2015
 ;;3.0;Surgery;****184**;24 Jun 93;Build 35
 ;** NOTICE: This routine is part of an implementation of a nationally
 ;**         controlled procedure. Local modifications to this routine
 ;**         are prohibited.
 ;
 N II,OT,DATE1,DATE2,SRNM11,SRNM13,SRNM23,SRNM2
 S (SRNM11,SRNM13,SRNM23,SRNM25)="",SRA(211)=$G(^SRF(SRTN,211))
 S DATE1=$E($P(SRA(211),"^",54),1,12),DATE2=$E($P(SRA(211),"^",55),1,12)
 S SRA("VER1")=$G(^SRF(SRTN,"VER1"))
 F II=11,23,13,25 I $P(SRA("VER1"),"^",II) S @("SRNM"_II)=$P($G(^VA(200,$P(SRA("VER1"),"^",II),0)),"^")
 S SRTEMP="@"_$J(SRASITE,3)_$J(SRTN,7)_"  E"_$J(DATE1,12)_$J(DATE2,12)
 S II=0,OT="" F  S II=$O(^SRF(SRTN,63,"B",II)) Q:'II  S OT=OT_II
 S SRTEMP=SRTEMP_$J(OT,7)_$J($P(SRA("VER1"),"^",2),10)_$J($P(SRA("VER1"),"^",3),2)_$J($P(SRA("VER1"),"^",4),2)_$J($P(SRA("VER1"),"^",5),2)
 S SRTEMP=SRTEMP_$J($P(SRA("VER1"),"^",6),2)_$J($P(SRA("VER1"),"^",7),1)_$J($P(SRA("VER1"),"^",8),1)_$J($P(SRA("VER1"),"^",9),1)_$J($E($P(SRA("VER1"),"^",19),1,12),12)
 S SRTEMP=SRTEMP_$J($P(SRA("VER1"),"^",10),1)_$J($E($P(SRA("VER1"),"^",21),1,12),12)_$J($E(SRNM11,1,30),30)_$J($P(SRA("VER1"),"^",22),1)_$J($P(SRA("VER1"),"^",12),1)
 S SRTEMP=SRTEMP_$J($E(SRNM23,1,30),30)_$J($E(SRNM13,1,30),30)_$J($P(SRA("VER1"),"^",24),2)_$J($P(SRA("VER1"),"^",14),2)_$J($E(SRNM25,1,30),30)
 S SRTEMP=SRTEMP_$J($P(SRA("VER1"),"^",15),1)_$J($P(SRA("VER1"),"^",16),1)
