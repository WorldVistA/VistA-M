PXCED800 ;WASH/BDB - Used in editing the 800 node, Service Connected conditions ;1/18/05 3:33pm
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**124,168**;Aug 12, 1996;Build 14
 ;; ;
 Q
 ;
 ;            Classification type 1 - Agent Orange
 ;                                2 - Ionizing Radiation
 ;                                3 - Service Connected
 ;                                4 - SW Asia Conditions
 ;                                5 - Military Sexual Trauma
 ;                                6 - Cancer of the Head and/or Neck
 ;                                7 - Combat Veteran
 ;                                8 - Project 112/SHAD
GET800 ;Used by the Service Connected Conditions
 N PXCEINDX,PXOUT
 N PXBDATA,PXLOC,PXAPTDT,PXDFN
 S PXCEDXSC=""
 I $O(^SCE("AVSIT",PXCEVIEN,0)) D CLASS^PXBAPI21("","","","",PXCEVIEN)
 I '$O(^SCE("AVSIT",PXCEVIEN,0)) D
 . S PXAPTDT=+^AUPNVSIT(PXCEVIEN,0)
 . S PXDFN=$P(^AUPNVSIT(PXCEVIEN,0),"^",5)
 . S PXLOC=$P(^AUPNVSIT(PXCEVIEN,0),"^",22)
 . D CLASS^PXBAPI21("",PXDFN,PXAPTDT,PXLOC,"")
 F PXCEINDX=1:1:8 I $G(PXBDATA("ERR",PXCEINDX))=4 S PXOUT=PXBDATA("ERR",PXCEINDX)
 I $D(PXOUT) S PXCEEND=1 Q
 S $P(PXCEDXSC,"^",1)=$P($G(PXBDATA(3)),"^",2)
 I +PXCEDXSC S (PXDATA(1),PXDATA(2),PXDATA(4))="^^"
 S $P(PXCEDXSC,"^",2)=$P($G(PXBDATA(1)),"^",2)
 S $P(PXCEDXSC,"^",3)=$P($G(PXBDATA(2)),"^",2)
 S $P(PXCEDXSC,"^",4)=$P($G(PXBDATA(4)),"^",2)
 S $P(PXCEDXSC,"^",5)=$P($G(PXBDATA(5)),"^",2)
 S $P(PXCEDXSC,"^",6)=$P($G(PXBDATA(6)),"^",2)
 S $P(PXCEDXSC,"^",7)=$P($G(PXBDATA(7)),"^",2)
 S $P(PXCEDXSC,"^",8)=$P($G(PXBDATA(8)),"^",2)
 Q
 ;
