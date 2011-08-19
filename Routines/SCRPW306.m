SCRPW306 ; BPFO/JRC - ACRP Ad Hoc Report for Perf Monitors; 6-19-2003
 ;;5.3;Scheduling;**292**;Aug 13, 1993
 ;
PMPR(SDX) ;Provider signing progress note
 K SDX N INFO,PTR
 D GETTIU
 S PTR=+$P(INFO,"^",1)
 S:PTR SDX(1)=PTR_"^"_$P($G(^VA(200,PTR,0)),"^",1)
 D NX Q
 ;
PMDT(SDX) ;Date progress notes was signed
 K SDX N INFO,DATE
 D GETTIU
 S DATE=+$P(INFO,"^",2)
 S:DATE SDX(1)=DATE_"^"_$$FMTE^XLFDT(DATE,"1D")
 D NX Q
 ;
PMET(SDX) ;Elapsed time in (days) for provider to sign progress note
 K SDX N INFO,ELAPSE
 D GETTIU
 S ELAPSE=$P(INFO,"^",3)
 S:ELAPSE'="" SDX(1)=ELAPSE_"^"_ELAPSE
 D NX Q
 ;
NX S:$D(SDX)<10 SDX(1)="~~~NONE~~~^~~~NONE~~~" Q
 ;
GETTIU ;Get data from TIU
 ;Input  : SDOE - Pointer to Outpatient Encounter (#409.68)
 ;         SDOE0 - Zero node of encounter
 ;Output : None
 ;         INFO = P1 ^ P2 ^ P3
 ;                P1 - Signing Provider (ptr)
 ;                P2 - Date Signed (FM)
 ;                P3 - Elapsed Time (day)
 ;Note   : INFO will be set to NULL if a note signed by an
 ;         acceptable provider is not found
 ;
 N TIUINFO,PROV,DATE,ELAPSE
 ;Get progress note status/info
 S TIUINFO=$$NOTEINF^SDPMUT2(SDOE)
 S INFO=""
 ;Status not acceptable
 I $P(TIUINFO,"^",2)'="B" Q
 ;Determine signing provider & date signed
 S PROV=$P(TIUINFO,"^",5)
 S DATE=$P(TIUINFO,"^",6)
 I 'PROV S PROV=$P(TIUINFO,"^",3),DATE=$P(TIUINFO,"^",4)
 ;Determine elapsed time
 S ELAPSE=$$FMDIFF^XLFDT(DATE,+SDOE0)
 ;Done
 S INFO=PROV_"^"_DATE_"^"_ELAPSE
 Q
