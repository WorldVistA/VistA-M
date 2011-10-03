PSO52CLR ;BIR/DB - Encapsulation Routine ; 27 Feb 2008
 ;;7.0;OUTPATIENT PHARMACY;**299**;DEC 1997;Build 5
STAT(PSO) ;Return Status(#100) external format from Prescription (#52) file
 N PSOSTAT I $G(PSO)="" Q "UNKNOWN"
 S PSOSTAT=$$EXTERNAL^DILFD(52,100,,PSO)
 I $G(PSOSTAT)="" S PSOSTAT="UNKNOWN"
 Q PSOSTAT
 ;
NEPSRX() ;Return number of entries in PSRX
 N DA,DA1,DATE,DSUP,DFN,DRUG,NE,RDATE,TEMP
 S (DA,NE)=0
 F  S DA=+$O(^PSRX(DA)) Q:DA=0  D
 . S TEMP=$G(^PSRX(DA,0))
 . S DFN=$P(TEMP,U,2)
 . I DFN="" Q
 . S DRUG=$P(TEMP,U,6)
 . I DRUG="" Q
 . S DSUP=$P(TEMP,U,8)
 . I DSUP="" Q
 . S RDATE=+$P($G(^PSRX(DA,2)),U,13)
 . I RDATE>0 S NE=NE+1
 .;Process the refill mutiple.
 . S DA1=0
 . F  S DA1=+$O(^PSRX(DA,1,DA1)) Q:DA1=0  D
 .. S TEMP=$G(^PSRX(DA,1,DA1,0))
 .. S DSUP=+$P(TEMP,U,10)
 .. I DSUP="" Q
 .. S RDATE=+$P(TEMP,U,18)
 .. I RDATE>0 S NE=NE+1
 .;Process the partial fill multiple.
 . S DA1=0
 . F  S DA1=+$O(^PSRX(DA,"P",DA1)) Q:DA1=0  D
 .. S TEMP=$G(^PSRX(DA,"P",DA1,0))
 .. S DSUP=+$P(TEMP,U,10)
 .. I DSUP="" Q
 .. S RDATE=+$P(TEMP,U,19)
 .. I RDATE>0 S NE=NE+1
 K DA,DA1,DATE,DSUP,DFN,DRUG,RDATE,TEMP
 Q NE
