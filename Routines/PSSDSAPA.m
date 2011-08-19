PSSDSAPA ;BIR/RTR,TMK-Dose Check APIs routine (continued) ; 27 Oct 2009  12:22 PM
 ;;1.0;PHARMACY DATA MANAGEMENT;**151**;9/30/97;Build 80
 ;
IV(PSSADFOI) ;Return Additive Frequency default to CPRS, Forum DBIA 5504 ; 27 Oct 2009  12:16 PM
 ;PSSADFOI = File 50.7 Internal Entry Number
 N PSSADFRS,PSSADFIN,PSSADFLP,PSSADFXX,PSSADFHD,PSSADFLD,PSSADFNN,PSSADFER,PSSADFCT
 S PSSADFRS="",(PSSADFXX,PSSADFCT)=0
 I '$G(PSSADFOI) Q PSSADFRS
 F PSSADFLP=0:0 S PSSADFLP=$O(^PS(52.6,"AOI",PSSADFOI,PSSADFLP)) Q:'PSSADFLP!(PSSADFXX)  D
 . ; Get INACTIVATION DATE and ADDITIVE FREQUENCY
 .S PSSADFNN=PSSADFLP_"," K PSSADFER,PSSADFLD
 .D GETS^DIQ(52.6,PSSADFNN,"12;18","I","PSSADFLD","PSSADFER")
 .I $G(PSSADFER("DIERR")) Q  ; Error(s) returned
 .S PSSADFIN=$G(PSSADFLD(52.6,PSSADFNN,12,"I")),PSSADFHD=$G(PSSADFLD(52.6,PSSADFNN,18,"I"))
 . ; Only consider if not inactive as of today
 .I PSSADFIN,PSSADFIN'>DT Q
 . ; If no frequency returned, set error flag, look no further
 .I PSSADFHD="" S PSSADFXX=1 Q
 . ; Save first non-null value found
 .I 'PSSADFCT S PSSADFRS=PSSADFHD,PSSADFCT=1 Q
 . ; Second or later match found and isn't the same value
 . ;  as first match value, set error flag, quit
 .I PSSADFHD'=PSSADFRS S PSSADFXX=1
 ; If error found, return null
 I PSSADFXX S PSSADFRS=""
 Q PSSADFRS
 ;
