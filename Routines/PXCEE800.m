PXCEE800 ;ISL/dee,ISA/KWP - Used in editing the 800 node, Service Connected conditions ;06/06/05
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**74,111,130,168**;Aug 12, 1996;Build 14
 ;; ;
 Q
 ;
GET800 ;Used by all the Service Connected Conditions
 ;Do not ask if not primary visit.
 Q:$P(PXCEAFTR(0),"^",22)'>0
 Q:$P(PXCEAFTR(0),"^",8)'=$P(^SC($P(PXCEAFTR(0),"^",22),0),"^",7)
 N PXCEINDX,PXOUT
 N PXBDATA
 D CLASS^PXBAPI21("",PXCEPAT,+PXCEAFTR(0),$P(PXCEAFTR(0),"^",22),PXCEFIEN)
 ;PX*1*111 - Add HNC
 F PXCEINDX=1:1:8 I $G(PXBDATA("ERR",PXCEINDX))=4 S PXOUT=PXBDATA("ERR",PXCEINDX)
 I $D(PXOUT) S (PXCEEND,PXCEQUIT)=1 Q  ;for visit and required fields
 S $P(PXCEAFTR(800),"^",1)=$P($G(PXBDATA(3)),"^",2)
 S $P(PXCEAFTR(800),"^",2)=$P($G(PXBDATA(1)),"^",2)
 S $P(PXCEAFTR(800),"^",3)=$P($G(PXBDATA(2)),"^",2)
 S $P(PXCEAFTR(800),"^",4)=$P($G(PXBDATA(4)),"^",2)
 S $P(PXCEAFTR(800),"^",5)=$P($G(PXBDATA(5)),"^",2)
 ;PX*1*111 - Add HNC
 S $P(PXCEAFTR(800),"^",6)=$P($G(PXBDATA(6)),"^",2)
 S $P(PXCEAFTR(800),"^",7)=$P($G(PXBDATA(7)),"^",2)
 S $P(PXCEAFTR(800),"^",8)=$P($G(PXBDATA(8)),"^",2)
 Q
 ;
