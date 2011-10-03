PSOQTIU4 ;VAPA/ELZ - tiu utility routine ; 30 Nov 2007  8:01 AM
 ;;7.0;OUTPATIENT PHARMACY;**294**;DEC 1997;Build 13
 ;
 ;
PHONE(DFN) ; -- entry point for pt's home phone number
 N VAPA
 D ADD^VADPT
 Q VAPA(8)
 ;
ADDRESS(DFN,TARGET) ; -- entry point for pt's home address
 N LINE,DA,VAPA
 K @TARGET S LINE=0
 D ADD^VADPT
 F DA=1:1:3 D
 . Q:VAPA(DA)=""
 . S LINE=LINE+1
 . S @TARGET@(LINE,0)=VAPA(DA)
 . W "."
 S LINE=LINE+1,@TARGET@(LINE,0)=VAPA(4)_", "_$P(VAPA(5),U,2)_"  "_VAPA(6)
 I VAPA(9)'="" S LINE=LINE+1,@TARGET@(LINE,0)="Temporary Address Start: "_$P(VAPA(9),U,2)  ;dc-3/18/98
 I VAPA(10)'="" S LINE=LINE+1,@TARGET@(LINE,0)="Temporary Address Stop: "_$P(VAPA(10),U,2)  ;dc-3/18/98
 S @TARGET@(0)="^^"_LINE_"^"_LINE_"^"_DT_"^^"
 Q "~@"_$NA(@TARGET)
 ;
NEXTAPPT(DFN) ; -- entry point for next scheduled appointment
 N INFO
 D SDA^VADPT
 S INFO=$S($D(^UTILITY("VASD",$J,1,"E")):$P(^("E"),U)_" "_$P(^("E"),U,2),1:"No Future Appointments Scheduled")
 K ^UTILITY("VASD",$J)
 Q INFO
