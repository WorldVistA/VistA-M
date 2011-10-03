FHOMAPI ;Hines OIFO/RTK OUTPATIENT MEALS/CPRS API's  ;8/26/03  10:15
 ;;5.5;DIETETICS;**2**;Jan 28, 2005
 ;
AUTH(DUZ) ;Check whether USER (DUZ) has FHAUTH key: 1=YES, 0=NO
 N FHAU S FHAU=0
 I $D(^XUSEC("FHAUTH",DUZ)) S FHAU=1
 Q FHAU
DIETLST ;Build list of allowable outpatient diets from site parameters
 K FHDIET,SPDIETS S SPDIETS=$P($G(^FH(119.9,1,0)),U,2,6)_"^"_$P($G(^FH(119.9,1,1)),U,1,10)
 F A=1:1:15 S AB=$P(SPDIETS,U,A) I AB'="" S FHN=$P($G(^FH(111,AB,0)),U,1),FHDIET(A)=AB_"^"_FHN
 Q
MAXDAYS(FHLOC) ;Returns max number of days a recurring meal may be ordered
 N FHMAXD S FHMAXD=365 I FHLOC="" Q FHMAXD
 S FHLOC=$O(^FH(119.6,"AL",FHLOC,""))
 I 'FHLOC Q FHMAXD
 S FHMAXD=$P($G(^FH(119.6,FHLOC,1)),U,2) I FHMAXD="" S FHMAXD=365
 Q FHMAXD
NFSLOC(FHLOC) ;Returns NFS location name given HOSP LOCATION pointer
 I FHLOC="" Q ""
 S FHLOC=$O(^FH(119.6,"AL",FHLOC,""))
 I 'FHLOC Q ""
 S FHLNAME=$P($G(^FH(119.6,FHLOC,0)),U,1)
 Q FHLNAME
