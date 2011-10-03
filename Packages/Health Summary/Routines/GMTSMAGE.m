GMTSMAGE ;SLC/RMP - Imaging HS Comp Data Extraction  ; 08/27/2002
 ;;2.7;Health Summary;**26,56**;Oct 20, 1995
 ;                    
 ; External References
 ;   DBIA  2791  ^MAG(2005
 ;                    
IMGPTRE(ZY,MAGMESS) ; Return Image Info List for Patient
 N MAX,Y,MAGDFN,MAGDUZ,CT,PD,T,I,P
 S MAX=$S(+($G(GMTSNDM))>0:+($G(GMTSNDM)),1:99999)
 S MAGDFN=$P(MAGMESS,"^",1),MAGDUZ=$P(MAGMESS,"^",2) S:MAGDUZ="" MAGDUZ=0
 F I=1:1:10 I $E(MAGDFN,1)=" " S MAGDFN=$E(MAGDFN,2,99)
 S MAGDFN=+MAGDFN I '$D(^MAG(2005,"APDTPX",MAGDFN)) S ZY(0)="1^0" Q
 S CT=0,T=0,I=0,P="",PD=""
 F  S PD=$O(^MAG(2005,"APDTPX",MAGDFN,PD)) Q:PD=""  Q:'$$GT(PD)  D
 . S P="" F  S P=$O(^MAG(2005,"APDTPX",MAGDFN,PD,P)) Q:P=""  D
 . . S I="" F  S I=$O(^MAG(2005,"APDTPX",MAGDFN,PD,P,I)) Q:+I<1  D
 . . . Q:$P($G(^MAG(2005,I,0)),"^",10)  ;   Child of Group
 . . . S T=T+1 Q:T>250  Q:(MAX>1)&(MAX<(CT+1))  S CT=CT+1
 . . . D ARRY(.ZY,CT,I)
 S ZY(0)="1^"_CT S:T>CT ZY(0)=ZY(0)_" of "_T K T,I
 Q
GT(ADT) ; Date Range Check
 Q:ADT>GMTS2 0
 Q $S(ADT>GMTS1:1,1:0)
ARRY(ZY,CT,I) ; Build Array
 S ZY(CT)=$P(^MAG(2005,I,2),"^",5)
 S $P(ZY(CT),"^",2)=$P(^MAG(2005,I,0),"^",8)
 S $P(ZY(CT),"^",3)=$P(^MAG(2005,I,2),"^",4)
 Q
