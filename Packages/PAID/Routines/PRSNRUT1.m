PRSNRUT1 ;WOIFO/DAM - API Pull POC Data;060409
 ;;4.0;PAID;**126**;Sep 21, 1995;Build 59
 ;;Per VHA Directive 2004-038, this routine should not be modified
 ;
 ;INPUT:
 ;    PPIEN: Pay period IEN is in TIME & ATTENDANCE RECORDS file (#458)
 ;         The .01 field is the pay period, eg "09-07" 
 ;                and matches the .01 field in 
 ;                POC DAILY TIME RECORDS file (#451)
 ;         The IEN is in the 2nd subscript and B xref of 
 ;                the .01 field in file (#458)
 ;    PRSIEN: Nurse IEN is the .01 field in the POC DAILY TIME RECORDS 
 ;          file (#451) multiple 451.09
 ;    PRSNDAY: Day number is the .01 field in POC DAILY TIME RECORDS 
 ;           file (#451) multiple 451.99. This parameter is optional.  
 ;           If a DAY is not passed in, results for the entire pay 
 ;           period are returned.
 ;    PRSNVER: "C" or "P" to retrieve Current or Previous version of time record
 ;    
 ;OUTPUT:
 ;    Returns array POCD(N)="Start Time^Stop Time^Meal Time
 ;    ^Type of Time^Point of Care^Type of Work^Mandatory Indicator
 ;    ^Reason for OT/CT/RG"
 ;         
L1(POCD,PPIEN,PRSIEN,PRSNDAY,PRSNVER) ;EMPLOYEE
 ;Called from PRSNRUT0
 ;
 S PRSNVER=$G(PRSNVER,"C")
 S POCD(0)=0
 N N
 S N=1
 N PRSND0,PRSND1,PRSND2,PRSND3,PRSND4
 S PRSND0=PPIEN
 S PRSND1=0
 F  S PRSND1=$O(^PRSN(451,PRSND0,"E",PRSND1)) Q:PRSND1'>0  D
 .  I $P($G(^PRSN(451,PRSND0,"E",PRSND1,0)),U,1)=PRSIEN  D 
 . .  D L2(.POCD,PRSND0,PRSND1,PRSNDAY,PRSNVER)
 Q
 ;
L2(POCD,PRSND0,PRSND1,PRSNDAY,PRSNVER)      ;Loop through DAY entries
 ;
 S PRSNVER=$G(PRSNVER,"C")
 S PRSND2=0
 F  S PRSND2=$O(^PRSN(451,PRSND0,"E",PRSND1,"D",PRSND2)) Q:'PRSND2  D
 .  I $P(^PRSN(451,PRSND0,"E",PRSND1,"D",PRSND2,0),U,1)=PRSNDAY D
 ..   D L3(.POCD,PRSND0,PRSND1,PRSND2,PRSNVER)
 .  I PRSNDAY="" D L3(.POCD,PRSND0,PRSND1,PRSND2,PRSNVER)
 Q
 ;
L3(POCD,PRSND0,PRSND1,PRSND2,PRSNVER) ;Loop through VERSION entries
 ;
 S PRSNVER=$G(PRSNVER,"C")
 S PRSND3=99999
 S PRSND3=$O(^PRSN(451,PRSND0,"E",PRSND1,"D",PRSND2,"V",PRSND3),-1)
 Q:PRSND3=""
 I PRSNVER="P" S PRSND3=$O(^PRSN(451,PRSND0,"E",PRSND1,"D",PRSND2,"V",PRSND3),-1)
 Q:PRSND3=""
 D L4(.POCD,PRSND0,PRSND1,PRSND2,PRSND3)
 Q
 ;
L4(POCD,PRSND0,PRSND1,PRSND2,PRSND3) ;RETURN DATA
 ;
 S PRSND4=0
 F  S PRSND4=$O(^PRSN(451,PRSND0,"E",PRSND1,"D",PRSND2,"V",PRSND3,"T",PRSND4)) Q:'PRSND4  D
 .  S POCD(N)=$P(^PRSN(451,PRSND0,"E",PRSND1,"D",PRSND2,"V",PRSND3,"T",PRSND4,0),U,1,10)
 .  S $P(POCD(N),U,11)=PRSND3
 .  S POCD(0)=N
 .  S N=N+1
 ;If there is at least one time segment then we are done
 Q:N>1
 ;Otherwise, update version number here for deleted time records
 S $P(POCD(N),U,11)=PRSND3
 S POCD(0)=N
 ;
 Q
